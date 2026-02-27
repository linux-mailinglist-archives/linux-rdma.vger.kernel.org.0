Return-Path: <linux-rdma+bounces-17267-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNEtJlzvoGmOoAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17267-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0661B1685
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 02:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83CF4304D1DF
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B092BE7A7;
	Fri, 27 Feb 2026 01:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c6f1vJTm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6528FA9A
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 01:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154689; cv=fail; b=a/ONxyPPI8oDLnS2RUXxS/SwBzWlk3L0FkVsZ91XnT/7RBjTqwgbrpNgKBdeJ0qNVpoa/XgW97jK2vaXHJkQZp134yoG1/xhKSY6J05hDW0kMjp5O4oNNwstvCBHVEFG/tri1WA8m7Wspk44dfJifBXT0m6ejg9kxWMKpF9FYwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154689; c=relaxed/simple;
	bh=XwwlLQcIitNSelCqA7dEDSbTZQ5CUfMqhydOUUhrS4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UntqnsboQz6Cm+c2mcJtAzKbyQZOzxp2Q4H0gbNxrL6RQ9fDQLQv/AVGSXQ4N3Lw2vSe50up/YTJYPc6yUAU36VdVctgSibAeAokBDEHrUju6TGQR5KZGcrFuZlxjqkEg3kI30GcLZXq2uB3pjKrqCirNCU4UX6XCkIEbe1v+LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c6f1vJTm; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpj5D80eqsqrU1bgPVmp/Dyv2dhqpBxtqIRyKNvhz5WPc0ARgQjfMdDDM4oFcs+zmo+0a39mB6OQV5aglSxfUIStm02y5Ihvn71zj+wJqmZJkbVtMYbMldLQLJ2BxX/CRgjUbRMm3TQtXP3qvQAXaMv64TGoMWQIcqeP2T1TdqJzo1yxkU1UJHrZ07wG4QBJq+CpB0jshtVP8Ujl4WsCR3TLOYdvKvIWzAaGlpYU/HJF2IpMY2iTK7Np9Qz3k8JLEWHy6jEp2Bk55lhfchalAgJusIyHwPcRpqpUlqFXsE3oVTt/dM0dvnLY6LIo1RrFVlVThmKNizcqRY3YSpmFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx0urKmxpq9C1VL29bxj5D6BuRCFL1Pk/uJaTnys7M4=;
 b=dYuZo/FjK8RsIIFFSlsR5sPSgTiYZGK3gelXQauH1eP/+Ufb33dgVApESs/yl1XqsMDuQ/6cIRvDR2tvaHBH7y85p8qhxkza6kaO/eMubqXHvfO2bPYU7dOUK2yaTtrN0rflelr9CUtcwHb0QlUrnfv539EX6jd/MfHcpHy7JZVytzlhBN1uBVKM7lwdDKBEd6Gql7l91X+efgU9hYfYZgIvr4vJPoimFQ1COlPcso7N14S6jVcA+Knds5ZHql/C8Vb8Fa1C2RHEswWyXxVRE7YYPDIAOqZm/il7r4SapB1LMxdDnHsQZEf2bu8YsvM2IrhkoPGteoUjN+DgLvoGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx0urKmxpq9C1VL29bxj5D6BuRCFL1Pk/uJaTnys7M4=;
 b=c6f1vJTm7j2XnMe2pSFb38u1s4HlVtOltmOh6hNMeH8pqudO21QsFH0b+gJ/7BpcrN5BhXT8tp0SEQXW5xppEGsJSnoieMC9+GaqadOi5i45kUejtFrcwI+4fjo6bRFzwkf2CrsHc9TrguYEWOcPbnVgJ2n2/l1JOx69+0TcjMz/IzIOjyrAsi328+a3fsR90Exlpg5zW4IHW+n6THCO1I91aLqgg2/59yvfEdyhwqXhYCz19g/0iov9rSLdAXxObzjtdbWTg5n84kXzK8ydb77+jvsQuauV8czDw1sPhedZ8/ORWCphiZKWtBQjao9Uu7XAogZ4vhal3TO1lhewjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 01:11:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 01:11:22 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v2 06/13] RDMA: Add ib_is_udata_in_empty()
