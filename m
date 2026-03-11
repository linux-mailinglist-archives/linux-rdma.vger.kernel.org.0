Return-Path: <linux-rdma+bounces-17984-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ1vDzessWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17984-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:53:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16D268481
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4DAB3025A65
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14793E5584;
	Wed, 11 Mar 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="dtrMfQN+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020117.outbound.protection.outlook.com [52.101.201.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03B35A930
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251636; cv=fail; b=hEG+YDZz9Yacrj9+PlVJ4VfhDUFg5ZfzL/ASnMZ1dVC1XrN3lW1EzDOkLE8caMSGDzRkLHjMknp+y7vglBLIJfZ6E682olvPjNtV+O7vk7ewok20vWO5HeiLytKKT93THGlsTXRasEpJgdUoEAHWRwN1ByWYAUiUMuquOd6VSlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251636; c=relaxed/simple;
	bh=u5bAZt8TUm0vhNQJcdgNrgLe74Bujg5xHwfYxCRiAPw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=gh3+izgtA/ZeUzOC+3JqRm9k6hKc5CHA9t3Vm79TZNPPTctFvzyEZS5FFPeEqAXKVk8lCxe3rK3VrBGvSjZnGQ03TlHIglSsavcyAdFG1z+Ze0nrMp343smOU4DOiDbFYAcz1tzurmcGBtoNUIiD1ipU0XxgyZ044ABRE3eMsU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=dtrMfQN+; arc=fail smtp.client-ip=52.101.201.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bn+4UjWcTmrDXbV3/i5dBttvKPvQwOvrI+kT8KVElkxfrzFeAHqDfRA83BDktiCSUloHhc76EvhAMRlX8UDM8j2OfIdIEOLG4VKqzD2aYQit/zMu5VehqTS/8t18ve/Vmjaj8yQJYNKkV+e5dmiK4t54BFe+sIIVR2Cn9VBtz27m+Lo/SAhxeUrFQwO5OCJuB1Q1oQxISS+JYu1Ydvkzb+OMVfwImJlOBdb546/IjmWxm1iTmMFrb7XceS72M2uInueWr8gba5yiAz4mhidjngQ0P8RT50D9TgMQkg5alPU6Rmr/tkHKqNvWH7vcLUiRWKUnweXsL6Fnr9IYLe1GSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U3jqbjQrFPw8o+ijwKoTpHUXClC8tPhal6bL3Uki/k=;
 b=hwCknLuRamhFeJo7voeEFBTe2+JdBA9Auw9KlfhpXaVZwtD2nX8RTF93wAvQF2mMbEqyuy9b1GEBv3jFKwaosBzES1xJ5hsTkkVnsqLAqEN29KMOvfwpQN5v+gb94XePe9CuZslLrz4VUbREpfFaGVZlExYwT9MqzD04Lzpps+C8CTSOnwWuCOsYAtZr2MTkk9IFzgR9o2SX0NUr8PAynTVwmhnWd64Ad6AuwQFpDQK7Lm3lOUhyYmrjE3L3FiclN+UNxINAQeA28MOS5AOhR3E4rnAW7T5C/av8JNXDM2u+a+bWf8xZuDnXfHaKimAdpB/MU6alLxqhJnHMQiWZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U3jqbjQrFPw8o+ijwKoTpHUXClC8tPhal6bL3Uki/k=;
 b=dtrMfQN+8jye5VZEtGXhOExhIrej5XSFGxcn2k955xKM4qLYOKh+OWcuoNdsODH7aQJA1VdsOAMPZ2N3KgQEQXB6jBY6akCqcAevRliioB+NhAqJjaMEaSONvHHY9tWhaVFv9IqdyefKVewipckQNw6Ch86331vcnn7T42xmvn8jeecZCgt3liM6DOrhAhhCM0bGhdIG0lvOVDdlhALaSa9VH0yEO44hwX0lo5Iw22wAU9pJDaWu+HizW6xISZRjPynayqAE92t/V/awLgM4Tq6c8Q88KEDL7aX7VN7wAWyly0/QWWaGwrzzCM0czZgUk/0tBBNJq9Ukl9OlXk3nCg==
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by CO1PR01MB6757.prod.exchangelabs.com (2603:10b6:303:d6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.15; Wed, 11 Mar 2026 17:53:38 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::b6) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:53:45 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 890F014D817;
	Wed, 11 Mar 2026 13:53:45 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 6C4081810D6C5;
	Wed, 11 Mar 2026 13:53:45 -0400 (EDT)
