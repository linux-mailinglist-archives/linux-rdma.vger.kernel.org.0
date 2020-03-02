Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A411752C6
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 05:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCBEnD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Mar 2020 23:43:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45704 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBEnD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Mar 2020 23:43:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so9011325oic.12
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2020 20:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVjZZXlxxONovY0ODyekptAXEkEhd6rnDXIXkGoZRRg=;
        b=Iide8lxNKBDjHUzJkogPJo6GTM08yYKSsLVJziAKptXj6kZULOaWjbWOWTK328rvuD
         suCrWMfgjz0IQzzzJYinAT80frlwfkndcBQ5OEhNoJhshFKfWVsdq8Q7e8KE9/a7GHJT
         S1GVfF8K4wEVZV7j8El3e7Q0GBvnuNwttsnHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVjZZXlxxONovY0ODyekptAXEkEhd6rnDXIXkGoZRRg=;
        b=BFw2PPnpZvFf/Rm9Pst3LS4IwaWkeWhiXJNMqz+nU+PlrEb8JU24LR0g6wMukzEEQo
         3c2VG3Mukw3mv9WlwB1KWW1MlvbxNJysm+lFQmQGIr+giHjkg28UkJPqqcEmRf/hP2/a
         BLnVW8hDIK+l59eOlCIf7QtqWrWgRGUoRm/zLSk0py2tSSdch9eqCorXjd4Gp/AX7/uG
         zcIJKQKIy0oQnmbubohIw7dowLjwZVLTFvQMHn2K6xPJ9gLl0Li/Pirg0S5DFpaBhUzw
         rmX61L/4bKa5zEQkTGo6hv9WcGAn7pJX4rL7zp9ECD5LNkv3l0kSBdQbbRgAVa72Kixf
         0wGg==
X-Gm-Message-State: APjAAAW9AwYILORyKGggcxsp6BcuG87o3ON972PbdEZe8atZov/ewWRO
        /nVOCk5QAzJgUr5I25NjlexchuQgiAAvQ1ik7Uf8ma50
X-Google-Smtp-Source: APXvYqzSPSTEYeatCMpLEDopRzctu56QeXrU4RfyMrVVEKI+LfE5Ks2hcpJ5I12GuShOwH64DtODXL0+kHU/EZqP/gc=
X-Received: by 2002:aca:ba55:: with SMTP id k82mr10180167oif.94.1583124180202;
 Sun, 01 Mar 2020 20:43:00 -0800 (PST)
MIME-Version: 1.0
References: <1582731932-26574-1-git-send-email-selvin.xavier@broadcom.com>
 <1582731932-26574-3-git-send-email-selvin.xavier@broadcom.com> <20200228163522.GA27288@ziepe.ca>
In-Reply-To: <20200228163522.GA27288@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Mon, 2 Mar 2020 10:12:49 +0530
Message-ID: <CA+sbYW0vgu5nSz8wyLdGH-OVikoO4yy-tfi_URpM9E3rHrs98A@mail.gmail.com>
Subject: Re: [PATCH for-next v4 2/2] RDMA/bnxt_re: Use driver_unregister and
 unregistration API
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 28, 2020 at 10:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Feb 26, 2020 at 07:45:32AM -0800, Selvin Xavier wrote:
> > @@ -1724,6 +1714,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
> >               rc = bnxt_re_add_device(&rdev, real_dev);
> >               if (!rc)
> >                       sch_work = true;
> > +             release = false;
> >               break;
> >
> >       case NETDEV_UNREGISTER:
> > @@ -1732,8 +1723,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
> >                */
> >               if (atomic_read(&rdev->sched_count) > 0)
> >                       goto exit;
>
> This sched_count stuff needs cleaning too.
>
> krefs should be used properly, carry the kref on the ib_device into
> the work and use the registration lock on the ib device to serialize
> instead of this sched_count stuff.
>
> This all sounds so familiar.. Oh I tried to fix this once - maybe the
> below will help you:
>
Thanks Jason for the patches. Changes in first patch is already
taken care in my series. Will test  your other two patches and will
get back.

