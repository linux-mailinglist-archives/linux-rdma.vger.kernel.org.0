Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69C32A1BD7
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Nov 2020 05:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgKAE2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Nov 2020 00:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgKAE2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Nov 2020 00:28:17 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0DAC0617A6
        for <linux-rdma@vger.kernel.org>; Sat, 31 Oct 2020 21:28:16 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id f37so9444533otf.12
        for <linux-rdma@vger.kernel.org>; Sat, 31 Oct 2020 21:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPw9VHT3LSVrND5lf6sF3ZE0eX3rpL3QVGi65jXa3C4=;
        b=cINhsJcJVRG8rXl4e80NuETRxNeE30apEMuOMC5m9Pikzq+ScTm/nmYfc2sZGbLFmj
         vTmVYJB3maDtoPGv9rmrOPBQA7SsVbWTCutmQLJm02Fd0bxbqO4S9WtoH3BxkI3aMJia
         Qi6ay0k38tM5oud0umy1WXYkxHYW6cVcuirB8MAckhQl/TcHlA4ICQiMFVDiE9mcmgQC
         Em02Ygi22pSODRELt786fEyWJRfBJ3UKvX4LB5dvgg6jCCxF83zFrMGbnnrcdIhAx9lJ
         r99J2SnjRe9zxbNd9mjJgF8z5u1SsGRiBmbLrR6n9SOCq5Rr5GtdrnQUJ7v5RA7QUJLK
         V3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPw9VHT3LSVrND5lf6sF3ZE0eX3rpL3QVGi65jXa3C4=;
        b=Ce8LQtgDlnsyPpGb+RdeVY9smYancEBnrEURwqyGHdI5/gRTa08hW6u9Lgzf5L19i/
         K9bzI44El9BOQGelyDBNLVp5en3CKeoMtL2YvPaWDgTQwm4AqNs/t5Kg1p43ar/MjsG0
         MRACBWZAcub3m+hArhKEhlKfPHAkLWANoSKoT2bG3Kc8P7+s55ZuNuhO/1lk9sYGkQT8
         Vd/xIgqmR8pReYxLxPY43mdgmd7cLRroJyPO7uY0qkV4njXnHbbeja4Uk2Ao/aai1hH9
         mzucl5J0waBxT/iLSHX2jn3wmXDWYNcviW24f8UG+DFKVavHO+YVys+bWEHr+so0gn/T
         lhkQ==
X-Gm-Message-State: AOAM531Hmo+AzGmprqr3Lj9yFk9oW5IiouudfzzR1PfXX3TMyivHEyAJ
        ihL7II0YXbA4SPPAbtx4EXw1wj/xJ6Dg80kF770IEfl9
X-Google-Smtp-Source: ABdhPJx6AUS6L8rlM2sh+IL/RkovPp+zRwpAIbOBGPPb4iYey8cPf1a9Zxx4VLIw1zUOXslz/Zd1GfgcYlqpiHxei2E=
X-Received: by 2002:a05:6830:2018:: with SMTP id e24mr7785503otp.278.1604204896094;
 Sat, 31 Oct 2020 21:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201030093803.278830-1-parav@nvidia.com>
In-Reply-To: <20201030093803.278830-1-parav@nvidia.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 1 Nov 2020 12:28:05 +0800
Message-ID: <CAD=hENeUA7AhndzEvWPyyZ6KcKu7T3sacXbDNCLRiLeEBBiELA@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Fix software RDMA drivers for dma mapping error
To:     Parav Pandit <parav@nvidia.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@nvidia.com>, bmt@zurich.ibm.com,
        linux-rdma@vger.kernel.org, hch@lst.de,
        syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 30, 2020 at 5:39 PM Parav Pandit <parav@nvidia.com> wrote:
