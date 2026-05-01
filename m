Return-Path: <linux-rdma+bounces-19803-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJHaKR7v82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19803-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:09:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B374A91AC
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48BDD303AF25
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E3347C6;
	Fri,  1 May 2026 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqJZ3Mpy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B135950;
	Fri,  1 May 2026 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594128; cv=fail; b=VHJdu2ui4NeDwJ5j68KbGAvW5mLO40ls8Stm/bLUIpKJDvq+9uP9efeT76kHePY3F7d/qP/I2m+m3noPwelYiF12wKqfjMDH0gmVW3+lPAlRW8HoChVsAJu9Gb+S6sJ3GA1uzIiDWeVUNhBPk5Gwh0GIRbgCiThq2PmTqvsddk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594128; c=relaxed/simple;
	bh=E8Y22OXWk/W9Z4t/wVjnLmHo2kV3n0qBr44bEXVNQak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbTnGiAdwYoqrkxrMLYTAnICTjl/Hp8WLJ65/kXFXfUFWlgQMHIMfD6DpcyPawYgHlFG34q2WndC3/1/0lnknnE3xxNWsTqPMar/8vhXREjxW98pl/4IZEVHzzh6QORA/YJHO8KyzsS7MK0jVl7IYtLqls7IGV2Wc1oGt2r6V2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqJZ3Mpy; arc=fail smtp.client-ip=52.101.48.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeojazlYbXJfWxpTzU4jqyOHNr5LpQ/5FZIRzAi570HYOOt+Ea8z5QCVqDF1Y6esI15QNz6m3QU2tIaEqGH3cSyOTzpeR/P3mxVZQ3elZ94F+qAIuESqoKty9udOO6dZmy1xeAMR1x/Fa0AAy9+3LIhW+4/WHmKrhI6bzhW76M21FyPwI5j5CO69fHlEOT18QIiOFtlFtDTerMj61szr7wB16bcf1DO4zwGUKk3QvkRxKR85Lc6SBKi985uRGIO7hV1lCOw6i7Ir2huaAIOOdyQRtBsmNT7eP69LE3L8nMhBOgLtBDtAtoDgLWgDXE1cJR56gX9OuVLl5T8vUy2coA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgNR8JKn3caYPqzLozD+4F7DAdvQW4I7IRDZEnhYpIo=;
 b=zAoCePwd6BmTT511rFEtX8wqxINgldMl38eoM4WfHYKdIqimHmOHt24damzXFdKtITrzUcH5X7XNK2K9oWQLfNmaboMz8Ej2fezsdA3OWahufL94jRFOMHmGyxFv5y8orwEXPmckFQ9L7WDT58MVh5oR259gdPupHiOt6qS9xs6s32hS/j+bty0JMsEZN3heodHqSXMnI31RA4lLjRa+UmIInsimybvTc8zlbso4eVcwL6tGCgGm1od2qtwcVqk0RfVFwbEsZKQvdKQyv/tb2XUWJdSZphZ46o0PIxsOEGzd55z4VJqPJXqkuT75PGWREg3Z0HyDxaxXr8lpTBNe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgNR8JKn3caYPqzLozD+4F7DAdvQW4I7IRDZEnhYpIo=;
 b=cqJZ3Mpy+/o5IOUSasX7OHiyhxiE9DHjOYMQocANI/V3oU7XSJVx95qk5/ALoxvtTEn2o4qqAqz5P8iKQUrDqWSDT3JClrNNttuntsMHLmgH5LOD6C86TI0TepWGmBKVsvFZvpgg2VNxOqH9oR7Cq0fSdwZaZHz83GsWf4alQE5ZF7bzDZJj48g/02YV4zHcLyC3n8tdSfotGjHuAdUvMExFslhV/h9wED50HWNivcUSrhOWav5W+7UTg/xcRM0qqaZk5Un0lmsCP9oGoCJZPio+tiTDj8px3p287nkCBoD8mjKIkkv5sn+Av29fLFCA1/TrVl7Do9Zdo3uIFNvCuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 00:08:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:41 +0000
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
Subject: [PATCH 03/11] net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
Date: Thu, 30 Apr 2026 21:08:29 -0300
Message-ID: <3-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: fbbf043b-b3af-47db-202f-08dea715cceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0BbT15eCcK0bI0N4Ua5Wyc0BoS78SPHz+HoytLPpIpH27E5XTrvbaOY2AVXnf38PdAJ47js5njlmOFWaOHSRhuxdonqHr3OaoKVjsiH3NuPOMq8aHcqXZni/RHrUfXu3y4b7nSwOENdbstaquFkhkv9C5lOJN1/dWOaLQqzqd2sTF5JMxNFMWqSMrDMnGSI5bgi57NLGLU4PUsg3DlnUovULBE4ioyaf3y5V0TCIFbE3t7j/oK2m+2H/PwIG5vQ6o7ZQQSYrhisLSalfNyPBAM9NOpKGAMrGSt7RjSAq9B9FXWEE2I3PNZC7PEOOKeXgXYzm0Pp6VD/iJMgUVl6dX3wE9JqN1uGZ089aT6jwGKiQRzWXVQatsIcV15JvrPDh3kpc/dRF1BkCiGEngiU97DYildRkvtezMRzQ8k8zQ5fs8NHm24Z5DMOWqZNfpKVmUxC1iS3WXEBQ6Zc0LZky/SEd6KH9gZhTY86dPkmyYVL2JKMenzEd8nJXIOQQ4fDn1btbY97vc4zuRvBGKXjEIdzbgXCSNAK3SFbf0GTjHxZWJf769KY06K5BxtkprZljIOVZDmEXEQ1v4BuxSbOAGxXsqRPm2oKUE4WTX9W+dw9NgO/cPd+6Rvzy4U8dmrJvzb22gZ026/nU1TFnaIHgP84HMOeNkfN9PvyjoUWJjEpbx83ska6y5nwYIYoMkb5BCMT4nhybuOa2y4U10+hJFXLTQ/vZoXUm49qiZEGsnY4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gZt+obZfuGkn3GZP9DtQBm90oIjvOMPOFzFGi2dSsyO7fHEYdBFNKAqdxsXI?=
 =?us-ascii?Q?wrCX+SmAzjg5ly6ZkYwxvn5/WpQqoTjqStur6XaFMLoe8SeXrKE2yxoSne6C?=
 =?us-ascii?Q?RuO1w34gDcwJjIMTraxBH6cXO2SchGcqu7MuhOejMvYuWmVMmbPTNskPz6M8?=
 =?us-ascii?Q?/Vghup/LXdALxbxrq3ogT/NsWyxjTckLNHj9IDhmNFpmjuWsRjxxiN8U+BLE?=
 =?us-ascii?Q?yNYhOPt7iG6YwZIvyaVPfmtjRIEHK1Q3Lzy9D87QAiLYLPYQR/vwEQk8bzgq?=
 =?us-ascii?Q?i77V58TRQqK2oyk/Ii29H049Bw8WFw/CFMUMMXpsQOMIzmOJlxxzHXUdemp9?=
 =?us-ascii?Q?oNZqMMBtnVEyd6UMlXCChwZoQ0hS6cGUhbg1iFUFrQQLwSEl/hnP9WHN6KCZ?=
 =?us-ascii?Q?GXcmnR1kClU2DCT5YQ4Nj1VGN3/HdrFnksNtlhl2W4+AwFkRKjTq9rBatY4X?=
 =?us-ascii?Q?Ki6i8yK7yv95CA7ogEqI+Wx2FAvLForqnCW/HotKURp9aBPnx5FoMkggDzgE?=
 =?us-ascii?Q?gz6XGP3ejYCTiipRKSIhYQw/EEHxVZOHswypETY6YCYlBSOEpHEOJA4lrE1J?=
 =?us-ascii?Q?M2d/NNO05TGWnooJTbq9KQlFAlwnlo4eEwnjgqxMWEfO8c1G+Oj/1xR3eObB?=
 =?us-ascii?Q?eIJ1L479mN7VBash9f6oXU7ey7En4K3R9Iu2b5AsY7D6M6fpNeBC6L0Tg9Rz?=
 =?us-ascii?Q?UnqnFEIgoNZoGtasvDpnhu7ZqI2lzcAhoaMtNjUxPumTpHT7ZA/Tx6VCmloS?=
 =?us-ascii?Q?CxwTPNGmrGl9F7BQnf94Pad5YtuzcL6N6AXSIh6Tq92zAeEmhKaX4EffG+tx?=
 =?us-ascii?Q?kk4M4BgxfksX1upSe39+4TTe/5QSVIfSzvP4SHJbCLYFdQ1lz80v18yKFUZe?=
 =?us-ascii?Q?Xcl4pBDa5Xcq+tvL4+LHuPV2FP5/V0xmsyD+tsftiOZ/7qn/siGQujfn2F/x?=
 =?us-ascii?Q?MwYsUDkO9pX0zXCJ4hFuzGW9Por2p14cUAWCtVkKZlRsuadtUD+K1taLLKWX?=
 =?us-ascii?Q?qZXRrEvHoiM087gRaVWgUm9l0bX7Op76Jr1C2BvBEHdlRSIjz6Wn4TVOyl4g?=
 =?us-ascii?Q?a7tv0hq4Wk4FgASaTRL7vfL45pIHozFlS7k8kzxGTNFHw3izhnK8g1duLitJ?=
 =?us-ascii?Q?5CBqMHI00me8iB3SKz8BG8MozPApyZqvuLO7qGe9EhVNLvDvEn+6/GJUSds1?=
 =?us-ascii?Q?uy371uDB4C6X+w5V9zwmjoZxSelKZCRyC8vTZAmG1qAxdD17y/rbw2IHgo6U?=
 =?us-ascii?Q?sakDFPwEVRyTK9NsKj0E7n92gcHkN/CG1BlOAO7L/aO4+MT0KraptyypQUXQ?=
 =?us-ascii?Q?zhjD0pTz3pmO8syoOCGs1DLiZk6V55DMoizUmjXjnZwR+t+Cr8xGZiIZkrU5?=
 =?us-ascii?Q?eJFm7IvE8Rtv5R1Gf8kwZEhdasgIa76GiEHB4Q9cRuYKstIXjjEULPVM+/OF?=
 =?us-ascii?Q?OrD5JaCV9sD+dEx7QBznu70t09ZkZ5FIxYp0Rg+LhnK2ZI0POB+3Y44YIPmf?=
 =?us-ascii?Q?knkpVxbVljJK0Fj/r4yoduoYCQRMzwKTEwZzCug80vtA6LINCmsNPDwVR/NI?=
 =?us-ascii?Q?FaUrRjCbOahHNZivdmBAGZ3gWz6hHBm9fjPOklxfX2KrLEOgWTnXu3kn8zJR?=
 =?us-ascii?Q?WBvJVi5ZLlhLlF26veJt9QyEM8EgJZUAEHq+sT8FRMBCH12OADi+7QMbMvfy?=
 =?us-ascii?Q?yEj8KfpIkfqvalZ5fVV+5TvJknPyMFjFy1R0X6C7Uca3jd9D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbbf043b-b3af-47db-202f-08dea715cceb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:40.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0ATzuqQXvV5t3c9hedf0uqZD6FnWaYLNv2wUF6unmek3L/Y7uZOfLu8O2CAnnSO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
X-Rspamd-Queue-Id: 16B374A91AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19803-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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


