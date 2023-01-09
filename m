Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E8F662FD6
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jan 2023 20:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjAITEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Jan 2023 14:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237323AbjAITE3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Jan 2023 14:04:29 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2104.outbound.protection.outlook.com [40.107.102.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E85392CA
        for <linux-rdma@vger.kernel.org>; Mon,  9 Jan 2023 11:04:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAiGRw/ssHty/kmpcs1gQjgCUwbYermkyELMdaYv2X6WgKOUkqom4bK+VL3sRYm32l4GNHFBdZ48gu17NvnYuxstE60PrTKKs1z4pKs0vkbjlvPZbTp6yqdYZyTmfu++nqwJ0kE2flBQNJ+KEjpWcdCjjQbn2Y1WQqJ9njZhecJTMBObGiHx3eWteSMhaaBTmnQqPzJunhmVQZ5NbMMIIzJhgAfqSIjYfgbT4K7HeUPeZMKkNqyNePP9VS0vx0W1iPINWiXxrXx7M0QYY+R3xJXdatCNTbUMWHCmYk8iE0iz6gVNMU2y2oRfuzUelbuMKCbRnUN34e3H+sNXZH5vCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LJwKoJLP0snXc8RW9WMN8sZHPQML36iDXo9+QCdilU=;
 b=QHO/e4qdkNyANPUvA03GJLxiMZXmwVn5FJ1Gj5YaJbjED/Aw2EokAq0xSjG0OGcMqHZFDIh/HWMppNf0hFgnXTix5qXYveSZcEUL9xQcqrDfx6wm1NgmoyB2mPPt6uLq58N0FQTTq6ji9iJZYGu4EQW8fgzAiZKFDXClSJgt6LtavMV/dPs+w8SD4MZgZISrDwSi28ZeSPkG+xTpqhKG6rRTeLN7C8bXE+HsWTyEfiBdv9W54f9pQuKiDJQgP9Tar4j4TkpufuUbocdfJreRZB37jpkrXs/IxwNhlop/agvcKClF9TMw7A2zLda5hqCKbC2gDkyKwq1/9jxjfVmTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LJwKoJLP0snXc8RW9WMN8sZHPQML36iDXo9+QCdilU=;
 b=ZgmCOUtG5nimvZncEnWL8HZ2GGnBBQiOZxGxTbjcutXDO3Iq+/PkL016soDkoUQC3vEXcuAYonGYpOyOrWPOvyvpmo5oQtEoEfGGv7ra3QBpfWngsk8Jmb5w7bTsMIir/i59bn2Ru6NipViYZpa14GSpjoJRhOeOjikZNX4Q1+LWxntAuq6AAd++BIBLnu2hyiiZblDaaqzYm/VLFUYsIkoeyGWFV4OeuNaXzfVcAi7LmY+0vZpNG4uUGdsFtEbaH1QoA4InCVxkAYAlfL7xXWXXGKOW2WVEIyFBd8ts0Byges2jdRTOavEmrlPOja9y7+4Pnks3xzFlMlth4AEnGg==
Received: from MW4PR04CA0073.namprd04.prod.outlook.com (2603:10b6:303:6b::18)
 by PH0PR01MB7256.prod.exchangelabs.com (2603:10b6:510:105::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 19:04:25 +0000
Received: from CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::c0) by MW4PR04CA0073.outlook.office365.com
 (2603:10b6:303:6b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 19:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT102.mail.protection.outlook.com (10.13.175.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 19:04:25 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 309J4OUL1477937;
        Mon, 9 Jan 2023 14:04:24 -0500
Subject: [PATCH for-next 5/7] IB/hfi1: Split IB counter allocation
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Mon, 09 Jan 2023 14:04:24 -0500
Message-ID: <167329106431.1472990.12587703493884915680.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
References: <167328561962.1472990.9463955313515395755.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT102:EE_|PH0PR01MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e5182b-33d3-4dd6-91e5-08daf2745370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJ0qKQdte9qebdAIVr/lphp9ZpxZoWTKDu1pkFFJJFOEtfWRNfYPO19EZRjE9od0yCFwlK2kJFEg4bBzNnQWeFi52fmICnaoExc1ZryZLbzTCt6AMa0Hf9BdN+lvLaclphEASg99JgUETYOrDYwEpdwT+dly3T29HpZ0lAX8ASvUjbk94IQPEnJqLgtZxsLU3Fk8lHCmQIdgry/jyCqoFLS/2wXixJ5AbWjscXT4NeITebazAVSmkJu6LaOmkFz1Xm4TDIPKR/gmDRbm6GnTB8qBROGFK5Du0QeLzrFwWcTzrCg4Auppukka0OF5e7bUwDqxWq/rDunebyo91EQivd7JAJEViVAeIsFm56GEg36VmpvTF9NfVwQfy1LKw4mExsSoc7nmr9+eEDVl3D2mwKWtsUVBMixtqOsALPCoyQWa/Zv1RumALm0hRwO9+ZGn1TG2NanFvQYJhFX0fy3QVsCtzbQpDbBiQsfTkUxd7lIFJg4iDD+p21EFbKJ1RZ/h2nTmLVTfbZ3sfalZuqhCDbBODE+cPgeD/t27WpaqTXv2YEU93XXvejdyOzeshwxJaz3Cj+ZPofeA0daHlRWh/wn2lSypuJ9AXsdldvMX2tb/DfuQeHbnnatVaOB2X5oxm4cKtmMsCGXGnzAqfyKFo0B+9qIKWrTY1oBAcFDRjRSWcuwKTA6DMA4nln2NBIHWonpdAY2cZMO4lJ0kNU/APg==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39840400004)(451199015)(46966006)(36840700001)(82310400005)(8936002)(2906002)(5660300002)(47076005)(426003)(41300700001)(81166007)(7696005)(70206006)(4326008)(70586007)(8676002)(316002)(356005)(44832011)(186003)(26005)(40480700001)(7126003)(336012)(55016003)(86362001)(83380400001)(36860700001)(103116003)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:04:25.4798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e5182b-33d3-4dd6-91e5-08daf2745370
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Dean Luick <dean.luick@cornelisnetworks.com>

Split the IB device and port counter allocation.  Remove
the need for a lock.  Clean up pointer usage.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/verbs.c |   81 ++++++++++++++----------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index e6e17984553c..7f6d7fc7951d 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1598,13 +1598,11 @@ static const char * const driver_cntr_names[] = {
 	"DRIVER_EgrHdrFull"
 };
 
-static DEFINE_MUTEX(cntr_names_lock); /* protects the *_cntr_names bufers */
 static struct rdma_stat_desc *dev_cntr_descs;
 static struct rdma_stat_desc *port_cntr_descs;
 int num_driver_cntrs = ARRAY_SIZE(driver_cntr_names);
 static int num_dev_cntrs;
 static int num_port_cntrs;
-static int cntr_names_initialized;
 
 /*
  * Convert a list of names separated by '\n' into an array of NULL terminated
@@ -1615,8 +1613,8 @@ static int init_cntr_names(const char *names_in, const size_t names_len,
 			   int num_extra_names, int *num_cntrs,
 			   struct rdma_stat_desc **cntr_descs)
 {
-	struct rdma_stat_desc *q;
-	char *names_out, *p;
+	struct rdma_stat_desc *names_out;
+	char *p;
 	int i, n;
 
 	n = 0;
@@ -1624,65 +1622,45 @@ static int init_cntr_names(const char *names_in, const size_t names_len,
 		if (names_in[i] == '\n')
 			n++;
 
-	names_out =
-		kzalloc((n + num_extra_names) * sizeof(*q) + names_len,
-			GFP_KERNEL);
+	names_out = kzalloc((n + num_extra_names) * sizeof(*names_out)
+				+ names_len,
+			    GFP_KERNEL);
 	if (!names_out) {
 		*num_cntrs = 0;
 		*cntr_descs = NULL;
 		return -ENOMEM;
 	}
 
-	p = names_out + (n + num_extra_names) * sizeof(*q);
+	p = (char *)&names_out[n + num_extra_names];
 	memcpy(p, names_in, names_len);
 
-	q = (struct rdma_stat_desc *)names_out;
 	for (i = 0; i < n; i++) {
-		q[i].name = p;
+		names_out[i].name = p;
 		p = strchr(p, '\n');
 		*p++ = '\0';
 	}
 
 	*num_cntrs = n;
-	*cntr_descs = (struct rdma_stat_desc *)names_out;
+	*cntr_descs = names_out;
 	return 0;
 }
 
-static int init_counters(struct ib_device *ibdev)
-{
-	struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
-	int i, err = 0;
-
-	mutex_lock(&cntr_names_lock);
-	if (cntr_names_initialized)
-		goto out_unlock;
-
-	err = init_cntr_names(dd->cntrnames, dd->cntrnameslen, num_driver_cntrs,
-			      &num_dev_cntrs, &dev_cntr_descs);
-	if (err)
-		goto out_unlock;
-
-	for (i = 0; i < num_driver_cntrs; i++)
-		dev_cntr_descs[num_dev_cntrs + i].name = driver_cntr_names[i];
-
-	err = init_cntr_names(dd->portcntrnames, dd->portcntrnameslen, 0,
-			      &num_port_cntrs, &port_cntr_descs);
-	if (err) {
-		kfree(dev_cntr_descs);
-		dev_cntr_descs = NULL;
-		goto out_unlock;
-	}
-	cntr_names_initialized = 1;
-
-out_unlock:
-	mutex_unlock(&cntr_names_lock);
-	return err;
-}
-
 static struct rdma_hw_stats *hfi1_alloc_hw_device_stats(struct ib_device *ibdev)
 {
-	if (init_counters(ibdev))
-		return NULL;
+	if (!dev_cntr_descs) {
+		struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+		int i, err;
+
+		err = init_cntr_names(dd->cntrnames, dd->cntrnameslen,
+				      num_driver_cntrs,
+				      &num_dev_cntrs, &dev_cntr_descs);
+		if (err)
+			return NULL;
+
+		for (i = 0; i < num_driver_cntrs; i++)
+			dev_cntr_descs[num_dev_cntrs + i].name =
+							driver_cntr_names[i];
+	}
 	return rdma_alloc_hw_stats_struct(dev_cntr_descs,
 					  num_dev_cntrs + num_driver_cntrs,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
@@ -1691,8 +1669,16 @@ static struct rdma_hw_stats *hfi1_alloc_hw_device_stats(struct ib_device *ibdev)
 static struct rdma_hw_stats *hfi_alloc_hw_port_stats(struct ib_device *ibdev,
 						     u32 port_num)
 {
-	if (init_counters(ibdev))
-		return NULL;
+	if (!port_cntr_descs) {
+		struct hfi1_devdata *dd = dd_from_ibdev(ibdev);
+		int err;
+
+		err = init_cntr_names(dd->portcntrnames, dd->portcntrnameslen,
+				      0,
+				      &num_port_cntrs, &port_cntr_descs);
+		if (err)
+			return NULL;
+	}
 	return rdma_alloc_hw_stats_struct(port_cntr_descs, num_port_cntrs,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
@@ -1917,13 +1903,10 @@ void hfi1_unregister_ib_device(struct hfi1_devdata *dd)
 	del_timer_sync(&dev->mem_timer);
 	verbs_txreq_exit(dev);
 
-	mutex_lock(&cntr_names_lock);
 	kfree(dev_cntr_descs);
 	kfree(port_cntr_descs);
 	dev_cntr_descs = NULL;
 	port_cntr_descs = NULL;
-	cntr_names_initialized = 0;
-	mutex_unlock(&cntr_names_lock);
 }
 
 void hfi1_cnp_rcv(struct hfi1_packet *packet)


