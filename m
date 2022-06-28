Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE8355EA4B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 18:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF1QxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jun 2022 12:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbiF1Qv0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jun 2022 12:51:26 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC915F42
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:50:49 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id z1so3603757qvp.9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jun 2022 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jTjiYkWQ6spKZZJ7AKBPlFLkZ9ROQGMaa/WVFdW9qPc=;
        b=hI3/YqpPGkso3Sdry6qxOR46oX06VkVAF7LIMxFF4gl/T9L8mIZUzJaL+RXjLRSaz0
         FU4XHIwXN82mnCgG2FX/L7TaC45AC5B3SJHsAZ0jCJxvvg0V0L7srZbJbGLpVHR0B9jy
         XLAf0E7gqrepEwCzDMGNqyHr1sUh7v/1JcZC8ZwrUbnW7r+MDuF2ilSdH3a2/ddggXB2
         x40Ajg0s1Rgx223ytZJExIS4Fv1n+CUnbeFwj7LrlyktmcUtutNgSnuSvkCNGA3wd3jV
         uXKK7x8u0s+yjxwaAj3e8HIFUIoHfDc2nUxQNrpQ8iVidAGup02n9z5wmswCMyz7akeN
         iuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jTjiYkWQ6spKZZJ7AKBPlFLkZ9ROQGMaa/WVFdW9qPc=;
        b=XhXJoB3Ysx+LdPvqtKK9nZLRjQvXSKbjj1kJU+JcmlumANSb/lxkNXjKUFYGJdjMQd
         TtgmCbpk3psZEegEwtGO8S6RJXxyVpX+YWuP6EPbxRoTIGCw6QnoQ6KfbHp0C6RhWKOv
         Gc6ye2x+ScEGoQqMI+tScBC0qpzIRgUH/ikhLD5Qj/m+G7nF0ux1+Hd0hvlw2QHHtPZ6
         E21OVMpjTijSR/SX08QWo5Ro2ljrgY+tsA4GN4vLyL0L92OPko4n1ziGZFc7HZBSpAAk
         4EdFuMaJU+Ok/Nudr05LCGMr+w4sQ6scQYpNN6kbAST75KLQDyn+GtkupkuBKmLVjnPr
         aKUw==
X-Gm-Message-State: AJIora8da/Gq0z/UMGlhxyp1rF0nY/HQgkW+RhtLVxT4Tid97D+oTwxa
        dITx2l18a+8iDLxjt7dcD1T3FA==
X-Google-Smtp-Source: AGRyM1sTrh8aXBOrg8WZpWwNPCXxL2XcVBDC4aGXxaGZcctmD6+xljnNQsrg8d5RVdd5w8VrbyVa3Q==
X-Received: by 2002:a05:6214:da8:b0:472:9358:9d9b with SMTP id h8-20020a0562140da800b0047293589d9bmr2118666qvh.94.1656435048991;
        Tue, 28 Jun 2022 09:50:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id ci27-20020a05622a261b00b00316dc1ffbb9sm1898504qtb.32.2022.06.28.09.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:50:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6EQJ-0032lk-Rp; Tue, 28 Jun 2022 13:50:47 -0300
Date:   Tue, 28 Jun 2022 13:50:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote
 versions
Message-ID: <20220628165047.GR23621@ziepe.ca>
References: <20220609120322.144315-1-haris.phnx@gmail.com>
 <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
 <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
 <20220624232745.GF23621@ziepe.ca>
 <CAE_WKMwcV_QFyN1j8Mb74-Nxg7V7j1V9M+16OxphUWYAU9m9GA@mail.gmail.com>
 <20220628163446.GQ23621@ziepe.ca>
 <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE_WKMz1XB19T9mXsSq+m0aUg9fKH0X4fTUYEoLtLR=NKZvKBg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 28, 2022 at 06:46:39PM +0200, haris iqbal wrote:
> On Tue, Jun 28, 2022 at 6:34 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jun 28, 2022 at 06:21:09PM +0200, haris iqbal wrote:
> >
> > > > Yes, no driver in Linux suports a disjoint key space.
> > >
> > > If disjoint key space is not supported in Linux; does this mean
> > > irrespective of whether an MR is registered (IB_WR_REG_MR) for LOCAL
> > > or REMOTE access, both rkey and lkey should be set?
> >
> > No.. It means given any key the driver can always tell if it is a rkey
> > or a lkey. There is never any aliasing of key values. Thus the API
> > often doesn't have a away to tell if the given key is an rkey or lkey.
> >
> > > PS: This discussion started in the following thread,
> > > https://marc.info/?l=linux-rdma&m=165390868832428&w=2
> >
> > rxe is incorrect to not accept the lkey presented on the
> > invalidate_rkey input. invalidate_rkey is misnamed.
> 
> 
> Understood. So a better fix for rxe (as compared to the one I sent)
> would be one of the following (if I understand correctly).
> 
> 1) The key sent in INV, is compared with lkey or rkey based on which
> one is set (non-zero).

This one seems to match the spec

However, it requires that keys don't alias, I don't know if rxe has
done this.

> OR,
> 2) The key sent in INV, is compared with lkey if the MR has only LOCAL
> access, and rkey if the MR has REMOTE access.

That might make more sense if rxe has aliasing keys and you need to be
specific about r/l

Jason
