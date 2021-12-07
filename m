Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C72D46BE0C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 15:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238165AbhLGOs2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 Dec 2021 09:48:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:15512 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231565AbhLGOs1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 09:48:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="235100439"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="235100439"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:44:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="462312784"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2021 06:44:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 06:44:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 06:44:55 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.020;
 Tue, 7 Dec 2021 06:44:55 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
 'irdma_prm_add_pble_mem()'
Thread-Topic: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
 'irdma_prm_add_pble_mem()'
Thread-Index: AQHX6bCNMQeR51AEWEqSWwxcHSAfJ6wni3UA//+RAfA=
Date:   Tue, 7 Dec 2021 14:44:55 +0000
Message-ID: <0500c21d9d814715956e3275afd4f116@intel.com>
References: <5e670b640508e14b1869c3e8e4fb970d78cbe997.1638692171.git.christophe.jaillet@wanadoo.fr>
 <20211207131428.GF1956@kadam>
In-Reply-To: <20211207131428.GF1956@kadam>
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

> Subject: Re: [PATCH] RDMA/irdma: Fix a potential memory allocation issue in
> 'irdma_prm_add_pble_mem()'
> 
> On Sun, Dec 05, 2021 at 09:17:24AM +0100, Christophe JAILLET wrote:
> > @@ -299,8 +298,7 @@ add_pble_prm(struct irdma_hmc_pble_rsrc *pble_rsrc)
> >  	return 0;
> >
> >  error:
> > -	if (chunk->bitmapbuf)
> > -		kfree(chunk->bitmapmem.va);
> > +	bitmap_free(chunk->bitmapbuf);
> >  	kfree(chunk->chunkmem.va);
> 
> Thanks for removing the "chunk->bitmapbuf = chunk->bitmapmem.va;" stuff.
> It was really confusing.  The kfree(chunk->chunkmem.va) is equivalent to
> kfree(chunk).  A good rule of thumb is that when you have one error:
> label to free everything then it's normally going to be buggy.
> 
> drivers/infiniband/hw/irdma/pble.c
>    281          pble_rsrc->next_fpm_addr += chunk->size;
>    282          ibdev_dbg(to_ibdev(dev),
>    283                    "PBLE: next_fpm_addr = %llx chunk_size[%llu] = 0x%llx\n",
>    284                    pble_rsrc->next_fpm_addr, chunk->size, chunk->size);
>    285          pble_rsrc->unallocated_pble -= (u32)(chunk->size >> 3);
>    286          list_add(&chunk->list, &pble_rsrc->pinfo.clist);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> "chunk" added to the "->pinfo.clist" list.
> 
>    287          sd_reg_val = (sd_entry_type == IRDMA_SD_TYPE_PAGED) ?
>    288                               sd_entry->u.pd_table.pd_page_addr.pa :
>    289                               sd_entry->u.bp.addr.pa;
>    290
>    291          if (!sd_entry->valid) {
>    292                  ret_code = irdma_hmc_sd_one(dev, hmc_info->hmc_fn_id,
> sd_reg_val,
>    293                                              idx->sd_idx, sd_entry->entry_type, true);
>    294                  if (ret_code)
>    295                          goto error;
>                                 ^^^^^^^^^^^
> 
>    296          }
>    297
>    298          sd_entry->valid = true;
>    299          return 0;
>    300
>    301  error:
>    302          if (chunk->bitmapbuf)
>    303                  kfree(chunk->bitmapmem.va);
>    304          kfree(chunk->chunkmem.va);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> kfree(chunk) will lead to a use after free because it's still on the list.
> 

Ugh! Yes, this is a bug. I will send a separate fix out shortly for this one.

Shiraz
