Return-Path: <linux-rdma+bounces-18768-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGqVBIMMyWkHtwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18768-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 13:26:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F7351CD7
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27156300A7FD
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2026 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAAE2DF138;
	Sun, 29 Mar 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eSNfeqQr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563E35DA74
	for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774783615; cv=none; b=koUOC+3WzCxie5PLsimRglUka0vaDs4BUh7b0FJ1yEJo7yOo9Eg6msznMXe+KdlsOQyPM9Ud3TkLhbdEqixdai7JNdop+rmPgNChgUze6gQNnxAkEAE2HTtH8KH730Y+v10XNNCvUXlwieAjNuFEN182mzUt/FquQqAvRMkjvRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774783615; c=relaxed/simple;
	bh=DXnAUYi4g7Z+BUnbVjXMikvsDuRwR4zJ0n+HkZshHaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQwlq5DiwIW64h/guD0+8Ai2mid6RQVFlcwKc2fmwM4jQ85MJ710zaWaK6KCkJ/FUUYlbQd4EaZOPCQCrz9TEj4ZPkxOoKFLs7lQwBeTYnW5Zvm/vIkPcK4CyGJW+hx+4EjE00uW+UvXt1tCE565163VVjDR5TYmy1SLw4742WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eSNfeqQr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso33967085e9.2
        for <linux-rdma@vger.kernel.org>; Sun, 29 Mar 2026 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774783612; x=1775388412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZlEgYriYHMDxgc9rFf1NxZlfu43BP7hOkbM37dOKRyc=;
        b=eSNfeqQrgg91OdoVFkgGrATJcngL2rzhZHYfX8gADDGjXzY2aQT+Ew4VLhs1xYjOxo
         H8Wa9GLay4XohlpdRAVb11fCLByBQ5/1QW8cQIA0tZdCtap8pv8+KGXinhrXmPt9cNC7
         3a5SgxCJa/aOXbcs/+rj9+pinIwRYTWGmrmJ0/7tAfJroULFCEYya0brbF2euMhJ4qLL
         Ef8F4Scwkpe4/G3eblaRNFi2ZFVttdYVTpbw70ucYqPFGn+q8fY9s2sLL93oPoinkfzd
         ddIFGiYePTpk9txqFNLGGstMeYCXe+KAu4CUSufmIJzW/PIO5IkN2S78EJkFD8+OD62Z
         /9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774783612; x=1775388412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlEgYriYHMDxgc9rFf1NxZlfu43BP7hOkbM37dOKRyc=;
        b=IwicCP28fwHo1snhFzQdvUwTiSHEyxtyfIM11/hYV5sDpGHimvvqEaVDps2rFwi3gP
         bM9kF3+1BCVQWB2Rwol6vSzYnKqTmICupiSSlh0OnDn+sKbc6Y8N1TtWdEFt+lXYa5TJ
         s++TDt62V447eVaoZn/BgY10ko4EBrE4hQGhBgxlhRM2NqZ0+3Lh5aTM142rrq5oz755
         HkZz0NgYkM2N6zgQ3t96LqKF+khLU/2lG388yc3s5XG8fDDTjRAV7RGWV+Y2aAU8QTRN
         hdKsRTd7WAiLtImREaaUN/5ry3t79HSqVUKEP3V9qCh6CuyXwXEa158MM4WcjTbtnhLm
         1+rw==
X-Gm-Message-State: AOJu0YxNDWR6y3yFe1zxWuSXrA8SMMq/IVc/iHaaISUxJrzwtXUJKXOQ
	0W33CNdc2vp0DmHNEFIplndhiCn/goBpFiOUZzMG2wI7lrxgjd6oJgvLVZ41FVHiql0=
X-Gm-Gg: ATEYQzxITw74ojEfm8rVZxlPkEkzLsZVVFTloDinMkHWdXXG4uq6RMfUb9ATKfDnyb+
	0Xio7dmS5jpCCNgd9XUILtMo5DMFhS1LEQxoYereV19DRfMq4kJNeNWjJPz59hbmHE1AMtV8dKk
	AkhLzKVEjJzYDSTdk5BoYSCc8M47yKzBn4A8BLHGRNy26B4ilYrrQoteFhbuO5zLxE+1wT+76EK
	s4KAcTNA1nr0o4p+jJ0pesjwvxS2kMZ+DyxU9l2xmyS3SPriMMCmG+/AN9TgO93zm41d3QsA3z7
	Z4VhmH5sVW6YG5N05nchMi9pU//mhDp+NGF7pQb6b4uQzvhq+F5ZafFSXGYbG3I9LsSsvJemmqf
	z0yrVNj/EdtlsSTxS8SYijDhcN2iZYKbRUP3VD9QfKTXA4fKefTrz1QzR2xN+6sAsla+fTlH0qy
	0WSinFTq1/JlIu2g9jXV2wVF0e6yYgWTJkiBuY9hHzRC8=
X-Received: by 2002:a05:600c:a016:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-48727ef153cmr137772855e9.26.1774783611167;
        Sun, 29 Mar 2026 04:26:51 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4c27:3a72:8516:e661])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48730688694sm95116045e9.11.2026.03.29.04.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 04:26:50 -0700 (PDT)
