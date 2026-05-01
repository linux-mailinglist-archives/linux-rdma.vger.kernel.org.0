Return-Path: <linux-rdma+bounces-19804-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE36Chjv82n38wEAu9opvQ
	(envelope-from <linux-rdma+bounces-19804-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:08:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3C4A9197
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 170BE3010B72
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3EA1684BE;
	Fri,  1 May 2026 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s5K14Eix"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BB81732;
	Fri,  1 May 2026 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777594128; cv=fail; b=thMTHqzLMvLk3lPRIhns5v+4YCyqSSDhz4+POh00CpL6JZ2vgX0V0yQC2Fa4MbyAPUkhy2RX0bZIZXZgQCGdgAqXWcEz9UA3BIuNRjAruSLWCxU4PP/WJWHOo9bzUZ8QsGvR5ugf4U/yypGXbQa/xmT/yLyqhD0KaNKj+QrAGO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777594128; c=relaxed/simple;
	bh=lggE1rtPfHtoUGHC9J94m+26DqukC/fBcuL/Chf0dTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+k18huaCcHdguT3wcucgBchij3KtnBsq3mr+gEK0h9LuHnrG7Xp81+3uzg6lYMg85IQ3prXJJWyoGQhbZ8RxLTBJW6EK30iylEuEJTgIz2PIGKgVBRg1pBZYc+r6rTk2KtTR/keMTJ8njCTpsW1tSqEVgooqIxJLcGld6jFaTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s5K14Eix; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7EbjJquqNAyI8Du43gMV4gYiJNfKeiInBUrjsdlT9A/YB5+P2lxdvNJdEEP1BTW5Rb9noDoFB7QFW+HVMyXkicI1/RNRMQFk4Hx8zhP7N34YvT+4b4gHMdXjw3KpdPKCAIomnWFAiGTgODr9LyhRR5E0Ws40v3NljN4sA/8eozj0YlMvh4JPcbetG6EGQCPxWIqn+A52CmPl7+/8NuB/kMeu2uI0fhgKkQWc/h1v49wkGYnT43SVb05MrucZdpSfD+vShjGCmreDU6f6N4zOac7V2Up35w+Dn6S8NwsOhUVy08PImJNzJ6n52pg3jOnPSRRqcXhe05fYvTtgDfoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WH8QTgzVEvwVn1J023aYxR41RTUe2ha67t2tbOgrUHk=;
 b=irK0QlQfRu/UC41HrmyRMLEuTN2oBjU5gSXBWqmm6FMW0Y2cT0ljvWS4HqloGLjGAdkmO195IWqObaIpvfgXv5ZRfyitIbYjoBYon/WRgSXjliK6rbRA9Y0rWBfULBBmQGmODrB8C8IJVa+RfE3oa4QLKrEv7OP5ownOyYbpuR4vhyOgZ2R1kWuCsx1/NnAxcdmiWtvpx7tqXByY2DhOpn5rq41Yu52ugbtlWeLMC41MLDfiSEttTnzGqcxy0ijAo7ItC3r/buKNQgwGY5YEBlaSx/MGFrtES2qIVTxvnkqc1E3OoSf+/5j0V1/WDHdxkSVunPYH4RBesi99D4XUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WH8QTgzVEvwVn1J023aYxR41RTUe2ha67t2tbOgrUHk=;
 b=s5K14EixYgIRW6poOXSM0o458jN4KeYHq9phUzd5KcrlcGPP+kIQtteBsAUyh+gECaY8reObndECoqeWnDVaqN74Cd/VI5T79jgOA6R+OjDZ1vpW8vdFKbfwcnfZszZYP7+N9lna3tIeM7lVhqWcwBa5AMyxbeUek5Rd13B+eJDt9qXzvtIv3RC8n3Ky0MxZJQnFYOo3p5CMjFuRlqxpXGPjTyBw8OIXrA7v50u1TGJXlAj1Vm4kXde/IL9S8sj8dF1wE/CthibMVK4d78OHBZWtO9ehWk2Z83RZrJh8d1F/ZbMH0vf/jj0WHR97ZdXNbY34UD0KS1cqeuRPBL+D/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SAVPR12MB999167.namprd12.prod.outlook.com (2603:10b6:806:4e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Fri, 1 May
 2026 00:08:39 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Fri, 1 May 2026
 00:08:39 +0000
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
Subject: [PATCH 04/11] net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
Date: Thu, 30 Apr 2026 21:08:30 -0300
Message-ID: <4-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
In-Reply-To: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SAVPR12MB999167:EE_
X-MS-Office365-Filtering-Correlation-Id: df0d0f53-6d66-4c97-1e0a-08dea715cb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1kk6e0pYCZBjXDMS4pUvYs4p1pS4V+z/8gHWbpRJ26cybWxmmR3TmTjwVFfEMcpru7ImfnzMw8J8NwiQHv71WRh2gE87VeXqOrY6ZgpriNBk2qd8XHliwTS0RBzMOIOXLsQ0KvGcfA6rgGmUGrQ+BzTYaPh4Acj11Y8KFu03CsB9WHv3twqfv91IHfEkMOhiDxUrJ6tN9DRl9qEoReSbcvdg4Ek4KICDf2TPJWIJBdtVySnKqSwcCJA2lJApxbm8rJjVqcJVqz6+APakvKBtq33lclswedmzBMDr1iYYgRrFPys4jpmrSXHG0uQzfL3VkZEFRqnPPSXLvhvNdf4vCdjLxkolx6NM56pRCoLG5PnAhoKSKox+FLoKoIudyQhVvAPe9komIszQuCcz2UtO8Hj4+kklI25L8IqDuaTh32jKgmw+VGrtdBF0RntabF6w+ZXcRwAF7qaUs5JIrvNkz9eYgr0sezlp8ERAAB1R68Iiv0Leq2dMRFHrUfZsUArAXy6UwzDrsk1IZ9qHwlZ5pdX/vcLDCMppg1JOVDUmHwWLVp0hEy97B/G+BuDZayacmKZDZtN8Rwod9JL6YrLWpZW9obdSgAQx3jAWeGXufza318qTmADDxOk1Tyr5uaT8qfrtJAV2tEZKDdCA8+5dfMuRUeum2CXha72qSuwNs6dRy4TsiS6a4B+czG9/NIxZoElzhwMR8D2eSNeIvfe0fkLWzbu3PHOjYrX0bnlEoXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KxVIkOCEjZIoqnxtuQ7ALTPSYQp6j9pBQ202+ITbvmn564A0nF+ydI9qFkRF?=
 =?us-ascii?Q?0387y19mgoD0ZDt84xT69LhDKMDHiUizPddh9/BNaAwH0OMnmB0313Crim0p?=
 =?us-ascii?Q?OJJHF6rrkecTpNze5zqNrnMFfC/DS2jXiq5fAEbXBZQkyZO13/dlWajXxG1F?=
 =?us-ascii?Q?AdyH4rAUMSFYcu95QqM/qskkptk+0T+IEGxzC5FwdIAtIA+WxJWL42zIDa8h?=
 =?us-ascii?Q?nOUty9OZMnWIHc42pnkovdXxHMpdy9XElOIhCYGlatmKnDDwgd20oabBJHDA?=
 =?us-ascii?Q?YBI0dFmp/KEYt2Uy2SQkUN+fTCI9/E5Ltcaa5Z0oMibYZQ1j+nQ2oe4srS19?=
 =?us-ascii?Q?1gzbWEPQBKFn+p+UhiIBIjCdqQQFKY3LFjK1TwNdVN3OHzrsVP0H4VA3BW7u?=
 =?us-ascii?Q?OzEh4tKHoSIM48Cq9jQQlUtEfNl7FjhU6Y3TPhiVAsWD5TpCYdcbXEesobYh?=
 =?us-ascii?Q?k8DbDQeUX/4FWigO3aDpz9b/nq5frkYrzz6F8nqD836OUIqQiU/zR9ptfe0Z?=
 =?us-ascii?Q?mXwXBCJeSr2SV+bsQ+UeveVoXNN/Wa6qMFJ8/osVz1aoRUoyoa+Z2yQwGpPj?=
 =?us-ascii?Q?qq4mQ7R6tFRP93rw081F4jiAk9kLoCjAXw83YoHKzNLwWu/U4197UDKGwATZ?=
 =?us-ascii?Q?A+Wfz/XZAS++KUv5OyiDKyijdoEHbalIjT/JV9fZaxSjWgYYt+TK1bqBeALA?=
 =?us-ascii?Q?f8UNbTNE3c7ubNhCwt5V0Sn3tmSFiVBRMH6OJzkoHEdrOHXG3J0xBN4q5HXq?=
 =?us-ascii?Q?E6GOCPlN9QAFNKywo8jQfsuTNKlNGU+1nf6Y42HSlvswaAo8BwNCrhvoM2o9?=
 =?us-ascii?Q?mXLXO/SFtvw5B3VJIqjC5b/yfm0l4ivencHAoL9QI9prhtY33KOvPNY7MBqv?=
 =?us-ascii?Q?lKmKsXtkH6DJ/NA2YtD59OKwgJTR6RQer/ZTXbVEGDwHlHaqnln6zYs55Qai?=
 =?us-ascii?Q?EFhU92OPoAp1oXRz6DZLgQtXDpDB2ISNVlL1d50BsSwaaZPVC7cKZjZzBJC4?=
 =?us-ascii?Q?nEx94uIhq8T6yMiJTo7RaIFjdHSQT/WJTyqF/ELvd6h9AQkQAsEswKyTQoKY?=
 =?us-ascii?Q?L9UdJpeN3x1nhJyA/WX2G4P3ZErE2UTONGHUN5So5q0XaDE1QHl3/2eMFKnW?=
 =?us-ascii?Q?CgDsA8MOUEtJ7PAwl1IoR4MXQivFHHifDxcEokeS+etNSMBfnAeVU7K9JlMZ?=
 =?us-ascii?Q?ZRC9fNHaJOBfRIvXxG+kNnTMwgpI/Q3PZjOdfj3oNwhq8iP+8lPN0QsxBN6J?=
 =?us-ascii?Q?k/5bwdyjri8ywP5ee0YxxL/L/ploumwAj4CMbw0oJLAdZx0KsPImbN0kNauH?=
 =?us-ascii?Q?/b6ZYWOkqd9CyZpgxX4Vvmy6OwuZCw63GGtar6zIfPdmRngLKZx80C40cpVM?=
 =?us-ascii?Q?5/wPirdzAdC4dxi33Y+xYZkdFVKo5bcYL7d1g4XCqSedY+/gqxZMuUKAquX2?=
 =?us-ascii?Q?5AYsAFtxQRXaRj2duchBjtvavz9HRCgGTHQB18CTrqK6UfIm0a0oYag+QpWJ?=
 =?us-ascii?Q?vYp7uRjVY+CjDrTHgeQcpKV1GcOjNfNy0GtDwSl7KF8AP5a6+JwwEDwlIObt?=
 =?us-ascii?Q?lqWA+IKxfm7yl5/GWXqMYOt8FYqN7h9hellWY1FHsZYk87KSEsIdu4bKq43H?=
 =?us-ascii?Q?XV9jWFLrL6Guy3HZIZLhyOJ7wZuLMcPQQC8mfn57FEj3ryHBmxS4sjQn2+pu?=
 =?us-ascii?Q?Gk1r6kYEm6N26ggr10ISE5k0wWpkdMg2EfhoqROqxj5pt1Z9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0d0f53-6d66-4c97-1e0a-08dea715cb77
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 00:08:38.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDOLxnUq/zn37KvdRT3tnH6Yz83aHQvFmOQYxIpEbdmK382JeQlHig6qI1bl6Tve
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999167
X-Rspamd-Queue-Id: BBF3C4A9197
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19804-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim]

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


