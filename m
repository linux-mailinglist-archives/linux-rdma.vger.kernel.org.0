Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86FE3B7A53
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 00:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhF2WQK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 18:16:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:39471 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233905AbhF2WQK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 18:16:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208290082"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="208290082"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 15:13:42 -0700
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="408583842"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 15:13:41 -0700
Date:   Tue, 29 Jun 2021 15:13:41 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kheib@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4] RDMA/siw: Convert siw_tx_hdt() to kmap_local_page()
Message-ID: <20210629221341.GA3167959@iweiny-DESK2.sc.intel.com>
References: <20210624174814.2822896-1-ira.weiny@intel.com>
 <20210623221543.2799198-1-ira.weiny@intel.com>
 <OF8390CEF8.B4919E81-ON00258703.004DEB09-00258703.004DEB36@ch.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8390CEF8.B4919E81-ON00258703.004DEB09-00258703.004DEB36@ch.ibm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> >
> Sry my misconfigured email attached some HTML crap. So I did not
> reach the list.

NP...

> 
> Tested V4 which works as intended. Thanks, Ira!
> 
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

Thanks!
Ira

