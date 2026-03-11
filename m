Return-Path: <linux-rdma+bounces-17934-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBHuF+UEsWmypwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17934-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:00:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A770025C9E2
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12ED317537F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BDA34889C;
	Wed, 11 Mar 2026 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="i0lzKMJj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF13148DD;
	Wed, 11 Mar 2026 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208798; cv=none; b=dxrO7d1sjsi8DMvnqSwGPVAwZqnSxompvu3dIP9HZfuYGo48o5gyssuIDLe4Rr8zCiAyJxRdTYq22O4Xm+vmdB5OCWSxo35kCiPx2WIqz9XU8MoX/y+NNjAOhjuZAthmtZwFOkJCfxq0aI7OlKtVcywAlaTbrr8H62Ka98PMz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208798; c=relaxed/simple;
	bh=kpbuCZ1QPjQpZ76qWKl/jASFMzxUllynABQDT/2B2Qw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCnQz4qReqvIoOmVFMlwrPyZl6V5dx6+XXDbaHMl0/ApDzLu6NODhq7WNZYu/4HrQCGYgtV4Op14Rp0Z3f8sSyjRCMBE8xsJDVEgsFpJ9hBdSlMWhlzmECi23F8IwZVeIGL4OcjFYng6kGtfka9BhjwmpYGo1G5Mi0xD6A/D7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=i0lzKMJj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIJLQv2701592;
	Tue, 10 Mar 2026 22:59:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=15sY8R66w4AJMn73QDMDsJFa5
	VrFghvaSbRqEOKbTv4=; b=i0lzKMJjGON6cJJpY8jsVSSnQB9uOzqekoFiL4ony
	X0qF9FSjwz1lgWpoRIbYsKpPjTWCglD3+8zjjWYUljbPwdlwLsDxJpB1PPLRSbtV
	jpmUDMPuz5gdyV2qe3YL/kv5UN69plA5pNh1Hz1vAmTqeAvdtODprd1PuQhydCzD
	D76YjnYJoFMCHB2z5VTW8gmDc0qyVhNdP6UZKWLjhn5B6jbCOUo4o7RilnmBvfaM
	sk/qN69AzVZ7ryqL4NCT9lF/ZL/udk+zygq07q0H9Gr24wpVivF6WQ/YwEG95C7P
	6SzgFqElXUyBG9a29GATOkKw8vti3+WMXaJDjes0LHlGQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte7r3m50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 22:59:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Mar 2026 22:59:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Mar 2026 22:59:27 -0700
Received: from naveenm-PowerEdge-T630 (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with SMTP id 04B553F7076;
	Tue, 10 Mar 2026 22:59:21 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:29:20 +0530
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        <netdev@vger.kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Danielle Ratson
	<danieller@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 0/6] ethtool: Generic loopback support
Message-ID: <abEEuPa3/cThM40a@naveenm-PowerEdge-T630>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
 <87tsupnjbc.fsf@all.your.base.are.belong.to.us>
 <aa/Jt36h3EuhpPKf@naveenm-PowerEdge-T630>
 <de9f5282-6270-4bb5-b9bf-d80cbc977f14@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <de9f5282-6270-4bb5-b9bf-d80cbc977f14@lunn.ch>
X-Proofpoint-GUID: HFeDxov8ODODU1VqkBvhGPkm5Amr8ibd
X-Authority-Analysis: v=2.4 cv=boxBxUai c=1 sm=1 tr=0 ts=69b104c0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=tB77cNMKvFgNZn3prR8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: HFeDxov8ODODU1VqkBvhGPkm5Amr8ibd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0OCBTYWx0ZWRfX6BWiXzsjxGeb
 LDwm98MPpTvMrSfKmo0cdQxVvEz2M1+4i1cPD7nvgNxv4q5Sjqjh2HRqHEBeRF19t9tDZ4Gc7Nw
 iY5aWHWcl/rid0svB3irrM/rQhxxSuuC0eH4qmHZYTp3ncsZ1rc6wG/8TOvDWrV7RZ1OmI5Zxf7
 X1YEXyjcyR2Q3M1hAaL0Ux7neTmEpnyXAO3XRFYvzc2DfvXFKwqcnk5hqOHCmhcZlsTqHm3SscZ
 iijF3asLSCx+dBKcsm/MByt14pm+D07ELyg00KHgxnBnghURQHEb5YaAO560ajqC2yaubd3/iSI
 L6YqIzlKLvAtD3TAC9j16GIGrEGDxMABkwGvviiFeN/LXs1F4EtRpGea6znDR3f9IpX+QQRIM0a
 BMCRrwv8iDnPq1xMmZZVZVOxD+3DM3zAecuzNRBNHHYMTXqg9b2duk13fRyZLT21aME/LOQjIxv
 2JSfqWuzVZqD2z7PBwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: A770025C9E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17934-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naveenm@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-10 at 19:30:14, Andrew Lunn (andrew@lunn.ch) wrote:
> > > > Since the GSERM is not a phylib phy_device, both the MAC PCS
> > > > loopback and the SerDes loopbacks fall under the MAC component
> > > > in your model.
> > > >
> > > > Mapped to the v2 model:
> > > >   component  name         supported    description
> > > >   MAC        mac          near-end     PCS-level loopback
> > > >   MAC        serdes-ned   near-end     digital only
> > > >   MAC        serdes-nea   near-end     analog
> > > >   MAC        serdes-fed   far-end      line-side
> > > >
> > > > The SerDes NED and NEA both have the same (component, direction).
> > > > Both are (MAC, near-end) -- but exercise fundamentally different
> > > > hardware paths. The name field distinguishes them as per your model,
> > > 
> > > Ok! ...and MAC+serdes makes sense from your PoV? Or do we need a new
> > > component "SERDES" (as Maxime points out in another reply)?
> > > 
> > 
> > In my earlier comment I mapped the SerDes loopbacks under the MAC
> > component to fit the current model, but a separate SERDES component
> > as Maxime suggests would be a better fit for our hardware.
> > 
> > On OcteonTX2 SoC, MAC (PCS) and SerDes are separate hardware blocks.
> > Each block has its own loopback controls.
> > 
> > With a SERDES component, the mapping becomes cleaner:
> >   component  name         supported
> >   MAC        mac          near-end
> >   SERDES     serdes-ned   near-end
> >   SERDES     serdes-nea   near-end
> >   SERDES     serdes-fed   far-end
> 
> If Linux where to drive the SERDES, what part of Linux would it be?
> Generic PHY? How does your SERDES hardware block fit into 802.3? Which
> clause describes it?

Hi Andrew,

On OcteonTx2 SoC, the SerDes (GSERM) is a HW block integrated into the
SoC die. It is not on an MDIO bus or any bus that Linux can enumerate.
The block is fully managed by the firmware running on the SoC. The NIC
driver configures it indirectly through firmware mailbox commands.

The data path looks like:
  MAC (RPM) --- SerDes (GSERM) --- module/PHY

In 802.3 terms, the closest match would be PMA. The GSERM handles
serialization/deserialization and the analog front-end.

Thanks,
Naveen

> 
> Thanks
> 	Andrew
> 

