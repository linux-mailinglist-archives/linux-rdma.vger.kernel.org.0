Return-Path: <linux-rdma+bounces-3234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D2590B4B4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE831C21258
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A699C16EB54;
	Mon, 17 Jun 2024 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZhIk7L8C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62B153511;
	Mon, 17 Jun 2024 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636969; cv=fail; b=MBg1XD8Y44o/aK39YvU5PpfSQMeu/DKO+St+iXboeKdGtNIpwp6+KIVnzWMV2Tvj3qBvssIbNq2xM9s4H0h8X5n2jDRY9MM4H8Z77mqa+QMRRjvwvCz/+3XUnkphmsSsqUWsSF2liI4+jPLeV/EpkzBsdfTXHmi4JWWrhklxJEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636969; c=relaxed/simple;
	bh=nGrkEuM6V+w5uB7BA28bNQiRi0JlbeBt8uw3GSdO/i4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GJ7h1p5g/3zm/bCwzkCDoKxSRlvZbHehyUz07Fnzc47qg6/Q2NW+XxG4iHWRk8sHClTJvqr2NkeTRyNidmCwyOV8l2XU0MS1Mqc4IG3pnGzHivp82H2otXfjM5Mv9CvZqyf+LD4QR4eD5Dtb/yN2Uypo/bGmv6WSi9dML5kXxZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZhIk7L8C; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7aV66aVW8/WiLJv2IC3pBuUg6oM8f/LV7Ui6nZ2PvSujXdBhPQ/j4x+bcCzq//LEQTY/u0Gw3qh39NteOMN0io0mf7IQoLv34DRY9fGqPjZOLlNzYZaLTj2y6KZ3mzC/EfSI53pP8xJX7PGusLmiMB6plvn7uS03A3bz4dzgF+aEhiYTRwxP0ZA9nD+N++TeK7xAGngNWZngsQ+gPN+qfKfLlB4zH6WHWJTA/okQdmbSHgH3JxiR6Bu5i5MUsDnGT4hRi4OjWdB1cjMAkOZwIG6BunUDwNNC9FtqskNtqONTQgS+ihkOUUBiZlHK6mRo8jD27y72Yeh8CGJtGq6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBnCTbq4ZFBVLXlkrqTHPkFV/4UN4TiMr0Pk3hG0w2c=;
 b=PchHgmbvUi9WURRkamqO76XbqUo5NBVMn7WLBYQBShRvYGHUG1V0eZ+vMivkdz2zX3/vs5nhe7OQFRkZksaLDkS3tNtQEQcjoC9RliQghu610kLewPK1GMit/4jjWIbSbM2bcnzL/pD28PhKPMQe3rkPaziK93VATdfw13o+4zZngjlfJeZPXwXe6hP9F/Se+pZcLheNAKCK9z7LgzDI/GF2Lr8Y6JNuDEJiMgNuUUa6wl2lh2ZyB/bNguC36BE5DHRqKK3CwwJGCannVdiUDK+1yOO+G19AQqbWBZaZBOT+8CRlVETTfXeneHysf1+zJEh5A4CGwIW8KeCFw7K58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBnCTbq4ZFBVLXlkrqTHPkFV/4UN4TiMr0Pk3hG0w2c=;
 b=ZhIk7L8CfkS3NK3FsqzafukzYEqBU+tSJI5460DhY5+4LxhllEGfoki/SsaUdA9XocEb6e7gCNL76xiJQZ1GW3/NiaBY4a0270VqHOYa/+XnOSrofrDb4bWqq/0dM+/HKeQbpqSyEto+dTl0SYthiMtWehwaBh34vqpwzOniTfnsp8TggWzwsh6TZuLjGrIdsBviZjfELKeyNJm91IqbqVbJ6ZGbdaddiLhedD9lNC/YwcmoAaYq1QvojT4ndIbLRL1TMLya+UYtj2eAsoiBMzZ8V/dSLfpZSQ+B0WmS9JMTpuY7XOYv5fex4apGBK0HkhmZPYNl8E9A9Fj+2z31sQ==
