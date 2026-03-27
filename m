Return-Path: <linux-rdma+bounces-18741-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ/KNwANx2nBSAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18741-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 00:04:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B5234C332
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 00:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2FA7302410D
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8C37F8A5;
	Fri, 27 Mar 2026 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vH/A4cUT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C3A29AB15
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774652642; cv=none; b=fiFiriWy8DlmKhu1P2acL+nL/pT6AlzOHVQ14j9MEoFIllHlzcz0IeUI1k1SMutphVW/Pnfn5o5ikGbfW55QWQWG9TSwzr2HJjb1qG9PyvE3Wm200XGrHa9shGYom657BxEoWw8MdUppLufxv3TTNBVX2e2m0ZdjTzq8sAgqh10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774652642; c=relaxed/simple;
	bh=d2Fa9db7navB7EVodrJyIFUSk2VOPg1LQTROuzvOFLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cs6ve+6bhWYtGY069bLRb4rNevkoepamAkjv7c8Q44BASCOUhiUbjpmDa4UtoPfwZsGemR1/4auKAiwd20hHOtJNa+HgVFJRNGx4RaeCrV3jkZ2cRZXHhMqPTnhcSF+oUrmhblP64Y/x88w2v947M9C+VT9pZ6mVJq4fOEAEGUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vH/A4cUT; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4280105c-13aa-4a02-8fd5-ea68b8936b67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774652637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LFlv7GUxveGq2IohaQ6lr+SWKP6l9WKNAF6d2qAnRg=;
	b=vH/A4cUTizd16Rri1ufSOZsgRlbJTnsqrVsMrqJsOlkI2Ne+3HBlbbGSl35cQnhKFQ7XCB
	Wqh4f0/kvQ99RCkTmY6x0AUr/zC4A2iQB22SwCfnw4CEcC32iCO/NLlzv6hR6Dfrvrn9aw
	A9/ifqG4LCammkzpLbEJkJy3NDSTVm4=
Date: Fri, 27 Mar 2026 16:03:47 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 00/15] RDMA: Introduce generic buffer descriptor
 infrastructure for umem
To: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, mrgolin@amazon.com,
 gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
 mbloch@nvidia.com, wangliang74@huawei.com, marco.crivellari@suse.com,
 roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
 ynachum@amazon.com, huangjunxian6@hisilicon.com,
 kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
 michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
 sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
 selvin.xavier@broadcom.com
References: <20260325150048.168341-1-jiri@resnulli.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18741-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 25B5234C332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/25/26 8:00 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> This patchset introduces a generic buffer descriptor infrastructure
> for passing memory buffers (dma-buf or user VA) to uverbs commands,
> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
> bnxt_re and mlx4 drivers.

While the current patch set successfully introduces a generic buffer 
descriptor

infrastructure for CQ and QP creation, it raises the question of why

Memory Region (MR) allocation and registration have not been integrated 
into

this new ib_umem_list architecture.

Given that MRs often require complex memory backing—such as discrete 
dma-buf segments

from GPUs or fragmented user-space virtual addresses—extending the 
UVERBS_ATTR_BUFFERS

array model to MRs would seem like a natural evolution. This would 
provide a unified

UAPI for handling heterogeneous memory sources and eliminate the need 
for per-command

attributes when registering composite memory regions. Are there specific 
architectural

constraints or synchronization concerns that necessitated keeping MR 
registration on its legacy

path for now?

In short, I am wondering **whether this architecture can include MR 
(memory region) or not**.

As such, CQ/QP/MR can use the same architecture.

Zhu Yanjun

> Instead of adding per-command UAPI attributes for each new buffer
> type, a single UVERBS_ATTR_BUFFERS array attribute carries all buffer
> descriptors. Each descriptor specifies a buffer type and is indexed by
> per-command slot enums. A consumption check ensures userspace and
> driver agree on which buffers are used.
> The patchset:
> 1. Introduces the core ib_umem_list infrastructure and UAPI.
> 2. Factors out CQ buffer umem processing into a helper.
> 3. Integrates umem_list into CQ creation, with fallback to existing
>     per-attribute path.
> 4-7. Converts efa, mlx5, bnxt_re and mlx4 to use umem_list for CQ
>     buffer.
> 8. Removes the legacy umem field from struct ib_cq, now that all
>     drivers use umem_list for CQ buffer management.
> 9. Adds a consumption check verifying all umem_list buffers were
>     consumed by the driver after CQ creation.
> 10. Integrates umem_list into QP creation.
> 11. Converts mlx5 QP creation to use umem_list.
> 12-15. Extends CQ and QP with doorbell record buffer slots and
>     converts mlx5 to use them.
>
> Note this re-works the original patchset trying to handle this:
> https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
> The code is so much different I'm sending this is a new patchset.
>
> Jiri Pirko (15):
>    RDMA/core: Introduce generic buffer descriptor infrastructure for umem
>    RDMA/uverbs: Push out CQ buffer umem processing into a helper
>    RDMA/uverbs: Integrate umem_list into CQ creation
>    RDMA/efa: Use umem_list for user CQ buffer
>    RDMA/mlx5: Use umem_list for user CQ buffer
>    RDMA/bnxt_re: Use umem_list for user CQ buffer
>    RDMA/mlx4: Use umem_list for user CQ buffer
>    RDMA/uverbs: Remove legacy umem field from struct ib_cq
>    RDMA/uverbs: Verify all umem_list buffers are consumed after CQ
>      creation
>    RDMA/uverbs: Integrate umem_list into QP creation
>    RDMA/mlx5: Use umem_list for QP buffers in create_qp
>    RDMA/uverbs: Add doorbell record buffer slot to CQ umem_list
>    RDMA/mlx5: Use umem_list for CQ doorbell record
>    RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
>    RDMA/mlx5: Use umem_list for QP doorbell record
>
>   drivers/infiniband/core/core_priv.h           |   1 +
>   drivers/infiniband/core/umem.c                | 248 ++++++++++++++++++
>   drivers/infiniband/core/uverbs_cmd.c          |  18 +-
>   drivers/infiniband/core/uverbs_std_types_cq.c | 158 ++++++-----
>   drivers/infiniband/core/uverbs_std_types_qp.c |  26 +-
>   drivers/infiniband/core/verbs.c               |  26 +-
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  23 +-
>   drivers/infiniband/hw/efa/efa_verbs.c         |  17 +-
>   drivers/infiniband/hw/mlx4/cq.c               |  21 +-
>   drivers/infiniband/hw/mlx5/cq.c               |  40 ++-
>   drivers/infiniband/hw/mlx5/doorbell.c         |  41 ++-
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
>   drivers/infiniband/hw/mlx5/qp.c               |  76 ++++--
>   drivers/infiniband/hw/mlx5/srq.c              |   2 +-
>   include/rdma/ib_umem.h                        |  54 ++++
>   include/rdma/ib_verbs.h                       |   5 +-
>   include/rdma/uverbs_ioctl.h                   |  14 +
>   include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
>   include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
>   19 files changed, 651 insertions(+), 166 deletions(-)
>

