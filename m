Return-Path: <linux-rdma+bounces-11781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E3CAEE641
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B8D174F5B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E991C2E54B3;
	Mon, 30 Jun 2025 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="dIsplsTS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2138.outbound.protection.outlook.com [40.107.102.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D92E717C
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306304; cv=fail; b=pBdORsjaeTAFF5uvAgd/aRWwv9Uv2w6SiE+TicrJgRpqZtVAdL/7g4WS1zoM5jq8rzkXvbDSk47p9W0+8tRY5hHEWEG03VgeX2lPnnhkmuXCuakocD7gdivbilYogMKRyU2WVx0PfofPirBKU5VQVzQs1yDp3NOMkncrVbOOdtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306304; c=relaxed/simple;
	bh=mRlCwyN8XkkDQupNZkUplTzYODjj7fmo0A09TnyB56g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQpOowz2e1VuU5AdX9U7e6BgknpUCdh5OVuxATFhXQKT3555ivsKtnS0KcCa+rDOi7xxANxHc7gg40cc1KRuTamqZBmRF9FZn71QCgKltkvJcEb+IAJy3ISATAN3CQ41Wr9e3uNaEz+hA2CTBbCROJANnhpim6uBR4KE0IaETog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=dIsplsTS; arc=fail smtp.client-ip=40.107.102.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy3F42oQaqOnz4egaAHMZonxK4CF8C20u97RIi8wMH+0G0RBHNSOoBmX+0pOXMZztxmqGIid2LP/x+i1jSdw4zgK6jm7zXuz7P9Bvemkn0MdlLFVBFF0TnUQRARHJBHNMqEpDgI9aGiHxlv6xs68Q7pKe3giS+qZP19dPHMDyTPC4vuBRobOZjFfrje/OJ91B0hbq8F1TDFtF6KcuAtBEWQsDD+8da7rsui1K/FrRcHjJVO8dEBZ38tzBLJgyxfuO4GTFgfRnmA9DZiQsnjj1Cpww5JO+xjxO2fZCpATZLSJrQ74G8XUMraUEPTW1UvtxxNiNIJiXprgewL4aoGGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNgrTHDrfkF4d0ZQ2EkkmIwHB9L0RrD8A4V1+7ZERlU=;
 b=ANOwEtolxTDiR3A4gMjfVPYMJvnhzA2dWgujtgwJQs2eqbm5ZdoWiqQaTLtB/ApqhLnZ2DGvLucEcdDFMVSCHVPsNURwOrSaUU12ldz9j455udk91tnKB++xHhmQ194YC8PE/RTHhVFzuGlS9l9djFXrcF/Hd8rbL0RgfPg/q8IrNRpIDadWSVBYbKTGkocF1Gc570gFPCYHYZGHBfLWNVvp4PPmObM+hyCC4c0u0cHgUXhNPVWRNqq9JJHzL/lXSG9VdvQEwN3JPVumk78sRYFjO03h5Uy8V332cT/2ks/2SXdnDigJEL/jPYHSvvvF1i7CMCecKE6RHCTw9PQmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNgrTHDrfkF4d0ZQ2EkkmIwHB9L0RrD8A4V1+7ZERlU=;
 b=dIsplsTSha1JnZCyoyMSucsUMujM1Gmc7SDpCpskRTTr5nOhoN4NsMwLRSPOYbwzAr3nS8E1ZyNBe/23/kBNUQZPkA+1MdQBPejs0ihdhaVtHvnuh+op738YqaDtedvufTkCJaLbZtwEEHqedchOyCt23KOcTB2PDiHzsoxtd+CUHJ7zOhmg0L4ttWsYT7nM/2NM0bmieDuBnxjq2etX6CBiDPg96GZkwXIHLBKkydTNzPf22RQXkQ/yX8JkbbkUQj/YJ35cdQVFyx19QJ8GhZNhEAJ5DQGkDkFYaA3T6PhqaB0AzUcCRBjlikZVQaUm1xIRTqdkXHeFkXVqNnnE2A==
