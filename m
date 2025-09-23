Return-Path: <linux-rdma+bounces-13596-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C7B963C6
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 16:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE07E172421
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459ED327A12;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1iY8Hp9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD25243371
	for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637313; cv=none; b=hM2GpuPs8Vrzmc0WWWPeFEucMAg48um4aqE8uaHCuFgHGMhaUzIWxK3mFB8VTZ4bv2OuAKdph+Qw32ImRXLkjBuHKbrKH0csimhEGHxmMZ/4PfvbiS+JESnTAXpcu5JDLw30MWz5jlNDI3uxzeUkGi/7viXGtkWkW0YgvXrR494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637313; c=relaxed/simple;
	bh=e0nsCyCfC2McRkZNrxie27zn3cIEpD7pvi/AAtxmrFM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TIsGzRnBuj2g81iuNiemrBp7ADHFstQga0wcXv1gyggnK+U/G844iXIVRmW06v/tJltKJs8Y03skyH+6r53Za36kFh0P2oHJncUkp2NWAy41mGvOFEqPDLs3igyT8TCfVp5llY1T3p2vyhBqMeko4eV8uzMyTjZ8Az++F8Oju5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1iY8Hp9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ea5b81c9c22so6254470276.2
        for <linux-rdma@vger.kernel.org>; Tue, 23 Sep 2025 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758637311; x=1759242111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/QA2HhGtX+wymkc8Enz5NcC1DmD4Tz0dJsyW7Bq9zaw=;
        b=k1iY8Hp90+P5qjs3wqeUGRugj0NavV1TV5b26MrurA5BDG72t9MCnhZZn6WCJWSdpN
         SPJhVVEnJrNo7a2f8haKYkXXryTYqL1eZwWe74e1ceOsvmGaih8O3oWBJIQNIcEQJH5G
         h6fBRF0EES/CZWBMZwwpGwJsq20AnH3XkhIwj0mU1igbhgyRHFRZTLd7+2CUnqs3Fsb3
         CnnbClyiwQHuesTeEZ5/0QPHaFLNo6U5MitLfkAnM1sZHtSMQWjII/Zeuw9rEMyHQsQ5
         fw/++I6tPSZwXeeIbpIvmY9DQ1Wny2ICMub2fwvaKMBUhjHJErLzEi0+jkTlYOAfj2Yq
         lQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637311; x=1759242111;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/QA2HhGtX+wymkc8Enz5NcC1DmD4Tz0dJsyW7Bq9zaw=;
        b=FRrfT9STYGZqd2D3Gd2LGplVOdgs7UMMLWPimwdJw+jlGbrbo7Tp07YUJiTa8TVZ2b
         ZqmFzRQDRlDnzoVAxzHwc2SYwLy09rnAZvX8/yApUlVTIU8nc2HIWJ95XD/9t5nAAAPw
         k1bCGN9azv1d0/+/JFaKmuG+ZshzCK3AunemMFAasFJ9y6/iekyRRiTunwlG/8j+CYBg
         N2lhsllgF6dWsYtUPM8Ufh6+v6uYvNVatbRUOAwBpQRsTzDopXdx247J9QkQoZXJkD94
         nDdOHewawE9J8y6ra3Ssqp560ukaxGi3SOoemcF6TW18ZoMfPT1/yo2fT9qyKQFUh6k/
         O9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV6QRFe/5NSNebhdOXStAesJGVPL+53InhkC7HgBsg6bdhswL2cusYuoMCrLsX+IQmUGSEUT5AzToMN@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ5TwMMVyvvVhlYYYmZO9orOHFCt2Oc0DO0F4B5ggqIWM/1HHh
	WIFeBoxklqx/jEoRyp6QBcBw1bCYjggnnKxfDrf5i5V49yb+VskQg7ccTqrHmPjKrZrFYxB4U/z
	AiAgoEf+ydQ==
X-Google-Smtp-Source: AGHT+IHz3/QeyN2db6lkL0EBunN2FFq5xE+BG5FsjArGwUlE1jWMPw8Ln3yqvhi791etAgM8Gkfitr07JhFt
X-Received: from ybey14.prod.google.com ([2002:a25:dc0e:0:b0:ea5:c9e0:940])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:230c:b0:e9b:b73c:be18
 with SMTP id 3f1490d57ef6-eb32ff9d4dcmr2443960276.41.1758637311216; Tue, 23
 Sep 2025 07:21:51 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:21:28 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923142128.943240-1-jmoroni@google.com>
Subject: [PATCH rdma-next] RDMA/irdma: Remove unused struct irdma_cq fields
From: Jacob Moroni <jmoroni@google.com>
To: mustafa.ismail@intel.com, tatyana.e.nikolova@intel.com
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

These fields were set but not used anywhere, so remove them.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 ---
 drivers/infiniband/hw/irdma/verbs.h | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index a47ccc86e..646939e3d 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2544,8 +2544,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 			goto cq_free_rsrc;
 		}
 
-		iwcq->iwpbl = iwpbl;
-		iwcq->cq_mem_size = 0;
 		cqmr = &iwpbl->cq_mr;
 
 		if (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
@@ -2560,7 +2558,6 @@ static int irdma_create_cq(struct ib_cq *ibcq,
 				err_code = -EPROTO;
 				goto cq_free_rsrc;
 			}
-			iwcq->iwpbl_shadow = iwpbl_shadow;
 			cqmr_shadow = &iwpbl_shadow->cq_mr;
 			info.shadow_area_pa = cqmr_shadow->cq_pbl.addr;
 			cqmr->split = true;
diff --git a/drivers/infiniband/hw/irdma/verbs.h b/drivers/infiniband/hw/irdma/verbs.h
index 49972b060..ed21c1b56 100644
--- a/drivers/infiniband/hw/irdma/verbs.h
+++ b/drivers/infiniband/hw/irdma/verbs.h
@@ -140,21 +140,15 @@ struct irdma_srq {
 struct irdma_cq {
 	struct ib_cq ibcq;
 	struct irdma_sc_cq sc_cq;
-	u16 cq_head;
-	u16 cq_size;
 	u16 cq_num;
 	bool user_mode;
 	atomic_t armed;
 	enum irdma_cmpl_notify last_notify;
-	u32 polled_cmpls;
-	u32 cq_mem_size;
 	struct irdma_dma_mem kmem;
 	struct irdma_dma_mem kmem_shadow;
 	struct completion free_cq;
 	refcount_t refcnt;
 	spinlock_t lock; /* for poll cq */
-	struct irdma_pbl *iwpbl;
-	struct irdma_pbl *iwpbl_shadow;
 	struct list_head resize_list;
 	struct irdma_cq_poll_info cur_cqe;
 	struct list_head cmpl_generated;
-- 
2.51.0.534.gc79095c0ca-goog


