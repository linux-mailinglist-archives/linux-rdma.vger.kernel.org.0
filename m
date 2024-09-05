Return-Path: <linux-rdma+bounces-4767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E12596D371
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C7C1C25A9A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C51946A8;
	Thu,  5 Sep 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EietAosk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23A2107;
	Thu,  5 Sep 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528922; cv=fail; b=Wz4y8xuo40b0ge+23oQoTgIj++IoNkQBHHrFtkrYpyn8VCYHdlEF1s6yfPWivw9bdIGUO7O7JFC31904J/8ijDS0fu89RQGBrd3hQecfJngXleZcvWA4kLtBKmd7qko4pC/Uxs+YnB8MTG4W2YJzborm48nH3lI3PipUNdQNDM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528922; c=relaxed/simple;
	bh=IS/ETyEJbo/8r9V2zooQpiTi399AiPSBmH+TOf+q0uE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MgIyCDurglzj2kIe+U+rqGIxQCeDUy6lQoU3Zn2TQ3I6ls7vw72hxULZQO9KGpL+YuQzYaC0O1g1tRFlVRumWbXaaFMHJJlEyJIde7qt212v5Qhsgd0Q6aZQati7G2fubUVPTB+gIOznM47lbn5yJPXpgRgYYYb0L9l4+zkQzgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EietAosk; arc=fail smtp.client-ip=40.107.215.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7SbvfVnjtPnIUI2pKY3E1+AEh1O8vzbSzSaevtZ8fWWi5CkoA5ympgzO8BftP5JuOFO4mmbVjZW5RLQWTOmitBkU+ytTx9T1A7he7SwJGx1heltngiRSUd9Y7ncG7M4NJOJrVrIERhv1Lkp3szevV7vH+Zan78BRiA7N2X+wCM8Gbt9MQer61kg57kw1YiWITHfj5Jr6sF4j5eskniEgfvTXiKzxnpleeKBlwBVNNBuDlhnPLDU6XGLpKuch/NwN3rRC3ClwF+LemVeQd984vZ2wQ6fgGN0lAEWzQsSHMMqFwNWnbXbhpDplhubsZs07pBuXDRM/PGq3YYcKx7czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUkvNJRmwSQABI5hx1gopWjXA80XLi69Mg8WzsFAnq4=;
 b=TVIruz6bpWJjqMcTbFgb5oriciRPA7l5vW+RYH1nmKS2LFxoTtK7NTVu9LTYFOcLqFL7ZX0zXSQ0v7ys0hcKVMVlp7/pYNaKDZD0guAjuA6uKH34KcM45ahMS6uQlcOAQsOXPYynR323OpXjnCCxAFdR7md3bXLTzA2U9HcwdF9aK9qXS/zHOiwugwUSJCZXHw6Q7IZNRUkRM7OHF54HPoxw8EnS8xLD7MA63lfEYRUC2jYTEyDFMqmj5db7M9dxret7gFdoQGDs0ppyeAIeDGmCATjParBMZVa08R1RZM2NYVytV7/baMk+3bpZGDgU6UDswU3adQJxu7mfAkM4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUkvNJRmwSQABI5hx1gopWjXA80XLi69Mg8WzsFAnq4=;
 b=EietAoskPP6iG2bpXp0ntZQUA59LiCe8UaLIY2G58CK5AZ37sCfql7nmpgLch2P0uy4jzmHh2X/d5eScBO8QVbKofwIjGrxAfWLG/+wdGhDsCgROeXmqy9+K4sU2UpxX3xQuChPkIfDZmjB48vCvRTF0SAJKijThhv/STb436Bg0w2x3cpE+nKGkyUIcB+lXFwPBvwnDh7RduP41y4WNs0tcwNCw9e7AAQLLod1RTHz9HQExc/kMzZ5A/1rvyF7i0uUBmbLQnaKSu75SmLvHnttf707XnODDTeHaZQXbvjEiaFaDlsFyNkvKN77XUlk3ViQNW0Sd9LTvfiNsqRQteg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYSPR06MB7308.apcprd06.prod.outlook.com (2603:1096:405:9d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 09:35:16 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:35:16 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Erick Archer <erick.archer@gmx.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 rdma-next] RDMA/core: Use ERR_CAST to return an error-valued pointer
