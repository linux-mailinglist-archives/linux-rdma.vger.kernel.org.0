Return-Path: <linux-rdma+bounces-7361-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4065A259FF
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 13:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8381B164481
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754D207DF1;
	Mon,  3 Feb 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0t+tC2+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D95207DED
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586925; cv=none; b=QTAf2pUuZgf24ltaQocA4Fw2pBkeLd8h80iGnYcRGuvn8zWK58Sc50A8dUeNzoJvu4f+WyXvqU1fS2F8C6yxNl0vu63BICgv5G6V7cyqgGvJ8xmyCGfp8hEaWtZexcXc/Z8KDDjygXwZDaeoXGG3Kiv0PJpY3SXQ/j+Sv68BEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586925; c=relaxed/simple;
	bh=I/6kTPuGF9r80a0srh6VE4oZIujlyJ5NQyUrGsQKM7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rmk8Y7tE3VayvvOGRjpvWrQ3kJ8jF1hgT1HA0qKl+F4oDAd9SZFCzXiICMkl8gzleYNC5SEAJacP4jrqQjhnmgIv5Qdi7pNIfnhv3wsiy0FtGShA4nqHDZ0PAxI34wb9QeP1dqUn4veDxIdq82uX/EYgH6vsiduSWNxn6ccpKRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0t+tC2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337DFC4CED2;
	Mon,  3 Feb 2025 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738586922;
	bh=I/6kTPuGF9r80a0srh6VE4oZIujlyJ5NQyUrGsQKM7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0t+tC2+Qxx7/9U7i+avc8LuyvdLwLzRhqN6yWu8EtsErOimwDygJSWGy4YwV8pai
	 NA4S73j/vTE8PoAZEj5SG+KjbOn6Lb6NGL7XHpFs7oAsuqZyXIF7GynfVg+I/SIWt/
	 LooezlltqJKbGxscNKKanTlMfOv0nsqEn2FOU8XIdvjeTcauYFb3bW74q3+QtmFzqN
	 DIm0JRpnGC+J27lZRttizxMgUbaR3Wpln9jGne5BjWTpxiBfLV0WzaGYwcRhlAq0rF
	 kkGgURgzE1CGanFbITQhpcMAMu3fELhsD8ya5dqhQeR4gBipq8agrqvXggoXNOSshf
	 i8bPWdvlWfm9w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/3] RDMA/core: Use ib_port_state_to_str() for IB state sysfs
Date: Mon,  3 Feb 2025 14:48:05 +0200
Message-ID: <06affabbbf144f990e64b447918af39483c78c3e.1738586601.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738586601.git.leon@kernel.org>
References: <cover.1738586601.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Refactor the IB state sysfs implementation to replace the local array
used for converting IB state to string with the ib_port_state_to_str()
function.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/sysfs.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 9f97bef02149..7491328ca5e6 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -216,24 +216,12 @@ static ssize_t state_show(struct ib_device *ibdev, u32 port_num,
 	struct ib_port_attr attr;
 	ssize_t ret;
 
-	static const char *state_name[] = {
-		[IB_PORT_NOP]		= "NOP",
-		[IB_PORT_DOWN]		= "DOWN",
-		[IB_PORT_INIT]		= "INIT",
-		[IB_PORT_ARMED]		= "ARMED",
-		[IB_PORT_ACTIVE]	= "ACTIVE",
-		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
-	};
-
 	ret = ib_query_port(ibdev, port_num, &attr);
 	if (ret)
 		return ret;
 
 	return sysfs_emit(buf, "%d: %s\n", attr.state,
-			  attr.state >= 0 &&
-					  attr.state < ARRAY_SIZE(state_name) ?
-				  state_name[attr.state] :
-				  "UNKNOWN");
+			  ib_port_state_to_str(attr.state));
 }
 
 static ssize_t lid_show(struct ib_device *ibdev, u32 port_num,
-- 
2.48.1


