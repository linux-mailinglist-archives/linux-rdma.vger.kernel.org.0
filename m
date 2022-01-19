Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC05493E8D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356230AbiASQrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 11:47:18 -0500
Received: from mga01.intel.com ([192.55.52.88]:16750 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235737AbiASQrS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jan 2022 11:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642610838; x=1674146838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ouFM4Xzqlt8xy1g3SKEJ91t3p2a++1MQRVRlemB2Og=;
  b=kE00GMjiBOwtgJYw9QYH5s/2xcEwg3+05DT/Eu8Z3hMvrtBo9D8D5zqT
   LQlm/FBeMqSTb4txkhHaqYQO1Zg453PtA5zmijJN8CXq5pEbGEOidyMlx
   ht5PgbWzjByArSdWmplh8Xj6sOGVzqoNo3kFguNx1aWq6GwOa4D3jg9Zh
   YzScMp9mT8mHwrcWdcv8HXN1+grP3NYibFeILTSBWSqy8VwESZLWBqzjR
   1SB2uQtHG5gjBsxq606fSImnWLbHrMoqXudnuXbylBXz23c1Yo4r4l+w2
   cXMQau8JIvMavCqmwJHL/qp24WqNJh5/RaMs1i51cDwIvx4NWpw9sMVqS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269502748"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="269502748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:47:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="625947611"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 08:47:14 -0800
Date:   Wed, 19 Jan 2022 08:47:13 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220119164713.GC209936@iweiny-DESK2.sc.intel.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
 <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119123635.GH84788@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 08:36:35AM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 19, 2022 at 01:54:32AM +0000, lizhijian@fujitsu.com wrote:

[snip]

> > 
> > IMHO, for the rxe, rxe_mr_init_user() will call get_user_page() to pin iova first, and then
> > the page address will be recorded into mr->cur_map_set->map[x]. So that when we want
> > to reference iova's kernel address, we can call iova_to_vaddr() where it will retrieve its kernel
> > address by travel the mr->cur_map_set->map[x].
> 
> That flow needs a kmap
> 
> > Do you mean we should retrieve iova's page first, and the reference the kernel address by
> > kmap(), sorry for my stupid question ?
> 
> Going from struct page to something the kernel can can touch requires
> kmap

kmap() the call is being deprecated.  Please use kmap_local_page() if possible.

https://lore.kernel.org/lkml/20211210232404.4098157-1-ira.weiny@intel.com/

Thanks,
Ira

