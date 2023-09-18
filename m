Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9009C7A4F3C
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjIRQgT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjIRQgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:36:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38D77EFD
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 09:12:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso7329986e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Sep 2023 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695053566; x=1695658366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNeRgzhkotk5Y/tE9RyRgAf8MdMOlhQwnd3LC8e2DAY=;
        b=XcCLV4sYQnL44ikgWyyKPeKrMIWghokfjEMGjl/IbzW7bAY6bFfmnOgeORAPdRHQB3
         N2VLmfMvk3kvW2Dz8BayegOWKfZPLykroEKMGIx7E51C9+J7j5o9WHC4lvHm/YJhiAtG
         /LIW6D1sClBq4YpB2iJI37hIGY6yAjAaXCY8c7LAWkGyAtTXPMKbgsTWam9A2DBjEuL+
         fjEUvDJOS6O8pMHwR8kI0bNHmtGeh2ZBlxb57aPznL/CUSOXniJGmxs5NhbTTmPCQhSE
         L0m0JcCHXT9kf4rTKknhgXxlYjC6mpVNVqP+cIoct8yZMjpt8mmqgMsLd0TLVvJXG7mo
         el0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053566; x=1695658366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNeRgzhkotk5Y/tE9RyRgAf8MdMOlhQwnd3LC8e2DAY=;
        b=r8JDmz5bPKfzpZ6tBd86fYYuz+VatjNnnSZDIVPVDV6n6UlhOBuXdE+4JSTeiTBp1u
         Vbo6prlziA85V5l4g0grU2oEHHKUTZK2O7UYazvfT0tu8nasb7RWoEjiMPxlu+81t6xq
         15fMa3+Ka8c/eMDo0NhqN4MVcuf3UXf60R/j8Al8Z9Dr/CggOYvGBohEXbiyw6Jgyx+a
         E++sTdNwDC4P6Hme/4zPCueA2sVLHbJ7lPnVD1N6CGLFLpkE9Vrx0KS9aa18/8S5m5n+
         fAR5kyu7pGDOd7Zw2aqgeiI3OMSJXJeIiBZXfDnWP9S7yEoXS1mdbsP8WLFRpav5gvEK
         PQvA==
X-Gm-Message-State: AOJu0YxTgmOq1kNSJunjEhAqGUKQRrLC2Gs8T0Qt0HwEWsUHvWOO1BYd
        saKsw+f/OApL/hne79okDJSdmz8VnxpLFhwYl7Oh1N1hHDYe8zU/
X-Google-Smtp-Source: AGHT+IGhokwD4qvoQXRF2wkkb+TAXeuQ4G+9K+aki6Tse8F5xHhnZi3BwxH3GCI5AyoEhRggX6IIZI7IoUTMtdVBKDc=
X-Received: by 2002:a19:ca13:0:b0:503:afa:e79 with SMTP id a19-20020a19ca13000000b005030afa0e79mr3204137lfg.5.1695053566056;
 Mon, 18 Sep 2023 09:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230918153646.338878-1-yanjun.zhu@intel.com>
In-Reply-To: <20230918153646.338878-1-yanjun.zhu@intel.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 18 Sep 2023 18:12:35 +0200
Message-ID: <CAMGffE=UFTK8XkcZ-ugTN5CL0CgDDsERWnKaVk37+9wA6FtdqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rtrs: Require holding rcu_read_lock explicitly
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 18, 2023 at 5:37=E2=80=AFPM Zhu Yanjun <yanjun.zhu@intel.com> w=
rote:
>
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> No functional change. The function get_next_path_rr needs to hold
> rcu_read_lock. As such, if no rcu read lock, warnings will pop out.
>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Thx!
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index b6ee801fd0ff..bc4b70318bf4 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -775,7 +775,7 @@ rtrs_clt_get_next_path_or_null(struct list_head *head=
, struct rtrs_clt_path *clt
>   * Related to @MP_POLICY_RR
>   *
>   * Locks:
> - *    rcu_read_lock() must be hold.
> + *    rcu_read_lock() must be held.
>   */
>  static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
>  {
> @@ -783,6 +783,11 @@ static struct rtrs_clt_path *get_next_path_rr(struct=
 path_it *it)
>         struct rtrs_clt_path *path;
>         struct rtrs_clt_sess *clt;
>
> +       /*
> +        * Assert that rcu lock must be held
> +        */
> +       WARN_ON_ONCE(!rcu_read_lock_held());
> +
>         clt =3D it->clt;
>
>         /*
> --
> 2.40.1
>
