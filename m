Return-Path: <linux-rdma+bounces-21261-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N09HvD1FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21261-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:22:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9655CF6C3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8129301AB8D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE0F280318;
	Tue, 26 May 2026 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXJ1ZfOy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12728B4E2
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758571; cv=fail; b=ZRdY/2MNmA4R/ZqjDq0yP73y4ujghrdaXYaqxfDsAP4XiqJqzMBoAHhPIbKUuCT+zY29BQX+IuzgXArv61gu8AnTymHMhT4eR9IlZo5I1UxMfLpVVLn0hnrR82iDApqJ4UqCj+DW9wDClusUAwGaPZj7SH0QJYAjF5wUUQEz3mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758571; c=relaxed/simple;
	bh=r5UhbyQR0Vit4tmMn7YWEK4TIMNL2iq9aKGnZz/fqFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V3ZVrKRIUnTQz+CDNAqaZ38Ai0+7wq8EWMiedSCjhKKWqjEtlMSTWJ5TSgpY1FZzxU2IxP60H8NS8thO5kxkYf+pLmbP/4zBQNiod10yGgYWDAzAddA36ckCMzR/2JZYlmylHISo4jXYUlG4p2lWKYuhmdecZK1A0ofadwbu1Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXJ1ZfOy; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmlTtcbBuyFL4qhxE5QbIG708famboz5+Jth3hkFcWJVrDm4Bkj0wXLC70u/XBZr8bVWqMPLHhEErFGLuVmu928S4B7bvClZozY5Bso3zyVyZtM8UA/3kHG9KCNxEswXzOyW1CJ/BaDEa576+xusycdF1xlNOwl2L1PVJGqcHh0LXvnOLM1ZrMYaegzWjDy7Z9poDoWWy6ReRx4pztODtb8uIdOyQajAevlvsvtNVuvXlnB4JLl5WUElfHFnNJSvTXBBIuA6TuUJkyibAm7zu1BD3MwrD9ak+C1zJycfcoA6PGV+s9umijv0ZaA251FXJrmiasEgCwyjbgZqUEZruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo6UqcPSGfG9I+7CjOu0q6VD/eCaCSXyX1b6FcCnoyY=;
 b=QwjWtI9JLMIAnBAQd0vR2EIsLJPyLrFonEyhOP+UHOqNSo8whQNt7kXtWuH0tQKG6VHdv6ACC4KikibtTWyIRjrbUGBfNIBkg/Il4bCNVPpk67yP0p5jFxv54ixYtYkNjGtOKXJfiws0dsOtE2RiLgmoTSEJpcz/eY6/W8aXxmSzqvBfkLa/QnVBy8T2H6bl1q2RBsxTMhhp7iu4z/tvQsuYHPoQMjsXBt4GLCqQeri6OsMVHoLq5wTmY/UvwkWsE05CAHTTYcfB4q+USxgVNE/N3F8W8uuqD56hnteSScvN9HlUcWYa2ViA4+sP8AqYVrJHa3DyYVfsXcFN2hGMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo6UqcPSGfG9I+7CjOu0q6VD/eCaCSXyX1b6FcCnoyY=;
 b=IXJ1ZfOy7DQVOrdg/pseaedpxEi3SeKoSfQxRxqRkZoUcRlPx/2Ri7t1pWTP9eaVILHE7afnhsTIbcXikKPlu6EwQ5GlkGPczRkbYgPdf64DNzas30RRBXFEtdgLVsxj/HtFtai4KthpLg4TLBJr+aktvePexItkBfdZEPkH9ZW3U2esjxdai8z5MMOYq1xX8Yo4NsTlYIPTyserLSa7mV0zhQXQld2+3qZ2upT02OMoD2D64l4GsiWIyaeRxGOSCMGlejX6D74BIrwMnbdxfs4To+0kguTKQ0kq/shnGqmrB0t/+z/rWtmEBLBUFPGv2FLA+bj8od+8HPj9rehOeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:45 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:45 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 6/6] RDMA/core: Move flow related functions to ib_uverbs_support.ko
