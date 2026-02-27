Return-Path: <linux-rdma+bounces-17268-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIOFM0zvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17268-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 908241B166F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 12FC3301BDDC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065132BEFE5;
	Fri, 27 Feb 2026 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HhA2qWow"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87A2882CD
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154689; cv=fail; b=IL4IANCAvNQx7oqmP0jSHvSqvHXiWuP++0kcsoSkfa6n1r+08ugo8Ub0tZXRpqAFNA3I/5/erpOCy+nXB0+s/g4YA2KgRHJFspTEk1q5OTaTfUALxhCW4aCyF4Vfpl2mcwEWaZlUYEutdpTZCnzL+R7KaQhH4OZnfOr9y5yGzUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154689; c=relaxed/simple;
	bh=vaYaBr8ATcfslojqOMTL/i57cac1RSgl71lkgA/GgUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fYNF8DbeJbnTEgDKic9m5GAWRn+/uGXcpdJYxOm1Uz5h6rn3t+vTTfujeGGPZjfygQ77/Mx5PFnC/T1fkPcpO2dSPYZTpA+UwtsxHwJ0vyAuMsEee7zRF0DUZ+AIruoEIBN9JTLxCBuJRkfyOtl/dICjbolyHzi9ivqi3i2Ol74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HhA2qWow; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGoyIBS1W5v95EJB+vAegBnN1w6tOU+5UHI8PCJr9CX55sXkWBesleJIFXmdxN5YIJzKwXsx28eG0QW+B/rkNhjIrTALbQgqWqXtf8g+yA4pD70rzCd7MUl1/1EgAaKGlEm42kPgMIaIO4UelwudBxk7nKrYYGwus2KeX//aRdPjPO951MdJDhmpBo8e9Vd99eZpbYb7sb9aa5mP8lELtTdAnb4ZaBs8TIMb23eskep+hvZB1+jFvX1AYUuysbjfWotYfipMH7RsTDax5cVmZuZw5ER64UuWF8Nl3vWpPtC9qeJ+0GYmMkulVzowIMGXeN4CfUxZzSvyokC1t//2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkPr4724u5mtkblept9D1ojZrt/uNT2baoN0uwva8rk=;
 b=U2RRgqVvhILwiaYRNUvEtIkOMD79EIg88SSzcgLdiCqPT9f0tCUHIrVHOTG/qRd4dmyWqAjYv6hTQqE4B9lCT1ddvjqjoDR79KCbt46XZSJhDO0j/fXV7b9MrPv/G3WwIt+VtuUq/NXxxhXUd/QbRN+ys3tyo77aU01uPj9D9fNBIJkf2jU3N0MoVZJT/k8bSAoFreWlGHbgnkKNvUBiyK7g1c+ZpotIkOoth8OUHU/H5dZuBm06SYavDEaPWqNI/LCB812w91DDPD2O4skBPsvQMClQ7BghAGzQrI3b7UbsLybgjcJVEhoApkRHRU6ccKImxDZmxC69OmLm1a3OWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkPr4724u5mtkblept9D1ojZrt/uNT2baoN0uwva8rk=;
 b=HhA2qWowCTt14YpXHQq4qXkmO1RlMacCAODFC03dE3WXZLSS/uWrRk+f+8wVl1L+OqP0o8OzLdzL/5vXqubwekwsEzQNWx+rgF+KG121LaDWWQib6bjl2HxeMqq44xOSIC8louyfu7g+7+AUBixWqgax3umoUERs10MkYoXDhffZER89SwYBpTxwLG8Dg9u5SuKFMv5GAFr0/kgkUjhSZWIhyJng/WCF4wD5enT1NRUtclGf8sRd9X1ibqiFJCqeY/njAXsfY/IkE4jKDg0VOK4fu3Q4AwscCp3MqgjC/93rCizPbXODNhJkshFm3mL+8RgfF6HyqvIQiGr45w1HRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB9459.namprd12.prod.outlook.com (2603:10b6:610:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:20 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:20 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 03/13] RDMA: Add ib_copy_validate_udata_in()
