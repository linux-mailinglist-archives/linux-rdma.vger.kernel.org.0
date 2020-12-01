Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4A2CA5F9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Dec 2020 15:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgLAOnO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 1 Dec 2020 09:43:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:28210 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbgLAOnO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 09:43:14 -0500
IronPort-SDR: VS65tg1XiBUXXQAOtREmWMR/K8JuayT9PwgY+D/0EbIHTG23yq8mWfq+K+OAGekzZ0X6zTa8Ky
 vHlNzu7d8DTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170270853"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="170270853"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 06:42:30 -0800
IronPort-SDR: oIr6baotrnbYYJYjUUouOdPFczSD6BQ7xNIDT5/BMzoIBBLWpUDWzrQ/cEeYCBsul6C4iEh2an
 uMJCTHTYd4qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="315685843"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 01 Dec 2020 06:42:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Dec 2020 06:42:26 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 1 Dec 2020 06:42:25 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.1713.004;
 Tue, 1 Dec 2020 06:42:25 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Yejune Deng <yejune.deng@gmail.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband: i40iw: replace atomic_add_return()
Thread-Topic: [PATCH] infiniband: i40iw: replace atomic_add_return()
Thread-Index: AQHWxvZEXNWJ2mNFXUOrhojqokPY6qniTm7g
Date:   Tue, 1 Dec 2020 14:42:25 +0000
Message-ID: <b578b692d2ec4f598be584b809aed400@intel.com>
References: <1606726376-7675-1-git-send-email-yejune.deng@gmail.com>
In-Reply-To: <1606726376-7675-1-git-send-email-yejune.deng@gmail.com>
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

> Subject: [PATCH] infiniband: i40iw: replace atomic_add_return()
> 
> atomic_inc_return() is a little neater
> 
> Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c
> b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> index 3053c345..26e92ae 100644
> --- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
> +++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
> @@ -2426,7 +2426,7 @@ static void i40iw_handle_rst_pkt(struct i40iw_cm_node
> *cm_node,
>  		}
>  		break;
>  	case I40IW_CM_STATE_MPAREQ_RCVD:
> -		atomic_add_return(1, &cm_node->passive_state);
> +		atomic_inc_return(&cm_node->passive_state);

Just an atomic_inc would suffice here.

>  		break;
>  	case I40IW_CM_STATE_ESTABLISHED:
>  	case I40IW_CM_STATE_SYN_RCVD:
> @@ -3020,7 +3020,7 @@ static int i40iw_cm_reject(struct i40iw_cm_node
> *cm_node, const void *pdata, u8
>  	i40iw_cleanup_retrans_entry(cm_node);
> 
>  	if (!loopback) {
> -		passive_state = atomic_add_return(1, &cm_node->passive_state);
> +		passive_state = atomic_inc_return(&cm_node->passive_state);

Fine with it as its consistent across i40iw. But aren't there many more instances of this across the tree?
Isn't this a choice best left to the developer?
