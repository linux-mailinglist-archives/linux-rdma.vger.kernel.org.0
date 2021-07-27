Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7403D74BE
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 14:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhG0MIG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 08:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236473AbhG0MIC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 08:08:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1649C61373;
        Tue, 27 Jul 2021 12:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627387682;
        bh=7LvTUArVOdRzWYfEtmbwTfkaY8DzCz+ox9YdHFuOenE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUMjD7skd0/8BYQ0Ms5w4opNTS6In9MSJYQCTQrrNEmVgzhfdXowYJb+pfKoza5BI
         tJrKyycfvdryDXGTbnkkUBhB2QuDwQI+Am0OJ1iQCZxvpTkk9xpTue5SUDgSB3Zy5U
         BwMAwVWXB8eau5sj/u7/nk1ToQ6ihuOiLoipOm3rXomuAoFANZ8GJUIMivcO8Hk2LO
         o1Y+yfVNjxaDBq47wJBlU4aiY87f98a6ezwDlmVHMFxdh3a4B/cCDTjrafOLLQaUsn
         6fOQP3IQWqdq5TGfY/Hq591XsYaXHCUb/JZDswlEODYRKFENVe3u7gj5jR+bptHi+A
         3C8ySd9af3xCg==
Date:   Tue, 27 Jul 2021 15:07:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v3 for-next 01/12] RDMA/hns: Introduce DCA for RC QP
Message-ID: <YP/3HPtB9DkFbWOL@unreal>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
 <1627356452-30564-2-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627356452-30564-2-git-send-email-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 11:27:21AM +0800, Wenpeng Liang wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The hip09 introduces the DCA(Dynamic context attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool, this will
> reduce the memory consumption when there are too many QPs are inactive.
> 
> If a QP enables DCA feature, the WQE's buffer will not be allocated when
> creating. But when the users start to post WRs, the hns driver will
> allocate a buffer from the memory pool and then fill WQEs which tagged with
> this QP's number.
> 
> The hns ROCEE will stop accessing the WQE buffer when the user polled all
> of the CQEs for a DCA QP, then the driver will recycle this WQE's buffer
> to the memory pool.
> 
> This patch adds a group of methods to support the user space register
> buffers to a memory pool which belongs to the user context. The hns kernel
> driver will update the pages state in this pool when the user calling the
> post/poll methods and the user driver can get the QP's WQE buffer address
> by the key and offset which queried from kernel.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 343 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_dca.h    |  22 ++
>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  27 ++-
>  include/uapi/rdma/hns-abi.h                 |  27 +++
>  6 files changed, 427 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h

<...>

> +static struct hns_dca_page_state *alloc_dca_states(void *pages, int count)
> +{
> +	struct hns_dca_page_state *states;
> +
> +	states = kcalloc(count, sizeof(*states), GFP_NOWAIT);

GFP_NOWAIT ????
Why do you use this flag while in the function before you used classic GFP_KERNEL?

Thanks
