Return-Path: <linux-rdma+bounces-3367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B0791100B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA61A1C242A4
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFDA1BA070;
	Thu, 20 Jun 2024 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJW2RHhY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE31C9EC3;
	Thu, 20 Jun 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906299; cv=none; b=i0/+JyG1mRq6yf+PnMuilfQuKx45EoFm6I6+ZpAJGTYL+ssWbwyEFruGcTCySZfeeQ/2ULsUpOcY1AN2tLokirT2xUW1niHwZSfs/HWQ9WxaQKTNn4/Q8Y/TMzVtBiE8TG1C18G9tzaKw0jB8EXxEfVerI+Cen04VWjrCnX8d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906299; c=relaxed/simple;
	bh=EEnf5xzi7eXOhkKDYzRKsCmReB+rHy33vbj/1r6jsqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjtGivw0aov+S/td7GSoPcBPCInKp6INRoVQn0Xxa9OR6eFPp+hSwR4uhzsu8ilj55TF0b3QwVGss6gWH9mWITPIFKNFmsOWDAzuDoBoQYY+Zmdo+bcIionDN7o7knbYWRPptpONM8b8o4tgyPJlwreQY/kdSwUtineqw8JYRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJW2RHhY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7061365d2f3so941691b3a.3;
        Thu, 20 Jun 2024 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906298; x=1719511098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EllZQDb/fqD8EGwJT0CuH2LSmY08c8ja9Mytx23g1KM=;
        b=fJW2RHhYQu8j9VzlQBTJNiee2IE2SLdof1Aw7zwr69AS6Hv09/UHjcdevwEW6iFE15
         sqpJYHqJt8/1E3Hwo/HzeC1KzXfchUjZhedpJUJu1CZnc92HgliMVd/Rbe7bGYeGrirI
         XkMUL+Yka8uEOQnWUA13T2/99UrG8wbd9QTq7rb66AgjIWmyAIGsLqR0oVDrpenuMflI
         Bn/oUTb7g9d/NQVqhgLZ8wp+ORkWG/9fcpDOadxhGLv3w0qqQSCX64qdLPvTHP15f5Ua
         aRdxt4BGLlgNX3syfDSN16KM8A1hOejTv05K/WM5h6jYMnSyDL67RXevfsrKJRsRPGdC
         ATDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906298; x=1719511098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EllZQDb/fqD8EGwJT0CuH2LSmY08c8ja9Mytx23g1KM=;
        b=DkFVZG+Pe4KNDRSbq4u2T4zw/JJ9yJ/8gW/eYNR69KS8szoDhufMpUgxWH5GuN1Zsy
         vdO2h0cPbX4bpqsPrX+MwFlYHM2Cq8qpjZl/6H2HFdNHJ7gwF42S10Ps9KWOHr5DY3Vz
         zaa824mpi4SVIhOKSMYeM6mJ87tt/+SdgXAk5HRMQJTRmWeSvJO7IowdZHj2fmeUTNH1
         J+ty8Duow3YBQmrLJ4fO1W13Oo1+y4Eh8mZMiStDRJxMU+i38j8M3+hhl+jnUODq0M39
         q9qtWxYYG36jrPPBziL7P7IV6lJaiZ75dqWsFWNyyr//hOaJXXucB/dCmw/CLKtQKgAo
         zESg==
X-Forwarded-Encrypted: i=1; AJvYcCVZXSKcBY1WWrSlDNTd1Me1EixHLmJgoejOn9eirFYID4FZ9Vk7YUne1Evm0eInD7yoknraZX+SNiXK2objf2xraIxig8GdEAam8A==
X-Gm-Message-State: AOJu0Yz35JKIezrNq49VusPTgS3ehTRj7S0DgGiMBdO8vqB6UofuBEUv
	IVIoVGMIAQVlwzME5rr4SndH/5hapFgZR9sh5A70kUkb2GH9Mkaoba/xFAZon1Q=
X-Google-Smtp-Source: AGHT+IEkrpt1MRFKLlVi7ulyys1DlHO0ZCczRH9xxekWr4vHxde7wTkq55+80B0FxrWnRZBVoG0B4w==
X-Received: by 2002:a05:6a20:4881:b0:1b0:1a02:4136 with SMTP id adf61e73a8af0-1bcbb386b43mr5771824637.8.1718906297955;
        Thu, 20 Jun 2024 10:58:17 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e2846sm1989195a91.24.2024.06.20.10.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:17 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 24/40] RDMA/rtrs: optimize __rtrs_get_permit() by using find_and_set_bit_lock()
Date: Thu, 20 Jun 2024 10:56:47 -0700
Message-ID: <20240620175703.605111-25-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function opencodes find_and_set_bit_lock() with a while-loop polling
on test_and_set_bit_lock(). Use the dedicated function instead.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 88106cf5ce55..52b7728f6c63 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -10,6 +10,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
 
+#include <linux/find_atomic.h>
 #include <linux/module.h>
 #include <linux/rculist.h>
 #include <linux/random.h>
@@ -72,18 +73,9 @@ __rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs_clt_con_type con_type)
 	struct rtrs_permit *permit;
 	int bit;
 
-	/*
-	 * Adapted from null_blk get_tag(). Callers from different cpus may
-	 * grab the same bit, since find_first_zero_bit is not atomic.
-	 * But then the test_and_set_bit_lock will fail for all the
-	 * callers but one, so that they will loop again.
-	 * This way an explicit spinlock is not required.
-	 */
-	do {
-		bit = find_first_zero_bit(clt->permits_map, max_depth);
-		if (bit >= max_depth)
-			return NULL;
-	} while (test_and_set_bit_lock(bit, clt->permits_map));
+	bit = find_and_set_bit_lock(clt->permits_map, max_depth);
+	if (bit >= max_depth)
+		return NULL;
 
 	permit = get_permit(clt, bit);
 	WARN_ON(permit->mem_id != bit);
-- 
2.43.0


