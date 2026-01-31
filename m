Return-Path: <linux-rdma+bounces-16295-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAdxKE0NfmlbVAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16295-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 15:10:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A83CC22DE
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 15:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BFA300B04D
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC956354ACF;
	Sat, 31 Jan 2026 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIlY6gES"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30380155757
	for <linux-rdma@vger.kernel.org>; Sat, 31 Jan 2026 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769868616; cv=none; b=SGWpSAIvEvul1BW88fUrh8MitlE5BurBS4XyJEkBcDEg63d7EXce9e6VYsMpWhpBEdfsrfsYcJRUkgTxfFeCb3SIqYm+oE1pm+r5iz685G9WpHOBj2slssaauVxdux0LBzAzigS9Ay55Y418PGh/S01REREZVc+shrNtN7jjGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769868616; c=relaxed/simple;
	bh=S8CR8nkDMDZcvLUSaAi6g9r6XrWrC9Tyn6hgxq5KP3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+P0/onXulXZdaBniZ8deF34GPACIXEs9+HK7hZQ9Ukoao7KkuN0A9hCkS4EivXm8HnXMrGX5qJ88CIrubbYEOVJQ485R8xto/EUl8q1Bnc3twa+nMfzlTzwEvj+nZ6PimFsBFgVH17KhoCuozjfrsZNy7nyBDfGtfoGTpfEOyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIlY6gES; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-352e3d18fa7so1613512a91.1
        for <linux-rdma@vger.kernel.org>; Sat, 31 Jan 2026 06:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769868613; x=1770473413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDjTkOG6bLb1ajjqYJK0tw/LTkdT0T6orQVEtr07L58=;
        b=OIlY6gESdU8hJno73XaIKeH1eWfFL35UMtgf6xiurVsNdn1SEzRI1reFQgOQYFAgP9
         XDdF8aExsOGTtS/IMuqnfw3eLfhiThGygeOePukq0FH5W08d8uV3dZEteN8Afl9pEf7m
         bH1pRSRCzGQmdRPZRkgrfulWS2mwD9RB/4LJDmSTFS9HOOYT57dRd6c4kXlbrj/NTcXu
         8cYNafJiiFVTLbXnKBn4wayIsbfkffGSYFWUwYAevAWDjFAdJEi0MsMx1CnycCyxrEyV
         0rXBu7UjEWfUB5ombTaJ8l1MdSDwIQBtBNaqgVn6vYzVbFc/nDBrtP5d70tDmKDmJR/x
         vTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769868613; x=1770473413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDjTkOG6bLb1ajjqYJK0tw/LTkdT0T6orQVEtr07L58=;
        b=t3jDS9dF3bc9uo7Yt8Xt8VCCJCPdngecjitmB9kgLwH6d17tQE+H9xFjDXrhLXP4ZD
         bdGGGdLJ6gS2u5wpg2zmBZl1A7WWQL8u4NfCK/jDzQUEcy2IzUivXx6W+Fgk52SB4qW3
         OivEUluLjhbGPceP4NWq1RiAhFANO8zdzeP1q7VAqq/7CMDuxwsoakzb4bgK3Azo+Piw
         +dpN4gLm5BFPCwJEkvLni8DsKJuVBzL+3LFjIla0fpkLwS8cwyNNqeLlSTAD3OEHrfeo
         G5eCWSuH8ASXoVSspkQ3F9olV9BE/Wy7huBgr8WlCFT0VKzZQOxL3GQAtONefg5h5MRH
         ZUcg==
X-Forwarded-Encrypted: i=1; AJvYcCXRX5NPPLiiqMtO5+/xEclWMkSwLiGfuignhHNH70mKiGAtaMHliZTfGYxLVhUWFGIR5aODYTTIR6m7@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXYpBKVPxlEQOUq7gZoXsymL0gxUzxm9W3sFiU0432DoobDWt
	8opQeQ4+iqMGX3N32slyB8VYNIy8mOOYw4Eq19Nkx+uZao2c3zKjVkb6
X-Gm-Gg: AZuq6aKzXmwIG8AF9jMhVbp3VyLtj/ZeM7TzgIaeItlReGrHAxq7/SbJ1RN+7vnJ2hf
	TEl4FeGRzxddy8C5fw8cT016Gk3s8neEyLqsDBLPmbbLzTb+4FxNfEKZBGY8PwidW5iU6ZkxvId
	wrj1wxOuvGfVs1fusVm0XO8IrYtFlnF0/qUcFaCFcF+Qkn1KmZ+T9ceps3bNS67NZEyF0wg3bZA
	CjwlSW08itAGg+PoiTHuX3Om4wJjIAfoXRnkB4W2nnrd9C6dYbKU3TWq1yrN2CD0Lvalje4InLM
	79hB4z1lyFrRUiPYSFKepPwxRH/tkVs6mvQ+cuA5nViTxS1Mn/ZDAQPLSW1dKLFQF6c47ouGMJJ
	Ml9K8y6Nv7x5AqcHmh+tjgs/l/+XDTaGgD5mLk+NnTrUde3rKf52EPAX1wwO8OMozpvEEZOrP9f
	5ElLnCOBNYYxZmcJ5LItpci+ImIt8NxzwZ
X-Received: by 2002:a17:90b:5907:b0:33b:ba50:fccc with SMTP id 98e67ed59e1d1-3543b3ac8d8mr5931630a91.18.1769868613255;
        Sat, 31 Jan 2026 06:10:13 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3543d3039d3sm3070841a91.1.2026.01.31.06.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 06:10:12 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: yjshin0438@gmail.com
Cc: ioerts@kookmin.ac.kr,
	jgg@ziepe.ca,
	joonkyoj@yonsei.ac.kr,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/umad: Reject negative data_len in ib_umad_write
Date: Sat, 31 Jan 2026 23:09:14 +0900
Message-ID: <20260131140954.89165-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMX6_QHrodOD1KD6qtK2A=tHOocrpSWJh7VTSYR+fMiHRgsktQ@mail.gmail.com>
References: <CAMX6_QHrodOD1KD6qtK2A=tHOocrpSWJh7VTSYR+fMiHRgsktQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16295-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A83CC22DE
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
 drivers/infiniband/core/user_mad.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index fd67fc9fe85a..db1643aab029 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -588,7 +588,15 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
 	}
 
 	base_version = ((struct ib_mad_hdr *)&packet->mad.data)->base_version;
+	if (count < hdr_size(file) + hdr_len) {
+		ret = -EINVAL;
+		goto err_ah;
+	}
 	data_len = count - hdr_size(file) - hdr_len;
+	if (data_len < 0) {
+		ret = -EINVAL;
+		goto err_ah;
+	}
 	packet->msg = ib_create_send_mad(agent,
 					 be32_to_cpu(packet->mad.hdr.qpn),
 					 packet->mad.hdr.pkey_index, rmpp_active,
-- 
2.43.0


