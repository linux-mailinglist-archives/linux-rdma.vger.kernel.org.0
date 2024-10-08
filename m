Return-Path: <linux-rdma+bounces-5308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1BA99478C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA64B247B6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9111CC14B;
	Tue,  8 Oct 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOBYX7fi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0E17279E
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387850; cv=none; b=Quo8C3n37p3Iy9mKm/+jTfyo4Q7kQTDrRbPQcfUOExAA5jAMmy9Qcoy5FRRct+zQHLxxZ0fbEDccYkkMrr7pbEoQCLbkdS+sVSHTrTxOJOGq6gBuTl6nvJx/BXryfYY+yq7tHifvNv/hsuSC0e105scUWI4cHKQg8dIhBaaJZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387850; c=relaxed/simple;
	bh=GVTYEjPDiHMpXb6DcdGVZJ+P/F18rLC9MA1VTVyzE4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmkQC3/LBjuwJyWu5kbFVqotqa2XpHas0SEj4h0uIEgk1UmdJuqYa3gz+B1j+Z5/L69cW4pdkGpsQgv869XeD1bqpt34bSOyX9neibTYY/rsjS+LyPkrEty8kLb5G4MkfSY4yjCi+BTrS94KwMuWURYZHvxva/7EuqVwLpi0hUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOBYX7fi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EDC4CEC7;
	Tue,  8 Oct 2024 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728387849;
	bh=GVTYEjPDiHMpXb6DcdGVZJ+P/F18rLC9MA1VTVyzE4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOBYX7filAeGY5/j0uIWq0nvXdctFjSmEenKSPXFc0ZHgoCVflUpE3ceZ6apsA4XF
	 4JdC75SbIF+NHsOpkIanlglXScxHqIsQKmx8NgfV2zfq+3ZuXbnszmBXzlwZvx0dCg
	 LhtUy3iBHIkyy1vMhFBEfiMEQcwPlriZh38jkNNq5ACTTIvpQY3/ooDiUA55Q7lWrL
	 W0Yxl99ll5jCkthuFVfzet9j08ldkBy1bYaeNGUlOc/HL0QaEZfMPt+Dmgt5EDkdzw
	 EgoXlVc40u5den4nwn7rnoslSkFOEUn4A+V2QluHRZGovDLdxfUV/mMdYniSC6z8/9
	 VhucHcsWnzV2g==
Date: Tue, 8 Oct 2024 14:44:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in
 __ethtool_get_link_ksettings
Message-ID: <20241008114406.GD25819@unreal>
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
index e029401b5680..f56085b928a4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2070,10 +2070,6 @@ static int iw_query_port(struct ib_device *device,
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
-	netdev = ib_device_get_netdev(device, port_num);
-	if (!netdev)
-		return -ENODEV;
-
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
@@ -2096,7 +2092,6 @@ static int iw_query_port(struct ib_device *device,
 		rcu_read_unlock();
 	}
 
-	dev_put(netdev);
 	return device->ops.query_port(device, port_num, port_attr);
 }
 
@@ -2134,13 +2129,27 @@ int ib_query_port(struct ib_device *device,
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
+		ret = iw_query_port(device, port_num, port_attr);
 	else
-		return __ib_query_port(device, port_num, port_attr);
+		ret = __ib_query_port(device, port_num, port_attr);
+	if (netdev)
+		dev_put(netdev);
+	return ret;
+
 }
 EXPORT_SYMBOL(ib_query_port);
 

