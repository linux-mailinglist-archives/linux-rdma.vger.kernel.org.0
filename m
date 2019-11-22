Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79152107722
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKVSQX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 22 Nov 2019 13:16:23 -0500
Received: from mga06.intel.com ([134.134.136.31]:62828 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfKVSQX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 22 Nov 2019 13:16:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 10:16:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="290720055"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 22 Nov 2019 10:16:12 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 10:16:13 -0800
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 10:16:13 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.94]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.139]) with mapi id 14.03.0439.000;
 Fri, 22 Nov 2019 12:16:10 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Hefty, Sean" <sean.hefty@intel.com>
Subject: RE: [PATCH rdma-next v1 03/48] RDMA/ucma: Mask QPN to be 24 bits
 according to IBTA
Thread-Topic: [PATCH rdma-next v1 03/48] RDMA/ucma: Mask QPN to be 24 bits
 according to IBTA
Thread-Index: AQHVoJdr+IGshBcVekuyjBi6jKUfq6eWBUsAgAEhFICAAFicMA==
Date:   Fri, 22 Nov 2019 18:16:09 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E92BDEDA1@CRSMSX101.amr.corp.intel.com>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-4-leon@kernel.org>
 <20191121213824.GA13840@iweiny-DESK2.sc.intel.com>
 <20191122065303.GB136476@unreal>
In-Reply-To: <20191122065303.GB136476@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTBjYzg1MDQtOThmMy00ZTkwLTliZDMtNzZhY2ViMjhhNGRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiazFBNnlGWmtZbFBGU2hRblprR2hEZDltOUcyQ0QzQzBoY1Z1dVpiRGJXYWRtUU5iTWk0ZlQ2XC9uWlk3V2xPbFwvIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> 
> On Thu, Nov 21, 2019 at 01:38:24PM -0800, Ira Weiny wrote:
> > > diff --git a/drivers/infiniband/core/ucma.c
> > > b/drivers/infiniband/core/ucma.c index 0274e9b704be..57e68491a2fd
> > > 100644
> > > --- a/drivers/infiniband/core/ucma.c
> > > +++ b/drivers/infiniband/core/ucma.c
> > > @@ -1045,7 +1045,7 @@ static void ucma_copy_conn_param(struct
> rdma_cm_id *id,
> > >  	dst->retry_count = src->retry_count;
> > >  	dst->rnr_retry_count = src->rnr_retry_count;
> > >  	dst->srq = src->srq;
> > > -	dst->qp_num = src->qp_num;
> > > +	dst->qp_num = src->qp_num & 0xFFFFFF;
> >
> > Isn't src->qp_num coming from userspace?  Why not return -EINVAL in
> > such a case?
> 
> I afraid that it will break userspace application, we had similar case in uverbs,
> where we added WARN_ON() while masked PSN and got endless amount of
> bug reports from our enterprise colleagues who didn't clear memory above
> those 24bits and saw kernel splats.

I want to say there is less change of that here because librdmacm should be handling most of these numbers within the library.

I have no dog in this fight so...

Ira

