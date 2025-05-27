Return-Path: <linux-rdma+bounces-10755-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57FEAC524A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 17:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CEBC167EBB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 15:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF28E248880;
	Tue, 27 May 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Jxwk2NtC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2092.outbound.protection.outlook.com [40.107.220.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA8139579
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360782; cv=fail; b=tAtpPrs3UT9wLCVeSMif7PtXX6xUqTuM2zqr2Vr9IhayP2WcWp4lex1Pn1lYx55Kwxf5XsKrO3o+y9wEVwDnmduqeaboaVCxL1ol4S7DzF5RDOPlvoYEkmKWfJPYMyRFuW9o3p6YQe6DjNW1ed9ftS71TIV/EHrFIhzXtQs7Bjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360782; c=relaxed/simple;
	bh=YlfuGjOB1KJGO7D9dKWokz5N5MC5IpEg2AGYF5p9VlM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9uRqUydfsI+p7ywypvfBXsFJo5lr9J5nGNFEPhg9XhEvFdSVIuFZ/pccWjoKCsC7nOJAlsFMS1vaHioXcQBLYVQKJlPP1HAdAu5z9GlNzd/vquIjK+npGcxg5aSE1I7samYTbn5OIfAwJv0gLXh5h7debJjeuCzPNPEEfaBXl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Jxwk2NtC; arc=fail smtp.client-ip=40.107.220.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwRzR+USuaiARPcFu1tD901wtHu6c+sJ3vkLRNikG6389WePKaAlfoHd62En/D8RtqVjQxAl2xB0Ff6RU2DWPl+CKIGjwTLEv9NAFxhSojQXQ5Qx9psrPJy/UOFm7tApMdxGMYn7nmoHRkll1hWgBJvDYWKGRXZxHCzuXVMuBPgGRuM/oCRfbBxUwetXzWwKmH0hvRV3sUtzcAIJ/TaqDpdijNDfp4p1L0nKLrhKX2gH8KGcy0qLR+qCyaHwN4E1JV5/cIpi2HijcZrqRfdODOe4NT6vc2TEWb0GvdFoT2iQPn9eu9bkXhVz8f0NLxUAbwKmiIVFdyaYnXg5HyiLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/cMdqVVBqnm8DjeghdMJ0Ojy0ZUUI10/x/9Yy20Seo=;
 b=tLznvTj1FSORHfe7hdrQpjPRAMGMqg5v06XOsMbbswTrRS7cKHL6dX6v2o6u/2cubFj/DHnM2pR5rpHPerF1R+lC6QAaIkCCa6F6a7CYr/8XfEF758wJYrYNjJcLmdS5tNS9kL4QJrTUtuC2+BY+jxY/jKYxR64P83f0rO8t768i2cI+McMHxUG22Ak22ApL9hVHKBsM/51E3/OH46yk6gxXiawcn0EWTcEbj7uNKl/1F3iksa8qeS0kJPLAMoPn9JZqYvvGZ821j6ydHRxTHjxeH9mJPmdcRkikY8zmGLselZ7IO9EcANucjePjWV2MbFiIeXbhhgU0mGqA04X6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/cMdqVVBqnm8DjeghdMJ0Ojy0ZUUI10/x/9Yy20Seo=;
 b=Jxwk2NtCmtRCeh0AYSYbpObQ0AnnyDhQ20OQxB7SQA7XrOSYIk8uLdwbnr1sMsI0iYDlj3+sgAsN9Zi0Rr90gv1HchpcSLXnygCCYj0gbC+IwjycrIUk4acxkYLVnyBdvM+dyVt6zza199mXJlBBzteNoiio4mIa9rcHZDBLjHlgelHOgvhI42gbrQMebp35up0DNoSt+w8oD0zkajcTxmcEX1LGcafMZdNKoxX86bm7lUWIWzbO6W1xXsfKmkW22LqMC30/2EV7/Wmm2XJv4h9bOzUmRvSJZAt5ARdyyr8NaBIuOWGfRJB3G3JZutrduSqjVA1bQwbdxgLl2bE/5w==
Received: from CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::23)
 by BL3PR01MB6818.prod.exchangelabs.com (2603:10b6:208:33d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Tue, 27 May 2025 15:46:13 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::ce) by CH0P223CA0025.outlook.office365.com
 (2603:10b6:610:116::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Tue,
 27 May 2025 15:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Tue, 27 May 2025 15:46:13 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id D534A14D722;
	Tue, 27 May 2025 11:46:12 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id D22501810D63E;
	Tue, 27 May 2025 11:46:12 -0400 (EDT)
Subject: [PATCH for-next 2/2] Maintainers: Remove QIB
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Tue, 27 May 2025 11:46:12 -0400
Message-ID:
 <174836077280.2436819.8306178407677103841.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
References:
 <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|BL3PR01MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: ec33fa88-be0e-4e2f-bcf3-08dd9d359c22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFFzY0xSQjhTSUE4QjBGZWpiWnlsLzl1VmJLOVBxUEhLVUFBd0ZyM3k5QWVP?=
 =?utf-8?B?SW5YanhNV1FIQXJtUW9oUjZiQjNGN1VpQm5ocjNjREtaT3ZMemhnY2g5NXBX?=
 =?utf-8?B?N2lVN1FXL0h3RlNPQU1VazBSL09xY1JhcW9vNU9maE9KWk9CUEFhTTdYQ3kz?=
 =?utf-8?B?WitmZUUzZTZLanJ4bnc5Q2VQV3lRUXcvejlqTXZPaWh0NmMrdmNtaEp4ZklB?=
 =?utf-8?B?NWRSYXg0UEVLdnZuMXhVMnZ1azlVVGN5dS9ObVE0aUgrZE5PN0NxTGtyMXB6?=
 =?utf-8?B?aU9ycDJHbFhHYnBrdkZXTjRXUlk5eXlIaEdlTnFZa0V1RldFZHIzNnFLaUZX?=
 =?utf-8?B?NitnanE3OFBrMHdiUGZpVjhjVEFaVWMyODh6SHJYbjd3MWNEa3dHdFJ6ZkRU?=
 =?utf-8?B?c2pybC9oNDdZNTllQkdFK3Z2bVl0VittM2J0Y282UDllUUtOc2laamQ0L3lh?=
 =?utf-8?B?aWJrN3k4UFEzRTBDK1B6YTRnV2lOeFVEU3NUOVAwT3pNa3VYUEpJektUR2VD?=
 =?utf-8?B?RkpyV1hGNnpRcmt2dDB4M2ljNTU3V3R4SGc0aDBpU2lCL0hXOThSMVdrd3ds?=
 =?utf-8?B?MHJvczhNRzM3UU1rWGFwQ1NkSWg5Wjc4V1czUFMyQ0NGSitQdmJlZU1mamRP?=
 =?utf-8?B?OWZBUWNlQjU0VDR6ZkUyek5QdHFFSVIwWUFmaTBlVEEvckVQZkZOWDdHV1N6?=
 =?utf-8?B?RGExLzZZTUZCWW9ocjlIY2ZqU1FEeXpiL3FXaDh5V1NabkorcEk1c1ZsSWNl?=
 =?utf-8?B?eXRhRGEvRGIyQ1BNNkRXQVZCYTc5MzVNRUtodDNkajlSTnlLMDcvN3VEd1dn?=
 =?utf-8?B?NXM0TjZvc0FXWUFzT1d1VTRCSnIrb2NnVGpOdlAvUzR3aHBRRzdESHVkcXA0?=
 =?utf-8?B?My9BSnQ2YlovNjB5c1UxV05oS2YxdVM1VVdYaWFhdEx3NEU0bGY5SGZwRzlX?=
 =?utf-8?B?WDdYaE9VQzFKeXo4K053d3N3TlN4VWVyOVB1TFZ5SkxaaXJTSFJIbnh3TzNy?=
 =?utf-8?B?dEV1aHA5QjBkeUQzYjVnZVJUKzNiZmpiRE5mcUxsNXkxWFhNSEtNN1hmdEd4?=
 =?utf-8?B?UmNzQllsVWJodWRYSzY1ZTVXejY2TGwwVEZaekREUktFY0F2UkllTjZHaXVP?=
 =?utf-8?B?aUJIbjJDYW16ZlhIdjRyOUM1c1FMTFFIQWVUWm9KSm9wYXZLQ1l4K3MrUDdR?=
 =?utf-8?B?M1hrdUpEQXhIZS8ybnBxcFRJTFRzSWNYbUlWNGRHaXdzL3NBZTF0bzNFK3Ni?=
 =?utf-8?B?M01lVjdGTktTMCtpSG9wQ0V1a2tRRU1TUDVBUEZCZ2FaejdCUnNaVXpGRFhT?=
 =?utf-8?B?em4yRkxsdVY0aFVUWWNselRaQjhSNEE2V2IvZVhJS0ZqaHNwa0VtZG1PUjdh?=
 =?utf-8?B?MG90WTJKM0txWmpLVk91Q0dqajZmRnFsZmFkY21MY1NWT3RCdi9uOUFVbEJZ?=
 =?utf-8?B?WjZCejhBTzRUTTZKdmsvQWZKMkM2UmJQbHJ5MExEbHJhNHltNmtRMkhZQWt3?=
 =?utf-8?B?R0F2R3RBOEZmWEx6TXpEQ0toTnR4WmZUTFZJbms1dndqSllKdEcwZTYrSmVN?=
 =?utf-8?B?NFpsNEptQkEwYnZsRDNMNWw5WmNsa25GTUhIc0tGdTVpMDh4UzdpYkJ3eWpu?=
 =?utf-8?B?cm5sZU1Gc1F6bkpTQXQvek9DNXdxbkFQOVVYQWgzZ1hnbTZxbndNK0x2T1Z1?=
 =?utf-8?B?emdPSksvRU5Yd1FCQnp6WXZNWlBkam9KYjlnRi94Wm4zY1BOV3BRbnJVZUFS?=
 =?utf-8?B?SE5QdTZSWEdmZjNXbytnLytHTkRhS3IzWHpmZk5NSCtpS3pxWXpuVXgvODJB?=
 =?utf-8?B?WlFKdlEvenprRlJRL2NWdmEyVHFwVzdBMTN5UDd5SkREWW5HTVh2bjZMdHM2?=
 =?utf-8?B?U05IcUJMNmRuWDlLZ2QzT0VaemJuY0VPWkp4MjI3OHlEeWp1QXFVQWxSRGEv?=
 =?utf-8?B?ZWU5TFZQV3R1WnVSYmJ5SGJQYVFSeml4OEM2UThDTGZqY1hHazZ5djNJWEx4?=
 =?utf-8?B?eEg3MUd0L09JMG9aVk8wM3lpSG5Fanp2RWE4L2NSUjlob2NGMkQybTZycjMy?=
 =?utf-8?Q?tBuqn/?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:46:13.3823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec33fa88-be0e-4e2f-bcf3-08dd9d359c22
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6818

qib driver has been removed. Take entry out of MAINTAINERS file.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 MAINTAINERS |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 136309587791..5db0b811cb61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19619,12 +19619,6 @@ S:	Maintained
 F:	drivers/firmware/qemu_fw_cfg.c
 F:	include/uapi/linux/qemu_fw_cfg.h
 
-QIB DRIVER
-M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
-L:	linux-rdma@vger.kernel.org
-S:	Supported
-F:	drivers/infiniband/hw/qib/
-
 QLOGIC QL41xxx FCOE DRIVER
 M:	Saurav Kashyap <skashyap@marvell.com>
 M:	Javed Hasan <jhasan@marvell.com>



