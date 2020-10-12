Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1BAA28AD8E
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Oct 2020 07:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgJLFV4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Oct 2020 01:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJLFV4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Oct 2020 01:21:56 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED889C0613CE
        for <linux-rdma@vger.kernel.org>; Sun, 11 Oct 2020 22:21:55 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dg9so13201305edb.12
        for <linux-rdma@vger.kernel.org>; Sun, 11 Oct 2020 22:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0R5L1o53BoczTM3Ja6SfdG7GuhxvBRufVBIdjGJFXc=;
        b=R2fpRB1Zx0eB4xJ3XescO3XW2ADr7656/xelLBJlE9P7BNX4csGtiWgDTDlzDXCBG0
         Y18lVQTKoPvOAF0i1t+xuB8yRAreJRmD8xaIUMKaGPEiY4ARsJjbPoM4SLWdUfWaNmj0
         eV8X105PR4qTDVLk6cXIMCzdAYXn7Q8icVpAmPpnplpgGjbom9XIi5RRZiVEpojlkmwH
         RsU8++HeO2h3S7DTBBk6pX8ZWBz/aNOFt2i4f5uGFyvfAZLX83U3zhxPo3DJ3LFBc2zh
         3NJfO7yecVN955UnXR3jg78eEff+4VdCuZi731heXiu9MMBuuIf5WVfppiVeN7qe8ASZ
         TlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0R5L1o53BoczTM3Ja6SfdG7GuhxvBRufVBIdjGJFXc=;
        b=ZGlF1fdphJUr9uLEpxBC5zECpyCmJ8COW03rUT6K+c72+PTB8zRqz4UG6u+uAMC726
         cUmadmgI+Jk5s7ZDohSISJseyxpcfSYFh4SU+aYAcUTphhvykHpS1xub9Nsx5mhTXkBa
         FFw7Bxw/NQ6V/b+7QUh+MXie97vnePdoU8ofdU208duiAwPV5e3UL6meaJ96TgqP2n80
         6M0wZ+skS55drmya5PYwDk6XZxpAk0Jmvwze+tpA1EaJwUECYjJ66tOZ+yChk1Jn7LdC
         ASV9HTSTiQDQ3cnDVOi01NnM78h01igMKb71CJzc8467bydxnH+nDY6ZxzmPrGbRiScL
         H8Ww==
X-Gm-Message-State: AOAM533iblBKxV2cnrdS+zEzOYhmAvLzIiA/BTlM7/Ue2I/3kuTUePs2
        gc59ShnkJWBetvnERLiKXAg6hjnhi+nBt8griRcNXw==
X-Google-Smtp-Source: ABdhPJxHdpvy19s/xYCWzkpKSX+ALqmaw1prmc7MiSkQvjUrP4IK5aSwT2ZeKjUc7fK1/u4135/S94DOLeteS3MKI+o=
X-Received: by 2002:aa7:c984:: with SMTP id c4mr12079683edt.42.1602480114295;
 Sun, 11 Oct 2020 22:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602122879.git.joe@perches.com> <7761c1efaebb96c432c85171d58405c25a824ccd.1602122880.git.joe@perches.com>
