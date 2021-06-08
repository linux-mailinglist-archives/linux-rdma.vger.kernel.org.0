Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149F43A07B4
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 01:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhFHXV4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 8 Jun 2021 19:21:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:52974 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234935AbhFHXV4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 19:21:56 -0400
IronPort-SDR: MXt3pJdBD6nEcc1RwXn0zN3XbvRw1fH9dIMCnqFKoqtQXNL0iee5qZE5jLTSYkMbTK0jvRA5rG
 WPBMsI6jtVbA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192073617"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="192073617"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:20:01 -0700
IronPort-SDR: KkTY5Z5XgiTVKbjF4CMt8dRyVqpD1jLTswMaok1hNW10RFQqiUjaGkkE5nzTsetAC1hJbtlBHu
 Fw9R1TA+hhAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="485492702"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2021 16:20:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 16:20:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 16:19:59 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2242.008;
 Tue, 8 Jun 2021 16:19:59 -0700
From:   "Saleem, Shiraz" <shiraz.saleem@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
Thread-Topic: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
Thread-Index: AQHXXKtJOg723JZ3GkKQmWFOucdPbqsLMV0A//+MguA=
Date:   Tue, 8 Jun 2021 23:19:58 +0000
Message-ID: <8d892696e01c47998b104579f489da25@intel.com>
References: <20210608211415.680-1-shiraz.saleem@intel.com>
 <20210608230448.GS1002214@nvidia.com>
In-Reply-To: <20210608230448.GS1002214@nvidia.com>
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

> Subject: Re: [PATCH rdma-next v1] irdma: Use list_last_entry/list_first_entry
> 
> On Tue, Jun 08, 2021 at 04:14:16PM -0500, Shiraz Saleem wrote:
> > Use list_last_entry and list_first_entry instead of using prev and
> > next pointers.
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> > ---
> > v0->v1: create patch on more recent git version
> >
> >  drivers/infiniband/hw/irdma/puda.c  | 2 +-
> > drivers/infiniband/hw/irdma/utils.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> This still doesn't apply to the rdma tree.. You need to use the exact rdma tree, not
> wherever this came from.
> 
> Anyhow I fixed it up by hand.
> 

I am not really sure what is going on. This applies cleanly for me to the tip of for-next. Here is snippet of git log -p.

commit fc7f645ca3c1b7a7e9f8eabc83a6ee462b277194 (HEAD -> rdma-for-next)
Author: Shiraz Saleem <shiraz.saleem@intel.com>
Date:   Tue Jun 8 12:02:30 2021 -0500

    irdma: Use list_last_entry/list_first_entry
    
    Use list_last_entry and list_first_entry instead of using prev and next
    pointers.
    
    Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
    Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 18057139817d..e09d3be90771 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -1419,7 +1419,7 @@ irdma_ieq_handle_partial(struct irdma_puda_rsrc *ieq, struct irdma_pfpdu *pfpdu,
 
 error:
        while (!list_empty(&pbufl)) {
-               buf = (struct irdma_puda_buf *)(pbufl.prev);
+               buf = list_last_entry(&pbufl, struct irdma_puda_buf, list);
                list_del(&buf->list);
                list_add(&buf->list, rxlist);
        }
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8f04347be52c..b4b91cb81cca 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -425,8 +425,8 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
 
        spin_lock_irqsave(&cqp->req_lock, flags);
        if (!list_empty(&cqp->cqp_avail_reqs)) {
-               cqp_request = list_entry(cqp->cqp_avail_reqs.next,
-                                        struct irdma_cqp_request, list);
+               cqp_request = list_first_entry(&cqp->cqp_avail_reqs,
+                                              struct irdma_cqp_request, list);
                list_del_init(&cqp_request->list);
        }
        spin_unlock_irqrestore(&cqp->req_lock, flags);

commit 61c7d826b81769ea57d094305c900f903768f322 (upstream_v2/for-next)
Author: Kamal Heib <kamalheib1@gmail.com>
Date:   Tue Jun 8 01:15:43 2021 +0300

    RDMA/irdma: Fix return error sign from irdma_modify_qp
    
    There is a typo in the returned error code sign from irdma_modify_qp()
    when the attr_mask is not supported - Fix it.

[....]