Received: from SA1PR04CA0003.namprd04.prod.outlook.com (2603:10b6:806:2ce::7)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:23 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::6b) by SA1PR04CA0003.outlook.office365.com
 (2603:10b6:806:2ce::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:09:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:09:10 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:09:07 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:55 +0300
Subject: [PATCH vhost 21/23] vdpa/mlx5: Re-create HW VQs under certain
 conditions
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-21-8c0483f0ca2a@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f249845-61e2-4aa7-da77-08dc8edf78a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkNtQWtLNEFOL3ZPTWcyalZKSFI1T3g0S0hIQmpSWXZtTjhvaGFNb04zR2FL?=
 =?utf-8?B?L0Z0eEZYWmlRVW9yUXZjc09GenNNYkZVMmpVZVlBMWhvZnZSVGhtYlBIZENv?=
 =?utf-8?B?eG1NZ3k3QjJLRnFsZGt0bm01S1NCYkx1R2VkY3RZOWtMa0pJaDVEQmU3UEM5?=
 =?utf-8?B?dVJBUDBXNE9vZFRISkI1bGhkTlBXOVJlRHVSWFpwRSsrMFZmRFRDK3ozbFY2?=
 =?utf-8?B?dVlBN05pdlVHQ0Ixb0x4Wk5tbHZMekIxNjNCczZFaUtGUVpBd3lQSGxDb0k4?=
 =?utf-8?B?TTAvM21jSm1vMGNpbVcrVk5MQnlBNFJ1UjhWeXF0U0gxZys0R1hCYjU2bFhL?=
 =?utf-8?B?N1F3a011QTRVUXozOVBvSE1PWW54cDZCSGFZUHVXMkhZZmtUNFBHZzhNU25q?=
 =?utf-8?B?Mi9vMlVFdHh5SEJCcU8zVXdvMCtjWk1RSlhUK29vUzNrVklVWVp6ZzBoSGJo?=
 =?utf-8?B?cjYxRmNCVW5rUElSTzVoeFR1Nlcva3FmcnNPRW1OUVJrcDRLbkhVZ1E2T05N?=
 =?utf-8?B?dVZqdmpnMk9MOU45K0FlR21zbllZTUJKdktZQm9LdGYvYWpzRHhmU3RQVDhP?=
 =?utf-8?B?ckE2L1ZpSlk2dExqQU85TUtZdlgyRUlZNFBWdmwyb0JTK3lmQ1ZocFhlV2pZ?=
 =?utf-8?B?dTNyaGxXdFBuNzR5RHU2dkVTVzJXQlNPcHZiR3E5TlVrNjlBN1VPbUpFN1BK?=
 =?utf-8?B?Zmw0QW1velFsakJ4UExQSHlybW9pNFQwNk8rT1dhYTVWVDlibHFmYTVDZGE5?=
 =?utf-8?B?ODJLL2tsMVhDWjJLeVpTdk4xbkhiVnlXNTd3NGMyUC9XS0J0R2pJejdoM2R6?=
 =?utf-8?B?RFRlYmZpcUlBU2ZoNFF5UjF5U0crVkMvK0FSZHpFREFyZzNEWkZqOW9mTHRV?=
 =?utf-8?B?bTJwK2J2NWJaNmVlV1BtTFUrSEdSbEwvUTJwZGwzdGhNRUFJL2NvQUlZTmRI?=
 =?utf-8?B?dTZwL3FoWlJZS3gzYlZQY3hnZmtNY1RxK0YvYlRpS3VmVkFuL05GL0N3MG5l?=
 =?utf-8?B?UlRSVjBHVTkzSTgxQ0RUdkdNYTRscWJHU1YvZkJwdmt2YTErUGZsY0hZdlNs?=
 =?utf-8?B?YWU2R0dHSCtjVE9zWE9iU21PZHNTOFJGaXIyTndPZlg2TkNXZ0wxNUllb1hp?=
 =?utf-8?B?MGRHU3ppME9GQW1LeUUvS054NHovTnIrNDdLdXlDVVBMM0xiMFlxSERaekxG?=
 =?utf-8?B?UjFEZXk2ZjRsWE4yUC9wS0syRmNIY1dTb1ZPM1JwK3MzYytpb1lvMDVCOXNF?=
 =?utf-8?B?SnAvbGs4MnhyTEJqMVMrUXZYdHJYVVNuUmRncllid2U3T1dZeDN0MEpOSzIy?=
 =?utf-8?B?L29YVDZkd0gwQzZjRUpJUXFEcVZKb2NQbkNZTVRVQ2c0d2N2TUQ0aG80UXZM?=
 =?utf-8?B?YWIvVjdKckJFUFJsbWdUaFpUOWt0cWtOVzFpSUNiUVBmRVI4T09YYVloWVFu?=
 =?utf-8?B?NjJUWjArWHBIZk1xazFkclBTRGJFc1g0TkNBbFh0WGgzazhXSjltbnoxSWRS?=
 =?utf-8?B?SldObVVUSWVWcTY4SXhabWZNU0ZkNWovTEl2QTBlamJ2K3ZneU4vVndCT3Rv?=
 =?utf-8?B?K1JIQ3BZY2liUUYzUFRuQ0lwS1lqa1NvNkIxV0dwcm9JNlVBRjZvOG5xOUdp?=
 =?utf-8?B?V2NsTGlXMHpJK2s2L1RMQjVTd2c4eHA3T2tXbC9SR3JUODdJOWhyLzRNVDF1?=
 =?utf-8?B?TUVoVEJaTXBYUjZJWDQzWDk3Y3lRQ081bVVYb2taRWdCN0cyNDY1VHpCOXZ4?=
 =?utf-8?B?dldmRzJrMjRpYStoMTYwMzk3SzVKeUtQRkZ1YkR3ZXFPTDYyNVJZUm9OYjMw?=
 =?utf-8?B?dnR6R3lQVUp5aFk4Vjd1UEYzVll0THgyUlhHaGt0M2ZBeW1zRGJOckxwRUpy?=
 =?utf-8?B?RHRwL3JCRHpybUVqS05KRVlBZ0JudlEzcmhuNi9Sam5xOVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:23.0551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f249845-61e2-4aa7-da77-08dc8edf78a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

There are a few conditions under which the hardware VQs need a full
teardown and setup:

- VQ size changed to something else than default value. Hardware VQ size
  modification is not supported.

- User turns off certain device features: mergeable buffers, checksum
  virtio 1.0 compliance. In these cases, the TIR and RQT need to be
  re-created.

Add a needs_teardown configuration variable and set it when detecting
the above scenarios. On next DRIVER_OK, the resources will be torn down
first.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++++++++++++
 drivers/vdpa/mlx5/net/mlx5_vnet.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b2836fd3d1dd..d80d6b47da61 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2390,6 +2390,7 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
         }
 
 	mvq = &ndev->vqs[idx];
