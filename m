Return-Path: <linux-rdma+bounces-21263-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PLYDv31FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21263-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A926B5CF6D1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B2530182B1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AE029A9C3;
	Tue, 26 May 2026 01:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udfQou4r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA332989B5
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758585; cv=fail; b=kV0sxB+a0k+IVQc2yfiN8t16xQwK9cNyePLdlfeVwtHrOITGLQWk0Jht7T49obasimVYzETqlKqitUIQs/YuB4VhESp0kUgbLGug8ad4B/KD7toEv4hy8GaKFuORZmGqt/EinIrMm2r8QCK+mBwYobm6Ia/D8I9S5Nbi7vZBJpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758585; c=relaxed/simple;
	bh=PYHvaWKVvFaBZ30OeI2eXzOPhNmdm5rTAikc+h73848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/5YD2X3UK21yIZjSVz0Bpp3hSfDt+qmFiHesl0rFpZ9mNutxOm8S1E4YzKRbWlDMJj4YA2F2Ov7TFynwl3d9y3VgsX9KEM1B5ypuBr3RHKVXgniCw/2E0o1/lcrGdEM1c6Gg8Q3dVYXRcsdn+nF++dqjOMJRdYFZ5KPkZIOlTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udfQou4r; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eMmcVdrM2I71yLCtjFqzHefljbeoZUlug3i7QMtFxK4HvIighzQThBg8hU3YqHlbi4BiyUeYBslLjmbRQpen6x9W/f/uSUIBj6TGxFcrTVKIElTK3VMzKBrvEw4dQ4qCPf1fht7IHjuddWmsxD7vh6cX7R1GvDQ4gr1icIa17KZPgw6aIcTewmQ/AVQQzesXHf0a/ODz4TYzT/u4ILY7a8H1B0jZ0ISe87szhtK1C2mHXlDK3O6/jZdjLcScISqLZFY5tGtZhxsyeGKNQLMqYs//QghGrExloCl0Kn4/QrfbuzW5qQ8Pzgtjf5knIC9fqmdOquhe7FgurNDyx3fInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWOs1Zlvt/PDx5x6doE0uW+9Dfzqm2XP+qlf3j4jJvQ=;
 b=ipYHLxL1ONxD3ZOOse5f2mPYiRBpLfpIGXgjHlMOkZyWdGd7LlmrFFmXou38uWJGrvPDsHBTovV70mh7BVeIuljv8pTbFrMYQJak4/Zzw3sgWAIlEJ1OICgkSvOq/tZNUP4RADO6an58fO30wjhewCxRRHkwW+SK1HxcnyTrTkobMWcacpZMXEG60oCIsI5xwTF7JsMp6/1jrxwmr9AxMFtPz0fHedd9i/3aDncsdvpKj0EYvGRUj0RoYe3IooH9Q8JZWaplW+TOPXft3AOTyKg2OYQ3v6xBcLcGl22uwlDxB71nrqmb5HWxWC8ahqwiBu1cfAKqi0qrLZvpZqVD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWOs1Zlvt/PDx5x6doE0uW+9Dfzqm2XP+qlf3j4jJvQ=;
 b=udfQou4rHr+4Ns8Na/L0i6lLTdTr1QxTmdf+kJrSWFkCvdhLhAfUZLueE3smeow0Uy0uhS/o6A2SN+jNqfLiH2Fa8dcz+7Av8FkDMdOLgqb0Oot1sA+4R5+auhmUiIWUP8wpK6dC28xsUA2dJnHBf4+5aG2xDeONus06yKpF4zXgo1LHofxtvQ7asV4SqMV+GSSTFlOh8WMYig2ktBuqG0Xk8JyBw+GDHOEJLQtiNdAOBNhC5naEL4MOXbO9870I0YNSgjyrEDMny2KJSoI2sGrovUH3aFrva4B4L+E8prtEXlKYxoinSP5rPl1WkNwN9dQeiu5/07mee6jiAVIi1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:46 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:46 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 3/6] RDMA/core: Remove uverbs_async_event_release()
