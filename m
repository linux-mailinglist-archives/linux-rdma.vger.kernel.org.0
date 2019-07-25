Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3525D7493A
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbfGYIho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 04:37:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45129 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388546AbfGYIho (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 04:37:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so49742147wre.12
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2019 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wo1+Vdd1yBTT42LZwp3V+1GDrxuisf5Tb8gUFKXEVlo=;
        b=cagU3JASigD51+n5G5vEMJgq8mWwYfi3fM99/+70K0uG/lc29w/BdlSf3MNx4hftAV
         PoiVXgODxHfnFRCG4QchggtpasuzbrHgNw+8rP90SV0pg4OJSAvIO72g9nWHoKvELWVh
         9knKIMaP4dgb387F6Z2FBQLqykP9uix53RkGkq9NwucuCEZ8U3tQ72rNCVhAB4rq0nB9
         s6EbI5WFResRxu2wioBMPiGux3H8qVT1CqVDuhJKPWQaBXUpshD1Ndq4i4kle38xAsbD
         PgNilV2s6WI3YFjI2JW9B4YALPx6XEZhdvHjc4cMmYZT+2kRmWIv6zZAjxcPc3JpBgR9
         uUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wo1+Vdd1yBTT42LZwp3V+1GDrxuisf5Tb8gUFKXEVlo=;
        b=hPvr+dQU6t++FHXkY25Wmf9acWWPsY6YX2RDdJCONjEKoylOd7HHC8mnaqHzlWQapq
         SQJeIc6ojf+K7JElU0Kotj28g7oe5DZ3TPWi3xBcvT1b0XOQntgyfcmkSs9ZumIptEvu
         oe1COxeRHKscJi1RkNQ3MHt+s22L2g274Dld4OgyaxsLrvwi1oirKWQysS+r64d/r8yZ
         4rRGRpdJPv7xWTk+fliXGhN61Zkd3L1rV9kDSK73jCnz8wkQbyjK4eQ4zEntI0LmLU11
         02nSGYsG/5erfL4xANbAXSGWoPV2PDkJGDYEWo9pXWldjnfSOl6MxZN+hAcKGpEfurrG
         tE4g==
X-Gm-Message-State: APjAAAU+C+vxDS85NfpML5SIZra5x5Yxs7+RJnCS0Im9HjtxvvhiIXe2
        4ejNZDB5JHoLnO/rnA1vy2E=
X-Google-Smtp-Source: APXvYqzlzgfjLLOcKmV8lePu1+XhRLWRvxwlfa4Q1PjUDGIlT/OoQl9iz3g1Y92G6BB8LlzMP0z8IQ==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr92622479wrv.180.1564043862319;
        Thu, 25 Jul 2019 01:37:42 -0700 (PDT)
Received: from kheib-workstation (bzq-79-176-65-36.red.bezeqint.net. [79.176.65.36])
        by smtp.gmail.com with ESMTPSA id j189sm55387317wmb.48.2019.07.25.01.37.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 01:37:41 -0700 (PDT)
Date:   Thu, 25 Jul 2019 11:37:37 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/3] {cxgb3, cxgb4, i40iw} Report phys_state
Message-ID: <20190725083736.GB11152@kheib-workstation>
References: <20190722070550.25395-1-kamalheib1@gmail.com>
 <20190722134327.GC7607@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722134327.GC7607@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 10:43:27AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 10:05:47AM +0300, Kamal Heib wrote:
> > This series includes three patches that add the support for reporting
> > physical state for the cxgb3, cxgb4, and i40iw drivers via sysfs.
> > 
> > Kamal Heib (3):
> >   RDMA/cxgb3: Report phys_state in query_port
> >   RDMA/cxgb4: Report phys_state in query_port
> >   RDMA/i40iw: Report phys_state in query_port
> > 
> >  drivers/infiniband/hw/cxgb3/iwch_provider.c | 16 +++++++++++-----
> >  drivers/infiniband/hw/cxgb4/provider.c      | 16 +++++++++++-----
> >  drivers/infiniband/hw/i40iw/i40iw_verbs.c   |  7 +++++--
> >  3 files changed, 27 insertions(+), 12 deletions(-)
> 
> Lets not have this generic iwapr code open coded please.
> 
> The core code already knows what the netdev is for the iWarp device.
> 
> Jason

I'm not sure if I truly understand what you are trying to say here.

Could you please add more info?

Thanks,
Kamal