+	ndev->needs_teardown = num != mvq->num_ent;
 	mvq->num_ent = num;
 }
 
@@ -2800,6 +2801,7 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	u64 old_features = mvdev->actual_features;
+	u64 diff_features;
 	int err;
 
 	print_features(mvdev, features, true);
@@ -2822,6 +2824,14 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 		}
 	}
 
+	/* When below features diverge from initial device features, VQs need a full teardown. */
+#define NEEDS_TEARDOWN_MASK (BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) | \
+			     BIT_ULL(VIRTIO_NET_F_CSUM) | \
+			     BIT_ULL(VIRTIO_F_VERSION_1))
+
+	diff_features = mvdev->mlx_features ^ mvdev->actual_features;
+	ndev->needs_teardown = !!(diff_features & NEEDS_TEARDOWN_MASK);
+
 	update_cvq_info(mvdev);
 	return err;
 }
@@ -3038,6 +3048,7 @@ static void teardown_vq_resources(struct mlx5_vdpa_net *ndev)
 	destroy_rqt(ndev);
 	teardown_virtqueues(ndev);
 	ndev->setup = false;
+	ndev->needs_teardown = false;
 }
 
 static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
@@ -3078,6 +3089,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
+
+			if (ndev->needs_teardown)
+				teardown_vq_resources(ndev);
+
 			if (ndev->setup) {
 				err = resume_vqs(ndev);
 				if (err) {
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
index 2ada29767cc5..da7318f82d2a 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
@@ -56,6 +56,7 @@ struct mlx5_vdpa_net {
 	struct dentry *rx_dent;
 	struct dentry *rx_table_dent;
 	bool setup;
+	bool needs_teardown;
 	u32 cur_num_vqs;
 	u32 rqt_size;
 	u16 default_queue_size;

-- 
2.45.1


