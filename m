Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4B257107
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 01:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH3XdI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sun, 30 Aug 2020 19:33:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:33684 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgH3XdH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 30 Aug 2020 19:33:07 -0400
IronPort-SDR: rEA9Jp+HQoE+tN66F6pviUlNvKXMrqH07Ft3W+lugkxeijnS7xNYTZeU/i2T7ztCapE6AjRWsu
 tR1/tKh2wMBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144632155"
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="144632155"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2020 16:33:06 -0700
IronPort-SDR: taCxOn6slzCycheuKxMAIDJVbTBAWTcFWCPbdOUwct4LRUp+WtJNACAal9mlFkXenwfiJIiK6r
 MlJsx0k2saqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,373,1592895600"; 
   d="scan'208";a="314176633"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2020 16:33:06 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 30 Aug 2020 16:32:50 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 30 Aug 2020 16:32:50 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.181]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.250]) with mapi id 14.03.0439.000;
 Sun, 30 Aug 2020 16:32:50 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/umem: Fix signature of stub
 ib_umem_find_best_pgsz()
Thread-Topic: [PATCH] RDMA/umem: Fix signature of stub
 ib_umem_find_best_pgsz()
Thread-Index: AQHWewv6IiI4aza96kCFyIrqTVgBiqlRVDeQ
Date:   Sun, 30 Aug 2020 23:32:49 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7010712F6AF@ORSMSX101.amr.corp.intel.com>
References: <0-v1-982a13cc5c6d+501ae-fix_best_pgsz_stub_jgg@nvidia.com>
In-Reply-To: <0-v1-982a13cc5c6d+501ae-fix_best_pgsz_stub_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/umem: Fix signature of stub ib_umem_find_best_pgsz()
> 
> The original function returns unsigned long and 0 on failure.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page
> size in an MR")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  include/rdma/ib_umem.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h index
> 71f573a418bf06..07a764eb692eed 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -68,10 +68,11 @@ static inline int ib_umem_copy_from(void *dst, struct
> ib_umem *umem, size_t offs
>  		      		    size_t length) {
>  	return -EINVAL;
>  }
> -static inline int ib_umem_find_best_pgsz(struct ib_umem *umem,
> -					 unsigned long pgsz_bitmap,
> -					 unsigned long virt) {
> -	return -EINVAL;
> +static inline unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
> +						   unsigned long pgsz_bitmap,
> +						   unsigned long virt)
> +{
> +	return 0;
>  }
> 
>  #endif /* CONFIG_INFINIBAND_USER_MEM */

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
