Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15D446C2D7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhLGScV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 Dec 2021 13:32:21 -0500
Received: from mga06.intel.com ([134.134.136.31]:59469 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhLGScV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 13:32:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="298448190"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="298448190"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 10:13:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="479613314"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2021 10:13:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:13:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 10:13:46 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Tue, 7 Dec 2021 10:13:46 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
 'irdma_prm_add_pble_mem()'
Thread-Topic: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
 'irdma_prm_add_pble_mem()'
Thread-Index: AQHX6bCNMQeR51AEWEqSWwxcHSAfJ6wnL0ag
Date:   Tue, 7 Dec 2021 18:13:46 +0000
Message-ID: <5f02a69c4f194803b4372493625c03be@intel.com>
References: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
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

> Subject: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
> 'irdma_prm_add_pble_mem()'
> 
> 'pchunk->bitmapbuf' is a bitmap. Its size (in number of bits) is stored in 'pchunk-
> >sizeofbitmap'.
> 
> When it is allocated, the size (in bytes) is computed by:
>    size_in_bits >> 3
> 
> There are 2 issues (numbers bellow assume that longs are 64 bits):
>    - there is no guarantee here that 'pchunk->bitmapmem.size' is modulo
>      BITS_PER_LONG but bitmaps are stored as longs
>      (sizeofbitmap=8 bits will only allocate 1 byte, instead of 8 (1 long))
> 
>    - the number of bytes is computed with a shift, not a round up, so we
>      may allocate less memory than needed
>      (sizeofbitmap=65 bits will only allocate 8 bytes (i.e. 1 long), when 2
>      longs are needed = 16 bytes)

Since sizeofbitmap is always a multiple of 64 (pchunk->size is a multiple of 4K block size, and pprm->pble_shift = 6),
I am not sure we will hit these issues today.

> 
> Fix both issues by using 'bitmap_zalloc()' and remove the useless 'bitmapmem'
> from 'struct irdma_chunk'.
> 
> While at it, remove some useless NULL test before calling kfree/bitmap_free.

Yes nonetheless the patch is good. And we should be using the bitmap_zalloc/free API's rather than open-coding it.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>


