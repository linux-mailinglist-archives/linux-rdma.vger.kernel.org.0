Return-Path: <linux-rdma+bounces-13514-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE1B89638
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 14:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3D81BC2449
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Sep 2025 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BE930E0DC;
	Fri, 19 Sep 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yVGbyG6x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2A30F7E6;
	Fri, 19 Sep 2025 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284000; cv=fail; b=awm9e0xL2Iw8T6B9rYBJGW+AN5ftlOD6Qx6OavW+Dj2fAUuSxCG3JUfjnVbEGglsseCH8pkJrHDLOiuLbpKVR0XDHQiHJii3B4ksLJP+X/XP+NrmI18jhZNKbvDKDVCuy6Ybg/kBtdCNJjeWYrz4BcLNqatcZFR5hQ1RZW3JG5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284000; c=relaxed/simple;
	bh=iRjz1K/PgH/x2Wk73N4sx+2Qix5UxQtXM4LIsXvldVk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlGhkrtCc/+soV1fGzsfiYEcse+dENTHWdFeyqYWuTX0Gr2qQ5tz3lXiR+FZ5+CmgcdRnwhEv1a2B81Dhm/2CGDbH/pgpoSge3HaW9uz2GUYQr3t4F0Wp9pWTGCYojCimp7uaX7fWoDdBquS6GV13dwzfnYVerdZkUzm2eYy1hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yVGbyG6x; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCIv1VNOywrtoiJclmT26d26H5Wo7AqO9mejwypfziq1JYAkp7aXq2Nboknz5YEdcAuJZiLOj4pz3wOZP5SBvPwxl3U6Zl0VUwWVRlihodP1KUYeBBKZ0qnK9IGgU6046P72NFhAJ4FBYIuJCJhkJx8XvLJX936blK2cIsakn4uRvGjnz63LnrE6cwqp+MloPlYSrVz/srNWyncfvJinSoTp/Nvt6pWb4UTUGfZy04umiz1GE4etbxleakzce0wNyw758ikgYfJU6kC6MGxPhP0IgCcZCR8LCNch6PdK5eBiEwf3rNNNZTWsMT0C505aeUpF0AgSdxYqXachMnohMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMm4eIFIYT8xglXUee56HfyohNnGeqj+eEvJU4+m3cI=;
 b=F47zmuOT9DLEFPlZRe0a7QgCvMzdzAhtxFoCe5xRmZIr4qhRu/CO32n1g3HgdPevdwAauFYufS+Fe8mqawL7XsR++E2lbIPRYygoPAa+epsa6wvo5ijSqvmFvkFBMcPN3xOHTZS9EbVs5d5UApjT/Q8qKg8EhEpXGa2AFjnlV6mrOdVYUQPhYEwaQec3NrYZl7hiL9t6sDtSfeF6L5OtQ2itqoES6B2pCoSGjOMr7CkLPFX43m8H23B3Fz9R1AoQQantV43cv+BI3knmmrA/PFMrUHKD/uI0D0bFSjbr/FhJU68g7IwEQbYNwMWFPs+UagQR1RZk7yTusljQaYCBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMm4eIFIYT8xglXUee56HfyohNnGeqj+eEvJU4+m3cI=;
 b=yVGbyG6xJWViPuXSjoTMAe/G8utFBmkk1CJZuaW4FHxfj9HmCf/eZKspJ7/hGvSh+ZENraGEZitLhe+N/F35DPp5Lsyum3zwNoDzFqMGpuVFs6C5yiehZNYfKzZHiZPahzc+ElEcj95U3cr0kqI3GCMELW/hYYABjJCC7sxYAqk=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 12:13:14 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::74) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Fri,
 19 Sep 2025 12:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 12:13:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 05:13:13 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 05:13:12 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 19 Sep 2025 05:13:10 -0700
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <allen.hubbe@amd.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Abhijit Gangurde <abhijit.gangurde@amd.com>
Subject: [PATCH rdma-next 2/2] RDMA/ionic: Use ether_addr_copy instead of memcpy
Date: Fri, 19 Sep 2025 17:43:01 +0530
Message-ID: <20250919121301.1113759-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919121301.1113759-1-abhijit.gangurde@amd.com>
References: <20250919121301.1113759-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 41309d46-bac4-45ac-83e7-08ddf775e87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3cvbi9BZm5yZDJpUG5nQTRHVmljcEM5eWVVUEhJSHpWVUZzcDZReFk4ZjB0?=
 =?utf-8?B?dGtqSWxtRERNb0hPVDNGdWdmbmxSSjE3OEh5L01MejVBMGE0MFJzRDkxWTg2?=
 =?utf-8?B?S2FYdEZsVGxZZkQ1NmpzQjBSWUp1TTNJYitiaDlzT0dCK0VTOE1PNWU0VXhZ?=
 =?utf-8?B?RmZtZm5ZaklscWlleEpRcEZxdUVlTkdQQjJsNUlFUkxQT0M4aU5jN1AxZWlB?=
 =?utf-8?B?LzNKUm9uZ3B2L1Q4aVFTZjFULzRyL040RGZ4ekxnclZDY3E2ZUZXME9JbHVD?=
 =?utf-8?B?ZGY1d0dLWlZDZk80SW9paUdvV1JWZTVkN0tjT245TTk0Lyt6OE9LUlhCVDF2?=
 =?utf-8?B?TXhxSzN0SFVTTUxETTYyNEYvVWcyVUN1N3JWTFBpRzU1YjQ3Z0dWRmdlVmsy?=
 =?utf-8?B?aUZLYjBXNVd4UGpoem56eitqanNrNU1ibEViNHNIR2tUVUZJclZWWGZSWmZR?=
 =?utf-8?B?OHVLWUl2N3pXWXY3cFBiT1pOeWM4SWxadG8vSUNMRE05WnlpMG01SEcrRXBD?=
 =?utf-8?B?L09RVWpWejI2QXdteHZlenFiV2FIUXlUTFl1by9ma1ZLRG5la1lSdkxjMkVo?=
 =?utf-8?B?OVV3WTlqVnJpR1JMNm9UMmVxdWlHYm8yRVFlZjJIQk11SGxJNDhtNkV5TmN1?=
 =?utf-8?B?Um9CNHYvVFlhUVRPTWdRUUxyRnBFaTFjOXA5S09DNGQvQ2tMaGlNUld0VGdR?=
 =?utf-8?B?ZTJFcURXTmthcUJKamtZVlV5eXlaMFM4Vjd0bzNZUWl6NUp3Wmg1VDQvUGpR?=
 =?utf-8?B?dFBRdkIrMjhqemZqeWhqSmR3RENZaVJJazhBditUM2ZPZHIxWnViMWlnQldH?=
 =?utf-8?B?VjVjUXJESi84T3lTZnFMdGlhODFwNlNjbVFDUG9SS09xYWQ2bCtQamtNY253?=
 =?utf-8?B?eWJJZDVPclQwQ1BrcG1KL0FyS1Y2QlRJM3ltTDMvd3h6QTIzRXBhQ013KzVY?=
 =?utf-8?B?WUIyNnZsRkluQ2hkZ0VQUmkycGxmNW9ZM3YwMUE4cmVJU1JMVHRkMGRMMmtq?=
 =?utf-8?B?eFZIcjR5VG9yeWsxSHVSSWJnL05WODl2d0sweHVxaUw5cHlwclNYaHBLb0FX?=
 =?utf-8?B?bS8xOUVVZjdGNjV0U1oxZWRFS0prNGJxNGtlSG1tSXluSUZPU0R2MjFIcnhm?=
 =?utf-8?B?bWxob2hlc2tEY0xLM2JjK3pZaVF1K1ZKQks2bXhKZGFiS1g0M0F2RUJ4VHpO?=
 =?utf-8?B?YTNOb0EzdkhabVQ4bVgvbzBVS2R5akdnaTZHSjlPdm9YNnVGSlNCYTQ3Y01z?=
 =?utf-8?B?WkE0dVFkR2YrSTRwV1hUVnhjWXZlWFpJYVA1Wm12Nk5OSVFxMng5Vm54bjNE?=
 =?utf-8?B?amFNMEYvbXB1VXYrS21tODRzUDhGczFQUmo4QjdZelMwZVpqTko0VW9XTHll?=
 =?utf-8?B?bnQ4MjhnSXhkeDlleERLeXZZWUQ3MG1pazFHVDV0SGV1QklNRUJmdk1iYjdY?=
 =?utf-8?B?UVNobmJmWHNUMHZ6VVlaK3pkV3ZBVDMzc0V0K0RReHpDZGdMaHNrMDBxWXZF?=
 =?utf-8?B?NkViSWVWZFVJSXB5MG9JbmhXbWFHQkxyOVFXcUJsVkk2MXRHSDliMHpUdzlu?=
 =?utf-8?B?MHVmL3hPdGw0eFppUmc5NHFBUUlpK20yTUNKZU1FeFJiek9RK0FSWVowSjVZ?=
 =?utf-8?B?dzRFWk83aThkYjR2cFVPQTd1a1JFMVpqMEI5aEZqTW1BTVZrQUJ1ZzJBdkNJ?=
 =?utf-8?B?Ukw3NkYxN21zbzNGYXdEZ3o1MVZTMFFQT3RMRVRMdmNvNWhlQ0RQdklnSW5N?=
 =?utf-8?B?aWpGR1pmQ1U2UUM3ekNXRjNxbStZNFhuU09pbTgrOTlQYzZTamtiRFN2akYx?=
 =?utf-8?B?VlFZTXVQcjVpVHNCUXN3SVF1QzNPRVN6R00wdnhoQjNkTWNrelNwRnVLTXMw?=
 =?utf-8?B?TWR4S0hkdlVQT1dwZWF6RGhtU2RLQTNYeFJBNU9LUmpkc013cFVpT2FVTnlP?=
 =?utf-8?B?MDErR2o5eGtLWjNVZHkyVHZIVjdYYXlEV0Q0MXB1Zm15WDdSZ2dsSVlZdG1h?=
 =?utf-8?B?YVN6R3NGVnVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 12:13:13.8771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41309d46-bac4-45ac-83e7-08ddf775e87c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

