Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2388A6103A
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jul 2019 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfGFLCg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Jul 2019 07:02:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfGFLCf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Jul 2019 07:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8bLQc4+RPGotEzco/YjdaD/+helrJCqU8PeAI1M0qSQ=; b=ZPP5RO11GzD09S5etzsYF1wXu
        /fKzci7MtBLdaysUHf5o5RClkPbEs6X2shUpRPUREakJM8OL/smrTQGfLlVHpWHxZDEcHkX999Ai3
        CYNOjPthN/zWYU2K7y16WSh6SyGOOsgUKV3ELg3bICDCVoaYl9A6e5VKRybKX4YBwR2UC95pdkRme
        p5aMawg+IspThiUHeA3XDtlb7/DX3SyjKy1WkXuC2AdJXI3daYj/aMIa15VAo192R+nWjSRWF79iv
        oXnBDB3RU7i7P9FKffe9FdFPch8l0XCptogdlC+Ad0NOSv35P4xyoMg9MYT0M+TW5+Mu8NTEVlnbx
        DmLwUy9Hw==;
Received: from 177.205.70.5.dynamic.adsl.gvt.net.br ([177.205.70.5] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjiSg-00067V-KD; Sat, 06 Jul 2019 11:02:35 +0000
Date:   Sat, 6 Jul 2019 08:02:30 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 01/43] docs: infiniband: convert docs to ReST and rename
 to *.rst
Message-ID: <20190706080230.6e34bda2@coco.lan>
In-Reply-To: <20190703180641.GA26394@ziepe.ca>
References: <cover.1561723979.git.mchehab+samsung@kernel.org>
        <4d843d0361e245861f7051e2c736a18dfaae7601.1561723980.git.mchehab+samsung@kernel.org>
        <20190703180641.GA26394@ziepe.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Em Wed, 3 Jul 2019 15:06:41 -0300
Jason Gunthorpe <jgg@ziepe.ca> escreveu:

> On Fri, Jun 28, 2019 at 09:19:57AM -0300, Mauro Carvalho Chehab wrote:
> > The InfiniBand docs are plain text with no markups.
> > So, all we needed to do were to add the title markups and
> > some markup sequences in order to properly parse tables,
> > lists and literal blocks.
> > 
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  .../{core_locking.txt => core_locking.rst}    |  64 ++++++-----
> >  Documentation/infiniband/index.rst            |  23 ++++
> >  .../infiniband/{ipoib.txt => ipoib.rst}       |  24 ++--
> >  .../infiniband/{opa_vnic.txt => opa_vnic.rst} | 108 +++++++++---------
> >  .../infiniband/{sysfs.txt => sysfs.rst}       |   4 +-
> >  .../{tag_matching.txt => tag_matching.rst}    |   5 +
> >  .../infiniband/{user_mad.txt => user_mad.rst} |  33 ++++--
> >  .../{user_verbs.txt => user_verbs.rst}        |  12 +-
> >  drivers/infiniband/core/user_mad.c            |   2 +-
> >  drivers/infiniband/ulp/ipoib/Kconfig          |   2 +-
> >  10 files changed, 174 insertions(+), 103 deletions(-)
> >  rename Documentation/infiniband/{core_locking.txt => core_locking.rst} (78%)
> >  create mode 100644 Documentation/infiniband/index.rst
> >  rename Documentation/infiniband/{ipoib.txt => ipoib.rst} (90%)
> >  rename Documentation/infiniband/{opa_vnic.txt => opa_vnic.rst} (63%)
> >  rename Documentation/infiniband/{sysfs.txt => sysfs.rst} (69%)
> >  rename Documentation/infiniband/{tag_matching.txt => tag_matching.rst} (98%)
> >  rename Documentation/infiniband/{user_mad.txt => user_mad.rst} (90%)
> >  rename Documentation/infiniband/{user_verbs.txt => user_verbs.rst} (93%)  
> 
> I'm not sure anymore if I sent a note or not, but this patch was
> already applied to the rdma.git:
> 
> commit 97162a1ee8a1735fc7a7159fe08de966d88354ce
> Author: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Date:   Sat Jun 8 23:27:03 2019 -0300
> 
>     docs: infiniband: convert docs to ReST and rename to *.rst
>     
>     The InfiniBand docs are plain text with no markups.  So, all we needed to
>     do were to add the title markups and some markup sequences in order to
>     properly parse tables, lists and literal blocks.
>     
>     At its new index.rst, let's add a :orphan: while this is not linked to the
>     main index.rst file, in order to avoid build warnings.
>     
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>     Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Ah, ok, thanks!

Not sure why but this one still applies on the top of -next.
Probably just the usual merge noise that happens close to
a new merge window.

Thanks,
Mauro