Date: Thu,  5 Sep 2024 17:34:40 +0800
Message-Id: <20240905093445.1186581-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0189.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::15) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYSPR06MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: cf61721b-316e-41f3-1a4b-08dccd8e0c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vZCHkujqGd3FhS8fw5XbkUYG5cmV2g07+b0dKDHihXwdyriF6E6xzxNW9XjY?=
 =?us-ascii?Q?DaBkb2Qvwjgo3KFGOHnjKUebn7BmwPlyemBNGFjLCn/m66U6u8ZW+mf1vlSX?=
 =?us-ascii?Q?CPLAX4n0jaWuWmgnCquo7L6gYh2bFhIPUYlFeOKsc47xctWJscV90ZBBfnLI?=
 =?us-ascii?Q?4r/nmfNTh8NpijDmicHJiv2AKP94wPOP8rUUBgjL2XhOiZXSSA1yDFJkyOtf?=
 =?us-ascii?Q?J5mWQgfB8wTeX3u34PwxgBgEsUWyIPoM9c5Yxr821YAiKmdTIdvFUJ5VBB5M?=
 =?us-ascii?Q?onZBt7Vjt2/YXSuSjQi0hCCdOwpsKkfOwg1E6KnYGupIcUC5N0K7Kt1tOBFe?=
 =?us-ascii?Q?JNl2iDk/ASsLQ2HBQpUCv2AmnSbyrdYts+tWlegR4GeXK2+Wb2JMJ6TDJZsF?=
 =?us-ascii?Q?kkduhSiNHvEX8jcPxTcdlV8Bsp7BT/wO2YTElgPtmuoc/r0+pDUBIbsv2Xjf?=
 =?us-ascii?Q?9h2uqBfawmGp9HCvK49xYxnNAqFoDu8IEXcCghbXfISNP+OMZ4N1yo/3Gvtw?=
 =?us-ascii?Q?UG+U4fpLHS3fPnio9Lw6egM8tM8z4SULhpyhEF8p9Yzf+tLJrivoII+dmwFG?=
 =?us-ascii?Q?7ZrmFyfoPjfaGE/gdHZgffv/hL+pGWCatS50sSv12QyIfJwBKMuTV9rot4CQ?=
 =?us-ascii?Q?Z5l8NVqUEBQ9yii4/n68yM3RoyBh75FrgupBnRr4M7dcIxO3EM4iSqSU0fAQ?=
 =?us-ascii?Q?IMANGH+pW2CUiR8yaqUntir6g5dPLTY4dvgbXB5/Ru96txvdaEDuYHv+dK+V?=
 =?us-ascii?Q?7M6sD07YHzrbgLqsC2NNuQWjq56i6VvQG1WH3BkABe2PkAN76Cbtl2ryI2jk?=
 =?us-ascii?Q?uwvbVX5URyNoOKXQXHs5PNogKt1oqQ4tyYRfcvwc4sfyFUBEp+FVswJC9h64?=
 =?us-ascii?Q?kxpTsCYJhhayN/f2pRARQbevQ580+Z1kdd8yip6SEsqdRFJmnb9D/yoGasaO?=
 =?us-ascii?Q?piTEqg1Gq5WBK2tERSi23O782JxAy8K9fR0KYjFynojuyc7ucaSKIoSDPCCk?=
 =?us-ascii?Q?RXYpxpVdmgXtjrPOKuHdQZqKwyyc+TAzg6DVwLP0Oq9+AYZKuJGpRvfOynGk?=
 =?us-ascii?Q?WQ/pWnbBsiTerC1deXbN8gp8Y6gU8uvmiQViK3oqEG3CWci3warQ5zexSwnU?=
 =?us-ascii?Q?lga3+xsjBuUtLYV4tVyqcye6vgByucF7ypynTilgpgx80olTG2It1eXzabIR?=
 =?us-ascii?Q?/m2nvqDSsBV0+xPysOrRNs/Qi1j6kems8l8TrpqEwLlZ6gLa/Mrtdb0LcCha?=
 =?us-ascii?Q?s8kTS0oCllBv+o7YmgbnQPRvHX143UPCuGhyrmUo0SaNgRPOP4IWEK5xnsNY?=
 =?us-ascii?Q?7g9Mu9dZNxwNAdyl45wULzKPuD/RsqleB5x9q/kAJ+fAXbVPwgmQS5iy+ebs?=
 =?us-ascii?Q?e0FDLU2tjLCTl/4THob/xfAqrVTSu8S21qhbbTIGoVIM5oXKVF11UW+zku8Y?=
 =?us-ascii?Q?04xtj4skLbg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/sbqViNmOVjo91iILV+GI5dF2wajUSjgJQaR7ZOTlzDUOBwXJYBLBOEVFRy/?=
 =?us-ascii?Q?GQevkWpPYdlxKH0fWRAGdTLoaWCOf1igAK3+s2EpOxPVupBapxicvAaKf17g?=
 =?us-ascii?Q?VgcDd8+WGsnpq3d85tfyQR422qlFlNE58YmFq8E2TxnPAuW7HDVfurv8FI4n?=
 =?us-ascii?Q?wXTFp352KuLWjg6ccmKeLpeQQMOaYyACpPpt9viFdlCncpI13/oitLY1m/1A?=
 =?us-ascii?Q?EnND7gSXo7z+YwQyo8PxrXoQM9d59ZAj4SkoKcnCpx7wF0dt29HfNPT1Nlsz?=
 =?us-ascii?Q?4Ua6Snt3PTkkWNbcBwvA/DRy9oG18pwSh78/STuSlP/RC/9bzIFPHCFuiQu7?=
 =?us-ascii?Q?OtAS6T6SvpQlGWvRfP1swsaLp1JfvFcoGCRaGLgpciHR9xiPaQyK3WRDn8+x?=
 =?us-ascii?Q?/nD5cViLTfQx7ZbPlcvjm0l2yoDwQEZ1ZCVY5muYLCBcgxx4GR8l16flLTUT?=
 =?us-ascii?Q?X5ObdW4I4oX3PxxFrss09QIUwqLQhWWct5kZR0u3JjMXBUDUkOho9faKT2ZF?=
 =?us-ascii?Q?z0XgGYb9/BDEQw1jF5f3MhYgeg+ZjyJd8+JVNp3f02e/E5FdvgFEVzAgTDmK?=
 =?us-ascii?Q?UdZZieywfjNitHesrkhSyMcebsvLs0OcWceLuWtGSm7SnmZFUWQR8cWq1uwj?=
 =?us-ascii?Q?42dDg4t7yy+jId0dCOaX+wXgmT3cEgEuPBmP+lBgpEbl2pypoG/WgaOXA64o?=
 =?us-ascii?Q?2Rrr5WagK5sEogMoRSB0UBOp8XvmcJH9tlg3csYHaKYX3TMXE5dgfvDhF0o8?=
 =?us-ascii?Q?NjIyiPUrmiTrCWkb5d8Try+aHbP4/ygIpeMbS6v6ghrUQ5MtjKNe5EIiOJZg?=
 =?us-ascii?Q?IJvWBTej6eNQ1eYkNFOrMlTiggESt40ix5Creo5cQpU6YeQd15LQKcJqG4tn?=
 =?us-ascii?Q?3+m1JSydL5Xrcy0xbVoJSOEA8WpeuC0LuLVpFstnNkZEprjNzq/YEANKovP7?=
 =?us-ascii?Q?cexeQGGSLN3QZhAOMaHZHojxw/oxwA0M5n4WZppKDIDgj1UgmnP3pJb/yZgc?=
 =?us-ascii?Q?IQzKD+ukINNkH6N+ABQpMMSjorag4eKtneShmQPbK1P96ze9841TzuoxRg37?=
 =?us-ascii?Q?CblTNO5admEF6F3aGahpH9onYf8SQfAvro5XM1g1DKPKKnm4PPb0IRJI4atX?=
 =?us-ascii?Q?TE8fQuXKeXOFyg3a6B7G6hdjSq6UJXD6bscbp22jb/mu2/fscT+6cT4xLw/1?=
 =?us-ascii?Q?8Ewp3DwZRIqfsngQuAg4w/E7Hq0HkdvuCyWDZZrvVpIVDRFAu0D5fAmPZ8H+?=
 =?us-ascii?Q?C6kWLmXwuSqCSEwZ3aaaAfbD5xSCYFwYhtZtfyBqhzQSxGrJDMgSh3ykoE9O?=
 =?us-ascii?Q?ro62pxIR/eRT9phR58JZbnQA6VF+A/0dzvDY600LIXchdLKqSX+3i1Kf0YoE?=
 =?us-ascii?Q?l8QVqiudm0JhwOzUAOBw7Sl0VXJfhMXV7HETra9F5/D9FCaMla+ohxnjdhYI?=
 =?us-ascii?Q?wFiO9ZTp7AZFn4ehWBw/seqrF3/r/5KzB+5w/ioVby8jBpYHfB4gJQC27lrm?=
 =?us-ascii?Q?ZyjV5JZ9Kc3B+wjHcKXXelxt0GsvlK9LU49VbgEUwgRmDeIvSZ10CsP/pB6O?=
 =?us-ascii?Q?ARzUoCndhBZPMlRNS+RkGEwg/J6BPr0q5YPEORrv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf61721b-316e-41f3-1a4b-08dccd8e0c79
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:35:15.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCHWLKbUXbNdwpi0EZdUp5MY3OBOH3YfAyWsSvp06F6scqoHzG+RcTR4Xx4BelyLQBPgEzM6fHZQI2ynK+/5dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7308

