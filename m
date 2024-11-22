Return-Path: <linux-rdma+bounces-6057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE819D5A06
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 08:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D801F2307B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2407B16F909;
	Fri, 22 Nov 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RL4qYoXX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0D13BC0D;
	Fri, 22 Nov 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260744; cv=none; b=XM3hEvYZ74+GuRX+8PwlopC+Vf2s/NrgTJ5vS5bhGSh8bKYatgfWyscfinNsR0ZETv/eLf2sbEiHPyCiSCZmt4uCObmmXQ5KG5ZU+aL3MNWGpZzTOdvK1oWPp2KBxMPkjFI6hwPHRibh/KSh+Oy2ulMkw1beKEe+wBBjm+jwmrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260744; c=relaxed/simple;
	bh=spbzWbd7FQqBtOkDzTFqT3YlrjAO8m3oga+driBa8Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r8q2VVAGjsTxlQbmh8jrwi+lmmHFpBYVYLoiu/liLNfXTc5gsFCYJD8ckWD3csAMhRsocMaCBzAOQEZ2SOA60ZFJ1nKbqE3xl4Oz509PbfyOfRzpjZZbDZbPC6xAyZar0j4oNfFWGvlWI/hUqFayJQ5GIGand9D4DgWXhSbJZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RL4qYoXX; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732260739; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dEzc/OQbGPUdT584qrTt3h94I3pDiGI55xF809EJ4xk=;
	b=RL4qYoXXzGNqaUlffiz4rGq3u+U8s4eG3wMInLKf4I8xJl6gstCzqjGOTH7jNrLumREmJaHwLTsHPJMmY+udFCFccllDC+Osd/w7mtnsoelPvYNxeKOr/YarCcIj+LejIYnPuBErnfsJC7O2f42P/C7z2ZYgNCsDH7XIGTaxSL0=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WJzio.n_1732259790 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Nov 2024 15:16:32 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] two fixes for SMC
Date: Fri, 22 Nov 2024 15:16:28 +0800
Message-Id: <20241122071630.63707-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all

This patch set contains two bugfixes, to fix SMC warning and panic
issues in race conditions.

Thanks!

Wen Gu (2):
  net/smc: initialize close_work early to avoid warning
  net/smc: fix LGR and link use-after-free issue

 net/smc/af_smc.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.32.0.3.g01195cf9f


