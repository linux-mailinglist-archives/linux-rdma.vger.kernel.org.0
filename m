Return-Path: <linux-rdma+bounces-3457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F77915A06
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD12283570
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEDA1A2C0C;
	Mon, 24 Jun 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Uh5xYb9V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E171A2540;
	Mon, 24 Jun 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269266; cv=fail; b=RHWf9qHy3v/83TCyB5Gyq1SRyMc13/HmdRGm7gaUpHi+YaPhAnKGr1lDGNid6UMJ85PDhtpAAJhMvFxMNix3Ybbn2filrNoQ8b0MieKOXYst7n/aAdEKPhzlMb/roNOT2XVc0AQKsUBcUzlVQdbM08XoZLrm0emjA5qPdHzy6dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269266; c=relaxed/simple;
	bh=XCeF/2caKxUj6vXzDDb46aXwynhWaqaQ8Fm/UsBqgbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TH1Z0G99oDDXkGxAlzjR+8dMnjolZCnzSgzTeIUNNWnIe/GespbKJB3ctQOzJhvstU0gOfserv/SGUCOhK1z1DMaTPbHXE4TQpJZEv/vvmzMGqUQ2VauxKTgJBJYB7p9RnSpwrD1csVbh/TbkMh3y/fZONRUpnjt5SW3ouZ7EVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Uh5xYb9V; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuvwcqEJj6+YswPRiaLFu1GHEx9SBMj8/BthmHzIufVx25Q4BF6DgAmHnt4gCzK+iRQf3Om53DnNx2ouN00kgW0gvqVbiiY5NrMLKraEvR5XuaONiC5eQ495vQ13rjXjBlnsC6QPRImcT/L6zA+tjD8KNxOnB/qzTka6Pb9iLXSyyRoKm3A8rqsJ49hyp78971SznySEk3VxaeWTGFbG6pI24bWlj3k/Y+f/l5jPATokeKluA4G0u2nxbK4U/t0Tl/UZth6jOuBdiCRGBD6xMTh1gQe6ySJ+AdLMYjo0LJXS0hZgickhWo1DfnAKHzp6sviE8TwaVhvFWINDkdcqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsaVyhrn2fpluRJdINOcBUH/9hti28c5b2oPJwmXZyk=;
 b=j+ksN6eOZJPN1uPewuf5lw6yv7NZw3wBNjTaEtfThpJlYtTrTS3HShF883gAlWyMNjfMEOIx2oWVUza3gLacL8yhM8VIjN/7H9d1X23MUENDHnDKNF8xalB6nTrWw7E77wlqXspr/HuMazTJbT1iFA5qLq1IZvUvninEbxdlMCcGLrU3Su7mQT0k95cCfgRuCWzpF3pkBsyjO+OAYO+Kmd85dQAZPZG+3AulEIagegFYKsCBXFzpe8frySqlF2QzHlJ9IqHaLj8c6zz2/46D/HMP1er2/BYoaAsQ85atfBHsZrR3PXqfCKf+mN6yrbfMSntczHCc/dvvZHnW4yuOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsaVyhrn2fpluRJdINOcBUH/9hti28c5b2oPJwmXZyk=;
 b=Uh5xYb9Vpoh9uEfFUxZc5+mQChYHn5O4f9H+wJABS/l//gUrrADBnJXlaKDQzuO824Pi4f2+ZBoSNoloz2GUiNGn0UkF+VQCL928g/gB94s+/IljNrEagTN8OT98/zrKUi4ouMggBA1/aFsEgebpsTTGriGkMvTEJ1kIETJNA241nVaFQq78MWVWLX2BDRIq/bUujCl9zl1/QsZh4ri5po8yRrwNlscSORY2hUAxrtOChRkeN7DBYOIa2fhWEfW6eWCeuSgYtKYBJNdsBESgqd+P14HFVrVZf5+oVVAiVKvUjlgLGOE5wVhytvy0CZ9Lf5nsld+ml7dWqJwCvk0a6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:37 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v2 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Date: Mon, 24 Jun 2024 19:47:31 -0300
