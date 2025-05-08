Return-Path: <linux-rdma+bounces-10134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877D3AAF251
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF301885CBA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F952163A0;
	Thu,  8 May 2025 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LGYrusOU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9DD215F41;
	Thu,  8 May 2025 05:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680458; cv=fail; b=urU+sJMoZyjNPnALTwjwWiGfXvAQ7mwjNl3HNslzOP1ehcgRQA6CRc7lbychiAsJRbGXge90w8EupVpDCrCAj/A3rLXDuLElnD0uQ4Z2eEa82eE9YkX1YJhXi0kUlFE6ak9scuyfFveloEyupDl8fIS/AlKKCfNXTa2N6wPRQfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680458; c=relaxed/simple;
	bh=YTWiCEPF+O295MyEgiyq8upE3zAAp7KmnaFkZkPt28w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzWQtzax3Ch2iWOkCMwuC0UBnTfPKCKEkRjop+La+1pXcd1O7LuQXo6Jf+vcCRnookuagExttwiIYXdxWBAfpXgA3fyB9Jr5mcraAVui93qid72fEIEKJvBczZ6ucTjmPfeobQG9uvhKFO0isYlaGEUbgEcgiRYImQtHHk2epRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LGYrusOU; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPRWQnsqfRPsXJKrw5aRqz7vcPARMVjVdfI1nYg1AjQgzg8Dad/kt25q8ChavUWit23Mx0Lffj8luckTJY4SqtM9yr747bO1/J2SsHRFHXMoRPw/4ybRu+bp+4XPJqPKht/C2lid6td24oXKA8MoPwxYzxtyW+oyK4CA+65B8CVyjrkfpa3u1o9Xa7qB49GzOsfkeX8oe2anlFIPgZcFXJyWm0NPWmt4dP+wJIJNZulpoKNajho+BqpIaQdPh45d2rIAOsLTDKNRJ4G/ZzRbljrWCk2jvgF5fl3yEFyNEkZIuztUbA2PaWcfDr9yYdWhV3NsVPHBxfiXliwktNpykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x/w07Ukgfegt7uUaI11b4U7dY/CodK+sMeDR7Fw61I=;
 b=a5pXgJnL90Z+ToRG0IwiYCof7tO9r1vU0CDYPJjUBLuI913EejDcfm4Paztcq9U7bqdhpoYSOVOVQlaCtYL1wksqk4SgRwJj/8WqG25/F5C5O9N2WfQTa2KDzOW89rWB3IJebzUmbZ4kg5iQWnhqunh6BPDCSGU5K2G56QJJkgoN/V81DelNx6aOMz1IdMH8FuWY3m12yVpjOE4w8/NTi21vcKowNmGPVKyE6jWTvKSL2ng47F5FAKGZnVwm5U6AERlKSpwUfggW98zylBr4MO0JCBBghfN94YE8pIPzeUKfZ214hjBPcl/Xae8Dp264F9TrOBeJqySm/Wc+soixSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x/w07Ukgfegt7uUaI11b4U7dY/CodK+sMeDR7Fw61I=;
 b=LGYrusOUuJkcBalkFjyurweHH141O4W8rwfm+gbpf9WDaW9WjdRQ9xWic1tDaBJvIXpxP0eV7bNxkgMwRRtJGPkueQmZMfWb6pmxxA2cSiLmQV7gk7r6+AXj800zOQaEKSbWetMxV8Yst4s2cRg2USjEqpomUO5bnmgeBs44l6g=
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 05:00:52 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::54) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 05:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:00:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:00:51 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:47 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 04/14] net: ionic: Provide RDMA reset support for the RDMA driver
Date: Thu, 8 May 2025 10:29:47 +0530
Message-ID: <20250508045957.2823318-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: a7502cb1-049c-40b3-5d73-08dd8ded4e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0+cNmhRhqBHlbu6BzYX2JjS3LB2oR7xevhxFX9uHvFPcmtUvqzKpauCvpbi?=
 =?us-ascii?Q?sVP184rjzZuZ4Izk+6n6MHRyWHDUtnSjsT4rTSx43Mo7i3jKE/lIUAWuKW+N?=
 =?us-ascii?Q?E07wZLJLJ2JWKfoX71cSnuyUm1M1kFhjKwVZ7etDI19KrRTn0zzs47Er1kcq?=
 =?us-ascii?Q?Fi4alKTPfXDKZ1BN9rTn6UTbbU17oDpPJkx2unIshUhmi3L1Q9e6Vc5mbxgf?=
 =?us-ascii?Q?YdAkSaIUzwjE2GnaJ8BHcC5U8tpgEebkwhN3TlUxoYeswwMadtaGjryKo8hD?=
 =?us-ascii?Q?xITw2WKtkUsWJq0RvA8ZhSEAc2V4MmbWEpFX6dO1rlvMPwITflZtnSCqV2L1?=
 =?us-ascii?Q?fPqhaPDWslZqQoisejmJNSEpSCApZ78u6nmPkdt0XjyOX9oO6v2NRrS4hOc2?=
 =?us-ascii?Q?5BYgBWXeMSmNNhCIyN7nY9sa30XxsYW0LKIGrDONxvFV3rZdq8bINowd0mXE?=
 =?us-ascii?Q?ABslHSLraijfhhgEZn/otCTrDp64qZ28RV/NF7glzTFLWR+rtPi+sBMjhOje?=
 =?us-ascii?Q?wzgPEQy2jZnRUpPySj1uNU8V+QsNA50u+hFNBb+6JVmibu2oJ7QEt/jy22Xv?=
 =?us-ascii?Q?xFTeGtj1ZtWRT8hsdDfx2vgtVSVXU9ehfsI561QQ7WFvG0EcZLLOodD75tn0?=
 =?us-ascii?Q?2lTZbODXX9l/DmzO3+7J1AOuR5bHqA2S7BAuLBeL50P8QDJUvaSdDde0mIA9?=
 =?us-ascii?Q?qiN4tPTKQlK/UhM3OY3CLgjVPGX/pUaa1m53lekXz/jzVRM1qKppNhVV2pcZ?=
 =?us-ascii?Q?Nlkao6sD8TdgaHKRafP9bMKYgGQrkchKLE6zVk9RdETCVUfYeRUz9nCzGWa7?=
 =?us-ascii?Q?mUqZygFcmWSx/dwy+gEaG79XBWmZdHAICY8nDmkYbC4tS97yvu768bBLJ2qs?=
 =?us-ascii?Q?P7pY1vLeBqMjDJmpRqKKRje3PONTimOF9iNB5AP8zfJS+gUMVMtLxy1a7n+h?=
 =?us-ascii?Q?17aPMKIUiw/kyiCRr7VRJC0cm0kOUcHEY5qlVruqAst/ugsTtMiwtGw0ZZno?=
 =?us-ascii?Q?9iQ3DL2rSEKEmcu0wwDp5l4RVxkqaH0KwolT2pCfDpkboLoIvl47argVIOCK?=
 =?us-ascii?Q?IUTNokRsqgRXWICYd34t9ZRDdvs90WvvWtm5UMWhyhTEkFnN/Wi8K/Pd+Hql?=
 =?us-ascii?Q?erh9AP39UwSUrv1ckDicsoFel4g/GLEBVMTfv7BPllM1J8vjX95cBhdJb8Pq?=
 =?us-ascii?Q?gNytl8NWio9zPMUismHbb96KC/8vGR1i/W0MM2RAbB5qjjU5qexPqzdUl3CR?=
 =?us-ascii?Q?Elt+Eny2lBFsbTF9NwMPfKPr9/lVU99Xy2g62SNZtP2aUD0gaXWpr7vP6/at?=
 =?us-ascii?Q?Fakp98THFr68Uf8GfEggHQbAKCXDaro3ZBIcgkU5MKfXL/Py6ttBzG+Ntzgk?=
 =?us-ascii?Q?7rvQ1wSFDJTdfh37rmYCJurcaD3yENXzWr0wAaV208ckR0LFub8TS9+QaEaM?=
 =?us-ascii?Q?LZqOXjpTY8sjzn7lTDatyDs16yky4fg/olhBsp9xDY+4yZjMjz3NORSU3Sua?=
 =?us-ascii?Q?HcGoUrQEcLCBVyoJJBfDxA3RNPBm7/xtVFTfzDHoB1hzG5uJMFgWDuDdIg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:00:51.6672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7502cb1-049c-40b3-5d73-08dd8ded4e50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

