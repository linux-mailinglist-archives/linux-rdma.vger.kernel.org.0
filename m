Return-Path: <linux-rdma+bounces-5309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90A9947BE
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 13:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7391C24F1F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9B1D54E9;
	Tue,  8 Oct 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0FZK6K+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679C176FA7
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388290; cv=none; b=rzgDB/gkowIx5cJRTFxal1zLE8a7K995cov2mOYCVu/qbUBelalpVv5AXyQW3dD+Svv/9BGxAjFeMP8Bu9yDlfXyIm8juzwiTACRKJ4f3qklZoVokSR9Z3y0TUOpRwvSixWICIa+ctY9v+uKwbSt9jEo42zAHRRoiOeS5rnEIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388290; c=relaxed/simple;
	bh=G8aoHW5v4fVgEbHEO2yl3tTlhqHFDWg9PB2P/YEz++A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD/c800M1YUKuPn2cNaUpXJeemXOG85IqhRJ4M9AFh2UvmRZMxnTj8IFLQStQGexeiq+ke8jYKDI7XWIIb6MrW1N9r7uPz8Ohio9cz0qTeCD5+xudsE338mDeL4bqteRcsRng9lWSFzGRquh90s2p/9J+t4RoZ52z81QEbTfSjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0FZK6K+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AF9C4CEC7;
	Tue,  8 Oct 2024 11:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728388290;
	bh=G8aoHW5v4fVgEbHEO2yl3tTlhqHFDWg9PB2P/YEz++A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0FZK6K+ctkZI7+FxCQhZzpKZkmA3/ynW7Co03Q4Oygjo8/M+uu32bNEpbJ/7hgsU
	 UnJPvKOLY5jx0ETp7WXB1Cgn3zKGyn+UZHSia1mSSQQzhkVXizGE1CAvVJygDfw9zY
	 h2w1ENtGzLzCC0KUfp96Ejmm/RyTmWFBJDR7bzksxKrGV6BvSnfIL/YoWJyTurtgVa
	 QCg37q32iHDfu8YX2D2ZX0iXHwb4QwbpQ7yOvecmhV/hJqWslsx+m1VRWqGXBiUlGO
	 d4uI62fcAx+QtrQdCcyDqSRlNCl6wlbzaq8UM8POeonQEUlawWfeiEytbbVHZvKtx4
	 m0ph3MiY5gQuQ==
Date: Tue, 8 Oct 2024 14:51:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 __ethtool_get_link_ksettings
Message-ID: <20241008115126.GE25819@unreal>
References: <000000000000657ecd0614456af8@google.com>
 <67048e62.050a0220.49194.051e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67048e62.050a0220.49194.051e.GAE@google.com>

On Mon, Oct 07, 2024 at 06:44:02PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 5f8ca04fdd3c66a322ea318b5f1cb684dd56e5b2
> Author: Chiara Meiohas <cmeiohas@nvidia.com>
> Date:   Mon Sep 9 17:30:22 2024 +0000
> 
>     RDMA/device: Remove optimization in ib_device_get_netdev()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16db2327980000
> start commit:   c4a14f6d9d17 ipv4: ip_gre: Fix drops of small packets in i..
> git tree:       net
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15db2327980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11db2327980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11eca3d0580000
> 
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: 5f8ca04fdd3c ("RDMA/device: Remove optimization in ib_device_get_netdev()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index e029401b5680..0b7e5245ffbc 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2061,19 +2061,14 @@ void ib_dispatch_event_clients(struct ib_event *event)
 	up_read(&event->device->event_handler_rwsem);
 }
 
-static int iw_query_port(struct ib_device *device,
-			   u32 port_num,
-			   struct ib_port_attr *port_attr)
+static int iw_query_port(struct ib_device *device, u32 port_num,
+			 struct ib_port_attr *port_attr,
+			 struct net_device *netdev)
 {
 	struct in_device *inetdev;
-	struct net_device *netdev;
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
-	netdev = ib_device_get_netdev(device, port_num);
-	if (!netdev)
-		return -ENODEV;
-
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
@@ -2096,7 +2091,6 @@ static int iw_query_port(struct ib_device *device,
 		rcu_read_unlock();
 	}
 
-	dev_put(netdev);
 	return device->ops.query_port(device, port_num, port_attr);
 }
 
@@ -2134,13 +2128,27 @@ int ib_query_port(struct ib_device *device,
 		  u32 port_num,
 		  struct ib_port_attr *port_attr)
 {
+	struct net_device *netdev = NULL;
+	int ret;
+
 	if (!rdma_is_port_valid(device, port_num))
 		return -EINVAL;
 
+	if (rdma_protocol_iwarp(device, port_num) ||
+	    rdma_protocol_roce(device, port_num)) {
+		netdev = ib_device_get_netdev(device, port_num);
+		if (!netdev)
+			return -ENODEV;
+	}
+
 	if (rdma_protocol_iwarp(device, port_num))
-		return iw_query_port(device, port_num, port_attr);
+		ret = iw_query_port(device, port_num, port_attr, netdev);
 	else
-		return __ib_query_port(device, port_num, port_attr);
+		ret = __ib_query_port(device, port_num, port_attr);
+	if (netdev)
+		dev_put(netdev);
+	return ret;
+
 }
 EXPORT_SYMBOL(ib_query_port);
 

