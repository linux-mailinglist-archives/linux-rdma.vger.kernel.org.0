Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E965501
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfGKLLu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 07:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbfGKLLt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 07:11:49 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2844221019;
        Thu, 11 Jul 2019 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562843508;
        bh=nzrGHFFsVIv3LdE1vQRBFWQIyGhWBcARlM1U6MsQOlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/SzIVfhWbo7KDBm/QDbslp8yuWG6svAq6BVpd7V91phXdd+9UX1er1c98lBrsl5J
         hrNfiOg/iHQOSoG4cKoW8E5f5xqYkqZ5PBG9U52seS+xKFydaa9yvq9mJ+jYu9YnJf
         xvgBFsAzcrosc0DR03ThiNOareWNUkOV37yw6MoU=
Date:   Thu, 11 Jul 2019 14:11:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Drung <benjamin.drung@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Subject: Re: failed armel build of rdma-core 24.0-1
Message-ID: <20190711111145.GF23598@mtr-leonro.mtl.com>
References: <156275862123.1841.4329369138979653018@wuiet.debian.org>
 <20190710192316.GH4051@ziepe.ca>
 <92fc16f9-d9f2-a05f-b049-137550ab4bfd@amazon.com>
 <20190711070744.GD23598@mtr-leonro.mtl.com>
 <bde8ef5c-10d4-0eae-efbf-5addff1633ff@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde8ef5c-10d4-0eae-efbf-5addff1633ff@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 11:00:44AM +0300, Gal Pressman wrote:
> On 11/07/2019 10:07, Leon Romanovsky wrote:
> > On Thu, Jul 11, 2019 at 09:35:59AM +0300, Gal Pressman wrote:
> >> On 10/07/2019 22:23, Jason Gunthorpe wrote:
> >>> Benjamin,
> >>>
> >>> Can you confirm that something like this fixes these build problems?
> >>>
> >>> diff --git a/debian/rules b/debian/rules
> >>> index 07c9c145ff090c..facb45170eacfc 100755
> >>> --- a/debian/rules
> >>> +++ b/debian/rules
> >>> @@ -63,6 +63,7 @@ ifneq (,$(filter-out $(COHERENT_DMA_ARCHS),$(DEB_HOST_ARCH)))
> >>>  		test -e debian/$$package.install.backup || cp debian/$$package.install debian/$$package.install.backup; \
> >>>  	done
> >>>  	sed -i '/mlx[45]/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
> >>> +	sed -i '/efa/d' debian/ibverbs-providers.install debian/libibverbs-dev.install debian/rdma-core.install
> >>>  endif
> >>>  	DESTDIR=$(CURDIR)/debian/tmp ninja -C build-deb install
> >>>
> >>>
> >>>
> >>> On Wed, Jul 10, 2019 at 11:37:01AM -0000, Debian buildds wrote:
> >>>>  * Source package: rdma-core
> >>>>  * Version: 24.0-1
> >>>>  * Architecture: armel
> >>>>  * State: failed
> >>>>  * Suite: sid
> >>>>  * Builder: antheil.debian.org
> >>>>  * Build log: https://buildd.debian.org/status/fetch.php?pkg=rdma-core&arch=armel&ver=24.0-1&stamp=1562758620&file=log
> >>>>
> >>>> Please note that these notifications do not necessarily mean bug reports
> >>>> in your package but could also be caused by other packages, temporary
> >>>> uninstallabilities and arch-specific breakages.  A look at the build log
> >>>> despite this disclaimer would be appreciated however.
> >>
> >> Was this error supposed to be reported by travis as well? I'm pretty sure all
> >> tests passed.
> >
> > Did you get any build failure email from debian? I didn't.
>
> I didn't, who is supposed to get these?

I don't know, but expected to see build failure emails to linux-rdma@.

Thanks
