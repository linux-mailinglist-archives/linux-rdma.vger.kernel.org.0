Return-Path: <linux-rdma+bounces-20759-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qITqGhHLBmrynwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20759-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:28:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E099654A901
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5E4B3007645
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB063E639F;
	Fri, 15 May 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E88/UBIT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E03E3C78;
	Fri, 15 May 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830001; cv=none; b=DZsltImXz+66vacu7rVP8P9a7AnjO1EWDx4GT/Z3ThgwgwrcQQXl5RRTI9Y1hXMnp8l1WD6CvQxCuP5RTXhajaKheph/S5OLjvXL3kWMRh6uHksOXk0Zo1mB3fsE3BRh/Xf5t9ARBZ5JijzK/doN8mEvq/tDQ4cDSD84s2YWx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830001; c=relaxed/simple;
	bh=rn6/ula3vDQ4829pPgWNMsEwfK8ksSTohkiy8sGhTF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov3cX/A50/uAvxZYkmwZ4h+h/Zal9a3N/4MGlxVjqRIUeZOJZs8MaGEHV2WkOEiIAV+rl0le9SzOdP/ewAtURcH8twlg/Z/eUhRNKnN5ToKUshAEo2tKDmFs2cLleCXhsZ3RirZqhBZnAI122gEhWSITDho8qRBwjJgqggvhoIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E88/UBIT; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIthtu4095646;
	Fri, 15 May 2026 00:25:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=WOnducfS3paZgSFl4KbJykZx3
	i5uMkJS7UHzrhCoBIY=; b=E88/UBITT8vt9i+Bk40uP+X99ona+5ZOCo4OF2ERH
	sZeoYmRsEChge0Z3tu6oSpwyCrkpErHds9cFe3DYcCC2hP54Sfsv5vHRuIcqtz6u
	fT0Zp2wWw6KshE/Ps1WynJT4TyuWP/06BP/QBwIeqIhY44O4nj/xhYcM7q1nWd4z
	p8KIgdcYf4bSv9VgF1PLD1PWrM77W4YPTwYXvXcOXEfzmdfzo0Bi9/lE/r/YbIBv
	bXbR7RP9yLFlmUMsW70lV5D9T8E4N6xzsvTjRu1Mxg1LoJkp+jh+vqIwgXlBDa/J
	uh1UsjUBvGR6HtswZbSXitp62fxeR9wXXKkOFj5nUpJ1A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e5m3u1kr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 00:25:58 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 15 May 2026 00:25:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 15 May 2026 00:25:57 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 92AE93F705B;
	Fri, 15 May 2026 00:25:49 -0700 (PDT)
Date: Fri, 15 May 2026 12:55:48 +0530
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
Subject: Re: [PATCH v14 net-next 1/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
Message-ID: <agbKfBoaPy3f5f7N@rkannoth-OptiPlex-7090>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-2-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514062537.3813802-2-rkannoth@marvell.com>
X-Proofpoint-ORIG-GUID: G9z1-fb4midd3iJ1VKXHOx7JLweKZzLi
X-Proofpoint-GUID: G9z1-fb4midd3iJ1VKXHOx7JLweKZzLi
X-Authority-Analysis: v=2.4 cv=NMzlPU6g c=1 sm=1 tr=0 ts=6a06ca87 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=um1NWcqe1mITRn-8xCIA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3MyBTYWx0ZWRfXxj0J9ao3RtU1
 ae5kV2bSfBe+uUFMwAjB92Nh4MICSoq1G/CnKNtZQv8Jekh4E2gRJ0U6lSO/hEAs3epd7ywD9sV
 Wsr9ZDSYrj7U69NlRfTy3Ae9n4h0Dhyg1j1rvDp/P2jTwwzKom3hx1wyX4qHWtI0XDfkq6zb4+M
 JAqtUN5I5WucX5t9MOHMn66/sjYGvGj03tlLaX05CYls1Ar8KQ+GzD6h8+PsQG8yOocSt5uFkOY
 ZibB3Mf1F/qG5wWhAicAJPt2mWSx+BzDNnQj6bDCEUG8Mzjp2UPK0lSB48kKY+JQbGvxSp9yFn3
 rWtMqrm1zYHLeDypxkdwFgkv3xPfwsdIr8BSi83uBpO/p/NlXM/68usOEyL0UsTgRPIlf97ElKM
 lfU9UJut2fzPNGi8ZvvbzCO9Xto+LYM3Zb8hkkdWce8EXHAE7lTDgLP7t7Ft9MFeJwaTdS56qTu
 U3IJ+wvJmdDOu8Pnrzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: E099654A901
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20759-lists,linux-rdma=lfdr.de];
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

