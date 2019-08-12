Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC93989DF0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 14:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfHLMS3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 08:18:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39289 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbfHLMSW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Aug 2019 08:18:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id 125so3680895qkl.6
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2019 05:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urT/w4DRsSK3AOkOvSyvpNei0u7r+kgvyvvqiee420c=;
        b=geAFiwHXv9J+WNeBrl0T55TNvcr6N/UKv1KlY/sQupgdY00vaP3gU3Yzf/yt/ow9Sv
         0QIddqKyqz/4QGnbZ85xhUQ0mm+NwrZiMc1ahmQPIBQvYprfx8qBDQ0N/zhXLpWCDJkO
         k5FHjqRik3830FUBorEn+YvaO7FZ/UuhAo2nlBo6GxXkonJVuR9muvXh/cNsCe5Gl9RQ
         +0qcxozZ8OyjsW7qgWCLWAPPRh1PYYxyytFTD97mEUJp1iABXCz8c90825ZACSu/XTjd
         oh1fDmIvRhAD+Tugrc+QeXwmF2cI+rQhbuVQYXIlpdo4h86ZrcwVRi/z6Kwz5Q0sO6cH
         VpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urT/w4DRsSK3AOkOvSyvpNei0u7r+kgvyvvqiee420c=;
        b=fSQwfS5dnZ3YN4q1e2x+nHMgF9/1HsrDL7663icdsBsxanzsehOzdXWOu++jB8fadP
         sL/nyWtTFY8sk+HtGY0rg+ujwXP2q27mFUpTtG/r1SobgrKxZYsrf01HqkYHrsBa3sxb
         +YvUuIIRqAsW+1hirbD3aeU/L5t6QWziewDrO9rSXxVo90pgpB7/sdlUZhbLt/2B49pq
         rGEFySOS2Ga4ifn/GrYLQz8TUnTK1AOfPkU7I/fYTILveC//hS5QnKX9LGdhW5RU1mqV
         lpT2QIOUlbzwQZvvltUQbc0WTdKJC2bv+XsQM14dw5UCMYuKadwu9BX5Po9aQ9nPRF6U
         RbNw==
X-Gm-Message-State: APjAAAXdaMxKSY5mgnag7fqvzonIRDhBM2pUtbBRO+p/bJkrf/r8pIBz
        6fcPRznW2Av6p9p7FOzMbBgowg==
X-Google-Smtp-Source: APXvYqx+Em5tNLy23hTbWmjL4JGjVtpsKP6+UBPUVf32h0y+4Jl2RqnO06XLiX0GVHa4PKwDP5eXtg==
X-Received: by 2002:a37:af82:: with SMTP id y124mr7241291qke.311.1565612301852;
        Mon, 12 Aug 2019 05:18:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r4sm42078682qtt.51.2019.08.12.05.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 05:18:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hx9HI-00073k-FC; Mon, 12 Aug 2019 09:18:20 -0300
Date:   Mon, 12 Aug 2019 09:18:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>
Subject: Re: [PATCH for-next V4 0/4] RDMA: Cleanups and improvements
Message-ID: <20190812121820.GB24457@ziepe.ca>
References: <20190807103138.17219-1-kamalheib1@gmail.com>
 <70ab09ce261e356df5cce0ef37dca371f84c566a.camel@redhat.com>
 <20190808075441.GA28049@mtr-leonro.mtl.com>
 <feab2a069bf9ac1e3c627373add292a77db86be0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feab2a069bf9ac1e3c627373add292a77db86be0.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 08, 2019 at 04:38:19PM -0400, Doug Ledford wrote:
> On Thu, 2019-08-08 at 10:54 +0300, Leon Romanovsky wrote:
> > On Wed, Aug 07, 2019 at 03:56:26PM -0400, Doug Ledford wrote:
> > > On Wed, 2019-08-07 at 13:31 +0300, Kamal Heib wrote:
> > > > This series includes few cleanups and improvements, the first
> > > > patch
> > > > introduce a new enum for describing the physical state values and
> > > > use
> > > > it
> > > > instead of using the magic numbers, patch 2-4 add support for a
> > > > common
> > > > query port for iWARP drivers and remove the common code from the
> > > > iWARP
> > > > drivers.
> > > > 
> > > > Changes from v3:
> > > > - Patch #1:
> > > > 
> > > > Changes from v2:
> > > > - Patch #1:
> > > > - Patch #3:
> > > > 
> > > > Changes from v1 :
> > > > - Patch #3:
> > > > 
> > > > Kamal Heib (4):
> > > >   RDMA: Introduce ib_port_phys_state enum
> > > >   RDMA/cxgb3: Use ib_device_set_netdev()
> > > >   RDMA/core: Add common iWARP query port
> > > >   RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
> > > 
> > > Thanks, series applied to for-next.
> > 
> > Doug,
> > 
> > First patch is not accurate and need to be reworked/discussed.
> > 
> > first, it changed "Phy Test" output to be "PhyTest" and second
> > "<unknown>" was changed to be "Unknown". I don't think that it is a
> > big
> > deal, but who knows what will break after this change.
> 
> A quick grep -r of rdma-core for "Phy Test" and "unknown" says nothing
> will break, but that doesn't attest to anything else.
> 
> It is also still in my wip branch, so can be fixed directly if needed.

There is no reason to change the text so we should fix it

Jason
