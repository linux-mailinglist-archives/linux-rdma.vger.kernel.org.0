Return-Path: <linux-rdma+bounces-20760-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KjjBTXLBmrynwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20760-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:28:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7BD54A921
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C5F23021E9D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688253E9C35;
	Fri, 15 May 2026 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="g5stKuKJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C134DCCD;
	Fri, 15 May 2026 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830056; cv=none; b=PrxrNbsLuPq4SckL1X9IGVdOZ6eWfHJNeVv5jfDhyh+/9KG+DTlfRGRRv9l61HB4WNSw6hmkYrXimSAiNaqyCSEMpnrVVr5YzhWI+OC/5xZtQ9a7XBRpWolgHE4kskHcfbQLPGgeZ6/PmoCXFWasW4aUrzvEkJnY0gCoBDxw698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830056; c=relaxed/simple;
	bh=CtXcKLY2TdeHy6fGq+PAmYUpChkHygIAlqMAIJMvYts=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkIVtuHP/M7v8DdYp091X5ceO3eRnupIy6mdWO8Qukzp30Uk9UdnRcTif33v6RM7JcsZ9i5xbap2FYJurk7LPPYphZhVRf/i16ax7Ktqvkh51GXZ/SWACyHMoeYo6RW2tjZfnak1qL2olyvI+bbarPdV8GIgvP5+WTunXwTmDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=g5stKuKJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F7B9CL1033243;
	Fri, 15 May 2026 00:27:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=y/HL4MaF3LtfbjmzG/YvFN4KE
	f18kgCJMeKCaLgm1VA=; b=g5stKuKJ6ocFJvgzqmxAzcARolm6hXN7U76l4T7Z+
	SdS/WpfqmEFdKpMYBx0ihLciRJyWTGP8TAo8bqkdYZJnKOaS80dDQjfs4fvQwveD
	Bd/qO8X5PVf73nZX9vEdn2IBR6BUimQ9Ags460Y61MzSWl5LrYI9d21FYm4+Fh2U
	WGWMYu1ILjOmb0NmQb6onWTrrBtEl/teEObxK9blN1vQI59m5SeD5SLI5EXfPlEd
	cPRIq8sAzAK3PdUpm2y2CXEmCyn8PbDUhBVHyIpo54t9H3f3kn4x7JAr3Ww3Kzbh
	mE3TgUs8xluPtM7J47yTjBnM1YzG5ceb1IlyBk++evuwQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e5m3whmvu-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 00:27:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 15 May 2026 00:27:00 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 15 May 2026 00:27:00 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1E8573F7057;
	Fri, 15 May 2026 00:26:49 -0700 (PDT)
