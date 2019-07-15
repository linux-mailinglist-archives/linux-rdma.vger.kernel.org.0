Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B58569A76
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfGOSFe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 15 Jul 2019 14:05:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:17891 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfGOSFe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 15 Jul 2019 14:05:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 11:05:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="169015436"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jul 2019 11:05:33 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jul 2019 11:05:32 -0700
Received: from fmsmsx120.amr.corp.intel.com ([169.254.15.50]) by
 fmsmsx118.amr.corp.intel.com ([169.254.1.247]) with mapi id 14.03.0439.000;
 Mon, 15 Jul 2019 11:05:32 -0700
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH 0/6] More 5.3 patches
Thread-Topic: [PATCH 0/6] More 5.3 patches
Thread-Index: AQHVOyzL+PXaI1F4XkKHg1EwLEsgCabMa5mA//+KxsCAAHgJAP//ituQ
Date:   Mon, 15 Jul 2019 18:05:32 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC70E1504B@fmsmsx120.amr.corp.intel.com>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
 <20190715175409.GA4970@ziepe.ca>
 <32E1700B9017364D9B60AED9960492BC70E15005@fmsmsx120.amr.corp.intel.com>
 <20190715180412.GB4970@ziepe.ca>
In-Reply-To: <20190715180412.GB4970@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmVkYzRlZjAtMDcxOC00NmVjLWI1MTQtMTkxMjZhNmYxMjFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieWNVNlJnZXRcLzhueVp1WmxueSt2eDA4bDBNZ1JNTGdFXC9QUlwvcnJWbXY0Q0Fxc2hGRGV2NklUYVdvbmJ3ZUk1QyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> > They apply cleanly to for-next and rdma/for-next.
> 
> Those branches are done - we are jumping to 5.3-rc1 next Monday.
> 
> Jason

Ok.  I will resubmit on that base.

Mike
