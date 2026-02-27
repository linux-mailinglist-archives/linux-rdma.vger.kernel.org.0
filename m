Return-Path: <linux-rdma+bounces-17276-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GyoBSH1oGk8oQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17276-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:36:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A75741B18CB
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5368F30CC1A2
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB0925B1CB;
	Fri, 27 Feb 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pzGDWdLh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B737292B54
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156099; cv=fail; b=K92/1J4Xdzh6n7xYhq33WxslABrizlwfJPeABdq9ujQeTtmzCxpVd5iKZvOVX4VxXM/TpkahaqWsrvW9Bi1UKLQtKesyqhaJT2r1Fa8do4Wdfu1HQhOh1tPPeBawgI1/i0rUvHXrW83GqqDce2kFVn6XoK8+yAvcZtWn299lRY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156099; c=relaxed/simple;
	bh=CtFmgAWmO9LGX+UGDIPJQWU5lfi03y1AiDz9p0KS/po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMI/x7vEebmed9fdlRX9H5fhxhvLsh43ExsVmT8Mmi0oGKbAegCnkKtMVRMCPWLAygITKzm/mcZeQteqeWpn0uptZvLa+2AeEXHdSZtxT0FvGPW1+BIDy8WH4OBys1JNFAmatFLiQUagSJ7LE5U57+uhzipa0k0+HKHaLYmq788=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pzGDWdLh; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4dtRDb9PK2oX5HgtImtK7dfntmvHsBt4UerSSXjkNWTheXoWoBx8yEQQ5scdsyqT9Shfp9Fcf8dI1nSFIPUzw7XHZ3nXXgG8tkDNvfqggyrokGM7+G0k5tz5VUos+tE15p50hEOlZJdfbMgwpD0BToRqYBQbXPwTmiX0QgxouovTKfgJm0uWpu0VBdYCP+6csM2bk6GvMh5wWMeglfTGVQrqpJqDaQy7G94NGMOSZcpnzX2ntNfE/4jZYmlmNxsw+qyZOthDGI/27PpbItmPZmVoM6x1Hn1CwlQ3XCySHygxOWGvctxuJTOSUCAsIs1bl+BAAP9BZTz5PlXKRp7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO2iv/iVKLb4DXhI/+ILZpsDRGTEaCkgl+P5SzRr7vM=;
 b=k86GiUk8mBtznJNKjfCUlrSi4crPKMtGgTP9+lyQ9s4qXVpXfWhGweSX5G13fseUwS0Yww3kSNSkn9XOpfyUqxgeOGV9KqA1tPfZogrQpMCk0yBgmJCNZ3BWL5lh1m16sPMAEF5HTQF09WUDUjUdPDbvnV81/sV6xzklcBZqz16IepjZS1vVrjYv/dL0wY+WO2ToWFCXYylPmOEvJs1VBeHT6exVoARi9ZZomFpEQhYPiASxzqEV3/Eg3XubA8n4Mt4WJRTQfbqDoBlR46znrET7bKcFiNIMeMfzyl+/rRRN1ocvruzf7u49FqIVwambkf2hDRIZp9e0WIgGi+Uvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO2iv/iVKLb4DXhI/+ILZpsDRGTEaCkgl+P5SzRr7vM=;
 b=pzGDWdLhjrcQyTwvpsmN2npAt05184XinponPoF1rZejfhkCST54znccOvmqMoj7EL9eCd0Q2RSaaqYlsD5B5Kk+RLtot1tZkl2d0x2nktJJqKjkimju5upjeDtIYwHhwK5oSaF9qntbZ2TxiE1xR4gysWzv84ffpHEGItI7PxdBuXJNm29VYE8sdcntAQwGYMiaCGLgTfcp3IWGJI7rvyl/W+YrxTD95J2RVTtfKLgMu42Sapj1kzF+fiEKPpuN4/Js5O0gKATBcUXWAAw0150NnB2sOElaJnnf3DIw6cdVI3dk6cZk92iPRSslsPaf82eMAD7vh1ZsoMHmzwrkpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:34:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:34:53 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 02/13] RDMA/core: Add rdma_udata_to_dev()
