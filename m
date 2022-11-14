Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D5628171
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Nov 2022 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiKNNgV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Nov 2022 08:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbiKNNgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Nov 2022 08:36:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC518E0D
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 05:36:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id be13so19311126lfb.4
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 05:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W5Myml/aSlr94xt+EGK+OgldqZY/JRzPirAi8hHbabI=;
        b=VTfe3R49uJxjZued/ZSof8wwGXvrjHlinZ48wx6B0Nmz46fqWSU4y7Sw04gB/fVM2g
         VgrQQ3XoHWeSDRU5UGf7MXt0h0tXtj5Y17gpJ+qC+QEU7lLpJZo2P1PTOP49TWjK3NrU
         wZY4+KJUN5EPoowdlWH92tM4qwgfYN120+rmDD5MExdXfj5m9FpZ3DzPR0/cxMRWJSZU
         4MjFXrMGwQQc+lI0JxsO8DvFXv6e4aMdrcu1QzL/1KMWTOQoqOpaW+feTmKjs7NTjsUO
         5ZnRCchRbHhHqMY9FVNkPjVa1MvSM6rj0xnz9foRoVvJ+NsvOXrsCnFFRlDFXSBzDBzc
         WE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5Myml/aSlr94xt+EGK+OgldqZY/JRzPirAi8hHbabI=;
        b=OXNcafqiG5FFj5+VIYkni37KKTmk2Q+G/fQrDROMWTS90LCSxLVx8mzGmD3zpDfWrI
         vZiHpSzDBUhDMPo/BXg+GyB+v5ejUxQI3xQn/PWcl3xP9C5UBqRkJpjeGpkAWpS9gW43
         wyw7z7iy5GMX3TNtFr8orFo0BGf2K6MCDyYtVCS/ctiS0HvlVlfgn0+Q4g2uYPxX2Pqd
         1L8H/QhHOviGvmgU9EFCqLgPnX5eqhRIc7CNCJ4wmSs6bFOFxNDtZuXShzMHOyxwwRQS
         9ghsJ109HpSlfhvIh/8BEQ+J5Dv4B5MeIiypM7g5VAGOSv31PBMoRPjHF9/zK5WmWV6b
         WA8w==
X-Gm-Message-State: ANoB5pkZFu3ZuAS+dVkvXsNm0XWAqmzKl28DAr46kB8IE+tCBrmVl+AP
        ZCy+KRCkTpQam9aIOa0XiFJRdopJ7qzISKSbIPKCYw==
X-Google-Smtp-Source: AA0mqf6S7aYbH0Px6BWBAEsnrVgBJT4a5dV390HMJl/vNfTlCj1zpZ1cAozbvBGNBGM++5uNVnzVpISmHZNhDQI/qic=
X-Received: by 2002:a19:2d1e:0:b0:4a2:b56c:388e with SMTP id
 k30-20020a192d1e000000b004a2b56c388emr3959305lfj.145.1668432972572; Mon, 14
 Nov 2022 05:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-2-guoqing.jiang@linux.dev> <CAMGffEkJ-3rodi1EJ=nouhcXdxB2AJ8qP2RyirxXyg=6HnakaA@mail.gmail.com>
 <82038928-59fb-e857-1855-1831252f4a88@linux.dev> <CAMGffEn4eUrSX-v3Dr-iOD_LOFvqneGDYCuvAgqpTYBZTDFRYA@mail.gmail.com>
 <2b99778c-9819-adc4-59fe-c8023c932247@linux.dev>
In-Reply-To: <2b99778c-9819-adc4-59fe-c8023c932247@linux.dev>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 14 Nov 2022 14:36:01 +0100
Message-ID: <CAJpMwyiQcMWqaLNuGvDJ2DJhrAR8R3Ac97pJ4rc=xiKVppN5tA@mail.gmail.com>
Subject: Re: [PATCH RFC 01/12] RDMA/rtrs-srv: Remove ib_dev_count from rtrs_srv_ib_ctx
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jinpu Wang <jinpu.wang@ionos.com>, jgg@ziepe.ca, leon@kernel.org,
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

On Mon, Nov 14, 2022 at 9:45 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>
>
> On 11/14/22 4:24 PM, Jinpu Wang wrote:
> > On Mon, Nov 14, 2022 at 9:00 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >> Hi Jinpu,
> >>
> >> On 11/14/22 3:39 PM, Jinpu Wang wrote:
> >>> Hi Guoqing,
> >>>
> >>> Thx for the patch, see comments below.
> >>> On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> >>>> The ib_dev_count is supposed to track the number of added ib devices
> >>>> which is only used in rtrs_srv_{add,remove}_one.
> >>>>
> >>>> However we only trigger rtrs_srv_add_one from rnbd_srv_init_module
> >>>> -> rtrs_srv_open -> ib_register_client -> client->add which should
> >>>> happen only once.
> >>> client->add is call per ib_device, eg:
> >>> jwang@ps404a-1.stg:~$ ls -l /sys/class/infiniband/mlx5_*
> >>> lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_0 ->
> >>> ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.0/infiniband/mlx5_0
> >>> lrwxrwxrwx 1 root root 0 Nov  8 13:49 /sys/class/infiniband/mlx5_1 ->
> >>> ../../devices/pci0000:ae/0000:ae:00.0/0000:af:00.1/infiniband/mlx5_1
> >>> rtrs will be call twice for  mlx5_0 and mlx5_1 devices
> >> Ah, yes.
> >>
> >> But still we can only load/unload module once, I guess it was used to avoid
> >> racy condition (concurrent loading/unloading module?), could you elaborate
> >> why it is needed?
> > The change was introduced due to  a bug report, you can follow the
> > discussion here for the history and reason:
> > https://lore.kernel.org/linux-rdma/20200617103732.10356-1-haris.iqbal@cloud.ionos.com/
>
> Thanks for the link.
>
> I probably missed something but I don't know how rnbd_server module can be
> initialized before cma module since we have the dependency chain as
> follows.

Hi Guoqing,

One of the ways this was happening was, when one builds the RNBD/RTRS
module into the kernel bzImage and then boots up the kernel. Depending
on the module init sequence, if the RNBD/RTRS modules are picked
before the RDMA one, then this issue would hit.

With the changes, RNBD/RTRS just register itself to ib. If any devices
are present at that moment, for example when the module is modprob'ed
later into the kernel, then .add gets called through
ib_register_client. If no devices are present, for example in case if
the module is built into the bzImage, and is inserted before RDMA
module, then ib_register_client simply registers RTRS, and returns
without calling .add
Now, when RDMA gets initialized, and it detects devices, then .add is
called for each device, which will land into rtrs_srv_add_one

>
> INFINIBAND_RTRS_SERVER depends on INFINIBAND_ADDR_TRANS
> BLK_DEV_RNBD_SERVER depends on INFINIBAND_RTRS_SERVER
>
> But commit 558d52b2976b ("RDMA/rtrs-srv: Incorporate ib_register_client into
> rtrs server init") did mention this.
>
> "and if the rnbd_server module is initialized before RDMA cma module, a
> null ptr
> dereference occurs during the RDMA bind operation."
>
> Thanks,
> Guoqing
