Return-Path: <linux-rdma+bounces-22511-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U7n1OWT5P2qNawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22511-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B96D23EB
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=gphfkYJP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22511-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22511-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F66F301690A
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03492E6116;
	Sat, 27 Jun 2026 16:25:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020105.outbound.protection.outlook.com [52.101.193.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145D1E5702
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577505; cv=fail; b=NTD+/Z+LYRTqxS/C5VGCe9VKXw5sjQopRIqKzEpQUwzGDVzxIDZrMwm4i56NivsFFDpCrnSPGYvlk/CZGjkostHE9zVqRSFcwF6QxQRMSWiCr49Eq68C+Upr6LHT1uX48AacLF32UTdT2P58M8ehUtr+UYngJ2bFs+rsFPwlIuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577505; c=relaxed/simple;
	bh=Xt+gEqjIT9cuPEi2iwZ0gtD18RqPViP7/z6uidnS8WM=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=qCHln8mC7D8hMGwlZJvs7vm7ZU4NCW6rny4S4TDE1cMVX4W8l2g+BTwFlio8f1+lpjBDo3laECdCwhJ4rcxSqhfsKhydbl8lT/Z2NrvbOHLrE3yNOzpAQrSs0xfkSgZqsSWq1mfsu8XUraA3uJ552k/1qL/nVlHy+97nvh4XmLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=gphfkYJP; arc=fail smtp.client-ip=52.101.193.105
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4kAYUHRGOf4jBhxfwYnGQMmERB0xlnol3lyyNON4Rxok0BIEWwjIWTegkYH1DTbvdXxf40L+uX8kG6t0bNq3yltynr8EUd2w9oS7ySAED2P1KKp4Avgp1PB0NSfr5fLBDq1ypwIFgkJtEzHhjEJm556XJZNKwXnE96S1y8LQ5KYFoSQIwoN7PDOpkSIkK39s2s0xrxlFHpKhq5dmnJY5Dsc40LAqOVBtUH58ihbaZbuoyQROMdCaWzT+k/MRIYgGLDlDX09WDuhqCRAx2zukV2aPC45vv/sP9k2o91mRuUSEJLJObB8wc7ZGq/uLaIpSGtfTH2xX/Kh0RCr8ZD6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r81ZKEGVHT52kbt+QFWfbIw7tJBoy9qpnZU0MDnZ//I=;
 b=aDk8V/agHoDmFZGTJZr/MJVIXHdFHUj4+LpDL2kieooSsipbP/56KPC3iKSkwG2C9ZNG3FKWHjbYw9kj5cJscV1LtRa0dAoGH1jRqagEdlI5heMf9GBbjiNcco5vFmOUqqkpqjCVEo3pC71mInl+GvSVHVFy6D313Gf0FiKQUE6QJ0qFNUVHgBczQK1gXyq4zQfoivrmD7TZdBT/M5XzhjO5VU8qBarkVwp8lpA41pGcD5a6fXpWgPmHIlrt9OIuhhHyGfM1Z18Iavy0cEJdVfU9Up99lWnkKPaYX6WmLceqDDFh2DpW5LUcvjV+JDWkCB1NCbhynK7EYZFeq7CDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=arndb.de
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r81ZKEGVHT52kbt+QFWfbIw7tJBoy9qpnZU0MDnZ//I=;
 b=gphfkYJPg6w7bWiJ+0sPiKKckYfNyCSFuIZc4zVgKZcSa+HXYonppibZ3VxkJICj5KCaqdazKdW3eSDccRNV5Bc215slsL73zS72A5fXdWz/iDHTKQssd9PPzHn16vjazM7ff1pPcbY51Vtthu4FPkSL5k2FMOtCsiw2KnqNBUWfwG5cXGa/dV/rrx7iFkXeorA9/abaX6r8VFXCKgaRm6EE0jnmEGkCxDjvda6+M60JBRQiuBcCEWhiQ2yLn1F9TeCt2+rT/5xUhBsMNyRg/EpjvloCnVTwpTdn525R+Vj435oW8+S0BT4CuUNeDXJQl20f6KsSXwMuGm17M3tqUQ==
Received: from SJ0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:a03:39e::14)
 by CY2PR01MB681791.prod.exchangelabs.com (2603:10b6:930:110::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 16:24:56 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::85) by SJ0PR03CA0279.outlook.office365.com
 (2603:10b6:a03:39e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:24:55 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 7D895146565;
	Sat, 27 Jun 2026 12:24:54 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 5E0BA1810D6C7;
	Sat, 27 Jun 2026 12:24:54 -0400 (EDT)
Subject: [PATCH v2 for-next 00/24] Migrate to hfi2 driver
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Douglas Miller <doug.miller@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:24:54 -0400
Message-ID: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CY2PR01MB681791:EE_
X-MS-Office365-Filtering-Correlation-Id: ef403930-be11-4bbd-bc68-08ded4689fb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|3023799007|55112099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SAJYJcCYVdTbhQy5tN1DTq9+7fqgbCXbLr5kEhTgH36qF+InfhjbaONoaAjoxuE6FdoFCKW0IHymFwWQG3gN68cAYXQYZvvkzwlNX9zhAuYjjToBVguLEv3e0EH7yDD29o8MDnC1VCovmsJdoyyHWSIxBgjDeNzsasFamIiIJJPgTZYRcyuFWKZ1D1t6PNL4TMY5bCWxXtaobVdIQVSJUQhAme1tXmStWXXnfx/hp2SBXHBGtKQzgdsKWOmjjdmREzk8oB+6wWcEt2DyW+TixYfQoZwJPx5pjVwjuQ4LPBO31kKvHhsMVzpsJR1Pl0TBE+84Eb41k0Tleid29asKXDEaFQkh0e2kSGGCYWsf5lX2+4/S3lOMC9JQ3Qrc5UU7+n82WzLfTPENP+YutespkBxfYhJk5Qdm/uzwmT0irZlqKQHEVjF5FCtrprWIBkF4iNNp0/ZAcjCFPkquJUqwEUr2g2hrL62HN2Ve1+c8dj0dKJ7jvA8oTwoHXlL5fWbgtI1KFcMDFrIwwZ9n5ed9+wzcs9f1QoMRU/be5VffMHgPzdXuS5a9dHwjeV6NErpZevWGYtTCgxwLd46cST6Gp0Z0jBI6VlX4gSh0rn0wzZ67ya8Z6qQxUjSQpt/xWDHascGqDCE3PBVeBpqJArzV6ixVGmKvEdgA0d8AxFCiQjKla7uzbB0AjM03mgXPvCms3BMElOerhW/+SwU4ODQL0Q==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(3023799007)(55112099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pw3LkGhc76Q/gNWHw+RPBKlWsMwK8B45CVojHPCu06FHUWuan8ubsvpmaAat33/sNTZmqe3kMc2ThE5iWKs81RQMQ/vnvtOdSx5GniRvXNt/LajfmlEF+YKu2C7Ce6XJJZVkdV+eZ9PuMC072h0kne8lcOGjrVGOqE8IjeIo7mIt0jibzjFhSmELIwgX1i0XyJRxOxUTL3jnfWdvYPPkfPK3bZTws02iil7FAAPfIUgndPbAvu4Zz9OVAMWJIyu8LB2++06s68ShH+N1NcN+7iL8UWJJpK8Rg0jCkEwcm0vto20BLmHiqSz2HetMsfMT2zvyp1K3hhemqHxZKa56cBwukwEvj/HEafT/USWD6f2UZPXnk1H/7WZaXGXLmWsAfLST6LLEJ3oRsOZqK+8evokHBn9Qw5oI+4Y767BoBJO1NY+jkQwf+fJVHJLC5OjN
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:24:55.2700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef403930-be11-4bbd-bc68-08ded4689fb7
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR01MB681791
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22511-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:arnd@arndb.de,m:doug.miller@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC8B96D23EB

While sharing similar bones, the chip for the Cornelis Networks next
generation fabric technology has some fundamental differences that
resulted in a near complete re-write of the driver. It also does not
use the private cdev interface that the hfi1 driver exposes. After
discussing this with the RDMA maintainers we have decided to go with
the approach of moving to a new driver and declaring hfi1 obsolete.

It is desirable to keep hfi1 around temporarily to let user APIs
catch up to support access through the uverbs device rather than the
private hfi1 cdev.

This driver is designed to support future products as well.

This series applies on top of the rdma/for-next branch.

This series will be followed up to pick up any remaining changes from
hfi1 that were not yet incorporated in our internal development tree.

Changelogs in individual patches but the highligths are as follows…

Changes since v1:
- Broke up the large MAD and verbs patches that exceeded 3K LOC.
  Machine-generated counter accessor functions are now separated
  from real logic into their own patches (Leon Romanovsky).
- Removed all TODO stubs (e.g., jkr_handle_link_bounce()) that only
  printed a warning. Cleaned up unnecessary casts, unused parameters,
  and other minor style issues (Jason Gunthorpe).
- Removed dead declarations from system core headers, including
  hfi2_cdev_cleanup() and similar functions that were declared but
  never defined (Jason Gunthorpe).
- Modernized hfi2_rdma_mmap() to use the rdma_user_mmap_io /
  rdma_user_mmap_entry infrastructure as required for new drivers
  (Jason Gunthorpe).
- The opa_vnic removal was submitted as a separate independent
  series per reviewer request (Leon Romanovsky).
- Replaced the writev-on-uverbs-fd approach with an anonymous
  'hfi2-sdma' file descriptor returned via ioctl. The data path
  write_iter is registered on the anonymous fd, avoiding any changes
  to the uverbs core.


---

Dennis Dalessandro (24):
      RDMA/hfi2: Start hfi2 driver by basing off of hfi1
      RDMA/hfi2: Add in HW register definition files
      RDMA/hfi2: Add counter accessor functions
      RDMA/hfi2: Add in HW register access support
      RDMA/hfi2: Add in trace header files
      RDMA/hfi2: Add in trace support
      RDMA/hfi2: Add system core header files
      RDMA/hfi2: Add driver and interrupt infrastructure
      RDMA/hfi2: Add initialization and firmware support
      RDMA/hfi2: Add in MAD handling related headers
      RDMA/hfi2: Add cport management
      RDMA/hfi2: Implement MAD handling
      RDMA/hfi2: Add IO related headers
      RDMA/hfi2: Add PIO send infrastructure
      RDMA/hfi2: Add SDMA infrastructure
      RDMA/hfi2: Implement data moving infrastructure
      RDMA/hfi2: Add verbs core
      RDMA/hfi2: Add RC protocol support
      RDMA/hfi2: Add in support for verbs
      RDMA/hfi2: Add misc header files
      RDMA/hfi2: Add the rest of the driver
      RDMA/hfi2: Make it build and add TODO list
      RDMA/hfi2: Modernize mmap to use rdma_user_mmap_entry infrastructure
      RDMA/hfi2: Support ipoib


 drivers/infiniband/hw/hfi1/Kconfig            |     5 +-
 drivers/infiniband/hw/hfi2/Kconfig            |    32 +
 drivers/infiniband/hw/hfi2/Makefile           |    75 +
 drivers/infiniband/hw/hfi2/TODO               |     6 +
 drivers/infiniband/hw/hfi2/affinity.c         |    75 +
 drivers/infiniband/hw/hfi2/affinity.h         |    26 +
 drivers/infiniband/hw/hfi2/chip.c             | 12948 ++++++++++++++++
 drivers/infiniband/hw/hfi2/chip.h             |  1445 ++
 drivers/infiniband/hw/hfi2/chip_counters.c    |  4162 +++++
 drivers/infiniband/hw/hfi2/chip_gen.c         |  1151 ++
 drivers/infiniband/hw/hfi2/chip_gen.h         |    44 +
 drivers/infiniband/hw/hfi2/chip_jkr.c         |  1017 ++
 drivers/infiniband/hw/hfi2/chip_jkr.h         |   128 +
 drivers/infiniband/hw/hfi2/chip_registers.h   |  1301 ++
 .../infiniband/hw/hfi2/chip_registers_jkr.h   |   251 +
 drivers/infiniband/hw/hfi2/common.h           |   331 +
 drivers/infiniband/hw/hfi2/cport.c            |  1017 ++
 drivers/infiniband/hw/hfi2/cport.h            |   275 +
 drivers/infiniband/hw/hfi2/cport_traps.h      |    43 +
 drivers/infiniband/hw/hfi2/debugfs.c          |  1535 ++
 drivers/infiniband/hw/hfi2/debugfs.h          |    66 +
 drivers/infiniband/hw/hfi2/driver.c           |  1917 +++
 drivers/infiniband/hw/hfi2/efivar.c           |   139 +
 drivers/infiniband/hw/hfi2/efivar.h           |    17 +
 drivers/infiniband/hw/hfi2/eprom.c            |   451 +
 drivers/infiniband/hw/hfi2/eprom.h            |    11 +
 drivers/infiniband/hw/hfi2/exp_rcv.c          |    79 +
 drivers/infiniband/hw/hfi2/exp_rcv.h          |   157 +
 drivers/infiniband/hw/hfi2/fault.c            |   325 +
 drivers/infiniband/hw/hfi2/fault.h            |    70 +
 drivers/infiniband/hw/hfi2/file_ops.c         |  1168 ++
 drivers/infiniband/hw/hfi2/file_ops.h         |    49 +
 drivers/infiniband/hw/hfi2/firmware.c         |  2267 +++
 drivers/infiniband/hw/hfi2/hfi2.h             |  3461 +++++
 drivers/infiniband/hw/hfi2/init.c             |  2924 ++++
 drivers/infiniband/hw/hfi2/intr.c             |   296 +
 drivers/infiniband/hw/hfi2/iowait.c           |   129 +
 drivers/infiniband/hw/hfi2/iowait.h           |   458 +
 drivers/infiniband/hw/hfi2/ipoib.h            |   173 +
 drivers/infiniband/hw/hfi2/ipoib_main.c       |   252 +
 drivers/infiniband/hw/hfi2/ipoib_rx.c         |    93 +
 drivers/infiniband/hw/hfi2/ipoib_tx.c         |   872 ++
 drivers/infiniband/hw/hfi2/mad.c              |  6503 ++++++++
 drivers/infiniband/hw/hfi2/mad.h              |   441 +
 drivers/infiniband/hw/hfi2/mmu_rb.c           |   344 +
 drivers/infiniband/hw/hfi2/mmu_rb.h           |    78 +
 drivers/infiniband/hw/hfi2/msix.c             |   422 +
 drivers/infiniband/hw/hfi2/msix.h             |    32 +
 drivers/infiniband/hw/hfi2/netdev.h           |    94 +
 drivers/infiniband/hw/hfi2/netdev_rx.c        |   494 +
 drivers/infiniband/hw/hfi2/opa_compat.h       |    87 +
 drivers/infiniband/hw/hfi2/opfn.c             |   324 +
 drivers/infiniband/hw/hfi2/opfn.h             |    88 +
 drivers/infiniband/hw/hfi2/pcie.c             |  1444 ++
 drivers/infiniband/hw/hfi2/pin_system.c       |   539 +
 drivers/infiniband/hw/hfi2/pinning.c          |    66 +
 drivers/infiniband/hw/hfi2/pinning.h          |    74 +
 drivers/infiniband/hw/hfi2/pio.c              |  2241 +++
 drivers/infiniband/hw/hfi2/pio.h              |   307 +
 drivers/infiniband/hw/hfi2/pio_copy.c         |   733 +
 drivers/infiniband/hw/hfi2/platform.c         |   982 ++
 drivers/infiniband/hw/hfi2/platform.h         |   372 +
 drivers/infiniband/hw/hfi2/qp.c               |  1048 ++
 drivers/infiniband/hw/hfi2/qp.h               |   112 +
 drivers/infiniband/hw/hfi2/qsfp.c             |   788 +
 drivers/infiniband/hw/hfi2/qsfp.h             |   202 +
 drivers/infiniband/hw/hfi2/rc.c               |  3276 ++++
 drivers/infiniband/hw/hfi2/rc.h               |    60 +
 drivers/infiniband/hw/hfi2/ruc.c              |   622 +
 drivers/infiniband/hw/hfi2/sdma.c             |  3989 +++++
 drivers/infiniband/hw/hfi2/sdma.h             |  1209 ++
 drivers/infiniband/hw/hfi2/sdma_defs.h        |   113 +
 drivers/infiniband/hw/hfi2/sdma_txreq.h       |   105 +
 drivers/infiniband/hw/hfi2/sriov.c            |   418 +
 drivers/infiniband/hw/hfi2/sriov.h            |    34 +
 drivers/infiniband/hw/hfi2/sysfs.c            |   878 ++
 drivers/infiniband/hw/hfi2/tid_rdma.c         |  5485 +++++++
 drivers/infiniband/hw/hfi2/tid_rdma.h         |   321 +
 drivers/infiniband/hw/hfi2/tid_system.c       |   481 +
 drivers/infiniband/hw/hfi2/trace.c            |   536 +
 drivers/infiniband/hw/hfi2/trace.h            |    26 +
 drivers/infiniband/hw/hfi2/trace_ctxts.h      |   116 +
 drivers/infiniband/hw/hfi2/trace_dbg.h        |   119 +
 drivers/infiniband/hw/hfi2/trace_ibhdrs.h     |   458 +
 drivers/infiniband/hw/hfi2/trace_iowait.h     |    55 +
 drivers/infiniband/hw/hfi2/trace_misc.h       |   109 +
 drivers/infiniband/hw/hfi2/trace_mmu.h        |    73 +
 drivers/infiniband/hw/hfi2/trace_pin.h        |   201 +
 drivers/infiniband/hw/hfi2/trace_rc.h         |   126 +
 drivers/infiniband/hw/hfi2/trace_rx.h         |   112 +
 drivers/infiniband/hw/hfi2/trace_tid.h        |  1687 ++
 drivers/infiniband/hw/hfi2/trace_tx.h         |  1187 ++
 drivers/infiniband/hw/hfi2/uc.c               |   543 +
 drivers/infiniband/hw/hfi2/ud.c               |  1037 ++
 drivers/infiniband/hw/hfi2/user_exp_rcv.c     |  1014 ++
 drivers/infiniband/hw/hfi2/user_exp_rcv.h     |   404 +
 drivers/infiniband/hw/hfi2/user_pages.c       |   106 +
 drivers/infiniband/hw/hfi2/user_sdma.c        |  1671 ++
 drivers/infiniband/hw/hfi2/user_sdma.h        |   261 +
 drivers/infiniband/hw/hfi2/uverbs.c           |   798 +
 drivers/infiniband/hw/hfi2/uverbs.h           |    39 +
 drivers/infiniband/hw/hfi2/verbs.c            |  2034 +++
 drivers/infiniband/hw/hfi2/verbs.h            |   463 +
 drivers/infiniband/hw/hfi2/verbs_txreq.c      |   101 +
 drivers/infiniband/hw/hfi2/verbs_txreq.h      |    98 +
 drivers/infiniband/hw/hfi2/vf2pf.c            |  1106 ++
 drivers/infiniband/hw/hfi2/vf2pf.h            |    54 +
 drivers/infiniband/hw/hfi2/vf2pf_int.h        |   181 +
 drivers/infiniband/hw/hfi2/vf2pf_lb.c         |   967 ++
 drivers/infiniband/hw/hfi2/vf2pf_lb.h         |    52 +
 drivers/infiniband/sw/rdmavt/mmap.c           |     7 +-
 include/uapi/rdma/hfi2-abi.h                  |   678 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |    47 +-
 113 files changed, 92484 insertions(+), 29 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi2/Kconfig
 create mode 100644 drivers/infiniband/hw/hfi2/Makefile
 create mode 100644 drivers/infiniband/hw/hfi2/TODO
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.c
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_counters.c
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
 create mode 100644 drivers/infiniband/hw/hfi2/sriov.c
 create mode 100644 drivers/infiniband/hw/hfi2/sriov.h
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
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf.c
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf.h
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf_int.h
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf_lb.c
 create mode 100644 drivers/infiniband/hw/hfi2/vf2pf_lb.h
 create mode 100644 include/uapi/rdma/hfi2-abi.h

--

-Denny


