Return-Path: <linux-rdma+bounces-667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259FD8354ED
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5876B1C21236
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A823317722;
	Sun, 21 Jan 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XgbDQMkj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B53415D0
	for <linux-rdma@vger.kernel.org>; Sun, 21 Jan 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705827112; cv=none; b=YgBca/Cj8WXTVylOSKG6aIVAJDxjl0D5lXJfwpyN2wsSUyVzhRhhc+ePNDX2xXU/blBnQvFnJHDpAMKEzObW71FqP7cpP3x3UMvvShKx8Kij51i6tiLpIeDHqozvFPvXouD7NGPRar4NRrSZom3d00jfIvG29lCVZMFbMx1sOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705827112; c=relaxed/simple;
	bh=pjtb6T7PqWyDsvfaJ8BTctuKXjOT/MRttZnRU4UU828=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QDAuRFREQCN/yR7XNPmwQesSL8oWLR9OXRwrz3PJ53bPARNferdYjI1QqRqnzMwfSIr8khWhCBcQkQwpW175qE7LmcuvsyqnkthlOgpgp/gnLiWtaVcWTJyE4LynnDgUesUqw/JMjY0oM+HTfnAZ531Yj6Uk2TCI2inTW4x/RTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XgbDQMkj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6edfa3cc-6ec1-49d0-817b-59239c1e669c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705827108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qstl+cJJqUSTFlohvj6VGa7Qo78UuXPfU7UT0vk8ydI=;
	b=XgbDQMkjrYgqrCDdrk+be8urG3KvcMvfrUOW2XP3d68D5IoM7sZrQHruo8JlIDwVmLscst
	wRIltHdp+Th+XN8KNtguAyRcrcGcXx49C2IKTsqlGhjW9nNLaI0RIPItHpNUiBetHLkcsR
	vN7EDlHMeYjL7qy2/XbrBO5oO4gp/hI=
Date: Sun, 21 Jan 2024 16:51:45 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Questions about RDMA subsystem shared mode for RoCE device with
 MLNX_OFED driver
To: =?UTF-8?B?6ZmI6YC45Yeh?= <neverhook430@gmail.com>,
 linux-rdma@vger.kernel.org
References: <CAAoLqsQ-iHo4YwsHyt6MkBKE20Ze=DF4kkFKkDX9QCDiDC2+oQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAAoLqsQ-iHo4YwsHyt6MkBKE20Ze=DF4kkFKkDX9QCDiDC2+oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/1/19 20:31, 陈逸凡 写道:
> Questions:
> 1. Is RDMA shared mode supported for RoCE/iWARP devices? To be more
> clearly, ibdev ant netdev required to be in the same net namespace or
> not?

RoCE/RXE + the following commits can support ibdev in the net namespace.

https://patchwork.kernel.org/project/linux-rdma/cover/20230508075636.352138-1-yanjun.zhu@intel.com/

Current implementation of RXE does not support net namespace. We need 
the above commits to support net namespace.

IMO, the current implementation of iWARP does not support net namespace, 
too.

Zhu Yanjun

> 2. If the answer for first question is ‘YES’, but my test failed with
> MLNX_OFED driver, it does check whether user can access the netdev of
> the target gid attr, which means they(user and the netdev) should be
> at the same namespace. Meanwhile the upstream code dose not have the
> corresponding codes.
> 
> 
> MLNX_OFED impl，form mlnx-ofa_kernel-23.10，compared to the upstream codes
> ---
> @@ -1722,6 +1739,9 @@ static int ib_resolve_eth_dmac(struct ib_device *device,
>   {
>          int ret = 0;
> 
> +       if (!rdma_check_gid_user_access(ah_attr->grh.sgid_attr))
> +               return -ENODEV;
> +
>          if (rdma_is_multicast_addr((struct in6_addr *)ah_attr->grh.dgid.raw)) {
>                  if (ipv6_addr_v4mapped((struct in6_addr
> *)ah_attr->grh.dgid.raw)) {
>                          __be32 addr = 0;
> ---
> 
> Its definition:
> ---
> /**
>   * rdma_check_gid_user_access - Check if user process can access
>   * this GID entry or not.
>   * @attr: Pointer to GID entry attribute
>   *
>   * rdma_check_gid_user_access() returns true if user process can access
>   * this GID attribute otherwise returns false. This API should be called
>   * from the userspace process context.
>   */
> bool rdma_check_gid_user_access(const struct ib_gid_attr *attr)
> {
> bool allow;
> /*
>   * For IB and iWarp, there is no netdevice associate with GID entry,
>   * For RoCE consider the netdevice's net ns to validate against the
>   * calling process.
>   */
> rcu_read_lock();
> if (!attr->ndev ||
>      (attr->ndev &&
>       net_eq(dev_net(attr->ndev), current->nsproxy->net_ns)))
> allow = true;
> else
> allow = false;
> rcu_read_unlock();
> return allow;
> }
> ---
> 
> I think rdma_check_gid_user_access should be ignored while RDMA
> subsystem configured as shared mode, It should works with exclusive
> mode. Am i missing anything? Please tell me the background about why
> MLNX_OFED driver perform the check if anyone knows.
> 
> Thanks!


