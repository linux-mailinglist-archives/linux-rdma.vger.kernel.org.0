Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F87AF78C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Sep 2023 02:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjI0AyC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 20:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjI0AwB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 20:52:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A305B212A;
        Tue, 26 Sep 2023 17:09:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-405361bb949so107665975e9.1;
        Tue, 26 Sep 2023 17:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773381; x=1696378181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6IH4cIf/YUQbm0f3DbgR+Cr/DgsuA+viBGblpNrbFk=;
        b=MsJBCV7wBWWUYJ91j18qO0dCJ9/I0x0WHIOPldnjmyo9QpbCBZy7V2qvWmW6n6JmJQ
         /y80co0CgedCX0MijySHp0UCBenxGMF4r8iQJsxy/55Ef+Ky39m/5Coz51kBTCMemT+z
         Tv2rAJaq6tQWgBvFM8ALNzXGneTC8EIWpeRY+dAb8HO/7ua2HzfE4UvqINB/UopQIMTJ
         a8PvW8NnAdcQe+O7InQQZlEd0Iy1bnQpSjja3CtI5ALbyO6hKV+QGKDbHaZzoLRy9964
         JsRRcCt0b4oL7WVx03d8BdcQ73Al4mHqoysRIOtDojOj3hq+R61fLIwXC8dgX65Ms0Zj
         fWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773381; x=1696378181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6IH4cIf/YUQbm0f3DbgR+Cr/DgsuA+viBGblpNrbFk=;
        b=D9fN/VfwDOjVvkdQrFBimBfSDzJ4AZBNnfEnEXWs8tUX4t8xWDOafGM5nbm3ywrtRU
         XFmVaGQ12UUbdUtVqLGMapoaI09kc0cwuYR3s7ZYfUx1gBg4WBy29pJzuSiJsb4LGER0
         t7NWh5xZEBT5lGS94yTnA/74FCv3ipDmS98sb2y0aHYIdXf2x8ZstlAzJyXmAP8cnott
         8knQK1ExLx5ocTKHCWJmSQcyZYOTL3GVlZUboLsvzr37IAat4i7oTjEwyIYrroYLGZLA
         xkDsCJih8DJZrRiMKuAuClw81kiVELOZmR4XUh6KGfY8i154l3Mt4FiOTbHdklt4RrJ8
         gPxw==
X-Gm-Message-State: AOJu0YwCj6gw3ZRR/2H+qnctbSvQNK2GsCQ54lMzDa8RKhrCZLVnK25m
        60+GcUKtZ/exGAOu/8+A1cSXGMMOXqx8hW3DlfwkWDhizEs5LQ==
X-Google-Smtp-Source: AGHT+IGaXPrvF+GuvM4qEASaLaiHb3SJbSTTjbzf4ykGiL7cgsFzVbhUrDL1HHWD8/28DSQM9J39SMQWqZcY1o84Dk0=
X-Received: by 2002:a5d:6782:0:b0:321:65f3:4100 with SMTP id
 v2-20020a5d6782000000b0032165f34100mr181669wru.7.1695773380830; Tue, 26 Sep
 2023 17:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230922163231.2237811-1-yanjun.zhu@intel.com>
 <169572143704.2702191.3921040309512111011.b4-ty@kernel.org>
 <20230926140656.GM1642130@unreal> <d3c05064-a88b-4719-a390-6bf9ae01fba5@acm.org>
 <b7b365e3-dd11-bc66-dace-05478766bf41@gmail.com> <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
In-Reply-To: <2d5e02d7-cf84-4170-b1a3-a65316ac84ee@acm.org>
From:   Rain River <rain.1986.08.12@gmail.com>
Date:   Wed, 27 Sep 2023 08:08:50 +0800
Message-ID: <CAJr_XRBcxkdXvzshntDtE9vnLnPzqHCKHxspjw-uKizSYT1HFw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe tasks"
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        matsuda-daisuke@fujitsu.com, shinichiro.kawasaki@wdc.com,
        linux-scsi@vger.kernel.org, Zhu Yanjun <yanjun.zhu@intel.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 27, 2023 at 4:37=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 9/26/23 11:34, Bob Pearson wrote:
> > I am working to try to reproduce the KASAN warning. Unfortunately,
> > so far I am not able to see it in Ubuntu + Linus' kernel (as you
> > described) on metal. The config file is different but copies the
> > CONFIG_KASAN_xxx exactly as yours. With KASAN enabled it hangs on
> > every iteration of srp/002 but without a KASAN warning. I am now
> > building an openSuSE VM for qemu and will see if that causes the
> > warning.
>
> Hi Bob,
>
> Did you try to understand the report that I shared? My conclusion from
> the report is that when using tasklets rxe_completer() only runs after
> rxe_requester() has finished and also that when using work queues that
> rxe_completer() may run concurrently with rxe_requester(). This patch
> seems to fix all issues that I ran into with the rdma_rxe workqueue
> patch (I have not tried to verify the performance implications of this
> patch):

In the same test environment in the link
https://lore.kernel.org/all/4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com/=
T/#m3294d00f5cf3247dfdb2ea3688b1467167f72704,

RXE with workqueue has worse performance than RXE with tasklet.
Sometimes RXE with workqueue can not work well.

Need this commit in RXE.

>
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c
> b/drivers/infiniband/sw/rxe/rxe_task.c
> index 1501120d4f52..6cd5d5a7a316 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -10,7 +10,7 @@ static struct workqueue_struct *rxe_wq;
>
>   int rxe_alloc_wq(void)
>   {
> -       rxe_wq =3D alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +       rxe_wq =3D alloc_workqueue("rxe_wq", WQ_UNBOUND, 1);
>          if (!rxe_wq)
>                  return -ENOMEM;
>
> Thanks,
>
> Bart.
