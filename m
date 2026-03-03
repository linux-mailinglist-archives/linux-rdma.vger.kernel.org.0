Return-Path: <linux-rdma+bounces-17437-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DzmL4o8p2mofwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17437-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 703FA1F670F
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0B0730BDEB7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CB938655E;
	Tue,  3 Mar 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxqmGZva"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165E5386441
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567428; cv=fail; b=UydJYWLKeqAHKqKKgcNOWQ+YdoUNKMXnfJwZDcbZ0tG+LT1j1hqxgIxkguQalYsd0hZpvRA6quIKgue4AwYlM0ev/jVFYV6htXGrPqS1aa0kxTLJS0M9G1GZVNneS74M7fNjHvylWXL2vSr62J9MjBEPESQbCdmFTSRn5g1mmho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567428; c=relaxed/simple;
	bh=D7sVLgekwwGqCf5bT4+O9OGm0u9mw5z8GCpvf2zlGNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFtLECasrMSTMQkX/tXIiVJ2AmCPQK7hzvia1GV1+fIYfb41zI2ofb3/fj2WROGEwUvq0oApeVWOYA+Q1sou6he0L8rKnGJLDS/usTeJWVxYApAkfeYIXbLFCGDgOuOADuP8t3ydeknXPfMW8+PJIyuUpYZZh6vx4D1iMmpvjQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pxqmGZva; arc=fail smtp.client-ip=52.101.85.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJoFsTMtgdYSmeZI766422U8t7IpYIexsFI2kFur7KF5/h2sXjdOzNzoOJQyfNqcE2X8OkdJOY3Fp5K7/L/7kGA61dakjVsenMGioIseoIZWGOYtg5oTIIFwR9MVv7LF52fiPFMfbdXft/upfMncuhNdz/MUFUVRBblaHUzjZ/e4QHS/ybGxlXFmPiWCoh8FQcnmp+hbHrK8fbykS2OEG6AzfBAwXtUiGg80/Wx31morky4zkbFTfABJQcXaRqJHC1J8b7GGODLv7cU3A0N1qPi1IIw7RgAaV0G8Wit2fcTWTcYVtP6FykqbUtnM0XAwSNFF/VZW89KLmSEmAoJGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hN+f29qWVdXmC8UfiDGCFA3GAWNqOuJFH4CpB56QLU=;
 b=sPkeSIwBq7t2g86Qn+6kL2BC5cA2mhFaTAcIxRr0+JJVFMQ9tk99tBSkddMXsTOR8WBbmL57DWgvkYCp4M3VSXTh2wR+rB3o+Z+nANb6fvws8ZvurdOPtczGzf0sPqfDEYsqXsA4M7cWHBZJf6Dttxc36VMfy3LOB144oFHB4ymchjijtMKHOwP7ApbpqkroSUoA21gBVdXFy6P4OzPd1Sb8ZphEexVCkSCXD/W1nwvWaLL8tilt1ZoY2pP463lmxMDsRyqM4BYO/T+enPcHkhOtgCEb7PFqCTH3IbsvwY7FkpU6yVvrXYEXegsLUlPxUeMWwoU6hXn3viB5p/AcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hN+f29qWVdXmC8UfiDGCFA3GAWNqOuJFH4CpB56QLU=;
 b=pxqmGZvaakG0PQlwlEYXaWIeuWGiZYSH7RGIGZ/9MwlknCNFHqCFmgdSfKgDDSw9jEnIq+8p6wx+5wyMMkeuzz+g6ywSftwhwbisVkKoKbALMNZTLHKd88Y8jbSJBn6VYdeZy9hxq1978pCT9cOrb93tu7kQzsNinYE7exK7vFyr3bzoxg5ChQ9ATTcIYFXPZJdNoGlwVBIEc8JFckB2L1Qycb24pzjQzfSMkuRLIgfakxaYQdmQXgvAqyO6dhJPLnY7UgaFliCdL/gPvWKp/HJNoJ37I6HiPJTWqeAfiWG4ilCRr/tLTn1rteSbQOv+028j9Maaunger74UAOznWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 19:50:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 19:50:18 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH v3 11/13] RDMA/bnxt_re: Use ib_respond_udata()