On 2026-05-14 at 11:55:29, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Improve MCAM visibility and field debugging for CN20K NPC.
>
> - Extend "mcam_layout" to show enabled (+) or disabled state per entry
>   so status can be verified without parsing the full "mcam_entry" dump.
> - Add "dstats" debugfs entry: reports recently hit MCAM indices with
>   packet counts; stats are cleared on read so each read shows deltas.
> - Add "mismatch" debugfs entry: lists MCAM entries that are enabled
>   but not explicitly allocated, helping diagnose allocation/field issues.
>

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
>> index 3d5eb952cc073..9567a2d80b584 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
>[ ... ]
>> @@ -193,6 +194,9 @@ struct npc_priv_t {
>>  	const int num_banks;
>>  	int num_subbanks;
>>  	int subbank_depth;
>> +	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
>> +		       MAX_NUM_SUB_BANKS *
>> +		       MAX_SUBBANK_DEPTH);
>[ ... ]
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> index 6b3f453fd5004..e9aad0ad3fa68 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>[ ... ]
>> @@ -842,6 +842,12 @@ npc_cn20k_enable_mcam_entry(struct rvu *rvu, int blkaddr,
>>  			    cfg);
>>  	}
>>
>> +update_en_map:
>> +	if (enable)
>> +		set_bit(index, npc_priv.en_map);
>> +	else
>> +		clear_bit(index, npc_priv.en_map);
>> +
>>  	return 0;
>>  }
>Will index ever exceed the static size of en_map?
>If the hardware reports larger values, could the set_bit() call here perform
>an out-of-bounds write and corrupt memory?
>

The index is guaranteed to stay within the static bounds of en_map.

The bitmap dimensions are calculated using the constants:
MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH. This product
represents the absolute maximum theoretical MCAM capacity for the
CN20K NPC architecture.

Furthermore, the index parameter is strictly validated upstream
within the RVU admin function layer (specifically via the resource
allocation checks in npc_get_mcam_idx) before reaching this function.
Because the hardware geometry is fixed and the index is validated
against the discovered capacity during initialization, an
out-of-bounds access is impossible.

>> +static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] = {};
>> +static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
>> +{
>[ ... ]
>> +			delta = stats - dstats[bank][idx];
>> +
>> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
>> +				 mcam_idx, pf, delta);
>> +			seq_puts(s, buff);
>> +
>> +			dstats[bank][idx] = stats;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&stats_lock);
>> +	return 0;
>> +}
>Is it safe to modify state within a seq_file show callback?
>The kernel's seq_file framework expects the show function to be side-effect
>free. If the formatted output exceeds the initial buffer size, seq_read_iter()
>discards the buffer, allocates a larger one, and re-invokes the show function.
>If that happens, wouldn't the retried invocation calculate a delta of zero
>because dstats was already updated in the first attempt, causing the
>statistics to be lost?

The seq_file show callback state mutation is safe in this context
because the implementation enforces a single-allocation guarantee
upstream via single_open_size().

During the .open file operation, single_open_size() is invoked with a
pre-calculated total size sufficient to contain the entire output
payload for all banks. This forces the seq_file framework to allocate
the full required buffer upfront.

Because the sequence allocation size matches the total data footprint,
seq_read_iter() will never encounter an overflow condition, avoiding the
discard-and-retry path entirely. Consequently, the show() callback is
guaranteed to execute exactly once per sequence read, eliminating the
possibility of calculating a zero delta on a re-entrant call.

>Additionally, dstats is declared as a global static array. If there are
>multiple RVU device instances, won't they overwrite each other's state and
>corrupt the delta calculations?
>The subsequent commit "octeontx2-af: npc: cn20k: Allocate npc_priv and dstats
>dynamically." might address the global array issue, but the seq_file state
>mutation appears to remain.

the system topology guarantees there is only a single RVU Admin Function (AF) device instance
active during the system life cycle. Because there are no concurrent
or multiple RVU AF instances to cause cross-device data corruption, the
global static array does not introduce an overwrite or race condition
between separate devices.

Moving dstats to a dynamic per-device structure in the subsequent patch
remains a structural improvement, but the logic in this transient commit
is functionally sound and free of data corruption risks.

