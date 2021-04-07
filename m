Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7335681A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 11:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350145AbhDGJdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 05:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbhDGJdT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 05:33:19 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D0BC061760
        for <linux-rdma@vger.kernel.org>; Wed,  7 Apr 2021 02:22:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s21so1717483eju.8
        for <linux-rdma@vger.kernel.org>; Wed, 07 Apr 2021 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaD4JWEw+doBeV8J7JmEjPkx/vhi6GCYLKeOHsRweMQ=;
        b=BKUADwSlSCVAd8gp95zLvfTZ6oJoXinISCFdp7XS4BfOjUzZ6wnMOEA+g520LS+JXe
         CiSLZf5vAZ+Ge1lGJamp7bOYkEdITgT50faM7ObyXeX7QNFHDZiEZF9Qxi2Oi6Rks7Hf
         Y9+hpKvh8aOxDABFfjy+SX0YLDd3UbSMzhng9tlNzGMI5sGqNu9lNfaIe5mu1xQA9eYX
         Rtw4NNfQlcGsEqoEsubW85OUKLtAKvegxizIdp3CEpJxtCBNZ0abJsOZW2gD/5dkJko9
         PT8XuGCNgwS5aILpJEs1b4vFmX1SkoRTODIVjUgO94pUDqSZUz9Ux87w/H03J+uSr359
         kkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaD4JWEw+doBeV8J7JmEjPkx/vhi6GCYLKeOHsRweMQ=;
        b=oxq6F21D4X1aLOK9UC22dRpNVao9pI8Br/V1Cp78iV1RkOExIwN7OVhGICUXSssKQh
         4S6RGMGf39ha2d/v1ZiGEQ2enJWDkSIcteWSMBR5gNyH/gyhHdHKXc5pwOEvhMTYsESH
         s2dZD6iJuPOe7PDstuWLY9LrI1VgGUIJx9RfQkryjkRMTrzV3XalLnE0TgqcqJIK/4g3
         JveUbzCgMQmGSiAl7HarX7zcTG5aSgUAHnf36jZkouIjttuI2YHxkpJwbMORT4EiM0M8
         GMC2b0b/YaMyh0U849palu1qEYyDfwfIScnoutpuZ2tjIKSuM+Tet2bGlSLsS5rCa/wa
         tvXg==
X-Gm-Message-State: AOAM530qgxrHSgHxizZtsnbgVsQr3KUl3d6HPheEmiRQw5pDraywi19G
        uYwxkee1pfOrA8KojNmV2hmCHE2XyD3RyI3QQx9z6Q==
X-Google-Smtp-Source: ABdhPJyD0R5RLKBmsjG6Kj3ybDz4S+0QxLTQWlGPjReTI8LjREdctNqQUUHZFMbAGNHbrfG3vBWuUzeswvn4JQZXDyo=
X-Received: by 2002:a17:906:2b46:: with SMTP id b6mr2539071ejg.521.1617787323341;
 Wed, 07 Apr 2021 02:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210406120553.197848-1-gi-oh.kim@ionos.com> <20210406120553.197848-3-gi-oh.kim@ionos.com>
In-Reply-To: <20210406120553.197848-3-gi-oh.kim@ionos.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 7 Apr 2021 11:21:52 +0200
Message-ID: <CAMGffEnZEAnkbjdr-ds8V32cVJRujMdFWyaY2p6_PpBjCN6ORw@mail.gmail.com>
Subject: Re: [PATCH 2/4] RDMA/rtrs-clt: new sysfs attribute to print the
 latency of each path
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 6, 2021 at 2:06 PM Gioh Kim <gi-oh.kim@ionos.com> wrote:
>
> From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
>
> It shows the latest latency that the client checked when sending
> the heart-beat.
>
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> index bc46b7a99ba0..fc6de514b328 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
> @@ -354,6 +354,21 @@ static ssize_t rtrs_clt_hca_name_show(struct kobject *kobj,
>  static struct kobj_attribute rtrs_clt_hca_name_attr =
>         __ATTR(hca_name, 0444, rtrs_clt_hca_name_show, NULL);
>
> +static ssize_t rtrs_clt_cur_latency_show(struct kobject *kobj,
> +                                   struct kobj_attribute *attr,
> +                                   char *page)
> +{
> +       struct rtrs_clt_sess *sess;
> +
> +       sess = container_of(kobj, struct rtrs_clt_sess, kobj);
> +
> +       return scnprintf(page, PAGE_SIZE, "%lld ns\n",
> +                        ktime_to_ns(sess->s.hb_cur_latency));
> +}
sysfs_emit should be used like other functions in the same file.  Gioh
can you please fix it?

Thanks!
> +
> +static struct kobj_attribute rtrs_clt_cur_latency_attr =
> +       __ATTR(cur_latency, 0444, rtrs_clt_cur_latency_show, NULL);
> +
>  static ssize_t rtrs_clt_src_addr_show(struct kobject *kobj,
>                                        struct kobj_attribute *attr,
>                                        char *page)
> @@ -397,6 +412,7 @@ static struct attribute *rtrs_clt_sess_attrs[] = {
>         &rtrs_clt_reconnect_attr.attr,
>         &rtrs_clt_disconnect_attr.attr,
>         &rtrs_clt_remove_path_attr.attr,
> +       &rtrs_clt_cur_latency_attr.attr,
>         NULL,
>  };
>
> --
> 2.25.1
>
