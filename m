Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE7A3E0CD7
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 05:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhHEDkx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Aug 2021 23:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231286AbhHEDkx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Aug 2021 23:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08779601FE;
        Thu,  5 Aug 2021 03:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628134839;
        bh=PK6dnDBY1zuPRNjL8RTX2Tvc6wQe7Reoet39PTJ0OvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f4VtB3inVBuZ48BKIde5Ozmc1B+6R0ID13sLavH3Awom27D6BmCGSsNWyaG4NI0wV
         XokCKghOii90o4qA1if/XlZK9fYDiXNsTQvbaHQTZgbTTixwTC7K9Y7KFCfA5idgKF
         IV5+EKabAYgS7Qe5Wq/YHP0piYf1UGK49qznC2vOsUDH5DVGPwz0qA8ZX4KhGy0/VO
         rTc5HJla6i7Uoc33kN3kuELXnOjjikZS9rEoVtEYBwmvxzfVD5Aj6Ayq3pYzKzWeha
         yv7lBSyqFfQIHLCXEzfJmwNYo+FCjSxel/OAO7lWdf7h1/mvQz7547vat0ybdfXNwm
         4OPyDF+ZfPXNA==
Date:   Thu, 5 Aug 2021 06:40:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     liangwenpeng@huawei.com, liweihang@huawei.com, dledford@redhat.com,
        jgg@ziepe.ca, chenglang@huawei.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Message-ID: <YQtdswHgMXhC7Mf5@unreal>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
 <YQqb0U43eQUGK641@unreal>
 <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 10:36:03AM +0800, YueHaibing wrote:
> On 2021/8/4 21:53, Leon Romanovsky wrote:
> > On Wed, Aug 04, 2021 at 08:59:39PM +0800, YueHaibing wrote:
> >> If re-registering an MR in hns_roce_rereg_user_mr(), we should
> >> return NULL instead of pass 0 to ERR_PTR.
> >>
> >> Fixes: 4e9fc1dae2a9 ("RDMA/hns: Optimize the MR registration process")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/infiniband/hw/hns/hns_roce_mr.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> >> index 006c84bb3f9f..7089ac780291 100644
> >> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> >> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> >> @@ -352,7 +352,9 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
> >>  free_cmd_mbox:
> >>  	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
> >>  
> >> -	return ERR_PTR(ret);
> >> +	if (ret)
> >> +		return ERR_PTR(ret);
> >> +	return NULL;
> >>  }
> > 
> > I don't understand this function, it returns or ERR_PTR() or NULL, but
> > should return &mr->ibmr in success path. How does it work?
> 
> Did you means hns_roce_reg_user_mr()?
> 
> hns_roce_rereg_user_mr() returns ERR_PTR() on failure, and return NULL on success,
> 
> In ib_uverbs_rereg_mr(), old mr will be used if rereg_user_mr() return NULL, see:
> 
>  829         new_mr = ib_dev->ops.rereg_user_mr(mr, cmd.flags, cmd.start, cmd.length,
>  830                                            cmd.hca_va, cmd.access_flags, new_pd,
>  831                                            &attrs->driver_udata);
>  832         if (IS_ERR(new_mr)) {
>  833                 ret = PTR_ERR(new_mr);
>  834                 goto put_new_uobj;
>  835         }
>  836         if (new_mr) {
> .....
>  860                 mr = new_mr;
>  861         } else {
>  862                 if (cmd.flags & IB_MR_REREG_PD) {
>  863                         atomic_dec(&orig_pd->usecnt);
>  864                         mr->pd = new_pd;
>  865                         atomic_inc(&new_pd->usecnt);
>  866                 }
>  867                 if (cmd.flags & IB_MR_REREG_TRANS)
>  868                         mr->iova = cmd.hca_va;
>  869         }

You overwrite various fields in old_mr when executing hns_roce_rereg_user_mr().
For example mr->access flags, which is not returned to the original
state after all failures.

Also I'm not so sure about if it is valid to return NULL in all flows.

Thanks

> 
> 
> > 
> > Thanks
> > 
> >>  
> >>  int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> >> -- 
> >> 2.17.1
> >>
> > .
> > 
