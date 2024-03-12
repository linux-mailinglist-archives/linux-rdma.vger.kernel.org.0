Return-Path: <linux-rdma+bounces-1399-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E69878F68
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 09:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7141F222D7
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4EC6997D;
	Tue, 12 Mar 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxOMTwL6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB53769976;
	Tue, 12 Mar 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230727; cv=none; b=pgVVR6/NGK3nyMHON13DOwRySU915eub1n+MsUZ4TzQcgN8F9y6qhNFN316t8Or8HI6/ALPIpfaQZykOUzYPN4k8yIzaLTl+4bKPpLi/wYaUtrdilbRUI2iiJSR/eXKoTWItRzXCOWHgj3kLOtsgeciwLkIfyXGGN3GSivyd5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230727; c=relaxed/simple;
	bh=hjEUoaSnv3s4TMFYXd/dWLIM48mAjAsndwyEjqfY9hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSx2PdHomE0rkSBaYjXdPQZAft2syg5289CkoweG/MPbrZGmgxgmeuG57fGknucZeHT+9t5VnQJk4bp0UYBFQCacIlWH95uRfTUASotl6zQSuFawp5MmyGm4ufWAbMugtH3iuWmBPMohs/BuBkdYo4hrvqLNEwh9j7/4vCf5ILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxOMTwL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85EEC433F1;
	Tue, 12 Mar 2024 08:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710230727;
	bh=hjEUoaSnv3s4TMFYXd/dWLIM48mAjAsndwyEjqfY9hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxOMTwL6CLqKvUmKKZhXs//giXwuz+tRxxYx7Mqvik9xwkptCnzWPx20iaaTnpnNB
	 5Q5b8fd/ALL7izauL33I5LeCoHis1RCkM63v0bN6bGJuV2gM1cLyZdEzhnr102YlHh
	 RkVcjcpc9KQW6QpWiq7yNDRtKtmmKGCT7ge0xvb7cUUkgBZbX5CtRAuGPNCvAG83Gv
	 HumVmlbLTZ1xr6kThWuQtm5NI6dkZBu1kuvUIy3WmtZckP4H6oPgYYpKxb4QZT//S3
	 u0ALKd5W8as/336mZm0UuaTFri0sALnLH9WzquwPSUkABb59oql0L1zmJ2qmLjEmAO
	 vzyIejzEnB19A==
Date: Tue, 12 Mar 2024 10:05:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/hns: Support congestion control algorithm
 parameter configuration
Message-ID: <20240312080522.GO12921@unreal>
References: <20240308105443.1130283-1-huangjunxian6@hisilicon.com>
 <20240310100027.GC12921@unreal>
 <c16e3cc2-1a70-a9ec-e533-e508cfbab18e@hisilicon.com>
 <20240311071119.GH12921@unreal>
 <f8354762-703c-16e2-fa8e-bc8519fdcd06@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8354762-703c-16e2-fa8e-bc8519fdcd06@hisilicon.com>

On Mon, Mar 11, 2024 at 10:00:27PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/3/11 15:11, Leon Romanovsky wrote:
> > On Mon, Mar 11, 2024 at 10:00:51AM +0800, Junxian Huang wrote:
> >>
> >>
> >> On 2024/3/10 18:00, Leon Romanovsky wrote:
> >>> On Fri, Mar 08, 2024 at 06:54:43PM +0800, Junxian Huang wrote:
> >>>> From: Chengchang Tang <tangchengchang@huawei.com>
> >>>>
> >>>> hns RoCE supports 4 congestion control algorithms. Each algorihm
> >>>> involves multiple parameters. Add port sysfs directory for each
> >>>> algorithm to allow modifying their parameters.
> >>>
> >>> Unless Jason changed his position after this rewrite [1], we don't allow
> >>> any custom driver sysfs code.
> >>>
> >>> [1] https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> >>>
> >>
> >> I didn't quite get the reason from [1], could you please explain it?
> > 
> > Before [1], we didn't allow custom sysfs. After [1], the sysfs code
> > started to be more sane and usable for the drivers. However, it is
> > unlikely that the policy is changed to allow driver sysfs code.
> > 
> >>
> >> And it would be helpful if you could give us a hint about any other
> >> proper ways to do the algorithm parameter configuration.
> > 
> > Like any other FW internals.
> > 
> 
> If we add the capability of custom driver parameter configuration to
> rdmatool (similar to [2]), would it be acceptable?

Moshe's patch is for devlink. We are working on a generic solution for
other vendors to control/debug their devices.
https://lwn.net/Articles/955001/
https://lore.kernel.org/all/20240304160237.GA2909161@nvidia.com/

Feel free to join the discussion and reply that you are interested in
this proposal as well and emphasize that your device is not netdev at
all.

Thanks

> 
> [2] https://patchwork.ozlabs.org/project/netdev/patch/1530703837-24563-4-git-send-email-moshe@mellanox.com/
> 
> Junxian
> 
> > Thanks
> > 
> >>
> >> Thanks,
> >> Junxian
> >>
> >>>>
> >>>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> >>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> >>>> ---
> >>>>  drivers/infiniband/hw/hns/Makefile          |   2 +-
> >>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  20 ++
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  59 ++++
> >>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 132 ++++++++
> >>>>  drivers/infiniband/hw/hns/hns_roce_main.c   |   3 +
> >>>>  drivers/infiniband/hw/hns/hns_roce_sysfs.c  | 346 ++++++++++++++++++++
> >>>>  6 files changed, 561 insertions(+), 1 deletion(-)
> >>>>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_sysfs.c
> >>>
> >>> Thanks
> >>

