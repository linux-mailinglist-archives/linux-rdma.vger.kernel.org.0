Return-Path: <linux-rdma+bounces-6689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374CD9F9DC3
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 02:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E31680F7
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF033CFC;
	Sat, 21 Dec 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dNkS4PVc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB233FE;
	Sat, 21 Dec 2024 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734745232; cv=none; b=ttHrN2W6tt1PMRGxd514LcecEpjyYrU03NsKG649ubOVhHmqMqXiWy53m8blCNnO0+qBYhk8L6Dxa/cv01Vr5fDv58PNuRPNp/bd347R2QOe64yw7DJi5t4/2mdDvxEwnE5mEQglhupD351TdP6NOOqgtGeHA5ukzrVavbrrJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734745232; c=relaxed/simple;
	bh=vV0gIq/4VGJz1BqnRdFM9jUprAcL472/iNEYi6SIQ/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZ6/cQVjam3j9pX53ZnfcbFcavDMf5epr2wGJMDY2oi9ACOURWeF21K96TgUU/Qs+e9aAScApqguZLDjTmA/cjiiBFaXVMwkdZIE/Gs067VmDZk4i7EaGTTPlDtm6yofy5QEzxUZPC34TTe2ozma21jinX4dpfvElXFc8dCYEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dNkS4PVc; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=cMrio3g91s5zE+pv+ooeAJjHddqyJb3B9hA8TzeKwZw=; b=dNkS4PVcHjv1jtWt
	XNInqId8h5zSi1KDKqhn6/UTvnm7FkrPPCewrM+YvnN977DB4JgbORJyu6aKQ3kMUbWYRsEr+OHWb
	fxeTBDjtp1Xw3Ei0xa0UdqT9xGJWEtCKPLH8CSC23XXgc69YQi/nAibD1lF86GZ1J8RUcJLflZIYi
	l3NxMSawm8MVNKeqzDoPG/PN9LEfT8Zu551LV6EEHJgSU3wu2zM46a6ePbvZqlHjTV9mU3zkUQf0H
	gB+FV1N2GfoL7kLc2mxwpK/keBVuS47iTM28dVwbL1Tlwy7yiLNqWK4W6LfJySZE9FZmn6tU1fNku
	YKLQX6uNi3jwmgX26Q==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tOoTi-006dmT-2J;
	Sat, 21 Dec 2024 01:40:26 +0000
From: linux@treblig.org
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 0/4] RDMA deadcode
Date: Sat, 21 Dec 2024 01:40:17 +0000
Message-ID: <20241221014021.343979-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

A small collection of function deadcoding, for functions that
haven't been used for between 5 and 20 years.

These are all entire function removals, and are build tested
only.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>


Dr. David Alan Gilbert (4):
  RDMA/core: Remove unused ib_ud_header_unpack
  RDMA/core: Remove unused ib_find_exact_cached_pkey
  RDMA/core: Remove unused ibdev_printk
  RDMA/core: Remove unused ib_copy_path_rec_from_user

 drivers/infiniband/core/cache.c           | 35 ----------
 drivers/infiniband/core/device.c          | 17 -----
 drivers/infiniband/core/ud_header.c       | 83 -----------------------
 drivers/infiniband/core/uverbs_marshall.c | 42 ------------
 include/rdma/ib_cache.h                   | 16 -----
 include/rdma/ib_marshall.h                |  3 -
 include/rdma/ib_pack.h                    |  3 -
 include/rdma/ib_verbs.h                   |  3 -
 8 files changed, 202 deletions(-)

-- 
2.47.1


