Return-Path: <linux-rdma+bounces-17434-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gANMMI08p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17434-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542451F6720
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAA9230BC59A
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD49384258;
	Tue,  3 Mar 2026 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dIL+7LJj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1537F003
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567426; cv=fail; b=C7cGxtQk+u+ZSDPOW032S6e7mELQoWpwidAff8YLMYQ8Q/3xXd99y1zHIOuOrFspFdBUDuIqgQ/UulgcFzGgmWqy/7dvxrb+E0sr4vX1/p6woz4WMdm0uueE/7+UE//JFfcW4fo4o3MocAoGyv1jJwxmImIA1mGA/vICZVpR0bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567426; c=relaxed/simple;
	bh=FAYkiIfdIzebDGq3DNmW9+v/TL8QzqBri2Op2oMSO9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqojY1WrvEUwpX/cFiRd923E7AUY9TFrNs1A1OVr1W+1bh90NOXZRyXSLiTfET3gGdSOEQtQLFEPpATyW4wJ7Oe5Ii1MUlxpXhfM7wJUQMBiPAqR7BdxwRIpD8ZUmGmTdSk64EjBqkFtExXjU0alC0Jr+8zZqVvfyn308Brsv1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIL+7LJj; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2eGRNbmXTp0ggUgDm21MPvCnh+oaJ3IuDzEYJDggVSeMJKif8vGgHCAHu5mhau5F7mYBj5HTttLBl+PNz5P5iyyMk0SCqobgGKwUjTtnx4H5B2pyXziITp4kXveNGM1gF7E7KBzQ6Ll9fGPuG0fcNGTBjis50SB5Y9HpoFw68P9GR6XEnxc8tjaNOmOTdGlUoGl5jFKU1pF4O5L3cssfhYLrVzF8pOuCWpDKQvXILltyzWU2XkwKY2Fe35ekKPvlt1yQH9tqt1jTH62IVjsDsKRt6J4dyMIkMb5jXr13FNjgcPxpGODPsi5KbjEyuar+K6Wl0PvIqRS0WESpf+f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6DWt1Q/thDioxfp3zxdnHm68AzIx4PQ5qxx4CHoVR8=;
 b=sfuyoJ/pR+7t5jdBNBcc6+5VK+B0mJtZN+cEcviDU73/Z9B/DVvgSsZQWA6BkNo9kcWtoEwr4yBAznM9WHseaw4dv3zhedIgkvF9V+fpJpfpy6YVm1eKNqYBKHpP41V4qZ5q1DtvxHifk0BEgq0xFkm6xTCMs0WHw6JuF3rYfX066uql63lqcf/uS7U3sRy9gQpHwxPRC7k8Hm812/v3Wv+Sbz80SYDQspT3uBpaXshqRGX0IwfNlin1BBzO6SBXj3fSeE7pf5abnkuGBajOVvwBAFTIK+UnlBmRVbANMFUaq8TWh6ZCvOAXO1HW5HrWWPXXzjiEhtg6qX3DkKPfPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6DWt1Q/thDioxfp3zxdnHm68AzIx4PQ5qxx4CHoVR8=;
 b=dIL+7LJjK+OkP1Hb02fAsqtjCSsd/OqRnjyg6MoxlIqKdxmrKc3U8PX5LVYIxK1FWdWqK4BecheCPz8dim8Q/dM749VfFLkQAfBJVQEKbLjPDZLfBOdZBbeHoHjoHG+xfgprltvrenmVdCgOqK12gi0/0q8nXOaC15cY4lPciUTbTl83RGuUFLVRFmSyTX9o3etxC73bkA8NRjJMTzog7j4xV/+4VjsrXYfWAL8G/YLqp9tXoDQvk+euk25TpyNPr54QjHD+xkL5uQiZS9/7xW0GwEgyxISrzdFVTmUU2DUwMlLXgRJsuPrBOc4Rx1z+2cutSU1XceI9puKi+V5HTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:16 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 05/13] RDMA: Add ib_respond_udata()
