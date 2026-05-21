Return-Path: <linux-rdma+bounces-21070-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CVVFgB9Dmo1/AUAu9opvQ
	(envelope-from <linux-rdma+bounces-21070-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:33:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B803B59E7A5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CBA33037400
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 03:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224F34DCEB;
	Thu, 21 May 2026 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WJAf7HYO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B22CCB9;
	Thu, 21 May 2026 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334373; cv=none; b=rs8fmjlZ2/Jwf3nAf72y/Q+/jxqMxA3BNC3/C8ghspnjmZGiRvijld4KRvX20qO7dj+ZUT1774h9755KYj+RnBECqYUz+5hJBFR2h1v2v35UXsF3h2DmFWbXcgNa23q4ahZUqag8WK4TjTOWBmIgLehYoYJjxFXO+8tTFC6xxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334373; c=relaxed/simple;
	bh=uNIXMJzs4YQYDLQ3MTX0keOY+2SpJv68o9GuVLrXDAE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KelXKkFDiV9tiNHtDRiuAZmYhjnqMue3HimEMzN5K2YxSpZgQs23xEGSYWwWdmwMByL9FaYIUGUfwiIQxjHEgncjEfeWihkbYtv8oxlhebmzu7OleRiOp3FjRlbzczh3vXuH6nin/31J86Fl/tYxtLyy8k+/KNn2AxrWLD7LpMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WJAf7HYO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KH9Wdu2938976;
	Wed, 20 May 2026 20:32:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=VTItxtoufp2IAQDsFpiT593sK
	qFYt65+ZQHAloVdjRM=; b=WJAf7HYOAoKHaFTCW+xZ9RYUHb/X+fUrsn8O096N2
	muwu5JfGAGizxSl/ruP9UGOEARBq/pQK0mPR8jAWZNvIKBQn2siEpeCo3y6sDXP3
	GlRN53cynv3LSqAIx51FEQFHYc8QRy49AEPbqVTYOAwNxY0uq6l15Zig7fQjGDpz
	C5g4WIf+sGGImnWtMoyLkGFTLpCmGrZcBkzlRd+O6d23DPCy4SRFt9e2NqT+R5Ip
	GJ+mkBWr47pDXEtRfE43fmTJXhMHckooy/Zx9tLlVaKWbmZ2UjKovS13MOKq+saJ
	1OHeakq5Ga/v2OT2uRort+4DuAbxnEW+rOD4aK3CIfI6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e9h419fn4-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 20:32:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 20:32:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 20:32:02 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 44C5C3F704B;
	Wed, 20 May 2026 20:31:54 -0700 (PDT)
Date: Thu, 21 May 2026 09:01:53 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <netdev@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
        <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
        <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
        <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
        <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
        <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
        <michael.chan@broadcom.com>, <pabeni@redhat.com>,
        <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
        <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
        <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
        <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v15 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <ag58qT7ziHKkEr3e@rkannoth-OptiPlex-7090>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
 <20260520020939.1457231-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520020939.1457231-6-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: KM6A8F57saif4rs3xSqfci0IdVsY5Cf8
X-Authority-Analysis: v=2.4 cv=XPEAjwhE c=1 sm=1 tr=0 ts=6a0e7cbf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8
 a=TqiHYjcEmwCWYqGesmoA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=Oh551-UHZqmTy8JkqTUo:22
X-Proofpoint-GUID: KM6A8F57saif4rs3xSqfci0IdVsY5Cf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzMCBTYWx0ZWRfX5dr7/nnC5wj2
 5lD6wwDKls2Lm4ebbiamtXXSysWddF8NQswBFPaCrc2ClsHfIy2fKWZ7ayo0v/4KZYpFhm0K9Sq
 i7heyVHjpnEWn4hUx7X7LFNUY7c9k1X2X0QqNgBXwXAKwumkJ6tcNtlPanNCTPlndJq2Lr+WMtY
 ICxiRUFwCHMWhjY261olzjQO8zj2HwlHNHMDQVc9pPWFC2ActAAmutyClpTWWF1Gda7h2jLex+m
 M03a7Apd4VYA/mBDPh7JEXLPy8tKCZlBzMsUXLAei0KYp75OtebcfbU6ZJcf1I48MzKHOQM7w4g
 Sx8IBXgy0nGkfj3P7Tu6akytB/weox45xu2Hsex6/8ignpXm2H+0NoCfPtzfEiniNI753NVmNlm
 nG20ebzaH59c6+qC8R8XsFIkNDgu7gwgsclRh/iBZodzGEMSS9x+e8l9Bbe1B7GnyR6hQ7txP8F
 yWj1c62tb4+Pcgy5IAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21070-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B803B59E7A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-20 at 07:39:35, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.

>> +	for (prio = 0; prio < cnt; prio++) {
>> +		sb_idx = narr[prio];
>> +		sb = &npc_priv.sb[sb_idx];
>> +
>> +		if (sb->flags & NPC_SUBBANK_FLAG_USED)
>> +			xa = &npc_priv.xa_sb_used;
>> +		else
>> +			xa = &npc_priv.xa_sb_free;
>> +
>> +		rc = xa_err(xa_store(xa, sb->arr_idx,
>> +				     xa_mk_value(sb_idx), GFP_KERNEL));
>Are we using the correct key for xa_store() here?
>It looks like the store operation uses the old priority index (sb->arr_idx)
>instead of the new priority index (prio). Because the subbank is not stored
>at the new priority slot, the cleanup loop below that erases priorities with a
>net loss of subbanks could permanently delete valid subbanks from the xarrays,
>making them unavailable for allocation.

pw-bot: changes-requested
ACK.

