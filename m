Return-Path: <linux-rdma+bounces-21074-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALecFVt+Dmp9/AUAu9opvQ
	(envelope-from <linux-rdma+bounces-21074-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:39:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39959E83E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6B28302F695
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458F6357D1E;
	Thu, 21 May 2026 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OF38nS0g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F62DF6F6;
	Thu, 21 May 2026 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334740; cv=none; b=Ln/cLnGx9v2+7lQ2aMjv9cFjJpYUm15wJVop4zz1QADfeDlSzpEuEV2qUwodanth46WlDdNHqhgX96K46BK4mPHVVu0bzLF06EwBchVKekhiBE90ryn4MVqY9CS+jqeGeUgPsvMaHURhjwzP40AsfXuYFHB2LC6Dy45cN2fkOLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334740; c=relaxed/simple;
	bh=iMPwYQ9kRrCdDcZUghsMeeB0GiI5SPWNa6BppfKBaJw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVbt44JB2Vl9bw5OGMSt8t+VID3YdqikxLU/SjoJryP4xMw7AN9QpLaPZKpmKqC+1tTHa8W+tVKtYBBymvCib/imrXtx7itpBKVHAi7Jt042Z0auvcc3gno5TgKX2yJszXQ/sv1m2gXUWQtAWaM7xPFgxIZlSrMZNzthKwm3Nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=OF38nS0g; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1lNMG2256003;
	Wed, 20 May 2026 20:38:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=0ov8Ic93QNOfWJlgaNYYbYJKG
	a3YcWyuAQsNZJVNxas=; b=OF38nS0gg2chhCc7rXNcMRuphSA9kVPCdxTHKW2Pl
	vnLZJCWB0i4P0LE9w6hlOSlrtfDC2Vvz4ysE1iQ6hrqA5eLkH3gXPFYhNS92V3QK
	cZrNV9v7OMdBj6yRkswYMTS8cLgN3DDYMYFjeNfRS7h0UMzhmb0vq5N4tUHzXRFc
	4malwHw/+QjwoDG8Iqv9304ikVYOJX06Q1ACr1wWyMiliy9OnibKAbxhZ0dDjVdg
	GmvOWHhOjmJPb9SSYKgmNn3+tY48jSLWmKaeeiE06/bqINKO0M1CaK9Gf4sr3MFb
	KQbiEx+e1zVijYnFwImAOI8vH/K36xmmjcyMky8cxVZTA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e94euksg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 20:38:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 20:38:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 20:38:30 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id C120D3F704B;
	Wed, 20 May 2026 20:38:22 -0700 (PDT)
Date: Thu, 21 May 2026 09:08:21 +0530
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
Subject: Re: [PATCH v15 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <ag5-LVIKQo52Bv5t@rkannoth-OptiPlex-7090>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
 <20260520020939.1457231-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520020939.1457231-10-rkannoth@marvell.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzMSBTYWx0ZWRfX5gDY70KsJTY2
 YF0UwbYTQ2XEBKZerXsRg37sYQsWLlpyc7qT61RkVpM5kv9UqO61RitnQzy3MRWLCgI9TieGyzm
 LpC/YO9OhbKn22SLXi51ZnGezWKpA6hvRtTzorY9JAU1j866SnWWDG7Ftf0UjF3Dx2AnkpPdiwE
 RH/Fl5EVshGfutBZ2u7kIVU8B2Ax911JyLjX29utDJR6k6NI1sOMM7828yjb1h/EXPa+eUIYfNJ
 AGGOrtsdmKpqdwZRzugLlhKoYhNknv4YtyM60/Wz8l8sgKFRv6bmht7WJefG3f5D3ybu2wp2231
 1VnjtD+frd3fa7bnaqbKEoXBmoXz4P4N9vO9OATMZ4QUCgbAVVj4FlNHPVACjaGdslf9tcp8v03
 gUfNwo4wjDYPXj1aRg1hmu0e0JWglR06mLRjJhmErFPC7Yogy0yiiuTnmFC5xF8OwuIEYbyqcHp
 8RfmGDlvnGtBhrlKrvw==
X-Proofpoint-ORIG-GUID: 2qTirnuZanSTlgADtU1b4_KXHHe7wWhX
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a0e7e37 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=ni2-oO_KdjcKqhd8j-8A:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 2qTirnuZanSTlgADtU1b4_KXHHe7wWhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21074-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CB39959E83E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-20 at 07:39:39, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.
>

>> @@ -397,6 +398,10 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
>>  	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
>>  			    npc_priv, &npc_vidx2idx_map_fops);
>>
>> +	dstats = devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
>> +	if (!dstats)
>> +		return -ENOMEM;
>> +
>Since dstats is a file-scope global pointer, won't devm_kzalloc overwrite
>it unconditionally if a second device is probed? In a multi-device scenario,
>this would leak the memory allocated for the first device. Also, if a device
>is unbound, devm_kzalloc frees dstats, which leaves the global pointer
>dangling for any other active devices. Should this be stored in a per-device
>structure like struct rvu instead?

There is only one rvu AF device per system. so this condition wont happen.

>> @@ -3954,18 +3952,19 @@ int npc_cn20k_search_order_set(struct rvu *rvu,
>>  	npc_lock_all_subbank();
>>
>>  	for (sb_idx = 0; sb_idx < cnt; sb_idx++) {
>> -		sb = &npc_priv.sb[sb_idx];
>> +		sb = &npc_priv->sb[sb_idx];
>>  		save[sb->idx] = sb->arr_idx;
>>  	}
>>
>>  	for (prio = 0; prio < cnt; prio++) {
>>  		sb_idx = narr[prio];
>This is a pre-existing issue, but is there any bounds validation on the values
>in the narr array? If narr[prio] is greater than or equal to num_subbanks,
>sb_idx will be out of bounds, leading to memory corruption when accessing
>the npc_priv->sb array.

The function explicitly enforces a configuration guard
via the condition 'if (cnt != npc_priv.num_subbanks)'. This ensures that the
loop iteration space is perfectly identical to the active sub-bank count,
preventing mismatched boundary tracking.

The value of 'npc_priv.num_subbanks' is capped
strictly below or equal to MAX_NUM_SUB_BANKS. This invariant is validated
during the early Admin Function (AF) driver probe sequence; any violation
terminates the probe, ensuring that out-of-bounds array layout parameters
cannot manifest in an operational runtime state.

>> -		sb = &npc_priv.sb[sb_idx];
>>
>>  		if (sb->flags & NPC_SUBBANK_FLAG_USED)
>> -			xa = &npc_priv.xa_sb_used;
>> +			xa = &npc_priv->xa_sb_used;
>>  		else
>> -			xa = &npc_priv.xa_sb_free;
>> +			xa = &npc_priv->xa_sb_free;
>> +
>> +		sb = &npc_priv->sb[sb_idx];
>Does this reordering cause the code to evaluate the flags of the wrong
>subbank? Because sb is assigned after checking sb->flags, the condition is
>evaluating the flags of the subbank from the previous iteration (or the
>initialization loop) instead of the new sb_idx. This looks like it could
>route free subbanks into the used xarray or vice versa.
>[ ... ]
ACK.

>
>> -	rsp->kw_type = npc_priv.kw;
>> -	rsp->x4_slots = npc_priv.bank_depth;
>> +	rsp->kw_type = npc_priv->kw;
>> +	rsp->x4_slots = npc_priv->bank_depth;
>Since this is an externally reachable path (via mailbox), if npc_priv is NULL,
>could this be triggered by a VF to cause a NULL pointer dereference and kernel
>panic?
Mandatory Allocation Path: The 'npc_priv' structure allocation and
initialization are mandatory execution steps within the CN20K-specific chip
initialization pipeline. If this allocation fails due to memory exhaustion,
the core Admin Function (AF) driver probe sequence aborts immediately with
an error status.

Because a probe failure prevents the device from
registering or initializing its mailbox subsystem, no VF/PF can ever issue or
reach this mailbox handler unless the probe has completed successfully. Hence,
the allocation is guaranteed to be valid for the entire driver runtime.

>> @@ -4687,71 +4686,79 @@ static int npc_priv_init(struct rvu *rvu)
>>  		return -EINVAL;
>>  	}
>>
>> -	npc_priv.num_subbanks = num_subbanks;
>> -	npc_priv.bank_depth = bank_depth;
>> -	npc_priv.subbank_depth = subbank_depth;
>> +	npc_priv = kcalloc(1, sizeof(*npc_priv), GFP_KERNEL);
>> +	if (!npc_priv)
>> +		return -ENOMEM;
>> +
>Like dstats, npc_priv is a global pointer. If a second device is probed,
>won't this unconditionally overwrite npc_priv and leak the previously
>allocated memory? And similarly, if a device is unbound and npc_priv is
>freed, it will leave the global pointer dangling for other devices.

NO. as there is only one AF device per system.

