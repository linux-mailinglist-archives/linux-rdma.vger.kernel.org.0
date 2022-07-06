Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB2F568F53
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 18:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiGFQjv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 12:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiGFQju (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 12:39:50 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107AD1AD8F
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 09:39:50 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ck6so18996159qtb.7
        for <linux-rdma@vger.kernel.org>; Wed, 06 Jul 2022 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fa4nx9soOqKJibdgUXA8pSzFsCLLBXgJvJKDXcrmDzk=;
        b=BA8GuQ8o60halp6kBi7QCLJv4biXC2Sk6LIP173bmoCpH+CRvjWgPweOHCDR8gZnv/
         xZOVhdXXRlzHo6W0axc/t8HYfV1IfUgtbHvcHShSYkgPPbUvq8A6KlXXg6XUW2Mzwlug
         9O1QHpgR8DHgUbDVzp6juLKg41mOXdWAxCudDW2dq1g2z1PpS0BGW69g4ES/CXfmzhHo
         7Ie/6JCYmv3RaYgem8iQ5acl1jOk1p5gBbr4qSK8VJmH1yksI5jaaKZoWoL2bF2TeXP+
         0QXZU0uzp7KetFOsnDzlZC+nlJ8arV/00p9GFsxJWdzhwkJVoWJtoGE0P78JIT9VMlkx
         txpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fa4nx9soOqKJibdgUXA8pSzFsCLLBXgJvJKDXcrmDzk=;
        b=TcCPg8ROg6bKfWN+Sv4EKIlKNEfgR3iej3Qb1i/leoN8x1FbsGSFJvszc3ZGPCCyo4
         FkZKF0qb5MZHZ0VWZl9Ko0bG446ciJCHBQfMvDPN0+vN1jkr2qCkf80ch5Puh8xWuMwH
         DPAPJc99soGBdRvCB0VbB2Q6I2FEq/dEgPltsDOxj9F30ElYnsMoRE4HHPEaLv+H9z1a
         RP9jNGCJ4xvi3WoFXKEewNnzqZwlrvC0kUOQLknGG76qA3DLuOzrvhCAEzKsaduv9jy0
         JwtLBuiJ7jS07uH6i5SEQEpTufdPB7UgUNdlWfhUqzx82Z9qdT8NwV+44WiMNIrTYJum
         mhsw==
X-Gm-Message-State: AJIora9BL0uRVUZBWdre6iyjGPXudipr2fG4l850VpLWJfscwtgNZNt3
        CKSHDpLzEbknnNTUIMMUQDRZ/w==
X-Google-Smtp-Source: AGRyM1tnYQbvpUd2z7uxCRh7AGVvPT6cQJUaz6AV/kKTVRPPtLVvKqtV/Ro2E17qaLyu4IlL3SlIVg==
X-Received: by 2002:a05:622a:1449:b0:31a:daa0:e0b8 with SMTP id v9-20020a05622a144900b0031adaa0e0b8mr33777651qtx.539.1657125589216;
        Wed, 06 Jul 2022 09:39:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q15-20020ac8450f000000b003177f0fb61esm23581858qtn.75.2022.07.06.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:39:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o9844-00772H-1e; Wed, 06 Jul 2022 13:39:48 -0300
Date:   Wed, 6 Jul 2022 13:39:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: For invalidate compare keys according to the
 MR access
Message-ID: <20220706163948.GL23621@ziepe.ca>
References: <20220629164946.521293-1-haris.phnx@gmail.com>
 <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <20220629184432.GW23621@ziepe.ca>
 <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <CAE_WKMzMi7A5qYp71ez=4E1BxcUNYCDeYq4DmFjxWMoHYRusAA@mail.gmail.com>
 <20220705135959.GG23621@ziepe.ca>
 <CAE_WKMxGZqa-GDxLQ1fG9icCjGyXK=cvu8xtrLym2oxPuo559Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE_WKMxGZqa-GDxLQ1fG9icCjGyXK=cvu8xtrLym2oxPuo559Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 06, 2022 at 05:41:08AM +0200, haris iqbal wrote:
> On Tue, Jul 5, 2022 at 4:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jul 05, 2022 at 11:28:59AM +0200, haris iqbal wrote:
> > > On Wed, Jun 29, 2022 at 8:48 PM Pearson, Robert B
> > > <robert.pearson2@hpe.com> wrote:
> > > >
> > > > > > > If the rkey's and lkeys are always the same why do we store them twice in the mr ?
> > > > > >
> > > > > > They are not always the same currently. If you request remote access they are the same if you don't rkey is set to zero.
> > > > > > You could, of course, check both the keys and the access bits but that is not the way it is written currently.
> > > >
> > > > > Storing the rkey instead of checking the flags seems like a weird obfuscation to me..
> > > >
> > > > > Jason
> > > >
> > > > One always has the choice to always just use the lkey and check the flags. But referring the rkey just uses one memory reference 😊
> > >
> > > Have we reached a consensus here as to how to solve this?
> > >
> > > This (and the issue created by dual map) has basically caused a
> > > regression in RTRS since the 5.15. And we would appreciate it a lot if
> > > the fix goes in and is backported.
> >
> > I think your patch is close, it should just be tweaked a bit.
> 
> I couldn't conclude from the conversation above what that tweak should
> be, if a conclusion has been reached. If not, then I'll wait.

The 'rkey' input can be an lkey or rkey, and in rxe the lkey or rkey
have the same value, including the variant bits.

So, don't check based on the flags, if the rkey is not 0 check it,
otherwise check the lkey

Since we already did a lookup on the non-varient bits to get this far,
the check's only purpose is to confirm that the wqe has the correct
variant bits.

Jason
