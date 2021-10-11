Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B342913D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 16:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhJKOQk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 11 Oct 2021 10:16:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:26732 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244329AbhJKON5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 Oct 2021 10:13:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="207686228"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="207686228"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 07:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="scan'208";a="716395226"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 11 Oct 2021 07:07:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 07:07:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 11 Oct 2021 07:07:11 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.012;
 Mon, 11 Oct 2021 07:07:11 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>
Subject: RE: [PATCH 2/4] RDMA/irdma: compact the ctrl.c
Thread-Topic: [PATCH 2/4] RDMA/irdma: compact the ctrl.c
Thread-Index: AQHXvk8yU/ivL/MoEEuuIwKNBjkzg6vN1F2g
Date:   Mon, 11 Oct 2021 14:07:11 +0000
Message-ID: <3fabebc8262043b988fcc712f020ca77@intel.com>
References: <20211011110128.4057-1-yanjun.zhu@linux.dev>
 <20211011110128.4057-3-yanjun.zhu@linux.dev>
In-Reply-To: <20211011110128.4057-3-yanjun.zhu@linux.dev>
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

> Subject: [PATCH 2/4] RDMA/irdma: compact the ctrl.c
> 
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function irdma_sc_send_lsmm_nostag is not used. So remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c | 38 ------------------------------
> drivers/infiniband/hw/irdma/type.h |  2 +-

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