Date: Thu, 26 Feb 2026 21:11:09 -0400
Message-ID: <6-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v2-13af4a900857+4f13-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:208:23e::30) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d615ea2-0cd2-42de-b8ad-08de759d1d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	vjvgTYMF0ADgRECz5nEePaCU6oYVq3wfCCfqXD96/8S3J4w/z6B74mecmtheFV1YwkZK7TFq5LQHg/2bgzQaYHlPu9uJy3hMUMZV1Rghyw+p4kj9vXAHCDo75ldxXbaCWsJ5x52y09LkyZCEy7zOWpSUFa+Hc07Q7ylB+MSEokGLsUZ2yqngbB4a41gd4e77T13WZprj//062pcRIpyT7q70ddO65Cl5DQfOMfAtXGO94Ov6nsJN9MhFP/DYhi7x7fvyRUAZjJcWOJdU61xL7TWLHj2x1epl2UOcl0zipuKEjo5QMv92rSbp7x2J3dew4WZdCAJHIxf0hsj1pFIoGkTjbK+owmsTuekm0TPvC7UjusTTS1W4AR6bFjsBmhWKNNGoDmA9i1R6TgMP1Esji2SBXZ1mVNaJkLRxjC2pQo4QHu9gJBl2W/mOQIqUokE7pA8ntokTdsglDoEiZvmfmGRJkVdFzChoBwZEZzz7QkdSITwIty15YAarnTyMhiHIDAUHq+tzjrq3ERchn2uyd9nDtYip36llZq6I89nWajna1fu68Opy9grfrZ3KeU4aoyDfzmMUPWlPPvKeF/PidGCpSQ+87QTrTsRKFq5qtcO87rhkW4j/gTd6DYby3sLmSVff2tNQPIGoqJadln0Hh3gx9SYWJLUbG42v+ll14XDffppLTnl3FYQkxmK6+VzGaWBkOQcY9RvY6CiXZi2T3OkR74G9PQRsn+kT3rXe5k8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bpc9WjA8ImiPGJy6aJcSfNSRX5RW+9RQBWC3Khs0yswO2fzVN25pqqJ+rK0O?=
 =?us-ascii?Q?EWw8Qn98/EXTCA/0NuVIL+wfZnYWdpb/y5hSCjTZb1LSjb9MIBlsVa+w5IwK?=
 =?us-ascii?Q?EJUdzF0EPxMM0EmyJjAhw8vBuEs+kgkn3JpBrQ1OLUsh4ERS8TvpUZY79zFq?=
 =?us-ascii?Q?AnLQdG+ZEkpNZdSYq4fYKxNXT7qZSIT2sFw9Q1Qg9biS94lYjUV81DfWC4cA?=
 =?us-ascii?Q?Kj7WS9aX/BfkTAhB/q1stVFYlIEt+o9DoLeWp1w9w8ajxd3M3NTG+5mWngw5?=
 =?us-ascii?Q?zRwrO47BoGsgAV2bpIpWFimdDKxAQMo/zqTJn2jOk8BsVpHQT8QRb9vTa/HQ?=
 =?us-ascii?Q?SkMZcQb4sSznUAQOjiLBhIFRu0R3tbfpsnfg5SuNfYcqhMYNP5FZAlVipenU?=
 =?us-ascii?Q?nHMnztJyNHOmhsOLVFQssv7EQoChnGVWT2FXtcZ7Q32FZ5O5hLioIW3hHFRc?=
 =?us-ascii?Q?EEtl7TkxIV2+mv73LniknwplZjTc4ZWUJgYdf3NjQ8gSsLBSpLjTn9XiTY0w?=
 =?us-ascii?Q?vpSR7hSKI0veqUz7XJIuNVAn5FZkD6+bzJeW0yjmbxkIBo9YMzKcvjWYoID6?=
 =?us-ascii?Q?xLkAeY1JanM7VcM4kRKh/yLizpwQHcbG+/SHWJxWNUpyf05AJN5gF4PMFZMy?=
 =?us-ascii?Q?UysWF6CF/0KQjJvadQQvEaNy6xlWZidgS36TVktM+lo4dTLCcLO69Vbg2QeR?=
 =?us-ascii?Q?vom16wT/nowRm2OrsLDeDg0+1jgHN/aEDhNmpd4eBWm2ih3U34BEn/t5FlE1?=
 =?us-ascii?Q?EcoG2Gme0OCDnf129NpwDGKU9uPorAmApggsjkQ0LdPm1m7S+bB6z3MPeSBs?=
 =?us-ascii?Q?S8RZT9MGFfCuqiUh3kmnuMIFTit6cBTlOXpkKM4lSInVBVSuySfACsWfBf9x?=
 =?us-ascii?Q?hJNgWEhrH2hbvCsdb3HmyMs0UG9+fQ9VuhGH2/qaGgCNdGzJcn0DYwunUlr9?=
 =?us-ascii?Q?B+COhSuvR/5ZXwcdlNmPC3McHUHNqMIc1GaSi/n3JcBP3yi2f1eke8FWVf65?=
 =?us-ascii?Q?xSpes6dJPRUWN+TLwVV+gBiIzfuE752qkKHh614nsV+EoZ/sYF6QpeebeUmg?=
 =?us-ascii?Q?Fwf7iMdBWxHJVF95oFtN69ZKlNMwhE9mNJ7ZTjEzVeRFX5t7TlrYHBt59gZ7?=
 =?us-ascii?Q?F/f6UEz80/bt7XExLkeEQZXnesyO+efAHY6Mbixv01emdU1/wGzODQAqgkAR?=
 =?us-ascii?Q?YuUqEoIbob3ctbyimCKalUNuoAPKDW+wIPLkMjzwQUSwU6W03msf3Ne8lYlc?=
 =?us-ascii?Q?RvwzsAdxwaqCGYvk+oQbFRvT76O4sfe7m7uJg++E+z1gcr79oMji9kOB7tHv?=
 =?us-ascii?Q?NYclbwH2OVr2RzcJiBlRuY1Jp1ID6JSZ/5TIlOgZSWr4qIJTklooWWlx0s35?=
 =?us-ascii?Q?enqonAaAc55m+L61cx3nrqRKBV1QrMvsKfEViaEqpV5+79nJnHIWSoqxFvcS?=
 =?us-ascii?Q?H5Mm0fsMuMAZRRwKgUtAkyJNYqg46jClKHdT1EQzfD02Dnr/qBgA0FPwCdmx?=
 =?us-ascii?Q?cXd4C3raqD1SZG5xfGUgLrcizfKAlOXppTftIabaC6ZBV1R5AYS1wLvQ/26p?=
 =?us-ascii?Q?rZ5nUhvzyPxV54TGgeE3KUU0wb8srOIYhIz2d8n7j0KcYYrn6G6KXr5Hrq8o?=
 =?us-ascii?Q?rBBVYpr8mFlPirgLQ0XGjxIZySv0naks8H8/ouhHkbsKyRszemD+Xeot0tSD?=
 =?us-ascii?Q?FLaShAtZw4TnQoF+GSg9jFH2iFCagUc18moirpxtZiUcFzEcBKETjSg2J801?=
 =?us-ascii?Q?PZeH/nax5w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d615ea2-0cd2-42de-b8ad-08de759d1d07
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 01:11:19.8956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNEmZM8+4x39E1r8+hsz9oiChziZ0GL2HyvuflW2qWB3b1MkVxukhDSGsBuU6MfV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17267-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 1A0661B1685
X-Rspamd-Action: no action

If the driver doesn't yet support any request driver data it should check
that it is all zeroed. This is a common pattern, add a helper around
_ib_copy_validate_udata_in() to do this.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/uverbs_ioctl.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 720f173c2b3fc7..cf395fa8c36174 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -1075,6 +1075,21 @@ int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
 		ret;                                                          \
 	})
 
+/**
+ * ib_is_udata_in_empty - Check if the udata input buffer is all zeros
+ * @udata: The system calls ib_udata struct
+ *
+ * This should be used if the driver does not currently define a driver data
+ * struct. Returns 0 if the buffer is empty or all zeros, -EOPNOTSUPP if
+ * non-zero data is present, or a negative error code on failure.
+ */
+static inline int ib_is_udata_in_empty(struct ib_udata *udata)
+{
+	if (!udata || udata->inlen == 0)
+		return 0;
+	return _ib_copy_validate_udata_in(udata, NULL, 0, 0);
+}
+
 /**
  * ib_respond_udata - Copy a driver data response to userspace
  * @_udata: The system calls ib_udata struct
-- 
2.43.0


