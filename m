Return-Path: <linux-rdma+bounces-6127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B99DA885
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C871B21C78
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6181FCFF3;
	Wed, 27 Nov 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZDAY7btk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62071F76A5;
	Wed, 27 Nov 2024 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714227; cv=none; b=gQ5TjJIozIBFgzr5jjySR9syjIRDK5634wRLEqSITEqfJgn5s48aBI9418c1J0pv/3DbROEiwVKHGT/uJpJgfuAsoWbYPP24Sar+X7z2oOEbSglOvuw50lwTWXWbtM3hYrkXV5ac9GXxHF0gRbm9Wtqnbz9pzF0uHz1CHd093mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714227; c=relaxed/simple;
	bh=lL70dIqRnAyBiu+zzo2/5+sjdmD6HVEsbvD4i+anjwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CNt6QrpV0BqRpXqAsAZiOknmrSVKzXkzAlfRMcSBepIAUQsLWeQMeTaMqu4mLMBJcrWUPu5GAladLYSuTu5T2tKI7pRERCv8qloS79zkvRmcx+iTnJMZGRrelErfBYGRd4yY1iFJQLGMtvcdLYg0Tna5ZjY/MnUT75RBBrwdKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZDAY7btk; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732714217; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=veLuyZ9oSCmnspBOb1TsKxfnMyJAgGIRoKvRICjdLKo=;
	b=ZDAY7btkpiKvyVyOIYm98/pL42EyeaHhONzMd9jBiyEgsHfz0bZO7DPxaPlT8WCaNGvyK+WQh0oaKX5tF3xz5R88XwB4op4Nu6RvrJdXLuWd/GPfp5zOf8Q78FAtWI4/9XquxNO3BrboiKKsONUUAux2+cxMFcN4PD4eiHl6Feo=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WKMbqQk_1732714214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 27 Nov 2024 21:30:16 +0800
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
	kgraul@linux.ibm.com,
	hwippel@linux.ibm.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] two fixes for SMC
Date: Wed, 27 Nov 2024 21:30:12 +0800
Message-Id: <20241127133014.100509-1-guwen@linux.alibaba.com>
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

v2->v1:
(https://lore.kernel.org/netdev/20241122071630.63707-2-guwen@linux.alibaba.com/)
- Patch #1: Collect 'Reviewed-by' tags;
- Patch #2: Extend sock lock protection from smc_conn_free() in smc_conn_abort() to most of smc_listen_work().

Wen Gu (2):
  net/smc: initialize close_work early to avoid warning
  net/smc: fix LGR and link use-after-free issue

 net/smc/af_smc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.32.0.3.g01195cf9f


