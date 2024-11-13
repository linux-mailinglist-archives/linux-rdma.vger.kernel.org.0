Return-Path: <linux-rdma+bounces-5951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200A9C69B0
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 08:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D921F25842
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7F183CD4;
	Wed, 13 Nov 2024 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KCUBut4l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AD7081F;
	Wed, 13 Nov 2024 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731482056; cv=none; b=IMZG622HLABVNY2ROq2A+gH3aT4KoVGzhOiPv7jOPXVK7ausGOBLEa26SNt15SbhN4MPBSV1+bx84oM4BSHm4MLsofIfKV4debYnC+0TDtzFT4YEwZeeUlASrd4P+9G/Z7FgNyVMOP07Ik3R3ItPcINBq9VdsTKNV6NhLX8nA/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731482056; c=relaxed/simple;
	bh=HlNS6kgEQgKSm4xwYQ0CuuCTRKbC+aH/Oee/3hAw5JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JLmx3GdUHouuKvBHsbOTvURZjorsSzVxndMLJGDny7qwby8sq9mF6zzgMDNaXioaBRZrvvqCkks3riFW+BMz2D3sX07zXNadaOpdxzaYPTskjhBXPAnyezHRjeSw5OyGFJdftTQb828Z7AUeqKxhKqmXZUoZSu6hPO2GDIbIPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KCUBut4l; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731482050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pRbx0dmK2wB4sQXWiP+JZgwKGAmCunG59XKcyNdF6cg=;
	b=KCUBut4l0Uk48b0mF3UuODFqfDqUQE5GQiUzOKL+uwg/JEC57nLcofmUEiANHosy/K6jWd585BYhXTh/SlE4Kdnbpb7gspE+aw9jaLuTGdXNBoU/b2S1NolKiZbE8GkexBwbUR/Nxq+oTXleRRdnciiNgBClWCQ2jhYmX/iqHfE=
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WJK51Wv_1731482045 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 13 Nov 2024 15:14:09 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next 0/3] Reduce locks scope of-smc_xxx_lgr_pending
Date: Wed, 13 Nov 2024 15:14:02 +0800
Message-ID: <20241113071405.67421-1-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set attempts to optimize the parallelism of SMC-R connections by reducing
locks scope of-smc_xxx_lgr_pending. This is a balance between large-scale refactoring
and performance optimization, where this patch attempts to achieve performance optimization
with as few changes as possible to minimize unexpected impacts.

Although there are still many bottlenecks that affect the connection performance of SMC, 
This also has a certain performance improvement after this patches.

Short-lived conenction wrk/nginx benchmark test:

+--------------+--------+--------+--------+-------+-------+-------+-------+
|conns/qps     |   c8   |  c16   |  c32   |  c64  | c512  | c1024 | c2048 |
+--------------+--------+--------+--------+-------+-------+-------+-------+
|SMC-R before  |10481.84|10761.04|10283.01|9006.88|9140.88|9255.41|7296.20|
+--------------+--------+--------+--------+-------+-------+-------+-------+
|SMC-R origin  |7328.86 |7256.99 |7288.53 |7239.55|5787.56|5371.17|3065.74|
+--------------+--------+--------+--------+-------+-------+-------+-------+

D. Wythe (3):
  net/smc: refactoring lgr pending lock
  net/smc: reduce locks scope of smc_xxx_lgr_pending
  net/smc: Isolate the smc_xxx_lgr_pending with ib_device

 net/smc/af_smc.c   | 36 +++++++++++++++++++-----------------
 net/smc/smc_core.c | 17 +++++++++++++++--
 net/smc/smc_core.h | 29 +++++++++++++++++++++++++++++
 net/smc/smc_ib.c   |  2 ++
 net/smc/smc_ib.h   |  2 ++
 5 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.45.0


