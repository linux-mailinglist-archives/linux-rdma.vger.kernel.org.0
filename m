Return-Path: <linux-rdma+bounces-21560-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKQoB5rtHGr9UAkAu9opvQ
	(envelope-from <linux-rdma+bounces-21560-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 04:25:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C12618D18
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 04:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB91E300902A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DBC218EBA;
	Mon,  1 Jun 2026 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ia51HFmi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05D2C9D;
	Mon,  1 Jun 2026 02:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780280726; cv=none; b=omax+ASZfsN8kJH6H5jWy4j03R7G1RK5V/Fi9idwL+0KxHs3i1M1L5q0wt2661F595IzLAthDawKPnF56hRICzDqTSDc2Kasi4ExrT9My8b7vJ0N2hJwrYShHB9F2smeBlmrSfbO2748ljuDC9gbA6YBK58v3AcufpvNvY9zBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780280726; c=relaxed/simple;
	bh=5gXmOo9PseUv/P1EirqnmdLrAuZm3rTttsujQJhQ2DY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9gWjcloj0L/cjUbiwnw+eZu7bBdlUSkDTL5QdiZxCvIcVxtuzMen2VoXNotxnoJgbW3RtXXM8cMXDPpf1sLdwyq967B22Yydk9ynHAk0HexiJyAPL4ik7FU9FfEz2ugyCWWKbX1iJccihhtMKvxfSgo2PVmm4p/ikR528uTagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ia51HFmi; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VMndRE2778715;
	Sun, 31 May 2026 19:24:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ROTvk335bO1SgjtDzV5JxSqEI
	lsTwiL/WjekFHZ/SkU=; b=ia51HFmim82kDB9HQtTfnMUcVTH4t0adbJdumRYBy
	TYp8s4Fji/PS8lc9Tc/+bHpGvjy6mJX5IzrFLuE4HZEff6Bj01gj07/g2gqGF5yM
	KoCvMMAEPvH6fFG5NgrGsHvuu5Sg66g+Z81SHYXFkl/yeceAl9LNddDi4MwntgjD
	MeyO6mS9f0lx5J3bM3jx5xnITgxpIlCztSMB2iHtWq6LVJH+TToE/ZatW1cvz9PH
	nX61vNPJ0+qq9cN2HzgiOiPY7qclwDaH18KOgVMloInrZ8wt+NinMk2N2+R6+GLM
	1VBdxqr4vRhQBRXpg3/lHA+yb5msHF1NUvAlp+7D14qkA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4egm56hr8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 19:24:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 31 May 2026 19:24:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 31 May 2026 19:24:43 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 511343F7062;
	Sun, 31 May 2026 19:24:35 -0700 (PDT)
Date: Mon, 1 Jun 2026 07:54:34 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>,
        <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <leon@kernel.org>, <mbloch@nvidia.com>, <michael.chan@broadcom.com>,
        <pabeni@redhat.com>, <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v16 net-next 1/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <ahztYkP52uiPK-Uw@rkannoth-OptiPlex-7090>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
 <20260521095303.2395584-2-rkannoth@marvell.com>
 <20260525135944.63d57e95@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260525135944.63d57e95@kernel.org>
X-Proofpoint-GUID: IB-6WCMEHY0UEz06VmgHg8SycRQakZo-
X-Proofpoint-ORIG-GUID: IB-6WCMEHY0UEz06VmgHg8SycRQakZo-
X-Authority-Analysis: v=2.4 cv=ZeYt8MVA c=1 sm=1 tr=0 ts=6a1ced6c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=YVm2GVML6gX3FXZ-CscA:9 a=CjuIK1q_8ugA:10 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDAyMiBTYWx0ZWRfX623+p2VnL5ej
 NYRo1w1iwWP/4Z9iOIpg2eHdilPW0V5X8q6zZc2iS7HZVCbV+v3xcaOLua4UdakzUoL+yOOuXOd
 OgBhg3mzZfLG8b7NBpc8/bOUvQbgjOsqmkAmFDnR5wjyb09NwuHU691v7CdsewfJJnfjlh03JDE
 8kA9vKhhlcPyFYohLgUVSRc+Ygg1MrWhh70sfKsYel1YjoClF4tg6XvvB09MSyMvWnlpKu/gwPt
 el/1gGkYNtJBfjmb+/O93rMvQu/uAiv4JhjEQ7zJn2NG9m5Qhs9u6xU3+j7WKJ+A0nQ+ITewHCi
 PG9u198AWBdKR14oOWaoUvQQb2CblnYwSzBkoVckFgdNxjy2usPDxdNwHyZv9/SHWITWyVrc5vP
 o9FBRK6ljOIaWUeyjE98SXSuiHR9e3gCiEgerC5lMiAdzE4Y2GdFyRwRg/c1AKRFPTYoFPBNMR3
 gQGW4Bgu4t6fBYdRi+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21560-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 85C12618D18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-26 at 02:29:44, Jakub Kicinski (kuba@kernel.org) wrote:
> On Thu, 21 May 2026 15:22:55 +0530 Ratheesh Kannoth wrote:
> > Improve MCAM visibility and field debugging for CN20K NPC.
> >
> > - Extend "mcam_layout" to show enabled (+) or disabled state per entry
> >   so status can be verified without parsing the full "mcam_entry" dump.
> > - Add "dstats" debugfs entry: reports recently hit MCAM indices with
> >   packet counts; stats are cleared on read so each read shows deltas.
> > - Add "mismatch" debugfs entry: lists MCAM entries that are enabled
> >   but not explicitly allocated, helping diagnose allocation/field issues.
>
> debugfs file which clears state seems quite odd.
> Does any user need this?
The clear-on-read behavior in dstats is implemented to provide incremental (delta)
hit-counts for live field debugging.

On each read operation, the driver compares current hardware hit counters against
a cached baseline array (in software). It reports only the entries that experienced an increment,
and then updates the baseline cache to the current hardware values. This allows developers
to easily isolate active traffic matching rules without looking at all  monotonically increasing hw counters.

I will update the commit message to reflect the same.

> This looks like a crutch for badly written tests TBH.

