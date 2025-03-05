Return-Path: <linux-rdma+bounces-8383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23BBA50E3B
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 22:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806E67A4F66
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 21:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61C5265627;
	Wed,  5 Mar 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjmsF5CP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DB265623;
	Wed,  5 Mar 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211888; cv=none; b=rG6iqrPJL1UKdNNVmwjfr24X4sXOYgRmdn85LB+4UZn0a1cXr9QdKUz8dxPfQ7ATLNWuloxG+PyJR67/Oaoa8im5hX4nxIk7yM8oFAZQOaVcPgLxRyImciJboCN6qmdBI42p+Fq6xTePQ61B70rddE0q/mMBgG+4jjAgExSezTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211888; c=relaxed/simple;
	bh=YjCoTZOlRS6mMKAdwn3KYADg0QYwOfrGsO4eUnmKbrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJbUIpslRsI85puOFtri+lILTZPmvnL9mWyfta5SqDPFm7ZHiH22RLbUC4DFm81oX7/shhOwPVRPiYewljGGAZ+P0UeGYqHu3hUd19zVQrIL5mf3Vglrjgo1uzYVcswQQ6ppvnNwPsLtMV4kC41+QCmJFgUgFhPTxefrC2aNNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjmsF5CP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741211887; x=1772747887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YjCoTZOlRS6mMKAdwn3KYADg0QYwOfrGsO4eUnmKbrA=;
  b=JjmsF5CPpCRT6G5jOajZzKxLsXhvbYfEFHZ7xFwN/S6k24xtwhQI3plx
   z5ySqCrngQ5niyHy29GXiyMia1reKegf6m2cFHh4crAJWKWPtlJLqJVRA
   4yEbsm0Sh0Nu3j5nqgwnYuodLRnw1oH8MiUGzoo2tz360ZPPIIcJz9syI
   yTYZ5LLCRGeTJ0r1VNCcxRWxjrLyBnwUAZzhYCcWZid/vsuPtSa5ML4bk
   Kh2tXF3ScE4yLHxlwP9gTooiiqkCbLzsVKQeoaf0g5tfUL4VlFaND117h
   8PTfo+rm3x4LtQj04SOsfROswIn2OvsyXMf0b4+kvFn6JNf89yborzbRO
   w==;
X-CSE-ConnectionGUID: f7bEEKluTDa5B+5yAWoe4g==
X-CSE-MsgGUID: PRn9JyIET2Om/AXlI6qNMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29782148"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="29782148"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:58:06 -0800
X-CSE-ConnectionGUID: rDzw+rSEQNC1DRHrvZ9gCQ==
X-CSE-MsgGUID: K5ultmhORqKLAlF6zM31Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118741658"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2025 13:58:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	tatyana.e.nikolova@intel.com,
	leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next 0/2][pull request] Fixes for "ice: managing MSI-X in driver"
Date: Wed,  5 Mar 2025 13:57:51 -0800
Message-ID: <20250305215756.1519390-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 26db4dbb747813b5946aff31485873f071a10332:

  Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue (2025-02-06 17:34:36 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git for-next-fixes

for you to fetch changes up to f798c4bce163411673e49b7d07587aff7896ded4:

  irdma: free iwdev->rf after removing MSI-X (2025-03-05 11:27:15 -0800)

----------------------------------------------------------------

A couple of fixes to the "ice: managing MSI-X in driver" series that
were found after merging.

Dan fixes an off by one issue on error path handling.

Michal adjusts location of freeing iwdev->rf to stop use-after-free
issue.

----------------------------------------------------------------
Dan Carpenter (1):
      ice, irdma: fix an off by one in error handling code

Michal Swiatkowski (1):
      irdma: free iwdev->rf after removing MSI-X

 drivers/infiniband/hw/irdma/main.c  | 4 +++-
 drivers/infiniband/hw/irdma/verbs.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

