Return-Path: <linux-rdma+bounces-19904-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMPVBDVT+GnSswIAu9opvQ
	(envelope-from <linux-rdma+bounces-19904-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 10:05:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 661994B9DBD
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 558AC3010485
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51924315D58;
	Mon,  4 May 2026 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Lyx1Si"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1458313E15
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881906; cv=none; b=Ikce86ax/yjlFNqA7dT36AynEK93uU4eB1Kwp31+e+E1yBJxrZnr/AeNfOPmd1zlCtmu5N0LvRPIs97t3MKsWdwISqbo5yz5KNgRb9zTTVTYrDx4WrU29/yyhItkm7MPaEAgqv3KIJUHyjX5WL4rjm7uxuFYE/Sw0gpO9VCKir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881906; c=relaxed/simple;
	bh=TzBZ5d6t1avGrBuVqX8j20XzTnEYIlJHq0BqR6MK4pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEGHCt0m6nwqaMVhwGOFtrZXqmeweJWJvQ8NkQFBj37XTgrRe6v/UPshDXxiauIAP1UzEG2FQhj1BdOAU99dTQwvLJRfAWhg1BoJq9PIqVWOdUKS+0IL6cQ1TdAkFqmdVzNje1Ni4YfVKTtdwtCs3UnQqzKxIdeO/RUlBAPdZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2Lyx1Si; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4911283eec.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777881904; x=1778486704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XshvABmAm/1LOdjBec6SaTsaXNuMFtJtTQSgJo3OP2A=;
        b=h2Lyx1Si1enFDnEWAkgiv3e9AXqgOlf4NWoW1COPaQeXQWccm/jv925EaGS4ZAPYl1
         zKQLZRjF4qZmQd0ZLa7B+KciLztcpj4STF23sY2xguaHyLDxHnwDvkERk4HxtXfx+pxN
         VWFJF5/4gqcA0Qbztrl8yP8PESnQ24x3prVKwNq1wbjsVi+59jb7DKzSVCE5DbNaZ7Hx
         UIyFhaPr5dzSQS5rTUrK6m4oiDGa/pt69M2fvwgzuMdDEQNSvB5RDPA6l9rUMJwZAg6W
         VFqV3+xn2HX7RmFQzPyZO8rKXSASVNqsWHfjViJCcd0z8B9TEGqZHrxqNjolFaOP0+Dl
         z78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881904; x=1778486704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XshvABmAm/1LOdjBec6SaTsaXNuMFtJtTQSgJo3OP2A=;
        b=qMb/Ndr+s+EL2S429aPurKtqOYEkX14okDwRoirPmI1/8+ngvJbHRAFMnVxLnYSu0a
         +4CCjkvhFcDWsF8U95T7LIa4glOc2asDZuWCbadMUzySXkxeupPURnTjckZYj9CvJggu
         3PQXkTCsj+6KP4u6UJRhkiNr+iSpUna0PTZseAJBqUSnEpj6HRGvzT4vjkImNXtJHV8x
         nAt0BoA0stiGNO9qWsz4ZseEgYGXQ+owiergnVhNxb4JtkchVacoPa5BSlA+1OGIEiQN
         ZQiASElBzfKGPxMJnkdBWNuRckU80via/rST/LdwllUnXEZqEmQra7F3X5j/kAYqezim
         iJXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9lJEAgHJnAxSHWPB6Zcx9oT0WiAXS5yBVJ9qt4YHUsAg3vI/rxSuciLfnoqk5F60O00nxk95gHMV1c@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0635hYLFoAGSPLT92fHm0W58Hf0w9j1depJygAHLtWTO3RAPi
	z0zfTFF+K8FSW/R/UTZ2DK7uz++GTUguYvBZRPTi4sjNCXaWuXWeesDoDDEzcsw=
X-Gm-Gg: AeBDietsKj7jMeBtHm8BWR96I575roZLJ7wljVW6CBxSo3uzBAVtd6i4psqsnAia0dy
	ke+Q4ENPra/S55oGwVuQVVHoDtRo2pfJvT4kd9vjC22omdcSEGYJex1EsmjLt6avZqa4uGHI3MR
	CuFj1IqZ+PyGU3aRJpSzZt+E57sBZjKAiA3aWFzFaqSrj1d1bWgbPNACd1DBWMXgOWa/wS7BH9o
	oSTOP6imwfMR/WaT2FUMSdCzxhC5Phkp8Ajt0k7nlgTfh8G3jsn3cKQvCsOgc0lU+iR5Q+9aHyR
	jpaQHD8xAm+TL7+BIymrv2+89B9vPdvSbZ80lsX92skm3U19tcae6rbBcnLq9mCYSzWg9lqegbE
	/LF0cH5A7/jDoG+XGVWNc+a0ntJ9sHe1KM78bdKpXhafPL+u/zqggNhUSFdeUNQY23VvoqacGzW
	/ZvnDrfEa72mxXp/iYUf6EyrmnzhbD8wwYxuoOhkvNVmeoqpwUhxN8bONRAujpnzZZPxjEKUEB
X-Received: by 2002:a05:7301:e25:b0:2ed:e14:42e5 with SMTP id 5a478bee46e88-2efba4a8667mr3520504eec.30.1777881903908;
        Mon, 04 May 2026 01:05:03 -0700 (PDT)
Received: from A02816.. (c-73-71-102-182.hsd1.ca.comcast.net. [73.71.102.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d78391sm20198312eec.7.2026.05.04.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:05:03 -0700 (PDT)
From: Sara Venkatesh <sarajvenkatesh@gmail.com>
To: bvanassche@acm.org,
	jgg@ziepe.ca
Cc: leon@kernel.org,
	dledford@redhat.com,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	carlos.bilbao@kernel.org,
	Sara Venkatesh <sarajvenkatesh@gmail.com>
Subject: [PATCH] RDMA/srpt: fix integer overflow in immediate data length check
Date: Mon,  4 May 2026 01:00:36 -0700
Message-ID: <20260504080036.3482415-1-sarajvenkatesh@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 661994B9DBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19904-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sarajvenkatesh@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

imm_buf->len is a user-controlled uint32_t received from the network.
Adding it to imm_data_offset without overflow checking allows a
malicious initiator to send len=0xFFFFFFFF, causing req_size to wrap
around to a small value, bypassing the bounds check, and subsequently
passing a ~4GB length to sg_init_one().

Use check_add_overflow() to detect wrapping before the comparison.

Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
Reported-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
Signed-off-by: Sara Venkatesh <sarajvenkatesh@gmail.com>
Reviewed-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 9aec5d80117f..f66cfd70c263 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1129,9 +1129,10 @@ static int srpt_get_desc_tbl(struct srpt_recv_ioctx *recv_ioctx,
 		struct srp_imm_buf *imm_buf = srpt_get_desc_buf(srp_cmd);
 		void *data = (void *)srp_cmd + imm_data_offset;
 		uint32_t len = be32_to_cpu(imm_buf->len);
-		uint32_t req_size = imm_data_offset + len;
+		uint32_t req_size;
 
-		if (req_size > srp_max_req_size) {
+		if (check_add_overflow((uint32_t)imm_data_offset, len, &req_size) ||
+		    req_size > srp_max_req_size) {
 			pr_err("Immediate data (length %d + %d) exceeds request size %d\n",
 			       imm_data_offset, len, srp_max_req_size);
 			return -EINVAL;
-- 
2.43.0


