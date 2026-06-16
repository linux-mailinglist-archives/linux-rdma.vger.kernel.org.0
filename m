Return-Path: <linux-rdma+bounces-22268-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hq2xCuSWMGoqUwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22268-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 02:20:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C231468AE4C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 02:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="qlZbl/aF";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22268-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22268-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC946301B930
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 00:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAAD223DD4;
	Tue, 16 Jun 2026 00:20:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187E1D7995
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 00:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781569235; cv=none; b=HSqgOJP+yKD4f1EMmJQU5pmQdY3tkBe/evbfOI421sud2SL1syLJj4rnRxWNfgKdytX1Ew+qaKpHmh01EhDYom41ksfFFdi4hdgBpE/gOitr/bJBfTFJN/gzeFLC4asOWGkM5W8f5b8TE36hjqvu6dqTJAjblOhoJ0hiI1UZlKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781569235; c=relaxed/simple;
	bh=9O8H+XbMNAvS0v8jx+Btb6gpaFePeTzU8+bTKnqo+90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGUx/8hiHwGaLlGe5NPNBq+X+i6ZchDjou+X3bVlMFSEkSuL7jOqqESyV4Nl8wKyoM4sc6IHSn6oEFekB5q4R3ATNtQqceQOywAjxyZS8PDs3+FUiMAYZ0DQm3evkwluuvMgXvaJ1bL0BkekjPEbGxwWzVTBzumpsLDsKyA+KUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlZbl/aF; arc=none smtp.client-ip=74.125.82.67
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-137335bc3caso4709181c88.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781569234; x=1782174034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMcLxKso4b2k5fy5qxZ4EymeOosh6CwCvDbgFOT0gso=;
        b=qlZbl/aF8AvrpScOyoFkDU0BNEPYrs/sUjc9Yw8v+b7WULPh5+LSy9F8MfDCXMDcc7
         za1kAR8zwkTVSKa3euLgiT5SSn8I6mOyAqHI1YpUSGKuCHPNQ3jiigNrb0ozqvgPoFcE
         KrnpQl2vYzzJPXW+/1cTjfIg2TE2Kyy2jL/cVNTPsBuS33M9sY48kOTIXTzside/EDC8
         OQOu3d7A2WCQK98PcCtQVbrmhNPHct5AQs47XR/9wTYXwbUYQ6dabT8F5/u545gQCK/4
         Y3Heo/SuZZqC0DVMr9lqDVqEX4kGkdFCd3eNki01gamwg5tNyozVcofrh124lja2CMYv
         LyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781569234; x=1782174034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMcLxKso4b2k5fy5qxZ4EymeOosh6CwCvDbgFOT0gso=;
        b=Qi94VPsUswiZ1jKLI8qqYoJh4H/oToHUBJVmQJnukJTRGDFToGotikddJ2l/tP7lmz
         9ROKg0XZyAFk2Gexl/dQas5LBgMlXH7HBA4zvK9P3FCbS/hzfrw8jC54y4vocF5i2yQc
         80WAWryCJtlKoBYSinpJ9v0dqAOcELpeGnBpJh1t5F5ni1XupK3DZ5qwivv0a+tDlu/n
         i0FUXl+oDLNxzSLNM/Bhs/ao5W0UNRisn5gpU7enFk34KqQv4TvHR0JcqJknAgjG/FLH
         HQCH1Avzx0/MxWXTe8WFz3hXUx/DuNJaSs56NsRyCrJVWhV5bnKK98heTvYtm4brp8lB
         PzCg==
X-Forwarded-Encrypted: i=1; AFNElJ/BCaM8HeWDQqk/7vHfQcirfmbjPOMQTOxPBNQQJhaPUc/24eLz12iDw9CrYwxHVmoitU5Tz5btD85x@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnDWgCkwxs4jUJUKUNuZH5c4gw2QYzqh6itABltzcT3qfg+iQ
	xGD3UC1FkPAPZhR4Fa6hsrsQgZNlHHRQuVdt+Det19pwAjrYlAZN+HnZ
