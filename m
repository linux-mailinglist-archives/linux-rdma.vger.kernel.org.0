Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3652C55F
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 13:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE1L0u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 07:26:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34426 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1L0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 07:26:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id t64so21765240qkh.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 May 2019 04:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C8PREvk4XjKT7EMr0Iibplv2mwgYkbpJMzuQMtp1V9M=;
        b=curfE0XAtWpbWMTzjFj45uzmaq7/I33cpw2XWuxo7VMig5KHreRfxJ/hY34tGiJca4
         XfC6Ky61yNUpUpl9SI674qbLd/Txg29vKIZxtWiGWL/nuVe+uP0+PmpmeyfF8cLm1/Qm
         7sL1kEgueKtRItK6JHmcci2aIENb7jdglsaRhC+xLTxyjj/zU4soRmKTJ0cF3O1nIeRf
         KjJEMB7xJJ2Xk4DL1yNfD6Y9GItau0I2Dyt0jzFJwuiD14Y+VHg7lon4myKB/CTOU3lj
         CQCbnTO4NNAabPmdSzhHio/ZseVvDKnbRygluNwUTD80HLroJz5Q2RSkYDsZJEsfeRc/
         p9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C8PREvk4XjKT7EMr0Iibplv2mwgYkbpJMzuQMtp1V9M=;
        b=DBdMSd5yx77zB8WLGR4EtD5eIEjRp83otCzbafUJIVidg3D32QyhICePKqzQawMbv8
         HVRgmbGiKazoPClKgXd58/pEO4HsweTcF/HAJZ4CHWXIARLycL0fgHOQ6d6AWQ5ozGg3
         619DODm2SZOf4+uBeM21ESeiGTevTEHYOYpNjjqCS6iZcizKijWA2kFfm0gV8ydpNxC+
         wwzjDRilyk6mZpFQyYekiUzjfiZUEudlbLvVEboc6FI5ZHDangJRTVqAUI6eNFOZJw4t
         6EAI4FoKmCW6X5V9R925sPNPxO+9hKsDJ2O4OO87VRRo9rE3vFeOWWrgKpft0quEkUPH
         SSaQ==
X-Gm-Message-State: APjAAAXsiZtCA1pgo/1/KfJxXy/eocbVOOvJReh6VqERNqLPGVqa+Btd
        9hr1sqyxosC1Lxi2q+KGlvXcWA==
X-Google-Smtp-Source: APXvYqw0pMuZTgpuhoS/yFgWmjyVw+Embr+PNSyXDMbhu5vHJ7WwSVBfCUtfE90Y9usjlPoB2VgObw==
X-Received: by 2002:a0c:9b8d:: with SMTP id o13mr44864600qve.36.1559042808980;
        Tue, 28 May 2019 04:26:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 6sm4092860qtp.80.2019.05.28.04.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 04:26:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVaFj-0004UE-Oq; Tue, 28 May 2019 08:26:47 -0300
Date:   Tue, 28 May 2019 08:26:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-core] verbs: Introduce a new reg_mr API for virtual
 address space
Message-ID: <20190528112647.GA31301@ziepe.ca>
References: <20190527150004.21191-1-yuval.shaia@oracle.com>
 <20190527182219.GF18100@ziepe.ca>
 <20190528063055.GA2558@lap1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528063055.GA2558@lap1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 09:30:56AM +0300, Yuval Shaia wrote:
> On Mon, May 27, 2019 at 03:22:20PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 27, 2019 at 06:00:04PM +0300, Yuval Shaia wrote:
> > > The virtual address that is registered is used as a base for any address
> > > used later in post_recv and post_send operations.
> > > 
> > > On a virtualised environment this is not correct.
> > > 
> > > A guest cannot register its memory so hypervisor maps the guest physical
> > > address to a host virtual address and register it with the HW. Later on,
> > > at datapath phase, the guest fills the SGEs with addresses from its
> > > address space.
> > > Since HW cannot access guest virtual address space an extra translation
> > > is needed to map those addresses to be based on the host virtual address
> > > that was registered with the HW.
> > > 
> > > To avoid this, a logical separation between the address that is
> > > registered and the address that is used as a offset at datapath phase is
> > > needed.
> > > 
> > > This separation is already implemented in the lower layer part
> > > (ibv_cmd_reg_mr) but blocked at the API level.
> > > 
> > > Fix it by introducing a new API function that accepts a address from
> > > guest virtual address space as well.
> > > 
> > > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > >  libibverbs/verbs.c | 24 ++++++++++++++++++++++++
> > >  libibverbs/verbs.h |  6 ++++++
> > >  2 files changed, 30 insertions(+)
> > > 
> > > diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
> > > index 1766b9f5..9ad74ee0 100644
> > > +++ b/libibverbs/verbs.c
> > > @@ -324,6 +324,30 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
> > >  	return mr;
> > >  }
> > >  
> > > +LATEST_SYMVER_FUNC(ibv_reg_mr_virt_as, 1_1, "IBVERBS_1.1",
> > > +		   struct ibv_mr *,
> > > +		   struct ibv_pd *pd, void *addr, size_t length,
> > > +		   uint64_t hca_va, int access)
> > > +{
> > 
> > Doesn't need this macro since it doesn't have a compat version
> 
> That is weird, without this it fails in link stage.
> 
> /usr/bin/ld: hw/rdma/rdma_backend.o: in function `rdma_backend_create_mr':
> rdma_backend.c:(.text+0x260a): undefined reference to `ibv_reg_mr_virt_as'
> collect2: error: ld returned 1 exit status

You do have to update the map file in any case

> > 
> > > +	struct verbs_mr *vmr;
> > > +	struct ibv_reg_mr cmd;
> > > +	struct ib_uverbs_reg_mr_resp resp;
> > > +	int ret;
> > > +
> > > +	vmr = malloc(sizeof(*vmr));
> > > +	if (!vmr)
> > > +		return NULL;
> > > +
> > > +	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
> > > +			     sizeof(cmd), &resp, sizeof(resp));
> > 
> > It seems problematic not to call the driver, several of the drivers
> > are wrappering mr in their own type (ie bnxt_re_mr) and we can't just
> > allocate the wrong size of memory here.
> > 
> > What you should do is modify the existing driver callback to accept
> > another argument and go and fix all the drivers to pass that argument
> > into their ibv_cmd_reg_mr as the hca_va above. This looks pretty
> > trivial.
> 
> So back to what was proposed in the RFC besides the addition of new arg
> instead of new callback, right?

Well, half and half, keep the normal function for the entry point and
change the sigature of the callback in driver.h

Jason
