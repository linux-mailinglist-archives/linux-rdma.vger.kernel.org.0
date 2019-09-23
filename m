Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EDBB530
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406587AbfIWN0w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 09:26:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46360 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406391AbfIWN0w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 09:26:52 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so17030902qtq.13
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ekuRyRpB6EiDd4zey8dCHtHjpTvs9dOvapz6es/DOY=;
        b=lFxlwLbx1YsFEqC4NkmPWXGiWzCXd8d6MXoVW84OT4UGkpN6FwNhD1H4OC70++Fy35
         4A0GpbzLj0gRIOWdb0xiknSe5iClh7ZYO7GH8e6HJvV2Vb2fhDlAaMfqoXa6iG4BMCcx
         Uw7OAeFlqow9YAukF4WZgwZhNgwVBUdx/bvhKf4tTQkt/NPodmTfor5gtgji4kA+ttUL
         Zw6zCAfk3zvgI5qjuxNvv5RLpbxvthEpQJVd97L3Le0l0YvDmQuEFi6hxsA47kYpgjIC
         he20Qb9hxqL3Dis5VNAVxAp3Cyz+pH/3GfQfM1PQDR3QZGjQOAUv3Sp9gtGnkrVnXmcj
         xZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ekuRyRpB6EiDd4zey8dCHtHjpTvs9dOvapz6es/DOY=;
        b=bRWZEssWRNmOfq9BXKScvfiSY/ZeEmg6vqhYOivT1bWlu3zUSx+bBSEUXj/l96GT5G
         zXcTtVZwTpyzofQZnGcSbxNbIbsuIin8vxhOfCLQbbHaBOXBlP0tNZnFFzOfgHEx3vV2
         u1W2bJDDY6pMshv7N/8u2VTdyk6VjGA1gq6NM9MIvIRaeIe2TBg0d3y2yjfIc9Yu3hGP
         WKrbEOwp7CuUIud2+Gg4uTMh1umP/KMXezNq+VX6XLmpyTgupUofl/zpL655fuicUJJQ
         Wq/IKv43IjuBoKChV2UHT+KQ1RAsMpUVCe2csA3AZc2F5DttHxhBKAl2KlMBCgXfr7D9
         rsEg==
X-Gm-Message-State: APjAAAUKdwcDLbvjC8+rfxNSB3XW6Qmq7KJsdoi3gmdcoiGD2dJCXVSD
        R+1DJ+tK0j1dRgkuVaZ9KmhXzg==
X-Google-Smtp-Source: APXvYqx4Wq4e5FH2azo7n0F62pTL/3RzK78MO3j8Rx0vztt8QPxHs8xm98KoU2Rdd+rHKwVpQ10b1Q==
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr23832963qvn.31.1569245211600;
        Mon, 23 Sep 2019 06:26:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-223-10.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.223.10])
        by smtp.gmail.com with ESMTPSA id b4sm4902388qkd.121.2019.09.23.06.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 06:26:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iCOMc-0003l2-H1; Mon, 23 Sep 2019 10:26:50 -0300
Date:   Mon, 23 Sep 2019 10:26:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Message-ID: <20190923132650.GA12047@ziepe.ca>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
 <MN2PR18MB318246963F0BD4E2FB7459F0A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB318246963F0BD4E2FB7459F0A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 23, 2019 at 09:30:54AM +0000, Michal Kalderon wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, September 19, 2019 9:02 PM
> > 
> > External Email
> > 
> > On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
> > 
> > > @@ -347,6 +360,9 @@ void qedr_mmap_free(struct
> > rdma_user_mmap_entry
> > > *rdma_entry)  {
> > >  	struct qedr_user_mmap_entry *entry =
> > > get_qedr_mmap_entry(rdma_entry);
> > >
> > > +	if (entry->mmap_flag == QEDR_USER_MMAP_PHYS_PAGE)
> > > +		free_page((unsigned long)phys_to_virt(entry->address));
> > > +
> > 
> > While it isn't wrong it do it this way, we don't need this mmap_free() stuff for
> > normal CPU pages. Those are refcounted and qedr can simply call
> > free_page() during the teardown of the uobject that is using the this page.
> > This is what other drivers already do.
> > 
> > I'm also not sure why qedr is using a phys_addr for a struct page object,
> > seems wrong.
> As mentioned in previous email, I misunderstood this part before. I'll move the free
> To object teardown. 
> What we need here is simply a shared page between kernel + user that both have
> Virtual pointers to, user writes to the page, kernel needs to read the data. 
> 
> The reason I used phys here is because the entry->address is defines as u64
> As it is common whether it is an address to the bar or a page... 
> Should I define a union based on the entry type ? and for a page use
> struct page object ? 

Yes, a union with a void * would be OK

Jason
