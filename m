Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC94C7319
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 18:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiB1RcR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237171AbiB1Rbz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 12:31:55 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD2788B2A
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:28:56 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id k15so5496056vkn.13
        for <linux-rdma@vger.kernel.org>; Mon, 28 Feb 2022 09:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3wpyOwuQhUGOIHIN+zR0Hn0TGtOWST/DTDZ6clNiLOk=;
        b=moTyxZTKd7QWIuAWyaSP6Y2A4nusSZkXYzpPHRzQS8bLv84a1yhXuqX7cJD71hwuOu
         f/o/s4yBgcSguSb8WM2aQbJHEPRes6Bl3R1cW+MRV5H2CvRFtPISt18+hUp42PNjr0tp
         MIThAcdlltk8UolzMSs2JmkPppSOR/t5fz8p57r20n0NHrpBLGlr708iWAo2KejhExH+
         DF3DkAL35yo8akJcrrFM1Uhq0waZNJoryj1ixyL0372tXxJomgh+yhkVSUyJiF+gf1Za
         eHCKt/FipFSAbI8gIZdge/QcD/ET5B1JwwDmPSMDK16AU0ZF2/4bKOVMh7U7H0c9OKU6
         hZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3wpyOwuQhUGOIHIN+zR0Hn0TGtOWST/DTDZ6clNiLOk=;
        b=Qm1AdSWXGqJFwh+dmpfbAl+I6m0xnzfs7LmeXM5SLxRKQk994f0Y/WzWHgZod3EG3e
         r7P4/ubq1iu5mNrbPTxwrFzmqs6G/BLEyjeMWytLE4JixC4XHMlqH76b9XGHxC0ZqJxd
         z1W2jlNQkKmI4w0RJ+ncS72PLe2XBWSsAFvqLVTf1jD9XgxLoOEIkH0LspuyxG1xxDAY
         1m/BhdD9+bMelDB/E9xeKLuf0RGsv8457ljSfpHw505yV5BXPxOK7nBHmK+V/WbKDXIJ
         p7z3l3HPtbLq0oQbeNLo8xpBoPeNOPQt1snL4tQsiUrXdc9vRFVxVRcasagp/VBg2Rgv
         oXUw==
X-Gm-Message-State: AOAM530bXZsbs+OeBNJoazcBfLhYZHnGtigPXPHmY4D4XCmNV0na2SCJ
        qowr4JGPm/7VOzY5oOfAR2v09d027xz1akD7Prc=
X-Google-Smtp-Source: ABdhPJwvYhw5YOvgxLsGuTe1QAbsOPqbHe6iFA22tIQJIvZuGnNXbYX69AjBBPB5iqGy5DvOgcEU1g8NVPSRwsq3wVM=
X-Received: by 2002:a1f:3244:0:b0:332:2037:83b1 with SMTP id
 y65-20020a1f3244000000b00332203783b1mr8557346vky.24.1646069335225; Mon, 28
 Feb 2022 09:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20220225195750.37802-1-rpearsonhpe@gmail.com> <20220225195750.37802-5-rpearsonhpe@gmail.com>
 <20220228165731.GI219866@nvidia.com>
In-Reply-To: <20220228165731.GI219866@nvidia.com>
From:   Robert Pearson <rpearsonhpe@gmail.com>
Date:   Mon, 28 Feb 2022 11:28:44 -0600
Message-ID: <CAFc_bgasCdwwb6C79cwsHVPv5tw+Sk+vJfe38M0OGbzCaMhv+Q@mail.gmail.com>
Subject: Re: [PATCH for-next v10 04/11] RDMA/rxe: Replace red-black trees by xarrays
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a xa_lock_irqsave()/ublock_irqrestore but I actually need
some things that they don't support.
In particular there is not an option to call xa_alloc_cyclic_irqsave
and I also need an irqsave version
of kref_put_lock and had to code one which calls the refcount version
but again that takes the address
of a lock and not an xarray. All this is because rdmacm is crazy and
makes verbs api calls with
spinlocks held.

Bob

On Mon, Feb 28, 2022 at 10:57 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Feb 25, 2022 at 01:57:44PM -0600, Bob Pearson wrote:
>
> > +void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
> > +{
> > +     struct rxe_pool_elem *elem;
> > +     unsigned long flags;
> > +     void *obj;
> > +
> > +     spin_lock_irqsave(&pool->xa.xa_lock, flags);
>
> You can't reach into the xa_lock like this, use the xa_lock()
> family of functions instead, everywhere.
>
> Jason
