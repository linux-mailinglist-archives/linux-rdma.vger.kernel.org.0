Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE63DAADE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 20:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhG2S0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 14:26:49 -0400
Received: from mail-mw2nam12on2098.outbound.protection.outlook.com ([40.107.244.98]:30452
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhG2S0s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 14:26:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqA48ZuIaBmTf9rvN+GXg25tnk5hFeOqfYNqTBshuEn3RxHH9idTctSmy8654R8FTnHrPQCHz6S8g+zTpBn1WJ105Zjmr65SzhyoMxtysCh1hslNchKHCu27vQe8EXG1IRBQkmqmLUfBUqfQNjiuW8QAKKi4wy1vPFvV68EBPwvxl1d58t/YJ5ChQy9LGrGUSuEApnKpVpjFHWTf7NB7EHbcOYt0jWDmaoDbu8k7SQZIoDlu9xxha3z6bu9mvlVwadBMxi+p+SEz2K7QMZINDMoPMaS0XwAOkrLG+MZOz6N70RRkEhsxi7XHA8nUKmtfBO9+1NcpSdCIAgdWkyv48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgc/2/NebGuU6ozQLFVNIzxffsqZjb60vrIQkBBM60Y=;
 b=a6yR/HugICntdYR9zhWXMgogBT2XA0d9rSNFdYJ+9F8cAZyUw2LYWdZLz6Ha1Il+FBsbbc615DxUC2xo4aj2Gmqog6YPbhij/xxZxm+lKdUGm/2WygIXwVa/IENxkIaaEOWbxjyacEqJkB/7XunlSR6DW/ZFbM0fZpGDNA+uzIB5O7iyFBmEawQ1AdxJL1O9p7Qq3l53LM1CM2nELq3ZyukwBu2kbxFgoNNs3dVSl86D0MFPlgs4C+tR5pQTxFX0r1rjLuSy81cl17oiYtNfmQEKRYSAyfWkLQnLVAoCucKFUn+04pkZ90yKqt3bt3rXMEwbtas6pQ8PoM4wlvcj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgc/2/NebGuU6ozQLFVNIzxffsqZjb60vrIQkBBM60Y=;
 b=hyRCWdkNqrnYzuxhZshZ6uaG2IqFFbtNLXJOKOuz6hUTbnPS54NGY0Vw4bRqYE/QcfS76f3gLgSATUvtekUsNv1mmXWTs7o3Q5G1OEMapifhXINBT+xnzQRO8HzGLeyqFhpW+GaLxzu1+mKJpb9xqc9LpjncqOKvDmJ3qqcYj/xV8G5tt+3iiSASWrzGvExsaFQq6oxLw1nPIVbzRNbJbTrMEpe2Nvp/yin4FDk/werUJIzUAhkahsw7fZLj4kMPwexKvWQSLGCxiL7r8xvLWeAG9AOxkDNrsLwUZLU89kYy1h0GiXkq1E59aJwzngiNeK67P72bCXXztSIs2Kg9Ng==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7201.prod.exchangelabs.com (2603:10b6:610:fe::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Thu, 29 Jul 2021 18:26:42 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4373.022; Thu, 29 Jul 2021
 18:26:42 +0000
From:   mike.marciniszyn@cornelisnetworks.com
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>
Subject: [PATCH for-rc] RDMA/cma: Revert INIT-INIT patch
Date:   Thu, 29 Jul 2021 14:26:22 -0400
Message-Id: <1627583182-81330-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:208:a8::45) To CH0PR01MB7153.prod.exchangelabs.com
 (2603:10b6:610:ea::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by MN2PR12CA0032.namprd12.prod.outlook.com (2603:10b6:208:a8::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 18:26:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fba04791-90c9-46f9-b9b6-08d952be69b5
X-MS-TrafficTypeDiagnostic: CH0PR01MB7201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR01MB720106AA4FF53DA2DB1893A9F2EB9@CH0PR01MB7201.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1DzqIfNjNZUvQY2KcQfz7LBaueKUAJFjBlugn4qTdrQslg1r27lbL+jbfIic/cx6d3lGZLfCZ5tBfrd4p0+vuMvVPxmLzyEQeOIYzR7lDqvXN6fiEExlcV3a0AyzJ/fOFHiPc9+/FaOmmF0T8QxcXrTufUSk9qA52MvKiHpCIswjzrUqcv/f4H71iFfohDwefn5/MelZkYwV1bGRfIMi7PoQ+5qm7kByHJmB9BdASDHL5dMDFSGAgPcy+9paSMgkxgAFAMRegcUVo9C1T/zUErn0i9kkCPINznFIEbNTob3rsxBQR//4pAZIl79OarQ6URcK1SrKPk80aQmlFrqSbXOARa7cwgw4XwnzGMBw/bOZqpOYq1PqLNo0peQABAmoPqozxZada4g7zejn1AhGbCqgS5Q5pgfEhgxLhTyUtQzMf/7edQZRMqxsCpBja4tFtcYqvM5rCkLNvrQUb6SP2QBTAh0dtvhOIVjSPExIK3CdAGkFYTuTZWRSdNFrQyZifyWrvHkpGoDNf5raCKwp75c2eqQZEyuNmSN9ygdk7+9YdFPc5LzlTFpgnSgPWd6d1ettVlhIX7k015THPo/XbjKNUQrnODol0xfeOYqFsl6Psvl3Ez+avIdlHurL406jljbBIqv2lwRWwuThjN3ACi6vxlfOxlDni9nB/0g3ZeA0wfABp/lWocCyhPmfleckIn/lm60QXWd/17DuVCMqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(6486002)(66556008)(6666004)(38350700002)(38100700002)(186003)(66476007)(316002)(36756003)(478600001)(26005)(9686003)(54906003)(2906002)(83380400001)(5660300002)(2616005)(956004)(86362001)(52116002)(7696005)(8676002)(4326008)(8936002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8d3+V+GKKt09YGNJTtKLwbRq/Nlpa08mUHuBEuRggtFEpbvSa9k/C4fZPCg?=
 =?us-ascii?Q?G2g11U4dUGU2nXdY08rD9wBV8lAy3C2mbvE9VNU1yTTj4ASdfM9SsMbkea26?=
 =?us-ascii?Q?xssuOQjRX1J3fYjVgSArD3ISwd2K0vbAV4WAZuFYcZMJrwnWoJskqsZgIWoB?=
 =?us-ascii?Q?kgU4I781IDZsfbqG+EBay4lpeEsDdcqLJ5tATBu8T8XfOTdp4mwRSj22GrNe?=
 =?us-ascii?Q?YS8Bqq7S4Siyeba1qXVWgKM1cbTxxe72AULhlgi3qM/zHuVeE43moRw9HJPL?=
 =?us-ascii?Q?CAFjxe8FtTJbC/sDx1vmuBZx6r3L9QwWlq5Am6iT3E+QNZ/p7KPxF8kydHWy?=
 =?us-ascii?Q?DhmnAODjxrvPYytquUKlbYaXTHZxXzM757azWCRFiOFzGhzEl9bECHj8QfOF?=
 =?us-ascii?Q?X3GIgQraTIPqtTMYLtO4SKVXZkixVFM642ssSDumgQ5Gm2Z2UAJcr/6Ryavz?=
 =?us-ascii?Q?jPXd6uN4lFnERIi0pt2oqlzdoZhpoOSueaUaxcKlgcxrFs64Hr5L0Csr3/Aa?=
 =?us-ascii?Q?B134vh+Oc+MEcsf1n4YPvCTYgMKCrdJebUfBbZlk7ffp3RfAijTTacT8lc1c?=
 =?us-ascii?Q?vVjdJg/8ImrLcIXJYq8NTVdqCBi/KXBLZrmd9GbQ8zxEMQrv1sjaJScxPclh?=
 =?us-ascii?Q?pfqxSLY4Q7/C+IP8tNgiP6dpUfpFUBC8ZxcYkk5QbIMdtz+zfpenZEBuRgxc?=
 =?us-ascii?Q?m91ralwXkuuDv8n48BaxCtHT2FIGyYkwn8g4CkdYSWCOmTyl9SjbD687nJyJ?=
 =?us-ascii?Q?9Qp748cz8tFvYV33n1Aj1uNgdZJUB5B06ZgcqS1GSashzy+7RkkjCh/M3GV1?=
 =?us-ascii?Q?NwP9Ej6jaq2mXOri2cOzB20Oe8gKrquVjRrpZRNvaK5WRRWzExjdQ/zeLzzX?=
 =?us-ascii?Q?Qf7vExXXhznUfEARMrgg9Mowywil4NUuOLgTtUoX72mHJ5gMLh5CElztBPlP?=
 =?us-ascii?Q?E+uQ2eUUesTsUPxjc1RVrJLSPKwGS6T8vzQy4U90WQJ6QAuDqEK++p3XGOOd?=
 =?us-ascii?Q?T9FyZEbh1I2UKzFQYO42bTDb4l0bTvhTf2tZ7VsLiefRC5Xi0oTYLVr1/WFj?=
 =?us-ascii?Q?ex6NeSK1nPT+UetAx25SxVQZTL+Mw7rq75f+bj2dfFXi3RcEi39Yqsdx/hRs?=
 =?us-ascii?Q?L0VP+f24jll0HhTjyNMBixzjEiX6PpyDRq8/NJGfdWqY+D7VvtuHqI0EUEwu?=
 =?us-ascii?Q?a10wfffHeA4fOCoyy8H1lKIyv93cGQbr24TlqZfel8TthnjFM59WhMdHXVi/?=
 =?us-ascii?Q?iyG6WkBpsNXsJ+mNRfsAoC24Er1P97PPDczxbdRTHGGKvOLaK7Bdr3fqmKq1?=
 =?us-ascii?Q?YqNLBTYOvKwjwL6bYYKM6iH7?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba04791-90c9-46f9-b9b6-08d952be69b5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 18:26:42.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib/966MJEOvmUzMLkN+bGlk8UTxZZf46h45HmirIZe5kP3B3D9PuuAPtBeyCH9DdPxn0HO4AuD7AuwmVKJbmu95wRI2nPcmEucKk0ooWYe4b1m0TyX/UvKx1XcmFvwBo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7201
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The net/sunrpc/xprtrdma module creates its QP using rdma_create_qp() and
immediately post receives, implicitly assuming the QP is in the INIT
state and thus valid for ib_post_recv().

The patch noted in Fixes: removed the RESET->INIT modifiy from
rdma_create_qp(), breaking NFS rdma for verbs providers that fail the
ib_post_recv() for a bad state.

This situation was proven using kprobes in rvt_post_recv() and
rvt_modify_qp(). The traces showed that the rvt_post_recv() failed before
ANY modify QP and that the current state was RESET.

Fix by reverting the patch below.

Fixes: dc70f7c3ed34 ("RDMA/cma: Remove unnecessary INIT->INIT transition")
Cc: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
---
 drivers/infiniband/core/cma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 515a7e9..5d3b8b8 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -926,12 +926,25 @@ static int cma_init_ud_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
 	return ret;
 }
 
+static int cma_init_conn_qp(struct rdma_id_private *id_priv, struct ib_qp *qp)
+{
+	struct ib_qp_attr qp_attr;
+	int qp_attr_mask, ret;
+
+	qp_attr.qp_state = IB_QPS_INIT;
+	ret = rdma_init_qp_attr(&id_priv->id, &qp_attr, &qp_attr_mask);
+	if (ret)
+		return ret;
+
+	return ib_modify_qp(qp, &qp_attr, qp_attr_mask);
+}
+
 int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 		   struct ib_qp_init_attr *qp_init_attr)
 {
 	struct rdma_id_private *id_priv;
 	struct ib_qp *qp;
-	int ret = 0;
+	int ret;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
 	if (id->device != pd->device) {
@@ -948,6 +961,8 @@ int rdma_create_qp(struct rdma_cm_id *id, struct ib_pd *pd,
 
 	if (id->qp_type == IB_QPT_UD)
 		ret = cma_init_ud_qp(id_priv, qp);
+	else
+		ret = cma_init_conn_qp(id_priv, qp);
 	if (ret)
 		goto out_destroy;
 
-- 
1.8.3.1

