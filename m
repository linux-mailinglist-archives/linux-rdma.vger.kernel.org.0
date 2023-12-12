Return-Path: <linux-rdma+bounces-380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F980E1D8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 03:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B28A1C2177F
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Dec 2023 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279F79E0;
	Tue, 12 Dec 2023 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp2Nz9P4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326A135;
	Mon, 11 Dec 2023 18:28:32 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5df49931b4eso28081517b3.0;
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348110; x=1702952910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXHhxsG3/UhGgqamsfrlyZxDKNFN6ooaZwOKCcSTfsQ=;
        b=jp2Nz9P49zWcrnTotdEWzMcMYlaNUW3Iqrj1F4Lr1niQgy2JKLY9kFqZzAultqMUBr
         ZHokKXNSda1Q3xriJREOyA+qW3LPfwA2OE5TZoxSvnaoeuE8aR6wqXpqAQI6RxmkTvAF
         pYqiaCGXQ29IIBsZ8uxxkFeR0pvbrN4YxbS7sHUvnIWuk6w6Rq3cqijp9lBLvJsBVLiZ
         aa5qTtj+pIPkA0w0c6OmhTaqanANwIlM3O2gH2xh/GpEyxBSsvTZAjfu0B+4jQbaiwc+
         t4WwcLk3ZKsIHV4pZnlQLuvb63G1o2ULmxkIizGDNA0zTJ1hH3TowJs4XewqcPHKNjFp
         ChzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348110; x=1702952910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXHhxsG3/UhGgqamsfrlyZxDKNFN6ooaZwOKCcSTfsQ=;
        b=xIfUdLzkmGrnaYCvmOS/23hjKA4tqcA1DJ2OTdrgTRs+LrL2Jxr7pISgJAbaHulsHt
         kn7gsSXKlwwNAb94Fpk6SznMIQbctlMYsVrXOpBpNhjuzZO9PNr3s9qpbiY1yvmfVXwW
         /F2KT0JV5PI5fQMLVXcF95MdXO4FHn7j67kpgPL8OsrMR7CaNTaQ5G2pZ6Uwn6hui4wZ
         VqAj1E5uMdUUr6yAK3B0V/VSWx4KSYJ8XgSzG1uk4ZP8+0HRmZ/JIjPKgpBD4Z5buzTW
         7AABXKwPN4m1o7FEEuIl/7ldFY3LCScptH5Ahk3YLIYljwGlYzgGUFsA916hYmNue8ib
         siTw==
X-Gm-Message-State: AOJu0YxE4uyH4ODJqaMG/IgDQCjH4fagOZpxS02HeEoDJ0qja259LjR2
	uQcUpJq27oz9vPuMViMOO+x16KfAgb+hrA==
X-Google-Smtp-Source: AGHT+IEhd3bdmNrEQft62JVx4q4yoIhcniOB2WhrpWCIonS9sKp3c3BAImI4DTarVU93O6a3waqqkQ==
X-Received: by 2002:a05:690c:4505:b0:5e1:9f39:b084 with SMTP id gt5-20020a05690c450500b005e19f39b084mr762715ywb.2.1702348110591;
        Mon, 11 Dec 2023 18:28:30 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id j72-20020a81924b000000b005d716572128sm3471268ywg.17.2023.12.11.18.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:30 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 25/35] RDMA/rtrs: optimize __rtrs_get_permit() by using find_and_set_bit_lock()
Date: Mon, 11 Dec 2023 18:27:39 -0800
Message-Id: <20231212022749.625238-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7f3167ce2972..9f1c612df392 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -72,18 +72,9 @@ __rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs_clt_con_type con_type)
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
2.40.1


