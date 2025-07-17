Return-Path: <linux-rdma+bounces-12276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63657B0916F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 18:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF75416A659
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D73B2FC3C6;
	Thu, 17 Jul 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clYRGTN5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4092FC3B8;
	Thu, 17 Jul 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768537; cv=fail; b=ugxm+7woA5cC1KSQiGh2M2iQJxGJR7oyt2C8zUEG0sV+vqpjk+ciPVJnmDLiEAUauo2HfrMO5ZyQhhutR430758K4acbmnhuZ0d2QsmJyO6RcOmzUEkB+nEvRnfOTo0KUsWSRnPGqtwTRobXnwZxr2cqOXcAP5mNa1tJvRrQa6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768537; c=relaxed/simple;
	bh=9tpHWwBuY4dd1+vStA7P30iD4/y4dYn+pYjFmyak2OU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeeoCOoA+r/2VCd4vHD7ikE7AmvrZeMc1l31xqWQ1vmtHSYakKflTolW6+mswyJb+IDLX4PCFx5S3+ciqT4mC69/xr6WvbANwPt9gb6vZoX2F+cCTdq2Nmwu1mVSSjYC9ptY8E7ySa+E+21yfG8TklVzTinQCkRlgnenuz0lJls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clYRGTN5; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBoB/I8j+ATeMzFu+jUBqgjwBLBFRELBm5cga7We2rac7HTRFlAOD/SecIMYi2AIWenuhHG8wzXvfcHfBQY6HKbCXIDCxFts8B4E8vpFYJ4SLA9csmZucsZdAN10QToBmHJUzKU9st7UJOLEIp5YV6qd2HLlkif1gNq50MRAFnbYa9eTV4vMXOOwgTZGsf8vX5gSORpdV7JdX78t+L9TTOK81R+stAfIvMNf5UOj7KGPQVsmmfqbM/wZwdVbAHcWwz199yFsiaBWV9PKWSnTPrzxFXuZ7DOFJ8oVz1v2c1a39gjqPjuNk/kYrtDe1XfHwvfxZnSguryaOt2eJBcMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqrwnyALV/aV1yJK+mQedDxjAdmHzjNQJZlvGIUdTDg=;
 b=cmcO6Ui5kLDY28FYhU9GP3ZtXjOfFQswKLqukvgJOZKQ5Plh6HmW7LlfU6qPj0rUaKCBM07kcrMIiwYwVSeDL6GwhVi9jp/FadJadYSfYPPfAA4+W2Q2+IBu6pROuMNayERoLXGo7TdEBHbHjMH0Ji1dA71Rpf0jQsUrta3Kk9ofP5pQGSZPa1j5RYNNysoEqfv4HOMIFr7b4KbRiUBAP9152PsDt0Fl/G7vhKrsjLj3/Gdh4DMVLgafH5v+QmhI7xi1R6Q+zEpI9Y7RSwKcu3fmGvLODn9WqqViqrQmwGnrOvDH9M66Sd0ZpWzVJYTlnCi6nVqY+abgq+OaPhnCXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqrwnyALV/aV1yJK+mQedDxjAdmHzjNQJZlvGIUdTDg=;
 b=clYRGTN5Qi/lkcWguoUgcZ6N0oGOxAM1nYkB+kjVB9IraEOCCjsCnUwl7utqJzMsdi6ibVgyvCUOfsbCFbb8ABTvdfVg+tQmtG8iiO5OtGqm9LYCB/5RdzqWo0S4X9FYXnXVMkgJMgcEF/JlPEIyl4VE9PLUQsc6wauQu3CZiiEkAqfbcG0WANc0rcKs7FQg0oF3s0c3IYEor35EIac/TGE3E+M5M1q6KCGWEBZko6pht6E/CAwUaa4qqeQLyE3ZziJkExjwAN7O0goQOeDQWHkv+D1jTHLqPORMsFhVBWiBU9457ivQXgufQvD/wZlccg9/Ily5CzmrOLu+wegCIg==
