Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2007B3E0272
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Aug 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbhHDNxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 09:53:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237156AbhHDNxj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Aug 2021 09:53:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FBFB60EE5;
        Wed,  4 Aug 2021 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628085207;
        bh=9OFLSLaWZEiz0zjbwf/0fkoZwlWio885LGnwee/LxW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/CW58RuFXGwzx9U720u7bhqr8lspy7Zqwn2Ag0dvEQLdTlpflBX6F75MT8lXVuqg
         8AvLMAOKcS9QF3JJiJxsb91vZlxydcURGKFfuDksLB4e8nDWquV5PKvqv0NHnHy8Xq
         IUD/9zjARklfA+8g+JMLsZctg6VtvoQaIX/KUD1ieYxkvePlFoLvtIeIhy9TeLTgm0
         ATYHGZEgrpSWSCtpn8sQwZoyPJH0O6OXDEN1dcecY+OWo+JHkbBCwg+cYaiul77tdp
         zPKqYI4S2VI7XvGDzsXUj+ERfgVEW7rv1zRV/ArU3cH3RSqfKWv5cqcfhphYXZx/bU
         ycn5PVT0T43wA==
Date:   Wed, 4 Aug 2021 16:53:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     liangwenpeng@huawei.com, liweihang@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, chenglang@huawei.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Message-ID: <YQqb0U43eQUGK641@unreal>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804125939.20516-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 04, 2021 at 08:59:39PM +0800, YueHaibing wrote:
> If re-registering an MR in hns_roce_rereg_user_mr(), we should
> return NULL instead of pass 0 to ERR_PTR.
> 
> Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 006c84bb3f9f..7089ac780291 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -352,7 +352,9 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
>  free_cmd_mbox:
>  	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
>  
> -	return ERR_PTR(ret);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	return NULL;
>  }

I don't understand this function, it returns or ERR_PTR() or NULL, but
should return &mr->ibmr in success path. How does it work?

Thanks

>  
>  int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> -- 
> 2.17.1
> 
