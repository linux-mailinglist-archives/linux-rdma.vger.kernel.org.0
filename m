Return-Path: <linux-rdma+bounces-20782-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL9iEHdjB2q90wIAu9opvQ
	(envelope-from <linux-rdma+bounces-20782-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 20:18:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E91F25560AB
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 20:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B99DE31700D0
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C123F8ED3;
	Fri, 15 May 2026 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HLqV0rfx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7D3F8EA0;
	Fri, 15 May 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866225; cv=fail; b=r//h5ElpimqXL43O39kuJIUrBULsBNbrdfKKVnpc8BdpUqt/IU0R9+ma8r2vTCP77jzxFaOiKzT7dliu7FFdJjKFqxFc6IkhJcXVexD/xD5MKlA2QZo6/6kvhIvxBZ92gHfC17iE2SprCjI+2BsPf+X2ar14LS/UItJWdIzBOx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866225; c=relaxed/simple;
	bh=E8Y22OXWk/W9Z4t/wVjnLmHo2kV3n0qBr44bEXVNQak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xns4tjXHy91eCTFnlfU8MUo0G0FFsokWidfqokJ/GI8VQdLKZIlYT57ECFySbxn5Ofpw42nWDSyvQU/J1R+XGxt8rXG2ctC/HFY6dGsRaNOOnKNRQAdoTmRVyAe7z+S9ji1qxHgaH04bw4E41WXxIDJreChHRr0qnPlx2QJpO7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HLqV0rfx; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgxwqEiwPbUlBl7kCROqEOUKwE05U7a518T/e3w46/KZuYWM6gkkULCCPNqqKK68WZlWebzlCTg5cMCykOLcPAubYrEoMfADvRDIYcsikLby2aYveQHbT/cjlV3qDBIoVoQ7838rq2qPyD/KqTlyXKoZNA+prqrZXK3CWFAVYyJhk0I0nSNtYSgAJifnhoXUe9Se83TPJ9r4tWlB0fqkS73nvXTXjYHgfa8BZ8j8OWOZcvb6hg3NbD/x8KUlTwZJVG9nz40HoxzQ2mZ4sO0daavN/8jwc0xx/CK4GQYSPl1knWPO52wnWvVQOon425MVovRpM4MdH9ERe9HIlcqbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgNR8JKn3caYPqzLozD+4F7DAdvQW4I7IRDZEnhYpIo=;
 b=U1i4GJ7ineHSFF7eZ54diLY1Sa2BbEBFsJynz+MZ+eF0yrX4uwS8WVtZLrD9T6n4HMMYBn/6N2M9QWE7arMiOQJ1Hrhki1x93G8yhmuufVVFi7CjyKIMw3nm5HKid+DVe1Su0BEAd/xb203FQmMf8NnXKrJx49S5g4HTONfBhcW+Jb/YWKYurwEE0VlU8b/+g6d0sxIvKEkFKRNOzO7ts+dsySzPuGsdCuBAKQvera3PibhlVWqBRmkFXmTTOpz/n1KisAeTexyvQXxSXlJ21DXr862/JrVnc9PXxflUy6WkrEnkzUbVeiSda3cvZuJOzmSO5lqaNjap5mWZESorpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgNR8JKn3caYPqzLozD+4F7DAdvQW4I7IRDZEnhYpIo=;
 b=HLqV0rfx33LUlSdyyDaNASAyUSvbAPxYPqJ6UxLGdrScMYZl8HsFGf2QA6fspK2cocD89ipCP308iJFkP7LRq2lJK++jTowHDFWBOsFYkhUC3ONENQG37a9VrmYnWVEAT29Se5ze+/5T9tZA1paFlBp+34AQI0Yqkqhy2Ut+fy7l0PNG+Gnm2wy4KnSP7ZVOHOLK1nKI0PUCT5sqUiAsWJXwtoe8JEc9IoSTnW67ZAHlD8jFaPI9sf+Ah74CoZgY9myJEpSNGKgB+VVnxjzIEdgmDGGFRS8JdPm9gQDfIIi7UmOrCL5yi/HgOy1Me+n7yeN4TNF/P52p7e+RljtUOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	David Matlack <dmatlack@google.com>,
	kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 03/11] net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
