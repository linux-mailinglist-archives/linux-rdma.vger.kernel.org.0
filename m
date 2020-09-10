Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71226480D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgIJOew convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 10 Sep 2020 10:34:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:59601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731019AbgIJObP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 10:31:15 -0400
IronPort-SDR: OTPpc1VBKeg+hBetJ7RYEPbP3Vro45/ZPgv35emsCgO4azJ4DVWFzlOpdKHnh+wRgUXb3sDBGm
 OO2kDCi4+J+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146261918"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="146261918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:31:13 -0700
IronPort-SDR: YwD3ByGVX2uxV95cYEAQntsgJLm67BJBFzAljvyGvsfCYhteodr05Ku2oi3KvgEqmKFgYTRBZv
 ky+mowGfI1RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="300569708"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Sep 2020 07:31:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 07:30:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 07:30:43 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Thu, 10 Sep 2020 07:30:43 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH rdma-next 10/10] RDMA/i40iw: Remove intermediate pointer
 that points to the same struct
Thread-Topic: [PATCH rdma-next 10/10] RDMA/i40iw: Remove intermediate pointer
 that points to the same struct
Thread-Index: AQHWh3rfsYJ+XjDqSE65y7ubBuANialh7rRg
Date:   Thu, 10 Sep 2020 14:30:42 +0000
Message-ID: <0b8aa47177d247acbfa7e9c901db1b4c@intel.com>
References: <20200910140046.1306341-1-leon@kernel.org>
 <20200910140046.1306341-11-leon@kernel.org>
In-Reply-To: <20200910140046.1306341-11-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH rdma-next 10/10] RDMA/i40iw: Remove intermediate pointer that
> points to the same struct
> 
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> There is no real need to have an intermediate pointer for the same struct, remove it,
> and use struct directly.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---

Looks good. Thanks!

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
