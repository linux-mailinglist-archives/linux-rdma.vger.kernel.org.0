Return-Path: <linux-rdma+bounces-21072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKc3DIx9Dmo1/AUAu9opvQ
	(envelope-from <linux-rdma+bounces-21072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:35:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B259E7E3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 05:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB7FD3004C16
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 03:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68039368971;
	Thu, 21 May 2026 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CeS57625"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96C368D43;
	Thu, 21 May 2026 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334535; cv=none; b=rZdf6oe9D+aGOUs81nUIbZxIToSvCFFF+baGglqcINZghjtjGyFfI/dQkmYvTyfhkCT/b2ED5f+HtbOn9bl6xDindAvmXeoV7UPAjG80s+lzalVfV22u3kiNFyhl+ZzTeVUDyCjuypXBNGLQAjlgEuTg/tpo4HdWFaKSGj6UMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334535; c=relaxed/simple;
	bh=moshBWE15UZnoCD5V64pTt2k5lgkOWRnHKKLPWqSizs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+e3hZ8VwQi4ZC3Y85Ko2vWz1HRHpDqsHx3T3U1KkxgJIiWBi1KRtFs1Wjqly7Ng1oNF4Z/lKKX1K7F4JB+qQj+Pc0o9thsrAdehv5iVy7d0kNxXPq21pnYwwwZwNntkZpobwItrGqlr6CzlfGECHUdK02mIMrWwXvC5KSJ4rYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CeS57625; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KG5NZ92758088;
	Wed, 20 May 2026 20:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=hD6kFXIHUISQTh8TKry/IAaDc
	rdzRm1QQq7F32R9jjw=; b=CeS57625olhEnoea4Ftpm6uzGBwTNS7CuBpnsZqXT
	doEyIq5atDnriCZR05ayF4YjBf7d3nbXMi4KZZnMGk5oeGfLnbL+aNmBivnjCmV9
	d6rHHQYtYcH69l9S36uGcEjCRSy/aBNu1bPDnK6davl3adcfxdziSRSwhcDrjdJE
	u+o9CKglrMjQPsiuUdxaUTyzVvwmsv3ZVrmo/scRk1BFtcTSXtukPvGK1MPXB3iI
	97fGb2Gr/xYf4aciyL8/RgQ/Q5yngdvnwqGtTyIJoj1PGGwa4AmEJd+k+vp42nn7
	SreX2qZckKSe6A/OCnmeRL+r4KMbatLV93/Ccu25QDOvQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4e9g5t1px7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 20:35:02 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 May 2026 20:35:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 May 2026 20:35:01 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id D5C823F705A;
	Wed, 20 May 2026 20:34:52 -0700 (PDT)
Date: Thu, 21 May 2026 09:04:51 +0530
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
Subject: Re: [PATCH v15 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <ag59W0c15nolHV5A@rkannoth-OptiPlex-7090>
References: <20260520020939.1457231-1-rkannoth@marvell.com>
 <20260520020939.1457231-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520020939.1457231-8-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=RcmgzVtv c=1 sm=1 tr=0 ts=6a0e7d66 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=JZNumeJdEMXqAt8E-vsA:9 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: nYalGxuMRrWe_A96hhxS61pweXjZqjTz
X-Proofpoint-GUID: nYalGxuMRrWe_A96hhxS61pweXjZqjTz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAzMSBTYWx0ZWRfX1eYj31/H5YUS
 jybwSc7w5DmvnfHcD5qHFv4mAlcV/pOMeXbjRVZXk87dMdTuOLF/ObUVAvqwJD0j8SmfO6PvXhR
 eA/OHxNflvpSJpIUZUDAtJAyCBEzoYWQwXp7KAtHUb9NoYCem2siZbu4xYjFB7z5MDN9rd0PIZQ
 buzb+dcadN9PJ37S8lniA6dVbvjUgXRAl86GIpXXrNMNV7aUU5S5kT5wGXsvxAAwImhZG0nepzp
 apflphHrdRTF1z4UTS98oFphB43PUpCsuC9oBos8UJORtISswQrLErdLodZlLeUvFOY0t0N/Jin
 Wi1Lv/W3U5DtQ7oVnhkpt4jqtGi9zyHy8SBUF1Fwe6aEVLWb+BS0ZlfYFlIyzikBD9XbzlQBmFz
 kvXo3mIO19TLAlb0u2JwHTZupquXltBbN16BPC68/sgcTYfZG+s/2J0wwWODSmeWbJOZJeXOkpJ
 zubaABeAREK6TTlQYCQ==
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
	TAGGED_FROM(0.00)[bounces-21072-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 944B259E7E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-20 at 07:39:37, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>

>> -static int npc_apply_custom_kpu(struct rvu *rvu,
>> -				struct npc_kpu_profile_adapter *profile)
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
>Since npc_prepare_default_kpu() sets adapter->kpu to point to the global
>static array npc_kpu_profiles, does this allocate device-managed memory
>and store it in a global structure?
>If a custom filesystem profile is loaded, devm_kcalloc() will associate the
>allocation with the current rvu->dev. When the device is unbound, the memory
>is freed but the global npc_kpu_profiles array retains dangling pointers.
>Could this lead to a use-after-free or cross-device corruption if multiple
>RVU devices are probed?

The RVU Admin Function (AF) is a singleton
hardware block within the SoC architecture. There is structurally only a
single instance of this device probed per system, precluding any risk of cross-
device pointer corruption or multi-instance allocation conflicts.

Since there is a 1:1 mapping between the rvu->dev instance
and the global hardware profile structures, the lifespan of the devm-allocated
memory is structurally bound to the lifespan of the entire driver module. The
pointers inside the global array are only populated upon a successful probe
of this unique instance and are discarded if the block is unbound, preventing
nominal use-after-free conditions.

>This is a pre-existing issue, but modifying kpu->cam2 and kpu->action2, or
>copying custom entries directly into kpu->cam and kpu->action, mutates the
>default global npc_kpu_profiles array in-place. Does this inadvertently
>affect other RVU devices that might be relying on the default profile?

The driver operates under distinct state
machines for profile initialization. If a custom profile is successfully
loaded from  filesystem, the driver diverts from and entirely
bypasses the default global 'npc_kpu_profiles' array path.

n-place mutations to 'kpu->cam2' and
'kpu->action2' occur strictly within the context of a dynamically allocated
custom adapter profile. Because custom profiles instantiate independent memory
buffers.

> +static int npc_apply_custom_kpu_from_fw(struct rvu *rvu,
>> +					struct npc_kpu_profile_adapter *profile)
>>  {
>>  	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata), offset = 0;
>> +	const struct npc_kpu_profile_fwdata *fw;
>>  	struct npc_kpu_profile_action *action;
>> -	struct npc_kpu_profile_fwdata *fw;
>>  	struct npc_kpu_profile_cam *cam;
>>  	struct npc_kpu_fwdata *fw_kpu;
>> -	int entries;
>> -	u16 kpu, entry;
>> +	int entries, entry, kpu;
>>
>> -	if (is_cn20k(rvu->pdev))
>> -		return npc_cn20k_apply_custom_kpu(rvu, profile);
>> +	fw = rvu->kpu_fwdata;
>> +
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
>This is a pre-existing issue, but is the bounds check here sufficient to
>prevent out-of-bounds memory accesses?
>The check validates that hdr_sz + offset fits within rvu->kpu_fwdata_sz,
>but it doesn't include the size of the fw_kpu structure itself.
>If the remaining firmware buffer exactly equals offset, wouldn't reading
>fw_kpu->entries access memory past the end of the firmware buffer?

This is a legacy code issue and will fix as part of a follow up patch to net tree.

>> +				struct npc_kpu_profile_adapter *profile,
>> +				bool from_fs, int *fw_kpus)
>> +{
>> +	size_t hdr_sz = sizeof(struct npc_kpu_profile_fwdata);
>> +	const struct npc_kpu_profile_fwdata *fw;
>> +	struct npc_kpu_profile_fwdata *sfw;
>[ ... ]
>> +	*fw_kpus = fw->kpus;
>> +
>> +	sfw = devm_kcalloc(rvu->dev, 1, sizeof(*sfw), GFP_KERNEL);
>> +	if (!sfw)
>> +		return -ENOMEM;
>> +
>> +	memcpy(sfw, fw, sizeof(*sfw));
>Is it safe to use standard memcpy() here when fw could be an I/O memory
>pointer?
>When the KPU profile is loaded from the firmware database, fw points
>directly to an __iomem mapping via ioremap_wc(). On ARM64 architectures,
>using standard memcpy() on device memory can cause unaligned or wide
>SIMD/NEON load instructions, resulting in a Synchronous Abort and kernel
>panic.
>Should this code use memcpy_fromio() instead to handle the device memory
>safely?
>> +
>>  	profile->custom = 1;
>> -	profile->name = fw->name;
>> +	profile->name = sfw->name;
>>  	profile->version = le64_to_cpu(fw->version);
>> -	profile->mcam_kex_prfl.mkex = &fw->mkex;
>> -	profile->lt_def = &fw->lt_def;
>[ ... ]

The 'fw' pointer references a standard
system memory shadow buffer allocated via the firmware subsystem interface
(e.g., request_firmware), not a direct MMIO or __iomem mapped peripheral
region.

