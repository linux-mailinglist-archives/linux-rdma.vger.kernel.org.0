Return-Path: <linux-rdma+bounces-17847-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDKnB3jKr2nWcAIAu9opvQ
	(envelope-from <linux-rdma+bounces-17847-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 08:38:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A850E24679F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 08:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C1343018C1C
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9CF333424;
	Tue, 10 Mar 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Nw7qZEeQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B188D1DE2AD;
	Tue, 10 Mar 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128165; cv=none; b=XT7CzeTxPPFHlMjtshuFFL84r/oireSCv/Fr766MQHllDOiAV4d2Oibr26bpp87SayPTfZqYQznk4oGM8pnc4E0uP0l/X1lXqPySCbx+ibPyrjuiBwryEGJMGPR96kDj0paJ99+LI9GfCyOZk6s2Fu0b4kZH2n00ftji05oaU5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128165; c=relaxed/simple;
	bh=PH3u2rmfzhLTFh22kBB3Mlpw1x36bETSokYAf6ZhKLo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW7xDmBMq0PW1YKdoT2QYs0/01nc0E4nSiSi40/WaZX+8uN8HXe3kE8KUd4CQxcGeBMXEO/tfoxh26HOsj0CbB5TzmVYmlFQFAP8A+sEo73TcKlPvwhSRJH7tJCBU0SrmcyhJGotpTIJNsvHTooMV8/Jkyi+dlECW0nWTWoUvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Nw7qZEeQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A6XLUZ919223;
	Tue, 10 Mar 2026 00:35:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
	9crNDXfz7p3hgckLSlhc90lGkgNrzZBqFlMHkE2mEk=; b=Nw7qZEeQyPSFRD8eU
	0dVEUMINY1HlEm0ormOpppBLakqQ96A2edlQwl6Lzpu9SgypBA2tMGUUBuax4HYn
	VX4vogW3XQI2pNQDpwWTB3wU2Meu2YBW8MKedOmweRrpLhJquhT6qQNgbII3b/g7
	l82FgYiLGfjHhi9KKT2z2WdwVPMxsptRUphqHhsETShyvuKHcBy3NkTw0H2VZUI/
	KqWA8XV5oV4jxUQHTHAh50avn+mJpuCh/DNqxvBTtmyOJybkS4l4kVUyEk/D9flu
	Hsp9rNWXrVSy+b6fpNQ7V6d0oFjCkPBXfXcIo7xaMpzqA7c0389q20kTNDJyLJVr
	cPABw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cte4t84vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 00:35:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Mar 2026 00:35:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Mar 2026 00:35:26 -0700
Received: from naveenm-PowerEdge-T630 (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 5212B3F7052;
	Tue, 10 Mar 2026 00:35:20 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:05:19 +0530
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
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
        Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Danielle Ratson <danieller@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: Re: [RFC net-next v2 0/6] ethtool: Generic loopback support
Message-ID: <aa/Jt36h3EuhpPKf@naveenm-PowerEdge-T630>
References: <20260308124016.3134012-1-bjorn@kernel.org>
 <aa7P7UUUG1p5RVwO@naveenm-PowerEdge-T630>
 <87tsupnjbc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsupnjbc.fsf@all.your.base.are.belong.to.us>
X-Authority-Analysis: v=2.4 cv=YpMChoYX c=1 sm=1 tr=0 ts=69afc9bf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=heUGGuA_X2RTU5F4dl4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2MiBTYWx0ZWRfX08fhuGpsejoF
 7cCReHajQeoOykPeAveUcCRUhtoTVavSgB5KVXB8NauM6cpR7axKPBjPlNKqMMSFkLQ3cGL/P14
 BiiP+9wxD9Lw2VGVJpintHTliQjkKawItWoYvUmDbaacw7OmW8TMXKrtBoV5TKYTHcwpu94OxkE
 gMvHDSZK4M7S032zUM5G6xVEEBIluipUFKshrwhFW/M46rhpJvmUdvDIV8eyzg8DHB/zvji6hZ8
 sEpPhqWfLumhSGs1Yi6M0LMAtbDaRun2xtUrztNluw8jIZ3DqVqZ28VxI63SHwaLhLMNCd3tnDm
 lO3wF2ZSOzn7UDocF5Cf6Yo06mYnLl2RgiNNkLrszJTKae3l113vQApmbrqLsxFRZIPiuMTO2Mc
 GJIe0yHGYkcn3kZ14YseIWAgd5LyYMypmMhBFKYldRSTu02xw6xgR713JLEaUem+N7VVSLC3BmS
 4XdThN5qMqJp85wKeSg==
X-Proofpoint-ORIG-GUID: Mok49Wu56o817oFaKiIx02vG7wwEg_jH
X-Proofpoint-GUID: Mok49Wu56o817oFaKiIx02vG7wwEg_jH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: A850E24679F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17847-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naveenm@marvell.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-09 at 20:25:51, Björn Töpel (bjorn@kernel.org) wrote:
> Naveen!
> 
> Naveen Mamindlapalli <naveenm@marvell.com> writes:
> 
> >> Open questions
> >> ==============
> >> 
> >>  - Is this the right extensibility model? I'd appreciate input from
> >>    other NIC vendors on whether component/name/direction is flexible
> >>    enough for their loopback implementations. Also, from the PHY/port
> >>    folks (Maxime, Russell)!
> >
> > Hi Bjorn,
> >
> > The component/name/direction model in v2 fits our hardware well.
> >
> > I am working on loopback support for Marvell OcteonTX2.
> > The MAC (RPM block) supports a PCS-level loopback. In addition,
> > the on-chip SerDes (GSERM) is managed by embedded firmware and
> > supports three more loopback modes:
> >   NED (Near-End Digital) -- digital domain, before the analog front-end
> >   NEA (Near-End Analog) -- through the full analog front-end
> >   FED (Far-End Digital) -- line-side traffic looped back
> >
> > Since the GSERM is not a phylib phy_device, both the MAC PCS
> > loopback and the SerDes loopbacks fall under the MAC component
> > in your model.
> >
> > Mapped to the v2 model:
> >   component  name         supported    description
> >   MAC        mac          near-end     PCS-level loopback
> >   MAC        serdes-ned   near-end     digital only
> >   MAC        serdes-nea   near-end     analog
> >   MAC        serdes-fed   far-end      line-side
> >
> > The SerDes NED and NEA both have the same (component, direction).
> > Both are (MAC, near-end) -- but exercise fundamentally different
> > hardware paths. The name field distinguishes them as per your model,
> 
> Ok! ...and MAC+serdes makes sense from your PoV? Or do we need a new
> component "SERDES" (as Maxime points out in another reply)?
> 

In my earlier comment I mapped the SerDes loopbacks under the MAC
component to fit the current model, but a separate SERDES component
as Maxime suggests would be a better fit for our hardware.

On OcteonTX2 SoC, MAC (PCS) and SerDes are separate hardware blocks.
Each block has its own loopback controls.

With a SERDES component, the mapping becomes cleaner:
  component  name         supported
  MAC        mac          near-end
  SERDES     serdes-ned   near-end
  SERDES     serdes-nea   near-end
  SERDES     serdes-fed   far-end

Thanks,
Naveen

> > I can work on MAC + SerDes loopback driver support for CN10K and
> > post patches on top of your series once MAC component dispatch is
> > in place.
> 
> Got it! Thanks!
> 
> 

