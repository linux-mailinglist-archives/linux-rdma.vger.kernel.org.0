Return-Path: <linux-rdma+bounces-17943-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFdYB+IasWmOqwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17943-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:33:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2018A25E04D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DEE63027C88
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9895D3B2FC2;
	Wed, 11 Mar 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EWvhKPJ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2193AF66A;
	Wed, 11 Mar 2026 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214425; cv=none; b=ep8GGrpGArV3fxwdgFjvG2FEkEMD7TK54qEwykFaPN1lKjnUqiAgIsMGCDa7BKuPj4i0kGShnJtYjszCDaqYF4G1nSwhhf9Fiv93oyC3q9nqfXTqQOLYFbdleMhGBe/JWuDl/X/tX7kamuKpAc3BbVA2E/ZTEYn0LeZhWu8yFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214425; c=relaxed/simple;
	bh=TnUwwV/B77eColgu+FTC3LP0ebszg38zOzmJYiOft34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9+ionISt273aC8znEZn24TN1PZvIZTRZ7kH9judtGgigcBLlBeEN4x2GSNeCnWArZJyoxx2NQhojWjZVojn2mmjuaJQMOs+zmig0JVq2SOILuvh7eWoDIE2D/gM03JaSfZQza2Yvto5LZ70ZVlzfO72YV/GLPzWw6P407EEW8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EWvhKPJ1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A077B4E42612;
	Wed, 11 Mar 2026 07:33:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 710D560004;
	Wed, 11 Mar 2026 07:33:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D351D10369B30;
	Wed, 11 Mar 2026 08:33:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773214415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=n3wH772870P9IpL8j8omLHGVOBI6gpvI4kazRBxkKQU=;
	b=EWvhKPJ1D02MgJTIdcjo6/tweA8f7JrxrAEY+uuuroqhEwOwZydPWLbS0Y4laB6GseyYgO
	UdFSQrUUuAqN2ezIfgS7Z15b5D1fbQHlSzAlHIJGg9Ws4t7hG7iNxc+eyWjxO25e9p1YCX
	JOUUpjSr3avSsNbQUtvMNrIBrZU1RihcEQEj4hjZEUVmB9gijeuoW1DDqORtn7y4fUYEYt
	S2Te6EQEonBfw5A2O4iAuDSHrFrbXyB61DBLRL6YCj8KlSJWxpf+0lGPsJTdN1RdM2Etdb
	LxotNJPIK+3HMww6dmYslKQAnR/S7r21luxnLVLWxksi4glXhvQD6WXz0ihxJQ==