Date: Sun, 29 Mar 2026 13:26:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 00/15] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <ygq3hh7svjb24uoaduzxbu5utyhddidkzl34ltyv77v4v566un@7xq5mcmocvbg>
References: <20260325150048.168341-1-jiri@resnulli.us>
 <4280105c-13aa-4a02-8fd5-ea68b8936b67@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4280105c-13aa-4a02-8fd5-ea68b8936b67@linux.dev>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18768-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,resnulli-us.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 7B4F7351CD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sat, Mar 28, 2026 at 12:03:47AM +0100, yanjun.zhu@linux.dev wrote:
>
>On 3/25/26 8:00 AM, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This patchset introduces a generic buffer descriptor infrastructure
>> for passing memory buffers (dma-buf or user VA) to uverbs commands,
>> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
>> bnxt_re and mlx4 drivers.
>
>While the current patch set successfully introduces a generic buffer
>descriptor
>
>infrastructure for CQ and QP creation, it raises the question of why
>
>Memory Region (MR) allocation and registration have not been integrated into
>
>this new ib_umem_list architecture.
>
>Given that MRs often require complex memory backing—such as discrete dma-buf
>segments
>
>from GPUs or fragmented user-space virtual addresses—extending the
>UVERBS_ATTR_BUFFERS
>
>array model to MRs would seem like a natural evolution. This would provide a
>unified
>
>UAPI for handling heterogeneous memory sources and eliminate the need for
>per-command
>
>attributes when registering composite memory regions. Are there specific
>architectural
>
>constraints or synchronization concerns that necessitated keeping MR
>registration on its legacy
>
>path for now?
>
>In short, I am wondering **whether this architecture can include MR (memory
>region) or not**.

I don't see why not. Seems like a straightforeward extension. Let's do
that in a follow-up patchset, could we?


>
>As such, CQ/QP/MR can use the same architecture.
>
>Zhu Yanjun
>
>> Instead of adding per-command UAPI attributes for each new buffer
>> type, a single UVERBS_ATTR_BUFFERS array attribute carries all buffer
>> descriptors. Each descriptor specifies a buffer type and is indexed by
>> per-command slot enums. A consumption check ensures userspace and
>> driver agree on which buffers are used.
>> The patchset:
>> 1. Introduces the core ib_umem_list infrastructure and UAPI.
>> 2. Factors out CQ buffer umem processing into a helper.
>> 3. Integrates umem_list into CQ creation, with fallback to existing
>>     per-attribute path.
>> 4-7. Converts efa, mlx5, bnxt_re and mlx4 to use umem_list for CQ
>>     buffer.
>> 8. Removes the legacy umem field from struct ib_cq, now that all
>>     drivers use umem_list for CQ buffer management.
>> 9. Adds a consumption check verifying all umem_list buffers were
>>     consumed by the driver after CQ creation.
>> 10. Integrates umem_list into QP creation.
>> 11. Converts mlx5 QP creation to use umem_list.
>> 12-15. Extends CQ and QP with doorbell record buffer slots and
>>     converts mlx5 to use them.
>> 
>> Note this re-works the original patchset trying to handle this:
>> https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
>> The code is so much different I'm sending this is a new patchset.
>> 
>> Jiri Pirko (15):
>>    RDMA/core: Introduce generic buffer descriptor infrastructure for umem
>>    RDMA/uverbs: Push out CQ buffer umem processing into a helper
>>    RDMA/uverbs: Integrate umem_list into CQ creation
>>    RDMA/efa: Use umem_list for user CQ buffer
>>    RDMA/mlx5: Use umem_list for user CQ buffer
>>    RDMA/bnxt_re: Use umem_list for user CQ buffer
>>    RDMA/mlx4: Use umem_list for user CQ buffer
>>    RDMA/uverbs: Remove legacy umem field from struct ib_cq
>>    RDMA/uverbs: Verify all umem_list buffers are consumed after CQ
>>      creation
>>    RDMA/uverbs: Integrate umem_list into QP creation
>>    RDMA/mlx5: Use umem_list for QP buffers in create_qp
>>    RDMA/uverbs: Add doorbell record buffer slot to CQ umem_list
>>    RDMA/mlx5: Use umem_list for CQ doorbell record
>>    RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
>>    RDMA/mlx5: Use umem_list for QP doorbell record
>> 
>>   drivers/infiniband/core/core_priv.h           |   1 +
>>   drivers/infiniband/core/umem.c                | 248 ++++++++++++++++++
>>   drivers/infiniband/core/uverbs_cmd.c          |  18 +-
>>   drivers/infiniband/core/uverbs_std_types_cq.c | 158 ++++++-----
>>   drivers/infiniband/core/uverbs_std_types_qp.c |  26 +-
>>   drivers/infiniband/core/verbs.c               |  26 +-
>>   drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  23 +-
>>   drivers/infiniband/hw/efa/efa_verbs.c         |  17 +-
>>   drivers/infiniband/hw/mlx4/cq.c               |  21 +-
>>   drivers/infiniband/hw/mlx5/cq.c               |  40 ++-
>>   drivers/infiniband/hw/mlx5/doorbell.c         |  41 ++-
>>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
>>   drivers/infiniband/hw/mlx5/qp.c               |  76 ++++--
>>   drivers/infiniband/hw/mlx5/srq.c              |   2 +-
>>   include/rdma/ib_umem.h                        |  54 ++++
>>   include/rdma/ib_verbs.h                       |   5 +-
>>   include/rdma/uverbs_ioctl.h                   |  14 +
>>   include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
>>   include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
>>   19 files changed, 651 insertions(+), 166 deletions(-)
>> 

