Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517B47843AD
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 16:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbjHVOOM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 10:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjHVOOL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 10:14:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BECE2
        for <linux-rdma@vger.kernel.org>; Tue, 22 Aug 2023 07:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee3i2RFJkZIlIQzr+Mekpn4Sn8HK1//t9eZNtqXtXGO4j9XEOFg7RbVwiLz2nLKBmIBjOStdGGOHrHNAcji/hoi7nZL/q2WXLQfkminxldwkSdA+C8XP/s09p+Ja5HmPl6vb0odnv1154hlqRxPBWat0D9JVrz/1DAhwcTwg9HvDd/gPWOD4c2qavBC5hFvNVNj5MeH3EDQgE+IDuudTWcYtAkJEJqQAc5o2t6mnvOSYspOkUqeoEh26+xw90v3DjG36UkYZNe2rUE9XrxseIWsnD7pqH8d45E4cnHe3jbk3BjBXkC9rz/N60aeYiVKndV7cWhcXjdeS58ZepG0zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzDpvlu79L5Z3FpK3Sx3gI7kYhhnN063C4eTNgTBfwQ=;
 b=BUdDRg252Iu4TSKmUWrTE0AOeNZjkczERqx3FBs785QZ4LVxqvlNujJwOtBKcpvWUR/2AAh84Ta/DYm6Hal9dzPTXIBBUVFQX7hLZbnk+j32mn3E9Mv/3XqJwefrgcD+Tu9BXelgJjbRshlcFIsbkh4lg0PB/gH7Gq0wiaCoocJyy3sH/eqG3JsrVipNhuqoGeiBV4svIQ+wLmhuTtIgBQ7qAZzY24gsdzKWAEX+lTHsMdPg5p53jHhwnTn2znu1vvQ4TfPKzhRcMY5DxYxvom8G7WkvbOK/PrL8Wyc1l06XfAsLrQr0UioCsKxWLnh5iw/qQxcrR9Hqsd3U5ZACiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzDpvlu79L5Z3FpK3Sx3gI7kYhhnN063C4eTNgTBfwQ=;
 b=E5tlcSm/7JSD5RtlccGj5Zo7T9Adklu7rAOBUFIjQ8Euoh/HnZVCCUe3zJDsgLeaZ90QCBi7CbDgAt/D/uhsG4D+hkO6aSMEibzcj/zTETOo71n73ieQcAe1DBxBH9ElN0RYjL6Dy6IwIB5S7IH1RmGvgsPHw77stXMrcuT3RBcilOpXIXhke30hM2RUpyXzwHLKBC7ATfQrlnuFIr3jKls4OSZ4E3i578Jj3SnBFxLe+0hrPQuDmCw/dL8tt707c7MTrWFWe1mhDP0psgcS0xeX6TKtszuJ/KNoTZ64+BBTjPQ7Mr1HdIc1W9cMV+EeTfe6aQWMXX7laJyLlkVWmw==
