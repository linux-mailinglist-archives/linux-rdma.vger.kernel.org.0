Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA96571331
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiGLHgR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiGLHgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 03:36:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DFF9A5DA
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 00:36:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g1so8971808edb.12
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKYWNjh6uS7sTcTxXh7MYPjOwdPod5IfYnOYmMhizzw=;
        b=J/Akhho9DdDvcMHcxp/1MI5y11ssV3+kQiBBJIODFpa7HR98CLbPtt3KNQydQU3Zv8
         UQaqXJr9JRQi0jPK8vxh9iIOcekB7Onz+ojbeLgi+BEk1feIds7Xz9fRVXp9BAR4Ld54
         GWeZCWrHWFTdX53VRCh0Mlm1U5t/SJmwZo+1HLbi3YzEmpXrahpz0t+f4dkUrQuvpEJf
         t0ThS4LFd0keYvtiAbNiHxDBej/BJIWetvJ0bu8mLw18+pQPboKJBkyC5fdqwlPCusBi
         uxXlOlPybMTIO0EzWQWeCoDK7S1REhsUlo+Fp8WAcbZ9MrLk91TSeLq/Y/c6ssgc8oiQ
         BXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKYWNjh6uS7sTcTxXh7MYPjOwdPod5IfYnOYmMhizzw=;
        b=lAnUTzCUaTiMiUpyWgnjJplUS2LlY59PXPfEYSixFYPrUoxX9QeVFIkUfIXcnJSOsZ
         45MtZps1qaQMtlJ+FwoYB4DhRoIkbxTXF+5SUa2Kup0IC/wsbZCvekY/jFaVGYFXjtiT
         eIt6R9anBF8kPJlgXezNfCQJs4jtm9CKs6HJonAQ4sh4pqBe/QouDa4hvl9Dan6Ee6QP
         Chwy/ILRSIXmMuo1ODSGopZ8hoEETqEl9fp9joPFiNisodcAUpC5ymmtwDgVNVlCV8QA
         CNUt0P13ZyRlPlHUb2bKVNtLjjAOutUqdX9yBcvWoesqXmrXGZam81EW4DErJjFSackK
         6wLQ==
X-Gm-Message-State: AJIora+DUyFFo0SNqQUs47d3xh+krpnDRRoFIZwcxSizA9lDOu4/8/Sc
        zgObzY6YndhyT1jWxfexU+l1m45amta+K0WbEU2hVw==
X-Google-Smtp-Source: AGRyM1t7gImuKNQDmSwDAD41VRaAgOv1rOeX0d41mqN/rjlwYLDZw7SHgWob8b9hjtJPT1bc+HASJ/7eu9zL0Zcqkhc=
X-Received: by 2002:a05:6402:42d5:b0:433:1727:b31c with SMTP id
 i21-20020a05640242d500b004331727b31cmr29924926edc.9.1657611373846; Tue, 12
 Jul 2022 00:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220707142144.459751-1-haris.iqbal@ionos.com>
 <20220707142144.459751-6-haris.iqbal@ionos.com> <20220708133200.GB4459@ziepe.ca>
In-Reply-To: <20220708133200.GB4459@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 12 Jul 2022 09:36:03 +0200
Message-ID: <CAMGffEnL+kG8=jtqxYCi91-kcmesVq_A5NSjh7NnNqAZH=vRiw@mail.gmail.com>
Subject: Re: [PATCH for-next 5/5] RDMA/rtrs-srv: Do not use mempool for page allocation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Md Haris Iqbal <haris.iqbal@ionos.com>, linux-rdma@vger.kernel.org,
        leon@kernel.org, Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 8, 2022 at 3:32 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 07, 2022 at 04:21:44PM +0200, Md Haris Iqbal wrote:
> > From: Jack Wang <jinpu.wang@ionos.com>
> >
> > The mempool is for guaranteed memory allocation during
> > extreme VM load (see the header of mempool.c of the kernel).
> > But rtrs-srv allocates pages only when creating new session.
> > There is no need to use the mempool.
> >
> > With the removal of mempool, rtrs-server no longer need to reserve
> > huge mount of memory, this will avoid error like this:
> > https://www.spinics.net/lists/kernel/msg4404829.html
>
> Use only lore.kernel.org links please

Sure, will fix it.
>
> Jason
