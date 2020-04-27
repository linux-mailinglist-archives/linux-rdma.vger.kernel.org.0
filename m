Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2881BABBA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 19:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgD0Ryo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 27 Apr 2020 13:54:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:5260 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0Ryo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 13:54:44 -0400
IronPort-SDR: 4gfFUGYr7UCEsJlp1PZE1lCcYfs+cl1s6srj891z0XGOydukGb2jOH5HJtKhPmGgpFyLgXgRuB
 RBkOKjLruL2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:54:44 -0700
IronPort-SDR: MZujpOBysJN4xpTHLptXZp+rUGrtGVv2Ofu/3/9NruEcwL3C0fhFuswgc3sAgL2hFniJ8MP1iw
 eIIE7PDPqXQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="247475307"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 27 Apr 2020 10:54:44 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 27 Apr 2020 10:54:43 -0700
Received: from fmsmsx124.amr.corp.intel.com ([169.254.8.70]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.87]) with mapi id 14.03.0439.000;
 Mon, 27 Apr 2020 10:54:43 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     "Latif, Faisal" <faisal.latif@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Shannon Nelson <shannon.nelson@intel.com>,
        "Singhai, Anjali" <anjali.singhai@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] i40iw: Fix error handling in i40iw_manage_arp_cache()
Thread-Topic: [PATCH] i40iw: Fix error handling in i40iw_manage_arp_cache()
Thread-Index: AQHWGIfnBzR4uDDw8E+FQe7fNMCiv6iK7swAgAImDBA=
Date:   Mon, 27 Apr 2020 17:54:43 +0000
Message-ID: <9DD61F30A802C4429A01CA4200E302A7DCD54B89@fmsmsx124.amr.corp.intel.com>
References: <20200422092211.GA195357@mwanda>
 <20200425230004.GA23991@ziepe.ca>
In-Reply-To: <20200425230004.GA23991@ziepe.ca>
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

> Subject: Re: [PATCH] i40iw: Fix error handling in i40iw_manage_arp_cache()
> 
> On Wed, Apr 22, 2020 at 12:22:11PM +0300, Dan Carpenter wrote:
> > The i40iw_arp_table() function can return -EOVERFLOW if
> > i40iw_alloc_resource() fails so we can't just test for "== -1".
> >
> > Fixes: 4e9042e647ff ("i40iw: add hw and utils files")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > drivers/infiniband/hw/i40iw/i40iw_hw.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/hw/i40iw/i40iw_hw.c
> > b/drivers/infiniband/hw/i40iw/i40iw_hw.c
> > index 55a1fbf0e670..ae8b97c30665 100644
> > +++ b/drivers/infiniband/hw/i40iw/i40iw_hw.c
> > @@ -534,7 +534,7 @@ void i40iw_manage_arp_cache(struct i40iw_device
> *iwdev,
> >  	int arp_index;
> >
> >  	arp_index = i40iw_arp_table(iwdev, ip_addr, ipv4, mac_addr, action);
> > -	if (arp_index == -1)
> > +	if (arp_index < 0)
> >  		return;
> >  	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, false);
> >  	if (!cqp_request)
> 
> It is right Shiraz?
> 
Yes. Not convinced i40iw_manage_arp_cache being a void is ok
but that's a separate problem which I ll review internally.

Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>


