Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D2D569E91
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jul 2022 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiGGJad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jul 2022 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiGGJad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jul 2022 05:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E163533E05
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 02:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F62562186
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 09:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C68C341C8
        for <linux-rdma@vger.kernel.org>; Thu,  7 Jul 2022 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657186230;
        bh=RihlDyQN4lrc4Ac44pKi2oZzo2pS/46Mh72kTjpRBMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T6EzO1AEYYMynBnjBULlVMNrjRMGEZyEs2THt6QLe5bYbKQPRU7CU71aVHqMixR+X
         Hn+IIy5d1BJULAvo+8Lq5oa4BGXkPHz+DLPDU1jPJ2QukjMApdtPNlaajQimz9ESoh
         aF9vsEoaV/vIZqHJJnQvQhMQmBpMx0KAuZgU9RxT7DAsPyQkzxrsD1nl2zA7BPmFI3
         fmA9HAaKk0NZQv3w5VJ/9b0u22Kd6rlQ8bdjkcX+b3SXJq+UsWIJz3p3mLjKKIB4DN
         hCBeutytgKdmZm4dbz+snZa1tdlJmfTeR7VsBJv3v0CntMpR+fqHF6Vlm6WDWcVJIi
         APhb+3/8+RqUQ==
Received: by mail-yb1-f169.google.com with SMTP id e69so24950543ybh.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Jul 2022 02:30:30 -0700 (PDT)
X-Gm-Message-State: AJIora9v++TS36FONl6ydSI82bB6m2h9Ww6ssVYmwovf21B6wUbWmknx
        wDbZlHcjk0baCrD5q0PaHQdlJJlVxszjRHTtpuc=
X-Google-Smtp-Source: AGRyM1uNgyEoOEe/qdRp0T/VyW0dtckh35RZHzVe9hpNbrTofc9bhjy7s6uJrRiivgEVvOxAj6t/GknpEcx2t2ozmHI=
X-Received: by 2002:a25:4210:0:b0:66e:bb10:1cb7 with SMTP id
 p16-20020a254210000000b0066ebb101cb7mr2588121yba.534.1657186229925; Thu, 07
 Jul 2022 02:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca> <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca> <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
 <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com> <20220706162448.GK23621@ziepe.ca>
In-Reply-To: <20220706162448.GK23621@ziepe.ca>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 7 Jul 2022 12:30:03 +0300
X-Gmail-Original-Message-ID: <CAFCwf10rGdOx94bOOW8vfuW73H_KFKPu2tg2Hpduzd+1OjnVOw@mail.gmail.com>
Message-ID: <CAFCwf10rGdOx94bOOW8vfuW73H_KFKPu2tg2Hpduzd+1OjnVOw@mail.gmail.com>
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

On Wed, Jul 6, 2022 at 7:24 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jul 06, 2022 at 11:59:14AM +0300, Oded Gabbay wrote:
>
> > Due to that, we would want to put all the ports under a single struct ib_device,
> > as you said it yourself in your original email a year ago.
>
> Yes
>
> > The major constraints are:
> >
> > 1. Support only RDMA WRITE operation. We do not support READ, SEND or RECV.
> >     This means that many existing open source tests in rdma-core are not
> >     compatible. e.g. rc_pingpong.c will not work. I guess we will need to
> >     implement different tests and submit them ? Do you have a
> > different idea/suggestion ?
>
> I would suggest following what EFA did and just using your own unique
> QP with dv accessors to create it. A QP that can only do RDMA WRITE is
> not IBA compliant and shouldn't be created by a standard verbs call.
>
> > 2. As you mentioned in the original email, we support only a single PD.
> >    I don't see any major implication regarding this constraint but please
> >    correct me if you think otherwise.
>
> Seems fine
>
> > 3. MR limitation on the rkey that is received from the remote connection
> >    during connection creation. The limitation is that our h/w extracts
> >    the rkey from the QP h/w context and not from the WQE when sending packets.
> >    This means that we may associate only a single remote MR per QP.
>
> It seems OK in the context above where you have your own QP type and
> obviouly your specila RDMA WRITE poster will not take in an rkey as
> any argument.
>
> >    Do you see any issue here with these two limitations ? One thing we noted is
> >    that we need to somehow configure the rkey in our h/w QP context, while today
> >    the API doesn't allow it.
>
> When you add your own dv qp create function it will take in the
> required rkey during qp creation.
>
> >    These limitations are not relevant to a deployment where all the NICs are
> >    Gaudi NICs, because we can use a single rkey for all MRs.
>
> Er, that is weird, did you mean to say you have only one MR per PD and
> that it always has a fixed value?
Not exactly. We have multiple MRs per PD, but the driver assigns the
same rkey (fixed value) for all created MRs. Our h/w matches the rkey
with the one that is written in the QP. The rkey is not part of the actual
MMU translation that is done inside our h/w. The MMU translation is
done using the PD (we call it ASID - address space ID) and Address.

>
> > 4. We do not support all the flags in the reg_mr API. e.g. we don't
> >    support IBV_ACCESS_LOCAL_WRITE. I'm not sure what the
> >    implication is here.
>
> It is OK, since you can't issue a local operation WQE anyhow you can
> just ignore the flag.
>
> > 5. Our h/w contains several accelerations we would like to utilize.
> >    e.g. we have a h/w mechanism for accelerating collective operations
> >    on multiple RDMA NICs. These accelerations will require either extensions
> >    to current APIs, or some dedicated APIs. For example, one of the
> >    accelerations requires that the user will create a QP with the same
> >    index on all the Gaudi NICs.
>
> Use your DV interface to do these kinds of things

Great!
We will start to move forward using this approach.
I imagine we will have something to show in a couple of months.

Thanks,
Oded

>
> Thanks,
> Jason
