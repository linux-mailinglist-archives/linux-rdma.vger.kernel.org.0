Return-Path: <linux-rdma+bounces-16442-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK7eNZ3JgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16442-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:10:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C1D75A8
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A85C303B4CA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281639C631;
	Tue,  3 Feb 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv+U42q6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56DA39A806
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113250; cv=none; b=b+ScbEtIXWpGTN34Qxz8FbkuKsK/qmWo2+SvCYxAMuIo3psnmIsooVl95heUm6ZlKY4MtG55yA1zciZtV58/CsK8pric/KBfdN0LrtBM/bbCFmRKNXW/Me83QnZKPV9jhUU3ITdEFMIOVwVWXpp4coesAEMDRa+iYMbfadLOYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113250; c=relaxed/simple;
	bh=+x9Z7SlUCwjiPO+c+IqwOnA+H7IrbXqTbDu1jbMaTKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm4ZwXnkfVHIH8J3HhWk6f1MjDrKKQsRcB8IRcHKVIu6i4q6WX+/YqsUWwyJWdAw9nJY77YtpXkT66bWz7b510d7rfXF+w1dK2eWE0+WOuxg2ihim7TOvyvNkWJnHIcIqJKaQX+uwpH5Q2s4lHVgE5spsbe/N9MtraF25aBhflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fv+U42q6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c61343f82d7so2159171a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 02:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113248; x=1770718048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iS/t+s7KGE5CS56UwXa5evOotPIXtxRZn2/qSwTLaaQ=;
        b=fv+U42q6gllNFFu7vocrPSyR9abYQkCvu7FN0ICmg40VJipVArvuLkZ9na3uQIQ5LE
         W21X7o2M9Kaipp9M9Wt3X2I0B+W7mc+ShQ7jXL09N2pmSfYbH1LoVG1Oe+yCwSHrQ/qa
         +nUAGmR/EMk9uz7iYLWXHtegH4g3ICjNAg7PkTFcPHXpesjzpoSsxFMWlS2VDTMZA48r
         sbCemtJbyJNAi0nWV8F2QlgUpE8/TGwd7PH8P8N8+Lr58z/QQ07Js5oQXC74SIDoXcZp
         bHNgABssMV6Y+y0/klQIpCXSvPxkuEdPtCTgufxa4Tp6tDjfBB4VIf60ZrOIKkDnP0lg
         ATJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113248; x=1770718048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS/t+s7KGE5CS56UwXa5evOotPIXtxRZn2/qSwTLaaQ=;
        b=PfWo+5Fu7zCB3Wj/yY25suFf8zUXACk/vkHYpH/1lxPOqk23UZ2f6/RyYFxg8w3pNV
         EmQq+cAH+Z8N2FMJXFz/1KQkA9y2OqyccM1hFaYfC8a5LVQkK6Oae/FEPPY7ybBbij5A
         fkLhEO1XhIY20B9wg3KCil9P2LDn++B0o3RB78YxxCkF7S4e8lqcka/C/l/NmaU92kl6
         raRlM8/uAiJVNj5q5INe5kcAptKKdrI6F+UGFjFT0W/e31MWgJ2ZbOKwCTA8nCn4U/Pr
         ZZ4iIgsv/vKQXQwFsQ/Xd3xrqtwA38wHYNT2PXTp9+6vWBUt7lFsPlTgteVONRzvhism
         CRtw==
X-Forwarded-Encrypted: i=1; AJvYcCXKy1dzMeCklLR4qjsJF1nGF5GvjKolvoKeWkNpWrf8zSjSphXCyeEpdOZH9/0IlgUbPcUz/pMGrstR@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6kwcrtRSvxXPa+P9HMZmoAHwrb1xboKkVqZ80R1Dc9r/Sc2u
	hQ9E8Fprm3BJkojOsR5IIrQtMgHY3p8Bfe+tXh1O06XSCAYR1Y7DVMbl
X-Gm-Gg: AZuq6aIyqiVxC5URjNq8askB8tJzsteHJTzFovC4RNltBn5Ai9Tgxgw4pWyKiKhFDNC
	89XkW4q96kNqfno02VWbWkewz0sPYZ6cnGRh/qYISR6tM78ED4F/nZ1WoomffxiBkp9h0u8z4Ds
	/McgFFRabsWTT9YHTu21VoW/QbeLyGX6+f8hdhQ+aVlRCAXY41EdJu+Z+1IuRGiuAWvcQNDZzyf
	6biN3qv1fZj94ucZk//FaiAuqzKy3gTmKBM5SByr3yRrKcg9f2P3r1BY3AFuACSoyK530hERxws
	pKEyt2qdaPmD6CDUtQn1P7USs2rhpLduziREXe2NJZDseUlTLO4yf7+0gz2q72S1XeMxUO/8mF0
	Hy5mG8S6d/uVAdPfw9jkz60VaAz1Yqxi3GN8mL3x2PGeowc+3F4O/dKMR0B32Av0zbVF8rEsg3v
	6yZABfA8a5UWifX1P7q1d4FV+wZWCYoQi6
X-Received: by 2002:a17:903:184:b0:2a9:9c2:e900 with SMTP id d9443c01a7336-2a909c2f432mr82342295ad.31.1770113248184;
        Tue, 03 Feb 2026 02:07:28 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8ec56da8esm96978225ad.13.2026.02.03.02.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:07:27 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: jgg@ziepe.ca
Cc: ioerts@kookmin.ac.kr,
	joonkyoj@yonsei.ac.kr,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	yjshin0438@gmail.com
Subject: [PATCH v2] RDMA/umad: Reject negative data_len in ib_umad_write
Date: Tue,  3 Feb 2026 19:06:21 +0900
Message-ID: <20260203100628.1215408-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16442-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kookmin.ac.kr,yonsei.ac.kr,kernel.org,vger.kernel.org,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kookmin.ac.kr:mid,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: 3D4C1D75A8
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
v2:
- make data_len size_t to avoid truncation
- use check_sub_overflow() for count - hdr_size - hdr_len
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