>
> A cited commit in fixes tag avoided setting dma_mask of the ib_device.
> Commit [1] made dma_mask as mandetory field to be setup even for
> dma_virt_ops based dma devices. Due to which below call trace occurred.
>
> Fix it by setting empty DMA MASK for software based RDMA devices.
>
> WARNING: CPU: 1 PID: 8488 at kernel/dma/mapping.c:149
> dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149 Modules linked in:
> CPU: 1 PID: 8488 Comm: syz-executor144 Not tainted 5.9.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> RIP: 0010:dma_map_page_attrs+0x493/0x700 kernel/dma/mapping.c:149
> Trace:
>  dma_map_single_attrs include/linux/dma-mapping.h:279 [inline]
> ib_dma_map_single include/rdma/ib_verbs.h:3967 [inline]
>  ib_mad_post_receive_mads+0x23f/0xd60
> drivers/infiniband/core/mad.c:2715
>  ib_mad_port_start drivers/infiniband/core/mad.c:2862 [inline]
> ib_mad_port_open drivers/infiniband/core/mad.c:3016 [inline]
>  ib_mad_init_device+0x72b/0x1400 drivers/infiniband/core/mad.c:3092
>  add_client_context+0x405/0x5e0 drivers/infiniband/core/device.c:680
>  enable_device_and_get+0x1d5/0x3c0
> drivers/infiniband/core/device.c:1301
>  ib_register_device drivers/infiniband/core/device.c:1376 [inline]
>  ib_register_device+0x7a7/0xa40 drivers/infiniband/core/device.c:1335
>  rxe_register_device+0x46d/0x570
> drivers/infiniband/sw/rxe/rxe_verbs.c:1182
>  rxe_add+0x12fe/0x16d0 drivers/infiniband/sw/rxe/rxe.c:247
>  rxe_net_add+0x8c/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:507
>  rxe_newlink drivers/infiniband/sw/rxe/rxe.c:269 [inline]
>  rxe_newlink+0xb7/0xe0 drivers/infiniband/sw/rxe/rxe.c:250
>  nldev_newlink+0x30e/0x540 drivers/infiniband/core/nldev.c:1555
>  rdma_nl_rcv_msg+0x367/0x690 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
>  rdma_nl_rcv+0x2f2/0x440 drivers/infiniband/core/netlink.c:259
>  netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
> sock_sendmsg_nosec net/socket.c:651 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:671
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2353
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2407
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2440
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x443699
>
> [1] commit f959dcd6ddfd ("dma-direct: Fix potential NULL pointer dereference")
>
> Reported-by: syzbot+34dc2fea3478e659af01@syzkaller.appspotmail.com
> Fixes: e0477b34d9d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Thanks a lot. I have made tests and confirmed that this commit works very well.

Zhu Yanjun

> ---
>  drivers/infiniband/sw/rdmavt/vt.c     | 7 +++++--
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>  drivers/infiniband/sw/siw/siw_main.c  | 7 +++++--
>  3 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
> index 43fbc4e54edf..5bd817490b1f 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -525,6 +525,7 @@ static noinline int check_support(struct rvt_dev_info *rdi, int verb)
>  int rvt_register_device(struct rvt_dev_info *rdi)
>  {
>         int ret = 0, i;
> +       u64 dma_mask;
>
>         if (!rdi)
>                 return -EINVAL;
> @@ -581,8 +582,10 @@ int rvt_register_device(struct rvt_dev_info *rdi)
>
>         /* DMA Operations */
>         rdi->ibdev.dev.dma_parms = rdi->ibdev.dev.parent->dma_parms;
> -       dma_set_coherent_mask(&rdi->ibdev.dev,
> -                             rdi->ibdev.dev.parent->coherent_dma_mask);
> +       dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
> +       ret = dma_coerce_mask_and_coherent(&rdi->ibdev.dev, dma_mask);
> +       if (ret)
> +               goto bail_wss;
>
>         /* Protection Domain */
>         spin_lock_init(&rdi->n_pds_lock);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7652d53af2c1..50ad3dded786 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1128,6 +1128,7 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>         int err;
>         struct ib_device *dev = &rxe->ib_dev;
>         struct crypto_shash *tfm;
> +       u64 dma_mask;
>
>         strlcpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
>
> @@ -1140,7 +1141,10 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>                             rxe->ndev->dev_addr);
>         dev->dev.dma_parms = &rxe->dma_parms;
>         dma_set_max_seg_size(&dev->dev, UINT_MAX);
> -       dma_set_coherent_mask(&dev->dev, dma_get_required_mask(&dev->dev));
> +       dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
> +       err = dma_coerce_mask_and_coherent(&dev->dev, dma_mask);
> +       if (err)
> +               return err;
>
>         dev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ);
>
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index e49faefdee92..6fe120187238 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -306,6 +306,7 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>         struct siw_device *sdev = NULL;
>         struct ib_device *base_dev;
>         struct device *parent = netdev->dev.parent;
> +       u64 dma_mask;
>         int rv;
>
>         if (!parent) {
> @@ -360,8 +361,10 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>         base_dev->dev.parent = parent;
>         base_dev->dev.dma_parms = &sdev->dma_parms;
>         dma_set_max_seg_size(&base_dev->dev, UINT_MAX);
> -       dma_set_coherent_mask(&base_dev->dev,
> -                             dma_get_required_mask(&base_dev->dev));
> +       dma_mask = IS_ENABLED(CONFIG_64BIT) ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32);
> +       if (dma_coerce_mask_and_coherent(&base_dev->dev, dma_mask))
> +               goto error;
> +
>         base_dev->num_comp_vectors = num_possible_cpus();
>
>         xa_init_flags(&sdev->qp_xa, XA_FLAGS_ALLOC1);
> --
> 2.26.2
>
