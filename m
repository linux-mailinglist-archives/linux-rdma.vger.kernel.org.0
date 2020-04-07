Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C471A188A
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Apr 2020 01:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGXUM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 19:20:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46067 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGXUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Apr 2020 19:20:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id m67so1266318qke.12
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2020 16:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlDHGZcWKCAFSbOO53Z/FyvtmMAg2FluX+COU1Hm9As=;
        b=WtB/aAWuO+h3kR+BTSgXV6ENJF0M1+ug3X+GozGdCgpsaADhsIpnt9bprKJIcnUTBZ
         mu1wjM25TR5B5lZzG82Fv2uLJgC2d7n+iRukqX64GR7wz0fs9Lq24OAJFDK+NrHexghR
         n0tFYmOi+iNqRUeaKksZliFU9c6o0q8TQxRpYd8fpct98QBaxJJhqtE357BXNmQgJhs5
         QddSFj7pDQwWUCGEtzASTGd9Z8mrZ8bl+GmCH7X32hbPu3fEHPFt6RFgJkCXixc7IYoB
         Pa6GJJZzR1Of3wtUAdZjUjqheO/4rk1ZvIdtcKdHEEhvAlAIBvWHrrR0qV3KxNPy99vN
         Chgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QlDHGZcWKCAFSbOO53Z/FyvtmMAg2FluX+COU1Hm9As=;
        b=RAhiRlYyLDnwMZoQobnH1b8AqMIig1ezVk5LDEGGLdXwGIMnjFDSr3Dt9DyLLbNpL4
         A63aDkNsjHyzRJFM9jkq/Fq8jCvypMtXnFwhGujAt5kT4v6e9ufsooENHwsZVzdmqlR2
         /ShCLVMVtBwH2/JbNQBgvDQROKCYQxsmXlRIfc23bQ1/8FMKaNBWytmfL8jOf93MPi0k
         IalHBls80rYEZ82ZUfdNOeWHrxAfc8+y9+upOR9KypjB1qNyw9Exgwly/dWT7SrdB9Rk
         flMSI16wPf0BnPgaHeSentndTj59ENLIWLUrfC5WH1F7YKhc1kfhiGbs+OEEk4l5bnSO
         cKlQ==
X-Gm-Message-State: AGi0PuZ2VLCgIic8pnVmdquT3+nkBHSOlytx9+b+PH0QD+H3aqFRRX0K
        Z++P/rd+RoL1HSlP9vNqNs9Mn523U8UwOQ==
X-Google-Smtp-Source: APiQypJNyFeEPRC1ygFrDrg61ibpmAoTYg0O4aMmkQ3ClpAwyx9mAjG36SXmG4ZGeiS09VTt3KhNtg==
X-Received: by 2002:a37:678f:: with SMTP id b137mr4784930qkc.500.1586301610827;
        Tue, 07 Apr 2020 16:20:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h46sm18529883qtc.84.2020.04.07.16.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 16:20:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLxVp-0006ft-Ce; Tue, 07 Apr 2020 20:20:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH] RDMA: Remove a few extra calls to ib_get_client_data()
Date:   Tue,  7 Apr 2020 20:20:09 -0300
Message-Id: <0-v1-fae83f600b4a+68-less_get_client_data%jgg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