Message-ID: <7-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eceff69-f2ef-4673-5c94-08dc949fa302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C3ppm2uzphacipk1BIMXdktwtwitnCY8JynB4YuepEPNBZjtM7ZxKa/P2da0?=
 =?us-ascii?Q?n89aHJsNkNuU16P97RJNE/I5/GQ1C0UDpY/6aM/nh001t9oyKfX9fFTJ67mu?=
 =?us-ascii?Q?QgMqVRpCUasF3lUkcZXsDHa6imMpwJKtoXbH/ZnGBnnzs40Pwto/gDPtsCXG?=
 =?us-ascii?Q?uMhSrLuRTtN5Zb1pUBuBF7xDcZHB42JmQXAJGluRwo8vQXErGcngqYIXW2Ay?=
 =?us-ascii?Q?KKy5kBaiZyGwGzTuX8QVoJa1124x7iC8CsrLgIH4hd/kDm/WkzGdozX1uvtQ?=
 =?us-ascii?Q?vItN3Adp3D/sFbvzI7YI7KmXNh3XLICX15P1xJVkbQSgeRKzIJQ3tlpX+pIc?=
 =?us-ascii?Q?Y6vfqM2G1GDh2lvqC0yw7Q7sppi6/OLI0GIyYxpCr82ekB98NJsKmn/r+okW?=
 =?us-ascii?Q?Px+Rlcr+DY2qDhbpyx3+6Sgm5ktvCXZKstuVH9O1rmr7o/AEZC/BerIj/Q0l?=
 =?us-ascii?Q?50sr9/7qBrlzhPeLVmReI61rnwX/BdVkca+xJ8cLSEMcve81DnRE9iOm8+Q8?=
 =?us-ascii?Q?HCFeuOQofOrNGGzYEosbyDCSsYWW4x1skNkIZrTP3HBcRqCmthKksaO+Dm+U?=
 =?us-ascii?Q?REN0ea+mBlu5ZcIKoMSO86QBZX1yxtYv5OOs5YcCsdznZ4I4TXyLOvwY3iys?=
 =?us-ascii?Q?HukeKMsiWX/PMDyWdOCPPzkbCOdFSvGgUVuGRLCO0FeY86WgtfycE38aSqTL?=
 =?us-ascii?Q?Hnc298qlaKUWrFVvxudXtwbs96K1wwq5tL73Tj3dY5Orp8+fTLYsCKIl6zTM?=
 =?us-ascii?Q?kudvY9EJwmUcBVmfyqVSz8nEMDjrmG/thQnvpwmpDCSVcsrhpgVy5Nk3vEaZ?=
 =?us-ascii?Q?43krd217D+PCXgyDFxDSR+rrfGOX3HVC9ARkCfZfachqEP35wTTj0xgeYXx4?=
 =?us-ascii?Q?0VuXppeLySmg9jaPrQzf+XQtm+DDWNiSFjTAMzg4kgXNfHkERfBztbpqZUav?=
 =?us-ascii?Q?2l0pdeR40NK05quzy3VIdvBfOmlTUod3eQnxPtlpJXGwVzVu2exRP5irxahT?=
 =?us-ascii?Q?yPSw0Kz2yXqEeOl4SYMF8uyOAE+R7FrLgs8Jd9TrBxl7iK7WktHMMHXrloqX?=
 =?us-ascii?Q?6VTheGfbl5xR0Sg61iJh5c4rh22BSl/oDfj0QXJy0vITm79X4fkKGSy90qWQ?=
 =?us-ascii?Q?Emdrt+Ahlr4G+ooflvebpjyZaahz9+7JkUJImzz5t1M24W2aAKGO4GJXDIdn?=
 =?us-ascii?Q?XGWWxAGXqEWbUrga7V0RLqVV1ibKBHrE214DMvYdNpyuAZ10I6EdShC7iODV?=
 =?us-ascii?Q?SYt+fbK047oSIghpDBZHUisy5pHGp3hl/x3KOBh4+NrY9gjXqcpXhS+LqKHd?=
 =?us-ascii?Q?R0ET6prx+EnJzbJqZv0ABssf4PMIFxDjwYOUuu2OHFeCOielAunfTMukvIDp?=
 =?us-ascii?Q?Ep84u4E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xioNFhZxLxvIH/DuMpXnmM/WW96JPsgLCrTNekBoGBcnU3w9EB/SIF2b2ugo?=
 =?us-ascii?Q?qgFamGJlNYl8czksCT+fE21xe+ccgqTzhqhHNYM7TiGjGGzPCWiJAvK5cayy?=
 =?us-ascii?Q?k34cr50VrJ271asbHBaXPAbm+E4pkQ3lhahZxgiwe4sO9A2g3bIlXkdp3A7i?=
 =?us-ascii?Q?kwkLTUoaZs4/qw8NlA1kY7d8Jri3eIr7yi8xFV8I1Os0bJXuQ9ZEV+GoxvJ7?=
 =?us-ascii?Q?prHsxHw27cctWbY6al/Gov2cE9JS5aO9MjxJ5PC3zvUVnx7jDbeRb5vlH8xt?=
 =?us-ascii?Q?pmdvCFwyHCJM28L8AaWiK5k1MRQY7wWPBdXTkveutNS/f4XNz2CJC96TakOp?=
 =?us-ascii?Q?FPYNqhcs1EoSl5mKAm03/4kojwyr8UwlKesbRfvJA6Q4/lsrbAvTa98kElUx?=
 =?us-ascii?Q?90SKfMesRo1MAXBWDpjyPi7EHGEQSsmXebn36F98dgpJbu85kC68cqkXLT5O?=
 =?us-ascii?Q?x/iTTmdrqU9ZNKp/HWfTXthdBS0naoz7PnjCE4c9BtydWWXQUC67bY9FuOPg?=
 =?us-ascii?Q?2FbZxG0AuNuT4LyBXOqgagAIweFBoTmIBT2R3dVtMttzpNLblz7RX22T3zj1?=
 =?us-ascii?Q?Bnm8voZ1FszBEt45pwzklzuXMLeKR+q65BUMcehHS1UkMWbUW8YJ8x+ZcNag?=
 =?us-ascii?Q?70Nmd5xSiVwcqmXnCtfGWXI5/vBHpQdHtzVFqu9+WWZa3qaMABnDlBcDiDUk?=
 =?us-ascii?Q?8BN34G+GcemIvlQ88tDOm6Ph02HhQQknAGChnE6pNQzBIpYPfcnZpwuX7LKa?=
 =?us-ascii?Q?Nty02WUBMDEdJx9mUejOTQ+e533XPQkaDxWy7vlT1kKbxcNNgSQOaB5nedf+?=
 =?us-ascii?Q?Cv7xylF4j5SYubMPrhEloAFPrqvYiC/um/h9lZvMogJuGGF8jfU7iQU+Hte2?=
 =?us-ascii?Q?0e0juHLkH4dyrFYUPjVD/18crm/FJU4+L3sxoKE331xws6RNXUWjuj6Lgw89?=
 =?us-ascii?Q?KO6CVRlKjx5LFFOd8bTfxs7q+ukelvIqwFO556gJfqteEg286hq2VM1jUYpB?=
 =?us-ascii?Q?ib9bLraR0CQUWyrVqvR0s7zSEVfsprgJq6jiWIzz3FuUhIXhsjqbv36IP1gK?=
 =?us-ascii?Q?7kqlymV+QE2YqZ3z8d4NCtvTrvtGlancKg8nq88bLfuRUVtIcDjfl4NMdolg?=
 =?us-ascii?Q?iQAUc+kuMSvt6ldRnCbr9rpsEvvM2hXIYj4f7WNYYFxH2IbVErpmjR95q+Fo?=
 =?us-ascii?Q?gwHFfQhWj5tcQQRk69X6qvilWnd9EEgYpDaVelbfiwQsBM8jVJKp5L0vwcRJ?=
 =?us-ascii?Q?do6hgRmqbAk15lix88t4bqIP57Ebf71YaAWLbFVF7DppRXzgAqxjIaizp9fw?=
 =?us-ascii?Q?QWeBc7NI9XqzDl+yfqj2LEp+FEO28CRfpQDg24bVkOJ66nWAz4b1Qe+hwlse?=
 =?us-ascii?Q?QMsKe1qrUoaoFq+Pvel3Y17P16tc2JRSusJCHKwiwuy/fJQqJmeIpLlDNrtN?=
 =?us-ascii?Q?oPpLk6e68b7lDv7eeXKowOVFOTyLht1zyVXsSUL7Wtj6EBCN+MYYyewSgdqi?=
 =?us-ascii?Q?+mdM7cVIhLLZEilj/9XAppg3egF+83aWMPsswWv680V3C5HGrkppEiWzRWDi?=
 =?us-ascii?Q?fj63slgNn1kdgrmVj11FbbiiJwSpabQfaoI8FT49?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eceff69-f2ef-4673-5c94-08dc949fa302
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:33.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g11XXo5ns5dLPOVYYf85YFsxg6YDLsfvhZSxz3MyBPI4pm+ZAn/+zNLisZt8MFBa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5's fw has long provided a User Context concept. This has a long
history in RDMA as part of the devx extended verbs programming
interface. A User Context is a security envelope that contains objects and
controls access. It contains the Protection Domain object from the
InfiniBand Architecture and both togther provide the OS with the necessary
tools to bind a security context like a process to the device.

