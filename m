Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46131567066
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiGEOJv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiGEOJd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 10:09:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8161F614
        for <linux-rdma@vger.kernel.org>; Tue,  5 Jul 2022 07:00:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l14so13742918qtx.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 Jul 2022 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=H/M96SwcQ+6khO48rEPFSqALYdOSCMlS7OhwhehnpdA=;
        b=brYM99p9J57tehMqH2FEM9lh530WXbLxP3KXVvJRF0M9nONH/qUbxLbddBo/8Gn2e9
         Ww268+3prNMkVhSCQbBJjHMW0XWwyznNC25bLE6VRLnhBKYDGcXycCI+/GBz0tRhd2wf
         1zadSrqdUdx0sfRB9YDwWxHxmyUmZ9VCvZyuXzUiA+HGH1TFKJjTp7M4iUJ9v1EPVwPm
         c9HpvLLq7TTAqxIMLDliSjHzxtLUdOVIi2oMDOA978BMpRrAg+rs4/1NrLVAmVBXnYGj
         r+E/qdo+BxZVSfILZaYdvODeNhL9ZUCllRUqCruUeLE5kAhR8WP65yjjoD1Hu8nR+JUK
         X8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H/M96SwcQ+6khO48rEPFSqALYdOSCMlS7OhwhehnpdA=;
        b=7D0nD2mliBALJFadaqmLDLiXRHPPAs0AIthjoo/sAsjkmQigf4JtUCsBYMV2MXyNdm
         xnV0daJpHomuW0QUGA4jUBPfVe7TWYUM+afzk9y3Che25qczArsIKcKAlO3bf9ge9vfs
         EY/7pA/EeTAC2DMsqxWV4le6hCaZEIefQ1l3AVSSkCN+G3eFBSrfsAhuWW6HjTTWhfOg
         jrQUMpk3xHCPfzP8AkonuSyDdaTj2aLATZRcRD4+FAjsSeprU7ABJbqYuhnzWu2GoVAH
         c1dY1BV5XA9QxuIIcsxGmZIOqKa1v66EXUmTFX+Acn4y+UPTAbjKVDvAdaF7f/XPEzR5
         wGfA==
X-Gm-Message-State: AJIora9QRuAm1/jYJo4P2fhhQyK8tIxqEQVSJvRLtDIHboPrAlayzEEf
        f5QCv+CAmJ/gARsmtTOAEbz4JA==
X-Google-Smtp-Source: AGRyM1vC+kAl4Hs+KYuXewDTo4F9Ekh8JT0omYuIrPnqITdKEE24mWy66ih99f+FdepJeJUTD9/BdA==
X-Received: by 2002:a05:622a:449:b0:31e:7949:9927 with SMTP id o9-20020a05622a044900b0031e79499927mr6842434qtx.604.1657029600634;
        Tue, 05 Jul 2022 07:00:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 142-20020a370994000000b006a73cb957dasm25909819qkj.20.2022.07.05.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 06:59:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8j5r-006Vb8-Ai; Tue, 05 Jul 2022 10:59:59 -0300
Date:   Tue, 5 Jul 2022 10:59:59 -0300
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
Message-ID: <20220705135959.GG23621@ziepe.ca>
References: <20220629164946.521293-1-haris.phnx@gmail.com>
 <20220629183445.GV23621@ziepe.ca>
 <MW4PR84MB2307EB091065A95A6972C41FBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <20220629184432.GW23621@ziepe.ca>
 <MW4PR84MB23074C9D7F136278F37FD7FEBCBB9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <CAE_WKMzMi7A5qYp71ez=4E1BxcUNYCDeYq4DmFjxWMoHYRusAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE_WKMzMi7A5qYp71ez=4E1BxcUNYCDeYq4DmFjxWMoHYRusAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 11:28:59AM +0200, haris iqbal wrote:
> On Wed, Jun 29, 2022 at 8:48 PM Pearson, Robert B
> <robert.pearson2@hpe.com> wrote:
> >
> > > > > If the rkey's and lkeys are always the same why do we store them twice in the mr ?
> > > >
> > > > They are not always the same currently. If you request remote access they are the same if you don't rkey is set to zero.
> > > > You could, of course, check both the keys and the access bits but that is not the way it is written currently.
> >
> > > Storing the rkey instead of checking the flags seems like a weird obfuscation to me..
> >
> > > Jason
> >
> > One always has the choice to always just use the lkey and check the flags. But referring the rkey just uses one memory reference 😊
> 
> Have we reached a consensus here as to how to solve this?
> 
> This (and the issue created by dual map) has basically caused a
> regression in RTRS since the 5.15. And we would appreciate it a lot if
> the fix goes in and is backported.

I think your patch is close, it should just be tweaked a bit.

Jason
