Return-Path: <linux-rdma+bounces-18771-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O6yNYl5yWlIyQUAu9opvQ
	(envelope-from <linux-rdma+bounces-18771-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 21:12:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A6353B93
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 21:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C544B3005D38
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437E37C0F0;
	Sun, 29 Mar 2026 19:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sy2MwpJs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5317E36EA8D
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774811354; cv=none; b=php2MbH+NNW39DftOuV+z6JPktYeAZJyPu84EQ0xB512ZUWnyCg7YwM4EM081MrfpB/HBDRmlrqQsuVjkocjYcuNs0iEzK/MUAFsxuQHJea+z2LMD3EatqmMY2xgXqH6jTq+yqobTAOUsyG5Tg/CLsvTWfhlFD7jib7GXGPwE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774811354; c=relaxed/simple;
	bh=f76WB89XYlf3RGGe262AZS8Aetm/FLZIe+1YZEOga84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+1pvI3K5x8qAIp/9YfSADd4eRbxfLXd39mI53A123RaffiwDyS/WHx8QoAUheOoKBB90EvR3xItHGn2jMsej3Ao1LDSifkHtWhhfctw5p5zbBBxZVyNbIMhbJLJ5GquI+XrkPXk6HjBDJ0kNl662z2WWX0pqy3CnX4OCTr+DYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sy2MwpJs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <84f43a4c-06f6-4763-ac44-389c3295d9c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774811348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yAj1RWIEUUgbVZyUURnz1Xb+qVgdzJsGws0exl6V0HI=;
	b=sy2MwpJsjWWKLRf4xEQsdl8DC7eLcGmq1suvP4KwRn5xCMCn3iRICkKTWkjczTF6BliVl0
	QQSvf5p4QrMtdzQJeWposKblhuyXelmp7Ha+OfLIN50oG+PZnw7t0+cW7Vw3iS1b/va+OO
	QKXSh20kNyOSp4RP9W4X0PBSEDaXnNY=
Date: Sun, 29 Mar 2026 12:08:59 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 00/15] RDMA: Introduce generic buffer descriptor
 infrastructure for umem
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
 mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
 parav@nvidia.com, mbloch@nvidia.com, wangliang74@huawei.com,
 marco.crivellari@suse.com, roman.gushchin@linux.dev, phaddad@nvidia.com,
 lirongqing@baidu.com, ynachum@amazon.com, huangjunxian6@hisilicon.com,
 kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
 michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
 sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
 selvin.xavier@broadcom.com
References: <20260325150048.168341-1-jiri@resnulli.us>
 <4280105c-13aa-4a02-8fd5-ea68b8936b67@linux.dev>
 <ygq3hh7svjb24uoaduzxbu5utyhddidkzl34ltyv77v4v566un@7xq5mcmocvbg>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ygq3hh7svjb24uoaduzxbu5utyhddidkzl34ltyv77v4v566un@7xq5mcmocvbg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18771-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 134A6353B93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


在 2026/3/29 4:26, Jiri Pirko 写道:
> Sat, Mar 28, 2026 at 12:03:47AM +0100, yanjun.zhu@linux.dev wrote:
>> On 3/25/26 8:00 AM, Jiri Pirko wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>>
>>> This patchset introduces a generic buffer descriptor infrastructure
>>> for passing memory buffers (dma-buf or user VA) to uverbs commands,
>>> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
>>> bnxt_re and mlx4 drivers.
>> While the current patch set successfully introduces a generic buffer
>> descriptor
>>
>> infrastructure for CQ and QP creation, it raises the question of why
>>
>> Memory Region (MR) allocation and registration have not been integrated into
>>
>> this new ib_umem_list architecture.
>>
>> Given that MRs often require complex memory backing—such as discrete dma-buf
>> segments
>>
> >from GPUs or fragmented user-space virtual addresses—extending the
>> UVERBS_ATTR_BUFFERS
>>
>> array model to MRs would seem like a natural evolution. This would provide a
>> unified
>>
>> UAPI for handling heterogeneous memory sources and eliminate the need for
>> per-command
>>
>> attributes when registering composite memory regions. Are there specific
>> architectural
>>
>> constraints or synchronization concerns that necessitated keeping MR
>> registration on its legacy
>>
>> path for now?
>>
>> In short, I am wondering **whether this architecture can include MR (memory
>> region) or not**.
> I don't see why not. Seems like a straightforeward extension. Let's do
> that in a follow-up patchset, could we?

