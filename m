Return-Path: <linux-rdma+bounces-1377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 402B8877B2A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 08:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CC11F21575
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F311A101E8;
	Mon, 11 Mar 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIHtkuQW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EACFBF2;
	Mon, 11 Mar 2024 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710141083; cv=none; b=B1kb/F9sxKSQ4KZlBOvARw5M/emSQ3OoS1Xl3eUFN9IIxvXei4N7hLOKzmlHw1H8Pg9LhPpB9EhlNP49Vl3AzbYP9LaoMlkAw31UKRIScq4OULvh2GMUbK9Xdm9w4M9fnZIMc4GHHL4XHcJTrg22nAE/lnoOeCHnOSldAx0q+zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710141083; c=relaxed/simple;
	bh=4k2sfDO9r77vfUAyF7jF5oNEM2gJ6Lzfg5JkoPLhg1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btikiaUUfBeJqw50RdV17obTvRbpvs+9wz5CetDkornvzfxRXwMDjE2SlzC6TrqArPWRE87sQfiDF6H376GFWj9PojVtpCpM5H2pA2wMTMOeDH7BDmSQbk1pTftvhSUutMr8spldejUb+haaEBwiLjmUAFYKEUOqYXPtbKfDWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIHtkuQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4308C433F1;
	Mon, 11 Mar 2024 07:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710141083;
	bh=4k2sfDO9r77vfUAyF7jF5oNEM2gJ6Lzfg5JkoPLhg1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIHtkuQWTH3TXkmrrLiRThcLOhfXFg9RHzNou/nReR/oZG4UCJnnDHa51DlbQOk/N
	 za1Rzfb6cvksAZPNZKF/NP1QJ2Wv6MP+CM5+eBo23XTI90YACQb03AXJmoYXL6QTjy
	 oxW3hkks/pnok0H1CBQM8KJjKqeevL53zW/q0Q/bMmA4bkleTyDE44Wky+p/hM/OZc
	 9TKaFNh2o9lC19AzOo6vi0zUdVkvs1wMgPsz+SemtSuSazpfkf7+TDGHzhKNOPCrMj
	 5PNy3Iyup09hR3yQll+6MT8KN5X7dJY+UylZWmga3xoU4Lc5+H7tQLu5s82WYGu21x
	 +9P9rEA1D9gkQ==
Date: Mon, 11 Mar 2024 09:11:19 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support congestion control algorithm
 parameter configuration
Message-ID: <20240311071119.GH12921@unreal>
References: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
 <20240310100027.GC12921@unreal>
 <c16e3cc2-1a70-a9ec-e533-e508cfbab18e@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c16e3cc2-1a70-a9ec-e533-e508cfbab18e@hisilicon.com>

On Mon, Mar 11, 2024 at 10:00:51AM +0800, Junxian Huang wrote:
> 
> 
> On 2024/3/10 18:00, Leon Romanovsky wrote:
> > On Fri, Mar 08, 2024 at 06:54:43PM +0800, Junxian Huang wrote:
> >> From: Chengchang Tang <tangchengchang@huawei.com>
> >>
> >> hns RoCE supports 4 congestion control algorithms. Each algorihm
> >> involves multiple parameters. Add port sysfs directory for each
> >> algorithm to allow modifying their parameters.
> > 
> > Unless Jason changed his position after this rewrite [1], we don't allow
> > any custom driver sysfs code.
> > 
> > [1] https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> > 
> 
> I didn't quite get the reason from [1], could you please explain it?

Before [1], we didn't allow custom sysfs. After [1], the sysfs code
started to be more sane and usable for the drivers. However, it is
unlikely that the policy is changed to allow driver sysfs code.

> 
> And it would be helpful if you could give us a hint about any other
> proper ways to do the algorithm parameter configuration.

Like any other FW internals.

Thanks

> 
> Thanks,
> Junxian
> 
> >>
> >> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >> ---
> >>  drivers/infiniband/hw/hns/Makefile          |   2 +-
> >>  drivers/infiniband/hw/hns/hns_roce_device.h |  20 ++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  59 ++++
> >>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 132 ++++++++
> >>  drivers/infiniband/hw/hns/hns_roce_main.c   |   3 +
> >>  drivers/infiniband/hw/hns/hns_roce_sysfs.c  | 346 ++++++++++++++++++++
> >>  6 files changed, 561 insertions(+), 1 deletion(-)
> >>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_sysfs.c
> > 
> > Thanks
> 

