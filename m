Return-Path: <linux-rdma+bounces-4895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570299761C1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 08:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0189A1F23162
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 06:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257918BC32;
	Thu, 12 Sep 2024 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="D8MtRxoK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD168189BB0;
	Thu, 12 Sep 2024 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726123354; cv=none; b=IxdyMeYoCaA2FEVx8iXpOflxWfHFnL8nYBDpPvDXjceSZkFhQu9hTuBlJRuaGVH/uZk+rkO7/IISFQVTLnWTWxgODcoeM+qtt2DtHdLt2z7VZy/wTWUNyyLbaL+yk/RQHlonOCVMrf1hPUiPI/msDTkeYA+fdXuAEglctLi2d7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726123354; c=relaxed/simple;
	bh=D5Pn4h1284j4OUOqpZme8DG3ltDWWwpkQMEEd3WMpgI=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=l6r9wMPnk2a0KASyodxY9aOOc+8OeszgpFzLyOOZvPR0oCyOf3Sris8iKhNfw9I9KbtXCYbmWxR44DQHwUoa7BWWmt+XfGHDUCehlnS8vWR2J+zQ0cpvkw+p++op8xy/VqJoPUlW6dEYOu0RlDHWm0JhHAhiPiF4kpuJeDNZq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=D8MtRxoK; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6gBPw019738
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:42:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726123335; bh=OQCdqXcgMg0VpcDr+sngwSohrYLV13e2sD1Rt2GwKuc=;
	h=Date:From:To:Cc:Subject;
	b=D8MtRxoKVDXnXt0bG7GbM4aDlSymXdaKtUepfxG9kS2bIXr60Oj0vkMjA0BcybjRA
	 zKj2ZUfxgAj98uufwJl9oQkZn0uQkFRchWDHEx7UbbYw4N3nZ9A2jq7wrb8FtGw5Jp
	 bDbmRqguon5fCbjHvOUUb9N950gvt4RjitZS+uVw=
Message-ID: <d04814fb-1ee1-4987-b8a1-d7d6b834c360@ans.pl>
Date: Wed, 11 Sep 2024 23:42:10 -0700
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
Subject: [PATCH net-next 4/4] mlx4: mlx4_get_port_ib_caps() cleanup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove magic values and casts from mlx4_get_port_ib_caps() and use
proper structures instead.

Replace 0x0015 with MLX4_ATTR_PORT_INFO that is named after a similar
const from ib_smi.h and because "GetPortInfo MAD" name is also mentioned
in the Firmware Release Notes.

Use cap_mask name after "struct ib_port_info" given the offset (64 + 20)
matches.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 drivers/net/ethernet/mellanox/mlx4/port.c | 26 ++++++++++++++---------
 include/linux/mlx4/device.h               |  2 +-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index 8c2a384404f9..d5109e38cbd5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -1054,10 +1054,15 @@ int mlx4_unbond_vlan_table(struct mlx4_dev *dev)
 	return ret;
 }
 
+struct mlx4_mad_port_info {
+	u8 reserved[20];
+	__be32 cap_mask;
+};
+
 int mlx4_get_port_ib_caps(struct mlx4_dev *dev, u8 port, __be32 *caps)
 {
 	struct mlx4_cmd_mailbox *inmailbox, *outmailbox;
-	u8 *inbuf, *outbuf;
+	struct mlx4_mad_ifc *inmad, *outmad;
 	int err;
 
 	inmailbox = mlx4_alloc_cmd_mailbox(dev);
@@ -1070,20 +1075,21 @@ int mlx4_get_port_ib_caps(struct mlx4_dev *dev, u8 port, __be32 *caps)
 		return PTR_ERR(outmailbox);
 	}
 
-	inbuf = inmailbox->buf;
-	outbuf = outmailbox->buf;
-	inbuf[0] = 1;
-	inbuf[1] = 1;
-	inbuf[2] = 1;
-	inbuf[3] = 1;
-	*(__be16 *) (&inbuf[16]) = cpu_to_be16(0x0015);
-	*(__be32 *) (&inbuf[20]) = cpu_to_be32(port);
+	inmad = (struct mlx4_mad_ifc *)(inmailbox->buf);
+	outmad = (struct mlx4_mad_ifc *)(outmailbox->buf);
+
+	inmad->method = 0x1; /* Get */
+	inmad->class_version = 0x1;
+	inmad->mgmt_class = 0x1;
+	inmad->base_version = 0x1;
+	inmad->attr_id = cpu_to_be16(MLX4_ATTR_PORT_INFO);
+	inmad->attr_mod = cpu_to_be32(port);
 
 	err = mlx4_cmd_box(dev, inmailbox->dma, outmailbox->dma, port, 3,
 			   MLX4_CMD_MAD_IFC, MLX4_CMD_TIME_CLASS_C,
 			   MLX4_CMD_NATIVE);
 	if (!err)
-		*caps = *(__be32 *) (outbuf + 84);
+		*caps = ((struct mlx4_mad_port_info *)outmad->data)->cap_mask;
 	mlx4_free_cmd_mailbox(dev, inmailbox);
 	mlx4_free_cmd_mailbox(dev, outmailbox);
 	return err;
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 4f2ff466b459..e64fc35c80b6 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -264,7 +264,7 @@ enum {
 	MLX4_FUNC_CAP_DMFS_A0_STATIC	= 1L << 2
 };
 
-
+#define MLX4_ATTR_PORT_INFO		0x0015
 #define MLX4_ATTR_CABLE_INFO		0xff60
 
 enum {
-- 
2.46.0