The security context is restricted to not be able to touch the kernel or
other processes. In the RDMA verbs case it is also restricted to not touch
global device resources.

The fwctl_mlx5 takes this approach and builds a User Context per fwctl
file descriptor and uses a FW security capability on the User Context to
enable access to global device resources. This makes the context useful
for provisioning and debugging the global device state.

mlx5 already has a robust infrastructure for delivering RPC messages to
fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
User Context ID in every RPC header so the FW knows the security context
of the issuing ID.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS                 |   7 +
 drivers/fwctl/Kconfig       |  14 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/mlx5/Makefile |   4 +
 drivers/fwctl/mlx5/main.c   | 337 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 include/uapi/fwctl/mlx5.h   |  36 ++++
 7 files changed, 400 insertions(+)
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/uapi/fwctl/mlx5.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2090009a6ae98a..f0689e510510b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9085,6 +9085,13 @@ F:	drivers/fwctl/
 F:	include/linux/fwctl.h
 F:	include/uapi/fwctl/
 
+FWCTL MLX5 DRIVER
+M:	Saeed Mahameed <saeedm@nvidia.com>
+R:	Itay Avraham <itayavr@nvidia.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/mlx5/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index 37147a695add9a..e5ee2d46d43126 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -7,3 +7,17 @@ menuconfig FWCTL
 	  support a wide range of lockdown compatible device behaviors including
 	  manipulating device FLASH, debugging, and other activities that don't
 	  fit neatly into an existing subsystem.