X-Gm-Gg: Acq92OH/Rm00Fo9i+wV7csxtgxgDg+LJBvG/grZm6q23PmHRmPng4mW02yU9VwR66D1
	Rf3TMrOvFalmFyElvv0Lmwh1hiroZKBcU4dRf0c7F1SyqrP5AyRoHSCrAUhKP7yALn7g+TAiXqE
	vWwk5zI5oCS2J/24K22bB9y4WZtW6prhCnlgMjN5SFbRaVGfy/nVZP5zSBVvhE8kyekWcVo+PUy
	u0NoOZ3xUtBYrnKHEktEW+5N8zFl0Onh7CRjOAncus/IR6q2aU7lPJRls1hy7ApwMFZXEJHEjRl
	vtxemDSuQsIzlS1nAdn1Nc0AyS8HHQLyX+6/jv7wpJp2fNA1BHHBU18IbCeWrPrbdHIvgooMvNT
	+cqp0YZPikI0u+Gi+XjogL/oYViFrnckcYp5YeP5wsMwoXwF3r/MwyskLmr3mS8x4VJBgx/j991
	Pm1DfMUh3p/SoS6d1P9M6t2kaBszoN9u822o9y8/7hCDTd6a5Q6ZhgHT7VxfjvF+KhpaVcOo0v2
	TMrFAE+Ifo+3b+ri+WLwEAK58YLJNG7gcWtb/xdMeHpqXsN9H2Z68VCSBHrWuah0Jw5X5BTK7jx
	ppJCazCoAM8IfiM24Q==
X-Received: by 2002:a05:7022:108:b0:138:508b:93ca with SMTP id a92af1059eb24-13985f23377mr563572c88.18.1781569233498;
        Mon, 15 Jun 2026 17:20:33 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1386f20ad25sm10026045c88.0.2026.06.15.17.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:20:33 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Subject: [PATCH] docs: infiniband: correct name of option to enable the ib_uverbs module
Date: Mon, 15 Jun 2026 17:20:23 -0700
Message-ID: <20260616002027.67925-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,lwn.net,linux.dev];
	TAGGED_FROM(0.00)[bounces-22268-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skhan@linuxfoundation.org,m:dzm91@hust.edu.cn,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:enelsonmoore@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:corbet@lwn.net,m:alexs@kernel.org,m:si.yanteng@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C231468AE4C

The Infiniband documentation states that CONFIG_INFINIBAND_USER_VERBS
should be used to enable the ib_uverbs module. However, this option was
renamed to CONFIG_INFINIBAND_USER_ACCESS in commit 17781cd6186c
("[PATCH] IB: clean up user access config options"). Update the
documentation to reflect this.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 Documentation/infiniband/user_verbs.rst                    | 2 +-
 Documentation/translations/zh_CN/infiniband/user_verbs.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/infiniband/user_verbs.rst b/Documentation/infiniband/user_verbs.rst
index 8ddc4b1cfef2..96bcd1bd37ad 100644
--- a/Documentation/infiniband/user_verbs.rst
+++ b/Documentation/infiniband/user_verbs.rst
@@ -2,7 +2,7 @@
 Userspace verbs access
 ======================
 
-  The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_VERBS,
+  The ib_uverbs module, built by enabling CONFIG_INFINIBAND_USER_ACCESS,
   enables direct userspace access to IB hardware via "verbs," as
   described in chapter 11 of the InfiniBand Architecture Specification.
 
diff --git a/Documentation/translations/zh_CN/infiniband/user_verbs.rst b/Documentation/translations/zh_CN/infiniband/user_verbs.rst
index 970bc1a4e396..31534681654b 100644
--- a/Documentation/translations/zh_CN/infiniband/user_verbs.rst
+++ b/Documentation/translations/zh_CN/infiniband/user_verbs.rst
@@ -17,7 +17,7 @@
 用户空间verbs访问
 =================
 
-  ib_uverbs模块，通过启用CONFIG_INFINIBAND_USER_VERBS构建，使用户空间
+  ib_uverbs模块，通过启用CONFIG_INFINIBAND_USER_ACCESS构建，使用户空间
   通过“verbs”直接访问IB硬件，如InfiniBand架构规范第11章所述。
 
   要使用verbs，需要libibverbs库，可从https://github.com/linux-rdma/rdma-core。
-- 
2.43.0


