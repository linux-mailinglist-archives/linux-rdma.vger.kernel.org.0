Return-Path: <linux-rdma+bounces-20783-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAZJAcxZB2orzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20783-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:37:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF15554EA
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74F2F30402D6
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0553E3DC87D;
	Fri, 15 May 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z8QIDS7S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAAB3F8EAC;
	Fri, 15 May 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866225; cv=fail; b=o4qIebvtupc3oejadYP03DgjtJ7q2bKQYe3TE8dh0dUyEihJAkYvWp5Ugcvfgqgv/vxe50zt72C+ygB+P3+yZu79jEYyEnuY+E8CzL5AOtnO1UZNX/WEwaelHoTlHa3TewALaik42uGdZYvBrqwDCtOsQ25u3kkbX7kAr3Yg8b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866225; c=relaxed/simple;
	bh=DZlaWR/YhZ7mz4Lm9B+t7BLspMDIJLMtDrG0+LxL2yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/0l/aVgSKHicy091CoKr1Dh/FtxNBzWRvM6rPCQzjBc2IRtqpENSv6UXny8uQiBWmj9y7IkWZ/ZxqMhQUdVNJF+m5EbgNi2BhblrWhKc/e5Qg8HkpgF/tdKD0eqRwNzmzVFEEsG2oHiSj51kj2VREaQjfRGLeHLRkAnq+NCXyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z8QIDS7S; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJSNrpy2iUjP571iftGV58TxM0m2PzlaYxPyzmAo9hf/s7+3DUJNs2HdEgKsJxFC9JltIoT3PM9ejP3omTBUONkPs0jvpUVG9Ewd4wbDzvKLSN8XtiBK908+hTK2VbMWOimhhn7QhSx+52CaRm6isiyBRu00L8OXujYKlYa/WxfI7+OsRU04VnOh4m5W4j010kwka+3Pvgl0jlqR9oVCJVap/1f91JhwusX7F1AsxgWta8lDACNvxKZNvs3RWZVlMlidCjkBkCdfVShDMkrd0Aeuav+Dm8nzOqgPxMO3YU64RUIggFF0YB8Jg3mf1dYlu6yo6898SzJTE4x1s+XKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ei0ExrkrXLbO40XJuWvqExHfjN9npGNYKh9dRIX6eY=;
 b=HIeMFIiDNZzbqkNDf2HfnUEzWJoRqllsduSIGSTtRK/1Y+BXi2v1Fo9vh3KcqmGPY55xD08tSKoxSEnkx/AhYBVj01YDu6Bs7rwbpu45fvt/giaNFYpK/R2Hp/TDs4S82gGAmSofLA39RZkwlXJ0nalId070B6K/+0F+eLo8zIdxsayb9QRxM/OjheO1f5cECWk1CJj74/mJ9D4USxj4Xw7FgiLGiUUxFISdw+tKrzYCWWAvPEdA64sQapJuyAfOVWP6ZBFf0IP7BUG0aovoY9zQM2Trq61P3aH/GU6G5jhjZXCp3h7sWI1F+upKVNBxODH6gXxJaX4mBtGCbjKmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ei0ExrkrXLbO40XJuWvqExHfjN9npGNYKh9dRIX6eY=;
 b=Z8QIDS7SjFAvcjGpWaNxMkxNknduotkONS9895Pu01cS7PxIgTeK+nFK6N5yPHpOpzWlcoirp+aeIVONWHDCY1DO1AGQHTDZ2a4T8sgVqyvbA3+7QMTsCMu7XqmTyjXBEd1Ha7mJN47hjSHIBn7BzI4uR9QU2o0N07383vuceAN9GQflsKPAKZ7aGBBjSz/RJvzvfcOK3P9rnlflkAsnk7mhSMy8plTZAdIoCHSI+790/45hxxqMEgeIVkJjObusGIN+PtwZy/0RwqZ0sPy7IQg7NxAYV415360NwBvCUNZEoGD0fZL7m6Go/XZBPE4PUVtauIuekQZ1ohvlrW1QKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 17:30:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:15 +0000
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
Subject: [PATCH v2 10/11] vfio: selftests: Add mlx5 driver - data path and memcpy ops
Date: Fri, 15 May 2026 14:30:07 -0300
Message-ID: <10-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0010.namprd02.prod.outlook.com
 (2603:10b6:208:530::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 11520db2-fd54-40b3-4b2b-08deb2a79eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	LKTcOmFYyaarKu7vsT9rzoYTtMI7/sDCYS+9CJY/eJCekMcGPc+G2J3b87lPRwlfahzyiZ4FyQ1eBk0og4Qw/N7RPZTEnM+ENnDuABy8fAb2sRP/iEgkc/tlXDFzP7dz9L4Z2c5Ned11Kingxtvag+neItXcB504ABh6YfOIe+CBIUynRI/Sjrlnfl34y46cGkWYPK1wwBy/lAjaNM1pbj1+WWPsn/rEOYbeCgNZ4b9m6BD5JTcIQuwJrxKB0H19SK47+g+tJF+KiloTtT1fiZkJfHg3HFJ93PxokY2srcI+ja8iRqqYIJSfFO5pZB+hPc1IL1stC/0s51LocYGXN3t4bxTaFjMhvCP/KYAJVJPC5EfLQi3CngOSzFLuI4tD9G7r2Tbt6G9pSAxTJ0GsDNocmzgUfmDjYF3kZr2O5R4r65ifZUDDHV/8K129ILpeHTr7vfazm9H1QFIq62EuRk2YvTL+E3Lemes01KOqKjzTMGiKfDz/s4Fs/fsyCbPQLFpEKNRCKGcZBLJhWPjTnP8WTrT5H/dI+a+vxpHk7gZMqudhLPsQRO62Ok/eW/MLqfqW/nFD2ILWH/Fd4DD6ym8ULqhMyCywyPlg5S1XRrehmsB1T/blmygbf/QsHgHfWpj81IgdVtBnU0occFL9wV+YZbIyDIEr65DuLiOYnKbngVRsI0bdyvvAIa2HBWvzcsDDhttyFGgL3FQfKznL+7QGN5VqaBYaPHUgMEa/atI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nX2XDvewcNx/pPaKrAfK8VBhATd7Zq2QoXsa7a67C1C5/cOGLfLQC8Y3HcIi?=
 =?us-ascii?Q?j0Y7+5JAAlfJjO6PE3TJTcLRyzYPCyk5bkRbdW/146cTiXLwxEBG1iuQ7rD4?=
 =?us-ascii?Q?LADt0UWbtcjD1yeZ346Zek3P3tQw9e1DaOaftzOLCzPBVUayQH9ADHJrGPXR?=
 =?us-ascii?Q?QtTDI6CVQTzvW5G+x8IwJ29/fi5JKmmdnsvtns4RLWoKdOZ9YuPv+/efRQ9h?=
 =?us-ascii?Q?lSoZFZFxPIpOTvw5YcQ7IFtM4zMrmFUxQCne7c/mlhG5w87ZMrgZupyjVJtc?=
 =?us-ascii?Q?/Xa/otjCQ/XSwt20wyVgf4s9dITjDMAK821AE8eyyV0Z8LpyPYJsJCa5VBih?=
 =?us-ascii?Q?KzPzFmncs3j2N832ZoMPiPLxSdq5gxa027te+AmpS8sYSdPns1cNhchOQDTV?=
 =?us-ascii?Q?LjDYrbhR2IkVCl3ryktpFEmOH4bU2UMHDahsp+pGFfZ+oHC8WzeCGxyzuzoe?=
 =?us-ascii?Q?LKk1jTg8I8kLFURHrDLqbb+tUWB4FvwFRuMNxAvkagpY9gW3xZi8NxjIzFhM?=
 =?us-ascii?Q?SsfKQKi/EhG2n1TnSUrPhrMdVMTOH74KZlkb7f8w7Izx5XqvLFxCikFCyltB?=
 =?us-ascii?Q?CjBfmge0Fr6m8bF5RSv8Mkca1Rv31qtg5Cr5r/E1WKvwVNvo22YhEbtg8JKs?=
 =?us-ascii?Q?kKB62KPXMGMbXz7qN96QKElmu5qJjbXwRJdlHsl6xlLbSnhu7T2zKYLGG4zb?=
 =?us-ascii?Q?3kaxmuI+NAEELLQKjM45kD2VbmfWk7o9bx0eBPv9IFkhT95neZQ7FrMHIY5a?=
 =?us-ascii?Q?se3WLSi3KYR85B2t21UMUtel1L8VjicsPMIhDV4bmZW554P7szvfU8wN9adS?=
 =?us-ascii?Q?IIGbfkCoINYvlhl/yQI/su9hYWuqqBShhaxBB+HcQ+94t0rm9h7952Atel+4?=
 =?us-ascii?Q?skWrANKfmnCEwxCfB8JxvigZdCFnVhhkRlLOEpX2+WLHqpj45vv7mngKNXD/?=
 =?us-ascii?Q?Vim8JN5b+j+4i7DKucBjh8zJ1Y2uy/FPvDBoRrlFIBwQD51+D4ZAUxUCoJb/?=
 =?us-ascii?Q?cGS96OWbMw87lDun1MrXXr9Lvmbi7hYxBL64UQ+mTh4kZf7FdqmtG/GHAccf?=
 =?us-ascii?Q?vKvd46YXANMh6Db6q5/QCSeKc1zzQbOVTs5eerE6J5UFSaGTvQzoV1B3FeCD?=
 =?us-ascii?Q?qSt1/yTmbFBMxo8k2J3mMYYbQK/kO795LGjjcmxwOyu/9EfWEM1/5OygqFz6?=
 =?us-ascii?Q?l8aF4wHb2qykpWllkI5oJQzZvU+CQKZA7TzlHZxnBw8+Qn6x3B903agZD33c?=
 =?us-ascii?Q?PyCJasTK92RlgqgHuZ011V922jztIns7BqfxlqiQUVndkJI1Y3JqZRmQDSUm?=
 =?us-ascii?Q?63lT/Jh9UC21XMZTC5N9qpnQBZJDunjvJYGEHBfKoIyEnbNJL6AJYC2JH293?=
 =?us-ascii?Q?brEosMoi4z1y3DXCmCoSouNUIZfQowcwphQIZat7CoP6q/iZ8S5B0II3NcJJ?=
 =?us-ascii?Q?bk81glusNSnQc8v1bv9hgEsaB10KT3sqedTbMs2uU9V0/CHMd5UFEDq3UPkJ?=
 =?us-ascii?Q?OMZe28YSIMqN08jGNkV8Wx83XB6VqFmKrhrY1CBJu2Img9S+tahbW100Pq0m?=
 =?us-ascii?Q?lTPcqtzwUCqLCv6rmil5hvJOAcIlsavGVo2shCRIfbDddK6lwOOnAa8NsaL2?=
 =?us-ascii?Q?ixxcEz2uq1+XnPNxlO7i5hI7TAY3MkrovaqvUrurW0jdqmvS9mb+gGk5M+/w?=
 =?us-ascii?Q?85fepRhDFXp9oJkyn7/MKwEhH5ydpg4SB7PFbLXJnA+vTJBV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11520db2-fd54-40b3-4b2b-08deb2a79eef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:13.1895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua5p8Bb/G9CjYoOwVTAw3itBGu498UnjSxEtxMhSYz5Euzg0jJ2h6SiHlscx1Gbq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-Rspamd-Queue-Id: 9CEF15554EA
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20783-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Complete the mlx5 driver by adding CQ/QP creation, QP state
transitions, WQE posting, CQ polling, and the
memcpy_start/memcpy_wait callbacks. After this patch the driver is
functional for DMA tests.

The data path implements RDMA Write self-loopback via an RC QP with
force-loopback.  WQEs are posted to a 16-entry send queue with an
NC doorbell, and completions are polled from a 16-entry CQ.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../selftests/vfio/lib/drivers/mlx5/mlx5.c    | 359 +++++++++++++++++-
 1 file changed, 357 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
index 804801cc564e7a..e5e75adb253166 100644
--- a/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
+++ b/tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
@@ -1343,6 +1343,354 @@ static void mlx5st_destroy_mkey(struct mlx5st_device *dev)
 	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 }
 
