Return-Path: <linux-rdma+bounces-17429-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFRgIAY8p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17429-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:52:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4D1F6690
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07C25302C6E1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4F2D063E;
	Tue,  3 Mar 2026 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cmMkrblX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D860E37C919
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567419; cv=fail; b=jbUC8bEK3Jl5Hxum36CFCbsUuTrwbhBjuWnDex/g7tlLQ1mfbyvRok3XHa8JIV6oeI9d6oiB6XqkpLrHH9Xc7HDs97DW0MsHUm+TNBkaBQZTk5UUQyni3dwqik39ksaxyabtnZ6cG5INP4jan2xR5Bt7uJtGi/lL0KlIiFaosok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567419; c=relaxed/simple;
	bh=GZn9bNTaOubQ2REYNeuF2BCbQVApHYyxJ83GwLUyaX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beCq28FAO6OQc820aI20TBbnWJ/YbPfEYoCyOGpMbGwTESARXfh1XeZnfgef5C4TWUzLWrhT+svUNGdmdTfSlQu2Om+cNsLH+aj9yR+81dVLuyUdZiy8VyzLSTWXMBH0b6kgzWbCrTmULK87CC/PMxlDBwNdfu52HGk5dYJDyvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cmMkrblX; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWiFnZGq6G6HoA2Id5WpxAHtOCBr8zX6yR0cOGgfQs54CgU946JPDzlxdhr9IVDc8oRmIznhpRzhtFWjYX5Bta/+Rsf0/OIpBUJNihgTQcBObPeVMyfDupIv1yJoseWmYMV6N2fh+ukaXynsgJUXfF9FxrZ+avqfuw5TO4zDEelw4OK/TY8iefoNJnGfXaqkebo9G8TLs/ZKVo6Vsq6GqYlJh+rVxwdFKv8ccOLQ4h5o8rRWr3P4kY5tyY2cTf5oDDM2JoMH9PJYoIwkUUH6/pJMJI6y+JMwxJ7vToinr8LkfuZLwZ+5Zk/mWnw9pLLL3hafu73UjPbTWHqSUVrjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUxzTqtfDU3ofLJVLmtHnJ7W0SN0Pk316W+6JZgL7xc=;
 b=Tyqw6eqmRg2zzJH5dHUuH1P7k8Cyqszww6EmERVpk4c1UvU+xd1HDEs+Y6lYbedFguRgJ1PAz2ghbZXcR9hi2aqMYu0//OS/vZAAfTpQ/ojcM73UqxJkgVpeebuvk4Buph+PQ5QshBughE8zAi88YGHtYGUJQirJhapX986kdJ+mCszIkiLnJy8E92F8HhD8S/nY3ivY1SNEc3xLDpPnQaQGXFIa7wtQmlDoe0L/PygAWDnttPASU59T8IUzkliqoTQPiQht+BuK5hNYaje8Mf+uMDaPOl7ZE1pikKsoWGtdgCxKvaRxGvaLWLZndstK3Q4BAif4kyJcdhvUatME7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUxzTqtfDU3ofLJVLmtHnJ7W0SN0Pk316W+6JZgL7xc=;
 b=cmMkrblXV4qPn0yfSxiJZdpUJ5U3Ev2IJxwCW/ZMh8ZzhFVL39E7YrWvRE9wd7Bq4WqTpKbdPJtSe0/XPkdzzUFv4yfhnZCmYFyrdB7Cu3HhHA3dYJYZDev98CyWHiMt+29EBT00oRAOjyH4S/u0LpBgOnsPaaVvvaCPY85g9gS4wy+9eEVAhS69ux3yZjJrbHEYPm/6dLSrakzZQxBGeigF/Q7uOqj3WZX2cEUUWnMMlCOmCxDNN/paWy+anTrowehnfvBNbJaAj8QnUNmlNg6E1zSq1zL1qMchpzZEMqT+I7J3t5XGESssL9oy/H6KpyaUHDEfrPePd/AFu6huEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 03/13] RDMA: Add ib_copy_validate_udata_in()
