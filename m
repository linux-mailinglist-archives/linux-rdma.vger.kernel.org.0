Return-Path: <linux-rdma+bounces-4893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AA99761B5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 08:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200291F22F57
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 06:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81018FDBC;
	Thu, 12 Sep 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="SzrOVy7K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B14418BC0F;
	Thu, 12 Sep 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123250; cv=none; b=hishDz0cWbTsFgcXPFQEyQFQU56rV+VZDeMsAGYtZM2FLhSGylcJkU2Gm8Bjj/yh9NvlLihw7P8/dwXzFGPcYd1m5OxpxTMo2baIeIldMpmSVsI+F/mVlbdULx22W2fH7H7Rnxn9SyfN82bQOmIOsHwlakG3Qx5ZQiwW8D6oOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123250; c=relaxed/simple;
	bh=XMBlrxlCPx0VfV796VkgKFGj4bPWZhKG3tKFHyzrVG4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=kVvTY/ztQHwkxR4jSb9+ma+43tp9K2cfFERPH9dBQdU2UdgCoZ2dtruEYHu62o98hEWZ+rPuXmtPgAdlXeA+csn6J+bwGYx45VyaVaTmPgqP9MJXAG8PhuZt4Wh5Or4/J7bqlMFwdcXjiLbo+FYzpHeLxsUc2ilCJhOU6Kito44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=SzrOVy7K; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6eM94019664
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726123226; bh=lJRYyaXMq7ZdxEsduECClyk7Cf2kY7DFi8yM/c0tHXQ=;
	h=Date:From:To:Cc:Subject;
	b=SzrOVy7KqkHQkubWe60ZWDZO+gmV/4WBvg/PErmAW+ZQkkYwziLGXocbuJXsvvMEr
	 YOrvQa43Prxbjn8EHyRPXaCNuhQHeEc+sBDEW8Z5Rl2/pwJJgt5Vidt8nNV3m5fuEG
	 ztKfspFRUgMROw8NdNMYFdHgsS45AjbCro5SeeSA=
Message-ID: <12a1d143-35d6-43f3-b8b3-ab0198f5540a@ans.pl>
Date: Wed, 11 Sep 2024 23:40:21 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Yishai Hadas <yishaih@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH net-next 2/4] mlx4: Use MLX4_ATTR_CABLE_INFO instead of 0xFF60
 magic value
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use MLX4_ATTR_CABLE_INFO instead of 0xFF60 magic value.

Also, remove MLX4_ATTR_EXTENDED_PORT_INFO which should have been done in
commit 8154c07fe14e ("mlx4_core: Get rid of redundant ext_port_cap flags").

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 drivers/net/ethernet/mellanox/mlx4/port.c | 8 ++++----
 include/linux/mlx4/device.h               | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 6dbd505e7f30..1ebd459d1d21 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -2052,7 +2052,7 @@ static int mlx4_get_module_id(struct mlx4_dev *dev, u8 port, u8 *module_id)
 	inmad->class_version = 0x1;
 	inmad->mgmt_class = 0x1;
 	inmad->base_version = 0x1;
-	inmad->attr_id = cpu_to_be16(0xFF60); /* Module Info */
+	inmad->attr_id = cpu_to_be16(MLX4_ATTR_CABLE_INFO);
 
 	cable_info = (struct mlx4_cable_info *)inmad->data;
 	cable_info->dev_mem_address = 0;
@@ -2071,7 +2071,7 @@ static int mlx4_get_module_id(struct mlx4_dev *dev, u8 port, u8 *module_id)
 		ret = be16_to_cpu(outmad->status);
 		mlx4_warn(dev,
 			  "MLX4_CMD_MAD_IFC Get Module ID attr(%x) port(%d) i2c_addr(%x) offset(%d) size(%d): Response Mad Status(%x) - %s\n",
-			  0xFF60, port, I2C_ADDR_LOW, 0, 1, ret,
+			  MLX4_ATTR_CABLE_INFO, port, I2C_ADDR_LOW, 0, 1, ret,
 			  cable_info_mad_err_str(ret));
 		ret = -ret;
 		goto out;
@@ -2170,7 +2170,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
 	inmad->class_version = 0x1;
 	inmad->mgmt_class = 0x1;
 	inmad->base_version = 0x1;
-	inmad->attr_id = cpu_to_be16(0xFF60); /* Module Info */
+	inmad->attr_id = cpu_to_be16(MLX4_ATTR_CABLE_INFO);
 
 	if (offset < I2C_PAGE_SIZE && offset + size > I2C_PAGE_SIZE)
 		/* Cross pages reads are not allowed
@@ -2195,7 +2195,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
 		ret = be16_to_cpu(outmad->status);
 		mlx4_warn(dev,
 			  "MLX4_CMD_MAD_IFC Get Module info attr(%x) port(%d) i2c_addr(%x) offset(%d) size(%d): Response Mad Status(%x) - %s\n",
-			  0xFF60, port, i2c_addr, offset, size,
+			  MLX4_ATTR_CABLE_INFO, port, i2c_addr, offset, size,
 			  ret, cable_info_mad_err_str(ret));
 
 		if (i2c_addr == I2C_ADDR_HIGH &&
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index a75bfb2a4438..4f2ff466b459 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -265,7 +265,7 @@ enum {
 };
 
 
-#define MLX4_ATTR_EXTENDED_PORT_INFO	cpu_to_be16(0xff90)
+#define MLX4_ATTR_CABLE_INFO		0xff60
 
 enum {
 	MLX4_BMME_FLAG_WIN_TYPE_2B	= 1 <<  1,
-- 
2.46.0