Date: Mon, 25 May 2026 22:22:42 -0300
Message-ID: <6-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::24) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: ed025b2b-60a4-445d-1794-08debac549d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	SqvBjumyZkj/Hf9J9FNq6PExCPioAgQr3LcDN/qi9xpkFkcPoDnK/DUR+rIy62aXtAE6N7vGj7usT0HHvsA3EUhrFDYlex/yPalPEh+ptzv5VkSkVmh83+RxQW/SiotXFXucTYYYDcvH91xuhekYAOIbBbc0C3uqFXX6fRsBXRTUOCuQst3HPes7VUXrjBTSP/TgO4zVHFBBLw6Nt0jScW/1EKoEbqRsfZzCALp4+lfM14WWU8+pNEGGqRyhn6GOWrmF1z/pSrhE5pp3VOm4ipnoj1Jjr54WII/X8XG2yoa5LoY6g/JRvHqOlOEe3OEbK6govnpTKXExUZEA5QATZV9qE1JUMeT9U3qFCBt1Qz20eSApP1Ll9SgetmcYQkb9wc9DHyUZSe1cV17GVqCRS5/1biei79Lvb9z4LzkGnzfPeSofqjnQj/DosSdOda73LEfvfaOLavHBtOye3+mCLeifQV05KhhNf60C+5ST0e4HVzyKl6l8X2Mt5Llmq6oOgKYkFAdgzNyk4AuTQQqv9/IiFYX0O0VZ1g9R/E6jCMwwDPyYzdnRHDug64sCnJG/l3Xb1tv9vd6bUIpKy7zMPyKnutgjFVVU+CJlZh7RWTYd45kAAfiJkyb/NlWs6vl+u4ZzcMacQjuE2Lc9GI69dFJ1NjIXCC8WhFodjwcQ3Jq5aYyDTcM1coXDGIn0QuTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fd19OXlFmMXqtHbi2ELDbplNlxR1mt0AHiAaslbgyraTnP2jhmJcJVBwINjr?=
 =?us-ascii?Q?pQ/nyKjBAJh6UZiBBd6WZAUgMbbSzrnp+xv0XlS7O62ppOzbo9UOT2wO1q90?=
 =?us-ascii?Q?l8HP1gyZ+GoB5iBxuzUcxTncv3UDOtnHbaKNgotWMBo+JXLUa0xt/O8Nrbeb?=
 =?us-ascii?Q?6VlKg5mDGCLX+oHrj5jH88DPgOPAbM3TA5VClQj8mdQilX/DkdlmHh5HzLDe?=
 =?us-ascii?Q?bqMZq+8oMar8Qm8T21P0sJu+onaSo4CMI7z4ePz81ETegLp+n5mB+Mzs3xw0?=
 =?us-ascii?Q?Ki/ljqAkSGo5FQ94JrScvVhgsiLAuqh/XsLiSyoWk/dws7a1qUkVaDSEx0on?=
 =?us-ascii?Q?asnTHY/6Nbn5i3PZ46eUewzdXi3BTzG3tLrkJr4zLFwsSh+zvueUaBUwSn6l?=
 =?us-ascii?Q?aKxWLbCtmPoaxWH7+DeL0Oxg6slO/LDwF9Z6zJvxDY02WpsXkG13pxweIw9I?=
 =?us-ascii?Q?9iC9s4HDI3JYLm7linN0KuGRPTxWJYTY/CZ5+3zvOiaoxCWIzCek9Y5OsPyn?=
 =?us-ascii?Q?0alDFTMpQ3x+FKaDHjNHRsDNUqnZshgKnaRCm9SeY4OyuB/Hg4DM68bHjhRD?=
 =?us-ascii?Q?lgiKKxM/DM/WwI7OAXE3DM1EI1BBs3l6rMSGqD0r8OjITuMbNlgOPcV5nJcS?=
 =?us-ascii?Q?pbBWirdDoD4zKjrg92GKuCWmXgOoxH00S+H6wI0Y2dI8A4O76y3pYcPnwuIv?=
 =?us-ascii?Q?wSms8Ilxg++uAke3r+jAOE0IwxFN0H9+CawPEk6hdgdeLwUiC+ZtEdEXmiij?=
 =?us-ascii?Q?wKvkNcnRmhNnzUz92pnpixE/275iPRbM0VMrYeB3jaPT9H6bhyeWXE6H+dIU?=
 =?us-ascii?Q?sch2RTwcYCIKZk6hpCwtI/39SoWVdeV5jK42Cgr+9r4YKrslVPd/A27DalC+?=
 =?us-ascii?Q?LzE7vuUQ67lMaV9dFdiEgksdxAhs0xwRqutLrDe7y2aF46LhzhDZiYpn9hwE?=
 =?us-ascii?Q?FW9MC/vsPV85+TLVQTy52/h9BMkHy5nlM/SZqFSdbnRKajKbLeKM/dQo+/Wo?=
 =?us-ascii?Q?htE5ICz++VA8CdyQGk7M96c94QRQC7K9rMeoR5PhwqbCn0mu9kXjk+QZK7Kh?=
 =?us-ascii?Q?6PYMhbjjsIAJXX2Eo7rWe6U3YaZiJJ2t3/SdODNR+CxgoqH1xTdcpb9qYPyh?=
 =?us-ascii?Q?BJ5zFM280y6WMUGuL/Whl6YEDx4T+C7ecWQ1JWKBtwbGgnTmRWc7vzWh451q?=
 =?us-ascii?Q?8FRMsTpzbgX4Q4WUbQC3XwFBq42B4xa0fXDNIZ0NHKjCsNHCAPA/RWLIUk0w?=
 =?us-ascii?Q?qbTR0kQqE42DDgEsVofLB6J50yLIPJs7pZO1q2Y4LcuRr9I0x96lBLXVvLNr?=
 =?us-ascii?Q?0zgvfPoO4zO/7axzt9dHkmR8itWna6NoWToU2qUNx9ftfIOjDaVrcI03pHB1?=
 =?us-ascii?Q?6ax0o/xXye8CsRvUK7ChTq78Crx8m8lD8ifRqEDirBZsdo9W1l7S5i/2x6JZ?=
 =?us-ascii?Q?gzwvkGt744zICrGAMn21ON8SQZkwdTxIZcWiEalQ7+jCtjhS2jyU04ylx74f?=
 =?us-ascii?Q?C1IjrhyksT85fblMZ8AZANyXrJ/gGEAlXq9utulwdRmCN1JQXDK5U/r+vHhG?=
 =?us-ascii?Q?0n2iSI8Cr8EGdLyn3FzgbJP76ppfJvkHTF1dY4otD+/tBdlAggZkaz7OpMJl?=
 =?us-ascii?Q?4Z0G3QYjXbaCtuQv1zMoqkQFdegw8r+lvHDQVq2xglzbkcBdMf60yzv6r08d?=
 =?us-ascii?Q?0reAzze/60WZBA5029rgWGoyFuaQn+eUpyscsjb3peFdUgxt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed025b2b-60a4-445d-1794-08debac549d7
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:44.4803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFninlwqMHwaolrGGO9cuTPd93vBEAFZIM5m7Y8mjf8l+HJZX0/gJg98lL+O+4md
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21261-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: DF9655CF6C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlx5 uses these as part of the driver implementation, move them to the
support module instead.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/Makefile      |  3 +-
 drivers/infiniband/core/uverbs_cmd.c  | 76 --------------------------
 drivers/infiniband/core/uverbs_flow.c | 78 +++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 77 deletions(-)
 create mode 100644 drivers/infiniband/core/uverbs_flow.c

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index 47f645cb76f69e..ab7a2197bc8635 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -49,4 +49,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
 				uverbs_std_types_qp.o
 
 ib_uverbs_support-y :=		rdma_core.o \
