Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8227E49DE96
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 10:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiA0J5e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 04:57:34 -0500
Received: from verein.lst.de ([213.95.11.211]:43477 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232243AbiA0J5e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jan 2022 04:57:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E739268AA6; Thu, 27 Jan 2022 10:57:30 +0100 (CET)
Date:   Thu, 27 Jan 2022 10:57:30 +0100
From:   "hch@lst.de" <hch@lst.de>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write
 operation
Message-ID: <20220127095730.GA14946@lst.de>
References: <20220113030350.2492841-3-yangx.jy@fujitsu.com> <20220117131624.GB7906@nvidia.com> <61E673EA.60900@fujitsu.com> <20220118123505.GF84788@nvidia.com> <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com> <20220119123635.GH84788@nvidia.com> <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com> <20220121125837.GV84788@nvidia.com> <20220121160654.GC773547@iweiny-DESK2.sc.intel.com> <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b322be-a718-5fb8-11e2-05ee783f1086@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 27, 2022 at 09:37:59AM +0000, yangx.jy@fujitsu.com wrote:
> Do you mean we have to consider that some allocated pages come from high 
> memory?
>
> I think INFINIBAND_VIRT_DMA kconfig[1] has ensured that all allocated 
> pages have a kernel virtual address.

rxe and siw depend on INFINIBAND_VIRT_DMA which depends on !HIGHMEM,
so you don't need kmap here at all.

> In this case, is it OK to call page_address() directly?

Yes.
