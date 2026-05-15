Return-Path: <linux-rdma+bounces-20775-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIpnFP9YB2pmzgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20775-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:33:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31520555370
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E7A1304BB75
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3805A3F8707;
	Fri, 15 May 2026 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pyHtBBXG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2B3DE436;
	Fri, 15 May 2026 17:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866216; cv=fail; b=seZwinPncLzHlEho3wVzVy82GZiheIusYfyEgp+wAHBe5ioCh6X0gHOSDsc4NZ2eZ8fgJ+92enh8LLDP2rnH1pCIzTOuT5rFtrBCeYWz+6xQBCu7Vw3/jiOWjGJIGvHyJBDE5ks0D+j4DpfMhcqCx1ZPBSsL16Vkg+vL+m7G1j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866216; c=relaxed/simple;
	bh=lggE1rtPfHtoUGHC9J94m+26DqukC/fBcuL/Chf0dTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pS9FP99QeFB5mexhcm2ktOVAwbYzYF5IAk5Z3pSmSWMbFEiTLHRAdL7/ll/QWLbVoOpjlX+MYmceXgQb4EsDsVE/Js0stlKbwk9VdlCO7hivW9fAD7flF5n5dRupXYFlhHoBMCXEXtXhLZ/yYEpH0EKknBZ9pmU0od4+RxDPad8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pyHtBBXG; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOkuRnbSDdHzmhFpfL545ZpvhSbaiLKZWR5FoolBrChJG7SU7aFO5Y/XWKWYTHWxDWHuNoYtU2qJBRpHabEAJNsGlc89J412HtSeZclg7YU8HAPwXKUSi336y/YuLrZlMcd4OJCfKLuhu6N5lMTPVqqw+x1Qy6ZIjJpr9JQazfpFm9Q+Vm0CrOe7oNELyn/eVoZlgt05LK22bqren9UIrZsHstSrqbiufWg/FkHp+LwCZrEQ+wGPc7RcVhHphWvl9EQrbkTELon4FSLwLjppXUU2uBEaKoUIHymjnRn0ykbVQvxhw6vOxGLkSjYqOmu3gyCN733bMF3MK3FRsXG9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH8QTgzVEvwVn1J023aYxR41RTUe2ha67t2tbOgrUHk=;
 b=fv6DXOSMDTgHo5/xpl3sHlCmZxu+lJI8mPo2pgrIgzFM627fB7Lr3N+Bs4l3WtSVphj7i0B5YS9npmKhGweqBdK3HgfJBt28rv5RBjrPJfo2D8SLw4KuLIlGMuhLLOn7JYix03AVDFNBh9oqjbAhZn3T/+SGc9lMYKblPHitOfDl6sLQdfijAgqXA/9vL0Y005xWtVGZjP5ZTcT6uv1KuHltiKyjj/trsIJT30OixOTkZ3c6E+CQctjnIG2h/mejBv34gzBNet2Pzx9WC6h7yC/4MgYpkRmuH8UM3l8BiOcDRrmUkHePnGGf8aVyphea/IU4UX/e2Awn3ucyNNfixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH8QTgzVEvwVn1J023aYxR41RTUe2ha67t2tbOgrUHk=;
 b=pyHtBBXGTh2P8dRhPVz6p5VY0TRg1q07yGX1WuU0xAA6Va/4uJzrJpJUmBRWJ+019skVKyE7fS0n30nJpuGqG+TdR4Rw5wFw5Ah8mU8kDNKNmBZTB5v45mZkdp03MekmTj7VS9xylxVSRARUbEl8D7Wnm2pzixRBSEJqR+H5F9cdHFknVxta2WZxjaossCkiVrupsrY/2eISbe9NZyNFhj3P3y61WF4XkoBLN/GtbbFLXBicVRwVJWallUSvWvgRGYTt9DahDDOa+X7LWOVz/amK59gS3Qf8enOpStMTx08khf+9w2iUMTb1cPJbEdKTXka4vvqM5pTKzbXPBgXB4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:10 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:10 +0000
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
Subject: [PATCH v2 04/11] net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
Date: Fri, 15 May 2026 14:30:01 -0300
Message-ID: <4-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 72251ac3-0ca0-4b48-f8b5-08deb2a79ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	tzx6XkrIR4ch8NYgczy/63strp4xE3hh5EXyaydJIHAH/opC9eGSkl9YpsQ9aWS8EzrodUzXODW00EpaL6oX5TZhoaCjp8wXLRBH89PZgXbdgGVb6yzNcrqwlMERWJ+FjIXjhUEgArSAeJ9pl80oCYr1B4YTm607JIzOsV361pWSVzVx6q22jGrK6sgVcCANbYPJAykJGSeWhgehy7pEtvZwVjA92xUnihHhAECJZC4/QuZpSMIR5pdtBzFnd4KS3rshf+76oR5LwDUfehr658CC3vGdNbk3jCKR7iihUHkBU3fBZMXSQUlPMliltlf45dQguDATl6zLgF4JUke/pYK79KtyhZ3Qz20c2lKyEkagyETHb2xgOpdiuepodlP/I2sET0OjhJTY9FsY0p1XKeycRZBg6cLEiItBAqrNwpSZpLrTpEhBKbctqUNqfK6wBbJMSTWnZO9ToeQpPUapXl+WK1UaBPodu1Ux0HAaNsbEN6Rp1qtGfjf/jF9tCmEsYIBIxm3GHuVyk3qACAfpD7AQl6+EwxVCJ6J8KARWmkzU4SEnai7/ZeOiX4TmWWhjzIwp+iQcEA+4uW5bnFLuOuzE2QgWoiSyjxASldvGkY1cJbVokICcFZlhKS8Db+QsBZkvkONg/4Qk0cLJlrle5lIN8A843+FACK3tP9mgUqpjWmTYsW1G4Amo2XK94yFyv7OpAEFt+arQrFfrwtiQof2Vbe2JmSFc9S5/3/U0eYU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsZ9gocu8v6NIkenTKYHrDWGDAh9hH2N7Mv+FQ6eQew8nvu6p02ffj2QZw4X?=
 =?us-ascii?Q?CDZLTgyv/X5JGyQGTstD7RCdFSUWXEVi+SZ4zQxTCD/O4dOo7Oa/mSJdXDu7?=
 =?us-ascii?Q?sDmtJzu8wxoRxLXxOd2GiliPHCUIAWVvAKxaOgwiasWsHqwub5YC4DRL4SPB?=
 =?us-ascii?Q?QHTzYgc9dG6HNn9tgrqfIwiS7sW9Qs1dv8dxx+It/giH7PyUUw6ovWYj9wvX?=
 =?us-ascii?Q?e+kWUPpH/rs4kd5b7x7t4PRpe34ArS80t9Rfk4I821xZXHeHUEM6jWxlbfQQ?=
 =?us-ascii?Q?Yq9VF0D5I55UCNXvzzSPoJd1s6pE3i7T4et67n7o4gHE8jy3Zgz+uAC/2BZR?=
 =?us-ascii?Q?kG9yfb7pt+ENzg4JkbkXHFhOPZS3JUtxSrnIHrkVlKUcDaGsJgod/R4VzYI8?=
 =?us-ascii?Q?csHV7dmENh+PPASR2XXCcOcQOiqlEv3+7jSm23ytOKTzfmdbp0RixC+rVWtr?=
 =?us-ascii?Q?j5F2EYNSXIExA4eJn/K5jN8JKgw+72AP6IpTeZsQU78HV+I+UWumh5n/G7Bx?=
 =?us-ascii?Q?yCZKZlv4DXHKqB9qiH2l1ztu+BFFxtfoMVbWNcymE7I9BLTtJKqmPauPSKZs?=
 =?us-ascii?Q?CS+xGF0jm+Hnb3Cdyo7/F29njIiZuYxvHJuRp68ZWL6Xa38M+zqsSZ8E1CXS?=
 =?us-ascii?Q?QAk6tHogs4cygvuucAUTpj3E7TArX3MPcf623U40JSgqN1WRV+gTt+Uu7XEs?=
 =?us-ascii?Q?Cbqpxl61dcahW1dbLzUxHN7v5ApNG1FiZIBlTUuk8KUHkkjRDY+NAlvoJ+us?=
 =?us-ascii?Q?czrn1jJnidzxqc/bs/avXX012FWJWPKze9jfXCukassMTFlehd076JEsxSNo?=
 =?us-ascii?Q?e9qIv+yVbwAE4zYTFtTZD3wedJOMhtpnSx7uMewuuMK/K7Xup77i5uPDlwFk?=
 =?us-ascii?Q?5ItFj6d+j8K57woMXF1TjNwwKLN4ghOU28KFZmLoFVzCPzTOzQu6mcpY82sv?=
 =?us-ascii?Q?t0kwWw8BrmpgyglnVQcfNsxCfWZKOByYklcKv98gJ6JBivjQ1Y6v0fCRrDkQ?=
 =?us-ascii?Q?D4QORbz0+sK0Lq2huZLZxjIOHFolLdzvWwDl+FUu00o6w586wrTO8arigFQE?=
 =?us-ascii?Q?tsEtUbC0ac6SG4ECyLBECiJJLLT56W0GKcN5h1vfCykfbwJ05VlOx3IlhWUx?=
 =?us-ascii?Q?Nl0UyWXyIRM0Vl0zjTvS3dDbV89eGuHpOdHXr23EY84p7x710JkenaF0fsTi?=
 =?us-ascii?Q?c8poEibS9wsTUfryev0pcKD/zM63s/eE2+NjpmCFVJxjWNTJFw/VjtTNvWbL?=
 =?us-ascii?Q?lzvnwaabeZXT4ucYCXXshpiVhOYOnsImL5+STGWuWoFGQG0DaVTdOfXWitKm?=
 =?us-ascii?Q?5albFxkyoOSADj+mefNC0xjiemkN5jMPQ7+s7GcG1yP1okNNf0Okql3svsNB?=
 =?us-ascii?Q?73VwFopFw+N0OijYUnqsJZT5MhZv8IPw/t6p/TR3OIYicvdbMSNcHV+Pbobg?=
 =?us-ascii?Q?pIol1b5GW9z4KI1pvFmX+dIjS7gWxD3wlDVv5dC51gadZjZpXaqnswG5inRY?=
 =?us-ascii?Q?1pON6Ozng09984dz+gFxffA7KY1+bwliutfM3YMy2gJFvdx2ZyfV8Y2csl7W?=
 =?us-ascii?Q?dHQfNW31n3QqkEy8/Q4tSEooideY1mg5fZO/EaLjDrp2P5MFtQWg90M881bQ?=
 =?us-ascii?Q?mzIwtG5kzffii/aVr3hgvNwyTsqa/1v0dKNhN7eojoHWBE9K1qMvxbuDKnnJ?=
 =?us-ascii?Q?LAbtPcf+BeK0vsldql5bR8US2Rbf5DAOGmlnrcKvzTFbtH8K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72251ac3-0ca0-4b48-f8b5-08deb2a79ca4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:09.3440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7Oa5O0bLr3QglnuNjljY+r6H9xWbP5uY7xpmTsMWfb9VRNjKnGMwPYaJAppXmBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: 31520555370
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20775-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Action: no action

