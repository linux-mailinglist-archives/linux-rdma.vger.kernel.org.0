Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77176FDB32
	for <lists+linux-rdma@lfdr.de>; Wed, 10 May 2023 12:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjEJKAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 May 2023 06:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjEJKAN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 May 2023 06:00:13 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D982219BC
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 03:00:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f386bcd858so22088281cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 10 May 2023 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683712812; x=1686304812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuQHaDc9ufi5244OqqGVdt/icJozNR6C9vCa8HUQp70=;
        b=Ie3xWbIeF0coQ8cfTfRafwfCuha5tVqCCHWSBAPuFsLJg0UL3AdhbH0SJbnAH39G0m
         rzrT0tziUZvxETJwwlUAh1KNYxFlpSx0rVHKBfxxx2lq1iQfG95XPRoJGC2gBjtoOsoI
         PNHECZqTY8wCQSe4HEmYjeOo4mwnnIT4i3b+b5LL6FSwisk1GZhWWduRN+gwdE3AFy/r
         l/Q7huJ5KbX4yQv4N8Rb86WNhcp2oIntofKifpyVHlEowilhqLL59nNvzsaZsk+67HWA
         6RVzoqeMsrjCHXKSIp0kSOnzZ/mSTPxSlUfPXBaaoYTK/3v5Emuq7ECei+hWhlreJ6Bh
         OmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683712812; x=1686304812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuQHaDc9ufi5244OqqGVdt/icJozNR6C9vCa8HUQp70=;
        b=FyBbm6/d2XThy646HtGO2eUXkHcDRfPVdEJ/Ndt1/uRvxSkzoAAu6BpMe8qSVn4lM/
         SHFtW/lXyHELA1qnsw89ZwIqaiKTuoPppqfAEkhl3ZCb7iuRr4HLY6RJk+upEwSm+REs
         FAfO6RsTJoD+AKGvH7lNbQphsjK0Orak5+P4cOf/JC7pnkpETUw9PlVPqHsbdCXyAjcx
         xFYpf/D2uPP/mSdzTMotS/4uN+16UBtehrNC4c96aYG070e1eas+2XBhvnwtMuzihWt4
         DmT8QDxSWgaLoxe4SH0pfE28HfuoOyfxv6A95h/Ry0j29mkBPuSZttu5aSvkidm7fNNL
         hxrA==
X-Gm-Message-State: AC+VfDyUBeUrBBhDBFvIRbQssRFELbAsk0jsigT3rQCVz2n3iepkGkpg
        DOFX3hjlfddNbsOEySFMPSjun6fUvRNtnQ9tGfo=
X-Google-Smtp-Source: ACHHUZ7AbRxMvtKsEZt5v1Epiw8ZLy0XoMH3JPhjaF+2ZgFy7u7LjG/Vs2v9KmaqF0yzuz+RJJFQEWIh0/kfEjOCy5c=
X-Received: by 2002:ad4:5ced:0:b0:621:404f:9c93 with SMTP id
 iv13-20020ad45ced000000b00621404f9c93mr6627097qvb.40.1683712811669; Wed, 10
 May 2023 03:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230509095016.112453-1-animesh.kishore@gmail.com> <20230509133727.GJ38143@unreal>
In-Reply-To: <20230509133727.GJ38143@unreal>
From:   Animesh Kishore <animesh.kishore@gmail.com>
Date:   Wed, 10 May 2023 15:30:00 +0530
Message-ID: <CALNrABWfN0sszDNNv0YwQ5VS0Yv07PW5no=aZSxZOCFUu7N7cg@mail.gmail.com>
Subject: Re: [PATCH] verbs: Add RDMA write RC pingpong test
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, jgg@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 9, 2023 at 7:07=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, May 09, 2023 at 12:50:16PM +0300, Animesh Kishore wrote:
> > - The test pingpongs data between server and client
> > instance using RC QPs with RDMA write BTH opcode.
> > - For RDMA write, there's no completion at responder. Hence,
> > we send a sideband ACK(using socket) from requester side
> > on completion. This indicates to responder that it has
> > received data.
> >
> > Check available test arguments and help:
> > ./build/bin/ibv_rc_wr_pingpong -h
> >
> > e.g.
> > Run server instance:
> > ./build/bin/ibv_rc_wr_pingpong -g 0 -d <ib_dev> -c -s 8192
> >
> > Run client instance:
> > ./build/bin/ibv_rc_wr_pingpong -g 0 -d <ib_dev> -c -s 8192 <server IP>
> >
> > Signed-off-by: Animesh Kishore <animesh.kishore@gmail.com>
> > ---
> >  debian/ibverbs-utils.install         |   2 +
> >  libibverbs/examples/CMakeLists.txt   |   3 +
> >  libibverbs/examples/rc_wr_pingpong.c | 782 +++++++++++++++++++++++++++
> >  libibverbs/man/CMakeLists.txt        |   1 +
> >  libibverbs/man/ibv_rc_wr_pingpong.1  |  63 +++
> >  5 files changed, 851 insertions(+)
> >  create mode 100644 libibverbs/examples/rc_wr_pingpong.c
> >  create mode 100644 libibverbs/man/ibv_rc_wr_pingpong.1
>
> Like I said in relevant PR https://github.com/linux-rdma/rdma-core/pull/1=
325#issuecomment-1531194836
> This new ibv_rc_wr_pingpong is unlikely to be merged.
>
> Thanks

Hi Leon,

Do you suggest to wait for more comments or close the PR at once ?

I think it's helpful for new users for below reasons.
Helps demonstrate complete flow and API usages. Works as a reference
to build IBverbs production applications which are typically in C/C++.

Also note, it's an overkill to extend existing example/rc_pingpong.c
(uses send/recv) to support RDMA write.

Thanks
Animesh
