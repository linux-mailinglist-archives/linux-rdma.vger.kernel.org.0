Return-Path: <linux-rdma+bounces-2546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 791108CAA0A
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95D71C213CA
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95856440;
	Tue, 21 May 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dlyRS5DW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441965579F;
	Tue, 21 May 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280468; cv=none; b=cCp4sI4GELNeHxwNoIue02/aWWIj8lzlsKAterV7GwoB/Dpd3yVg+9me7r3InQgiZp0EjVXgq7GAwyZOO63RS4goXeKbOpq2bKb7nNLsKSZwOwlswfJuARpoIKq54otJeR1V5Ye+Rpm2zyNU5xSmDierdXwt8tXf5typIlA715g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280468; c=relaxed/simple;
	bh=sYda1mFc5l5LWsjSR6YQyytMG2Tf3oGJO9A7uH5E2wA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BYE8w3mrj0tp0TfqmS6cWUVK3iRyiaO4yNFt6p7lOG65YINCE8SmDEIonKZgjx2ab3ITNDEawTMWkhLPqeZKE8q5PtsxXwfFLhDDJdkbVTnt7ZY3l+VGL8F7TrsCfwI/JCnTSEds/IHe6z22j/3kq5zNwY1f5BhDnoki4L/x6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dlyRS5DW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E33420B915A;
	Tue, 21 May 2024 01:34:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E33420B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716280461;
	bh=AtyUGx9oWS97PLPb0VNQ/W3pJzLpNy9b+v7egSR3WkU=;
	h=From:To:Cc:Subject:Date:From;
	b=dlyRS5DWXH45Y2qWrVTb6LNL8WVFrl7zj5y838k+uKUpQSrtIHbPBZJj/LSzAuH/E
	 vS7BhpbWd09rn9pYRPGysD+j0bd98k40ZuyxgYEIOMLe24mZSVn4g4hObGUP+zRQ8/
	 ucsgCJZBUzSUb5c08pvCIRw0vet2zCCx5WITsRxE=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2 0/3] RDMA/mana_ib: Add support of RC QPs
Date: Tue, 21 May 2024 01:34:10 -0700
Message-Id: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series enables creation and destruction of RC QPs.
The RC QP can be transitioned to RTS and be used by rdma-core.

RDMA-CORE: https://github.com/linux-rdma/rdma-core/pull/1461

v1->v2:
* Removed an old comment in 2/3.
* Fixed text in a debug message in 3/3.

Konstantin Taranov (3):
  RDMA/mana_ib: Create and destroy RC QP
  RDMA/mana_ib: Implement uapi to create and destroy RC QP
  RDMA/mana_ib: Modify QP state

 drivers/infiniband/hw/mana/main.c    |  59 ++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  99 +++++++++++++++-
 drivers/infiniband/hw/mana/qp.c      | 166 ++++++++++++++++++++++++++-
 include/uapi/rdma/mana-abi.h         |   9 ++
 4 files changed, 328 insertions(+), 5 deletions(-)

-- 
2.43.0


