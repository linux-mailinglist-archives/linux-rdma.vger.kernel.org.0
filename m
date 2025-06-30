Return-Path: <linux-rdma+bounces-11768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1DAEE630
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0253A6DB9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755F1292B44;
	Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="VLGEG1un"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2133.outbound.protection.outlook.com [40.107.243.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE1299957
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306295; cv=fail; b=tPkh2YeebhhcePq7TY/M8l2P9HJYg+q7OB5zNjvWvwsIIe+zBl34/ncHtyks1LKc4HVMDONOUepflRKpxz0nzs4Kch2uv6SqUCQGKM9F8aneYI+8NyDAyjUUvriTqkxs/uJMfUhsSE4DJRAOqdg3V7jHfwhVU4rvxlnMX8t0h1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306295; c=relaxed/simple;
	bh=wvyaxoJVPp2qNnlfjcrXhtko/VKSn92Y8Zuo2KtPLVw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1nwsnKYLkn+QCtnrW1ii6Md2rcJkRI4sv1qhNm09dngg7UoVnhSHgLZjKSgSQizrMLhfQmIlIk0JDT6rE93mOyZMLSQgwlzStdXeO4OqAJWGrvU2JH/o0spE7jpdD6K9ZJGSrVE4HNVZWAaGGl6Q3urGw7rA5XdHfTymmS7WrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=VLGEG1un; arc=fail smtp.client-ip=40.107.243.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUjqTjrV532mDVh3rbCEizQzhqE8YyhkocG0BVwHd6ywZU2nRg87xGU1QoZ7pUvBCfmO/ZIsfy/3vFavwJ3HXmq0EmaqGMRgyUghsjJP+7kBBFqJjxR3IZN8LssiiiyMJih/aAgNqH5MEHwgHWzkDjmMGMwCr4s/TlsV4fJd2Z4bvcM+oxBp9mlzkBchxMvDS5EjZbAgNFgQ/o7gx3+BbnRQl6Fdq+dWJPiEBZAoWmrxxm82+CowobYzHTOHLs4g5Wt1AseoSTBN0bQ/HFOcXsER1kq3MmF93xF1RX2Nuw6eVAY/N4A5XdDCqbcM8Z/ilnpttdLPfo5W0NAsy+hyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmmXrvjnRFWlfrGM5+Gjh/rqqMouk9c1GJGLuQY2tWY=;
 b=qqLgYk7V1Umyfd3PIYneM08UV9+7PLdZt73D1+EKDAAY75JP5aDOVnxNdEifUX49bjbttpwXL8IVNsNMxwP+7k+0ytQP1/ItXCdtFpN8LVULf7KyGK5kL2vlaOJRmLszgEUb91dzr6y9sqzFDYMcJHJi3mVmwuPOiPeANF+CP048LlgphEXvLs9P/yhTfX+ZLafaWTr11ZOXrGvST7HIEHECbzufrwQGRbD7z35KmvAk0D0WcPpGta5dqibZZqwa3nKqG6T3W4ml0h2SLf4PB1JtzheyOnC6xfTyRfVBR+XdN+fs9gflFJj9fPo+IStVfqq3ESKfZR63yqqIkR3OnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmmXrvjnRFWlfrGM5+Gjh/rqqMouk9c1GJGLuQY2tWY=;
 b=VLGEG1untdYJ3QewVeSQwczeWJvbbyO9mClZknH9uANXllIhhHCYKdroQD0DyLLa3qWnUN4pV5+S1FwJXKOXv1KAzbZtiQByrnTwSqgbR6MIKlIETIin/J2InZTOvYv/xyIC0GSTSi9NXTrabVZnXSZ3TA8cqDvGA3ZDioFTQ2MoI63QOslGKBhtzTvaAoiJdCReRvAyhHXfOctNtjQspAXcsUtZd1y9mqxeJWwLB88Ug7QTWOU1Ewu0TQbB3zUtXEsjYg+6fPShGXct34l4jJh/XGzOmrPrHzKw+gqZg14Xo/bYyawTfE+G8l6T7mkeG76i+dey+D3r9PPDnOU1dg==
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by BY1PR01MB9090.prod.exchangelabs.com (2603:10b6:a03:5b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.29; Mon, 30 Jun 2025 17:58:10 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:e5:cafe::8f) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 17:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:10 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id D809714D72B;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 9BBF41811AA4A;
	Mon, 30 Jun 2025 11:29:52 -0400 (EDT)
Subject: [PATCH for-next 01/23] RDMA/OPA: Update OPA link speed list
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:29:52 -0400
Message-ID:
 <175129739240.1859400.12244684198572711947.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|BY1PR01MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa30d0c-efb9-4e72-60bc-08ddb7ffacfd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUpYWWFqcmlyYTZPK2YxQ091L1dkUG9QN0RuaS9iNlR5OEJLdVU1T29Yd2Y3?=
 =?utf-8?B?ZlRiSHhVVU0rcUtNbjBWOE5QMXBHb3kxaXp4bTdqQ0c3bXhhcFZUZWlmWHFi?=
 =?utf-8?B?SWVBMXM1emFiM1U0d3ZGSDBCUUJhRTJzeFhpYTBuUGRtbm8vOWUyaVJydTdU?=
 =?utf-8?B?WW5Ra2ZWRHU2aUtlemkrRlVMeUlwbm9UbmRTcmxwTjJnVTUwZGJuNDZzaUpQ?=
 =?utf-8?B?ZzlISnJycUtSWTNFS01iaSs3Q203KzNDelVKcVhpUVpzK3ljWmFMWWR6bzla?=
 =?utf-8?B?WStsWitya1NTWjVscXptSmdvdnh0TEdYdFdlY3BrZXRiN3krYW55akdJa21v?=
 =?utf-8?B?Q25mcnBhME9UcWVRZnNZWUFvOGJzOENCTnJCWDBTTmkrRnRHZ2VTVnNlTGN2?=
 =?utf-8?B?WEhvTlpCQUV2VXM1OHYreTBvRkNDbFB4VHVmQmdmamV1blVHeFluTkZnWmV2?=
 =?utf-8?B?VjYwcko4Vy83QnF1dkF2ZGthT2I2d0ovckxKNG1TakR5ZzNoOEhoQ1ZENXk3?=
 =?utf-8?B?bkRrTjNWRkJodWRpOHdyKy9MTWJIVEhIRG1sMXNlSThiaGRaT3RDcHZaVkhN?=
 =?utf-8?B?ZlZnQlRLbVBKR2MxN0E4N3o2enVoQXBHaklTTkhGUHZjalhGTTY2TVFhai9n?=
 =?utf-8?B?Zlc5a3lhcjJ1VTVnZXZYL3FLT3haVWgyY3oxQnNKTExzNTkvYld4SGR1Vk9p?=
 =?utf-8?B?dHR3U2RlVHI5N2ZKWktEeFVkUDFXZU9KakpxVThNcmg3U0F4VW15Vk8zdWt3?=
 =?utf-8?B?RDRSV29UVTlXMVkzc0lXYnhzOFZvaTlDeDBWbmxtZlIrZjBWR0tOY2Fvak8r?=
 =?utf-8?B?cGFmKzNtdTdxbjZrWUFuMC95VUFFVkFqUEg5NjVZU0k5VDZ2bndBb1JwVWZI?=
 =?utf-8?B?dWtKWkl4eC83NUcvU0ViL1dQSENEczMrbUZBT3BOQjY4eVUvVVRtWDU3TG4v?=
 =?utf-8?B?TjVUa3NuaW1QZ1dMSHc5eWJXb2g0eHdZU2pTaW9qRkVYL29Bd0NWRU1xaGky?=
 =?utf-8?B?TUtjcmdaUEIrNzl1a2hFS3VFMjZHQ3hzNUo1K01OK1lYeDdNL3FGdDBPVktH?=
 =?utf-8?B?MWRpVENUandzT3NMa1NuaHloQVZpMEdiTXRVYldQNHY0a2xVQmVOWDVhdmhx?=
 =?utf-8?B?Z2FjRmJXYkJNVHF0TFk0TXN6U0oxa20wN1NlYzZ3U1RhYnVmUzJ3dFZITlFk?=
 =?utf-8?B?ZnZuV09ZZ1ljL2gvWmk3MHZkanphM0YxbU5oQnowU0ZTQXQvdjJuVFJQTDVP?=
 =?utf-8?B?dmpneitacFdDc1dMK2tmSUtsOTUwdFdqcEdCcXVzcTlBajYvU2FmbVlFY2pP?=
 =?utf-8?B?MHRwWWR4bnprQTc2TkY4M2dwUnJBd2pjUE5LY2RoOHZRZHFQVGlHQzdONUxG?=
 =?utf-8?B?TThiVHJLZEpCSHFJbXdseW11RG5KNWxwdnRWdUxLOWo5RmxGRnNaRENnV2c5?=
 =?utf-8?B?d2haSjQ5aUtzUEZNTEhKMzdWaUl3Y1k1Mkk0Z1VQQXR3eCtkR2JPMTZ2UWxJ?=
 =?utf-8?B?czlia2s1M1FxbVgwRlQzZjJ6WkF5ZVRnVWgrK0JGbngwb3UzaGRxSHlGdGdP?=
 =?utf-8?B?Wm8ralR6MHY0eU1udkpYRnlWYXZnZzE3eHlBdS9xeE50b3M3cEJBcWZJVGxu?=
 =?utf-8?B?YnNEVFd4NWEzMzJaTkdXYVVrdEdqTnkzazV2aDRvUkZvYUJEYUhvSlhOK0c2?=
 =?utf-8?B?M3NNTlVBUHhUQkFMaVNhTnpQTEJzWWI4NnB4cXN2MnY3N2s3TklDYlJDZ0Fk?=
 =?utf-8?B?QkFFYURZdlpMSnhTK25FeHNaaVN6MFpkUURna2xtMCthZnBWNUJpS3dOWFpZ?=
 =?utf-8?B?bEpYWDJZaE8xaEl4QlFXc3hFK1VSeUhtVFpxR2ZFS3I0WnhDS0tqZEk4cmJt?=
 =?utf-8?B?eVJXK0JNMHc3djNjWFNjeDFRNFh0MFBYQU12cTI0dU9kbVMwaENNODVyYVNx?=
 =?utf-8?B?VXUyUXNNdDdGMG5KQXUzckxwZjZJSEZLUXp2M0hGb3VkNUxRMmI0QkJvWnZG?=
 =?utf-8?B?SDBRYXA5bXMxWWZWcWRaaWdmbmtXczZUUnExQWZrWmp3RDRkbXlEcHFVQkYw?=
 =?utf-8?Q?pKSbKa?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:10.2632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa30d0c-efb9-4e72-60bc-08ddb7ffacfd
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB9090

From: Dean Luick <dean.luick@cornelisnetworks.com>

Update the list of available link speeds.  Fix comments.

Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 include/rdma/opa_port_info.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/rdma/opa_port_info.h b/include/rdma/opa_port_info.h
index 73bcac90a048..fb66d3a1dfa9 100644
--- a/include/rdma/opa_port_info.h
+++ b/include/rdma/opa_port_info.h
@@ -93,9 +93,11 @@
 #define OPA_LINKINIT_QUARANTINED                (9 << 4)
 #define OPA_LINKINIT_INSUFIC_CAPABILITY         (10 << 4)
 
-#define OPA_LINK_SPEED_NOP              0x0000  /*  Reserved (1-5 Gbps) */
-#define OPA_LINK_SPEED_12_5G            0x0001  /*  12.5 Gbps */
-#define OPA_LINK_SPEED_25G              0x0002  /*  25.78125?  Gbps (EDR) */
+#define OPA_LINK_SPEED_NOP           0x0000  /* no change */
+#define OPA_LINK_SPEED_12_5G         0x0001  /* 12.5 Gbps */
+#define OPA_LINK_SPEED_25G           0x0002  /* 25.78125 Gbps */
+#define OPA_LINK_SPEED_50G           0x0004  /* 53.125 Gbps */
+#define OPA_LINK_SPEED_100G          0x0008  /* 106.25 Gbps */
 
 #define OPA_LINK_WIDTH_1X            0x0001
 #define OPA_LINK_WIDTH_2X            0x0002



