Return-Path: <linux-rdma+bounces-8692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5AA60B01
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 09:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF5A19C1592
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9115575B;
	Fri, 14 Mar 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pgtYO0a1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89717557C
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940141; cv=none; b=TuVyi4fLQLXvCegyYAdjebvnFDe1qpfxqyFX7bFibiwGAFmYgauxOcAdBiuQQWp9Ex1/LgKm20YitQmpUP8//w2+L6/ofMCyRT141C3u/weOiS48gPKJrldsWHykRMcTbt+eCMhAw8FyMaWDti00LJ7Wy5Y4asrF++xt+WDHIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940141; c=relaxed/simple;
	bh=mw1gsDpkMBW5z7VuL2kKRUNqznLO0j2iLZO0QMNiTT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diBjWRG+D2XeD9AffdayiS4/uleIpP9fgCRgNlr7TKHBUfdVXGB8IkemKTGNj9He37AG1xigux773QPUwIrfujDmUzdRYxfYri0aplfAa9KpUzHcdB6dXfjbL19wUdQU1q6voW06WYi9kduL3XUel2WyYU/cszknwOnoHwtnN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pgtYO0a1; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1741940140; x=1773476140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mw1gsDpkMBW5z7VuL2kKRUNqznLO0j2iLZO0QMNiTT0=;
  b=pgtYO0a1uvQeimPOPWSEpFOeHfjfmzshsRcFO17h8zO34th5lMju1W0I
   vfSAz9Uu0SL/AIFVxenhBz6b5qdVxjqrDB+3tiMg80xKmK3d2xHNMUMwO
   LK5wSYboEw93U5vdGHL4R6ejWaT5qv1XG/5AkTVoHI0622/bCbz1nV6MK
   0m/qjckB0VKBtE3dX3pg/Hl+BrKKaE5ZyVBdDNgRS1ib88qh+Aqpva8DX
   +zvubYf0uzFw6+dBhEA1FEBJGnEeW4UiDHEvHfUPINSOkmXsuTQoVvKFy
   oI95B9vGI+XMe9b2C7kNbe+JJ4mlnZESEfQ4g5c89tO+9JwgH4AkTYwzF
   g==;
X-CSE-ConnectionGUID: VHwW91cVQfSFo0XeUNyY3A==
X-CSE-MsgGUID: Ci/YqrNKSK+O27MTz92kPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="172022385"
X-IronPort-AV: E=Sophos;i="6.14,246,1736780400"; 
   d="scan'208";a="172022385"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 17:14:28 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1C45EDBB87
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 17:14:26 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E3D11D52E6
	for <linux-rdma@vger.kernel.org>; Fri, 14 Mar 2025 17:14:25 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 41E99200B295;
	Fri, 14 Mar 2025 17:14:25 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v1 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE with ODP
Date: Fri, 14 Mar 2025 17:10:54 +0900
Message-Id: <20250314081056.3496708-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RDMA FLUSH[1] and ATOMIC WRITE[2] were added to rxe, but they cannot run
in the ODP mode as of now. This series is for the kernel-side enablement.

There are also minor changes in libibverbs and pyverbs. The rdma-core tests
are also added so that people can test the features.
PR: https://github.com/linux-rdma/rdma-core/pull/1580

You can try the patches with the tree below:
https://github.com/ddmatsu/linux/tree/odp-extension

Note that the tree is a bit old (6.13-rc1), because there was an issue[3]
in the for-next tree that disabled ibv_query_device_ex(), which is used to
query ODP capabilities. However, there is already a fix[4], and it is to be
resolved in the next release. I will update the tree once it is ready.

[1] [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
https://lore.kernel.org/lkml/20221206130201.30986-1-lizhijian@fujitsu.com/

[2] [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
https://lore.kernel.org/linux-rdma/1669905432-14-1-git-send-email-yangx.jy@fujitsu.com/

[3] [bug report] RDMA/rxe: Failure of ibv_query_device() and ibv_query_device_ex() tests in rdma-core
https://lore.kernel.org/all/1b9d6286-62fc-4b42-b304-0054c4ebee02@linux.dev/T/

[4] [PATCH rdma-rc 1/1] RDMA/rxe: Fix the failure of ibv_query_device() and ibv_query_device_ex() tests
https://lore.kernel.org/linux-rdma/174102882930.42565.11864314726635251412.b4-ty@kernel.org/T/#t

Daisuke Matsuda (2):
  RDMA/rxe: Enable ODP in RDMA FLUSH operation
  RDMA/rxe: Enable ODP in ATOMIC WRITE operation

 drivers/infiniband/sw/rxe/rxe.c      |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  12 +++
 drivers/infiniband/sw/rxe/rxe_mr.c   |   4 -
 drivers/infiniband/sw/rxe/rxe_odp.c  | 132 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c |  18 ++--
 include/rdma/ib_verbs.h              |   2 +
 6 files changed, 155 insertions(+), 15 deletions(-)

-- 
2.43.0


