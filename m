Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED9BA62707
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2019 19:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389799AbfGHRZa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Jul 2019 13:25:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34651 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389945AbfGHRZa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Jul 2019 13:25:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so11194568qtq.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jul 2019 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ku/o68pleqE6un6ZW/BvkhdW//GDmVPordPUQ3yzu6U=;
        b=aE8JZ4oLuploE3xF/JrOpdr9AoVRhkEOsLUz30R2UjWMXOkivBepSb7ZtC0ZX+KsXy
         3jJydV56/hO6tGXVAMdnk5HMzPdKt86jE10qCn/1Gf88ooDqWjePCTTNZ0F+BSMBygqX
         YPq3EkN9XpWd27tk+5DaiRPVF5jljyVG7WLFWT1raAYswkHluQ+WIivkJ/9MijGIrDSx
         woUAgC/OYAaDLs3ChTeqeOT97WIiKsdJIuVECqzzDxRRnFjmfYc0TVVKBO4QBv1Yc2gL
         zNp5fGpXei7QgoOsN3bD6RPxGHKUtvFfX0ZuijlV/H08KY1uKgW6HuDlLPmodBgLWv82
         dkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ku/o68pleqE6un6ZW/BvkhdW//GDmVPordPUQ3yzu6U=;
        b=lMrwMbPKpbp65f7/+JXu4alvmNZVM9/LxRMtjvJh7TAinrE7RKreGTKKRaZJpcwS57
         V7OIIEHBbFlL0cjKyplN3L7taDHux/+L9Pz5b/ihapFFKhOCpop4Bwn/9RD2DTy2OBc7
         RNowjqbL4s+W/0386Cm4bd2j9tAw4yzlVpwJDBpTYzKR/LmVgvDdLUrmcow2A4GgBVW2
         s5fzHTv/uVijeG3nmJ6g62PKDYRozjPHkQ6jeaK0Db5R9ZNl6X91Dq9QqyngzYiMyXDo
         45WhIRrnSfFGW5Ve+68AMNoSeyhs7WMylqB2IX2ECEmRL7aYOL+NYWDnuF3eZRSB3DTL
         DS+A==
X-Gm-Message-State: APjAAAVLHTU8F6T9ZMSUtUInWOfh8k82vtdCa4F17wPTyOYTVu2QyiR7
        YmpdBGOn93ILPjICj3iL7qFFMQ==
X-Google-Smtp-Source: APXvYqxo7P6BBN+I5qF/OaEb7YKPon028ElmrspccvTXQPbFVXwjbGN4QtHkhSa38AtF7UfZ251zUw==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr15087393qtk.68.1562606729322;
        Mon, 08 Jul 2019 10:25:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t2sm9809926qth.33.2019.07.08.10.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jul 2019 10:25:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hkXOK-0007Ke-A9; Mon, 08 Jul 2019 14:25:28 -0300
Date:   Mon, 8 Jul 2019 14:25:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 35/39] docs: infiniband: add it to the driver-api bookset
Message-ID: <20190708172528.GC23996@ziepe.ca>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
 <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
 <20190703180802.GA26557@ziepe.ca>
 <20190706081950.4a629537@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190706081950.4a629537@coco.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 06, 2019 at 08:19:50AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 3 Jul 2019 15:08:02 -0300
> Jason Gunthorpe <jgg@ziepe.ca> escreveu:
> 
> > On Fri, Jun 28, 2019 at 09:30:28AM -0300, Mauro Carvalho Chehab wrote:
> > > While this contains some uAPI stuff, it was intended to be
> > > read by a kernel doc. So, let's not move it to a different
> > > dir, but, instead, just add it to the driver-api bookset.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > >  Documentation/index.rst            | 1 +
> > >  Documentation/infiniband/index.rst | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > > index ea33cbbccd9d..e69d2fde7735 100644
> > > +++ b/Documentation/index.rst
> > > @@ -96,6 +96,7 @@ needed).
> > >     block/index
> > >     hid/index
> > >     iio/index
> > > +   infiniband/index
> > >     leds/index
> > >     media/index
> > >     networking/index
> > > diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
> > > index 22eea64de722..9cd7615438b9 100644
> > > +++ b/Documentation/infiniband/index.rst
> > > @@ -1,4 +1,4 @@
> > > -:orphan:
> > > +.. SPDX-License-Identifier: GPL-2.0
> > >  
> > >  ==========
> > >  InfiniBand  
> > 
> > Should this one go to the rdma.git as well? It looks like yes
> 
> I'm OK if you want to add to rdma.git. However, this will likely rise 
> conflicts, though, as this series has lots of other patches touching
> Documentation/index.rst. 

Applied now, it seems better to keep everything consistent

Jason
