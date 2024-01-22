Return-Path: <linux-rdma+bounces-698-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E898377AD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jan 2024 00:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FA91C2344E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 23:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C204D100;
	Mon, 22 Jan 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iAt7YVGP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16124CDFF;
	Mon, 22 Jan 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965792; cv=none; b=sRsHdgeYBnVvSBbmVT6WPp9DqKfpNbfX33+5EQp/ppKAyNHLPJ9AZTS+mWt8FERUpiwsj9ngZyoi14XhXfKI1TGjEHoVg3qoJ4MbddJGmhhzu87xlxasINLhnDIy+6FGe3q27NkPVdFevL2UO6JbhbqHRboFq/e7MF6h5txzTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965792; c=relaxed/simple;
	bh=eLJhNzdFZj3RlP7C0RvlpZ87zYE+Z2S+CabRM8UsbZQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r5NvJlRdushJJAujNBmxi1ZuIktXic66Fl8TcSlL8ZLyotOMlvEi7/NVb3NFdGACM0KgSLZ+Ki+I3hFFbkEIds7tylzFrsf9cJ3RGmppD8Ufd6NiQmzudYMe1ZSnKkJtIjwgP0a4oSHkXzFq8CSPWtrMco1ZNxg5+t0C37k74BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iAt7YVGP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 75C2120E2C18;
	Mon, 22 Jan 2024 15:23:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75C2120E2C18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705965790;
	bh=nTh23HnZRdP/6Sx5yekzRTq2MwUPNWD0l+ejJL4d8AQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iAt7YVGPAUXBwHjlUekjBctC05U3DbUMvOVJ/UzaRzdQiAEU/111LXnrg/Z5NN25j
	 kqBFK2rOqeLWa3jp3HsH+GI4WoDJ6nSl+dgT/EWFK1uS1q3xxBsfG3nrTGiwwfzMNB
	 w0y4vHsDKpaFATKhWRqqR1lmZwxjF7J/2Tz6kI+Y=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v1 0/3] RDMA/mana_ib: Introduce three helper functions to clean code
Date: Mon, 22 Jan 2024 15:22:58 -0800
Message-Id: <1705965781-3235-1-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

This patchset aims to remove code repetitions in mana_ib
as well as to avoid explicit use of the gdma_dev.
The gdma_dev was either ethernet or IB device depending on
the usage, which was often easy to confuse and misuse.

Introduced functions:
1) mdev_to_gc
2) mana_ib_get_netdev
3) mana_ib_install_cq_cb

Konstantin Taranov (3):
  RDMA/mana_ib: introduce mdev_to_gc helper function
  RDMA/mana_ib: introduce mana_ib_get_netdev helper function
  RDMA/mana_ib: introduce mana_ib_install_cq_cb helper function

 drivers/infiniband/hw/mana/cq.c      | 25 +++++++-
 drivers/infiniband/hw/mana/main.c    | 40 +++++--------
 drivers/infiniband/hw/mana/mana_ib.h | 20 ++++++-
 drivers/infiniband/hw/mana/mr.c      | 13 +---
 drivers/infiniband/hw/mana/qp.c      | 88 +++++++++-------------------
 5 files changed, 84 insertions(+), 102 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


