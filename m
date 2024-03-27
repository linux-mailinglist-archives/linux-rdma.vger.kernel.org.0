Return-Path: <linux-rdma+bounces-1593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D688EA07
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856701F33F4B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C912F59C;
	Wed, 27 Mar 2024 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEVXKgSe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4E12EBD5
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555061; cv=none; b=l+8emsfwI3WKi9fM2TMb+AMxU2i1o+soYfrHYzmUHo+0RI80b24/UHSfccpAklhLgawrlW37JXKN9ElkFCZO6M2tF+rZZSgWIkn8LmZurPV6zzLdctc7haydxr2NM93GxUKO4qUijqq6CTxmXdVX08hHXn8OSC32JQvPp8olVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555061; c=relaxed/simple;
	bh=hu+sSbFLIXAKlrWao5wVCYP2Ee0hJ4jSnfY4fHwka+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqZCZUXp37AX4DANBF6Va3e1CCpGMDnB296Vph61xdQ6do3bqQxYfhsnSH9SubkraKQKNG30JQhLfruae7kQw3IMe2cPIpCWfW5WtoEma1duJYsVctzGlBXUaBcvXH4orhE0Gq8R9DJluxe/YcNS3ahX6C1LW52dzIbxoTOZFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEVXKgSe; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e67d42422aso4134412a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711555059; x=1712159859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhL5vLaHOFdZg37ZOMVXMEp5PFqWRWgRRVOZKVIqNG0=;
        b=NEVXKgSe/EOIjGN0OubCDoA2SgrkKXYHHTRaT3FkDGhO6CIgjXMDdqS2x6IzunxHbV
         tdLH3JPz75ZhXiq2ysO+iufxmNCOkCuKTNme99ogoit6GjUe/ryKNYA4mJJYDn3fChr6
         Rl1Lj6R/QnoVpKEPUYokXRngPbtp/ljLFT84xDdqKja0AZUk/Ktb+AcF49l/oSBF//6V
         oG23vusj0s59aEY53to56uPKiMMGJPwus2+ZxdczpuJAodpUhiYflI08TdlHzSeq4/80
         1pNo48vjceCnN1nfduaF1y+oJYhN0pw+mEHKui1hCMEFwwOgtdrR2HW2eZS8WPo5BgpC
         T2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555059; x=1712159859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhL5vLaHOFdZg37ZOMVXMEp5PFqWRWgRRVOZKVIqNG0=;
        b=ZLSGxyrccgPLU2BrKZ92Ux30yNlt47R/guYKIJtnTlnOtam3arPL4Wc53Qk7KqRPzP
         xByxOKeXf0Hd3D9zRc5N8MRdDb+zzqGy9giWskU3b5G/pG7jFNQ+Po0FIDdVpgNPnHup
         X2Jl5tLEfwyFi1tmJGd7sVBlcAXAzO/dCI/mLwxE/pezlZExTEOlKZNe04WyvmHBiWAc
         3xeHdllUMauJjIu7Rbe++udgXcasbI3KlUkkdtQ3c9CIEvKgCM00P/buYJJO5uOw3bfd
         EYwSg1tvGS2vrLILk1s8c3B7TTV+bCWkMcRkkkC5zzsNKRcvoPPrtDYsEAppobQMWLYt
         izEw==
X-Forwarded-Encrypted: i=1; AJvYcCXpHJqg1XrPm7EGm3JSd4C+wtrmEbfLA/r9Bm0XXzohKTX36nySVygDI4wIVARH/zRiTw4Ih8j79zLlqNETP+R8EKp+mWBdxKVdTQ==
X-Gm-Message-State: AOJu0YwJu4RGD28sAFW6sHDPXUJWYqusSPRdXy8rzVwYIGT13en9VrYx
	8uPgyzK0z9Z+OD8A1aOzVnkXINb9wqmeXveE7gJm1N8KvI/7s3I3
X-Google-Smtp-Source: AGHT+IEbM1PoZiSese6LDqebDqkYPP56mc6WYm8BiDGp2/jLJScVCLNivCFMxYTCyFF1k1Jk7NUnaQ==
X-Received: by 2002:a9d:4d8c:0:b0:6e6:c74e:e763 with SMTP id u12-20020a9d4d8c000000b006e6c74ee763mr365721otk.24.1711555059653;
        Wed, 27 Mar 2024 08:57:39 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e6e3fdec53sm883487otq.35.2024.03.27.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:57:39 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 01/12] RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
Date: Wed, 27 Mar 2024 10:51:47 -0500
Message-ID: <20240327155157.590886-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240327155157.590886-2-rpearsonhpe@gmail.com>
References: <20240327155157.590886-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_comp_queue_pkt() an incoming response packet skb is enqueued
to the resp_pkts queue and then a decision is made whether to run the
completer task inline or schedule it. Finally the skb is dereferenced
to bump a 'hw' performance counter. This is wrong because if the
completer task is already running in a separate thread it may have
already processed the skb and freed it which can cause a seg fault.
This has been observed infrequently in testing at high scale.

This patch fixes this by changing the order of enqueuing the packet
until after the counter is accessed.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 0b1e5b99a48b ("IB/rxe: Add port protocol stats")
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index b78b8c0856ab..c997b7cbf2a9 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -131,12 +131,12 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
 	int must_sched;
 
-	skb_queue_tail(&qp->resp_pkts, skb);
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
+	skb_queue_tail(&qp->resp_pkts, skb);
+
 	if (must_sched)
 		rxe_sched_task(&qp->comp.task);
 	else
-- 
2.43.0


