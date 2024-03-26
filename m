Return-Path: <linux-rdma+bounces-1569-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B288CB2A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 18:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BE8B24A87
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Mar 2024 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C93B1D543;
	Tue, 26 Mar 2024 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaDsNrxz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E837A95B
	for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475075; cv=none; b=H1vOUNA3kFbOOcNzj2OEgbrzxgLY9TZt+OZym3Vcngp771xmg3+MAGYa8cRuLQQqYu4Z/w5w+LkXbxinSfuGVkYMawv09ykoqfEiMQ4JtAf/OVYnqsHHu0toBDiFevA8TwxstaMqEySY5BmIEUM3R4M4V1ka8nLUt3a35/nXPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475075; c=relaxed/simple;
	bh=hu+sSbFLIXAKlrWao5wVCYP2Ee0hJ4jSnfY4fHwka+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoGkSJwy8Xve6ktiQAUIkyZwku4KgSaTgbfQ+VsvsnCA9xFnbh0zZABlnduprF8NGBjvFzaIYt7pqbmG65hPNy2b36eVlYqhEoGBPM24094spa2IuscRyhJspkntIZDB/0kjOBLjL0lDvB9ONN3VScPVp4tue9w+ZS8LKFoGTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaDsNrxz; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a550ce1a41so1298874eaf.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Mar 2024 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711475073; x=1712079873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhL5vLaHOFdZg37ZOMVXMEp5PFqWRWgRRVOZKVIqNG0=;
        b=DaDsNrxzhsOT/5mbOgbmUJtmkQJMZMRSLIFoczN2UQ6VsSfCwAk+6spb0Rw/6De/6H
         uExZR4LJsvcvv9bmM2VjKkHvbtNZheT554nPYff4FnBGVXJ9hUONHA8Vs8rQIwXrAre0
         QMG6LhtXl61sCCcqceeXi+eJWrMBQslmvEOQ3Vjd67hVG0re6nEVjnPkct0HsPiOWsTn
         uBMnUWgWf59nkc7WXkAYdX9rCU7cM4jnalEhO6IGG1xP9TO36l1LvpP66evVc6+coAp/
         iLfhIvRHe/Nn7ED5BVvxt6qhQs9R0SF5jcBvA61NKKI/LlX+46Jw4jt4e+fc9/HgqdDc
         3KiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475073; x=1712079873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhL5vLaHOFdZg37ZOMVXMEp5PFqWRWgRRVOZKVIqNG0=;
        b=MieXfU/u0qDWrgGfIByCCXZWYco2aCbM64wHDdYEo5PeDBpqaa4Ngtbk4DbNbCgvDx
         J5DzqRq8C2xdGxOAfRvpRjTFRFNmGQvmn1fLaVPW5ulH7W1tn5pNsFSj+Zt/poiyeP/p
         5ED6rPr+ziUHIFECXglJeT4IPX9teDaRBLt8+xUk4yXZhd37x7M6i0otynh8dRabLb7b
         +nlvB2vcfYX3tUSAYGoUyUZneIBeQ4jWvhxmK67OToty/D3VOjepnCN+Sh9KoplFNsv/
         PXcth72y2EiftFgS4SbLXA+o7xMxpO/MuBN/oSCpBT7eTLkS1FoB2gKl250TY3wTqhcH
         uhcw==
X-Forwarded-Encrypted: i=1; AJvYcCWgwNklaZMvnQXjaxM76zMtisFX48QxapxfO7trTCLnMJxhDOIiXtPs0gVcx3BJ9/7b8P/X8G0VoB0rXWg5epgsfcKeaVRxO6MOmw==
X-Gm-Message-State: AOJu0YySJcn11lW1LcKIuWl2hxFm48Pm8UAdobBWAmNXvQxnQEoaAanG
	ch8l/ui42HnPLDkRz2Q6TKNlebYbs6bqbsCFtD+/sAPDPoein6aX
X-Google-Smtp-Source: AGHT+IFi0gtl1AFuLLl2FrF715P3WXrNf58O+sk6a+R67N1NjDvqrcsq8GXppPZyVAQZPIL26Qdy+w==
X-Received: by 2002:a05:6820:3083:b0:5a5:639a:2faa with SMTP id eu3-20020a056820308300b005a5639a2faamr2004027oob.2.1711475073400;
        Tue, 26 Mar 2024 10:44:33 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-b62e-99ff-fef9-fa2e.res6.spectrum.com. [2603:8081:1405:679b:b62e:99ff:fef9:fa2e])
        by smtp.gmail.com with ESMTPSA id i10-20020a056820138a00b005a53e935171sm1399860oow.35.2024.03.26.10.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:44:32 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 01/11] RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
Date: Tue, 26 Mar 2024 12:43:16 -0500
Message-ID: <20240326174325.300849-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326174325.300849-2-rpearsonhpe@gmail.com>
References: <20240326174325.300849-2-rpearsonhpe@gmail.com>
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