Date: Tue,  3 Mar 2026 15:50:02 -0400
Message-ID: <5-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: b952a060-8ee1-4023-9c42-08de795e15b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	b3tJ526waEA0tIS4iOuaVIdZhJ2MDPeHrkyIYt7ZlUoe7u9wCGg1d5b8lSdU509zDKP4OxjzmNHgeF7cLYsEzRG31PIp8A27VxNf2z0ES125JlnLvshuyvz/H/7WTMOIwb8dx2gHDxdQqoLizId65neEHJISDmtEKRSb8QhxvuFcn0pk6vooJoXghBA6YOI+Lb1xnH4a1d6PQVfilNAdjZGjQ1Rz5saYVDCclplDV6F+EH3zYLBW5A/3phIe5RsK+Uyqspqi/Hwe9xIz+IgyjV2P0xDgUOEbTmTn0iahb1WKVRdNhLLYVXDLoNAAvwuCQq99QxYHRP6wKtvvFWjjVLgEzKNmtlxIQVMH2ScazGPKelMtmadY5iy5113ACrvHn2tldZHXvmWw92FWqqAQPsfxDRE3UAK5ffZxUxuzFRsCQwSSbYvPftbgJUIDRKUfzBQUnaF6eFFjvWzHewuGBDYy2k73hetuWEbDQ5c4eR+1E+Sgei3ueFTrl7xyzLaZ7rL1n8C6lXGiDtBi5q9U5oGo+27LCTCZd7uwRxpO/JJ6/B/+iSkJ4wX/qgSDCRHxO2V6sL54HaqtCaq7uCoP73VI05GVucSgyY1+yIda10qb7iswoKxtSz0oShPyLAYgoYkMxL58QrGG4PvSJhLS1zXg7YnnuGex/cmy8sj0tbk+Gg1D6bP84FULW+vv5levr+zFt9SSWVqe6zwX+XN4hmkSzqRlKYS24Eqb6GwNwx0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MrhbXoiRzvltwdNI0Ck73YskRkZw9KPqhcnbqBmUoz21ejBbwiik+MaA6yYt?=
 =?us-ascii?Q?9ZbPUP6GYhhd2+Hgp0a+C2o3ytX6/Frr2bgb/EnkvlKqAu+/uGzETf6IcAdM?=
 =?us-ascii?Q?VmVKzQ8uXW9/P3cBpPscKY8LAu8zsnvy3N68h57yI9uqGyW7LirhjLe6bCJ9?=
 =?us-ascii?Q?Zn2X8j2fyCF6iS/15tarMSlMuG73bW6HifvFEdeL6AE34JIzDYx5DDMKjL3B?=
 =?us-ascii?Q?kqgktafmT6Pcg7YyHrzvqDGCtgWWGocqMjHgrCBxfcBG7uSSW0Oq5SM4nnfo?=
 =?us-ascii?Q?cGb0fGA7WZYdZ3zmBaZI5gTACAEDZLbDsZXnWYTfacG41ENC0xu2BZJF+8bP?=
 =?us-ascii?Q?qRlgbIYGqJuiv5PWKUFeYjiwO9usldrXUd91JYY2+43X25RwA+igO31D6Iya?=
 =?us-ascii?Q?yzA7umBuz8JiR+w0egvkSVrTXTHGs/dQ0C+/F9VcxmP/RKisH8T87nAEow07?=
 =?us-ascii?Q?abaZix32VpihujDZ4o7VEgOxIEb5lU4gin3Okj4rPwtD2+T+tjPlCAwC6PyE?=
 =?us-ascii?Q?KKBMHt+sxvJoiGij+BkbVSV10jkmmuMBs2mVxfHs1n799uo/1itbvu+UixjZ?=
 =?us-ascii?Q?NkpSpdNa0ptQ861Ea0AAuZeuc8j8NYGD54gYy7y/T4ugS+m80scTxs/e5FHe?=
 =?us-ascii?Q?bhib+2lL6sy3rwLnnOO/fDjnTccYdZOPDF1OJgw6DYUrHbto+RRJx9lA8GmO?=
 =?us-ascii?Q?vT4++Z4455i9laTJQjzQqY6VPh56nVupkJbZkHDIXuuFF1y0aiZmjawKxAlU?=
 =?us-ascii?Q?/7SnVF0Z3hF2TZKtQAnhSVdEiDj9dMJdEBxz9e/vQJlL5IfmTLTZohxhRF4D?=
 =?us-ascii?Q?ZFNPBsvY9Nnds8ft6yIHstj768UtJwsK4rGuyc/gmZvf2tjMMMegtLd5Tg++?=
 =?us-ascii?Q?J4F5jCvK1xEjOgfH4ZzD/9g37EUhHImPDOtTAywvvBlnCinGCw2MrBO8bSPa?=
 =?us-ascii?Q?hwWmiA3Hs6PujnHLj+k1cgKb6/pu6dGU9aFYqrIWej+Ge8LA9cvUNiUj0JMh?=
 =?us-ascii?Q?l0Ye6ZHia1bHEHei70GZF2jGCPesPz5ywMzP9vv9ef7xMKRBMn01jz3V05sr?=
 =?us-ascii?Q?KY9JsK8Kgkq+B3Qce7XH9vSj1Ycwf2FYHu0DWw/SFYKlmbIpxftz9pzU49uv?=
 =?us-ascii?Q?IyuVVXONC2h/0uUEZnDZWg6QvRwwMEfY6gE16KsWSUh22g3OnoXCKArxVRSV?=
 =?us-ascii?Q?wvpCTYxkLfVNlsoKKwYvVel12VBOCUT1VZUdJNNJRCRaBBkWQd0JrWerKBQi?=
 =?us-ascii?Q?QoN/Je0LueASXtx/Kf0hIm5r+n1+oW6zu+WYxHOLnziw4NnRm1fYfR35LgOb?=
 =?us-ascii?Q?nr9mnb9wE8S/KUvuNqtqsGaGSZ/QnxXq2vgXQZsPiYAp3BpO1AvrnEluRr+b?=
 =?us-ascii?Q?pok1qhDyQfdTXOziv50bR8BLV3kbucbMmpqfcqpCmy6LMMmaSzStvx6c28R8?=
 =?us-ascii?Q?GeQvIRk+MSlb4o2bvqeo7aMMN2ohk6A+CrJBKitpDGoZZlLu8+u/y7JFLM+0?=
 =?us-ascii?Q?dZqc+Ts19MflKIb7gwcApTEmu6Qc7ivYUsor5xCqpyaPGoLCpsQhJZV1SG80?=
 =?us-ascii?Q?cUvAvV5mXfa48o5SpoxMi/ASj/l1r0aRjA2m5gyn3GZZFpM2Pu9/cYzKiOGG?=
 =?us-ascii?Q?X/CfXkQXNjNx0UgMU6Nxw4BcuC5vqlmgMC1eg+kDdT2ZFUiRKI9c3zPaKRMC?=
 =?us-ascii?Q?oztz9iRRDPBpEGazpdCArYUGYAYM83psVXDNW68yhOVS7Uzntg3mUZ5UpqwX?=
 =?us-ascii?Q?gD4UKhDDrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b952a060-8ee1-4023-9c42-08de795e15b4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:13.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC+aupc068sP3aL7lxtVh+IT0Uf3EH7XCJxAlVqXwpc3ljL1ehrnUfehfmphwUHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 542451F6720
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17434-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,broadcom.com:email]
X-Rspamd-Action: no action

