Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06B33752F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 15:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhCKONN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 09:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233256AbhCKOMx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 09:12:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 053A964E77;
        Thu, 11 Mar 2021 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615471972;
        bh=sdeipfns5kt1PWF6q1N5om3MHUtfAAJhqn4SCS/EBPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Soj1WKpkFhwK59JYb09zMLDUjL4HNxWQnIixL9G7ymKCUNrRlUE01cyRbv6DQQfXF
         WWcaPV9cJCHldVZihN7oZsWNqHAMlWYaMsEUYZDZqEBrs372hZjstrqqG1iW/ssd/o
         XSt2F6irghQCO/9fS/iSbRQH12Kvn2qHwzY9O8YdBn5vg6xqrRvz+VfOJKOkDaAKCf
         YGRScjPPsXZ8YC97CTWR5sbGj0fzPx8K7pS9PvTcnoaDgpjUb2OiqKY5WdSyKcmdn+
         ACmNmFOrsiG2Mw9iNzxHSjy41DFMbYEwRlAMKJVtqmUk/AGYVD29UFhRyrVVVToNfz
         ktTXXYS9RIZVw==
Date:   Thu, 11 Mar 2021 16:12:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     lyl2019@mail.ustc.edu.cn
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: Re: [PATCH] infiniband/core: Fix a use after free in
 cm_work_handler
Message-ID: <YEolYCHpzxQ2eRST@unreal>
References: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
 <YEnhO9EXgI8pwVD2@unreal>
 <1149b747.c620.17820d56572.Coremail.lyl2019@mail.ustc.edu.cn>
 <YEn5XxgB1LqQ0PSE@unreal>
 <f748b4c.c8d4.178212b8650.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f748b4c.c8d4.178212b8650.Coremail.lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 11, 2021 at 08:03:23PM +0800, lyl2019@mail.ustc.edu.cn wrote:
>
>
>
> > -----原始邮件-----
> > 发件人: "Leon Romanovsky" <leon@kernel.org>
> > 发送时间: 2021-03-11 19:05:03 (星期四)
> > 收件人: lyl2019@mail.ustc.edu.cn
> > 抄送: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
> > 主题: Re: Re: [PATCH] infiniband/core: Fix a use after free in cm_work_handler
> >
> > On Thu, Mar 11, 2021 at 06:29:19PM +0800, lyl2019@mail.ustc.edu.cn wrote:
> > > In the implementation of destory_cm_id(), it restores cm_id_priv by
> > > "cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);".
> > >
> > > And the last line of destory_cm_id() calls "(void)iwcm_deref_id(cm_id_priv);"
> > > to free the cm_id_priv.
> >
> > It is not enough to see double call to iwcm_deref_id() because it is
> > protected with refcount to claim use-after-free. Did you hit the BUG_ON()
> > for the second call to iwcm_deref_id()?
> >
> > And please don't do top-posting.
> >
> > Thanks
> >
> > >
> > >
> > > > -----原始邮件-----
> > > > 发件人: "Leon Romanovsky" <leon@kernel.org>
> > > > 发送时间: 2021-03-11 17:22:03 (星期四)
> > > > 收件人: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > > > 抄送: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
> > > > 主题: Re: [PATCH] infiniband/core: Fix a use after free in cm_work_handler
> > > >
> > > > On Wed, Mar 10, 2021 at 06:21:53PM -0800, Lv Yunlong wrote:
> > > > > In cm_work_handler, it calls destory_cm_id() to release
> > > > > the initial reference of cm_id_priv taken by iw_create_cm_id()
> > > > > and free the cm_id_priv. After destory_cm_id(), iwcm_deref_id
> > > > > (cm_id_priv) will be called and cause a use after free.
> > > > >
> > > > > Fixes: 59c68ac31e15a ("iw_cm: free cm_id resources on the last deref")
> > > > > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > > > > ---
> > > > > drivers/infiniband/core/iwcm.c | 4 +++-
> > > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> > > > > index da8adadf4755..cb6b4ac45e21 100644
> > > > > --- a/drivers/infiniband/core/iwcm.c
> > > > > +++ b/drivers/infiniband/core/iwcm.c
> > > > > @@ -1035,8 +1035,10 @@ static void cm_work_handler(struct work_struct *_work)
> > > > >
> > > > > 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
> > > > > 			ret = process_event(cm_id_priv, &levent);
> > > > > -			if (ret)
> > > > > +			if (ret) {
> > > > > 				destroy_cm_id(&cm_id_priv->id);
> > > > > +				return;
> > > >
> > > > The destroy_cm_id() is called to free ->id and not cm_id_priv. This "return"
> > > > leaks cm_id_priv now and what "a use after free" do you see?
> > > >
> > > > > +			}
> > > > > 		} else
> > > > > 			pr_debug("dropping event %d\n", levent.event);
> > > > > 		if (iwcm_deref_id(cm_id_priv))
> > > > > --
> > > > > 2.25.1
> > > > >
> > > > >
>
> I'm not familiar with debug the kernel, sorry.This problem was
>  reported by my code analyzer and reviewed by myself.
>
> But i think as long as destroy_cm_id() is called, iwcm_deref_id() will be called twice.
> Then "BUG_ON(atomic_read(&cm_id_priv->refcount)==0);" in iwcm_deref_id() will be triggered.
>
> Is it not a true problem?

I don't know, this is I'm trying to understand here.

Thanks
