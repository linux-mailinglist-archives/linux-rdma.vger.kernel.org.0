Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE6935E9E8
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 02:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhDNAOR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 13 Apr 2021 20:14:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:25144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhDNAOQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 20:14:16 -0400
IronPort-SDR: jn+JrUXaCD+pnGqOhDWnl9QeuXfRQmEY4AfHkfcFe17OnWZXplTS9VbcIpveLtlx8sDCCxsqI2
 VRA2aIYtCB/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="174633122"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="174633122"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 17:13:56 -0700
IronPort-SDR: 4TfW4I1t8BznDeLdjKDb2+G61VH45NV1uVHBIKbjzCXsFC/pK77pWJnvyu8YOqhTWnk72tteRe
 7sEFkXDAbTgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="418071543"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2021 17:13:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 17:13:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 17:13:55 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2106.013;
 Tue, 13 Apr 2021 17:13:55 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Latif, Faisal" <faisal.latif@intel.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Devale, Sindhu" <sindhu.devale@intel.com>
Subject: RE: [bug report] i40iw: add pble resource files
Thread-Topic: [bug report] i40iw: add pble resource files
Thread-Index: AQHXMFM0OznmeABrpE2F1JiU3rNAjqqy6XxA
Date:   Wed, 14 Apr 2021 00:13:55 +0000
Message-ID: <9572e3c8647d44f9b06dde9dc54a3c88@intel.com>
References: <YHV4CFXzqTm23AOZ@mwanda>
In-Reply-To: <YHV4CFXzqTm23AOZ@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [bug report] i40iw: add pble resource files
> 
> Hello Faisal Latif,
> 
> The patch 9715830157be: "i40iw: add pble resource files" from Jan 20, 2016, leads
> to the following static checker warning:
> 
> 	drivers/infiniband/hw/i40iw/i40iw_pble.c:414 add_pble_pool()
> 	warn: '&chunk->list' not removed from list
> 
> drivers/infiniband/hw/i40iw/i40iw_pble.c
>    391          }
>    392          pble_rsrc->next_fpm_addr += chunk->size;
>    393          i40iw_debug(dev, I40IW_DEBUG_PBLE, "next_fpm_addr = %llx
> chunk_size[%u] = 0x%x\n",
>    394                      pble_rsrc->next_fpm_addr, chunk->size, chunk->size);
>    395          pble_rsrc->unallocated_pble -= (chunk->size >> 3);
>    396          list_add(&chunk->list, &pble_rsrc->pinfo.clist);
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> "chunk" is added to the list.
> 
>    397          sd_reg_val = (sd_entry_type == I40IW_SD_TYPE_PAGED) ?
>    398                          sd_entry->u.pd_table.pd_page_addr.pa : sd_entry-
> >u.bp.addr.pa;
>    399          if (sd_entry->valid)
>    400                  return 0;
>    401          if (dev->is_pf) {
>    402                  ret_code = i40iw_hmc_sd_one(dev, hmc_info->hmc_fn_id,
>    403                                              sd_reg_val, idx->sd_idx,
>    404                                              sd_entry->entry_type, true);
>    405                  if (ret_code) {
>    406                          i40iw_pr_err("cqp cmd failed for sd (pbles)\n");
>    407                          goto error;
>                                 ^^^^^^^^^^ We hit an error
> 
>    408                  }
>    409          }
>    410
>    411          sd_entry->valid = true;
>    412          return 0;
>    413   error:
>    414          kfree(chunk);
>                 ^^^^^^^^^^^^
> "chunk" is freed but it's still on the list
> 

Hi Dan - Thanks for the report and it looks legit. We will send a fix for it.

Shiraz
