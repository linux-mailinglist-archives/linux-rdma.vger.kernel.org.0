Return-Path: <linux-rdma+bounces-6120-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0279B9DA507
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 10:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CE6B2300A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B7194143;
	Wed, 27 Nov 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SV46ClXd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E81514CE;
	Wed, 27 Nov 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700757; cv=none; b=VGncl2sHG6JavA8KcjJwAl3PrFUoY0x2Ly07weF+PXWHPuQ2VTX0fp5IVC4ASKJ28Ftg/icd0qAsUE4TKaBcZ377mnI2SVccfE4YtWJetGzdHF8mOmBb2qf9b04etOlk+PwagWYgP8FfqWWyQHQiXvr82A/q6QjH3qolfiseXGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700757; c=relaxed/simple;
	bh=R3HYp/DOwrU2eyUrOwWKyWxrVbEIaYiW13wVM/FVuos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LjhDV44HjmBYgtzy+iyfIJFLAffOjsNIPzZfI0Hoq3Itcl1MhF+ZCd08eLbkmQFEx3cSx2cVMy6/rcv2dti2OKjtOZBrofUvvgEinLkC6esXpggqucwl1ERgKsj78xreAnkvSxkRW8c5Wd7wl0dlm+sEJUnyLccwNvfcdikS7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SV46ClXd; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732700745; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=weifCjPoYZWK40FITDhmI6kvvpcn6jOZZ1R+uxr338Q=;
	b=SV46ClXdiold6eQfdvn2CyBwogL6dRu8O4B4NgxDg0rLr1r1zfc1Sv4vqXH/ynY4Domhn5iKOuZAhx13BYjOfL+m6qSQiSp+NzHiz36Y5t9AjS6yQWuFXmzKtOpNdhCyUxEizK93TwznikyIJ6N0zjGDGnB9A9RaxOLXtogxwlU=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKMBIdW_1732700744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 17:45:45 +0800
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
Subject: [PATCH net-next 0/2] net/smc: Two features for smc-r
Date: Wed, 27 Nov 2024 17:45:31 +0800
Message-Id: <20241127094533.18459-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two features for smc-r:
- support SMC-R V2 for rdma devices with max_recv_sge equals to 1
- support ipv4 mapped ipv6 addr client for smc-r v2

Guangguan Wang (2):
  net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to
    1
  net/smc: support ipv4 mapped ipv6 addr client for smc-r v2

 net/smc/af_smc.c   |  3 ++-
 net/smc/smc_core.c |  5 +++++
 net/smc/smc_core.h | 11 ++++++++++-
 net/smc/smc_ib.c   |  3 +--
 net/smc/smc_llc.c  | 21 +++++++++++++++------
 net/smc/smc_wr.c   | 42 +++++++++++++++++++++---------------------
 6 files changed, 54 insertions(+), 31 deletions(-)

-- 
2.24.3 (Apple Git-128)