Date: Thu, 26 Feb 2026 21:11:05 -0400
Message-ID: <2-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 145f481d-23e9-4c0d-b275-08de75a0682a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	7sPG6jcML6GyEKrfpn+CyhBURFNAWnOTD8mArUghkLRQs5o5pGz1vdznCmrnJGEoFZ3sYbwwvUy+OA/kXn8s6Vy1bX3uWF04f013f3qVgik4AoKCu7dz5v5JArWvzzHQ7V5szFycBi130Y3mA7rFQwDnmfO/gIh4L2BR/5uevRVFX/5XmLHNbiS84OUuJW8MoLjBmwzw9UxDA/IUGwTR28mMA6KVVn5OF/+XWhRa+THx22r7kEJEGJYoYPb8TJooGzcMXN8NLPexV47f1+w/Xw+ZA4siBhQ1uplkU21R0jpS7w+M7IdrlaIDQ6l7MgptCJVJMzwxZIN9dq56DonG2UWskrAIdi0SXpQMgLfFNG2Arp/nrliXk7k9M2OuNNnfco9aYOijCDaHKkDklEObB1qGv7NarXn06N51Qi0oF5qgsyhkzXl+ykmhq6/Ndrdsnv7LdKuz+jHf6SsEMjrzXvMdbeg21fWV4wF7SBrN+is7vZBPL+LWpqWxuccGV8kEsilOSfXOO8RqMcNiOwde0cbGaNEMeyREB5nqKbeM5FGaJrpeUgdI2p6rHWqjfLJUJascsQm/hzikKKcZhqpbbBLCBcUOk5q30fypB9ePxMXeWJrnLhHd57yMqyPEiSpR53CbPwm+priYoDlhLssxhrqNqkWlc6cP7xTvbmuBBHoU5gEd7RTw2b6OtNTmTu4pFtYw/CGLU18nEAipmYZ9+rrfsk9h+gY7+hmyowDq9t0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2q0Rp+bWZu/3Jw+UNvHZ9ODVzWpki3OjKFFa6yDDitUzIYhZE8k6lE4TvfwT?=
 =?us-ascii?Q?kkQUK0MgpqUwgwwCuv3fA+ZmROH+YeUwuquVtkCzPM3o6QWQGEzMHaMceDtT?=
 =?us-ascii?Q?qvamsOLMU+4zXEw+MDxfQocaGQ1L33FsZvwR2F9VFL6Rb05rY0OpVm7fze2B?=
 =?us-ascii?Q?Zm1CqiKOOi/+VIvcQjzouh/3+qaIjjLUHB7W9zJFXkUe3GCRCXyk4n+N6mYx?=
 =?us-ascii?Q?b2PQjs5mX0LVHiXj5amxc43NZFD6L+klFXNn8gpWTDwIMuR9jBJIg34ZVIKO?=
 =?us-ascii?Q?70hi1hBIJQ1U7LzIcR/ete8trI8aulyavU3Kvp4zo+hIjbePWKXFP0j/+v71?=
 =?us-ascii?Q?Kvvm9us3iwhFBdC9qn/nUysuPylqAnQAfwu+KVU8GIRc6ZtDmpHtHr8quilF?=
 =?us-ascii?Q?LGqB/t/6cZ0DAH99nJ4AOy2n/h653wzIqCusKVLoL7i7UV/7E5eC8MJPzDs3?=
 =?us-ascii?Q?fEfsBH+AKLsBUieN3zu/KNWnyR8w4uXkSM7bF3g4GLJgpSE/RdlENnyQqnG7?=
 =?us-ascii?Q?sO3Pq+pY3ADC5wpkW3idUkorIdU5Um6D0cUGEXtDtWrhprP+FMP+NfQsJtrL?=
 =?us-ascii?Q?NmwbNv6aeNz+1OjgO/zDxIpP7lFS+SIYVRO69OMACO9EJgYHWE88+dDGsq4O?=
 =?us-ascii?Q?WgR3VDyiJZ7+sMz592dv0o0iNOiHVPuPnFvisufwfaCRdbhWlFfsNCvJjdg5?=
 =?us-ascii?Q?kopmfqSGWD/NHIfnX4swv72M7FtoIiEvXxCbSH1/88/MwCMlBxoNGQzTBCLT?=
 =?us-ascii?Q?8j+2y8f8dTUWi5TuI9FGS1xQN7d1f5d5W0IQ0ARqcT+IdvTSjSNobBDRr3SM?=
 =?us-ascii?Q?bEDhHZsjNEsingcNw0n1plaIlabTs+iKfdXvkXteI6xacBM0eioNd6en46Zc?=
 =?us-ascii?Q?7mlryPlE6cVzut1+mB0K7tb2lNDl2vlhAKatQkCYf1vxCATzcUmiJJL60ZON?=
 =?us-ascii?Q?rBGXlVfGVyKXAOO7svK1oQYjoVIEonc5UljkLfRTnm08/O1rRgOCXHMlz+ek?=
 =?us-ascii?Q?ViM/LbNonAnQVVAiA0nZdb1rWK7Cg/B1fDXMMSiGBikpo+CWRpV+5upqufj2?=
 =?us-ascii?Q?Kp6IWWH3XaEqo5wCZbx+3akgKPD6zrlQZeIN80fVZegnXFwG4vBD0D40OUTp?=
 =?us-ascii?Q?9ezEnWR7LLpnFD+2M7wguv/zXFRMkJIPZVMGTwiYtJzgjokL7qOZgXrmSPb2?=
 =?us-ascii?Q?/v5b0ETI1KT1FgA9eeLSgJ9fqrWUw1dLV8iCuC2Y0mwzzKGqjkJzJW1IO4KC?=
 =?us-ascii?Q?jZau2pnNW8hNRg9yV2i+DXKT3uvDLq9VFZDLcK4YOrly+lswu87v1rmAJDEi?=
 =?us-ascii?Q?v+yHuTdGzjM6tUZxsgLssf0S4Rjyd9xiJS4ltxRGc3l897JXB++52L9XKd7J?=
 =?us-ascii?Q?cFodIhBWCB+fgerqg4QwCaEUV426NxYVgxcTvz1irTkYOsC+PYC6flwufWyc?=
 =?us-ascii?Q?TBnLkCjs+5qrYP1IMHljtpPM6sU807jCkWKT6bhLhBVNctVf1+zYWOIVaWEZ?=
 =?us-ascii?Q?G/cXTGKYOCrbctrULs5CU/TTh/OOj71k6amUCHRqxkUiY4LfBqOaA2uEJUSQ?=
 =?us-ascii?Q?a6K/gu546aYWqbuuECNeLPzBbMuQxeKiX8FqHwM7Hx65CnyOROjrhDgG89of?=
 =?us-ascii?Q?B9WLHqDdyHQfWusd6JMal30cLgY5yfxvKbKOMMdOYZKxE/lLyU8CWv1jcAbx?=
 =?us-ascii?Q?92eakIacKIP+Hto7EulRCbkfsnbso6OdGlZyHoLH5REv88PBA6SE7Vj8y++u?=
 =?us-ascii?Q?CpvNoXjtyw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145f481d-23e9-4c0d-b275-08de75a0682a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:34:53.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlChTX+5HbiitjuYTI887KFd+Qit20GxS7ocDL8RocJGQdTppg117AElD38cGMH7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