Received: from SJ0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:a03:33a::8)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:08:52 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::3f) by SJ0PR03CA0003.outlook.office365.com
 (2603:10b6:a03:33a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 16:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 16:08:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 09:08:34 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 09:08:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 09:08:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Brett
 Creeley" <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, "Subbaraya Sundeep" <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 4/5] devlink: Make health reporter grace period delay configurable
Date: Thu, 17 Jul 2025 19:07:21 +0300
Message-ID: <1752768442-264413-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 430ed534-c16c-4426-4573-08ddc54c3904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5QS3RZVWxqRC9nc25xenpVcXlsRG15VmxlUmUzRVh6RWU3K3k1OTE1OWQ1?=
 =?utf-8?B?d1RsOENUNk81ZE5HN0Q1a0RPYWhTQzJ3MW5TdTdCMzd1UVJ2djMvTWlsWGc3?=
 =?utf-8?B?eWE0TTEvNTRXOFRjTTZyRm1KNEQ5ODhoVjlrOXd6RGV3ZThNYmVDQXF3VDRs?=
 =?utf-8?B?L3JvdkFTVHdxbXc3UFBPd1JZVFVQLzB1NHJKZy9GWnJWMVBvQUdYakVuSzFj?=
 =?utf-8?B?ajFRSDB0NXFVeHlEOVE5QU84aFNBNHZVbXdXVHZaaHJmc0FGdVJRU0dYYjZG?=
 =?utf-8?B?RnkyZjQ2T09DTHNsQXRnOWM2cjVaRGtIVFNiTHZMTzBlRXBXZ000RmY5a29k?=
 =?utf-8?B?YUhZd0t1QkRpWis0OURwbHJZbkdraWJxMG5CYXhhYkN0dHN5blFVem5GeTFr?=
 =?utf-8?B?SERYd2o5bGl1NVFCVVBmNGJBVWlmVjFSbHIybjIzR2lweUZFVGlsWjZqS3VG?=
 =?utf-8?B?TzZXNTJjenZwSVZZR2tCaW5HNnluQjNIcW9rVE1BWXo5UllGWGtvV3ZmdUll?=
 =?utf-8?B?K2pVSE5qUUNWU1YwYlpiWEVXRk5QS1lBWWRtaHAweVlTMTVMWUwxU3hndjNH?=
 =?utf-8?B?cWJmNCt5QW1QVkUzdXdyS0NLd1pESWlQeVZkQVNLSStjNUtINkFPcStjUjlR?=
 =?utf-8?B?R2tOaVVJTzkveXJ6cThBVmxRZC9PNHk0YTdjRmZ2Uy9iKzBNSFMvUExmYU1G?=
 =?utf-8?B?eTB2K0lxL20xVGs4TVpBbGFMSFN5WEwyNERzMnJBTjRGdFY2cndsQWFFWGVq?=
 =?utf-8?B?SGlab2o4NVZxQjE4U0ZBVG5ybUZjZ0FNNXpBa2h4ZHRmUENpd0t5bHlFNUsr?=
 =?utf-8?B?VUd2aEZBY0FBTXZXU3gzWFcwTTl1R0lZaFNlclJsRUwzd2FicXhIZUZETjVh?=
 =?utf-8?B?QWoxWjBPTnA3ZVNaKzErSUFWY0Q0MTU5dXdQTkxrSDZJUy9iWXJUa0NQY1RS?=
 =?utf-8?B?MkdKQ0IzanR3VE9ycVdvWTQyUng0eDNYWk5EYXo5VlVzaG5VbEEwZHRtWmxH?=
 =?utf-8?B?azRHaDlSenY3TVhkQVNmQnBXdXhuQmlLMlVkYnNFRVJmVDViamtjVDRkTXBw?=
 =?utf-8?B?K0N1Ym8wSmMxN1kyQWJTNnh0SjF5SGZKODBYdVN6U2t4MEdHWU9nSzErNGRn?=
 =?utf-8?B?TUpRQ1hmQnJPY2p0aEdzZk54Q2NQVW5BYUhVRXJ1SnlkSk13Z0FWcmFPYytN?=
 =?utf-8?B?WnRTdkVGd1IwVitnMHF3Ny9zVnhycUxHZm1SOGt2cG85VU9oVUhTSDZMeXZX?=
 =?utf-8?B?WG45cTQwYzFsUjY1MzhtbDlPWHQ2QzcvU3F2UHBFVG56ZysrWmpLRk5LNmo2?=
 =?utf-8?B?bmxCK0lERkM1TE1qcUdDeFJseUx6dHE1ZGFlMENUaDMzM2thYTNLbVRBcjBQ?=
 =?utf-8?B?RkxYWTNFWmEzV3FDc3FXSE9LbU53SVRqSnJob21KdVZEbnF0SEQ4c0txRlA4?=
 =?utf-8?B?cFhhQ0JWTjJyS2oxa1FFWW5qWFA3Sm96UHRCTzlub3hVN3FwWTY1ZFl3bDl5?=
 =?utf-8?B?dGloMzBNSG9qeGFZV1l2RkdDYWdPQ2FUY2JRMmRwd2I4cTJ3VUZyOG5OY1c1?=
 =?utf-8?B?OXBJbFhtbUZncHNqek1TejhhVk9vb3pBNU14Ym5jalNYSlNUSHA1RU9DcDNJ?=
 =?utf-8?B?UzFRclFzb2dEQmhPRkgxVUd5dWI4dEdwSW8rQTVRL1MvTzdGdnNZMi9LYkhC?=
 =?utf-8?B?Vk8remRoK3FjcmZzcEdnR01vUVN6L1plOXhGRXpHOVcyd1d2TThJOWJZMERU?=
 =?utf-8?B?SzRSSGVwVHd5V0J4TXpKZFZOdmMxUnhZKzlZdi9sVnFEcmFsYkhvV1V0Y1cv?=
 =?utf-8?B?bjZmM1RpSVpjcnJZL2lqejdPaU1uaVB3eFZVVXY2VHdLOExIbFBzRU1XZC9Z?=
 =?utf-8?B?cWN0Sk5PaTBkaS93T3VWT2NqZzE1M3gzWFZjN2t2dGgyeSttN3FVbjV6Z0Mv?=
 =?utf-8?B?RXlrMWJrTGhaUEFnc2hYeTd6djBncXhNSFRzRW9JM2ZpWnNLRjVUaDRQVm5T?=
 =?utf-8?B?N2R6aERwTG9DajExdk15QndjYldqUkR2UEQxTk03VGFPTjBtdDZkTEgwTHFj?=
 =?utf-8?Q?5hkwB7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:08:52.0687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430ed534-c16c-4426-4573-08ddc54c3904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

From: Shahar Shitrit <shshitrit@nvidia.com>

Enable configuration of the grace period delay — a time window
starting from the first error recovery, during which the reporter
allows recovery attempts for each reported error.

This feature is helpful when a single underlying issue causes
multiple errors, as it delays the start of the grace period
to allow sufficient time for recovering all related errors.
For example, if multiple TX queues time out simultaneously,
a sufficient grace period delay could allow all affected TX
queues to be recovered within that window. Without this delay,
only the first TX queue that reports a timeout will undergo
recovery, while the remaining TX queues will be blocked once
the grace period begins.

Configuration example:
$ devlink health set pci/0000:00:09.0 reporter tx grace_period_delay 500

Configuration example with ynl:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/devlink.yaml \
 --do health-reporter-set --json '{
  "bus-name": "auxiliary",
  "dev-name": "mlx5_core.eth.0",
  "port-index": 65535,
  "health-reporter-name": "tx",
  "health-reporter-graceful-period-delay": 500
}'

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  7 +++++
 .../networking/devlink/devlink-health.rst     |  2 +-
 include/uapi/linux/devlink.h                  |  2 ++
 net/devlink/health.c                          | 30 +++++++++++++++++--
 net/devlink/netlink_gen.c                     |  5 ++--
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1c4bb0cbe5f0..c6cc0ce18685 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -848,6 +848,10 @@ attribute-sets:
       -
         name: region-direct
         type: flag
