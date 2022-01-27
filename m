Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D549E9AA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 19:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbiA0SIg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 13:08:36 -0500
Received: from mga01.intel.com ([192.55.52.88]:49877 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239361AbiA0SIf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jan 2022 13:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306915; x=1674842915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39T5LfFvDbJHmvOFk9KwZ0FYW8S84k6NCsY7m7gOun4=;
  b=JM3pnRqjeeUrJrp4nTVjWTKdCh/OvTnMKtwnHdqqGkgXBXDSnRrRjmnx
   9ZSz3Ll+2b2Nw/pNrjnEsOM34wNKSPYe26ithf2QodUx362fC5eaWmItm
   dVWxEuCWZzu14WmTcDuQp78SV5Ovx055kMuNqg0lPHJZFDo2vsntjh4Uo
   ozqkCRAOAoB5RGb/c6NuI2j+msZoLLMDQFrStk9C+VB4S3xUdtz+tUPrS
   pTV94uaDB8Tw9ASCKMqd6CNR32MwhgcRMsRduHxHGPV9IPJuVMeWT/A1E
   1FN2dJvCNjh6XMfuwtN3S70Js3VpzPB57JWdLXkW4eoJZ9Zwht7dM3mTk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="271387047"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="271387047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:08:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674801151"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:08:33 -0800
Date:   Thu, 27 Jan 2022 10:08:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "hch@lst.de" <hch@lst.de>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220127180833.GF785175@iweiny-DESK2.sc.intel.com>
References: <20220117131624.GB7906@nvidia.com>
 <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
 <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
 <20220127095730.GA14946@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127095730.GA14946@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 10:57:30AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 27, 2022 at 09:37:59AM +0000, yangx.jy@fujitsu.com wrote:
> > Do you mean we have to consider that some allocated pages come from high 
> > memory?
> >
> > I think INFINIBAND_VIRT_DMA kconfig[1] has ensured that all allocated 
> > pages have a kernel virtual address.
> 
> rxe and siw depend on INFINIBAND_VIRT_DMA which depends on !HIGHMEM,
> so you don't need kmap here at all.

Until/if I get PKS protecting pmem.[1]  Then if the page is pmem, page_address()
will give you an address which you will fault on when you access it.

> 
> > In this case, is it OK to call page_address() directly?
> 
> Yes.

For now yes...  But please use kmap_local_page() and it will do the right thing
(by default call page_address() on !HIGHMEM systems).

IMO page_address() is a hold over from a time when memory management was much
simpler and, again IMO, today its use assumes too much for drivers like this.
As more protections on memory are implemented it presents a series of land
mines to be found.

While kmap is also a hold over I'm trying to redefine it to be 'get the kernel
mapping' rather than 'map this into highmem'...  But perhaps I'm losing that
battle...

Ira

[1] https://lore.kernel.org/lkml/20220127175505.851391-1-ira.weiny@intel.com/T/#mcd60ea9a9c7b90e63b8d333c9270186fc7e47707