Received: from SA1PR05CA0018.namprd05.prod.outlook.com (2603:10b6:806:2d2::18)
 by IA0PR01MB8238.prod.exchangelabs.com (2603:10b6:208:490::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Mon, 30 Jun 2025 17:58:11 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:2d2:cafe::75) by SA1PR05CA0018.outlook.office365.com
 (2603:10b6:806:2d2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Mon,
 30 Jun 2025 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:11 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id E5BB714D734;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 1533D1848B5CB;
	Mon, 30 Jun 2025 11:30:28 -0400 (EDT)
Subject: [PATCH for-next 08/23] RDMA/hfi2: Start hfi2 driver by basing off of
 hfi1
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:28 -0400
Message-ID:
 <175129742804.1859400.7490653481781042723.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|IA0PR01MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 427e8827-3ecd-419d-78b6-08ddb7ffada0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RmUFpCNWFVN3VqN2dZTFB0VnVrYWFmejlMWVkzZVFBNldiZmtpRjhwRGNS?=
 =?utf-8?B?Z1M0Nk9BVVFiNWNlK2E3bklIcUdFbFU5dTluZlB5U2pGbE8rd0hGVzFVcXo1?=
 =?utf-8?B?REtTTFZ3MU0rVVRkUmNHMlVsSDRYSE4yOHlZMHNzVUppS2d6NnVoMmxlZWNk?=
 =?utf-8?B?Vy9tSkR1OFJEZkpLblFORTduSks5YWNQNmtqM0kzSndTRnVmdC9pYmYwL000?=
 =?utf-8?B?TCtqOXBrSnAzeFczV3JnMDNxbE5XWTdwZVYwT1YrelBIT05LSndTWEFLZk11?=
 =?utf-8?B?d2ZZc0R5MnNQVytEMXdpWGhNb1BDVW5rZElDd3NkNVpsSEJEUDNWRHg1YVRm?=
 =?utf-8?B?T1Z4Z2pGY3FvUHI2b21VZTRTaGtRdlhUUVNHa1NRbkY3NXJVTEIwQS9YVDJq?=
 =?utf-8?B?Z2svSDFaQ0FyNGNRa01EZ3VBVHdybzZUS3JBb0V1WHEra1ozWWZ5b2NhK1hm?=
 =?utf-8?B?MnZDazlZU05zMUxRRnFWRHZhNStwUkVHRFIzWHpKWnBCTHEvTENKQWdQUWRS?=
 =?utf-8?B?djdNRWphY25HbWlQMWtPMU5VbTVtU0MzT1lseFBpMG5KTEIybUQwMnkyanRp?=
 =?utf-8?B?UkNrcytuY2JHc3pmYVR0SHJDMmZiWFNUSCtXd2dPZHpadkVPVmdweENSazFP?=
 =?utf-8?B?bWsySTYvcTRHY2E0aUUrdHJ0Qk5RN2Nja290QlREeFp6b1VybFFTTWVKUkhC?=
 =?utf-8?B?VkIycHFBYXJpeHVhZ3ZzNndhNTQ4NG5RSG94R01UWmd2c0VvMTI1Sis0MDVU?=
 =?utf-8?B?MkJIbEZQWGx0NXNOVjVEMVdpZVE0YkpaYTNhZVR2RzJ3SlhGN1ZicjQwRi9U?=
 =?utf-8?B?c2l2Wk1veU5qTlFpR1MyRXlPNk1JL2RVcXVoTHFuTTFRanVoMjlvTHFVZ3Yv?=
 =?utf-8?B?eUdGSEd1bVVRcG5ZeEVxRDVEbXFvdnpjY2pwb3AwZjdpVjFEUDAraGkzUmhN?=
 =?utf-8?B?bGFwUVZDbnN2NGJBemZBendJclZUdUdlcDN3TlFnZzNzQWNuUGhyQTduUG9w?=
 =?utf-8?B?TFd2NTV5aGZqaklHczZ3aHZyWms0YXNSQkE1R2N5VkM4TDBRQytmYit4aTF1?=
 =?utf-8?B?KzZhUXFieXZ1SnZ4VnNFYWpadlBib1VWbkVrNTRRR1ZOY2loTmw5U1BHYkd4?=
 =?utf-8?B?ejlHMGxwWmV4Mm1ucWNRazZxVEs4cHR6cEdTUDFGU2tHUldYTmxFbFZRUjNa?=
 =?utf-8?B?dk9nUzFXNVVZRDhjLzYyTis1SUR3eWtFbGdQU3dmZ01yWHhNL1BhZ253Q3BI?=
 =?utf-8?B?NXFyMUx4VDE3WlRXakY3SWZvMFJPR1ZPNDZlam1wUzNQZlRJUHlIUHBLOWZJ?=
 =?utf-8?B?Sy8yRjhlMXhxbzVJQTA5WEFBZkdsTTBEM3lyQ0tCbUVMdW4vQU9Ha3FBU0tH?=
 =?utf-8?B?ZE96dHNxSnZlSkJ0ZVdwODd3NzNwZFNTWlFYYW1BTUdSaDkzNE9uOFJzKzUw?=
 =?utf-8?B?amxONnRyak5waHh3ZWlVRmFhTUdEcS9EWWoyZlMvVHVndlRMSU1PTFBJaE1n?=
 =?utf-8?B?U2o1OGR4OGZFN0NxSzFFbW5PMVZWVVVtcjU5c2dXRUFkRmtZTllaV2VBazUx?=
 =?utf-8?B?UVVxUFdISVJJUGxmOUR4Mmw2ZUxnUkNRV25SSFdpY0F5cm5EZkZHMTJ4RE9X?=
 =?utf-8?B?dmtaMngwTzZzVTQ5dGtVTE9NblB6NlJDYjVBTVlYZERNUE5Hd1BieS9JOERx?=
 =?utf-8?B?TE9ZUGtLdm5kZzZpUVBWWld3akRLYkZHK2NjM1RFT0RiZVFmMHp3N1l2WEp0?=
 =?utf-8?B?SEoyN0VxQ1Z4ZWZjdDJOcmdlWGlKRDFWZ1FUVVZyUkFGek1WbTRpZTkwTHdJ?=
 =?utf-8?B?ZWk1VGtQMzdkMytBdTRsTG1naEozenFxL2xNb1NFZCt1cGdlUlZmaTlsN0do?=
 =?utf-8?B?M1JDTkk1VzVXSlZuclpnbXZZWWp1b1MxQkF3Y3NKSnF2bnE1R0pkYndTQkJP?=
 =?utf-8?B?R25BOFNQeDh2ZVpDZGZQUk5mR3ZlVHJUcTJyeFlzY1lsaXJBNXF0dzN0Szg5?=
 =?utf-8?B?SHBndi9uNzR4b1B0dlYwT2ZZNVV2aHpuMzVGSWVLZGZYNitYK2VOTkdUMlNi?=
 =?utf-8?Q?jzRHjL?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:11.2276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e8827-3ecd-419d-78b6-08ddb7ffada0
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8238

The hfi1 driver has seen a near complete rewrite. Instead of trying to
wedge all of the changes back into hfi1 we are going to deprecate the
driver in favor of a new driver. This driver will not have the
objectionalbe private cdev and instead will rely on the infrastructure
provided by the ib core for doing user interaction.

This new driver will support both the old/existing chip (WFR) as well as
the new (JKR) chip and follow on chips for 800Gbps and 1.6Tbps.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/hfi2.h | 3283 +++++++++++++++++++++++++++++++++++++
 1 file changed, 3283 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/hfi2.h

diff --git a/drivers/infiniband/hw/hfi2/hfi2.h b/drivers/infiniband/hw/hfi2/hfi2.h
new file mode 100644
index 000000000000..cf6240119d4d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/hfi2.h
@@ -0,0 +1,3283 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2025 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_KERNEL_H
+#define _HFI2_KERNEL_H
+
+#include <linux/refcount.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/mutex.h>
+#include <linux/list.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/fs.h>
+#include <linux/completion.h>
+#include <linux/kref.h>
+#include <linux/sched.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/xarray.h>
+#include <rdma/ib_hdrs.h>
+#include <rdma/opa_addr.h>
+#include <linux/rhashtable.h>
+#include <rdma/rdma_vt.h>
+
+#include "chip_registers.h"
+#include "common.h"
+#include "opfn.h"
+#include "verbs.h"
+#include "pio.h"
+#include "chip.h"
+#include "mad.h"
+#include "qsfp.h"
+#include "platform.h"
+#include "affinity.h"
+#include "msix.h"
+#include "cport.h"
+
+/* The active logical port index, default is 0 */
+#define HFI2_PORT_IDX 0
+
+/* bumped 1 from s/w major version of TrueScale */
+#define HFI2_CHIP_VERS_MAJ 3U
+
+/* don't care about this except printing */
+#define HFI2_CHIP_VERS_MIN 0U
+
+/* The Organization Unique Identifier (Mfg code), and its position in GUID */
+#define HFI2_OUI 0x001175
+#define HFI2_OUI_LSB 40
+
+#define DROP_PACKET_OFF		0
+#define DROP_PACKET_ON		1
+
+#define NEIGHBOR_TYPE_HFI		0
+#define NEIGHBOR_TYPE_SWITCH	1
+
+#define HFI2_MAX_ACTIVE_GEN_WQ_ENTRIES		10
+#define HFI2_MAX_ACTIVE_WORKQUEUE_ENTRIES	5
+
+extern unsigned long hfi2_cap_mask;
+#define HFI2_CAP_KGET_MASK(mask, cap) ((mask) & HFI2_CAP_##cap)
+#define HFI2_CAP_UGET_MASK(mask, cap) \
+	(((mask) >> HFI2_CAP_USER_SHIFT) & HFI2_CAP_##cap)
+#define HFI2_CAP_KGET(cap) (HFI2_CAP_KGET_MASK(hfi2_cap_mask, cap))
+#define HFI2_CAP_UGET(cap) (HFI2_CAP_UGET_MASK(hfi2_cap_mask, cap))
+#define HFI2_CAP_IS_KSET(cap) (!!HFI2_CAP_KGET(cap))
+#define HFI2_CAP_IS_USET(cap) (!!HFI2_CAP_UGET(cap))
+#define HFI2_MISC_GET() ((hfi2_cap_mask >> HFI2_CAP_MISC_SHIFT) & \
+			HFI2_CAP_MISC_MASK)
+/* Offline Disabled Reason is 4-bits */
+#define HFI2_ODR_MASK(rsn) ((rsn) & OPA_PI_MASK_OFFLINE_REASON)
+
+/*
+ * Control context is always 0 and handles the error packets.
+ * It also handles the VL15 and multicast packets.
+ */
+#define HFI2_CTRL_CTXT    0
+
+/*
+ * Driver context will store software counters for each of the events
+ * associated with these status registers
+ */
+#define NUM_CCE_ERR_STATUS_COUNTERS 41
+#define NUM_RCV_ERR_STATUS_COUNTERS 64
+#define NUM_MISC_ERR_STATUS_COUNTERS 13
+#define NUM_SEND_PIO_ERR_STATUS_COUNTERS 36
+#define NUM_SEND_DMA_ERR_STATUS_COUNTERS 4
+#define NUM_SEND_EGRESS_ERR_STATUS_COUNTERS 64
+#define NUM_SEND_ERR_STATUS_COUNTERS 3
+#define NUM_SEND_CTXT_ERR_STATUS_COUNTERS 5
+#define NUM_SEND_DMA_ENG_ERR_STATUS_COUNTERS 24
+
+/*
+ * per driver stats, either not device nor port-specific, or
+ * summed over all of the devices and ports.
+ * They are described by name via ipathfs filesystem, so layout
+ * and number of elements can change without breaking compatibility.
+ * If members are added or deleted hfi2_statnames[] in debugfs.c must
+ * change to match.
+ */
+struct hfi2_ib_stats {
+	__u64 sps_ints; /* number of interrupts handled */
+	__u64 sps_errints; /* number of error interrupts */
+	__u64 sps_txerrs; /* tx-related packet errors */
+	__u64 sps_rcverrs; /* non-crc rcv packet errors */
+	__u64 sps_hwerrs; /* hardware errors reported (parity, etc.) */
+	__u64 sps_nopiobufs; /* no pio bufs avail from kernel */
+	__u64 sps_ctxts; /* number of contexts currently open */
+	__u64 sps_lenerrs; /* number of kernel packets where RHF != LRH len */
+	__u64 sps_buffull;
+	__u64 sps_hdrfull;
+};
+
+extern struct hfi2_ib_stats hfi2_stats;
+extern const struct pci_error_handlers hfi2_pci_err_handler;
+
+extern int num_driver_cntrs;
+
+/*
+ * First-cut criterion for "device is active" is
+ * two thousand dwords combined Tx, Rx traffic per
+ * 5-second interval. SMA packets are 64 dwords,
+ * and occur "a few per second", presumably each way.
+ */
+#define HFI2_TRAFFIC_ACTIVE_THRESHOLD (2000)
+
+/*
+ * Below contains all data related to a single context (formerly called port).
+ */
+
+struct hfi2_opcode_stats_perctx;
+
+struct ctxt_eager_bufs {
+	struct eager_buffer {
+		void *addr;
+		dma_addr_t dma;
+		ssize_t len;
+	} *buffers;
+	struct {
+		void *addr;
+		dma_addr_t dma;
+	} *rcvtids;
+	u32 size;                /* total size of eager buffers */
+	u32 rcvtid_size;         /* size of each eager rcv tid */
+	u16 count;               /* size of buffers array */
+	u16 numbufs;             /* number of buffers allocated */
+	u16 alloced;             /* number of rcvarray entries used */
+	u16 threshold;           /* head update threshold */
+};
+
+struct exp_tid_set {
+	struct list_head list;
+	u32 count;
+};
+
+struct hfi2_ctxtdata;
+typedef int (*intr_handler)(struct hfi2_ctxtdata *rcd, int data);
+typedef void (*rhf_rcv_function_ptr)(struct hfi2_packet *packet);
+
+struct tid_queue {
+	struct list_head queue_head;
+			/* queue head for QP TID resource waiters */
+	u32 enqueue;	/* count of tid enqueues */
+	u32 dequeue;	/* count of tid dequeues */
+};
+
+struct hfi2_ctxtdata {
+	/* rcvhdrq base, needs mmap before useful */
+	void *rcvhdrq;
+	/* kernel virtual address where hdrqtail is updated */
+	volatile __le64 *rcvhdrtail_kvaddr;
+	/* so functions that need physical port can get it easily */
+	struct hfi2_pportdata *ppd;
+	/* so file ops can get at unit */
+	struct hfi2_devdata *dd;
+	/* this receive context's assigned PIO ACK send context */
+	struct send_context *sc;
+	/* per context recv functions */
+	const rhf_rcv_function_ptr *rhf_rcv_function_map;
+	const rhf_rcv_function_ptr *save_rhf_rcv_function_map;
+	/*
+	 * The interrupt handler for a particular receive context can vary
+	 * throughout it's lifetime. This is not a lock protected data member so
+	 * it must be updated atomically and the prev and new value must always
+	 * be valid. Worst case is we process an extra interrupt and up to 64
+	 * packets with the wrong interrupt handler.
+	 */
+	intr_handler do_interrupt;
+	/** fast handler after autoactive */
+	intr_handler fast_handler;
+	/** slow handler */
+	intr_handler slow_handler;
+	/* napi pointer assiociated with netdev */
+	struct napi_struct *napi;
+	/* verbs rx_stats per rcd */
+	struct hfi2_opcode_stats_perctx *opstats;
+	/* clear interrupt mask */
+	u64 imask;
+	/* ctxt rcvhdrq head offset */
+	u32 head;
+	/* number of rcvhdrq entries */
+	u16 rcvhdrq_cnt;
+	u8 ireg;	/* clear interrupt register */
+	/* receive packet sequence counter */
+	u8 seq_cnt;
+	/* size of each of the rcvhdrq entries */
+	u8 rcvhdrqentsize;
+	/* offset of RHF within receive header entry */
+	u8 rhf_offset;
+	/* KDETH receive header size */
+	u8 kdeth_rcv_hdr;
+	/* dynamic receive available interrupt timeout */
+	u8 rcvavail_timeout;
+	/* Is ASPM interrupt supported for this context */
+	bool aspm_intr_supported;
+	/* ASPM state (enabled/disabled) for this context */
+	bool aspm_enabled;
+	/* Is ASPM processing enabled for this context (in intr context) */
+	bool aspm_intr_enable;
+	struct ctxt_eager_bufs egrbufs;
+	/* QPs waiting for context processing */
+	struct list_head qp_wait_list;
+	/* tid allocation lists */
+	struct exp_tid_set tid_group_list;
+	struct exp_tid_set tid_used_list;
+	struct exp_tid_set tid_full_list;
+
+	/* Timer for re-enabling ASPM if interrupt activity quiets down */
+	struct timer_list aspm_timer;
+	/* per-context configuration flags */
+	unsigned long flags;
+	/* array of tid_groups */
+	struct tid_group  *groups;
+	/* receive header queue dma addresses */
+	dma_addr_t rcvhdrq_dma;
+	dma_addr_t rcvhdrqtailaddr_dma;
+	/* receive header error queue (rheq) */
+	void *rheq;
+	dma_addr_t rheq_dma;
+	/* Last interrupt timestamp */
+	ktime_t aspm_ts_last_intr;
+	/* Last timestamp at which we scheduled a timer for this context */
+	ktime_t aspm_ts_timer_sched;
+	/* Lock to serialize between intr, timer intr and user threads */
+	spinlock_t aspm_lock;
+	/* Reference count the base context usage */
+	struct kref kref;
+	/* numa node of this context */
+	int numa_id;
+	/* associated msix interrupt. */
+	s16 msix_intr;
+	/* job key */
+	u16 jkey;
+	/* number of RcvArray groups for this context. */
+	u32 rcv_array_groups;
+	/* index of first eager TID entry. */
+	u32 eager_base;
+	/* number of expected TID entries */
+	u32 expected_count;
+	/* index of first expected TID entry. */
+	u32 expected_base;
+	/* Device context index */
+	u16 ctxt;
+
+	/* PSM Specific fields */
+	/* lock protecting all Expected TID data */
+	struct mutex exp_mutex;
+	/* lock protecting all Expected TID data of kernel contexts */
+	spinlock_t exp_lock;
+	/* Queue for QP's waiting for HW TID flows */
+	struct tid_queue flow_queue;
+	/* Queue for QP's waiting for HW receive array entries */
+	struct tid_queue rarr_queue;
+	/* when waiting for rcv or pioavail */
+	wait_queue_head_t wait;
+	/* uuid from PSM */
+	u8 uuid[16];
+	/* same size as task_struct .comm[], command that opened context */
+	char comm[TASK_COMM_LEN];
+	/* Bitmask of in use context(s) */
+	DECLARE_BITMAP(in_use_ctxts, HFI2_MAX_SHARED_CTXTS);
+	/* per-context event flags for fileops/intr communication */
+	unsigned long event_flags;
+	/* A page of memory for rcvhdrhead, rcvegrhead, rcvegrtail * N */
+	void *subctxt_uregbase;
+	/* An array of pages for the eager receive buffers * N */
+	void *subctxt_rcvegrbuf;
+	/* An array of pages for the eager header queue entries * N */
+	void *subctxt_rcvhdr_base;
+	/* total number of polled urgent packets */
+	u32 urgent;
+	/* saved total number of polled urgent packets for poll edge trigger */
+	u32 urgent_poll;
+	/* Type of packets or conditions we want to poll for */
+	u16 poll_type;
+	/* non-zero if ctxt is being shared. */
+	u16 subctxt_id;
+	/* The version of the library which opened this ctxt */
+	u32 userversion;
+	/*
+	 * non-zero if ctxt can be shared, and defines the maximum number of
+	 * sub-contexts for this device context.
+	 */
+	u16 subctxt_cnt;
+
+	/* Bit mask to track free TID RDMA HW flows */
+	unsigned long flow_mask;
+	struct tid_flow_state flows[RXE_NUM_TID_FLOWS];
+};
+
+/**
+ * rcvhdrq_size - return total size in bytes for header queue
+ * @rcd: the receive context
+ *
+ * rcvhdrqentsize is in DWs, so we have to convert to bytes
+ *
+ */
+static inline u32 rcvhdrq_size(struct hfi2_ctxtdata *rcd)
+{
+	return PAGE_ALIGN(rcd->rcvhdrq_cnt *
+			  rcd->rcvhdrqentsize * sizeof(u32));
+}
+
+static inline u32 rheq_size(struct hfi2_ctxtdata *rcd)
+{
+	return PAGE_ALIGN(rcd->rcvhdrq_cnt * sizeof(u64));
+}
+
+/*
+ * Represents a single packet at a high level. Put commonly computed things in
+ * here so we do not have to keep doing them over and over. The rule of thumb is
+ * if something is used one time to derive some value, store that something in
+ * here. If it is used multiple times, then store the result of that derivation
+ * in here.
+ */
+struct hfi2_packet {
+	void *ebuf;
+	void *hdr;
+	void *payload;
+	struct hfi2_ctxtdata *rcd;
+	__le32 *rhf_addr;
+	struct rvt_qp *qp;
+	struct ib_other_headers *ohdr;
+	struct ib_grh *grh;
+	struct opa_16b_mgmt *mgmt;
+	u64 rhf;
+	u32 maxcnt;
+	u32 rhqoff;
+	u32 dlid;
+	u32 slid;
+	int numpkt;
+	u16 tlen;
+	s16 etail;
+	u16 pkey;
+	u8 hlen;
+	u8 rsize;
+	u8 updegr;
+	u8 etype;
+	u8 extra_byte;
+	u8 pad;
+	u8 sc;
+	u8 sl;
+	u8 opcode;
+	bool migrated;
+	/* chip-dependent extracted RHF fields */
+	u64 err_flags;
+	u16 egr_index;
+	u8 rcv_seq;
+	bool sc4;
+	bool has_errs;
+};
+
+/* Packet types */
+#define HFI2_PKT_TYPE_9B  0
+#define HFI2_PKT_TYPE_16B 1
+
+/*
+ * OPA 16B Header
+ */
+#define OPA_16B_L4_MASK		0xFFull
+#define OPA_16B_SC_MASK		0x1F00000ull
+#define OPA_16B_SC_SHIFT	20
+#define OPA_16B_LID_MASK	0xFFFFFull
+#define OPA_16B_DLID_MASK	0xF000ull
+#define OPA_16B_DLID_SHIFT	20
+#define OPA_16B_DLID_HIGH_SHIFT	12
+#define OPA_16B_SLID_MASK	0xF00ull
+#define OPA_16B_SLID_SHIFT	20
+#define OPA_16B_SLID_HIGH_SHIFT	8
+#define OPA_16B_BECN_MASK       0x80000000ull
+#define OPA_16B_BECN_SHIFT      31
+#define OPA_16B_FECN_MASK       0x10000000ull
+#define OPA_16B_FECN_SHIFT      28
+#define OPA_16B_L2_MASK		0x60000000ull
+#define OPA_16B_L2_SHIFT	29
+#define OPA_16B_PKEY_MASK	0xFFFF0000ull
+#define OPA_16B_PKEY_SHIFT	16
+#define OPA_16B_LEN_MASK	0x7FF00000ull
+#define OPA_16B_LEN_SHIFT	20
+#define OPA_16B_RC_MASK		0xE000000ull
+#define OPA_16B_RC_SHIFT	25
+#define OPA_16B_AGE_MASK	0xFF0000ull
+#define OPA_16B_AGE_SHIFT	16
+#define OPA_16B_ENTROPY_MASK	0xFFFFull
+
+/*
+ * OPA 16B L2/L4 Encodings
+ */
+#define OPA_16B_L4_9B		0x00
+#define OPA_16B_L2_TYPE		0x02
+#define OPA_16B_L4_FM		0x08
+#define OPA_16B_L4_IB_LOCAL	0x09
+#define OPA_16B_L4_IB_GLOBAL	0x0A
+
+/*
+ * OPA 16B Management
+ */
+#define OPA_16B_L4_FM_PAD	3  /* fixed 3B pad */
+#define OPA_16B_L4_FM_HLEN	24 /* 16B(16) + L4_FM(8) */
+
+static inline u8 hfi2_16B_get_l4(struct hfi2_16b_header *hdr)
+{
+	return (u8)(hdr->lrh[2] & OPA_16B_L4_MASK);
+}
+
+static inline u8 hfi2_16B_get_sc(struct hfi2_16b_header *hdr)
+{
+	return (u8)((hdr->lrh[1] & OPA_16B_SC_MASK) >> OPA_16B_SC_SHIFT);
+}
+
+static inline u32 hfi2_16B_get_dlid(struct hfi2_16b_header *hdr)
+{
+	return (u32)((hdr->lrh[1] & OPA_16B_LID_MASK) |
+		     (((hdr->lrh[2] & OPA_16B_DLID_MASK) >>
+		     OPA_16B_DLID_HIGH_SHIFT) << OPA_16B_DLID_SHIFT));
+}
+
+static inline u32 hfi2_16B_get_slid(struct hfi2_16b_header *hdr)
+{
+	return (u32)((hdr->lrh[0] & OPA_16B_LID_MASK) |
+		     (((hdr->lrh[2] & OPA_16B_SLID_MASK) >>
+		     OPA_16B_SLID_HIGH_SHIFT) << OPA_16B_SLID_SHIFT));
+}
+
+static inline u8 hfi2_16B_get_becn(struct hfi2_16b_header *hdr)
+{
+	return (u8)((hdr->lrh[0] & OPA_16B_BECN_MASK) >> OPA_16B_BECN_SHIFT);
+}
+
+static inline u8 hfi2_16B_get_fecn(struct hfi2_16b_header *hdr)
+{
+	return (u8)((hdr->lrh[1] & OPA_16B_FECN_MASK) >> OPA_16B_FECN_SHIFT);
+}
+
+static inline u8 hfi2_16B_get_l2(struct hfi2_16b_header *hdr)
+{
+	return (u8)((hdr->lrh[1] & OPA_16B_L2_MASK) >> OPA_16B_L2_SHIFT);
+}
+
+static inline u16 hfi2_16B_get_pkey(struct hfi2_16b_header *hdr)
+{
+	return (u16)((hdr->lrh[2] & OPA_16B_PKEY_MASK) >> OPA_16B_PKEY_SHIFT);
+}
+
+static inline u8 hfi2_16B_get_rc(struct hfi2_16b_header *hdr)
+{
+	return (u8)((hdr->lrh[1] & OPA_16B_RC_MASK) >> OPA_16B_RC_SHIFT);
+}
+
+static inline u8 hfi2_16B_get_age(struct hfi2_16b_header *hdr)
+{
+	return (u8)((hdr->lrh[3] & OPA_16B_AGE_MASK) >> OPA_16B_AGE_SHIFT);
+}
+
+static inline u16 hfi2_16B_get_len(struct hfi2_16b_header *hdr)
+{
+	return (u16)((hdr->lrh[0] & OPA_16B_LEN_MASK) >> OPA_16B_LEN_SHIFT);
+}
+
+static inline u16 hfi2_16B_get_entropy(struct hfi2_16b_header *hdr)
+{
+	return (u16)(hdr->lrh[3] & OPA_16B_ENTROPY_MASK);
+}
+
+#define OPA_16B_MAKE_QW(low_dw, high_dw) (((u64)(high_dw) << 32) | (low_dw))
+
+/*
+ * BTH
+ */
+#define OPA_16B_BTH_PAD_MASK	7
+static inline u8 hfi2_16B_bth_get_pad(struct ib_other_headers *ohdr)
+{
+	return (u8)((be32_to_cpu(ohdr->bth[0]) >> IB_BTH_PAD_SHIFT) &
+		   OPA_16B_BTH_PAD_MASK);
+}
+
+/*
+ *  * Private data for snoop/capture support.
+ */
+struct hfi2_snoop_data {
+	int mode_flag;
+	struct cdev cdev;
+	struct device *class_dev;
+	/* protect snoop data */
+	spinlock_t snoop_lock;
+	struct list_head queue;
+	wait_queue_head_t waitq;
+	void *filter_value;
+	int (*filter_callback)(void *hdr, void *data, void *value);
+	u64 dcc_cfg; /* saved value of DCC Cfg register */
+};
+
+/* snoop mode_flag values */
+#define HFI2_PORT_SNOOP_MODE     1U
+#define HFI2_PORT_CAPTURE_MODE   2U
+
+/*
+ * 16B Management
+ */
+#define OPA_16B_MGMT_QPN_MASK	0xFFFFFF
+static inline u32 hfi2_16B_get_dest_qpn(struct opa_16b_mgmt *mgmt)
+{
+	return be32_to_cpu(mgmt->dest_qpn) & OPA_16B_MGMT_QPN_MASK;
+}
+
+static inline u32 hfi2_16B_get_src_qpn(struct opa_16b_mgmt *mgmt)
+{
+	return be32_to_cpu(mgmt->src_qpn) & OPA_16B_MGMT_QPN_MASK;
+}
+
+static inline void hfi2_16B_set_qpn(struct opa_16b_mgmt *mgmt,
+				    u32 dest_qp, u32 src_qp)
+{
+	mgmt->dest_qpn = cpu_to_be32(dest_qp & OPA_16B_MGMT_QPN_MASK);
+	mgmt->src_qpn = cpu_to_be32(src_qp & OPA_16B_MGMT_QPN_MASK);
+}
+
+/**
+ * hfi2_get_rc_ohdr - get extended header
+ * @opah - the opaheader
+ */
+static inline struct ib_other_headers *
+hfi2_get_rc_ohdr(struct hfi2_opa_header *opah)
+{
+	struct ib_other_headers *ohdr;
+	struct ib_header *hdr = NULL;
+	struct hfi2_16b_header *hdr_16b = NULL;
+
+	/* Find out where the BTH is */
+	if (opah->hdr_type == HFI2_PKT_TYPE_9B) {
+		hdr = &opah->ibh;
+		if (ib_get_lnh(hdr) == HFI2_LRH_BTH)
+			ohdr = &hdr->u.oth;
+		else
+			ohdr = &hdr->u.l.oth;
+	} else {
+		u8 l4;
+
+		hdr_16b = &opah->opah;
+		l4  = hfi2_16B_get_l4(hdr_16b);
+		if (l4 == OPA_16B_L4_IB_LOCAL)
+			ohdr = &hdr_16b->u.oth;
+		else
+			ohdr = &hdr_16b->u.l.oth;
+	}
+	return ohdr;
+}
+
+struct rvt_sge_state;
+
+/*
+ * Get/Set IB link-level config parameters for f_get/set_ib_cfg()
+ * Mostly for MADs that set or query link parameters, also ipath
+ * config interfaces
+ */
+#define HFI2_IB_CFG_LIDLMC 0 /* LID (LS16b) and Mask (MS16b) */
+#define HFI2_IB_CFG_LWID_DG_ENB 1 /* allowed Link-width downgrade */
+#define HFI2_IB_CFG_LWID_ENB 2 /* allowed Link-width */
+#define HFI2_IB_CFG_LWID 3 /* currently active Link-width */
+#define HFI2_IB_CFG_SPD_ENB 4 /* allowed Link speeds */
+#define HFI2_IB_CFG_SPD 5 /* current Link spd */
+#define HFI2_IB_CFG_RXPOL_ENB 6 /* Auto-RX-polarity enable */
+#define HFI2_IB_CFG_LREV_ENB 7 /* Auto-Lane-reversal enable */
+#define HFI2_IB_CFG_LINKLATENCY 8 /* Link Latency (IB1.2 only) */
+#define HFI2_IB_CFG_HRTBT 9 /* IB heartbeat off/enable/auto; DDR/QDR only */
+#define HFI2_IB_CFG_OP_VLS 10 /* operational VLs */
+#define HFI2_IB_CFG_VL_HIGH_CAP 11 /* num of VL high priority weights */
+#define HFI2_IB_CFG_VL_LOW_CAP 12 /* num of VL low priority weights */
+#define HFI2_IB_CFG_OVERRUN_THRESH 13 /* IB overrun threshold */
+#define HFI2_IB_CFG_PHYERR_THRESH 14 /* IB PHY error threshold */
+#define HFI2_IB_CFG_LINKDEFAULT 15 /* IB link default (sleep/poll) */
+#define HFI2_IB_CFG_PKEYS 16 /* update partition keys */
+#define HFI2_IB_CFG_MTU 17 /* update MTU in IBC */
+#define HFI2_IB_CFG_VL_HIGH_LIMIT 19
+#define HFI2_IB_CFG_PMA_TICKS 20 /* PMA sample tick resolution */
+#define HFI2_IB_CFG_PORT 21 /* switch port we are connected to */
+
+/*
+ * Host Link States
+ *
+ * These describe the states the driver thinks the logical and physical
+ * states are in.  Used as an argument to set_link_state().  Implemented
+ * as bits for easy multi-state checking.  The actual state can only be
+ * one.
+ */
+#define __HLS_UP_INIT_BP	0
+#define __HLS_UP_ARMED_BP	1
+#define __HLS_UP_ACTIVE_BP	2
+#define __HLS_DN_DOWNDEF_BP	3	/* link down default */
+#define __HLS_DN_POLL_BP	4
+#define __HLS_DN_DISABLE_BP	5
+#define __HLS_DN_OFFLINE_BP	6
+#define __HLS_VERIFY_CAP_BP	7
+#define __HLS_GOING_UP_BP	8
+#define __HLS_GOING_OFFLINE_BP  9
+#define __HLS_LINK_COOLDOWN_BP 10
+
+#define HLS_UP_INIT	  BIT(__HLS_UP_INIT_BP)
+#define HLS_UP_ARMED	  BIT(__HLS_UP_ARMED_BP)
+#define HLS_UP_ACTIVE	  BIT(__HLS_UP_ACTIVE_BP)
+#define HLS_DN_DOWNDEF	  BIT(__HLS_DN_DOWNDEF_BP) /* link down default */
+#define HLS_DN_POLL	  BIT(__HLS_DN_POLL_BP)
+#define HLS_DN_DISABLE	  BIT(__HLS_DN_DISABLE_BP)
+#define HLS_DN_OFFLINE	  BIT(__HLS_DN_OFFLINE_BP)
+#define HLS_VERIFY_CAP	  BIT(__HLS_VERIFY_CAP_BP)
+#define HLS_GOING_UP	  BIT(__HLS_GOING_UP_BP)
+#define HLS_GOING_OFFLINE BIT(__HLS_GOING_OFFLINE_BP)
+#define HLS_LINK_COOLDOWN BIT(__HLS_LINK_COOLDOWN_BP)
+
+#define HLS_UP (HLS_UP_INIT | HLS_UP_ARMED | HLS_UP_ACTIVE)
+#define HLS_DOWN ~(HLS_UP)
+
+#define HLS_DEFAULT HLS_DN_POLL
+
+/* use this MTU size if none other is given */
+#define HFI2_DEFAULT_ACTIVE_MTU 10240
+/* use this MTU size as the default maximum */
+#define HFI2_DEFAULT_MAX_MTU 10240
+/* default partition key */
+#define DEFAULT_PKEY 0xffff
+
+/*
+ * Possible fabric manager config parameters for fm_{get,set}_table()
+ */
+#define FM_TBL_VL_HIGH_ARB		1 /* Get/set VL high prio weights */
+#define FM_TBL_VL_LOW_ARB		2 /* Get/set VL low prio weights */
+#define FM_TBL_BUFFER_CONTROL		3 /* Get/set Buffer Control */
+#define FM_TBL_SC2VLNT			4 /* Get/set SC->VLnt */
+#define FM_TBL_VL_PREEMPT_ELEMS		5 /* Get (no set) VL preempt elems */
+#define FM_TBL_VL_PREEMPT_MATRIX	6 /* Get (no set) VL preempt matrix */
+
+/*
+ * Possible "operations" for f_rcvctrl(ppd, op, ctxt)
+ * these are bits so they can be combined, e.g.
+ * HFI2_RCVCTRL_INTRAVAIL_ENB | HFI2_RCVCTRL_CTXT_ENB
+ */
+#define HFI2_RCVCTRL_TAILUPD_ENB 0x01
+#define HFI2_RCVCTRL_TAILUPD_DIS 0x02
+#define HFI2_RCVCTRL_CTXT_ENB 0x04
+#define HFI2_RCVCTRL_CTXT_DIS 0x08
+#define HFI2_RCVCTRL_INTRAVAIL_ENB 0x10
+#define HFI2_RCVCTRL_INTRAVAIL_DIS 0x20
+#define HFI2_RCVCTRL_PKEY_ENB 0x40  /* Note, default is enabled */
+#define HFI2_RCVCTRL_PKEY_DIS 0x80
+#define HFI2_RCVCTRL_TIDFLOW_ENB 0x0400
+#define HFI2_RCVCTRL_TIDFLOW_DIS 0x0800
+#define HFI2_RCVCTRL_ONE_PKT_EGR_ENB 0x1000
+#define HFI2_RCVCTRL_ONE_PKT_EGR_DIS 0x2000
+#define HFI2_RCVCTRL_NO_RHQ_DROP_ENB 0x4000
+#define HFI2_RCVCTRL_NO_RHQ_DROP_DIS 0x8000
+#define HFI2_RCVCTRL_NO_EGR_DROP_ENB 0x10000
+#define HFI2_RCVCTRL_NO_EGR_DROP_DIS 0x20000
+#define HFI2_RCVCTRL_URGENT_ENB 0x40000
+#define HFI2_RCVCTRL_URGENT_DIS 0x80000
+#define HFI2_RCVCTRL_TID_CONFIG 0x100000
+
+/* partition enforcement flags */
+#define HFI2_PART_ENFORCE_IN	0x1
+#define HFI2_PART_ENFORCE_OUT	0x2
+
+/* how often we check for synthetic counter wrap around */
+#define SYNTH_CNT_TIME 3
+
+/* Counter flags */
+#define CNTR_NORMAL		0x0 /* Normal counters, just read register */
+#define CNTR_SYNTH		0x1 /* Synthetic counters, saturate at all 1s */
+#define CNTR_DISABLED		0x2 /* Disable this counter */
+#define CNTR_32BIT		0x4 /* Simulate 64 bits for this counter */
+#define CNTR_VL			0x8 /* Per VL counter */
+#define CNTR_SDMA              0x10
+#define CNTR_OVF	       0x20 /* per receive context overflow */
+#define CNTR_INVALID_VL		-1  /* Specifies invalid VL */
+#define CNTR_MODE_W		0x0
+#define CNTR_MODE_R		0x1
+
+/* VLs Supported/Operational */
+#define HFI2_MIN_VLS_SUPPORTED 1
+#define HFI2_MAX_VLS_SUPPORTED 8
+
+#define HFI2_GUIDS_PER_PORT  5
+#define HFI2_PORT_GUID_INDEX 0
+
+static inline void incr_cntr64(u64 *cntr)
+{
+	if (*cntr < (u64)-1LL)
+		(*cntr)++;
+}
+
+#define MAX_NAME_SIZE 64
+struct hfi2_msix_entry {
+	enum irq_type type;
+	int irq;
+	void *arg;
+	cpumask_t mask;
+	struct irq_affinity_notify notify;
+};
+
+struct hfi2_msix_info {
+	/* lock to synchronize in_use_msix access */
+	spinlock_t msix_lock;
+	DECLARE_BITMAP(in_use_msix, CCE_NUM_MSIX_VECTORS);
+	struct hfi2_msix_entry *msix_entries;
+	u16 max_requested;
+};
+
+/* per-SL CCA information */
+struct cca_timer {
+	struct hrtimer hrtimer;
+	struct hfi2_pportdata *ppd; /* read-only */
+	int sl; /* read-only */
+	u16 ccti; /* read/write - current value of CCTI */
+};
+
+struct link_down_reason {
+	/*
+	 * SMA-facing value.  Should be set from .latest when
+	 * HLS_UP_* -> HLS_DN_* transition actually occurs.
+	 */
+	u8 sma;
+	u8 latest;
+};
+
+enum {
+	LO_PRIO_TABLE,
+	HI_PRIO_TABLE,
+	MAX_PRIO_TABLE
+};
+
+struct vl_arb_cache {
+	/* protect vl arb cache */
+	spinlock_t lock;
+	struct ib_vl_weight_elem table[VL_ARB_TABLE_SIZE];
+};
+
+struct per_vl_data {
+	u16 mtu;
+	struct send_context *sc;
+};
+
+/* 16 to directly index */
+#define PER_VL_SEND_CONTEXTS 16
+
+/* maximum pkey table size */
+#define MAX_PKEY_VALUES 1024
+
+/*
+ * The structure below encapsulates data relevant to a physical IB Port.
+ * Current chips support only one such port, but the separation
+ * clarifies things a bit. Note that to conform to IB conventions,
+ * port-numbers are one-based. The first or only port is port1.
+ */
+struct hfi2_pportdata {
+	struct hfi2_ibport ibport_data;
+
+	struct hfi2_devdata *dd;
+
+	/* PHY support */
+	struct qsfp_data qsfp_info;
+	/* Values for SI tuning of SerDes */
+	u32 port_type;
+	u32 tx_preset_eq;
+	u32 tx_preset_noeq;
+	u32 rx_preset;
+	u8  local_atten;
+	u8  remote_atten;
+	u8  default_atten;
+	u8  max_power_class;
+
+	/* did we read platform config from scratch registers? */
+	bool config_from_scratch;
+
+	/* GUIDs for this interface, in host order, guids[0] is a port guid */
+	u64 guids[HFI2_GUIDS_PER_PORT];
+
+	/* GUID for peer interface, in host order */
+	u64 neighbor_guid;
+
+	/* Per VL data. Enough for all VLs but not all elements are set/used. */
+	struct per_vl_data vld[PER_VL_SEND_CONTEXTS];
+
+	/* up or down physical link state */
+	u32 linkup;
+
+	/*
+	 * this address is mapped read-only into user processes so they can
+	 * get status cheaply, whenever they want.  One qword of status per port
+	 */
+	u64 *statusp;
+
+	/* seqlock for sc2vl */
+	seqlock_t sc2vl_lock ____cacheline_aligned_in_smp;
+	u64 sc2vl[4];
+	/* adding a new field here would make it part of this cacheline */
+
+	/* SendDMA related entries */
+	/* array of vl maps */
+	struct sdma_vl_map __rcu *sdma_map;
+
+	struct workqueue_struct *link_wq;
+
+	/* move out of interrupt context */
+	struct work_struct link_vc_work;
+	struct work_struct link_up_work;
+	struct work_struct link_down_work;
+	struct work_struct sma_message_work;
+	struct work_struct link_downgrade_work;
+	struct work_struct link_bounce_work;
+	struct delayed_work start_link_work;
+	/* host link state variables */
+	struct mutex hls_lock;
+	u32 host_link_state;
+
+	/* these are the "32 bit" regs */
+
+	u32 ibmtu; /* The MTU programmed for this unit */
+	/*
+	 * Current max size IB packet (in bytes) including IB headers, that
+	 * we can send. Changes when ibmtu changes.
+	 */
+	u32 ibmaxlen;
+	u32 current_egress_rate; /* units [10^6 bits/sec] */
+	/* LID programmed for this instance */
+	u32 lid;
+	/* list of pkeys programmed; 0 if not set */
+	u16 pkeys[MAX_PKEY_VALUES];
+	u16 link_width_supported;
+	u16 link_width_downgrade_supported;
+	u16 link_speed_supported;
+	u16 link_width_enabled;
+	u16 link_width_downgrade_enabled;
+	u16 link_speed_enabled;
+	u16 link_width_active;
+	u16 link_width_downgrade_tx_active;
+	u16 link_width_downgrade_rx_active;
+	u16 link_speed_active;
+	u16 link_ltp_rtt;
+	u8 vls_supported;
+	u8 vls_operational;
+	u8 actual_vls_operational;
+	/* LID mask control */
+	u8 lmc;
+	/* Rx Polarity inversion (compensate for ~tx on partner) */
+	u8 rx_pol_inv;
+	/* QOS shift: number of QPN bottom bits set to zero by rdmavt */
+	u8 qos_shift;
+
+	u8 hw_pidx;     /* physical port index */
+	u32 port;        /* IB port number and index into dd->pports - 1 */
+	/* type of neighbor node */
+	u8 neighbor_type;
+	u8 neighbor_normal;
+	u8 neighbor_fm_security; /* 1 if firmware checking is disabled */
+	u8 neighbor_port_number;
+	u8 is_sm_config_started;
+	u8 offline_disabled_reason;
+	u8 is_active_optimize_enabled;
+	u8 driver_link_ready;	/* driver ready for active link */
+	u8 link_enabled;	/* link enabled? */
+	u8 linkinit_reason;
+	u8 local_tx_rate;	/* rate given to 8051 firmware */
+	u8 qsfp_retry_count;
+
+	/* placeholders for IB MAD packet settings */
+	u8 overrun_threshold;
+	u8 phy_error_threshold;
+	unsigned int is_link_down_queued;
+
+	/* Used to override LED behavior for things like maintenance beaconing*/
+	/*
+	 * Alternates per phase of blink
+	 * [0] holds LED off duration, [1] holds LED on duration
+	 */
+	unsigned long led_override_vals[2];
+	u8 led_override_phase; /* LSB picks from vals[] */
+	atomic_t led_override_timer_active;
+	/* Used to flash LEDs in override mode */
+	struct timer_list led_override_timer;
+
+	/* array of kernel send contexts */
+	struct send_context **kernel_send_context;
+	/* array of vl maps */
+	struct pio_vl_map __rcu *pio_map;
+	/* starting receive context for this port */
+	u16 rcv_context_base;
+	/* number of receive contexts in use for this port */
+	u16 num_rcv_contexts;
+	/* number of available user/netdev contexts for this port */
+	u16 num_user_contexts;
+	/* Lowest context number which can be used by user processes */
+	u16 first_dyn_alloc_ctxt;
+	/* number of kernel recieve queues (includes control context) */
+	u16 n_krcv_queues;
+	/* number of reserved contexts for netdev usage */
+	u16 num_netdev_contexts;
+	/* current number of receive user ctxts available for this port */
+	u32 freectxts;
+	/* starting RcvArray entry for this port */
+	u32 rcv_array_base;
+
+	u32 sm_trap_qp;
+	u32 sa_qp;
+
+	/*
+	 * cca_timer_lock protects access to the per-SL cca_timer
+	 * structures (specifically the ccti member).
+	 */
+	spinlock_t cca_timer_lock ____cacheline_aligned_in_smp;
+	struct cca_timer cca_timer[OPA_MAX_SLS];
+
+	/* List of congestion control table entries */
+	struct ib_cc_table_entry_shadow ccti_entries[CC_TABLE_SHADOW_MAX];
+
+	/* congestion entries, each entry corresponding to a SL */
+	struct opa_congestion_setting_entry_shadow
+		congestion_entries[OPA_MAX_SLS];
+
+	/*
+	 * cc_state_lock protects (write) access to the per-port
+	 * struct cc_state.
+	 */
+	spinlock_t cc_state_lock ____cacheline_aligned_in_smp;
+
+	struct cc_state __rcu *cc_state;
+
+	/* Total number of congestion control table entries */
+	u16 total_cct_entry;
+
+	/* Bit map identifying service level */
+	u32 cc_sl_control_map;
+
+	/* CA's max number of 64 entry units in the congestion control table */
+	u8 cc_max_table_entries;
+
+	/*
+	 * begin congestion log related entries
+	 * cc_log_lock protects all congestion log related data
+	 */
+	spinlock_t cc_log_lock ____cacheline_aligned_in_smp;
+	u8 threshold_cong_event_map[OPA_MAX_SLS / 8];
+	u16 threshold_event_counter;
+	struct opa_hfi2_cong_log_event_internal cc_events[OPA_CONG_LOG_ELEMS];
+	int cc_log_idx; /* index for logging events */
+	int cc_mad_idx; /* index for reporting events */
+	/* end congestion log related entries */
+
+	struct vl_arb_cache vl_arb_cache[MAX_PRIO_TABLE];
+
+	/* port relative counter buffer */
+	u64 *cntrs;
+	/* port relative synthetic counter buffer */
+	u64 *scntrs;
+	/* RcvCounterArray32.RcvBufOvflCount saved current value */
+	u32 rcv_ovfl_cnt;
+	/* port_xmit_discards are synthesized from different egress errors */
+	u64 port_xmit_discards;
+	u64 port_xmit_discards_vl[C_VL_COUNT];
+	u64 port_xmit_constraint_errors;
+	u64 port_rcv_constraint_errors;
+	/* count of 'link_err' interrupts from DC */
+	u64 link_downed;
+	/* number of times link retrained successfully */
+	u64 link_up;
+	/* number of times a link unknown frame was reported */
+	u64 unknown_frame_count;
+	/* port_ltp_crc_mode is returned in 'portinfo' MADs */
+	u16 port_ltp_crc_mode;
+	/* port_crc_mode_enabled is the crc we support */
+	u8 port_crc_mode_enabled;
+	/* mgmt_allowed is also returned in 'portinfo' MADs */
+	u8 mgmt_allowed;
+	u8 part_enforce; /* partition enforcement flags */
+	struct link_down_reason local_link_down_reason;
+	struct link_down_reason neigh_link_down_reason;
+	/* Value to be sent to link peer on LinkDown .*/
+	u8 remote_link_down_reason;
+	/* Error events that will cause a port bounce. */
+	u32 port_error_action;
+	struct work_struct linkstate_active_work;
+	/* Does this port need to prescan for FECNs */
+	bool cc_prescan;
+	/*
+	 * Sample sendWaitCnt & sendWaitVlCnt during link transition
+	 * and counter request.
+	 */
+	u64 port_vl_xmit_wait_last[C_VL_COUNT + 1];
+	u16 prev_link_width;
+	u64 vl_xmit_flit_cnt[C_VL_COUNT + 1];
+	/* per-port networking */
+	struct hfi2_netdev_rx *netdev_rx;
+	int netdev_rsm_rule;
+	atomic_t ipoib_rsm_usr_num;
+};
+
+typedef void (*opcode_handler)(struct hfi2_packet *packet);
+typedef void (*hfi2_make_req)(struct rvt_qp *qp,
+			      struct hfi2_pkt_state *ps,
+			      struct rvt_swqe *wqe);
+extern const rhf_rcv_function_ptr normal_rhf_rcv_functions[];
+extern const rhf_rcv_function_ptr netdev_rhf_rcv_functions[];
+
+/* return values for the RHF receive functions */
+#define RHF_RCV_CONTINUE  0	/* keep going */
+#define RHF_RCV_DONE	  1	/* stop, this packet processed */
+#define RHF_RCV_REPROCESS 2	/* stop. retain this packet */
+
+struct rcv_array_data {
+	u32 ngroups;
+	u8 group_size;
+};
+
+struct err_info_rcvport {
+	u8 status_and_code;
+	u64 packet_flit1;
+	u64 packet_flit2;
+};
+
+struct err_info_constraint {
+	u8 status;
+	u16 pkey;
+	u32 slid;
+};
+
+struct hfi2_temp {
+	unsigned int curr;       /* current temperature */
+	unsigned int lo_lim;     /* low temperature limit */
+	unsigned int hi_lim;     /* high temperature limit */
+	unsigned int crit_lim;   /* critical temperature limit */
+	u8 triggers;      /* temperature triggers */
+};
+
+struct hfi2_i2c_bus {
+	struct hfi2_devdata *controlling_dd; /* current controlling device */
+	struct i2c_adapter adapter;	/* bus details */
+	struct i2c_algo_bit_data algo;	/* bus algorithm details */
+	int num;			/* bus number, 0 or 1 */
+};
+
+/* common data between shared ASICs */
+struct hfi2_asic_data {
+	struct hfi2_devdata *dds[2];	/* back pointers */
+	struct mutex asic_resource_mutex;
+	struct hfi2_i2c_bus *i2c_bus0;
+	struct hfi2_i2c_bus *i2c_bus1;
+};
+
+/* sizes for both the QP and RSM map tables */
+#define NUM_MAP_ENTRIES	 256
+#define NUM_MAP_REGS      32
+
+/* device data struct now contains only "general per-device" info.
+ * fields related to a physical IB port are in a hfi2_pportdata struct.
+ */
+struct sdma_engine;
+struct sdma_vl_map;
+
+#define BOARD_VERS_MAX 96 /* how long the version string can be */
+#define SERIAL_MAX 16 /* length of the serial number */
+
+/* chip implementation values */
+enum {
+	CHIP_NONE,
+	CHIP_WFR,	/* Intel OPA 100 */
+	CHIP_JKR,	/* CN 5000 */
+};
+
+/* must be >= than all param->num_ports values */
+#define LARGEST_NUM_PORTS 2
+
+/* must be >= than all param->num_int_csrs values */
+#define LARGEST_NUM_INT_CSRS 21
+
+/* max number of contexts on any device */
+#define MAX_CTXTS 256
+/* max number of RSM rules on any device */
+#define MAX_RSM_RULES 64
+
+/* chip specific values */
+struct chip_params {
+	int chip_type;
+	int num_ports;
+	u32 bar0_size;
+	u32 kreg1_size;
+	u32 kreg2_offset;
+	u32 kreg2_size;
+	u32 rcv_array_offset;
+	u32 rcv_array_size;
+	u32 link_speed_supported;
+	u32 link_speed_active;
+	u32 asic_cclock_ps;
+	u32 rsm_rule_size;
+	u32 pkey_table_size;
+	const char *generic_boardname;
+	u32 max_eager_entries;
+	u8 pio_base_bits; /* SendCtxtCtrl.CtxtBase bit count */
+	const struct flag_data *egress_err_info_data;
+	u64 send_ctrl_flush; /* set-once flush flag */
+	u64 port_discard_egress_errs;
+
+	/* interrupt sources */
+	u32 num_int_csrs;
+	u32 num_int_map_csrs;
+	u32 is_rcvavail_start;
+	u32 is_rcvurgent_start;
+	u32 is_sdmaeng_err_start;
+	u32 is_sdma_idle_start;
+	u32 is_sdma_progress_start;
+	u32 is_sdma_start;
+	u32 is_last_source;
+	const struct is_table *is_table;
+	const struct gi_enable_entry *gi_enable_table;
+
+	/* counters */
+	struct cntr_entry *chip_dev_cntrs;
+	u32 chip_dev_cntr_first;
+	u32 chip_num_dev_cntrs;
+	struct cntr_entry *chip_port_cntrs;
+	u32 chip_port_cntr_first;
+	u32 chip_num_port_cntrs;
+
+	/* ingress port registers */
+	u32 rxe_iport_stride;
+	u32 rcv_iport_ctrl_reg;
+	u32 rcv_iport_status_reg;
+	u32 rcv_bth_qp_reg;
+	u32 rcv_multicast_reg;
+	u32 rcv_bypass_reg;
+	u32 rcv_vl15_reg;
+	u32 rcv_err_info_reg;
+	u32 rcv_err_status_reg;
+	u32 rcv_err_mask_reg;
+	u32 rcv_err_clear_reg;
+	u32 rcv_qp_map_table_reg;
+	u32 rcv_partition_key_reg;
+	u32 rcv_counter_array32_reg;
+	u32 rcv_counter_array64_reg;
+
+	/* ingress port receive context registers */
+	u32 rxe_iprc_stride;
+	u32 rcv_jkey_ctrl_reg;
+
+	/* RXE restricted context registers */
+	u32 rxe_rctxt_stride;
+	u32 rcv_rctxt_ctrl_reg;
+	u32 rcv_egr_ctrl_reg;
+	u32 rcv_tid_ctrl_reg;
+
+	/* RXE kernel context registers */
+	u32 rxe_kctxt_stride;
+	u32 rcv_kctxt_ctrl_reg;
+	u32 rcv_hdr_addr_reg;
+	u32 rcv_hdr_cnt_reg;
+	u32 rcv_hdr_ent_size_reg;
+	u32 rcv_hdr_tail_addr_reg;
+	u32 rcv_avail_time_out_reg;
+	u32 rcv_hdr_ovfl_cnt_reg;
+
+	/* RXE kernel/user registers */
+	u32 rxe_ku_stride;
+	u32 rcv_ctxt_status_reg;
+
+	/* RXE user registers */
+	u32 rxe_uctxt_stride;
+	u32 rcv_hdr_tail_reg;
+	u32 rcv_hdr_head_reg;
+	u32 rcv_egr_index_head_reg;
+	u32 rcv_tid_flow_table_reg;
+
+	/* TXE kernel registers */
+	u32 send_contexts_reg;
+	u32 send_dma_engines_reg;
+	u32 send_pio_mem_size_reg;
+	u32 send_dma_mem_size_reg;
+	u32 send_pio_init_ctxt_reg;
+
+	/* send context registers */
+	u32 txe_sctxt_stride;
+	u32 send_ctxt_status_reg;
+	u32 send_ctxt_credit_ctrl_reg;
+	u32 send_ctxt_credit_status_reg;
+	u32 send_ctxt_credit_return_addr_reg;
+	u32 send_ctxt_credit_force_reg;
+	u32 send_ctxt_err_status_reg;
+	u32 send_ctxt_err_mask_reg;
+	u32 send_ctxt_err_clear_reg;
+
+	/* TXE send context registers */
+	u32 txe_tctxt_stride;
+	u32 send_ctxt_ctrl_reg;
+
+	/* SDMA registers */
+	u32 txe_sdma_stride;
+	u32 send_dma_ctrl_reg;
+	u32 send_dma_status_reg;
+	u32 send_dma_base_addr_reg;
+	u32 send_dma_len_gen_reg;
+	u32 send_dma_tail_reg;
+	u32 send_dma_head_reg;
+	u32 send_dma_head_addr_reg;
+	u32 send_dma_priority_thld_reg;
+	u32 send_dma_idle_cnt_reg;
+	u32 send_dma_reload_cnt_reg;
+	u32 send_dma_desc_cnt_reg;
+	u32 send_dma_desc_fetched_cnt_reg;
+	u32 send_dma_eng_err_status_reg;
+	u32 send_dma_eng_err_mask_reg;
+	u32 send_dma_eng_err_clear_reg;
+
+	/* SDMA Config registers */
+	u32 txe_sdmacfg_stride;
+	u32 send_dma_cfg_memory_reg;
+
+	/* egress port registers */
+	u32 txe_eport_stride;
+	u32 send_ctrl_reg;
+	u32 send_high_priority_limit_reg;
+	u32 send_egress_err_status_reg;
+	u32 send_egress_err_mask_reg;
+	u32 send_egress_err_clear_reg;
+	u32 send_bth_qp_reg;
+	u32 send_static_rate_control_reg;
+	u32 send_sc2vlt0_reg;
+	u32 send_sc2vlt1_reg;
+	u32 send_sc2vlt2_reg;
+	u32 send_sc2vlt3_reg;
+	u32 send_len_check0_reg;
+	u32 send_len_check1_reg;
+	u32 send_low_priority_list_reg;
+	u32 send_high_priority_list_reg;
+	u32 send_counter_array32_reg;
+	u32 send_counter_array64_reg;
+	u32 send_cm_ctrl_reg;
+	u32 send_cm_global_credit_reg;
+	u32 send_cm_credit_used_status_reg;
+	u32 send_cm_timer_ctrl_reg;
+	u32 send_cm_local_au_table0_to3_reg;
+	u32 send_cm_local_au_table4_to7_reg;
+	u32 send_cm_remote_au_table0_to3_reg;
+	u32 send_cm_remote_au_table4_to7_reg;
+	u32 send_cm_credit_vl_reg;
+	u32 send_cm_credit_vl15_reg;
+	u32 send_egress_err_info_reg;
+	u32 send_egress_err_source_reg;
+	u32 send_egress_ctxt_status_reg;
+	u32 send_egress_send_dma_status_reg;
+
+	/* egress port send context registers */
+	u32 txe_epsc_stride;
+	u32 send_ctxt_check_enable_reg;
+	u32 send_ctxt_check_vl_reg;
+	u32 send_ctxt_check_job_key_reg;
+	u32 send_ctxt_check_partition_key_reg;
+	u32 send_ctxt_check_slid_reg;
+	u32 send_ctxt_check_opcode_reg;
+
+	/* SI registers */
+	u32 cce_msix_int_map_vec_reg;
+	u32 send_pio_err_status_reg;
+	u32 send_pio_err_mask_reg;
+	u32 send_pio_err_clear_reg;
+	u32 send_dma_err_status_reg;
+	u32 send_dma_err_mask_reg;
+	u32 send_dma_err_clear_reg;
+	u32 csr_err_status_reg;
+	u32 csr_err_mask_reg;
+	u32 csr_err_clear_reg;
+
+	void (*setextled)(struct hfi2_pportdata *ppd, u32 on);
+	void (*start_led_override)(struct hfi2_pportdata *ppd,
+				   unsigned int timeon,
+				   unsigned int timeoff);
+	void (*shutdown_led_override)(struct hfi2_pportdata *ppd);
+	void (*read_guid)(struct hfi2_devdata *dd);
+	int (*early_per_chip_init)(struct hfi2_devdata *dd);
+	int (*mid_per_chip_init)(struct hfi2_devdata *dd);
+	void (*init_other)(struct hfi2_devdata *dd);
+	int (*late_per_chip_init)(struct hfi2_devdata *dd);
+	void (*start_port)(struct hfi2_pportdata *ppd);
+	void (*stop_port)(struct hfi2_pportdata *ppd);
+	void (*init_tids)(struct hfi2_devdata *dd);
+	void (*put_tid)(struct hfi2_ctxtdata *rcd, u32 index,
+			u32 type, unsigned long pa, u16 order, bool flush);
+	void (*rcv_array_wc_fill)(struct hfi2_ctxtdata *rcd, u32 index,
+				  u32 type);
+	void (*set_port_tid_count)(struct hfi2_ctxtdata *rcd);
+	void (*set_port_max_mtu)(struct hfi2_pportdata *ppd, u32 maxvlmtu);
+	void (*update_rcv_hdr_size)(struct hfi2_pportdata *ppd, u16 ctxt,
+				    u32 size);
+	bool (*check_synth_status)(struct hfi2_devdata *dd);
+	void (*update_synth_status)(struct hfi2_devdata *dd);
+	u64 (*create_pbc)(struct hfi2_pportdata *ppd, u64 flags, int srate_mbs,
+			  u32 vl, u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
+	void (*set_pio_integrity)(struct send_context *sc, enum spi_cmds cmd);
+	int (*find_used_resources)(struct hfi2_devdata *dd);
+	void (*read_link_quality)(struct hfi2_pportdata *ppd, u8 *link_quality);
+	void (*set_rheq_addr)(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr);
+	void (*handle_link_bounce)(struct work_struct *work);
+	void (*enable_rcv_context)(struct hfi2_pportdata *ppd, u16 ctxt,
+				   u64 *kctxt_ctrl, bool enable);
+};
+
+/* synthetic counter data */
+struct wfr_synth_data {
+	u64 last_tx;
+	u64 last_rx;
+};
+
+union synth_data {
+	struct wfr_synth_data wfr;
+};
+
+/* Port State Change (TRAP128) data used exclusivly by that code */
+struct hfi2_psc {
+	struct work_struct work;	/* port-state-change TRAP handler */
+	struct semaphore wait;		/* serialization of port-state-change processing */
+	atomic_t nq;			/* number of outstanding TRAP128 svc reqs */
+};
+
+/* CPORT items, separate from hfi2_devdata */
+struct hfi2_cport {
+	struct hfi2_devdata *dd;
+	struct cport_options opts;
+	struct cport_trap_status traps;
+	struct semaphore outbox;	/* PF0->CPORT outbox contention avoidance */
+	struct xarray tid_xa;		/* maps req msg to u32 tid */
+	u32 tid_next;			/* for xa_alloc_cyclic() */
+	struct work_struct mctxt_work;	/* first step of MCTXT recv */
+	atomic_t seqno;			/* sequence number for sends */
+	unsigned int rseqno;		/* sequence number for recvs */
+#ifdef CONFIG_HFI2_CPORT_POLLING
+	struct task_struct *poll_th;
+#endif
+	atomic_t nping;			/* CPORT ping counter */
+	struct task_struct *ping_th;	/* kthread currently running ping */
+	struct xarray trap_xa;		/* handlers for MCTXT TRAPs */
+	struct hfi2_psc psc;		/* used only by TRAP128 */
+	cport_handler handlers[256];
+};
+
+typedef int (*send_routine)(struct rvt_qp *, struct hfi2_pkt_state *, u64);
+struct hfi2_netdev_rx;
+struct hfi2_devdata {
+	struct hfi2_ibdev verbs_dev;     /* must be first */
+	/* pointers to related structs for this device */
+	/* pci access data structure */
+	struct pci_dev *pcidev;
+	struct cdev user_cdev;
+	struct cdev diag_cdev;
+	struct cdev ui_cdev;
+	struct device *user_device;
+	struct device *diag_device;
+	struct device *ui_device;
+	const struct chip_params *params;
+	struct hfi2_cport *cport;
+	struct workqueue_struct *hfi2_wq;
+
+	/* first mapping up to RcvArray */
+	u8 __iomem *kregbase1;
+	resource_size_t physaddr;
+
+	/* second uncached mapping from RcvArray to pio send buffers */
+	u8 __iomem *kregbase2;
+	/* for detecting offset above kregbase2 address */
+	u32 base2_start;
+
+	/* send context data */
+	struct send_context_info *send_contexts;
+	/* map hardware send contexts to software index */
+	u16 *hw_to_sw;
+	/* spinlock for allocating and releasing send context resources */
+	spinlock_t sc_lock;
+	/* lock for pio_map */
+	spinlock_t pio_map_lock;
+	/* Send Context initialization lock. */
+	spinlock_t sc_init_lock;
+	/* lock for sdma_map */
+	spinlock_t                          sde_map_lock;
+	/* default flags to last descriptor */
+	u64 default_desc1;
+
+	/* fields common to all SDMA engines */
+
+	volatile __le64                    *sdma_heads_dma; /* DMA'ed by chip */
+	dma_addr_t                          sdma_heads_phys;
+	void                               *sdma_pad_dma; /* DMA'ed by chip */
+	dma_addr_t                          sdma_pad_phys;
+	/* for deallocation */
+	size_t                              sdma_heads_size;
+	/* num used */
+	u32                                 num_sdma;
+	/* array of engines sized by num_sdma */
+	struct sdma_engine                 *per_sdma;
+	/* SPC freeze waitqueue and variable */
+	wait_queue_head_t		  sdma_unfreeze_wq;
+	atomic_t			  sdma_unfreeze_count;
+	atomic_t			  sdma_print_tag;
+
+	u32 lcb_access_count;		/* count of LCB users */
+
+	/* common data between shared ASICs in this OS */
+	struct hfi2_asic_data *asic_data;
+
+	/* mem-mapped pointer to base of PIO buffers */
+	void __iomem *piobase;
+	/*
+	 * write-combining mem-mapped pointer to base of RcvArray
+	 * memory.
+	 */
+	void __iomem *rcvarray_wc;
+	/*
+	 * credit return base - a per-NUMA range of DMA address that
+	 * the chip will use to update the per-context free counter
+	 */
+	struct credit_return_base *cr_base;
+
+	/* send context numbers and sizes for each type */
+	struct sc_config_sizes sc_sizes[SC_MAX];
+
+	char *boardname; /* human readable board info */
+
+	u64 ctx0_seq_drop;
+
+	/* reset value */
+	u64 z_int_counter;
+	u64 z_rcv_limit;
+	u64 z_send_schedule;
+
+	u64 __percpu *send_schedule;
+	/* number of pio send contexts in use by the driver */
+	u32 num_send_contexts;
+	/* first RcvArray entroy to use */
+	u32 first_rcvarray_entry;
+	/* first PIO block to use */
+	u32 first_pio_block;
+	/* first receive context to use */
+	u16 first_rcv_context;
+	/* first send send context to use */
+	u16 first_send_context;
+	/* first available RSM rule */
+	u8 first_rsm_rule;
+	/* RSM rules are initialized (first_rsm_rule is valid) */
+	bool rsm_rule_init;
+
+	/* base receive interrupt timeout, in CSR units */
+	u32 rcv_intr_timeout_csr;
+
+	spinlock_t sendctrl_lock; /* protect changes to SendCtrl */
+	spinlock_t rcvctrl_lock; /* protect changes to RcvCtrl */
+	spinlock_t uctxt_lock; /* protect rcd changes */
+	struct mutex dc8051_lock; /* exclusive access to 8051 */
+	struct workqueue_struct *update_cntr_wq;
+	struct work_struct update_cntr_work;
+	struct work_struct rcverr_work;
+	struct work_struct freeze_work;
+	/* exclusive access to 8051 memory */
+	spinlock_t dc8051_memlock;
+	int dc8051_timed_out;	/* remember if the 8051 timed out */
+	/*
+	 * A page that will hold event notification bitmaps for all
+	 * contexts. This page will be mapped into all processes.
+	 */
+	unsigned long *events;
+	/*
+	 * per unit status, see also portdata statusp
+	 * mapped read-only into user processes so they can get unit and
+	 * IB link status cheaply
+	 */
+	struct hfi2_status *status;
+
+	/* revision register shadow */
+	u64 revision;
+	/* Base GUID for device (network order) */
+	u64 base_guid;
+
+	/* both sides of the PCIe link are gen3 capable */
+	u8 link_gen3_capable;
+	u8 dc_shutdown;
+	/* localbus width (1, 2,4,8,16,32) from config space  */
+	u32 lbus_width;
+	/* localbus speed in MHz */
+	u32 lbus_speed;
+	int unit; /* unit # of this chip */
+	int node; /* home node of this chip */
+
+	/* save these PCI fields to restore after a reset */
+	u32 pcibar0;
+	u32 pcibar1;
+	u32 pci_rom;
+	u16 pci_command;
+	u16 pcie_devctl;
+	u16 pcie_lnkctl;
+	u16 pcie_devctl2;
+	u32 pci_msix0;
+	u32 pci_tph2;
+
+	/*
+	 * ASCII serial number, from flash, large enough for original
+	 * all digit strings, and longer serial number format
+	 */
+	u8 serial[SERIAL_MAX];
+	/* human readable board version */
+	u8 boardversion[BOARD_VERS_MAX];
+	u8 lbus_info[32]; /* human readable localbus info */
+	/* chip major rev, from CceRevision */
+	u8 majrev;
+	/* chip minor rev, from CceRevision */
+	u8 minrev;
+	/* hardware ID */
+	u8 hfi2_id;
+	/* implementation code */
+	u8 icode;
+	/* vAU of this device */
+	u8 vau;
+	/* vCU of this device */
+	u8 vcu;
+	/* link credits of this device */
+	u16 link_credits;
+	/* initial vl15 credits to use */
+	u16 vl15_init;
+
+	/*
+	 * Cached value for vl15buf, read during verify cap interrupt. VL15
+	 * credits are to be kept at 0 and set when handling the link-up
+	 * interrupt. This removes the possibility of receiving VL15 MAD
+	 * packets before this device is ready.
+	 */
+	u16 vl15buf_cached;
+
+	/* Misc small ints */
+
+	u16 irev;	/* implementation revision */
+	u32 dc8051_ver; /* 8051 firmware version */
+
+	spinlock_t hfi2_diag_trans_lock; /* protect diag observer ops */
+	struct platform_config platform_config;
+	struct platform_config_cache pcfg_cache;
+
+	struct diag_client *diag_client;
+
+	/* general interrupt masks */
+	struct {
+		u64 remap;	  /* remaped away */
+		u64 cce_int_mask; /* cache of csr */
+	} gi_mask[LARGEST_NUM_INT_CSRS];
+
+	struct rcv_array_data rcv_entries;
+
+	/* cycle length of PS* counters in HW (in picoseconds) */
+	u16 psxmitwait_check_rate;
+
+	/*
+	 * 64 bit synthetic counters
+	 */
+	struct timer_list synth_stats_timer;
+
+	/* MSI-X information */
+	struct hfi2_msix_info msix_info;
+
+	/*
+	 * device counters
+	 */
+	char *cntrnames;
+	size_t cntrnameslen;
+	size_t ndevcntrs;
+	u64 *cntrs;
+	u64 *scntrs;
+
+	/* remembered values for synthetic counters */
+	union synth_data synth_data;
+
+	/*
+	 * per-port counters
+	 */
+	size_t nportcntrs;
+	char *portcntrnames;
+	size_t portcntrnameslen;
+
+	struct hfi2_snoop_data hfi2_snoop;
+
+	/* overflow header counter support */
+	DECLARE_BITMAP(ovf_disabled, MAX_CTXTS);
+	u8 ovf_offset[MAX_CTXTS];
+
+	struct err_info_rcvport err_info_rcvport;
+	struct err_info_constraint err_info_rcv_constraint;
+	struct err_info_constraint err_info_xmit_constraint;
+
+	atomic_t drop_packet;
+	bool do_drop;
+	u8 err_info_uncorrectable;
+	u8 err_info_fmconfig;
+
+	/*
+	 * Software counters for the status bits defined by the
+	 * associated error status registers
+	 */
+	u64 cce_err_status_cnt[NUM_CCE_ERR_STATUS_COUNTERS];
+	u64 rcv_err_status_cnt[NUM_RCV_ERR_STATUS_COUNTERS];
+	u64 misc_err_status_cnt[NUM_MISC_ERR_STATUS_COUNTERS];
+	u64 send_pio_err_status_cnt[NUM_SEND_PIO_ERR_STATUS_COUNTERS];
+	u64 send_dma_err_status_cnt[NUM_SEND_DMA_ERR_STATUS_COUNTERS];
+	u64 send_egress_err_status_cnt[NUM_SEND_EGRESS_ERR_STATUS_COUNTERS];
+	u64 send_err_status_cnt[NUM_SEND_ERR_STATUS_COUNTERS];
+
+	/* Software counter that spans all contexts */
+	u64 sw_ctxt_err_status_cnt[NUM_SEND_CTXT_ERR_STATUS_COUNTERS];
+	/* Software counter that spans all DMA engines */
+	u64 sw_send_dma_eng_err_status_cnt[
+		NUM_SEND_DMA_ENG_ERR_STATUS_COUNTERS];
+	/* Software counter that aggregates all cce_err_status errors */
+	u64 sw_cce_err_status_aggregate;
+	/* Software counter that aggregates all bypass packet rcv errors */
+	u64 sw_rcv_bypass_packet_errors;
+
+	/* Save the enabled LCB error bits */
+	u64 lcb_err_en;
+	struct cpu_mask_set *comp_vect;
+	int *comp_vect_mappings;
+	u32 comp_vect_possible_cpus;
+
+	/*
+	 * Capability to have different send engines simply by changing a
+	 * pointer value.
+	 */
+	send_routine process_pio_send ____cacheline_aligned_in_smp;
+	send_routine process_dma_send;
+	void (*pio_inline_send)(struct hfi2_devdata *dd, struct pio_buf *pbuf,
+				u64 pbc, const void *from, size_t count);
+	/* hfi2_pportdata, points to array of (physical) port-specific
+	 * data structs, indexed by pidx (0..n-1)
+	 */
+	struct hfi2_pportdata *pport;
+	/* receive context data */
+	struct hfi2_ctxtdata **rcd;
+	u64 __percpu *int_counter;
+	/* verbs tx opcode stats */
+	struct hfi2_opcode_stats_perctx __percpu *tx_opstats;
+	/* device (not port) flags, basically device capabilities */
+	u16 flags;
+	/* number of elements allocated in the rcd array */
+	u16 num_rcd;
+	/* Number of physical ports available */
+	u8 num_pports;
+	/* adding a new field here would make it part of this cacheline */
+
+	u64 __percpu *rcv_limit;
+
+	/* OUI comes from the HW. Used everywhere as 3 separate bytes. */
+	u8 oui1;
+	u8 oui2;
+	u8 oui3;
+
+	/* Timer and counter used to detect RcvBufOvflCnt changes */
+	struct timer_list rcverr_timer;
+
+	wait_queue_head_t event_queue;
+
+	/* receive context tail dummy address */
+	__le64 *rcvhdrtail_dummy_kvaddr;
+	dma_addr_t rcvhdrtail_dummy_dma;
+
+	/* Serialize ASPM enable/disable between multiple verbs contexts */
+	spinlock_t aspm_lock;
+	/* Number of verbs contexts which have disabled ASPM */
+	atomic_t aspm_disabled_cnt;
+	/* Keeps track of user space clients */
+	refcount_t user_refcount;
+	/* Used to wait for outstanding user space clients before dev removal */
+	struct completion user_comp;
+
+	bool eprom_available;	/* true if EPROM is available for this device */
+	bool aspm_supported;	/* Does HW support ASPM */
+	bool aspm_enabled;	/* ASPM state: enabled/disabled */
+	struct rhashtable *sdma_rht;
+
+	/* Lock to protect IRQ SRC register access */
+	spinlock_t irq_src_lock;
+	struct hfi2_affinity_node *affinity_entry;
+
+	/* Keeps track of IPoIB RSM rule users */
+	DECLARE_BITMAP(rsm_rule_bitmap, MAX_RSM_RULES);
+	/* per-device tuning */
+	int sdma_threshold;
+	int pad_sdma_desc;
+	int sdma_align;
+};
+
+/* 8051 firmware version helper */
+#define dc8051_ver(a, b, c) ((a) << 16 | (b) << 8 | (c))
+#define dc8051_ver_maj(a) (((a) & 0xff0000) >> 16)
+#define dc8051_ver_min(a) (((a) & 0x00ff00) >> 8)
+#define dc8051_ver_patch(a) ((a) & 0x0000ff)
+
+/* hfi2_put_tid types */
+#define PT_EXPECTED       0
+#define PT_EAGER          1
+
+struct tid_rb_node;
+
+/* Private data for file operations */
+struct hfi2_filedata {
+	struct srcu_struct pq_srcu;
+	struct hfi2_devdata *dd;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ctxtdata *uctxt;
+	struct hfi2_user_sdma_comp_q *cq;
+	/* update side lock for SRCU */
+	spinlock_t pq_rcu_lock;
+	struct hfi2_user_sdma_pkt_q __rcu *pq;
+	u16 subctxt;
+	/* for cpu affinity; -1 if none */
+	int rec_cpu_num;
+	/*
+	 * For TID memory implementations that must enforce RLIMIT_MEMLOCK.
+	 *
+	 * tid_n_pinned should only be used by TID memory implementations.
+	 */
+	u32 tid_n_pinned;
+	bool use_mn;
+	struct tid_rb_node **entry_to_rb;
+	spinlock_t tid_lock; /* protect tid_[limit,used] counters */
+	u32 tid_limit;
+	u32 tid_used;
+	u32 *invalid_tids;
+	u32 invalid_tid_idx;
+	/* protect invalid_tids array and invalid_tid_idx */
+	spinlock_t invalid_lock;
+};
+
+extern struct xarray hfi2_dev_table;
+struct hfi2_devdata *hfi2_lookup(int unit);
+int get_num_user_contexts(struct hfi2_devdata *dd, int pidx);
+
+static inline unsigned long uctxt_offset(struct hfi2_ctxtdata *uctxt)
+{
+	return uctxt->ctxt * HFI2_MAX_SHARED_CTXTS;
+}
+
+int hfi2_init(struct hfi2_devdata *dd, int reinit);
+extern unsigned int snoop_drop_send;
+extern unsigned int snoop_force_capture;
+int hfi2_count_active_units(void);
+
+int hfi2_diag_add(struct hfi2_devdata *dd);
+void hfi2_diag_remove(struct hfi2_devdata *dd);
+void handle_linkup_change(struct hfi2_pportdata *ppd, u32 linkup);
+void cport_handle_linkup_change(struct hfi2_pportdata *ppd,
+				struct opa_port_info *pi, u32 linkup);
+void go_port_active(struct hfi2_pportdata *ppd);
+
+void handle_user_interrupt(struct hfi2_ctxtdata *rcd);
+
+int start_cport(struct hfi2_devdata *dd);
+int hfi2_create_rcvhdrq(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd);
+int hfi2_setup_eagerbufs(struct hfi2_ctxtdata *rcd);
+int hfi2_create_kctxts(struct hfi2_devdata *dd);
+#define DYNAMIC_CONTEXT 0xffff /* dynamic context request */
+int hfi2_create_ctxtdata(struct hfi2_pportdata *ppd, int numa, u16 ctxt,
+			 struct hfi2_ctxtdata **rcd);
+void hfi2_free_ctxt(struct hfi2_ctxtdata *rcd);
+void hfi2_init_pportdata(struct pci_dev *pdev, struct hfi2_pportdata *ppd,
+			 struct hfi2_devdata *dd, u8 hw_pidx, u32 port);
+void hfi2_free_ctxtdata(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd);
+int hfi2_rcd_put(struct hfi2_ctxtdata *rcd);
+int hfi2_rcd_get(struct hfi2_ctxtdata *rcd);
+struct hfi2_ctxtdata *hfi2_rcd_get_by_index(struct hfi2_devdata *dd, u16 ctxt);
+int handle_receive_interrupt(struct hfi2_ctxtdata *rcd, int thread);
+int handle_receive_interrupt_nodma_rtail(struct hfi2_ctxtdata *rcd, int thread);
+int handle_receive_interrupt_dma_rtail(struct hfi2_ctxtdata *rcd, int thread);
+int handle_receive_interrupt_napi_fp(struct hfi2_ctxtdata *rcd, int budget);
+int handle_receive_interrupt_napi_sp(struct hfi2_ctxtdata *rcd, int budget);
+void set_all_slowpath(struct hfi2_pportdata *ppd);
+
+extern const struct pci_device_id hfi2_pci_tbl[];
+void hfi2_make_ud_req_9B(struct rvt_qp *qp,
+			 struct hfi2_pkt_state *ps,
+			 struct rvt_swqe *wqe);
+
+void hfi2_make_ud_req_16B(struct rvt_qp *qp,
+			  struct hfi2_pkt_state *ps,
+			  struct rvt_swqe *wqe);
+
+/* return true if the port is available for use */
+static inline bool port_available_ppd(struct hfi2_pportdata *ppd)
+{
+	/* check is only valid after set_up_context_variables() is called */
+	return ppd->n_krcv_queues != 0;
+}
+
+/* return true if the port index available for use */
+static inline bool port_available_pidx(struct hfi2_devdata *dd, int pidx)
+{
+	return port_available_ppd(&dd->pport[pidx]);
+}
+
+/* receive packet handler dispositions */
+#define RCV_PKT_OK      0x0 /* keep going */
+#define RCV_PKT_LIMIT   0x1 /* stop, hit limit, start thread */
+#define RCV_PKT_DONE    0x2 /* stop, no more packets detected */
+
+/**
+ * hfi2_rcd_head - add accessor for rcd head
+ * @rcd: the context
+ */
+static inline u32 hfi2_rcd_head(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->head;
+}
+
+/**
+ * hfi2_set_rcd_head - add accessor for rcd head
+ * @rcd: the context
+ * @head: the new head
+ */
+static inline void hfi2_set_rcd_head(struct hfi2_ctxtdata *rcd, u32 head)
+{
+	rcd->head = head;
+}
+
+/* calculate the current RHF address */
+static inline __le32 *get_rhf_addr(struct hfi2_ctxtdata *rcd)
+{
+	return (__le32 *)rcd->rcvhdrq + rcd->head + rcd->rhf_offset;
+}
+
+/* return DMA_RTAIL configuration */
+static inline bool get_dma_rtail_setting(struct hfi2_ctxtdata *rcd)
+{
+	return !!HFI2_CAP_KGET_MASK(rcd->flags, DMA_RTAIL);
+}
+
+/**
+ * hfi2_seq_incr_wrap - wrapping increment for sequence
+ * @seq: the current sequence number
+ *
+ * Returns: the incremented seq
+ */
+static inline u8 hfi2_seq_incr_wrap(u8 seq)
+{
+	if (++seq > RHF_MAX_SEQ)
+		seq = 1;
+	return seq;
+}
+
+/**
+ * hfi2_seq_cnt - return seq_cnt member
+ * @rcd: the receive context
+ *
+ * Return seq_cnt member
+ */
+static inline u8 hfi2_seq_cnt(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->seq_cnt;
+}
+
+/**
+ * hfi2_set_seq_cnt - return seq_cnt member
+ * @rcd: the receive context
+ *
+ * Return seq_cnt member
+ */
+static inline void hfi2_set_seq_cnt(struct hfi2_ctxtdata *rcd, u8 cnt)
+{
+	rcd->seq_cnt = cnt;
+}
+
+/**
+ * last_rcv_seq - is last
+ * @rcd: the receive context
+ * @seq: sequence
+ *
+ * return true if last packet
+ */
+static inline bool last_rcv_seq(struct hfi2_ctxtdata *rcd, u32 seq)
+{
+	return seq != rcd->seq_cnt;
+}
+
+/**
+ * rcd_seq_incr - increment context sequence number
+ * @rcd: the receive context
+ * @seq: the current sequence number
+ *
+ * Returns: true if the this was the last packet
+ */
+static inline bool hfi2_seq_incr(struct hfi2_ctxtdata *rcd, u32 seq)
+{
+	rcd->seq_cnt = hfi2_seq_incr_wrap(rcd->seq_cnt);
+	return last_rcv_seq(rcd, seq);
+}
+
+/**
+ * get_hdrqentsize - return hdrq entry size
+ * @rcd: the receive context
+ */
+static inline u8 get_hdrqentsize(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->rcvhdrqentsize;
+}
+
+#define DEFAULT_HDRQ_ENTSIZE 32
+/**
+ * kctxt_hdrqentsize - return hdrq entry size for a port kernel context
+ * @ppd: target port structure
+ */
+static inline u8 kctxt_hdrqentsize(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_ctxtdata *rcd;
+
+	/* use default if port not available */
+	if (!port_available_ppd(ppd))
+		return DEFAULT_HDRQ_ENTSIZE;
+
+	/* use port's first rcv context */
+	rcd = ppd->dd->rcd[ppd->rcv_context_base];
+	return get_hdrqentsize(rcd);
+}
+
+/**
+ * get_hdrq_cnt - return hdrq count
+ * @rcd: the receive context
+ */
+static inline u16 get_hdrq_cnt(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->rcvhdrq_cnt;
+}
+
+/**
+ * hfi2_is_slowpath - check if this context is slow path
+ * @rcd: the receive context
+ */
+static inline bool hfi2_is_slowpath(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->do_interrupt == rcd->slow_handler;
+}
+
+/**
+ * hfi2_is_fastpath - check if this context is fast path
+ * @rcd: the receive context
+ */
+static inline bool hfi2_is_fastpath(struct hfi2_ctxtdata *rcd)
+{
+	if (is_control_context(rcd))
+		return false;
+
+	return rcd->do_interrupt == rcd->fast_handler;
+}
+
+/**
+ * hfi2_set_fast - change to the fast handler
+ * @rcd: the receive context
+ */
+static inline void hfi2_set_fast(struct hfi2_ctxtdata *rcd)
+{
+	if (unlikely(!rcd))
+		return;
+	if (unlikely(!hfi2_is_fastpath(rcd)))
+		rcd->do_interrupt = rcd->fast_handler;
+}
+
+int hfi2_reset_device(int);
+
+void receive_interrupt_work(struct work_struct *work);
+
+/* extract service channel from header and rhf */
+static inline int hfi2_9B_get_sc5(struct ib_header *hdr, bool sc4)
+{
+	return ib_get_sc(hdr) | (sc4 << 4);
+}
+
+/* 9B header length function */
+static inline u16 ib_get_len(const struct ib_header *hdr)
+{
+	return be16_to_cpu(hdr->lrh[2]);
+}
+
+#define HFI2_JKEY_WIDTH       16
+#define HFI2_JKEY_MASK        (BIT(16) - 1)
+#define HFI2_ADMIN_JKEY_RANGE 32
+
+/*
+ * J_KEYs are split and allocated in the following groups:
+ *   0 - 31    - users with administrator privileges
+ *  32 - 63    - kernel protocols using KDETH packets
+ *  64 - 65535 - all other users using KDETH packets
+ */
+static inline u16 generate_jkey(kuid_t uid)
+{
+	u16 jkey = from_kuid(current_user_ns(), uid) & HFI2_JKEY_MASK;
+
+	if (capable(CAP_SYS_ADMIN))
+		jkey &= HFI2_ADMIN_JKEY_RANGE - 1;
+	else if (jkey < 64)
+		jkey |= BIT(HFI2_JKEY_WIDTH - 1);
+
+	return jkey;
+}
+
+/*
+ * active_egress_rate
+ *
+ * returns the active egress rate in units of [10^6 bits/sec]
+ */
+static inline u32 active_egress_rate(struct hfi2_pportdata *ppd)
+{
+	u16 link_speed = ppd->link_speed_active;
+	u16 link_width = ppd->link_width_active;
+	u32 egress_rate;
+
+	if (link_speed == OPA_LINK_SPEED_100G)
+		egress_rate = 100000;
+	else if (link_speed == OPA_LINK_SPEED_50G)
+		egress_rate = 50000;
+	else if (link_speed == OPA_LINK_SPEED_25G)
+		egress_rate = 25000;
+	else /* assume OPA_LINK_SPEED_12_5G */
+		egress_rate = 12500;
+
+	switch (link_width) {
+	case OPA_LINK_WIDTH_4X:
+		egress_rate *= 4;
+		break;
+	case OPA_LINK_WIDTH_3X:
+		egress_rate *= 3;
+		break;
+	case OPA_LINK_WIDTH_2X:
+		egress_rate *= 2;
+		break;
+	default:
+		/* assume IB_WIDTH_1X */
+		break;
+	}
+
+	return egress_rate;
+}
+
+/*
+ * egress_cycles
+ *
+ * Returns the number of 'fabric clock cycles' to egress a packet
+ * of length 'len' bytes, at 'rate' Mbit/s. Since the fabric clock
+ * rate is (approximately) 805 MHz, the units of the returned value
+ * are (1/805 MHz).
+ */
+static inline u32 egress_cycles(u32 len, u32 rate)
+{
+	u32 cycles;
+
+	/*
+	 * cycles is:
+	 *
+	 *          (length) [bits] / (rate) [bits/sec]
+	 *  ---------------------------------------------------
+	 *  fabric_clock_period == 1 /(805 * 10^6) [cycles/sec]
+	 */
+
+	cycles = len * 8; /* bits */
+	cycles *= 805;
+	cycles /= rate;
+
+	return cycles;
+}
+
+void set_link_ipg(struct hfi2_pportdata *ppd);
+void process_becn(struct hfi2_pportdata *ppd, u8 sl, u32 rlid, u32 lqpn,
+		  u32 rqpn, u8 svc_type);
+void return_cnp(struct hfi2_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
+		u16 pkey, u32 slid, u32 dlid, u8 sc5,
+		const struct ib_grh *old_grh);
+void return_cnp_16B(struct hfi2_ibport *ibp, struct rvt_qp *qp,
+		    u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
+		    u8 sc5, const struct ib_grh *old_grh);
+typedef void (*hfi2_handle_cnp)(struct hfi2_ibport *ibp, struct rvt_qp *qp,
+				u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
+				u8 sc5, const struct ib_grh *old_grh);
+
+#define PKEY_CHECK_INVALID -1
+int egress_pkey_check(struct hfi2_pportdata *ppd, u32 slid, u16 pkey,
+		      u8 sc5, int8_t s_pkey_index);
+
+#define PACKET_EGRESS_TIMEOUT 350
+static inline void pause_for_credit_return(struct hfi2_devdata *dd)
+{
+	/* Pause at least 1us, to ensure chip returns all credits */
+	u32 usec = cclock_to_ns(dd, PACKET_EGRESS_TIMEOUT) / 1000;
+
+	udelay(usec ? usec : 1);
+}
+
+/**
+ * sc_to_vlt() - reverse lookup sc to vl
+ * @ppd - per-port data
+ * @sc5 - 5 bit sc
+ */
+static inline u8 sc_to_vlt(struct hfi2_pportdata *ppd, u8 sc5)
+{
+	unsigned seq;
+	u8 rval;
+
+	if (sc5 >= OPA_MAX_SCS)
+		return (u8)(0xff);
+
+	do {
+		seq = read_seqbegin(&ppd->sc2vl_lock);
+		rval = *(((u8 *)ppd->sc2vl) + sc5);
+	} while (read_seqretry(&ppd->sc2vl_lock, seq));
+
+	return rval;
+}
+
+#define PKEY_MEMBER_MASK 0x8000
+#define PKEY_LOW_15_MASK 0x7fff
+
+/*
+ * ingress_pkey_matches_entry - return 1 if the pkey matches ent (ent
+ * being an entry from the ingress partition key table), return 0
+ * otherwise. Use the matching criteria for ingress partition keys
+ * specified in the OPAv1 spec., section 9.10.14.
+ */
+static inline int ingress_pkey_matches_entry(u16 pkey, u16 ent)
+{
+	u16 mkey = pkey & PKEY_LOW_15_MASK;
+	u16 ment = ent & PKEY_LOW_15_MASK;
+
+	if (mkey == ment) {
+		/*
+		 * If pkey[15] is clear (limited partition member),
+		 * is bit 15 in the corresponding table element
+		 * clear (limited member)?
+		 */
+		if (!(pkey & PKEY_MEMBER_MASK))
+			return !!(ent & PKEY_MEMBER_MASK);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * ingress_pkey_table_search - search the entire pkey table for
+ * an entry which matches 'pkey'. return 0 if a match is found,
+ * and 1 otherwise.
+ */
+static inline int ingress_pkey_table_search(struct hfi2_pportdata *ppd,
+					    u16 pkey)
+{
+	int i;
+
+	for (i = 0; i < ppd->dd->params->pkey_table_size; i++) {
+		if (ingress_pkey_matches_entry(pkey, ppd->pkeys[i]))
+			return 0;
+	}
+	return 1;
+}
+
+/*
+ * ingress_pkey_table_fail - record a failure of ingress pkey validation,
+ * i.e., increment port_rcv_constraint_errors for the port, and record
+ * the 'error info' for this failure.
+ */
+static inline void ingress_pkey_table_fail(struct hfi2_pportdata *ppd, u16 pkey,
+					   u32 slid)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	incr_cntr64(&ppd->port_rcv_constraint_errors);
+	if (!(dd->err_info_rcv_constraint.status & OPA_EI_STATUS_SMASK)) {
+		dd->err_info_rcv_constraint.status |= OPA_EI_STATUS_SMASK;
+		dd->err_info_rcv_constraint.slid = slid;
+		dd->err_info_rcv_constraint.pkey = pkey;
+	}
+}
+
+/*
+ * ingress_pkey_check - Return 0 if the ingress pkey is valid, return 1
+ * otherwise. Use the criteria in the OPAv1 spec, section 9.10.14. idx
+ * is a hint as to the best place in the partition key table to begin
+ * searching. This function should not be called on the data path because
+ * of performance reasons. On datapath pkey check is expected to be done
+ * by HW and rcv_pkey_check function should be called instead.
+ */
+static inline int ingress_pkey_check(struct hfi2_pportdata *ppd, u16 pkey,
+				     u8 sc5, u8 idx, u32 slid, bool force)
+{
+	if (!(force) && !(ppd->part_enforce & HFI2_PART_ENFORCE_IN))
+		return 0;
+
+	/* If SC15, pkey[0:14] must be 0x7fff */
+	if ((sc5 == 0xf) && ((pkey & PKEY_LOW_15_MASK) != PKEY_LOW_15_MASK))
+		goto bad;
+
+	/* Is the pkey = 0x0, or 0x8000? */
+	if ((pkey & PKEY_LOW_15_MASK) == 0)
+		goto bad;
+
+	/* The most likely matching pkey has index 'idx' */
+	if (ingress_pkey_matches_entry(pkey, ppd->pkeys[idx]))
+		return 0;
+
+	/* no match - try the whole table */
+	if (!ingress_pkey_table_search(ppd, pkey))
+		return 0;
+
+bad:
+	ingress_pkey_table_fail(ppd, pkey, slid);
+	return 1;
+}
+
+/*
+ * rcv_pkey_check - Return 0 if the ingress pkey is valid, return 1
+ * otherwise. It only ensures pkey is vlid for QP0. This function
+ * should be called on the data path instead of ingress_pkey_check
+ * as on data path, pkey check is done by HW (except for QP0).
+ */
+static inline int rcv_pkey_check(struct hfi2_pportdata *ppd, u16 pkey,
+				 u8 sc5, u16 slid)
+{
+	if (!(ppd->part_enforce & HFI2_PART_ENFORCE_IN))
+		return 0;
+
+	/* If SC15, pkey[0:14] must be 0x7fff */
+	if ((sc5 == 0xf) && ((pkey & PKEY_LOW_15_MASK) != PKEY_LOW_15_MASK))
+		goto bad;
+
+	return 0;
+bad:
+	ingress_pkey_table_fail(ppd, pkey, slid);
+	return 1;
+}
+
+/* MTU handling */
+
+/* MTU enumeration, 256-4k match IB */
+#define OPA_MTU_0     0
+#define OPA_MTU_256   1
+#define OPA_MTU_512   2
+#define OPA_MTU_1024  3
+#define OPA_MTU_2048  4
+#define OPA_MTU_4096  5
+
+u32 lrh_max_header_bytes(struct hfi2_pportdata *ppd);
+int mtu_to_enum(u32 mtu, int default_if_bad);
+u16 enum_to_mtu(int mtu);
+static inline int valid_ib_mtu(unsigned int mtu)
+{
+	return mtu == 256 || mtu == 512 ||
+		mtu == 1024 || mtu == 2048 ||
+		mtu == 4096;
+}
+
+static inline int valid_opa_max_mtu(unsigned int mtu)
+{
+	return mtu >= 2048 &&
+		(valid_ib_mtu(mtu) || mtu == 8192 || mtu == 10240);
+}
+
+int set_mtu(struct hfi2_pportdata *ppd);
+
+int hfi2_set_lid(struct hfi2_pportdata *ppd, u32 lid, u8 lmc);
+void hfi2_disable_after_error(struct hfi2_devdata *dd);
+int hfi2_rcvbuf_validate(u32 size, u8 type, u16 *encode);
+
+int fm_get_table(struct hfi2_pportdata *ppd, int which, void *t);
+int fm_set_table(struct hfi2_pportdata *ppd, int which, void *t);
+
+void set_up_vau(struct hfi2_pportdata *ppd, u8 vau);
+void set_up_vl15(struct hfi2_pportdata *ppd, u16 vl15buf);
+void reset_link_credits(struct hfi2_pportdata *ppd);
+void assign_remote_cm_au_table(struct hfi2_pportdata *ppd, u8 vcu);
+
+int set_buffer_control(struct hfi2_pportdata *ppd, struct buffer_control *bc);
+
+static inline struct hfi2_devdata *dd_from_ppd(struct hfi2_pportdata *ppd)
+{
+	return ppd->dd;
+}
+
+static inline struct hfi2_devdata *dd_from_dev(struct hfi2_ibdev *dev)
+{
+	return container_of(dev, struct hfi2_devdata, verbs_dev);
+}
+
+static inline struct hfi2_devdata *dd_from_ibdev(struct ib_device *ibdev)
+{
+	return dd_from_dev(to_idev(ibdev));
+}
+
+static inline struct hfi2_pportdata *ppd_from_ibp(struct hfi2_ibport *ibp)
+{
+	return container_of(ibp, struct hfi2_pportdata, ibport_data);
+}
+
+static inline struct hfi2_ibdev *dev_from_rdi(struct rvt_dev_info *rdi)
+{
+	return container_of(rdi, struct hfi2_ibdev, rdi);
+}
+
+static inline struct hfi2_ibport *to_iport(struct ib_device *ibdev, u32 port)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	u32 pidx = port - 1; /* IB number port from 1, hdw from 0 */
+
+	WARN_ON(pidx >= dd->num_pports);
+	return &dd->pport[pidx].ibport_data;
+}
+
+static inline struct hfi2_ibport *rcd_to_iport(struct hfi2_ctxtdata *rcd)
+{
+	return &rcd->ppd->ibport_data;
+}
+
+/**
+ * hfi2_may_ecn - Check whether FECN or BECN processing should be done
+ * @pkt: the packet to be evaluated
+ *
+ * Check whether the FECN or BECN bits in the packet's header are
+ * enabled, depending on packet type.
+ *
+ * This function only checks for FECN and BECN bits. Additional checks
+ * are done in the slowpath (hfi2_process_ecn_slowpath()) in order to
+ * ensure correct handling.
+ */
+static inline bool hfi2_may_ecn(struct hfi2_packet *pkt)
+{
+	bool fecn, becn;
+
+	if (pkt->etype == RHF_RCV_TYPE_BYPASS) {
+		fecn = hfi2_16B_get_fecn(pkt->hdr);
+		becn = hfi2_16B_get_becn(pkt->hdr);
+	} else {
+		fecn = ib_bth_get_fecn(pkt->ohdr);
+		becn = ib_bth_get_becn(pkt->ohdr);
+	}
+	return fecn || becn;
+}
+
+bool hfi2_process_ecn_slowpath(struct rvt_qp *qp, struct hfi2_packet *pkt,
+			       bool prescan);
+static inline bool process_ecn(struct rvt_qp *qp, struct hfi2_packet *pkt)
+{
+	bool do_work;
+
+	do_work = hfi2_may_ecn(pkt);
+	if (unlikely(do_work))
+		return hfi2_process_ecn_slowpath(qp, pkt, false);
+	return false;
+}
+
+/*
+ * Return the indexed PKEY from the port PKEY table.
+ */
+static inline u16 hfi2_get_pkey(struct hfi2_ibport *ibp, unsigned index)
+{
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	u16 ret;
+
+	if (index >= ppd->dd->params->pkey_table_size)
+		ret = 0;
+	else
+		ret = ppd->pkeys[index];
+
+	return ret;
+}
+
+/*
+ * Return the indexed GUID from the port GUIDs table.
+ */
+static inline __be64 get_sguid(struct hfi2_ibport *ibp, unsigned int index)
+{
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+
+	WARN_ON(index >= HFI2_GUIDS_PER_PORT);
+	return cpu_to_be64(ppd->guids[index]);
+}
+
+/*
+ * Called by readers of cc_state only, must call under rcu_read_lock().
+ */
+static inline struct cc_state *get_cc_state(struct hfi2_pportdata *ppd)
+{
+	return rcu_dereference(ppd->cc_state);
+}
+
+/*
+ * Called by writers of cc_state only,  must call under cc_state_lock.
+ */
+static inline
+struct cc_state *get_cc_state_protected(struct hfi2_pportdata *ppd)
+{
+	return rcu_dereference_protected(ppd->cc_state,
+					 lockdep_is_held(&ppd->cc_state_lock));
+}
+
+/*
+ * values for dd->flags (_device_ related flags)
+ */
+#define HFI2_INITTED           0x1    /* chip and driver up and initted */
+#define HFI2_PRESENT           0x2    /* chip accesses can be done */
+#define HFI2_FROZEN            0x4    /* chip in SPC freeze */
+#define HFI2_HAS_SDMA_TIMEOUT  0x8
+#define HFI2_HAS_SEND_DMA      0x10   /* Supports Send DMA */
+#define HFI2_FORCED_FREEZE     0x80   /* driver forced freeze mode */
+#define HFI2_SHUTDOWN          0x100  /* device is shutting down */
+
+/* IB dword length mask in PBC (lower 11 bits); same for all chips */
+#define HFI2_PBC_LENGTH_MASK                     ((1 << 11) - 1)
+
+/* ctxt_flag bit offsets */
+		/* base context has not finished initializing */
+#define HFI2_CTXT_BASE_UNINIT 1
+		/* base context initaliation failed */
+#define HFI2_CTXT_BASE_FAILED 2
+		/* waiting for a packet to arrive */
+#define HFI2_CTXT_WAITING_RCV 3
+		/* waiting for an urgent packet to arrive */
+#define HFI2_CTXT_WAITING_URG 4
+
+/* free up any allocated data at closes */
+int hfi2_init_dd(struct hfi2_devdata *dd);
+
+/* LED beaconing functions */
+void hfi2_start_led_override(struct hfi2_pportdata *ppd, unsigned int timeon,
+			     unsigned int timeoff);
+void shutdown_led_override(struct hfi2_pportdata *ppd);
+
+#define HFI2_CREDIT_RETURN_RATE (100)
+
+/*
+ * The number of words for the KDETH protocol field.  If this is
+ * larger then the actual field used, then part of the payload
+ * will be in the header.
+ *
+ * Optimally, we want this sized so that a typical case will
+ * use full cache lines.  The typical local KDETH header would
+ * be:
+ *
+ *	Bytes	Field
+ *	  8	LRH
+ *	 12	BHT
+ *	 ??	KDETH
+ *	  8	RHF
+ *	---
+ *	 28 + KDETH
+ *
+ * For a 64-byte cache line, KDETH would need to be 36 bytes or 9 DWORDS
+ */
+#define DEFAULT_RCVHDRSIZE 9
+
+/*
+ * Maximal header byte count:
+ *
+ *	Bytes	Field
+ *	  8	LRH
+ *	 40	GRH (optional)
+ *	 12	BTH
+ *	 ??	KDETH
+ *	  8	RHF
+ *	---
+ *	 68 + KDETH
+ *
+ * We also want to maintain a cache line alignment to assist DMA'ing
+ * of the header bytes.  Round up to a good size.
+ */
+#define DEFAULT_RCVHDR_ENTSIZE 32
+
+bool hfi2_can_pin_pages(struct hfi2_devdata *dd, struct mm_struct *mm,
+			u32 nlocked, u32 npages);
+int hfi2_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr,
+			    size_t npages, bool writable, struct page **pages);
+void hfi2_release_user_pages(struct mm_struct *mm, struct page **p,
+			     size_t npages, bool dirty);
+
+/**
+ * hfi2_rcvhdrtail_kvaddr - return tail kvaddr
+ * @rcd - the receive context
+ */
+static inline __le64 *hfi2_rcvhdrtail_kvaddr(const struct hfi2_ctxtdata *rcd)
+{
+	return (__le64 *)rcd->rcvhdrtail_kvaddr;
+}
+
+static inline void clear_rcvhdrtail(const struct hfi2_ctxtdata *rcd)
+{
+	u64 *kv = (u64 *)hfi2_rcvhdrtail_kvaddr(rcd);
+
+	if (kv)
+		*kv = 0ULL;
+}
+
+static inline u32 get_rcvhdrtail(const struct hfi2_ctxtdata *rcd)
+{
+	/*
+	 * volatile because it's a DMA target from the chip, routine is
+	 * inlined, and don't want register caching or reordering.
+	 */
+	return (u32)le64_to_cpu(*hfi2_rcvhdrtail_kvaddr(rcd));
+}
+
+/*
+ * sysfs interface.
+ */
+
+extern const char ib_hfi2_version[];
+extern const struct attribute_group ib_hfi2_attr_group;
+extern const struct attribute_group *wfr_attr_port_groups[];
+extern const struct attribute_group *cport_attr_port_groups[];
+
+int hfi2_verbs_register_sysfs(struct hfi2_devdata *dd);
+void hfi2_verbs_unregister_sysfs(struct hfi2_devdata *dd);
+/* Hook for sysfs read of QSFP */
+int qsfp_dump(struct hfi2_pportdata *ppd, char *buf, int len);
+
+int hfi2_pcie_init(struct hfi2_devdata *dd);
+void hfi2_pcie_cleanup(struct pci_dev *pdev);
+int hfi2_pcie_ddinit(struct hfi2_devdata *dd, struct pci_dev *pdev);
+void hfi2_pcie_ddcleanup(struct hfi2_devdata *);
+int pcie_speeds(struct hfi2_devdata *dd);
+int restore_pci_variables(struct hfi2_devdata *dd);
+int save_pci_variables(struct hfi2_devdata *dd);
+int do_pcie_gen3_transition(struct hfi2_devdata *dd);
+void tune_pcie_caps(struct hfi2_devdata *dd);
+int parse_platform_config(struct hfi2_pportdata *ppd);
+int get_platform_config_field(struct hfi2_pportdata *ppd,
+			      enum platform_config_table_type_encoding
+			      table_type, int table_index, int field_index,
+			      u32 *data, u32 len);
+
+struct pci_dev *get_pci_dev(struct rvt_dev_info *rdi);
+
+/*
+ * Flush write combining store buffers (if present) and perform a write
+ * barrier.
+ */
+static inline void flush_wc(void)
+{
+	asm volatile("sfence" : : : "memory");
+}
+
+void handle_eflags(struct hfi2_packet *packet);
+void seqfile_dump_rcd(struct seq_file *s, struct hfi2_ctxtdata *rcd);
+
+/* global module parameter variables */
+extern unsigned int hfi2_max_mtu;
+extern unsigned int hfi2_cu;
+extern unsigned int user_credit_return_threshold;
+extern int num_user_contexts;
+extern unsigned long n_krcvqs;
+extern uint krcvqs[];
+extern int krcvqsset;
+extern uint loopback;
+extern uint quick_linkup;
+extern uint rcv_intr_timeout;
+extern uint rcv_intr_count;
+extern uint rcv_intr_dynamic;
+extern ushort link_crc_mask;
+
+extern struct mutex hfi2_mutex;
+
+/* Number of seconds before our card status check...  */
+#define STATUS_TIMEOUT 60
+
+#define DRIVER_NAME		"hfi2"
+#define HFI2_USER_MINOR_BASE     0
+#define HFI2_TRACE_MINOR         127
+#define HFI2_DIAGPKT_MINOR       128
+#define HFI2_DIAG_MINOR_BASE     129
+#define HFI2_SNOOP_CAPTURE_BASE  200
+#define HFI2_NMINORS             255
+
+#define PCI_VENDOR_ID_INTEL 0x8086
+#define PCI_DEVICE_ID_INTEL0 0x24f0
+#define PCI_DEVICE_ID_INTEL1 0x24f1
+#define PCI_VENDOR_ID_CORNELIS 0x434e
+#define PCI_DEVICE_ID_CORNELIS1 0x0001
+#define PCI_SUBDEVICE_CN5000_DUAL_PORT 0x0002
+
+/* create a ULL mask out of the given number of bits */
+#define MASK_ULL(bits) ((1ull << (bits)) - 1)
+
+#define HFI2_PKT_USER_SC_INTEGRITY					    \
+	(SEND_CTXT_CHECK_ENABLE_DISALLOW_NON_KDETH_PACKETS_SMASK	    \
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_KDETH_PACKETS_SMASK		\
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_BYPASS_SMASK		    \
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_GRH_SMASK)
+
+#define HFI2_PKT_KERNEL_SC_INTEGRITY					    \
+	(SEND_CTXT_CHECK_ENABLE_DISALLOW_KDETH_PACKETS_SMASK)
+
+static inline u64 hfi2_pkt_default_send_ctxt_mask(struct hfi2_devdata *dd,
+						  u16 ctxt_type)
+{
+	u64 base_sc_integrity;
+
+	/*
+	 * No integrity checks if HFI2_CAP_NO_INTEGRITY is set
+	 * or driver is snooping
+	 */
+	if (HFI2_CAP_IS_KSET(NO_INTEGRITY) ||
+	    (dd->hfi2_snoop.mode_flag & HFI2_PORT_SNOOP_MODE))
+		return 0;
+
+	base_sc_integrity =
+	SEND_CTXT_CHECK_ENABLE_DISALLOW_BYPASS_BAD_PKT_LEN_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_STATIC_RATE_CONTROL_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_LONG_BYPASS_PACKETS_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_LONG_IB_PACKETS_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_BAD_PKT_LEN_SMASK
+#ifndef CONFIG_FAULT_INJECTION
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_TEST_SMASK
+#endif
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_SMALL_BYPASS_PACKETS_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_SMALL_IB_PACKETS_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_RAW_IPV6_SMASK
+	| SEND_CTXT_CHECK_ENABLE_DISALLOW_RAW_SMASK
+	| SEND_CTXT_CHECK_ENABLE_CHECK_BYPASS_VL_MAPPING_SMASK
+	| SEND_CTXT_CHECK_ENABLE_CHECK_VL_MAPPING_SMASK
+	| SEND_CTXT_CHECK_ENABLE_CHECK_OPCODE_SMASK
+	| SEND_CTXT_CHECK_ENABLE_CHECK_SLID_SMASK
+	| SEND_CTXT_CHECK_ENABLE_CHECK_VL_SMASK
+	| SEND_CTXT_CHECK_ENABLE_CHECK_ENABLE_SMASK;
+
+	if (ctxt_type == SC_USER)
+		base_sc_integrity |=
+#ifndef CONFIG_FAULT_INJECTION
+			SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_TEST_SMASK |
+#endif
+			HFI2_PKT_USER_SC_INTEGRITY;
+	else if (ctxt_type != SC_KERNEL)
+		base_sc_integrity |= HFI2_PKT_KERNEL_SC_INTEGRITY;
+
+	/* turn on send-side job key checks if !A0 */
+	if (!is_ax(dd))
+		base_sc_integrity |= SEND_CTXT_CHECK_ENABLE_CHECK_JOB_KEY_SMASK;
+
+	return base_sc_integrity;
+}
+
+static inline u64 hfi2_pkt_base_sdma_integrity(struct hfi2_devdata *dd)
+{
+	u64 base_sdma_integrity;
+
+	/* No integrity checks if HFI2_CAP_NO_INTEGRITY is set */
+	if (HFI2_CAP_IS_KSET(NO_INTEGRITY))
+		return 0;
+
+	base_sdma_integrity =
+	SEND_DMA_CHECK_ENABLE_DISALLOW_BYPASS_BAD_PKT_LEN_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_LONG_BYPASS_PACKETS_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_LONG_IB_PACKETS_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_BAD_PKT_LEN_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_SMALL_BYPASS_PACKETS_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_SMALL_IB_PACKETS_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_RAW_IPV6_SMASK
+	| SEND_DMA_CHECK_ENABLE_DISALLOW_RAW_SMASK
+	| SEND_DMA_CHECK_ENABLE_CHECK_BYPASS_VL_MAPPING_SMASK
+	| SEND_DMA_CHECK_ENABLE_CHECK_VL_MAPPING_SMASK
+	| SEND_DMA_CHECK_ENABLE_CHECK_OPCODE_SMASK
+	| SEND_DMA_CHECK_ENABLE_CHECK_SLID_SMASK
+	| SEND_DMA_CHECK_ENABLE_CHECK_VL_SMASK
+	| SEND_DMA_CHECK_ENABLE_CHECK_ENABLE_SMASK;
+
+	if (!HFI2_CAP_IS_KSET(STATIC_RATE_CTRL))
+		base_sdma_integrity |=
+		SEND_DMA_CHECK_ENABLE_DISALLOW_PBC_STATIC_RATE_CONTROL_SMASK;
+
+	/* turn on send-side job key checks if !A0 */
+	if (!is_ax(dd))
+		base_sdma_integrity |=
+			SEND_DMA_CHECK_ENABLE_CHECK_JOB_KEY_SMASK;
+
+	return base_sdma_integrity;
+}
+
+#define dd_dev_emerg(dd, fmt, ...) \
+	dev_emerg(&(dd)->pcidev->dev, "%s: " fmt, \
+		  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
+
+#define dd_dev_err(dd, fmt, ...) \
+	dev_err(&(dd)->pcidev->dev, "%s: " fmt, \
+		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
+
+#define dd_dev_err_ratelimited(dd, fmt, ...) \
+	dev_err_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
+			    rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), \
+			    ##__VA_ARGS__)
+
+#define dd_dev_warn(dd, fmt, ...) \
+	dev_warn(&(dd)->pcidev->dev, "%s: " fmt, \
+		 rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
+
+#define dd_dev_warn_ratelimited(dd, fmt, ...) \
+	dev_warn_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
+			     rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), \
+			     ##__VA_ARGS__)
+
+#define dd_dev_info(dd, fmt, ...) \
+	dev_info(&(dd)->pcidev->dev, "%s: " fmt, \
+		 rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
+
+#define dd_dev_info_ratelimited(dd, fmt, ...) \
+	dev_info_ratelimited(&(dd)->pcidev->dev, "%s: " fmt, \
+			     rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), \
+			     ##__VA_ARGS__)
+
+#define dd_dev_dbg(dd, fmt, ...) \
+	dev_dbg(&(dd)->pcidev->dev, "%s: " fmt, \
+		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), ##__VA_ARGS__)
+
+#define hfi2_dev_porterr(dd, port, fmt, ...) \
+	dev_err(&(dd)->pcidev->dev, "%s: port %u: " fmt, \
+		rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), (port), ##__VA_ARGS__)
+
+#define ppd_dev_err(ppd, fmt, ...) \
+	dev_err(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
+		rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
+		##__VA_ARGS__)
+
+#define ppd_dev_warn(ppd, fmt, ...) \
+	dev_warn(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
+		 rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
+		 ##__VA_ARGS__)
+
+#define ppd_dev_warn_ratelimited(ppd, fmt, ...) \
+	dev_warn_ratelimited(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
+			     rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
+			     ##__VA_ARGS__)
+
+#define ppd_dev_info(ppd, fmt, ...) \
+	dev_info(&(ppd)->dd->pcidev->dev, "%s.%u: " fmt, \
+		 rvt_get_ibdev_name(&(ppd)->dd->verbs_dev.rdi), (ppd)->hw_pidx, \
+		 ##__VA_ARGS__)
+
+#define USER_OPCODE_CHECK_VAL 0xC0
+#define USER_OPCODE_CHECK_MASK 0xC0
+#define OPCODE_CHECK_VAL_DISABLED 0x0
+#define OPCODE_CHECK_MASK_DISABLED 0x0
+
+static inline void hfi2_reset_cpu_counters(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	dd->z_int_counter = get_all_cpu_total(dd->int_counter);
+	dd->z_rcv_limit = get_all_cpu_total(dd->rcv_limit);
+	dd->z_send_schedule = get_all_cpu_total(dd->send_schedule);
+
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		ppd->ibport_data.rvp.z_rc_acks =
+			get_all_cpu_total(ppd->ibport_data.rvp.rc_acks);
+		ppd->ibport_data.rvp.z_rc_qacks =
+			get_all_cpu_total(ppd->ibport_data.rvp.rc_qacks);
+	}
+}
+
+void setextled(struct hfi2_pportdata *ppd, u32 on);
+
+/* return the i2c resource given the target */
+static inline u32 i2c_target(u32 target)
+{
+	return target ? CR_I2C2 : CR_I2C1;
+}
+
+/* return the i2c chain chip resource that this device uses for QSFP */
+static inline u32 qsfp_resource(struct hfi2_devdata *dd)
+{
+	return i2c_target(dd->hfi2_id);
+}
+
+/* Is this device integrated or discrete? */
+static inline bool is_integrated(struct hfi2_devdata *dd)
+{
+	return dd->pcidev->device == PCI_DEVICE_ID_INTEL1;
+}
+
+/**
+ * hfi2_need_drop - detect need for drop
+ * @dd: - the device
+ *
+ * In some cases, the first packet needs to be dropped.
+ *
+ * Return true is the current packet needs to be dropped and false otherwise.
+ */
+static inline bool hfi2_need_drop(struct hfi2_devdata *dd)
+{
+	if (unlikely(dd->do_drop &&
+		     atomic_xchg(&dd->drop_packet, DROP_PACKET_OFF) ==
+		     DROP_PACKET_ON)) {
+		dd->do_drop = false;
+		return true;
+	}
+	return false;
+}
+
+int hfi2_tempsense_rd(struct hfi2_devdata *dd, struct hfi2_temp *temp);
+
+#define DD_DEV_ENTRY(dd)       __string(dev, dev_name(&(dd)->pcidev->dev))
+#define DD_DEV_ASSIGN(dd)      __assign_str(dev)
+
+static inline void hfi2_update_ah_attr(struct ib_device *ibdev,
+				       struct rdma_ah_attr *attr)
+{
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ibport *ibp;
+	u32 dlid = rdma_ah_get_dlid(attr);
+
+	/*
+	 * Kernel clients may not have setup GRH information
+	 * Set that here.
+	 */
+	ibp = to_iport(ibdev, rdma_ah_get_port_num(attr));
+	ppd = ppd_from_ibp(ibp);
+	if ((((dlid >= be16_to_cpu(IB_MULTICAST_LID_BASE)) ||
+	      (ppd->lid >= be16_to_cpu(IB_MULTICAST_LID_BASE))) &&
+	    (dlid != be32_to_cpu(OPA_LID_PERMISSIVE)) &&
+	    (dlid != be16_to_cpu(IB_LID_PERMISSIVE)) &&
+	    (!(rdma_ah_get_ah_flags(attr) & IB_AH_GRH))) ||
+	    (rdma_ah_get_make_grd(attr))) {
+		rdma_ah_set_ah_flags(attr, IB_AH_GRH);
+		rdma_ah_set_interface_id(attr, OPA_MAKE_ID(dlid));
+		rdma_ah_set_subnet_prefix(attr, ibp->rvp.gid_prefix);
+	}
+}
+
+/*
+ * hfi2_check_mcast- Check if the given lid is
+ * in the OPA multicast range.
+ *
+ * The LID might either reside in ah.dlid or might be
+ * in the GRH of the address handle as DGID if extended
+ * addresses are in use.
+ */
+static inline bool hfi2_check_mcast(u32 lid)
+{
+	return ((lid >= opa_get_mcast_base(OPA_MCAST_NR)) &&
+		(lid != be32_to_cpu(OPA_LID_PERMISSIVE)));
+}
+
+#define opa_get_lid(lid, format)	\
+	__opa_get_lid(lid, OPA_PORT_PACKET_FORMAT_##format)
+
+/* Convert a lid to a specific lid space */
+static inline u32 __opa_get_lid(u32 lid, u8 format)
+{
+	bool is_mcast = hfi2_check_mcast(lid);
+
+	switch (format) {
+	case OPA_PORT_PACKET_FORMAT_8B:
+	case OPA_PORT_PACKET_FORMAT_10B:
+		if (is_mcast)
+			return (lid - opa_get_mcast_base(OPA_MCAST_NR) +
+				0xF0000);
+		return lid & 0xFFFFF;
+	case OPA_PORT_PACKET_FORMAT_16B:
+		if (is_mcast)
+			return (lid - opa_get_mcast_base(OPA_MCAST_NR) +
+				0xF00000);
+		return lid & 0xFFFFFF;
+	case OPA_PORT_PACKET_FORMAT_9B:
+		if (is_mcast)
+			return (lid -
+				opa_get_mcast_base(OPA_MCAST_NR) +
+				be16_to_cpu(IB_MULTICAST_LID_BASE));
+		else
+			return lid & 0xFFFF;
+	default:
+		return lid;
+	}
+}
+
+/* Return true if the given lid is the OPA 16B multicast range */
+static inline bool hfi2_is_16B_mcast(u32 lid)
+{
+	return ((lid >=
+		opa_get_lid(opa_get_mcast_base(OPA_MCAST_NR), 16B)) &&
+		(lid != opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE), 16B)));
+}
+
+static inline void hfi2_make_opa_lid(struct rdma_ah_attr *attr)
+{
+	const struct ib_global_route *grh = rdma_ah_read_grh(attr);
+	u32 dlid = rdma_ah_get_dlid(attr);
+
+	/* Modify ah_attr.dlid to be in the 32 bit LID space.
+	 * This is how the address will be laid out:
+	 * Assuming MCAST_NR to be 4,
+	 * 32 bit permissive LID = 0xFFFFFFFF
+	 * Multicast LID range = 0xFFFFFFFE to 0xF0000000
+	 * Unicast LID range = 0xEFFFFFFF to 1
+	 * Invalid LID = 0
+	 */
+	if (ib_is_opa_gid(&grh->dgid))
+		dlid = opa_get_lid_from_gid(&grh->dgid);
+	else if ((dlid >= be16_to_cpu(IB_MULTICAST_LID_BASE)) &&
+		 (dlid != be16_to_cpu(IB_LID_PERMISSIVE)) &&
+		 (dlid != be32_to_cpu(OPA_LID_PERMISSIVE)))
+		dlid = dlid - be16_to_cpu(IB_MULTICAST_LID_BASE) +
+			opa_get_mcast_base(OPA_MCAST_NR);
+	else if (dlid == be16_to_cpu(IB_LID_PERMISSIVE))
+		dlid = be32_to_cpu(OPA_LID_PERMISSIVE);
+
+	rdma_ah_set_dlid(attr, dlid);
+}
+
+static inline u8 hfi2_get_packet_type(u32 lid)
+{
+	/* 9B if lid > 0xF0000000 */
+	if (lid >= opa_get_mcast_base(OPA_MCAST_NR))
+		return HFI2_PKT_TYPE_9B;
+
+	/* 16B if lid > 0xC000 */
+	if (lid >= opa_get_lid(opa_get_mcast_base(OPA_MCAST_NR), 9B))
+		return HFI2_PKT_TYPE_16B;
+
+	return HFI2_PKT_TYPE_9B;
+}
+
+static inline bool hfi2_get_hdr_type(u32 lid, struct rdma_ah_attr *attr)
+{
+	/*
+	 * If there was an incoming 16B packet with permissive
+	 * LIDs, OPA GIDs would have been programmed when those
+	 * packets were received. A 16B packet will have to
+	 * be sent in response to that packet. Return a 16B
+	 * header type if that's the case.
+	 */
+	if (rdma_ah_get_dlid(attr) == be32_to_cpu(OPA_LID_PERMISSIVE))
+		return (ib_is_opa_gid(&rdma_ah_read_grh(attr)->dgid)) ?
+			HFI2_PKT_TYPE_16B : HFI2_PKT_TYPE_9B;
+
+	/*
+	 * Return a 16B header type if either the destination
+	 * or source lid is extended.
+	 */
+	if (hfi2_get_packet_type(rdma_ah_get_dlid(attr)) == HFI2_PKT_TYPE_16B)
+		return HFI2_PKT_TYPE_16B;
+
+	return hfi2_get_packet_type(lid);
+}
+
+static inline void hfi2_make_ext_grh(struct hfi2_packet *packet,
+				     struct ib_grh *grh, u32 slid,
+				     u32 dlid)
+{
+	struct hfi2_ibport *ibp = &packet->rcd->ppd->ibport_data;
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+
+	if (!ibp)
+		return;
+
+	grh->hop_limit = 1;
+	grh->sgid.global.subnet_prefix = ibp->rvp.gid_prefix;
+	if (slid == opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE), 16B))
+		grh->sgid.global.interface_id =
+			OPA_MAKE_ID(be32_to_cpu(OPA_LID_PERMISSIVE));
+	else
+		grh->sgid.global.interface_id = OPA_MAKE_ID(slid);
+
+	/*
+	 * Upper layers (like mad) may compare the dgid in the
+	 * wc that is obtained here with the sgid_index in
+	 * the wr. Since sgid_index in wr is always 0 for
+	 * extended lids, set the dgid here to the default
+	 * IB gid.
+	 */
+	grh->dgid.global.subnet_prefix = ibp->rvp.gid_prefix;
+	grh->dgid.global.interface_id =
+		cpu_to_be64(ppd->guids[HFI2_PORT_GUID_INDEX]);
+}
+
+/* return value to add to size to make it a multiple of 8, values 0-7 */
+static inline u32 hfi2_pad8(u32 size)
+{
+	return -((int)size) & 0x7;
+}
+
+static inline int hfi2_get_16b_padding(u32 hdr_size, u32 payload)
+{
+	return -(hdr_size + payload + (SIZE_OF_CRC << 2) +
+		     SIZE_OF_LT) & 0x7;
+}
+
+static inline void hfi2_make_ib_hdr(struct ib_header *hdr,
+				    u16 lrh0, u16 len,
+				    u16 dlid, u16 slid)
+{
+	hdr->lrh[0] = cpu_to_be16(lrh0);
+	hdr->lrh[1] = cpu_to_be16(dlid);
+	hdr->lrh[2] = cpu_to_be16(len);
+	hdr->lrh[3] = cpu_to_be16(slid);
+}
+
+static inline void hfi2_make_16b_hdr(struct hfi2_16b_header *hdr,
+				     u32 slid, u32 dlid,
+				     u16 len, u16 pkey,
+				     bool becn, bool fecn, u8 l4,
+				     u8 sc)
+{
+	u32 lrh0 = 0;
+	u32 lrh1 = 0x40000000;
+	u32 lrh2 = 0;
+	u32 lrh3 = 0;
+
+	lrh0 = (lrh0 & ~OPA_16B_BECN_MASK) | (becn << OPA_16B_BECN_SHIFT);
+	lrh0 = (lrh0 & ~OPA_16B_LEN_MASK) | (len << OPA_16B_LEN_SHIFT);
+	lrh0 = (lrh0 & ~OPA_16B_LID_MASK)  | (slid & OPA_16B_LID_MASK);
+	lrh1 = (lrh1 & ~OPA_16B_FECN_MASK) | (fecn << OPA_16B_FECN_SHIFT);
+	lrh1 = (lrh1 & ~OPA_16B_SC_MASK) | (sc << OPA_16B_SC_SHIFT);
+	lrh1 = (lrh1 & ~OPA_16B_LID_MASK) | (dlid & OPA_16B_LID_MASK);
+	lrh2 = (lrh2 & ~OPA_16B_SLID_MASK) |
+		((slid >> OPA_16B_SLID_SHIFT) << OPA_16B_SLID_HIGH_SHIFT);
+	lrh2 = (lrh2 & ~OPA_16B_DLID_MASK) |
+		((dlid >> OPA_16B_DLID_SHIFT) << OPA_16B_DLID_HIGH_SHIFT);
+	lrh2 = (lrh2 & ~OPA_16B_PKEY_MASK) | ((u32)pkey << OPA_16B_PKEY_SHIFT);
+	lrh2 = (lrh2 & ~OPA_16B_L4_MASK) | l4;
+
+	hdr->lrh[0] = lrh0;
+	hdr->lrh[1] = lrh1;
+	hdr->lrh[2] = lrh2;
+	hdr->lrh[3] = lrh3;
+}
+
+static inline u32 chip_send_contexts(struct hfi2_devdata *dd)
+{
+	return read_csr(dd, dd->params->send_contexts_reg);
+}
+
+static inline u32 chip_sdma_engines(struct hfi2_devdata *dd)
+{
+	return read_csr(dd, dd->params->send_dma_engines_reg);
+}
+
+static inline u32 chip_pio_mem_size(struct hfi2_devdata *dd)
+{
+	return read_csr(dd, dd->params->send_pio_mem_size_reg);
+}
+
+static inline u32 chip_sdma_mem_size(struct hfi2_devdata *dd)
+{
+	return read_csr(dd, dd->params->send_dma_mem_size_reg);
+}
+
+static inline u64 read_iport_csr(const struct hfi2_devdata *dd, int pidx,
+				 u32 offset)
+{
+	/* IPORT CSRs are separated by rxe_iport_stride */
+	return read_csr(dd, offset + (dd->params->rxe_iport_stride * pidx));
+}
+
+static inline void write_iport_csr(struct hfi2_devdata *dd, int pidx,
+				   u32 offset, u64 value)
+{
+	/* IPORT CSRs are separated by rxe_iport_stride */
+	write_csr(dd, offset + (dd->params->rxe_iport_stride * pidx), value);
+}
+
+static inline u64 read_iprc_csr(const struct hfi2_devdata *dd, int pidx,
+				int rc, u32 offset)
+{
+	/*
+	 * IPORT receive context CSRs are separated by rxe_iport_stride and
+	 * rxe_iprc_stride.
+	 */
+	return read_csr(dd, offset + (dd->params->rxe_iport_stride * pidx)
+			+ (dd->params->rxe_iprc_stride * rc));
+}
+
+static inline void write_iprc_csr(struct hfi2_devdata *dd, int pidx,
+				  int rc, u32 offset, u64 value)
+{
+	/*
+	 * IPORT receive context CSRs are separated by rxe_iport_stride and
+	 * rxe_iprc_stride.
+	 */
+	write_csr(dd, offset + (dd->params->rxe_iport_stride * pidx)
+		  + (dd->params->rxe_iprc_stride * rc), value);
+}
+
+static inline u64 read_rctxt_csr(const struct hfi2_devdata *dd, int ctxt,
+				 u32 offset)
+{
+	/* restricted rcv context CSRs are separated by rxe_rctxt_stride */
+	return read_csr(dd, offset + (dd->params->rxe_rctxt_stride * ctxt));
+}
+
+static inline void write_rctxt_csr(struct hfi2_devdata *dd, int ctxt,
+				   u32 offset, u64 value)
+{
+	/* restricted rcv context CSRs are separated by rxe_rctxt_stride */
+	write_csr(dd, offset + (dd->params->rxe_rctxt_stride * ctxt), value);
+}
+
+static inline u64 read_kctxt_csr(const struct hfi2_devdata *dd, int ctxt,
+				 u32 offset)
+{
+	/* kernel rcv context CSRs are separated by rxe_kctxt_stride */
+	return read_csr(dd, offset + (dd->params->rxe_kctxt_stride * ctxt));
+}
+
+static inline void write_kctxt_csr(struct hfi2_devdata *dd, int ctxt,
+				   u32 offset, u64 value)
+{
+	/* kernel rcv context CSRs are separated by rxe_kctxt_stride */
+	write_csr(dd, offset + (dd->params->rxe_kctxt_stride * ctxt), value);
+}
+
+static inline u64 read_ku_csr(const struct hfi2_devdata *dd, int ctxt,
+			      u32 offset)
+{
+	/* kernel/user rcv context CSRs are separated by rxe_ku_stride */
+	return read_csr(dd, offset + (dd->params->rxe_ku_stride * ctxt));
+}
+
+static inline void write_ku_csr(struct hfi2_devdata *dd, int ctxt,
+				u32 offset, u64 value)
+{
+	/* kernel/user rcv context CSRs are separated by rxe_ku_stride */
+	write_csr(dd, offset + (dd->params->rxe_ku_stride * ctxt), value);
+}
+
+static inline u64 read_uctxt_csr(const struct hfi2_devdata *dd, int ctxt,
+				 u32 offset)
+{
+	/* user per-context CSRs are separated by rxe_uctxt_stride */
+	return read_csr(dd, offset + (dd->params->rxe_uctxt_stride * ctxt));
+}
+
+static inline void write_uctxt_csr(struct hfi2_devdata *dd, int ctxt,
+				   u32 offset, u64 value)
+{
+	/* user per-context CSRs are separated by rxe_uctxt_stride */
+	write_csr(dd, offset + (dd->params->rxe_uctxt_stride * ctxt), value);
+}
+
+static inline u64 read_sctxt_csr(const struct hfi2_devdata *dd, int ctxt,
+				 u32 offset)
+{
+	/* send context CSRs are separated by txe_sctxt_stride */
+	return read_csr(dd, offset + (dd->params->txe_sctxt_stride * ctxt));
+}
+
+static inline void write_sctxt_csr(struct hfi2_devdata *dd, int ctxt,
+				   u32 offset, u64 value)
+{
+	/* send context CSRs are separated by txe_sctxt_stride */
+	write_csr(dd, offset + (dd->params->txe_sctxt_stride * ctxt), value);
+}
+
+static inline u64 read_tctxt_csr(const struct hfi2_devdata *dd, int ctxt,
+				 u32 offset)
+{
+	/* TXE send context CSRs are separated by txe_tctxt_stride */
+	return read_csr(dd, offset + (dd->params->txe_tctxt_stride * ctxt));
+}
+
+static inline void write_tctxt_csr(struct hfi2_devdata *dd, int ctxt,
+				   u32 offset, u64 value)
+{
+	/* TXE send context CSRs are separated by txe_tctxt_stride */
+	write_csr(dd, offset + (dd->params->txe_tctxt_stride * ctxt), value);
+}
+
+static inline u64 read_sdma_csr(const struct hfi2_devdata *dd, int eng,
+				u32 offset)
+{
+	/* SDMA engine CSRs are separated by txe_sdma_stride */
+	return read_csr(dd, offset + (dd->params->txe_sdma_stride * eng));
+}
+
+static inline void write_sdma_csr(struct hfi2_devdata *dd, int eng,
+				  u32 offset, u64 value)
+{
+	/* SDMA engine CSRs are separated by txe_sdma_stride */
+	write_csr(dd, offset + (dd->params->txe_sdma_stride * eng), value);
+}
+
+static inline u64 read_sdmacfg_csr(const struct hfi2_devdata *dd, int eng,
+				   u32 offset)
+{
+	/* SDMA config engine CSRs are separated by txe_sdmacfg_stride */
+	return read_csr(dd, offset + (dd->params->txe_sdmacfg_stride * eng));
+}
+
+static inline void write_sdmacfg_csr(struct hfi2_devdata *dd, int eng,
+				     u32 offset, u64 value)
+{
+	/* SDMA config engine CSRs are separated by txe_sdmacfg_stride */
+	write_csr(dd, offset + (dd->params->txe_sdmacfg_stride * eng), value);
+}
+
+static inline u64 read_eport_csr(const struct hfi2_devdata *dd, int pidx,
+				 u32 offset)
+{
+	/* EPORT CSRs are separated by txe_eport_stride */
+	return read_csr(dd, offset + (dd->params->txe_eport_stride * pidx));
+}
+
+static inline void write_eport_csr(struct hfi2_devdata *dd, int pidx,
+				   u32 offset, u64 value)
+{
+	/* EPORT CSRs are separated by txe_eport_stride */
+	write_csr(dd, offset + (dd->params->txe_eport_stride * pidx), value);
+}
+
+static inline u64 read_epsc_csr(const struct hfi2_devdata *dd, int pidx,
+				int sc, u32 offset)
+{
+	/*
+	 * EPORT send context CSRs are separated by txe_eport_stride and
+	 * txe_epsc_stride.
+	 */
+	return read_csr(dd, offset + (dd->params->txe_eport_stride * pidx)
+			+ (dd->params->txe_epsc_stride * sc));
+}
+
+static inline void write_epsc_csr(struct hfi2_devdata *dd, int pidx,
+				  int sc, u32 offset, u64 value)
+{
+	/*
+	 * EPORT send context CSRs are separated by txe_eport_stride and
+	 * txe_epsc_stride.
+	 */
+	write_csr(dd, offset + (dd->params->txe_eport_stride * pidx)
+		  + (dd->params->txe_epsc_stride * sc), value);
+}
+
+static inline u32 rhe_rcv_type_err(struct hfi2_packet *packet)
+{
+	/* same field location on WFR, JKR; different u64 */
+	return (packet->err_flags >> RHF_RCV_TYPE_ERR_SHIFT) & RHF_RCV_TYPE_ERR_MASK;
+}
+
+static inline bool rhe_crk_err(struct hfi2_packet *packet)
+{
+	/* same bit location on WFR, JKR; different u64 */
+	return !!(packet->err_flags & RHF_DC_ERR);
+}
+
+static inline bool rhe_tid_err(struct hfi2_packet *packet)
+{
+	/* same bit location on WFR, JKR; different u64 */
+	return !!(packet->err_flags & RHF_TID_ERR);
+}
+
+static inline bool rhe_len_err(struct hfi2_packet *packet)
+{
+	/* same bit location on WFR, JKR; different u64 */
+	return !!(packet->err_flags & RHF_LEN_ERR);
+}
+
+static inline bool rhe_icrc_err(struct hfi2_packet *packet)
+{
+	/* same bit location on WFR, JKR; different u64 */
+	return !!(packet->err_flags & RHF_ICRC_ERR);
+}
+
+#endif                          /* _HFI2_KERNEL_H */