Received: from MW4PR02CA0029.namprd02.prod.outlook.com (2603:10b6:303:16d::34)
 by SN7PR01MB8133.prod.exchangelabs.com (2603:10b6:806:353::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.25; Tue, 22 Aug 2023 14:08:00 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::c7) by MW4PR02CA0029.outlook.office365.com
 (2603:10b6:303:16d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 14:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Tue, 22 Aug 2023 14:07:59 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 37ME7wgq1856204;
        Tue, 22 Aug 2023 10:07:58 -0400
Subject: [PATCH for-next 2/2] IB/hfi1: Reduce printing of errors during driver
 shut down
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Douglas Miller <doug.miller@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Tue, 22 Aug 2023 10:07:58 -0400
Message-ID: <169271327832.1855761.3756156924805531643.stgit@awfm-02.cornelisnetworks.com>
In-Reply-To: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
References: <169271289743.1855761.7584504317823143869.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|SN7PR01MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 478b184d-1e17-42ef-a971-08dba3193138
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mrc27w4nJMAejFuxuUGHeWConZJWHBk0hE8puJTvZiDFc2xU0Ub9Iwb+alOTJXIFxnHrolCwOh0A0QxYS6hkN4NS/boTSdFJo/3XxoZJhPzrQHBppCwsw3TUVgRKJdp/FrySacLeHPe9VRU9CsWlHpUBofAKF/zAe/K0lj/cWId6ieAfTZeaz7k84kbHL4L5+3tbucKJWQ6vAMI+Wv0vbWkvMlwkMHBnx2UFpewaM6U4mq8aKL4EvKx6dh7yb55F9VpgJYamQR602nG7DTXWyB7MolqKtu/zRcZo1S0JpPoxdRKUAhUJXKdfxtUFUZHBEiZnrF3V0EG/wds9ky2LP2BVzuyJXFQkThESPu/F6rhErrvJ/pAX5R3UwEijE3BOprwvbb82LoyXFeb3MTXwC5xeWqo1Lgo6YbSsWTOupDM3X4DAv+Ag3m83gPrrZW5p45W0eNDHpA5A6RvGo8IHfZFN8RQZ0/EEd+OByZ5AwTF2/Cpou2nxsIkTBKxJH7/A9Q3tpovbcUgUD+sT8gM1CQzPcg47riS0/qpc78BvhjClxOE0+tM4Ew54gYpflq4Q0YTIYTJyxSEbGbl+wDEIhyjQDoVprmgRqE8teRlwsaj3u/tTAxwbRVbNALOeJAOSMZjMayTTh5TG8ebCs1DOsB6NuqjMnkbc3YrQBe4+HHOvoLpKaROyzdFHeuPOh69hQPnsAQjMmhlS8UExLs2ycQTOgrb0bbpsuFVEw6Xkp1A=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39840400004)(396003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(55016003)(7696005)(40480700001)(7126003)(103116003)(5660300002)(86362001)(44832011)(2906002)(4326008)(70206006)(70586007)(8936002)(41300700001)(8676002)(316002)(356005)(81166007)(478600001)(83380400001)(36860700001)(47076005)(336012)(426003)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:07:59.5707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478b184d-1e17-42ef-a971-08dba3193138
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Douglas Miller <doug.miller@cornelisnetworks.com>

The driver prints unnecessary prints for error conditions on shutdown
remove them to quiet it down.

Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/chip.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 9dbb89e9f4af..e954af824f37 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1461,7 +1461,8 @@ static u64 dc_access_lcb_cntr(const struct cntr_entry *entry, void *context,
 		ret = write_lcb_csr(dd, csr, data);
 
 	if (ret) {
-		dd_dev_err(dd, "Could not acquire LCB for counter 0x%x", csr);
+		if (!(dd->flags & HFI1_SHUTDOWN))
+			dd_dev_err(dd, "Could not acquire LCB for counter 0x%x", csr);
 		return 0;
 	}
 
@@ -6160,7 +6161,7 @@ static int request_host_lcb_access(struct hfi1_devdata *dd)
 	ret = do_8051_command(dd, HCMD_MISC,
 			      (u64)HCMD_MISC_REQUEST_LCB_ACCESS <<
 			      LOAD_DATA_FIELD_ID_SHIFT, NULL);
-	if (ret != HCMD_SUCCESS) {
+	if (ret != HCMD_SUCCESS && !(dd->flags & HFI1_SHUTDOWN)) {
 		dd_dev_err(dd, "%s: command failed with error %d\n",
 			   __func__, ret);
 	}
@@ -6241,7 +6242,8 @@ int acquire_lcb_access(struct hfi1_devdata *dd, int sleep_ok)
 	if (dd->lcb_access_count == 0) {
 		ret = request_host_lcb_access(dd);
 		if (ret) {
-			dd_dev_err(dd,
+			if (!(dd->flags & HFI1_SHUTDOWN))
+				dd_dev_err(dd,
 				   "%s: unable to acquire LCB access, err %d\n",
 				   __func__, ret);
 			goto done;


