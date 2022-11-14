Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36961628511
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237409AbiKNQXk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 11:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiKNQX1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 11:23:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD83A6
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:23:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so20115897lfi.7
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XnUIvmC+iX3nCUVpcXy1cqMsdzKOxfI2liQe+iDYp2s=;
        b=Es0h3lFnsZjckuHlwqNdn3xqJs+v3ptpOjzPjwx4EYBR468gLNiVXhcJizAn9rp5H5
         879HFn238UNdsH0rILeOMr5KZLk7VWvCEPW25zwmWRet7kk+KANqqnTsw1hyXWBYX8el
         m17Q0+p3wBpktzcXH488kfC6ORNohgBB+kcLBAaPHuBmvNhnQBAUQ5mLnd15gOl8P6EZ
         +5QMv80SXfY9TLbiWDhhYDrknAZAcBDrOgnSdoHBbeWkdAbgdC51VDbpZsR3+wawCAhR
         2pqgBGf3epsg2QxsYuWT0Bqryhwu895hVm1o8GqB2dpRnydpM6Yu6DYOlGLZ3Fk+e+Bd
         uYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnUIvmC+iX3nCUVpcXy1cqMsdzKOxfI2liQe+iDYp2s=;
        b=lebrrRLXoFVdgrNuyYQNNGZ0pAHXSOCtvJT1L3Bzg2x8NxCB8fiEna33keH6xyRsFE
         6Z3fHbucwJ5mWIdwYFf8UIpIIl3fIwEqFP3GdT6P6uIqsvOkX6HBaen1YJVevSWOaNsY
         M4zDbYVUWd5ac6lhaMaJUqZL1v8vJLQb8F5yOoqZ1+xeAhpzdMHoqf9R2Y0tS16ErHhf
         PjiYqu4h/dK/EJg3f/n3hPVQ4/rCLlWg8x2gOW0rCFL45lq6Mn/bdwt5GwMNdxzmlSBX
         VrJWjIDPj540J9/vgSh4fdj+gXbRBCNczq25++MoTsiFGWW3cbEXHEmVHKY5Ngot128q
         YIxA==
X-Gm-Message-State: ANoB5pkjpuPLIRp851lL0+UFVfHV/HROlFJIuxzoW3foxlPY7C65/lY0
        ax5SdF3oeqokDqb6bTyUirT/47/EXr+UNqskzzbR1g==
X-Google-Smtp-Source: AA0mqf6vBlS3VMvdoiXPdBNG6W5TumCyDVTXCEqtggCv+B+6LORUrxOe48LKRdr7aWbw9Hfs7gRLBb3sw/Km11R0jLk=
X-Received: by 2002:a19:2d1e:0:b0:4a2:b56c:388e with SMTP id
 k30-20020a192d1e000000b004a2b56c388emr4215008lfj.145.1668443003680; Mon, 14
 Nov 2022 08:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev> <20221113010823.6436-13-guoqing.jiang@linux.dev>
In-Reply-To: <20221113010823.6436-13-guoqing.jiang@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 14 Nov 2022 17:23:12 +0100
Message-ID: <CAJpMwyjRAHD=bXchSuEKqq2KcgiCJpzF+ChfROZKDf4xQ1bSMw@mail.gmail.com>
Subject: Re: [PATCH RFC 12/12] RDMA/rtrs-srv: Remove kobject_del from rtrs_srv_destroy_once_sysfs_root_folders
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
> The kobj_paths which is created dynamically by kobject_create_and_add,
> and per the comment above kobject_create_and_add, we only need to call
> kobject_put which is not same as other kobjs such as stats->kobj_stats
> and srv_path->kobj.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Md Haris Iqbal <haris.iqbal@ionos.com>

Thanks

> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index da8e205ce331..c76ba29da1e2 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -203,7 +203,6 @@ rtrs_srv_destroy_once_sysfs_root_folders(struct rtrs_srv_path *srv_path)
>
>         mutex_lock(&srv->paths_mutex);
>         if (!--srv->dev_ref) {
> -               kobject_del(srv->kobj_paths);
>                 kobject_put(srv->kobj_paths);
>                 mutex_unlock(&srv->paths_mutex);
>                 device_del(&srv->dev);
> --
> 2.31.1
>
