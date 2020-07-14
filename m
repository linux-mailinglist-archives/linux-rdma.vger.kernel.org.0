Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E448B2200BF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 00:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgGNWfB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 14 Jul 2020 18:35:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:38772 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgGNWfB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 18:35:01 -0400
IronPort-SDR: NTqGm4GlXQcTdDYixeY9DqC8llyEbAwySR+B9t9RQFohzetGyVGSYYepBegUv9xpkzC+TRtsZJ
 c/pHSpVHjpPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="210582891"
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="210582891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 15:35:00 -0700
IronPort-SDR: 4ZCQM5uwxmMTAFtrb2Xm+AGqVjO5kx6C/YFbEhRZCQfZeI/aGFMfFVus1fEDVY+0oUg/JmSl9Y
 hRXgwanHb6cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,353,1589266800"; 
   d="scan'208";a="268772906"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2020 15:34:59 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 15:34:59 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.101]) by
 fmsmsx158.amr.corp.intel.com ([169.254.15.146]) with mapi id 14.03.0439.000;
 Tue, 14 Jul 2020 15:35:00 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: RE: [PATCH for-next v1 0/7] RDMA: Remove query_pkey from iwarp
 providers
Thread-Topic: [PATCH for-next v1 0/7] RDMA: Remove query_pkey from iwarp
 providers
Thread-Index: AQHWWg1tVvfsjARE4EmX7rEO+Tc9F6kHdOYA
Date:   Tue, 14 Jul 2020 22:34:58 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7010659C72C@fmsmsx124.amr.corp.intel.com>
References: <20200714183414.61069-1-kamalheib1@gmail.com>
In-Reply-To: <20200714183414.61069-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH for-next v1 0/7] RDMA: Remove query_pkey from iwarp
> providers
> 
> This patch set does the following:
> 1- Avoid exposing the pkeys sysfs entries for iwarp providers.
> 2- Avoid allocating the pkey cache for iwarp providers.
> 3- Remove the requirement by RDMA core to implement query_pkey
>    by all providers.
> 4- Remove the implementation of query_pkey callback from iwarp providers.
> 
> v1: Patch #1: Move the free of the pkey_group to the right place.
> 
[...]
>   RDMA/i40iw: Remove the query_pkey callback
 
i40iw bits look ok. Thanks!

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