Subject: [PATCH for-next resend 00/24] Migrate to hfi2 driver
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>,
 Dean Luick <dean.luick@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:53:45 -0400
Message-ID:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CO1PR01MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec99713-6980-48ea-8e7f-08de7f97245f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|34020700016|36860700016|376014|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	i+Uw4wzZKR+r4ztNi4cXjsPeqa7jgDwG8U9y4kqO7Zwz2b1W+YsmBrkBcisDUNBT1UpIa0zxwIFg6SVUi13/ug8oA/P/LRmMwKoKeA5XchBWBJFlbEaudssVbEMgUTWJ9lDjMjvOfyMAOHcTxJ3bvLnRBJ72jRj1lIuGHJKJfQQyCnX7l2rxbS6d+aqtTmhRcKZjNTVYgBStDbBF5MsJt1fKf6kShkjw/lxRtxKnToee3c9xjS5KWIWZtZv2M7jQ6mWKbs/CZjKlk2oXP8KS7eC39+YMfCTyCk63t4u90JEIbr6tnbMGWu5rreY+6iog2tlXqIF1WIa1mAV3byQNKB5V4zTPDu351RECeBcOzjJQweoqXqrbgOVOsfcwDrRMWnTeaxMOAo+L+r2+r60ydVpQX3JvisEoBwm5FxsPCyxiLZSCjs+1M2wFgAG8QBJMx26joCnMtqb6qBjescASg11OK7hEdh0cdlW+h60zXCI74zXKpOf4PzOVr9tCn07E8Plx+XAs7ePA6ZZDaaDpMV2mP64f7IqBanq1ZAjZ2biYfQUR0p58eLRbtKJAc1CvIpEDNQowZtZMStvZoEfa7LeLMcXPEZQd9tO/lj4bbTyvAx2bTcK4V7RUKy1u1WfwKgX6LbkvyLxGKjSbNSH3TazdaOorrqXRzSFAmkczigo4UhzVAviHVqvbNCtFo480rM/haSGWeeY6S93uJ9M1idBFukpqmMvjuExsWn0uL3iwtGN+B1ewCwajWK+79ja4jx3abnYb45Qarp5wUq9rbg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(34020700016)(36860700016)(376014)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qUcXTdWBGyF2s5koAA0XWrFwUMfBFX+Gu4XyYDSiuN2wb67dzu9B12yY3XMXYXc1d2dH2Jgm4AQdltHFx9Fch8azL26CQUAxHeold+dv2HzBTqf/csthEf0mbuM4Y7YFvbx/7wbrUqF6dYZNFPXH4PyO3dPbPZ86C/+BEJdrV3274MEjtWGBhXI3G764UYh1NnmTnqnSd5l0Ad4dcJp6Yyd07C6rsGk18Lk6qHpmEmPoS4thkbj8gupBby8DHgtrXlyNM+feOCbajodqNqkexo6xY407W3It8R5JOwgcBD5IZ2aVeRBye6yt/QnHAWDD7zEiRxb+Ht68usH5zBLPQSyqDC92OkZFEq/5/QJxIcz3Xxb4M73NSpI8CdH9E9aUOwuL+xMRKn+ghKUSIgB4jGqTY5TtKztQTzVbqsFSjcJgUkrLEIIdDB9OQwqyPfGN
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:53:45.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec99713-6980-48ea-8e7f-08de7f97245f
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6757
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17984-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,awdrv-04.cornelisnetworks.com:mid,cornelisnetworks.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: BD16D268481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies for re-sending but even my cover letter bounced so no hope of
getting thigns to thread properly. Re-sending the whole series.

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

