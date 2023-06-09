Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC300729FDF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFIQRO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 12:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjFIQRO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 12:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2462D44
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686327383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEN3nQPttAlVzmr3cmWzqrRm+cOjJpZk/4cLj8awTyo=;
        b=Rx/DCLURKqU/IMcxbVB6fOrNwqHa5ihpLd7ItY4vy9/Uw+0PUcBtXBfYUqfjP3SBDkB0R7
        HnhEdw6t3Gar+5pdx9vIRWDFjSaTt/SdWL/uqWSKlLQcsCQHku8nyAfi1TwUrxu8viGbfM
        3jKnKB2SVlqbip4csEl4EDdG4H5NZok=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-gO73p6qOOGKLcpVnDyMbag-1; Fri, 09 Jun 2023 12:16:22 -0400
X-MC-Unique: gO73p6qOOGKLcpVnDyMbag-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2565bf593e7so605403a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 09:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686327381; x=1688919381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEN3nQPttAlVzmr3cmWzqrRm+cOjJpZk/4cLj8awTyo=;
        b=RkJM+9HX3mP4pjEDw9nyeolhQ4yCD77IKUV5Av+XHjd2SnylJoKbmN4eVb8DLuxH4o
         x8mNzW1wdyM9QvCGU3ZH9gLQhNuKnSk8M2K0biCeWtfanQ9J6G+Zy5NzNFuObhLQAhj9
         ePlfiE4hBJa+qF/Z01v8tvNnSahXOsRSvtsDNf314GdTASlPzDMhVO1wWDFwjHLDoBZ/
         7/62s+0yPMKkAUkdLdYxN1KhZWqDo2um9LezuIPxzTu+F/i8mOqlobFwoPNyHRTxm6Rf
         0efBKYrGS3LQi2ReZfOWfIENzJE05luymPoSOmFH5N6W2Up8Ud3dIOAFW6qLBeZ+X4Xq
         CozA==
X-Gm-Message-State: AC+VfDy/gRIQo6WddvttIu3BwURgeXOPXKAwmazQkzZd0iejEhHywmqC
        RhRrhPI1jr/kg6vmq1sK+3J6XvTB3ZOZxSpdEkJDhuDm6ir4ljD3w34uVYaXB3aLtGvApIoJ0kU
        wYWtZ83JujW07spgMqrh3jrakKEQ0KckHfQTwrQ==
X-Received: by 2002:a17:90a:bd90:b0:256:b190:2733 with SMTP id z16-20020a17090abd9000b00256b1902733mr1291937pjr.33.1686327381615;
        Fri, 09 Jun 2023 09:16:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49M1iZ7VeVCBDK+2YJEsM73zbJqcjtIN870yPgscvNWp87ELxmK2fXozowGxc6q6NKrQj4i8ZL/3hjeV2v9JM=
X-Received: by 2002:a17:90a:bd90:b0:256:b190:2733 with SMTP id
 z16-20020a17090abd9000b00256b1902733mr1291919pjr.33.1686327381293; Fri, 09
 Jun 2023 09:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230609153147.667674-1-neelx@redhat.com> <ZINMuV+XhTCnnlK+@ziepe.ca>
In-Reply-To: <ZINMuV+XhTCnnlK+@ziepe.ca>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Fri, 9 Jun 2023 18:15:44 +0200
Message-ID: <CACjP9X85R=p0crhtC+tW7QsL5T0Mq4iOt0HfWBW4V83kcn-C6A@mail.gmail.com>
Subject: Re: [PATCH] verbs: fix compilation warning with C++20
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 9, 2023 at 6:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Jun 09, 2023 at 05:31:47PM +0200, Daniel Vacek wrote:
> > Our customer reported the below warning whe using Clang v16.0.4 and C++=
20,
> > on a code that includes the header "/usr/include/infiniband/verbs.h":
> >
> > error: bitwise operation between different enumeration types ('ibv_acce=
ss_flags' and
> > 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-enum=
-conversion]
> >                 mem->mr =3D ibv_reg_mr(dev->pd, (void*)start, len, IBV_=
ACCESS_LOCAL_WRITE);
> >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~
> > /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro 'ibv=
_reg_mr'
> >                              ((access) & IBV_ACCESS_OPTIONAL_RANGE) =3D=
=3D 0))
> >                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> >
> > According to the article "Clang 11 warning: Bitwise operation between d=
ifferent
> > enumeration types is deprecated":
> >
> > C++20's P1120R0 deprecated bitwise operations between different enums. =
Such code is
> > likely to become ill-formed in C++23. Clang 11 warns about such cases. =
It should be fixed.
>
> There should be a cast to an integer in the macro, we can't know what
> the user will pass in there and it may not be that enum.

Hmm, if the user passes a definition from the header files at least we
should be consistent I'd say, which is this case. No one was passing
any custom values here.
If you cast to an integer here you may start silently hiding possible
errors. If the user passes any custom value, IMO, it's his
responsibility to make it right.

I forgot to explicitly mention before that this change was tested and
it addresses the warning successfully.

--nX

> Jason
>

