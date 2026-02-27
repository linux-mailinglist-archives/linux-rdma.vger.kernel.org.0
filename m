Return-Path: <linux-rdma+bounces-17277-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOC9Btb0oGk8oQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17277-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:35:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F91B187C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 321F13012816
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B926CE2C;
	Fri, 27 Feb 2026 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PTzaH03f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5327AC5C
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772156101; cv=fail; b=OqfJScJx9q+ASHtaB0vyEytpa7wAZku6q6k03SA98hT9sXj0oGO4xlA8Kfr4KAfOHZIHEdMbVdppFlFYwt338QroxCeeHt8p+svI9X+nXEW+Hd+pR+wuchi7ugntx6geu4654EmAb7Ks9jdQkY78Ke5G7WZUpSLB13OcMDHQJR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772156101; c=relaxed/simple;
	bh=X/wTdnE2oRa79VIvcNV/e9WLxQTK8pjj8GgKL0z8h90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVkzlDJuzXpaQq/50TibuKtw+ZkqbQOrJTibCVH2t87FO/HL9FlU4njMJMvpgScJnye+x75XxON7A2lMucRlAtRD64rKasL7t+kJwxPkOIjS0JGVq/WHIDqDOjogCeu9Xb5kmMVlR15BhaiuZqD391BGxSGmjuHvRAYNUWxYxto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PTzaH03f; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHVBw6aTRTgkluBr6vJMC7IwmfgJ4WNpfAXWwfT+shNVmMkbdNkERhI5QJHuPhzJVfIVkkF0dr0gjcVCIOLua6pE9Z9FJR8OoW2s06VbtBQK0sl6Ob8co6EgZIlUP5mJQwJK6wpnQV0rYeWeV/pEd2E8FkoYH3WNWNliICzGJnNfcsNbn/Qrt1WyHnuj1uvjtgo7aMRx0jrljo5Z93LYoWpDZUH3CtouhJXs+z4Ebm7lu7lIeEKHZR4/f5UwzbBSPYZel13uz7pDIf7vyzPhycKK0hshbtgkiiHco16nuT/JufE2MAyNaFppCig3QgaDJz5dEfF1Z0CC3R5/hy46zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnbDNpsTIG1/uVdNaVxwvQHw8ph3nZiEZn33OBhYeeM=;
 b=IEqxeHYsKEPAEHIubqBPVkC2qudoUMuBQEmC4IBSXxQ4tIxWVF3ZzSxYY+tRWfKS6UTxaBfr5OY8oo6jXwKmCeK62ATaZNn8froy+5x3uAlW+3kR69uT5wQ6pwA6IEpWyBJREXUGBuiFmCBV0yqKet8OkpafK0Ky5+4rW3HsoOUfXBEVJ8ilGayLlcPxORyAgQh5iVIAP3CvxQoP7SFbCA9Fx8Fn2BnkF7HMD2hrbmyN4BsdkQ4gLyvlDXDHOwsfcEzUd4R6grDzS8ZTRKPQFsGG3w92NKkxS1lz5TzblhxTBcFlpGZvbi6e5fm+d60DAAdVHuIHK4oG2OaJrINmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnbDNpsTIG1/uVdNaVxwvQHw8ph3nZiEZn33OBhYeeM=;
 b=PTzaH03fVbyARPWvXMHdBLohTTDkxwkGwvdpFOC+CxblZCzyvN+Mnqcyd7gmsUgrcba7MIEMjmovKkPPeC+2a4bIthaXa9kbPvo9lXFNQge7OfY4gCQe6WW1CIwnxduIgKwS4CIr5YsL4KbrgqRT3a+GmsMNw/RQzSH/JLP9oZ36poFGUu5+Rvjoe8N1vjbg8so0OZZ6RyfBOymLl+ZH62w4vmALbsxBLj6xeL7s9QCyCw5mv82UILrdCpOskr5e/x3wMpiXfL1iQNsBwhlA891eHL08XaUgDKxM9pBaujT6iQJZdnotYUbPy9Xc8++v5odDhSRTm8dajufMSxltXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:34:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:34:54 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 01/13] RDMA: Use copy_struct_from_user() instead of open coding
