Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54828ADBD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 07:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgJLFak (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 01:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgJLFak (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 01:30:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F46C0613CE
        for <linux-rdma@vger.kernel.org>; Sun, 11 Oct 2020 22:30:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l16so15586379eds.3
        for <linux-rdma@vger.kernel.org>; Sun, 11 Oct 2020 22:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+tlvBIXPIpndKCtroYI+zFWJEcB8tB+JAa3U2YJgP8=;
        b=gH/ilyTgySSIfu8sXrVWLSqL5M31gZ5gqAyDRGOQY79qNirVqmcJ+K7uc31x+F6SYy
         x6XXvDerbyLDzLm4U55OBdG9OZOvh8a3dLRL8bUR8R2IYFY97e/1OgxRb4wFITuvi43T
         yVF1zEX9zG1TrePr7o0m9SxTGyUMIGx4SnY9EF2ZMg/pN9vggY5RFdxzlQ7MIF9QCRUv
         eFc8LGkqsQySVPmTDz3gC5aWoA7GVG6O3GhInRgpvYoBgFsqX99e0Gsxg46IFiCbvAH8
         BxpIZ4z+NJmMCYYxqE21Aa81ZP68iT3ZhsoqBmXEjsr5WEeu8kEhgDT0uGk6B7bb+z8s
         9+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+tlvBIXPIpndKCtroYI+zFWJEcB8tB+JAa3U2YJgP8=;
        b=J34hLoyrlBjHE8wBOG2TwVvb8uKJ8YgRIVpGjFGIVBuBcGUtZKU1xpgA5s59Lsz4k2
         xMF0qn5hm6kWcuICPo7T2RpsDIT+oeiBnv/+BhVuB18OpoY5Cfi+H3c5F0L4ylDvH3BQ
         YSklocQT132PreSMoX+Gz0uXx1uHlb2N3VEBBjGLYvRd02+GW49OeGHGF0t6cT0fFaPI
         6gF+8wtcl9olTquAI5Sax3yUnn//SK/tcuDakmRsR3xAeE8NTtl/WJCu3na6KUPb5Qhw
         2GaQL01jof0F7+lpxg1pmdHnkIjfOeWqA9goyeQ5MAqMd89HwuVCYdKd9Y3TcsWpKn7W
         +jxQ==
X-Gm-Message-State: AOAM530dAi/bUjqkzfOAK2EbYK/7Bn0xuPnUMhnZFTnf7HDY7gbKmhbO
        PVlhF2OQBAnk17/V4wj1O28RdtxESaT8zBBwDhYIXA==
X-Google-Smtp-Source: ABdhPJwq19S3itBXNN7D6ior4OMucXmM1yjShl7GyXd6KoWXjjKsPb0+xlOlU99ol8rS0zG/Kk2GDhJlp5JMm4VkGMA=
X-Received: by 2002:aa7:c0d2:: with SMTP id j18mr2437470edp.89.1602480638426;
 Sun, 11 Oct 2020 22:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602122879.git.joe@perches.com> <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
In-Reply-To: <f5c9e4c9d8dafca1b7b70bd597ee7f8f219c31c8.1602122880.git.joe@perches.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 12 Oct 2020 07:30:27 +0200
Message-ID: <CAMGffEmJQSzF=kkxD8RreGODZdUktewTEaznCuFFu=kw22o=Jg@mail.gmail.com>
Subject: Re: [PATCH 3/4] RDMA: manual changes for sysfs_emit and neatening
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 8, 2020 at 4:36 AM Joe Perches <joe@perches.com> wrote:
>
> Make changes to use sysfs_emit in the RDMA code as cocci scripts can not
> be written to handle _all_ the possible variants of various sprintf family
> uses in sysfs show functions.
>
> While there, make the code more legible and update its style to be more
> like the typical kernel styles.
>
> Miscellanea:
>
> o Use intermediate pointers for dereferences
> o Add and use string lookup functions
> o return early when any intermediate call fails so normal return is
>   at the bottom of the function
> o mlx4/mcg.c:sysfs_show_group: use scnprintf to format intermediate strings
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/core/sysfs.c              | 60 +++++++-------
>  drivers/infiniband/hw/cxgb4/provider.c       |  5 +-
>  drivers/infiniband/hw/hfi1/sysfs.c           | 38 ++++-----
>  drivers/infiniband/hw/mlx4/main.c            |  5 +-
>  drivers/infiniband/hw/mlx4/mcg.c             | 82 +++++++++++---------
>  drivers/infiniband/hw/mlx4/sysfs.c           | 47 ++++++-----
>  drivers/infiniband/hw/mlx5/main.c            |  4 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c | 29 ++++---
>  drivers/infiniband/hw/qib/qib_sysfs.c        | 45 +++++------
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 66 +++++++---------
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 21 +++--
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 13 ++--
>  drivers/infiniband/ulp/srp/ib_srp.c          |  4 +
>  13 files changed, 206 insertions(+), 213 deletions(-)
>

>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> index 0c767582286b..51ba82fc425c 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -196,11 +196,10 @@ static struct kobj_attribute rtrs_clt_state_attr =
>         __ATTR(state, 0444, rtrs_clt_state_show, NULL);
>
>  static ssize_t rtrs_clt_reconnect_show(struct kobject *kobj,
> -                                       struct kobj_attribute *attr,
> -                                       char *buf)
> +                                      struct kobj_attribute *attr,
> +                                      char *buf)
>  {
> -       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> -                         attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
>  }
>
>  static ssize_t rtrs_clt_reconnect_store(struct kobject *kobj,
> @@ -228,11 +227,10 @@ static struct kobj_attribute rtrs_clt_reconnect_attr =
>                rtrs_clt_reconnect_store);
>
>  static ssize_t rtrs_clt_disconnect_show(struct kobject *kobj,
> -                                        struct kobj_attribute *attr,
> -                                        char *buf)
> +                                       struct kobj_attribute *attr,
> +                                       char *buf)
>  {
> -       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> -                         attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
>  }
>
>  static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
> @@ -260,11 +258,10 @@ static struct kobj_attribute rtrs_clt_disconnect_attr =
>                rtrs_clt_disconnect_store);
>
>  static ssize_t rtrs_clt_remove_path_show(struct kobject *kobj,
> -                                         struct kobj_attribute *attr,
> -                                         char *buf)
> +                                        struct kobj_attribute *attr,
> +                                        char *buf)
>  {
> -       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> -                         attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
>  }
>
>  static ssize_t rtrs_clt_remove_path_store(struct kobject *kobj,
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 381a776ce404..6e7bebe4e064 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -27,11 +27,10 @@ static struct kobj_type ktype = {
>  };
>
>  static ssize_t rtrs_srv_disconnect_show(struct kobject *kobj,
> -                                        struct kobj_attribute *attr,
> -                                        char *buf)
> +                                       struct kobj_attribute *attr,
> +                                       char *buf)
>  {
> -       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> -                         attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n", attr->attr.name);
>  }
>
>  static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
> @@ -72,8 +71,7 @@ static ssize_t rtrs_srv_hca_port_show(struct kobject *kobj,
>         sess = container_of(kobj, typeof(*sess), kobj);
>         usr_con = sess->s.con[0];
>
> -       return sysfs_emit(page, "%u\n",
> -                         usr_con->cm_id->port_num);
> +       return sysfs_emit(page, "%u\n", usr_con->cm_id->port_num);
>  }
>
>  static struct kobj_attribute rtrs_srv_hca_port_attr =
> @@ -87,8 +85,7 @@ static ssize_t rtrs_srv_hca_name_show(struct kobject *kobj,
>
>         sess = container_of(kobj, struct rtrs_srv_sess, kobj);
>
> -       return sysfs_emit(page, "%s\n",
> -                         sess->s.dev->ib_dev->name);
> +       return sysfs_emit(page, "%s\n", sess->s.dev->ib_dev->name);
>  }
>
For rtrs, looks good to me!
Thanks,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
