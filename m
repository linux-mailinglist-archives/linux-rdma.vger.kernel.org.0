Return-Path: <linux-rdma+bounces-8912-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3DEA6D590
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB57169F31
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Mar 2025 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D06D259C8C;
	Mon, 24 Mar 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Vv5d3eYb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C51F92A
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803090; cv=none; b=rTJcX+KxhgNfHZQfBsugHCZsMi1GqkOdreOrOC4XqMB7kFdx8fPOUGpak6vrwGEysrHewUXDYdBC1dRvvf0hu3d/UVvXABfCUQxMAgu3YN4pRMtHHyib8asCBfOlI9L2Gsu1s8frsLDLNXTYhFLOnIMiNz18oMn0QIkK4M0PQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803090; c=relaxed/simple;
	bh=DBIkpGiCFdp5DHayPdmufWmT6VqwTjogE9fOF/9G3l4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spizHxO2Cv8jAbxyAxC5PkDARVwRFU6EDowXrg/mPEHbhnzZp4c75M0786NT4PxCIrK6ozCycORMLWFm6+PJkBslFqpNi9RiyluX11/XrlcmKbApMcPrkZWltIbNLOywvStsRDdqFV9E8BQ6u0z8HnaCz2ITSIIUynXLs1LTzZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Vv5d3eYb; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1742803088; x=1774339088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DBIkpGiCFdp5DHayPdmufWmT6VqwTjogE9fOF/9G3l4=;
  b=Vv5d3eYbiGIxx3tBBmwmoTTM+1jqs7paTJxJVVLnBHt/ghUsp8LU9/cx
   Bb9OXAgGowr4YmcsENa7xdTFOcuVur1m/X1hBnmtwhjfyaMJ2C3cTuJlV
   j7xV5V2mT8loK3bwMLBt0G0MNnIKQB3XfJ4dhrUx/fGXUSUQs3FNGS0HI
   LPffGt6vGcxt0/QRrjS411W+xnzisHCa8Nf8E7hoENYPsgw54sY7pYFlJ
   1QI0A+CWfOCf6e0G5h96iv6yy2Ghrtk666O+Hzv9fZTx7hv/ebnnKvNOd
   /fQ6b4WmVv/ljJ3aCpF71u3MP4kN6/he0Gx1VLpi6Uvi5B9xFMWsPo5NE
   Q==;
X-CSE-ConnectionGUID: TC7EUMo1RlyaqSygiitWkg==
X-CSE-MsgGUID: nqcHh24qRUKXcGuXmaH/Dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11382"; a="193204410"
X-IronPort-AV: E=Sophos;i="6.14,271,1736780400"; 
   d="scan'208";a="193204410"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 16:56:57 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 66162D6EA5
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 16:56:55 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 35370144EB
	for <linux-rdma@vger.kernel.org>; Mon, 24 Mar 2025 16:56:55 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id E88392005347;
	Mon, 24 Mar 2025 16:56:54 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	zyjzyj2000@gmail.com
Cc: lizhijian@fujitsu.com,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE with ODP
Date: Mon, 24 Mar 2025 16:56:47 +0900
Message-Id: <20250324075649.3313968-1-matsuda-daisuke@fujitsu.com>
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
https://github.com/ddmatsu/linux/tree/odp-extension3

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
  v2->v3: Addressed comments from Leon Romanovsky
          cf. https://lore.kernel.org/linux-rdma/20250319085825.GH1322339@unreal/

Daisuke Matsuda (2):
  RDMA/rxe: Enable ODP in RDMA FLUSH operation
  RDMA/rxe: Enable ODP in ATOMIC WRITE operation

 drivers/infiniband/sw/rxe/rxe.c      |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |  18 ++++-
 drivers/infiniband/sw/rxe/rxe_mr.c   |  48 ++++++------
 drivers/infiniband/sw/rxe/rxe_odp.c  | 108 ++++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_resp.c |  15 ++--
 include/rdma/ib_verbs.h              |   2 +
 6 files changed, 159 insertions(+), 34 deletions(-)

-- 
2.43.0


