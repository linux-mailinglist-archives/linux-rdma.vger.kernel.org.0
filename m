Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F2D12199C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLPTBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 14:01:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45461 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLPTB3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Dec 2019 14:01:29 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so5039166lfa.12
        for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2019 11:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8zv1CiPH593sjJeuXjnKC5zw4ZEGW4qNjfHHVhMY3Y=;
        b=ezPwBt9pUMGZXAfLdBdvnrmdpl1zWlUKRl7w5W1F0CBO0BZjbIoARtDcId4cwYQVoJ
         x6deawPEIIjhrfIYzC7E3RnmFJPoPe+o4Tpp0m4KWbTXmqmXuilZniU4wGMH521vhenO
         Fyb+whsXeMgRu2l2jULJPCi1SVUHPGeRtYiGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8zv1CiPH593sjJeuXjnKC5zw4ZEGW4qNjfHHVhMY3Y=;
        b=KdftecDm//O2p3OBTYZ8JjlcmDB4gW59eiZdOYQKIzVWv9vwxiSNfSXmgrdQJYD4RD
         FeOxSVCijVTmsuTUy6774GLTwmSpUI6fEzpeQZJiYbaaC8y1Otk/W4bSQppalEP97Q6z
         TTC7X9ptrkpdrNKueFxiTb1yC3aFpGr0wd73gGfVIFEsIJl+ePLy4N3ARsSTdLf17mkd
         EFq00WKzqaecu445WPkZ1SctSbPW1JIPHKH3/bZRzmaGajZn7m7KXN27ODgIx1tGQf5z
         +Npg2EFp1AlU4CTusw7WWGOsi142kggmFv4EwImOA/jyZSgQ2C3psUxmTkVJ8Coas0aH
         ACXA==
X-Gm-Message-State: APjAAAWIKcfT/qNQDST/TGCjcNReuuPdGcxp4oUIQ0Ne6+mOX/LGBDEl
        sVMKZ41v87P3MPnpavHwMhq7gC9EN7PJCPEQ5blH0Q==
X-Google-Smtp-Source: APXvYqz7K/UCHxkFWnkPVaboJEEgUEvs787WcXzp6l8eUvEdNbEIL+niAGbE/zeLTUwQA96F6RqcRb0xCxq1xsIoOKc=
X-Received: by 2002:a19:a408:: with SMTP id q8mr335591lfc.174.1576522886867;
 Mon, 16 Dec 2019 11:01:26 -0800 (PST)
