Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7463BBB53D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 15:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407128AbfIWNaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 09:30:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40943 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407137AbfIWNaC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 09:30:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so15326604qkb.7
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HjfT9E4TX3HFHZ+7BRh0/oXYEdbQiW+jXB/W2TTKitw=;
        b=BITFvnD4B/2jX70W7gUefG2OIvmzKkIicC9YWomkunIxq+q0IVg4OHnPqjdEgPKzBH
         spCCtAK52BoudxTxXmH/EAy2jZojr+v5B0Db+WynJV1AoUZInelEBqmyUVbxlVlpClkW
         PoXS68RFG9taFllQZgLHwe9cAUhwghRI+ysPKRgTMtb4B/wrntK6W5GxlC6GpCeekaVT
         U6sZLIZ6j/9rBdfw7M2TkNhh8UoJ+iAcR1PMkfQuldQonhKCQxrE6i7Y2Et5+Ftvmh7r
         ul6ORU6T7JitQAvM6tFDBeh/F6NI4o1oNq3FxbIjINBuEiee86xH/yTBrL3emM5bF+QH
         oXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjfT9E4TX3HFHZ+7BRh0/oXYEdbQiW+jXB/W2TTKitw=;
        b=ucZI24X1y5M0zq+PZ1KnPjwHCiFmTp/9T/XLyIs0ZxII2UdxUtJVod70vRBhhv97Q0
         +og5BmvrYAneVxEAKyhMHEVYmSYfKSo/zkidjZwa+sufDlEt4TQq+A+JKpFsJ3YYVYA9
         ZVDWdjFMqAxpGfGOmYhqfaVob3mVI+TNNUFn4dsgH6yrNA5kR1kf5O9qXX0Bu6O/H4Pe
         ucmkjnklugUuEWCp13Nbfi0oxyAdZYfQYUl/g9C5QJNODm0zhZY07Iv40AJIuoYd4lsR
         1hWxT3IiE6oa60f4VVYyHnZIrSoG9Fda3CQFneSz+aZNohGZK41GaKJNlLx/popiPz54
         YMLQ==
X-Gm-Message-State: APjAAAVDCjD7e+UzNcz0o9UTl8/AohkWgX2D/Ytj17FphWGVq9aPi9cL
        YVr7uIkoyBILcxa3KsCKSdqZrA==
X-Google-Smtp-Source: APXvYqxnPCGkk82yIiecaEoyYqvVyQJB74C4UEjXbHgVJsQE7gVxV2qgMLuX4MOapWf3SRj9AE59pg==
X-Received: by 2002:a37:498f:: with SMTP id w137mr16724578qka.419.1569245401262;
        Mon, 23 Sep 2019 06:30:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id e4sm4665989qkl.135.2019.09.23.06.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 06:30:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iCOPg-0003mb-BY; Mon, 23 Sep 2019 10:30:00 -0300
Date:   Mon, 23 Sep 2019 10:30:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v11 rdma-next 2/7] RDMA/core: Create mmap
 database and cookie helper functions
Message-ID: <20190923133000.GD12047@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-3-michal.kalderon@marvell.com>
 <20190919180746.GF4132@ziepe.ca>
 <MN2PR18MB31822DCFCA312D6A455A000BA1850@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB31822DCFCA312D6A455A000BA1850@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 09:36:01AM +0000, Michal Kalderon wrote:
> > > + * will use the key to retrieve information such as address to
> > > + * be mapped and how.
> > > + *
> > > + * Return: unique key or RDMA_USER_MMAP_INVALID if entry was not
> > added.
> > > + */
> > > +u64 rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
> > > +				struct rdma_user_mmap_entry *entry,
> > > +				size_t length)
> > 
> > The similarly we don't need to return a u64 here and the sort of ugly
> > RDMA_USER_MMAP_INVALID can go away
> 
> So you mean add a return code here ? and on failure driver will delete the 
> Allocated xx_user_mmap_entry and not store it in xx_key ? 

I'm not sure what this means

Jason
