Return-Path: <linux-rdma+bounces-5655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D19B77DB
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A6E1F24FA6
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA5193439;
	Thu, 31 Oct 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbqi/JKa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24807881E
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368104; cv=none; b=OADFWb9znP+g0kZEbuzQZoyhTtTooBeo6T5V6xJ2RVpXilFIRPM1xu97cDFrRvBMoUjDeypuYuXMZvmVEJ7Qe9z0L9ppjFQiYZKgy2+Gl1oyB1bdfBO2ftRf4ehlN2TLf6BPEC2fCCMmWk1+QnnoLTAEoHKBv+eLPLrb7/J1YFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368104; c=relaxed/simple;
	bh=aNOZ2CmuiHNyjBwqFvEgOgXepLs9RrAJDma4LVAmKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWJv5mm69SiUZkUEu9ragWOi2JQ3TGTmvjM3sEHoKHFkDtc7rwpmZIxxDHT7tYOvtAOnl9vClWRJRUhbvfV/oxmVjbTgnKoVxKibRt/WelZj0CWPHzL3d3t+S+C2OvpkyFC2vSrpgni2piiCr2DPGRMG+uV53SHFjkWz4baDUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbqi/JKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25801C4CEC3;
	Thu, 31 Oct 2024 09:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730368103;
	bh=aNOZ2CmuiHNyjBwqFvEgOgXepLs9RrAJDma4LVAmKz4=;
	h=From:To:Cc:Subject:Date:From;
	b=Gbqi/JKamB69s5Zp8uitcAFv2PjdDFSUScG4X0QWo6tOa5DmWUl5Wm94MamFV7d08
	 4A3+YMv8pV/fsNnowPtKpeqht6ZiHiGE7ya2ijXwftxsBGtrUQO4sqhuWS/EtPJsgx
	 5C/pWj1+Z7e3HA5Ex6SVH+yUez/3MhBZDKdumuEHHrGwvnn4Z3nYX+0WWFlgaNIWxE
	 xb/sA1EzN6CKu1L7kJcrtHuME0PCFtjZEX9jmOi0RE9Yv7sByaZhwbHXHtCP1ioIgN
	 yomubVPy1PGdB2WzSlDcXDdX7NPUele7wBcy4c+KcyAgj9N3UJYc1G6Ag/XKOty8f4
	 Hagrw/6Zbgj2g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Support querying per-plane IB PortCounters
Date: Thu, 31 Oct 2024 11:48:14 +0200
Message-ID: <828d57444a0a41042556bb0a4394ecf2fcaed639.1730368052.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

On a SMI device, set requested plane_num when querying PPCNT register
with the PortCounters Attribute group.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mad.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 1b6c5e37d169..2453ae4384a7 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -278,7 +278,13 @@ static int process_pma_cmd(struct mlx5_ib_dev *dev, u32 port_num,
 			goto done;
 		}
 
-		err = query_ib_ppcnt(mdev, mdev_port_num, 0, out_cnt, sz, 0);
+		if (dev->ib_dev.type == RDMA_DEVICE_TYPE_SMI)
+			err = query_ib_ppcnt(mdev, mdev_port_num, port_num,
+					     out_cnt, sz, 0);
+		else
+			err = query_ib_ppcnt(mdev, mdev_port_num, 0,
+					     out_cnt, sz, 0);
+
 		if (!err)
 			pma_cnt_assign(pma_cnt, out_cnt);
 	}
-- 
2.46.2