Date: Mon, 25 May 2026 22:22:39 -0300
Message-ID: <3-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::11) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeda3eb-24ec-404f-774d-08debac54ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wuSHcHGy/Me7Ujd2pHK1UL847oDVUPJ3yItPJjiJvBm8kxT6n39mTv6pu2j7zWEzr79fIZ77umYy/05xkwbjPWXNgjX/5VpQqmHvk+BcFwWhmYvFFGooMNe9x05GCtVwaz/1dgodZ/4KlK3Afgp/j4PtoVm8lKsF5jbaT5WICNZX/M/UWekLAqBd9lWFUoCHAdjUr6E+l57AbWQiGAyf7S0lTGuUOny6ru+ZEYfwgpadwTQYcrGjTF6eYXgwX1IGssvhCtAguW8VRY23Grwy9hZXEdfMxrAZpGMneUGhbxz2G2Zm4EbMsK9USYWTP/RCz0dJ0O/SF8aPKP/PTNE1Lc68M8OSF2E/luuPeW4m73JDo+C8lXl6IJGRXovUOxaiCTmgL3eSKzWumIZO/NZp+F7EhuvJ5jqgsoqiUOkYwblQ+CsGSbMdw1gKjjjjNBhfE1d+Z4nSEqt0RGYpcWAdAa2SUhMb+zd28e637vXZ3VSMrdSiYXesNbD51Ufq3/kLu4L3LWRUPbS8c7JvHqi0iOrxET8mXRnpQWzqk6nj9IEO/EeD0re63eu0TjtugGr7isjWLO0AES8Cxz9Sb8ynsG5TocaOL/TqH6ztrr0W0mmj7B3rqi2zgDaMTuDDoH3IvqaOJ9jdf8WAapQr5XTp/d+MzBuCVVQV71l2w556cZJc3F4FUUrbywAW4pLvHp7R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vrJqEtEaQxdB++SBRwqVNN1EmcdtpAhr4PqLqBKLyG4Nx1uG61N8ZnUvT0En?=
 =?us-ascii?Q?MB+vnjxuoSOV4Jfj6JpZZ+Vg0STFRwDfCXE8/jH1ZeP56VZgdEq1BSTByekA?=
 =?us-ascii?Q?nKPP8LLVn2S5rienrJQX44Q6R4n2+o4AZ/j1LpoCDF8F+vDBMccG2+C3l0ys?=
 =?us-ascii?Q?xA/GHGReXba9JtHSPUjkjltldeJ0thX4cE2tH5TGZaQ6AYGdQz9eZa/Rx5s5?=
 =?us-ascii?Q?5eZWlOdsA1FUOKqu3hoIbkFe9KEqsYHKYQjdxcWy4h3MtrC2xNeczBaSWRSz?=
 =?us-ascii?Q?9HuECEu3Tb5gJvOPId2u06mchideUtK1GJHIMSghyNmC8Ps8HJ2oW8HrtuFQ?=
 =?us-ascii?Q?pLqXxXzWZ8RYANsU3ydnjShW4/9iFMN4uorGic9LgeGTb1iNMSneuvbd2egt?=
 =?us-ascii?Q?26D4zkAeGnPR/BtPI1ih2UYDsLsc7zQDPMGIdYEBF2g9dI3nDRP57grRZYR/?=
 =?us-ascii?Q?tA7MWOqvbktD5LNp4nDYJVJ+w05qnWfRdTrj5D4Dxlg2tqHqj4OKYmG+CJei?=
 =?us-ascii?Q?n9sbIOqJakkfURjJEXGqzTYkkPJvNshZiQnMe6r3c5PMlKcCt6a+JZA5s5vc?=
 =?us-ascii?Q?T5oFinuagjBPG0GVy23IPiBVQmgLW86I1C3LbCezLnj53D9tHcThfinKBICt?=
 =?us-ascii?Q?sJ933nLtNSPFLBlGJTFowD/s2K0ClxQ4Ox39lpORtn8/V9NRY+dK/6oVvBGM?=
 =?us-ascii?Q?Ax50uc1tLQ0hMpflrQNBia+wNTbdaX3c4JHpw+6PdWX9HVpMarzYriyiQXhF?=
 =?us-ascii?Q?aMgf7CiPaQQqrZZKsBf2EnE9wxkylnNt6soUrqjFR0a0FY2Q6tdybH372YNy?=
 =?us-ascii?Q?td4a8L1zAjuzyFLGZp5dt0zDtebR8SMvaMhUq3YzEUtd2o4ejpcCpPgNfJSQ?=
 =?us-ascii?Q?YKdmgbSA9pmLh0ZNd6dR0xZMHTcOH6zrAhH5eOUVKsVdLA+mEwa0NVkiCqPZ?=
 =?us-ascii?Q?AZVGXKBhlW6m/dyMt8fgHWc1hrx9buTpRBjn4juiZNKQIOIHaO14tpEM2hgX?=
 =?us-ascii?Q?ziS7ZCc4zM4QNFtQEhcqeY8zr2XvupgtV9Tc9iGUTxcfkfcEsQpSKNfpOaNY?=
 =?us-ascii?Q?wuzDLrCQVkgzha2r/VDmAorAB+Ny0HE1szikLCBwpbu1ZPJl6205Llt/nNQI?=
 =?us-ascii?Q?6+2CuwEELhAALWRauThNJF6o/WSdneHILAjuRtkIJprl2QyWckKte9C0y5nL?=
 =?us-ascii?Q?MibyLKHdqq8tCQcVj1HSmEgMWNIFxOdHTI0Uam/PzxD1Z4oRbh3aOiSpuDGr?=
 =?us-ascii?Q?MDJTL/ISyruA9v1C6zEyEFs/euBqCHYv5PMM+9mc2Dgfp0V/+rkkssTGuVb/?=
 =?us-ascii?Q?Az6ocU825H9+7mDbSVKzNYyFHfAML2be1ASV/XUS0EzEbih5+ITiMUfpPPcs?=
 =?us-ascii?Q?PGEGyBCxoSVpPErt/CmuSxZiA/o/QoChkcIHb6vWF18mnqs8xazmZTG7StUh?=
 =?us-ascii?Q?gR8NSdkn9QhvWGI7xk86Hty7AuYjwcBOQufsXIQ0gjMqP8A0Lu2ni9w7cvnY?=
 =?us-ascii?Q?Ws8oX/00ABU2iK4KIWNYhiOdocREXwdRK2D5s08sV+LpCtqOoyiRwV0DMUKm?=
 =?us-ascii?Q?OcPRbeVYn4ZtREv6SrRtbhwAXHrxKfbe3CJPl3VQvxPBzxEKX6UephuoI2IY?=
 =?us-ascii?Q?HUk0YAh8sz+yPe3Gp9IZry1+jxcxPK2A+QEDZ5O6p9FEXipDC2oneOfR3+AV?=
 =?us-ascii?Q?VooxCTKUKZPTgdqmltigQXb3E2V64VgjqtxlJukO3+ZXqED0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeda3eb-24ec-404f-774d-08debac54ace
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:46.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89Cwu6szCQtANs+A6GVOR7/vn5yj6fJi7WnTwuNFxwBfkdbE7qYRQkFPZIi8yzcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21263-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: A926B5CF6D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Instead of having an alternative fops release always use the standard
uverbs_uobject_fd_release() and route the special async behavior back up
through uverbs_obj_fd_type ops pointer.

