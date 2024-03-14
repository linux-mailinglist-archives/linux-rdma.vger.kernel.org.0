Return-Path: <linux-rdma+bounces-1430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4087BBDA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 12:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8561F2359B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Mar 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D46EB5C;
	Thu, 14 Mar 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPTKJx2b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B931E4A6;
	Thu, 14 Mar 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415302; cv=none; b=hUtIqmCgK4VpufkuRRblsA+JlyECsh9z8iogIeGwFctKNgmHPKaVTqlw5q79dfiIMuLEEUQQc3ZppoafPZVwMO01Qvgk3tU2Z5KrpZYK8XrM55U+lPwa2VK3wMUr4iD2Cx/xd9Nl2wzpIR61/dn48xlxJ4u7JIlV4lh9m4phH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415302; c=relaxed/simple;
	bh=/e4egWfyHLEr6CKVlApdU6rX/Pl05FzCsMuWzLLtWuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZAZztBcTzs7dSdjDhzGbGBSVaFZ3XDdHvM+9xrnPjwoJnstiOOleHvM2aCMjGqcwvZavO5pngecn46pPwyOTdLcNR4+EqufMXycLM+rpK6hSPEete9iZs/9m6Gex7BZnSfAjCiJFpo2TFgk9+aGWiUY80MN+egiP/Xb49BrP8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPTKJx2b; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6ca3fc613so655326b3a.3;
        Thu, 14 Mar 2024 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710415301; x=1711020101; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AeW2q5R52plyXVS3rUk/RqZo0VpJ2WOdd43z+DAb70=;
        b=RPTKJx2brrjIq/TihSRrQ2dAuPx0YcqnSr572272tzVuQEcO4QJklJxLsgJviU6enK
         fH6xhEHqGVgxdX5RL3jMpJbcoXYuvtq7g01/I00iunrxGCB7uGKWCoCJf1ITUxV+Y1yq
         LeR12CFjtVFhUlfRSkb77Fh/MsjVm2I+b8/JglvXCcaivVImt5FvERTNfjS9VcZmF9u4
         cOfrmXBE8H1uc3JmVB5cAXLB7rqEl81JH2+9QzialYjIi7x8/kkjaURDgFSZJqtU+JPk
         2pZEjF3K7stAd6lciE4G1PFxHNUHWhtbCZVx4CA004/7AKNPvuYD0dkpWoziQ9QwlHT+
         75mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710415301; x=1711020101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AeW2q5R52plyXVS3rUk/RqZo0VpJ2WOdd43z+DAb70=;
        b=mEy3uqZK7nCqrW9P+0ux5FoYdRnJYQeyExDJMi6wCf5J0Y0Zf0Easehet66cEnp+tc
         f9jeynmPT2Q16qSK5y46YBKJ2CziICfT8XTL+LH4gYd041aIUSBHoQtluJuu8mQWAlGA
         DoOAjn2IjK1wic3oYE0z8te+0dA38LJyYeKvwNyG2qPvlOZKrQBzwuzJ67IqAvh4rf9C
         xr72Ym5dS8g70SjW1+Vjsp7J9V6wz4IXB8y90Y+c6Al+DlUPduhkavTUGGOjVyLUZdR4
         5zNfs9kDDdIf5mAwoakW+zXTTusdSJ50NRtlqpv9QxOjt7dJjgAETudfDHf3x87n0dEq
         OC9w==
X-Forwarded-Encrypted: i=1; AJvYcCWYKWe/vg4CvPc+ccCeUqrKrCAxbFW/JG2mWbZOcxXaf9HVjLUKuKCU6Tw8IAJn7WeU0BfAuDWTMh44cNaUmdNzvU3MhyUzaspNS5UHKhHEIclglV72c1qWkKJ3n/f1xy7/oe2k8UB8yQb/QA4byovF5jJ+/VQsjC1sSt1wgI0JBg==
X-Gm-Message-State: AOJu0Yy0ka3ush9gHQaYJAzXCNr0uegaLQDOZ1fq/KTpv5mLmua4wFNJ
	3blZzsdUgkpv+37OUKR1uHexP9MswuOhPjWD7Eoxm+tpbj38Gj4F
X-Google-Smtp-Source: AGHT+IH1qTv+002pcVWpFQ6wjJkyWYtmkGCa5KRii43/enzZq51zlGHAIAtz2cl8q0jE+qGj0eEBKg==
X-Received: by 2002:a05:6a21:3a46:b0:1a1:484b:bb72 with SMTP id zu6-20020a056a213a4600b001a1484bbb72mr1637487pzb.51.1710415300659;
        Thu, 14 Mar 2024 04:21:40 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b001ddc83fda95sm1424238plg.186.2024.03.14.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:21:40 -0700 (PDT)
Date: Thu, 14 Mar 2024 20:21:35 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: [PATCH net] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
Message-ID: <ZfLdv5DZvBg0wajJ@libra05>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so they
are expected to ensure acquire/release memory ordering semantics.
However, test_and_set_bit/clear_bit() don't imply such semantics, on
top of this, following smp_mb__after_atomic() does not guarantee release
ordering (memory barrier actually should be placed before clear_bit()).

Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.

Signed-off-by: Yewon Choi <woni9911@gmail.com>
---
 net/rds/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc6..8f38009721b7 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(rds_send_path_reset);
 
 static int acquire_in_xmit(struct rds_conn_path *cp)
 {
-	return test_and_set_bit(RDS_IN_XMIT, &cp->cp_flags) == 0;
+	return test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags) == 0;
 }
 
 static void release_in_xmit(struct rds_conn_path *cp)
 {
-	clear_bit(RDS_IN_XMIT, &cp->cp_flags);
-	smp_mb__after_atomic();
+	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
 	/*
 	 * We don't use wait_on_bit()/wake_up_bit() because our waking is in a
 	 * hot path and finding waiters is very rare.  We don't want to walk
-- 
2.43.0


