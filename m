Return-Path: <linux-rdma+bounces-6330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9129E9630
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 14:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83751651EF
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD3238749;
	Mon,  9 Dec 2024 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vnQx2b+I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC0233D72;
	Mon,  9 Dec 2024 13:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749628; cv=none; b=nasFTFAKQgozzVwWWnN9H9Guu9OiYQgo2inHRtBFaIWIBT2brGtBU3Fk8UgFKCNU/UldHjOwTaOTlA68lDAqb2AtPc43o9P+eL+9afqWa9G3EiFyLYLxBKUyCTnHxn0nqy2/3GO+T84TIM7w3R33SLVzFnYQQUOz3eCEFK1zKVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749628; c=relaxed/simple;
	bh=E+UAeEJoDkplvRMVF2pktf22DII10AsH7WGPs7ZpbT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eRhdCxJAgVVomZ8GyRHHBd811phiM2TjJxl4/J672pALqe8xdHOYOKymVuvpkh9Yr80aDIS+Vbvx60yY9sjeYJUPwc6fakb7Khs1fWfthDVxZkyqjd7AByYaQy4NvNdfd/D2pAvJf0FiTTthBo/XsaknvF+AbTITxQIU5adZ7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vnQx2b+I; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733749621; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=/I7yPO7EcSekPMhCgT8SWcWo1LXPkjZ7aepql1hUkXg=;
	b=vnQx2b+I18Qcvg3QyQLAdqqr4Ti5SjI9u+QHaulHLOUwXrHzavMaW/tgXeHPp2/gt2lq+CExt8O7l1uXp2h2Yvd4EQK3OTWtssK91Evh+J2aWqZb+RJDSHnSsLHfP2UQ69gQqmDe2JNWeP26U0Kmq8vo+N1NF8CFt+5EwP4VHX0=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WL8eHiI_1733749619 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 21:07:01 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
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
Subject: [PATCH net-next v3 0/2] net/smc: Two features for smc-r
Date: Mon,  9 Dec 2024 21:06:47 +0800
Message-Id: <20241209130649.34591-1-guangguan.wang@linux.alibaba.com>
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


