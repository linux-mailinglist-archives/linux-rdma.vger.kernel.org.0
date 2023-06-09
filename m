Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB6729FFC
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242143AbjFIQTB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbjFIQS6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 12:18:58 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A000B5
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 09:18:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9a949c012so16723491cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686327519; x=1688919519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0NurmJcRSmn8loyf60/M3Uhfw+rRKoepof9vnQUM/yU=;
        b=Fn7NJq1LXbaZZ31QLN94ERRNJy+QUw8zFhv2Lglfc+e0xQLqbaGlHbk4vqN+91GSvN
         ra6w2eT5GYmn5Wb8d0XC5WjHyAVJFFS8+UT4e9XE1SXpU2XfBncIXb4fanwtJ94jd+2M
         cupvjWZztvsXMBu/oQlWJo+AZYCFTSLZfgnPplQ1JZpV4oVkm4yhrl6ZUGOPbbfRTe6z
         svA6fOR2P8Utb4SVDU6IZXOlc3GWwfdxNPrYYNa+2AT8i5WM0wyB3BckLkSALviHBJjs
         FougiNqrJb61LVFSh43+6A8ukcA2gMYQhVFKqG5YsxHA2DYbllTxoVKZ3JiN52DXxc65
         JwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327519; x=1688919519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NurmJcRSmn8loyf60/M3Uhfw+rRKoepof9vnQUM/yU=;
        b=HA7IB/H/R0cYd+IudPzyXzFxsFT+0tgfeDeR0RknkK445ikvlgZySBufwvpQ3w9UQe
         Bpyq3QIixnWHALfSIK/c1bsHblnej3uhjQVWewYnM//jMEGCM+Ib2OXvit9Qh82bIzXb
         r4Mw8TXVLMahDRP47ExgA1s95YRFJiNjIVMniMHbSVluwbM3CQIStOHn1Xrk6oOpZNLG
         KNd1nnt+71+llonFZ7XYmXQg0JDyPoDLVtMHALgN6rS0XqebJ1Z6Ybyi9eAms6roBJL2
         JBTf7vNdfwSVjhppRHZEGI0SQOd+SiceMP18cxb5ocmwq3B0vDW1TfuCuQNiMHSL1HWg
         M5yQ==
X-Gm-Message-State: AC+VfDzW2vWTwL/mtpAUwSOhaV0w/VaUjkqnydLofMqRbftxCgBQVUx1
        iygvK4cFWeaur8jOxyjkqtrfQ6qt/FsyS+FcfMM=
X-Google-Smtp-Source: ACHHUZ5A5JWN1S61vyxb95p8LkvjB7uBTneBBvV/1r0Ho2ATZSSzCIGt8zMChq32jOWFbWgWxZiA8Q==
X-Received: by 2002:a05:622a:552:b0:3f8:50c:f2ba with SMTP id m18-20020a05622a055200b003f8050cf2bamr2666575qtx.19.1686327519683;
        Fri, 09 Jun 2023 09:18:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id o16-20020a05622a009000b003ef2c959d1bsm1248920qtw.67.2023.06.09.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:18:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q7eow-003wa4-IY;
        Fri, 09 Jun 2023 13:18:38 -0300
Date:   Fri, 9 Jun 2023 13:18:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vacek <neelx@redhat.com>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Subject: Re: [PATCH] verbs: fix compilation warning with C++20
Message-ID: <ZINQ3lI+ugqHbPN3@ziepe.ca>
References: <20230609153147.667674-1-neelx@redhat.com>
 <ZINMuV+XhTCnnlK+@ziepe.ca>
 <CACjP9X85R=p0crhtC+tW7QsL5T0Mq4iOt0HfWBW4V83kcn-C6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjP9X85R=p0crhtC+tW7QsL5T0Mq4iOt0HfWBW4V83kcn-C6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 09, 2023 at 06:15:44PM +0200, Daniel Vacek wrote:
> On Fri, Jun 9, 2023 at 6:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Jun 09, 2023 at 05:31:47PM +0200, Daniel Vacek wrote:
> > > Our customer reported the below warning whe using Clang v16.0.4 and C++20,
> > > on a code that includes the header "/usr/include/infiniband/verbs.h":
> > >
> > > error: bitwise operation between different enumeration types ('ibv_access_flags' and
> > > 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
> > >                 mem->mr = ibv_reg_mr(dev->pd, (void*)start, len, IBV_ACCESS_LOCAL_WRITE);
> > >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv_reg_mr'
> > >                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) == 0))
> > >                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 1 error generated.
> > >
> > > According to the article "Clang 11 warning: Bitwise operation between different
> > > enumeration types is deprecated":
> > >
> > > C++20's P1120R0 deprecated bitwise operations between different enums. Such code is
> > > likely to become ill-formed in C++23. Clang 11 warns about such cases. It should be fixed.
> >
> > There should be a cast to an integer in the macro, we can't know what
> > the user will pass in there and it may not be that enum.
> 
> Hmm, if the user passes a definition from the header files at least we
> should be consistent I'd say, which is this case. No one was passing
> any custom values here.
> If you cast to an integer here you may start silently hiding possible
> errors. If the user passes any custom value, IMO, it's his
> responsibility to make it right.

The signature of the API is to accept an int, we cannot demand any
more of that from the user. The macro wiped out the type cast to an
int, it should put it back.

Jason
