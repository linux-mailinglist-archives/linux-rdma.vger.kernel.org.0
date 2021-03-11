Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6683370C9
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 12:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhCKLFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 06:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232471AbhCKLFH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 06:05:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82AE264F2D;
        Thu, 11 Mar 2021 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615460707;
        bh=ojLsKqfHgZ/ae7khvpUUUEKBw/8cvtf1sRoHwUnM5Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDoKshXjwCFRnIIjb8xnD4Tm4t7ur2iUmxbF2Yxtuhvg2Vx1TZUvzdEGxBORmXNSj
         PsOpC7k1yu9BSdzWP7tgNZtG8nMG3TYSPOcrjzvCpCGR12bsMCFHC42FRWVYqIWn8p
         xjVO9FsVLQPQSc50wJkGuORTbn/kVAkrqaIZC2dXeZ+obslcQyeFkPB5bbZ8ZzE/eJ
         ++pV5t83DZMi1x9E9BY2OwLtwyYmpNoyAjCw4w1B7ZGTiWChvHzko+LBJwSC315Dgb
         2K/+m3x0M63TahFcKOhEna5EMqmUMW1fgxNw5J+5+BtSlJjNIPqE2ddqU6hevq3M6B
         LQ0PdvHtM2usg==
Date:   Thu, 11 Mar 2021 13:05:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     lyl2019@mail.ustc.edu.cn
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] infiniband/core: Fix a use after free in
 cm_work_handler
Message-ID: <YEn5XxgB1LqQ0PSE@unreal>
References: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
 <YEnhO9EXgI8pwVD2@unreal>
 <1149b747.c620.17820d56572.Coremail.lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1149b747.c620.17820d56572.Coremail.lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 11, 2021 at 06:29:19PM +0800, lyl2019@mail.ustc.edu.cn wrote:
> In the implementation of destory_cm_id(), it restores cm_id_priv by
> "cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);".
>
> And the last line of destory_cm_id() calls "(void)iwcm_deref_id(cm_id_priv);"
> to free the cm_id_priv.

It is not enough to see double call to iwcm_deref_id() because it is
protected with refcount to claim use-after-free. Did you hit the BUG_ON()
for the second call to iwcm_deref_id()?

And please don't do top-posting.

Thanks

>
>
> > -----原始邮件-----
> > 发件人: "Leon Romanovsky" <leon@kernel.org>
> > 发送时间: 2021-03-11 17:22:03 (星期四)
> > 收件人: "Lv Yunlong" <lyl2019@mail.ustc.edu.cn>
> > 抄送: dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
> > 主题: Re: [PATCH] infiniband/core: Fix a use after free in cm_work_handler
> >
> > On Wed, Mar 10, 2021 at 06:21:53PM -0800, Lv Yunlong wrote:
> > > In cm_work_handler, it calls destory_cm_id() to release
> > > the initial reference of cm_id_priv taken by iw_create_cm_id()
> > > and free the cm_id_priv. After destory_cm_id(), iwcm_deref_id
> > > (cm_id_priv) will be called and cause a use after free.
> > >
> > > Fixes: 59c68ac31e15a ("iw_cm: free cm_id resources on the last deref")
> > > Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> > > ---
> > >  drivers/infiniband/core/iwcm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> > > index da8adadf4755..cb6b4ac45e21 100644
> > > --- a/drivers/infiniband/core/iwcm.c
> > > +++ b/drivers/infiniband/core/iwcm.c
> > > @@ -1035,8 +1035,10 @@ static void cm_work_handler(struct work_struct *_work)
> > >
> > >  		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
> > >  			ret = process_event(cm_id_priv, &levent);
> > > -			if (ret)
> > > +			if (ret) {
> > >  				destroy_cm_id(&cm_id_priv->id);
> > > +				return;
> >
> > The destroy_cm_id() is called to free ->id and not cm_id_priv. This "return"
> > leaks cm_id_priv now and what "a use after free" do you see?
> >
> > > +			}
> > >  		} else
> > >  			pr_debug("dropping event %d\n", levent.event);
> > >  		if (iwcm_deref_id(cm_id_priv))
> > > --
> > > 2.25.1
> > >
> > >
