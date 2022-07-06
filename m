Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC756824E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 11:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiGFI7u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiGFI7q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 04:59:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF812AD7
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 01:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA323B818BB
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 08:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F4C341CB
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657097982;
        bh=O1EwVKaiskNG9ZaG+LETtDScoTP99A+EgN+vGU8UVuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DpNQ2XzqtIrzs9YEbhMLrPZmv8t0ttICO4ui+0KaIBSruiNxeyTLE4ilJoVT76uEX
         yh2StDuTgcz9cxaEStx3HVMRMVQACWg8f8T5Gvq3eoHxuiyAM9xkpOd6F2hecAU1cq
         zskug0OIdfEKQWcxiiSRknejj+3oI1j8ymZ4K7hLXNaGuCvrJ1OeQvwjTHBSWyUOwj
         CV+KcVm9OzZg0jUPqDgVfrBbvSY55DWE51foF3gYTvfXqdT8rPpKu87sqIk1b4mlGT
         oGqs2Gk9e8xQfMMokN2wBYTmsr/UNv22xgxIUHQebFPjoFHlB2ah4/7rjWPp9X2Q0x
         oZ2OPPhnOoR+A==
Received: by mail-yb1-f178.google.com with SMTP id r3so26241204ybr.6
        for <linux-rdma@vger.kernel.org>; Wed, 06 Jul 2022 01:59:42 -0700 (PDT)
X-Gm-Message-State: AJIora8bjUZ6YHhyY/2g88XXqyH/Ma8CXFumbdm7zJARyRkiXhCZlfUW
        d5IyMZBlw+Xb4sDg6D023Z9hIIzlIrq4YuOCad0=
X-Google-Smtp-Source: AGRyM1uAtTj/Ye5uTl0Ows4TvNdC2QgMGxMDcRjASMGeyipiTDCUBx5/T+e+QV3pS/nLcBeTqBBwUbWarj2ZHFSP5+E=
X-Received: by 2002:a05:6902:1141:b0:66d:5bc3:b675 with SMTP id
 p1-20020a056902114100b0066d5bc3b675mr42134654ybu.108.1657097981491; Wed, 06
 Jul 2022 01:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca> <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca> <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
In-Reply-To: <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 6 Jul 2022 11:59:14 +0300
X-Gmail-Original-Message-ID: <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
Message-ID: <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 5:19 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Mon, Aug 23, 2021 at 4:04 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Aug 23, 2021 at 11:53:48AM +0300, Oded Gabbay wrote:
> >
> > > Do you see any issue with that ?
> >
> > It should work out, without a netdev you have to be more careful about
> > addressing and can't really use the IP addressing modes. But you'd
> > have a singular hardwired roce gid in this case and act more like an
> > IB device than a roce device.
> >
> > Where you might start to run into trouble is you probably want to put
> > all these ports under a single struct ib_device and we've been moving
> > away from having significant per-port differences. But I suspect it
> > can still work out.
> >
> > Jason
>
> ok, thanks for all the info.
> I will go look at the efa driver.
>
> Thanks,
> Oded

Hi Jason.

So it took a *bit* longer than expected due to higher-priority tasks,
but in the last month we did a thorough investigation of how our h/w maps
to the IBverbs API and it appears we have a few constraints that are
not quite common.

Tackling these constraints can affect the basic design of the driver or
even be a non-starter for this entire endeavor.

Therefore, I would like to list the major constraints and get your opinion
whether they are significant, and if so, how to tackle them.

To understand the context of these constraints, I would like to first say
that the Gaudi NICs were designed primarily as a form of a scale-out fabric
for doing Deep-Learning training across thousands of Gaudi devices.

This means that the designated deployment is one where the entire network
is composed of Gaudi NICs, and L2/L3 switches. Doing interoperability with
other NICs was not the main goal, although we did manage to
work vs. a MLNX RDMA NIC in the lab.

In addition, I would like to remind you that each Gaudi has multiple NIC
ports, but from our perspective they are all used for the same purpose.
i.e. We are using ALL the Gaudi NIC ports for a single user process
to distribute its Deep-Learning training workload.

Due to that, we would want to put all the ports under a single struct ib_device,
as you said it yourself in your original email a year ago.
I haven't written this as a h/w constraint, but this is very important
for us from a system/deployment perspective. I would go on to say it
is pretty much
mandatory.

The major constraints are:

1. Support only RDMA WRITE operation. We do not support READ, SEND or RECV.
    This means that many existing open source tests in rdma-core are not
    compatible. e.g. rc_pingpong.c will not work. I guess we will need to
    implement different tests and submit them ? Do you have a
different idea/suggestion ?

2. As you mentioned in the original email, we support only a single PD.
   I don't see any major implication regarding this constraint but please
   correct me if you think otherwise.

3. MR limitation on the rkey that is received from the remote connection
   during connection creation. The limitation is that our h/w extracts
   the rkey from the QP h/w context and not from the WQE when sending packets.
   This means that we may associate only a single remote MR per QP.

   Moreover, we also have an MR limitation on the rkey that we can give to the
   remote side. Our h/w extracts the rkey from QP h/w context and not
from the received
   packets. This means we give the same rkey for all MRs that we create per QP.

   Do you see any issue here with these two limitations ? One thing we noted is
   that we need to somehow configure the rkey in our h/w QP context, while today
   the API doesn't allow it.

   These limitations are not relevant to a deployment where all the NICs are
   Gaudi NICs, because we can use a single rkey for all MRs.

4. We do not support all the flags in the reg_mr API. e.g. we don't
   support IBV_ACCESS_LOCAL_WRITE. I'm not sure what the
   implication is here.

5. Our h/w contains several accelerations we would like to utilize.
   e.g. we have a h/w mechanism for accelerating collective operations
   on multiple RDMA NICs. These accelerations will require either extensions
   to current APIs, or some dedicated APIs. For example, one of the
   accelerations requires that the user will create a QP with the same
   index on all the Gaudi NICs.

Those are the major constraints. We have a few others but imo they are less
severe and can be discussed when we upstream the code.

btw, due to the large effort, we will do this conversion only for
Gaudi2 (and beyond).
Gaudi1 will continue to use our proprietary, not-upstreamed, kernel driver uAPI.

Appreciate your help on this.

Thanks,
Oded
