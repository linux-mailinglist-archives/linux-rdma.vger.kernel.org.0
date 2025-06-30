Return-Path: <linux-rdma+bounces-11775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA2AEE637
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2064216E6B7
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849DA2E718B;
	Mon, 30 Jun 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="jWnacdCc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021107.outbound.protection.outlook.com [52.101.62.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FEA292B50
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306299; cv=fail; b=RQPWpiABCWwTF58GOsYtUD2Dulp57zDtLlu4VcSu+Y3kRRw9x29VHVjrqomVI+TfoTfTpFJ4Z5DHuZMDRr0WxglZRwfNc77q6ECKZD/kT5wjVsDPANnCUR0zvaPDHMJXLGoKn7geyqWhu15njzniNKjyCkFDGqSQr3Rpu4znL14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306299; c=relaxed/simple;
	bh=rB+/BB8miiiGMHJr1zrKNn2rf+hb9i0c0AjOlXlcdoA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=U4QC1+F/9062zAWDC1lAjVE7eO1H/y0k9HfgteSzVBwU1OM4Bmch86QahGUgpqvsmRDPaHYEKN8gDFAHb8qYaGfJwXhbkJoRdBqlLu4X0xwLBV8kg/69vROMw4gtu4jFzIrZYWg355IHhQIDTMMM47GbCiUAuBwKZDwFSswWGJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=jWnacdCc; arc=fail smtp.client-ip=52.101.62.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJp8zAIifHewGlRYWmkuuZqHJZ54G+bcAChaiDctC6xRVgg/hw3e12HkjtLZat6bpz8xWpjLPP0VmJmyEX9gK2O0LxgUwLUriIfpldS+Zao+GMhrD2A8SPN1UbzBOan3Q+j5SOuihsFEPGQaDOD0ABruP12QrctY1wE3zEGz8sT/ZCu9W1/VjE+Lx1hYKOggLwBmzAyup7lkgfNb8D9mG9gbLj9lm2gCHiC4TY1TyMDFzsrxaBJFDixJv/0oqLqYgA7G4N57DdcOxpNq1wXjdjw+bwJU2F39kE/VwyFK85sW1jxh6OpV471vFRrwnk8EvmVpbe9/kZ9033hWIOPH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtPz23C//bulweRj2ihxK0II4UhkKsu9pV1SrvXvEKk=;
 b=gc8jBIyWWhQd4pv5YFbCA3ZwR9vOpR1SXP/g+dPIUt2eORH2+CdPsqgoPiSo3l0xEwdsGS/dth8EOkaR0WZ9fw9y3uAJJDjJGYpoD8BzQvnRBZY3W6XDqJRm70bXeLqExA/02vgeJQ8Sc0bgWtnVXcRvS5GsNM+aL3WqmazYvlPfcF0VqLYrGq70ldRMrpHGOgqPE42Sa07JGBCT+VpMKXhETMa3ngc6aZWp403kFeExrVAVRuSvBD34UgPsKtL/mr3l5MKmB2creqvt/ZRpkl41MOKCM+BduDCnmySE4wdF+Myqwcx3y+c1hXoxMbhAg8lmFn/+aHuTns/OIxz8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtPz23C//bulweRj2ihxK0II4UhkKsu9pV1SrvXvEKk=;
 b=jWnacdCcxQOWT5G/EVgOAahEzE4ZnLEJ7nDWBz0eEFRJ7DSZHiElFge94fNtc2dpO40VwBv2rL8totTLVdJkXqD+BXBWidkIw5l1zU4h/ui6DhYRW2RYf+rwSW1YOo4CC5YiryrXHlmjRDP0EoCbgWt9N/oUs4Bs2ij+Mfn8ZwlGiJ6lIGqL2onXEG9SfjJEAbI+TfMftEJfUJFOPgH83rrD8fJcDEd7jr9jwO4alAF6GkQ+z9O83UVyxkRfq8iT+h5etx//Mmq79vqbYXEut5EZGqa5pX6aOt44Z53mzsB4MnY4ahtHWvjUr8gNhb6pjo9oTaXqPGOmsk1DA6t9+g==
