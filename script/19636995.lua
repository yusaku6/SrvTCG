--急き兎馬
--Rapid Red Hared Mare
--Scripted by Eerie Code
function c19636995.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,19636995)
	e1:SetCondition(c19636995.hspcon)
	e1:SetValue(c19636995.hspval)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ADJUST)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c19636995.descon)
	e2:SetTarget(c19636995.destg)
	e2:SetOperation(c19636995.desop)
	c:RegisterEffect(e2)
end
function c19636995.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=31
	local lg=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	for tc in aux.Next(lg) do
		zone=bit.bxor(zone,tc:GetColumnZone(LOCATION_MZONE,0,0,tp))
	end
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c19636995.hspval(e,c)
	local tp=c:GetControler()
	local zone=31
	local lg=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	for tc in aux.Next(lg) do
		zone=bit.bxor(zone,tc:GetColumnZone(LOCATION_MZONE,0,0,tp))
	end
	return 0,zone
end
function c19636995.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetColumnGroupCount()>0
end
function c19636995.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c19636995.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end