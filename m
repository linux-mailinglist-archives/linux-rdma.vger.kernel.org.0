Return-Path: <linux-rdma+bounces-5459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C69A5876
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 03:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0561C20815
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2024 01:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2A8BE5;
	Mon, 21 Oct 2024 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrEIvDHZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABD2EBE;
	Mon, 21 Oct 2024 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729473347; cv=none; b=dVDUw85aJt+z2J9s6t3VitXQGLu8KckpGnn4gooxgFzUJOPFENkauK5aCHWoeVEyah36XstglSGGDTFs/MxSJKs1NqIe1QYXKdsIWrZfJ+9qCZ2fWgm7vn5sPOkK1/zetCYKknfwL9SeGQRnlE0S+bmHGKUzd5hTJgvXXqyb1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729473347; c=relaxed/simple;
	bh=BI9Q9ZUlQiY1jsmjR1g/2co4zW/naWyEETlDmd+hyhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ew+CR7W4hMu5HX8VFz7PadDhJ5m42jldKtiMwA5dtW6OBAKENJSzISgS04yTqHKwhQ0ZHEaiQBZ8O0h29ejv57BndtmHI9MqCxbDpbeJl/p8PoiWYIAzEbQEB8orwK5g/+6+lTFvh81KsFJkLGVpFeTiFmLut8HbQpFLYvfZY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrEIvDHZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c693b68f5so41078535ad.1;
        Sun, 20 Oct 2024 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729473345; x=1730078145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g83Gh21Rtk98rhGv2tDfxM2gmGbALgRmapHQzAjA6CI=;
        b=YrEIvDHZpxoZsLCN+fjBa5TEAGcHheOpRAzGj2iPodmDeMN1p8fSqqFPtHknqGYyhf
         QIeabLiTKi3gwSe7tYM17yBiyh1cW/6J/Yv2s8WcW3upOa9o+fQFLv5szMZSzOyqRJcS
         MPQXjx7vPhm1Rf+cAiF2ex1thXqXCf1yhpsjRNovKcX8v2TTLXspORILkT9sWid9IM9t
         BPzwlZRiVIpGslZtT+nc0RA9VCAGLHnM6DmY+2sh/nV9LwH4MBGVZFuaHAIQrGd8VnkK
         SIMWbpBW0r3rrWTB3O0EzobI7SIUn3AKUPB6iHqTPfP7CHQ1paJJ/+UUof2bLxCMLKWs
         78Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729473345; x=1730078145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g83Gh21Rtk98rhGv2tDfxM2gmGbALgRmapHQzAjA6CI=;
        b=FiVkc1C+9OyYkxcJuo1yjtR9CTkZviU2Cmv4pcJlFjm7sZFOo7Dn4dI7uDe2oUq51a
         ujCTRX9W0x9HTSyEPivWNgGJNUfNdR/9wHo+ZxwMq2186UnWa96IeTA5o4U+t4Kl1OOp
         u88X7f3ThI4onRn+3luIb1a7BtGy0+DI0DbJCcg90ez15LlpuyCV9ZdV2N+Uy4HwyVj0
         U4cIr/U2To7iRc5QyFcnDMPzHMn14bU/WsZDTte8OijqLwP+dTI+++NcLLjYZb/Odh9m
         57/JSzxklvLV1PKjuue05vFqedPAdByznohRpJJQPi29m32BQOcasTdCN2orUQOgoTYZ
         byeA==
X-Forwarded-Encrypted: i=1; AJvYcCWW/KPbFXAImWoKdTszQKJiSgKLv0BHfI464BeW0Oea9CXudjtSbkqGyhC4QVhfbjvZbkP+sxUbYW9JURw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hDBrIupYWEABnuygV9im0EGEQpjvh5a2lIoHy0IJp9ORjqeZ
	j0VyJvKu7I/ATddzMsHyodaVEzadF5XFJI4jsCFX4qVosA5ybgFH4c/9BQ==
X-Google-Smtp-Source: AGHT+IEGA8Nd6qo20wkr2oX1evHm81krZcanksKEUWAmKm2DPsizp4V6eH1BClDv/k4f0PpdzAdi2A==
X-Received: by 2002:a17:902:ecd2:b0:20b:5645:d860 with SMTP id d9443c01a7336-20e5a8c6c33mr115689035ad.36.1729473344935;
        Sun, 20 Oct 2024 18:15:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f58d6sm15327425ad.276.2024.10.20.18.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:15:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] RDMA: use ethtool string helpers
Date: Sun, 20 Oct 2024 18:15:43 -0700
Message-ID: <20241021011543.5922-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids having to manually increment the pointer.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c       | 9 +++------
 drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c | 4 +---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 7da94fb8d7fa..4feb7170535c 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -128,16 +128,13 @@ static void ipoib_get_ethtool_stats(struct net_device *dev,
 static void ipoib_get_strings(struct net_device __always_unused *dev,
 			      u32 stringset, u8 *data)
 {
-	u8 *p = data;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < IPOIB_GLOBAL_STATS_LEN; i++) {
-			memcpy(p, ipoib_gstrings_stats[i].stat_string,
-				ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < IPOIB_GLOBAL_STATS_LEN; i++)
+			ethtool_puts(&data,
+				     ipoib_gstrings_stats[i].stat_string);
 		break;
 	default:
 		break;
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
index 29b3d8fce3f5..316959940d2f 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c
@@ -164,9 +164,7 @@ static void vnic_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 		return;
 
 	for (i = 0; i < VNIC_STATS_LEN; i++)
-		memcpy(data + i * ETH_GSTRING_LEN,
-		       vnic_gstrings_stats[i].stat_string,
-		       ETH_GSTRING_LEN);
+		ethtool_puts(&data, vnic_gstrings_stats[i].stat_string);
 }
 
 /* ethtool ops */
-- 
2.47.0


