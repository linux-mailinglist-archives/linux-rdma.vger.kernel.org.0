Return-Path: <linux-rdma+bounces-2827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD88FB1E1
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB491C20BCA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D0145B2D;
	Tue,  4 Jun 2024 12:14:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17D5145A1D
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 12:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503264; cv=none; b=gdpN5IAV5dw53kDjNMGGE6vxyZ26m5tKcdpuHQLK6a/uf52pfS6zsgmb/hDGZhzCesbw8Pmx/SeJl8BZ4t9SkbmJnSoTE8LSvmiAU5T7RTY5L60v/xWWCZ4uGn8UggVan6knYE6Z/yZ17sje6B6dS8IKg/Vm0ltaFYIFj0zDLOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503264; c=relaxed/simple;
	bh=GywndVMWTn9z5KPv1ebAn4b1QO6DeMqETldw1k5A5bM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mNvwLuK5ev3yY23MoV2Ofwu0JWwtMAaniPtH0invlHQ7br2XGpEL3a9K9eruOQaQGNLM1jP+zyvM1ywYeVik8TCiAxz8hRyjUfDfyxWT+KrcagcPOtoRqCgYa9PsheCTiNhB/j35LRi7Sivy8jTxVpd6Hf1Evnd9UksIjxSgDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VtqDH0l8gzxRTf;
	Tue,  4 Jun 2024 20:10:23 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CF78D180085;
	Tue,  4 Jun 2024 20:14:18 +0800 (CST)
Received: from DESKTOP-8LI8G6S.china.huawei.com (10.173.124.235) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Jun 2024 20:14:18 +0800
From: Gonglei <arei.gonglei@huawei.com>
To: <qemu-devel@nongnu.org>
CC: <peterx@redhat.com>, <yu.zhang@ionos.com>, <mgalaxy@akamai.com>,
	<elmar.gerdes@ionos.com>, <zhengchuan@huawei.com>, <berrange@redhat.com>,
	<armbru@redhat.com>, <lizhijian@fujitsu.com>, <pbonzini@redhat.com>,
	<mst@redhat.com>, <xiexiangyou@huawei.com>, <linux-rdma@vger.kernel.org>,
	<lixiao91@huawei.com>, <arei.gonglei@huawei.com>, <jinpu.wang@ionos.com>,
	Jialin Wang <wangjialin23@huawei.com>
Subject: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Date: Tue, 4 Jun 2024 20:14:06 +0800
Message-ID: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.8.2.windows.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

From: Jialin Wang <wangjialin23@huawei.com>

Hi,

This patch series attempts to refactor RDMA live migration by
introducing a new QIOChannelRDMA class based on the rsocket API.

The /usr/include/rdma/rsocket.h provides a higher level rsocket API
that is a 1-1 match of the normal kernel 'sockets' API, which hides the
detail of rdma protocol into rsocket and allows us to add support for
some modern features like multifd more easily.

Here is the previous discussion on refactoring RDMA live migration using
the rsocket API:

https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/

We have encountered some bugs when using rsocket and plan to submit them to
the rdma-core community.

In addition, the use of rsocket makes our programming more convenient,
but it must be noted that this method introduces multiple memory copies,
which can be imagined that there will be a certain performance degradation,
hoping that friends with RDMA network cards can help verify, thank you!

Jialin Wang (6):
  migration: remove RDMA live migration temporarily
  io: add QIOChannelRDMA class
  io/channel-rdma: support working in coroutine
  tests/unit: add test-io-channel-rdma.c
  migration: introduce new RDMA live migration
  migration/rdma: support multifd for RDMA migration

 docs/rdma.txt                     |  420 ---
 include/io/channel-rdma.h         |  165 ++
 io/channel-rdma.c                 |  798 ++++++
 io/meson.build                    |    1 +
 io/trace-events                   |   14 +
 meson.build                       |    6 -
 migration/meson.build             |    3 +-
 migration/migration-stats.c       |    5 +-
 migration/migration-stats.h       |    4 -
 migration/migration.c             |   13 +-
 migration/migration.h             |    9 -
 migration/multifd.c               |   10 +
 migration/options.c               |   16 -
 migration/options.h               |    2 -
 migration/qemu-file.c             |    1 -
 migration/ram.c                   |   90 +-
 migration/rdma.c                  | 4205 +----------------------------
 migration/rdma.h                  |   67 +-
 migration/savevm.c                |    2 +-
 migration/trace-events            |   68 +-
 qapi/migration.json               |   13 +-
 scripts/analyze-migration.py      |    3 -
 tests/unit/meson.build            |    1 +
 tests/unit/test-io-channel-rdma.c |  276 ++
 24 files changed, 1360 insertions(+), 4832 deletions(-)
 delete mode 100644 docs/rdma.txt
 create mode 100644 include/io/channel-rdma.h
 create mode 100644 io/channel-rdma.c
 create mode 100644 tests/unit/test-io-channel-rdma.c

-- 
2.43.0


