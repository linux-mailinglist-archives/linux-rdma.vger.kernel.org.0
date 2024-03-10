Return-Path: <linux-rdma+bounces-1358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FE877606
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 11:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DECC1F224AB
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ECC1EA7D;
	Sun, 10 Mar 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngcoceyg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C521DDD6;
	Sun, 10 Mar 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710064832; cv=none; b=sL9dUym1sZa5dERJSrZ2nW2kXZrbTc7WaULhLceWWnHr05KBn55UHYl/jaUyzGqhyEk0EFDLkExwrRIMOS2kNbv0WqLb6chHzCF7soAaisj+D7y5bjtowQ5M11RfF4A7KSKpMToIU+DZZoq7UKEqM5nnuDcpJmxfKP+VI8AaPhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710064832; c=relaxed/simple;
	bh=PbfF8xS4zOPWpBWQGpm7wUS2lrqSxKxSFbPCwoNQc0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6zyqeUxdCDYpmjpD2Zop3fflYNb9DB6l+Opz4S2ZfP9HYTwD0FZfj13ZyO9hLpZf5bIoSzWQfok5aQzSSyuB1Z3x3YKl+fNb0kVi1oOppmPZwbjP4jy0Lr9QrAxpz8OfmxvXv+a51Z6qeFkmWGzDj1/0GK7JiwxS5tm8A3pQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngcoceyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39044C433C7;
	Sun, 10 Mar 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710064831;
	bh=PbfF8xS4zOPWpBWQGpm7wUS2lrqSxKxSFbPCwoNQc0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgcoceygpKJizGvoNZOdd2oOtOQw3MB0P5LzSX5lHMGnuG2QMCMzMOpiLZAInIawb
	 IYjdinW3Jjvp9BBin1OjTMZhA7uzwbCQZmCEUlCkuxWFSKBFMyXBN0SRK7NZV3bvYf
	 /f048sZSA+kvzn0ngRW+KQS5FLC7C961j39KJaJcRUgFe7zFwycIzy8NYT+gSk/nAa
	 nsVMXqNiXcybT8aGfzHTpLXj9UIWss4UVQ8mrXDZ08yAdGUv51HrQ4XzSde4zV6Bc+
	 77UrK7PaeF3Ud3eqIhDmwsH3Yt+OhPvwnaCH7bpvYBb5+Rrp7NOKIjFxfO4ETeBXGT
	 J53DeAugBfN0A==
Date: Sun, 10 Mar 2024 12:00:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support congestion control algorithm
 parameter configuration
Message-ID: <20240310100027.GC12921@unreal>
References: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>

On Fri, Mar 08, 2024 at 06:54:43PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> hns RoCE supports 4 congestion control algorithms. Each algorihm
> involves multiple parameters. Add port sysfs directory for each
> algorithm to allow modifying their parameters.

Unless Jason changed his position after this rewrite [1], we don't allow
any custom driver sysfs code.

[1] https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/

> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  20 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  59 ++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 132 ++++++++
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   3 +
>  drivers/infiniband/hw/hns/hns_roce_sysfs.c  | 346 ++++++++++++++++++++
>  6 files changed, 561 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_sysfs.c

Thanks

