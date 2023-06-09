Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0017372A03B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjFIQeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFIQeJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 12:34:09 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE71BEB
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 09:34:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75b3645fb1fso190739485a.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686328444; x=1688920444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tt32Ii/dMQWTK8QuiOQbhXwMUMcqIPJQr+pOwKS8lfw=;
        b=ijj9SQ/Mu6Bqy1Wmz9dq7aebEN0MedDDkkIJp0XJDo3ZlNoXgNChyw+c8jIDLrQUiv
         mmAQgZlkqFEjPA7kNZMEBFusC0NxRehdrv1fHx74AxwAY71KpNHt+VU/YXFNBXVyqc5m
         2g9FKnPkj2zT94hpz8hdRcUPs9TgW+ZFFT+toq+wxRLVjOl/s6yq6EHBoiL0Arwx1DCQ
         Ijobwdjrh4NZGpkBR4wROfqlqyLVnQWfpEY9vTxO0u5R3qUwW0MyGm8HRBknCLA/u2b0
         zJkeCr+7qYXwi0SrTSSCuweeV2m/+6X9W6ZOUEaonAwkf8OqPFb3Hj4TisIRy7NYcEFm
         QjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686328444; x=1688920444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tt32Ii/dMQWTK8QuiOQbhXwMUMcqIPJQr+pOwKS8lfw=;
        b=UEGlJFLWj+FQYqwOSzcD2JaxFSwM+x+GMSAwbYNdxYpG82736ylOjpt3E1ym00NgE2
         YdN9Sk12DoPnWXlnwLUDF6xxeIqOLHgbj7garP+sMg2tLsNIOd7FBDoNosEDCMBvWtAu
         y/9rxuwvPDoWBvpc6SEU5CHPWopyeagnKRjrAmVFLmastDIxbuOgHYIljNcdp8mWK3C1
         60YacjF2t4GW0I7e8E04cj0RUoInRly1mb/f1Gv8Rn2Kyeh8jFcLHL0j2N/PKJiEA3RP
         eQ4j+x0t0p80gq4ZOHp09MHw35PR4y84olq0nc/x7NROkDbE9bnyrqrCYF7sh7K0zFzR
         PH/g==
X-Gm-Message-State: AC+VfDzF2OyquK874TaOssaPYCwTavnx1CVpppbRKz03Mz3sGSlpMnx5
        9Tf2gHOQMim/y5zEoPyX7mzlPQ==
X-Google-Smtp-Source: ACHHUZ4z0/3iDamel5beJ1Xp2rhxa3DsI2vuIf8A+awnJj3ogIXulOJb7sYuWHw4pE2z/hiyvomg2Q==
X-Received: by 2002:a05:620a:3c91:b0:75b:23a1:d8d0 with SMTP id tp17-20020a05620a3c9100b0075b23a1d8d0mr2525085qkn.20.1686328444532;
        Fri, 09 Jun 2023 09:34:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g17-20020ae9e111000000b0075d49ce31c3sm1129862qkm.91.2023.06.09.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:34:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q7f3r-003xi0-DE;
        Fri, 09 Jun 2023 13:34:03 -0300
Date:   Fri, 9 Jun 2023 13:34:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Subject: Re: [PATCH] verbs: fix compilation warning with C++20
Message-ID: <ZINUe30DbtnUuLOZ@ziepe.ca>
References: <20230609153147.667674-1-neelx@redhat.com>
 <ZINMuV+XhTCnnlK+@ziepe.ca>
 <CACjP9X85R=p0crhtC+tW7QsL5T0Mq4iOt0HfWBW4V83kcn-C6A@mail.gmail.com>
 <ZINQ3lI+ugqHbPN3@ziepe.ca>
 <CACjP9X8pYqxTGQvqnqK6CWqTuy4BZBr_Ze0rfniJ8LOYUsLCog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjP9X8pYqxTGQvqnqK6CWqTuy4BZBr_Ze0rfniJ8LOYUsLCog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 06:29:55PM +0200, Daniel Vacek wrote:
> On Fri, Jun 9, 2023 at 6:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Fri, Jun 09, 2023 at 06:15:44PM +0200, Daniel Vacek wrote:
> > > On Fri, Jun 9, 2023 at 6:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Fri, Jun 09, 2023 at 05:31:47PM +0200, Daniel Vacek wrote:
> > > > > Our customer reported the below warning whe using Clang v16.0.4 and C++20,
> > > > > on a code that includes the header "/usr/include/infiniband/verbs.h":
> > > > >
> > > > > error: bitwise operation between different enumeration types ('ibv_access_flags' and
> > > > > 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
> > > > >                 mem->mr = ibv_reg_mr(dev->pd, (void*)start, len, IBV_ACCESS_LOCAL_WRITE);
> > > > >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_reg_mr'
> > > > >                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
> > > > >                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > 1 error generated.
> > > > >
> > > > > According to the article "Clang 11 warning: Bitwise operation between different
> > > > > enumeration types is deprecated":
> > > > >
> > > > > C++20's P1120R0 deprecated bitwise operations between different enums. Such code is
> > > > > likely to become ill-formed in C++23. Clang 11 warns about such cases. It should be fixed.
> > > >
> > > > There should be a cast to an integer in the macro, we can't know what
> > > > the user will pass in there and it may not be that enum.
> > >
> > > Hmm, if the user passes a definition from the header files at least we
> > > should be consistent I'd say, which is this case. No one was passing
> > > any custom values here.
> > > If you cast to an integer here you may start silently hiding possible
> > > errors. If the user passes any custom value, IMO, it's his
> > > responsibility to make it right.
> >
> > The signature of the API is to accept an int, we cannot demand any
> > more of that from the user. The macro wiped out the type cast to an
> > int, it should put it back.
> 
> Oh, I see. In that case shall we still keep this patch or just do
> the cast?

Just do the cast

Jason
