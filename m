Return-Path: <linux-rdma+bounces-2568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE648CBCDE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22658B215CA
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7B97F7EF;
	Wed, 22 May 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EQIlxrWp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850078061F;
	Wed, 22 May 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366249; cv=none; b=iKWtXpdZPAq9gzVndlb3RyfzvTLosecAPGI4MvUJJ7M4UU2bQX3kK5PGUqQa0i6/DPxyVn7N6iKxS+3JB8vld+yCJtZb2wWbaSmOebRFtWMaqMp/9HUqsFNKrB97ITu1ehx59I27n1fimQWaIux2fg/UsIBJeBwq2dGKHDqq3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366249; c=relaxed/simple;
	bh=WW8olC3eTArZzrqCjhroBlhu5q5PE/1WdEiKUVo/Iew=;
	h=From:To:Cc:Subject:Date:Message-Id; b=M98IOlVQVI5IULOsXjmuTrIl9/3rImoVy60kCR09AGeSYwAJlGr12N8SvjpqITw/9vAVzwzm74SQNh3bqHXqhi/VDw+FSRuaKvOOORV4Pff061Kn3vXdPkhrpQf5GLZt8Of1RPeb/iRe8UPcMuOBnMLU0+Ez0PGOCd3RkNimIgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EQIlxrWp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0508020B915A;
	Wed, 22 May 2024 01:24:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0508020B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716366247;
	bh=HsbSLbtjwfFNdGkPVNkoExIhdGgewlE+wCx6VMLl9cs=;
	h=From:To:Cc:Subject:Date:From;
	b=EQIlxrWpk4KpVfCjICMzneOzVR/jywUwY6DD3W3IV9nJlJN7YnapDYLNz49UNLNnc
	 /L4TBXpVhFBWYbQbcht0+S3s4ZfqKDpwfbaDuxGyk8v7MoBtvwFyLooZf6uTnMPx84
	 wpQouIDaCqkAdQmsVSZj4uP80qdm4UUgzULyXt2A=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v3 0/3] RDMA/mana_ib: Add support of RC QPs
Date: Wed, 22 May 2024 01:23:59 -0700
Message-Id: <1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com>
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

v2->v3:
* fixed c99 comment style

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