+
+if FWCTL
+config FWCTL_MLX5
+	tristate "mlx5 ConnectX control fwctl driver"
+	depends on MLX5_CORE
+	help
+	  MLX5CTL provides interface for the user process to access the debug and
+	  configuration registers of the ConnectX hardware family
+	  (NICs, PCI switches and SmartNIC SoCs).
+	  This will allow configuration and debug tools to work out of the box on
+	  mainstream kernel.
+
+	  If you don't know what to do here, say N.
+endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1cad210f6ba580..1c535f694d7fe4 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
+obj-$(CONFIG_FWCTL_MLX5) += mlx5/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/mlx5/Makefile b/drivers/fwctl/mlx5/Makefile
new file mode 100644
index 00000000000000..139a23e3c7c517
--- /dev/null
+++ b/drivers/fwctl/mlx5/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_MLX5) += mlx5_fwctl.o
+
+mlx5_fwctl-y += main.o
diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
new file mode 100644
index 00000000000000..5e64371d7e5508
--- /dev/null
+++ b/drivers/fwctl/mlx5/main.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/fwctl.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
+#include <uapi/fwctl/mlx5.h>
+
+#define mlx5ctl_err(mcdev, format, ...) \
+	dev_err(&mcdev->fwctl.dev, format, ##__VA_ARGS__)
+
+#define mlx5ctl_dbg(mcdev, format, ...)                             \
+	dev_dbg(&mcdev->fwctl.dev, "PID %u: " format, current->pid, \
+		##__VA_ARGS__)
+
+struct mlx5ctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+	u32 uctx_uid;
+};
+
+struct mlx5ctl_dev {
+	struct fwctl_device fwctl;
+	struct mlx5_core_dev *mdev;
+};
+DEFINE_FREE(mlx5ctl, struct mlx5ctl_dev *, if (_T) fwctl_put(&_T->fwctl));
+
+struct mlx5_ifc_mbox_in_hdr_bits {
+	u8 opcode[0x10];
+	u8 uid[0x10];
+
+	u8 reserved_at_20[0x10];
+	u8 op_mod[0x10];
+
+	u8 reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_mbox_out_hdr_bits {
+	u8 status[0x8];
+	u8 reserved_at_8[0x18];
+
+	u8 syndrome[0x20];
+
+	u8 reserved_at_40[0x40];
+};
+
+enum {
+	MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES = 0x4,
+};
+
+enum {
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS = 0x819,
+	MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS = 0x820,
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS = 0x821,
+	MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT = 0xb2e,
+};
+
+static int mlx5ctl_alloc_uid(struct mlx5ctl_dev *mcdev, u32 cap)
+{
+	u32 out[MLX5_ST_SZ_DW(create_uctx_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {};
+	void *uctx;
+	int ret;
+	u16 uid;
+
+	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
+
+	mlx5ctl_dbg(mcdev, "%s: caps 0x%x\n", __func__, cap);
+	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
+	MLX5_SET(uctx, uctx, cap, cap);
+
+	ret = mlx5_cmd_exec(mcdev->mdev, in, sizeof(in), out, sizeof(out));
+	if (ret)
+		return ret;
+
+	uid = MLX5_GET(create_uctx_out, out, uid);
+	mlx5ctl_dbg(mcdev, "allocated uid %u with caps 0x%x\n", uid, cap);
+	return uid;
+}
+
+static void mlx5ctl_release_uid(struct mlx5ctl_dev *mcdev, u16 uid)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	int ret;
+
+	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
+	MLX5_SET(destroy_uctx_in, in, uid, uid);
+
+	ret = mlx5_cmd_exec_in(mdev, destroy_uctx, in);
+	mlx5ctl_dbg(mcdev, "released uid %u %pe\n", uid, ERR_PTR(ret));
+}
+
+static int mlx5ctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	int uid;
+
+	/*
+	 * New FW supports the TOOLS_RESOURCES uid security label
+	 * which allows commands to manipulate the global device state.
+	 * Otherwise only basic existing RDMA devx privilege are allowed.
+	 */
+	if (MLX5_CAP_GEN(mcdev->mdev, uctx_cap) &
+	    MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES)
+		mfd->uctx_caps |= MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES;
+
+	uid = mlx5ctl_alloc_uid(mcdev, mfd->uctx_caps);
+	if (uid < 0)
+		return uid;
+
+	mfd->uctx_uid = uid;
+	return 0;
+}
+
+static void mlx5ctl_close_uctx(struct fwctl_uctx *uctx)
+{
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+
+	mlx5ctl_release_uid(mcdev, mfd->uctx_uid);
+}
+
+static void *mlx5ctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	struct fwctl_info_mlx5 *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uid = mfd->uctx_uid;
+	info->uctx_caps = mfd->uctx_caps;
+	*length = sizeof(*info);
+	return info;
+}
+
+static bool mlx5ctl_validate_rpc(const void *in, enum fwctl_rpc_scope scope)
+{
+	u16 opcode = MLX5_GET(mbox_in_hdr, in, opcode);
+
+	/*
+	 * Currently the driver can't keep track of commands that allocate
+	 * objects in the FW, these commands are safe from a security
+	 * perspective but nothing will free the memory when the FD is closed.
+	 * For now permit only query commands. Also the caps for the scope have
+	 * not been defined yet, filter commands manually for now.
+	 */
+	switch (opcode) {
+	case MLX5_CMD_OP_POSTPONE_CONNECTED_QP_TIMEOUT:
+	case MLX5_CMD_OP_QUERY_ADAPTER:
+	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
+	case MLX5_CMD_OP_QUERY_HCA_CAP:
+	case MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_ROCE_ADDRESS:
+		return scope <= FWCTL_RPC_CONFIGURATION;
+
+	case MLX5_CMD_OP_QUERY_CONG_PARAMS:
+	case MLX5_CMD_OP_QUERY_CONG_STATISTICS:
+	case MLX5_CMD_OP_QUERY_CONG_STATUS:
+	case MLX5_CMD_OP_QUERY_CQ:
+	case MLX5_CMD_OP_QUERY_DCT:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS:
+	case MLX5_CMD_OP_QUERY_EQ:
+	case MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_FLOW_COUNTER:
+	case MLX5_CMD_OP_QUERY_FLOW_GROUP:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE:
+	case MLX5_CMD_OP_QUERY_GENERAL_OBJECT:
+	case MLX5_CMD_OP_QUERY_ISSI:
+	case MLX5_CMD_OP_QUERY_L2_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_LAG:
+	case MLX5_CMD_OP_QUERY_MAD_DEMUX:
+	case MLX5_CMD_OP_QUERY_MKEY:
+	case MLX5_CMD_OP_QUERY_MODIFY_HEADER_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PACKET_REFORMAT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PAGES:
+	case MLX5_CMD_OP_QUERY_Q_COUNTER:
+	case MLX5_CMD_OP_QUERY_QP:
+	case MLX5_CMD_OP_QUERY_RMP:
+	case MLX5_CMD_OP_QUERY_RQ:
+	case MLX5_CMD_OP_QUERY_RQT:
+	case MLX5_CMD_OP_QUERY_SCHEDULING_ELEMENT:
+	case MLX5_CMD_OP_QUERY_SPECIAL_CONTEXTS:
+	case MLX5_CMD_OP_QUERY_SQ:
+	case MLX5_CMD_OP_QUERY_SRQ:
+	case MLX5_CMD_OP_QUERY_TIR:
+	case MLX5_CMD_OP_QUERY_TIS:
+	case MLX5_CMD_OP_QUERY_VHCA_MIGRATION_STATE:
+	case MLX5_CMD_OP_QUERY_VNIC_ENV:
+	case MLX5_CMD_OP_QUERY_VPORT_COUNTER:
+	case MLX5_CMD_OP_QUERY_VPORT_STATE:
+	case MLX5_CMD_OP_QUERY_WOL_ROL:
+	case MLX5_CMD_OP_QUERY_XRC_SRQ:
+	case MLX5_CMD_OP_QUERY_XRQ_DC_PARAMS_ENTRY:
+	case MLX5_CMD_OP_QUERY_XRQ_ERROR_PARAMS:
+	case MLX5_CMD_OP_QUERY_XRQ:
+		return scope <= FWCTL_RPC_DEBUG_READ_ONLY;
+
+	case MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS:
+		return scope <= FWCTL_RPC_DEBUG_WRITE;
+
+	case MLX5_CMD_OP_ACCESS_REG:
+		return scope <= FWCTL_RPC_DEBUG_WRITE_FULL;
+	default:
+		return false;
+	}
+}
+
+static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			    void *rpc_in, size_t in_len, size_t *out_len)
+{
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	void *rpc_alloc __free(kvfree) = NULL;
+	void *rpc_out;
+	int ret;
+
+	if (in_len < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
+	    *out_len < MLX5_ST_SZ_BYTES(mbox_out_hdr))
+		return ERR_PTR(-EMSGSIZE);
+
+	/* FIXME: Requires device support for more scopes */
+	if (scope != FWCTL_RPC_CONFIGURATION &&
+	    scope != FWCTL_RPC_DEBUG_READ_ONLY)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x inlen %zu outlen %zu\n",
+		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
+		    in_len, *out_len);
+
+	if (!mlx5ctl_validate_rpc(rpc_in, scope))
+		return ERR_PTR(-EBADMSG);
+
+	/*
+	 * mlx5_cmd_do() copies the input message to its own buffer before
+	 * executing it, so we can reuse the allocation for the output.
+	 */
+	if (*out_len <= in_len) {
+		rpc_out = rpc_in;
+	} else {
+		rpc_out = rpc_alloc = kvzalloc(*out_len, GFP_KERNEL);
+		if (!rpc_alloc)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	/* Enforce the user context for the command */
+	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
+	ret = mlx5_cmd_do(mcdev->mdev, rpc_in, in_len, rpc_out, *out_len);
+
+	mlx5ctl_dbg(mcdev,
+		    "[UID %d] cmdif: opcode 0x%x status 0x%x retval %pe\n",
+		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
+		    MLX5_GET(mbox_out_hdr, rpc_out, status), ERR_PTR(ret));
+
+	/*
+	 * -EREMOTEIO means execution succeeded and the out is valid,
+	 * but an error code was returned inside out. Everything else
+	 * means the RPC did not make it to the device.
+	 */
+	if (ret && ret != -EREMOTEIO)
+		return ERR_PTR(ret);
+	if (rpc_out == rpc_in)
+		return rpc_in;
+	return_ptr(rpc_alloc);
+}
+
+static const struct fwctl_ops mlx5ctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_MLX5,
+	.uctx_size = sizeof(struct mlx5ctl_uctx),
+	.open_uctx = mlx5ctl_open_uctx,
+	.close_uctx = mlx5ctl_close_uctx,
+	.info = mlx5ctl_info,
+	.fw_rpc = mlx5ctl_fw_rpc,
+};
+
+static int mlx5ctl_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+
+{
+	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = madev->mdev;
+	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = fwctl_alloc_device(
+		&mdev->pdev->dev, &mlx5ctl_ops, struct mlx5ctl_dev, fwctl);
+	int ret;
+
+	if (!mcdev)
+		return -ENOMEM;
+
+	mcdev->mdev = mdev;
+
+	ret = fwctl_register(&mcdev->fwctl);
+	if (ret)
+		return ret;
+	auxiliary_set_drvdata(adev, no_free_ptr(mcdev));
+	return 0;
+}
+
+static void mlx5ctl_remove(struct auxiliary_device *adev)
+{
+	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&mcdev->fwctl);
+}
+
+static const struct auxiliary_device_id mlx5ctl_id_table[] = {
+	{.name = MLX5_ADEV_NAME ".fwctl",},
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, mlx5ctl_id_table);
+
+static struct auxiliary_driver mlx5ctl_driver = {
+	.name = "mlx5_fwctl",
+	.probe = mlx5ctl_probe,
+	.remove = mlx5ctl_remove,
+	.id_table = mlx5ctl_id_table,
+};
+
+module_auxiliary_driver(mlx5ctl_driver);
+
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
+MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 8bde0d4416fd55..49a357e1bc713f 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -42,6 +42,7 @@ enum {
 
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
+	FWCTL_DEVICE_TYPE_MLX5 = 1,
 };
 
 /**
diff --git a/include/uapi/fwctl/mlx5.h b/include/uapi/fwctl/mlx5.h
new file mode 100644
index 00000000000000..bcb4602ffdeee4
--- /dev/null
+++ b/include/uapi/fwctl/mlx5.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ *
+ * These are definitions for the command interface for mlx5 HW. mlx5 FW has a
+ * User Context mechanism which allows the FW to understand a security scope.
+ * FWCTL binds each FD to a FW user context and then places the User Context ID
+ * (UID) in each command header. The created User Context has a capability set
+ * that is appropriate for FWCTL's security model.
+ *
+ * Command formation should use a copy of the structs in mlx5_ifc.h following
+ * the Programmers Reference Manual. A open release is available here:
+ *
+ *  https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming-manual.pdf
+ *
+ * The device_type for this file is FWCTL_DEVICE_TYPE_MLX5.
+ */
+#ifndef _UAPI_FWCTL_MLX5_H
+#define _UAPI_FWCTL_MLX5_H
+
+#include <linux/types.h>
+
+/**
+ * struct fwctl_info_mlx5 - ioctl(FWCTL_INFO) out_device_data
+ * @uid: The FW UID this FD is bound to. Each command header will force
+ *	this value.
+ * @uctx_caps: The FW capabilities that are enabled for the uid.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_mlx5 {
+	__u32 uid;
+	__u32 uctx_caps;
+};
+
+#endif
-- 
2.45.2


