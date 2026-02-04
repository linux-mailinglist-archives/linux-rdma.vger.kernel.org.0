Return-Path: <linux-rdma+bounces-16542-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E3GLjKfg2kLqQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16542-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:34:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 324DBEC167
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B77143012BF4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866D38737B;
	Wed,  4 Feb 2026 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIiJD3Md"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD421C6FF5;
	Wed,  4 Feb 2026 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770233647; cv=fail; b=E4Q7TnWiLQRNsi0nEFRceTYEyd8IE4imDnhbeDpTcCFgTQNousPlwN3E+IxifL0FYjaRHiP1yPv02KD/N1xPNSmy8PqhF0tF7XivwrElqQPLtVNdEnkrWMnWucfc3XWp6n2Sk2ACeoMvlmJtxCq9HUUA7BnGUieR5+kH+k3wu4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770233647; c=relaxed/simple;
	bh=S1v+NpewjmdYd4xOmEjpamr8QjU2xu0kaPDX6nWju7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lnsWyOSbq+IRPe30AGcF4VrmwB42Q+9XYkgRylmw/2exjoYsOQ7emls/QWNiRdt+9I5OsLaeMsJmbaIm/wIhf4A8zqGnNRpjDGOXKmfaGuXPFndqdsEiMe0NTfcWHG7E5TW4WTg26uCIRgcRO8M2DS4Gvzc365oB6kZFtmZr+CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EIiJD3Md; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5bWovS2WxdkoxlZgPmqbSsb7CP1BVW3Ub9mt2w1wa8w5VA4B4wIk3pvW2ArHLcaQUtJdtQWEFSogO7vdFzwy0yl8VRPinlPDGq77NHGUOnoyot/fLXEtHQ920xvtCbJ5GpsxU6M9kbA9qrDQNCRox6XwevHT8dF2pteEKn5I6LmSpBkt8v1VPKoDO/60NeuBAZ+yICaV0PZqUivUTb2RyLnUnszkuB1hZJNZCdcSlquur1aq2qT+Syx+hF1QdmHghVjALPN+05QmdwWDyAEi8mbRfP6TJ3xCUGBMzZaQZ4wujz2PzB1RNm5ZCUTeij0scdiaQ6CIMFvddy8xtU9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNld/jG0OxkI2WgH5PVFS06xHiiYAHPPg3nQqzzXotg=;
 b=CDKKfHgCNLuvDLUF8mhIAimdOI9siIklLCa/Z5pp23hJiHLSlppQOFlxw0zQKehh87LgEeoKm6r/BRD0i0hjJh/xMgVKHN5tJSR61PrtcGnFdKXla8Ix9/GC5MpsVhkq6JcpQUH/JY5WPTxZflGWIQE4FfrEuM5o3o5Gd/UzQDMEmdaH+mmaL5Jt3lN0txCth/T50ISORh7p+0PJxCSaO19g0EKCujhzHOLATTNC7tjEJ0irGP/vambjHGR5uUOkIkDaCsSZKEXqKhuUxRcTHlto8iKunqBMhAUYgvV+H54TmRHDuJry8YvS8ipGxy0WYu7NiSiNmle3G9i9VJC7Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNld/jG0OxkI2WgH5PVFS06xHiiYAHPPg3nQqzzXotg=;
 b=EIiJD3Md5e9vsZvwAdDdC57vkjZg62uoklXVBLdE9PDRA6LWqz1uPHpT/46WB+fYhZBoRA7pjQILS4/4QEm3D0FiRnGelEDUqa6uBD3aOYdCQcXePm2ZhDJW1pCtd2cpOu0jNqip04X1RPADh6Hp6UPTxnio2tqADnG12FcHbv9FN6So8bdgo9p8a0MoWe4F9Qm8U9N9rQxjUqM1T8kL01JjiQhpgVeI/rnlasNi6HcETvNVIms28Zj1jkto+uLufGHyJxysWdI2ug4oeUUrQODKoIETNGOkNxBDPnYXkSR0/ROt0WyrrB/Jw8uelucQS7ei4kTUjAVHCJoxAMDj5Q==
