Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E0410B53
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfEAQad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 12:30:33 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40610 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfEAQad (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 May 2019 12:30:33 -0400
Received: by mail-yw1-f68.google.com with SMTP id t79so8688460ywc.7
        for <linux-rdma@vger.kernel.org>; Wed, 01 May 2019 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1M9ilxcPXnPkoEZdSxCbeaFKUqEN54+Yt/Ya0MxG338=;
        b=KYmxJcvYJusFNQXCG+O3788sqmPok2eD3pg/ZSpiDNgd8k8PE+uhabO+3xn0n2nT3j
         djwFOMCY6DjrAxfMtE5F893QiHz3EnWwwJBhXDgnQBwVKZrxyoeBvl3/ZMMrY6P/essL
         fEqzn6OgHyMXE92nUa8yyx6z3vIKF4gytFCarjfDaNgPuN+aTByXuRG7eN6+sYvFH968
         IvQjyE5KvOj/QvZ4HMwHSLwHSnyU5d8+McnPvZKlr2epst2m7ensQwTdjROaHEnnitHD
         0fZm2DT3f6Q8B3W4RHfTUARWyDEzcPIEs8WV07S5N/XHmzSDTRE5hxDP1uYLGIvbDlk9
         Cqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1M9ilxcPXnPkoEZdSxCbeaFKUqEN54+Yt/Ya0MxG338=;
        b=I4zvnYY6LuzD+NHlTalYkaf5EljemCQpej4sBPSOxDdfb0Si9xjPSM3jyMVwZPUuCi
         L89fYaVtJxcaM+okxm3wHYwYYWobacx9cOg1qXYksW+djWFJzzBCtH8W8EN+TI9O1kj0
         hK1hFSX7cbOa4Z/e3R/pymY9N13whIJ9s/KhTY5RAreodyB9dCo9WmvI78riXai/j1UL
         jiyiqmxyjcJ3g+xuzYWo1r6y9gweEwdVa+BXK2Jf2C291uL1xxWpgAiQydGlCKhMLYI2
         y+B1lhEgm5pja54RL13/hvVpyQifWX9TS/iz4DFeb+D3jQv6XWmaSp5rqjm/wRlr5gLK
         MgtA==
X-Gm-Message-State: APjAAAV3YBynvB0loH8cgPp9OItQ1fLApJ+TuZfa+bDQkzxHMjGD7niB
        MNHP1uIoD6geokSuELDEs59pUA==
X-Google-Smtp-Source: APXvYqwWBGCYcWYCubmGdLFkw0EttfHgEV49CJAIa4nOxzqEA0AF0hXEtxxvaZxR8qErsT6+MYxFmg==
X-Received: by 2002:a25:3406:: with SMTP id b6mr42328036yba.375.1556728232981;
        Wed, 01 May 2019 09:30:32 -0700 (PDT)
Received: from ziepe.ca (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id h204sm38472154ywh.110.2019.05.01.09.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 09:30:32 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hLs7r-0004Ib-Ak; Wed, 01 May 2019 13:30:31 -0300
Date:   Wed, 1 May 2019 13:30:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH rdma-next 7/7] RDMA/core: Allow detaching gid attribute
 netdevice for RoCE
Message-ID: <20190501163031.GB15621@ziepe.ca>
References: <20190410081524.18737-1-leon@kernel.org>
 <20190410081524.18737-8-leon@kernel.org>
 <20190410092924.GL3201@mtr-leonro.mtl.com>
 <VI1PR0501MB22716B71DCDAD172090BA3D1D12E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190410135507.GE8997@ziepe.ca>
 <20190410140416.GQ3201@mtr-leonro.mtl.com>
 <VI1PR0501MB2271247334248A6156AF2AB1D12E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
 <20190410141857.GF8997@ziepe.ca>
 <20190410142435.GR3201@mtr-leonro.mtl.com>
 <20190501053613.GA7676@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501053613.GA7676@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 05:36:17AM +0000, Leon Romanovsky wrote:
> On Wed, Apr 10, 2019 at 02:24:36PM +0000, Leon Romanovsky wrote:
> > On Wed, Apr 10, 2019 at 11:18:57AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Apr 10, 2019 at 02:13:03PM +0000, Parav Pandit wrote:
> > >
> > > > > Parav,
> > > > >
> > > > > Boot with rcu_dereference produces the following warning.
> > > > >
> > > > > [    7.921247] mlx5_core 0000:00:0c.0: firmware version: 3.10.9999
> > > > > [    7.921730] mlx5_core 0000:00:0c.0: 0.000 Gb/s available PCIe bandwidth
> > > > > (Unknown speed x255 link)
> > > > > [    8.299897] mlx5_ib: Mellanox Connect-IB Infiniband driver v5.0-0
> > > > > [    8.307859]
> > > > > [    8.307989] =============================
> > > > > [    8.308084] WARNING: suspicious RCU usage
> > > > > [    8.308193] 5.1.0-rc2+ #278 Not tainted
> > > > > [    8.308302] -----------------------------
> > > > > [    8.308446] drivers/infiniband/core/cache.c:302 suspicious
> > > > > rcu_dereference_check() usage!
> > > > >
> > > > > >
> > > > Yes. So lets do
> > > >
> > > > rcu_dereference_protected(attr->ndev, 1);
> > > >
> > > > with below updated comment?
> > > >
> > > > +	/* rcu_dereference is not needed because GID attr being passed as input during
> > > > +	 *  GID addition cannot change. It is used only to avoid smatch complain.
> > > > +	 */
> > >
> > > Why cannot it change?
> > >
> > > You don't need to talk about smatch, the use of
> > > rcu_dereference_protected is self-explanatory.
> >
> > While you are discussing the best comment, I tried it and it worked.
> >
> > Jason, do I need to resend v2?
> 
> Jason?

Sure otherwise it will get forgotton..

Jason
