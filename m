Return-Path: <linux-rdma+bounces-23153-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8UArN4EdVWp4kAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23153-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:16:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9B74DEE3
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="Q9/BmxtO";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23153-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23153-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55FBA303D318
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E819F3438AB;
	Mon, 13 Jul 2026 17:13:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C0224F3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:13:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962789; cv=none; b=ngF7e4+7UBszOAMzlIZYZSIDH0mkLTDwAjoDWgTLctM6KY/NI4cStUDd0tREDxKFZnfV2P2cxbp4udsLpIEUuvTBH1Pzt9mXdnw3Zx4dbzwVBR80m6Fd9+3+xof17tgIbqFlxzAuFCBsx09HrogGa2SZhNz/o3FfW68Lgi9KbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962789; c=relaxed/simple;
	bh=2ciwpwQKyDUd6M5hmOIkOdHQYSXF9IRNcOEurd/ogJg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lsiqlNW0Jyt2JqJQ3iaS0CeIH5EGaHOyc4bdvSr6W8nrwt4l/m+ab4Jo4f7dYkH0FOT9Wg+TtICaVorujwboxjsfCvZRSTC4QlzeGDi0cN90G3YDLAb2iQs9jwydvCdKNbjnnr5eoBe2IrRrKGfUnByVlBFfGvMibNZ0R6B13q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9/BmxtO; arc=none smtp.client-ip=209.85.219.73
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8ea75996387so84524556d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783962787; x=1784567587; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/IzBwHnTZZB3XD8oy+6y6WOmXcxsFhbanaw25aK1SSg=;
        b=Q9/BmxtOtNid921qFfu0s57vxpF5Cp/7yOpKp/LzvpQJKGn06MkcK9svldxyIhPEje
         boNdwU051vmbg191KoAHjwutbZfwV4ld2okGbeh3DZRDy5Y3xUXOGllDsAwq7T2DqQPA
         FhpGqzoJgW/1HBvJMdQCmYeNleRaoF29dkYvuVXqzm36i4nRdV2hR6xf90kS28KpX+yk
         9bscSl6g7vtAMn15aCWN+aTO/LhPmI3mVzAjPpvbBmXXjOSsK97479YyAPxdgemuH8pS
         2O/Aup5U8QBIgVU7dxXzzVUR09OoBJ2EOliGpmbRB4bzUOaFY5SPmfl4BGz3QaQ0cBx1
         gZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962787; x=1784567587;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/IzBwHnTZZB3XD8oy+6y6WOmXcxsFhbanaw25aK1SSg=;
        b=KR+Mq1MzXq1xtWUu6wrOY3Qo2GNBPDc5pn2DRPXVU371qBGgAeFmbSQFQFmHEXQEqL
         5eiXCLPSI8sxK1IzbKNLQHomIEG4ryH/ZoNObPpc9z5V4sADySS+j1u1c5N2TDjwF0Zh
         fzw3Km3XZW/iP+Gc4X/nNLoKNrgPfVKbLKyoSnJQbLeSIebRsr72xsHIQqcAbv2mYEyJ
         pSLKPiSe97B0wHZxiUmCNG0CKkc7drJvPCbXDJ0g1A+ACCy9GvkzJ7oLLDhu6+i6huBM
         aYhTJrBSQlhJhgE+A00SYpz07YzJq+tQOnmASv/F7j4gdFgmaZC4FJAqKD95QxY8hWTr
         bvbA==
X-Gm-Message-State: AOJu0YxnmV1UiA5eqy/qYCq516AIj2xXHjYC9BIph0ZTnSMnyMEpEMDR
	sP5LZvWHw0oIo/1TAM/+YnLI9N5qgwsDV/HxxuypIj6Uxihz/PvQpJZAcCQX8acbft3A2YWfcSI
	bDIfsDop4bQ==
X-Received: from qvbqh6.prod.google.com ([2002:a05:6214:4c06:b0:904:ddb0:c57f])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6214:4383:b0:8ef:4749:b1cb
 with SMTP id 6a1803df08f44-903feb472camr99572576d6.6.1783962787110; Mon, 13
 Jul 2026 10:13:07 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:12:51 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713171257.3131493-1-jmoroni@google.com>
Subject: [PATCH rdma-next v4 0/6] RDMA/irdma: Adopt robust udata
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-23153-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73F9B74DEE3

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

Changes in v4:
* Rebase to latest for-next and added prerequisite-patch-id.
Changes in v3:
* Add ib_no_udata_io helper to more easily handle the
  common case of no input/no output ops.
* Fixed regression in create_qp failure path caught by sashiko.
* Rebased on top of previous posted irdma fixes.
* Fixed an additional latent legacy compat bug in create_qp.
* Added missing response buffer clearing for reg/rereg_user_mr.
Changes in v2:
* Fixed Sashiko findings:
  - Moved ib_respond_empty_udata to beginning of most
    methods to close gaps where it could previously
    return 0 without calling ib_respond_empty_udata. This
    also fixes issues where the ib_respond_empty_udata
    call itself could fail, which may leave resources
    in an inconsistent state (kernel believes object
    is alive, but driver resources have been cleaned up).
  - Moved input validation to beginning of modify_qp
    methods to close gaps where the op could be invoked
    with udata but without input checking.
  - Fixed a QPN leak that could occur during QP create
    by moving input validation earlier.

v3: https://lore.kernel.org/linux-rdma/20260702170652.4159201-1-jmoroni@google.com/
v2: https://lore.kernel.org/linux-rdma/20260629232532.2057423-1-jmoroni@google.com/
v1: https://lore.kernel.org/linux-rdma/20260627025642.4064973-1-jmoroni@google.com/T/#t

Jacob Moroni (6):
  RDMA/irdma: Add checks for no udata
  RDMA/irdma: Clear udata response buffers where necessary
  RDMA/irdma: Use robust input copy helpers
  RDMA/irdma: Use robust udata helper for QP creation
  RDMA/irdma: Fix legacy i40iw compat check in create_qp
  RDMA/irdma: Enable uverbs_robust_udata compliance flag

 drivers/infiniband/hw/irdma/verbs.c | 216 +++++++++++++++++++---------
 include/uapi/rdma/irdma-abi.h       |   1 +
 2 files changed, 147 insertions(+), 70 deletions(-)


base-commit: 15ae32c4a3551c4c9da457370bdfdd65d171e512
prerequisite-patch-id: 77dd4e2a9a8beba569e8f7c0454db9c13465dd6d
-- 
2.55.0.795.g602f6c329a-goog


