Return-Path: <linux-rdma+bounces-20763-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NgoM3/MBmrynwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20763-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:34:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7654AA3C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18EA130910EF
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 07:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62283EF65C;
	Fri, 15 May 2026 07:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MYp/CBZE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0703EF66B;
	Fri, 15 May 2026 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830259; cv=none; b=B0YpGTgZOtYheQSdpPJ+h2A8sET0Pj3txPQtdxVT1CDGm9CYhwSt3iIdGwoHQPthjhVScOqZrhGngpbmDDVVtYSYXHnuIfIWMpd4GpIscsanmgsGsbnEzYZEGmNjIeaV2EoSonHN3A7DkKEpaEiPalUiTMXBWJlElfA3x6FUjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830259; c=relaxed/simple;
	bh=d0Kt3xKJRx8BG1SM8nfNrs3y9A0YwGic8Ep8Tg2mZsI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDMS4k//psDspN+tk4Efddpmn6ALxt6kRG9YSF7YRJSAc8yhfzEwgP3ljvqp2LfsPuPGozELs7XO5ybRX5SVc/JraJ10sgsit2QjRGl4bL04fka4y4kzmwJl1g7V9HPGgsWRjpuR+XmCceDPfbqLffQ8nDTCPUtHX3s8y+0HLOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MYp/CBZE; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F7Q5IK235918;
	Fri, 15 May 2026 00:30:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	axk6VHkC9O1+l7O4FvdtYcQCnCnI0bBdK8uGHZVBxo=; b=MYp/CBZEg0qvnyPsK
	u7ieHcP5nD4e/LyKyuO693USSvtr+GX1UjeyHhp6vjCmSheR09gQT9rVnT3GbwRi
	qvg4VlxOzjr0nBy2VVzKcAOIFnQxk70F+3RsRcuO95zDtM+1oP+CNo8L7GXzt7qw
	9Nief8fYdve33M/lXL0nqnDlJlPrFXoAgZ/RCc2/FKWIPZCzpaplU3Yqs5c3Q972
	gJYWXsUn502ninc+ygX9VP9MIwIEQgHoPXoGqRMmnQ/CMyNcY2kYqRp9B9D7glrM
	+mgjtzkxitmzH7pv/s+eSf5jLfOj1yJlcJXnxZ99recMgfOheVpVZBrA4reAvlma
	2OFLg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4e5m3shn5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 00:30:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 15 May 2026 00:30:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 15 May 2026 00:30:39 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0A8953F705B;
	Fri, 15 May 2026 00:30:31 -0700 (PDT)
Date: Fri, 15 May 2026 13:00:30 +0530
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
Subject: Re: [PATCH v14 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
Message-ID: <agbLlpli-whxptBX@rkannoth-OptiPlex-7090>
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-10-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514062537.3813802-10-rkannoth@marvell.com>
X-Proofpoint-GUID: 2e2IpkC-R7Icf1wrfMDb87VupUCFURLg
X-Authority-Analysis: v=2.4 cv=NtrhtcdJ c=1 sm=1 tr=0 ts=6a06cba0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8
 a=deVN925vS6uNbc_aF5kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 2e2IpkC-R7Icf1wrfMDb87VupUCFURLg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA3NCBTYWx0ZWRfX0yZVeFx589u0
 XT5g+PpBJoki/to7G2lNKYfWUNWZokwHIAVFhe+Sjzo9TQzqjKaeeclr84Sksucm0BW9zBDYxVN
 g4A0PMmeTmiLO7oD1rcJTs6Q5EThspHS9+1eCbf89arcYQAXv8r707zuIeizwdIQVcvZfF+Tcb+
 TY/1R3n1RigbsJv9IAWdycK7xWtp11tWkP4Mocig6iihK3afXV1QTNYDx5pfbJv/0REx0JeMaJH
 kZckHCZrQuUdGRKLqH1qnvt1nBgfnft+Zp8oHs9MxVZwU5alHytB6A+7idklsZ0y2CwXyeCHcZy
 vJTSLnPsjJF/LG/x3Wm5Br08B4l0oPXryzfhdL2Gb5LT3arRY65aLHsrIIkTX+G4e9yjk2KAiRe
 syOXki3IRE8Xu9jlaFRiUigf4q/4Aa3I4u843J6nqMiZBAG6ivtH6oZt7KK2suy8kuIyeFRSWFb
 bAhe3bLv2NXgOoSd8Ng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Rspamd-Queue-Id: 4BF7654AA3C
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email,marvell.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20763-lists,linux-rdma=lfdr.de];
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

