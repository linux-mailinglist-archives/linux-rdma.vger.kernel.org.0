Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3A5FFE79
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Oct 2022 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiJPJin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Oct 2022 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJPJim (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Oct 2022 05:38:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034043DBD8
        for <linux-rdma@vger.kernel.org>; Sun, 16 Oct 2022 02:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpV/KkFsyrWqwuif5IkeBSokcfXZjGSXKmWusKwEg0GRiKLVaAKBGjdoYF6QPvqc11zJV7Zot2f3ltarhFTkl0y/52g2Yt+NbPm6OToa1sihZTWcxASohuyb25ly9x+Tp+jLzFPdSeQExqE8iwUm+NZTva6dfRTA1vJm33L/78rrq9VMB3gENn+ky5MPoWOYvC75s+BfTvuNH/Fp4ukb46eBEGjBd0yxrvUroG5NayYy1Gbgxr0r1Pma24mqT3PG2Agv5FeBn9Tv84FY/51ZQKLzSnwJzIWdmMP69ZVP+b9t4zAudbE7jci7hubHdY2HmdJqvV69xiF+x2weFj7jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+/JEkJNoF0CIyvyUAtwKuBOGNJJurroINFWT/JSmyg=;
 b=YsiGRC6YHbr4W3P+OSiKq4DeBGZFM1kv9J/ln6VCJzEtXSMGWQA9glSIUTAnLWnAAlpAUixGMprexqI3BwpaZO3d5+D8e3/LJiZgUiVH3eHEm/Gp52kSSN1zT3wRrGqwpgU7QkhO7G+dFiam6UmO7b3e1GxmglMkm6sw4Hduh3S3RZnb351yejnIXTKLi5Nqid/OCdXNt8LTQguByiFbTrKEtqfZ6ZdW6GemI2jmvJXOasfWWPQgx/MlTYO4a2QnHX4piHPRwjUBw1Q3UHunHYBMjCFGBqpht/NgLrBDoi6FxENgSEH/1ZiDXqDEMVhJQNI8G298jcK4HGOd9dhKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+/JEkJNoF0CIyvyUAtwKuBOGNJJurroINFWT/JSmyg=;
 b=FE9H268dIBek2Fo2VjXtPolqa5fCZxeEyMSc45YFMng9ode7vuHdUqZi1wVXuVQKxM+EBxqySo2HTHpK+r/wHOPUpDz1CmbmMUQnWaGwYe7MsjhmkQ2+1hGuCCq7304Io+S83v53lg0JN8NeQ+ukg4gC8EfvCWin1tP6ddgldl50Rb0mcd/igFYFNWuLBR6btn0f9LRZ/quzPkU533EF93SH9hfA2HfoFp8dHGHkp6raxdSruyT86l9QaxEFRx8QvLkli6T6txh4No4NzRqCCPFlRh34L9TQY4rUu9r9JcG0sER5BW8DNAZxqQoL5yhpFE8JJlGh/khPahs1K2oDcg==
Received: from MW3PR06CA0030.namprd06.prod.outlook.com (2603:10b6:303:2a::35)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sun, 16 Oct
 2022 09:38:39 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::67) by MW3PR06CA0030.outlook.office365.com
 (2603:10b6:303:2a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Sun, 16 Oct 2022 09:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Sun, 16 Oct 2022 09:38:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sun, 16 Oct
 2022 02:38:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Sun, 16 Oct 2022 02:38:37 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Sun, 16 Oct 2022 02:38:36 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <sergeygo@nvidia.com>, <leonro@nvidia.com>
Subject: [PATCH 1/3] IB/iser: open code iser_conn_state_comp_exch
Date:   Sun, 16 Oct 2022 12:38:31 +0300
Message-ID: <20221016093833.12537-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20221016093833.12537-1-mgurtovoy@nvidia.com>
References: <20221016093833.12537-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT007:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: a757b377-8f00-49b2-6189-08daaf5a3462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/juDeOAZUb+inO0JpqHjaFVsgaP9V9lWwHHZz8IkrKWRBw+M8gYtKQCIihpBazUPTts3ZoLsqAQ4Pk7abgtw9H5U5WasD+wBeXCoVtklbkZ9izKQZcrTTNxX9M+ArvVb3wFh/WBO9Wr8paiYZB9cx3+pLkxqTNmey088KG2/nfTLU/h+yw5qgME6Vb2qKOMy+NUxpN2E0BICyzNWS0rBkktMoZ9rtyBeX20k6Zwgf2wERCn/K4CGECRxLJhIxhiijnu31Gwt1wfRw33t5tf30Nbqz8BLRuQ9RRJDEH06IG/axFuStfmQV59jjJYpX8wb6eFyEWzC0TmVHT5MDI7v+EbIn+09vtru77r/eYN0kDBUEExZbk527sfZaudsk5SNYGITqHJJkvRrhe27SmzQBHPgesTCoJz+P8nftjz8inoUX12lIxVBOtcPhtDmD8peN+alSH/0NGmsJfyaOBaYqUDisBuQ+lbqFqy9qCXItX7zJ4sSlIca/9ufoi3+pipmOGmkxJTvWjqguRaoybNGN0i3e64rsf7W6COW+6jElQ2kmxuOo1h5Tm+TymT2M+3X3OYusE3FYLujwZjVOb3lrQsOBv+fLk7aD1h3XMaHbeiGvbZiCJwJXLrTA48VEaByXtHUgT2Iu6MlCQNDgqUtgDoO/iA04HCcjJikQopN/N3P4T4bjVi4ZcNxyZbpCepIyTPc9VBn1ZlfUTea978UKJWlHcT7l2CFLCo6ddeXoF+QUc1PRAc/GGllIkVm8KWudDAsTved83kvlE5JFcNgw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(36840700001)(40470700004)(70586007)(70206006)(41300700001)(8676002)(40480700001)(316002)(36860700001)(110136005)(54906003)(4326008)(2906002)(36756003)(5660300002)(8936002)(478600001)(40460700003)(336012)(1076003)(186003)(2616005)(26005)(6666004)(107886003)(7636003)(356005)(47076005)(426003)(86362001)(83380400001)(82740400003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2022 09:38:38.6189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a757b377-8f00-49b2-6189-08daaf5a3462
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Sergey Gorenko <sergeygo@nvidia.com>

There is a single caller to iser_conn_state_comp_exch. Open code its
logic and remove it.

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Sergey Gorenko <sergeygo@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_verbs.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index a00ca117303a..a73c30230ff9 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -347,22 +347,6 @@ static void iser_device_try_release(struct iser_device *device)
 	mutex_unlock(&ig.device_list_mutex);
 }
 
-/*
- * Called with state mutex held
- */
-static int iser_conn_state_comp_exch(struct iser_conn *iser_conn,
-				     enum iser_conn_state comp,
-				     enum iser_conn_state exch)
-{
-	int ret;
-
-	ret = (iser_conn->state == comp);
-	if (ret)
-		iser_conn->state = exch;
-
-	return ret;
-}
-
 void iser_release_work(struct work_struct *work)
 {
 	struct iser_conn *iser_conn;
@@ -465,10 +449,10 @@ int iser_conn_terminate(struct iser_conn *iser_conn)
 	int err = 0;
 
 	/* terminate the iser conn only if the conn state is UP */
-	if (!iser_conn_state_comp_exch(iser_conn, ISER_CONN_UP,
-				       ISER_CONN_TERMINATING))
+	if (iser_conn->state != ISER_CONN_UP)
 		return 0;
 
+	iser_conn->state = ISER_CONN_TERMINATING;
 	iser_info("iser_conn %p state %d\n", iser_conn, iser_conn->state);
 
 	/* suspend queuing of new iscsi commands */
-- 
2.18.1

