Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAA26A766
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgIOOmv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 10:42:51 -0400
Received: from sonic307-9.consmr.mail.ne1.yahoo.com ([66.163.190.32]:38641
        "EHLO sonic307-9.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgIOOmj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600180957; bh=YzWWG+/9RPY8U0VkmR6N5Gk17aLV6Gsybz6nO0noKaw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=DzaDGsGUtflBXHPie45h5+ePj4aSkZGstypBqnuYWbLovNNHUeAAexMiB29Wwx8NXL7durXnCbPeARha3jasR/4HYTDKL8+XDwGIfLqFRA4sAR2rLaNwOC6QSAfi1opKR3WXuL93UqLjokKslfWlfMPO5oedg6+cEYnbcytNO/mO7rL0s/CgQ8P8PhmfakTr2zmmPnUBkPQoALVPmNAHYkkgWjYzTxj8POSMgTw/vuPBWOYfd9uOhuZ1xvvM9o4VJYMZFDkQoa40qtIhCKrGVEJEBcS1KnjLZkrFZHfWmxJ1Vj7nmFwy7Mxz8aQJZWd39orUBngQmm5XkRkxwzeZFQ==
X-YMail-OSG: MIXYvHIVM1nx1QGYsnkGOqGapttQ1yDv8afBdG15I.wPuMqkyB7dBileWv4Ce0s
 8Wp_oZuPDbUjsK1SfM0sDgVIKxilyHE3QZkQ0W.Mt_otvWSAn41OcuhX6kqoBlPZOTawolzrO8.A
 diQiXFeypSLATQZdsPNKTKL.DIctB6p9KUHVT1txm7rOuP3UyQ9Nj0G3RsZUsRV_JGp1fPkZYDSd
 Rx3pYkL4DPE2x34UXnwFpkaREs8X0urVO10yRqYytKr53OOB0FzNCGLm8XVXZKw5Sy32IY5cpkaS
 kH3h.Bh.abZHjaf0NgIGkypA107gBIRCIqmzrUBXmjbUfKvBg1T6AHFx3tcsO2c9DN_vOz6AKInX
 3X1D0gvf7a281BoybQhUfpWigOYhIhMzpN6MQpsZYq5nxcwOm9IDG_Po.59eJYWXiGpcX.0nhAB9
 8tLAGJ.rRTzfmfORFLlFnWkrwDzYcqs8hqnTEkN9TXZKAEuGEIDnCKbmnpNi1.NcX4zmw7I.tB8Z
 1YDeA0_KWf1JMXaq4s4UGwakQf3aBWQpA4yOB1BSDgsskEaafgAuJoCznL73W8nT7pETlWgEsQmd
 RexLnWeKZ25FZE_WoZJR.iqAgOOBZDV._pFb75lrjH4MyrcrmBr5uWaryuOQyGxGpZRLvvoLt381
 CbSGufK7j_fgAcmr3LD7GnxozuaOOMyC1BFu0LY5caFmG39Rq_EPb7EK64zog7q7yECPp7.YzUMo
 m.sp902UEu0fNQvrpkQN6ZxnExrBg7QbnJBaxkaZlh8KDePXvcrkoEK_pt5QI22wIuumncYIbLNr
 S4ofv9kQ9tg9EWYcx3vHgLqkHU4an1eQd3tfKtyRewzcKmkje4M_JmCLmYoTJdt_ISUc7rVCy.8i
 JoWIynA9hzxDnMQdpV1PePt17PXqDHfsuSmlVQ80WvFGtAp03UAH.QGai1EOYpu_P1ga3c_ziiyq
 YqlNkynf7BnzHAz.APHkBwVSkaFvEnjLpg2OLXtPCQw02xf53b0._kRd753U1tdDvFjPcOX0Pxpy
 vrjdb.Ubfsuj1GOwdNos76xGgGnOsLotRm88lTCiBFuLzofWRLnMMx_RQ2qavR_7WhhZjqtwyZg0
 X29G_ZboYGALMv.JtSJrzma8hizO4lrKCXuTaCEQcnlqmly.x6roD6ndbhz.4OvM1lE7bpOjAtEa
 GkgQsHTbRJLdGVbOz_YS3LvCWB3ln19GbbhESRVfCI4sQaU4Lgxc259CdXhAlJFWPlJFhcC3zrf1
 nCfkWihMaWmIKiYqh8b7MNi89._ZVrHczEiR8MlxI6Vf802Zrw3nMuVkT3o1GfaFBR5EmhhriWoX
 F1ylML7JNrnt29rp9L41es0EiJCeV.OQoV3YCB4gsiVsV9wj8HgNexUVFDuVa.qK7H93fL8OaDcD
 rbsy5xJ.CLDhsVVTsZPU0AIDfW0FJPlZ7Hl9KwGntRfhU7r57XBrOIdZdxpPQPhtJCS6ECTwkQjz
 4wjiGv8QI0w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 15 Sep 2020 14:42:37 +0000
Date:   Tue, 15 Sep 2020 14:42:36 +0000 (UTC)
From:   jude <jude.clake23@gmail.com>
Reply-To: jude.clake@gmail.com
Message-ID: <1934784307.2521245.1600180956045@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1934784307.2521245.1600180956045.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Dear=C2=A0Friend,

I=C2=A0am=C2=A0Mr=C2=A0Jude=C2=A0Clacke,=C2=A0the=C2=A0director=C2=A0of=C2=
=A0the=C2=A0accounts=C2=A0&=C2=A0auditing=C2=A0dept=C2=A0.at=C2=A0the=C2=A0=
Bank=C2=A0OF=C2=A0Africa=C2=A0Ouagadougou-west=C2=A0Africa.=C2=A0(B=C2=A0O=
=C2=A0A)=C2=A0With=C2=A0due=C2=A0respect,=C2=A0I=C2=A0have=C2=A0decided=C2=
=A0to=C2=A0contact=C2=A0you=C2=A0on=C2=A0a=C2=A0business=C2=A0transaction=
=C2=A0that=C2=A0will=C2=A0be=C2=A0beneficial=C2=A0to=C2=A0both=C2=A0of=C2=
=A0us.

At=C2=A0the=C2=A0bank's=C2=A0last=C2=A0accounts/auditing=C2=A0evaluations,=
=C2=A0my=C2=A0staff=C2=A0came=C2=A0across=C2=A0an=C2=A0old=C2=A0account=C2=
=A0which=C2=A0was=C2=A0being=C2=A0maintained=C2=A0by=C2=A0a=C2=A0foreign=C2=
=A0client=C2=A0who=C2=A0we=C2=A0learnt=C2=A0was=C2=A0among=C2=A0the=C2=A0de=
ceased=C2=A0passengers=C2=A0of=C2=A0motor=C2=A0accident.

Since=C2=A0his=C2=A0death,=C2=A0even=C2=A0the=C2=A0members=C2=A0of=C2=A0his=
=C2=A0family=C2=A0haven't=C2=A0applied=C2=A0for=C2=A0claims=C2=A0over=C2=A0=
this=C2=A0fund=C2=A0and=C2=A0it=C2=A0has=C2=A0been=C2=A0in=C2=A0the=C2=A0sa=
fe=C2=A0deposit=C2=A0account=C2=A0until=C2=A0I=C2=A0discovered=C2=A0that=C2=
=A0it=C2=A0cannot=C2=A0be=C2=A0claimed=C2=A0since=C2=A0our=C2=A0client=C2=
=A0is=C2=A0a=C2=A0foreign=C2=A0national=C2=A0and=C2=A0we=C2=A0are=C2=A0sure=
=C2=A0that=C2=A0he=C2=A0has=C2=A0no=C2=A0next=C2=A0of=C2=A0kin=C2=A0here=C2=
=A0to=C2=A0file=C2=A0claims=C2=A0over=C2=A0the=C2=A0money.=C2=A0As=C2=A0the=
=C2=A0director=C2=A0of=C2=A0the=C2=A0department,=C2=A0this=C2=A0discovery=
=C2=A0was=C2=A0brought=C2=A0to=C2=A0my=C2=A0office=C2=A0so=C2=A0as=C2=A0to=
=C2=A0decide=C2=A0what=C2=A0is=C2=A0to=C2=A0be=C2=A0done.=C2=A0I=C2=A0decid=
ed=C2=A0to=C2=A0seek=C2=A0ways=C2=A0through=C2=A0which=C2=A0to=C2=A0transfe=
r=C2=A0this=C2=A0money=C2=A0out=C2=A0of=C2=A0the=C2=A0bank=C2=A0and=C2=A0ou=
t=C2=A0of=C2=A0the=C2=A0country=C2=A0too.

The=C2=A0total=C2=A0amount=C2=A0in=C2=A0the=C2=A0account=C2=A0is=C2=A0thirt=
y=C2=A0three=C2=A0million=C2=A0five=C2=A0hundred=C2=A0thousand=C2=A0dollars=
=C2=A0(USD=C2=A033,500,000.00).with=C2=A0my=C2=A0positions=C2=A0as=C2=A0sta=
ffs=C2=A0of=C2=A0the=C2=A0bank,=C2=A0I=C2=A0am=C2=A0handicapped=C2=A0becaus=
e=C2=A0I=C2=A0cannot=C2=A0operate=C2=A0foreign=C2=A0accounts=C2=A0and=C2=A0=
cannot=C2=A0lay=C2=A0bonafide=C2=A0claim=C2=A0over=C2=A0this=C2=A0money.=C2=
=A0The=C2=A0client=C2=A0was=C2=A0a=C2=A0foreign=C2=A0national=C2=A0and=C2=
=A0you=C2=A0will=C2=A0only=C2=A0be=C2=A0asked=C2=A0to=C2=A0act=C2=A0as=C2=
=A0his=C2=A0next=C2=A0of=C2=A0kin=C2=A0and=C2=A0I=C2=A0will=C2=A0supply=C2=
=A0you=C2=A0with=C2=A0all=C2=A0the=C2=A0necessary=C2=A0information=C2=A0and=
=C2=A0bank=C2=A0data=C2=A0to=C2=A0assist=C2=A0you=C2=A0in=C2=A0being=C2=A0a=
ble=C2=A0to=C2=A0transfer=C2=A0this=C2=A0money=C2=A0to=C2=A0any=C2=A0bank=
=C2=A0of=C2=A0your=C2=A0choice=C2=A0where=C2=A0this=C2=A0money=C2=A0could=
=C2=A0be=C2=A0transferred=C2=A0into.

I=C2=A0want=C2=A0to=C2=A0assure=C2=A0you=C2=A0that=C2=A0this=C2=A0transacti=
on=C2=A0is=C2=A0absolutely=C2=A0risk=C2=A0free=C2=A0since=C2=A0I=C2=A0work=
=C2=A0in=C2=A0this=C2=A0bank=C2=A0that=C2=A0is=C2=A0why=C2=A0you=C2=A0shoul=
d=C2=A0be=C2=A0confident=C2=A0in=C2=A0the=C2=A0success=C2=A0of=C2=A0this=C2=
=A0transaction=C2=A0because=C2=A0you=C2=A0will=C2=A0be=C2=A0updated=C2=A0wi=
th=C2=A0information=C2=A0as=C2=A0at=C2=A0when=C2=A0desired.

I=C2=A0will=C2=A0wish=C2=A0you=C2=A0to=C2=A0keep=C2=A0this=C2=A0transaction=
=C2=A0secret=C2=A0and=C2=A0confidential=C2=A0as=C2=A0I=C2=A0am=C2=A0hoping=
=C2=A0to=C2=A0retire=C2=A0with=C2=A0my=C2=A0share=C2=A0of=C2=A0this=C2=A0mo=
ney=C2=A0at=C2=A0the=C2=A0end=C2=A0of=C2=A0transaction=C2=A0which=C2=A0will=
=C2=A0be=C2=A0when=C2=A0this=C2=A0money=C2=A0is=C2=A0safety=C2=A0in=C2=A0yo=
ur=C2=A0account.=C2=A0I=C2=A0will=C2=A0then=C2=A0come=C2=A0over=C2=A0to=C2=
=A0your=C2=A0country=C2=A0for=C2=A0sharing=C2=A0according=C2=A0to=C2=A0the=
=C2=A0previously=C2=A0agreed=C2=A0percentages.=C2=A0You=C2=A0might=C2=A0eve=
n=C2=A0have=C2=A0to=C2=A0advise=C2=A0me=C2=A0on=C2=A0possibilities=C2=A0of=
=C2=A0investment=C2=A0in=C2=A0your=C2=A0country=C2=A0or=C2=A0elsewhere=C2=
=A0of=C2=A0our=C2=A0choice.=C2=A0May=C2=A0God=C2=A0help=C2=A0you=C2=A0to=C2=
=A0help=C2=A0me=C2=A0to=C2=A0a=C2=A0restive=C2=A0retirement,=C2=A0Amen.

Please=C2=A0for=C2=A0further=C2=A0information=C2=A0and=C2=A0enquiries=C2=A0=
feel=C2=A0free=C2=A0to=C2=A0contact=C2=A0me=C2=A0back=C2=A0immediately=C2=
=A0for=C2=A0more=C2=A0explanation=C2=A0and=C2=A0better=C2=A0understanding=
=C2=A0through=C2=A0this=C2=A0email=C2=A0address=C2=A0(jude.clake23@gmail.co=
m)

I=C2=A0am=C2=A0waiting=C2=A0for=C2=A0your=C2=A0urgent=C2=A0response!!!
Thanks=C2=A0and=C2=A0remain=C2=A0blessed.
Mr=C2=A0Jude=C2=A0Clacke