Date: Tue,  3 Mar 2026 15:50:00 -0400
Message-ID: <3-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: d53ee48c-d43b-4ee8-7a06-08de795e1476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	bCjyrim6YW2CcgXpvXEh4Jmw9w+tUvbd/g0MEK/VppyWnkTpSyDHJc2SWCWRTd+uDow1eF9yjNI+74gBeb5OhkxctyFbn8lFXiLRCJTisMI7PxeW8WuRBkV8WVIouATNX5HvnG+/M2vnleQPY4u4aaeJQd2rWEC0uu7nCWuuGL6ZXqD5ge5UADpD24vMqs9jZp45LI36Kdf8pdsymKQxSgRfC/drQJSwEO7qlHTSavpMlgwASchYBgaVuZEyDS97EtpxZ2MGFObFtn0XEiTKpXJ4BtbXo6X0ymM8IWQWrrlinSI14uPqANv+Tm6dtg6tbiXwmxMjtexuWgqKVT0HQDCa5RMtFCgwDYSbhwpnbc7JCuw25R0lOM+zlYsvVbljxXl9BE2KhFIfV1wlTYylGO7toeBxPjIDKWWbbRt5k9hckAxRK2Vnet8rKUZyaxbT6tUSUx9TvdBUxMmQw1+IzuEqiVQIhObojoJGsiW+ixgZ/2xj5u/LqzrlScFaPwqozLn3tutLnAXD09nPx6gxowi25eNYTzy620a1/bLXM6QRgJAwL15ufppWrkagotB95bFmTFmBq2lBTddV/GH+S/9B0L5n5YSxPaOiYpsCuVQCoSjfNvggVDraRvyf4XSw8aQR66lNwhd1j1dK6D+L9d/sXTwCtudYJKtwLU5ErfAFBfd1WFcwh0TNbygJWBjriL6hlUBydhLSlCY6QrsJlxirJcwphUuaDm0cbGRfSMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ighrgXyyKtStZmBeXuFGvm9HYTwgybd0bC/REx2aKMhjn6vlNaavKNOpuAew?=
 =?us-ascii?Q?xwIFo8Gn81129DmqrgE0YWp0i902Yno1HYvSlan8sNSMIN6bgynl2DYobfKG?=
 =?us-ascii?Q?7MhDhlivL+OvbRi1kcc2PZHVAUFnMnDMUxZ0D0veYW0S/atzy5H4sPUEXj6V?=
 =?us-ascii?Q?LRbh9S7nW/FtOXHhwakAo98oB6WkDp8prdnCTy67gEhYpCCUZzHcO+1L5KqG?=
 =?us-ascii?Q?pxgE2zjRYP8qR6YS+rjDSxpKbt3b5wqHkIVyJRdZU9AV67hQd8f44LElMCjU?=
 =?us-ascii?Q?7tJuNso8HUswRByYpGdZb+0B5wVoub9DFQu6KmkMYYdSgTBHYquIQYkJC9fp?=
 =?us-ascii?Q?lIXcPO7/vdRs0URUaZa9TALKrRU8RqWVRvYsYdXEKU+LL0MVXTtO2F1Tdy1B?=
 =?us-ascii?Q?AMDiao7TXNFDRLIkcXXnSgINoS31zdFqELrJ/n8T0BpofrBlPb7vK5YYRqsX?=
 =?us-ascii?Q?OLJr29Nln4ZaJ53xn3AshNbc+fL4bpeiuzd1hRM7IJ2WpeaCo/pcbCX6b+tk?=
 =?us-ascii?Q?JXRI2P1uNl560ZhFKBuFXUoY5shmMQQyxWMi1Nur6dYABugEH6tJxXVpL98I?=
 =?us-ascii?Q?KNohGXkAd0JoVLwN64ZHEOPKIruS0nc0qKpWk4X8QwLS0sGsdfVeeHN1/hRg?=
 =?us-ascii?Q?YMMnBAXBGLqIECK+6xIDDy0h925v2GKZyaz9AIgayJgIS3kCWZKWHqvbR/fY?=
 =?us-ascii?Q?MVAUHW+imoFG0niHTDC6ot0YYduzzzokajkcpnWIqmVLcQB8FJ6H2zYfh3AP?=
 =?us-ascii?Q?EsyGZHRHNCEnEscrF8YvherHZjuIo9ZFA17lP6Yy2la1NNVxwInFdXODnE46?=
 =?us-ascii?Q?F2TMbVRspWxTxYFNzRmC7bMFjAI6YHlPTUkchA+tYEo6nsrIeNE3zboc5irz?=
 =?us-ascii?Q?yBcPj4a0SnSAp8ePWA6A06YILSy1zEEG+UFEClhmLx5r2sr07kmbRUePQr3P?=
 =?us-ascii?Q?1NVd1FSqfXVkSDuQI2I5PmZ4HbnujyigIeGeBnW0Vlk88FgEAviivO3Nt0Wf?=
 =?us-ascii?Q?KLInlT7k9KeKnoSYuZK0rhuXu0m4EsdE+PZhjOFHX0cfukBt+87NUEnxnWDV?=
 =?us-ascii?Q?65Zvmem4tBeh6qhUgyvo7mHN+5c+bBT1NJrNknJgQIu+Hi//65dmWUtuPOYw?=
 =?us-ascii?Q?QzmYSn2mWaXM7R56VAZTmyWfxJEAZg/zFZiZtg4g2lIVPzmCCcQAnmVZ8InW?=
 =?us-ascii?Q?zPnR6AL81EBSJ6WqMTkgPXpe87KiBzDLI193fRrRBk1YDUgGQ7pmr/Ax24mT?=
 =?us-ascii?Q?hFsp4gTtdbQVq1ME3GRr9JiRB4u1kg83qwI569Zp+PGN8QUMK/zaKjOvZWW9?=
 =?us-ascii?Q?T7DvwDI80FGL58DECbUlKDJ+VNv9SLt5O8DGuSl1EGneF+8z7At+27/BrkgG?=
 =?us-ascii?Q?JmKRaTvP5hhohmc34oZ3Ci7Fo86v/sEBgyh8CisKtdUDhrxPWxGCCPqyBUCv?=
 =?us-ascii?Q?UXyYRBcQeC0sp0ZXxnfQl3rgiTf1vrlNEgw0HanUPGdhCSrLuPb2aN7jVz5Q?=
 =?us-ascii?Q?btVAGdrc02k6kRmtzQMcrN7B53FiVifAj5V0dXikOiqmmC7RSr8Ef9Z74FS/?=
 =?us-ascii?Q?Zg0evdywQQ+6Azk7wEWg3dcH/5zX1jMuJ1cJkvdYi+nqxSHkISedcZ2gBYIY?=
 =?us-ascii?Q?9tl3kWkK9rA4h+mVVVRTVqHXlO50jzv6vVaSwFP9+zBalgOma9MaGzVKsbx7?=
 =?us-ascii?Q?/Y9W+9kJyiy+8QZx5XhBEMmvmTTbUfbDYoyqqVDNVZrMd00cDhNsZh/n2iro?=
 =?us-ascii?Q?1zrZ9uai3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53ee48c-d43b-4ee8-7a06-08de795e1476
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:11.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Fo1z7DlDhYMqA55cNb68HvFX+lqjiJ2qF/Y0MNmsN8ltpNjzrpeHJVI/OCp70H+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 7CA4D1F6690
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17429-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Action: no action

