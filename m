Return-Path: <linux-rdma+bounces-6316-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D69E6999
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 10:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CDB18842FC
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Dec 2024 09:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E61E0DEA;
	Fri,  6 Dec 2024 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1xhZt9w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0611DE3C7;
	Fri,  6 Dec 2024 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475824; cv=none; b=Gkm0lN4b3nFWZbmq80QPrT72Gh1G9eXIhdxVCd69cWlU5lLVE088N0H5cEf5kU8Yoi5w5WJ5zj3IqDXYSUyV/TdTcQ/lYJXcWyls9yokY86Pu48nxQD4ezeFVn6U3SUAqJUnIIWfKmdifIq9FtOptrWQVHjVuJ+pbS1PzME0AHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475824; c=relaxed/simple;
	bh=9aDqtlCUiJKrKZPRA9Pwb1mlutnI39j9QaNes07JbYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mXTUWQGgQOFDE66LouOAyh0ZLvFyQtpfRbr5vYrtsqnpvHlucgv70WdXdr+EuHstnjoM+9aC3LBjHH99GGYVVeM6Q6PfoLDwUGSoC8Fyu/UyASj9nMPDcR5ETFV/J6J6P+kWU+ull6l0A7mdL7mPUhSWqtjxXcEO1mW40+HBL8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1xhZt9w; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215bebfba73so17262525ad.1;
        Fri, 06 Dec 2024 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733475822; x=1734080622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNmkcABijER99QBs4F7z9voX03afqB9KDzNNlLM/0Ug=;
        b=a1xhZt9w2zPQWnvCWTwb6fB32vhNzSvxTtdi/dFXkIwnrgYLhR2262Y0fc3rV2Ey+0
         YOnEMk1+p9Rca5G965pPscs4tQ3YgHTFNgDR0u5F7/3YAwdwgvqqNmTWvjzTcgGyznv7
         vpBbpwpasA4+zx64ka/kwCE1FDx/AOQPyJNcX65syioGnVKMroMpRDxKyftAmaAfxKDK
         jGq9Vc7G7hurXMesFwzJuyVI012E1Co6TVM5elLheu8IGuvjavwNa7dv2eutH2sdmp/i
         ctqK4e0MOT199KZrSswm4WHWUravZMLwZ/ZBe4YNmQW6bF9qZ7ZRDf0ynNK8a148qat3
         ieJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475822; x=1734080622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNmkcABijER99QBs4F7z9voX03afqB9KDzNNlLM/0Ug=;
        b=LJY3O9jIWruFlU7qqghKHWoCl8YLUkl+lIe3q+EryBv/VLWbuw8AaILvAalvpb7zZ2
         O0p9IZZYLGfO+fnPljLC0qzkJs708VQKk/PWuxAKA7oAZG7HwtcEOyT8ulT40H9cPJiX
         ixGXJPQXEa0fym+MnNKFhkDqNn3XBobebYhyDMqpM3oMvOaEuBe1tQ9S6RHqMu1ptn0T
         4zcF99PhNNcAetlqu3SqFE+e6I6ThY5NRHFSjTYThb7cb0fsMDKM6JoCIpAB9hdclTyG
         YOcayfJ+l9EUwRRnk77dlXgVvgj+xrth3Mkl5jXqE+199A8LbiJ+R471wz1pen8jfRnA
         YJHw==
X-Forwarded-Encrypted: i=1; AJvYcCWNxbBstPR4HZRicHCNGMqcuUV56qaCKwWq6/T8Jc/1mTV2jMD93vpcuPMH2/cK7m5l5Hr46On4Mvqn@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5DpsJaih1uw8eb3KJimC3Q6ig+3Xo+nxKnN4NfROYng5/cU5
	2rGiG5a04oPJnHNWrg4QESB6jKvf4vltYkREJbi0jLYx3nBITV7r
X-Gm-Gg: ASbGnctJWZCNP6cW6BDoitUnDNphTkqC4ZdpXzQkofixQlSkodXKw6yQpuo2Fe5T1LH
	Fk7nAPiKV+7EfFbKd8rddOPc5L3J4kr68t+FQa5bmUpw7k7xMda2+/kfEPQzwMcl5wmfhEy5b1W
	pjEO2Dyr2UKRftgCpEuyvezjtChGjta3eYTj81aO8w0AOgj/5dL9JQE82l1b+9tUA54i5MAq8Fy
	2cTHvoKbwkiDPs4g/9aM1rrrfNtLAy5y/i/DiF5OfONq9HEYPRX1b/zZoFnl/YQQfuCLfdIZcKv
X-Google-Smtp-Source: AGHT+IFXJUzXxiixFJYgU2jzZEtyzJ26r56ck1RGtjGbb7M1Eo9JnZ/Qy7y1GpXJEtcGyDHGKK8Rxw==
X-Received: by 2002:a17:903:245:b0:211:7156:4283 with SMTP id d9443c01a7336-21614dc5181mr26133795ad.43.1733475821697;
        Fri, 06 Dec 2024 01:03:41 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3ea67sm24632395ad.28.2024.12.06.01.03.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Dec 2024 01:03:41 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: saeedm@nvidia.com,
	tariqt@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>
Subject: [PATCH v3 net-next] net/mlx5e: Report rx_discards_phy via rx_fifo_errors
Date: Fri,  6 Dec 2024 17:03:28 +0800
Message-Id: <20241206090328.4758-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed a high number of rx_discards_phy events on some servers when
running `ethtool -S`. However, this important counter is not currently
reflected in the /proc/net/dev statistics file, making it challenging to
monitor effectively.

Since rx_fifo_errors represents receive FIFO errors on this network
deivice, it makes sense to include rx_discards_phy in this counter to
enhance monitoring visibility. This change will help administrators track
these events more effectively through standard interfaces.

I have also verified the manual of ethtool counters on mlx5 [0], it seems
that rx_discards_phy and rx_fifo_errors has the same meaning:

  rx_discards_phy: The number of received packets dropped due to lack of
                   buffers on a physical port. If this counter is
                   increasing, it implies that the adapter is congested and
                   cannot absorb the traffic coming from the network.

                   ConnectX-3 naming : rx_fifo_errors

Link: https://enterprise-support.nvidia.com/s/article/understanding-mlx5-ethtool-counters [0]
Suggested-by: Tariq Toukan <ttoukan.linux@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

Changes:
v2->v3:
- Drop the changes on the Doc

v1->v2: https://lore.kernel.org/netdev/20241114021711.5691-1-laoar.shao@gmail.com/
- Use rx_fifo_errors instead (Tariq)
- Update the if_link.h accordingly

v1: https://lore.kernel.org/netdev/20241106064015.4118-1-laoar.shao@gmail.com/

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e601324a690a..15b1a3e6e641 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3916,6 +3916,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	}
 
 	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_fifo_errors = PPORT_2863_GET(pstats, if_in_discards);
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
-- 
2.43.5


