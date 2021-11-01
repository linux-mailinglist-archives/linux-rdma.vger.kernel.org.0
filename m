Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED8E441C9E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Nov 2021 15:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhKAOcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 1 Nov 2021 10:32:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:32546 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231981AbhKAOcH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 1 Nov 2021 10:32:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="218214604"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="218214604"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="727373403"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 01 Nov 2021 07:29:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 1 Nov 2021 07:29:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 1 Nov 2021 07:29:32 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.012;
 Mon, 1 Nov 2021 07:29:32 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: RE: [PATCHv2 1/1] RDMA/irdma: optimize rx path by removing
 unnecessary copy
Thread-Topic: [PATCHv2 1/1] RDMA/irdma: optimize rx path by removing
 unnecessary copy
Thread-Index: AQHXzTkk3/rZRvS4h0+5Cn4MBTPGy6vuvj6A
Date:   Mon, 1 Nov 2021 14:29:32 +0000
Message-ID: <066524eb5d5145cc9b12268025cde9d8@intel.com>
References: <20211030104226.253346-1-yanjun.zhu@linux.dev>
In-Reply-To: <20211030104226.253346-1-yanjun.zhu@linux.dev>
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

> Subject: [PATCHv2 1/1] RDMA/irdma: optimize rx path by removing unnecessary
> copy
> 
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In the function irdma_post_recv, the function irdma_copy_sg_list is not needed
> since the struct irdma_sge and ib_sge have the similar member variables. The
> struct irdma_sge can be replaced with the struct ib_sge totally.
> 
> This can increase the rx performance of irdma.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
