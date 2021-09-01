Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B13FD8FF
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhIALuK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 1 Sep 2021 07:50:10 -0400
Received: from smtp.digdes.com ([85.114.5.13]:45999 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243957AbhIALuJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Sep 2021 07:50:09 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Sep 2021 07:50:08 EDT
Received: from DDSM-MAIL01.digdes.com (172.16.100.67) by relay.digdes.com
 (172.16.96.24) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 1 Sep
 2021 14:43:34 +0300
Received: from DDSM-MAIL02.digdes.com (172.16.100.74) by
 DDSM-MAIL01.digdes.com (172.16.100.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 14:43:34 +0300
Received: from DDSM-MAIL02.digdes.com ([fe80::3088:3004:df3c:83c4]) by
 ddsm-mail02.digdes.com ([fe80::3088:3004:df3c:83c4%8]) with mapi id
 15.01.2176.009; Wed, 1 Sep 2021 14:43:34 +0300
From:   Chesnokov Gleb <Chesnokov.G@raidix.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Topic: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Thread-Index: AQHXeN9BrGPA8AdBnUS24KgxTpIoiqtKCs4AgABs1p3///xlAIAEckoAgABcYwCAB7VNgIAP402AgBCyij6AAKtZAIAXHP5C
Date:   Wed, 1 Sep 2021 11:43:34 +0000
Message-ID: <c6827ac071364d488a3115d2cdcbff6e@raidix.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
 <20210722142346.GL1117491@nvidia.com>
 <d7cba69f-42f1-c86e-8c01-9ddba87332e8@grimberg.me>
 <20210727173709.GH1721383@nvidia.com>
 <4e31b660-822a-5bc9-26e3-76046049695a@grimberg.me>
 <57cdb944fa6e445c97692328fb2435c0@digdes.com>,<b5b8b842-897d-5cad-1f32-a212c9e91737@grimberg.me>
In-Reply-To: <b5b8b842-897d-5cad-1f32-a212c9e91737@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.100.54]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> There are two handlers in question here, the listener cm_id and
> the connection cm_id. The connection cma_id should definitely trigger
> disconnect and resource cleanup. The question is should the listener
> cma_id (which maps to the isert network portal - np) recreate the
> cma_id in this event.

1) How connection cm_id and isert_conn are created:
[cma.c]     - cma_ib_req_handler()
                 - * Create conn_id via cma_ib_new_conn_id(listen_id)
                 - * Calls isert_connect_request(conn_id)
[ib_isert.c] - - isert_connect_request(cma_id)
                 - - * isert_conn = kzalloc()
                 - - * isert_conn->cm_id = cma_id

2) Acceptance of the connection request starts after creating the listener cm_id:
[ib_isert.c] - isert_setup_id()
[ib_isert.c] - - rdma_listen()
[cma.c]      - - - cma_ib_listen()
[cma.c]      - - - - ib_cm_insert_listen(cma_ib_req_handler)


3) Processing RDMA_CM_EVENT_ADDR_CHANGE for connection cm_id:
[ib_isert.c] - rdma_disconnect(cm_id)
[ib_isert.c] - rdma_destroy_id(cm_id)
[ib_isert.c] - kfree(iser_conn)

4) Processing RDMA_CM_EVENT_ADDR_CHANGE for listener cm_id:

Since iser_conn has been freed, it needs to be recreated.

There are 2 options here:
a) listener cm_id needs to be recreated, it calls rdma_listen(),
which in turn initiates the acceptance of the connection request,
after which iser_conn will be created.

b) listener cm_id does not need to be recreated,
that is, RDMA_CM_EVENT_ADDR_CHANGE is informative for it.

I have tested my test case with the following patch that matches point b:

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 636d590765f9578c0ff595cdf74b79400bfa66ed..54f615828961576ffa1f74c8b9781a5cf48512a3 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -601,6 +601,8 @@ static int
 isert_np_cma_handler(struct isert_np *isert_np,
 		     enum rdma_cm_event_type event)
 {
+	int ret = -1;
+
 	isert_dbg("%s (%d): isert np %p\n",
 		  rdma_event_msg(event), event, isert_np);
 
@@ -609,19 +611,14 @@ isert_np_cma_handler(struct isert_np *isert_np,
 		isert_np->cm_id = NULL;
 		break;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
-		isert_np->cm_id = isert_setup_id(isert_np);
-		if (IS_ERR(isert_np->cm_id)) {
-			isert_err("isert np %p setup id failed: %ld\n",
-				  isert_np, PTR_ERR(isert_np->cm_id));
-			isert_np->cm_id = NULL;
-		}
+		ret = 0;
 		break;
 	default:
 		isert_err("isert np %p Unexpected event %d\n",
 			  isert_np, event);
 	}
 
-	return -1;
+	return ret;
 }
 
 static int

As a result, the listener cm_id remained, the connection request did not come, isert_conn was not recreated.
On the initiator, the load dropped to 0 and then ended.


With my patch that matches point a, the listener cm_id was recreated -> connection request was received -> isert_conn was created.

Based on the above, I can conclude that the RDMA_CM_EVENT_ADDR_CHANGE event is not informative for the listener cm_id.

Best regards,
Chesnokov Gleb
