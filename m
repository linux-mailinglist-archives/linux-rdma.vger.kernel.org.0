Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 500F65DB01
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jul 2019 03:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfGCBhk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jul 2019 21:37:40 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35823 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfGCBhk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jul 2019 21:37:40 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so831765qto.2
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jul 2019 18:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n6Cr/2TTE7sXeLBBF+y17Nyc+Rmb7wg0ZYDpvKpdMZo=;
        b=ILpe1sm7yeBmxdmgGnui8zJdUwwsL5/Awh9sP+1Urt25Tyueb+6L9qfd1M1aDlCK5A
         VC7T1u9YeM//gggooGZjmqecH+oPZOXQgQXJDmnRM3X90QC9YdDpMJP8iod7yU9q5MfG
         kPqSf85t7OPwCxqJJeSg9wLorF/Kx0s/lfqigjr7D4pZ4dFCj9xG1Q2OQgFNLsVXQlci
         f5QSqwlNx3Y1OODy/vkFZiJp+vuOPm9zUXt3fJDz5GiHSAcyJryCxwgZoaE9AJw+aOu3
         aSWWcXs8HqDNFO6eMXgvMnmuYYTDysfZm7aT1DtoJoAUHI8uEq6jctdIOooedu7S9b8u
         w8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6Cr/2TTE7sXeLBBF+y17Nyc+Rmb7wg0ZYDpvKpdMZo=;
        b=KV2dJF62yKI2B5821olW4Hk9uL9RsM57X6KXZsLaRsJFTzlrBPb0SSPE1zuy6Btftq
         utr7BcuoVwz+HyguAu3xYd6205NAqAODyFQ7EiwfokPz4cCYBdnpBGpoPWXNFZnMVS28
         NUA2Frncb0VtKyhrZYDMtbFV7GDXaKB8ClzxQBqMOH2OLYLZvo7c2j6J0CCpPGMcfqN4
         5dMhy77DkYFDK2yfeL8Z8WGrOUkgT2/MMLmid7koRmb02e5Cppz9C9KUP36XUNJbpLFf
         KBV3fBj5VUWt2X4cAo6qUDWyyE2lIDARDAZYL36SilRrjdxwQ3Ifo3EZ0T1VbzD7jCyi
         TAbg==
X-Gm-Message-State: APjAAAVeWrEIuCkVm5zMEQfRidNb7H7jmSpDwu9V9/Ak/Ym47GNigh6O
        wYQvlmQvAN9g2F3MxMr2GdJlyQJQolujXw==
X-Google-Smtp-Source: APXvYqzahrIGBxJr0L734X837Aw/jUrFoyRV1Ja6eoxxNEtWFXGhBkcoV4Wto4Fl7pfF0jnNQlcvcw==
X-Received: by 2002:ac8:2f7b:: with SMTP id k56mr27448392qta.376.1562107285605;
        Tue, 02 Jul 2019 15:41:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id a21sm98861qkg.47.2019.07.02.15.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 15:41:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hiRSm-0003JP-Pu; Tue, 02 Jul 2019 19:41:24 -0300
Date:   Tue, 2 Jul 2019 19:41:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     Yuval Shaia <yuval.shaia@oracle.com>, yishaih@mellanox.com,
        dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        mark.haywood@oracle.com, Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH v6 rdma-core] verbs: Introduce a new reg_mr API for
 virtual address space
Message-ID: <20190702224124.GC11860@ziepe.ca>
References: <20190613110936.30535-1-yuval.shaia@oracle.com>
 <20190701081542.GA30149@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701081542.GA30149@srabinov-laptop>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 01, 2019 at 11:15:42AM +0300, Shamir Rabinovitch wrote:
> On Thu, Jun 13, 2019 at 02:09:36PM +0300, Yuval Shaia wrote:
> > The virtual address that is registered is used as a base for any address
> > passed later in post_recv and post_send operations.
> > 
> > On some virtualized environment this is not correct.
> > 
> > A guest cannot register its memory so hypervisor maps the guest physical
> > address to a host virtual address and register it with the HW. Later on,
> > at datapath phase, the guest fills the SGEs with addresses from its
> > address space.
> > Since HW cannot access guest virtual address space an extra translation
> > is needed to map those addresses to be based on the host virtual address
> > that was registered with the HW.
> > This datapath interference affects performances.
> > 
> > To avoid this, a logical separation between the address that is
> > registered and the address that is used as a offset at datapath phase is
> > needed.
> > This separation is already implemented in the lower layer part
> > (ibv_cmd_reg_mr) but blocked at the API level.
> > 
> > Fix it by introducing a new API function which accepts an address from
> > guest virtual address space as well, to be used as offset for later
> > datapath operations.
> > 
> > Also update the PABI to v25
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> > v0 -> v1:
> > 	* Change reg_mr callback signature instead of adding new callback
> > 	* Add the new API to libibverbs/libibverbs.map.in
> > v1 -> v2:
> > 	* Do not modify reg_mr signature for version 1.0
> > 	* Add note to man page
> > v2 -> v3:
> > 	* Rename function to reg_mr_iova (and arg-name to iova)
> > 	* Some checkpatch issues not related to this fix but detected now
> > 		* s/__FUNCTION__/__func
> > 		* WARNING: function definition argument 'void *' should
> > 		  also have an identifier name
> > v3 -> v4:
> > 	* Fix commit message as suggested by Adit Ranadiv
> > 	* Add support for efa
> > v4 -> v5:
> > 	* Update PABI
> > 	* Update debian files
> > v5 -> v6:
> > 	* Move the new API to section in libibverbs/libibverbs.map.in
> > 	  (IBVERBS_1.7) as pointed out by Mark Haywood
> 
> When will this be pulled in to rdma-core master ?
> 
> I can use this API for the shared PD demo app.

I was happy with it, but haven't checked every detail yet

Jason
