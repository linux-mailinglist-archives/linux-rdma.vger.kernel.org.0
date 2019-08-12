Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1249989F66
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 15:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfHLNOj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 09:14:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36807 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbfHLNOj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Aug 2019 09:14:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so102768026qtc.3
        for <linux-rdma@vger.kernel.org>; Mon, 12 Aug 2019 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vbrMZbAlGPGIi9DYbOom+lM0TPxk5SFfu4EZNBvas+0=;
        b=e/wVC5Jsg0dpN+nqggurv3OeAZMQPfVoIZJqlbzNt4BX/crXn1r3Md5uvCU+vUTL0+
         3sawdcTQd4cLhODY2C+Do6IAAG8fJRk0p+f2CiXiEpC9OattHXuMKRj94aYVxKfSjPjl
         amvS0eoFZG5pIhIMZKX0gvfSKMxywUCbqSV6mrbV1wG+6BqDHmw/svBQUiueU3maQp73
         Mn6YvC7+UmPM7/Hv+GAJ5buzPlMdlSC98CEmgUUgRWBEP/xMjckbnFwrd2bmDAvGmKpf
         JyK1VjEhDit4sx0uJjwJiBAyiVgnB2bX1JX62kqVZ47gp8sMt8+BmfTXRr6IEVOvy+e5
         JyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vbrMZbAlGPGIi9DYbOom+lM0TPxk5SFfu4EZNBvas+0=;
        b=WuirAmaFlCNhVGoskjErBvRXUqUFn1WNVDgXLZflRRtyOilhrGuD/nuihPYFdCq7GC
         aBqkSCu5SiNCkn6jrwQgP856/jxwbM6/MnZmJI3zP3bqNnoQE/Zmy44uUHQDBeVYHsT7
         CZImrpT5tn/HVtf4ToMSSCOTNigskuq+2Kysd9hxCY4ZpgosFV/owOkQmTG5RnnATk0b
         aWoAsCBYrHGFrUj/t/H883BAi3+pmixSrvszu2URqA2/BeXiLgwzCgY0VlSh+74SrhNx
         Mj8zfkmqUE+zPts27r5I6FabtjgLuN7mGeeJF4QL6Rj6fwfuRJ6HxVlsQFNAqdXKy6rN
         d2Lg==
X-Gm-Message-State: APjAAAXhdKQKLvC3o2wedVYD+BaD+YMiS3vsunaEoAS2cxgToXM8Gw53
        eN+VL3tSHFv57meOwJWWASO46w==
X-Google-Smtp-Source: APXvYqzHX5Z/+L9bk7vjqS6B9s5w6reatSvTYGtMgJe0+fwP88eLOkF3PhJT49YD7Yn993GaX7Yzfg==
X-Received: by 2002:ad4:430f:: with SMTP id c15mr6553622qvs.25.1565615678691;
        Mon, 12 Aug 2019 06:14:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g18sm622441qtq.69.2019.08.12.06.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 06:14:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hxA9l-0007cl-Tc; Mon, 12 Aug 2019 10:14:37 -0300
Date:   Mon, 12 Aug 2019 10:14:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Lijun Ou <oulijun@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 8/9] RDMA/hns: Kernel notify usr space to stop
 ring db
Message-ID: <20190812131437.GG24457@ziepe.ca>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <1565343666-73193-9-git-send-email-oulijun@huawei.com>
 <20190812055220.GA8440@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812055220.GA8440@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 08:52:20AM +0300, Leon Romanovsky wrote:
> On Fri, Aug 09, 2019 at 05:41:05PM +0800, Lijun Ou wrote:
> > From: Yangyang Li <liyangyang20@huawei.com>
> >
> > In the reset scenario, if the kernel receives the reset signal,
> > it needs to notify the user space to stop ring doorbell.
> 
> I doubt about it, it is racy like hell and relies on assumption that
> userspace will honor such request to stop.

Sounds like this is the device unplug flow we already have support
for, use the APIs to drop the VMA refering to the doorbell

> > Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> >  drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 52 ++++++++++++++++++++++++++++-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 +++
> >  drivers/infiniband/hw/hns/hns_roce_main.c   | 22 ++++++------
> >  4 files changed, 70 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> > index 32465f5..be65fce 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> > @@ -268,6 +268,8 @@ enum {
> >
> >  #define PAGE_ADDR_SHIFT				12
> >
> > +#define HNS_ROCE_IS_RESETTING			1
> > +
> >  struct hns_roce_uar {
> >  	u64		pfn;
> >  	unsigned long	index;
> > @@ -1043,6 +1045,8 @@ struct hns_roce_dev {
> >  	u32			odb_offset;
> >  	dma_addr_t		tptr_dma_addr;	/* only for hw v1 */
> >  	u32			tptr_size;	/* only for hw v1 */
> > +	struct page		*reset_page; /* store reset state */
> > +	void			*reset_kaddr; /* addr of reset page */
> >  	const struct hns_roce_hw *hw;
> >  	void			*priv;
> >  	struct workqueue_struct *irq_workq;
> > diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > index d33341e..138e5a8 100644
> > +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> > @@ -1867,17 +1867,49 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
> >  			  link_tbl->table.map);
> >  }
> >
> > +static int hns_roce_v2_get_reset_page(struct hns_roce_dev *hr_dev)
> > +{
> > +	hr_dev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> > +	if (!hr_dev->reset_page)
> > +		return -ENOMEM;
> > +
> > +	hr_dev->reset_kaddr = vmap(&hr_dev->reset_page, 1, VM_MAP, PAGE_KERNEL);
> > +	if (!hr_dev->reset_kaddr)
> > +		goto err_with_vmap;

Yes, this vmap is nonsense too, get_zeroed_page() is the right API

Jason
