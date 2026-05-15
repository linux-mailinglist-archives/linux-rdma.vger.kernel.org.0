Return-Path: <linux-rdma+bounces-20784-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M6/EWBcB2orzwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20784-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:48:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E9C5558E9
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 19:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C4F830072AE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 May 2026 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1693F39F7;
	Fri, 15 May 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SXzJAfF8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013070.outbound.protection.outlook.com [40.107.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B1D3F39CD;
	Fri, 15 May 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866228; cv=fail; b=FD2UQsGt6bCHNY8Ow6rh1fkeFSrUnFhivB0/vxeC/jzHDvyD05T+6BWOFeNcEnnUSpVtHldbv1WDHkiqtn3X0i+7Dr2Qm9vQR8iZGbLYTM/8v5yp1uDBkBMAKhXxNXVutxZrX4InjWxS9YtlYRGFYVm8NQ54WnqUjZngcJn/zK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866228; c=relaxed/simple;
	bh=dV9WfT60tZCdJ6lOGltcwKOD9rgJ1YliWiFKPmtiupc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TTxWoIcQqzIgouSuliBCh1VYPYT1MUhEN4jlDn7db2p6Ck58/HPoOFOdHCG4+pemL0KbZyXMLmkR+AEboWRGu15VQka8fW4W/F/OoefnPfW5UlPN0Hn6YkcJCjmu274Wf6Z/J3L++qMqW9AQb6B6ucWOZHFYkqeUwYRDNxF01d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SXzJAfF8; arc=fail smtp.client-ip=40.107.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAP+MgJ08Q40gWdcVK2PU+sVVjWysArIFkSshACQSxzzJGTPWP3R5BoUjwn8gMEu/Ge0hBqXWdawekb5VDWzhMr6tggEkSkVq8LQDLBjgPmB5dzrv/bptopiMpdIQ5+yrYf9LemIZClvBbCHXiZ4TGUgyYVfulWzqH/2ODMWlMB8maggCrkgZ8u0GYx/gofrrvNCxF62Ib/mcP1tXef8K0YWfV8dqU4/QfMVVKs3oqC4IJxkm+Srr9wnxLImcvDiEkSahRrlemtr3Nlzo9uG4RnvXGc4LUL0Pk5SzaUxg+L99XBDQgUjL4C9ALusA9mnF2ylfCpO72XuG1cQYU1L7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cetFkOGBs7hItmyNqgEw4kvtUL0NNmagM5kPxpbj3p8=;
 b=AwoHf+IuKbsU+uMrJQs1NY9INT12RpUdhKbN9ysijgLTpVfZN7MQeoLnDuCNK9+ncjcg4OC+hNS6jlKftjzBwmW7LfhMoFRZmmJi6EvPunlo1lfRfQ+JPP754y7QTusFSKZIo5rre7QGS23XYHcMFMQHDme3Pq8+dYbQoR6vxGy8uKHEnwE+bZA+RM7FxJ23J32uOprViyouBBino/pHHdBZn0gYdJM2Gde7FFLWIywhs6AvrTqzdZ+knSQLz4sz8xR9P4nmF2ooNFf0WFpncvNPkmtnIRHooc5cHtdQ7Jg4E7h32ONDvYRni87W4qA77LgcKIWppolzi/Sgqx04Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cetFkOGBs7hItmyNqgEw4kvtUL0NNmagM5kPxpbj3p8=;
 b=SXzJAfF87/rd1hSAWeZi/8fEswH12KyZ/49i4VNdkZPTRy9uSHNinVK+iiI3sj69ej1mPfpwgkil6waTyKx+osUujH1+Q4h/4YMsC1RQMTChX5vc5Z93MpM6yGQYpY8N0m3TF+OkjVf5bFxYJCIiOPpZOhoq9TeeyiJGpRPZsmx9zianfdBEjQ/KtH5V2NvNlHXxMowDV2Eb9zFPwxPcn8Z9zdeP5jTEX+zedT8MIwUvtbkmZrVSq5UauPSoghgMCttvfSRZBkfdVSjjQg5Z4z84sPSmrEKwdplrHsgoLgfvTW1rWw9zoeNIpznwtkJtD7c9gMogzPVZITpT8Z90Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 17:30:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0025.012; Fri, 15 May 2026
 17:30:13 +0000
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
Subject: [PATCH v2 07/11] vfio: selftests: Allow drivers to specify required region size
Date: Fri, 15 May 2026 14:30:04 -0300
Message-ID: <7-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:208:32a::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 308cbf50-368a-4d6f-9273-08deb2a79d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	WdEsoS2FrQHtGE3/2mABjshdrqhk9xamqDh56vhDxhqbjvS69xRKrUuH/Wd6mgznJgGiUbA7komii19gw/1eIkhW/U1NfcxPiKAnzfU0UxUqnDUnG7Ria1WlHtgar6uGP1P01Ty4F+Ap3vB8FNIzjCJ3p97HKqlGFJu+VPN9H4DISGQ8KQx2IEY/Xh2FgJBXEYNlid5L8/LEuDao4z0HJNA0QDdWOHjqq9V9TQTPvIvakapTQdV1TZ3AiPh2DStKVO5OflHMuJe4uNSxzmpQ6Hu8vvj/fsmpeaYLBswSTbQ5mKfgXF2+1OQqafqPMh7Ahtq2smcSpI6lOPZzoG6SLKzXUH512KlWv9Vh0eNLVN5/Ea1v4POeW19m9Hy+uXPWQ/yg1+z22xP5Sjd97/2HPfyraBqTQKI7247Tt3OAIui7xZBpa1ghPcNp8Q1zgja+UeVIY+bG3gF8LpS3tis3RwVz1LM66rICHjYsaQVW3hom7IcBBK/TyDsfxR1WjmWYySTjAWcsn8VP/M7n4s3+ZXQHGvIqgAtZGEaz8D5ue8WC2mSYjGmArtw8thfoY8uBWQYWwz8/qo4z4l44Ecz+pKYl6zgCtRgqLuEJdpF20Sy2xKpPgOpzXFxCu07THhkPDeVl/6OW7vLw32PUqnqrp1ANGdySx9u31wkjSXkAeV4DaH3woeJe/SCS0YbxtlUzYsZE67lE/ZjEev9APT24TezXmiX9x2A2qYrLoNUQtes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eyyn4Vy+GfpCaxodlraoNknAGT7TecGQ/SJjRy1ldO0lgqWfeuto14cc44RK?=
 =?us-ascii?Q?xpFJ0WbweE1eeZZXRbV4YH9uQIM2q+4ediGxGnYvk5Upjht8tTacSjSnMGzX?=
 =?us-ascii?Q?g4e/UnxYx9Wmh2BZBDl0BCvtjhIwKTo8I3DraKIDO+0vuIz8geNGGnc7lZWI?=
 =?us-ascii?Q?2ViTZX2HKX21SNBl9bUoc47te0hGg6iC2J0W3yk0K2xpiOtLtCRQXrqE6RGQ?=
 =?us-ascii?Q?7FmsKQy6GoCIpN4JNvXoQDecw2+H9tOOwT0muOmUZ5UiYJL1tHzff6MOOvx6?=
 =?us-ascii?Q?1YPIDYuQ8YK8+ZZR/yjxmhUm+9EKJ8V0BY4bX9h4dVwkU+vsnbgh99yuBwCM?=
 =?us-ascii?Q?Pb8ASJwn080AdO0We+gsjGKjwE8KLvuUzsHZ8ZHkouo0Mgs88t8yjqYPQm/+?=
 =?us-ascii?Q?tjkOAQkonq+7BKwNw9UsRaJZSNKWokMIALQ4rw8XI+ttE43IX52CHqLOZBIj?=
 =?us-ascii?Q?r3ly3Twxwu1N7h6jAHBvoy/kR7kmTrAxOb4qNtVia62uDsWxPoxr8lUQybMl?=
 =?us-ascii?Q?c7wjT3L8j9NX1wA96kClTkkoiRjj3TTM2df0O3+q09hshugHwSzBVQ5XYfrE?=
 =?us-ascii?Q?/M9LFbs1XFuWGCZRZJr0YbxUENp0rZe+Ktxzg+VmaOgCtQsgPBQkM+GGBsMx?=
 =?us-ascii?Q?aqRDjW+SS503UniPoqicS35u6dYwrbOhZy+hrCJm0nTjcNJmBhh8t5KVeH+0?=
 =?us-ascii?Q?b6+jyuxYzqutPBB8SfW0APAdTG54KS/huXkkUiLSPgtX+q2GrbMgontM+gFY?=
 =?us-ascii?Q?6iHPCGW90dz8fvjMvQ02OdwD9zCnVa5ZHIxkLi0xZGWpeJgzum1elxEqg+Xe?=
 =?us-ascii?Q?8KB52DLgcJ9OPjyU3o2INd0ESMyrrgeKmcebE2SwCh5jmRHkIiWNpj/k03n6?=
 =?us-ascii?Q?h6pwjHOpLqjoXT98FkW1I5YFSyDOMoY1POROiszzlBeEhTP87oX2sVJ3nzFX?=
 =?us-ascii?Q?HyJ8FgOY/pW0u7VOKxChqvwXHpd5kHsuFRMVDvFVQLS0i1m0/MbWtGKu3Ufq?=
 =?us-ascii?Q?01xnAFDyNSinAdMJ5A64BUXcntusRwMfjjGTGL5+faRi9PixwextZCBFmImz?=
 =?us-ascii?Q?roXS16Edx/L2XZHtXngZslcSQKZ24gW0lQpwbIYvuRpXxsr9YdhUNhhn6uSe?=
 =?us-ascii?Q?0vZ7lBBSgJAAMJT10rDsBXeYRl8SOqO2co1R3R5wEOo0JkDo/y2Xyj6zO/Wr?=
 =?us-ascii?Q?h13ISl1Eaei/58IailaZwUExplE+EWiHlxX6gzuQXaRShkVTKMh5xy3wuXZy?=
 =?us-ascii?Q?kKPKYIJJ8zb8DN/hCfH42067WMDCgdjj7lHz4LyK8P2YYu/eL8F0DnDzNAJI?=
 =?us-ascii?Q?w2oESbUrvrpieHYRpf1QE+JKX7Yn/NDCb/r1zxObpNJbUnYzs+NI4roAkuhm?=
 =?us-ascii?Q?t68clVsXT+n4AzdQTnDSJrWcFywPauyhl4DgxEu4GpRgYUpJCYLd39FryfmD?=
 =?us-ascii?Q?V49luXtL55aIVuf8v7RnxNlAYdT79A6WGVErtMag448j0LntYglsTCCDHC6l?=
 =?us-ascii?Q?/n2ea4UO+RpMiUpIillEjjIsj10CuYUXYG3S4nqSMYKQVfHlaL7j+bN38ixJ?=
 =?us-ascii?Q?Fv/c8yiJ/slOyntFmBMOuBeMeOQAR2bPR6ddIQzfSMcocvdrvUErj0OaxOQA?=
 =?us-ascii?Q?ykbHzd9FjfZ86lQBPP1zLoqbqs+eI0fZWW78TJBqnG1OEl6HybEBlMJ69YUD?=
 =?us-ascii?Q?emKPH9XvK6WQNH6dAkJAl8aR4W41kYI5J8Mf6i2fkDlPY+kW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 308cbf50-368a-4d6f-9273-08deb2a79d9d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 17:30:11.0276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUz3+jYQwFWKM0zquVDN1sstXUH2rgZB6k/hoPWuES6SygoLg4eYTcSLK0PEKrSk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Rspamd-Queue-Id: 94E9C5558E9
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20784-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Action: no action

Add a region_size field to struct vfio_pci_driver_ops so drivers can
declare how much DMA-mapped region they need. The mlx5 driver will need
~18MB for firmware pages. Existing drivers pass in the sizeof their state
struct. The core code will round up and minimize it to SZ_2M so as not to
change any test behavior.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c         | 1 +
 tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c       | 1 +
 .../selftests/vfio/lib/include/libvfio/vfio_pci_driver.h   | 6 ++++++
 tools/testing/selftests/vfio/vfio_pci_driver_test.c        | 7 ++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
index 19d9630b24c23f..40b8541b588eee 100644
--- a/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
+++ b/tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c
@@ -418,6 +418,7 @@ static void dsa_send_msi(struct vfio_pci_device *device)
 
 const struct vfio_pci_driver_ops dsa_ops = {
 	.name = "dsa",
+	.region_size = sizeof(struct dsa_state),
 	.probe = dsa_probe,
 	.init = dsa_init,
 	.remove = dsa_remove,
diff --git a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
index a871b935542bad..c9b28365c5eb6b 100644
--- a/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
+++ b/tools/testing/selftests/vfio/lib/drivers/ioat/ioat.c
@@ -226,6 +226,7 @@ static void ioat_send_msi(struct vfio_pci_device *device)
 
 const struct vfio_pci_driver_ops ioat_ops = {
 	.name = "ioat",
+	.region_size = sizeof(struct ioat_state),
 	.probe = ioat_probe,
 	.init = ioat_init,
 	.remove = ioat_remove,
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
index e5ada209b1d102..547369c5cff95a 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
@@ -9,6 +9,12 @@ struct vfio_pci_device;
 struct vfio_pci_driver_ops {
 	const char *name;
 
+	/*
+	 * Size of the driver's state structure overlaid on
+	 * device->driver.region.vaddr
+	 */
+	u64 region_size;
+
 	/**
 	 * @probe() - Check if the driver supports the given device.
 	 *
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index afa0480ddd9b2a..5a46800cde4c8d 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -2,6 +2,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 
+#include <linux/log2.h>
 #include <linux/sizes.h>
 #include <linux/vfio.h>
 
@@ -80,7 +81,11 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 	driver = &self->device->driver;
 
 	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
-	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
+
+	VFIO_ASSERT_NE(driver->ops->region_size, 0);
+	region_setup(self->iommu, self->iova_allocator, &driver->region,
+		     max_t(u64, roundup_pow_of_two(driver->ops->region_size),
+			   SZ_2M));
 
 	/* Any IOVA that doesn't overlap memcpy_region and driver->region. */
 	self->unmapped_iova = iova_allocator_alloc(self->iova_allocator, SZ_1G);
-- 
2.43.0


