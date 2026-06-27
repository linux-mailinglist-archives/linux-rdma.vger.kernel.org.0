Return-Path: <linux-rdma+bounces-22500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fuwZBPc7P2p+QAkAu9opvQ
	(envelope-from <linux-rdma+bounces-22500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:56:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4BE6D0CE8
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 04:56:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=M8b0nyHa;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22500-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22500-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21B2302DFA4
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377627FD43;
	Sat, 27 Jun 2026 02:56:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35231419A4
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 02:56:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782529012; cv=none; b=hRcFPt6DtrY65YVhMqIcSVMyndf+GL3J4GwNHWXIsTdo5Yp7wxeDmbcCDXFxXCfPEvDkQ5lFyUdu8NkZ4ZdKLncFyYj1/1Eu+D++MROEoKBsDyH+xulaXw1xTKhIki8xA60C/ypGrBMgai1I09xYFEoPtz7honaGocylB1z7EyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782529012; c=relaxed/simple;
	bh=XwNTF0g1kz959JGzc5MF+ON3a3mPfRe1o3kQBmzRh9Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gHrJ891zl35xijYfHVa4TaTU2D8oI3V/yPbBS7alrwSFu6xmPiIj9QyLZVuAY6QtpCLTJB/bvziMGW9F5KDxGdzf3CuE5JA+tRNVethmfR6PNfRxHbjrbapKs1CuwyNdw4zlWd7R+sO90IhoqrOIY2L4CUhSdJ2Linlw+9+JIoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M8b0nyHa; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-662e19fad94so2630073d50.2
        for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782529010; x=1783133810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZM5fPepQ/gxo+4pOkQXKxqDpxqxpJb3C4WBSyDbZYXk=;
        b=M8b0nyHa36ILnmDiI5BCiYCMK0PT5QH7/IyIFFK1iwVA9N1junJaf99rbGkBKQU7nG
         SFAE6DLn2Z4hMn8XrLAV05hnsyvS6eTf94EjOHG+ufT4fDNGnbOS6xizeCS22aKrqrLz
         G9sfmY09cC+7KaLgtdKXBcH069nxSG6il1xitId2ExYR26HiD4PmNhXCk5Z8dXJwrtwn
         ClXGVU28wiklNo8q6SboSannDNsBKd9qNr/BifLRX4yl084D+L8BFbooebZj2jotE2/V
         YIfPjjhG3Vv4C/DbZgbBjwZ9Ulwnvef+G7lnTfpbOxULMaRkd1wgISeUqvwZaFYmVfxd
         MIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782529010; x=1783133810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZM5fPepQ/gxo+4pOkQXKxqDpxqxpJb3C4WBSyDbZYXk=;
        b=jhcDKLYVKBV7tb8RCHin9+Br5b4N9nEo0AZto5Qifv5X/1M6Ey8mV1U9DiWRMoDRmA
         B0+MJQiE2w5zsrqAvtnDA8nj4ZZhtqQ0C1HE7Y8PE94gSPCWRT658mFYYYgwwrVFcv4p
         yobbAgKO6H13cyzgyRHfaYpNxbxS3gSrHcBS0MyjqNkE+3OEMMW1l9iLoeCdyP+YNtFR
         Q7GdPdsyPKdUhOO4O/xBaL/k1kNLaytzcMk6ZHrUpPnI5ZyRWbsvwYD5wFaH+pqnnM/I
         mpAVCMyL/iEjm/56zjTHCFyeOKP0T15q9IoWx2EkVebq1UjLA4YHmyy6tgw6Hc9w4D2e
         bNYg==
X-Gm-Message-State: AOJu0YwI4qtWOM861UDDDAB4aeYL2iFYvPi2N/m9/v5OcWOYT/O0GfPp
	vOLzFSDpXMOs46fqrZDZr2J/8COKKjy9XQK1Juj9zN+7wNT8bLLlzuPemduIeZs5hmslBb65NXo
	rKT5TnV3Qkw==
X-Received: from yxbr1.prod.google.com ([2002:a05:690e:4401:b0:65e:a13d:6a72])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:13ce:b0:664:7eea:2327
 with SMTP id 956f58d0204a3-66487f66856mr8262077d50.42.1782529009511; Fri, 26
 Jun 2026 19:56:49 -0700 (PDT)
Date: Sat, 27 Jun 2026 02:56:37 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260627025642.4064973-1-jmoroni@google.com>
Subject: [PATCH rdma-next 0/5] RDMA/irdma: Adopt robust udata
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22500-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F4BE6D0CE8

This series brings irdma up to uverbs_robust_udata compliance.

The driver has been audited to confirm that:

  1. Methods which do not accept udata input perform an explicit
     check for no (or zero value) input.

  2. Methods which do accept input perform the correct validation
     to ensure that additional udata beyond the kernel's current
     ABI definition is zero, and to enforce the required minimum
     length.

  3. Methods which do not return udata responses use the proper
     helper.

The irdma driver is backwards compatible with the legacy i40iw
provider, so special care was taken to avoid breaking any legacy
binaries, as there were some small differences in the ABI/semantics.

This has passed the rdma-unit-test suite using the normal irdma
provider from upstream rdma-core.

Jacob Moroni (5):
  RDMA/irdma: Enforce empty udata input for no-input ops
  RDMA/irdma: Use robust udata input copy helpers
  RDMA/irdma: Use ib_respond_empty_udata where applicable
  RDMA/irdma: Use robust udata helper for QP creation
  RDMA/irdma: Enable uverbs_robust_udata compliance flag

 drivers/infiniband/hw/irdma/verbs.c | 135 ++++++++++++++++++----------
 include/uapi/rdma/irdma-abi.h       |   1 +
 2 files changed, 87 insertions(+), 49 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog


