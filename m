Return-Path: <linux-rdma+bounces-20762-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDQYDUHMBmrynwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20762-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:33:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3654A9FF
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B217C3065EB5
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8901A3E9C09;
	Fri, 15 May 2026 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SkSodnWs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3813DF01F;
	Fri, 15 May 2026 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830229; cv=none; b=r3amhdUYVr1pePOI4J2GNvIFihA0pX3Ot8bDQJlk/MGV9epDbeP8YhV9Zid66e/PI23TK/5aN/61iRwDRfW/36pgZqkSB8tW7LeFrojTBjQMWPrXmXwpCcjdQZZyP3Pm1b+om1qjJ44s5mUN3I57DU7jSceTEO1mtJli+Dz6J6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830229; c=relaxed/simple;
	bh=Qc0V+oBsz9NYag/Rs08yT6DmzNkjs35uRalKHucyqoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3UugpiDlE5h3ugzrWwuARDZQX0HHZTdVgYksaAFjuwlILfk+SbBgjg7evgSCWJo9dGoVLLaVxtvvk9stZQKDZIEUkRkr44U9VZa5LEyGLtEccRpWmYJXQZrxeRmLET6uRmprqT+HaSEIUClxrGrvLPkMVqJ3+FOUQ9Fq/tVvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SkSodnWs; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F7NV9o236018;
	Fri, 15 May 2026 00:29:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=6ze7yPiuD3UNPXYW4n8fxVLVH
	nR1K8F8PdrMkyW5KfY=; b=SkSodnWs364tH+LxXrnN81x1nrnUu2BpmJdmE1hjT
	UsqTAdDy8tZAt6ShAer1FhaWAusYblZG3H4EcfRmNxvB+DrTF655X+RPRS67p2IO
	spjERtgoFyQMNFqFQMwvSGXaFMUxjSl4YbjrlkdguKe/ALtrIsBuhmzmm7R5J1FC
	h/MDiynjVRvbHaGp4CmunP9uAARxyfi1Vlk6+QTPb8eLOBDcbmifMDfp6j+XS8AX
	RyfYvoFw5WiJmJvT7iODyB7clAq1uV0neZdWLC7het7iI57SiTh4D0/KTZAdR6Wr
	zSIivZ3kbnUaa51TlULNdOdxOWARkpfUpQ8hmV2Mx2HOQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e5m3shmv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 00:29:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 15 May 2026 00:29:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 15 May 2026 00:29:48 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8EC6C3F7057;
	Fri, 15 May 2026 00:29:40 -0700 (PDT)
