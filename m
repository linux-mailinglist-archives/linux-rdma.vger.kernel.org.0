Return-Path: <linux-rdma+bounces-15439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA276D10CB7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 08:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D48309B671
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42710329C7D;
	Mon, 12 Jan 2026 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b="anTil1tn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from www5210.sakura.ne.jp (www5210.sakura.ne.jp [133.167.8.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA630171A;
	Mon, 12 Jan 2026 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=133.167.8.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201469; cv=none; b=fGXvog2oXW1UOiKGmhi0eBgzG4RYyg2wihJZqMBZq8lOvj2IS2vBXqmGUhRBqHQJuMaIpNDU9JT3heNN5/0lB2y3U/y/SjPg3iguV7iBwvGx0QrntU9vJHP0nUbvx64i5KDmx62tyipmAwyQc18qs42VbEkcajpHPJBiiQ5OCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201469; c=relaxed/simple;
	bh=esO6uWafR2EY4B/IxQZXOrPuPt/Pg00SHCmazwLp3BI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONux85ZFjgtlnIkUDK5rNMVeDjy2ziNjCIPdnf47vdUzB3Q60bAcHOa6AbBhXDcMN0f56Klfb7lOnNCQvq/zzR2IIS6hI2fgf9E6WpbtmtWkPeNqqCxVQxJeiQmyjoVrS5cmhZ09tJjAJG8Ara/yUqY/hLb1FDy3eduhKG0waj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=mgml.me; dkim=pass (2048-bit key) header.d=mgml.me header.i=@mgml.me header.b=anTil1tn; arc=none smtp.client-ip=133.167.8.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mgml.me
Received: from fedora (p3112209-ipxg00a01tokaisakaetozai.aichi.ocn.ne.jp [114.173.113.209])
	(authenticated bits=0)
	by www5210.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60C73Ylf068770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 12 Jan 2026 16:03:44 +0900 (JST)
	(envelope-from k@mgml.me)
DKIM-Signature: a=rsa-sha256; bh=vnjgIdyu3sSbrPktVtB/o1O6znU6bm1lyfWA01IqtMc=;
        c=relaxed/relaxed; d=mgml.me;
        h=From:To:Subject:Date:Message-ID;
        s=rs20250315; t=1768201424; v=1;
        b=anTil1tn2Tufe03NLas2UYxqxPnJgk4Cs6LCUsDqQcLSwBOPLXbUNW/ejJHJVwI2
         Tfoq5wKxEZK21TER5ckDxdW78h8ATYaY627E47RbLxykP6WdpX7cBhLIPY/jdkr1
         9p/Eel3B2te1O1eMzTacax/Ji4urmoN75LZ+aaNTZVGvufVbbEZBSQNtgf44d7a9
         Au+3Lrtc5S0G5dVmuPMfVqOf4qh7jsZ84gZ1t9RurOMsNP8YDL5JDl3HiQHLuiGo
         azbz1LIos8pLgzR2rCOyeUS6Mj+LkHys6b4mCPigQWJoGwSRtJIIWq/Zf02nwiMm
         2LZtIq7egapszsIZCmIuGg==
From: Kenta Akagi <k@mgml.me>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kenta Akagi <k@mgml.me>
Subject: [PATCH RFC mlx5-next 0/1] net/mlx5e: Expose physical received bits counters to ethtool
Date: Mon, 12 Jan 2026 16:03:23 +0900
Message-ID: <20260112070324.38819-1-k@mgml.me>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to measure the cable BER on ConnectX.

According to the documentation[1][2], there are counters that can be used
for this purpose: rx_corrected_bits_phy, rx_pcs_symbol_err_phy and
rx_bits_phy. However, rx_bits_phy does not show up in ethtool
statistics.

This patch exposes the PPCNT phy_received_bits as rx_bits_phy.


On a ConnectX-5 with 25Gbase connection, it works as expected.

On the other hand, although I have not verified it, in an 800Gbps
environment rx_bits_phy would likely overflow after about 124 days.
Since I cannot judge whether this is acceptable, I am posting this as an
RFC first.


[1] commit 8ce3b586faa4 ("net/mlx5: Add counter information to mlx5
    driver documentation")
[2] https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/counters.html

Kenta Akagi (1):
  net/mlx5e: Expose physical received bits counters to ethtool

 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.50.1


