Return-Path: <linux-rdma+bounces-21154-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOIZOyxEEGrpVQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21154-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:55:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903885B3513
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 13:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A741300DDD8
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DE3EA94F;
	Fri, 22 May 2026 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gBip7CO+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7854C3CBE6B;
	Fri, 22 May 2026 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450540; cv=none; b=t7LcI0nIPMhpUy4wrSBBENwk9A5OQ8rqMUIPDvXpITHVbtO4OW9WOC2IVFiwaT0Tqt5LHDRDhHX71h9rtpqgPluLnkbzvGe4tdoxK58YehMRMLpqVeLWME3yGTNF5hZ4IaaSKqMdGUY8B4AHy4SvGd4DLC0Fg0ql/19w97q5/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450540; c=relaxed/simple;
	bh=6eyn1Jha3vDmyk2oxi9jurBu1zW/thPNp1/L6UVvqgI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8CUt3/PyuE33s9m/pmabmsAZvKbptHIWy6gNp6I0T8loyzSjnzDpj2E+S69G9Ip+e8tyQbbJipnbAxzU6g6ouyhgGP5puslZ45NL7TSYAJHLy9gWdmmuNYoEstka9JAvj4hQPulOhEEsYB0HAKGEsO/4WvWJjQZip1M7EPJ61I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gBip7CO+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M4qJuY092449;
	Fri, 22 May 2026 04:48:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=76lA5hDeG8LLZ60pzeSd7kSpw
	fGaYTO7DJWvyEI4nug=; b=gBip7CO+RSoN8qpe/kE5F9usyARcRz5/5VD5UYfJZ
	crOaxn7OPwSdKG5Yf17wqILngMtkWHBWvhm9qbN6PJgZZdu7oLnbrZlGWBdaWcYm
	XPsXOItfPXc3X2t2vc4H6auOsXJTl4QhImDoYVNNN7Fj2Jsh9eW3ZoFUou1PN3Ma
	QHWc810IUpqEEr4AweFRNzelOL+9fgimo/PsjM6vFKXpj3r9g4fcQT9FXex5B+O2
	4sfv37L9pK9wGLUXm3jRWSd97k1lZoGPKyDyfZYzHgnq80TSgabIGoIpvDUcP6xp
	11IpUnCByGHeW24+5jyJ9afSEQQye7RAuJevRv0PLUwsg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e9vjjccpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 04:48:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 22 May 2026 04:48:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 22 May 2026 04:48:15 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 1730C5B6949;
	Fri, 22 May 2026 04:48:06 -0700 (PDT)
