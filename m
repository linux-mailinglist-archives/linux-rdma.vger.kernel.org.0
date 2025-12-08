Return-Path: <linux-rdma+bounces-14927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA5CCADB71
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D58E6305A632
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2142E54B3;
	Mon,  8 Dec 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="f1koe9JU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC02DF138
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210524; cv=none; b=ZtgWmUxV8TWypC5xNE0YPaicCL3bRg4AY81u1Pe9U6JsSZYwptOQDlkCtXBG7WbF6N4j4B5eo1wsHlcRcq/qOtTlsMbEipsEYLr5VMXi+Da5mVaDqDa+1dVIudUslhs2+Jl+qh5uRDZ7gTtS9kjDCZ6qmZ019ftT1tu1R47KUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210524; c=relaxed/simple;
	bh=h/iXcp++uQuRdQMFtLiAWtub4iwxgXbCeRKOflHJa00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+IbrVhlxuKkvXC8vl4GNi5ou4NmE0ztxL7V9sSTQF/otwovZg1GFHNXNjRK+fhyaBi2PLdq/o9Q3hYRKs5e6JUozYehlUPVsoQKJm07+i4NwEI4nusbWsK6yn1Vl4iP/Nmd7NthJgJ5cRrf5Gbu74Vs7sJxDEihVco0RRMIWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=f1koe9JU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so43577805e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210521; x=1765815321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z72T/ajUMrekUrwPTx/PIadbtDX/BBz8Q7IqRq3WukY=;
        b=f1koe9JU90fKJHocMlzFfK5UusgLyYMrr0grGkWkomUKZkjOISuhDQIlJVcOFuF72N
         T0CfMWu107Do9wsxCQdBZjaGuCNzywQTs4x1jnSUMwGIlW5gKxIVgZseIK9xCrW++1oU
         arfmiWYByqBozZ738ta5HkVbJJeQEPed0T4MvFQtqYTS0JlGeHbbOTgKt7A3DYTbFF/v
         rBSyOJhtcTFH1g1arlgHHvxcF28lP0WyT5gBWzEZLZm0cBj142sL6l05WUvRzGmyvazi
         vAfguGv53maOHRKoE4hvd7oV8eqma6wvmPsFfkJlxVcTbw0WuVrgUeJqoC6NrfoRsNaf
         BSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210521; x=1765815321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z72T/ajUMrekUrwPTx/PIadbtDX/BBz8Q7IqRq3WukY=;
        b=YTuBLeBpwE3kYBAKVCnSZnUFAMTOkmumLiI5L3fTpDoTfFz3eEoqbmSce6NwqoLKZT
         Xq0RFP7z+e3gdci58l3bo8LqAgzJIKvkEdTozJk7lWWF8W7T10hVnuE8SAKlB1bZSfa9
         OvBoxXbF4hg606O+9sNv1A822t+0f+Q7cJWGIYU+A9fz9rt9G1EbB06v+0KkmcjwJCe2
         4y5Mna47GMg+hm3cGz/G6yZkuU1E8kaL4Kz8F+DAJEjmJZe59fDSi569UYB1WIVa0NaN
         mogYW/s/znsoZMLFOrQYu96f3p38IP2/f5Ga1DpPg/zsBrn8Tx3tVA1MmXKOJbDH4HSW
         z7Og==
X-Gm-Message-State: AOJu0YyAxP/GZK2ITTE2xN0aang64o6nLZsIOVonM04ymMXz7JbHF4ri
	6rdJWsz0BekXBcpTuODZbHzCjAyMaFKEDMPKFlslNhY45WoqkljJqFUzhckGuWiEN8sIWr2ufDV
	rR5UW
X-Gm-Gg: ASbGncsEeuC/fEeW78zN3PKbecY0T1/p06u+P3GLvdXe9kTorHWRGuMNVeifxLLVgfi
	nEdwLMOO7c0uLX/QQzh1Jmw55eg1zb+owGMskcw3PDxPDM2AaJlr52o9LGdaVu5MDKh4KyktNFU
	u7vf+ZLBCsn7vtYEtXkKw7LDThh0kjcSGAV1B8GTWMHAExdJDBOV5Aqt4jqpRGMQ6iPMXR+sHRp
	695UqnJ+AfKV/WiyAMFDupiDMxzJJ0Aaac4Hkx41xOXYBUf3maHCDCD+xWcGMuSLk/qyADKQzz3
	0Vu54d0E0nAHi4TRJq8GX488I6KD7bkkBFQChZ2O4p8YzVTHlRsRa39RQXqPaExffvKz9Q9CwKc
	loVORPi3O6GeY8Y12uVrZu6zmPRd2NyPV7fz5eXrcdvFtRRg4oRzO9rEHFFqAOP5h0i1zaIjqYT
	xbHlCWEjNC0JSc6oukgfMElg93qo3UdcutVXns8yMv2RoM8xZbFwZxmDLJbd8MyL8+gd0MMUXRn
	icZQH8zyN3OgCtAo7RLVTNl
X-Google-Smtp-Source: AGHT+IEkHfbjqa2cKaTSXOcl9/Zj/LvnYDtFO9icwqojjNVOfMEE87Kw/Gl3pXBz618rWHidvMUj3g==
X-Received: by 2002:a05:600c:8719:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-47939e2828cmr87686475e9.19.1765210520807;
        Mon, 08 Dec 2025 08:15:20 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:20 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 5/9] RDMA/rtrs-clt: Remove unused list-head in rtrs_clt_io_req
Date: Mon,  8 Dec 2025 17:15:09 +0100
Message-ID: <20251208161513.127049-6-haris.iqbal@ionos.com>
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

From: Jack Wang <jinpu.wang@ionos.com>

Remove unused member.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 0f57759b3080..3633119d1db2 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -92,7 +92,6 @@ struct rtrs_permit {
  * rtrs_clt_io_req - describes one inflight IO request
  */
 struct rtrs_clt_io_req {
-	struct list_head        list;
 	struct rtrs_iu		*iu;
 	struct scatterlist	*sglist; /* list holding user data */
 	unsigned int		sg_cnt;
-- 
2.43.0