+      -
+        name: health-reporter-graceful-period-delay
+        type: u64
+
       -
         name: rate-tc-bws
         type: nest
@@ -1228,6 +1232,8 @@ attribute-sets:
         name: health-reporter-dump-ts-ns
       -
         name: health-reporter-auto-dump
+      -
+        name: health-reporter-graceful-period-delay
 
   -
     name: dl-attr-stats
@@ -1965,6 +1971,7 @@ operations:
             - health-reporter-graceful-period
             - health-reporter-auto-recover
             - health-reporter-auto-dump
+            - health-reporter-graceful-period-delay
 
     -
       name: health-reporter-recover
diff --git a/Documentation/networking/devlink/devlink-health.rst b/Documentation/networking/devlink/devlink-health.rst
index e0b8cfed610a..07602f678282 100644
--- a/Documentation/networking/devlink/devlink-health.rst
+++ b/Documentation/networking/devlink/devlink-health.rst
@@ -50,7 +50,7 @@ Once an error is reported, devlink health will perform the following actions:
   * Auto recovery attempt is being done. Depends on:
 
     - Auto-recovery configuration
-    - Grace period vs. time passed since last recover
+    - Grace period (and grace period delay)  vs. time passed since last recover
 
 Devlink formatted message
 =========================
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e72bcc239afd..42a11b7e4a70 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -634,6 +634,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,	/* u64 */
+
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
 	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
 	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
