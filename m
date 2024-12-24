Return-Path: <linux-rdma+bounces-6725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE39FBC5E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 11:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7F517A1ADD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333D1B4132;
	Tue, 24 Dec 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYTZhEW0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF219992C;
	Tue, 24 Dec 2024 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036348; cv=none; b=FN1pwbQ5oiEggtTXGwgCwMuERviu+3pz2DKLFpDf2HC6CfedXHkZH3aQ+tGjYdFtZ0G9AUNq2BM2lD7Rdi+gU0KHvfuMHSYaKWkDhqtpvN+RRT0qTwrFzsINk14uZqL9SkLJRsEHQ5WdLXLk1qqgVkuwwYs7vCuaCHwqq8mlQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036348; c=relaxed/simple;
	bh=rjd++XfsGDmrXD2GtJRVRftnr6JD4CiogwRhfPoy1hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzwnwmrGeY3kxUo5ZkD/oT5voJXVl26Spx9qk/E9HfZR9eK/Q3EqiPDyJgeoL0kuAm9ZeuQfx86FeF8PTMjT7P8zgV32G5mbG+s0jBMYhsxgt/Hf33DBU7G6LzKRYHulbiAX5bw6IYfaYbciMIVzbvM8WjDNzbYg5vV+bXSmZEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYTZhEW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925F2C4CED0;
	Tue, 24 Dec 2024 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735036348;
	bh=rjd++XfsGDmrXD2GtJRVRftnr6JD4CiogwRhfPoy1hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYTZhEW0T5eOCrzvwN/IvoWtrIKQWTJ8tAwAKaRSg5wdMYRyFRo8c2Ztg0aShuZjS
	 6vHby5fQHweBaR6W+VM3POf47oue/xsU+NP55QpmvLPlEG7wkkxj0afDaHeJAX9mdv
	 vNVwbmk9AQd3Ij75ZQzsHz2zUhDsm5BC7Wy/N7zQ2iUOO26soSmCv8YvZuR04FvaQ5
	 vd8nWjVt/ulnzx/Cf7HeC3NXe+htbrolZKOjBjCji9CE/qeVpEZpXEWVkHOWuDYF6s
	 WbEzTyrNRJENRgk/8cN+8q8pQwhwdrOKcrNCQrBiKsTN9e6447Ame+U8ccth1HhIi1
	 ZJwh2AhcwIp+w==
Date: Tue, 24 Dec 2024 12:32:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, selvin.xavier@broadcom.com, chengyou@linux.alibaba.com,
	kaishen@linux.alibaba.com, mustafa.ismail@intel.com,
	tatyana.e.nikolova@intel.com, yishaih@nvidia.com, benve@cisco.com,
	neescoba@cisco.com, bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com, zyjzyj2000@gmail.com, bmt@zurich.ibm.com,
	linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com,
	liyuyu6@huawei.com, linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC 00/12] RDMA: Support link status events dispatching
 in ib_core
Message-ID: <20241224103224.GF171473@unreal>
References: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>

On Fri, Nov 22, 2024 at 06:52:56PM +0800, Junxian Huang wrote:
> This series is to integrate a common link status event handler in
> ib_core as this functionality is needed by most drivers and
> implemented in very similar patterns. This is not a new issue but
> a restart of the previous work of our colleagues from several years
> ago, please see [1] and [2].
> 
> [1]: https://lore.kernel.org/linux-rdma/1570184954-21384-1-git-send-email-liweihang@hisilicon.com/
> [2]: https://lore.kernel.org/linux-rdma/20200204082408.18728-1-liweihang@huawei.com/
> 
> With this series, ib_core can handle netdev events of link status,
> i.e. NETDEV_UP, NETDEV_DOWN and NETDEV_CHANGE, and dispatch ib port
> events to ULPs instead of drivers. However some drivers currently
> have some private processing in their handler, rather than simply
> dispatching events. For these drivers, this series provides a new
> ops report_port_event(). If this ops is set, ib_core will call it
> and the events will still be handled in the driver.
> 
> Events of LAG devices are also not handled in ib_core as currently
> there is no way to obtain ibdev from upper netdev in ib_core. This
> can be a TODO work after the core have more support for LAG. For
> now mlx5 is the only driver that supports RoCE LAG, and the events
> handling of mlx5 RoCE LAG will remain in mlx5 driver.
> 
> In this series:
> 
> Patch #1 adds a new helper to query the port num of a netdev
> associated with an ibdev. This is used in the following patch.
> 
> Patch #2 adds support for link status events dispatching in ib_core.
> 
> Patch #3-#7 removes link status event handler in several drivers.
> The port state setting in erdma, rxe and siw are replaced with
> ib_get_curr_port_state(), so their handler can be totally removed.
> 
> Patch #8-#10 add support for report_port_event() ops in usnic, mlx4
> and pvrdma as their current handler cannot be perfectly replaced by
> the ib_core handler in patch #2.
> 
> Patch #11 adds a check in mlx5 that only events of RoCE LAG will be
> handled in mlx5 driver.
> 
> Patch #12 adds a fast path for link-down events dispatching in hns by
> getting notified from hns3 nic driver directly.
> 
> Yuyu Li (12):
>   RDMA/core: Add ib_query_netdev_port() to query netdev port by IB
>     device.
>   RDMA/core: Support link status events dispatching
>   RDMA/bnxt_re: Remove deliver net device event
>   RDMA/erdma: Remove deliver net device event
>   RDMA/irdma: Remove deliver net device event
>   RDMA/rxe: Remove deliver net device event
>   RDMA/siw: Remove deliver net device event
>   RDMA/usnic: Support report_port_event() ops
>   RDMA/mlx4: Support report_port_event() ops
>   RDMA/pvrdma: Support report_port_event() ops
>   RDMA/mlx5: Handle link status event only for LAG device
>   RDMA/hns: Support fast path for link-down events dispatching

I took the series as it is good thing to remove code duplication
and we waited enough.

However, I'm disappointed to see "RDMA/hns: Support fast path for
link-down events dispatching" patch and would like you to use
netdev notifiers instead. I doubt that this "fast-path" is needed.

Thanks

