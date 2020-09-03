Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08A25C3A8
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgICOzz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 3 Sep 2020 10:55:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:43373 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgICOLl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 10:11:41 -0400
IronPort-SDR: UajGs2BWSQfHa8vECQKrXvToisvnFssjPRPKE1+F37I/SIECgi7YWk2v+TEkFhLDr0IXNj2q7u
 Fe4DYsoMLdMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145272277"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145272277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:11:39 -0700
IronPort-SDR: nF21J34mYSHVlCC0opNh5GEEdZMgUS27XPdc7koRE6vcJoRscwZFKy2NpugePJl2c/h3Tqxfix
 IljKCNuXhvkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="326233354"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2020 07:11:38 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 07:11:38 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 07:11:38 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.245]) with mapi id 14.03.0439.000;
 Thu, 3 Sep 2020 07:11:37 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 02/14] RDMA/umem: Prevent small pages from being
 returned by ib_umem_find_best_pgsz()
Thread-Topic: [PATCH 02/14] RDMA/umem: Prevent small pages from being
 returned by ib_umem_find_best_pgsz()
Thread-Index: AQHWgMIvlK3UiZHkXUSnz9HsWkCUf6lW6QWA
Date:   Thu, 3 Sep 2020 14:11:37 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A70107141173@ORSMSX101.amr.corp.intel.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned by
> ib_umem_find_best_pgsz()
> 
> rdma_for_each_block() makes assumptions about how the SGL is constructed that
> don't work if the block size is below the page size used to to build the SGL.
> 
> The rules for umem SGL construction require that the SG's all be PAGE_SIZE
> aligned and we don't encode the actual byte offset of the VA range inside the SGL
> using offset and length. So rdma_for_each_block() has no idea where the actual
> starting/ending point is to compute the first/last block boundary if the starting
> address should be within a SGL.

Not sure if we were exposed today. i.e. rdma drivers working with block sizes smaller than system page size?

Nevertheless it's a good find and looks right thing to do for now.

> 
> Fixing the SGL construction turns out to be really hard, and will be the subject of
> other patches. For now block smaller pages.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page
> size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>

