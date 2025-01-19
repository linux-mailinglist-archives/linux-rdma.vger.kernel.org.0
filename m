Return-Path: <linux-rdma+bounces-7097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BCA16355
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 18:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C786164789
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2025 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7973D1DF727;
	Sun, 19 Jan 2025 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xyj7C/Xd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39162942A
	for <linux-rdma@vger.kernel.org>; Sun, 19 Jan 2025 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737307730; cv=none; b=n2GI+zGvPmBdQIVzvoDjxqgYwBPj9XzbrlZdbSUqrE1/bEFRKLyo7DUb82ZxPMSEIIrbNID0gv3oorpILVWUAGm9t043yoM2ZQ5XDrgrHndkJZDQl20oj6d/+giwBJu7bodHJsXOVDxaWzTdMH90Vw1c5szitLq7nyNrzWE6DRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737307730; c=relaxed/simple;
	bh=SwbpUwtM3IWoGNGTgzh16e6ruryZy8kvMHpGBwBdWoQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Oa4j6knYXC3jFXFpEq0wakdkU818ssk3S1220EXMT3ehp6Okbiyw2mCcv5tQZ/djkPgVD6mlkDLv9Rty1T9MYFYWKLjKExZCzorTaPrwoibPuOP/EfbSrw8FvTm71BtiviPjM4Oe5SumUi2V6++Qjrdj/pH2e+f/escORGgWbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xyj7C/Xd; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737307720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JxmsntAbTbV6u2c0yeGxzBbU5n8Xi1ITxuOS3FtenkA=;
	b=Xyj7C/Xdqlt/TGAzvO8hVL0YzdQhGuCHr9Jvk9CrLf6voBGWMvqIbqyESvRfI1Ho7iIYxx
	jnecUqDTN4XlH+xiMwoi00oK/waftfyPW4vpE9fS0MsYPBvynCvG4mED9xYwFW9f4BEJ0D
	kEWdNQw58aB7+Fj+D9LaVLUZA+bNul0=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH 0/3] Add the support of tun to RXE
Date: Sun, 19 Jan 2025 18:28:28 +0100
Message-Id: <20250119172831.3123110-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently the tun device can work well with SIW while it can not work well
with SoftROCE.

The RXE device can be attached to the tun device with the command "rdma
link add ...". But when running rping command over this RXE device, some
error will occur.

The following bash script can verify this patch series.

"
ip tuntap add mode tun tun0
ip -4 a
ip addr add 1.1.1.1/24 dev tun0
ip link set tun0 up
ip -4 a
rdma link add rxe0 type rxe netdev tun0
rdma link
rping -s -a 1.1.1.1&
dmesg -c
rping -c -a 1.1.1.1 -d -v -C 3
rdma link del rxe0
rdma link
ip addr del 1.1.1.1/24 dev tun0
ip tuntap del mode tun tun0
modprobe -v -r tun
"

In the above script, a tun device is added and an ip address is configured
on it. Then a RXE device is attached to this tun device. A rping test is
executed with this RXE device. It should be successful with this patchset.
Finally all the RXE device and tun device should be released after the
rping command is executed.

Without this patch series, when running "rping -c -a ..." command, the
following errors will appear.

"
...
created cm_id 0x556b45faf2a0
cma_event type RDMA_CM_EVENT_ADDR_ERROR cma_id 0x556b45faf2a0 (parent)
cma event RDMA_CM_EVENT_ADDR_ERROR, error -19
waiting for addr/route resolution state 1
destroy cm_id 0x556b45faf2a0
"

Zhu Yanjun (3):
  RDMA/rxe: Replace netdev dev addr with raw_gid
  RDMA/rxe: Add query_gid support
  RDMA/rxe: Make rping work with tun device

 drivers/infiniband/core/cma.c         | 24 +++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe.c       | 15 +++++++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 15 ++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  4 +++-
 4 files changed, 49 insertions(+), 9 deletions(-)

-- 
2.34.1