Thanks,
Selvin
> commit 33d88c818d155ffb2ef4b12e72107f628c70404c
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Thu Jan 10 12:05:19 2019 -0700
>
>     RDMA/bnxt_re: Use ib_device_get_by_netdev() instead of open coding
>
>     The core API handles the locking correctly and is faster if there
>     are multiple devices.
>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index fa539608ffbbe0..bd67a31937ec65 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -504,21 +504,6 @@ static bool is_bnxt_re_dev(struct net_device *netdev)
>         return false;
>  }
>
> -static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
> -{
> -       struct bnxt_re_dev *rdev;
> -
> -       rcu_read_lock();
> -       list_for_each_entry_rcu(rdev, &bnxt_re_dev_list, list) {
> -               if (rdev->netdev == netdev) {
> -                       rcu_read_unlock();
> -                       return rdev;
> -               }
> -       }
> -       rcu_read_unlock();
> -       return NULL;
> -}
> -
>  static void bnxt_re_dev_unprobe(struct net_device *netdev,
>                                 struct bnxt_en_dev *en_dev)
>  {
> @@ -1616,23 +1601,26 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>  {
>         struct net_device *real_dev, *netdev = netdev_notifier_info_to_dev(ptr);
>         struct bnxt_re_work *re_work;
> -       struct bnxt_re_dev *rdev;
> +       struct bnxt_re_dev *rdev = NULL;
> +       struct ib_device *ibdev;
>         int rc = 0;
>         bool sch_work = false;
>
>         real_dev = rdma_vlan_dev_real_dev(netdev);
>         if (!real_dev)
>                 real_dev = netdev;
> -
> -       rdev = bnxt_re_from_netdev(real_dev);
> -       if (!rdev && event != NETDEV_REGISTER)
> -               goto exit;
>         if (real_dev != netdev)
>                 goto exit;
>
> +       ibdev = ib_device_get_by_netdev(real_dev, RDMA_DRIVER_BNXT_RE);
> +       if (!ibdev && event != NETDEV_REGISTER)
> +               goto exit;
> +       if (ibdev)
> +               rdev = container_of(ibdev, struct bnxt_re_dev, ibdev);
> +
>         switch (event) {
>         case NETDEV_REGISTER:
> -               if (rdev)
> +               if (ibdev)
>                         break;
>                 rc = bnxt_re_dev_reg(&rdev, real_dev);
>                 if (rc == -ENODEV)
> @@ -1676,6 +1664,9 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>                 }
>         }
>
> +       if (ibdev)
> +               ib_device_put(ibdev);
> +
>  exit:
>         return NOTIFY_DONE;
>  }
>
> commit 6c617f08e749ee0f6c7be6763ea92e49ae484712
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Thu Jan 10 14:40:16 2019 -0700
>
>     RDMA/bnxt_re: Use ib_device_try_get()
>
>     There are a couple places in this driver running from a work queue that
>     need the ib_device to be registered. Instead of using a broken internal
>     bit rely on the new core code to guarantee device registration.
>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 666897596218d3..fa539608ffbbe0 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1137,12 +1137,13 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
>         u16 gid_idx, index;
>         int rc = 0;
>
> -       if (!test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
> +       if (!ib_device_try_get(&rdev->ibdev))
>                 return 0;
>
>         if (!sgid_tbl) {
>                 dev_err(rdev_to_dev(rdev), "QPLIB: SGID table not allocated");
> -               return -EINVAL;
> +               rc = -EINVAL;
> +               goto out;
>         }
>
>         for (index = 0; index < sgid_tbl->active; index++) {
> @@ -1163,6 +1164,8 @@ static int bnxt_re_update_gid(struct bnxt_re_dev *rdev)
>                                             rdev->qplib_res.netdev->dev_addr);
>         }
>
> +out:
> +       ib_device_put(&rdev->ibdev);
>         return rc;
>  }
>
> @@ -1545,12 +1548,7 @@ static void bnxt_re_task(struct work_struct *work)
>         re_work = container_of(work, struct bnxt_re_work, work);
>         rdev = re_work->rdev;
>
> -       if (re_work->event != NETDEV_REGISTER &&
> -           !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
> -               goto exit;
> -
> -       switch (re_work->event) {
> -       case NETDEV_REGISTER:
> +       if (re_work->event == NETDEV_REGISTER) {
>                 rc = bnxt_re_ib_reg(rdev);
>                 if (rc) {
>                         dev_err(rdev_to_dev(rdev),
> @@ -1559,7 +1557,13 @@ static void bnxt_re_task(struct work_struct *work)
>                         bnxt_re_dev_unreg(rdev);
>                         goto exit;
>                 }
> -               break;
> +               goto exit;
> +       }
> +
> +       if (!ib_device_try_get(&rdev->ibdev))
> +               goto exit;
> +
> +       switch (re_work->event) {
>         case NETDEV_UP:
>                 bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
>                                        IB_EVENT_PORT_ACTIVE);
> @@ -1579,6 +1583,8 @@ static void bnxt_re_task(struct work_struct *work)
>         default:
>                 break;
>         }
> +
> +       ib_device_put(&rdev->ibdev);
>         smp_mb__before_atomic();
>         atomic_dec(&rdev->sched_count);
>  exit:
>
> commit e64da98a182a2cae3338f28f6e581f189b5f8674
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Thu Jan 10 12:02:11 2019 -0700
>
>     RDMA/bnxt_re: Fix lifetimes in bnxt_re_task
>
>     A work queue cannot just rely on the ib_device not being freed, it must
>     hold a kref on the memory so that the BNXT_RE_FLAG_IBDEV_REGISTERED check
>     works.
>
>     Also, every single work queue call has an allocated memory, and the kfree
>     of this memory was missed sometimes.
>
>     Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
>
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 814f959c7db965..666897596218d3 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -1547,7 +1547,7 @@ static void bnxt_re_task(struct work_struct *work)
>
>         if (re_work->event != NETDEV_REGISTER &&
>             !test_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags))
> -               return;
> +               goto exit;
>
>         switch (re_work->event) {
>         case NETDEV_REGISTER:
> @@ -1582,6 +1582,7 @@ static void bnxt_re_task(struct work_struct *work)
>         smp_mb__before_atomic();
>         atomic_dec(&rdev->sched_count);
>  exit:
> +       put_device(&rdev->ibdev.dev);
>         kfree(re_work);
>  }
>
> @@ -1658,6 +1659,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>                 /* Allocate for the deferred task */
>                 re_work = kzalloc(sizeof(*re_work), GFP_ATOMIC);
>                 if (re_work) {
> +                       get_device(&rdev->ibdev.dev);
>                         re_work->rdev = rdev;
>                         re_work->event = event;
>                         re_work->vlan_dev = (real_dev == netdev ?