Date: Thu, 26 Feb 2026 21:11:04 -0400
Message-ID: <1-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b552d1-ec7b-43f4-248e-08de75a068ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	7hoZ7k5OVbGoQe7lM9LWwwqYtZiTYoTNlkmtZrb0UyipJeRNgCZESuvrF0XtIYxJoeVhBforKMq54uTXkT0Z7nwgCaXgNIZ3ZMsbpUfRHLQETaI1vw4I3Hl5YC1C3D24m3DZ+qsbAcg/K32QizMtvktTOp+YfmzexPqhS2QcGb6ZaS9v0eWey+MatsK+7DU9o1fUoPLLMOlDUhUoRjSlzBtj91Hs2eiXw89ogHNM34iwRVXQMqQx4jHlziLXW5rmLpYJkeUWWSgqpCysAD8MkEfbK5/dVf7t4wLVDiATJ+NJf6a8DR3m5o92fUEvQ4FygKU0GLcL2Bg48+87h/0ur9Zm4VleCq3GgUyKauAGiLwvm3qDYb9V7BEpu0L+L6R7Qjiw7enBQjhK+9WCxRn+7345PseW2abv+aFz6cCHAdPTCIyPDgzfZUJHzeK81jfTzjVb4VmQFf1/qrYFgOYGa0XFFGRrjmp6LzBlK8Mp/V1kTXwIymdiISGvCcvHmWsw10stVpZPD1IhIQYZzDQ5Lm6i9mVkKOmGLRX2SCm9AqiaUVr0Z21De5I5IfRH7V2jZF0I1H+YcUkJEjYAuPVjfFx5Zy1ZhIFA960YoUdCRtX0SW7mUfnSHI4Wes8FV/smLweGi5QKOrgii2DvFgGXB9N9se51VkPDcEQEZc4aUHv3IuX69AHvGSE72WGXbPxZBhGXyVb0aDpFK3Mj+zUoOKrB5M2M1V2GNAAwHHQsc4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spfZH49GwKJBb3I4EUbXKVxeBj3Xd3NYkjXk40nCmnrlZBNKFV0Wpsr7H8cr?=
 =?us-ascii?Q?K9qPE5dbzziatTerWTHs3ZMAOn+KBsYJ5X8KdbVWXrZ1AvZdTjEJZ015SM0M?=
 =?us-ascii?Q?2sRVnHdkYQUUa9Z/0b4pUTQSOkp/DXofbE7VXtkIgplZsWaT3FcNwyGACu8i?=
 =?us-ascii?Q?V56AgXuCcjBPij3ggEDyKG1uOVvgVi2HzGj6VqeVZ0LHVBwGxbsb/7MWokha?=
 =?us-ascii?Q?PHpvM/vnsVinHZ4T1hL3DSGOyT66WiKMbBftf437xp6KB1a75MDR1NHJ4tPJ?=
 =?us-ascii?Q?3DuPrwBtjqU4kGCXcbpA10IYFPnD7LcU7Ow9Ur38ExzA03xL2w940V2XciUY?=
 =?us-ascii?Q?rt0idGFSD8G+RQOmklCznoN5HhKbQb4agxvL2jzzfAVQTqm+TNwhNuDaWnVD?=
 =?us-ascii?Q?Uwx50ev/5WvW1d0Bb6+ScTixznOr066LsBaYTD3C16WJkpKCysQUDS32Mxx4?=
 =?us-ascii?Q?5IlNvFVjy6+GbVj6al3TikcmpQ0n0tHrIjIYfz8ms+c5QTRqdjK2T2ZHHSgp?=
 =?us-ascii?Q?Ln6nHWFigy0B2oFDT3dkl1EzvQ8jx3mVcMiJpMKhlUnNQ0hA0cHpAjqki/Pp?=
 =?us-ascii?Q?9v69GOLGpCJlT2JcOr6faSDP/pYJGp82WmOE0HTndtBkbY5ofDEaOZV3M3RU?=
 =?us-ascii?Q?NdTXNNJ6R15rZnpz4fN2Zb+KR9yaK5KPQ7LsWmTfpUBaK+gZF2zg8CDsbSTn?=
 =?us-ascii?Q?XLknkNQJH7Y7WcnddpnLRI6aW2DcDZ1Ep1YdDofLMDhwDO/iNiIU9/GSTIeR?=
 =?us-ascii?Q?sVl2Tf0RtCSWiZWr8a+RenjLfUZtghvOtIen4CY/7+kLzdGn62CmMgKkM+sN?=
 =?us-ascii?Q?cxk7Qr4zB4nk0Pad1Yb+mMl+GXcYhPBJS+56TdXzgS74yjCb9M3zhzXbFG8U?=
 =?us-ascii?Q?h1kujyn6LdPWwHJKFNzE/qzrH/50y+vmhwzZ22rc2buqfDceAH4+8HPQT36T?=
 =?us-ascii?Q?zDguEpa5Lq7mD6jOTSfqZ1sTGzXJBx4qLntR9LVLdqCZqaE1YS+un6Zn19bi?=
 =?us-ascii?Q?D3wMaNKff/X387rNF2SQsPMRFAIs5M6OPblNIodDcT5pCxJcFZNpjm7r1ndl?=
 =?us-ascii?Q?X3Jt9limXCms35r1MGeEr98Dhey9jN5Rukufbd9U8C/g6iYsb3V/2ADhzqrk?=
 =?us-ascii?Q?QXJEugvKwrKxUKyb3GvGTqaiv5qliD6ZZ8BzTIt16ZF+6AKrrxv9f2nNyU53?=
 =?us-ascii?Q?WIw4Py2GW4TsSvRN76kkbtsmkU/q3Vj2oLEPSqUwx7qqauxv6u7PaKBReRBu?=
 =?us-ascii?Q?pSuv+XeCvP4l73bpsNOkclxFErALFUe8hh1e/DlTl7mGVuJSZwH6hiIsV3kU?=
 =?us-ascii?Q?GBHXNCROT2IaepYS6ZeVm6JAHCx0YhmlX1k86/RUtc+ckwBHaR3ixV0BXvkz?=
 =?us-ascii?Q?rFzzFit+/RThGRQUSX4FdH6cuoITbkwkec4bIp5SWrEgZvIkulNQDJGg3UBa?=
 =?us-ascii?Q?8m4z1TLuecg1IFULkJ5/aTRONj/GHEnXetk29TXR0vxuNLJTwyWxGI1fjsoM?=
 =?us-ascii?Q?++bWnY7zhluHpVgR7qq+EyfoZWLW6qURcq8+DDF6olzBzn7Y2Xb1lLrDD8y3?=
 =?us-ascii?Q?euKbRfPD5TCjOT+MMlrQky//U4GxsfkVKntlEDlWvZbbzxnp4vVk6tyS37ze?=
 =?us-ascii?Q?A2dnqHkyp1/zNJitkcBS8jCwRsRC/0ogfpy6N88TndOa3/RAHFOPg8RxUD1l?=
 =?us-ascii?Q?VOptn1ca6AMgvsf98D7s8PE3BiZD/qpK3xb7HBBaXdf4Gfi7iPQ0hvRkLZwz?=
 =?us-ascii?Q?sYpkEUln4Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b552d1-ec7b-43f4-248e-08de75a068ba
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:34:54.6930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZWaZSVhAIeAuY2qsEonel32Wut6lmfmUHcpVM5aCmL/2rZc3djfJQKWOpe/Xc09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17277-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 593F91B187C
X-Rspamd-Action: no action

