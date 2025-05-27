Return-Path: <linux-rdma+bounces-10754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15670AC5249
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC681BA2868
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541821A3145;
	Tue, 27 May 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="IJuTn+87"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2125.outbound.protection.outlook.com [40.107.93.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184A46BF
	for <linux-rdma@vger.kernel.org>; Tue, 27 May 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748360770; cv=fail; b=TA+Bm1YryklrtVhitXIH8B70xw2fwyIydoHkMQx/VHhd4O0d9R+2VYDa+AaQA2lI3lKbpgH1OpSXoVqgbmP0mbnPrYUOkDK5473vAhCR6E5CjGYMhXiG7Zti9+wMEInARhKDGylWjVeL1NPoYmN+Px0E93DGxYBfG3pUfVu0Rrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748360770; c=relaxed/simple;
	bh=+iUwx3vuYA5gnbtu82d04V9DgowRDBzP7GTilEYRiVo=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ISKkOHK0XmECDMdE8NjGAJFlKphiYaYUu/7AU3DUenmvjJi5EunLwYWE/d29YR9XamBBr/WMtgOCL/xLTpGQtks18Q/UdS4+k9eRV04jyKFZr59azNIcjicZ6DkFQZXWVcUXl9rrS4t4GvEbnh4HzeAgLhSupR0nx01DzBGvavg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=IJuTn+87; arc=fail smtp.client-ip=40.107.93.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLLj9nvWh77ss2/pRFoM+JFKAWdwf7Xt4sptZtsvBFjYWLKSk/sts4MQMTaZmRr/DLhKCWp93K5UIveCAqkPQw8ERTVGc0rzk2t0+2DZ5iAWwA/Nunt/XFLdE3vMJLpCNiRQ/mg6Pqt8G69d9pzno7fML90YynZUD68ozguF4olYu1JFrGIy1KMu+4TWpiQ2rATehf7RHP0NtANbWt3cjAeSSrsSm2XablyBlM5k37IBBpdCOPBzQvmltp3cPevyQjc+UgByCCKl343X4M+nCklLeWiBkqjqsibegeXGBNDIO0oyECXVIL3iN9FabdClH4sb3RaEIWlzIIRWWbfcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pixf1xqVxnfTEMCUPf5HdyN0vf7XSHy41wzM+TAALBo=;
 b=NnlNs2h0JZM5X5fn5cV1Z6Ws4kRLwsvJOt0mC7FP2fQAuv54SAF7hrpOjLsdSRXI5GqbHPek7sNc6vSL4U2Yz2Qur2rUtC8r14EkRpdB+EuRarvBdqX37mNGrkgo8GcAq6w7ZPq3rGqj3kS/uHbZBkOstgQhspe1d+WHUG2AqNPge3mjFUj7ckmzm3sT67mgXiMD7JiIXCqw6UfLaQ1B41UTBjOGw3SXXETo+mJH8SeCEgEXMXGimgWgfVk0YQXC2fr+CLskUIkWtnP6H0HNQsx6geJAIC9prVqh/B5pCMjKfLeULKpaB3rGpfXneB/kPE83RLJXHRCNGOSgHrjqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pixf1xqVxnfTEMCUPf5HdyN0vf7XSHy41wzM+TAALBo=;
 b=IJuTn+873vghgPQrV/ZE09aHGLyzu7ua6OuAkcjoSrIgnBhPUxdk+AnIyuD0WfMuPWRNOUwIlgLmz0By/9HKSyCLYsCww+wxEq9rs+1yjdtubTQZt4+w7S5jwvDgpIpSntxB8e1PUgoiJjWcJWSQiQuI77ZHe8NPfnAF0N7q9E5qX9pwiWXbubm/XvzS3yoA4SrYRVtiebnQ5dSSv9p8NQz8M/3ucfprr33eZy/JGxfvXdlKEiW9TAetnFiwFpg2hQuPyjwtzjA22Ow3qY2GQG8JxYP8K2eAJCXs8E/UJ4F9rysxEM82FRp5V2YgniMTqsQ8kOWxrhl+FjzjsXCoTQ==
Received: from SJ0PR03CA0103.namprd03.prod.outlook.com (2603:10b6:a03:333::18)
 by BL3PR01MB6868.prod.exchangelabs.com (2603:10b6:208:353::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Tue, 27 May 2025 15:46:04 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::5c) by SJ0PR03CA0103.outlook.office365.com
 (2603:10b6:a03:333::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Tue,
 27 May 2025 15:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Tue, 27 May 2025 15:46:03 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 9DE4D14D722;
	Tue, 27 May 2025 11:46:02 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 824491810D63E;
	Tue, 27 May 2025 11:46:02 -0400 (EDT)
Subject: [PATCH for-next 0/2] Remove ancient qib driver
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Tue, 27 May 2025 11:46:02 -0400
Message-ID:
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|BL3PR01MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae81e88-20d1-4533-1cc3-08dd9d35964a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0pGcHJtajl3VEJhZFZZR01jVW83VlpUaFRKVlhZM3F2T3BpMU9qQmxLRnQ5?=
 =?utf-8?B?VTRmcVhDTWsrMDdta2s4RXN6Q1gzd1Z6M1IwOGxJQ29FQVkwREJkeHpLNVJY?=
 =?utf-8?B?SlZJYWpLbUdJZDhFZDNER25BSlJiQ2dhd3VkWS9Pb1lCR0Z3UjhPaWhNS2Qw?=
 =?utf-8?B?ZGhOL1B3cHRYOTdYRzEydzBNRWM4QzhxTnRTb0ZBQXFmV0hmR1hPRk1wVHJX?=
 =?utf-8?B?czVwN09JOEtLY1luWFkxUHc0VEx5VmMwWDlVUFVxbEZ4Q1g1UlppYVgwRVBT?=
 =?utf-8?B?b3NWS2RSMXhYLzVlSGpVVUpCY1VZNHpUTlVjU0pIeVBYNnNzVkh2Mi9vZnp6?=
 =?utf-8?B?clUySnNEUElSOENlMEZGY2VqWm14Y0x3SkovY0NzdkVlSC9DNnd3N0VPRzc1?=
 =?utf-8?B?NDM4YkxJS1ZoM3dHZUxvRko0Vk03aGV2SkNkT0xoQ0l1VGFMcm9YT3ZOcE1h?=
 =?utf-8?B?TDBORk5NQ2dET2tSclBsM3VJUitJOURlWWord3BjTjE1U3h1TzE3U2ZHVk5B?=
 =?utf-8?B?SlhOaFJhY1FPLytYSzd1d09vclNqUjNIVW5BTGwwc3d3eC9hTStSdmgyUmFv?=
 =?utf-8?B?dUhkOFUxZWVrOUM1Si95VHBHSWk2b0tmMytjQ1lSenJ5OUdWZUFnZG5nUTJM?=
 =?utf-8?B?N0dwSVp1em1xNHhNSk00TDJUVlA1V1BHSVM1eGhhc0FvQ1FFeXYxdGRHSjQw?=
 =?utf-8?B?SUUvUDhSK0VaQ2hUL0o1ZGd0MzZmSlcyL1hNbDIrdFN6dWVEdnhvak5DY2pY?=
 =?utf-8?B?eXhQaWhUZWUrZzl2MTlBWmdyS2x2NS9MdFZDTzhuQ1B6ekswSkRaNFN4Vkgw?=
 =?utf-8?B?c0VlQXJVVm9ZcHQ1MWkrcTBxWDJQNnl3a2M3eVRZS285Q214aEVta1ZReS9z?=
 =?utf-8?B?Y0lRMS9uL3RHMVBRMVUreEhnclVKQmRESS9hc3Q0TXA3cU1HaFRCcDhWd2lV?=
 =?utf-8?B?OHlkQ2lsejltSkpsMnBGUFo1NnBWencrajZrMnhUTDFOVHVnMDh0NFlCeWlR?=
 =?utf-8?B?RUduNmNZTTZ6ZXA5Q0MwZ24xK1RrbGptT1QyTXVSSS84MEpwb0lpbGhIa0NP?=
 =?utf-8?B?OTZXcXhXMVRuakM1UmZycUh0enM1L0QzeWVmY1lYeXgwV01FL2Y2N1dRNU4w?=
 =?utf-8?B?V2EyV2g0RTZLWU5OWG81b3FVMTNhZlIwR01udmN3NENVdGdVL3ZnYWhEQXBj?=
 =?utf-8?B?L1BFN2lqRlF0UzhnWWVZeTJxcUFnTmhHUVl5US9LQnhmZ096QlJoS2FDczVV?=
 =?utf-8?B?MUplOXduY3V6dEducm16TzJENE92T3JZVjBqS1dtZVVSd0F2dm42Q0IxV201?=
 =?utf-8?B?dnRXb1ZEOE45a3Z3TzlxS2ZialZXRTdvVnNVZ0xQSk1ob1d2ci9tZElCbURY?=
 =?utf-8?B?UnYrbE81UTEzakd1MmhRbnB3OUVsNlRINnN3amVZaXI2VlFIU3BwN1JHR1pR?=
 =?utf-8?B?dDZVVmpXSkR2TlBwRU9qVkR4eFJkL0VMTjFDTDZiWGI3UHplYTBWeWNnd01r?=
 =?utf-8?B?bmQ0Z0FsYmRlcjlkeEpKeFpVY3V3UWFDRk9pV05EYWt3T3JHTDdzNy9hV0dm?=
 =?utf-8?B?WmRRM1VDZGZ5SXM2NmhkeGVZRTM3S05UVDFESWNOdlc1OGUveEFZaTNNMmF4?=
 =?utf-8?B?dTREZ05tSkhXRmVFYmRuMTRyYnU2T09Rb3NDbVA2dkhQcUZxNFFLcm1MNjBo?=
 =?utf-8?B?bmFGbEh2U3NPMWtaKzFCYnlsQWVuRFkrclZ4d3p1UmNXU05XUUR2Z0RCRDY4?=
 =?utf-8?B?ODArYmFWbEh1VmpJbnVaRUMxNDhkV0VNWU1kSXhBT1RVYkVOeTl1KzgrZnFB?=
 =?utf-8?B?ODUzMW1ISFh4WXQzK204aXFIdU5RajlRQXZldExuZWhadjY3RHI5by9yVlVX?=
 =?utf-8?B?L1p3VmlGMVN3Sm9ramE0THVYcE5PTUtEa0tQL29TVi9qdXpCeDc1SFJQUXBF?=
 =?utf-8?B?VEk4QXYvaTFWajR2S2dLSzBqSE1oTi9Wa2l2VnpZRnAzalN1RXg1R2NQYnJa?=
 =?utf-8?B?TVRXTkxWZGxNdnJ5bW9QY1RqOTJaUjBibExZYThFb2ZnTmx1MjFBYXlXdEdB?=
 =?utf-8?Q?3C+SeU?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 15:46:03.4778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae81e88-20d1-4533-1cc3-08dd9d35964a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6868

Time for qib to go bye-bye.

---

Dennis Dalessandro (2):
      RDMA/qib: Remove outdated driver
      Maintainers: Remove QIB


 MAINTAINERS                                |    6 -
 drivers/infiniband/Kconfig                 |    1 -
 drivers/infiniband/hw/Makefile             |    1 -
 drivers/infiniband/hw/qib/Kconfig          |   17 -
 drivers/infiniband/hw/qib/Makefile         |   17 -
 drivers/infiniband/hw/qib/qib.h            | 1492 ----
 drivers/infiniband/hw/qib/qib_6120_regs.h  |  977 ---
 drivers/infiniband/hw/qib/qib_7220.h       |  149 -
 drivers/infiniband/hw/qib/qib_7220_regs.h  | 1496 ----
 drivers/infiniband/hw/qib/qib_7322_regs.h  | 3163 --------
 drivers/infiniband/hw/qib/qib_common.h     |  798 --
 drivers/infiniband/hw/qib/qib_debugfs.c    |  274 -
 drivers/infiniband/hw/qib/qib_debugfs.h    |   45 -
 drivers/infiniband/hw/qib/qib_diag.c       |  906 ---
 drivers/infiniband/hw/qib/qib_driver.c     |  798 --
 drivers/infiniband/hw/qib/qib_eeprom.c     |  271 -
 drivers/infiniband/hw/qib/qib_file_ops.c   | 2401 ------
 drivers/infiniband/hw/qib/qib_fs.c         |  549 --
 drivers/infiniband/hw/qib/qib_iba6120.c    | 3533 --------
 drivers/infiniband/hw/qib/qib_iba7220.c    | 4596 -----------
 drivers/infiniband/hw/qib/qib_iba7322.c    | 8474 --------------------
 drivers/infiniband/hw/qib/qib_init.c       | 1782 ----
 drivers/infiniband/hw/qib/qib_intr.c       |  240 -
 drivers/infiniband/hw/qib/qib_mad.c        | 2449 ------
 drivers/infiniband/hw/qib/qib_mad.h        |  300 -
 drivers/infiniband/hw/qib/qib_pcie.c       |  598 --
 drivers/infiniband/hw/qib/qib_pio_copy.c   |   64 -
 drivers/infiniband/hw/qib/qib_qp.c         |  454 --
 drivers/infiniband/hw/qib/qib_qsfp.c       |  549 --
 drivers/infiniband/hw/qib/qib_qsfp.h       |  188 -
 drivers/infiniband/hw/qib/qib_rc.c         | 2131 -----
 drivers/infiniband/hw/qib/qib_ruc.c        |  314 -
 drivers/infiniband/hw/qib/qib_sd7220.c     | 1445 ----
 drivers/infiniband/hw/qib/qib_sdma.c       |  999 ---
 drivers/infiniband/hw/qib/qib_sysfs.c      |  731 --
 drivers/infiniband/hw/qib/qib_twsi.c       |  502 --
 drivers/infiniband/hw/qib/qib_tx.c         |  566 --
 drivers/infiniband/hw/qib/qib_uc.c         |  521 --
 drivers/infiniband/hw/qib/qib_ud.c         |  583 --
 drivers/infiniband/hw/qib/qib_user_pages.c |  137 -
 drivers/infiniband/hw/qib/qib_user_sdma.c  | 1470 ----
 drivers/infiniband/hw/qib/qib_user_sdma.h  |   52 -
 drivers/infiniband/hw/qib/qib_verbs.c      | 1705 ----
 drivers/infiniband/hw/qib/qib_verbs.h      |  398 -
 drivers/infiniband/hw/qib/qib_wc_ppc64.c   |   62 -
 drivers/infiniband/hw/qib/qib_wc_x86_64.c  |  150 -
 46 files changed, 48354 deletions(-)
 delete mode 100644 drivers/infiniband/hw/qib/Kconfig
 delete mode 100644 drivers/infiniband/hw/qib/Makefile
 delete mode 100644 drivers/infiniband/hw/qib/qib.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_6120_regs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_7220.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_7220_regs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_7322_regs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_common.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_debugfs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_debugfs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_diag.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_driver.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_eeprom.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_file_ops.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_fs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_iba6120.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_iba7220.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_iba7322.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_init.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_intr.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_mad.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_mad.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_pcie.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_pio_copy.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_qp.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_qsfp.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_qsfp.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_rc.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_ruc.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_sd7220.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_sdma.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_sysfs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_twsi.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_tx.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_uc.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_ud.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_user_pages.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_user_sdma.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_user_sdma.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_verbs.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_verbs.h
 delete mode 100644 drivers/infiniband/hw/qib/qib_wc_ppc64.c
 delete mode 100644 drivers/infiniband/hw/qib/qib_wc_x86_64.c

--

-Denny


