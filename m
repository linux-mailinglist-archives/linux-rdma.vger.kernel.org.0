Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3432C2297DE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgGVMIW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 08:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMIW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 08:08:22 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80DC0619DC
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 05:08:21 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id u8so863251qvj.12
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jul 2020 05:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hj6XgX8Y0vPYBNaytHRV0GJe28+NuFfmKzNb05UtU+I=;
        b=KpUBPsVntGXgiogdbmKigO9DeweuXOyEK4P/dNuxqkdY1xuu3QLqKdDE+fpJF3JkUh
         FAiV1CybnGx3pvEs5EppekYT8CzCONyoo4HkazzeW7lThj6EQzvEpo3FPJ9hx6uRQmCA
         hnY4euvxIDjZTMRAO+2MsksmmSn0vgTAinUXTcVqZNskN/odAM6o1kTxsNHGTyXx250l
         l9++uJNdUdN77VqmljZ2ae5ffWFT5EILoCuXuCwQAKmi5dzY3cc18FkYwa22+NxKPErE
         FEQBbhSmQWCNCTm1MmjsnoV3l0Ua6mADrCR9Z7kGDDDrMUPTUDd3u+oOQpjyhScKLuCu
         p8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hj6XgX8Y0vPYBNaytHRV0GJe28+NuFfmKzNb05UtU+I=;
        b=rdftVyjSsmx/UJV11j+sccXcRQkCiMLQFk2ZNDy4uDih2EbbVEPX/YHutkl6Q5DCKi
         wTW1w/+m30FwDulqBRSAcfFSk9rAqOL6hjq8QH+OcreLdBaMvbVcYewy4hHvqrivibY8
         txWd8C6WtnuC1wI+f1iZHfYnQLvIi25bUF2/oA+J2Eg2zSGwdHT+CO6TAyILfdBzlEA6
         qQlf8zx8NFvKzU6pfv72If3UrHIvGrf1p6gHmwCV9sm9qDjTr6uf30OCd23WlUOt5ggC
         WhDlQTtaQA5hg9GXGvelqD9JeSlzkU3ouJhZMtKiTv3iNCidcNmqJVgWwm1V3GG0dCgf
         E3Fg==
X-Gm-Message-State: AOAM533fqbHFIzPqLzVpxNsZs4IZxsK1GqNJfe64hgXMYgluP1iw2UNl
        bW5nxc2Qv2t6aQO6ynu2asX1Vw==
X-Google-Smtp-Source: ABdhPJzjlypQZ8HE7Q525xh25tbpb4nmRlCio+aY18PWSegr9fZrl+uzjIIxvTrNiMyAugsGAQ7KHg==
X-Received: by 2002:a05:6214:925:: with SMTP id dk5mr31653149qvb.183.1595419700934;
        Wed, 22 Jul 2020 05:08:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d8sm4131633qtr.12.2020.07.22.05.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:08:19 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyDXn-00DgWU-87; Wed, 22 Jul 2020 09:08:19 -0300
Date:   Wed, 22 Jul 2020 09:08:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Shadi Ammouri <sammouri@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v3 3/4] RDMA/efa: User/kernel compatibility
 handshake mechanism
Message-ID: <20200722120819.GI25301@ziepe.ca>
References: <20200721133049.74349-1-galpress@amazon.com>
 <20200721133049.74349-4-galpress@amazon.com>
 <20200722115548.GH25301@ziepe.ca>
 <15fcfced-0f4b-563e-7d7f-d448c66201c1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15fcfced-0f4b-563e-7d7f-d448c66201c1@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 22, 2020 at 03:04:20PM +0300, Gal Pressman wrote:
> On 22/07/2020 14:55, Jason Gunthorpe wrote:
> > On Tue, Jul 21, 2020 at 04:30:48PM +0300, Gal Pressman wrote:
> >> Introduce a mechanism that performs an handshake between the userspace
> >> provider and kernel driver which verifies that the user supports all
> >> required features in order to operate correctly.
> >>
> >> The handshake verifies the needed functionality by comparing the
> >> reported device caps and the provider caps. If the device reports a
> >> non-zero capability the appropriate comp mask is required from the
> >> userspace provider in order to allocate the context.
> >>
> >> Reviewed-by: Shadi Ammouri <sammouri@amazon.com>
> >> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> >> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >>  drivers/infiniband/hw/efa/efa_verbs.c | 49 +++++++++++++++++++++++++++
> >>  include/uapi/rdma/efa-abi.h           | 10 ++++++
> >>  2 files changed, 59 insertions(+)
> >>
> >> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >> index 26102ab333b2..7ca40df81ee5 100644
> >> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >> @@ -1501,11 +1501,48 @@ static int efa_dealloc_uar(struct efa_dev *dev, u16 uarn)
> >>  	return efa_com_dealloc_uar(&dev->edev, &params);
> >>  }
> >>  
> >> +#define EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)                         \
> >> +	(!(_dev)->dev_attr._attr || ((_comp_mask) & (_mask)))
> >> +
> >> +#define DEFINE_COMP_HANDSHAKE(_dev, _comp_mask, _attr, _mask)                  \
> >> +	{                                                                      \
> >> +		.attr = #_attr,                                                \
> >> +		.check_comp = EFA_CHECK_COMP(_dev, _comp_mask, _attr, _mask)   \
> >> +	}
> >> +
> >> +int efa_user_comp_handshake(const struct ib_ucontext *ibucontext,
> >> +			    const struct efa_ibv_alloc_ucontext_cmd *cmd)
> >> +{
> >> +	struct efa_dev *dev = to_edev(ibucontext->device);
> >> +	int i;
> >> +	struct {
> >> +		char *attr;
> >> +		bool check_comp;
> >> +	} user_comp_handshakes[] = {
> >> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, max_tx_batch,
> >> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_TX_BATCH),
> >> +		DEFINE_COMP_HANDSHAKE(dev, cmd->comp_mask, min_sq_depth,
> >> +				      EFA_ALLOC_UCONTEXT_CMD_COMP_MIN_SQ_WR),
> >> +	};
> > 
> > This seems like a very expensive construct
> > 
> > Why have the array at all? Just list the macros and have them jump to
> > err
> 
> Do you mean:
> 
> if (CHECK_COMP(x1)) {
>     ibdev_dbg(err);
>     goto err;
> }
> 
> if (CHECK_COMP(x2)) {
>     ibdev_dbg(err);
>     goto err;
> }
> 
> [...]
> 
> That adds much more boilerplate code for each feature. Or do you have something
> else in mind?

#define DO_COMP_HANDSHAKE() \
    if (...) goto err

DO_COMP_HANDSHAKE(x1)
DO_COMP_HANDSHAKE(2)

Jason
