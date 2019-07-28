Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF877EC2
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jul 2019 11:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfG1JXA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jul 2019 05:23:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfG1JXA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Jul 2019 05:23:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so58590091wru.13
        for <linux-rdma@vger.kernel.org>; Sun, 28 Jul 2019 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XS/TbtrDw/wCBH2kSRjqesmZuKsQMi5qDLYpv7C7z94=;
        b=Jp6M38qhP6ohAHBTND9EkbDLcNnlNMJPfywE6XQH6JbRLMY4wCHYRduRexzTl0sdY0
         wRHJ91k+/F7/kEjnGW5zqOnf45poxPCPT2+3I+eVa4qdEIsQfPzETkr+EME+xv35iVxP
         cLRxs8UcFKe3va3FhJqKGIysMoN11kXfWckcw/xJwuZovgor4QCmVWpcyCvPyoZsiWuz
         0OEG2STpvbmSvPHTgKu4uuFTsRUwogTHfbWdV7vvlwhSluk/FiCydJ+1Q59/2gWFzl1z
         LtwFNinDym+sZJx9gQW/+dsDq8pKG9oxVY7Si9x6vYeYnGigxpR0fzz4gqdBr49eqXeA
         hidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XS/TbtrDw/wCBH2kSRjqesmZuKsQMi5qDLYpv7C7z94=;
        b=J0RkDXpfRNiCfy2xNYwjcict1Eni5t1hlILV3OgbjRSucYBA13VY2kBBhqoczGL1ie
         PWaK8+zyHqjQShR8mePMj2wKXSSpElVfjnN27FhyIh3HB6rSbYxpDtSZDNwSJQg58G2P
         6XqoCa1d84Q2CJKUJl9qWuYJilE2NeFvZzs/Wh8ZcbytXvwgQzuDiz9318rsPctA1BFI
         Gwm4ouH7v+yJYNVTeaWMlD4h0xUbJ7rEVaNZbfWdQ9UinT3vYIcfdWn2bmPlEtaFtYzF
         yXeoxwJmBtXHusRakWMJj3sR/0mG6OnLPCKuPNUmGfdPC/tI4C39eQqNf1ppeU6xj5VV
         7/2A==
X-Gm-Message-State: APjAAAUdy9DX5IydFOULE9EyOgg01ATin83sA+HUemw6sjCkZaP/2SpW
        7jm5CWpCPa59flvBj4DkbRI=
X-Google-Smtp-Source: APXvYqy0TlatQJwwUaWxG2OiYDlia2Y6aVUy5bno6QIuJn2UZtz63zEINnP+8xJeYumrHSnsVm5SdA==
X-Received: by 2002:adf:db50:: with SMTP id f16mr103117008wrj.214.1564305778052;
        Sun, 28 Jul 2019 02:22:58 -0700 (PDT)
Received: from kheib-workstation (bzq-79-176-65-36.red.bezeqint.net. [79.176.65.36])
        by smtp.gmail.com with ESMTPSA id 91sm127442640wrp.3.2019.07.28.02.22.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 02:22:57 -0700 (PDT)
Date:   Sun, 28 Jul 2019 12:22:53 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/3] {cxgb3, cxgb4, i40iw} Report phys_state
Message-ID: <20190728092253.GA5250@kheib-workstation>
References: <20190722070550.25395-1-kamalheib1@gmail.com>
 <20190722134327.GC7607@ziepe.ca>
 <20190725083736.GB11152@kheib-workstation>
 <20190725184744.GC7467@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725184744.GC7467@ziepe.ca>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 25, 2019 at 03:47:44PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 25, 2019 at 11:37:37AM +0300, Kamal Heib wrote:
> > On Mon, Jul 22, 2019 at 10:43:27AM -0300, Jason Gunthorpe wrote:
> > > On Mon, Jul 22, 2019 at 10:05:47AM +0300, Kamal Heib wrote:
> > > > This series includes three patches that add the support for reporting
> > > > physical state for the cxgb3, cxgb4, and i40iw drivers via sysfs.
> > > > 
> > > > Kamal Heib (3):
> > > >   RDMA/cxgb3: Report phys_state in query_port
> > > >   RDMA/cxgb4: Report phys_state in query_port
> > > >   RDMA/i40iw: Report phys_state in query_port
> > > > 
> > > >  drivers/infiniband/hw/cxgb3/iwch_provider.c | 16 +++++++++++-----
> > > >  drivers/infiniband/hw/cxgb4/provider.c      | 16 +++++++++++-----
> > > >  drivers/infiniband/hw/i40iw/i40iw_verbs.c   |  7 +++++--
> > > >  3 files changed, 27 insertions(+), 12 deletions(-)
> > > 
> > > Lets not have this generic iwapr code open coded please.
> > > 
> > > The core code already knows what the netdev is for the iWarp device.
> > > 
> > > Jason
> > 
> > I'm not sure if I truly understand what you are trying to say here.
> > 
> > Could you please add more info?
> 
> Implement this in the core code if the port type is iwarp

OK, I'll give it a try.

> 
> Jason