Add MLX5_GET_ONCE / MLX5_SET_ONCE which include READ_ONCE/WRITE_ONCE
semantics for touching ownership bits that hardware may read or write
at any time. The kernel driver doesn't use the IFC struct for these
ownership bits, but the VFIO driver will and needs these helpers.

Add MLX5_GET_MMIO / MLX5_SET_MMIO for accessing the init seg using
the IFC offsets. They embed a readl/writel using the IFC struct to
generate the addressing.

Add MLX5_ARRAY_GET64(), the missing counterpart to
MLX5_ARRAY_SET64().

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc_macros.h | 52 ++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/include/linux/mlx5/mlx5_ifc_macros.h b/include/linux/mlx5/mlx5_ifc_macros.h
index d357acfd351de2..be963b9ad5b295 100644
--- a/include/linux/mlx5/mlx5_ifc_macros.h
+++ b/include/linux/mlx5/mlx5_ifc_macros.h
@@ -85,6 +85,13 @@ __mlx5_mask(typ, fld))
 	__MLX5_SET64(typ, p, fld[idx], v); \
 } while (0)
 
+#define MLX5_ARRAY_GET64(typ, p, fld, idx)                                   \
+	({                                                                   \
+		BUILD_BUG_ON(__mlx5_bit_sz(typ, fld) % 64);                  \
+		be64_to_cpu(                                                 \
+			*((__be64 *)(p) + __mlx5_64_off(typ, fld) + (idx))); \
+	})
+
 #define MLX5_GET64(typ, p, fld) be64_to_cpu(*((__be64 *)(p) + __mlx5_64_off(typ, fld)))
 
 #define MLX5_GET64_PR(typ, p, fld) ({ \
