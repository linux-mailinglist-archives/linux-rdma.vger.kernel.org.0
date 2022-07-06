Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5B568F08
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Jul 2022 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiGFQYv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Jul 2022 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiGFQYv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Jul 2022 12:24:51 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEE9220E3
        for <linux-rdma@vger.kernel.org>; Wed,  6 Jul 2022 09:24:50 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l14so18951155qtx.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Jul 2022 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uINY8FbXZ4K0fgSzKCzCILQBpZoaurxgAcM5XQzBO2s=;
        b=jufWmSUm3dS52kuMnxSYftc6uLsnfldwGPfUzw9VQD07HFJgUL3ozoibvvh9sNqlNc
         HT+FCTbVRcGTaiHz5FjthsL952JyNV1H/FbVHB+3Bk+eOKbzHTQ4yoOfH7zNzccz82zB
         PDUEsfwI+aozsYDeITqDqUYckliaHSJ18T59x7XsSNUnNBIkMOifByVwSOIkLGRoVcSY
         SvGnltzf/NC1EoHRd+NelYqaTaeXgtvfaRPGCXKA5BQLcVQy2eppcaaBuI6k+/dNknv9
         dKGRxbQdo1YQhhk1bYkUCtbGgTE2O2fgz3idgAPheEbdyvCh27jPi67C0GJc8l0I/Lwa
         7+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uINY8FbXZ4K0fgSzKCzCILQBpZoaurxgAcM5XQzBO2s=;
        b=tRF5OxcWrzi0THGBLG9b2HerP/Xc84qtdqV3fnaNWNRgHbCnzg3+D1RAUUx+lOTkVx
         vINl6KCR2TMkVvFSuU3VYQnthSNZxYVqwSo60cpthjRRnxjcqxS47nzVrfCpNKOAw3D4
         GC4tCh/jzfz5i3EoKRhIHm0TTby7OfjA2rZCwYKFO1V7aMkGQ8urKSRJHBxnoJuoF3wp
         x+Irf+mtHwYPaNm3wXCybycG62CmoXU/oSw8zsP6PpvM3le+yMEst3TSPDXQk2K37LjT
         ou1ZFucA71CxwgtcVGK2RxXaQcTGmDEdXVdzu9mglRgOcdS+FFL5HLMGwfhTskmPjNyD
         dicQ==
X-Gm-Message-State: AJIora8Xg4fLsOu/1vpz8bMwnnyLE9Mxq6tiUm08s45kiTuFbBrD4kSJ
        Fc9aGRbKpiv0gjueXVBRcPeinQ==
X-Google-Smtp-Source: AGRyM1vSaBHN7QOTWTn9NvV2TrR5W6NZI6h6AHLLDLRRLyhfXqfmJFDLtvOW4xWIzDspFYjwmdhK6g==
X-Received: by 2002:ac8:5e09:0:b0:31e:7ac2:e2e9 with SMTP id h9-20020ac85e09000000b0031e7ac2e2e9mr11120428qtx.194.1657124689450;
        Wed, 06 Jul 2022 09:24:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f11-20020a05620a408b00b006a74458410csm27331300qko.123.2022.07.06.09.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:24:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o97pY-0076oM-2k; Wed, 06 Jul 2022 13:24:48 -0300
Date:   Wed, 6 Jul 2022 13:24:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Creating new RDMA driver for habanalabs
Message-ID: <20220706162448.GK23621@ziepe.ca>
References: <CAFCwf12o_Hq8Ci4o1H9xvqDJT9DeVmXUc7d21EqZz1meNdU3qg@mail.gmail.com>
 <20210822223128.GZ543798@ziepe.ca>
 <CAFCwf10LXiAxf7Xr+pMcmSk-_q1FEY_YcBjoH05K0mkK9hMCYA@mail.gmail.com>
 <20210823130419.GA543798@ziepe.ca>
 <CAFCwf11NeJYDMBXaNTpQ+dLecxoAnFYE2Z9T9D4-A5gLtf8q+A@mail.gmail.com>
 <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13LRmez63hGmXMDO2FoC3Qo_2BwtAtnzyJ70=_OcTc23w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 06, 2022 at 11:59:14AM +0300, Oded Gabbay wrote:

> Due to that, we would want to put all the ports under a single struct ib_device,
> as you said it yourself in your original email a year ago.

Yes

> The major constraints are:
> 
> 1. Support only RDMA WRITE operation. We do not support READ, SEND or RECV.
>     This means that many existing open source tests in rdma-core are not
>     compatible. e.g. rc_pingpong.c will not work. I guess we will need to
>     implement different tests and submit them ? Do you have a
> different idea/suggestion ?

I would suggest following what EFA did and just using your own unique
QP with dv accessors to create it. A QP that can only do RDMA WRITE is
not IBA compliant and shouldn't be created by a standard verbs call.
 
> 2. As you mentioned in the original email, we support only a single PD.
>    I don't see any major implication regarding this constraint but please
>    correct me if you think otherwise.

Seems fine

> 3. MR limitation on the rkey that is received from the remote connection
>    during connection creation. The limitation is that our h/w extracts
>    the rkey from the QP h/w context and not from the WQE when sending packets.
>    This means that we may associate only a single remote MR per QP.

It seems OK in the context above where you have your own QP type and
obviouly your specila RDMA WRITE poster will not take in an rkey as
any argument.

>    Do you see any issue here with these two limitations ? One thing we noted is
>    that we need to somehow configure the rkey in our h/w QP context, while today
>    the API doesn't allow it.

When you add your own dv qp create function it will take in the
required rkey during qp creation.
 
>    These limitations are not relevant to a deployment where all the NICs are
>    Gaudi NICs, because we can use a single rkey for all MRs.

Er, that is weird, did you mean to say you have only one MR per PD and
that it always has a fixed value?
 
> 4. We do not support all the flags in the reg_mr API. e.g. we don't
>    support IBV_ACCESS_LOCAL_WRITE. I'm not sure what the
>    implication is here.

It is OK, since you can't issue a local operation WQE anyhow you can
just ignore the flag.

> 5. Our h/w contains several accelerations we would like to utilize.
>    e.g. we have a h/w mechanism for accelerating collective operations
>    on multiple RDMA NICs. These accelerations will require either extensions
>    to current APIs, or some dedicated APIs. For example, one of the
>    accelerations requires that the user will create a QP with the same
>    index on all the Gaudi NICs.

Use your DV interface to do these kinds of things

Thanks,
Jason
