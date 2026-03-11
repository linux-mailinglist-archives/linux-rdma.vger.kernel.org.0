Return-Path: <linux-rdma+bounces-17962-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIUHE41IsWlCtAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17962-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:48:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EBD262880
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2717F3053A2D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107B53CF672;
	Wed, 11 Mar 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bslJA/ua"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5938AC88;
	Wed, 11 Mar 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225558; cv=none; b=lDYll77MiOnH0K7tAolHfVlrcNM2GFcg7SaFx0aPMG/HpFzAyY+XtNmmoJvbpgo0PeLM66C2zpt2nKObO/+AnRXgy6lIptDR84mHRzk0GHvwq+MiD3lmmW8uOaq59TyrHw8TQjJP7XDECfXi2LMVjUsvsF1d6trtcNU+0UaL0hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225558; c=relaxed/simple;
	bh=b4QnC1LhazFqQ4sAt/8PpLltQNH3c8407OBltp5UFb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLL/IYS58GoBN+Zu0gWRoJAY3BBVnU+qNcfKS4T90iprmmNC36Vvk6a/PKS20wqHzeu72LWsCzyWbmgMLQCMvjTzQSInOS/pWWZY9Nd5yB8V8sg1VKVlo6C9uP+BusrrkWxuOeQ3yTKey3Ex32Sv1rN7XaTOIcYWa7mV2d8BloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bslJA/ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3820C4CEF7;
	Wed, 11 Mar 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773225558;
	bh=b4QnC1LhazFqQ4sAt/8PpLltQNH3c8407OBltp5UFb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bslJA/uagxLYaYRzuGHoTdYomEu1yPsMV9d2iys6xE4LedCN0Asttas91fhNwaLyv
	 tQb//nAmpCrJS1Btr4N2A4UF+EcN0VyxMAbpOjd473hUujGfXvEwcFCVmmDc2Tx9PT
	 PuHz6XTjH/nJaIJyd3+fVbJR/vTK8S+k/jchMOTz2UFFCuBU7igF0dN046Y0ED/Oom
	 F+bhFj3tpt53qtB1u4cBNY4i081KTnVvIGe17APu5+KsiWy2ArUufVOtSW92s6DRGs
	 ihewGmdjul8TOtuWzQrrszBRWDdoal135f9w7OBLwxJ/MiNEV8f8fDtQja1H4os5zm
	 CtMB6Rhf00cuA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>, Hariprasad Kelam
 <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Leon Romanovsky <leon@kernel.org>, Michael
 Chan <michael.chan@broadcom.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan
 <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Willem de Bruijn
 <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
In-Reply-To: <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
 <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
Date: Wed, 11 Mar 2026 11:39:15 +0100
Message-ID: <87tsum3b1o.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 53EBD262880
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17962-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,marvell.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,marvell.com,bootlin.com,kernel.org,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,all.your.base.are.belong.to.us:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Maxime Chevallier <maxime.chevallier@bootlin.com> writes:

> Hi again Bj=C3=B6rn,
>
> First, thanks for iterating so quick !

Thank *you* for helping me navigating the lower levels of the stack! I'm
trying to be like the Iron Maiden tune: Be quick or be... ? :-P

>> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/ne=
tlink/specs/ethtool.yaml
>> index 4707063af3b4..8bd14a3c946a 100644
>> --- a/Documentation/netlink/specs/ethtool.yaml
>> +++ b/Documentation/netlink/specs/ethtool.yaml
>> @@ -211,6 +211,49 @@ definitions:
>>          name: discard
>>          value: 31
>>=20=20
>> +  -
>> +    name: loopback-component
>> +    type: enum
>> +    doc: |
>> +      Loopback component. Identifies where in the network path the
>> +      loopback is applied.
>> +    entries:
>> +      -
>> +        name: mac
>> +        doc: MAC loopback. Loops traffic at the MAC block.
>> +      -
>> +        name: pcs
>> +        doc: |
>> +          PCS loopback. Loops traffic at the PCS sublayer between the
>> +          MAC and the PHY.
>> +      -
>> +        name: phy
>> +        doc: |
>> +          Ethernet PHY loopback. This refers to the Ethernet PHY managed
>> +          by phylib, not generic PHY drivers. A Base-T SFP module
>> +          containing an Ethernet PHY driven by Linux should report
>> +          loopback under this component, not module.
>> +      -
>> +        name: module
>> +        doc: |
>> +          Pluggable module (e.g. CMIS (Q)SFP) loopback. Covers loopback
>> +          modes controlled via module firmware or EEPROM registers. When
>> +          Linux drives an Ethernet PHY inside the module via phylib, use
>> +          the phy component instead.
>
> So to get back on Andrew's remarks, let's see if we can get something
> closer to 802.3.
>
> Here, we have loopback at various locations, which all depends on the
> Ethernet standard you use.
>
> It's usually in the PCS, PMA or PMD components. Thing is, we may have
> these in multiple places in our link.
>
> If we take an example with a 10G PHY, we may have :
>
> +----SoC-----+
> |            |
> |  MAC       |- drivers/net/ethernet
> |   |        |
> | Base-R PCS |- could be in drivers/net/pcs, or directly
> |   |        | in the MAC driver
> |   |        |
> |  SerDes    |- May be in drivers/phy, maybe handled by firmware,
> |   |        |  maybe by the MAC driver, maybe by the PCS driver ?
> +---|--------+
>     |
>     | 10GBase-R
>     |
> +---|-PHY+
> |   |    |
> | SerDes | \
> |   |    | |
> |  PCS   | |
> |   |    |  > All of that handled by the drivers/net/phy PHY driver
> |  PMA   | |
> |   |    | |
> |  PMD   | /
> +---|----+
>     |
>     v 10GBaseT
>
> So even the "PCS" loopback component is a bit ambiguous, are we talking
> about the PHY PCS or the MAC PCS ?
>
> Another thing to consider is that there may be multiple PCSs in the SoC
> (e.g. a BaseX and a BaseR PCS like we have in mvpp2), the one in use
> depends on the current interface between the MAC and the PHY.
>
> Another open question is, do we deal with loopbacks that may affect
> multi-netdev links ? Like the multi-lane modes we discussed with fbnic,
> or even for embedded, interfaces such as QSGMII ?

