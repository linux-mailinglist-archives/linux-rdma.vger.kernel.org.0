Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB046EAF
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jun 2019 09:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfFOHRA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jun 2019 03:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFOHRA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Jun 2019 03:17:00 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DA32184B;
        Sat, 15 Jun 2019 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560583019;
        bh=gvAp6TKVdm6LZKK6KGml86ppPiyCZ9iuJojeJR63DCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHObXZ2JatcDJsASB+AUDSBqRolKfvQR7S5sd9POKMLJ52d5r9EtJSvpGlxlTbFF5
         KciMnn/l9z6REb0SSMEVEHPMT3ivQcSunFk8H2+N1uZ4e5taa0Zpc3tjKHcweyY4fu
         njCSEwN1L2OQr27gjNNTq1Frp7HLcCFf8/IQsOV0=
Date:   Sat, 15 Jun 2019 10:16:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190615071653.GB4694@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b271896e1f3e643ccc5824ff6ac419787c52910.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 14, 2019 at 03:00:32PM -0400, Doug Ledford wrote:
> On Thu, 2019-06-13 at 21:38 -0300, Jason Gunthorpe wrote:
> > +       if (ibdev)
> > +               ret = __ib_get_client_nl_info(ibdev, client_name,
> > res);
> > +       else
> > +               ret = __ib_get_global_client_nl_info(client_name,
> > res);
> > +#ifdef CONFIG_MODULES
> > +       if (ret == -ENOENT) {
> > +               request_module("rdma-client-%s", client_name);
> > +               if (ibdev)
> > +                       ret = __ib_get_client_nl_info(ibdev,
> > client_name, res);
> > +               else
> > +                       ret =
> > __ib_get_global_client_nl_info(client_name, res);
> > +       }
> > +#endif
>
> I was trying to put my finger on something yesterday while reading the
> code, and this change makes it more clear for me.  Do we really want to
> limit the info type based on ibdev?  It seems to me that all global
> info retrieval should work whether you open a specific ibdev or not.
> It's only the things that need the ibdev to return the correct response
> that should require it.  Right now we only have one global info
> provider, but would it be better to do:
>
> 	if (!strcmp("rdma_cm", client_name))
> 		ret = __ib_get_global_client_nl_info(client_name, res);
> 	else
> 		ret = __ib_get_client_nl_info(ibdev, client_name, res);
>
> The other thing I was wondering about was the module loading.  Every
> attempt to load a module is a fork/exec cycle and a context switch over
> to modprobe and back, and we make no attempt here to keep each
> invocation of the netlink query from requesting a module.  I'm
> concerned this is actually a potential DoS attack vector.  I was
> thinking we should track each client name that's valid, and only try
> each name once.  I saw four module names: rdma_cm, umad, issm, and
> uverbs.  I'm wondering if we should have a static table in the netlink
> file with an entry for each of the client names and a variable to
> indicate we've attempted to load that module, and on -ENOENT, we check
> the table for a match to our passed in client_name, and only if we have
> a match, and it's load count is 0, do we call request_module() and
> increment the load count.  Thoughts?

Isn't request_module privileged operation, so only root or his friends
can do this DDoS?

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> 2FDD