Date: Tue,  3 Mar 2026 15:50:08 -0400
Message-ID: <11-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v3-bd56dd443069+49-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::6) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ec3f53-c513-4a1f-0cd7-08de795e165b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	MrriooGJ1PLhzR+1pPb/0ltc5SdCS7q3NbV+epl716tQNltHYxxK14eWPfIl8ka6jVzCYjc/aURo6Qtc90AZ/0+Clz7cEdE5amuGzOsMuja4RQ5CwPfccqP5MRcwOf8m7dCXC3ZgkYdxYKK6/FSB08LFU20q3Uy/anQJ8a0K4MUCy0NCeV8+hNqI4oz/v6d5OgMY20VYjm0zrZFiWsGpZeFutv6cUIaUlphqnE7ErzC3ARPw3JoD2hC3ldMXOHHJcad6kmh3QHwc0mA/lysjG3l4lZLGEeK5e0nMLmzeJdcbf36o0tpSwIdl9IYqUzOBPGuKp+miqVEuqg9hAa8Gc6MPQh+KfKVoo+v1P+q51S5kHIqY9RGcqyg5TOR2U6yIN7sIjCLLZplYUumpBFXiTkThyJVwfUifr5A6hW2OOW3mLxon4K/Bjo6caQg4oqiYMmFEGeFHAOZCWtNvW3XCi0/xoUoVHjJxDP6AADWTJxFxE8gKz5bqIIUFNCgZWz/TfJhqn0IcmzFBSQsibSkALTYhVs3wUnHYyLA7B7MOdCOD5zGg/byGSchZ4YRv83KcxbU0b/dIgdbJDi7ResZmfzcTwwTzMLvDvwDcmq43tj32PgQsVSngrMawKXfT/O6sLqYbE3iRyosiL3igD/rzrbcYjziELMktBYb/k/wdfoJlRVNXJeWP18z0lmEo8Mn7IVsdsW4EcIKoa97CZaxPUcOOv3xpGfvNWHtM8F7DBC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1HeIWHfz8jBovi7sfKlB0G6haSGnQIJ6lUWPXuxMhG5V4nViJeQbyd8bVfwS?=
 =?us-ascii?Q?zU+Bj1gvr0JlirrtQ+SgXeDVekJTfqa295EVkw/gu3ZwDuWWm7VSqFsrswQ+?=
 =?us-ascii?Q?ML9WkOs6LDx5cd5Y28e7EUJkSAxoTfoBGT7gwmi0BvgRkh80wq4iaUVeTXVN?=
 =?us-ascii?Q?+pzLUnaZsy0hFsllTPcSFICdtEMP3B/ieVW3IpbFWzMyVxM6K8l257S+B+T9?=
 =?us-ascii?Q?PKOmSc78d8KCHmmjfXty2nVu1Shj9wLRPFWR4jyjuQ+RsrNS3aMr3k6Q2zix?=
 =?us-ascii?Q?OfvxXP3P5T4SAyGNB8+hAI/5XzdGV2BoExcTa+O7WyKVMKkCUDKq43GTydjo?=
 =?us-ascii?Q?BTsboD9lPQqyCn3nSvqsOG5KyVQoAT5cUHCiwHhigI4gc1nDqo6JEz60bHRH?=
 =?us-ascii?Q?sbC60lOgvBFC9y74wMnCIQbmhb7Y5G9gHk4OqS0kuvqUbbx8S9VPZgiz50+c?=
 =?us-ascii?Q?W6HgpDNvlGu9jwwSPSyqBHE/nlDVGsCm+CC11q0RgZtP3f+IN9k8rUKAi4jt?=
 =?us-ascii?Q?8Bp1M50iIaFUd7CPqDPMYMelrO9pLC/Z8l19RoM2oY2tyAj1uepV7oz7OepL?=
 =?us-ascii?Q?QfbDphaAHIo4I0+GfmucC9C9rEpyF8ZdTbMOLbbaGNS3vGZdM/lTaXWaGGGC?=
 =?us-ascii?Q?d6rewMzs0UYUetUp7dTfrLtiTdse2SctMXiHTfLKtS3Fmwa+PkYb8tDrWv51?=
 =?us-ascii?Q?11l82vEl/p64yExjRuU4KTUIZO8nCuGQKYR/jGPvxbxaYR6ReIBoKTr7Rfhh?=
 =?us-ascii?Q?B3mE7vWcp/eUEhGJLVVFiAwvnjcUC+36tAyAJnnl3SktOKCRE0RpmM9A/q00?=
 =?us-ascii?Q?2oQlohU6I+u5o3NXcrpZEuYK58cIr3KedC4gLViCF5exI9wu5NwK8PICOkde?=
 =?us-ascii?Q?2PFpQH2bnGVPtqltMMOQupdVyQrtCpv2z+YQELjfwqsY64DQmM0Z8TlRSJvJ?=
 =?us-ascii?Q?3jJhpOPHJCbFCsqko+gVqwi4jdrzjpB8nyyPrCIvJRjnOK+oAkjvN4xfl2pl?=
 =?us-ascii?Q?a4yL/cEd+IkNYZtoBv/YdAWuP25dIB5/2NTggUQG9PltYS2gbG5uaDwkYF9e?=
 =?us-ascii?Q?RjyysdK3UjIVuxwQ7OF9yIRfaGdY8HcY8yE+p+LOPvOsBPh4zJM5MHMiXpQh?=
 =?us-ascii?Q?SV1jkPMxYkK3xLOtH4c9eeCE54POl7Di1CoJAcG4c8mceUanT2DRc7cCoJpr?=
 =?us-ascii?Q?Rj53RaCtDmkE/ofFee2QfeamWV/GpikeJ6Umg9qjNOh4DXzTMfNXBaWm+xsd?=
 =?us-ascii?Q?lr0WvOSKEM40+bADxQ58Yv2x1Y1Wcqm1TS9L5SgkJ32CLa9pkn3OE9cvuBit?=
 =?us-ascii?Q?VJN9/Q+VQRlMV2Pl1U3TYHETlghZ9JhKTDdQl+CyU6KOSk5VSHn/qhfMKwnn?=
 =?us-ascii?Q?NKFIF7iVDNbk3jDwj0Dj5o/tFJOzqavlQaf9Bf3VaaZur2fPidNo6iGrQxfw?=
 =?us-ascii?Q?BP/GjQ7E2LCOAWQZYDxNzSDmsKBk1cZKYiMfgAArFn3CJBKvlF/EM+hKhVEn?=
 =?us-ascii?Q?kg4f507E3LuGGsRdPsXHIinhvcqJkFhTPHoK4a68Y47Q84uRnT851GoADilY?=
 =?us-ascii?Q?s9kuVln5FWiH9f/AlQ4ZWQqYLocs9yGXiw/sDV7hXOhT0BK4VpPaikkZmFES?=
 =?us-ascii?Q?0SxBJt6DP8NTaid7WUyyxq2mNe8YKu/dpiWqoZ3spVuKkPg+bsnACi/tQiHr?=
 =?us-ascii?Q?kU20DTH49Lpllah5U4+F4uPqPkizvDE9lx/Jj1J6J+Ogd9miHEpUJyShNs7f?=
 =?us-ascii?Q?SQ+ZHFeU7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ec3f53-c513-4a1f-0cd7-08de795e165b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 19:50:14.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztvA+qE6xhBcvEp1a0KgEoJMv/gFnMUsupmcCnd2qGAUgJI9QLMzykVtRkemOHXJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Rspamd-Queue-Id: 703FA1F670F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17437-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,broadcom.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