Received: from PH7PR02CA0024.namprd02.prod.outlook.com (2603:10b6:510:33d::10)
 by CH7PR01MB8932.prod.exchangelabs.com (2603:10b6:610:252::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.29; Mon, 30 Jun 2025 17:58:10 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::e6) by PH7PR02CA0024.outlook.office365.com
 (2603:10b6:510:33d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.28 via Frontend Transport; Mon,
 30 Jun 2025 17:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:09 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id C8F1714D723;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 5CE0B1811AA42;
	Mon, 30 Jun 2025 11:29:47 -0400 (EDT)
Subject: [PATCH for-next 00/23] Migrate to hfi2 driver
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>,
 Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:29:47 -0400
Message-ID:
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|CH7PR01MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 857bccc0-e2f4-40b4-900c-08ddb7ffac79
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9lOUx2TmlRbWY3WUtuOU4remVpRW8yTlZrTkd4Tnc4dG5nZ09TOTVKUEJt?=
 =?utf-8?B?VCtnak4rZUpDakYyakt1WGVmdndyU2VSTG9iOGJJeHh3d0E0NkxremhVaE1a?=
 =?utf-8?B?aE5aR0RwaXdXY2p2d2pWU2U1anRmZWwyNFIwckNMa2Y1Y2RPYXlIc00wbXBa?=
 =?utf-8?B?QXoxemNyYkthOE9vRXZHcVloVkFoVkg0bFBLNDFRKzBHNFBVeDlxUWRFN3N2?=
 =?utf-8?B?UWJRK3pzc0tjcVEvSktnWmV3Sk10cEo4Yyt5RjlhRVJRTUo3d25OU2NLNWs4?=
 =?utf-8?B?WS9COE9GVXU3QXE1U25zelZiczRQRVRqM20yZXYzVkdHY3R2RlNyNitmeTll?=
 =?utf-8?B?L0NlS3VTUXhaWUlqeFF4WmN2VmpnTlhudzZ0dVFLMEpFNGwyZjRJbkFLMno5?=
 =?utf-8?B?ODd4Ry83ckxCNFowUXk2Q0NBSnpWdHc5NVRINE90Qk82Y2F4QXpyQ3NabDRp?=
 =?utf-8?B?Zjc5djc3N2VOUGhuUG9Qa2kzaW5aQXVaL3o4NnpWZnhEOVpScmt1YmV6WE96?=
 =?utf-8?B?VDJMNVNic1JaTDZ6KzFMVE9ZMGNlLzFUZUpzYWlBTGhXNWhCbWtZK09oVmU5?=
 =?utf-8?B?ckVjalhVTDlrWGRVYngxeGJOenVQemZSUG5nUk5aREVVUFNtWFZVQktML2F4?=
 =?utf-8?B?YmVpVFpuTnppdUN4dWZsOU4zbnpVdjRVTnoyRC8xQTN4VmxjSnJUa1oxRmZ0?=
 =?utf-8?B?YkdqdzQrM29OcENmc1h6U1Nod3hhV3RQRjBmNFl0dDc0WXYwanEyK2hZWWxi?=
 =?utf-8?B?bEJvaXI1ZUJpR2ZqUk5pdG9pVXhNaDNweFRxcnlFRkxFMzNqd1Y0c09makFM?=
 =?utf-8?B?Vm9CV2FiNzljRFk3alQ5L2RaNW1yS2wzV2ZmejVqRnNxOUx1b1l1dFJkaU1t?=
 =?utf-8?B?M1RyTmd0RHc5Tm0zVVA3YVBOaElldUtIL2RpZGd1aldqemZoNUd5S05na2JV?=
 =?utf-8?B?U0JmQVN1OUlXUGRmZEl4ZDZhZXBQaWw0REcyQlN4NFFKNThVZFEremFYNitK?=
 =?utf-8?B?WnhFUFA0MDhsOVNDZkJpUytLeFZZMjFRZjJyVXZmaDJCVDVEYnlFdGdVRkQ1?=
 =?utf-8?B?QS9JZmFIRXNVcmt1SXY3UXpwMk1DMmpnNE5sdmtpaVZlNmx2Y0owazlia21F?=
 =?utf-8?B?Zmw0UnRsTTE4NTVvWDRuYUc0SVpUbjdUUXMvMEpOVGxjZDRuYlBnaVFnOXQ0?=
 =?utf-8?B?ME5pb3RzNnJGTVpXR0lkR25OeXMycWFZTUU4OVlYTzB3c0dqdjlpYkdiLzVu?=
 =?utf-8?B?NEk3cVdZRzczcTJOTExUUk9XY2Q2NFFtWndwQUlxd3JmdHFyd3F4ejJkbWNk?=
 =?utf-8?B?M3hUSDNLenJPcFRjK3JGcmxVN0ZwQmhZODVUc0U2UkI5WE1Nc1RycGdESldV?=
 =?utf-8?B?cVZtZ3BOWTFqMDRPTXJGQUowdTBJQ0VXeGlNUmdla1VuUjhxNFhXSlQ1SWF3?=
 =?utf-8?B?eTYvY1pEN20vOGxMMnJYUEdKL1FTZzhJcGQ2SXJvNVBzZC9nY1NRelNMVjUy?=
 =?utf-8?B?WEZSZTIxTW5IL0ROY2dKNitBekpQR3NzclBGWVYyNFFOb3Z5Wll0cmtwS2dK?=
 =?utf-8?B?VEdTOEJ3WnZuaHpVaXpPMncySW02TW8xRHhjbDJRb3ZRVU5XREtLS1NDN1NR?=
 =?utf-8?B?WnZIdDBvRnU1b1dHVkhDMGswT3NFVU1OQ1Vkc0ZIVkpMdFBpdzBxUGhxZWJi?=
 =?utf-8?B?VngrQ2JKZmJ4dnl1K1JwZy94OXdsV0p4R1gzZEl0dDRkcXFITFFBcGYzYVc5?=
 =?utf-8?B?VnpkVTFKSTFGQmFsTU5jMHVCRCtUVjZxVzJBTW1odC9uTWFzQWVJUklCekxp?=
 =?utf-8?B?cG15QmdQUWx1bk0zK3MzdG1NRWp5QVZNbkptTGJBNmZGQWhXVUk5R21pWDFj?=
 =?utf-8?B?ZzNlbElGWUY2UUgrRktLa3lJM09iMFJxVThOQUpRYmVEaFJLSGE5Y004K1Ay?=
 =?utf-8?B?a203TEMwaDNWY1J4UnorZ1ZKbGpFYTRiYVJ5Q1JsdUgwWHQ5OEdCOFhscUxi?=
 =?utf-8?B?VmJ1M1pkMHBtOEtodHV0TGpUUFE2ZXV5ZmdleG9ZN2FjY0VjQlNuREFVRFhn?=
 =?utf-8?Q?Gq6YY8?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:09.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857bccc0-e2f4-40b4-900c-08ddb7ffac79
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8932

While sharing similar bones the chip for the Cornelis Networks next
generation fabric technology has some fundamental differences that
resulted in a near complete re-write of the driver. It also does not use
the private Cdev interface that the hfi1 driver exposes. After mentioning
this in an offlist email thread with the RDMA maintainers we have decided
to go with the approach of moving to a new driver and declaring hfi1
obsolete.

It is desirable to  keep hfi1 around temporarily to let user APIs catch up
to support access through the uverbs device rather than the private hfi1
Cdev.

This driver is designed to support future products as well.

Included in this submission is a couple patches to rdmavt and the IB core
to allow writev access to the uverbs device.

We are also removing the opa_vnic driver and associated collateral as it
has no future and has just been languishing in the tree for some time.

This series will be followed up to pick up any changes from hfi1 that
were not yet incorporated in our internal development tree.

Depending on how the review of this code goes we will either submit
separately or as a v2 to this series.

We are also open to other ideas on how to submit this and make it more
consumable for review and feedback.

---

Dean Luick (5):
      RDMA/OPA: Update OPA link speed list
      RDMA/rdmavt: Add ucontext alloc/dealloc passthrough
      RDMA/rdmavt: Correct multi-port QP iteration
      RDMA/rdmavt: Add driver mmap callback
      RDMA/core: Add writev to uverbs file descriptor

Dennis Dalessandro (18):
      RDMA/hfi1: Remove opa_vnic
      RDMA/hfi2: Consolidate ABI files and setup uverbs access
      RDMA/hfi2: Start hfi2 driver by basing off of hfi1
      RDMA/hfi2: Add in HW register definition files
      RDMA/hfi2: Add in HW register access support
      RDMA/hfi2: Add in trace header files
      RDMA/hfi2: Add in trace support
      RDMA/hfi2: Add system core header files
      RDMA/hfi2: Add system core support
      RDMA/hfi2: Add in MAD handling related headers
      RDMA/hfi2: Implement MAD handling
      RDMA/hfi2: Add IO related headers
      RDMA/hfi2: Implement data moving infrastructure
      RDMA/hfi2: Add in support for verbs
      RDMA/hfi2: Support ipoib
      RDMA/hfi2: Add misc header files
      RDMA/hfi2: Add the rest of the driver
      RDMA/hfi2: Make it build


 Documentation/infiniband/opa_vnic.rst         |   159 -
 .../zh_CN/infiniband/opa_vnic.rst             |   156 -
 MAINTAINERS                                   |    14 +-
 drivers/infiniband/Kconfig                    |     3 +-
 drivers/infiniband/core/device.c              |     1 +
 drivers/infiniband/core/uverbs_main.c         |    22 +
 drivers/infiniband/hw/hfi1/Makefile           |     4 +-
 drivers/infiniband/hw/hfi1/aspm.c             |     2 +-
 drivers/infiniband/hw/hfi1/chip.c             |    54 +-
 drivers/infiniband/hw/hfi1/chip.h             |     2 -
 drivers/infiniband/hw/hfi1/driver.c           |    13 +-
 drivers/infiniband/hw/hfi1/file_ops.c         |     2 +-
 drivers/infiniband/hw/hfi1/hfi.h              |    20 -
 drivers/infiniband/hw/hfi1/init.c             |     4 +-
 drivers/infiniband/hw/hfi1/mad.c              |     1 -
 drivers/infiniband/hw/hfi1/msix.c             |     4 +-
 drivers/infiniband/hw/hfi1/netdev.h           |     8 +-
 drivers/infiniband/hw/hfi1/netdev_rx.c        |     3 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h      |     2 +-
 drivers/infiniband/hw/hfi1/verbs.c            |     2 -
 drivers/infiniband/hw/hfi1/vnic.h             |   126 -
 drivers/infiniband/hw/hfi1/vnic_main.c        |   615 -
 drivers/infiniband/hw/hfi1/vnic_sdma.c        |   282 -
 drivers/infiniband/hw/hfi2/Kconfig            |    23 +
 drivers/infiniband/hw/hfi2/Makefile           |    69 +
 drivers/infiniband/hw/hfi2/affinity.c         |  1173 ++
 drivers/infiniband/hw/hfi2/affinity.h         |    85 +
 drivers/infiniband/hw/hfi2/aspm.c             |   291 +
 drivers/infiniband/hw/hfi2/aspm.h             |    35 +
 drivers/infiniband/hw/hfi2/chip.c             | 16345 ++++++++++++++++
 drivers/infiniband/hw/hfi2/chip.h             |  1420 ++
 drivers/infiniband/hw/hfi2/chip_gen.c         |   504 +
 drivers/infiniband/hw/hfi2/chip_gen.h         |    29 +
 drivers/infiniband/hw/hfi2/chip_jkr.c         |   873 +
 drivers/infiniband/hw/hfi2/chip_jkr.h         |   119 +
 drivers/infiniband/hw/hfi2/chip_registers.h   |  1297 ++
 .../infiniband/hw/hfi2/chip_registers_jkr.h   |   224 +
 drivers/infiniband/hw/hfi2/common.h           |   335 +
 drivers/infiniband/hw/hfi2/cport.c            |   746 +
 drivers/infiniband/hw/hfi2/cport.h            |   247 +
 drivers/infiniband/hw/hfi2/cport_traps.h      |    43 +
 drivers/infiniband/hw/hfi2/debugfs.c          |  1578 ++
 drivers/infiniband/hw/hfi2/debugfs.h          |    70 +
 drivers/infiniband/hw/hfi2/device.h           |    18 +
 drivers/infiniband/hw/hfi2/driver.c           |  1959 ++
 drivers/infiniband/hw/hfi2/efivar.c           |   138 +
 drivers/infiniband/hw/hfi2/efivar.h           |    16 +
 drivers/infiniband/hw/hfi2/eprom.c            |   450 +
 drivers/infiniband/hw/hfi2/eprom.h            |    10 +
 drivers/infiniband/hw/hfi2/exp_rcv.c          |    78 +
 drivers/infiniband/hw/hfi2/exp_rcv.h          |   156 +
 drivers/infiniband/hw/hfi2/fault.c            |   335 +
 drivers/infiniband/hw/hfi2/fault.h            |    69 +
 drivers/infiniband/hw/hfi2/file_ops.c         |  1272 ++
 drivers/infiniband/hw/hfi2/file_ops.h         |    46 +
 drivers/infiniband/hw/hfi2/firmware.c         |  2266 +++
 drivers/infiniband/hw/hfi2/hfi2.h             |  3283 ++++
 drivers/infiniband/hw/hfi2/init.c             |  2729 +++
 drivers/infiniband/hw/hfi2/intr.c             |   296 +
 drivers/infiniband/hw/hfi2/iowait.c           |   128 +
 drivers/infiniband/hw/hfi2/iowait.h           |   457 +
 drivers/infiniband/hw/hfi2/ipoib.h            |   172 +
 drivers/infiniband/hw/hfi2/ipoib_main.c       |   253 +
 drivers/infiniband/hw/hfi2/ipoib_rx.c         |    92 +
 drivers/infiniband/hw/hfi2/ipoib_tx.c         |   871 +
 drivers/infiniband/hw/hfi2/mad.c              |  6055 ++++++
 drivers/infiniband/hw/hfi2/mad.h              |   448 +
 drivers/infiniband/hw/hfi2/mmu_rb.c           |   334 +
 drivers/infiniband/hw/hfi2/mmu_rb.h           |    77 +
 drivers/infiniband/hw/hfi2/msix.c             |   411 +
 drivers/infiniband/hw/hfi2/msix.h             |    26 +
 drivers/infiniband/hw/hfi2/netdev.h           |    99 +
 drivers/infiniband/hw/hfi2/netdev_rx.c        |   494 +
 drivers/infiniband/hw/hfi2/opa_compat.h       |    86 +
 drivers/infiniband/hw/hfi2/opfn.c             |   323 +
 drivers/infiniband/hw/hfi2/opfn.h             |    87 +
 drivers/infiniband/hw/hfi2/pcie.c             |  1380 ++
 drivers/infiniband/hw/hfi2/pin_system.c       |   550 +
 drivers/infiniband/hw/hfi2/pinning.c          |    66 +
 drivers/infiniband/hw/hfi2/pinning.h          |    74 +
 drivers/infiniband/hw/hfi2/pio.c              |  2277 +++
 drivers/infiniband/hw/hfi2/pio.h              |   305 +
 drivers/infiniband/hw/hfi2/pio_copy.c         |   715 +
 drivers/infiniband/hw/hfi2/platform.c         |  1035 +
 drivers/infiniband/hw/hfi2/platform.h         |   371 +
 drivers/infiniband/hw/hfi2/qp.c               |   949 +
 drivers/infiniband/hw/hfi2/qp.h               |   107 +
 drivers/infiniband/hw/hfi2/qsfp.c             |   787 +
 drivers/infiniband/hw/hfi2/qsfp.h             |   201 +
 drivers/infiniband/hw/hfi2/rc.c               |  3259 +++
 drivers/infiniband/hw/hfi2/rc.h               |    59 +
 drivers/infiniband/hw/hfi2/ruc.c              |   595 +
 drivers/infiniband/hw/hfi2/sdma.c             |  3971 ++++
 drivers/infiniband/hw/hfi2/sdma.h             |  1212 ++
 drivers/infiniband/hw/hfi2/sdma_defs.h        |   116 +
 drivers/infiniband/hw/hfi2/sdma_txreq.h       |   104 +
 drivers/infiniband/hw/hfi2/sysfs.c            |   752 +
 drivers/infiniband/hw/hfi2/tid_rdma.c         |  5538 ++++++
 drivers/infiniband/hw/hfi2/tid_rdma.h         |   320 +
 drivers/infiniband/hw/hfi2/tid_system.c       |   476 +
 drivers/infiniband/hw/hfi2/trace.c            |   535 +
 drivers/infiniband/hw/hfi2/trace.h            |    25 +
 drivers/infiniband/hw/hfi2/trace_ctxts.h      |   115 +
 drivers/infiniband/hw/hfi2/trace_dbg.h        |   118 +
 drivers/infiniband/hw/hfi2/trace_ibhdrs.h     |   458 +
 drivers/infiniband/hw/hfi2/trace_iowait.h     |    54 +
 drivers/infiniband/hw/hfi2/trace_misc.h       |   108 +
 drivers/infiniband/hw/hfi2/trace_mmu.h        |    72 +
 drivers/infiniband/hw/hfi2/trace_pin.h        |   201 +
 drivers/infiniband/hw/hfi2/trace_rc.h         |   125 +
 drivers/infiniband/hw/hfi2/trace_rx.h         |   171 +
 drivers/infiniband/hw/hfi2/trace_tid.h        |  1687 ++
 drivers/infiniband/hw/hfi2/trace_tx.h         |  1186 ++
 drivers/infiniband/hw/hfi2/uc.c               |   542 +
 drivers/infiniband/hw/hfi2/ud.c               |  1030 +
 drivers/infiniband/hw/hfi2/user_exp_rcv.c     |  1012 +
 drivers/infiniband/hw/hfi2/user_exp_rcv.h     |   404 +
 drivers/infiniband/hw/hfi2/user_pages.c       |   106 +
 drivers/infiniband/hw/hfi2/user_sdma.c        |  1671 ++
 drivers/infiniband/hw/hfi2/user_sdma.h        |   262 +
 drivers/infiniband/hw/hfi2/uverbs.c           |   598 +
 drivers/infiniband/hw/hfi2/uverbs.h           |    19 +
 drivers/infiniband/hw/hfi2/verbs.c            |  2052 ++
 drivers/infiniband/hw/hfi2/verbs.h            |   488 +
 drivers/infiniband/hw/hfi2/verbs_txreq.c      |   100 +
 drivers/infiniband/hw/hfi2/verbs_txreq.h      |    97 +
 drivers/infiniband/sw/rdmavt/mmap.c           |    22 +-
 drivers/infiniband/sw/rdmavt/qp.c             |     2 +-
 drivers/infiniband/sw/rdmavt/vt.c             |     8 +
 drivers/infiniband/ulp/Makefile               |     1 -
 drivers/infiniband/ulp/opa_vnic/Kconfig       |     9 -
 drivers/infiniband/ulp/opa_vnic/Makefile      |     9 -
 .../infiniband/ulp/opa_vnic/opa_vnic_encap.c  |   513 -
 .../infiniband/ulp/opa_vnic/opa_vnic_encap.h  |   524 -
 .../ulp/opa_vnic/opa_vnic_ethtool.c           |   183 -
 .../ulp/opa_vnic/opa_vnic_internal.h          |   329 -
 .../infiniband/ulp/opa_vnic/opa_vnic_netdev.c |   400 -
 .../infiniband/ulp/opa_vnic/opa_vnic_vema.c   |  1056 -
 .../ulp/opa_vnic/opa_vnic_vema_iface.c        |   390 -
 include/rdma/ib_verbs.h                       |     2 +
 include/rdma/opa_port_info.h                  |     8 +-
 include/rdma/rdma_vt.h                        |    10 +
 include/uapi/rdma/hfi/hfi1_ioctl.h            |   120 +-
 include/uapi/rdma/hfi/hfi1_user.h             |   282 +-
 include/uapi/rdma/hfi2-abi.h                  |   726 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |     1 +
 146 files changed, 88394 insertions(+), 5195 deletions(-)
 delete mode 100644 Documentation/infiniband/opa_vnic.rst
 delete mode 100644 Documentation/translations/zh_CN/infiniband/opa_vnic.rst
 delete mode 100644 drivers/infiniband/hw/hfi1/vnic.h
 delete mode 100644 drivers/infiniband/hw/hfi1/vnic_main.c
 delete mode 100644 drivers/infiniband/hw/hfi1/vnic_sdma.c
 create mode 100644 drivers/infiniband/hw/hfi2/Kconfig
 create mode 100644 drivers/infiniband/hw/hfi2/Makefile
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.c
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.c
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_gen.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip_gen.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_jkr.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip_jkr.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_registers.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_registers_jkr.h
 create mode 100644 drivers/infiniband/hw/hfi2/common.h
 create mode 100644 drivers/infiniband/hw/hfi2/cport.c
 create mode 100644 drivers/infiniband/hw/hfi2/cport.h
 create mode 100644 drivers/infiniband/hw/hfi2/cport_traps.h
 create mode 100644 drivers/infiniband/hw/hfi2/debugfs.c
 create mode 100644 drivers/infiniband/hw/hfi2/debugfs.h
 create mode 100644 drivers/infiniband/hw/hfi2/device.h
 create mode 100644 drivers/infiniband/hw/hfi2/driver.c
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.c
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
 create mode 100644 drivers/infiniband/hw/hfi2/eprom.c
 create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
 create mode 100644 drivers/infiniband/hw/hfi2/exp_rcv.c
 create mode 100644 drivers/infiniband/hw/hfi2/exp_rcv.h
 create mode 100644 drivers/infiniband/hw/hfi2/fault.c
 create mode 100644 drivers/infiniband/hw/hfi2/fault.h
 create mode 100644 drivers/infiniband/hw/hfi2/file_ops.c
 create mode 100644 drivers/infiniband/hw/hfi2/file_ops.h
 create mode 100644 drivers/infiniband/hw/hfi2/firmware.c
 create mode 100644 drivers/infiniband/hw/hfi2/hfi2.h
 create mode 100644 drivers/infiniband/hw/hfi2/init.c
 create mode 100644 drivers/infiniband/hw/hfi2/intr.c
 create mode 100644 drivers/infiniband/hw/hfi2/iowait.c
 create mode 100644 drivers/infiniband/hw/hfi2/iowait.h
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib.h
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib_main.c
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib_rx.c
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib_tx.c
 create mode 100644 drivers/infiniband/hw/hfi2/mad.c
 create mode 100644 drivers/infiniband/hw/hfi2/mad.h
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.c
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
 create mode 100644 drivers/infiniband/hw/hfi2/msix.c
 create mode 100644 drivers/infiniband/hw/hfi2/msix.h
 create mode 100644 drivers/infiniband/hw/hfi2/netdev.h
 create mode 100644 drivers/infiniband/hw/hfi2/netdev_rx.c
 create mode 100644 drivers/infiniband/hw/hfi2/opa_compat.h
 create mode 100644 drivers/infiniband/hw/hfi2/opfn.c
 create mode 100644 drivers/infiniband/hw/hfi2/opfn.h
 create mode 100644 drivers/infiniband/hw/hfi2/pcie.c
 create mode 100644 drivers/infiniband/hw/hfi2/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi2/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi2/pinning.h
 create mode 100644 drivers/infiniband/hw/hfi2/pio.c
 create mode 100644 drivers/infiniband/hw/hfi2/pio.h
 create mode 100644 drivers/infiniband/hw/hfi2/pio_copy.c
 create mode 100644 drivers/infiniband/hw/hfi2/platform.c
 create mode 100644 drivers/infiniband/hw/hfi2/platform.h
 create mode 100644 drivers/infiniband/hw/hfi2/qp.c
 create mode 100644 drivers/infiniband/hw/hfi2/qp.h
 create mode 100644 drivers/infiniband/hw/hfi2/qsfp.c
 create mode 100644 drivers/infiniband/hw/hfi2/qsfp.h
 create mode 100644 drivers/infiniband/hw/hfi2/rc.c
 create mode 100644 drivers/infiniband/hw/hfi2/rc.h
 create mode 100644 drivers/infiniband/hw/hfi2/ruc.c
 create mode 100644 drivers/infiniband/hw/hfi2/sdma.c
 create mode 100644 drivers/infiniband/hw/hfi2/sdma.h
 create mode 100644 drivers/infiniband/hw/hfi2/sdma_defs.h
 create mode 100644 drivers/infiniband/hw/hfi2/sdma_txreq.h
 create mode 100644 drivers/infiniband/hw/hfi2/sysfs.c
 create mode 100644 drivers/infiniband/hw/hfi2/tid_rdma.c
 create mode 100644 drivers/infiniband/hw/hfi2/tid_rdma.h
 create mode 100644 drivers/infiniband/hw/hfi2/tid_system.c
 create mode 100644 drivers/infiniband/hw/hfi2/trace.c
 create mode 100644 drivers/infiniband/hw/hfi2/trace.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_ctxts.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_dbg.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_ibhdrs.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_iowait.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_misc.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_mmu.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_pin.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_rc.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_rx.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_tid.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_tx.h
 create mode 100644 drivers/infiniband/hw/hfi2/uc.c
 create mode 100644 drivers/infiniband/hw/hfi2/ud.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_exp_rcv.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_exp_rcv.h
 create mode 100644 drivers/infiniband/hw/hfi2/user_pages.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_sdma.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_sdma.h
 create mode 100644 drivers/infiniband/hw/hfi2/uverbs.c
 create mode 100644 drivers/infiniband/hw/hfi2/uverbs.h
 create mode 100644 drivers/infiniband/hw/hfi2/verbs.c
 create mode 100644 drivers/infiniband/hw/hfi2/verbs.h
 create mode 100644 drivers/infiniband/hw/hfi2/verbs_txreq.c
 create mode 100644 drivers/infiniband/hw/hfi2/verbs_txreq.h
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/Kconfig
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/Makefile
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_netdev.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
 delete mode 100644 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c
 create mode 100644 include/uapi/rdma/hfi2-abi.h

--
-Denny


