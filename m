Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF38667E52
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jan 2023 19:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjALSoj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 13:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240734AbjALSnx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 13:43:53 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2112.outbound.protection.outlook.com [40.107.102.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10FF0D
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 10:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIIHtT6dHla230WPyd7JoXWbu8js7ELcjO0YAOFVZoDdu3fRIGh3rrwAF3BbzYlKRkRyGbtwf/hbE/OKoGIgLnw5kdCNPPdpluHH3yBUvNGyIIG6ysicMYHtNnsmOalze2dURVYzGSO+w/fW5KMqFhRODUkBjhorFJqsenHj70J6xdy8Hkn5SwEVVvhPvVx0tD8wtKjfqmuQ7FG6bA8FANyqmK954mOqXt+B9M1IPpz3kfL516wBp/V/lji4+oXUbRXFcpiVQ+PbkgNgP8MwwOQPuuM8RVoOoJ8cSayuOW+B7lt6feM+t3hNHkqWQxdC66HztPah6P7H4MUR8mHIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jsuF4mAZQhltBu02IijkC+9fTfKg40Ekovt0etJNn8=;
 b=l1mzOHiWopJud6n9zYbj8hIGUjZCscLu1To4JetqeJIDdMW524RI0tYrYbnPSlT833R2kJm+ONnddzvQixChuSd+jZiI+JTQaBvL8tvIiAGjOS+Pax7XhxON9WzU4p66LqlijlDBgrTRFECyoWXDqpah4woEzYNJZQ517v8/nhn5oQCMdqb68binAS2QDav9d3lS0A77YwKZBW8lnIUn4seEHVOuedrJ1bBVA5Af2dyLyOgJL0+BRrDluu5t7KWxvxBU9CkHjQoPt5fpYXl8EzIukKHwq0X/vxcEgh9CrhWTbjuD6Zz0JQqQkiVSrtGzbIS8wYMFpyJOR4m0n1x6bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jsuF4mAZQhltBu02IijkC+9fTfKg40Ekovt0etJNn8=;
 b=iGtJjvFtW3yOK0z8mOKQTQAbXDCsV0XB3fxAnsdI91LBtc6nEkednCgTE4FKEcmQlQSktHiUJsiOgkjNggwaYuPyx/pVxK/PsEiSmzFzX2Q+AU72fQm1QLksPd2t8nVjAJ3X+apOs83UIr/SdJWmAOzl4y2vbO4wfagE23xvHUL1U1gNjcpqEf/NZCZ7WO8+GD4sqWj68SibhTSW1uOijb6XhItxfLkoor3gjKg0QGERwjzqgaaMB9lmboxdvOXD8foV+pVHrNRd1M2gdsgLC+Sg2xGFJ+o5+ak+QFsz7BUD0nwqNQ/VPLpw1cXkeYie3A30sm5DpK2mqelw6qrQDw==
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 CO1PR01MB7322.prod.exchangelabs.com (2603:10b6:303:155::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Thu, 12 Jan 2023 18:16:04 +0000
Received: from DS1PEPF0000E651.namprd02.prod.outlook.com
 (2603:10b6:8:2a:cafe::38) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Thu, 12 Jan 2023 18:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-02.cornelisnetworks.com; pr=C
Received: from awfm-02.cornelisnetworks.com (208.255.156.42) by
 DS1PEPF0000E651.mail.protection.outlook.com (10.167.18.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Thu, 12 Jan 2023 18:16:03 +0000
Received: from awfm-02.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-02.cornelisnetworks.com (8.16.1/8.16.1) with ESMTP id 30CIG2Jr2132385;
        Thu, 12 Jan 2023 13:16:02 -0500
Subject: [PATCH for-rc v2] IB/hfi1: Restore allocated resources on failed
 copyout
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@nvidia.com, leonro@nvidia.com
Cc:     Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Date:   Thu, 12 Jan 2023 13:16:02 -0500
Message-ID: <167354736291.2132367.10894218740150168180.stgit@awfm-02.cornelisnetworks.com>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E651:EE_|CO1PR01MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a2ab0e-efe2-413a-0931-08daf4c91148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /r9faEunmsrizGGZ3So7R7mAWJuIqH/KBW/sg/Fe0nr2JGG2ziQuJdiaw7Owc2aS9IzYQzkaoJJ0W+5PDX965oBcuh31RJvN0KTKPIxdszAZwQGmv33xRrwPDcUPvRUNkgEiuY5V9hagsxDmhdHAwfy5mNXB/jPuY90RP4uPGcpUsD27XZPvZTEQeRS1/UiUe7zBr8FyS3KTJP/RQy/eyzeMEfKq04oT3FwdxaxDMyjQY4LLClciLz8atDWUtkzFXzhwYDclzBWs9e+yLMbR+uNsN8r7i9e5jVEKEX+7cdGrLHWgjSrEcXjx2CwfcwydCskJGH5SuA4FwMbhgPyeFkFIbWCbkhH7AD8M3AORRd6+1irq2R6pPkIG9rXFfJRWNhizjDjru2S34ABCE5yEtuWU6KjUKn/+mEP3ftwJEvp4+hru1OMFAWtXA6xMvhvEX9hJL/wQJjlwf1IRgTSlo99e0pmQgTB2NdwxVR+LsSzs+2DBALttRnHM2QEE9On7lRaW9QoDBiSjvgzHbbk2jRzvq/bc8tspQsEVEwqY0150Jbwl1Po4NLDWke8Y6X69yT7Pvi8DkBnrwiDE36MGfiuXfoQpf8KQzPvuXR7G0fESdMYvV5TQEPr8/BZPR60USttjb0fvdqESFZx2QUL8MiFKCm5dyH6WY0seEVt7Lu552oNay309P/kpYKDJSaD5ysPp1h6yk07iHsI+DCFskg==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-02.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39840400004)(396003)(451199015)(36840700001)(46966006)(81166007)(356005)(426003)(41300700001)(103116003)(47076005)(478600001)(7126003)(316002)(26005)(336012)(55016003)(7696005)(70206006)(186003)(40480700001)(82310400005)(86362001)(70586007)(36860700001)(5660300002)(2906002)(44832011)(4326008)(8676002)(83380400001)(8936002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 18:16:03.9852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a2ab0e-efe2-413a-0931-08daf4c91148
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-02.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E651.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB7322
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

Fix a resource leak if an error occurs.

Fixes: f404ca4c7ea8 ("IB/hfi1: Refactor hfi_user_exp_rcv_setup() IOCTL")
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---

Changes from v1:
Do not call copy_to_user() again if the first one failed.
---
 drivers/infiniband/hw/hfi1/file_ops.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index f5f9269fdc16..7c5d487ec916 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -1318,12 +1318,15 @@ static int user_exp_rcv_setup(struct hfi1_filedata *fd, unsigned long arg,
 		addr = arg + offsetof(struct hfi1_tid_info, tidcnt);
 		if (copy_to_user((void __user *)addr, &tinfo.tidcnt,
 				 sizeof(tinfo.tidcnt)))
-			return -EFAULT;
+			ret = -EFAULT;
 
 		addr = arg + offsetof(struct hfi1_tid_info, length);
-		if (copy_to_user((void __user *)addr, &tinfo.length,
+		if (!ret && copy_to_user((void __user *)addr, &tinfo.length,
 				 sizeof(tinfo.length)))
 			ret = -EFAULT;
+
+		if (ret)
+			hfi1_user_exp_rcv_invalid(fd, &tinfo);
 	}
 
 	return ret;


