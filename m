Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383CD433ABB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhJSPjE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 19 Oct 2021 11:39:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:33383 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhJSPix (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 11:38:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226012163"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="226012163"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 08:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="443931797"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2021 08:36:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 08:36:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 08:36:37 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.012;
 Tue, 19 Oct 2021 08:36:37 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH 1/1] RDMA/irdma: remove the check to the returned value of
 irdma_uk_cq_init
Thread-Topic: [PATCH 1/1] RDMA/irdma: remove the check to the returned value
 of irdma_uk_cq_init
Thread-Index: AQHXxL8T2lLZeNA6w0iUPDo7/yhD5qvacQlQ
Date:   Tue, 19 Oct 2021 15:36:37 +0000
Message-ID: <f6a7d200d1f94c7abe8f2524a1d3acd7@intel.com>
References: <20211019153717.3836-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211019153717.3836-1-yanjun.zhu@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH 1/1] RDMA/irdma: remove the check to the returned value of
> irdma_uk_cq_init

Maybe you can condense this to --

RDMA/irdma: Make irdma_uk_cq_init return a void


> 
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Since the function irdma_uk_cq_init always returns 0, so remove the check to the
> returned value of the function irdma_uk_cq_init.

Maybe --

irdma_uk_cq_init always returns 0, so make it a void.


> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 5 +----
>  drivers/infiniband/hw/irdma/uk.c   | 6 ++----
>  drivers/infiniband/hw/irdma/user.h | 4 ++--
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 

Thanks for this!

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