@@ -130,4 +137,49 @@ __mlx5_mask16(typ, fld))
 		tmp;							  \
 		})
 
+/*
+ * Use READ_ONCE/WRITE_ONCE for a single field that hardware may read/write
+ * unpredictably, mostly owner bits. All other bits in the DW must be stable.
+ * Usually a dma_wmb() will be required before a write and a dma_rmb() after a
+ * read.
+ */
+#define MLX5_GET_ONCE(typ, p, fld)                                              \
+	((be32_to_cpu(READ_ONCE(*((__be32 *)(p) + __mlx5_dw_off(typ, fld)))) >> \
+	  __mlx5_dw_bit_off(typ, fld)) &                                        \
+	 __mlx5_mask(typ, fld))
+
+#define MLX5_SET_ONCE(typ, p, fld, v)                                      \
+	do {                                                               \
+		u32 _v = v;                                                \
+		__be32 *_dw = (__be32 *)(p) + __mlx5_dw_off(typ, fld);     \
+		BUILD_BUG_ON(__mlx5_st_sz_bits(typ) % 32);                 \
+		WRITE_ONCE(*_dw,                                           \
+			   cpu_to_be32((be32_to_cpu(READ_ONCE(*_dw)) &     \
+					(~__mlx5_dw_mask(typ, fld))) |     \
+				       (((_v) & __mlx5_mask(typ, fld))     \
+					<< __mlx5_dw_bit_off(typ, fld)))); \
+	} while (0)
+
+/* Access MMIO registers, usually the init segment, using IFC structs. */
+#define MLX5_GET_MMIO(typ, p, fld)                                         \
+	((ioread32be(((__be32 __iomem *)(p) + __mlx5_dw_off(typ, fld))) >> \
+	  __mlx5_dw_bit_off(typ, fld)) &                                   \
+	 __mlx5_mask(typ, fld))
+
+/* The set is not relaxed so there is an integrated dma_wmb(). */
+#define MLX5_SET_MMIO(typ, p, fld, v)                                         \
+	do {                                                                  \
+		u32 _v = v;                                                   \
+		void __iomem *_dw =                                           \
+			((__be32 __iomem *)(p) + __mlx5_dw_off(typ, fld));    \
+		if (__mlx5_bit_sz(typ, fld) == 32)                            \
+			iowrite32be(_v, _dw);                                 \
+		else                                                          \
+			iowrite32be((ioread32be(_dw) &                        \
+				     (~__mlx5_dw_mask(typ, fld))) |           \
+					    ((_v & __mlx5_mask(typ, fld))     \
+					     << __mlx5_dw_bit_off(typ, fld)), \
+				    _dw);                                     \
+	} while (0)
+
 #endif /* MLX5_IFC_MACROS_H */
-- 
2.43.0


