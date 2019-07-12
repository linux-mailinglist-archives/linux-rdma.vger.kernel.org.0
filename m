Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0506721C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfGLPOZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:14:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34890 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfGLPOZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 11:14:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so8447837qto.2
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1NndeDHC4SKCtD2njC25wcF/fpw0ZFMG+wxyiwc8W7Y=;
        b=l45/aiqYWpvyQ1RtFqL4X2dgQ4zP4rHvDqXZDf+brdvNfOSxkqU5NzKU7E56br/H+e
         zoJ7wBWrL//znBKcRoro1c9RrDoLsxUlUGt0b3WHUvQ1gaOavfbEMrsCEBBw0Zj0iuxp
         41/CfFkA8o6kRCiaXTE1ZeevDGmvF41ji1PiODQU8nizvAgIpiAJdoSlHvLbKodPZb4L
         gXoFZpa+1EKQHdqp9CrqPvV49ZfSKr4i/QcQdaGpudb1mnXU6gXicDgbomjMdopnFJPH
         PXqnAt74gvGMDuT5DzQeeHxli7baf1lzNYDqPHzPlzYkhpOAjqk+jqXegqzk1GCB+A1q
         sECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1NndeDHC4SKCtD2njC25wcF/fpw0ZFMG+wxyiwc8W7Y=;
        b=LZbVrVxLy4NKUjqmwI5Lq3h5jWYwjFZSCBWXLOQd8yoUaD2yZM/m2X+y+vmuTOuMXE
         UmJeibT9LchZd9jec0W1zvPwxUyjy3r/s5fvAtqOyJABh6MTT3GjSPLs6rivMU22F1Tl
         JOmiavBQ4XIu4AQhzQDf22q+sE06jQuf8AFNhIDa5fUsHwCpeDlxA2MrlfRTrFYQNN3s
         Uz54OVuIueYOiNpqlIBKfik0uUeoczvZzR4b66p0qeyofwkO/gpT2gfSA3MvihgaVUYK
         pQm7Ihw1scbR+a0OCTrjmYyHfZdI4NIv9W/zaL18p7mYNSxLcJfBwgROmE5OnOZtJHaz
         JXXA==
X-Gm-Message-State: APjAAAUbo0HoRP9cTaOq4B85rUJ7ZS9cvqETzHkUSpR+g2k7iHNw2iup
        5Vmx0qRtM16FlkRBKcZIpxZrKw==
X-Google-Smtp-Source: APXvYqzVsPvT5muHqZYRh1ti9OhEbH2ZE+gb0xXnUhlfTc2I3i5b2FRluj/KK3RazAZvETosrH8YnA==
X-Received: by 2002:a05:6214:1447:: with SMTP id b7mr7231470qvy.89.1562944464279;
        Fri, 12 Jul 2019 08:14:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d25sm3518972qko.96.2019.07.12.08.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 08:14:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlxFf-0002BK-4s; Fri, 12 Jul 2019 12:14:23 -0300
Date:   Fri, 12 Jul 2019 12:14:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712151423.GG27512@ziepe.ca>
References: <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <20190712120328.GB27512@ziepe.ca>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <CAK8P3a3ZqY_qLSN1gw12EvzLS49RAnmG4nT9=N+Qj9XngQd0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ZqY_qLSN1gw12EvzLS49RAnmG4nT9=N+Qj9XngQd0CA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 03:22:35PM +0200, Arnd Bergmann wrote:
> On Fri, Jul 12, 2019 at 3:05 PM Bernard Metzler <BMT@zurich.ibm.com> wrote:
> 
> >
> > We share CQ (completion queue) notification flags between application
> > (which may be user land) and producer (kernel QP's (queue pairs)).
> > Those flags can be written by both application and QP's. The application
> > writes those flags to let the driver know if it shall inform about new
> > work completions. It can write those flags at any time.
> > Only a kernel producer reads those flags to decide if
> > the CQ notification handler shall be kicked, if a new CQ element gets
> > added to the CQ. When kicking the completion handler, the driver resets the
> > notification flag, which must get re-armed by the application.
> >
> > We use READ_ONCE() and WRITE_ONCE(), since the flags are potentially
> > shared (mmap'd) between user and kernel land.
> >
> > siw_req_notify_cq() is being called only by kernel consumers to change
> > (write) the CQ notification state. We use smp_store_mb() to make sure
> > the new value becomes visible to all kernel producers (QP's) asap.
> >
> >
> > From cfb861a09dcfb24a98ba0f1e26bdaa1529d1b006 Mon Sep 17 00:00:00 2001
> > From: Bernard Metzler <bmt@zurich.ibm.com>
> > Date: Fri, 12 Jul 2019 13:19:27 +0200
> > Subject: [PATCH] Make shared CQ notification flags 32bit to respect 32bit
> >  architectures
> >
> > Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> 
> This fixes the build for me, thanks!
> 
> Tested-by: Arnd Bergmann <arnd@arndb.de>

Since this is coming up so late in the merge window, I'm inclined to
take the simple path while Bernard makes a complete solution
here. What do you think Arnd?

From 0b043644c0ca601cb19943a81aa1f1455dbe9461 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Fri, 12 Jul 2019 12:12:06 -0300
Subject: [PATCH] RMDA/siw: Require a 64 bit arch

The new siw driver fails to build on i386 with

drivers/infiniband/sw/siw/siw_qp.c:1025:3: error: invalid output size for constraint '+q'
                smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);

As it is using 64 bit values with the smp_store_mb.

Since the entire scheme here seems questionable, and we are in the merge
window, fix the compile failures by disabling 32 bit support on this
driver.

A proper fix will be reviewed post merge window.

Fixes: c0cf5bdde46c ("rdma/siw: addition to kernel build environment")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/sw/siw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index b622fc62f2cd6d..dace276aea1413 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,6 +1,6 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
-	depends on INET && INFINIBAND && LIBCRC32C
+	depends on INET && INFINIBAND && LIBCRC32C && 64BIT
 	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
-- 
2.21.0