Date: Fri, 15 May 2026 14:30:00 -0300
Message-ID: <3-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 7919aafd-6176-48e8-8c58-08deb2a79ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	WCxq9SZbBkcbURKPUgK5a1iHqj3DxqJHn/JuUMqqPcf6/NfEZTC7SV7sIEvr9NCEgjyMGPPw9Mvhuj33IK0M2hhIfZWQIxmhrkxeE4zd1LsUneG25A85dHQpZ/d78fgQCh688aO9Zk+f+KlHBWEpgwNVP5/TBecSVF8c1MpOnH8gUoZlGOOlO2meAZZqP01NIOHk61NNx5jrSALDvdeDpVb0AxB8XY0q37Jzv3YgEkEuUGSnAD+o6wbmeR3T5ela1QJ3wvgcqZ31FcWKNxjoypoKBfxpd1fG8qwMWkTeJ+YxsE8a52+KDSd5KoE2+cF0OD4QPOIaVv2zVli2vhGpLPlEBaq6z9Jhu5p+Lg/7dP2P8L9aQjaahHN/KUBp0kjk9xCC2GKQABdR1+KDCVlTa72aJivwXLx+VNHjKVau1jHqeDJI6OiwLLtU3J0nkzCeRuvz+2FFxE5zqtqHlX8lBPP1WQZk24siJwrHzDlw8Z0pKlgReMnwxbNYlKrz7JtsbPXJdO8KDpgquQXreMdHmwbLBKzxOA0g38LqPXCc7sYaTtiSy5YI3NJ+IXwy3oN8TqFmI7UK6vQWmf8MNaiFL7Dya3iJMYaF7HHpkf97Qf7XSSwyWoJnLmJk3w8tASr8vdVZZpfc79yQXeXY31d8NBWyY/M/c0N1hM8tC2zgS7bv3l4Xs3a2Msb/h9lvTinmxg+k1RfR1T0a9AGCiAnSygjuUizln9fQVq5x8VCD55Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c5S2tgGUpn0GPdsokahuURsjFt3R8hqCdzw2K2DSQgNnZidm+v8J7rcAgP+Y?=
 =?us-ascii?Q?aB1xT7Om3q5lvj3eat8nEk6kDdeTmBT0zoULHzx2npuKLBCk7AdtavurUAmE?=
 =?us-ascii?Q?oSQ5yYXOcTGaXR2RFk9SeVdAj6mhIEgQIK19aGfenzqNaqHK/0ZCKbrGalmI?=
 =?us-ascii?Q?d7lPJ78y039elbc20eQzOrAd3rd/1TvZ+6u+5GbUq/mK2AUjw0ujTmaZoeZf?=
 =?us-ascii?Q?Ly5Wf+kfNpm3QWbIbzUvAn8i2cqhfLiTbVuDjG/Geue2xcQTVDjdKj/3Nv0a?=
 =?us-ascii?Q?G1Qqmx8jDkbhX8Avi2JdZb/ll6bm4ikPqTf9oKCuLwjfsS52myEhRAfYN4m9?=
 =?us-ascii?Q?Mi0tOaQ4Ti0K9rOgLLHuGdt+lztQXrdI/gJSo2ENmrmrwkfFxg6Q82OU3xew?=
 =?us-ascii?Q?BYsbCYxI1oWrVUiqDemr88ScJlsLSOAVeVH3vM5qmKRRFYAnfTS9j6yur61K?=
 =?us-ascii?Q?kc2f/ws5obC5vsQY3WF5Tm1FNQLaTQyYR6pPe4kz30leLahJszb3HLj87CF8?=
 =?us-ascii?Q?Wkuq71vz5tOYUGkrprCYo3YO8XKXoTGZKh3JdL2lSstAfSfodUkbAawao1Yq?=
 =?us-ascii?Q?aHmjSa+D5EE19Jbf3iEfS5JrWKd7nsCGjSPkJKxom1AnPv4nnSPBs6ygxO1F?=
 =?us-ascii?Q?IIQWdKmJKBNgzOJv4xAnhbljlE9trxx9B603RlB49wp8hhfjcN0oFqGOWsHg?=
 =?us-ascii?Q?By7ParGQw8/vRn4zXULY0jUCs5uPoPQbgPFQGVxVDfRC1OfSmicPuHGuHsQp?=
 =?us-ascii?Q?JFT1XCihSUOWjtettAGAeLWx8Jh9hpCcGTDqlBzmTpUuLBVddTJvvFm+wJwS?=
 =?us-ascii?Q?IgH/i1A3Gpgl1DwOPndht861XmZO1Ef9mtHLORhoRBK3Lyj6uVoRf+LYmdZk?=
 =?us-ascii?Q?Gu2ATx3A1xAg3I4VseKYapRMmea/Fu2o+0n2tmzwNCydOqUZrBBfM+RqcF3g?=
 =?us-ascii?Q?vGbnQPIgPx3i03DlPL/6IkYc4ewqIw8zt6L2WHOKy+tTUQVo5Jfze+TOwwAO?=
 =?us-ascii?Q?OGAALh7+yy6exkJK/AD404PVCTWHpD1XS2Gl0o5zF/HM1cz48r/zXB7z8RGb?=
 =?us-ascii?Q?JA4DVFXBEDhr5PJBgmAqqJBRomigzacKs73Biqso9FSp5dSKKoZGQff/4j0X?=
 =?us-ascii?Q?6e3V+LqZHMI3Gkpm5gWwlxYKFXD+SEwnUaHQ1OxGDh03jQR6Lq3iOTZO9NXA?=
 =?us-ascii?Q?qCaMe01CSCyVKpgoUkW9dYYVGNtXwZqiU4v83tM6ltZbp6HuUrhzy+sz2MM/?=
 =?us-ascii?Q?ppNurPzEKBYHXdsDguzu2+JN3OL125Hf3E9kUz1dJppcLK9FheZuRekZ/00g?=
 =?us-ascii?Q?LPt8HeUOLNQJYtFT6v54mMwpJ77ZzP5P+icSA8fDvsJBJtKhYJi5kAqJ8wja?=
 =?us-ascii?Q?oM5eIVOyMuCPrDql2V0AcIJQMKHcuY8K/X+QwZmjmVLWnvGQM0zcpq8lMVKp?=
 =?us-ascii?Q?vJ5UOVLXtHpEgURaRf8Ko4oRjK98zphGO1en3fJPjoN2QFLcq0Yw4ge+V6bM?=
 =?us-ascii?Q?oNrzgSq3LY0xHGKzyXcP1nbjtrnFvjMBgTQYLdzsPETPdmkhqvnKBEQDRpn6?=
 =?us-ascii?Q?3BosvOmcBZnBVqZc1sVrU8FqJ7rI7fwHMnK+lyBycl6CR4nbaxRjxGXrIafg?=
 =?us-ascii?Q?g18tg1RdI6ZzEfeueQzmS9fq4GkJrK/oG1wghJlf0bcIv50uw8M82C9e589W?=
 =?us-ascii?Q?VBOdwP309RfOQY6fJ7dZ5UgPt7KbM9/Hu48MxvrGTZhyYaGu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7919aafd-6176-48e8-8c58-08deb2a79ccb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:09.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXKgy/nHrHQSdgbjFAoXEhWT0XwOJ2j8AX8CiBoL1RoS58Pkax2Lt/7Slq1h+fri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: E91F25560AB
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20782-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