-				ucaps.o
+				ucaps.o \
+				uverbs_flow.o
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 91a62d2ade4dd0..32914007bae66f 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2594,82 +2594,6 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	return ret;
 }
 
-struct ib_uflow_resources *flow_resources_alloc(size_t num_specs)
-{
-	struct ib_uflow_resources *resources;
-
-	resources = kzalloc_obj(*resources);
-
-	if (!resources)
-		return NULL;
-
-	if (!num_specs)
-		goto out;
-
-	resources->counters =
-		kzalloc_objs(*resources->counters, num_specs);
-	resources->collection =
-		kzalloc_objs(*resources->collection, num_specs);
-
-	if (!resources->counters || !resources->collection)
-		goto err;
-
-out:
-	resources->max = num_specs;
-	return resources;
-
-err:
-	kfree(resources->counters);
-	kfree(resources);
-
-	return NULL;
-}
-EXPORT_SYMBOL(flow_resources_alloc);
-
-void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res)
-{
-	unsigned int i;
-
-	if (!uflow_res)
-		return;
-
-	for (i = 0; i < uflow_res->collection_num; i++)
-		atomic_dec(&uflow_res->collection[i]->usecnt);
-
-	for (i = 0; i < uflow_res->counters_num; i++)
-		atomic_dec(&uflow_res->counters[i]->usecnt);
-
-	kfree(uflow_res->collection);
-	kfree(uflow_res->counters);
-	kfree(uflow_res);
-}
-EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
-
-void flow_resources_add(struct ib_uflow_resources *uflow_res,
-			enum ib_flow_spec_type type,
-			void *ibobj)
-{
-	WARN_ON(uflow_res->num >= uflow_res->max);
-
-	switch (type) {
-	case IB_FLOW_SPEC_ACTION_HANDLE:
-		atomic_inc(&((struct ib_flow_action *)ibobj)->usecnt);
-		uflow_res->collection[uflow_res->collection_num++] =
-			(struct ib_flow_action *)ibobj;
-		break;
-	case IB_FLOW_SPEC_ACTION_COUNT:
-		atomic_inc(&((struct ib_counters *)ibobj)->usecnt);
-		uflow_res->counters[uflow_res->counters_num++] =
-			(struct ib_counters *)ibobj;
-		break;
-	default:
-		WARN_ON(1);
-	}
-
-	uflow_res->num++;
-}
-EXPORT_SYMBOL(flow_resources_add);
-
 static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 				       struct ib_uverbs_flow_spec *kern_spec,
 				       union ib_flow_spec *ib_spec,