This removes a dependency where the technically lower level rdma_core.c is
referring to a symbol from uverbs_std_types_async_fd.c.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/rdma_core.c           | 30 ++++++++++++++++---
 drivers/infiniband/core/uverbs.h              |  1 -
 drivers/infiniband/core/uverbs_main.c         |  2 +-
 .../core/uverbs_std_types_async_fd.c          | 22 +++++---------
 drivers/infiniband/core/uverbs_uapi.c         | 13 ++++++++
 include/rdma/uverbs_types.h                   |  8 ++++-
 6 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 5018ec837056ff..71e3d58d26e654 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -465,8 +465,8 @@ alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
 
 	fd_type =
 		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
-	if (WARN_ON(fd_type->fops && fd_type->fops->release != &uverbs_uobject_fd_release &&
-		    fd_type->fops->release != &uverbs_async_event_release)) {
+	if (WARN_ON(fd_type->fops &&
+		    fd_type->fops->release != &uverbs_uobject_fd_release)) {
 		ret = ERR_PTR(-EINVAL);
 		goto err_fd;
 	}
@@ -846,13 +846,35 @@ int uverbs_uobject_release(struct ib_uobject *uobj)
  */
 int uverbs_uobject_fd_release(struct inode *inode, struct file *filp)
 {
+	void (*release_cleanup)(struct ib_uobject *uobj) = NULL;
+	struct ib_uobject *uobj = filp->private_data;
+	int ret;
+
 	/*
 	 * This can only happen if the fput came from alloc_abort_fd_uobject()
 	 */
-	if (!filp->private_data)
+	if (!uobj)
 		return 0;
 
-	return uverbs_uobject_release(filp->private_data);
+	/*
+	 * uverbs_disassociate_api() can NULL type_attrs after disassociate, but
+	 * it won't if release_cleanup is used.
+	 */
+	if (uobj->uapi_object->type_attrs)
+		release_cleanup = container_of(uobj->uapi_object->type_attrs,
+					       struct uverbs_obj_fd_type, type)
+					  ->release_cleanup;
+	if (release_cleanup)
+		uverbs_uobject_get(uobj);
+
+	ret = uverbs_uobject_release(uobj);
+
+	if (release_cleanup) {
+		release_cleanup(uobj);
+		uverbs_uobject_put(uobj);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(uverbs_uobject_fd_release);
 
diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
index 1563169c65009e..a1de8fe9c90bf1 100644
--- a/drivers/infiniband/core/uverbs.h
+++ b/drivers/infiniband/core/uverbs.h
@@ -203,7 +203,6 @@ void ib_uverbs_init_event_queue(struct ib_uverbs_event_queue *ev_queue);
 void ib_uverbs_init_async_event_file(struct ib_uverbs_async_event_file *ev_file);
 void ib_uverbs_free_event_queue(struct ib_uverbs_event_queue *event_queue);
 void ib_uverbs_flow_resources_free(struct ib_uflow_resources *uflow_res);
-int uverbs_async_event_release(struct inode *inode, struct file *filp);
 
 int ib_alloc_ucontext(struct uverbs_attr_bundle *attrs);
 int ib_init_ucontext(struct uverbs_attr_bundle *attrs);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 15d8387718c050..a937d276c5c076 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -338,7 +338,7 @@ const struct file_operations uverbs_async_event_fops = {
 	.owner	 = THIS_MODULE,
 	.read	 = ib_uverbs_async_event_read,
 	.poll    = ib_uverbs_async_event_poll,
-	.release = uverbs_async_event_release,
+	.release = uverbs_uobject_fd_release,
 	.fasync  = ib_uverbs_async_event_fasync,
 };
 
diff --git a/drivers/infiniband/core/uverbs_std_types_async_fd.c b/drivers/infiniband/core/uverbs_std_types_async_fd.c
index cc24cfdf7aee66..671f510bca496f 100644
--- a/drivers/infiniband/core/uverbs_std_types_async_fd.c
+++ b/drivers/infiniband/core/uverbs_std_types_async_fd.c
@@ -32,14 +32,9 @@ static void uverbs_async_event_destroy_uobj(struct ib_uobject *uobj,
 					NULL, NULL);
 }
 
-int uverbs_async_event_release(struct inode *inode, struct file *filp)
+static void uverbs_async_event_free_event_queue(struct ib_uobject *uobj)
 {
 	struct ib_uverbs_async_event_file *event_file;
-	struct ib_uobject *uobj = filp->private_data;
-	int ret;
-
-	if (!uobj)
-		return uverbs_uobject_fd_release(inode, filp);
 
 	event_file =
 		container_of(uobj, struct ib_uverbs_async_event_file, uobj);
@@ -50,11 +45,7 @@ int uverbs_async_event_release(struct inode *inode, struct file *filp)
 	 * release. The user knows it has reached the end of the event stream
 	 * when it sees IB_EVENT_DEVICE_FATAL.
 	 */
-	uverbs_uobject_get(uobj);
-	ret = uverbs_uobject_fd_release(inode, filp);
 	ib_uverbs_free_event_queue(&event_file->ev_queue);
-	uverbs_uobject_put(uobj);
-	return ret;
 }
 
 DECLARE_UVERBS_NAMED_METHOD(
@@ -66,11 +57,12 @@ DECLARE_UVERBS_NAMED_METHOD(
 
 DECLARE_UVERBS_NAMED_OBJECT(
 	UVERBS_OBJECT_ASYNC_EVENT,
-	UVERBS_TYPE_ALLOC_FD(sizeof(struct ib_uverbs_async_event_file),
-			     uverbs_async_event_destroy_uobj,
-			     &uverbs_async_event_fops,
-			     "[infinibandevent]",
-			     O_RDONLY),
+	UVERBS_TYPE_ALLOC_FD_RELEASE(sizeof(struct ib_uverbs_async_event_file),
+				     uverbs_async_event_destroy_uobj,
+				     uverbs_async_event_free_event_queue,
+				     &uverbs_async_event_fops,
+				     "[infinibandevent]",
+				     O_RDONLY),
 	&UVERBS_METHOD(UVERBS_METHOD_ASYNC_EVENT_ALLOC));
 
 const struct uapi_definition uverbs_def_obj_async_fd[] = {
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 31b248295854bd..4e2e556c8119b5 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -718,12 +718,25 @@ void uverbs_disassociate_api(struct uverbs_api *uapi)
 		if (uapi_key_is_object(iter.index)) {
 			struct uverbs_api_object *object_elm =
 				rcu_dereference_protected(*slot, true);
+			const struct uverbs_obj_type *type_attrs =
+				object_elm->type_attrs;
 
 			/*
 			 * Some type_attrs are in the driver module. We don't
 			 * bother to keep track of which since there should be
 			 * no use of this after disassociate.
+			 *
+			 * release_cleanup is the exception because
+			 * uverbs_uobject_fd_release() needs it. In this case
+			 * the module reference held by the fops will guarentee
+			 * the type_class remains valid too.
 			 */
+			if (type_attrs &&
+			    type_attrs->type_class == &uverbs_fd_class &&
+			    container_of(type_attrs, struct uverbs_obj_fd_type,
+					 type)->release_cleanup)
+				continue;
+
 			object_elm->type_attrs = NULL;
 		} else if (uapi_key_is_attr(iter.index)) {
 			struct uverbs_api_attr *elm =
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index 6a253b7dc5ea66..5a07f9a6dcd1f6 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -147,6 +147,7 @@ struct uverbs_obj_fd_type {
 	struct uverbs_obj_type  type;
 	void (*destroy_object)(struct ib_uobject *uobj,
 			       enum rdma_remove_reason why);
+	void (*release_cleanup)(struct ib_uobject *uobj);
 	const struct file_operations	*fops;
 	const char			*name;
 	int				flags;
@@ -190,7 +191,8 @@ int uverbs_uobject_release(struct ib_uobject *uobj);
 
 #define UVERBS_BUILD_BUG_ON(cond) (sizeof(char[1 - 2 * !!(cond)]) -	\
 				   sizeof(char))
-#define UVERBS_TYPE_ALLOC_FD(_obj_size, _destroy_object, _fops, _name, _flags) \
+#define UVERBS_TYPE_ALLOC_FD_RELEASE(_obj_size, _destroy_object,	\
+				     _release_cleanup, _fops, _name, _flags) \
 	((&((const struct uverbs_obj_fd_type)				\
 	 {.type = {							\
 		.type_class = &uverbs_fd_class,				\
@@ -199,9 +201,13 @@ int uverbs_uobject_release(struct ib_uobject *uobj);
 					    sizeof(struct ib_uobject)), \
 	 },								\
 	 .destroy_object = _destroy_object,				\
+	 .release_cleanup = _release_cleanup,				\
 	 .fops = _fops,							\
 	 .name = _name,							\
 	 .flags = _flags}))->type)
+#define UVERBS_TYPE_ALLOC_FD(_obj_size, _destroy_object, _fops, _name, _flags) \
+	UVERBS_TYPE_ALLOC_FD_RELEASE(_obj_size, _destroy_object, NULL,	\
+				     _fops, _name, _flags)
 #define UVERBS_TYPE_ALLOC_IDR_SZ(_size, _destroy_object)	\
 	((&((const struct uverbs_obj_idr_type)				\
 	 {.type = {							\
-- 
2.43.0


