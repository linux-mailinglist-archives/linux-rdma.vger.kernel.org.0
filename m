Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A155A72A033
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjFIQbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFIQbV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 12:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41811BEB
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686328234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7963VZ0EQavHYSMbMkAmbSWbxKhzEfpht810fwshAw=;
        b=S6Tx5p4EWk6pIBTeu9756KcVcka/DvPaQj9oqMrBNGCob1tNYkUZm7DEtR7ctEtDfMYqVG
        eAd69xX9GO5akbrgxmYTa2RO1D/OQ0n60dft49t+vlnLl0xJaPhccWzaUpDKwylidm5R6Z
        wLePnF7qldEeURLdxuTb43oAABp05YU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-GPMLOnAEMbyS8QcCAipTrA-1; Fri, 09 Jun 2023 12:30:32 -0400
X-MC-Unique: GPMLOnAEMbyS8QcCAipTrA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-25682c04fd7so604547a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 09:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686328231; x=1688920231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7963VZ0EQavHYSMbMkAmbSWbxKhzEfpht810fwshAw=;
        b=OT08uRa2/GQDmXbEf9QPxDDmSgxaEiu0AJwMpRrR3drOr3tIsmZ3o4cnajUWno1unU
         SoxsnlHyZa0PwwW3HMjkokNtYv91KvZw66z7iAaHHAavrPTYiy82g6KK5qAi7rVyZCD3
         yFfpIBa9uvKqSAPGWJ1f94qqvLc/TOjapjmmBONkViMjAeL7QxVV+PF7EMdJ1/Iy6vNC
         BJ4OwfLUNhX9pvSeLU6fOHPIF/LP6H9t/NYMKnFSRc4nZcwC5eSNDBOnNA3BwlBF+/SM
         vdEyvoXLOp9GAi4C6mpBgCdbiFRbFyAO+KqQNhh4kROqiUCIZ7TeWhaI5YvrwZzdTLb7
         1Ozg==
X-Gm-Message-State: AC+VfDwso/8OSrJ8ohL2jFFB5zJNaZ+ZPtMKHlN2DjfffnbOfNapOWBR
        8+KcxIFj9Dq72DW0hI1ZizRYSkyXe2HLYe/E8wCHeaEEiXrCx2Dal6lUUL1f3yAc/rUY1m43TLf
        Ps1IDfyrpoYIm6WL/jGw9Yia1fRrrpiAqkEIIsA==
X-Received: by 2002:a17:90a:741:b0:259:3e7d:3b79 with SMTP id s1-20020a17090a074100b002593e7d3b79mr1316078pje.43.1686328231618;
        Fri, 09 Jun 2023 09:30:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ64bKuJLnUAFsM8to28KtdiXxvhAQe1GXTiRYqCWMm/aAme2uH/7yafiRP4qjm752C+ympsHwsJKB+3BXaQYdE=
X-Received: by 2002:a17:90a:741:b0:259:3e7d:3b79 with SMTP id
 s1-20020a17090a074100b002593e7d3b79mr1316063pje.43.1686328231302; Fri, 09 Jun
 2023 09:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230609153147.667674-1-neelx@redhat.com> <ZINMuV+XhTCnnlK+@ziepe.ca>
 <CACjP9X85R=p0crhtC+tW7QsL5T0Mq4iOt0HfWBW4V83kcn-C6A@mail.gmail.com> <ZINQ3lI+ugqHbPN3@ziepe.ca>
In-Reply-To: <ZINQ3lI+ugqHbPN3@ziepe.ca>
From:   Daniel Vacek <neelx@redhat.com>
Date:   Fri, 9 Jun 2023 18:29:55 +0200
Message-ID: <CACjP9X8pYqxTGQvqnqK6CWqTuy4BZBr_Ze0rfniJ8LOYUsLCog@mail.gmail.com>
Subject: Re: [PATCH] verbs: fix compilation warning with C++20
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Rogerio Moraes <rogerio@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 9, 2023 at 6:18=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> On Fri, Jun 09, 2023 at 06:15:44PM +0200, Daniel Vacek wrote:
> > On Fri, Jun 9, 2023 at 6:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > > On Fri, Jun 09, 2023 at 05:31:47PM +0200, Daniel Vacek wrote:
> > > > Our customer reported the below warning whe using Clang v16.0.4 and=
 C++20,
> > > > on a code that includes the header "/usr/include/infiniband/verbs.h=
":
> > > >
> > > > error: bitwise operation between different enumeration types ('ibv_=
access_flags' and
> > > > 'ib_uverbs_access_flags') is deprecated [-Werror,-Wdeprecated-enum-=
enum-conversion]
> > > >                 mem->mr =3D ibv_reg_mr(dev->pd, (void*)start, len, =
IBV_ACCESS_LOCAL_WRITE);
> > > >                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
> > > > /usr/include/infiniband/verbs.h:2514:19: note: expanded from macro =
'ibv_reg_mr'
> > > >                              ((access) & IBV_ACCESS_OPTIONAL_RANGE)=
 =3D=3D 0))
> > > >                               ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > 1 error generated.
> > > >
> > > > According to the article "Clang 11 warning: Bitwise operation betwe=
en different
> > > > enumeration types is deprecated":
> > > >
> > > > C++20's P1120R0 deprecated bitwise operations between different enu=
ms. Such code is
> > > > likely to become ill-formed in C++23. Clang 11 warns about such cas=
es. It should be fixed.
> > >
> > > There should be a cast to an integer in the macro, we can't know what
> > > the user will pass in there and it may not be that enum.
> >
> > Hmm, if the user passes a definition from the header files at least we
> > should be consistent I'd say, which is this case. No one was passing
> > any custom values here.
> > If you cast to an integer here you may start silently hiding possible
> > errors. If the user passes any custom value, IMO, it's his
> > responsibility to make it right.
>
> The signature of the API is to accept an int, we cannot demand any
> more of that from the user. The macro wiped out the type cast to an
> int, it should put it back.

Oh, I see. In that case shall we still keep this patch or just do the cast?

--nX

> Jason
>

