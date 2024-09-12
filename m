Return-Path: <linux-rdma+bounces-4894-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1649761BB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 08:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044E2288F31
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885518BB80;
	Thu, 12 Sep 2024 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="j0l+p40m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D118952C;
	Thu, 12 Sep 2024 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123299; cv=none; b=Y8wzXbE2af6Q4yB3Ako2Dw7OlafJETOyu4W/BRJ4kTXBWZVM+NURr0m1/qO2tSnlQRLhsLqtM1B92m+8DGBiEH8GQkedY6+zKONpX3rV8m7hQD/dfEU8NLn8bWsMurdQc+/s2kfuu3fGDZlP6eKolfeTE+Jv9SCbp7ejD4rym58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123299; c=relaxed/simple;
	bh=zIrVbo2KbiQUEuSx07s3yuqK2iwfLP6ZlnpOTlHmQh4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=q9jkzASvVuvAeU9EghQyzNmP96s6YrSyhU/epYvtfR11i4UckacLW/IrLxHROzgFoUG0XF2zgrf176YzCyUQ3F7ZumhrfENdZE45d3TJsTR6AH1rJ0S8Q9fSgdyK/IiXQ0VhsUJxOJXHlmSSlZedzm9oral4yGyWrqN0j11hn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=j0l+p40m; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6fC48019711
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:41:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726123276; bh=J+6fkP0ad5n7/Hr0nrC4Rko89CYV+gxUyBVkcGsfPE8=;
	h=Date:From:To:Cc:Subject;
	b=j0l+p40mowfmQdO4uw/+siNe9SeOcm5tiT2Zk78OpI/BzRr571pENBIGtDWN6el/J
	 3W24m6ZZaUemL8m+mfMwbrGZ+xYjbAwnLkLqsBnXgvCPBnNr60fsc/aOb8rdyeDU11
	 DsjML8Y1rP0wI84xXzSnKIQNHP/UAUygtB9EvMeQ=
Message-ID: <2aa0787e-a148-456e-b1b5-8f1e9785ed04@ans.pl>
Date: Wed, 11 Sep 2024 23:41:11 -0700
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
        Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
        Amir Vadai <amirv@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH net-next 3/4] mlx4: Do not mask failure accessing page A2h
 (0x51)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Due to HW/FW limitation, page A2h (I2C 0x51) may not be available.
Do not mask the problem so the userspace can properly handle it.

When returning the error to the userspace, use -EIO instead of
"err" because it holds MAD_STATUS.

Fixes: f5826c8c9d57 ("net/mlx4_en: Fix wrong return value on ioctl EEPROM query failure")
Fixes: 32a173c7f9e9 ("net/mlx4_core: Introduce mlx4_get_module_info for cable module info reading")
Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c | 2 +-
 drivers/net/ethernet/mellanox/mlx4/port.c       | 9 +--------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
index 4c985d62af12..677917168bd5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -2094,7 +2094,7 @@ static int mlx4_en_get_module_eeprom(struct net_device *dev,
 			en_err(priv,
 			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
 			       i, offset, ee->len - i, ret);
-			return ret;
+			return -EIO;
 		}
 
 		i += ret;
diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 1ebd459d1d21..8c2a384404f9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -2198,14 +2198,7 @@ int mlx4_get_module_info(struct mlx4_dev *dev, u8 port,
 			  MLX4_ATTR_CABLE_INFO, port, i2c_addr, offset, size,
 			  ret, cable_info_mad_err_str(ret));
 
-		if (i2c_addr == I2C_ADDR_HIGH &&
-		    MAD_STATUS_2_CABLE_ERR(ret) == CABLE_INF_I2C_ADDR)
-			/* Some SFP cables do not support i2c slave
-			 * address 0x51 (high page), abort silently.
-			 */
-			ret = 0;
-		else
-			ret = -ret;
+		ret = -ret;
 		goto out;
 	}
 	cable_info = (struct mlx4_cable_info *)outmad->data;
-- 
2.46.0

