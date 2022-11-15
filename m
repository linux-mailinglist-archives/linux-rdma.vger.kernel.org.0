Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265E16294CC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238007AbiKOJtO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 04:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238029AbiKOJtM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 04:49:12 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B472D2D0
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 01:49:09 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id k19so16804608lji.2
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 01:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8m0XLrSSKEe666eNC6yJ4ZkBItu26anin6JmJAwbKII=;
        b=XT59P3xECXDv8CZacA/hPHOAKPW+FBCmMj0x1EI3la7fTm9tbH7bzsyjKp1rCbK8Go
         BJWWF+tmja29pdPkReDFOyxkWMpWxnlCFv35nEwgG+U1+cNd0W4wAa98rp0PUWqkgzKE
         083bsBK1USbaD8c0avqFJNAoomrJiK5Bkd/XVR27QIjx3jbVyLd4wUw3iiAlvbsD1UFV
         rSKJFbQqLIgq2dlB3zq2L/jN+H659CDpRK9k/XIXSj4R6ee2UJmrBUex5CFexlV8i9MU
         t5zDqLqUBhAXP3/au4QXqwoOonFFrQJ8tL4uQrS3IW7UkXLnOWc5fQ4ZWoEJ0tqJeXaf
         J5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8m0XLrSSKEe666eNC6yJ4ZkBItu26anin6JmJAwbKII=;
        b=NBgZ862z9eDKi4NFBa/YN5F2v0RTAwLvILBWVUCUmN2XdkQSPqJYCBK/TFDi9Anb1B
         n5NZQhM5dNU+sseQ4vIS2kIvUhIARiIwFVdCWWzfmsDsoYS6X5UAPXl+gZLpkw5rBh8n
         gdvzkIGPOF6ohWVrTWga3kMTU1c9YmjcJOGGWWS6Y6kLQc6iDa/QnUFEeosYxbhE9Gvf
         ZGr8Qfggr8RuGKQupE1NKY8XwKl3GBPJ61A+PFDwjE70UgWbSWiJNFQiEA6Pmd2NC91n
         dDDjfV2Z0pEQju+V4+nxgdia4qsnCRgH2dK7YhuagnZ0mG5d6/2+jpNqWQzZSKf+oZ+B
         WcaQ==
X-Gm-Message-State: ANoB5pkIom6k68usDW8AbQlwPJsGWkUyCQvO4v/cXzmll3gHy9uhUiG6
        wnLpBrMMLqoQ2FiI0lyfccO/CXNMaZZOEJ694EyDZg==
X-Google-Smtp-Source: AA0mqf7FzeCo8azWXEWwRUHgpKY4YDd6/NGShz5LeTuB4mGqbYDR+jjzNkhdWK87sP2Cst+ryzYarYzYh/9cAR55l2s=
X-Received: by 2002:a2e:2c15:0:b0:277:2463:cfdb with SMTP id
 s21-20020a2e2c15000000b002772463cfdbmr5524758ljs.213.1668505747472; Tue, 15
 Nov 2022 01:49:07 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-11-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-11-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Tue, 15 Nov 2022 10:48:56 +0100
Message-ID: <CAJpMwyjkeYj6eVMG+htwHkFVRP6m-tGpyFEaUeSCkXO3u6MqzA@mail.gmail.com>
Subject: Re: [PATCH RFC 10/12] RDMA/rtrs-srv: Remove paths_num
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
> The paths_num is only increased by rtrs_rdma_connect -> __alloc_path
> which is only one time thing, so is the decreasing of it given only
> rtrs_srv_close_work -> del_path_from_srv, which means paths_num should
> always be 1.

It would actually go up to the number of paths a session will have in
a multipath setup. It is the exact counter part of paths_num in the
structure rtrs_clt_sess. But whereas on the client side, the number is
used to access the path list for making decisions in multipathing IO
like round-robin, etc. On the server side, I don't see the use of it.
Maybe just for sanity checks.

@Jinpu Any thoughts?

>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 --------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.h | 1 -
>  2 files changed, 9 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index e2ea09a8def7..400cf8ae34a3 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1437,8 +1437,6 @@ static void __add_path_to_srv(struct rtrs_srv_sess *srv,
>                               struct rtrs_srv_path *srv_path)
>  {
>         list_add_tail(&srv_path->s.entry, &srv->paths_list);
> -       srv->paths_num++;
> -       WARN_ON(srv->paths_num >= MAX_PATHS_NUM);
>  }
>
>  static void del_path_from_srv(struct rtrs_srv_path *srv_path)
> @@ -1450,8 +1448,6 @@ static void del_path_from_srv(struct rtrs_srv_path *srv_path)
>
>         mutex_lock(&srv->paths_mutex);
>         list_del(&srv_path->s.entry);
> -       WARN_ON(!srv->paths_num);
> -       srv->paths_num--;
>         mutex_unlock(&srv->paths_mutex);
>  }
>
> @@ -1719,10 +1715,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
>         char str[NAME_MAX];
>         struct rtrs_addr path;
>
> -       if (srv->paths_num >= MAX_PATHS_NUM) {
> -               err = -ECONNRESET;
> -               goto err;
> -       }
>         if (__is_path_w_addr_exists(srv, &cm_id->route.addr)) {
>                 err = -EEXIST;
>                 pr_err("Path with same addr exists\n");
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> index eccc432b0715..8e4fcb578f49 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> @@ -100,7 +100,6 @@ struct rtrs_srv_sess {
>         struct list_head        paths_list;
>         int                     paths_up;
>         struct mutex            paths_ev_mutex;
> -       size_t                  paths_num;
>         struct mutex            paths_mutex;
>         uuid_t                  paths_uuid;
>         refcount_t              refcount;
> --
> 2.31.1
>
