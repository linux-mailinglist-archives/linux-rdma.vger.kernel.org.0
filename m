Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF64061066
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jul 2019 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfGFLTz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 6 Jul 2019 07:19:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfGFLTz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 6 Jul 2019 07:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eAaoeydu5/7mUiHaUSIJXkqgFNZi4v8q6elnU4LELEc=; b=HM9aBZZ88EbUMezo9xeghq0JB
        BOxyGdDGNE3KI259r57Tvc8tCjHrFND3Uw6hWJ8OzwZgyntlankqMNX4agY0yNi5NEmlPpSBJPWLU
        QXO7JFKABLWhvMXrKmgg5mLflV4M2gvt3efrMzOYrpBJqUpkfrDLoFsxNkglg0vbf5VCkJmQ4fEtp
        Ffyri9Y2+TBpeQrJvoPxAS++QEiTMTeOJKSHIOi9rbWBlCMa01nsQPGmagErGtqB5tR0tu8Gf2csN
        ddIMqv9tSZDECrwFtIstUZxdc5i/p+1bL1CSk5EhF9wFrkYGw+BPkb1WR5zf/UgChAj+40UYUP0xo
        25/8N+HLg==;
Received: from 177.205.70.5.dynamic.adsl.gvt.net.br ([177.205.70.5] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjijR-0002Ls-VR; Sat, 06 Jul 2019 11:19:54 +0000
Date:   Sat, 6 Jul 2019 08:19:50 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 35/39] docs: infiniband: add it to the driver-api
 bookset
Message-ID: <20190706081950.4a629537@coco.lan>
In-Reply-To: <20190703180802.GA26557@ziepe.ca>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
        <12743088687a9b0b305c05b62a5093056a4190b8.1561724493.git.mchehab+samsung@kernel.org>
        <20190703180802.GA26557@ziepe.ca>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Em Wed, 3 Jul 2019 15:08:02 -0300
Jason Gunthorpe <jgg@ziepe.ca> escreveu:

> On Fri, Jun 28, 2019 at 09:30:28AM -0300, Mauro Carvalho Chehab wrote:
> > While this contains some uAPI stuff, it was intended to be
> > read by a kernel doc. So, let's not move it to a different
> > dir, but, instead, just add it to the driver-api bookset.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> >  Documentation/index.rst            | 1 +
> >  Documentation/infiniband/index.rst | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/index.rst b/Documentation/index.rst
> > index ea33cbbccd9d..e69d2fde7735 100644
> > +++ b/Documentation/index.rst
> > @@ -96,6 +96,7 @@ needed).
> >     block/index
> >     hid/index
> >     iio/index
> > +   infiniband/index
> >     leds/index
> >     media/index
> >     networking/index
> > diff --git a/Documentation/infiniband/index.rst b/Documentation/infiniband/index.rst
> > index 22eea64de722..9cd7615438b9 100644
> > +++ b/Documentation/infiniband/index.rst
> > @@ -1,4 +1,4 @@
> > -:orphan:
> > +.. SPDX-License-Identifier: GPL-2.0
> >  
> >  ==========
> >  InfiniBand  
> 
> Should this one go to the rdma.git as well? It looks like yes

I'm OK if you want to add to rdma.git. However, this will likely rise 
conflicts, though, as this series has lots of other patches touching
Documentation/index.rst. 

So, I suspect that it would be easier to merge this together with the
other patches via the docs tree, by the end of the merge window.

If you prefer to apply it against your tree, my plan is to do
a final rebase at the second week of the merge window, in order to
avoid such conflicts.

Thanks,
Mauro
