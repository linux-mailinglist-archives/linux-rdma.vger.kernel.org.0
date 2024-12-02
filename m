Return-Path: <linux-rdma+bounces-6179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F11A9E02C1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 14:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEDB372C0
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Dec 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD581FF616;
	Mon,  2 Dec 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kaaTCAUl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830A1FC0F4;
	Mon,  2 Dec 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144271; cv=none; b=G1QK0631/Tc9AQp1FU9aDuIX0Stt1aLora8fhHJ4B9j/GvhTogYfUOtFE86LJfyALOWU25sx53jQplvYzKXFcfIXqtPAVqE8jyKLZF/o/detkqmjcXEacCOoEBTv6LzNmMveg3ouOT9QUOlUtO3DBJ04U6595z+LMNg7q2PzAnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144271; c=relaxed/simple;
	bh=J2kQa/XnrrkajCWkxQGGecfXFAr+1pxZMdEhg+Clx8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k87TfPJ09Tifl66EqNG3zS6obDVlZkBT31XisRMDyVl/m0V9cZSsFj/MGyVzWVWHA4poIPrNi/+ZLAaUZ0XkAWvm/w6CLZLzpkuUcvTT9aQKbRx41+ht/bCyzbriJYRvZp6sV9H0IY1PGbNFJ/Rld1WXe+tSNkflyH6rQYrReLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kaaTCAUl; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733144260; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=kdK5ktIeDQ0vPxMpZuU20IWvGKY6wcnNooWcP6cTXNE=;
	b=kaaTCAUlkVb+qzwEulZyaJfdsdkknhPnbC/yu7UUo7J7vTWHOtE5QH3vRCWMQUvLpy4znu1dZt4SymIVKhtfzpLVgr38VRmREaD8Bok2G56xtbLUh/6HJjz7Kyab88NmwUs7j1KKI7Vg0Cl8zBuQmYWwrukq6pUEKLY9SYaovsw=
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WKiDfov_1733143933 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Dec 2024 20:52:15 +0800
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
Subject: [PATCH net-next v2 0/2] net/smc: Two features for smc-r
Date: Mon,  2 Dec 2024 20:52:01 +0800
Message-Id: <20241202125203.48821-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 -> v2:
Patch #2 fix build error reported by kernel test robot <lkp@intel.com>.
https://lore.kernel.org/oe-kbuild-all/202411282154.DjX7ilwF-lkp@intel.com/

Guangguan Wang (2):
  net/smc: support SMC-R V2 for rdma devices with max_recv_sge equals to
    1
  net/smc: support ipv4 mapped ipv6 addr client for smc-r v2

 net/smc/af_smc.c   |  5 +++++
 net/smc/smc_core.c |  5 +++++
 net/smc/smc_core.h | 11 ++++++++++-
 net/smc/smc_ib.c   |  3 +--
 net/smc/smc_llc.c  | 21 +++++++++++++++------
 net/smc/smc_wr.c   | 42 +++++++++++++++++++++---------------------
 6 files changed, 57 insertions(+), 30 deletions(-)

-- 
2.24.3 (Apple Git-128)


