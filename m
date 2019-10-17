Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 762C7DA54A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Oct 2019 08:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394225AbfJQGGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Oct 2019 02:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392531AbfJQGGu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Oct 2019 02:06:50 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9351420854;
        Thu, 17 Oct 2019 06:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571292410;
        bh=SeTRR7ahU/epsaYXu84jW9n11znQ9YqkS+nPaJsNFrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAsCYr4ZV8dfvW7w6rel4ZdlSDjapnwB7kSjZH/PrTi72lTqhRvjEq9LLsM9i4hJS
         9phmxDEIA6/QR5QwzpIynoZmm+n9P3cXlRMv4Cd9EcXljQKc0hO8BCzFsunEMnmO7q
         0eUN7GsGhSL3nIsQaBYlWk+uAyG4TzCL67fNLrsU=
Date:   Thu, 17 Oct 2019 09:06:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Don Dutile <ddutile@redhat.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>, jgg@ziepe.ca,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        nirranjan@chelsio.com
Subject: Re: [PATCH for-next] iw_cxgb3: remove iw_cxgb3 module from kernel.
Message-ID: <20191017060647.GG6957@unreal>
References: <20190930074252.20133-1-bharat@chelsio.com>
 <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411c4ea1-4320-fa04-b014-7e5fe91869a8@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 16, 2019 at 01:47:29PM -0400, Don Dutile wrote:
> On 09/30/2019 03:42 AM, Potnuri Bharat Teja wrote:

<...>

> > -
> > -#endif /* CXGB3_ABI_USER_H */
> > diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> > index b8bb285f6b2a..b2680051047a 100644
> > --- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
> > +++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> > @@ -88,7 +88,6 @@ enum rdma_driver_id {
> >   	RDMA_DRIVER_UNKNOWN,
> >   	RDMA_DRIVER_MLX5,
> >   	RDMA_DRIVER_MLX4,
> > -	RDMA_DRIVER_CXGB3,
> >   	RDMA_DRIVER_CXGB4,
> >   	RDMA_DRIVER_MTHCA,
> >   	RDMA_DRIVER_BNXT_RE,
> >
> Isn't there a better way to mark a driver deprecated?


Change in this enum was a mistake.

>
> This kind of removal makes long-term maintenance of such drivers painful in downstream distros, as API changes that are rippled from core through all the drivers, don't update these drivers, and when backporting such API changes to downstream distros, we have to +1 removed drivers.

https://lore.kernel.org/linux-rdma/20191015075419.18185-2-leon@kernel.org/T/#u

>
> It's much easier if upstream continues to update the drivers for such across-the-driver-patch-changes.
> heck, add a separate patch that punches out a printk stating DEPRECATED (dropping a patch to backport is easy! :) ).
>
> I told Doug I'd shoot him if he removed another driver from upstream again, that still has to be maintained in RHEL -- don't make me take him *and Jason* out! ;-)  ... yeah, you too Jason!
>
>
>
>
>
