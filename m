Return-Path: <linux-rdma+bounces-9538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC6A93160
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD11B64709
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C991252919;
	Fri, 18 Apr 2025 05:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Et7pzQar"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CDB8821;
	Fri, 18 Apr 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744953397; cv=none; b=Y1WjuaaufZlHpLC2FaoRH0qziwp0uafWQtOvszAX9peUYeeDBwud23Li+vj0dDtINo12uqLrrLVM2a+3rV3DEFvYCothVo5RiT1ZllWYExU7kgkntAWut2f4qvYhYq/00G+7x3Q8g7IPTy1FB+2a3M7N0AQMJt4kmWDKMLGySeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744953397; c=relaxed/simple;
	bh=3D6YyMecF+w2jGNM4p/JeYkbIJ9gVYdp1v0x1DyLnk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K1OR+nuZa36ZGmRiLgbbYJcqEWCMf3jlT7gr9GIbspMz13DGYqqQnhtA74jhEKGZJ1Jb6l/7dq6rexgHvx5e4LFGuAefNIagSC80elDCwerRRFgmdMdWK5IIT21r+WgTkXfj+BbDmVx7lM9LWPBJxDTAOlsgd8IegCbK2xijSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Et7pzQar; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1744953395; x=1776489395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3D6YyMecF+w2jGNM4p/JeYkbIJ9gVYdp1v0x1DyLnk4=;
  b=Et7pzQarZj5BS+1ExVqzbtJKCr3Z01Km4PoFuOWDneOVr1x1O/0EZWhS
   YXy/m3e39WzxMgzlG3h8F8NvynZVk7Nmw2EqXLPfMN85sPntZK0v7JIvp
   AxEOu2MyZG0BjGN5qHcJOpBM4kXbVmSNp8RB/BRJNrd5m7T8ah09otOQm
   UWgEqppLg+slWw0T2lzDinS5HRfkc9pIGzmZQt7w4ISw1cxWGvDydaT+0
   b18GNVoneEvDKEgVF7J1bzpIcqXwhaTEKvDI6JP72yk1fjSBgRM7fZnQ+
   0fK6ePPz3qUOzRpEl9RJpUAJv8RD2b1bCt1+/O09E9SpkbNT6XnyjbL/3
   A==;
X-CSE-ConnectionGUID: BTlZQ/T1Q5+L9ImwnIIlVQ==
X-CSE-MsgGUID: 2rCgrCy+Tb6WXHfCto33tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="197221526"
X-IronPort-AV: E=Sophos;i="6.15,221,1739804400"; 
   d="scan'208";a="197221526"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 14:15:23 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2027FC2260;
	Fri, 18 Apr 2025 14:15:21 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DB0FCD8C97;
	Fri, 18 Apr 2025 14:15:20 +0900 (JST)
Received: from sm-x86-stp01.ssoft.mng.com (unknown [10.124.178.20])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 699D42005376;
	Fri, 18 Apr 2025 14:15:20 +0900 (JST)
From: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
To: linux-rdma@vger.kernel.org,
	leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-kernel@vger.kernel.org,
	Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
Subject: [PATCH for-next 0/1] RDMA/core: Move ODP capability definitions to uapi
Date: Fri, 18 Apr 2025 14:13:44 +0900
Message-Id: <20250418051345.1022339-1-matsuda-daisuke@fujitsu.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The On-Demand Paging capabilities bits are defined respectively with
identical values in the kernel and rdma-core. It is conventional that such
definitions are placed in UAPI in order to avoid the definitions being
inconsistent among the two components.

Here is a PR for rdma-core:
https://github.com/linux-rdma/rdma-core/pull/1580
The former three patches correspond to this kernel-side change.
The latter four patches are for adding a new feature to rxe, and changes
for kernel-side are already merged in wip/leon-for-next tree[1].

[1] [PATCH for-next v3 0/2] RDMA/rxe: RDMA FLUSH and ATOMIC WRITE with ODP
https://lore.kernel.org/linux-rdma/174411071857.217309.12836295631004196048.b4-ty@kernel.org/

Daisuke Matsuda (1):
  RDMA/core: Move ODP capability definitions to uapi

 include/rdma/ib_verbs.h           | 20 ++++++++++----------
 include/uapi/rdma/ib_user_verbs.h | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.43.0


