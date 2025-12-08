Return-Path: <linux-rdma+bounces-14931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646BCADB7F
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16D773072E02
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDF2E22B5;
	Mon,  8 Dec 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LuuwXyyC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3F2E62C8
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210528; cv=none; b=t+pO4AkJCfM6X2DX4VUdef8gz6viwqyKAsTNeSZW5r2a40pXx11CB80X0+OjESLGIwjponyDuzbcDIH9o+t7jSMHSBh6nbP9lRQm2CYe3Dxw7Lr4R8RHjq+DKCWJAgqafIUejfG7Gz8T2inWVzViABVpnntKcbBD/o3UlkHGKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210528; c=relaxed/simple;
	bh=gbGRGODT6JLwORu3WP5FxAh59/HqdoWxbu/sYnXcOTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlL5VPNCDcZbCZcHpYBgrBcYO8UQF4F4zNAz/sdDe53AyLxq0jV9I3nsU2D/MjF06EF9reH+NZrVRdgdWUWOfhYTWnLYtUrUDsAlU77vMW30KB9gHQi//KhHGoo1W0w1uA95rJzrTJvUbe60up3HZoNZybJpHDbCm6BUKCxQEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LuuwXyyC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477563e28a3so33513505e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210524; x=1765815324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqCa47HMjCmWeLLuxUL8lvGFx6hj7PYfVsUYt04GJFw=;
        b=LuuwXyyCPteiU8FcvSOZLGZ1iFux0Tt/B/zhuJGRcro5115a+M/bSF4BjBrhD9RUtt
         zFjiNvE+ijn3RltXnTeUF9yTi1c3ZIrU5B1r8VawaB1AWoBTCGB5l+Zo9WjwPX5MwOAo
         5kL9UD5iRzMYWc+oZLGz6cyLazwQ8mt6cg7wTUkn2E50+nMbIJIYlkTPlbo63iIzleqi
         7h7868u5KZlm1B7dHHd0n31LyxlI1VRmwIzSwLx9a0jgwoNCYc7OBj/w6OWW6C3G+7by
         IATTtlA7lP0dPI33ML85d0A0Y08Uq9a9YgvEn+UxiKnDa6Cyd6mhPsxv7rKNLS7y1XUL
         mIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210524; x=1765815324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PqCa47HMjCmWeLLuxUL8lvGFx6hj7PYfVsUYt04GJFw=;
        b=L/lgl17cwsCTjqHYf3j5iUAybs+jsbQAXeIcFEtbUwb1JY7iNWg24L0Ht5hxAG3xRb
         4BdGF+xf+r5fcChF9/Z6lfymrwYMNH7QDIuRKk9gY/cRbpjoE55teJ77KXtN2U7/IkAj
         cTiKmHrh0PwTeF0z5gD3FrwlYcmNbkACng+5hNtvz3qLvF33Ge6oM4aRp3E0Nt7UDkSf
         Zqlq+4IHzUctRamsd5HDjHIkYZ6z8pQqtP40tmVw/i0FydunN4wQOUJATbFRhpwbjOun
         P6Wdz5v6ZG7VwMCng09K3VpvCXxwJoK4DndDDCQICMzd3ByDnNjFF/SJnIfdq5LnyI0g
         LO8A==
X-Gm-Message-State: AOJu0YxZS8GaGWVFUQNZvxCtjpSvDh6jti8phhWeAwdz2B27etEeH9g3
	fe0mbrB90oX61YUocr9dPKPnHfBzPI7FHmBQowBV+N9nqQNVexcQHBBz2P6FK6kFNPGdbu7LMpm
	boeVw
X-Gm-Gg: ASbGnctGoFpcqKbSR19jwmPTmVXA45Vg4Xhh9HI9xF9EW21VFZ2BERSthOHc7a005yK
	sD7JGdOCpNksCFXRY5roytS2+PzBVb8c46rlFq6dz1VsuVifpitYAOSZUX7IGfeIyU/OywbbX8R
	9fTtoyWz83zgFwJQqhdkYWpzn5GpTYBLoA9LWaFEQ+e/m2hjTU20tkPlFrnKouzj3zOGxOgZC9H
	tzh2CAn3vrxvcQOqFQvfJHYpyaur6MzEI9c283O6ZU1gm9bx/imXXG7xTdmOG8uI8fid3GyAr4n
	csNiJA/rR3nmQadniHFEHHpsKGgl9l5eIkP9hITKF4yKL71V1kzamu7oR56L4k3DUDIdK9WqvdV
	2yLoE1GeUK3ETrpFf3v3ragxVS5sYOWCo2DW0C3U8P1DEf8aDBAJzklfAuLT1YoPnxuxLru3tZN
	vilh5Lo4sumBYcl05l8aCxa4uFC2yqQsY966W+v8gEL6q8zUMsgSzwWZRilFAH4J3RkZK3Z/vk3
	5PruL0dxLGPecstlIHr0N3E
X-Google-Smtp-Source: AGHT+IH0ESSTBCNxj6VNCuF1CDZwTzrlClXzipkjj6tIGF00dF7QmlYPLaC/Kc8i88RHNQn2Qen8Jg==
X-Received: by 2002:a05:600c:a08:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47939dfa053mr105959405e9.6.1765210523914;
        Mon, 08 Dec 2025 08:15:23 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:23 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 9/9] RDMA/rtrs-clt.c: For conn rejection use actual err number
Date: Mon,  8 Dec 2025 17:15:13 +0100
Message-ID: <20251208161513.127049-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the connection establishment request is rejected from the server
side, then the actual error number sent back should be used.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index dcf5704366eb..3e62da5eaca7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1929,7 +1929,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	struct rtrs_path *s = con->c.path;
 	const struct rtrs_msg_conn_rsp *msg;
 	const char *rej_msg;
-	int status, errno;
+	int status, errno = -ECONNRESET;
 	u8 data_len;
 
 	status = ev->status;
@@ -1951,7 +1951,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 			  status, rej_msg);
 	}
 
-	return -ECONNRESET;
+	return errno;
 }
 
 void rtrs_clt_close_conns(struct rtrs_clt_path *clt_path, bool wait)
-- 
2.43.0