X-Rspamd-Server: lfdr
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17276-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A75741B18CB
X-Rspamd-Action: no action

Get an ib_device out of a udata so it can be used for debug prints.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/ib_core_uverbs.c | 27 ++++++++++++++++++++++++
 include/rdma/uverbs_ioctl.h              |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index d3836a62a00495..bfe37a9c8a72bf 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -389,3 +389,30 @@ int rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
 						 U32_MAX);
 }
 EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
+
+/**
+ * rdma_udata_to_dev - Get a ib_device from a udata
+ * @udata: The system calls ib_udata struct
+ *
+ * The struct ib_device that is handling the uverbs call. Must not be called if
+ * udata is NULL. The result can be NULL.
+ */
+struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
+{
+	struct uverbs_attr_bundle *bundle =
+		rdma_udata_to_uverbs_attr_bundle(udata);
+
+	lockdep_assert_held(&bundle->ufile->device->disassociate_srcu);
+
+	if (bundle->context)
+		return bundle->context->device;
+
+	/*
+	 * If the context hasn't been created yet use the ufile's dev, but it
+	 * might be NULL if we are racing with disassociate.
+	 */
+	return srcu_dereference(bundle->ufile->device->ib_dev,
+				&bundle->ufile->device->disassociate_srcu);
+}
+EXPORT_SYMBOL(rdma_udata_to_dev);
+
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index e6c0de227fad3d..bb86d8ae8a834b 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -667,6 +667,8 @@ rdma_udata_to_uverbs_attr_bundle(struct ib_udata *udata)
 	(udata ? container_of(rdma_udata_to_uverbs_attr_bundle(udata)->context, \
 			      drv_dev_struct, member) : (drv_dev_struct *)NULL)
 
+struct ib_device *rdma_udata_to_dev(struct ib_udata *udata);
+
 #define IS_UVERBS_COPY_ERR(_ret)		((_ret) && (_ret) != -ENOENT)
 
 static inline const struct uverbs_attr *uverbs_attr_get(const struct uverbs_attr_bundle *attrs_bundle,
-- 
2.43.0


