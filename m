Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004ED4EB37C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Mar 2022 20:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiC2SoK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Mar 2022 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbiC2SoK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Mar 2022 14:44:10 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2094.outbound.protection.outlook.com [40.107.92.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839EDB7170
        for <linux-rdma@vger.kernel.org>; Tue, 29 Mar 2022 11:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZWJPArTHMJtSGmIyYuXHm+h5COiGJnu49k/Cb9k9nnjhqxU5YyGc1neDKZxKIgLeKNcWbu1tevAlYbQZYyxKUPmzXLswP1wKaqrCOIuDXhguozCROgN/l8POWTynr4ov9b2g6m6z2Ma/je6HJWkAdAN3ApVTt0du0enjPDgXQ4ca4zbMvCWXfmk/n4vPxofwyieGoxLUEYfvSihvSl1jfrJrAfPpOsXB1YyNKPVn46khwfmHCz3zN4D70EuEqhdEkuxDbqp9A6xUVZoj+B3zy5MOoM7XlAm8Q+4rj8661AO/Ppx846sjTpMwuDczA2Iiqdp96641aNbx/CFGt4NLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT9mnS2Xg4OJj1OMmAs0947qpW+hfV1N4WL7N3JXzag=;
 b=SkFmqAO8SWv52VKc9ep7pr7r0vFYtOcVpnuEWkJ4lbpb20s7FQKWZgvzqqmK3IChqlVB5/E2z0tcETtT7cUuUKQQcF0CaTwsuzMDCWJAMKWXd7EO+4Fy8gxqYnOkEIVFjpJ0SSeUjKvb45hD1J4uDdsWeCYnqgBHUIEty0jPAmq1S6uFzXSRxmLoFymZsq4NgY9RMkRZsE7m2/D3+gkmYJ/MhT+z1gvk86X0sQOtsZyOpT7qnsxsbqlftyYWXR5ydXUMrmqJSG6VvuAAFXnCTx0ZzqFHN3CMwGnMdDFZPdVWno4/BjwCSILxve8JA4TmyTZkfez52FLJUF0n6j5uhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT9mnS2Xg4OJj1OMmAs0947qpW+hfV1N4WL7N3JXzag=;
 b=P1dO2jwewCTdnSqwNPdoOkvZQmcbdKVIX4hujVPLSU8uDXVGgQw3IuX8p+G7Jqn1pZ6JrZozsTNxbSoYfEW+j4r9FzbAjWpiFStPmQo1VMFKNsHnYdgtepq5v2mWyEegaw3oNqFhqxaZ71wEI7cpHbGw2wmj72WKoZvWPI3iNyZLvEKh+MLY0pTQ04W5OLwqk+K6eIJ6P3RxVNKcoW1hxTkQuhcK5gudUQVAkAXd/akqhtKYuJzgBlDHcJYlVkQ2rs5XyiB2VADEzNemLT436Ljp0/izsDhkxnprbbVZs5hVHeTSIZgkFeFO6Ve51v3CpMVpZjmUnc2kPhONQEZAEw==
Received: from DM6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:5:1b3::42)
 by SA0PR01MB6315.prod.exchangelabs.com (2603:10b6:806:e3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Tue, 29 Mar 2022 18:42:24 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::9f) by DM6PR17CA0029.outlook.office365.com
 (2603:10b6:5:1b3::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23 via Frontend
 Transport; Tue, 29 Mar 2022 18:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.19 via Frontend Transport; Tue, 29 Mar 2022 18:42:22 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 22TIgLKc182095;
        Tue, 29 Mar 2022 14:42:21 -0400
Subject: [PATCH for-next] MAINTAINERS: Update qib and hfi1 related drivers
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 29 Mar 2022 14:42:21 -0400
Message-ID: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 906948ae-3a67-48df-5d38-08da11b3dcff
X-MS-TrafficTypeDiagnostic: SA0PR01MB6315:EE_
X-Microsoft-Antispam-PRVS: <SA0PR01MB63151D750631E8CA7BAA11CAF41E9@SA0PR01MB6315.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RI45uXEDgaB3aOh+84rbNMbtXNfw9p7RRMgTFIQQstgd37sxO5xX7i3Q8ssseCIwb9RjxDQIXpotqV91iR0DzpwAl2UDbsFDKNNYewvrkPPiCrFwZIh+JhTrep5ian4qL4GY/JFAQaA8d4dNggGKjjlTZxy3mXhr0xFC2Gv1iQTf9u38l6OoogyBQDEowWa/h/56OfEgTzA+JN5omvEATlT1cA75FJgddP2MRs6VVmw6rdJ445FWTjZDqiuW5vrRDKKRfcGh07ZBBAKt73CYXlqpspR9/f4BkSW6ekQvbtqyywp9lCfLKp/V3xkZO+md1HRBYoH1GwUKgtS9aQNN6YvH1y4Qy4xL2z2v6GJ9ZEZHDSZnJ8P2Az8S0URn6tyxceg89Yjl4BCc9R2BMlBsb1qq8PP6Rkm8anujHFpS1XbKOFZfMC5ep8GoxH6gZJYv+WyBBof+Rehfmsuo4SRCJIILy64h4I60Qm+usIiO61j9xM3Hqd/ongVpgtBIOpvnb2o6pthYwXzZzRvQfKCtgJmWuUd2SC1iXveNnL7HqA44+ObA8yGLrvSQV9Qv+4DCsHAg6lrZkZmET5De2cODxOdvh7YgbjCSOPDAGEAUVMSHCJva0hnT5n8yk4GpBwa4NgfUUzaC/g8lqsc/HeZ5i/Pd10/8K0laRR23LT3IwrHnS3KSyQxq75og9nIX+n9brOFP3H3EJPf/ixyjzoWmRA==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(376002)(396003)(136003)(346002)(46966006)(36840700001)(1076003)(356005)(316002)(36860700001)(47076005)(8676002)(55016003)(4326008)(70586007)(81166007)(70206006)(82310400004)(7696005)(103116003)(336012)(5660300002)(426003)(2906002)(40480700001)(7126003)(44832011)(83380400001)(186003)(508600001)(26005)(86362001)(8936002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 18:42:22.9950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906948ae-3a67-48df-5d38-08da11b3dcff
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove Mike's contact from maintainers file.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 MAINTAINERS |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9..9dc04be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8506,7 +8506,6 @@ F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
 HFI1 DRIVER
-M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
@@ -14358,7 +14357,6 @@ F:	drivers/char/hw_random/optee-rng.c
 
 OPA-VNIC DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
-M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/ulp/opa_vnic
@@ -15756,7 +15754,6 @@ F:	include/uapi/linux/qemu_fw_cfg.h
 
 QIB DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
-M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/qib/
@@ -16271,7 +16268,6 @@ F:	drivers/net/ethernet/rdc/r6040.c
 
 RDMAVT - RDMA verbs software
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
-M:	Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/sw/rdmavt

