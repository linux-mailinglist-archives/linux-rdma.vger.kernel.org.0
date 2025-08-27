Return-Path: <linux-rdma+bounces-12947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0895DB381DB
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 14:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9479F682381
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Aug 2025 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3042FABE7;
	Wed, 27 Aug 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jzCwat/X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012022.outbound.protection.outlook.com [52.101.126.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4632BD5B0;
	Wed, 27 Aug 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296020; cv=fail; b=H4Zro9azQFpUvyCRq4YR3Frf4Rj2hmVdIM3VKwZkuimiYHryvgu3vFinA1/3jQu46mkl+TGhUuk7NqOV+hAz0HzBKdUgoHJ8lwIqr1Npqff27RxUBeNMroMVRTJVxQ50zEH8pYcKprX8+OB3pTDzrF1YbfMYnRah50dD/fp8nB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296020; c=relaxed/simple;
	bh=hjr6pP20a6QijiCJM6kH3SzHyLujW1zjN5CFXECP9L0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jRIUjLRorzH6AZaINyq2wUEPnfh1I0IPeobGHGU+dtSXs7DbUqyy/SH1PzcM+zWFaxfIX11Pt+uvRs85kf3VGMhgesd4NInkH+3IEtW7pS+7NjLRCPPkxbt/ZhMlnz/YDuoJ7N4wnlOQhqBQyrsgPKlm7oEOGWujJ3z4OB7RtY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jzCwat/X; arc=fail smtp.client-ip=52.101.126.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wAH1ezklqWzwBG9C/iVM/1ZU38qVg4WwTsuV+zg4X+1NEwWjAW/kqzhSmUgBmtSDjfBpPPvP4uGX7Xy+USOznYs+wHDW7sDtBXHbY/DX2UeC65/oLwh5UCEUiWB4XdhSU8AWd2YlOuU2AFyho8F+KTlMyya8nfV9Uf5ygQ89vkTQmAOvrfBBMvyaj7wHCYckIBzIdplIfbUW9MxNsnpdbAe3LK4sUpHX0Og11czLzm+LtQzutnCIvP1TJRwuDbYJFQPsA5l9aZxrmE+0z4iDzEbKdJBZW9y/I1HTqGIlPC1NVrBk8/NV9X0qldfZhuTgYnjJLLQc+qnqw/0TF9Czfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWz0SzJXqHe0FQIA6ensOBchdlTzWT3ryZmlvzoPbRI=;
 b=Tzjyh3KvVwUhPbrEDgMNZSxZRrDeW8CfotQjx8cAYZcSSEzJI57gfNAiJB9KUjeZNl10c+2fmaBz/UkgeBtCPYSOxmmWDqNIBzwVksZTFofPqYC6338zC6ROftvZqqp4sK99/lEg85JrJlJYzGsavHrHoC2+Il/ddP4xymPTXWvRwzYfmeZPwqH9g9/orYHoAvPkwEYLEaoKh6UGDjIK2Ggtj1iL0h9FChUzbzWuKB+emEw+UanR4Zaz8tHEnZWb83S5C9j0iDhVCgCBtIQKgoY6auGO5wW/5Ct/pRsyeRGgSZ6rT+hiadIlEFGbISrk+cdkCyqw4yYyWh+8f0HLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWz0SzJXqHe0FQIA6ensOBchdlTzWT3ryZmlvzoPbRI=;
 b=jzCwat/XTn/1UPYOtwa4X2at3kTi/m4z6O4orJC3mfnl3imIDgrAieVqwMg0UuvN72+MRwuL+OUGSpB9n9952FRDovIyWwEW5KzRwlNJ7xx0ftIPNJQoa6CUPZ6uLp7bqwAbDWj3aT3kCtaoAGe6z4DZ1yazz+cRIne2sITcsOBwqU+vHXN8cy0jLVRiAM7F/JKOZbT3gbmt+KMW9XXfWMyIOjuF7a+BNVBsxAfXswJEz6oCjPt+zi5/0GIMcOlybyl/CrvTbq6ZZuGiy18FlGwqwvLotf5UcMNf+v5jlyVh3h/cU0UMKQW3Qr6hJaP5/lvPe/ZkQVbHYbymcdYpig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB6424.apcprd06.prod.outlook.com (2603:1096:101:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 12:00:16 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 12:00:16 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] RDMA/core: fix "truely"->"truly"
Date: Wed, 27 Aug 2025 20:00:07 +0800
Message-Id: <20250827120007.489496-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: ef99bfd5-edb4-4277-75ed-08dde5614928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DhjeVi+t/RdyNLEhYnYSF/E4FzuMd41u7LhpwiSNL9ClW6fraruT+w7LuP+Q?=
 =?us-ascii?Q?Dfpor8zN3jPSyjunKaTMZXuACSrXcMnXeqHfBngNAzzenK3ZANixmfqvT1n8?=
 =?us-ascii?Q?MyxL7w0YZBXCT9yPQ9XNvol3+cSd7njJnEYsSN7xeZAX5Jf2VxJDng6flXFr?=
 =?us-ascii?Q?FnLVSOHepuMEUhjgVvqOaSUB3BNdPEWVga82M2y1QZPzt9mzl2o0Dwe4hnTN?=
 =?us-ascii?Q?6C1IepyuYvdUBaPfsCA3kx5A5pOmeiUCQsAY6+M1+37ME0oOL5d1eqxyLQXZ?=
 =?us-ascii?Q?iAfef8uKHwWuHIITQkpMLFior3wKdC3yhxyzwfE7cQlwEeZDRuH4ESITE6fA?=
 =?us-ascii?Q?Y56n0+qmEAkEFliSEygMnEAzwJZa7dXH78Hc0WHIERYixpF7QU2D0sDBIZ3O?=
 =?us-ascii?Q?zyYpk9M9YRHFb5n+mf1cOhs5F8RFQXOUKruV0boitdZ00aDT9qbjrng7nP1M?=
 =?us-ascii?Q?pUyFZP9sCSeiRCFiL5fag5b/hWzGl2LR1Dyq0mY6L0wkGr9bNr1092G6mOPr?=
 =?us-ascii?Q?sQujLVDBjtX0BQvcdJXIwuxOrIw13CvQHSYc9kqdwDyoRcExTpTjsyuZ+5da?=
 =?us-ascii?Q?iwNUS1TrCKGzrf/jjcPuMcWYYhu/z8tUCKvnvXQoQi4wTEeGcJOKfzRovYr5?=
 =?us-ascii?Q?ZfPNPRjW6BWcCOITktq8bt2LKZ8cZxpXolrIcR2MLnHk+IjW0U1ajxy2fNLB?=
 =?us-ascii?Q?2/y8AfYsyTUYB/paBNZZa0cbeTIqSzAwckUDpN5O/cYoIvQoHhzOoPpE7oaC?=
 =?us-ascii?Q?dyEXRwhtNytavRtVLd/ajo3GrWR55xloTRPn+hzNumnZsXBhAhJPpXYr5aDX?=
 =?us-ascii?Q?ojymdWorZJdi/nEl/+vfuxPxL95SN/Zz8S+c4rCvEDa4zeacZSZ0SqRCTa2/?=
 =?us-ascii?Q?yUtpfWcSTUDXFPuevNzC4HKKVElfabFLTUZObbXRa+BFa/i7t+eZh6EXtnvE?=
 =?us-ascii?Q?FCtndb1DjLSOVk6C7n+Lsjfi2qV7olBKE+UoRNWwdu0XrvEnDWeXS0b186E9?=
 =?us-ascii?Q?M0xfkCCu8vyCUNy7VemDrlcDRYbQnPBgXcf5wIsMTegm3tSbOBIzMh4+evCE?=
 =?us-ascii?Q?pUX8Avnc+jOfO0vvvqO51Jd0nAlNGB7H7z7WhEF05nb0PA8Q2T6juV5aO2fy?=
 =?us-ascii?Q?QMDqplFq0IwGuF7WQ1SwH4bSI6RM5R3zSZeAQubPcnZcILm1EIjR4K48M+K/?=
 =?us-ascii?Q?Ex9rCk/1DEbbYpSwHebioPVOukhUwXl30mqz1EGiDcqoZ2gKjGbx1wGj36wO?=
 =?us-ascii?Q?H6YqwuG3ZuZdE43DBfRgIRvPVcL4Wuv7GcHhhulWiA7gmCtdyAOf1g01uT+a?=
 =?us-ascii?Q?e/58BrjqTOT/zPcSDBE5OUfx6jJ/TfkXb9uCd1yXiIMz//K/b+G1DtNHNc/0?=
 =?us-ascii?Q?kPhrdzWeZ2tGAyPoTJ4ggL1C4FeElTeiG08ULuQPZqX+mI83jNKSOpme3vd/?=
 =?us-ascii?Q?1cR9MJhnUoieE7+tSMwyam8KaJJE7riFaPrh2Es2+mSWrvNQLIg80g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JuOVY6XwyrH1FymjJp0dB73S4Y/NP72GSbFQCQZ9FEC9UcsUXfQEU4aSBSxd?=
 =?us-ascii?Q?Y7aUk/pabQ/rdzAOWvY/SuvnBt+F9V5cMHQjLF+rX2L4JTzzOcM+6kqHR7U+?=
 =?us-ascii?Q?fdPcmEQQ4WnHegenINgp/0rv3mmazY8/+d+eAoIOCxgORuesX1dSW3mUYnDV?=
 =?us-ascii?Q?BnTSQbCPYkCNT09G3KUPyy3pUig+UlEiwclTPskp2YUjoTRoBz9FlgaPM3XC?=
 =?us-ascii?Q?Ke49DLmElFFFritk1khzX1e7AKbqKDE+H5HUv3i39NpBPq1sz4z2Qwr3/JWh?=
 =?us-ascii?Q?1EZu+CLNLobM8ceqbGQmBIBInlXcGTEKH88Uijte8DsasK6CmqVDwN0TJfVU?=
 =?us-ascii?Q?eDLpUaqfbWz5Gg7qtLH/hdkpA0/9/8Hbvyqa6RjELtPGJJmJxZ49rhbQwZW8?=
 =?us-ascii?Q?X4xWSJwLiBsfLCnsVKEgnA7OOIzNTr3+KxX38FSxmph6jW88x/pYFelVIuY1?=
 =?us-ascii?Q?zRyeIieOOcUuSgcyjyeS3X2kCNDL4KJWSkdlDqf4G8g2l677CYDmb4oG8AFd?=
 =?us-ascii?Q?EcJwbfMu32rqiLzatGPaAQmHOoC8BBzEgbGhezlKIcdGBelbJjvgB7pZdPak?=
 =?us-ascii?Q?hHR9oeT0+YvhJIjy8tqUhrg48BIoKAOqexprff9ERBDvPdXWCqbWjXv+1YXr?=
 =?us-ascii?Q?YEWaFeoNrMBO6+hYGDANI0WYOkpdo4yEjCmT8jf9MN9AdRG4UaLnSLGex6sM?=
 =?us-ascii?Q?HGRsDwEDfEKQy6/jRaJXYZFcRj56T+PQYXZasQFZAeyzw2IYi9uFyhhkYoGw?=
 =?us-ascii?Q?auQTt6gqxmA5kas4ATrgUo3wnZRpsCGB19DqLfBs/EZhUKZGiPJeuLOQEL+B?=
 =?us-ascii?Q?QKaQ/s30CB3Mi7vSBDUH6HV6/VfmvoqOC5xv47G9k6vB7E7qbmz9TMPZ2al3?=
 =?us-ascii?Q?/OHs9AWdOmEof+iZPt5+lvgtLpFvCRuP0lpHnGxKNEzsB1Rj3IgDI8LC732/?=
 =?us-ascii?Q?ZtbHaf/dGzDN66u/owzE8r+TZc9NyCVDuEAXoNx43yKzlh9eD8RWo/aFKTKL?=
 =?us-ascii?Q?JdPt3FLD76J9EODhILod8l7NRC1qlLcrB9pVB9KvvOBedRp/NVkFlOzvOV4Q?=
 =?us-ascii?Q?5YJ2WUh1mBLL4Giw42QRONOKxLFtAcdjM0nbikfIAyLc3SMlNwODP4NqAMhR?=
 =?us-ascii?Q?m/wzxfAMAmKCyTcOwjYPHkOkwwiArdd+xNoP3nTuZ/ysSYkaZgKY42ft7p0U?=
 =?us-ascii?Q?hUUu+HOl5fAh+It4JztJ9iBzRYB3ZArsWNo0ixLpo4fa0VJQty7pNH0gIPJa?=
 =?us-ascii?Q?VJ0Z/7xZsfvNfa0HOk/cE5yq+3EMzo3W8oOajt++DiWUv1kilMBmGN1aWXi9?=
 =?us-ascii?Q?6TG7ZdjYfaKA7z/u3NAyjbg5+z0OGFZ4IpM5bMDwVdFTN9tzQ89ZxNJHm0ko?=
 =?us-ascii?Q?a2Zh2GJnO7FD+MBao92UhmTUJJzdrs39qG3v9Ez8Cy7MCvb+v3Tfjdu1MVez?=
 =?us-ascii?Q?RpW2L8N3zhx3xxXrQbm1he/Y+j1KHO8gSQmHaSO1fmxutimzxEgBnBcdGjKe?=
 =?us-ascii?Q?StQXbwtpAxsw0IDLOuvlmF9l4EdZdOvbKDPHJAcue2YVVXAEkEof1tK00Iko?=
 =?us-ascii?Q?lRDt/EBMKTucHQsSuszW8DGMatf0OLbpu6c1Dbqn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef99bfd5-edb4-4277-75ed-08dde5614928
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 12:00:16.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOA/EoYKWssJMo74VXjtwyMha2x/T3gt47UgFC2bKGp6lUWosQN3gSJSKhe2rVtynZMjImgAKU3pOQs0DJ8gYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6424

Trivial fix to spelling mistake in comment text.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3145cb34a1d2..b4f3c835844a 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1543,7 +1543,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 
 	/*
 	 * We have a registration lock so that all the calls to unregister are
-	 * fully fenced, once any unregister returns the device is truely
+	 * fully fenced, once any unregister returns the device is truly
 	 * unregistered even if multiple callers are unregistering it at the
 	 * same time. This also interacts with the registration flow and
 	 * provides sane semantics if register and unregister are racing.
-- 
2.34.1