Extract the entire MLX5_SET/GET macro family and their internal
helpers from device.h into a new lightweight header
(include/linux/mlx5/mlx5_ifc_macros.h).  device.h cannot be
included by the VFIO selftest because it pulls in rdma/ib_verbs.h;
the macros themselves depend only on endian helpers, BUILD_BUG_ON,
and basic C types.

The moved macros include the internal helpers (__mlx5_nullp through
__mlx5_st_sz_bits), all size/address macros (MLX5_ST_SZ_BYTES,
MLX5_BYTE_OFF, MLX5_ADDR_OF, etc.), the 32-bit accessors (MLX5_SET,
MLX5_GET, MLX5_SET_TO_ONES, MLX5_ARRAY_SET, MLX5_GET_PR), the
64-bit accessors (MLX5_SET64, MLX5_GET64, MLX5_ARRAY_SET64,
MLX5_GET64_PR), the 16-bit accessors (MLX5_GET16, MLX5_SET16), and
the big-endian getters (MLX5_GET64_BE, MLX5_GET_BE).

device.h includes the new header so existing kernel code is
unchanged.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/mlx5/device.h          | 117 +----------------------
 include/linux/mlx5/mlx5_ifc_macros.h | 133 +++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 116 deletions(-)
 create mode 100644 include/linux/mlx5/mlx5_ifc_macros.h

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index c739a1f578dc44..2de2640d830bd6 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -36,6 +36,7 @@
 #include <linux/types.h>
 #include <rdma/ib_verbs.h>
 #include <linux/mlx5/mlx5_ifc.h>