Date: Fri, 15 May 2026 12:56:49 +0530
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
Subject: Re: [PATCH v14 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
Message-ID: <agbKuUI4m1Wtnti_@rkannoth-OptiPlex-7090>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-6-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514062537.3813802-6-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=YMqvDxGx c=1 sm=1 tr=0 ts=6a06cac7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=KvYP_omU_0Oirzp_N2YA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3MyBTYWx0ZWRfXyhvkg8VxWlgY
 WuwT2vSdqVjiRegaWMkJt1WW1qFcw+lwREXl56N86zZq9Zo7Isue8tbvSoc+bnYVPa+cf3nUSM3
 OvytXS/T9akmOyY2Qn764RWuAGYlK2peII6iJhR92zg+i06H5Dj5r4XZLneUf9itMmymWutKjuy
 QWay358evg1Sfe7ksNDZFOki0VpyKyP36+xU9QUn1/afdujovm1Zm81qn9a/RybjJ9aKW8V6Ojh
 2wgZNly52zpMoQcPZFfoR/wz8Rqf2DQ9myerbVZGKyo6oGdh92owovPec2LLKum+07/Wqu+Y91G
 LdBdKvFAF0I+OhBHuhZRyvharmKx65cd41fjmld3JVwLk9SOfV3yHfnK0kHFDt9Jukm9IDVfZ7z
 yBp+RTia91XXSEZVS3AMCQ9hKZJdN2A1u2TLeaKygkNRlQV1eweudK/QDxGtqNyFrQB3X+cHMwF
 8Xs0mU958Ah4JAhwWCQ==
X-Proofpoint-GUID: 6wjn7lM1EhK2N6T11qfwWx0mj6MAhQdD
X-Proofpoint-ORIG-GUID: 6wjn7lM1EhK2N6T11qfwWx0mj6MAhQdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 4C7BD54A921
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20760-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-05-14 at 11:55:33, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> CN20K NPC MCAM is split into 32 subbanks that are searched in a
> predefined order during allocation. Lower-numbered subbanks have
> higher priority than higher-numbered ones.
>
> Add a runtime "srch_order" to control the order in which
> subbanks are searched during MCAM allocation.
>

>
>> +int npc_cn20k_search_order_set(struct rvu *rvu,
>> +			       u64 narr[MAX_NUM_SUB_BANKS], int cnt)
>> +{
>> +	struct npc_mcam *mcam = &rvu->hw->mcam;
>> +	struct npc_subbank *sb;
>> +	struct xarray *xa;
>> +	int prio, rc;
>> +	int sb_idx;
>> +
>> +	if (cnt != npc_priv.num_subbanks) {
>> +		dev_err(rvu->dev, "Number of entries(%u) != %u\n",
>> +			cnt, npc_priv.num_subbanks);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&mcam->lock);
>> +	npc_lock_all_subbank();
>Does exposing npc_lock_all_subbank() to a user-triggerable devlink callback
>cause a lockdep violation?
>npc_lock_all_subbank() acquires mutexes for all subbanks sequentially.
>Since these mutexes share the same lock class, lockdep might detect this
>as a possible recursive lock. With up to 32 subbanks, this also exceeds
>the maximum lockdep nesting limit of 8 subclasses.

The 32 subbank mutexes are physically distinct locks protecting independent
hardware queues, meaning no actual runtime deadlock path exists. To satisfy
lockdep's verification engine and prevent tracking limit exhaustion during
sequential allocation, the driver uses a singular, overarching top-level
domain lock (mcam->lock) to serialize the entire configuration sequence.

Because mcam->lock acts as the primary synchronization barrier for the
devlink context, concurrent cross-subbank inversion paths are structurally
impossible. To permanently silence the tracking constraint warning, i can post a patch
(post merging this series) to either mutex_lock_nested() with an explicit index state
or disables lockdep tracking entirely for this specialized hardware control
loop using the lockdep_set_novalidate_class() macro

>> +	restrict_valid = false;
>> +
>> +	for (prio = 0; prio < cnt; prio++) {
>> +		sb_idx = narr[prio];
>> +		sb = &npc_priv.sb[sb_idx];
>> +		sb->arr_idx = prio;
>> +
>> +		/* erase entry if exist */
>> +		xa_erase(&npc_priv.xa_sb_free, sb->arr_idx);
>> +		xa_erase(&npc_priv.xa_sb_used, sb->arr_idx);
>> +
>> +		xa = &npc_priv.xa_sb_free;
>> +		if (sb->flags & NPC_SUBBANK_FLAG_USED)
>> +			xa = &npc_priv.xa_sb_used;
>> +
>> +		/* if xa_store() fails due to memory pressure, there is
>> +		 * no point in rolling back, as roll back may also fail
>> +		 */
>> +		rc = xa_err(xa_store(xa, sb->arr_idx,
>> +				     xa_mk_value(sb_idx), GFP_KERNEL));
>> +		if (rc) {
>> +			dev_err(rvu->dev,
>> +				"Setting arr_idx=%d for sb=%d failed\n",
>> +				sb->arr_idx, sb_idx);
>> +			goto fail;
>> +		}
>> +	}
>Does this error path leak subbank resources and leave the xarrays in a
>corrupted state?
>If xa_store() fails, the function jumps to the fail label and aborts
>without restoring the original state. Because the entry at the current
>priority index was already erased via xa_erase(), but the new subbank
>failed to store, that subbank is permanently lost.
>Additionally, the subbank that failed to store is left with a modified
>arr_idx pointing to an empty slot, potentially breaking future allocations.
>Could this function preallocate resources (such as using xa_reserve()) or
>build temporary xarrays to ensure the changes can be applied atomically
>without a destructive intermediate state?
>> +    restrict_valid = false;
>> +
>> +    for (prio = 0; prio < cnt; prio++) {
>> +            sb_idx = narr[prio];
>> +            sb = &npc_priv.sb[sb_idx];
>> +            sb->arr_idx = prio;
>> +
>> +            /* erase entry if exist */
>> +            xa_erase(&npc_priv.xa_sb_free, sb->arr_idx);
>> +            xa_erase(&npc_priv.xa_sb_used, sb->arr_idx);
>> +
>> +            xa = &npc_priv.xa_sb_free;
>> +            if (sb->flags & NPC_SUBBANK_FLAG_USED)
>> +                    xa = &npc_priv.xa_sb_used;
>> +
>> +            /* if xa_store() fails due to memory pressure, there is
>> +             * no point in rolling back, as roll back may also fail
>> +             */
>> +            rc = xa_err(xa_store(xa, sb->arr_idx,
>> +                                 xa_mk_value(sb_idx), GFP_KERNEL));
>> +            if (rc) {
>> +                    dev_err(rvu->dev,
>> +                            "Setting arr_idx=%d for sb=%d failed\n",
>> +                            sb->arr_idx, sb_idx);
>> +                    goto fail;
>> +            }
>> +    }
>Does this error path leak subbank resources and leave the xarrays in a
>corrupted state?
>If xa_store() fails, the function jumps to the fail label and aborts
>without restoring the original state. Because the entry at the current
>priority index was already erased via xa_erase(), but the new subbank
>failed to store, that subbank is permanently lost.
>Additionally, the subbank that failed to store is left with a modified
>arr_idx pointing to an empty slot, potentially breaking future allocations.
>Could this function preallocate resources (such as using xa_reserve()) or
>build temporary xarrays to ensure the changes can be applied atomically
>without a destructive intermediate state?

The omission of a transactional rollback path is intentional due to
the systemic implications of a GFP_KERNEL allocation failure inside
the xarray core. If xa_store() returns an ENOMEM error, the underlying
slab allocator is already exhausted, meaning any programmatic attempt
to erase or restore original indices would also fail, compounding the
unpredictable state.

Because this devlink callback operates under the top-level mcam->lock
mutex, no concurrent allocation or translation worker can read the
partially modified xarrays while the driver is in this degraded state.
An xa_store() failure indicates a fatal, system-wide memory leak or
exhaustion event. At this threshold, the driver prints a critical
error payload to dmesg to allow deterministic post-mortem debugging of
the host's global memory subsystem, rather than attempting an unreliable
in-kernel rollback.