Thanks a lot. Appreciate it.

Zhu Yanjun

>
>
>> As such, CQ/QP/MR can use the same architecture.
>>
>> Zhu Yanjun
>>
>>> Instead of adding per-command UAPI attributes for each new buffer
>>> type, a single UVERBS_ATTR_BUFFERS array attribute carries all buffer
>>> descriptors. Each descriptor specifies a buffer type and is indexed by
>>> per-command slot enums. A consumption check ensures userspace and
>>> driver agree on which buffers are used.
>>> The patchset:
>>> 1. Introduces the core ib_umem_list infrastructure and UAPI.
>>> 2. Factors out CQ buffer umem processing into a helper.
>>> 3. Integrates umem_list into CQ creation, with fallback to existing
>>>      per-attribute path.
>>> 4-7. Converts efa, mlx5, bnxt_re and mlx4 to use umem_list for CQ
>>>      buffer.
>>> 8. Removes the legacy umem field from struct ib_cq, now that all
>>>      drivers use umem_list for CQ buffer management.
>>> 9. Adds a consumption check verifying all umem_list buffers were
>>>      consumed by the driver after CQ creation.
>>> 10. Integrates umem_list into QP creation.
>>> 11. Converts mlx5 QP creation to use umem_list.
>>> 12-15. Extends CQ and QP with doorbell record buffer slots and
>>>      converts mlx5 to use them.
>>>
>>> Note this re-works the original patchset trying to handle this:
>>> https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
>>> The code is so much different I'm sending this is a new patchset.
>>>
>>> Jiri Pirko (15):
>>>     RDMA/core: Introduce generic buffer descriptor infrastructure for umem
>>>     RDMA/uverbs: Push out CQ buffer umem processing into a helper
>>>     RDMA/uverbs: Integrate umem_list into CQ creation
>>>     RDMA/efa: Use umem_list for user CQ buffer
>>>     RDMA/mlx5: Use umem_list for user CQ buffer
>>>     RDMA/bnxt_re: Use umem_list for user CQ buffer
>>>     RDMA/mlx4: Use umem_list for user CQ buffer
>>>     RDMA/uverbs: Remove legacy umem field from struct ib_cq
>>>     RDMA/uverbs: Verify all umem_list buffers are consumed after CQ
>>>       creation
>>>     RDMA/uverbs: Integrate umem_list into QP creation
>>>     RDMA/mlx5: Use umem_list for QP buffers in create_qp
>>>     RDMA/uverbs: Add doorbell record buffer slot to CQ umem_list
>>>     RDMA/mlx5: Use umem_list for CQ doorbell record
>>>     RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
>>>     RDMA/mlx5: Use umem_list for QP doorbell record
>>>
>>>    drivers/infiniband/core/core_priv.h           |   1 +
>>>    drivers/infiniband/core/umem.c                | 248 ++++++++++++++++++
>>>    drivers/infiniband/core/uverbs_cmd.c          |  18 +-
>>>    drivers/infiniband/core/uverbs_std_types_cq.c | 158 ++++++-----
>>>    drivers/infiniband/core/uverbs_std_types_qp.c |  26 +-
>>>    drivers/infiniband/core/verbs.c               |  26 +-
>>>    drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  23 +-
>>>    drivers/infiniband/hw/efa/efa_verbs.c         |  17 +-
>>>    drivers/infiniband/hw/mlx4/cq.c               |  21 +-
>>>    drivers/infiniband/hw/mlx5/cq.c               |  40 ++-
>>>    drivers/infiniband/hw/mlx5/doorbell.c         |  41 ++-
>>>    drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
>>>    drivers/infiniband/hw/mlx5/qp.c               |  76 ++++--
>>>    drivers/infiniband/hw/mlx5/srq.c              |   2 +-
>>>    include/rdma/ib_umem.h                        |  54 ++++
>>>    include/rdma/ib_verbs.h                       |   5 +-
>>>    include/rdma/uverbs_ioctl.h                   |  14 +
>>>    include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
>>>    include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
>>>    19 files changed, 651 insertions(+), 166 deletions(-)
>>>
-- 
Best Regards,
Yanjun.Zhu