+/*
+ * CQ create/destroy
+ */
+
+static void mlx5st_create_cq(struct mlx5st_device *dev)
+{
+	struct vfio_pci_device *device = dev->device;
+	u64 in[MLX5_ST_SZ_QW(create_cq_in) + 1] = {};
+	u32 out[MLX5_ST_SZ_DW(create_cq_out)] = {};
+	struct mlx5_ifc_cqc_bits *cqc;
+	unsigned int i;
+	__be64 *pas;
+
+	/* Initialize CQEs before CREATE_CQ: opcode=0xF, owner=1 */
+	for (i = 0; i < CQ_CQE_CNT; i++) {
+		struct mlx5st_cqe64 *cqe = &dev->cq_buf[i];
+
+		MLX5_SET(cqe64, cqe, opcode, 0xF);
+		MLX5_SET_ONCE(cqe64, cqe, owner, 1);
+	}
+
+	MLX5_SET(create_cq_in, in, opcode, MLX5_CMD_OP_CREATE_CQ);
+
+	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
+	MLX5_SET(cqc, cqc, log_cq_size, LOG_CQ_SIZE);
+	MLX5_SET(cqc, cqc, uar_page, dev->uar_page);
+	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, dev->eqn);
+	MLX5_SET(cqc, cqc, cqe_sz, 0);
+	pas = MLX5_ADDR_OF(create_cq_in, in, pas);
+	MLX5_SET(cqc, cqc, page_offset, mlx5st_fill_pas(device, dev->cq_buf, pas));
+	MLX5_SET(cqc, cqc, log_page_size, 0);
+	MLX5_SET64(cqc, cqc, dbr_addr, to_iova(device, &dev->cq_dbrec));
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+
+	dev->cqn = MLX5_GET(create_cq_out, out, cqn);
+	dev->cq_ci = 0;
+	dev_dbg(device, "Created CQ: cqn=%u, %d entries\n", dev->cqn,
+		 CQ_CQE_CNT);
+}
+
+static void mlx5st_destroy_cq(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_cq_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_cq_in)] = {};
+
+	MLX5_SET(destroy_cq_in, in, opcode, MLX5_CMD_OP_DESTROY_CQ);
+	MLX5_SET(destroy_cq_in, in, cqn, dev->cqn);
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
+/*
+ * QP create/destroy
+ */
+
+static void mlx5st_create_qp(struct mlx5st_device *dev)
+{
+	struct vfio_pci_device *device = dev->device;
+	u64 in[MLX5_ST_SZ_QW(create_qp_in) + 1] = {};
+	u32 out[MLX5_ST_SZ_DW(create_qp_out)] = {};
+	struct mlx5_ifc_qpc_bits *qpc;
+	__be64 *pas;
+
+	MLX5_SET(create_qp_in, in, opcode, MLX5_CMD_OP_CREATE_QP);
+
+	qpc = MLX5_ADDR_OF(create_qp_in, in, qpc);
+	MLX5_SET(qpc, qpc, st, MLX5_QPC_ST_RC);
+	MLX5_SET(qpc, qpc, pm_state, MLX5_QPC_PM_STATE_MIGRATED);
+	MLX5_SET(qpc, qpc, pd, dev->pdn);
+	MLX5_SET(qpc, qpc, uar_page, dev->uar_page);
+	MLX5_SET(qpc, qpc, cqn_snd, dev->cqn);
+	MLX5_SET(qpc, qpc, cqn_rcv, dev->cqn);
+	MLX5_SET(qpc, qpc, log_sq_size, LOG_SQ_SIZE);
+	MLX5_SET(qpc, qpc, log_msg_max, dev->log_max_msg);
+	MLX5_SET(qpc, qpc, rq_type, 0x3);
+	MLX5_SET(qpc, qpc, ts_format, 1);
+	pas = MLX5_ADDR_OF(create_qp_in, in, pas);
+	MLX5_SET(qpc, qpc, page_offset,
+		 mlx5st_fill_pas(device, dev->sq_buf, pas));
+	MLX5_SET(qpc, qpc, log_page_size, 0);
+	MLX5_SET64(qpc, qpc, dbr_addr, to_iova(device, &dev->qp_dbrec));
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+
+	dev->qpn = MLX5_GET(create_qp_out, out, qpn);
+	dev->sq_pi = 0;
+	dev_dbg(device, "Created QP: qpn=%u, RC, sq=%d wqes\n", dev->qpn,
+		 SQ_WQE_CNT);
+}
+
+static void mlx5st_destroy_qp(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(destroy_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
+
+	MLX5_SET(destroy_qp_in, in, opcode, MLX5_CMD_OP_DESTROY_QP);
+	MLX5_SET(destroy_qp_in, in, qpn, dev->qpn);
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+}
+
+/*
+ * QP state transitions
+ */
+
+static void mlx5st_qp_rst2init(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(rst2init_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(rst2init_qp_in)] = {};
+	struct mlx5_ifc_qpc_bits *qpc = MLX5_ADDR_OF(rst2init_qp_in, in, qpc);
+
+	MLX5_SET(rst2init_qp_in, in, opcode, MLX5_CMD_OP_RST2INIT_QP);
+	MLX5_SET(rst2init_qp_in, in, qpn, dev->qpn);
+
+	MLX5_SET(qpc, qpc, primary_address_path.vhca_port_num, 1);
+	MLX5_SET(qpc, qpc, pm_state, MLX5_QPC_PM_STATE_MIGRATED);
+	MLX5_SET(qpc, qpc, rre, 1);
+	MLX5_SET(qpc, qpc, rwe, 1);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	dev_dbg(dev->device, "QP RST->INIT\n");
+}
+
+static void mlx5st_qp_init2rtr(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(init2rtr_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(init2rtr_qp_in)] = {};
+	struct mlx5_ifc_qpc_bits *qpc = MLX5_ADDR_OF(init2rtr_qp_in, in, qpc);
+
+	MLX5_SET(init2rtr_qp_in, in, opcode, MLX5_CMD_OP_INIT2RTR_QP);
+	MLX5_SET(init2rtr_qp_in, in, qpn, dev->qpn);
+
+	MLX5_SET(qpc, qpc, mtu, 3);
+	MLX5_SET(qpc, qpc, log_msg_max, dev->log_max_msg);
+	MLX5_SET(qpc, qpc, remote_qpn, dev->qpn);
+	MLX5_SET(qpc, qpc, min_rnr_nak, 12);
+	MLX5_SET(qpc, qpc, primary_address_path.vhca_port_num, 1);
+	MLX5_SET(qpc, qpc, primary_address_path.fl, 1);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	dev_dbg(dev->device, "QP INIT->RTR (fl=1)\n");
+}
+
+static void mlx5st_qp_rtr2rts(struct mlx5st_device *dev)
+{
+	u32 out[MLX5_ST_SZ_DW(rtr2rts_qp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(rtr2rts_qp_in)] = {};
+	struct mlx5_ifc_qpc_bits *qpc = MLX5_ADDR_OF(rtr2rts_qp_in, in, qpc);
+
+	MLX5_SET(rtr2rts_qp_in, in, opcode, MLX5_CMD_OP_RTR2RTS_QP);
+	MLX5_SET(rtr2rts_qp_in, in, qpn, dev->qpn);
+
+	MLX5_SET(qpc, qpc, log_ack_req_freq, 0);
+	MLX5_SET(qpc, qpc, retry_count, 7);
+	MLX5_SET(qpc, qpc, rnr_retry, 7);
+	MLX5_SET(qpc, qpc, primary_address_path.ack_timeout, 14);
+
+	mlx5st_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	dev_dbg(dev->device, "QP RTR->RTS\n");
+}
+
+/*
+ * Post RDMA Write WQE
+ */
+static void mlx5st_post_rdma_write(struct mlx5st_device *dev, u64 src_addr,
+				    u32 src_lkey, u64 dst_addr, u32 dst_rkey,
+				    u32 length, bool signaled)
+{
+	struct mlx5st_send_wqe *wqe;
+	unsigned int idx;
+
+	idx = dev->sq_pi % SQ_WQE_CNT;
+	wqe = &dev->sq_buf[idx];
+
+	memset(wqe, 0, sizeof(*wqe));
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, opcode, MLX5_OPCODE_RDMA_WRITE);
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, wqe_index, dev->sq_pi);
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, qp_or_sq, dev->qpn);
+	MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, ds, MLX5_RDMA_WRITE_DS);
+	if (signaled)
+		MLX5_SET(wqe_ctrl_seg, &wqe->ctrl, ce, MLX5_WQE_CE_CQE_ALWAYS);
+
+	MLX5_SET64(wqe_raddr_seg, &wqe->raddr, raddr, dst_addr);
+	MLX5_SET(wqe_raddr_seg, &wqe->raddr, rkey, dst_rkey);
+
+	MLX5_SET(wqe_data_seg, &wqe->data, byte_count, length);
+	MLX5_SET(wqe_data_seg, &wqe->data, lkey, src_lkey);
+	MLX5_SET64(wqe_data_seg, &wqe->data, addr, src_addr);
+
+	dev->sq_pi++;
+
+	/* Ensure WQE is visible to device before doorbell record */
+	dma_wmb();
+
+	WRITE_ONCE(dev->qp_dbrec.send_counter,
+		   cpu_to_be32(dev->sq_pi & 0xffff));
+
+	/*
+	 * Ring doorbell: write first 8 bytes of ctrl to UAR BF register,
+	 * iowrite has an internal dma_wmb() so the doorbell record will be
+	 * visible.
+	 */
+	iowrite64be(be64_to_cpu(*(__be64 *)wqe),
+		    (u8 __iomem *)dev->uar_base + dev->uar_bf_offset);
+	dev->uar_bf_offset ^= MLX5_BF_SIZE;
+}
+
+/*
+ * Poll CQ
+ */
+static int mlx5st_poll_cq_batch(struct mlx5st_device *dev,
+				unsigned int max_cqe)
+{
+	unsigned int polled = 0;
+
+	while (polled < max_cqe) {
+		unsigned int idx = dev->cq_ci % CQ_CQE_CNT;
+		struct mlx5st_cqe64 *cqe = &dev->cq_buf[idx];
+		u8 owner, opcode;
+
+		owner = MLX5_GET_ONCE(cqe64, cqe, owner);
+		if (owner != ((dev->cq_ci >> LOG_CQ_SIZE) & 1))
+			break;
+
+		dma_rmb();
+
+		opcode = MLX5_GET(cqe64, cqe, opcode);
+
+		dev->cq_ci++;
+		WRITE_ONCE(dev->cq_dbrec.recv_counter,
+			   cpu_to_be32(dev->cq_ci & 0xffffff));
+
+		if (opcode == MLX5_CQE_REQ) {
+			dev->sq_ci =
+				(u16)(MLX5_GET(cqe64, cqe, wqe_counter) + 1);
+			polled++;
+			continue;
+		}
+		if (opcode == MLX5_CQE_REQ_ERR ||
+		    opcode == MLX5_CQE_RESP_ERR) {
+			dev_dbg(dev->device,
+				"CQE error: opcode=0x%x syndrome=0x%x vendor=0x%x\n",
+				opcode,
+				MLX5_GET(cqe64, cqe, error_syndrome.syndrome),
+				MLX5_GET(cqe64, cqe,
+					 error_syndrome.vendor_error_syndrome));
+			return -1;
+		}
+		dev_err(dev->device, "CQE unexpected opcode=0x%x\n", opcode);
+		return -1;
+	}
+
+	return polled;
+}
+
+static int mlx5st_poll_cq(struct mlx5st_device *dev, unsigned int timeout_ms)
+{
+	struct timespec start, now;
+	unsigned int elapsed;
+	int ret;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (;;) {
+		ret = mlx5st_poll_cq_batch(dev, 1);
+		if (ret < 0)
+			return -1;
+		if (ret > 0)
+			return 0;
+
+		if (dev->have_eq)
+			mlx5st_process_events(dev);
+
+		clock_gettime(CLOCK_MONOTONIC, &now);
+		elapsed = (now.tv_sec - start.tv_sec) * 1000 +
+			  (now.tv_nsec - start.tv_nsec) / 1000000;
+		if (elapsed > timeout_ms) {
+			dev_err(dev->device, "CQ poll timeout after %u ms\n",
+				timeout_ms);
+			return -1;
+		}
+	}
+}
+
+/*
+ * Data path setup/teardown helpers
+ */
+
+static void mlx5st_setup_datapath(struct mlx5st_device *dev)
+{
+	mlx5st_create_cq(dev);
+	mlx5st_create_qp(dev);
+	mlx5st_qp_rst2init(dev);
+	mlx5st_qp_init2rtr(dev);
+	mlx5st_qp_rtr2rts(dev);
+}
+
+static void mlx5st_teardown_datapath(struct mlx5st_device *dev)
+{
+	if (dev->qpn) {
+		mlx5st_destroy_qp(dev);
+		dev->qpn = 0;
+	}
+	if (dev->cqn) {
+		mlx5st_destroy_cq(dev);
+		dev->cqn = 0;
+	}
+	dev->sq_pi = 0;
+	dev->sq_ci = 0;
+	memset(&dev->qp_dbrec, 0, sizeof(dev->qp_dbrec));
+	memset(&dev->cq_dbrec, 0, sizeof(dev->cq_dbrec));
+}
+
+/*
+ * memcpy callbacks
+ */
+
+#define MLX5ST_MEMCPY_TIMEOUT_MS 60000
+
+static void mlx5st_memcpy_start(struct vfio_pci_device *device,
+				 iova_t src, iova_t dst, u64 size, u64 count)
+{
+	struct mlx5st_device *dev = to_mlx5st(device);
+	u64 i;
+
+	for (i = 0; i < count; i++) {
+		bool signaled = (i == count - 1);
+
+		mlx5st_post_rdma_write(dev, src, dev->global_lkey, dst,
+				       dev->global_rkey, size, signaled);
+	}
+}
+
+static int mlx5st_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct mlx5st_device *dev = to_mlx5st(device);
+	int ret;
+
+	ret = mlx5st_poll_cq(dev, MLX5ST_MEMCPY_TIMEOUT_MS);
+	if (ret) {
+		/*
+		 * CQE error puts the QP in error state.  Rebuild the data path
+		 * so subsequent operations can succeed.
+		 */
+		mlx5st_teardown_datapath(dev);
+		mlx5st_setup_datapath(dev);
+	}
+	return ret;
+}
+
 /*
  * Driver ops callbacks
  */