diff --git a/drivers/infiniband/core/uverbs_flow.c b/drivers/infiniband/core/uverbs_flow.c
new file mode 100644
index 00000000000000..1528a294f7f85f
--- /dev/null
+++ b/drivers/infiniband/core/uverbs_flow.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+#include "uverbs.h"
+
+struct ib_uflow_resources *flow_resources_alloc(size_t num_specs)
+{
+	struct ib_uflow_resources *resources;
+
+	resources = kzalloc_obj(*resources);
+
+	if (!resources)
+		return NULL;
+
+	if (!num_specs)
+		goto out;
+
+	resources->counters =
+		kzalloc_objs(*resources->counters, num_specs);
+	resources->collection =
+		kzalloc_objs(*resources->collection, num_specs);
+
+	if (!resources->counters || !resources->collection)
+		goto err;
+
+out:
+	resources->max = num_specs;
+	return resources;
+
+err:
+	kfree(resources->counters);
+	kfree(resources);
+
+	return NULL;
+}
+EXPORT_SYMBOL(flow_resources_alloc);
+
+void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res)
+{
+	unsigned int i;
+
+	if (!uflow_res)
+		return;
+
+	for (i = 0; i < uflow_res->collection_num; i++)
+		atomic_dec(&uflow_res->collection[i]->usecnt);
+
+	for (i = 0; i < uflow_res->counters_num; i++)
+		atomic_dec(&uflow_res->counters[i]->usecnt);
+
+	kfree(uflow_res->collection);
+	kfree(uflow_res->counters);
+	kfree(uflow_res);
+}
+EXPORT_SYMBOL(ib_uverbs_flow_resources_free);
+
+void flow_resources_add(struct ib_uflow_resources *uflow_res,
+			enum ib_flow_spec_type type,
+			void *ibobj)
+{
+	WARN_ON(uflow_res->num >= uflow_res->max);
+
+	switch (type) {
+	case IB_FLOW_SPEC_ACTION_HANDLE:
+		atomic_inc(&((struct ib_flow_action *)ibobj)->usecnt);
+		uflow_res->collection[uflow_res->collection_num++] =
+			(struct ib_flow_action *)ibobj;
+		break;
+	case IB_FLOW_SPEC_ACTION_COUNT:
+		atomic_inc(&((struct ib_counters *)ibobj)->usecnt);
+		uflow_res->counters[uflow_res->counters_num++] =
+			(struct ib_counters *)ibobj;
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	uflow_res->num++;
+}
+EXPORT_SYMBOL(flow_resources_add);
-- 
2.43.0