Message-ID: <580debbb-8f6c-4b60-95ef-22c68480ded1@bootlin.com>
Date: Wed, 11 Mar 2026 08:33:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] ethtool: Add loopback netlink UAPI
 definitions
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Naveen Mamindlapalli
 <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-3-bjorn@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260310104743.907818-3-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 2018A25E04D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17943-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[nvidia.com,marvell.com,bootlin.com,kernel.org,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi again Björn,

First, thanks for iterating so quick !

On 10/03/2026 11:47, Björn Töpel wrote:
> Add the netlink YAML spec and auto-generated UAPI header for a unified
> loopback interface covering MAC, PCS, PHY, and pluggable module
> components.
> 
> Each loopback point is described by a nested entry attribute
> containing:
> 
>  - component  where in the path (MAC, PCS, PHY, MODULE)
>  - name       subsystem label, e.g. "cmis-host" or "cmis-media"
>  - id         optional instance selector (e.g. PHY id, port id)
>  - supported  bitmask of supported directions
>  - direction  NEAR_END, FAR_END, or 0 (disabled)
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/netlink/specs/ethtool.yaml      | 123 ++++++++++++++++++
>  .../uapi/linux/ethtool_netlink_generated.h    |  59 +++++++++
>  2 files changed, 182 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 4707063af3b4..8bd14a3c946a 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -211,6 +211,49 @@ definitions:
>          name: discard
>          value: 31
>  
> +  -
> +    name: loopback-component
> +    type: enum
> +    doc: |
> +      Loopback component. Identifies where in the network path the
> +      loopback is applied.
> +    entries:
> +      -
> +        name: mac
> +        doc: MAC loopback. Loops traffic at the MAC block.
> +      -
> +        name: pcs
> +        doc: |
> +          PCS loopback. Loops traffic at the PCS sublayer between the
> +          MAC and the PHY.
> +      -
> +        name: phy
> +        doc: |
> +          Ethernet PHY loopback. This refers to the Ethernet PHY managed
> +          by phylib, not generic PHY drivers. A Base-T SFP module
> +          containing an Ethernet PHY driven by Linux should report
> +          loopback under this component, not module.
> +      -
> +        name: module
> +        doc: |
> +          Pluggable module (e.g. CMIS (Q)SFP) loopback. Covers loopback
> +          modes controlled via module firmware or EEPROM registers. When
> +          Linux drives an Ethernet PHY inside the module via phylib, use
> +          the phy component instead.

So to get back on Andrew's remarks, let's see if we can get something
closer to 802.3.

Here, we have loopback at various locations, which all depends on the
Ethernet standard you use.

It's usually in the PCS, PMA or PMD components. Thing is, we may have
these in multiple places in our link.

If we take an example with a 10G PHY, we may have :

+----SoC-----+
|            |
|  MAC       |- drivers/net/ethernet
|   |        |
| Base-R PCS |- could be in drivers/net/pcs, or directly
|   |        | in the MAC driver
|   |        |
|  SerDes    |- May be in drivers/phy, maybe handled by firmware,
|   |        |  maybe by the MAC driver, maybe by the PCS driver ?
+---|--------+
    |
    | 10GBase-R
    |
+---|-PHY+
|   |    |
| SerDes | \
|   |    | |
|  PCS   | |
|   |    |  > All of that handled by the drivers/net/phy PHY driver
|  PMA   | |
|   |    | |
|  PMD   | /
+---|----+
    |
    v 10GBaseT

So even the "PCS" loopback component is a bit ambiguous, are we talking
about the PHY PCS or the MAC PCS ?

Another thing to consider is that there may be multiple PCSs in the SoC
(e.g. a BaseX and a BaseR PCS like we have in mvpp2), the one in use
depends on the current interface between the MAC and the PHY.

Another open question is, do we deal with loopbacks that may affect
multi-netdev links ? Like the multi-lane modes we discussed with fbnic,
or even for embedded, interfaces such as QSGMII ?

As for the SerDes on the MAC side (say, the comphy on Marvell devices),
can we say it's a PMA for 10GBase-KR ? Or is it something that's simply
out of spec ?

So I'd say, maybe we should not have a PCS loopback component at all,
but instead loopback at the well-defined components on our link, that is:

 - MAC => MAC loopack, PCS on the MAC side, SerDes on the SoC, etc.
 - PHY => Loopbacks on the PCS/PHY/PMA withing the PHY device
 - Module => For non-PHY (Q)SFPs

The important part would therefore to get the "name" part right, making
sure we don't fall into driver specific names.

We can name that 'pcs', 'pma', 'pmd', or maybe even 'mii' ? Let's see :

+----SoC-----+
|            |
|  MAC       |- component = MAC, name = 'mac'
|   |        |
| Base-R PCS |- component = MAC, name = 'pcs'
|   |        |
|   |        |
|  SerDes    |- component = MAC, name = 'mii' ?
|   |        |
+---|--------+
    |
    | 10GBase-R
    |
+---|-PHY+
|   |    |
| SerDes | - component = PHY, name = 'mii' ?
|   |    |
|  PCS   | - component = PHY, name = 'pcs'
|   |    |
|  PMA   | - component = PHY, name = 'pma'
|   |    |
|  PMD   |- component = PHY, name = 'pmd' or 'mdi' ?
+---|----+
    |
    v 10GBaseT

Sorry that's a lot of questions and I don't expect you to have the
answer, but as what you've come-up with is taking a good shape, it's
important to decide on the overall design and draw some lines about
what do we support, and how :(

> +  -
> +    name: loopback-direction
> +    type: flags
> +    doc: |
> +      Loopback direction flags. Used as a bitmask in supported, and as
> +      a single value in direction.
> +    entries:
> +      -
> +        name: near-end
> +        doc: Near-end loopback; host-loop-host
> +      -
> +        name: far-end
> +        doc: Far-end loopback; line-loop-line

I was browsing 802.3, it uses the terminlogy of "local loopback" vs
"remote loopback", I suggest we use those.

Maxime