In-Reply-To: <7761c1efaebb96c432c85171d58405c25a824ccd.1602122880.git.joe@perches.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 12 Oct 2020 07:21:43 +0200
Message-ID: <CAMGffE=bkmnUn+fo1QJRJ3tC_gyagyf-spxTtBrM_6rbpYZFxg@mail.gmail.com>
Subject: Re: [PATCH 2/4] RDMA: Convert sysfs kobject * show functions to use sysfs_emit()
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 8, 2020 at 4:36 AM Joe Perches <joe@perches.com> wrote:
>
> Done with cocci script:
>
> @@
> identifier k_show;
> identifier arg1, arg2, arg3;
> @@
> ssize_t k_show(struct kobject *
> -       arg1
> +       kobj
>         , struct kobj_attribute *
> -       arg2
> +       attr
>         , char *
> -       arg3
> +       buf
>         )
> {
>         ...
> (
> -       arg1
> +       kobj
> |
> -       arg2
> +       attr
> |
> -       arg3
> +       buf
> )
>         ...
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         return
> -       sprintf(buf,
> +       sysfs_emit(buf,
>         ...);
>         ...>
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         return
> -       snprintf(buf, PAGE_SIZE,
> +       sysfs_emit(buf,
>         ...);
>         ...>
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         return
> -       scnprintf(buf, PAGE_SIZE,
> +       sysfs_emit(buf,
>         ...);
>         ...>
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> expression chr;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         return
> -       strcpy(buf, chr);
> +       sysfs_emit(buf, chr);
>         ...>
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         len =
> -       sprintf(buf,
> +       sysfs_emit(buf,
>         ...);
>         ...>
>         return len;
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         len =
> -       snprintf(buf, PAGE_SIZE,
> +       sysfs_emit(buf,
>         ...);
>         ...>
>         return len;
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
>         len =
> -       scnprintf(buf, PAGE_SIZE,
> +       sysfs_emit(buf,
>         ...);
>         ...>
>         return len;
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> identifier len;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         <...
> -       len += scnprintf(buf + len, PAGE_SIZE - len,
> +       len += sysfs_emit_at(buf, len,
>         ...);
>         ...>
>         return len;
> }
>
> @@
> identifier k_show;
> identifier kobj, attr, buf;
> expression chr;
> @@
>
> ssize_t k_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> {
>         ...
> -       strcpy(buf, chr);
> -       return strlen(buf);
> +       return sysfs_emit(buf, chr);
> }
>
> Signed-off-by: Joe Perches <joe@perches.com>
Thanks,
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 26 ++++++++++----------
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 14 +++++------
>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> index 7f71f10126fc..0c767582286b 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -187,9 +187,9 @@ static ssize_t rtrs_clt_state_show(struct kobject *kobj,
>
>         sess = container_of(kobj, struct rtrs_clt_sess, kobj);
>         if (sess->state == RTRS_CLT_CONNECTED)
> -               return sprintf(page, "connected\n");
> +               return sysfs_emit(page, "connected\n");
>
> -       return sprintf(page, "disconnected\n");
> +       return sysfs_emit(page, "disconnected\n");
>  }
>
>  static struct kobj_attribute rtrs_clt_state_attr =
> @@ -197,10 +197,10 @@ static struct kobj_attribute rtrs_clt_state_attr =
>
>  static ssize_t rtrs_clt_reconnect_show(struct kobject *kobj,
>                                         struct kobj_attribute *attr,
> -                                       char *page)
> +                                       char *buf)
>  {
> -       return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
> -                        attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> +                         attr->attr.name);
>  }
>
>  static ssize_t rtrs_clt_reconnect_store(struct kobject *kobj,
> @@ -229,10 +229,10 @@ static struct kobj_attribute rtrs_clt_reconnect_attr =
>
>  static ssize_t rtrs_clt_disconnect_show(struct kobject *kobj,
>                                          struct kobj_attribute *attr,
> -                                        char *page)
> +                                        char *buf)
>  {
> -       return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
> -                        attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> +                         attr->attr.name);
>  }
>
>  static ssize_t rtrs_clt_disconnect_store(struct kobject *kobj,
> @@ -261,10 +261,10 @@ static struct kobj_attribute rtrs_clt_disconnect_attr =
>
>  static ssize_t rtrs_clt_remove_path_show(struct kobject *kobj,
>                                           struct kobj_attribute *attr,
> -                                         char *page)
> +                                         char *buf)
>  {
> -       return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
> -                        attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> +                         attr->attr.name);
>  }
>
>  static ssize_t rtrs_clt_remove_path_store(struct kobject *kobj,
> @@ -327,7 +327,7 @@ static ssize_t rtrs_clt_hca_port_show(struct kobject *kobj,
>
>         sess = container_of(kobj, typeof(*sess), kobj);
>
> -       return scnprintf(page, PAGE_SIZE, "%u\n", sess->hca_port);
> +       return sysfs_emit(page, "%u\n", sess->hca_port);
>  }
>
>  static struct kobj_attribute rtrs_clt_hca_port_attr =
> @@ -341,7 +341,7 @@ static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
>
>         sess = container_of(kobj, struct rtrs_clt_sess, kobj);
>
> -       return scnprintf(page, PAGE_SIZE, "%s\n", sess->hca_name);
> +       return sysfs_emit(page, "%s\n", sess->hca_name);
>  }
>
>  static struct kobj_attribute rtrs_clt_hca_name_attr =
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 07fbb063555d..381a776ce404 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -28,10 +28,10 @@ static struct kobj_type ktype = {
>
>  static ssize_t rtrs_srv_disconnect_show(struct kobject *kobj,
>                                          struct kobj_attribute *attr,
> -                                        char *page)
> +                                        char *buf)
>  {
> -       return scnprintf(page, PAGE_SIZE, "Usage: echo 1 > %s\n",
> -                        attr->attr.name);
> +       return sysfs_emit(buf, "Usage: echo 1 > %s\n",
> +                         attr->attr.name);
>  }
>
>  static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
> @@ -72,8 +72,8 @@ static ssize_t rtrs_srv_hca_port_show(struct kobject *kobj,
>         sess = container_of(kobj, typeof(*sess), kobj);
>         usr_con = sess->s.con[0];
>
> -       return scnprintf(page, PAGE_SIZE, "%u\n",
> -                        usr_con->cm_id->port_num);
> +       return sysfs_emit(page, "%u\n",
> +                         usr_con->cm_id->port_num);
>  }
>
>  static struct kobj_attribute rtrs_srv_hca_port_attr =
> @@ -87,8 +87,8 @@ static ssize_t rtrs_srv_hca_name_show(struct kobject *kobj,
>
>         sess = container_of(kobj, struct rtrs_srv_sess, kobj);
>
> -       return scnprintf(page, PAGE_SIZE, "%s\n",
> -                        sess->s.dev->ib_dev->name);
> +       return sysfs_emit(page, "%s\n",
> +                         sess->s.dev->ib_dev->name);
>  }
>
>  static struct kobj_attribute rtrs_srv_hca_name_attr =
> --
> 2.26.0
>
