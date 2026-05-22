Return-Path: <linux-rdma+bounces-21155-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKNANxpFEGpqVgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21155-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:59:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B835B3605
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5477F30A6E6E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1093F54AE;
	Fri, 22 May 2026 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="jLcXZYR0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEB3EFD1F;
	Fri, 22 May 2026 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450717; cv=none; b=Xa5JdW0XSOTbC5D8225FlRHRgDD5hiXAUuYJeIFvrEoKm5M+aafEeSZCzhT7YZ0DRhHjuojinu8TmmoQ+3dDR4jIdtScLjDBsCdskWI+/OyP09Kv2nPfew+2PCoWrfL7BkutNU+Zn0rCu+shsG5kTYeD1/55BV2dxZmnWMii9Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450717; c=relaxed/simple;
	bh=W2uoMQ06PqTqlnsg8xTdLjeudGgZmupcHFArBXUXn/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1OZaqpd12ZvrEfL+TcLOQdDIx43MTy7opi3hKzuObI0832/sgGyKJ9jG9v4WIXM5d78KjxhA8NK0uvNEG1sehCajYRb3IY4ekSz2KneXc0na+37QinehKC50kwcOsiYGH2s23TZCU6v88EWXxIvAFzLPvg4B39KrA+yIwl+2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=jLcXZYR0; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M56ri2091636;
	Fri, 22 May 2026 04:51:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=Q98qvVz6bWd4vJptQvs1DxTBs
	6d5qnrj7xHi6NTbZxg=; b=jLcXZYR0/UKn00mL7kFlk7Mu57oOazh3LlyM469oz
	34hCNk0a+S0scy/pk6WBXM+nDg1vXHUIPkvQK7iUzdOfPR81ZzRb2TAMeui4LM2S
	5xeAc+xzeBXhfZfRUDHE6F+1S9YnseHPhIACVc6AW4JqPsulcSS3A8B8GnRAYR1I
	jtWUghy919wvdv8RnTrWteFEClfxr0MkWnVBbdeRB6klidnRHNIq2OJfJO/zmxgo
	68eN4rFqx/psm3zfveUQUKAZjGo2qZMZoz8mv+tBRKBuO0K8foarp1RduGwLB7LS
	+/d/koJP9YRNNRncgCF0Y9+L4WNdwIkD+qxauVuiB4WJA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e9vjjcd21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 04:51:27 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 22 May 2026 04:51:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 22 May 2026 04:51:26 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 5AC5F3F707A;
	Fri, 22 May 2026 04:51:18 -0700 (PDT)
Date: Fri, 22 May 2026 17:21:17 +0530
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
Subject: Re: [PATCH v16 net-next 8/9] octeontx2: cn20k: Respect NPC MCAM
 X2/X4 profile in flows and DFT alloc
Message-ID: <ahBDNRgCfJKoAY9O@rkannoth-OptiPlex-7090>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
 <20260521095303.2395584-9-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521095303.2395584-9-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=O4kJeh9W c=1 sm=1 tr=0 ts=6a10433f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=h_rf9Kp-KExXIHB_074A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2t0pQsNbwm-7N9RYWypKqT7XwbdesSto
X-Proofpoint-GUID: 2t0pQsNbwm-7N9RYWypKqT7XwbdesSto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExOCBTYWx0ZWRfXwfhfWTEJmlxX
 0jjTtOIwVe7NVhn6KXWSGN4rzprNHK4B7aV9r+ljRhmwEiZB3nXvrKoaxwh4eB595oxPcQk3kob
 olYdK50sZwttyGCQLXK9Raifwz7buyFLmXPStZ99ZXYW1RBqA/Poz1PDn86fBpH3KSxRpcKRyeH
 JIOhnxklbeH6YNSDc1gHtwuKgxEYPO/G5F/9kUVciV8fO6m72s5GOThhrkswo0vjbZIvPRyqev8
 wAhBa2HckpL13irmHXHd6rlqOslgwvm5HgePsUBSx4xKJCs90ANPFv3v7pvVj+puJtrLlhYVywd
 /UckvxKVSJaSGT0k0L3jhcU23UstfoGLfXaK6C7NTGH1Vs0zGhzSyp5znkMIv058dTRfUevMUNV
 mLfsbq+5TfhKp04FgN5GG4+mbk6oEI9cRN8H/6AH/pT8efSOjJscO7PSGPebbccym4cbhR08tmx
 F9u1Y41dmXpWk5BIJxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21155-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 45B835B3605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 at 15:23:02, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
>> Default CN20K NPC rule allocation now keys off the active MCAM keyword
>> width: use X4 with a bank-masked reference index when the silicon uses
>> X4 keys, and X2 with the raw index otherwise (replacing the previous
>> always-X2 / eidx + 1 behaviour).
>
>> -static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, bool *is_x2,
>> -				  u16 *x4_slots)
>> +static int otx2_mcam_pfl_info_get(struct otx2_nic *pfvf, u16 *x4_slots, u8 *kw_type)
>>  {
>>  	struct npc_get_pfl_info_rsp *rsp;
>>  	struct msg_req *req;
>>  	static struct {
>>  		bool is_set;
>> -		bool is_x2;
>> +		u8 kw_type;
>>  		u16 x4_slots;
>>  	} pfl_info;
>This is a pre-existing issue, but since this patch expands the cached fields
>here, is it safe to use a function-local static struct for this profile
>information?
>Because pfl_info is static, it is shared globally across all NIC instances.
>However, access to it is protected by pfvf->mbox.lock further down in the
>function, which is a per-NIC instance lock.
>If multiple NIC instances (like multiple PFs or VFs) invoke this concurrently,
>they will acquire their own instance locks but race on this shared static
>structure. Could CPU or compiler instruction reordering cause one thread to
>observe pfl_info.is_set == true before x4_slots or kw_type are fully written?
>This could result in x4_slots == 0, causing underflow when calculating
>x4_slots - 1 later in otx2_alloc_mcam_entries().
>Additionally, does this mean the first probed device populates the cache for
>all devices, potentially forcing incorrect configurations if different hardware
>blocks have differing profiles?

These are AF attributes and is same for all PFs/VFs. Even multple PF/VFs request for these
features, AF will process these requests one by one. And all results of these requests will be same.

