Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FB144B278
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Nov 2021 19:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbhKISKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 9 Nov 2021 13:10:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:63901 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241477AbhKISKp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 9 Nov 2021 13:10:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232356425"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="232356425"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 10:07:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="545427672"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2021 10:07:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 10:07:47 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 9 Nov 2021 10:07:46 -0800
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.012;
 Tue, 9 Nov 2021 10:07:46 -0800
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH for-next] RDMA/irdma: Use helper function to set GUIDs
Thread-Topic: [PATCH for-next] RDMA/irdma: Use helper function to set GUIDs
Thread-Index: AQHX1B2oW9YzleS7Z021UOW4kJ8dz6v7gBBw
Date:   Tue, 9 Nov 2021 18:07:46 +0000
Message-ID: <cd149375cf544d99817925295cc8a36c@intel.com>
References: <20211107212227.44610-1-kamalheib1@gmail.com>
In-Reply-To: <20211107212227.44610-1-kamalheib1@gmail.com>
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

> Subject: [PATCH for-next] RDMA/irdma: Use helper function to set GUIDs
> 
> Use the addrconf_addr_eui48() helper function to set the GUIDs for both RoCE
> and iWARP modes, Also make sure the GUIDs are valid EUI-64 identifiers.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 

Looks ok. Thanks!

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