These four places already have easy access to the client data, just use
that instead.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/sa_query.c    | 15 ++++++---------
 drivers/infiniband/core/user_mad.c    |  3 +--
 drivers/infiniband/ulp/srpt/ib_srpt.c |  7 ++-----
 net/smc/smc_ib.c                      |  3 +--
 4 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 74e0058fcf9e1d..2dd326f2beed0d 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1412,17 +1412,13 @@ void ib_sa_pack_path(struct sa_path_rec *rec, void *attribute)
 EXPORT_SYMBOL(ib_sa_pack_path);
 
 static bool ib_sa_opa_pathrecord_support(struct ib_sa_client *client,
-					 struct ib_device *device,
+					 struct ib_sa_device *sa_dev,
 					 u8 port_num)
 {
-	struct ib_sa_device *sa_dev = ib_get_client_data(device, &sa_client);
 	struct ib_sa_port *port;
 	unsigned long flags;
 	bool ret = false;
 
-	if (!sa_dev)
-		return ret;
-
 	port = &sa_dev->port[port_num - sa_dev->start_port];
 	spin_lock_irqsave(&port->classport_lock, flags);
 	if (!port->classport_info.valid)
@@ -1450,8 +1446,8 @@ enum opa_pr_supported {
  * query is possible.
  */
 static int opa_pr_query_possible(struct ib_sa_client *client,
-				 struct ib_device *device,
-				 u8 port_num,
+				 struct ib_sa_device *sa_dev,
+				 struct ib_device *device, u8 port_num,
 				 struct sa_path_rec *rec)
 {
 	struct ib_port_attr port_attr;
@@ -1459,7 +1455,7 @@ static int opa_pr_query_possible(struct ib_sa_client *client,
 	if (ib_query_port(device, port_num, &port_attr))
 		return PR_NOT_SUPPORTED;
 
-	if (ib_sa_opa_pathrecord_support(client, device, port_num))
+	if (ib_sa_opa_pathrecord_support(client, sa_dev, port_num))
 		return PR_OPA_SUPPORTED;
 
 	if (port_attr.lid >= be16_to_cpu(IB_MULTICAST_LID_BASE))
@@ -1574,7 +1570,8 @@ int ib_sa_path_rec_get(struct ib_sa_client *client,
 
 	query->sa_query.port     = port;
 	if (rec->rec_type == SA_PATH_REC_TYPE_OPA) {
-		status = opa_pr_query_possible(client, device, port_num, rec);
+		status = opa_pr_query_possible(client, sa_dev, device, port_num,
+					       rec);
 		if (status == PR_NOT_SUPPORTED) {
 			ret = -EINVAL;
 			goto err1;
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 1235ffb2389b1c..7f1bd34c239c7f 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1154,8 +1154,7 @@ MODULE_ALIAS_RDMA_CLIENT("umad");
 static int ib_issm_get_nl_info(struct ib_device *ibdev, void *client_data,
 			       struct ib_client_nl_info *res)
 {
-	struct ib_umad_device *umad_dev =
-		ib_get_client_data(ibdev, &umad_client);
+	struct ib_umad_device *umad_dev = client_data;
 
 	if (!rdma_is_port_valid(ibdev, res->port))
 		return -EINVAL;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 98552749d71cbd..9d02d8088f1c26 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -135,14 +135,11 @@ static bool srpt_set_ch_state(struct srpt_rdma_ch *ch, enum rdma_ch_state new)
 static void srpt_event_handler(struct ib_event_handler *handler,
 			       struct ib_event *event)
 {
-	struct srpt_device *sdev;
+	struct srpt_device *sdev =
+		container_of(handler, struct srpt_device, event_handler);
 	struct srpt_port *sport;
 	u8 port_num;
 
-	sdev = ib_get_client_data(event->device, &srpt_client);
-	if (!sdev || sdev->device != event->device)
-		return;
-
 	pr_debug("ASYNC event= %d on device= %s\n", event->event,
 		 dev_name(&sdev->device->dev));
 
diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index d6ba186f67e2aa..995313e3f6ffed 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -570,9 +570,8 @@ static void smc_ib_add_dev(struct ib_device *ibdev)
 /* callback function for ib_unregister_client() */
 static void smc_ib_remove_dev(struct ib_device *ibdev, void *client_data)
 {
-	struct smc_ib_device *smcibdev;
+	struct smc_ib_device *smcibdev = client_data;
 
-	smcibdev = ib_get_client_data(ibdev, &smc_ib_client);
 	if (!smcibdev || smcibdev->ibdev != ibdev)
 		return;
 	ib_set_client_data(ibdev, &smc_ib_client, NULL);
-- 
2.26.0

