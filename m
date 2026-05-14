Return-Path: <linux-rdma+bounces-20632-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICHfJdFLBWoIUgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20632-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:13:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FBB53D916
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D0983033F8F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92903644DB;
	Thu, 14 May 2026 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ezRhRNmR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106D2DB7B8;
	Thu, 14 May 2026 04:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731962; cv=none; b=kQc1vJd8dOhfu+iWHGCmlhMi+AeUiG8WIOo4H8xuSelAgbWZKx6HUzttKec6KF736PfTni154rLxMqt1heYIUSgJ58sGbURyWPYlJ1CAJ2wFb3yzgzORNceAq6ghuBrS6kv8aigyulDlzp5QvUs8Sh6Cd+BCyebujyPWMcIgOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731962; c=relaxed/simple;
	bh=O/5IzQ+ALGwPU70swHcEct5p/ZwjQeEnGuuuBIkLcgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcjgjqi8eUODnFMjB7HC2zYpnKqdCwiw5owd59UL+Nvf5WccoeFJ8uYVVpbRQfcVRjgXNFMUemjeWFI7B0WDtJUnLJnA/KK62wVvjd6vr8qXR0VtIRbQypgK5Rk9zYLUwPEjMXWyQtnHdcIQ7x8S8WyzdxkKvfhq00PjGX/PLxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ezRhRNmR; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DIK4851649973;
	Wed, 13 May 2026 21:12:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=jVg5XPevpAN+4FeOvuj9GFc3w
	qhzOHV7/gPPdCyPZ6o=; b=ezRhRNmRpcCZzp2xc2IL7dBlUQhq8MD0ZA769dSYu
	YSLoqScQoJxhxgC++AXZv5cMLC7LzJtWA+JTWJYYFpexYQx1BS68Ck6EBd7ImqN/
	qjT6NHYMGfjzlR7Ghpjj8DJTgQ5ZNLOzShKIx4sTdJdGsVQpWzbnznhcv+QMB05j
	a6RlOEvAX6MQKES7p72dEtZ8TmQsfKROLYZIFy0z//KiQCYNnle6mw2AhzEgEizV
	nECF6gfHozTYWs7Vx1reCmAm4KhoOSZ+dVpqw0MUL6J5OLXz+EjM9fqG7cpz7KAk
	lckUTnrH09vP1mHNwG41kJQ2Zzi2Ju0oBOlwKXdtnORtQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e4xg11adu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 21:12:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 13 May 2026 21:12:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 13 May 2026 21:12:15 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C657F5B6938;
	Wed, 13 May 2026 21:12:07 -0700 (PDT)
Date: Thu, 14 May 2026 09:42:06 +0530
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
Subject: Re: [PATCH v13 net-next 6/9] octeontx2: cn20k: Coordinate default
 rules with NIX LF lifecycle
Message-ID: <agVLlhSQSditFNd0@rkannoth-OptiPlex-7090>
References: <20260511033923.1301976-1-rkannoth@marvell.com>
 <20260511033923.1301976-7-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260511033923.1301976-7-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a054ba1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=lYvYoO4M92OMNn7NHnwA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BC_1ImIzAMnZ5nxuEDDzc_n5FhLp1rsl
X-Proofpoint-GUID: BC_1ImIzAMnZ5nxuEDDzc_n5FhLp1rsl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAzOCBTYWx0ZWRfXy0l7JUih9h2W
 mPrMuCahDrm0yx+wGt++hA2cX39DqhwnbGi/7CLnmklnoz7eudYVdHfWApJISc7RgsuBQkFQenu
 1FFdYFVhhhNfL/JdDXfKGhdO1snCthfJSe6DvP0rdkxnDOysKtiWvEJX3d0OBa76tntVSu4M1v4
 mmiH/N+Y04K0KYEvyGmSJ0iTp26a7lJeasCFAqZ2KcdmIJDEpTecB2mANx8AEle45NsNeec+5rn
 TGvM1d51lRe54G2w9gj1yIIAv+uUq48y+d5WcRUAMKZmVAgF2hT+r6+kJLHVghiA1d8/ScA4CR2
 2xTz1OvC4M+cp/BnvWbJOTDYcddGcCtHKrfSWLFFlTCHFdumE1yGWIFn51tDJGYl874CtmdeTxO
 UEtlweieu5p1SryIXnZFr2OPPTmSfObd7jzyH1NNrWiRO8ThyLC20IGjNMkxPC4bVRH0Nh7jC7z
 IQB02s5QI+UbCIQ9O5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: F1FBB53D916
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20632-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Action: no action

On 2026-05-11 at 09:09:20, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Add NIX_LF_DONT_FREE_DFT_IDXS so the PF can send NIX LF free during hw
> reinit or teardown without the AF freeing CN20K default NPC rule indexes
> while the driver still owns that state (otx2_init_hw_resources and
> otx2_free_hw_resources).

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
>[ ... ]
>> @@ -1684,10 +1691,16 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>>  	if (is_sdp_pfvf(rvu, pcifunc))
>>  		intf = NIX_INTF_TYPE_SDP;
>>
>> -	err = nix_interface_init(rvu, pcifunc, intf, nixlf, rsp,
>> -				 !!(req->flags & NIX_LF_LBK_BLK_SEL));
>> -	if (err)
>> -		goto free_mem;
>> +	if (is_cn20k(rvu->pdev)) {
>> +		rc = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
>> +		if (rc)
>> +			goto free_mem;
>> +	}
>Can this error path wipe out user-configured MCAM rules?
No. Default rules are configured first soon after nix_lf alloc. So there is no
rule before it.

>> -			__func__, pcifunc);
>> +
>> +	/* In cn20k, default rules are freed before detach rsrc */
>> +	if (ucast_idx < 0)
>>  		return;
>> -	}
>Does this unconditionally remove the error log and mask legitimate errors on
>older silicon?
>If npc_get_nixlf_mcam_index() fails on non-CN20K platforms due to an internal
>error or missing entry, the failure is now silently ignored, degrading
>debuggability. Should this dev_err() be preserved and wrapped in an
>is_cn20k() check instead?
nix_lf_detach() will be called first and then rvu_npc_clear_ucast_entry().
In cn20k, since npc mcam entries are allocated/deallocated dynamically, ucast_idx
will be negative. Remove the unnecessary log.

>
> On CN20K, allocate default NPC rules from NIX LF alloc before
> nix_interface_init, roll back with npc_cn20k_dft_rules_free on failure,
> and free from NIX LF free when the new flag is not set. Tighten
> rvu_mbox_handler_nix_lf_alloc error handling: use a single rc, propagate
> qmem_alloc and other errors, and set -ENOMEM only when kcalloc fails
> (remove the blanket -ENOMEM at the free_mem path).
>
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 69 ++++++++++++-------
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 20 ++++--
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  6 +-
>  4 files changed, 61 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index dc42c81c0942..e07fbf842b94 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h

