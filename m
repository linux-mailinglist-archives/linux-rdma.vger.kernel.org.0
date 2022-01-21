Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B149629A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jan 2022 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351460AbiAUQIm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jan 2022 11:08:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:30954 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239055AbiAUQIm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 21 Jan 2022 11:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642781322; x=1674317322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CLI4ZPbcFkmdFIvg7kjbyulrlDX2BZJUPr9V92jeriM=;
  b=i4hLwpj2sGJdsoAqZqXJRfklCRX638lVJmrovGpCLMq8oVhCr2rP1WJa
   g7mG8CXOrpOklVGn++7XtJUjgk2vv9Y9RxwhoF5wh0mpyzsl8Rls7gieC
   S/qQEzccQtH04k2hoSuyEa3rE9fYiP5bs5J9THcxmLzjKDboNd2VuibGn
   Vts4IE1R7k+dbdyVztLDHVBYOEa/5CAlzQeKYDjF8Kni6kgI05OVvQs4v
   8fJEkLDMajZLfbszrGmZ6G2h3U1b2LoSVg0Auzu+IDK01cesp67s+UsX2
   2WquMrN96jjHWiRM85y+F+tEKas8V2WvHdMiIwydKETGdsYvI1HS/d47l
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="306405411"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="306405411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 08:08:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="672982490"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 08:08:41 -0800
Date:   Fri, 21 Jan 2022 08:08:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Li, Zhijian" <lizhijian@cn.fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH v2 2/2] RDMA/rxe: Support RDMA Atomic Write operation
Message-ID: <20220121160841.GD773547@iweiny-DESK2.sc.intel.com>
References: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
 <20220113030350.2492841-3-yangx.jy@fujitsu.com>
 <20220117131624.GB7906@nvidia.com>
 <61E673EA.60900@fujitsu.com>
 <20220118123505.GF84788@nvidia.com>
 <7dfed756-42a7-b6f7-3473-1348479d30db@fujitsu.com>
 <20220119123635.GH84788@nvidia.com>
 <022be340-a49a-1e94-5fb8-1c77f06fecc2@cn.fujitsu.com>
 <20220121125837.GV84788@nvidia.com>
 <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220121160654.GC773547@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 21, 2022 at 08:06:54AM -0800, 'Ira Weiny' wrote:
> On Fri, Jan 21, 2022 at 08:58:37AM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 20, 2022 at 08:07:36PM +0800, Li, Zhijian wrote:
> > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> > > b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > index 0621d387ccba..978fdd23665c 100644
> > > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > > @@ -260,7 +260,8 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64
> > > length, u64 iova,
> > >                                 num_buf = 0;
> > >                         }
> > > 
> > > -                       vaddr = page_address(sg_page_iter_page(&sg_iter));
> > > +                       // FIXME: don't forget to kunmap_local(vaddr)
> > > +                       vaddr = kmap_local_page(sg_page_iter_page(&sg_iter));
> > 
> > No, you can't leave the kmap open for a long time. The kmap has to
> > just be around the usage.
> 
> Indeed Jason is correct here.  A couple of details here.  First
> kmap_local_page() is only valid within the current thread of execution.  So
> what you propose above will not work at all.  Second, kmap() is to be avoided.
> 
> Finally, that page_address() should be avoided IMO and will be broken, at least
> for persistent memory pages, once some of my work lands.[*]  Jason would know
> better, but I think page_address should be avoided in all driver code.  But
> there is no clear documentation on that.
> 
> Taking a quick look at rxe_mr.c buf->addr is only used in rxe_mr_init_user().
                                                            ^^^^^^^^^^^^^^
Sorry...                                            I meant rxe_mr_copy()...

> You need to kmap_local_page() around that access.  What else is struct
> rxe_phys_buf->addr used for?  Can you just map the page when you need it in
> rxe_mr_init_user()?

rxe_mr_copy()...

Ira

> 
> If you must create a mapping that is permanent you could look at vmap().
> 
> Ira
> 
> > 
> > Jason
