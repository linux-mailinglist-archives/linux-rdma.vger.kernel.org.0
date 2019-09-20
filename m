Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0DB90C4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfITNiU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Sep 2019 09:38:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34807 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfITNiU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Sep 2019 09:38:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so6219779qta.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2019 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+39PcM6RkOaLc8Zvsd6QK7EhsEtSW4j1Q86rpXWC01c=;
        b=Lg90za2Vy9r9MmcQ1sBpjNM3+yp3xUPvCE4GG7nOnmn34gSpjMKFlOTJq4BWqBS5O8
         O4wmvD/anqKPDZ+pRoLHmlKwZNi6zoBZR+R4h5nQ19Sv7WA8wS+tUfxQquC298AemSJ8
         Oxgh7g3RE66mUYF0+H0xacVS6CXLJCnNc2zfAHEb+l1rI05fIFPocfXXnIjMEoQ/zHEp
         UMlLg5HQkf+6Pix31DUkDFNMTTlSvgat5KucQrt0HaDQRzHigQtz/G4UBswdYuaRPbjy
         20J0HfaOAkMJClyFdKmmU+D5x4LS4Esj0EpUsB85/g0k9X/1twVJMnuQoFvP/DwGOaGg
         Kn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+39PcM6RkOaLc8Zvsd6QK7EhsEtSW4j1Q86rpXWC01c=;
        b=lVOWPaZd5mQzwLId57vqErZmOCeDj2sCQkaODD7EJ8piEi0+vij/h0Uc0rs79+zips
         YkKUZxujj5LdY8hAz0Ym1nTwlqfkFI00+oC4csFLB63ym2lQ7YKTh7+xfFLPya55ZT56
         JPHM2KjpqptHfgXaERhFQbdrF5E/suCDNiCqKUu4f11JA3TtAr53ibC8h/Ht/b1xddZo
         dkp3Lg1cfDaCj0Uybru0HChJp2qATYorXOWfq1lT36kiTrbYte9XKiwNiuyKGPDkJVRm
         Mfp+dKCdVIj1cIKKieMWgRv9TdWVrTAW82Jn6/G5Mz66tVpEsDRxUfhre1LTDVDjVkKb
         kj/A==
X-Gm-Message-State: APjAAAXXHbYjDEL0DxJirD9Y1q44MrGmDcuDCd21K0v2N/0lW6FXdgiw
        Owkh5k/N+lZ+5W9cLdyOq44LQg==
X-Google-Smtp-Source: APXvYqx8d97uQnmyFeQzhoorhwkkmQMbSL2QzUOJ+n2ettbVffF50XeLG2uxTA8Or87VhjXWSs7JfQ==
X-Received: by 2002:ac8:78d:: with SMTP id l13mr3321530qth.86.1568986698975;
        Fri, 20 Sep 2019 06:38:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id c25sm890016qtv.71.2019.09.20.06.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Sep 2019 06:38:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iBJ73-00056F-T3; Fri, 20 Sep 2019 10:38:17 -0300
Date:   Fri, 20 Sep 2019 10:38:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        bmt@zurich.ibm.com, sleybo@amazon.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell overflow
 recovery support
Message-ID: <20190920133817.GB7095@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e19fb2-cd5c-4394-16d6-75ac856340b4@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 20, 2019 at 04:30:52PM +0300, Gal Pressman wrote:
> On 19/09/2019 21:02, Jason Gunthorpe wrote:
> > On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
> > 
> >> @@ -347,6 +360,9 @@ void qedr_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
> >>  {
> >>  	struct qedr_user_mmap_entry *entry = get_qedr_mmap_entry(rdma_entry);
> >>  
> >> +	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
> >> +		free_page((unsigned long)phys_to_virt(entry->address));
> >> +
> > 
> > While it isn't wrong it do it this way, we don't need this mmap_free()
> > stuff for normal CPU pages. Those are refcounted and qedr can simply
> > call free_page() during the teardown of the uobject that is using the
> > this page. This is what other drivers already do.
> 
> This is pretty much what EFA does as well.  When we allocate pages
> for the user (CQ for example), we DMA map them and later on mmap
> them to the user. We expect those pages to remain until the entry is
> freed, how can we call free_page, who is holding a refcount on those
> except for the driver?

free_page is kind of a lie, it is more like put_page (see
__free_pages). I think the difference is that it assumes the page came
from alloc_page and skips some generic stuff when freeing it.

When the driver does vm_insert_page the vma holds another refcount and
the refcount does not go to zero until that page drops out of the
vma (ie at the same time mmap_free above is called). 

Then __put_page will do the free_unref_page(), etc.

So for CPU pages it is fine to not use mmap_free so long as
vm_insert_page is used

Jason