Add a new function to consolidate the required compatibility pattern for
driver data of checking against a minimum size, and checking for unknown
trailing bytes to be zero into a function.

This new function uses the faster copy_struct_from_user() instead of
trying to directly check for zero.

Incorporate the common ibdev_dbg() logging directly into the error paths
of the helper.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rdma_core.h    |  3 ++
 drivers/infiniband/core/uverbs_ioctl.c | 51 ++++++++++++++++++++++++++
 include/rdma/uverbs_ioctl.h            | 26 +++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 55f1e3558856f1..269b393799abbc 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -151,6 +151,9 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 			      unsigned int num_attrs);
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
 
+typedef int (*uverbs_api_ioctl_handler_fn)(struct uverbs_attr_bundle *attrs);
+uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata);
+
 extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index f37bb447c2306b..81798c0875ed3a 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -70,6 +70,19 @@ struct bundle_priv {
 	u64 internal_buffer[32];
 };
 
+uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
+{
+	struct uverbs_attr_bundle *bundle =
+		rdma_udata_to_uverbs_attr_bundle(udata);
+	struct bundle_priv *pbundle =
+		container_of(&bundle->hdr, struct bundle_priv, bundle);
+
+	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
+
+	return srcu_dereference(pbundle->method_elm->handler,
+				&bundle->ufile->device->disassociate_srcu);
+}
+
 /*
  * Each method has an absolute minimum amount of memory it needs to allocate,
  * precompute that amount and determine if the onstack memory can be used or
@@ -847,3 +860,41 @@ void uverbs_finalize_uobj_create(const struct uverbs_attr_bundle *bundle,
 		  pbundle->uobj_hw_obj_valid);
 }
 EXPORT_SYMBOL(uverbs_finalize_uobj_create);
+
+int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
+			       size_t kernel_size, size_t minimum_size)
+{
+	int err;
+
+	if (udata->inlen < minimum_size) {
+		ibdev_dbg(
+			rdma_udata_to_dev(udata),
+			"System call driver input udata too small (%zu < %zu) for ioctl %ps called by %pSR\n",
+			udata->inlen, minimum_size,
+			uverbs_get_handler_fn(udata),
+			__builtin_return_address(0));
+		return -EINVAL;
+	}
+
+	err = copy_struct_from_user(req, kernel_size, udata->inbuf,
+				    udata->inlen);
+	if (err) {
+		if (err == -E2BIG) {
+			ibdev_dbg(
+				rdma_udata_to_dev(udata),
+				"System call driver input udata not zero from %zu -> %zu for ioctl %ps called by %pSR\n",
+				minimum_size, udata->inlen,
+				uverbs_get_handler_fn(udata),
+				__builtin_return_address(0));
+			return -EOPNOTSUPP;
+		}
+		ibdev_dbg(
+			rdma_udata_to_dev(udata),
+			"System call driver input udata EFAULT for ioctl %ps called by %pSR\n",
+			uverbs_get_handler_fn(udata),
+			__builtin_return_address(0));
+		return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(_ib_copy_validate_udata_in);
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index bb86d8ae8a834b..505492443c36b5 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -897,6 +897,9 @@ int _uverbs_get_const_unsigned(u64 *to,
 			       size_t idx, u64 upper_bound, u64 *def_val);
 int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 				  size_t idx, const void *from, size_t size);
+
+int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
+			       size_t kernel_size, size_t minimum_size);
 #else
 static inline int
 uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
@@ -953,6 +956,14 @@ _uverbs_get_const_unsigned(u64 *to,
 {
 	return -EINVAL;
 }
+
+static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
+					     size_t kernel_size,
+					     size_t minimum_size)
+{
+	return -EINVAL;
+}
+
 #endif
 
 #define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \
@@ -1018,4 +1029,19 @@ uverbs_get_raw_fd(int *to, const struct uverbs_attr_bundle *attrs_bundle,
 	return uverbs_get_const_signed(to, attrs_bundle, idx);
 }
 
+/**
+ * ib_copy_validate_udata_in - Copy and validate that the request structure is
+ *                             compatible with this kernel
+ * @_udata: The system calls ib_udata struct
+ * @_req: The name of an on-stack structure that holds the driver data
+ * @_end_member: The member in the struct that is the original end of struct
+ *               from the first kernel to introduce it.
+ *
+ * Check that the udata input request struct is properly formed for this kernel.
+ * Then copy it into req
+ */
+#define ib_copy_validate_udata_in(_udata, _req, _end_member)      \
+	_ib_copy_validate_udata_in(_udata, &(_req), sizeof(_req), \
+				   offsetofend(typeof(_req), _end_member))
+
 #endif
-- 
2.43.0


