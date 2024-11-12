Return-Path: <linux-rdma+bounces-5934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7879C5144
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107BE2828CA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35920BB49;
	Tue, 12 Nov 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDWkijmg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9120B212
	for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2024 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401796; cv=none; b=BBNQKmXx6ZH+GquSQGU4vMgNipjyIpDT2wzjHFKGqp8oEQoAcgq+J/ZowYnL7YH5vzCUY3pHHxFRfEwfsOhwpFQS+77rbGSaVzBJp3ZXhIyE/ciBrYjQBh+Leh3JiJvoR4/L5SRs4OcO1jtlZaE+u0mTxbO7zy/zJsTNIGPF1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401796; c=relaxed/simple;
	bh=iGGFOXDun+rCFPYiHtDKcYd0nEne8mLZl5GT+0y9P20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+xDclAcj5wDmkn2bmU4UwuBJWqTnh4brg781UOVy1bqARNC3Sj7MCxFebrWKRFrDkBv6Tfif96qsQ7rtFcezmr2zyH9PNkf4rGSsa/+ILakXclT5yNIWz1gzOPb+fKBeqUSljkwVnATwguLVCm884BYCngw6gcs4+VRiXBdHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDWkijmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C494C4CECD;
	Tue, 12 Nov 2024 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731401795;
	bh=iGGFOXDun+rCFPYiHtDKcYd0nEne8mLZl5GT+0y9P20=;
	h=From:To:Cc:Subject:Date:From;
	b=XDWkijmgZnOnwSLu/YPu+n32sFvU7QgZ4AlHiVdCoj2OnL25xwjeSgyBbL8wbVntX
	 G1ssHOoyvMwcyaLvR+A7l5SoYVTCF7cPzKDLYizS8usVRC4UKhXCg99vy5kHNOZm+/
	 SfbxjWnPlOB6JMJqZzZr0KX3mp6XJ7xZVdB3z7pXQBI8kKuLre/R5NyDoNgng/+HRp
	 bm/qm4l2kh/TdyMCPZZW3H1x4KWG1eKU3NJWysK8oe3jmnta5lHAj9ENEytxLppSgS
	 Hr79IBCjRwjNy5iOwzESVnt4fsaqFEfVYjDr8u9Y1CecoU9dHsG2aYzOVj/XH0r7hD
	 1iXMMhRrThkCg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH rdma-rc] Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"
Date: Tue, 12 Nov 2024 10:56:26 +0200
Message-ID: <bb9d403419b2b9566da5b8bf0761fa8377927e49.1731401658.git.leon@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

The citied commit in Fixes line caused to regression for udaddy [1]
application. It doesn't work over VLANs anymore.

Client:
  ifconfig eth2 1.1.1.1
  ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
  ip link set dev p0.3597 up
  ip addr add 2.2.2.2/16 dev p0.3597
  udaddy -S 847 -C 220 -c 2 -t 0 -s 2.2.2.3 -b 2.2.2.2

Server:
  ifconfig eth2 1.1.1.3
  ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
  ip link set dev p0.3597 up
  ip addr add 2.2.2.3/16 dev p0.3597
  udaddy -S 847 -C 220 -c 2 -t 0 -b 2.2.2.3

[1] https://github.com/linux-rdma/rdma-core/blob/master/librdmacm/examples/udaddy.c
Fixes: 5069d7e202f6 ("RDMA/core: Fix ENODEV error for iWARP test over vlan")
Reported-by: Leon Romanovsky <leonro@nvidia.com>
Closes: https://lore.kernel.org/all/20241110130746.GA48891@unreal
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/addr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index c4cf26f1d149..be0743dac3ff 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -269,8 +269,6 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const struct sockaddr *src_in)
 		break;
 #endif
 	}
-	if (!ret && dev && is_vlan_dev(dev))
-		dev = vlan_dev_real_dev(dev);
 	return ret ? ERR_PTR(ret) : dev;
 }
 
-- 
2.47.0


