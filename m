Return-Path: <linux-rdma+bounces-21071-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGP9ICh9Dmo1/AUAu9opvQ
	(envelope-from <linux-rdma+bounces-21071-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:34:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED8259E7B4
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEF79302439A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 03:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240C034DCEB;
	Thu, 21 May 2026 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lCyGbxXt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28532BDC13;
	Thu, 21 May 2026 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334434; cv=none; b=i0Ansb446O+qREuKc4BYisbxyzU3KqM2ucVX5oUYjfXEuxXsSN7OTan/aQ+nJHNy6HuCESCTQxNKQhpxV649pctAe0WWYDKnsEIK58G6GTiic8Rzs/r2m+SZVsmggmEGwfrW377l2KeR1tajS+tJnb9CwkuoS3JbES6d7g8eYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334434; c=relaxed/simple;
	bh=yFt1+6Um8q7+eLh4kt+xsMiLeh9KZ8pcIuYb/S5L/BU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlCGIvnDv+Gl835+trwdv3nIkayH/2ytus0PJ5ObL+uUPf4m39QZ78aqTItJbymVinKX7p8j7zpJazzmvlOhN7/sEN3zp7Q/uTMcqLagPJw523/7h23y6D/m4iRIrVB2GCW/SGcxJsuz6zA/Q3WTmGPMeZ/3YrCWQWZHk6HGTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lCyGbxXt; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L2cVDF1358276;
	Wed, 20 May 2026 20:33:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=RuuH+jVBCgJRXAEgm5itlS6+P
	NvTf2a1MsyknXR/I+w=; b=lCyGbxXtgNqCk6m4mfeVENSFjWdwZywaF0YaNSE8z
	QmaoY1n6uecM/4GwSGMduVt7rUw4JyEOt2lXAPoeF3avOKuRpW2WOJVmHzcFYkFR
	3gjguAnG4BQkx+8rjokmprrcs9OJgBt8yOaQDSQL86pCQC89xPB5yh2XtYTpo1wT
	RH+jaxk4v2eSbD/lpfTFZgSVTbLbLG1bE2y9PJ7Cd92p/wlv4mX8zDjN+9KNLk/y
	tM85vPcz9jhoRxsIqrh3rLh+AcfEAWRcWtNINFXCkMUSYHHgcQZqDhykWe/seSqI
	3CfW0LT5pNFQzebbggr4p5isRIikTidvj3RFJcKwTrQgg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e9sem83ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 20:33:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 20:33:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 20:33:16 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id A5A993F705A;
	Wed, 20 May 2026 20:33:08 -0700 (PDT)
Date: Thu, 21 May 2026 09:03:07 +0530
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
Subject: Re: [PATCH v15 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <ag5884G9AcnQaaO5@rkannoth-OptiPlex-7090>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
 <20260520020939.1457231-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520020939.1457231-7-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzMCBTYWx0ZWRfXwhymDlO36qpG
 e2kDTdao4eKcjyTXKVmnsThRVSr/So6/i+YsSYW+6n7d3RAQqkeC3XHGtCb5U5YFuMOHpYYQYV5
 aauL9Gh+C86O0poXh1ObAJ41o7rVfgoNIcx4P+m8ttB+inT7xWI8BsHTnZzcFSVB3UVPNjGNGAX
 QG857Hz4zhf7Y3LfyaYzjYoepjurySleIxvK3Lk+rz246Yi6u/oX8OGKtn/LM3lysRUaUIuJ9/y
 4lqJ8YI+fLP7QKzHsNQXLPgSh8/fCilbJ59z9vJih4z1hjLZiJHh23FsfeGI/6vbTRu2mgIXHWr
 2OQXWx83n8PT0JOqPgbZTMzFKRY3FAta0rd5fsdMR9FfVIjGSD96co9laRkBFtD0MXqjtFfG5K6
 Yft/ap3OX/nenOqEYEYdRPm69FXbnJWMLNAWOrEhHJzlPffiejAsz0thOiR3L5wLVhemE24DUX0
 3ONAk+It42gWr9rMBIw==
X-Proofpoint-GUID: ZQqhriIRdlBUh9rNCJy_qIP0swzZUjtd
X-Authority-Analysis: v=2.4 cv=HPrz0Itv c=1 sm=1 tr=0 ts=6a0e7cfd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=7kQYbe1jYpKiIMT8zEUA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZQqhriIRdlBUh9rNCJy_qIP0swzZUjtd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21071-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1ED8259E7B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-20 at 07:39:36, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
> reinit or teardown without the AF freeing CN20K default NPC rule indexes
> while the driver still owns that state (otx2_init_hw_resources and
> otx2_free_hw_resources).

>
>>  	/* Alloc NIX RQ HW context memory and config the base */
>>  	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
>> -	err = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> -	if (err)
>> +	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
>> +	if (rc)
>>  		goto free_mem;
>This isn't a bug introduced by this patch, but can repeated NIX_LF_ALLOC
>mailbox messages cause an unbounded memory leak of host DMA and heap memory?
>The function rvu_mbox_handler_nix_lf_alloc() handles the NIX_LF_ALLOC
>mailbox request by allocating memory for several context structures via
>qmem_alloc() and context bitmaps via kcalloc(). The pointers to these new
>allocations are written directly to the pfvf structure.
>However, there appears to be no check to ensure the contexts have not been
>allocated already, nor are existing allocations freed. Can a guest VM (VF)
>trigger this by repeatedly sending the NIX_LF_ALLOC message, constantly
>triggering new allocations while abandoning the previous pointers? This
>might leak host memory (especially dma_alloc_attrs space used in
>qmem_alloc()), potentially leading to host memory exhaustion.

The number of available NIX LFs is
structurally finite and bounded by the hardware topology. A VF/PF cannot
arbitrarily trigger allocations without successfully provisioned LF
resources. Furthermore, the NIX_LF_FREE mailbox path guarantees the
complete rollback and freeing of all hardware context memories (via
qmem_free) and bitmaps allocated during NIX_LF_ALLOC.

Repeated calls to NIX_LF_ALLOC on an already active/
allocated LF context are rejected earlier in the pipeline by validation
checks verifying block provisioning status, preventing dangling pointers or
unbounded heap leaks in nominal operation.

this patch strictly unifies the error return code
variable from 'err' to 'rc' to match driver-wide conventions. Addressing
secondary, pre-existing hardening improvements for the allocation path falls
outside the scope of this transactional fix and is better suited as a
separate hardening patch targeted at net-next.

