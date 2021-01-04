Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B242E90C1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jan 2021 08:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbhADHHB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jan 2021 02:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:52536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbhADHHB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Jan 2021 02:07:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B34F32087E;
        Mon,  4 Jan 2021 07:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609743980;
        bh=OG7D4CMRV9LGdQ7auL/TzVCnxzoDQ6JDQfHcrXoOF/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ma8bX5nXPJp+FiTArbWo6+B7KEBR47zRG+B6O0mGeUanqgvNLkqzCttchY5W3RdCw
         NzHLvPgLMhW/T+gT0GNjvBZB89lNnO7V2c/tAQ3RE4bl3k0jknrXrJWBT4IHKCtdYP
         p2w+hL0Y+XdJCFiOUyla41RrT3A6KigPPslQuud7p8kJZWB6fawSkTgvpDFNOLYqVj
         7HwFPW7RqRpwb0GtKziDuloaL6AM7+1XZeiG1J852eqnQU9wijzNB0XsgACIPlJyqy
         w3PXC10cM8CWmgHOxCOk5QL/LY42gzJblGjf/+W9nM43IKu10t4TcA1cFX02JkDUwJ
         QBF6JExL9W7ig==
Date:   Mon, 4 Jan 2021 09:06:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH for-next] RDMA/hns: Create CQ with selected CQN for bank
 load balance
Message-ID: <20210104070616.GE31158@unreal>
References: <1609742115-47270-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609742115-47270-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 04, 2021 at 02:35:15PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
>
> In order to improve performance by balancing the load between different
> banks of cache, the CQC cache is desigend to choose one of 4 banks
> according to lower 2 bits of CQN. The hns driver needs to count the number
> of CQ on each bank and then assigns the CQ being created to the bank with
> the minimum load first.
>
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 114 +++++++++++++++++++++++-----
>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   8 +-
>  3 files changed, 104 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
> index 8533fc2..00350a3 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_cq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
> @@ -38,11 +38,74 @@
>  #include "hns_roce_hem.h"
>  #include "hns_roce_common.h"
>

<...>

> +	id = ida_alloc_range(&bank->ida, bank->min, bank->max, GFP_ATOMIC);

Do you create CQ in atomic context?
It is probably GFP_KERNEL and not GFP_ATOMIC.

Thanks
