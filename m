Return-Path: <linux-rdma+bounces-20815-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHHHGYlgCWrhXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20815-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DDE55F7D0
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 08:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 814DE301C112
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 06:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EFD2D3A69;
	Sun, 17 May 2026 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="xwgXfcSk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B92BEC43
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999416; cv=none; b=IXPoa7tKLkwUo/9jWsUw7X8iwtB81QJpDFez9Yh9qHwjWI+gl2WmY2nj1ouxS4yk4qxbI/MeC7yF8kj3OaId9oXophfghTJNsKOeW+2D8r2axYaeJA6GK/D56EAS+Y7lNefJPCk5rcZfoJlQfOuWEmgx/9MkcdL26/6C3fKf4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999416; c=relaxed/simple;
	bh=gmWaXbUKYT4j4Ut5FMVCCQC4suELpzkUaOblTMYApGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mR99id6BJGZTR4vwxc0WowhEgaCX7ObVUa+3wcKfnDj8prX0bBAxvzHDhDzA9an5pPVj5osnUnFKia+hK1/ITHFiPmR7zirMCyCmzI0lX+9Lazd6RNhqrLqy6GNPGTPGG6mU1El9vYlaL0y2Tiw1Jpv0TeyGj2iR1T47o7y2YAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=xwgXfcSk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so5906655e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 16 May 2026 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778999414; x=1779604214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqRHQ+3TygZL+3HtC6xM2PaNGrq0n39+cUHNMroCpIM=;
        b=xwgXfcSkkY5eDgG0MzhgXu+Qf4SLYRZpCfGWMque0dSaKDvNKD4H7aS2g/9d+OLg8X
         5wBL1ikGvjfrgV3ASpjmHQRjU9hQIvtLjbq9ABW67u6Bp5V4Dcu/8uaYeUymADppHp3J
         +hDqdRNluvYnBIURslR4LVv7PfdskUSLcGk6pPbXYzCW4W3OypH4hsYBaxN4XSlvwBte
         tGe3v0y0qCi7sIimm+U3KpTNPOVJpTg/sw1u+PWiNSG1Mhebxm2m1iTZm8iAoiVljQA3
         wloPyfh9v2rQedc+2wmROLBXHeRzOUWIsB4etw7PT8BDAgBGP562b6iD1HICgluPtiIb
         ou7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999414; x=1779604214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqRHQ+3TygZL+3HtC6xM2PaNGrq0n39+cUHNMroCpIM=;
        b=qOW4yhuHq+V1bQ+kilXxIUwYdm1vHy+9ZxlqMOk0qKzREvGVWyeTmuGnONzQBWFYnw
         G4BqICnLkcDr6iUJ1+3kKG85R5ztbiPm7pHeyh5d9Z92op5Cae1voUfAtYlhfm/gu/4y
         nEg0qaJlK+4VxWKZHQSWtkbso2UNjy4fe8KT7S1qzrrLc+71WSnXD2m47NxMgJJAOTWJ
         6OD6/1Kct+Lzsb/mn+Z65k4Q0cvE3sYluTnuwQh27+nR8JMEZhbYfyy8iPD4c+6NWrvD
         gAcEt2XxfJqbQv1ZTNd4Vpd9/Z4PkITjUw/ZwOFIrU94j9/kjhrqfY73tPi7P5rQtKBV
         ixBw==
X-Gm-Message-State: AOJu0YyIdFDAIp6c3kVaR3y3G/+VtAajvZrMFeGCMXlxO6UbOwCEc+1e
	czIO5WEEwCEijJPEtveWf41JgDA+WW0aBd1zcmp4/BZNR4nlmkTBzlK0nTKyfVgSli9dTgwhUhW
	kBdTD1R1c0g6D
X-Gm-Gg: Acq92OHyhzkq0ipObrAwe7zkMtOgljG2sq+yAoIS/ZUPWuA1V2RE9EAiHSOMiRo/7dx
	gQ1g7sbLogPe7IJOgxLTDcrAsBb7VHvHXiC7ywV/EaR8B8gxsYMOe54mMZywCofxCZlD+8fxhJd
	TUOihRftbNiv9nnWIfj+Ec6n1uZ1xQ/3QdMuSMhU3mC/8iJHepp5Mu+h/OL+DhIt1gC3HhJswQC
	e6oIAIAx41fjhlk3kiThle2dOl6dFUa/Mkqn9jqkro51HNLF8sScmicyx5kqQNiT7l5V9weKZ/v
	uT2gJ2ZmsAiajuFHynod96fpCZhG3gdjZEI0T4YNVB5DVcTmYE2aYdBa68cdrwTMfAByZdomcwB
	OsAgcVWs0uiWVYUKcC0iMWiAFjmMBP305NLaGzZilQ8bGm5lIgvXuKoIAqKjZTGRl38e3bss/DC
	8YAIeFp1U9mbyJHxt2ynAtdbZ5Nnf6OE8GRb7LT+u3swefRnrjBiPbQ5ax
X-Received: by 2002:a05:600c:3e1b:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48fe60eccc3mr139130635e9.13.1778999413784;
        Sat, 16 May 2026 23:30:13 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec39ff1sm29660019f8f.10.2026.05.16.23.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:30:13 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v5 04/15] RDMA/umem: Route ib_umem_get_va() through ib_umem_get()
Date: Sun, 17 May 2026 08:29:55 +0200
Message-ID: <20260517063006.2200680-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517063006.2200680-1-jiri@resnulli.us>
References: <20260517063006.2200680-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6DDE55F7D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20815-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

ib_umem_get_va() is now redundant: ib_umem_get() with va_fallback=true
covers the same path. Make it a static inline wrapper instead of a
separately exported symbol.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 15 ---------------
 include/rdma/ib_umem.h         | 10 ++++++++--
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 3f5cb276c29a..5815bde36e53 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -394,21 +394,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 }
 EXPORT_SYMBOL(ib_umem_get);
 
-/**
- * ib_umem_get_va - Pin and DMA map userspace memory.
- *
- * @device: IB device to connect UMEM
- * @addr: userspace virtual address to start at
- * @size: length of region to pin
- * @access: IB_ACCESS_xxx flags for memory being pinned
- */
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access)
-{
-	return __ib_umem_get_va(device, addr, size, access);
-}
-EXPORT_SYMBOL(ib_umem_get_va);
-
 /**
  * ib_umem_release - release pinned memory
  * @umem: umem struct to release
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 65fdd0eed8b3..e152699666ac 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -96,8 +96,14 @@ struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
 			    ib_umem_buf_desc_filler_t legacy_filler,
 			    bool va_fallback, u64 addr,
 			    size_t addr_size, size_t min_size, int access);
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access);
+
+static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
+					     unsigned long addr, size_t size,
+					     int access)
+{
+	return ib_umem_get(device, NULL, 0, NULL, true, addr, size, size,
+			   access);
+}
 
 static inline struct ib_umem *
 ib_umem_get_attr(struct ib_device *device, struct ib_udata *udata,
-- 
2.54.0


