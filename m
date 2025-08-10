Return-Path: <linux-rdma+bounces-12637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34E8B1F8D4
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 09:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9C53BD250
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95194241695;
	Sun, 10 Aug 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PlxXLCM2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013051.outbound.protection.outlook.com [40.107.44.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47F423BD02;
	Sun, 10 Aug 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754811006; cv=fail; b=Rk9Hp1P0Y3OK1xX71OwFpf0of2lQn3Fye3KykvoH2bzaUZI5CYP6vcnR2C8noL1ifaC/NUuRS2DrFavRL5yTAT6E48+DhaFqzHwO05UC0mxpsS16skOsAEVIniqQ0CjZnv87BdDzRPg7Mfgid6REdm+BrDasYmtBfycbTCGKiw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754811006; c=relaxed/simple;
	bh=8jOOjyPYxrGmPyxaOYU0kPx/ltBFFm/Ws1TE+WIKIGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJ0h5ZsAXsn7tc8sTFKcpDGb2mYj5v1nw7pO5JF8x33yIKSzY1QlkOjlGsoSTqaX4/KQBz+Y36Ik5o5yEIngFDXunW+NHtKL7eYQ8tMrNQ3MOkXZAI35bxK3utRvSUejNwz51RgSJtywLIwsLLFPJ1Bu4xBTQDRlqxu5ZiFO4wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PlxXLCM2; arc=fail smtp.client-ip=40.107.44.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8fhqoUxO41Q6BuUUUfB47jxWjXnAlWwltcbS0Mx1zFZyf3mFQEfP3D0Bo0C6k4WDgpTi7Tn4qIDBgzluH9y75ZSolBcAyo8vPGTFvzUAV+R2JS5EjjEGbIJMAMNVggNO5Tt07oYBdyqkPCix0JAGPEZ6YcFU3IuG6m6XBejDczcPrJv44B594dpteOLAz85mEt3kFyCfYlqRAtU/8rW+DVJguMJf3MmMasRUquCAH2zRkzbRbGNXmnj87Nmp+yykUIwuFQQzgpU29KkGMNE6tmnPhf/z4r6zSa9ys5mleEA8wbESx4Sw8R2Rw8//Hmtc7+u0kPOaEUAKZMvOlI8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe4vAy6CQm0X4tWkIikjZQ4uL/Fkv5Wct+n7W1CgVb8=;
 b=XsTfMqJ3gzuouopkCtUbsm9DoHzH5VM0c6jrVBJGz4iQkbve1IlDENtAHFPj446H66dW/zDlaerH7nvjMzK3K/SWLSonB0osCnzm226Y46aerqlvBPXqfF71AmAY3XqEv5YuYXXqfEHyon7BIHytQYXpZLizrd6/9nNo3cP2OqriGQTHwYnGtNxXUMCjXT7DhlIL0g6OtyO74rnjMe9KO3XZVXTHs2CiARs4GCfwnOzUVNDVxLI+c/+K2oOcL9rZl9q6iulS5Nl17i1fZ9k8uFzTUbYRMszMI+hfyhMNdsT6J6xtTqZXN4C3SNDtuVdZ9imHQWz7bHNntMEgERx9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe4vAy6CQm0X4tWkIikjZQ4uL/Fkv5Wct+n7W1CgVb8=;
 b=PlxXLCM2w3cAI4QwE00o4TDYCa+92XCTp55e+gryDkSVnZFdWc/l5b2vcOtAgScWC9Y7V/cMfshRdDKSP+X0SZ/TVDozGJh3TSsPlW7d+1/V9XuiNtLcFsAtYWMFD52/sa34B6+igwjNkCUBkJFACL7sM4+EIU+EsWD1fz/GP7OoBro3XVdO4V0hka9Ju0CUd7Lzkc8rxkKF8bo93OFO4epxNwEs2tdH9AUtq+VKWvrB4nMz+TC25AxteKBMagIdAFpodOJN7Fgrz8YiK2bMNIlEasF4uHdZza0pw0BARbiYAHAODlfC2ImLN1+WYC1zBhr2eF5EFrLgf/giuC095w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYSPR06MB6576.apcprd06.prod.outlook.com (2603:1096:400:47b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 07:30:02 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 07:30:02 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:RDS - RELIABLE DATAGRAM SOCKETS),
	linux-rdma@vger.kernel.org (open list:RDS - RELIABLE DATAGRAM SOCKETS),
	rds-devel@oss.oracle.com (moderated list:RDS - RELIABLE DATAGRAM SOCKETS),
	linux-kernel@vger.kernel.org (open list)
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 2/3] RDS: remove redundant __GFP_NOWARN
Date: Sun, 10 Aug 2025 15:29:41 +0800
Message-Id: <20250810072944.438574-3-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810072944.438574-1-rongqianfeng@vivo.com>
References: <20250810072944.438574-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYSPR06MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd3e1e8-bdf7-437b-211c-08ddd7dfb84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XSKoZ9XwOsIwUaES1TER6vr4Nb1Pi8p43FSENWwvBOCqSE0x8h6sjxtC9IpA?=
 =?us-ascii?Q?+wGa7M0pzia9nFgVOCsAxsTRRVB1McVzdJYG+0w3ZQ80OwTr2jS096Vhjn6t?=
 =?us-ascii?Q?6i1gwiDbwyYpXDdPymarlM5jVPc74woYjTH9TR5M0+SOnTQnz59W/rHjEK5D?=
 =?us-ascii?Q?d+TD/Pe27kUsHyshU37G+8MWiSY0hnSFt/gLGgnCuJ8UqjbI7+y5nXr1kCM8?=
 =?us-ascii?Q?z2yjybWa1A0UzKtVLRUvXl+3bnVrjxk0jrF4nAFcOXB7rBj2ElgJT6CRKvwe?=
 =?us-ascii?Q?fxMMW8gWPaRXU25B63AXQsbYvq83HpN05g7oCp9dNWmFEh+UEgXYEZTFNyMs?=
 =?us-ascii?Q?lEC3d0HYbCOvK/eazzaawcuXGwY/jeF+B5wIW4f/jHVdkvU3nsBaWwgQ/xbh?=
 =?us-ascii?Q?Xmb0DEglBvoShYkZU5fnEbn8oLh9dfTVXL2jUgVKYDzQB2qSs3ya0CCId6lJ?=
 =?us-ascii?Q?PBRsCv++4QM81LKGMH60a7ND6tj4IYAUmm1avDjumUHHcs5A+0TklUg5KQMT?=
 =?us-ascii?Q?lvJtE0TOH6ELFsg8OWpOob4G3Cdq3F4ZPnlVHKjiHg5khM226ue7a+hDApeX?=
 =?us-ascii?Q?WfKoQcrybsU159TVxZPu+BXju0gM2un4VRtNdO2RZ4lKzzJuB5cuSuiGOjKH?=
 =?us-ascii?Q?A5WlS9qNTPs5C0NBD60MtFCQzYvLy4o/S5ExEzq3mB++jL2Vmt7EXreLG9wU?=
 =?us-ascii?Q?8S+BsfpxB/ddDqwK0xMPYbdCJQjkXLKcsXFLrViI8VhxK4bL5+sUxbOqCrF/?=
 =?us-ascii?Q?jELrdAEFgkBOcjmPLRJ582XhHfzRdOmYio/CcJY9g0ho6qcJQYPed7vF7N6P?=
 =?us-ascii?Q?RV9twown2SuUxx2jZ7stP0hZD2sJwM0XfYEXtnmM5uq8ttWFuujmXWw304Ju?=
 =?us-ascii?Q?PnZxyYSWkzPeLBRiG6qchKwj5VGD0uPXzzoiWchbo2uzdeh8QEd+kL7Y2+RP?=
 =?us-ascii?Q?wiyHWoYsFMTUMmxR7X74KQMoizvbjclt8Zs6zg2dRKL7DKmUOr6tWnwFOaEh?=
 =?us-ascii?Q?hCzdedG1/vtPjMiYBYPsPp+i1sVHidHL4/aIjBnTogTJ794n58QJCNuB6+gY?=
 =?us-ascii?Q?WCMV1qesYC0YgxdNGLTyghUVX1PiRK9upyEYlDhYs3vDB6tKXbQbsuFN3djW?=
 =?us-ascii?Q?PDIobfw1fSqh9TQxvigdd9OzaBy6hKzM1SMTKQPLf86tRw8bp+VpAcTAcXkO?=
 =?us-ascii?Q?t80mD7/OU4TFCZIizTJZC3yQnvkcNFUBYwzv7wxcBtFNQdADrxbeAgOKgiW/?=
 =?us-ascii?Q?mRLgszZIVxs2PsjWGW7/IgRiXFGL45C1lIgmsMHek3K11w0456OBA6Yq6FSn?=
 =?us-ascii?Q?1W6JhtUy3NEgIZEVwz2pk76bSjQE87vBaHaeQoMcUORaJLlTKJ2oiw+DRNiJ?=
 =?us-ascii?Q?itLhmfCK63rzpBwcXVOLhXC9XB33M5+tjnMcnbmG8KJBMfEAbaShgUIF1jAn?=
 =?us-ascii?Q?yBVjffX0fenUPCIkMvRubtpWiDn/jx1KOCUeyylI0P5FJ1irXTKl3Jz3elh0?=
 =?us-ascii?Q?tYyg4ejpBTmk+Po=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u4SgDOea3mqWy5a/CHparp+wr9mm8xiNoFzk33rQeN2hGAd//2Ai1QK76Xde?=
 =?us-ascii?Q?diP04CrNRdu+G+NN6LiuvPKdp5851XZMbS7nHFm60LmLyHQSHE6RcCvyXcm8?=
 =?us-ascii?Q?mJ2ty9kSp2rnhY8rAqdqaRhCyuE8p4sui8YYKdwJx7ADy2ciMeu6aWfIaEsF?=
 =?us-ascii?Q?Upe/HtFZjaJI8ygeIYCODudBBjnHewWp5ShkjASJGY9uivABtIIEX3nAXpvt?=
 =?us-ascii?Q?xFIRTX0aEZXAhwRx6ymOUMSvlXRszOYBXqA2k+yVbUK24Xgn/74kz/U8hvLO?=
 =?us-ascii?Q?ccLvxajM9AytFVV8gmHxov61pfCu1JpzI7EtL6MBzvYu0mWr4lzvawHWhY4R?=
 =?us-ascii?Q?o/TKO6L3f3u9UXK7qSRr6YVoR30+1WO+JvB+wz8XP/GpxC5HtK/7N/bx206e?=
 =?us-ascii?Q?qF7NmyjyoSPjLMVsN4K+IM+J0HVevOUv6JBPT/WcEbuB6QBeC6uYbO1amY4T?=
 =?us-ascii?Q?MQ5qDofXxtzVtf6pE8sAzuMXxps4PBYjyD0WUhDwUZq2SqVc9pj6hXl1E1gg?=
 =?us-ascii?Q?Igvl6eSLuJ5I08lgCjQqJPgfcsVyS5gzUefGg6pVMN8J7qmov1WwPd4b1M97?=
 =?us-ascii?Q?S2m0t3hiHj2aKNqYJGYWBu+QjM7C9JKbf/dEEVCFoMZdrSKooBpm8qUEm4RY?=
 =?us-ascii?Q?wpWzX5JaN43G2ouR1RPPe2YqA8NkpUQnCpVYFwcoc2K6u2CX2dGu9WDoqhlb?=
 =?us-ascii?Q?s4PK9d7H8BtBv6y/t8+RiS21I5OF6jI8VQZaZ4ke9apTBMr+CEe2zStIsLmi?=
 =?us-ascii?Q?OG3xmsR50PK6a9ZrIBtb7DdJpI4V8E3T7m6NbV4eUbPgfm03MO4aSDuCqGe9?=
 =?us-ascii?Q?Qe8cM7RNJdkIsFCA4GWSVbL3ZsbB3edLwBFE1YJbNLQgAGuT8RVRe2nwTS+m?=
 =?us-ascii?Q?flMJEq2cqQIyMrjmNAnh5yrIcWfPn1oEsCWgyMlsomF07WjNbgFprVXNe3f3?=
 =?us-ascii?Q?GxgulathEwJilDrmVWv/YJ4tRJDRsyKVx7fGfRrmrRpwaO+4+tvP2fuy/p7p?=
 =?us-ascii?Q?Rxq/AYeoezNs9SxGfP8ziKyOdniwhT4FaADTSGjtnrTaHp5PcFOY2vVk3UYI?=
 =?us-ascii?Q?CjgKOZfmlGn1fzOHbCGJWFRr4TSjogER9NTM+4rpB2S5iEVizvVw+X8C6CpF?=
 =?us-ascii?Q?HkiCPOksXCrIExZr9G05H7iRPbOrm2kmQEQm7z7Y0ECOChEzHKlrwHrX87zV?=
 =?us-ascii?Q?iB+vzyeFR4Hep76XOhN/Sj3NBHVfyIqA2dFrkU8jmvklU6+tcugWSNRnBWcl?=
 =?us-ascii?Q?GpD5T6crW0qdiUM2Hgu/uaNjUwfxYplqWswFzB0GW5g0exHynJ/58/6lZRSU?=
 =?us-ascii?Q?PcTq1jIsv0zE/VWaZn18gmFIquoSRXhxAWcsHkVWlYSgRFt13ux7BdO6hXag?=
 =?us-ascii?Q?vidj5hzywkE5QIUSr/JyJroCNKlOiRNTROTwypWqH/ZEvuk1Ev5mJ94WDrDV?=
 =?us-ascii?Q?hYBF79pzEnOEGdPcUx3beuDEwBtLieOEY7bvS1ct4EYO0BznYXbUMgDigrpV?=
 =?us-ascii?Q?9Tuqv5o63VmZ3TuaxYLD5nJkJaYWEaHjmV95hoMxtRpqJV8+z1vv6TS2IAx+?=
 =?us-ascii?Q?k+Klmh+bs3s3Xk507M3l8tcU5DstEl+VwgVBUMGA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd3e1e8-bdf7-437b-211c-08ddd7dfb84a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 07:30:02.8488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWPdouFbvkEb5w/L1GxANg2/Vry9i7wzIiNoU47xBirx3VT/MIbGxCySmlbTHQzbIGiBcuKl07rw27Bl1kwmUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6576

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
__GFP_NOWARN.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 net/rds/ib_recv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index e53b7f266bd7..4248dfa816eb 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -1034,7 +1034,7 @@ void rds_ib_recv_cqe_handler(struct rds_ib_connection *ic,
 		rds_ib_stats_inc(s_ib_rx_ring_empty);
 
 	if (rds_ib_ring_low(&ic->i_recv_ring)) {
-		rds_ib_recv_refill(conn, 0, GFP_NOWAIT | __GFP_NOWARN);
+		rds_ib_recv_refill(conn, 0, GFP_NOWAIT);
 		rds_ib_stats_inc(s_ib_rx_refill_from_cq);
 	}
 }
-- 
2.34.1


