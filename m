Return-Path: <linux-rdma+bounces-16407-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODc/ONWZgWl/HAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16407-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 07:46:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0C9D5701
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 07:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA381300A32F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 06:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2438E5C2;
	Tue,  3 Feb 2026 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbNjFLMs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0342F49EC
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 06:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770101199; cv=none; b=OG2GXGhTSGAykb6ToSsOfEbx2zluF2k1Jvq6jiO1DJdVsme50xawiJ3xjG7Mk3XotLjWJHmldMTjIHDuwomlyjQ2an2LNqJY+q9CUj4jsV2OS1MdVY5xniFBrohxpZC7eXGEMge/6x9Wwjtc3Jfur8r1AU/u2+5/EzspJSgEJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770101199; c=relaxed/simple;
	bh=Bvqj6T9cw5K6MD41d+zcTJNbllTcUHxmOH/fWeXMrDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uN2i56y14CwcgXqh7y9PLdcQrKFILd6h4dojNaVCn5xknBOCPAciiJtwJDfOh0AkP3SqzYIuWiW3LC2o6R+2j2ch06ToXLAGELhiFynWGK3/V9YTZJS+kaUCuO90td/XKaKwlXD06THMl+f9raCsnmhGbOUiSXpBXT/SKncjC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbNjFLMs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-823f9f81da5so784842b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 22:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770101194; x=1770705994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYR2Ob3u1X+p33lzaxWPtjVYuyz2/Pq7DsSEoXqJ0Fo=;
        b=fbNjFLMsqpIPU5Jao27ASxRLBDjCKB6A2ibuHPB5XJqzYNSnZOM9tioLQBXCEXQ1EK
         IguHyWaJTlJpBkuupw6a2k165jfu8+7bjSknHAmbWWnI/Lf0XIcmpba1pGqY0pT+jI6c
         NUf2sg47Tz289PTXU9wYSBrdJ6ElAyoFZk02zVQQ2wfGE6nOnbFYH3vnt3lU/p38DpKD
         +m+zVKwuiHU2z0ShVtrwP15JbUsi04m5/rb2sKi0Y+IRcdA5Wk6tE8l2C+o8DKU8izAM
         JySC5wAj1BGtzur+dkFNQrGBtmnsoKG6MPvISy8En0EcHVUix6yjOnnE17tvX8C0rPGl
         cLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770101194; x=1770705994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYR2Ob3u1X+p33lzaxWPtjVYuyz2/Pq7DsSEoXqJ0Fo=;
        b=bwkT/uNwUe1NpZhgbAW1QuTSN7DSnhLAaqdbHWmkNrKbU6v+pJ4W2y8susxa0zQ4X6
         FAl4uwxmtcf5ZLqtOHes34adpGExRZCrjD6A0i+76xGnjlzAzYRc6DxHj4jvPq9Gpxe5
         jICPsQ929cln2whEZBhj2J9Wp/pSZmQCAEkNC5pARmusQEa5s5v2xvCaxSYQHsKNy0TE
         GmKViBa1n7aRzXjyvDVDl6IhlALIv7IUPA3a9n1jqjWARN+51wUfzJ5KR5eAQyzDIYLE
         ctiNWGIeiGQDc/+fXBTRWmC4Z7+Wqy6VZabxSBsTnJlgqQ9JQoZnOn/55QAGAz81toKW
         omXg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Mix9wTj7IR4MSEeiURvo7Gt7qD/Vt7UHpKVvgzP8U0FGQTWifhzrHgc5lcgwVTkgGk90JLRj0Tyo@vger.kernel.org
X-Gm-Message-State: AOJu0YxMmvU8wQY9SNjWPLXoDJi5RXpBxW+uyuYuQ7O/h0XkXGormZk9
	m0qDJ/CCVAoHXLF2TdNX/85AjPZUBF4MRSxbxsgEmPCf725rleNHLSZc
