Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC94AA31
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfFRSqz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 14:46:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40526 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfFRSqz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 14:46:55 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so16676698qtn.7
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ha2EyIfYXF22QF52W+p7tjwrs6cBRLT4vNGFSyQgHAQ=;
        b=jEkp82rLcQvFwiVELqePHEzIxyTzWkp+U84b7P6NPOQC+XkgaAzDFozIe+diE6KxhQ
         SmdvCRWtxnI8WPVz6ymVYe2nbcPRiNpLH6jQJ4b7cWamrFWdIUHah550ub7bGy2EBwvL
         BjvM+3xOPPmuFqJ4ocq3DFrllLjcTpugXRfDnIir25VoyxkNUYxnvK6RQwtFOwAV3y65
         W0b+SF654WZUcoXzKV0ufjmPK2SphiiVZOr0b/5T7xja04ryxT0/+fswOV0tgnI46wEb
         qjxtpstzwm6PRCEKIvxqRGMl13zra9PNcX00Aufu0S8ixydMtFfFnT9vJAdtEgBeC2/K
         QiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ha2EyIfYXF22QF52W+p7tjwrs6cBRLT4vNGFSyQgHAQ=;
        b=WA8RPcG0Y/W7m6VMWy3aY6lBeBb9pF7N8fY9+b+GIVsBvkIGa4WE/o9kjkMaEZT7Vi
         Y2zK5ecV8l5rH1Rv1ZZ1UjLYM2RoDA3RrHlxaArOdMLSth5NEYQETvs7QV7P1M90hDM1
         vQp/HvLsuogkeL2C7AcuuzwdBp6c18WwJLp6lbMXoflDxGVhvGfX+SQNZ7O7YFbYOTeL
         gE3+iatHrs6SsEIQ/zv2+bvYfX9nCddGCGG9yTlfsgU/+4p+WY+zQ7NQ+jaMMvKwgHmd
         zOWrCtF+nCa1Vsoh30fQNYQXeJpxUkE8fSADHAT0Fw/ZXdwgBNBu4DmIczroYEUvpIYI
         o4Ug==
X-Gm-Message-State: APjAAAUx/Oafr7kMV5stwIDcnxqyxeGp3l3B/+F6dZiFKFEEc/23zlkm
        kyk/AaRMqW7PF5yRa1PwYiMpcQ==
X-Google-Smtp-Source: APXvYqygkS11it+V7jC4U5BJsu98+uOSH4uLX+MaaEAAKPyWF7GN1eW4NVx2XzlxslDDwPinBoiMyg==
X-Received: by 2002:ac8:520e:: with SMTP id r14mr99773776qtn.50.1560883614382;
        Tue, 18 Jun 2019 11:46:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s35sm9946969qth.79.2019.06.18.11.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 11:46:53 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdJ89-0008VZ-Cb; Tue, 18 Jun 2019 15:46:53 -0300
Date:   Tue, 18 Jun 2019 15:46:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190618184653.GM6961@ziepe.ca>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <20190618121709.GK4690@mtr-leonro.mtl.com>
 <20190618131019.GE6961@ziepe.ca>
 <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
 <20190618165338.GO4690@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618165338.GO4690@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 07:53:38PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 18, 2019 at 11:55:08AM -0400, Doug Ledford wrote:
> > On Tue, 2019-06-18 at 10:10 -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 18, 2019 at 03:17:09PM +0300, Leon Romanovsky wrote:
> > > > >  /**
> > > > >   * ib_set_client_data - Set IB client context
> > > > >   * @device:Device to set context for
> > > > > diff --git a/drivers/infiniband/core/nldev.c
> > > > > b/drivers/infiniband/core/nldev.c
> > > > > index 69188cbbd99bd5..55eccea628e99f 100644
> > > > > +++ b/drivers/infiniband/core/nldev.c
> > > > > @@ -120,6 +120,9 @@ static const struct nla_policy
> > > > > nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
> > > > >  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type =
> > > > > NLA_NUL_STRING,
> > > > >  				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN
> > > > > },
> > > > >  	[RDMA_NLDEV_NET_NS_FD]			= { .type =
> > > > > NLA_U32 },
> > > > > +	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type =
> > > > > NLA_NUL_STRING,
> > > > > +				    .len = 128 },
> > > > > +	[RDMA_NLDEV_ATTR_PORT_INDEX]		= { .type = NLA_U32 },
> > > >
> > > > It is wrong, we already have RDMA_NLDEV_ATTR_PORT_INDEX declared in
> > > > nla_policy.
> > > > But we don't have other RDMA_NLDEV_ATTR_CHARDEV_* declarations
> > > > here.
> > >
> > > Doug can you fix it?
> >
> > I haven't pushed my wip to for-next yet, so yeah, I can fix it.  We
> > just need to decide on what the full fix is ;-)
> >
> > Drop the duplicate ATTR_PORT_INDEX, but what about a final decision on
> > including the outputs for possible future type checking?  You and Leon
> > seem to be going back and forth, and I don't have strong feelings
> > either way on this one.  It's just a definition statement, not like
> > it's a dead subroutine.
> 
> I have a very strong opinion about it.

Then Doug should add the policies, here are the output values from the
userspace:

        [RDMA_NLDEV_ATTR_CHARDEV] = { .type = NLA_U64 },
        [RDMA_NLDEV_ATTR_CHARDEV_ABI] = { .type = NLA_U64 },
        [RDMA_NLDEV_ATTR_DEV_INDEX] = { .type = NLA_U32 },
        [RDMA_NLDEV_ATTR_DEV_NODE_TYPE] = { .type = NLA_U8 },
        [RDMA_NLDEV_ATTR_NODE_GUID] = { .type = NLA_U64 },
        [RDMA_NLDEV_ATTR_UVERBS_DRIVER_ID] = { .type = NLA_U32 },
        [RDMA_NLDEV_ATTR_CHARDEV_NAME] = { .type = NLA_NUL_STRING },
        [RDMA_NLDEV_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING },
        [RDMA_NLDEV_ATTR_DEV_PROTOCOL] = { .type = NLA_NUL_STRING },
        [RDMA_NLDEV_ATTR_FW_VERSION] = { .type = NLA_NUL_STRING },

Jason