Hmm, TBH punt on it for now. The current design is per-netdev, and
drivers should only expose loopbacks they can scope to a single netdev.
Multi-netdev loopbacks can be addressed later if a real use case arises.
That keeps the series focused and avoids designing for hypotheticals.

> As for the SerDes on the MAC side (say, the comphy on Marvell devices),
> can we say it's a PMA for 10GBase-KR ? Or is it something that's simply
> out of spec ?
>
> So I'd say, maybe we should not have a PCS loopback component at all,
> but instead loopback at the well-defined components on our link, that is:
>
>  - MAC =3D> MAC loopack, PCS on the MAC side, SerDes on the SoC, etc.
>  - PHY =3D> Loopbacks on the PCS/PHY/PMA withing the PHY device
>  - Module =3D> For non-PHY (Q)SFPs

Less is more! I like that! So, the component maps to the Linux driver
boundary (who owns the loopback), and the name is the 802.3 sublayer
within that device?

> The important part would therefore to get the "name" part right, making
> sure we don't fall into driver specific names.
>
> We can name that 'pcs', 'pma', 'pmd', or maybe even 'mii' ? Let's see :
>
> +----SoC-----+
> |            |
> |  MAC       |- component =3D MAC, name =3D 'mac'
> |   |        |
> | Base-R PCS |- component =3D MAC, name =3D 'pcs'
> |   |        |
> |   |        |
> |  SerDes    |- component =3D MAC, name =3D 'mii' ?
> |   |        |
> +---|--------+
>     |
>     | 10GBase-R
>     |
> +---|-PHY+
> |   |    |
> | SerDes | - component =3D PHY, name =3D 'mii' ?
> |   |    |
> |  PCS   | - component =3D PHY, name =3D 'pcs'
> |   |    |
> |  PMA   | - component =3D PHY, name =3D 'pma'
> |   |    |
> |  PMD   |- component =3D PHY, name =3D 'pmd' or 'mdi' ?
> +---|----+
>     |
>     v 10GBaseT
>
> Sorry that's a lot of questions and I don't expect you to have the
> answer, but as what you've come-up with is taking a good shape, it's
> important to decide on the overall design and draw some lines about
> what do we support, and how :(

(Again, this is why input from folks like you/Andrew/Naveen is
excellent! (Hey, I just wanted the CMIS loopback to start with! ;-)))

I like this. The nice thing is that since "name" is a string, we're not
locked into an enum -- drivers report what they have using 802.3
vocabulary, and we document the recommended names (pcs, pma, pmd, mii)
with references? That way it's unambiguous, but not too constrained.

For the next spin, I'll drop the pcs component entirely and keep only
mac, phy, and module. I'll also expand the component docs to explain
that the sublayer granularity lives in the name attribute using 802.3
terminology. How does that sound?

>> +  -
>> +    name: loopback-direction
>> +    type: flags
>> +    doc: |
>> +      Loopback direction flags. Used as a bitmask in supported, and as
>> +      a single value in direction.
>> +    entries:
>> +      -
>> +        name: near-end
>> +        doc: Near-end loopback; host-loop-host
>> +      -
>> +        name: far-end
>> +        doc: Far-end loopback; line-loop-line
>
> I was browsing 802.3, it uses the terminlogy of "local loopback" vs
> "remote loopback", I suggest we use those.

Sounds good!

Thanks for taking the time to think through the layering -- this is much
cleaner.


Bj=C3=B6rn


