Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B74A00B9
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jan 2022 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350845AbiA1TPc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jan 2022 14:15:32 -0500
Received: from mga18.intel.com ([134.134.136.126]:61968 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350864AbiA1TP2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jan 2022 14:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643397328; x=1674933328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8plCbEIR1B8ZhTQBvd+/ZMTxaUBxLbwqRy2aMBbjVjU=;
  b=fGVVrEpMZdmHdb2am9bLAL6r97Z9JkPZp81tmfedr61FjBnoYtN8Qeid
   xwFqHMAVE+ArI4coXJEkWG8comym7fcdmsWqvTGp6Pa6vTBa57lNdcGq3
   /k6Lg77SMh/gPaw7vvNSJVSKuiUHINizIvbdDOM5572TRCJk6f61Yw22U
   QDX5fE1N12VaL8jBKxksIidSWTb/c7Ry/D+EJk9ub4k1TOJs7x5NQoYNU
   U0vG238IJC8YwWVt1+VQMb09cLcqbo8c5iVBBOuUYWE48ey29dKV/Cco3
   3O/oov5oXI8Me12pDq9X+TJDxIju6fCHcyP/mNQ+sBtVFxvy6lzCIdJL8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="230758145"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="230758145"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:15:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="521822663"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 11:15:27 -0800
Date:   Fri, 28 Jan 2022 11:15:27 -0800
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
Message-ID: <20220128191527.GG785175@iweiny-DESK2.sc.intel.com>
References: <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
 <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
 <20220127095730.GA14946@lst.de>
 <20220127180833.GF785175@iweiny-DESK2.sc.intel.com>
 <20220128061618.GA1551@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128061618.GA1551@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 28, 2022 at 07:16:18AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 27, 2022 at 10:08:33AM -0800, Ira Weiny wrote:
> > On Thu, Jan 27, 2022 at 10:57:30AM +0100, Christoph Hellwig wrote:
> > > On Thu, Jan 27, 2022 at 09:37:59AM +0000, yangx.jy@fujitsu.com wrote:
> > > > Do you mean we have to consider that some allocated pages come from high 
> > > > memory?
> > > >
> > > > I think INFINIBAND_VIRT_DMA kconfig[1] has ensured that all allocated 
> > > > pages have a kernel virtual address.
> > > 
> > > rxe and siw depend on INFINIBAND_VIRT_DMA which depends on !HIGHMEM,
> > > so you don't need kmap here at all.
> > 
> > Until/if I get PKS protecting pmem.[1]  Then if the page is pmem, page_address()
> > will give you an address which you will fault on when you access it.
> 
> In that case we'll have problems all over the drivers that select
> INFINIBAND_VIRT_DMA, so this one doesn't make much of a difference..

Ah...  ok...

Obviously I've not kept up with the software providers...

For this use case, can kmap_local_page() work?

Ira