This entire function is just open coding copy_struct_from_user(), call it
directly, it is faster anyhow.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 758ed4ae5f7a85..5e5f049c3845a3 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -83,28 +83,16 @@ static int uverbs_response(struct uverbs_attr_bundle *attrs, const void *resp,
 	return 0;
 }
 
-/*
- * Copy a request from userspace. If the provided 'req' is larger than the
- * user buffer then the user buffer is zero extended into the 'req'. If 'req'
- * is smaller than the user buffer then the uncopied bytes in the user buffer
- * must be zero.
- */
 static int uverbs_request(struct uverbs_attr_bundle *attrs, void *req,
 			  size_t req_len)
 {
-	if (copy_from_user(req, attrs->ucore.inbuf,
-			   min(attrs->ucore.inlen, req_len)))
-		return -EFAULT;
+	int ret;
 
-	if (attrs->ucore.inlen < req_len) {
-		memset(req + attrs->ucore.inlen, 0,
-		       req_len - attrs->ucore.inlen);
-	} else if (attrs->ucore.inlen > req_len) {
-		if (!ib_is_buffer_cleared(attrs->ucore.inbuf + req_len,
-					  attrs->ucore.inlen - req_len))
-			return -EOPNOTSUPP;
-	}
-	return 0;
+	ret = copy_struct_from_user(req, req_len, attrs->ucore.inbuf,
+				    attrs->ucore.inlen);
+	if (ret == -E2BIG)
+		ret = -EOPNOTSUPP;
+	return ret;
 }
 
 /*
-- 
2.43.0


