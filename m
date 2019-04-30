Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7329AFE8D
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 19:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfD3RNK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 13:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RNJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Apr 2019 13:13:09 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 498812064A;
        Tue, 30 Apr 2019 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556644389;
        bh=S99Z6o7F7FzVoTC94QiwrHxGisC9gNZfwlAgAn8/gmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDHCePdFank+ZeMuTNF05TsNErCuHWbYNt+GROIBIKE/KGClCLZ2U5++yNyT3q+Ir
         FfWWXrTAu9AtTUbcK4NwRJNYtnCG+0q+Y2KhWkh6CVn4NhVmx6UtkCxKhQyM2sULWS
         NlbXbyyIkXlGKbF/PSMu1+6JoJQmd7G6yjVtAGF8=
Date:   Tue, 30 Apr 2019 20:13:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Denis Drozdov <denisd@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Erez Alfasi <ereza@mellanox.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH for-next v1 4/4] IB/{core,hw}: ib_pd should not have
 ib_uobject pointer
Message-ID: <20190430171302.GK6705@mtr-leonro.mtl.com>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
 <20190430142333.31063-5-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430142333.31063-5-shamir.rabinovitch@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 30, 2019 at 05:23:24PM +0300, Shamir Rabinovitch wrote:
> future patches will add the ability to share ib_pd across multiple
> ib_ucontext. given that, ib_pd will be pointed by 1 or more ib_uobject.
> thus, having ib_uobject pointer in ib_pd is incorrect.
>
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> ---
>  drivers/infiniband/core/nldev.c            | 5 -----
>  drivers/infiniband/core/uverbs_cmd.c       | 1 -
>  drivers/infiniband/core/verbs.c            | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
>  drivers/infiniband/hw/mlx5/main.c          | 1 -
>  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
>  include/rdma/ib_verbs.h                    | 1 -
>  7 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index bced945a456d..f8a325d8082c 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -606,11 +606,6 @@ static int fill_res_pd_entry(struct sk_buff *msg, bool has_cap_net_admin,
>  	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, res->id))
>  		goto err;
>
> -	if (!rdma_is_kernel_res(res) &&
> -	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> -			pd->uobject->context->res.id))
> -		goto err;
> -

Definitely not, in current code, PD is not shared and connected to ucontext,
users need to continue to see it. There are multiple ways to return
multiple contextes for shared PD:
1. Return multiple fill_res_pd_entry() for every shared PD, but with
different context ID.
2. Create nested context ID and return list here.

Thanks
