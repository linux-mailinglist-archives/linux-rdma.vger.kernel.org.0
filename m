Return-Path: <linux-rdma+bounces-20340-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHIXC99MAWqnUAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20340-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:28:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 826385079DF
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 05:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7776F300B04B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4637C91F;
	Mon, 11 May 2026 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="boGCTIn2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C72225A38;
	Mon, 11 May 2026 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470101; cv=none; b=t4bPiFy0onrsDh+Nn/fISztxNiqeZM0zcOW03qiWlp+Ahobpjeobtgy1bI1BTlq3hjgAnuymmRKo/xLVTjC+UC7OmKuVVy7F3nuO/tA+vpeYPmcswJqToi0ow+ET8AH6OlWG4JxgVthHUwfdpJiHnfo0k+yQLCdr7yZyWlOZLdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470101; c=relaxed/simple;
	bh=cHa9TF65XKgAtaZwJgStkMjB54mwmKRj3/3OaDXHyEo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDT62ICdU/xI9/eAkyB1yWKOFy18y58cydUmV3XsLbHlhGuqFZcLYu7hJ+wqTMnWYZLvYSU3AM0D/b6b/9A6iqjFn+wW3RCQTbj2B0c3RXuWjO3CeNZMvKSFkFZhQJg8pl6EarNWUFvMU/H/8jJk0KLoVwFgpYPN0aYj49iW0RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=boGCTIn2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ANCPT22550148;
	Sun, 10 May 2026 20:27:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=kIBFiOeKUUS7hhydWEbQV1KAc
	v9hj4RTFo4FZIhv4eg=; b=boGCTIn2+4Q8dzUWc/cSC/Mz7UGAKbUjRwvSRZwBi
	4uKg3z/B1IqyTtdhrXBQhysuVVcEkU/Y/GL1jtMQ2RPvZJvF3szLOEnQbhPaNra0
	okPKsgawp/SVilp8wL52+VxjdpqcliyTPIFLvBOGbebRWs+LLxZ0aSAjVS50kfTZ
	9w617aV94jwFy251YorEpiD7ynI708gnn+8rK3Ne/mHv1HtkhE63KycroU8ucsmj
	Bo5lwpkozv6IW3t5eJmsTamw18q6y8Vn/BPoqF/B5RPz1wAuaydY2JwQJlZEdH7a
	VF7jzO5Z5JWVoUsAdiHjwqsCU/EA71LlfFYwNuo9WEOWQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e24ejaxav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 20:27:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 10 May 2026 20:27:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 10 May 2026 20:27:57 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 056163F708E;
	Sun, 10 May 2026 20:27:48 -0700 (PDT)
Date: Mon, 11 May 2026 08:57:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
        <oss-drivers@corigine.com>
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
Subject: Re: [PATCH v12 net-next 7/9] octeontx2-af: npc: Support for custom
 KPU profile from filesystem
Message-ID: <agFMs01f5aH63EDV@rkannoth-OptiPlex-7090>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
 <20260508034912.4082520-8-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260508034912.4082520-8-rkannoth@marvell.com>
X-Authority-Analysis: v=2.4 cv=c5qbhx9l c=1 sm=1 tr=0 ts=6a014cbf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=pzlqSEyjIBYPxFa5tP8A:9 a=CjuIK1q_8ugA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 5zUb3tE70VDA888__w3jEbooMCjDESuG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAzNCBTYWx0ZWRfX4zqZUKG7sEZ5
 VwxTwAKmk3mCTcwm8FCmC8eQVDJoXYT41elcVNjSAdCLE+tvSA1XPyHuqTtd2zZd69AGFIEX6ad
 eUw9PumK48KRcpo+m3gf66csewn3gTshUFg/S1tGTfcaBCXK/eVoGZLFBBep3inbm+X1EdjZtz+
 FlpyO/Mu3WahLs+f9+SXsm59QomD4zzNhC2u3UmCVriCSb4oQfB72amMbG+Hk/qwIbSwig99I/G
 T//0+YP6xu2ISajPNepaXSu1IrF7GG7v8sVaqu1M3aG8AqocVQxi7hfkvfax2ykx1eDNCvFat9I
 lxMBZvtS0ZtoxMgIt9AvUSYzO2j/64mXkuHrS+AtrIoFec418CvODqpFSeibA8qV7eaTwqcyTu2
 WiDea2sthonz7MnwGJK/LxcDrh4Ca1BntZJuk/Krz2rvdt36nYcgtqWu3b0mSG8nPQWvltFRIwQ
 0GC5hHB3HEoSmPWjQ4Q==
X-Proofpoint-GUID: 5zUb3tE70VDA888__w3jEbooMCjDESuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Rspamd-Queue-Id: 826385079DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20340-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
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

On 2026-05-08 at 09:19:10, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Flashing updated firmware on deployed devices is cumbersome. Provide a
> mechanism to load a custom KPU (Key Parse Unit) profile directly from
> the filesystem at module load time.
>
> When the rvu_af module is loaded with the kpu_profile parameter, the
> specified profile is read from /lib/firmware/kpu and programmed into
> the KPU registers. Add npc_kpu_profile_cam2 for the extended cam format
> used by filesystem-loaded profiles and support ptype/ptype_mask in

pw-bot: changes-requested

