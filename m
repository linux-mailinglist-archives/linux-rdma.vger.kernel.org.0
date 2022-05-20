Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D952F327
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352957AbiETShh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 14:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352946AbiETShf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 14:37:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2096.outbound.protection.outlook.com [40.107.223.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1F1195934
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 11:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPn+8mpA3n6RBrmvf9/xtsolNH45SaEg0gDcUuibuEOy7bGnuW0Ita1w2bfhJdt014tm1gTcGwsZwvwYydA+9WWeq6a7uZHAMtXjiZ+eXIhO4lcnzuhOdBZghVGtNTGMsUfwg8m9LZAeYI+GP6rZzdWkOGIp+o5R+mIL+Sm7xDCVsxy5IbwR3QLOBRpOU1uM5K59tX+EbihE6Ok3umXnY+pMHqYG5HIpL5Yz+SSz4znJ5/PLycktBvwhS0xVl9yuNW3A7Iz0EGLkfzEBy+QZo+70jOBFgg0nA6KYxLIEPFUo6+DIMM0KXPQ0Z+IA+kT522QeI5jKk95O9ayofR2LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35+qFFoJMGLSyuqUYFOf1FhMq8V1FHvskPvODH76Osk=;
 b=TEPPJkR6T/SG2qXj0mfj9W2rZlck29YcrSSPQlrC5ueALIS4MMKPM4Rr0RlUeebrDwANaefexS/gca9ezu7lBFJ3jt3Q9QPSGsPSw6dn0NdVNP0/708MLhXA1OiD0qwXJq1m95K0KWkxnsXiGCnGK91HewiR038eJq+wnASGeiFxwgqwLpHkKA4tqQqIX6NWa4vvthZPWVXxVULWlyi/rvnHwbEGizhXjUUyVwhTaizmPStZMVsNcGBISkCVm0RAOckKMnK3R2cJ2thD2kAkz9nmoy/E+SAq2SYV3dzzZc7E9Ges8Wje6eWiFsPiCk/pz9sDgY87DxfGybBAaQbEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=nvidia.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35+qFFoJMGLSyuqUYFOf1FhMq8V1FHvskPvODH76Osk=;
 b=WwOdBS/J5KZTTv4cAo3pRzPEPMcJO+uZXFiZX6Kyl7TzLP1htnw7eKcVc3+BIOWgD93SM7wiivNgs6Oejkk295EOM6qPWjjCfDqaUl3UinXTvPXt2vNHAXIggO8yrVsqJWUZyDPIDfR0UtO2sNBED5b0XJffWAm2kDOwZJlzL7Ao8NL2wRvUIwQ8phsd5Kn9UacHNBHTB3FuZe4yMdtNoOlEGzutsM4fkIiiXfF6+ci63AUcKlYKeFcioEVp0xQbzIHiztD+Jcoh3IgZdMISsQfhNSr9Ry63jjnsimUilOknxkuQIdvEn2Y+IcWtgRniz3q01vxIta9NOHo1PKy8oA==
Received: from MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33)
 by DM8PR01MB7046.prod.exchangelabs.com (2603:10b6:8:1b::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Fri, 20 May 2022 18:37:29 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ff) by MW4PR03CA0058.outlook.office365.com
 (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Fri, 20 May 2022 18:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com; pr=C
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 18:37:28 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 24KIbRMO056711;
        Fri, 20 May 2022 14:37:27 -0400
Subject: [PATCH for-next 6/6] RDMA/hfi1: Remove all traces of diagpkt support
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     leonro@nvidia.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 20 May 2022 14:37:27 -0400
Message-ID: <20220520183727.48973.93587.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
References: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95671fe-e976-4d52-3d78-08da3a8fcb35
X-MS-TrafficTypeDiagnostic: DM8PR01MB7046:EE_
X-Microsoft-Antispam-PRVS: <DM8PR01MB704611F00AE1600579170395F4D39@DM8PR01MB7046.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Z0HTdb2TvUQxboTjDgr9e1Cu9vUPLTQQg1772uhichq8sSa0YB7W8iwcTzb32bg8CBoG13tQRCTbEyBvkQu58os8hAWAWhCzFN1KiccoiXhV+QyhFZTlXRyWLLMnGDVYUuAj+mFQ7w9GL3r+4MWyrJOdX8qJwG3bu42ZTiP68q86IA4Ws5OHRHuQj0sB/eptR/5aNEqYukCz0zG+ICdgk4eD5ghFjFLBstkvwypjq4ZBjHGgdx8WJAd1LwAuhenjMBJb9w+XnLUnDJf4oqRT+l4vVY9zUB2zU9Ofapf0e+bfB1zXwaeiJ1VhAspb8ZKhuN/Cj8TOElF2DqQ35QSEXaSrybC8RCR97+WjVh7THefZ/micBZ5KsWkRapxhhMgk0ZEsoYNT6az4VX3hQ2YOvg1RJFJT9hbHmSSCdNHZ2M3AysSFo9xtMcphVVQAdlkw4G5d2ry2FSflSjUMuYETS8MScmxnKcsThwPEQt5kJ2F1J/M6YzwJnlMCIL7cLmvSInYcwPFbDyd1AmAoaiVxi1sX19e2d8+lMI5qcrwL+vGNfSdG3MhLniuzPtgaUi7RvhBAzo21S+f7iZrM7Z0JGv5e/Cdwfl6HXZOW5faNcZkxlocmWCgzHiChoYb0KxTFRC5CdzANiWKfuV9Xqh9zCg1LAvJ5K4RIZfEjY+qcydleC4L9y3YlD/cEmtRzuGFS4sCA6JA7dYXoIM8JvWTjw==
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(39840400004)(376002)(396003)(346002)(136003)(46966006)(36840700001)(44832011)(47076005)(5660300002)(70586007)(81166007)(8676002)(356005)(4326008)(8936002)(70206006)(103116003)(82310400005)(26005)(36860700001)(336012)(426003)(86362001)(7696005)(316002)(41300700001)(2906002)(40480700001)(1076003)(83380400001)(7126003)(55016003)(186003)(508600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 18:37:28.8782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95671fe-e976-4d52-3d78-08da3a8fcb35
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

One of the concessions we made to get our driver upstream was to remove the
diagnostic packet support. There is however still some cruft that was left over.
Remove it.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/common.h |   23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/common.h b/drivers/infiniband/hw/hfi1/common.h
index f32f858..166ad6b 100644
--- a/drivers/infiniband/hw/hfi1/common.h
+++ b/drivers/infiniband/hw/hfi1/common.h
@@ -138,29 +138,6 @@
 			     HFI1_USER_SWMINOR)
 
 /*
- * Diagnostics can send a packet by writing the following
- * struct to the diag packet special file.
- *
- * This allows a custom PBC qword, so that special modes and deliberate
- * changes to CRCs can be used.
- */
-#define _DIAG_PKT_VERS 1
-struct diag_pkt {
-	__u16 version;		/* structure version */
-	__u16 unit;		/* which device */
-	__u16 sw_index;		/* send sw index to use */
-	__u16 len;		/* data length, in bytes */
-	__u16 port;		/* port number */
-	__u16 unused;
-	__u32 flags;		/* call flags */
-	__u64 data;		/* user data pointer */
-	__u64 pbc;		/* PBC for the packet */
-};
-
-/* diag_pkt flags */
-#define F_DIAGPKT_WAIT 0x1	/* wait until packet is sent */
-
-/*
  * The next set of defines are for packet headers, and chip register
  * and memory bits that are visible to and/or used by user-mode software.
  */