On 2026-05-14 at 11:55:37, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> Replace the file-scope static npc_priv with a kcalloc'd struct filled
> from hardware bank/subbank geometry at init (num_banks is no longer a
> const compile-time constant; drop init_done and use a non-NULL
> npc_priv pointer for liveness). Thread npc_priv_get() / pointer access
> through the CN20K NPC code paths, extend teardown to kfree the root
> struct on failure and in npc_cn20k_deinit, and adjust MCAM section
> setup to use the discovered subbank count.
>

>>  #include "cn20k/reg.h"
>>  #include "rvu_npc_fs.h"
>>
>> -static struct npc_priv_t npc_priv = {
>> -	.num_banks = MAX_NUM_BANKS,
>> -};
>> +static struct npc_priv_t *npc_priv;
>Since npc_priv and dstats are still declared as global file-scope variables,
>won't probing multiple RVU devices cause these pointers to be overwritten?
>If a second device is probed, the allocations for the first device would be
>leaked and both devices would end up sharing the second device's state.
>On device unbind, devres will automatically free dstats, leaving a dangling
>global pointer. Additionally, npc_cn20k_deinit() explicitly frees npc_priv
>and sets it to NULL.
>If a userspace process reads a debugfs file after device unbind, could it
>cause a NULL pointer dereference on npc_priv or a use-after-free when
>accessing the dstats array?
While a global file-scope pointer introduces a shared-state risk in
drivers that support multiple instances, the structural design and
physical topology of the OcteonTX2 platform eliminate this hazard.

First, the system architecture dictates that exactly one physical RVU
Admin Function (AF) hardware block exists per SoC layout. Because the
hardware platform cannot expose multiple active AF instances, there is
no parallel or sequential device probing sequence to trigger a race
condition, overwrite existing allocations, or cause memory leaks between distinct devices.

Second, the debugfs nodes and the driver's structural life cycle are
fundamentally serialized. When a device unbind occurs, the kernel’s
driver model coordinates the teardown by systematically removing the
associated debugfs entries before finalizing the subsystem de-initialization.
Because the debugfs file operations are unlinked and blocked from further
invocation prior to executing the kfree(npc_priv) routine in
npc_cn20k_deinit(), any userspace read attempt is rejected at the VFS
layer, removing the possibility of a post-unbind NULL pointer dereference
or use-after-free regression.

>>   */
>>  struct npc_priv_t {
>>  	int bank_depth;
>> -	const int num_banks;
>> +	int num_banks;
>>  	int num_subbanks;
>>  	int subbank_depth;
>>  	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *
>Now that num_banks and bank_depth are populated from hardware values
>instead of compile-time constants, do we need to validate them against the
>MAX_NUM_BANKS and MAX_SUBBANK_DEPTH constants?
>Looking at npc_mcam_dstats_show(), it loops based on these hardware values
>and indexes into the dstats array:
>npc_mcam_dstats_show() {
>    ...
>	for (int bank = npc_priv->num_banks - 1; bank >= 0; bank--) {
>		for (int idx = npc_priv->bank_depth - 1; idx >= 0; idx--) {
>            ...
>			if (stats < dstats[0][bank][idx])
>				dstats[0][bank][idx] = 0;
>    ...
>}
>Since dstats is still statically sized using MAX_NUM_BANKS and related
>macros, will this result in out-of-bounds accesses if the hardware returns
>larger values?
>Similarly, the en_map bitmap is sized using these same static constants.
>Could operations like set_bit(index, npc_priv->en_map) in
>npc_cn20k_enable_mcam_entry() corrupt the npc_priv_t structure if the
>hardware dimensions exceed the static bitmap size?

The static definitions for the tracking arrays and bitmaps are based
strictly on the silicon's hard limits, preventing any possibility of
out-of-bounds corruption.

The compile-time constants (MAX_NUM_BANKS, MAX_NUM_SUB_BANKS, and
MAX_SUBBANK_DEPTH) do not represent arbitrary bounds; they define the
absolute, physical maximum limits across all existing and planned SoC
variants for the CN20K hardware profile. The hardware registers cannot
expose configuration dimensions that exceed these maximum architectural limits
because the underlying silicon layout lacks the physical lines or registers
to support larger structures.

Because the statically allocated arrays and bitmaps (like dstats and
en_map) are configured to support this full architectural envelope, the
runtime values assigned to num_banks and bank_depth are structurally
guaranteed to be less than or equal to these maximum limits. As a result,
the loops inside npc_mcam_dstats_show() and bit operations inside
npc_cn20k_enable_mcam_entry() will never cross the boundaries of the
allocated memory footprint, making runtime validation checks redundant.