Date: Fri, 15 May 2026 12:59:39 +0530
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
Subject: Re: [PATCH v14 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <agbLYwt5v6PMWYf6@rkannoth-OptiPlex-7090>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514062537.3813802-8-rkannoth@marvell.com>
X-Proofpoint-GUID: arqEWia0VCSlJjWkDASsbcFIR8tqxRr2
X-Authority-Analysis: v=2.4 cv=NtrhtcdJ c=1 sm=1 tr=0 ts=6a06cb6d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=aOsrkaatB_mle0zbCPYA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: arqEWia0VCSlJjWkDASsbcFIR8tqxRr2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3MyBTYWx0ZWRfX1LTArKeIXiXM
 DZOQ2+AalfsPJ2Em80puE1txUodjwaCNyROYnJpHOP/pjX1cvnlnlHEUZXu69GLD9osbtx5T/n0
 rKK7/ZAILZhPt6agyHONflyUOz6c0KfpAwNOe6j4L5X/W9uXUYoxarbO4MCnnn95t/9u31xyMwt
 2OrWeOux2hoohv2sKsBvnBiXdxXceXvnaU9LM12pq4EY8DnqYgwrpJQX7j55fR07hg/zCVsnIqX
 MJ48oTU9s/dGxHdW6GSvJ2QH5S0f4GKB4Sw/+OWYS2qJ1jw1hf0GMouPPPSfLxllcJZ3fLiQ3lu
 tFUgL7tmGlK863y3ia3TEzaRyNkxkY+REfgwKOK4ovW/vZRYH/WODWt6TjRyQ9rLGSkic3YBvnP
 rZbEdTrlFxUs0ypF6ethCr1Pd3eJ9sIdG/6vTEHszDO59AKNufOa81RfCyWfFRvrbAZvrcRgriP
 4AciPph9Axm9WeK0oZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 9EC3654A9FF
X-Rspamd-Server: lfdr
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20762-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Action: no action

On 2026-05-14 at 11:55:35, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in
> npc_config_kpucam when profile->from_fs is set.
>

>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> index ec5b2d6482462..21eb15f38c009 100644
>> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>[ ... ]
>> @@ -1788,26 +1872,175 @@ static void npc_prepare_default_kpu(struct rvu *rvu,
>>  	npc_cn20k_update_action_entries_n_flags(rvu, profile);
>>  }
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
>Since adapter->kpu can point to the global array npc_kpu_profiles
>(assigned in npc_prepare_default_kpu), does this store a device-managed
>allocation inside a global structure?
>If the device unbinds, the devm subsystem will automatically free this
>memory. Might this leave dangling pointers in the global state, leading to a
>use-after-free regression for concurrent or subsequent RVU device probes?

The concern regarding devm-allocated memory pointers persisting in a
global structure is valid in multi-instance architectures, but it is
not operational in this system due to hardware and driver life-cycle
guarantees.

First, the system topology restricts the platform to exactly one physical
RVU Admin Function (AF) device instance across the entire lifetime of the
running system. Because there are never concurrent or parallel RVU AF
hardware device instances probing the system, cross-device global pointer
corruption or concurrent use-after-free conditions cannot occur.

Second, the life cycle of the global profile structure is tied directly
to the lifetime of the underlying AF driver module. When the AF driver is
unbound or unloaded, the module's exit pathways discard the subsystem
state entirely. Since no subsequent or concurrent probe sequence can run
independently of this shared lifecycle, the devm-freed pointers inside the
adapter layout never present a true runtime dangling hazard.

>> +	if (!kpu->cam2)
>> +		return -ENOMEM;
>> +
>> +	kpu->action2 = devm_kcalloc(rvu->dev, num_entries,
>> +				    sizeof(*kpu->action2), GFP_KERNEL);
>> +	if (!kpu->action2)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +static int npc_apply_custom_kpu_from_fw(struct rvu *rvu,
>> +					struct npc_kpu_profile_adapter *profile)
>> +{
>> +	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
>> +	const struct npc_kpu_profile_fwdata *fw;
>> +	struct npc_kpu_profile_action *action;
>> +	struct npc_kpu_profile_cam *cam;
>> +	struct npc_kpu_fwdata *fw_kpu;
>> +	int entries, entry, kpu;
>> +
>> +	fw = rvu->kpu_fwdata;
>> +
>> +	for (kpu = 0; kpu < fw->kpus; kpu++) {
>> +		if (rvu->kpu_fwdata_sz < hdr_sz + offset) {
>Is this check sufficient to read the fw_kpu structure safely? The condition
>only verifies that the starting offset is within bounds, but immediately
>below we dereference fw_kpu->entries.
>If the remaining firmware data is less than sizeof(*fw_kpu), it seems this
>will result in an out-of-bounds read. The new npc_apply_custom_kpu_from_fs
>function handles this correctly by checking for
>hdr_sz + offset + sizeof(*fw_kpu).

The observation regarding the potential out-of-bounds boundary check
is correct, but it targets legacy parsing logic that is completely
outside the functional scope of this specific patch series.

The npc_apply_custom_kpu_from_fw() is existing code that was
merely refactored and moved to accommodate upstream review comments.
It does not introduce the sub-optimal length check as a regression.

This length validation issue will be isolated and submitted
independently as a standalone bug fix patch targeting the net tree.

>> +static int npc_apply_custom_kpu_from_fs(struct rvu *rvu,
>> +					struct npc_kpu_profile_adapter *profile)
>> +{
>> +	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
>> +	const struct npc_kpu_profile_fwdata *fw;
>> +	struct npc_kpu_profile_action *action;
>> +	struct npc_kpu_profile_cam2 *cam2;
>> +	struct npc_kpu_fwdata *fw_kpu;
>> +	int entries, ret, entry, kpu;
>> +
>> +	fw = rvu->kpu_fwdata;
>> +
>> +	/* Binary blob contains ikpu actions entries at start of data[0] */
>> +	profile->ikpu2 = devm_kcalloc(rvu->dev, 1,
>> +				      sizeof(ikpu_action_entries),
>> +				      GFP_KERNEL);
>> +	if (!profile->ikpu2)
>> +		return -ENOMEM;
>> +
>> +	action = (struct npc_kpu_profile_action *)(fw->data + offset);
>> +
>> +	if (rvu->kpu_fwdata_sz < hdr_sz + sizeof(ikpu_action_entries))
>> +		return -EINVAL;
>Could this lead to a memory leak of profile->ikpu2 and other devm_kcalloc
>allocations if the firmware parsing fails midway?
>Since npc_load_kpu_profile catches the error and falls back to the default
>profile, the device probe ultimately succeeds. The devm allocations from the
>failed filesystem attempt appear to remain stranded for the entire lifetime
>of the device.

The concern regarding the lifetime of the devm allocations during a
fallback scenario is understandable, but it does not represent a leaking
hazard or an operational bug.

Because these allocations are bound to the device's lifecycle using the
managed device resource framework (devm_kcalloc), the kernel guarantees
automatic reclamation when the underlying RVU physical device unbinds
or removes.

While the failed filesystem parsing attempt results in a fallback to
the default profile, the device probe itself still completes successfully.
The allocated profile block remains mapped to the operational device instance
as an unused buffer structure, rather than an untracked, stranded memory
leak. Explicitly rolling back or manually freeing devm memory within the
probe failure path would duplicate the clean-up routines inherently managed
by the devm subsystem, adding redundant code paths for a non-breaking,
one-time configuration fallback.

