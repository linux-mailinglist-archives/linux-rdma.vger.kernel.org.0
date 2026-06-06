Return-Path: <linux-rdma+bounces-21888-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c9wNOSqdI2rQvwEAu9opvQ
	(envelope-from <linux-rdma+bounces-21888-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 06:08:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 484F264C567
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 06:08:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AgPmD8NH;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21888-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21888-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1142B303258B
	for <lists+linux-rdma@lfdr.de>; Sat,  6 Jun 2026 04:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9422F3C0A;
	Sat,  6 Jun 2026 04:06:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBE2F39B9
	for <linux-rdma@vger.kernel.org>; Sat,  6 Jun 2026 04:06:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780718811; cv=none; b=pyUmLOh8HYOQYc8bPgBUOrAndQn2to2u4w9Rxj0e2pzhJoEUiW0LJnfx/dEw/ATTHyXwMOUFHWU8br1Tu1pD9R6oAMWv66o7IFeQ4xfVsnxC9pv9gq+8N77dszywRm+OZU6stbGm4Ty2g/s9MN4nraQdp85TMM+UHJ4P/cujbqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780718811; c=relaxed/simple;
	bh=Wwc/btTfzA7l/jcXEHUEYbKRnHwUM7rrn89qeAjFt2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opggQsMmX7OTreE4P1SeosdCgoLG6T6uHAA3lz6vYpMZRL9jBZQRQlL4f4dPRMjIBUDD/ak4izxI0nIetX0VOBlRYRV1rPCbrweb+7x71gJmJ7C+IXPcNSyBwZOe/40IxIBIkEggL+Lcq7AHqdr/0JzDU8Rrv1CoNrvydsWKRXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgPmD8NH; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1124620b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 05 Jun 2026 21:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780718809; x=1781323609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkFR8PD5hTsVehXEUiC3ZjzrwKQUAHChOG9ZKsTB6rM=;
        b=AgPmD8NHm5YeTXBdlus3ahsacJgfKDFAxXDjKqtPNrh02/GYaRisx3WBrICyc9dK3M
         OYrw6zs9M7cn1zHWqSPNFm8XtO/Vp3Lx64/E8wtkLxecGBBnCP//zG0D0oc653IcWPLf
         TSj9urGm+l4oC23kcACccytQkEWy3RG9cgTY2mWmFOnFCB7ydefQLKDxqJ1j5Q2a6J6T
         ukDzQqX2LpDCeYdjZKUNqsA38SovIsf/OQT+hb2PbLVKyLX92li8YJs16HrtQV3ejDwx
         DAfzmr3i4wsdiUHaWf8INXi/IMVNI5Bc3h4OuKNApl/9yCrW9P4wPT6szL3aTHRYS3DY
         mmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780718809; x=1781323609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkFR8PD5hTsVehXEUiC3ZjzrwKQUAHChOG9ZKsTB6rM=;
        b=K5nXu6/6A0zF+lXZhOzDcR3VcGAeIxv1quWmOqyx3eKBCc6anhWqEKZOMUWtxYCIBn
         RlsRbZqXlm/lBqZlYbgGPk5u2IdjwbyA+XzwU57BrqIXQN7F2wxev1sEnrl6HHhXloO8
         DcCSkppQTD3EXrSI85v5GObm434Vb4nL9rPG1kD0Ra7kHvjX8glWHX4H06S7q7EUKdb0
         x93nP/xuqllnNxEs/CUWeutK57Jm5pJlX5xrNu7ZlNUNvnfC/GUFvaOzGjo73WvOCGDU
         PocFiKugKYsAAcK1k7Q0uAoIPrOv7ltiDVoI3LYFwIp5bA5Fv+6WKJAwAAyOnYdDQJh/
         CuqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RtrSWW51uS8/6kbSyqdzwvkL96o5z3v/g9j7XTGrsooYAADrz4w6JZ+qyaP8SWGCp5mI3qA84di21@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyc+4UYu5QqNiJ0Zs/T/3pVDrFvLhU9v/bm63DasZbg2T903Yt
	mePfjHC2c/BO9ZknRcxEmAxI8mUz0gp2YxRheLLBwrECYmbZV/QFTzZ9N8vvuE0Vxb++1g==
X-Gm-Gg: Acq92OGt7vt1CSYllIveMigxTeUbvjBCpMYH8/2AearZTJy+2j7C3M6Zv9XNWZzoCeN
	SC7lFUHp823nqvfQZGf3Hz8GIRs3OmfVD9x6voU9qTTEO0Wkf38LeqOCdV7x/r3XNWI4h0nxDte
	qWn11KcO5f9k9Txi6dbKnoZvvTHlAI/8t7So3v832SCCfOOtJhsgn8P7RuE9bhEPPa3dbWRQMvt
	53MzAdNA6iJLjXm5r6riHAJCtUGGYAGNw9f9fX0Xqg9DsYhFtMokuLuXd7FuyygpDHJZ11oNt7/
	kUg8si2pJtbyn5vNb2IKga79/L+yA4kyoJYG3TF2VKkEqpcXusU8zpTUyc9lGPpl2Y7n8Glm4t6
	pjM1vT91NWc6uG6lnTpD5mOjWDMH42oA+2wekzm4K7mjQq/RHmnxMVImZtJY0R9ITL/Guf/WyFg
	yuIJUkzz6WqBGBN8FTKAGaz3oJdImh6nC3yM8o1zIyXu1TYf4bswLMbg==
X-Received: by 2002:a05:6a00:194a:b0:842:4f20:53ff with SMTP id d2e1a72fcca58-842b0fd16bdmr7035088b3a.42.1780718809337;
        Fri, 05 Jun 2026 21:06:49 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:967f:7ce4:ec98:f08b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372a16sm13112774b3a.18.2026.06.05.21.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:06:49 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] RDMA/bnxt_re: check debugfs parameter allocation
Date: Sat,  6 Jun 2026 12:06:44 +0800
Message-ID: <20260606040644.13-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21888-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[broadcom.com,ziepe.ca,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 484F264C567

bnxt_re_debugfs_add_pdev() allocates per-file private data for the CC
configuration debugfs entries. The loop that initializes those entries
uses rdev->cc_config_params immediately, so allocation failure would lead
to NULL pointer dereferences while setting up debugfs.

Debugfs is best-effort. If the CC configuration private data cannot be
allocated, skip those entries and continue with the independent CQ
coalescing debugfs setup.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index 5fed2cf66be30..b1d6a8b32cc48 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -498,6 +498,8 @@ void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 	bnxt_re_debugfs_add_info(rdev);
 
 	rdev->cc_config_params = kzalloc_obj(*cc_params);
+	if (!rdev->cc_config_params)
+		goto init_cq_coal;
 
 	for (i = 0; i < BNXT_RE_CC_PARAM_GEN0; i++) {
 		struct bnxt_re_cc_param *tmp_params = &rdev->cc_config_params->gen0_parms[i];
@@ -510,6 +512,7 @@ void bnxt_re_debugfs_add_pdev(struct bnxt_re_dev *rdev)
 							 &bnxt_re_cc_config_ops);
 	}
 
+init_cq_coal:
 	bnxt_re_init_cq_coal_debugfs(rdev);
 }
 
-- 
2.34.1