MIME-Version: 1.0
References: <1576195889-23527-1-git-send-email-psajeepa@purestorage.com> <20191215185500.GA6097@unreal>
In-Reply-To: <20191215185500.GA6097@unreal>
From:   Prabhath Sajeepa <psajeepa@purestorage.com>
Date:   Mon, 16 Dec 2019 11:01:15 -0800
Message-ID: <CAE=VkfCzi3ooh7Cg8NqDNdVE4cwPvjO6JNjKCiAJQC37KyWJag@mail.gmail.com>
Subject: Re: [PATCH] IB/mlx5: Fix outstanding_pi index for GSI qps
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roland Dreier <roland@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 15, 2019 at 10:55 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Dec 12, 2019 at 05:11:29PM -0700, Prabhath Sajeepa wrote:
> > b0ffeb537f3a changed the way how outstanding WRs are tracked for GSI QP. But the
> > fix did not cover the case when a call to ib_post_send fails and index
> > to track outstanding WRs need to be updated correctly.
> >
> > Fixes: b0ffeb537f3a ('IB/mlx5: Fix iteration overrun in GSI qps ')
> > Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
> > ---
> >  drivers/infiniband/hw/mlx5/gsi.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c
> > index ac4d8d1..1ae6fd9 100644
> > --- a/drivers/infiniband/hw/mlx5/gsi.c
> > +++ b/drivers/infiniband/hw/mlx5/gsi.c
> > @@ -507,8 +507,7 @@ int mlx5_ib_gsi_post_send(struct ib_qp *qp, const struct ib_send_wr *wr,
> >               ret = ib_post_send(tx_qp, &cur_wr.wr, bad_wr);
> >               if (ret) {
> >                       /* Undo the effect of adding the outstanding wr */
> > -                     gsi->outstanding_pi = (gsi->outstanding_pi - 1) %
> > -                                           gsi->cap.max_send_wr;
> > +                     gsi->outstanding_pi--;
>
> I'm a little bit confused, what is the difference before and after
> except dropping "gsi->cap.max_send_wr"?
>
> Thanks
>
> >                       goto err;
> >               }
> >               spin_unlock_irqrestore(&gsi->lock, flags);
> > --
> > 2.7.4
> >

This patch needs to be considered in conjunction with the below patch
done by Slava Shwartsman

commit b0ffeb537f3a726931d962ab6d03e34a2f070ea4

Author: Slava Shwartsman <slavash@mellanox.com>

Date:   Sun Jul 3 06:28:19 2016

    IB/mlx5: Fix iteration overrun in GSI qps



    Number of outstanding_pi may overflow and as a result may indicate that

    there are no elements in the queue. The effect of doing this is that the

    MAD layer will get stuck waiting for completions. The MAD layer will

    think that the QP is full - because it didn't receive these completions.



    This fix changes it so the outstanding_pi number is increased

    with 32-bit wraparound and is not limited to max_send_wr so

    that the difference between outstanding_pi and outstanding_ci will

    really indicate the number of outstanding completions.


    Cc: Stable <stable@vger.kernel.org>

    Fixes: ea6dc2036224 ('IB/mlx5: Reorder GSI completions')

    Signed-off-by: Slava Shwartsman <slavash@mellanox.com>

    Signed-off-by: Leon Romanovsky <leon@kernel.org>

    Reviewed-by: Haggai Eran <haggaie@mellanox.com>

    Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

    Signed-off-by: Doug Ledford <dledford@redhat.com>

diff --git a/drivers/infiniband/hw/mlx5/gsi.c b/drivers/infiniband/hw/mlx5/gsi.c

index 53e03c8..79e6309 100644

--- a/drivers/infiniband/hw/mlx5/gsi.c

+++ b/drivers/infiniband/hw/mlx5/gsi.c

@@ -69,15 +69,6 @@ static bool mlx5_ib_deth_sqpn_cap(struct mlx5_ib_dev *dev)

        return MLX5_CAP_GEN(dev->mdev, set_deth_sqpn);

 }



-static u32 next_outstanding(struct mlx5_ib_gsi_qp *gsi, u32 index)

-{

-       return ++index % gsi->cap.max_send_wr;

-}

-

-#define for_each_outstanding_wr(gsi, index) \

-       for (index = gsi->outstanding_ci; index != gsi->outstanding_pi; \

-            index = next_outstanding(gsi, index))

-

 /* Call with gsi->lock locked */

 static void generate_completions(struct mlx5_ib_gsi_qp *gsi)

 {

@@ -85,8 +76,9 @@ static void generate_completions(struct mlx5_ib_gsi_qp *gsi)

        struct mlx5_ib_gsi_wr *wr;

        u32 index;



-       for_each_outstanding_wr(gsi, index) {

-               wr = &gsi->outstanding_wrs[index];

+       for (index = gsi->outstanding_ci; index != gsi->outstanding_pi;

+            index++) {

+               wr = &gsi->outstanding_wrs[index % gsi->cap.max_send_wr];



                if (!wr->completed)

                        break;

@@ -430,8 +422,9 @@ static int mlx5_ib_add_outstanding_wr(struct
mlx5_ib_gsi_qp *gsi,

                return -ENOMEM;

        }



-       gsi_wr = &gsi->outstanding_wrs[gsi->outstanding_pi];

-       gsi->outstanding_pi = next_outstanding(gsi, gsi->outstanding_pi);

+       gsi_wr = &gsi->outstanding_wrs[gsi->outstanding_pi %

+                                      gsi->cap.max_send_wr];

+       gsi->outstanding_pi++;



        if (!wc) {

                memset(&gsi_wr->wc, 0, sizeof(gsi_wr->wc));



The above fix was incomplete since it did not fix the ib_post_send
failure case, which is fixed by the patch I submitted.


-- 
Thanks,
Prabhath
