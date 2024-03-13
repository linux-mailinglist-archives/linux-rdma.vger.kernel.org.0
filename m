Return-Path: <linux-rdma+bounces-1416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC887A83A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3BF285526
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0484087F;
	Wed, 13 Mar 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bb3NbINI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F89210F1;
	Wed, 13 Mar 2024 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336311; cv=none; b=nFiZkgPMyH4F7I733qW9u8ey6IFFTH1LaMRomKhmrIGV1be1hJpCtEvt7EvyQwnP1fluXtUzMiKt8sk0vT1TSjdkR0bC3lAnWeFY9HqtrOQyF7Igk9HH0IBLYdAF8WPz13En8JVjfJnGrS6BWjTgFWRepugTsMYi5oNrlQMaa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336311; c=relaxed/simple;
	bh=TcOVyEgWPO7+FIB4h6Ug6v35BqN5ZuqUqlOKKCHwN5Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=URdaYDfcZNX5YQGCSR0ZPFgi1dBNpJ5jVi9lfpZ5vUhYC5hK+xvEX9/C7KMThiuKLdPEYg3QrJNA/1oIEVoDrsD5FkfPoZt6GV+92GlX27o1rmNUINkRXKFcdZ5rYheKfQYk05nQ5U+g6FIIGzmHWaumpTMCM4PhF62ythscV1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bb3NbINI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71CBC20B74C0;
	Wed, 13 Mar 2024 06:25:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71CBC20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710336304;
	bh=N1ONS5i/qA6Bitcc0ZJ2Ph+JttW5gpC5h00IFpVNWJg=;
	h=From:To:Cc:Subject:Date:From;
	b=Bb3NbININzf3eTKcMHkrZdhWWBgYjyQMPEEMHxFvQlQsMvhwKDYXzHAeh0lAZLucR
	 f8UxpylM6UgpozTTBnWSnfixeJhUdOt1G103DfcpMhkVaf31kGmWoUv9JnZqRcinwO
	 NPmPTfcONtZapBOk0RPdqMeufq/PN+SIx0xU0pMQ=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/4] Define and use mana queues for CQs and WQs
Date: Wed, 13 Mar 2024 06:24:55 -0700
Message-Id: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patch series aims to reduce code duplication by
introducing a notion of mana ib queues and corresponding helpers
to create and destroy them.

Konstantin Taranov (4):
  RDMA/mana_ib: Introduce helpers to create and destroy mana queues
  RDMA:mana_ib: Use struct mana_ib_queue for CQs
  RDMA/mana_ib: Use struct mana_ib_queue for WQs
  RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs

 drivers/infiniband/hw/mana/cq.c      | 52 ++++-------------
 drivers/infiniband/hw/mana/main.c    | 40 +++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h | 31 ++++++----
 drivers/infiniband/hw/mana/qp.c      | 86 ++++++++++------------------
 drivers/infiniband/hw/mana/wq.c      | 31 ++--------
 5 files changed, 104 insertions(+), 136 deletions(-)


base-commit: 96d9cbe2f2ff7abde021bac75eafaceabe9a51fa
-- 
2.43.0


