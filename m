Return-Path: <linux-rdma+bounces-19196-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEXEGGxB2GlEaggAu9opvQ
	(envelope-from <linux-rdma+bounces-19196-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:16:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC33D0BC3
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 02:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DD7130177BC
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Apr 2026 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B26265CA2;
	Fri, 10 Apr 2026 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kq8tPiJ9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2B1F875A
	for <linux-rdma@vger.kernel.org>; Fri, 10 Apr 2026 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780192; cv=none; b=CqB9aQUQkZFtEdY9vmHLQoGlxYRsdW936de6yWhE32nw1zef+UNWFr9hcTG/ck4JApUNaCe4t+cth+5MILu34uHV1SluvGEzrRmR4tl2/uouDH4+/77MJpyNE81poTaDnSqHfXRjkpi2Nzfa/VKYo15+fAK8d0JxIaNaPytWFkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780192; c=relaxed/simple;
	bh=ismENOt4U+WU6MErnc6TmILuwRGdObfgLDDZxhrJj7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mgo+hKh97iQkUS6FO4QwYp8H7tA3/8rOvHbPdUCCRjMjb+kz4eY6/IlSNZxElfe2J8ryy3LveaZLGm+bTNHk6RA839dJwsBpXmMOWaz5aaJBx4YqNS7dfYXVIUS/lbxIw52lAj5Z8FQbv4v2OTaWIK+3nvGbQA60bDrcqmdIge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kq8tPiJ9; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2b2503753efso12630915ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 09 Apr 2026 17:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775780190; x=1776384990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBen+1IoSpzDRpuAQzDqqIXSCFP27EkcSl+DB/MBo8I=;
        b=Kq8tPiJ9h/9+Y2VVy2AUFyD5/y0wnfbkigtldXbmKsUXoHShOEiyZosO6Pil+HDVXm
         fb1DMUmjuymmxoM8kQsiBzNFDGgx1SnUVOSA3mRcbPKkehGA4y9kN7udjzpjrds2i+rq
         6oAbasHFhTtZg09585Jb3hgncKFb97O8kDzOM1ilWxe/STtG18IETpHTimSXeUTbKY02
         CoMaB0n67yyLR8TuYh/S8dZYkUtaLI8+ilRYNc5iovYZtZFVN9RCnRhnLyU2He6UKyju
         g0mQrDheHXFlC380KDjsDGreIY72oUy6653pSnTXQD4pPLfNDZlo6yXnpwAq3KHF/xTz
         4fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775780190; x=1776384990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBen+1IoSpzDRpuAQzDqqIXSCFP27EkcSl+DB/MBo8I=;
        b=gEQ4ADqAOuMoq0cgbLRPiev/tMDsdLWWMkUFbMe4nF4xz/l+fuKuxO0WdC43AXWZ3e
         hRVPfyw1PQ77tSh0ng8OpjjQlGEM9YY5MQ4+rcO+6/MplyHQOTEtpvxGlT1Ry792UDWs
         5MmNTGRQzLY3U3t6X0JeOiMpUCYj+lMVdmeI63wl3ZImOh7tq/rNmt+l1wDs1ctL4T6S
         AR1pNEGBHm+J4mHOVstjYKMIoZoLUIGWgnBY3UZZjpiF8tn9S5PV/WNHbStQEjqJgd82
         R9ikhuzl7Iu/ik4ih+c7JztuphVXFc1ekWloOwUCu4iy+2OlBA5a4zbZPsDhFnFA4Isw
         l5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUbApi+1Riqg7YAV7DngRhSqLueyo2TLgZGA2uN959sY//Uwu8Ehl8pJp2xRZANlqIdOg55ueX3UDAv@vger.kernel.org
X-Gm-Message-State: AOJu0YwbSG9q27k0MgozPw2AkyQmP2rkF3Yh0I9g9b3TNNb2/tv5FHGW
	1XoFB9bAm286wLYqjbcXdEPUIZ5XxlohubeKQvrgN2NmQtdPpkDln9ZwzT4MQevc/THZ75MrFVG
	74HF0AXHZj65eif4mODudd7KBuUQMKVzjwUJymS3cYT7insv30EW/
X-Gm-Gg: AeBDieuPFUmjk9xGfB5+bIWQ81vEedSmI2WCCAaU6jRcRDjJSuzHqeixPX81p+Pz+D5
	hQPxdBNB4GOtm0zx1k7+K0DCBUQSgxPKgItcL/HLkLsO8LlBP0blKBNLgpjEiPIN0fbKwfBrXeI
	UiseX/z0lMHUhTzQmGt/FTKsIIo3t+UyRWvCl+jptgz3V0vu98VmJoq/wrb63ZJOaO/Dx1ATmHI
	kUd1Y38Lsy6CDMY+JdH+ZIi7ytUwHJdiPnPzxjGLR6MNFW75TJSuYqvDmGH2XznZ/sstux5oAgt
	cXjStlq36U6+H1Qom+QyauU+gOTTaTj7LaZ8cIWLmJTifBllv9BpOOYoseqJRlxd41fzG52s+jX
	/Q5nJV1PSAHlmmt5uS5s2CYNj8LtnvPh0f5iopg==
X-Received: by 2002:a17:903:40cb:b0:2b2:4e5a:9471 with SMTP id d9443c01a7336-2b2d5a38464mr8639795ad.22.1775780189904;
        Thu, 09 Apr 2026 17:16:29 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b2d4e14a87sm716215ad.5.2026.04.09.17.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 17:16:29 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.40.132])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4E0353406B2;
	Thu,  9 Apr 2026 18:16:29 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 41A0747DA5; Thu,  9 Apr 2026 18:16:29 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Edward Srouji <edwards@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Kees Cook <kees@kernel.org>,
	mkhalfella@purestorage.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH] RDMA/addr: change addr_wq back to unordered workqueue
Date: Thu,  9 Apr 2026 18:15:49 -0600
Message-ID: <20260410001549.3149060-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19196-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgogte@purestorage.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[purestorage.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEDC33D0BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 5fff41e1f89d ("IB/core: Fix race condition in resolving IP to MAC")
changed the workqueue "addr_wq" to a single-threaded wq.
Commit e19c0d237873 ("RDMA/rdma_cm: Remove process_req and timer sorting")
eliminated global work and started using per-req work.
Now we no longer have the race, change "addr_wq" back to multi-threaded
workqueue to speed up multiple addr resolutions.

Fixes: e19c0d237873 ("RDMA/rdma_cm: Remove process_req and timer sorting")
Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 866746695712..7ce012f389bd 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -848,7 +848,7 @@ static struct notifier_block nb = {
 
 int addr_init(void)
 {
-	addr_wq = alloc_ordered_workqueue("ib_addr", 0);
+	addr_wq = alloc_workqueue("ib_addr", WQ_UNBOUND, 0);
 	if (!addr_wq)
 		return -ENOMEM;
 
-- 
2.53.0