diff --git a/net/devlink/health.c b/net/devlink/health.c
index a0269975f592..5699779fce77 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -113,7 +113,9 @@ __devlink_health_reporter_create(struct devlink *devlink,
 {
 	struct devlink_health_reporter *reporter;
 
-	if (WARN_ON(ops->default_graceful_period && !ops->recover))
+	if (WARN_ON(ops->default_graceful_period_delay &&
+		    !ops->default_graceful_period) ||
+	    WARN_ON(ops->default_graceful_period && !ops->recover))
 		return ERR_PTR(-EINVAL);
 
 	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
@@ -293,6 +295,11 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
 			       reporter->graceful_period))
 		goto reporter_nest_cancel;
+	if (reporter->ops->recover &&
+	    devlink_nl_put_u64(msg,
+			       DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,
+			       reporter->graceful_period_delay))
+		goto reporter_nest_cancel;
 	if (reporter->ops->recover &&
 	    nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER,
 		       reporter->auto_recover))
@@ -458,16 +465,33 @@ int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
 
 	if (!reporter->ops->recover &&
 	    (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] ||
-	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER]))
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] ||
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY]))
 		return -EOPNOTSUPP;
 
 	if (!reporter->ops->dump &&
 	    info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP])
 		return -EOPNOTSUPP;
 
-	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD])
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]) {
 		reporter->graceful_period =
 			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]);
+		if (!reporter->graceful_period)
+			reporter->graceful_period_delay = 0;
+	}
+
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY]) {
+		u64 configured_delay =
+			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY]);
+
+		if (!reporter->graceful_period && configured_delay) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "Cannot set grace period delay without a grace period.");
+			return -EINVAL;
+		}
+
+		reporter->graceful_period_delay = configured_delay;
+	}
 
 	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER])
 		reporter->auto_recover =
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index c50436433c18..b0f38253d163 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -389,7 +389,7 @@ static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLIN
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
-static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP + 1] = {
+static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -397,6 +397,7 @@ static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATT
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .type = NLA_U8, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
@@ -1032,7 +1033,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP,
+		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD_DELAY,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.31.1


