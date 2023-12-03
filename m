Return-Path: <linux-rdma+bounces-193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95058026FF
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A9B20945
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD381804E;
	Sun,  3 Dec 2023 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fla16aY/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D19B1FEF;
	Sun,  3 Dec 2023 11:33:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da819902678so1798521276.1;
        Sun, 03 Dec 2023 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632033; x=1702236833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMYRsf2KUQS5uwQ6urvBpybENsSrVhN/8XcMm7CzDDE=;
        b=fla16aY/YuRlrnmExwMcprcZzfGgUqAsre8kjf55bttl3EH4eCr70ZlYvTUnb9LzYr
         ThQd/RIz/EbmFydVpaW69jCRfYR4wzRalg4MSF4Alkm7I4xlHD7cF5OIz4tzAutVss0N
         hwh5/QlzddAGwRBlYTq9s2ljQDq4ZrCAw0Md0VY8/935KIipZq8ZdDduVwq66qAxessq
         MI+C7j17an+6p75bbbcw+MAEkvg0rfu+K319CRJ9pAsACCvdThUwP3qn5YNWY0nGgFtn
         YELcGzJo6MWrUN/7EAA/mOCJLVdQEWcgq+9TJc6Bg1cbQ0FsLSJBNWyvFFGbyjPMaCR7
         lKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632033; x=1702236833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMYRsf2KUQS5uwQ6urvBpybENsSrVhN/8XcMm7CzDDE=;
        b=hNs+yHmIy70jLrl8dgnzsIyB4ywklhgMRQGtY6FByWS7l3M8MfjPnT3XZpolYpfBHx
         2JNNFUwcp/QtUOoqPHbHhXPwZgYWIm7rH2aWkYmUrjaDMeQpViaGTIYH0ZTKKRrOmNph
         lXFnUKubcySBWRpR+0oI9yDDkk92U2bbVvXSQ19ealC4cnciWbdTkiCqbWoVbR7WGg9H
         024BSVZHS4q3cP7XwOsr/UTTxqnybvzaq3radYcLCgYh3URD8FhoNCM+ni2VgQsw4PDU
         tmSJraT77yzrp/xHRkhruCmjdNSmhvQRNCOHgNl7dv/PpaHKccb8VdxCIKJyzgxuMqKa
         lHuw==
X-Gm-Message-State: AOJu0YwjghAjfN3DTmHXBznB1DvwArF/KutgsMQLnwvfDvhh1wQMReVn
	S44nZDiZvAq2aJmd4fXdUkkGZfi+lBi2Gw==
X-Google-Smtp-Source: AGHT+IGduPg2sefAjk91T8uEcsf30VtqsMKGSFuvvW7gch00T0bY9HWrkg6qeFiGnN+s5O99T9BAWw==
X-Received: by 2002:a25:94d:0:b0:d80:68d1:b826 with SMTP id u13-20020a25094d000000b00d8068d1b826mr1828079ybm.6.1701632032837;
        Sun, 03 Dec 2023 11:33:52 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id r11-20020a25844b000000b00d9a43500f1dsm1751830ybm.28.2023.12.03.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:52 -0800 (PST)
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
Subject: [PATCH v2 25/35] RDMA/rtrs: fix opencoded find_and_set_bit_lock() in __rtrs_get_permit()
Date: Sun,  3 Dec 2023 11:32:57 -0800
Message-Id: <20231203193307.542794-24-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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
index 07261523c554..2f3b0ad42e8a 100644
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


