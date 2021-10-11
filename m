Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5042919B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 16:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhJKOWB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 11 Oct 2021 10:22:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:1860 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238750AbhJKOUB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Oct 2021 10:20:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="250270196"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="250270196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 07:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="714725811"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga006.fm.intel.com with ESMTP; 11 Oct 2021 07:07:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 07:07:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 07:07:20 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.012;
 Mon, 11 Oct 2021 07:07:20 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: RE: [PATCH 4/4] RDMA/irdma: compact the file uk.c
Thread-Topic: [PATCH 4/4] RDMA/irdma: compact the file uk.c
Thread-Index: AQHXvk80qXGkegaZfUWVJFLbv9TYvavN1cEw
Date:   Mon, 11 Oct 2021 14:07:20 +0000
Message-ID: <d99982bf2c514de280363e4f1202b5eb@intel.com>
References: <20211011110128.4057-1-yanjun.zhu@linux.dev>
 <20211011110128.4057-5-yanjun.zhu@linux.dev>
In-Reply-To: <20211011110128.4057-5-yanjun.zhu@linux.dev>
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

> Subject: [PATCH 4/4] RDMA/irdma: compact the file uk.c
> 
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function irdma_cqp_up_map_cmd is not used. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/protos.h |  2 --  drivers/infiniband/hw/irdma/utils.c  | 34
> ----------------------------

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