Wrap the common copy_to_user() pattern used in drivers and enhance it
to zero pad as well. Include debug logging on failures.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 24 +++++++++++++++++++
 include/rdma/uverbs_ioctl.h            | 33 ++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 5e5b00c6236fa8..b61af625e679b2 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -910,3 +910,27 @@ int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
 	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(_ib_copy_validate_udata_cm_fail);
+
+int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
+{
+	size_t copy_len;
+
+	/* 0 length copy_len is a NOP for copy_to_user() and doesn't fail. */
+	copy_len = min(len, udata->outlen);
+	if (copy_to_user(udata->outbuf, src, copy_len))
+		goto err_fault;
+	if (copy_len < udata->outlen) {
+		if (clear_user(udata->outbuf + copy_len,
+			       udata->outlen - copy_len))
+			goto err_fault;
+	}
+	return 0;
+err_fault:
+	ibdev_dbg(
+		rdma_udata_to_dev(udata),
+		"System call driver out udata has EFAULT (%zu into %zu) for ioctl %ps called by %pSR\n",
+		len, udata->outlen, uverbs_get_handler_fn(udata),
+		__builtin_return_address(0));
+	return -EFAULT;
+}
+EXPORT_SYMBOL(_ib_respond_udata);
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index a73016a977a12d..38a11bfe137430 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -900,6 +900,7 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 
 int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 			       size_t kernel_size, size_t minimum_size);
+int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
 #else
 static inline int
 uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
@@ -964,6 +965,11 @@ static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 	return -EINVAL;
 }
 
+static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
+				    size_t len)
+{
+	return -EINVAL;
+}
 #endif
 
 #define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \
@@ -1069,4 +1075,31 @@ int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
 		ret;                                                          \
 	})
 
+/**
+ * ib_respond_udata - Copy a driver data response to userspace
+ * @_udata: The system calls ib_udata struct
+ * @_rep: Kernel buffer containing the response driver data on the stack
+ *
+ * Copy driver data response structures back to userspace in a way that
+ * is forwards and backwards compatible. Longer kernel structs are truncated,
+ * userspace has made some kind of error if it needed the truncated information.
+ * Shorter structs are zero padded.
+ */
+#define ib_respond_udata(_udata, _rep) \
+	_ib_respond_udata(_udata, &(_rep), sizeof(_rep))
+
+/**
+ * ib_respond_empty_udata - Zero fill the response buffer to userspace
+ * @_udata: The system calls ib_udata struct
+ *
+ * Used when there is no driver response data to return. Provides forward
+ * compatability by zeroing any buffer the user may have provided.
+ */
+static inline int ib_respond_empty_udata(struct ib_udata *udata)
+{
+	if (udata && udata->outlen && clear_user(udata->outbuf, udata->outlen))
+		return -EFAULT;
+	return 0;
+}
+
 #endif
-- 
2.43.0


