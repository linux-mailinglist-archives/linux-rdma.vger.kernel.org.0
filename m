Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A362777A
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 09:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiKNIY3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 03:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiKNIY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 03:24:28 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4200763BF
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 00:24:27 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a15so12156442ljb.7
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCLrvp19OQN823AHiYgg/dxohAqLmX84+nMFwA5PtNA=;
        b=NEZM/Y9RyhQ9ann7t94Noc5ZwQro+OHB9TVz6Jz3AZAz5XMK3svOcfLKq9PLjQPKKU
         3pNUkp/EVWLuN1jMax/qvbP/x5SVD5kuF2kw2FHI4lDDrtlu7+La412KF9ZfeSMbvf28
         TG2q0vMeQCFj6cbegLwaVFhR5XWLzDya3oQn6DeH5dj1bQUUxOqrWXDvctsT2GQ6r1AC
         qHVmAI/w222kvOGQ6u/L6zCKZcl22GTx13HRWaP5H9l+w806Zx44zu1Q9nQmGRtMrMD9
         kY6r0EWBmlewhUmUUNp6g11v2RzyD6ZbF2HsCM8h3/Jbjfa1MmODKEothlHRshw6f0OY
         /H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BCLrvp19OQN823AHiYgg/dxohAqLmX84+nMFwA5PtNA=;
        b=4AQfhCtfoZoAWU8pdJT1NMP48xgVmmujSTQjDkcqi5WgyvBG+P4CztQ8Y4UOl7vXyz
         oCXJ0fWygFf3YIZAqfibnzmRBRyE5jOay7oracXnHoGx2JI9F13nN39szoZ4zOBhX8gs
         3xiu1Botoxkkmvgs9+/U7BJqd/ZsIa3WaFV3xaifesmSIbSkoUao5zlsVprekrQw/q9u
         gqcOoYOogEWJ3S4owy2d0k9xuCEF5a6Tyubt94ycz01kCUdFDRPuc5kd0cJhlB3UNcpL
         FNdDesyFCk/kYhVXuj8TnN6AMoeNFrCRIWoNZPr+Qz6iQ8iGX1PIKBWTgZT33TbWwpNc
         bw+w==
X-Gm-Message-State: ANoB5pksS6ev69j2cmQqQkCZ69v/xwlgx8J/FzuW8pRqFvCnhVbr3Bqr
        Hhp/Gak5ZFaVD8jQ5uJUSSvPEZl9bkL1uwUDcmXfJ3PAkJ/Pog==
X-Google-Smtp-Source: AA0mqf79ot5qmRkPXdH+NsIs7fZAqjeEV9g11uqGfTLadqVWSNSzSaH2IVJSNzu5t8LaiHLv3gAUVKXE2JkeoAUw18A=
X-Received: by 2002:a05:651c:8b:b0:26d:d196:d04 with SMTP id
 11-20020a05651c008b00b0026dd1960d04mr3947238ljq.403.1668414265500; Mon, 14
 Nov 2022 00:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-2-guoqing.jiang@linux.dev> <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
 <82038928-59fb-e857-1855-1831252f4a88@linux.dev>
In-Reply-To: <82038928-59fb-e857-1855-1831252f4a88@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 14 Nov 2022 09:24:14 +0100
Message-ID: <CAMGffEn4eUrSX-v3Dr-iOD_LOFvqneGDYCuvAgqpTYBZTDFRYA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jgg@ziepe.ca, leon@kernel.org,
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

On Mon, Nov 14, 2022 at 9:00 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Hi Jinpu,
>
> On 11/14/22 3:39 PM, Jinpu Wang wrote:
> > Hi Guoqing,
> >
> > Thx for the patch, see comments below.
> > On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >> The ib_dev_count is supposed to track the number of added ib devices
> >> which is only used in rtrs_srv_{add,remove}_one.
> >>
> >> However we only trigger rtrs_srv_add_one from rnbd_srv_init_module
> >> -> rtrs_srv_open -> ib_register_client -> client->add which should
> >> happen only once.
> > client->add is call per ib_device, eg:
> > jwang@ps404a-1.stg:~$ ls -l /sys/class/infiniband/mlx5_*
> > lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_0 ->
> > ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/infiniband/mlx5_0
> > lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_1 ->
> > ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.1/infiniband/mlx5_1
> > rtrs will be call twice for  mlx5_0 and mlx5_1 devices
>
> Ah, yes.
>
> But still we can only load/unload module once, I guess it was used to avoid
> racy condition (concurrent loading/unloading module?), could you elaborate
> why it is needed?
The change was introduced due to  a bug report, you can follow the
discussion here for the history and reason:
https://lore.kernel.org/linux-rdma/20200617103732.10356-1-haris.iqbal@cloud.ionos.com/

>
> Thanks,
> Guoqing
Thx!