eth header from ib_ud_header structure packs the mac
into 4B high and 2B low parts. But when 4B high is used
in memcpy, it sees it as overflow. However, this is safe
due to the 4B high and 2B low arrangement in the structure.
To avoid the memcpy warning, use ether_addr_copy to copy
the mac address.

In function ‘fortify_memcpy_chk’,
    inlined from ‘ionic_set_ah_attr.isra’ at drivers/infiniband/hw/ionic/ionic_controlpath.c:609:3:
./include/linux/fortify-string.h:580:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
  580 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:287: drivers/infiniband/hw/ionic/ionic_controlpath.o] Error 1
make[5]: *** [scripts/Makefile.build:556: drivers/infiniband/hw/ionic] Error 2
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:556: drivers/infiniband/hw] Error 2
make[3]: *** [scripts/Makefile.build:556: drivers/infiniband] Error 2
make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
make[1]: *** [/tmp/tmp53nb1nwr/Makefile:2011: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Fixes: e8521822c733 ("RDMA/ionic: Register device ops for control path")
Reported-by: Leon Romanovsky <leon@kernel.org>
Closes: https://lore.kernel.org/lkml/20250918180750.GA135135@unreal/
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 9ce7c2e6d7a8..ea12d9b8e125 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -606,7 +606,7 @@ static void ionic_set_ah_attr(struct ionic_ibdev *dev,
 	memset(ah_attr, 0, sizeof(*ah_attr));
 	ah_attr->type = RDMA_AH_ATTR_TYPE_ROCE;
 	if (hdr->eth_present)
-		memcpy(&ah_attr->roce.dmac, &hdr->eth.dmac_h, ETH_ALEN);
+		ether_addr_copy(ah_attr->roce.dmac, hdr->eth.dmac_h);
 	rdma_ah_set_sl(ah_attr, vlan >> VLAN_PRIO_SHIFT);
 	rdma_ah_set_port_num(ah_attr, 1);
 	rdma_ah_set_grh(ah_attr, NULL, flow_label, sgid_index, ttl, tos);
-- 
2.43.0


