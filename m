Return-Path: <linux-rdma+bounces-20761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKm1KPbLBmrynwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:32:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0454A9DA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A069C307D023
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0153E92B7;
	Fri, 15 May 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hw7o8KdZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346173E4C8C;
	Fri, 15 May 2026 07:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830187; cv=none; b=taEuwb/ikcfKcnn6nZsnDzlGnHQaCU08AQEHMaDJO+Lk02pmQHKkKcEX3pD5KRMJz2mdi3JBlqZZtIlcriIpYD8xP7PY7cJOem1Z2ncQR1PKZBPPVUaJWVJRDWiNpC33wC+adzgzCyow9QjwFur0/NAIbL5o0wRu8fIB6Zdy9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830187; c=relaxed/simple;
	bh=dPuELiT2Bsqx8fnIaOkzHcfQa8yLb8VhNQiWP13A6Ek=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/HxEdxfaepRn6G4x3gTU7tHNK+OvVzsJR13WuHHAhUEmBbK5opO7mn53yjRgSYkQg27kGjzI47BSNGVjbpUdruPO7L89iHMg8tetePabs3mj5ferM8rzCX74xij3pTs3/HQmyw10wPY8cP8hrbIyip3+Fefb73eeTEQ7PClL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hw7o8KdZ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F7QCu3235793;
	Fri, 15 May 2026 00:28:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=ZW9mPw4tNY2+UL8Fwefbn8UoC
	5cQHplDA04VvRfNt5Q=; b=hw7o8KdZS4otf5MjFBBBEVbkj6mcd05+Ka+sSytXw
	QWSv8w1BrbZpZo2V1Lh63Mm2ursneQ2JjgwMdeuUhVa2aKUMnQj0XcsfB6z+VI+r
	O8yJTgrlKq3CQupBPd5JBF6uFqM1KgjGfBboW+8Arusj9MIMf1drt+4vAR+sgM4L
	7ZX5OACsECxBF0lUtLO2+qZhyJ33iJRe10W9z6taamExRTPicTqeCOuTrAsFWipo
	V6yLFK1nfhuPB364SEYlsV9i4Nyernr9b8t+zmYfyXv56CnssfjAB6LArZRC1Xfa
	c/y0QS/aKzGa5qtEoWufLw2lS3bkadI63DB0OZz3G7AUQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e5m3shmrd-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 00:28:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 15 May 2026 00:28:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 15 May 2026 00:28:24 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5500B3F7063;
	Fri, 15 May 2026 00:28:16 -0700 (PDT)
Date: Fri, 15 May 2026 12:58:15 +0530
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
Subject: Re: [PATCH v14 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <agbLD0oiKwkDJacw@rkannoth-OptiPlex-7090>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514062537.3813802-7-rkannoth@marvell.com>
X-Proofpoint-GUID: 97Elp48jrfrzVKfMTI48D2kSqZ-DCeiz
X-Authority-Analysis: v=2.4 cv=NtrhtcdJ c=1 sm=1 tr=0 ts=6a06cb1a cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=0cyJEnxP_0G9nOKdDYoA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 97Elp48jrfrzVKfMTI48D2kSqZ-DCeiz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3MyBTYWx0ZWRfX9fhuAAgiFAEj
 8uo95x2dm2n5kgKwEmO+QKVdKSKbrYq194AfxBgmhgH+2VrNTs2KrIN9lh1HPq2IzK0GEn6pY0C
 yjS+aAZujPuSwNqbRH8MmjBMgkBSh4rX1X9cxYSiKrlgOn2/hHL/aLirG2puIrW6dgfb0sCPI1q
 oAUoMfV1OqOWGq5BddWExVNiTbM3azmON1tbi5/z2baDdbeLHAQv4hoznZ1vMY3Bl+MyT1Cui6T
 UzjI2K1vkuaVaE3eoPU6JjK6hQoO0I+iLRfoUJx4w+x/iKz1O8vSFwK4ebloAO9G1VNJj0db+Qe
 Vh0JNMWULPJye7OY3Ut/9YrZVBodspEAxQrKuZGxnC4xoVlV8WJIyYbCxhMyu7Zweag8nYVNINy
 exoAZJbOwYhkJkAuRhbyxaUA6eJUKkUrA+nj37fLzlaP5D5OHUYc10hgOBoT2I1XMLF24/aQqsv
 y1Sfy8u1B8/LnMqgahA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 3EA0454A9DA
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
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20761-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-14 at 11:55:34, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
> reinit or teardown without the AF freeing CN20K default NPC rule indexes
> while the driver still owns that state (otx2_init_hw_resources and
> otx2_free_hw_resources).
>
> On CN20K, allocate default NPC rules from NIX LF alloc before
> nix_interface_init, roll back with npc_cn20k_dft_rules_free on failure,
> and free from NIX LF free when the new flag is not set. Tighten
> rvu_mbox_handler_nix_lf_alloc error handling: use a single rc, propagate
> qmem_alloc and other errors, and set -ENOMEM only when kcalloc fails
> (remove the blanket -ENOMEM at the free_mem path).
>

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> index f977734ae712c..7df256a9e01c5 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> @@ -1566,13 +1567,15 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>>
>>  	/* Alloc NIX RQ HW context memory and config the base */
>>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
>> -	err = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> -	if (err)
>> +	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> +	if (rc)
>>  		goto free_mem;
>>
>>  	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
>> -	if (!pfvf->rq_bmap)
>> +	if (!pfvf->rq_bmap) {
>> +		rc = -ENOMEM;
>>  		goto free_mem;
>> +	}
>While reviewing these error handling updates, I noticed a potential
>regression in the surrounding allocation logic. Does this code leak the DMA
>memory for pfvf->rq_ctx and pfvf->rq_bmap if a Virtual Function repeatedly
>sends NIX_LF_ALLOC messages without first sending a corresponding NIX_LF_FREE?
>Since qmem_alloc and kcalloc unconditionally allocate memory and overwrite
>the existing pfvf pointers without freeing the old ones, could an unprivileged
>guest exhaust host memory by continuously triggering this mailbox handler?
>The same pattern appears to apply to pfvf->sq_ctx and pfvf->cq_ctx further
>down in the function.
The concern regarding multiple sequential allocations without an
explicit free operation is mathematically valid, but it does not represent
a realistic vector for host memory exhaustion in this path.

The NIX Logical Function (LF) provisioning handler is an administrative
mailbox message governed by the upstream Virtual Function (VF)
managed by the RVU core. A VF cannot arbitrarily invoke NIX_LF_ALLOC
repeatedly to leak memory; the resource virtualization layer tracks the
lifecycle state of each functional interface, ensuring that an LF cannot be
re-allocated if it is already in an active or allocated state.

Furthermore, introducing extensive state validation or pre-allocation checks here falls
completely outside the scope of this enhancement patch.
Since this series focuses solely on replacing uninitialized return values and
standardizing error tracking, adding complex architectural lifecycle checks
would break patch granularity. This specific lifecycle robustification is more
appropriately handled via a dedicated hardening patch in a future net-next cycle.

