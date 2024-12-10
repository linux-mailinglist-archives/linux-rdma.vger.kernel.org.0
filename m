Return-Path: <linux-rdma+bounces-6373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FF9EA9AE
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 08:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C61169034
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 07:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257D1155327;
	Tue, 10 Dec 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5Z60lLA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE379F2
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816012; cv=none; b=TDL6mygaGGNF4SNHmkg0q8DEENUEhxVbtQ/sVdiEc3sRotNK4M4oi1GFIoMWJz9vHqTOl0RO79sjlLtmNQdJJCahqNPIy+frSvZ4ENWvlKQqO/GCXKMLfmW5REf1vWQmOwuRSIepstKyg3iF07UAP8UZ4GgcSRsV6SAvgOwqbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816012; c=relaxed/simple;
	bh=v07F4rgHO+0WNHN4a7J0YhlBDatve2kkUwimAptWNJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNokiyCn9vi/gVa2bDJATd+FJxMCitWaBkfL1D2SN5ouhcXGQJX/MAOnLWWDRM0/+g0YJFGMJ+Rui0/QGqF/MSOef4j7WT/Ql0vwCKAa9aPIsINF8287KZaO0p+Zpr6xlV6O/uiGVS6MbNSy5VgyKmSS1pR8n1waJeZFoE+pOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5Z60lLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20E9C4CEDD;
	Tue, 10 Dec 2024 07:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733816011;
	bh=v07F4rgHO+0WNHN4a7J0YhlBDatve2kkUwimAptWNJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=K5Z60lLANaw/hfppWCbfAoj13r+rNsaIkXkK4BwMRZdijFqi2XXmZ5W5oc0sJWKZu
	 kvb/vf9Bw0DklncJwLFSpHpFh7zQ1W1MpkLY6azu3ySfDKh97w9Q0YlGWOQIF1gtnH
	 v6Bi/ukfXhUXBwfWTCVnDewCe+CaA6lml6RwHEVDsvJOchNbaNbHFKAH4nz+pcZDvq
	 V/qpBHYHRxh6gRnjZer1aKe1ruuzxE0Y4yjr5phviLb1bOKDHa6WYw7zLrKx43lk7l
	 zst7CiPCeBvutCyXPsOuOoE/ridyzI9NfGvlf6HmAX3Pdgvwu4bicOOgJNF3OE9GqS
	 3P5kZpVZk9kfg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH rdma-rc] RDMA/nldev: Set error code in rdma_nl_notify_event
Date: Tue, 10 Dec 2024 09:33:10 +0200
Message-ID: <13eb25961923f5de9eb9ecbbc94e26113d6049ef.1733815944.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

In case of error set the error code before the goto.

Fixes: 6ff57a2ea7c2 ("RDMA/nldev: Fix NULL pointer dereferences issue in rdma_nl_notify_event")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-rdma/a84a2fc3-33b6-46da-a1bd-3343fa07eaf9@stanley.mountain/
Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index acb02f8c87c0..f13aa2661f06 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -2966,8 +2966,8 @@ int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
 			  enum rdma_nl_notify_event_type type)
 {
 	struct sk_buff *skb;
+	int ret = -EMSGSIZE;
 	struct net *net;
-	int ret = 0;
 	void *nlh;
 
 	net = read_pnet(&device->coredev.rdma_net);
-- 
2.47.0


