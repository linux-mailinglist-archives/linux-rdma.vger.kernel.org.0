Return-Path: <linux-rdma+bounces-17428-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBq9F787p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17428-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:51:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B771F663D
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E2653049318
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71537C91B;
	Tue,  3 Mar 2026 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aYD5Jqwq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723337C910
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567417; cv=fail; b=JnXdhL5hnxz78bSNgj2HYtIrKiRnaCn8wd2l1Ywj+mSxyqnt2FDHtYIhMyCLf01MnxG6fDbMWV0XiYQ/jkV6192vBpTuw+GpVfeR/Rr3rPOWlemU0xsqAdiW36arldM+hAE/ZIFup5LKnCR3/3e1MkvXerSfrksoRUow6pOtSjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567417; c=relaxed/simple;
	bh=CtFmgAWmO9LGX+UGDIPJQWU5lfi03y1AiDz9p0KS/po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fX+ryZjWwG+pbdWQ5Q6n0QJ44LeBTNLlbEBdcz1GnBofoaEN4izyjIOErdRTHqsYAhl5KSlnbamhDm5UOOeitpRramnsXzjKSTLwAIFvh5Cf2kSyDDueMHK52/xC7KnjrnsBac1BLCiBQhCmFVS4ACp7N3bg0oWayNypoJBF2ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aYD5Jqwq; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdNttThgtDmaWlQKpcPEryrY4o/1Ge1Q81GvnZFgDCPD2VuwGx/GU8+g2PvJB/azoqvZMvaBbzaoX7EeTbrjjfqPbW7hGt+vg4ccT62RSWJPZgrPwh5A5niosOT5hw/cQzJqluuhRgf/91x1mQsgoiWAfzJxzQCwVSFkK3VOFqVaOytyNdleVXZcAHUq84LobuPJvnD4uKs+kvgtGDs0/vVX4Ro9YNfbHkY5u42Ox31VOZEsS9CCFJFDMkkhN3eJTdA5IwFo99RbpuxshGBVmpWgL24xZLRlR1B0IiYp9GY+kOUucTyhNVtfaCUmXt13k7uaxGnQJ7sKGCJmMl7GYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO2iv/iVKLb4DXhI/+ILZpsDRGTEaCkgl+P5SzRr7vM=;
 b=h7RetUIQRRRW0MgEUOgissxmonUAoexiLyXISw9GNRw7wZDyLuE4UChr7xr1328gKnHhrUZcO2rwyBxzG4bXNyZJHzL9H11A/QU5UxnWjqznC9t6G//iUpCwyCW39yhqegmC8tm+e89r7HlddvxMOTCEUvbb4+QoQJIDoF1rl1HispOKHuQEAwclDWSppXvLzauV0hrnHpkL90ay0jowrFMT3Xxb7c+P03lKYPyGGtDWCLIyxro5SRq9d0IaI88SQkij3TxjIarvclG9FsYQ05byKVRwwknIk24jAPzpPQybiJHOXcF0jblqxNqamynpUGNHSWqiT8XB5C+rwZtR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO2iv/iVKLb4DXhI/+ILZpsDRGTEaCkgl+P5SzRr7vM=;
 b=aYD5JqwqMNzZO916mXmHMtna56r+QY2Czx6onisdSlQb1gGTxgrFQeQaePjEU1OT93vyCneWtjLJIsldgKtqa2otq7sghFCOr7uQuSVzMoRY8Sxps9CSoAoE8L5fbYLjAApTuDLrH6cc8xnjdlB3R4ZUpssaUgQh71PBxitVvlZD0XH9mPpjcc0PBkk7Iqlt32GzapW0zvEmlKrMmnfNGtKNGWd1NcKW1X/yENO95l72zG5Sv5mXC3VNODedbABh9j0V4THYZGegn87PVU2WKUl4ft8HayHe8vkrWnFURjbHfcSC2vesZohZg0uCpL25rmzi8qwHlNSOapgj5OhCMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:11 +0000
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
Subject: [PATCH v3 02/13] RDMA/core: Add rdma_udata_to_dev()
Date: Tue,  3 Mar 2026 15:49:59 -0400
Message-ID: <2-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: a26d93ac-849d-41ed-4579-08de795e1477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	7Q6ROvpfoBkDlCK5UK1z2GnCxdZsy0I08S9D34V6zksL5z5rN7zXUmcQgDMedzAYlPkCILciOUvSOVaOr7V/MnZUdJ+AkZJ9p7jrpWNAEsAVcoPVKThLC1VkJLEUJkdjJ9duSA1nePNnFw1EISZqdJXkMs8gim1pKxOv3DrizsuTy7kdIu2Y07+uavXLD2EHyMf5nhhQYQE5Z86U+CletAys+OUtEGrPjF1jJaw3qFo7R5esYYmCL8/22eWqsilOFfrq6sm+VQkhQP8fMVQCzi/XQc/Vv11HZZlD+g+nSmotrgjNYxzStSaDb2X510zyZHWZpn7CHWt4Y7rEJtgKjEvfpVJaSR0EGAUOLbQXcc/SDFA0yT1w7O6lYXAikYLHN2Ij2FL0Xk8aIVzeI9ftMDUpIniTNdxd6OnIi8h2/u2sHBmc1KK6DxMoAXFSQxoJCsyZghVkoZIyv4Z5Hds2GND77/ycxwcvHpyFDo9f/HI6XoQqPO/l23FpmKSK38G7SyGXyJWouTQl1I7uLYXFp4o9q7GDYs4W8BCxMYKoLGhF46pQi40uihwNpNMNXSGgisOGEVWi2ZyHvtK6MQqdZsze0k1JeJwL4YgsiweowWxEcpU2VUeZp/PH/P6jVRGOC9Fz4kI3Gjk+KmchfCUNSKOaWEoXVhrxIjPEXbW9iZ5umsXx4RwwT4seeonO5DCAh5+H9IXqbzd4Ow6Fg32x0Ht9Vqq8G0VWoIAwkbDcp7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3zvD+W2v7WOaWQswJdFfqA1oyF6eB45ujQrt2mV+8j+BT3PuoM/5KH8mH15D?=
 =?us-ascii?Q?Qtq/376r/GWB/7K5XUD1a0pPh0KQlpTfsoC0AVqO4ZzzP3ZwzrEVbKjYN0yT?=
 =?us-ascii?Q?RphBLrhygI67v066oueRhYsMqPWGB6inEIT79Ztlb0zd6HFV9AVu3uIPJ/vO?=
 =?us-ascii?Q?bgNmOYxr/rwGkEcs8Q0oOPFkj/Da9yRFg7FN10hDfZgSgVvbuoH4FOJB97na?=
 =?us-ascii?Q?q+Y3wCFXWHTeNMHoFOqAOzyK+Q5CpJsp673FAz9zcPsG2slaNV/JsBsZJpsj?=
 =?us-ascii?Q?6FdPoJRgBRDq0/Vj+xM4g1ePzg4HSzbpmGjG4V9AKandHEK5fiopfMd6kom/?=
 =?us-ascii?Q?qSrrawZWd9p447riEE1MXjm0CsecXRu3/Si5bX3al4LMmmTtXSve0qvEat/j?=
 =?us-ascii?Q?V7QtK/u/GRVyvo/OlvGWjPFx5x7G6bE17QSDKxwhM9qgx1V61QKJbhU2lzMo?=
 =?us-ascii?Q?Yf66oHLnNuD0BGzugEYT8BUShf27q7Ibvu4KdJVklkkkX9OQTTSV1JuFu9gl?=
 =?us-ascii?Q?/xjTNPTJqBZK0lJlR1ryOu6vJMmXb22eJzOmLU3PiOMH1u9Na/1JO0bnxdZY?=
 =?us-ascii?Q?4+NxcD1Hgp14r/iBZ5wR3w/TruVpee94Bt14Lpk9KKmwi9cc5gs25gKnCkaC?=
 =?us-ascii?Q?GnF6+fExCN7NqZIU2Uvu5NS4UtLCVVP705LL9wQILh3hCpIjSpRMW6xBeT2/?=
 =?us-ascii?Q?/Mff5JQPEx6OVxc1Q70PSC4RePrnJKR9qfaegeDbjwfnLS7MRwu+pX5h09Rh?=
 =?us-ascii?Q?1GNrlHGq5X0T987eXvAt66RyWhTYkg3ChR3hX8L4pkjALEuxwyGfxaeN0c2A?=
 =?us-ascii?Q?HEijeYoO872n8sFdgDbLojDQVmcgMasY1aGaEFXqpdwvWlGIBvKGUWBr+49Q?=
 =?us-ascii?Q?Ttk/pmBZdQ45fg+gUDqmtLcmpOqzQAFVi8EdLn6mgfDwQAMLXjjxxTbLRBCr?=
 =?us-ascii?Q?TaEzZ9jmT3WpjtYr6aUNs+D+Q++WODuoY+b6vuwipeA1w/qA0ZHWmNKGR+WR?=
 =?us-ascii?Q?PbLnq3jctycfamnmpkfOXnPT8Ta9Jq6PSOol2mZ5pipzs4lXjE0iKAUf5AdX?=
 =?us-ascii?Q?hxYWkr+PT0UiP2qmpXkNSFyj5KsE/f+JfIeJFJm32IZ+6d0Qo/mspeGue9o1?=
 =?us-ascii?Q?YlGP1LmipHAY6l71204sZixDrl/e++kd976sfpSvrOKj0scTScSb/eHHTaU2?=
 =?us-ascii?Q?7RxZ+zCB+gQjv6yGjZ8/b4gbY+clvKKhsonMCtni58wedyrMT+K2K3SzDoFH?=
 =?us-ascii?Q?2DvUlVj16EkNBY37AeFLH3CGCKOenXMrgMMbJLkCThngz7toXJfuf9fwLDPF?=
 =?us-ascii?Q?dYt4cEkTKyswr3b8V2gPq6YXkZPACv4Tqu3PcKzPbz63fgAFNG/XaAdEGb0o?=
 =?us-ascii?Q?RvtAyPoEUilMMLMFCqNPfWgcj3ZTo8GIy+4Hq28ZWu7OxUOXS875UuxFoPsV?=
 =?us-ascii?Q?Ht0VUjF3/fzbleUoGl2e0OiTN2cBVhwXA4jyml47vIsS26uKqjPmY8T3Cy2g?=
 =?us-ascii?Q?BLTmfN0Z9oTMsckJjmwEuJp+1zSJmQQcloL3d/k7cIH0y/j3TLwlf8BXZqXY?=
 =?us-ascii?Q?pHhHOde+iJ6fcC0QQAWx8p6Eu5JlMRy4aT9V4mXFSzPh+hJmW54KEDrLE2aJ?=
 =?us-ascii?Q?ixCG9J93Uh9Ig8PhXkRB9ojsX7y+Gmto8QLHiRURgnNZfPeeptgBq5hxdHls?=
 =?us-ascii?Q?AUSLhCScRH5tHXXhb7qt7i/dWlVcA504LqSu3EMmpaDo6CnbMENkarXc/vSW?=
 =?us-ascii?Q?2e8R89Casw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26d93ac-849d-41ed-4579-08de795e1477
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:11.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1WPPID22T/JiEDOsZhkebHfAE3oRNha+X/8rNEzUNDaC4ZujzBVE0wJUzOty1NL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 20B771F663D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17428-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
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