All the calls to ib_copy_to_udata() can use this helper safely.

Tested-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Acked-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 31 +++++++-----------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 412b99658d9073..663f452946c782 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -187,7 +187,6 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibdev, ibdev);
 	struct bnxt_qplib_dev_attr *dev_attr = rdev->dev_attr;
 	struct bnxt_re_query_device_ex_resp resp = {};
-	size_t outlen = (udata) ? udata->outlen : 0;
 	int rc = 0;
 
 	rc = ib_is_udata_in_empty(udata);
@@ -258,8 +257,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 	ib_attr->max_pkeys = 1;
 	ib_attr->local_ca_ack_delay = BNXT_RE_DEFAULT_ACK_DELAY;
 
-	if ((offsetofend(typeof(resp), packet_pacing_caps) <= outlen) &&
-	    _is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2)) {
+	if (_is_modify_qp_rate_limit_supported(dev_attr->dev_cap_flags2)) {
 		resp.packet_pacing_caps.qp_rate_limit_min =
 			dev_attr->rate_limit_min;
 		resp.packet_pacing_caps.qp_rate_limit_max =
@@ -267,11 +265,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
 		resp.packet_pacing_caps.supported_qpts =
 			1 << IB_QPT_RC;
 	}
-	if (outlen)
-		rc = ib_copy_to_udata(udata, &resp,
-				      min(sizeof(resp), outlen));
-
-	return rc;
+	return ib_respond_udata(udata, resp);
 }
 
 int bnxt_re_modify_device(struct ib_device *ibdev,
@@ -769,7 +763,7 @@ int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 		pd->pd_db_mmap = &entry->rdma_entry;
 
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
 			rdma_user_mmap_entry_remove(pd->pd_db_mmap);
 			rc = -EFAULT;
@@ -1727,11 +1721,9 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 
 			resp.qpid = qp->qplib_qp.id;
 			resp.rsvd = 0;
-			rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
-			if (rc) {
-				ibdev_err(&rdev->ibdev, "Failed to copy QP udata");
+			rc = ib_respond_udata(udata, resp);
+			if (rc)
 				goto qp_destroy;
-			}
 		}
 	}
 
@@ -1990,9 +1982,8 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
 			}
 			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
 		}
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
-			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
 			bnxt_qplib_destroy_srq(&rdev->qplib_res,
 					       &srq->qplib_srq);
 			goto fail;
@@ -3281,9 +3272,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 		resp.tail = cq->qplib_cq.hwq.cons;
 		resp.phase = cq->qplib_cq.period;
 		resp.rsvd = 0;
-		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
+		rc = ib_respond_udata(udata, resp);
 		if (rc) {
-			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
 			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 			goto free_mem;
 		}
@@ -4489,12 +4479,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 		}
 	}
 
-	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
-	if (rc) {
-		ibdev_err(ibdev, "Failed to copy user context");
-		rc = -EFAULT;
+	rc = ib_respond_udata(udata, resp);
+	if (rc)
 		goto cfail;
-	}
 
 	return 0;
 cfail:
-- 
2.43.0


