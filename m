Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC412125B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 18:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLPRwD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 12:52:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfLPRwC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Dec 2019 12:52:02 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64202072D;
        Mon, 16 Dec 2019 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518721;
        bh=Ax9FX6mkAiMSD2E503wbhkyltTzj2mc0isu/CrNmJ3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GyUKL1atiewyOIgNqC/Ykcz1HvUb/Jttc0W8Hz7wfDucBV2GUWnlrFE5mQ35f47yN
         HVdBTfnXxraBxcjQzDTIDd8f8geB7bomYASzdvxPbuSCetdmxaUOVmNaIBCMi8o8hz
         xV6xWdyoEKMaXqoDCVde3pexb5dEVRUUe6Qmp3RI=
Date:   Mon, 16 Dec 2019 19:51:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Prabhath Sajeepa <psajeepa@purestorage.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>,
        Ashish Karkare <ashishk@purestorage.com>
Subject: Re: [PATCH] IB/mlx5: Fix outstanding_pi index for GSI qps
Message-ID: <20191216175158.GC66555@unreal>
References: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com>
 <20191215185500.GA6097@unreal>
 <CAE=VkfD0Ywey6wW_rOZ=4qGyW347kTXH_MM17NvQhy6bkT=+tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=VkfD0Ywey6wW_rOZ=4qGyW347kTXH_MM17NvQhy6bkT=+tw@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please don't send HTML emails, they are marked as SPAM and dropped from
ML, and please don't do top-posting.

Can you please resend so we will be able to read it?

My question is still valid, what is the difference between
"gsi->outstanding_pi = (gsi->outstanding_pi - 1)" in original code
and "gsi->outstanding_pi--" in proposed patch.

Thanks

On Mon, Dec 16, 2019 at 09:21:53AM -0800, Prabhath Sajeepa wrote:
> Hi Leon,
>
> This patch needs to be considered in conjunction with the below change done
> by Slava Shwartsman
>
> commit b0ffeb537f3a726931d962ab6d03e34a2f070ea4
>
> Author: Slava Shwartsman <slavash@mellanox.com>
>
> Date:   Sun Jul 3 06:28:19 2016
>
>     IB/mlx5: Fix iteration overrun in GSI qps
>
>         Number of outstanding_pi may overflow and as a result may indicate that
>
>     there are no elements in the queue. The effect of doing this is that the
>
>     MAD layer will get stuck waiting for completions. The MAD layer will
>
>     think that the QP is full - because it didn't receive these completions.
>
>         This fix changes it so the outstanding_pi number is increased
>
>     with 32-bit wraparound and is not limited to max_send_wr so
>
>     that the difference between outstanding_pi and outstanding_ci will
>
>     really indicate the number of outstanding completions.
>
>         Cc: Stable <stable@vger.kernel.org>
>
>     Fixes: ea6dc2036224 ('IB/mlx5: Reorder GSI completions')
>
>     Signed-off-by: Slava Shwartsman <slavash@mellanox.com>
>
>     Signed-off-by: Leon Romanovsky <leon@kernel.org>
>
>     Reviewed-by: Haggai Eran <haggaie@mellanox.com>
>
>     Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
>     Signed-off-by: Doug Ledford <dledford@redhat.com>
>
> diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
>
> index 53e03c8..79e6309 100644
>
> --- a/drivers/infiniband/hw/mlx5/gsi.c
>
> +++ b/drivers/infiniband/hw/mlx5/gsi.c
>
> @@ -69,15 +69,6 @@ static bool mlx5_ib_deth_sqpn_cap(struct mlx5_ib_dev *dev)
>
>         return MLX5_CAP_GEN(dev->mdev, set_deth_sqpn);
>
>  }
>
>
>
> -static u32 next_outstanding(struct mlx5_ib_gsi_qp *gsi, u32 index)
>
> -{
>
> -       return ++index % gsi->cap.max_send_wr;
>
> -}
>
> -
>
> -#define for_each_outstanding_wr(gsi, index) \
>
> -       for (index = gsi->outstanding_ci; index != gsi->outstanding_pi; \
>
> -            index = next_outstanding(gsi, index))
>
> -
>
>  /* Call with gsi->lock locked */
>
>  static void generate_completions(struct mlx5_ib_gsi_qp *gsi)
>
>  {
>
> @@ -85,8 +76,9 @@ static void generate_completions(struct mlx5_ib_gsi_qp *gsi)
>
>         struct mlx5_ib_gsi_wr *wr;
>
>         u32 index;
>
>
>
> -       for_each_outstanding_wr(gsi, index) {
>
> -               wr = &gsi->outstanding_wrs[index];
>
> +       for (index = gsi->outstanding_ci; index != gsi->outstanding_pi;
>
> +            index++) {
>
> +               wr = &gsi->outstanding_wrs[index % gsi->cap.max_send_wr];
>
>
>
>                 if (!wr->completed)
>
>                         break;
>
> @@ -430,8 +422,9 @@ static int mlx5_ib_add_outstanding_wr(struct
> mlx5_ib_gsi_qp *gsi,
>
>                 return -ENOMEM;
>
>         }
>
>
>
> -       gsi_wr = &gsi->outstanding_wrs[gsi->outstanding_pi];
>
> -       gsi->outstanding_pi = next_outstanding(gsi, gsi->outstanding_pi);
>
> +       gsi_wr = &gsi->outstanding_wrs[gsi->outstanding_pi %
>
> +                                      gsi->cap.max_send_wr];
>
> +       gsi->outstanding_pi++;
>
>
>
>         if (!wc) {
>
>                 memset(&gsi_wr->wc, 0, sizeof(gsi_wr->wc));
>
>
>
> The above fix was incomplete since it did not fix the ib_send_post
> failure case, which is fixed by the patch I submitted.
>
>
> Thanks,
>
> Prabhath.
>
>
> On Sun, Dec 15, 2019 at 10:55 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> > On Thu, Dec 12, 2019 at 05:11:29PM -0700, Prabhath Sajeepa wrote:
> > > b0ffeb537f3a changed the way how outstanding WRs are tracked for GSI QP.
> > But the
> > > fix did not cover the case when a call to ib_post_send fails and index
> > > to track outstanding WRs need to be updated correctly.
> > >
> > > Fixes: b0ffeb537f3a ('IB/mlx5: Fix iteration overrun in GSI qps ')
> > > Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> > > ---
> > >  drivers/infiniband/hw/mlx5/gsi.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mlx5/gsi.c
> > b/drivers/infiniband/hw/mlx5/gsi.c
> > > index ac4d8d1..1ae6fd9 100644
> > > --- a/drivers/infiniband/hw/mlx5/gsi.c
> > > +++ b/drivers/infiniband/hw/mlx5/gsi.c
> > > @@ -507,8 +507,7 @@ int mlx5_ib_gsi_post_send(struct ib_qp *qp, const
> > struct ib_send_wr *wr,
> > >               ret = ib_post_send(tx_qp, &cur_wr.wr, bad_wr);
> > >               if (ret) {
> > >                       /* Undo the effect of adding the outstanding wr */
> > > -                     gsi->outstanding_pi = (gsi->outstanding_pi - 1) %
> > > -                                           gsi->cap.max_send_wr;
> > > +                     gsi->outstanding_pi--;
> >
> > I'm a little bit confused, what is the difference before and after
> > except dropping "gsi->cap.max_send_wr"?
> >
> > Thanks
> >
> > >                       goto err;
> > >               }
> > >               spin_unlock_irqrestore(&gsi->lock, flags);
> > > --
> > > 2.7.4
> > >
> >
>
>
> --
> Thanks,
> Prabhath