X-Gm-Gg: AZuq6aIhn8cFK+SqbFmnnHuyNQ208fF7zLF/wh+KoJLz8hXF05qgN0txE3MACvMzF9v
	2O8cnqYAAF4ci7WhowsicCw1VdboOSjuonMc/PNmTJS3xpFcCo9GXPg9TtCD3emXeWQlV0oHrWQ
	WqW4i2QM34m2/AMLDHhCqQ1O/zKdGu88NMjWv0Klp8oWvU8kRGQRcQNR8e2GPKmp8PCE0yL5w6r
	n/PLceLdf8c81vediLg46I1TY1Gc4ajIuIfK4cb73dn/0ajb/BP7OQGi/PweW4Qkde8CbQgx80t
	EnFBYvA+Exr4wNgS2bmW/0Xd8h8vDO2yozJnKl5ivGDlzFKsDkW8Ocye7CKdmTASKAV6EMk2Wjr
	ESEl1suAw7CoUHE+65nNfs/nZgbL+aoR+HZ+BbJElwNw5cDngOd+S4rZNoILxPLuYcNzsG9CNDf
	7XW0mLK6s+2RpwF36oH1WjGRVu4MpUrUjr
X-Received: by 2002:a05:6a20:5493:b0:371:5a31:e486 with SMTP id adf61e73a8af0-392e0011f2bmr14237960637.6.1770101194522;
        Mon, 02 Feb 2026 22:46:34 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35477615e65sm1454141a91.3.2026.02.02.22.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 22:46:34 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: jgg@ziepe.ca
Cc: ioerts@kookmin.ac.kr,
	joonkyoj@yonsei.ac.kr,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	yjshin0438@gmail.com
Subject: [PATCH] RDMA/umad: Reject negative data_len in ib_umad_write
Date: Tue,  3 Feb 2026 15:46:08 +0900
Message-ID: <20260203064620.686140-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202183449.GL2328995@ziepe.ca>
References: <20260202183449.GL2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16407-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kookmin.ac.kr,yonsei.ac.kr,kernel.org,vger.kernel.org,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kookmin.ac.kr:mid,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: 8B0C9D5701
X-Rspamd-Action: no action

ib_umad_write computes data_len from user-controlled count and the
MAD header sizes. With a mismatched user MAD header size and RMPP
header length, data_len can become negative and reach ib_create_send_mad().
This can make the padding calculation exceed the segment size and trigger
an out-of-bounds memset in alloc_send_rmpp_list().

Add an explicit check to reject negative data_len before creating the
send buffer.

KASAN splat:
[  211.363464] BUG: KASAN: slab-out-of-bounds in ib_create_send_mad+0xa01/0x11b0
[  211.364077] Write of size 220 at addr ffff88800c3fa1f8 by task spray_thread/102
[  211.365867] ib_create_send_mad+0xa01/0x11b0
[  211.365887] ib_umad_write+0x853/0x1c80

Fixes: 2be8e3ee8efd ("IB/umad: Add P_Key index support")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
---
 drivers/infiniband/core/user_mad.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index fd67fc9fe85a..2f7e3c4483fc 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -514,7 +514,8 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	struct rdma_ah_attr ah_attr;
 	struct ib_ah *ah;
 	__be64 *tid;
-	int ret, data_len, hdr_len, copy_offset, rmpp_active;
+	int ret, hdr_len, copy_offset, rmpp_active;
+	size_t data_len;
 	u8 base_version;
 
 	if (count < hdr_size(file) + IB_MGMT_RMPP_HDR)
@@ -588,7 +589,10 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	}
 
 	base_version = ((struct ib_mad_hdr *)&packet->mad.data)->base_version;
-	data_len = count - hdr_size(file) - hdr_len;
+	if (check_sub_overflow(count, hdr_size(file) + hdr_len, &data_len)) {
+		ret = -EINVAL;
+		goto err_ah;
+	}
 	packet->msg = ib_create_send_mad(agent,
 					 be32_to_cpu(packet->mad.hdr.qpn),
 					 packet->mad.hdr.pkey_index, rmpp_active,
-- 
2.43.0


