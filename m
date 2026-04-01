Return-Path: <linux-rdma+bounces-18870-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLIsH8t0zGn1SwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18870-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 03:28:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 390073737C4
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9953C3028C86
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 01:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8CE29AB05;
	Wed,  1 Apr 2026 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTINmaOS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67409291864
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006900; cv=none; b=VRzrTS8atzoUGZaqGdSvGRNtrtqSZwpMocLSHNE6V/bzLj5TwTnP+3M6OnaL4i6EXf9CTiZxzn3NeQ6xPCwx5vd6koyJoAfaQVWyegx15Zc2BIZd3MtuyPtgJUe0ufsuTeJzHl6cm+GH1CVO/eIR1PCMcpfXpzK8eQDhbTw7QQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006900; c=relaxed/simple;
	bh=XGStqx4/4JKwb98DYxFMjT+tYwnri1aOSY8zy0q6eWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A2UpiGgATR0Gdo1lO00nR+OTGKog6IpEoNTYxogXp6vyFnsueHd5LP/LwMKlPgSv/GkoxjU8mutsa7wfQNe4VYQn7AAOkaaeqEM3wE0uFp/HFzWJt25UMf/ZD/J8Q7SbsD6YrmL0hPSNbgLgFxWnS6/Igwmws+6xoBB+5tljkA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTINmaOS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82a655cfab5so5861371b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775006899; x=1775611699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5dSt9xvwpq2GzN2R6IXQ5mT9aFlyd2hukUPd+j41X0=;
        b=UTINmaOSwVDRzUUHUsJ9IS79PE/sHQXVBM/6qlbTcM0uwkji1ndq3ikHO7NSyC8IWR
         ks0/j5SMQTG3D/QXSjJhMbLiohz6GZ9VIoETOy3Be6pc6fI0dXrsdqsbFSukFAJuIF/Z
         Vof6xX39mlPmwCY0EGr3mQjZKkLmHb0PswQxO2ZPp1BEuHqefM/NYQlUemqixVCQhB93
         Rb8BxhFTZsbV//tsvkzOx0G8KqcPKrUSVFJ8COWJ3B6M0uLxextDGx3jvWCpZAbCWbK1
         aEpyDDQBPOXwlJzXbeBInBXdk9Qz8yMnqEjBRWn/OHsx25F8KOBfTmFxUDPNVMlXxXUz
         Uj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006899; x=1775611699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5dSt9xvwpq2GzN2R6IXQ5mT9aFlyd2hukUPd+j41X0=;
        b=bW/2eL0984dP2+n5y1IFW5f19Vj+6M9PY/QMMkkpD+IUz1Ty1AeSMmxE+0TwBHDqAN
         nTa/PkoRnAXzUNBSxn7GlpR4Lg0jMAd/KBLVw6gTPd7jK1nG2EtZ8N4XMNm+HC/s7eNK
         g8kHf7vRiCVQud82EyKCieNEPbhVbkiCdtfHfYdD5iU2SDptuxKrk0ztO2lb8kDcMucu
         1q9/v+YyQuv0kUmjLh9dSIfZptVmE0KoPH963XvfN2mHKXFnygQ+qGP8qxHU4/SOtVXo
         dd5rtjCAoD1KPXDLqPsN1gocFjfD7oyB0MKU7yqZdjF5qa70Z766brrsvqA5H7ciMnQh
         cvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2X0Ir0gGKjYv1/BsK6jqgYA7BYGo1ADReaO9EXhFjY1Qh2fnvVlJsPW3sf1qHVL8lXDl8CsrhcVTZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcnKPO09G3b3Km2OUq/p4WfvYOtCccm6PmJUA9mJn5iw/UB/hM
	X4bs4po02IyA4FOCu/838LwJLjNZ1IqAtj0TOQ/iaJ3k/4fgvViYJhq4im3YcbAp
X-Gm-Gg: ATEYQzxdzmzyIWnhQ0Q6xqml6BgLlxOUrjG4X0yLsN8dJfTrJgOATym13CJPyha054F
	PQmuDIV3oZfG+VFp9UC0ixoWU0u5Svs5nIIImwWyppuy8A4piWSQzrblXWOENnFVzS5e7tk9Jm/
	q6QuRx91nXzqF6v8KcDgPSgMgUNQ+9lb5p4qGbfJdoxl24xQ5DQ9TlEuv1J7F9GSqhPiiSc0qXN
	OZkyzyS49gcQGZfSNMlTwdTsQ1aXwilrYT7x8TpwiTuA/AxDmO7JbTTQUYqE/cxPAGgEorWADNi
	EbtdubJhgxJJQpT219jCJ0ljxzX1NKiLyS9VKE6XueJoP0JbpB3VslE9iuMZX3KB7SZU5hqjTR/
	yN6PSvDK/99oe6HU+zDbg49sIKQMOxZrVJQawH/OuoTL1NkuHrEttGQs9IGajjAIOXBBKMZpHe/
	V4TZAFgw+TVsXhkMN7teqR0cDaja9SCi2++tpMNzdvP+dkC/p7eEgudSVHSxErB/VRH5RzRcnu9
	js1xg==
X-Received: by 2002:a05:6a00:3d98:b0:82c:ec1b:9e0f with SMTP id d2e1a72fcca58-82cec1ba325mr840862b3a.3.1775006898667;
        Tue, 31 Mar 2026 18:28:18 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:df22:56ae:c631:2dc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc72asm11685664b3a.48.2026.03.31.18.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:28:18 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: kees@kernel.org,
	eaujames@ddn.com,
	parav@nvidia.com,
	maorg@nvidia.com,
	rosenp@gmail.com,
	jiri@resnulli.us,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/cache: fix invalid-free of flex-array data_vec in release_gid_table
Date: Wed,  1 Apr 2026 06:58:10 +0530
Message-ID: <20260401012810.11876-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,ddn.com,nvidia.com,gmail.com,resnulli.us,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-18870-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,4334f9a250019c1b79b4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 390073737C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 74e2711bb2af ("RDMA/core: Use kzalloc_flex for GID table")
converted alloc_gid_table() to use kzalloc_flex(), which allocates
the ib_gid_table struct and its trailing data_vec flex array member
in a single contiguous slab block.

However, release_gid_table() was not updated accordingly and still
calls kfree(table->data_vec), passing a pointer that points 216 bytes
into the middle of the slab object rather than its head. This is an
invalid free which KASAN catches as:

  BUG: KASAN: invalid-free in release_gid_table+0x384/0x470

Since data_vec is now a flex array member of ib_gid_table, it is
freed implicitly when kfree(table) is called. Remove the redundant
and invalid kfree(table->data_vec).

Fixes: 74e2711bb2af ("RDMA/core: Use kzalloc_flex for GID table")
Reported-by: syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4334f9a250019c1b79b4
Tested-by: syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/infiniband/core/cache.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 896486fa6185..647a547e2d7f 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -801,7 +801,6 @@ static void release_gid_table(struct ib_device *device,
 	}
 
 	mutex_destroy(&table->lock);
-	kfree(table->data_vec);
 	kfree(table);
 }
 
-- 
2.43.0


