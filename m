Return-Path: <linux-rdma+bounces-2099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425818B380D
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27C3284078
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 13:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D71474C8;
	Fri, 26 Apr 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eo2RmEZU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF63146D5A;
	Fri, 26 Apr 2024 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714137167; cv=none; b=cBbQbl8nGr5IqQ1XxG2iuPiAgeqevkywQLR5w8ffbIAzx6kW7GhMGDKddKNYXxGPDYy08tvVVuyfZR+SThA6BM+h5GRtYscMBuuujkYo8xIPMrU6Ty2m/qA5xEAIYRV60woBEJQFHugsqaiPcfPmYuarLWxd7db6In+6ZTIyNu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714137167; c=relaxed/simple;
	bh=XXhcj0cDpVh7xPwt8Dp0EC9SyzQNMQnm3miM/hj7FWQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=m06ofmYsgYiCsy5tEEM9PrL+yeA8+TWvPGjGmPv7Js7RwPGZnfNWDFGqA1Kwwf4bTjjKEIn1zvImuQhMt9rnZp4MU050l/QjtcBap1+lvJT17E1aDGmuPfT9MKy8kZz88+TE1PupYV3Vy8BfIydQLJQTSWq7QSFFmks7FLyrn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eo2RmEZU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA291210EF22;
	Fri, 26 Apr 2024 06:12:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA291210EF22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714137165;
	bh=RO8omU3mFuuk6wZAfmhtQuuvQ83q0qcIhS82ZrxUOB0=;
	h=From:To:Cc:Subject:Date:From;
	b=eo2RmEZUb5cAqMcv+xAJZ6udM65wQvUF/wqJmKU10KQnVm73JSh7kQdArDWQ8q3kn
	 kqSG5TlEqoPAiFU3nGdugG/ZSSkxcK8NIpI/4y49khW7tRRCTOV5IY3vRP4i9veOrn
	 bMOsBM29ZyBGaNGVVZTnqpBBBp3b5kOzDyD9/Qt0=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 0/5] RDMA/mana_ib: Implement RNIC CQs
Date: Fri, 26 Apr 2024 06:12:35 -0700
Message-Id: <1714137160-5222-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series implements creation and destruction of CQs
which can be used with RC QPs.

Patches with RC QPs will be sent in the next patch series.

To create a CQ for RNIC, mana_ib requires creation of EQs
within mana_ib device. An EQ of mana ethernet cannot be used.

To make the implementation of create_cq cleaner, this series
also introduces a helper to remove CQ callbacks.

Mana ethernet and mana_ib CQs are different entities which are
created in different isolation zones (ethernet vs rnic).
As a result, RNIC cannot use ethenet CQs and ethernet cannot
use RNIC CQs.
That is why, we use existing udata request for creation of
ethernet CQs. If the request has an extra flag, then we create
an RNIC CQ. The kernel-level CQs will be RNIC CQs (in future
patches).

To preserve backward and forward compatibility with RDMA-CORE,
we will make the following changes to mana provider in RDMA-CORE:

The rdma-core will request RNIC CQs by default, with the proposed
request format and the special flag.
If the mana has installed an allocator with manadv_set_context_attr,
then the rdma-core understands that this is a DPDK use-case and
requests an ethernet CQ, by not setting the flag.

If the user has a new RDMA-core and an old kernel, then the user can
detect it as the response to create RNIC cq will not have queue id.

If the user has an old RDMA-core, then the flags will be 0 and ethernet
CQ will be created (as expected by the user).

v1->v2:
1) removed patch that replace cqe with buf_size
2) added aditional check of queue id in the remove cb helper
3) removed buf_size from uapi request and added flags instead. It seems
to be a better proposal that will not require to increase the ABI version.

Konstantin Taranov (5):
  RDMA/mana_ib: create EQs for RNIC CQs
  RDMA/mana_ib: create and destroy RNIC cqs
  RDMA/mana_ib: introduce a helper to remove cq callbacks
  RDMA/mana_ib: boundary check before installing cq callbacks
  RDMA/mana_ib: implement uapi for creation of rnic cq

 drivers/infiniband/hw/mana/cq.c      | 74 +++++++++++++++++++----
 drivers/infiniband/hw/mana/main.c    | 88 +++++++++++++++++++++++++++-
 drivers/infiniband/hw/mana/mana_ib.h | 34 +++++++++++
 drivers/infiniband/hw/mana/qp.c      | 26 ++------
 include/uapi/rdma/mana-abi.h         | 12 ++++
 5 files changed, 200 insertions(+), 34 deletions(-)

-- 
2.43.0


