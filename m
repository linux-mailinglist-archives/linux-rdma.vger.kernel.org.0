Return-Path: <linux-rdma+bounces-16235-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id erdPG3p1fGl7NAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16235-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 10:10:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE1B8BD5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 10:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AF83300E72C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 09:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACEA346784;
	Fri, 30 Jan 2026 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7JReE3i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E023F23BCF7
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769764215; cv=none; b=eLa1OH9U8sdVmg3urYZaSr6LIdWojnIDoOfK8Idpin8hEODITY5O47a2F4O3sbs84KpeFyqJs7Ca/3l6fC4cMyBYfOJdD4J6FCSGoGgwwhhhmThui6c2DSKsMVcCPV6CHot8b/K+AruevtLywU0E4isHp1VjzZH1mSk02fl3LZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769764215; c=relaxed/simple;
	bh=6gUSuH3FvYcDRfON0d/gsR4ELKPPhUXoPa4UU3rbWi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldfEcHCbCcZX3ImLFsTUlw/5yWaOU1+qsv3g9xxvR3VcmPhn93cptyv0Y/LjgCgXWbp0fB2AoFtfYx45pdrgvuJJsweP5Jpk7WVtjpulR/FXrv8SMDKKGirNNvT9298H5jmR2p8bAYRTuefyIGM42xVpvJVnnq1BFnCckLyI4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7JReE3i; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8231061d234so1662906b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 01:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769764213; x=1770369013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FBb6805HeHSkRdX5bS4q6RmIIubCh3FTCohlTI/P0Q=;
        b=S7JReE3i04xQUNaQZjAQt+6nqR5YH8oVobqg6sKfADYwAqB6UYrG1MhWQI/m+JU3Fc
         kwm9Gr/N88fxC0FJYZhqqlOqCQOHaj1qORlYBT/Pmm/MDIYPwrCFWpuxQmt/chlYZgLB
         pO+ysxz3jH+jlSCO5EWUVsaM706MPZWFDBiv9p4BN8uo++/4AMRiXLqgbJElANpFbN2W
         48NAr4Vu11C3dGlm4rmss0k+PdY04Ffr6jlQELHbjNNuybQUpRmteK01FOBEMTQYJ2DR
         vMs080qf7HGS9b0ZnUz/bKR6dPWMQ64DiYlLfyUvOPeNgyyihfsSE+Mdy6RlqgX6EzSk
         SSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769764213; x=1770369013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7FBb6805HeHSkRdX5bS4q6RmIIubCh3FTCohlTI/P0Q=;
        b=NsAV15Z94BDIKMJCrWpkoaLgc6rAT3RFoUt36VGPVeRnz9h3VR19DJoYXKdyWpJKys
         M+CVwaQXOnOufXHHM6ifgSuA6HWsos84Tiw4VvMgvq9++Na2ELTqNx5iEjlnnxY55nzh
         kuUS8DJh8WccjvRm6AnFs+mACtzqlKXXLxjwUK0phFK6T4rWFcenis8RBi30ONeTFIeF
         7mwz6TM2p8QUbjc0TxwpDJdlRjE4vejrubBCLkD6ffzxSWAT4hZqVjtYXZK9L+cdr4ks
         y2ijT0IkzvxpM4vic9iXXSR38eeV8Ice7RcHAJ3X/qZPKsCQ3PVyjOMHeo99gZVGeAmN
         Bmow==
X-Gm-Message-State: AOJu0Yx++B0HJfr270hx+G0XekcoGYecz4MuVySx5khhcnA90MP28M7k
	Qm661ktHfJR/uWA5mQ3m7wsMJaQgLVbuulJIUwjYYLfrUaOBZcSeH4ME
X-Gm-Gg: AZuq6aIjsRJPwCzX/tPeHE78RNBnKc3HjVw3LFcb2k732sgtd8mMRXVaVANYWR8IlU1
	oEE4DgXYZ2kuyVzEHi+RRyFiqI39LkhuWdpRdY7g5zx4tLOVRGqkvUnfE5gIy3LZtmQpQTcyUT+
	0cba9fKkvUngysOiOGfL32TFbixQlhtr2RoVgVf4fMkc7nx2+V81THjb4GS1+yO+xWtlBnyvQjU
	GGa8vPViOrnBYsMa3aofAjW3wUQlqPTla7yS6gkzDFYeyt3LUINlpgcpziBM9oIYxpSp4RVunC/
	eIHr6sYOp6O5aSQySdID21+3FepCqZYO9ABm/zwapYMPvqJX1WnU+cXoH8LJyceBs8O/1put6zn
	PNNY0qFzNbpbkK4QJEfDHZUmISEj8GapV5UbU7FzLnnD4CoOIz52f+Sq1QyeCYzUVZ2f1mRTN57
	Soy7jXlntS0kitwbjKlOAXVPH0wPXmRWs6
X-Received: by 2002:a05:6a00:ad81:b0:81f:3d13:e079 with SMTP id d2e1a72fcca58-823ab747b2amr2425159b3a.45.1769764213082;
        Fri, 30 Jan 2026 01:10:13 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b6b2bdsm7431930b3a.30.2026.01.30.01.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:10:12 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	Joonkyoo Jeong <joonkyoj@yonsei.ac.kr>,
	ioerts@kookmin.ac.kr
Subject: [PATCH] RDMA/uverbs: Validate wqe_size in post_send
Date: Fri, 30 Jan 2026 18:09:23 +0900
Message-ID: <20260130090945.2426003-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAMX6_QHfPsyybbO_79u4RpbGY9H28xhpaVPHUD-wu2U+V5W=7w@mail.gmail.com>
References: <CAMX6_QHfPsyybbO_79u4RpbGY9H28xhpaVPHUD-wu2U+V5W=7w@mail.gmail.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16235-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kookmin.ac.kr:mid,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: B3EE1B8BD5
X-Rspamd-Action: no action

ib_uverbs_post_send() allocates and copies a user-provided wqe_size but
never validates that the size is large enough for struct ib_uverbs_send_wr.
A too-small wqe_size lets the kernel read past the allocation when accessing
user_wr fields, which is observable with KASAN.

Example KASAN splat:
BUG: KASAN: slab-out-of-bounds in ib_uverbs_post_send+0x106b/0x1600
Read of size 4 at addr ffff888007df4748 by task repro_hybrid

Add a minimum size check to reject undersized WQEs.

Fixes: 67cdb40ca444 ("[IB] uverbs: Implement more commands")
Reported-by: YunJe Shin <ioerts@kookmin.ac.kr>
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
---
 drivers/infiniband/core/uverbs_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index ce16404cdfb8..a80b959482e9 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2049,6 +2049,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
+	if (cmd.wqe_size < sizeof(struct ib_uverbs_send_wr))
+		return -EINVAL;
+
 	user_wr = kmalloc(cmd.wqe_size, GFP_KERNEL);
 	if (!user_wr)
 		return -ENOMEM;
-- 
2.43.0