Instead of directly casting and returning (void *) pointer, use ERR_CAST
to explicitly return an error-valued pointer. This makes the error handling
more explicit and improves code clarity.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/infiniband/core/mad_rmpp.c   | 2 +-
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 drivers/infiniband/core/verbs.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 8af0619a39cd..b4b10e8a6495 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -158,7 +158,7 @@ static struct ib_mad_send_buf *alloc_response_msg(struct ib_mad_agent *agent,
 	ah = ib_create_ah_from_wc(agent->qp->pd, recv_wc->wc,
 				  recv_wc->recv_buf.grh, agent->port_num);
 	if (IS_ERR(ah))
-		return (void *) ah;
+		return ERR_CAST(ah);
 
 	hdr_len = ib_get_mad_data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
 	msg = ib_create_send_mad(agent, recv_wc->wc->src_qp,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 1b3ea71f2c33..35a83825f6ba 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -192,7 +192,7 @@ _ib_uverbs_lookup_comp_file(s32 fd, struct uverbs_attr_bundle *attrs)
 					       fd, attrs);
 
 	if (IS_ERR(uobj))
-		return (void *)uobj;
+		return ERR_CAST(uobj);
 
 	uverbs_uobject_get(uobj);
 	uobj_put_read(uobj);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 473ee0831307..77268cce4d31 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -572,7 +572,7 @@ struct ib_ah *rdma_create_ah(struct ib_pd *pd, struct rdma_ah_attr *ah_attr,
 					   GFP_KERNEL : GFP_ATOMIC);
 	if (IS_ERR(slave)) {
 		rdma_unfill_sgid_attr(ah_attr, old_sgid_attr);
-		return (void *)slave;
+		return ERR_CAST(slave);
 	}
 	ah = _rdma_create_ah(pd, ah_attr, flags, NULL, slave);
 	rdma_lag_put_ah_roce_slave(slave);
-- 
2.34.1


