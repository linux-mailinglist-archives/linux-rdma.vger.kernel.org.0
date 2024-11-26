Return-Path: <linux-rdma+bounces-6098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F39D920F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 08:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB0B21BC1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Nov 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38191898FC;
	Tue, 26 Nov 2024 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Hhk234Gh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98E178372
	for <linux-rdma@vger.kernel.org>; Tue, 26 Nov 2024 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604643; cv=none; b=PFUx5cIW90FyxvFoGTKXlSshLNygozBIjcaGtU37LV4C9yVDq+nimesIRZnn0v6SPUyxJJBTSQDnaydYwG2SP6enOrw5H4zROqYwaJ4go6h5vZlbObU8K8TY3BYDOS9Msr17jWC3UnLf5xZ3rPWTw1baEmX2rFrXeDs9iDN4v8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604643; c=relaxed/simple;
	bh=9uMqcVpJ1vDq6AvY2MVgLej6w+0rx0Ioff8iVWNqlGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XnWtt6ALFOy54MoeGU3+wwAAogcvdtpLmJCA4Q6IK9BspI06icG6cjetWD+ukBSEPsbbk6WsL5NlTdgI0H3M8gAO5vNn4DCJmI+WJS75SKJQFph4jj+ry0oVA09d7Ntp4uezjBOT2q0s8SAW4OicoYyJQXv30k3deEXA7jjxs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Hhk234Gh; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732604632; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZoVAEm6xntHKNce0y/GQ90AovwEpYSwzFlN4KcW1B1Q=;
	b=Hhk234GhvcI72gOqGhakq1NeT1VAovgB8nbpTLAxpyUvCYKdHqCAF/56kx8A3eszP9Jq+oDtW9U/Jxg5Q/1jx0BIdVTvOdVEBOQI5pJ++xtEMc0i5SwIatiByATPkIZYoZWDirfqK7SnwHfx3KOYPW0tXDggdyhl+TQgstRD7jY=
Received: from localhost(mailfrom:boshiyu@linux.alibaba.com fp:SMTPD_---0WKHPI-0_1732604631 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 15:03:52 +0800
From: Boshi Yu <boshiyu@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	kaishen@linux.alibaba.com,
	chengyou@linux.alibaba.com
Subject: [PATCH for-next 0/8] RDMA/erdma: Support the RoCEv2 protocol
Date: Tue, 26 Nov 2024 14:59:06 +0800
Message-ID: <20241126070351.92787-1-boshiyu@linux.alibaba.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series introduces support for the RoCEv2 protocol into the
erdma driver. As the most prevalent RDMA protocol, RoCEv2 is widely
used in the production environment. Given the extensive application of
erdma across various scenarios in the Alibaba Cloud, there has arisen a
requirement for erdma to support the RoCEv2 protocol. Therefore, we update
both the erdma hardware and the erdma driver to accommodate the RoCEv2
protocol.

- #1 adds the device probe logic for the erdma RoCEv2 device.
- #2~#4 implement resource management interfaces required by the erdma
  RoCEv2 device, such as the GID table, PKey and address handle.
- #5~#6 implment the modify QP interface for the erdma RoCEv2 device and
  reformat the code of modify_qp interface to improve readability.
- #7 introduces the query_qp command to obtain several qp attributes
  from the hardware.
- #8 extends the procedure for create_qp, post_send and poll_cq interfaces
  to support UD QPs and UD WRs.

Thanks,
Boshi Yu

Boshi Yu (8):
  RDMA/erdma: Probe the erdma RoCEv2 device
  RDMA/erdma: Add GID table management interfaces
  RDMA/erdma: Add the erdma_query_pkey() interface
  RDMA/erdma: Add address handle implementation
  RDMA/erdma: Add erdma_modify_qp_rocev2() interface
  RDMA/erdma: Reformat the code of the modify_qp interface
  RDMA/erdma: Add the query_qp command to the cmdq
  RDMA/erdma: Support UD QPs and UD WRs

 drivers/infiniband/hw/erdma/Kconfig       |   2 +-
 drivers/infiniband/hw/erdma/erdma.h       |   8 +-
 drivers/infiniband/hw/erdma/erdma_cm.c    |  71 +--
 drivers/infiniband/hw/erdma/erdma_cq.c    |  65 +++
 drivers/infiniband/hw/erdma/erdma_hw.h    | 135 +++++-
 drivers/infiniband/hw/erdma/erdma_main.c  |  57 ++-
 drivers/infiniband/hw/erdma/erdma_qp.c    | 299 +++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 524 +++++++++++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.h | 171 +++++--
 9 files changed, 1134 insertions(+), 198 deletions(-)

-- 
2.43.5


