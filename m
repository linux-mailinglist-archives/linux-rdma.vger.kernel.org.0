Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9137D56CDA3
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jul 2022 09:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiGJHbM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Jul 2022 03:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJHbL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Jul 2022 03:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AAB18E12
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jul 2022 00:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C945361146
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jul 2022 07:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F986C3411E
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jul 2022 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657438269;
        bh=X9sEaG8Sp6a6FoK7iNEcnmCcdDxuWWuJg+IrJ+siH/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tQWXVk5iKIvP8S3QJdrU8NGWwwmGkgZCQi07baPg+S0SplFvS23tyvhDRFAiZrDFP
         FbucIkmb0eoO6mXdH6UoG/dnKWwUWeFEm+JZkfggCI2axP2VpJn7PbWc91jcZGE6jH
         F0MKSvcHpX1vlWAjFv9mqtLdJCsA7o686XboSrwGjje2GkfT/4coNqRqHiBF7IgAWS
         y3FXxtY6iYJfLxfW/iQYbe30+oPboksUheVgH5zoXDHm1AzQhFm6Xx+0IlL5ImvAIl
         rZ4wAAhtqLdBt9E5XLddX1FJb2T0tJ4ThC5GE1Yon6YQs0JAKS/ywVd0YGBclHJi4Y
         +TUZJrj2sTvSw==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31cac89d8d6so22961037b3.2
        for <linux-rdma@vger.kernel.org>; Sun, 10 Jul 2022 00:31:09 -0700 (PDT)
X-Gm-Message-State: AJIora9rZSJTVDU0zKqkQrVMEecN9YKi7W+xUuW7w0fk5jR0ZSMGBviT
        54kUV+VYrIX0v6dxw1AvqvXeKrSq6B2nGilysuk=
X-Google-Smtp-Source: AGRyM1v+FB6ntGBlwn63KZk7AXT6OK8iF8KBRM951VoFQJ50MqsKDt0hAjLmlSugAeKUyqj3PbMylZnsdFHLo+NitHg=
X-Received: by 2002:a81:85c5:0:b0:31c:1f50:1bbb with SMTP id
 v188-20020a8185c5000000b0031c1f501bbbmr13160295ywf.3.1657438268255; Sun, 10
 Jul 2022 00:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca> <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca> <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
 <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
 <20220706162448.GK23621@ziepe.ca> <CAFCwf10rGdOx94bOOW8vfuW73H_KFKPu2tg2Hpduzd+1OjnVOw@mail.gmail.com>
 <20220708132916.GA4459@ziepe.ca>
In-Reply-To: <20220708132916.GA4459@ziepe.ca>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 10 Jul 2022 10:30:41 +0300
X-Gmail-Original-Message-ID: <CAFCwf11ibw0y_pZbAYE3B_-Wp7FmqK_Qt=gzQeOr5brzm4E4fw@mail.gmail.com>
Message-ID: <CAFCwf11ibw0y_pZbAYE3B_-Wp7FmqK_Qt=gzQeOr5brzm4E4fw@mail.gmail.com>
Subject: Re: Creating new RDMA driver for habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 8, 2022 at 4:29 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 07, 2022 at 12:30:03PM +0300, Oded Gabbay wrote:
> > > >    These limitations are not relevant to a deployment where all the NICs are
> > > >    Gaudi NICs, because we can use a single rkey for all MRs.
> > >
> > > Er, that is weird, did you mean to say you have only one MR per PD and
> > > that it always has a fixed value?
>
> > Not exactly. We have multiple MRs per PD, but the driver assigns the
> > same rkey (fixed value) for all created MRs. Our h/w matches the rkey
> > with the one that is written in the QP. The rkey is not part of the actual
> > MMU translation that is done inside our h/w. The MMU translation is
> > done using the PD (we call it ASID - address space ID) and Address.
>
> I don't understand this at all - how can you have multiple MRs if
> there is only one ASID per PD? The MR is logically the ASID since the
> MR is the verbs model for MMU translation.

We don't follow the MR verbs model. This is the meaning of the
hardware constraint I wrote imo.
Our MMU does a pgt walk that starts with ASID and then just goes
according to the virtual address, same as regular CPU does.
The key is not a part of the pgt.
The ASID represents different processes, but because we decided long
ago we support only a single user process,
we only allocate a single ASID, which will translate to a single PD in
our IBverb driver.

>
> So, if you have one ASID per PD and multiple MRs, what are the MRs
> supposed to be?
>
> Jason

Per my understanding, the MRs are meant to notify the driver that the
user would like the h/w MMU to be familiar with these memory regions.
As we also need to pin them, it is preferable to have multiple small
MRs than a single very large MR.
The fact that the key that is returned is the same for all memory
regions shouldn't affect the user. Our MMU will be able to do the
translation correctly using only the ASID+address.
In addition, because we also have on-device memory (HBM), we would
like to allow the user to register memory regions in that memory. So
we need to support at least two MRs.

Thanks,
Oded