+#include <linux/mlx5/mlx5_ifc_macros.h>
 #include <linux/bitfield.h>
 
 #if defined(__LITTLE_ENDIAN)
@@ -46,122 +47,6 @@
 #error Host endianness not defined
 #endif
 
-/* helper macros */
-#define __mlx5_nullp(typ) ((struct mlx5_ifc_##typ##_bits *)0)
-#define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
-#define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
-#define __mlx5_16_off(typ, fld) (__mlx5_bit_off(typ, fld) / 16)
-#define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
-#define __mlx5_64_off(typ, fld) (__mlx5_bit_off(typ, fld) / 64)
-#define __mlx5_16_bit_off(typ, fld) (16 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0xf))
-#define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
-#define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
-#define __mlx5_dw_mask(typ, fld) (__mlx5_mask(typ, fld) << __mlx5_dw_bit_off(typ, fld))
-#define __mlx5_mask16(typ, fld) ((u16)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
-#define __mlx5_16_mask(typ, fld) (__mlx5_mask16(typ, fld) << __mlx5_16_bit_off(typ, fld))
-#define __mlx5_st_sz_bits(typ) sizeof(struct mlx5_ifc_##typ##_bits)
-
-#define MLX5_FLD_SZ_BYTES(typ, fld) (__mlx5_bit_sz(typ, fld) / 8)
-#define MLX5_ST_SZ_BYTES(typ) (sizeof(struct mlx5_ifc_##typ##_bits) / 8)
-#define MLX5_ST_SZ_DW(typ) (sizeof(struct mlx5_ifc_##typ##_bits) / 32)
-#define MLX5_ST_SZ_QW(typ) (sizeof(struct mlx5_ifc_##typ##_bits) / 64)
-#define MLX5_UN_SZ_BYTES(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 8)
-#define MLX5_UN_SZ_DW(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 32)
-#define MLX5_BYTE_OFF(typ, fld) (__mlx5_bit_off(typ, fld) / 8)
-#define MLX5_ADDR_OF(typ, p, fld) ((void *)((u8 *)(p) + MLX5_BYTE_OFF(typ, fld)))
-
-/* insert a value to a struct */
-#define MLX5_SET(typ, p, fld, v) do { \
-	u32 _v = v; \
-	BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 32);             \
-	*((__be32 *)(p) + __mlx5_dw_off(typ, fld)) = \
-	cpu_to_be32((be32_to_cpu(*((__be32 *)(p) + __mlx5_dw_off(typ, fld))) & \
-		     (~__mlx5_dw_mask(typ, fld))) | (((_v) & __mlx5_mask(typ, fld)) \
-		     << __mlx5_dw_bit_off(typ, fld))); \
-} while (0)
-
-#define MLX5_ARRAY_SET(typ, p, fld, idx, v) do { \
-	BUILD_BUG_ON(__mlx5_bit_off(typ, fld) % 32); \
-	MLX5_SET(typ, p, fld[idx], v); \
-} while (0)
-
-#define MLX5_SET_TO_ONES(typ, p, fld) do { \
-	BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 32);             \
-	*((__be32 *)(p) + __mlx5_dw_off(typ, fld)) = \
-	cpu_to_be32((be32_to_cpu(*((__be32 *)(p) + __mlx5_dw_off(typ, fld))) & \
-		     (~__mlx5_dw_mask(typ, fld))) | ((__mlx5_mask(typ, fld)) \
-		     << __mlx5_dw_bit_off(typ, fld))); \
-} while (0)
-
-#define MLX5_GET(typ, p, fld) ((be32_to_cpu(*((__be32 *)(p) +\
-__mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
-__mlx5_mask(typ, fld))
-
-#define MLX5_GET_PR(typ, p, fld) ({ \
-	u32 ___t = MLX5_GET(typ, p, fld); \
-	pr_debug(#fld " = 0x%x\n", ___t); \
-	___t; \
-})
-
-#define __MLX5_SET64(typ, p, fld, v) do { \
-	BUILD_BUG_ON(__mlx5_bit_sz(typ, fld) != 64); \
-	*((__be64 *)(p) + __mlx5_64_off(typ, fld)) = cpu_to_be64(v); \
-} while (0)
-
-#define MLX5_SET64(typ, p, fld, v) do { \
-	BUILD_BUG_ON(__mlx5_bit_off(typ, fld) % 64); \
-	__MLX5_SET64(typ, p, fld, v); \
-} while (0)
-
-#define MLX5_ARRAY_SET64(typ, p, fld, idx, v) do { \
-	BUILD_BUG_ON(__mlx5_bit_off(typ, fld) % 64); \
-	__MLX5_SET64(typ, p, fld[idx], v); \
-} while (0)
-
-#define MLX5_GET64(typ, p, fld) be64_to_cpu(*((__be64 *)(p) + __mlx5_64_off(typ, fld)))
-
-#define MLX5_GET64_PR(typ, p, fld) ({ \
-	u64 ___t = MLX5_GET64(typ, p, fld); \
-	pr_debug(#fld " = 0x%llx\n", ___t); \
-	___t; \
-})
-
-#define MLX5_GET16(typ, p, fld) ((be16_to_cpu(*((__be16 *)(p) +\
-__mlx5_16_off(typ, fld))) >> __mlx5_16_bit_off(typ, fld)) & \
-__mlx5_mask16(typ, fld))
-
-#define MLX5_SET16(typ, p, fld, v) do { \
-	u16 _v = v; \
-	BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 16);             \
-	*((__be16 *)(p) + __mlx5_16_off(typ, fld)) = \
-	cpu_to_be16((be16_to_cpu(*((__be16 *)(p) + __mlx5_16_off(typ, fld))) & \
-		     (~__mlx5_16_mask(typ, fld))) | (((_v) & __mlx5_mask16(typ, fld)) \
-		     << __mlx5_16_bit_off(typ, fld))); \
-} while (0)
-
-/* Big endian getters */
-#define MLX5_GET64_BE(typ, p, fld) (*((__be64 *)(p) +\
-	__mlx5_64_off(typ, fld)))
-
-#define MLX5_GET_BE(type_t, typ, p, fld) ({				  \
-		type_t tmp;						  \
-		switch (sizeof(tmp)) {					  \
-		case sizeof(u8):					  \
-			tmp = (__force type_t)MLX5_GET(typ, p, fld);	  \
-			break;						  \
-		case sizeof(u16):					  \
-			tmp = (__force type_t)cpu_to_be16(MLX5_GET(typ, p, fld)); \
-			break;						  \
-		case sizeof(u32):					  \
-			tmp = (__force type_t)cpu_to_be32(MLX5_GET(typ, p, fld)); \
-			break;						  \
-		case sizeof(u64):					  \
-			tmp = (__force type_t)MLX5_GET64_BE(typ, p, fld); \
-			break;						  \
-			}						  \
-		tmp;							  \
-		})
-
 enum mlx5_inline_modes {
 	MLX5_INLINE_MODE_NONE,
 	MLX5_INLINE_MODE_L2,
diff --git a/include/linux/mlx5/mlx5_ifc_macros.h b/include/linux/mlx5/mlx5_ifc_macros.h
new file mode 100644
index 00000000000000..d357acfd351de2
--- /dev/null
+++ b/include/linux/mlx5/mlx5_ifc_macros.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2013-2026, Mellanox Technologies. All rights reserved.
+ *
+ * Accessor macros for mlx5 IFC structures.
+ *
+ * Extracted from device.h so that code which cannot include device.h
+ * (e.g. selftests) can still use the MLX5_SET/GET family directly.
+ */
+
+#ifndef MLX5_IFC_MACROS_H
+#define MLX5_IFC_MACROS_H
+
+/* Internal helpers -- 32-bit */
+#define __mlx5_nullp(typ) ((struct mlx5_ifc_##typ##_bits *)0)
+#define __mlx5_bit_sz(typ, fld) sizeof(__mlx5_nullp(typ)->fld)
+#define __mlx5_bit_off(typ, fld) (offsetof(struct mlx5_ifc_##typ##_bits, fld))
+#define __mlx5_16_off(typ, fld) (__mlx5_bit_off(typ, fld) / 16)
+#define __mlx5_dw_off(typ, fld) (__mlx5_bit_off(typ, fld) / 32)
+#define __mlx5_64_off(typ, fld) (__mlx5_bit_off(typ, fld) / 64)
+#define __mlx5_16_bit_off(typ, fld) (16 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0xf))
+#define __mlx5_dw_bit_off(typ, fld) (32 - __mlx5_bit_sz(typ, fld) - (__mlx5_bit_off(typ, fld) & 0x1f))
+#define __mlx5_mask(typ, fld) ((u32)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
+#define __mlx5_dw_mask(typ, fld) (__mlx5_mask(typ, fld) << __mlx5_dw_bit_off(typ, fld))
+#define __mlx5_mask16(typ, fld) ((u16)((1ull << __mlx5_bit_sz(typ, fld)) - 1))
+#define __mlx5_16_mask(typ, fld) (__mlx5_mask16(typ, fld) << __mlx5_16_bit_off(typ, fld))
+#define __mlx5_st_sz_bits(typ) sizeof(struct mlx5_ifc_##typ##_bits)
+
+/* Size and address macros */
+#define MLX5_FLD_SZ_BYTES(typ, fld) (__mlx5_bit_sz(typ, fld) / 8)
+#define MLX5_ST_SZ_BYTES(typ) (sizeof(struct mlx5_ifc_##typ##_bits) / 8)
+#define MLX5_ST_SZ_DW(typ) (sizeof(struct mlx5_ifc_##typ##_bits) / 32)
+#define MLX5_ST_SZ_QW(typ) (sizeof(struct mlx5_ifc_##typ##_bits) / 64)
+#define MLX5_UN_SZ_BYTES(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 8)
+#define MLX5_UN_SZ_DW(typ) (sizeof(union mlx5_ifc_##typ##_bits) / 32)
+#define MLX5_BYTE_OFF(typ, fld) (__mlx5_bit_off(typ, fld) / 8)
+#define MLX5_ADDR_OF(typ, p, fld) ((void *)((u8 *)(p) + MLX5_BYTE_OFF(typ, fld)))
+
+/* insert a value to a struct */
+#define MLX5_SET(typ, p, fld, v) do { \
+	u32 _v = v; \
+	BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 32);             \
+	*((__be32 *)(p) + __mlx5_dw_off(typ, fld)) = \
+	cpu_to_be32((be32_to_cpu(*((__be32 *)(p) + __mlx5_dw_off(typ, fld))) & \
+		     (~__mlx5_dw_mask(typ, fld))) | (((_v) & __mlx5_mask(typ, fld)) \
+		     << __mlx5_dw_bit_off(typ, fld))); \
+} while (0)
+
+#define MLX5_ARRAY_SET(typ, p, fld, idx, v) do { \
+	BUILD_BUG_ON(__mlx5_bit_off(typ, fld) % 32); \
+	MLX5_SET(typ, p, fld[idx], v); \
+} while (0)
+
+#define MLX5_SET_TO_ONES(typ, p, fld) do { \
+	BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 32);             \
+	*((__be32 *)(p) + __mlx5_dw_off(typ, fld)) = \
+	cpu_to_be32((be32_to_cpu(*((__be32 *)(p) + __mlx5_dw_off(typ, fld))) & \
+		     (~__mlx5_dw_mask(typ, fld))) | ((__mlx5_mask(typ, fld)) \
+		     << __mlx5_dw_bit_off(typ, fld))); \
+} while (0)
+
+#define MLX5_GET(typ, p, fld) ((be32_to_cpu(*((__be32 *)(p) +\
+__mlx5_dw_off(typ, fld))) >> __mlx5_dw_bit_off(typ, fld)) & \
+__mlx5_mask(typ, fld))
+
+#define MLX5_GET_PR(typ, p, fld) ({ \
+	u32 ___t = MLX5_GET(typ, p, fld); \
+	pr_debug(#fld " = 0x%x\n", ___t); \
+	___t; \
+})
+
+/* 64-bit field accessors */
+#define __MLX5_SET64(typ, p, fld, v) do { \
+	BUILD_BUG_ON(__mlx5_bit_sz(typ, fld) != 64); \
+	*((__be64 *)(p) + __mlx5_64_off(typ, fld)) = cpu_to_be64(v); \
+} while (0)
+
+#define MLX5_SET64(typ, p, fld, v) do { \
+	BUILD_BUG_ON(__mlx5_bit_off(typ, fld) % 64); \
+	__MLX5_SET64(typ, p, fld, v); \
+} while (0)
+
+#define MLX5_ARRAY_SET64(typ, p, fld, idx, v) do { \
+	BUILD_BUG_ON(__mlx5_bit_off(typ, fld) % 64); \
+	__MLX5_SET64(typ, p, fld[idx], v); \
+} while (0)
+
+#define MLX5_GET64(typ, p, fld) be64_to_cpu(*((__be64 *)(p) + __mlx5_64_off(typ, fld)))
+
+#define MLX5_GET64_PR(typ, p, fld) ({ \
+	u64 ___t = MLX5_GET64(typ, p, fld); \
+	pr_debug(#fld " = 0x%llx\n", ___t); \
+	___t; \
+})
+
+/* 16-bit field accessors */
+#define MLX5_GET16(typ, p, fld) ((be16_to_cpu(*((__be16 *)(p) +\
+__mlx5_16_off(typ, fld))) >> __mlx5_16_bit_off(typ, fld)) & \
+__mlx5_mask16(typ, fld))
+
+#define MLX5_SET16(typ, p, fld, v) do { \
+	u16 _v = v; \
+	BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 16);             \
+	*((__be16 *)(p) + __mlx5_16_off(typ, fld)) = \
+	cpu_to_be16((be16_to_cpu(*((__be16 *)(p) + __mlx5_16_off(typ, fld))) & \
+		     (~__mlx5_16_mask(typ, fld))) | (((_v) & __mlx5_mask16(typ, fld)) \
+		     << __mlx5_16_bit_off(typ, fld))); \
+} while (0)
+
+/* Big endian getters */
+#define MLX5_GET64_BE(typ, p, fld) (*((__be64 *)(p) +\
+	__mlx5_64_off(typ, fld)))
+
+#define MLX5_GET_BE(type_t, typ, p, fld) ({				  \
+		type_t tmp;						  \
+		switch (sizeof(tmp)) {					  \
+		case sizeof(u8):					  \
+			tmp = (__force type_t)MLX5_GET(typ, p, fld);	  \
+			break;						  \
+		case sizeof(u16):					  \
+			tmp = (__force type_t)cpu_to_be16(MLX5_GET(typ, p, fld)); \
+			break;						  \
+		case sizeof(u32):					  \
+			tmp = (__force type_t)cpu_to_be32(MLX5_GET(typ, p, fld)); \
+			break;						  \
+		case sizeof(u64):					  \
+			tmp = (__force type_t)MLX5_GET64_BE(typ, p, fld); \
+			break;						  \
+			}						  \
+		tmp;							  \
+		})
+
+#endif /* MLX5_IFC_MACROS_H */
-- 
2.43.0