This series will be followed up to pick up any remaining changes from
hfi1 that were not yet incorporated in our internal development tree.
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
- The opa_vnic removal is being submitted as a separate independent
  series per reviewer request (Leon Romanovsky).

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
      RDMA/hfi2: Support ipoib
      RDMA/hfi2: Add misc header files
      RDMA/hfi2: Add the rest of the driver
      RDMA/hfi2: Make it build
      RDMA/hfi2: Modernize mmap to use rdma_user_mmap_entry infrastructure


 MAINTAINERS                                   |     8 +-
 drivers/infiniband/Kconfig                    |     1 +
 drivers/infiniband/hw/Makefile                |     1 +
 drivers/infiniband/hw/hfi2/Kconfig            |    25 +
 drivers/infiniband/hw/hfi2/Makefile           |    76 +
 drivers/infiniband/hw/hfi2/affinity.c         |  1194 ++
 drivers/infiniband/hw/hfi2/affinity.h         |    86 +
 drivers/infiniband/hw/hfi2/aspm.c             |   286 +
 drivers/infiniband/hw/hfi2/aspm.h             |    36 +
 drivers/infiniband/hw/hfi2/chip.c             | 12762 ++++++++++++++++
 drivers/infiniband/hw/hfi2/chip.h             |  1436 ++
 drivers/infiniband/hw/hfi2/chip_counters.c    |  4129 +++++
 drivers/infiniband/hw/hfi2/chip_gen.c         |  1093 ++
 drivers/infiniband/hw/hfi2/chip_gen.h         |    44 +
 drivers/infiniband/hw/hfi2/chip_jkr.c         |   989 ++
 drivers/infiniband/hw/hfi2/chip_jkr.h         |   128 +
 drivers/infiniband/hw/hfi2/chip_registers.h   |  1301 ++
 .../infiniband/hw/hfi2/chip_registers_jkr.h   |   251 +
 drivers/infiniband/hw/hfi2/common.h           |   336 +
 drivers/infiniband/hw/hfi2/cport.c            |  1037 ++
 drivers/infiniband/hw/hfi2/cport.h            |   265 +
 drivers/infiniband/hw/hfi2/cport_traps.h      |    43 +
 drivers/infiniband/hw/hfi2/debugfs.c          |  1551 ++
 drivers/infiniband/hw/hfi2/debugfs.h          |    66 +
 drivers/infiniband/hw/hfi2/driver.c           |  1962 +++
 drivers/infiniband/hw/hfi2/efivar.c           |   139 +
 drivers/infiniband/hw/hfi2/efivar.h           |    17 +
 drivers/infiniband/hw/hfi2/eprom.c            |   451 +
 drivers/infiniband/hw/hfi2/eprom.h            |    11 +
 drivers/infiniband/hw/hfi2/exp_rcv.c          |    79 +
 drivers/infiniband/hw/hfi2/exp_rcv.h          |   157 +
 drivers/infiniband/hw/hfi2/fault.c            |   325 +
 drivers/infiniband/hw/hfi2/fault.h            |    70 +
 drivers/infiniband/hw/hfi2/file_ops.c         |  1205 ++
 drivers/infiniband/hw/hfi2/file_ops.h         |    49 +
 drivers/infiniband/hw/hfi2/firmware.c         |  2267 +++
 drivers/infiniband/hw/hfi2/hfi2.h             |  3473 +++++
 drivers/infiniband/hw/hfi2/init.c             |  2931 ++++
 drivers/infiniband/hw/hfi2/intr.c             |   296 +
 drivers/infiniband/hw/hfi2/iowait.c           |   129 +
 drivers/infiniband/hw/hfi2/iowait.h           |   458 +
 drivers/infiniband/hw/hfi2/ipoib.h            |   173 +
 drivers/infiniband/hw/hfi2/ipoib_main.c       |   258 +
 drivers/infiniband/hw/hfi2/ipoib_rx.c         |    93 +
 drivers/infiniband/hw/hfi2/ipoib_tx.c         |   872 ++
 drivers/infiniband/hw/hfi2/mad.c              |  6531 ++++++++
 drivers/infiniband/hw/hfi2/mad.h              |   450 +
 drivers/infiniband/hw/hfi2/mmu_rb.c           |   344 +
 drivers/infiniband/hw/hfi2/mmu_rb.h           |    78 +
 drivers/infiniband/hw/hfi2/msix.c             |   450 +
 drivers/infiniband/hw/hfi2/msix.h             |    31 +
 drivers/infiniband/hw/hfi2/netdev.h           |    96 +
 drivers/infiniband/hw/hfi2/netdev_rx.c        |   494 +
 drivers/infiniband/hw/hfi2/opa_compat.h       |    87 +
 drivers/infiniband/hw/hfi2/opfn.c             |   324 +
 drivers/infiniband/hw/hfi2/opfn.h             |    88 +
 drivers/infiniband/hw/hfi2/pcie.c             |  1459 ++
 drivers/infiniband/hw/hfi2/pin_system.c       |   539 +
 drivers/infiniband/hw/hfi2/pinning.c          |    66 +
 drivers/infiniband/hw/hfi2/pinning.h          |    74 +
 drivers/infiniband/hw/hfi2/pio.c              |  2236 +++
 drivers/infiniband/hw/hfi2/pio.h              |   307 +
 drivers/infiniband/hw/hfi2/pio_copy.c         |   710 +
 drivers/infiniband/hw/hfi2/platform.c         |  1041 ++
 drivers/infiniband/hw/hfi2/platform.h         |   372 +
 drivers/infiniband/hw/hfi2/qp.c               |  1105 ++
 drivers/infiniband/hw/hfi2/qp.h               |   112 +
 drivers/infiniband/hw/hfi2/qsfp.c             |   788 +
 drivers/infiniband/hw/hfi2/qsfp.h             |   202 +
 drivers/infiniband/hw/hfi2/rc.c               |  3276 ++++
 drivers/infiniband/hw/hfi2/rc.h               |    60 +
 drivers/infiniband/hw/hfi2/ruc.c              |   622 +
 drivers/infiniband/hw/hfi2/sdma.c             |  3998 +++++
 drivers/infiniband/hw/hfi2/sdma.h             |  1209 ++
 drivers/infiniband/hw/hfi2/sdma_defs.h        |   113 +
 drivers/infiniband/hw/hfi2/sdma_txreq.h       |   105 +
 drivers/infiniband/hw/hfi2/sriov.c            |   429 +
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
 drivers/infiniband/hw/hfi2/user_exp_rcv.c     |  1013 ++
 drivers/infiniband/hw/hfi2/user_exp_rcv.h     |   404 +
 drivers/infiniband/hw/hfi2/user_pages.c       |   108 +
 drivers/infiniband/hw/hfi2/user_sdma.c        |  1667 ++
 drivers/infiniband/hw/hfi2/user_sdma.h        |   261 +
 drivers/infiniband/hw/hfi2/uverbs.c           |   736 +
 drivers/infiniband/hw/hfi2/uverbs.h           |    41 +
 drivers/infiniband/hw/hfi2/verbs.c            |  2110 +++
 drivers/infiniband/hw/hfi2/verbs.h            |   496 +
 drivers/infiniband/hw/hfi2/verbs_txreq.c      |   101 +
 drivers/infiniband/hw/hfi2/verbs_txreq.h      |    98 +
 drivers/infiniband/hw/hfi2/vf2pf.c            |  1111 ++
 drivers/infiniband/hw/hfi2/vf2pf.h            |    54 +
 drivers/infiniband/hw/hfi2/vf2pf_int.h        |   181 +
 drivers/infiniband/hw/hfi2/vf2pf_lb.c         |   966 ++
 drivers/infiniband/hw/hfi2/vf2pf_lb.h         |    52 +
 drivers/infiniband/sw/rdmavt/mmap.c           |     1 +
 114 files changed, 93338 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hfi2/Kconfig
 create mode 100644 drivers/infiniband/hw/hfi2/Makefile
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.c
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.c
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
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

--
-Denny