The Ethernet driver holds the privilege to execute the device commands.
Export the function to execute RDMA reset command for use by RDMA driver.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_api.h   |  9 ++++++++
 .../net/ethernet/pensando/ionic/ionic_aux.c   | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index d75902ca34af..e0b766d1769f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -54,4 +54,13 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
  */
 int ionic_error_to_errno(enum ionic_status_code code);
 
+/**
+ * ionic_request_rdma_reset - request reset or disable the device or lif
+ * @lif:        Logical interface
+ *
+ * The reset is triggered asynchronously. It will wait until reset request
+ * completes or times out.
+ */
+void ionic_request_rdma_reset(struct ionic_lif *lif);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index ba29c456de00..bbad848d2dce 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -93,3 +93,25 @@ void ionic_auxbus_unregister(struct ionic_lif *lif)
 out:
 	mutex_unlock(&lif->adev_lock);
 }
+
+void ionic_request_rdma_reset(struct ionic_lif *lif)
+{
+	struct ionic *ionic = lif->ionic;
+	int err;
+
+	union ionic_dev_cmd cmd = {
+		.cmd.opcode = IONIC_CMD_RDMA_RESET_LIF,
+		.cmd.lif_index = cpu_to_le16(lif->index),
+	};
+
+	mutex_lock(&ionic->dev_cmd_lock);
+
+	ionic_dev_cmd_go(&ionic->idev, &cmd);
+	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+
+	mutex_unlock(&ionic->dev_cmd_lock);
+
+	if (err)
+		pr_warn("%s request_reset: error %d\n", __func__, err);
+}
+EXPORT_SYMBOL_NS(ionic_request_rdma_reset, "NET_IONIC");
-- 
2.34.1