Date: Thu, 26 Feb 2026 21:11:06 -0400
Message-ID: <3-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:208:329::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 860cd609-a665-4be1-3ff5-08de759d1c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	S+OyP/6eB1J21uwsFow3bpT/nA4h5S43cqtVpMauY7c+gIrHHo3JxbiVBcwxcFyF/Y01RlHaC3Mw743RqhimKMU8r+aV7hZP98D8IUuoD+JlvfdFkfQoPd1q/kEZ3J0ZLd0HWMnQwMSi8F93ZIsjZLWKBDk2yZ4obOCxsv4AljNwdgAT9wxfzpIgOEoNeMiSQ+QOTAzTNU1WHBhhKdDqWNH+kYi0W/dIc/DptwzgdGwYAtXJ1prB9akT7klkkmAeH47zAaRa3VtLFp56lpSRLu19LkybKEltWDBDHYWJfG8/jNm4VccYH6x4gYF0njVR8gx/K3iCsp7b1WDwker3CwVqLn8laImG8nxk9w5Hkf4L0EPee/7hEAKlAAYmYJFtqa8um40PK8grri4SfmGkgzooxXEzuQA4NmfPQUnvgVLRUav1eCxqUllMaRSk3xg9eg5GLkcLKrcz3gQC4Mh1IWKt7e5Cy3re0KpwsRyh5ZWisSetk9ApCR0GuIHOJJ6d4FvMeYp+i4pjHD63sUniIJa+nsidqo8UNZjAbauT2jteV8tzCkODl03mTxfgQ7FwakJySnCWBbR+6aWpIDrccMttpji4aLqkLmOD3+6gF3kvGNyCa9rBPAdq4JSV6Uz9bZueK6GNbeMgeEqLiOXEsaxwO3ZCiWX/vS1N8UFviMTcnQrnWl08y+qQ9F+oAHqPstevB29Cyt1WtjrUI/hgT4OzIZXaZ20P4V4/wlTw9MU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3VCjNCneae/hH5JXgEj0XoZ5s3eAWZ9UMAfnOEXPoiJbkK2LjToz2fVoGHL?=
 =?us-ascii?Q?cRv4Kyg5KURs/zUhGhwGVchsBgO+sudzkRDKmhXWeCmofJC60rWaQrMRqGC2?=
 =?us-ascii?Q?GI0IwB27t3YLQaubM8oWGtoQUqdOeMlDydooGsXBVy+U74AcCc4ulBn3kfZC?=
 =?us-ascii?Q?WFLa74IN9uh0Iq4UCt0PTOcL0hIAzrq4WF1gyDTvbWHyOCqeFYEGZREh/fQB?=
 =?us-ascii?Q?75tiiXSJjJpH+yvxlZdtYeSZj87ib2R/gzPAPV8e/0+j4k1XVrSIswbLePmO?=
 =?us-ascii?Q?1CQbcHt7U4SvmM3ZHlfGA0WcOuN5Xfh6yq8vGTui6yMNbjgT5Uqjemne7dmq?=
 =?us-ascii?Q?NHJpArN9T0miSOZfLxht4Eb7Hu8a4dMKiwJzVWtIoUA1dLGxHxr3CIHCSeNI?=
 =?us-ascii?Q?K2APt+W97NanRK0DLTFhsloNKX6hqM3z5+6luckHRmGomaiherqlIavf7Dl0?=
 =?us-ascii?Q?hypuJ7vBjw+uHlCqrHo1iEKwHt97cMXZ6ZaXJBgtI8celYCdmIOYHjpEdhUV?=
 =?us-ascii?Q?fZBZ9VvgJWyWJB7biUEVQTYKI+2AZ4s//v59WDBX/tMlW40SUTR9mHgNxCdo?=
 =?us-ascii?Q?TFvSTQkOJiHmhOGq4fDzHGV9rI6IzRGz1uRP9w5zBoNsLRD0JSUgd7OCgDol?=
 =?us-ascii?Q?+lpqkrFBt5qG4deZf9e0wxYZ8ml+ve9w4FS7OueWwmzIqdNej7rgoOcBWe0O?=
 =?us-ascii?Q?Zz5wN0lRbhNiHHSO+TONOXyiYk24oPOLP4jakqc75d5DRPyeJpoEjjJCCM7Q?=
 =?us-ascii?Q?o3QzsuLyk2E1rVlgW9PByDfuFYOnO15TpFjr9AIi5qUv0OdT0vW1k48pl3Wg?=
 =?us-ascii?Q?D+1stMpmqc/kJVxDA9OD1ambTFi5YjfEqFF9raaSlYtEcYwNZjUW3eV/Un5R?=
 =?us-ascii?Q?dMBhWwYhqybkPnVFusDO2lbJ+l12dcS7BCID9jYRYQyVXbAmigu/xkM3PrkC?=
 =?us-ascii?Q?DrcD87CCJGg4muQ4HFp0X5ut2gsSfAUmFVtZcIEI3IE4Tli1cPckxMU966Av?=
 =?us-ascii?Q?2jlL3Ai0wEnyZnKzuy5Ym51hwUTZ5ThG7U8NTzPRnM7rctfDHYej+0RH1YlN?=
 =?us-ascii?Q?BBL66yKbgYnQGWKrwLY2gU8qmCnB/OpPmHf1m0NWXCHwDIdnCyDeK3WWtgbR?=
 =?us-ascii?Q?978bstl8vUurGKYtRDnmqMDzOX1PUzY2wog8kkb1g9HvD02SnRC5LbuPG6j0?=
 =?us-ascii?Q?OofXRD+FqccpFjvW7/g0ewbk2XJTfGs6NbTftqfmTnvDkSefwxCb1rSYjpM+?=
 =?us-ascii?Q?3+VE+w1pnXo3Z7Z2AqEgtyoFWS73eiv/igb+XK8xydpm1lyd1uAMg3IBZmKe?=
 =?us-ascii?Q?5DrGWJ048sUynU403Ty0TH6a4r7XzScIH4YwYpxF7bUOlnuk0uEqZdeywJE2?=
 =?us-ascii?Q?Miyt7bVyPAhseidbet3QupQyx95N4ObhEQTfIuTwt7JmrFeZkf8k6r9TBWiE?=
 =?us-ascii?Q?cpVf34+8+2UFgJAdcXhQhpFxWUngZT8VOy+9HmPY6svLTAfBuY4TcEwQCLha?=
 =?us-ascii?Q?O2UvvPuSTLKLg3uYWF3l/lKTOXA4/61dwEwAxPT56NGkQGszLdVr1joyv5nL?=
 =?us-ascii?Q?bMZh+vSBJ8dEB3aOZjqtfJOV0DeqnIi3GR9C/DzY7zhX5EbHMk4dOCF6pahv?=
 =?us-ascii?Q?eqe5CElVRRn8X4xwcfi4yxBHnnuZqJTZ3YTI62U82l+8C+faNZIzx9gpNQ8O?=
 =?us-ascii?Q?qjLYvWzo4YBGLAEAxLTdiEIwkGRTTCkvHWaZK9FgpYay2MxJ4yagoeFiAnr8?=
 =?us-ascii?Q?CAJDcjrg5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 860cd609-a665-4be1-3ff5-08de759d1c6f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:18.2950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LofdjIBF8t9+tbCTrgZN8jtY7+lEWXPNCJVoH9czBlT/3JcbRvLm/Nm7EL6D6jDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9459
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17268-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 908241B166F
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
index bb86d8ae8a834b..5ea53a49b7c6b5 100644
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
+	return -EVINAL;
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


