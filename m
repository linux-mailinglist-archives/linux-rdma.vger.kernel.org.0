Return-Path: <linux-rdma+bounces-6363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68D79EA519
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 03:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445B1286AA8
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 02:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA919D8BD;
	Tue, 10 Dec 2024 02:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFWs0bjR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B8199949;
	Tue, 10 Dec 2024 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733797634; cv=none; b=HFqx41kDLPGaPYmwQxUoL/vADR7J8yMRs5tihbQZRMaCDBQKAlex1+AY1jG3+Ve/7QJ0lW/Ui9m90tkkmBd4rxq8lnFkJHLa1sc7+wmQTvOv2y6P4HVsLDvzIeDv0CkADJknyGn96nr6Yd9SkSOzRirz2po7v6xE9waybrL/A3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733797634; c=relaxed/simple;
	bh=P9K/1F8jUaRy07xqIvk6GRg+ZQ7cdQOWsK9k3jlyN4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BTUZC6mxFyY/5RdJBegKHzE/IBU3tbtCYyA8dK9sI3VPqKJQ3HlXMOSzNcRFKl+h8jgKacBgGo7neeaVXwT4Cde0kmviIVASH1qxdNjYjMe7Ve+mq5oqYlVaBA16ZzQ8T1RAuVAQFCteb1JHmK0Kvlg++jDO7sMEggG1KYxFibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFWs0bjR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7250c199602so5119620b3a.1;
        Mon, 09 Dec 2024 18:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733797632; x=1734402432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7Inf/IBagpHI1F16LUrcy4yQaYHpb8yuceNofp6zsc=;
        b=gFWs0bjRbUwtq6rmfFHqGXi8sUenCbXlEQt8K4NvjgiQRh1sYx7kmBdBsMFsHDGqbc
         0R2VqFTHuYhcmQ85/FeZrjnoyi0Phfl8Xo44I1sNiGIXUGNBPJ1TcF81b0/B5RRxSjJ6
         grfqrzvzi1TNLrBjq3MbPP8rCb2FyCEwaqve5ksnNLvCFf/tt3JvKosW54gY+Pe0u4ti
         QNs9VSOBN3sTeZq9aUU+pqWNh7n7tfeX/XFjkkYjK+VXb0G0u1EudoptBRgwYNeaP50L
         nMUrcH6oy70EKJQibXs52jZWINFYFnpYGzr6+B1FNiv/65cXBT2yWtamW0ZnsBcSvZHi
         2WBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733797632; x=1734402432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7Inf/IBagpHI1F16LUrcy4yQaYHpb8yuceNofp6zsc=;
        b=ryb8uWBaif1BAuy1gIRx13iS+z+ioiPMcEZKkCEjZZ23Pc8dUZR0YHCFmV+3BnU6js
         XXQC5u9nDnpgREtlDGFxP/Z24YrymNXk7kHZ2wuEHRpiiPdsz7An8j42wKmcF/4EueB/
         yOC6asM8BzmbxQJsMkQj4i0QmHE1cT1jqXh0/Femb3IxwhDXWxclovscmMp/WzP6Jcc+
         kPO2LZocfHWk5LL3twAGlGwNWt0rau4NO4LvH+YU5jwvgbcs1YBdS3YuDo45LkLcyj78
         U1AwWlCimDtmNrYySdPqoB9Vf2lbYlyz3u2tWFh4ScK55V21h/Nz/wjXnz7EWNsBLzo+
         +aOg==
X-Forwarded-Encrypted: i=1; AJvYcCV1hGHoqWkientWo3kp539gr3JUcCNC8E9/LA0MBA8jQMx4twITUFkCucI+R/2gXvomZdMo4vVWkKvC@vger.kernel.org
X-Gm-Message-State: AOJu0YygC2zj2CLlQ9F2nuAL394Q1smro+zYLGGYYQ91jvhWdci3if52
	yOdrq2W+6wtQLLc1/ceKie3jS3QN8db20nb3nQpmCdy6jEeDdQgt
X-Gm-Gg: ASbGnctRIebidIRLyQG1lmbjYI62h5BTfumFCj//K4cGskaCJY/8F7JZFe0ioRWWejz
	UbVNxaHHeEjEyOjk28XJZJh4QltTOrbTOD6802Zxd83gRUCVdTK/DrStbIHk0LD3RvR6JxvxFmb
	7qULj4n4vIWE0qRC9HgB7ClOCEQYt+oUo3gDPPeL275qQRFHGzg3NokVkHO2GF8os/IZ7/1218w
	QTi+2FPju0LnSw9PenPaBQobgOLsM24hd270XuiffETOT3/ILHG5L1qHSpNqtJx6KJRQ4GZ6t+t
	IPGI
X-Google-Smtp-Source: AGHT+IHOUXtCy2OMg8nQ38PpKzg0l/zWdlxavpLGmx5w6cBBYgdSnzGQMBwjzwxo/1xE9TasQGwnVg==
X-Received: by 2002:a05:6a20:12c5:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1e1b1b5c646mr3831785637.36.1733797631650;
        Mon, 09 Dec 2024 18:27:11 -0800 (PST)
Received: from localhost.localdomain ([180.159.118.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4e9d822fsm2396934a12.14.2024.12.09.18.27.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:27:11 -0800 (PST)
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
Subject: [PATCH v4 net-next] net/mlx5e: Report rx_discards_phy via rx_dropped
Date: Tue, 10 Dec 2024 10:27:06 +0800
Message-Id: <20241210022706.6665-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We noticed a high number of rx_discards_phy events on certain servers while
running `ethtool -S`. However, this critical counter is not currently
included in the standard /proc/net/dev statistics file, making it difficult
to monitor effectively—especially given the diversity of vendors across a
large fleet of servers.

Let's report it via the standard rx_dropped metric.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e601324a690a..3117fafdabcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3916,6 +3916,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	}
 
 	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_dropped = PPORT_2863_GET(pstats, if_in_discards);
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
-- 
2.43.5