Received: from PH8PR02CA0002.namprd02.prod.outlook.com (2603:10b6:510:2d0::11)
 by DS2PR12MB9800.namprd12.prod.outlook.com (2603:10b6:8:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 19:34:04 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::d) by PH8PR02CA0002.outlook.office365.com
 (2603:10b6:510:2d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Wed,
 4 Feb 2026 19:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 19:34:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 4 Feb
 2026 11:33:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 4 Feb
 2026 11:33:34 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 0/5] net/mlx5e: Report more netdev stats
Date: Wed, 4 Feb 2026 21:33:10 +0200
Message-ID: <20260204193315.1722983-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS2PR12MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: 7442eab8-16a1-40a6-7755-08de64245a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OnGeTMdFtl77iaba5tVyIHJdO/AQhNc08yCKjhJ1IOo8m5bWYxDspII/mB4H?=
 =?us-ascii?Q?j1ua9mXEBHCOpA6JIHYxFhQvjdDVLqp0DJw1tH5YIWPsLHfTx576gXgSaSxr?=
 =?us-ascii?Q?Pg/UurjvwFATmzryzc9jovVaUE3eGTYVA6Bm+4mLGJgx6XB5YNTbHIcK4qIn?=
 =?us-ascii?Q?2jOoD9z9tYC48FbtwlbZTtvZWZngkv5VX5VgD9u4FrlxIDaYLm0ht9J3eLWN?=
 =?us-ascii?Q?heyJ0iRJZhKEG2IrSrtWkpxeA9YYzH3Wy1RXN6Jfx288axT8Bgu13vH+zO9b?=
 =?us-ascii?Q?onFuU3ZoFOuCkZWvfJP8wzapO+nhJi4/1A264VVUi5M8PBltN67M0NxeYnoy?=
 =?us-ascii?Q?k//yosfjdYFaNWUdJZ8wcMhtuRvwAP7nIkeUR7ZoXUuwIe/4jeMZQhLbMZ28?=
 =?us-ascii?Q?Xf4GvnFUU5jOBc+lb+ZoyNhncJD5RIFBL+eN/rCGxjfEaVTzjrciMDqtoG1H?=
 =?us-ascii?Q?yS8XATf7i2ipUXpk3aQ5vl09LYrZq/G/jgKcLnUeRmL8Xca4hcqBRGnvIT4w?=
 =?us-ascii?Q?N3TVHnVy9z/u777GElDDYXY5j27H9r5MXvsJ81lzQc7gup1BqadGisqbBvrK?=
 =?us-ascii?Q?icQHsyoiC+084Yt5go91i7oOX0QXmHLi9rGq8rQojGRLJkcYyfPDFyLOqbGj?=
 =?us-ascii?Q?CeFSJgv3UN67pahyR/AOaus9z7UbmJXMdSg/PPEMRC6zW5DBOvI4qmsarkF4?=
 =?us-ascii?Q?d1dkj8n3sscp8ED6j7I2OA3zsU7ldb0ALrR+pweefSfd1p0dVIVYZfywCgWk?=
 =?us-ascii?Q?+rr9sqOfLg2rpST5Y0clS6xrowWozVY2CcA6eAe2/odBGC4SlT+x1edRFmzG?=
 =?us-ascii?Q?2Wra+h3AEtiqJxvHL82ZiTo2faqEK7iu411P9yR3azMKE1ZdqU6tEJRFlCLj?=
 =?us-ascii?Q?JLQ0U4lWO6MWYzJLqnp3r2nVi+bpDJ0ap3kSLyFe9suPByLnWmSyJZh8dedY?=
 =?us-ascii?Q?sJYLzi449VqVtfGEehXEGKyh6sppmGRGWxPFeMQXWbdJlXVBRY0vZBBYIt/P?=
 =?us-ascii?Q?EA36Zt+g4w3UhuC4ufIqr5oaSzP8vTpZc685wIwxd2w3/QT1rxsQqQagRQwk?=
 =?us-ascii?Q?1glutHABX3vIDwSQXx5Jum3fKNr7K5SqQVi7C96vDcbicrhPCt4LeIXhr0al?=
 =?us-ascii?Q?gotrrps49Ngfh5F+ZAYbCK5dXg8KSC+Hg+mRRTdrKiczPl5ieykaHM/HqzT7?=
 =?us-ascii?Q?mjPxDl3GszcXiJHvNE8/4QsD+c87+irm6Qp7YU8RFEOyGg5vJioB7G+7Fbfx?=
 =?us-ascii?Q?AcJ+gtAlscfgTkGgP9U+RzFKFvB+M4pqxOtiROHSOS+Ewy8MtPunichCyA0/?=
 =?us-ascii?Q?kq8lyehfSCoLaDRL1tL8PrlZyYvHF15yABO/M7tFkIPIJcG8q29S1hH2PH2v?=
 =?us-ascii?Q?hgvKyXcCvkGf0LeqUxRTDz2ULukIgJQy4OrAho+l3VB8MHont8TYsBICRapB?=
 =?us-ascii?Q?Bxu2c8vk0SEMOFDKH6hpLgJI4YjID9m38N33b19ch3IIvAGMdi8iWPDJcUqc?=
 =?us-ascii?Q?Gno73PnSRmOTinpM6MSprVWXjOXvmnKkDNblf+m8AmhJNtDCSiqbmpzfujNe?=
 =?us-ascii?Q?BQSZzNr5VKalU0U8+9kqjwCZ5X0ejI7dseGQMDY8LM4L/NbBSthmpu2SKhxM?=
 =?us-ascii?Q?o4xIguZoeA4pk+BWX3enbb1oswZ/inZ3131f7r7EvzG7m/icixuWuCPpwtm6?=
 =?us-ascii?Q?+FLGDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/gPBLrONnjXxoEYwiaj7U7pQfxw6AvnSQFWQYbw3fqTRh0m3/A34H37AgRUrjje7We+I+Vt4lt5NhE+PSf9wXwvAMyIrblAFkSwywzBwLOit8xFjNYz256tL93Rcqb2RHvrCYrNutgXO/q2XRCG+59YR585m3V9AHNc0sJqWylsGhnc2daMh9qhSlxlymgCeKihF8t/flnhKfV+3t6qMmQG936f41BZeyGkCdqZhgmgasqQhuZmkZ0fbOI9Ib9lsg+HgTnVEWicXjhwIRQE0a5IMgrkEOVtv90n4JRY7R3Au7i6rfVCT6KorUXmkDWnOF0ELDw6v3gPvK2mCVyN3/4xUM2ZuIqm4hNI/8dF1wKyz/TbiEM0kx0s490qZj0l+AiZbfKX00Ifaz5RRPEE2GVOqOPNWeJjBkLLLCbxPM7AtHXpAzViBnV9es78TD8CH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 19:34:03.2733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7442eab8-16a1-40a6-7755-08de64245a8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16542-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 324DBEC167
X-Rspamd-Action: no action

Hi,

This series by Gal extends the set of counters reported in netdev stats,
by adding:
- hw_gso_packets/bytes
- hw_gro_packets/bytes
- TX/RX csum
- TX queue stop/wake

Regards,
Tariq

Gal Pressman (5):
  net/mlx5e: Report hw_gso_packets and hw_gso_bytes netdev stats
  net/mlx5e: Report hw_gro_packets and hw_gro_bytes netdev stats
  net/mlx5e: Report TX csum netdev stats
  net/mlx5e: Report RX csum netdev stats
  net/mlx5e: Report stop and wake TX queue stats

 .../net/ethernet/mellanox/mlx5/core/en_main.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)


base-commit: 9a9424c756feee9ee6e717405a9d6fa7bacdef08
-- 
2.44.0


