Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3178643E136
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhJ1Msl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 08:48:41 -0400
Received: from mail-dm6nam10on2105.outbound.protection.outlook.com ([40.107.93.105]:11073
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230382AbhJ1Msi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 08:48:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqr3S20QfURBDDUY136ZFbFYfbqbfSBvpwJ21MUI17wjRvjF0MwQcmiNplWA+sgNUkIItMVVggJPo9cOCpKt7JxrPmwBaaLNeBiv5owfnEMSmGM3kzx43C2Gpj1C5zwtzGWEJ93V29t1YBjx3l2do8uLTDMlR6tu8whnmqzQWMrKjGiajKzN2995P0T45ntWllVuW6CJfaiZ9ZyZXtULw9VdsrYDdBsahchKIyz4q/18ibUovpfdpfaE3pNfGcy6cRIsEY3patSEC1NtKqfVqhj+oN6BIcwWdHfTBs366nWVlZUye1UnTRhPurE5OF9HYkH83Kg9mxiFTxp7nHY53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td6kpdR09IbE1NhQZMj7gETWXzBEN2HRKbta3Ak3bPc=;
 b=hea4TkR9whqL5td2s2S3miaU2mDjvW9kSaUybw3P39bFtQKUB9FmHWjr5G878diBBEsGJ+KpZztqfgxVy3QijkMYuMf7FSSo1zVNCSpPNWnmIo7tXORK5BY7jD88nsyb7lQGlUS710gT5pujAt3pzpQti2mNYUz3zET96/Hgztf9oAVIHFEUsk3Ju0GXb5vHCvJIU+kwkdmUO/KgUnrCOzis7hTLLAgcjOXV+RY4FPk5IZhckCghOkyxUsu8zGpkIRchvM/OIyWzpPMm36k/0AEDzvwvmkTnROAAJBj8L6X7vGjU/TBlspRiwyJX6YpzPvqGoDQoAQFvLGrplqfimQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td6kpdR09IbE1NhQZMj7gETWXzBEN2HRKbta3Ak3bPc=;
 b=LEjLgse7Zlry+gPBH4TKlyfe9eaxH4WNPVJylWHpwPiv2SpxoBqM9bHXzio1tBF8p9fzOk5aJxJqax/qohARBX5kVptVcmLo3g+TXmjE3xyYBYr7Yhz/zWbqSfuhmOeD/BcG+WIpBwkHzoC4AwEGK9Jw1tBXzFoI/Gb8BnMAWhZ8m4n+XN9VesBj5OujnLzMfGue7Twz3D7JQAYU84YQ9qWNlbYBX6zO+OK2sQHn5WKq54+BA+7VeVgz3nbhAZV2zMmAKD/RVDWHh3clNQLgzd189fXOmx8OmBB7sQUYOwMDsS0tEHDJfl5NUQn+e6oKWduOW7nxAmi4FPSQT/oDbg==
Received: from BN9PR03CA0565.namprd03.prod.outlook.com (2603:10b6:408:138::30)
 by BN0PR01MB6814.prod.exchangelabs.com (2603:10b6:408:149::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Thu, 28 Oct 2021 12:46:07 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::15) by BN9PR03CA0565.outlook.office365.com
 (2603:10b6:408:138::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend
 Transport; Thu, 28 Oct 2021 12:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 12:46:07 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19SCk6q1029048;
        Thu, 28 Oct 2021 08:46:06 -0400
Subject: [PATCH for-next 2/3] IB/qib: Rebranding of qib driver to Cornelis
 Networks
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Scott Breyer <scott.breyer@cornelisnetworks.com>
Date:   Thu, 28 Oct 2021 08:46:06 -0400
Message-ID: <20211028124606.26694.71567.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e84d8ab0-ba74-45f6-192f-08d99a10e926
X-MS-TrafficTypeDiagnostic: BN0PR01MB6814:
X-Microsoft-Antispam-PRVS: <BN0PR01MB681468991F55187B47A0B9C1F4869@BN0PR01MB6814.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtfYmC/L+I3B+LSPknhxh0uZHuYdaPQKjpBuQuHoUTeAFmXfwT0/kShf3TIalc8p23ET5gXWMYsTb4mf6EAL3ELmkmXtf8/fImWB8tfJtb7MRv28qJBXKaKp1P9RzVgCWcTG6D2HwPrxWgTSLQ/JhRkJnJ8xGSDxxfNlWa6mV78yYQSHiK9wdmq/L23kVc5C2KZEegZB1HfpkIqLqqcpkQR/dIgGwClfsAdP/ZeBSbhzUZ+ZPY9iqzlE/n84BPe0lxcPPhOXwSAMKu1/b5UgdmHbYwWIlGvYxupm0U6YMuBaSlevikrjzbTihnXNd/bQa+3zYcQh5I8BQzm9mkrKajskLIep1/e9dQUH6+YmoR2lU7c/82G4V/Qk0v+vAUwa7xuzl9uP3VZctx2A+nHCUFZPB0z/zdWe9NfVjnpmZSDF9ajSQ5sMZNs8LPap489ofcGEoOlnXOhm5A1QD4waEcoMjwOAincm15qr6x11UlV04KuIHIDKf7u1H+SZ7eb4qNO8I7yX/3j8ZVBrhPh99VzGx/bvzn19MYtRoJFZ9eksTozoMG+n52i8n/gx1RKaKQYVL/OVLKrXHca+P+lXEJfiBn0KTIbOuOcMxWpHTU9ZrvLhMM+3a0at0xE9RU8smkRBDfXasx4WPmiJuG4c52TyoJZOxHXALVWz4HVKS5Ti+qc6QuO2vhJBJGXuym3sh/cVy3DYjQWuBoSj5KHm+VHXQgOnzq2vQ9oubV0ILwM=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(107886003)(5660300002)(2906002)(103116003)(4326008)(70586007)(81166007)(70206006)(336012)(47076005)(508600001)(426003)(8936002)(186003)(82310400003)(36906005)(8676002)(26005)(44832011)(86362001)(7126003)(356005)(1076003)(316002)(55016002)(83380400001)(7696005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 12:46:07.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84d8ab0-ba74-45f6-192f-08d99a10e926
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6814
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Scott Breyer <scott.breyer@cornelisnetworks.com>

Changes instances of Intel to Cornelis in identifying strings

Signed-off-by: Scott Breyer <scott.breyer@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/qib/qib_driver.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_driver.c b/drivers/infiniband/hw/qib/qib_driver.c
index 84fc4dc..bf3fa12 100644
--- a/drivers/infiniband/hw/qib/qib_driver.c
+++ b/drivers/infiniband/hw/qib/qib_driver.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (c) 2021 Cornelis Networks. All rights reserved.
  * Copyright (c) 2013 Intel Corporation. All rights reserved.
  * Copyright (c) 2006, 2007, 2008, 2009 QLogic Corporation. All rights reserved.
  * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
@@ -62,8 +63,8 @@
 		 "Attempt pre-IBTA 1.2 DDR speed negotiation");
 
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_AUTHOR("Intel <ibsupport@intel.com>");
-MODULE_DESCRIPTION("Intel IB driver");
+MODULE_AUTHOR("Cornelis <support@cornelisnetworks.com>");
+MODULE_DESCRIPTION("Cornelis IB driver");
 
 /*
  * QIB_PIO_MAXIBHDR is the max IB header size allowed for in our

