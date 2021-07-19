Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA63CE2B8
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 18:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbhGSPbb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Jul 2021 11:31:31 -0400
Received: from smtp.digdes.com ([85.114.5.12]:65122 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345946AbhGSP1I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 11:27:08 -0400
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by relay2.digdes.com
 (172.16.96.56) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 19 Jul
 2021 19:07:45 +0300
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by
 DDSM-MAIL01.digdes.com (172.16.100.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 19:07:44 +0300
Received: from DDSM-MAIL01.digdes.com ([fe80::bcb8:b09e:6891:336a]) by
 ddsm-mail01.digdes.com ([fe80::bcb8:b09e:6891:336a%2]) with mapi id
 15.01.2176.009; Mon, 19 Jul 2021 19:07:44 +0300
From:   Chesnokov Gleb <Chesnokov.G@raidix.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Topic: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Index: AQHXeN9BrGPA8AdBnUS24KgxTpIoiqtKCs4AgABs1p0=
Date:   Mon, 19 Jul 2021 16:07:44 +0000
Message-ID: <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>,<20210719121302.GA1048368@nvidia.com>
In-Reply-To: <20210719121302.GA1048368@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.100.53]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> And I don't see anything preventing that from running concurrently
> with the WQ

Thanks, i made a fix.

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index de5ab2ae8e1738455bc36eca5487f1c9136e060e..6b0fc8d54f49102ad8c9fe67b1888dc6883f2164 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -601,14 +601,18 @@ static void isert_np_reinit_id_work(struct work_struct *w)
 {
 	struct isert_np *isert_np = container_of(w, struct isert_np, work);
 
-	rdma_destroy_id(isert_np->cm_id);
+	mutex_lock(&isert_np->id_mutex);
+	if (isert_np->cm_id) {
+		rdma_destroy_id(isert_np->cm_id);
 
-	isert_np->cm_id = isert_setup_id(isert_np);
-	if (IS_ERR(isert_np->cm_id)) {
-		isert_err("isert np %p setup id failed: %ld\n",
-			  isert_np, PTR_ERR(isert_np->cm_id));
-		isert_np->cm_id = NULL;
+		isert_np->cm_id = isert_setup_id(isert_np);
+		if (IS_ERR(isert_np->cm_id)) {
+			isert_err("isert np %p setup id failed: %ld\n",
+				  isert_np, PTR_ERR(isert_np->cm_id));
+			isert_np->cm_id = NULL;
+		}
 	}
+	mutex_unlock(&isert_np->id_mutex);
 }
 
 static int
@@ -2292,6 +2296,7 @@ isert_setup_np(struct iscsi_np *np,
 	}
 
 	INIT_WORK(&isert_np->work, isert_np_reinit_id_work);
+	mutex_init(&isert_np->id_mutex);
 
 	sema_init(&isert_np->sem, 0);
 	mutex_init(&isert_np->mutex);
@@ -2455,8 +2460,12 @@ isert_free_np(struct iscsi_np *np)
 	struct isert_np *isert_np = np->np_context;
 	struct isert_conn *isert_conn, *n;
 
-	if (isert_np->cm_id)
+	mutex_lock(&isert_np->id_mutex);
+	if (isert_np->cm_id) {
 		rdma_destroy_id(isert_np->cm_id);
+		isert_np->cm_id = NULL;
+	}
+	mutex_unlock(&isert_np->id_mutex);
 
 	/*
 	 * FIXME: At this point we don't have a good way to insure
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 5fdc799f3ca864667a454374f8548e7f031e9925..dafe7b44494d1d5687f0d87e18855d78e8729707 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -211,4 +211,5 @@ struct isert_np {
 	struct list_head	pending;
 	struct work_struct      work;
 	struct workqueue_struct *reinit_id_wq;
+	struct mutex		id_mutex;
 };

> What is this trying to do anyhow? If the addr has truely changed why
> does the bind fail?

When the active physical link member of bonding interface in active-standby 
mode gets faulty, the standby link will represent the assigned addresses on 
behalf of the active link.
Therefore, RDMA communication manager will notify iSER target with 
RDMA_CM_EVENT_ADDR_CHANGE.

The iSCSI socket address does not change.
But the cma_id at the IB layer, which is bound to the iSCSI socket, will change.
The problem is that the new cma_id is trying to bind to a socket address that is still bound to the old cma_id.
That is, before you bind a new cma_id to a socket, you must first delete the old one.

Best regards,
Chesnokov Gleb

From: Jason Gunthorpe <jgg@nvidia.com>
Sent: Monday, July 19, 2021 3:13:02 PM
To: lanevdenoche@gmail.com
Cc: linux-rdma@vger.kernel.org; sagi@grimberg.me; dledford@redhat.com; Chesnokov Gleb
Subject: Re: [PATCH 1/1] iser-target: Fix handling of RDMA_CV_EVENT_ADDR_CHANGE
    
On Wed, Jul 14, 2021 at 09:26:46PM +0300, lanevdenoche@gmail.com wrote:
> @@ -2466,6 +2489,8 @@ isert_free_np(struct iscsi_np *np)
>        }
>        mutex_unlock(&isert_np->mutex);
>  
> +     destroy_workqueue(isert_np->reinit_id_wq);
> +

This is racy, the lines above have:

        if (isert_np->cm_id)
                rdma_destroy_id(isert_np->cm_id);

And I don't see anything preventing that from running concurrently
with the WQ

What is this trying to do anyhow? If the addr has truely changed why
does the bind fail?

Jason
    