>>  } __packed;
>>
>> +struct npc_kpu_profile_cam2 {
>> +	u8 state;
>> +	u8 state_mask;
>> +	u16 dp0;
>> +	u16 dp0_mask;
>> +	u16 dp1;
>> +	u16 dp1_mask;
>> +	u16 dp2;
>> +	u16 dp2_mask;
>Since the firmware image is little-endian, should these fields be defined as
>__le16?
>When they are accessed as host-order integers without le16_to_cpu() conversion,
>will this lead to incorrect packet parsing rules and silent data corruption on
>big-endian architectures?

The current KPU profile loading infrastructure is architecturally
coupled to a little-endian firmware format. While I acknowledge that
defining these members as u16 instead of __le16 introduces a
potential risk of silent data corruption on big-endian hosts, the
existing OcteonTX2 driver stack is currently for
little-endian operation to match the native hardware and firmware
ecosystem.

Implementing full endian-neutrality for the KPU profile involves a
deep refactoring of the firmware parser and associated hardware
abstraction layers. Given that current deployments are exclusively
little-endian, I propose addressing host-endianness portability as a
comprehensive enhancement in a future net-next series. This ensures
that endian safety is addressed systematically across the entire
driver rather than being localized to this

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
>> +	if (!kpu->cam2)
>> +		return -ENOMEM;
>> +
>> +	kpu->action2 = devm_kcalloc(rvu->dev, num_entries,
>> +				    sizeof(*kpu->action2), GFP_KERNEL);
>Will this cause data corruption and a use-after-free across devices?
>In npc_prepare_default_kpu(), the device's profile->kpu pointer is initialized
>to point to the statically defined npc_kpu_profiles global array.
>Here, we are assigning device-scoped devm_kcalloc memory directly into this
>globally shared array. If multiple RVU devices probe concurrently, they might
>data-race on this shared state. Additionally, upon device unbind, devres will
>free the memory, leaving dangling pointers in the global array.

No. There is only one AF device and one LF for NPC. So mutluple proble of RVU af device is not
possible.

> +	fw = rvu->kpu_fwdata;
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
>> +		if (fw_kpu->entries > KPU_MAX_CST_ENT)
>> +			dev_warn(rvu->dev,
>> +				 "Too many custom entries on KPU%d: %d > %d\n",
>> +				 kpu, fw_kpu->entries, KPU_MAX_CST_ENT);
>> +		entries = min_t(int, fw_kpu->entries, KPU_MAX_CST_ENT);
>> +		cam = (struct npc_kpu_profile_cam *)fw_kpu->data;
>> +		offset += sizeof(*fw_kpu) + fw_kpu->entries * sizeof(*cam);
>Is there a missing bounds check here for negative values?
>Since fw_kpu->entries is read as a signed int, a malicious firmware blob
>providing a negative value (e.g., -1) could cause the offset calculation to
>underflow the unsigned size_t offset.
>This would wrap the offset backwards, allowing the boundary check
>(rvu->kpu_fwdata_sz < hdr_sz + offset) to incorrectly pass in the next
>iteration, resulting in an out-of-bounds access.
ACK. Added a check to check if fw_kpu->entries < 0 and return error.

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
>> +
>> +	/* The firmware layout does dependent on the internal size of
>> +	 * ikpu_action_entries.
>> +	 */
>> +	memcpy((void *)profile->ikpu2, action, sizeof(ikpu_action_entries));
>> +	offset += sizeof(ikpu_action_entries);
>Will this create a fragile firmware ABI coupled to the internal kernel
>structure size?
>Because ikpu_action_entries is a kernel-internal static array, its size
>depends on the number of port kinds (NPC_MAX_PKIND) defined in the specific
>kernel version compiling it.
>If future kernel versions add elements to this array, the parser will expect a
>larger initial block than the firmware file actually provides. This would
>misalign all subsequent read offsets, causing the driver to interpret garbage
>memory.
I agree that number of ikpu entries is not part of the structure. We dont want to
add a field and break legacy ABI. Here assumption is that ikpu section entries match
number of hardware ikpu entries.

>	strcat(path, kpu_profile);
>> +
>> +	if (request_firmware_direct(&fw, path, rvu->dev))
>> +		return -ENOENT;
>> +
>> +	dev_info(rvu->dev, "Loading KPU profile from filesystem: %s\n",
>> +		 path);
>> +
>> +	rvu->kpu_fwdata = fw->data;
>> +	rvu->kpu_fwdata_sz = fw->size;
>> +
>> +	ret = npc_apply_custom_kpu(rvu, profile, true, &fw_kpus);
>> +	release_firmware(fw);
>> +	rvu->kpu_fwdata = NULL;
>> +
>> +	if (ret) {
>> +		rvu->kpu_fwdata_sz = 0;
>> +		dev_err(rvu->dev,
>> +			"Loading KPU profile from filesystem failed\n");
>> +		return ret;
>> +	}
>> +
>> +	rvu->kpu.kpus = fw_kpus;
>> +	profile->kpus = fw_kpus;
>Does this truncate the hardware programming loop in npc_parser_profile_init()?
>By explicitly updating profile->kpus to fw_kpus, the hardware programming loop
>will only configure up to fw_kpus. Since all KPUs are disabled at the beginning
>of npc_parser_profile_init(), the remaining hardware KPUs will be left
>completely disabled, breaking network parsing for traffic reliant on default
>KPU logic.
BInary blob contains all entries fow all kpu hw entries. There is no partial loading as in
fw binary loading.

> npc_config_kpucam when profile->from_fs is set.