@@ -1373,6 +1721,11 @@ static void mlx5st_init(struct vfio_pci_device *device)
 	mlx5st_alloc_pd(dev);
 	mlx5st_create_mkey(dev);
 
+	mlx5st_setup_datapath(dev);
+
+	device->driver.max_memcpy_size = 1ULL << dev->log_max_msg;
+	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;
+
 	dev_dbg(device, "mlx5 driver initialized\n");
 }
 
@@ -1380,6 +1733,8 @@ static void mlx5st_remove(struct vfio_pci_device *device)
 {
 	struct mlx5st_device *dev = to_mlx5st(device);
 
+	mlx5st_teardown_datapath(dev);
+
 	dev_dbg(device, "teardown: destroy_mkey\n");
 	if (dev->mkey_index) {
 		mlx5st_destroy_mkey(dev);
@@ -1408,7 +1763,7 @@ struct vfio_pci_driver_ops mlx5st_ops = {
 	.probe = mlx5st_probe,
 	.init = mlx5st_init,
 	.remove = mlx5st_remove,
-	.memcpy_start = NULL,
-	.memcpy_wait = NULL,
+	.memcpy_start = mlx5st_memcpy_start,
+	.memcpy_wait = mlx5st_memcpy_wait,
 	.send_msi = NULL,
 };
-- 
2.43.0