Date: Fri, 22 May 2026 17:18:06 +0530
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
Subject: Re: [PATCH v16 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <ahBCdspfMKMJYPlW@rkannoth-OptiPlex-7090>
References: <20260521095303.2395584-1-rkannoth@marvell.com>
 <20260521095303.2395584-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260521095303.2395584-8-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=O4kJeh9W c=1 sm=1 tr=0 ts=6a104280 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=NlRZgN0ufz6fjOar1VwA:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: HIYrUHewJBAFBUAvIXL7nI5YC_SZaETQ
X-Proofpoint-GUID: HIYrUHewJBAFBUAvIXL7nI5YC_SZaETQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExOCBTYWx0ZWRfXxIZEWg2TUA3y
 d/abet0caiHgyTSLcUIv++rf7wbTrdYKCq4AI8uCzlDnQK3wOxFUKNOZuZ8Ea0eqQLCHx/xt1bo
 3SffeK//CV6A3GDJrO65b6m9ioQwJ0WEzrnPthaMFlesG8ttdFRgU7EfcNJiUb4N41X5pv9ILPk
 pQMRT0QYQyrIx/04k/bK2FL2TNDiQtcHN7PVTzyidecA/oJrpjVY6hNJEWK0ry2a+32TuduHapM
 oNB3sPKI1kNTDZJmIGdiC0YpKIInWx6FVP/iv0QyzragbLkqvaBU7YtboEsEXYfpmlRBYhUf67M
 b5ykz/dtQJMfn4ODoJZ1woB+JV99iZdzK59+DMawqiziEk581PaSfdEuqwLyl14XXnTrquQaFuf
 CncJIqiIeWEEq9ZGQobeuIwOUN0jdDkbl1ZBBqJBdqexYDNNmzvncrUSdkPA4Qd4SgIKn9vs1HL
 8R6/PSta7zU211uognA==
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
	TAGGED_FROM(0.00)[bounces-21154-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 903885B3513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-21 at 15:23:01, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.

>This commit introduces a mechanism to load custom KPU profiles from the
>filesystem at module load time. It adds a kpu_profile module parameter
>to read profiles from /lib/firmware/kpu.
>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> index 0e1744609ccfd..513e68711962f 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
>> @@ -1676,8 +1692,15 @@ int npc_cn20k_apply_custom_kpu(struct rvu *rvu,
>>  	}
>>
>>  	for (kpu = 0; kpu < fw->kpus; kpu++) {
>>  		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
>>  		if (fw_kpu->entries > KPU_CN20K_MAX_CST_ENT)
>This is a pre-existing issue, but missing a check for negative entries here
>allows bypassing bounds checks. If fw_kpu->entries is negative, multiplying it
>by sizeof(*cam) causes an unsigned wraparound. The offset decreases,
>potentially wrapping around the 64-bit address space to bypass bounds checks
>later, leading to arbitrary backward out-of-bounds reads. Could we add a check
>to ensure entries is non-negative?
>This is also a pre-existing issue, but does missing a bounds check before
>dereferencing the firmware structure fields lead to an out-of-bounds read?
>The bounds check for rvu->kpu_fwdata_sz < hdr_sz + offset happens later, but
>fw_kpu is located at fw->data + offset. If the firmware blob is truncated
>exactly at hdr_sz + offset, reading fw_kpu->entries accesses 4 bytes out of
>bounds. Can this be checked before accessing fw_kpu?

Pre existing issue. Will prepare patch for net tree once this series is merged.

>>
>> +static int npc_alloc_kpu_cam2_n_action2(struct rvu *rvu, int kpu_num,
>> +					int num_entries)
>> +{
>> +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
>> +	struct npc_kpu_profile *kpu;
>> +
>> +	kpu = &adapter->kpu[kpu_num];
>> +
>> +	kpu->cam2 = devm_kcalloc(rvu->dev, num_entries,
>> +				 sizeof(*kpu->cam2), GFP_KERNEL);
>Does storing device-managed memory in a shared static global array cause
>use-after-free and data races? The adapter->kpu pointer references
>npc_kpu_profiles, which is a static global array shared across all OcteonTX2
>devices.
>If multiple devices are probed, they will race to overwrite these pointers.
>Furthermore, if a device is unbound, the devm framework frees the memory,
>leaving dangling pointers in the global array which will trigger a
>use-after-free on subsequent access.
>

There is only one AF device per system.

>> +	fw = rvu->kpu_fwdata;
>>
>> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>> +			dev_warn(rvu->dev,
>> +				 "Profile size mismatch on KPU%i parsing\n",
>> +				 kpu + 1);
>> +			return -EINVAL;
>> +		}
>> +
>> +		fw_kpu = (struct npc_kpu_fwdata *)(fw->data + offset);
>> +		if (fw_kpu->entries < 0) {
>Is there a missing bounds check before dereferencing fw_kpu? The bounds check
>for rvu->kpu_fwdata_sz < hdr_sz + offset only verifies the start of the
>structure.
>Since fw_kpu is located at fw->data + offset, the structure itself resides
>after hdr_sz + offset. If the firmware blob is truncated to exactly
>hdr_sz + offset, reading fw_kpu->entries will access 4 bytes out of bounds.
>

This is an existing issue. I agree, even though we rearranged and renamed functions,
mentioned bug exist. Will prepare a net-next patch to harden these parts once this series
is merged.

> +	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
>> +				      sizeof(ikpu_action_entries),
>> +				      GFP_KERNEL);
>> +	if (!profile->ikpu2)
>> +		return -ENOMEM;
>> +
>> +	action = (struct npc_kpu_profile_action *)(fw->data + offset);
>> +
>> +	if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
>> +		return -EINVAL;
>> +
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>Does tying the firmware ABI to the kernel's internal array size break
>backward and forward compatibility?
>Since ikpu_action_entries is a statically sized kernel array, its size
>increases whenever new port kinds are added in future kernel releases. Older
>firmware binaries will either fail the bounds check or parse data from the
>wrong offset, breaking firmware compatibility.

NO. We keep the same size for all binaries (ikpu_action_entries). We cant introduce
size variable in this structure as it will break backward compatability.

>+	*fw_kpus = fw->kpus;
>> +
>> +	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
>> +	if (!sfw)
>> +		return -ENOMEM;
>> +
>> +	memcpy(sfw, fw, sizeof(*sfw));
>Will calling memcpy directly on an IOMEM pointer cause faults on ARM64?
>The KPU profile firmware can be loaded from the firmware database which maps
>the profile as device memory. Using standard memcpy emits unaligned loads or
>DC ZVA instructions that trigger hardware exceptions like alignment faults or
>external aborts on device memory on ARM64 architectures.
>Should memcpy_fromio be used here instead?
>
THis is not an IO memory. This fw loaded memory thru request_firmware_direct()

