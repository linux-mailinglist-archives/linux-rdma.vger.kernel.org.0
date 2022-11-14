Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C94628510
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbiKNQXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 11:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiKNQXI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 11:23:08 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411D2F398
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:23:07 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id c25so13877668ljr.8
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+XHqhmE9c8ljAHwnKRbzL6lgGb29nprsd2yKH8yo87A=;
        b=Fi43vcOIgEBhIjiGwV2BiP81GwuTtH5iGolFBMKiy1wsYe0iZvZ12w9Zht6QtWrHti
         8wcyzF4wkfiPWGFvin2nusgzddUUShN/za76zdAS9pKJPdJKHFbPVIbxHGcR1aPaeTNb
         /YXFOwRPtPoa5YL4oVsTGwgj7CvNT/xigZ5eg+cZcg6cZs3h0W5TUrsOTJ92WiwgsrJn
         dcF2bzCCtJ81cx6D1RI07oFvo5Xlfla4o4OPDyVfIQA0UtD8W3sj7r4FGODTzqgEFVY7
         YI9OJAJfaKddw2B70JYNrJTvD/cEtkm2OGuGP1QiY68sG2qiqoa4qxpQ2iBAGcZVv+j/
         v16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XHqhmE9c8ljAHwnKRbzL6lgGb29nprsd2yKH8yo87A=;
        b=BBCBZ8N1gZelkb6CstgS6lEgo3aAs2vKv5iL65o1xTlA7Pmj+YbLCaEgKoyR/SDjCW
         aGwgHAn8nYPoCrTx7QwgSXkE31uhlj7tvrAVhsTCQGAJa9xUtwFECaQlu2/TyPsov030
         k0CmOFB3l7UvFAuUqeYnSfGhLTVLsqMjO/KbHdIeahedIaACnLuobB7y5+q5XEseE0uY
         hPaUYsSlPmY0fzoZnkTSSzatytrqvhCUdTL5gPQgKsva5DD/ORwDwI8OBK7zopIkNxu9
         k/k8sDWoFLB3rRAaz/BTXI/Xy2Jbd5ZEpxtcimnvwWb7FTlmmws5jXf7V6YLSdZIuoQW
         QrLQ==
X-Gm-Message-State: ANoB5pk+HIucb89J+YUPel0ljWNuZy2HfVf9jWOHt+P3VJL1yWF6K3fO
        Lf/uoBBGJdzGXEBVZ86/n8113hSQp6JJBakFjWCgeqa3j7xwhQ==
X-Google-Smtp-Source: AA0mqf7/uXZRxUOIRT7nXKzlhcW88Whg2cQnY4fZbXF9GLx+rpxkWwB5lhIfbRgfHw9JJNK7G5rqTooHJ0RUdJ6YjQc=
X-Received: by 2002:a2e:2c15:0:b0:277:2463:cfdb with SMTP id
 s21-20020a2e2c15000000b002772463cfdbmr4433179ljs.213.1668442985597; Mon, 14
 Nov 2022 08:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-12-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-12-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 14 Nov 2022 17:22:54 +0100
Message-ID: <CAJpMwyh0dxi1oWiyc6DXUc6Zyzup3=Hjy4qMiA4=Fj1N6p1-Dg@mail.gmail.com>
Subject: Re: [PATCH RFC 11/12] RDMA/rtrs-srv: fix several issues in rtrs_srv_destroy_path_files
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     jinpu.wang@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> There are several issues in the function which is supposed to be paired
> with rtrs_srv_create_path_files.
>
> 1. rtrs_srv_stats_attr_group is not removed though it is created in
>    rtrs_srv_create_stats_files.
>
> 2. it makes more sense to check kobj_stats.state_in_sysfs before destroy
>    kobj_stats instead of rely on kobj.state_in_sysfs.
>
> 3. kobject_init_and_add is used for both kobjs (srv_path->kobj and
>    srv_path->stats->kobj_stats), however we missed to call kobject_del
>    for srv_path->kobj which was called in free_path.
>
> 4. rtrs_srv_destroy_once_sysfs_root_folders is independant of either
>    kobj or kobj_stats.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 2a3c9ac64a42..da8e205ce331 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -304,12 +304,18 @@ int rtrs_srv_create_path_files(struct rtrs_srv_path *srv_path)
>
>  void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
>  {
> -       if (srv_path->kobj.state_in_sysfs) {
> +       if (srv_path->stats->kobj_stats.state_in_sysfs) {
> +               sysfs_remove_group(&srv_path->stats->kobj_stats,
> +                                  &rtrs_srv_stats_attr_group);
>                 kobject_del(&srv_path->stats->kobj_stats);
>                 kobject_put(&srv_path->stats->kobj_stats);
> +       }
> +
> +       if (srv_path->kobj.state_in_sysfs) {
>                 sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
> +               kobject_del(&srv_path->kobj);
>                 kobject_put(&srv_path->kobj);
> -
> -               rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
>         }
> +
> +       rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
>  }
> --
> 2.31.1
>
