Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9D322983C
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGVMaa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 08:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGVMaa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 08:30:30 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27208C0619DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 05:30:29 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so1389281qtt.13
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lnsIFlnai9mxsKneEWJdOUjlrgS9boAYpwVL4fKxOGA=;
        b=eKj4wnGY8xfLRW1U+nJu21kdvFtjGbEJFUAPTZa+vWCj6Ic+YqJVGP/4nyBDAqNZVB
         3gL6FuhOwGJf0vNLjzAV4Z28y2QeKLg20YQ3sTTyvzdIGuwvwFI7jZB0RMZ19Cl7FRSj
         66ih0K+sRxYDnafAcBgcED3I2AtO672P6sh7AoKT++R50fL6ArHvpTuqhvRg+bWcpEnp
         5q13JPaEBFaL7/DN2SzAsozsiu2BEpqgI0l7YdUoLfw3bucKaZjwEn7SWiVMWxKzfAXv
         g3Q5bPA/D4DyGDjv8Fkn06x3qwdCTyubsrd89/i4yZIEWFt91AFBQCSQPyJAGvad2BEy
         FwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnsIFlnai9mxsKneEWJdOUjlrgS9boAYpwVL4fKxOGA=;
        b=cqigaDINAiQoqBKHUsM50SY1APzPJIiUGjOhFkVFEgnIgmZ/BkG1nZHk0nbLha/3KR
         IIuVoAmcch8A5zKWs5ICzHTMT2b5f1cu7m/lX5oZHNPzltJ3I5ec9YwWr+y/UwFCUwtm
         0dcEbX/PGwZVIOdGoHkIOVbgGYXAWgLcpfWkVTVygvxL0gONsE1GI6bdqI3drU7aNEmJ
         VAq+IW1v09/52g32DaPU8DsevzSOLjgR2PTVBGGM+qZPByS0ixb0uSJNTSPDOVeC8WJr
         ePKbt1aBoUIMSjr1w7aenW7BswcY1A01j9Y2vkCqVw+nRDCKrtHQqOEHCLogiDzglmPu
         4W3g==
X-Gm-Message-State: AOAM532lKJgEJilJwacJs/HM8W2Y2IpJ4KUMA1aXcnBF6nFzdSu5SwgC
        ArQD0eoDtl69kqJ0SOPyEestgA==
X-Google-Smtp-Source: ABdhPJxpm1vuJ6vjlaahgM7Y4aTVtbSYH0mVUC4auLDGXvE1f7J3bktTNO1qBtYDLwkiWrpUBZMSrg==
X-Received: by 2002:ac8:168d:: with SMTP id r13mr33896004qtj.207.1595421028332;
        Wed, 22 Jul 2020 05:30:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j72sm5212980qke.20.2020.07.22.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:30:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyDtC-00Dh65-Ly; Wed, 22 Jul 2020 09:30:26 -0300
Date:   Wed, 22 Jul 2020 09:30:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v3 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
Message-ID: <20200722123026.GJ25301@ziepe.ca>
References: <20200721133049.74349-1-galpress@amazon.com>
 <20200721133049.74349-4-galpress@amazon.com>
 <20200722115548.GH25301@ziepe.ca>
 <15fcfced-0f4b-563e-7d7f-d448c66201c1@amazon.com>
 <20200722120819.GI25301@ziepe.ca>
 <790570eb-dfcf-9763-fada-9faca569da7a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790570eb-dfcf-9763-fada-9faca569da7a@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 03:13:57PM +0300, Gal Pressman wrote:
> On 22/07/2020 15:08, Jason Gunthorpe wrote:
> > On Wed, Jul 22, 2020 at 03:04:20PM +0300, Gal Pressman wrote:
> >> On 22/07/2020 14:55, Jason Gunthorpe wrote:
> >>> On Tue, Jul 21, 2020 at 04:30:48PM +0300, Gal Pressman wrote:
> >>>> Introduce a mechanism that performs an handshake between the userspace
> >>>> provider and kernel driver which verifies that the user supports all
> >>>> required features in order to operate correctly.
> >>>>
> >>>> The handshake verifies the needed functionality by comparing the
> >>>> reported device caps and the provider caps. If the device reports a
> >>>> non-zero capability the appropriate comp mask is required from the
> >>>> userspace provider in order to allocate the context.
> >>>>
> >>>> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
> >>>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>>>  drivers/infiniband/hw/efa/efa_verbs.c | 49 +++++++++++++++++++++++++++
> >>>>  include/uapi/rdma/efa-abi.h           | 10 ++++++
> >>>>  2 files changed, 59 insertions(+)
> >>>>
> >>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >>>> index 26102ab333b2..7ca40df81ee5 100644
> >>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >>>> @@ -1501,11 +1501,48 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
> >>>>  	return efa_com_dealloc_uar(&dev->edev, &params);
> >>>>  }
> >>>>  
> >>>> +#define EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)                         \
> >>>> +	(!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask)))
> >>>> +
> >>>> +#define DEFINE_COMP_HANDSHAKE(_dev, _comp_mask, _attr, _mask)                  \
> >>>> +	{                                                                      \
> >>>> +		.attr = #_attr,                                                \
> >>>> +		.check_comp = EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)   \
> >>>> +	}
> >>>> +
> >>>> +int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
> >>>> +			    const struct efa_ibv_alloc_ucontext_cmd *cmd)
> >>>> +{
> >>>> +	struct efa_dev *dev = to_edev(ibucontext->device);
> >>>> +	int i;
> >>>> +	struct {
> >>>> +		char *attr;
> >>>> +		bool check_comp;
> >>>> +	} user_comp_handshakes[] = {
> >>>> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, max_tx_batch,
> >>>> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
> >>>> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, min_sq_depth,
> >>>> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR),
> >>>> +	};
> >>>
> >>> This seems like a very expensive construct
> >>>
> >>> Why have the array at all? Just list the macros and have them jump to
> >>> err
> >>
> >> Do you mean:
> >>
> >> if (CHECK_COMP(x1)) {
> >>     ibdev_dbg(err);
> >>     goto err;
> >> }
> >>
> >> if (CHECK_COMP(x2)) {
> >>     ibdev_dbg(err);
> >>     goto err;
> >> }
> >>
> >> [...]
> >>
> >> That adds much more boilerplate code for each feature. Or do you have something
> >> else in mind?
> > 
> > #define DO_COMP_HANDSHAKE() \
> >     if (...) goto err
> > 
> > DO_COMP_HANDSHAKE(x1)
> > DO_COMP_HANDSHAKE(2)
> 
> I'd rather not have gotos inside macros, I find that very confusing.
> I can add the ifs I suggested if you want the array removed.

IHMO it barely seems worth all the macros in the first place, and
constructing that whole array on the stack at runtime is pretty
horrible

Jason
