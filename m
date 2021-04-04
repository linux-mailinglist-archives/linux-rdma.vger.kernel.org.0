Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B9B353836
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhDDNPo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 09:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhDDNPn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Apr 2021 09:15:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A63DD61210;
        Sun,  4 Apr 2021 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617542139;
        bh=F5BU3c8ulrHcngMnkVKeevAYqz8+ly+plYwNP3IB6/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A95bpsJLF1e1zeYJritmas9caa2EDZ7d05RQ62dppYaJzCri14JpYc+j9Yri/VXgF
         2km8HtKKbQa1D12E4IeAnCcNenUoqC3vsYwiuZ3oppJR8IJBfZQJb41eMpDikQizeH
         CWPlZTN5fRrT/lCt7ewOV1eGnze5vaqocLgMDCvcW/LRhOsG2jDLQNPQ+eAwmStj7M
         jyo9oiycs1SwbWLPxVEXi5ZFWWvaaKr4TVGCVotQsRaTMcVr1vCqtgCC4L3xfm3LDS
         A+q9FssaN9GLk5GTukkAuckzpdOq+WETXuG/c/UkqEaGFcuvtAo6PpcZSI/4P51Lni
         3B04ALmRsUjvw==
Date:   Sun, 4 Apr 2021 16:15:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Mark Bloch <mbloch@nvidia.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Bloch <markb@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/addr: potential uninitialized variable in
 ib_nl_process_good_ip_rsep()
Message-ID: <YGm798Im61n+2/mb@unreal>
References: <YGcES6MsXGnh83qi@mwanda>
 <YGmWB4fT/8IFeiZf@unreal>
 <1b21be94-bf14-9e73-68a3-c503bb79f683@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b21be94-bf14-9e73-68a3-c503bb79f683@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 04, 2021 at 04:13:17PM +0300, Mark Bloch wrote:
> On 4/4/21 1:33 PM, Leon Romanovsky wrote:
> > On Fri, Apr 02, 2021 at 02:47:23PM +0300, Dan Carpenter wrote:
> >> The nla_len() is less than or equal to 16.  If it's less than 16 then
> >> end of the "gid" buffer is uninitialized.
> >>
> >> Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> ---
> >> I just spotted this in review.  I think it's a bug but I'm not 100%.
> > 
> > I tend to agree with you, that it is a bug.
> > 
> > LS_NLA_TYPE_DGID is declared as NLA_BINARY which doesn't complain if
> > data is less than declared ".len". However, the fix needs to be in
> > ib_nl_is_good_ip_resp(), it shouldn't return "true" if length not equal
> > to 16.
> 
> What about just updating the policy? The bellow diff should work I believe.

I didn't know about ".validation_type", but yes this change will be enough.

> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 0abce004a959..65e3e7df8a4b 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -76,7 +76,9 @@ static struct workqueue_struct *addr_wq;
>  
>  static const struct nla_policy ib_nl_addr_policy[LS_NLA_TYPE_MAX] = {
>         [LS_NLA_TYPE_DGID] = {.type = NLA_BINARY,
> -               .len = sizeof(struct rdma_nla_ls_gid)},
> +               .len = sizeof(struct rdma_nla_ls_gid),
> +               .validation_type = NLA_VALIDATE_MIN,
> +               .min = sizeof(struct rdma_nla_ls_gid)},
>  };
>  
>  static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
> 
> > 
> > Thanks
> > 
> 
> Mark
