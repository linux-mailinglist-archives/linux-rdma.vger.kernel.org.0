Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533845928F
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 06:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF1EVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 00:21:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45581 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF1EVp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jun 2019 00:21:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id z19so1981569pgl.12
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2019 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/XpMubTKWEVE1kXy+59OWuJCKgRmN4x1Bk/PveL5YOg=;
        b=QY2k8KLz8FVg003CFkG1XXJA+uvFmGsbbUlzsqFK8h2JhiIaJAqVMr0EvKpOLYNzKe
         Rx9GA9VY2j4eyu7u8k14zt8r+iZcRObcCYiHmtha7SRIbLxF+WQWBucSa8Ttbw0k38sp
         U4WQzfDnFLUJ678PUUy2Cnj6ihXkTEWghmeHTkveyILL8kfCFCshj5NKWy/0scG56Hch
         U7dghtfSzw3SJ00IG/8u0K8zBeKWyoC/4g0awMGDJrysXCuOq91DBCwePEXiCFj3ePie
         w+OCf1/7mIKwB2irietRt8DRSnCIZvIBZMv+J2za6gJLGNSswiI3+BEOXzqwUGNbHAnt
         LGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/XpMubTKWEVE1kXy+59OWuJCKgRmN4x1Bk/PveL5YOg=;
        b=Ubjz8Eu8+f/+EFyjLn2T5uw4ubYmcB53RDecOr2Id7z4cfBFWPEzQLIP0VJidghnyT
         H5odROrbOmEl1wdhgJptpfuVeIzZZfedol59HV2Gz18zMOME+afVJZg80HZyXPNRbFDl
         ElI3eAf3POrKnpWf22C19fNX65burBPSQv+oh76mOt42xPh46DCJ95vpL4qPa4exLoOu
         Ws6ydqWuuPW5sWDvK2ARu5tMOHqBCdbErrH7RGaBzY7drbbO9uJgMWl58smEKeXSVF8N
         aLauNt/czXoNSMt8vqo0BzXM4ZaAnBBl8jmfT9dffHhjUUsydXYVbHyfz/nzZV221n0c
         VvSQ==
X-Gm-Message-State: APjAAAX3DZQwC0BoxManiBptZVO0xzSNRXXaENwfQeDlaYKC5XurUE6t
        EX59b4rGL9nQQOLA+GRPjv2BDg==
X-Google-Smtp-Source: APXvYqyv2tAjSzml0G00TZQjj6VsPj/I5aLRnZ27UFg+JC95CuGttkftQPpQkgYXq0dOxFlMZx7sRA==
X-Received: by 2002:a63:514e:: with SMTP id r14mr7130706pgl.71.1561695704414;
        Thu, 27 Jun 2019 21:21:44 -0700 (PDT)
Received: from ziepe.ca ([38.88.19.130])
        by smtp.gmail.com with ESMTPSA id f10sm644815pfd.151.2019.06.27.21.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 21:21:43 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hgiON-0000zC-5o; Fri, 28 Jun 2019 01:21:43 -0300
Date:   Fri, 28 Jun 2019 01:21:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Gal Pressman <galpress@amazon.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Message-ID: <20190628042143.GB3705@ziepe.ca>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <MN2PR18MB3182402E20F3A908B700CB62A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3182402E20F3A908B700CB62A1FD0@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 27, 2019 at 09:35:16PM +0000, Michal Kalderon wrote:
> > > The flags taken from EFA aren't necessarily going to work for other drivers.
> > > Maybe the flags bits should be opaque to ib_core and leave the actual
> > > mmap callbacks in the drivers. Not sure how dealloc_ucontext is going
> > > to work with opaque flags though?
> > 
> > Yes, the driver will have to take care of masking the flags before lookup
> 
> The efa flags seemed pretty generic, perhaps we should have two sets ? 
> This way if a driver ( like mlx5) has additional flags it can have it's own
> Mmap function and for the generic flags call the common mmap function. 

The flags are part of the driver ABI, so to convert anything to use
this new common code still requires the driver to process its
historical flag values somehow...

Jason
