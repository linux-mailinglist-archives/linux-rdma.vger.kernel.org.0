Return-Path: <linux-rdma+bounces-6410-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BAF9EC22E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 03:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C4285EB9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F31FDE2D;
	Wed, 11 Dec 2024 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E2PnwzhH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC71FDE1E;
	Wed, 11 Dec 2024 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884272; cv=none; b=FC79YeJuH6tQPrwL1/248RHtgrJUJrMLEc89UwnVVw54alYfJgOyqvcpl4bjvhpQXuFzl2yJw6DvrRcjKRPoQzENiykUhZDJKScSdDX9crxuVIVp0hY4m3qNnLihFhnWlY3ghVxlhN6n9RnWY7jVYF0ephMCj0IiZ09ntXlNuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884272; c=relaxed/simple;
	bh=E+UAeEJoDkplvRMVF2pktf22DII10AsH7WGPs7ZpbT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHf0hYaBLMQqdkN3CGdcf5hKrHZNBJhvQpquJEmJYXNNbpvswP8SYtkLj/jVP4Yook7r0Zka0gFqIcp/C5yRD3TWt6t9o5rnguAXInPQUk1ZO/zjr6UxJ7FQuxfxenbsjOHGtQ+9gb4QhJdicVCpjF7NMKfp6OYBIqchZpBk3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E2PnwzhH; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733884266; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/I7yPO7EcSekPMhCgT8SWcWo1LXPkjZ7aepql1hUkXg=;
	b=E2PnwzhHi4LjF90ZBBCew1AVYhh4FgqwTVjm8RiZI9UPlqophm31EHZxn8M9tl90rXeXNjaeR0XjGniMoy7LlpioJ+7TrvLPyIQEei+IMFHCK6I+mhR9uiPRYpehGQib3Q0MCjhbk5RchpLJeLVtGgVqaUVDVhu0RZNjc52nHE0=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WLGemUd_1733884265 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 10:31:06 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	pasic@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next RESEND v3 0/2] net/smc: Two features for smc-r
Date: Wed, 11 Dec 2024 10:30:53 +0800
Message-Id: <20241211023055.89610-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2 -> v3:
(https://lore.kernel.org/netdev/20241202125203.48821-1-guangguan.wang@linux.alibaba.com/)
Patch #1 add 'Reviewed-by' tag.
Patch #2 remove the condition when IPV6 is disabled, and change the
condition to an easier understanding way. Correct the typo and add
'Reviewed-by' tag.

v1 -> v2:
Patch #2 fix build error reported by kernel test robot <lkp@intel.com>.
https://lore.kernel.org/oe-kbuild-all/202411282154.DjX7ilwF-lkp@intel.com/

Guangguan Wang (2):
  net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to
    1
  net/smc: support ipv4 mapped ipv6 addr client for smc-r v2

 net/smc/af_smc.c   |  5 ++++-
 net/smc/smc_core.c |  5 +++++
 net/smc/smc_core.h | 11 ++++++++++-
 net/smc/smc_ib.c   |  3 +--
 net/smc/smc_llc.c  | 21 +++++++++++++++------
 net/smc/smc_wr.c   | 42 +++++++++++++++++++++---------------------
 6 files changed, 56 insertions(+), 31 deletions(-)

-- 
2.24.3 (Apple Git-128)


