Return-Path: <linux-rdma+bounces-8770-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B2A6704B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E586188B9F1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6621FECA7;
	Tue, 18 Mar 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JndOUwLD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D31F8BC8
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291463; cv=none; b=gp6GuYm9vs6pwUHliPoIs2q206IbRkBtt7tjoD3k7M+WA0k/QGSvfx7CkKuCV+skwyGQkIzPsHnRecYshKKA9fat4yb/RDFy83AWE8/iyQOoIMzvorNb+Jyl5Rda6Ks/BZ6Ra6oHSEP3YBmfjpjRbCEU6TUTZYPRRmPuwLWMQ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291463; c=relaxed/simple;
	bh=VvXwTxklfWBJePLneeoIecuXAUoQOoBL8UBwq/uXnJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TNlMIJ/QzJcrtKBM5bLUMCo4TRExZhbmoR440S23SPwrEdJdC2CwGG4ivsXIflbn/a00c6xZHrpT95IFjY+TYCivBriGzAG8XRPOvBHAJ0XMDup4eERsN82AgV1Sf/iIgYpFstXLTYTDejxguKz6aV4s9Mtt11IIDEh7HAzhlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JndOUwLD; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742291461; x=1773827461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VvXwTxklfWBJePLneeoIecuXAUoQOoBL8UBwq/uXnJU=;
  b=JndOUwLDzGOlngiRVCnyNMonZKv+iQ1xgwbHtjb5BEzV/mK8+SJuX7Qn
   uRA5cF7UeysO6rgUF1ladbUph9tMgX9PCsokeYexqqB+O0EI5NvkD5zSi
   BKC3zTC56+9sr+jXJt0OrGoJ4ZkSbLWhx0PbekEPfv/sKE/npv5geL8mW
   gRxxL6MepcWvVS8zqw7iZZg+eWuivkp1oCBEprrCndC0I9lDO7XWr66yq
   R3JJOld7eUYpfPWmDs2wjeD/LxUmk8G9+sbAlf/bM62bkYOvOSOxCSKFZ
   KLB6ifOiKawpxvdEjGy03d73M14hdwXahvnc8b6mavL6RzjMkkyzJNQIm
   w==;
X-CSE-ConnectionGUID: YrgFUe1QQaaETd7uCpovsg==
X-CSE-MsgGUID: A2pH31kQSe2JT9x7ZXE/QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="181454776"
X-IronPort-AV: E=Sophos;i="6.14,256,1736780400"; 
   d="scan'208";a="181454776"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 18:49:50 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C3D08D6EA7
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 18:49:48 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 922E4D3F31
	for <linux-rdma@vger.kernel.org>; Tue, 18 Mar 2025 18:49:48 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 4BE9D2005361;
	Tue, 18 Mar 2025 18:49:48 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v2 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE with ODP
Date: Tue, 18 Mar 2025 18:49:30 +0900
Message-Id: <20250318094932.2643614-1-matsuda-daisuke@fujitsu.com>
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
https://github.com/ddmatsu/linux/tree/odp-extension2

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

History:
  v1->v2: Removed some code duplications

Daisuke Matsuda (2):
  RDMA/rxe: Enable ODP in RDMA FLUSH operation
  RDMA/rxe: Enable ODP in ATOMIC WRITE operation

 drivers/infiniband/sw/rxe/rxe.c      |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  12 +++
 drivers/infiniband/sw/rxe/rxe_mr.c   |  48 +++++------
 drivers/infiniband/sw/rxe/rxe_odp.c  | 115 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c |  15 ++--
 include/rdma/ib_verbs.h              |   2 +
 6 files changed, 161 insertions(+), 33 deletions(-)

-- 
2.43.0


