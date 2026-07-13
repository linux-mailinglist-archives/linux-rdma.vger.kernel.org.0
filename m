Return-Path: <linux-rdma+bounces-23159-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GXevNpYdVWqIkAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23159-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:17:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA4874DF10
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 19:17:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=NXlXVjJJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23159-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23159-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46209307FA77
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DA344DB9;
	Mon, 13 Jul 2026 17:13:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893D0224F3
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 17:13:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962804; cv=none; b=RPj01jODZFvRHdJ2u0MeZUXVfzwqx2zg54rg/1eEumdKBpNSKNRaO9foVVk0251FL1LO7oaIFxrTir/yUdLzBu+7+jC6Azf/tZ7lfdNIjEOGgLV5NJ5WwWrM1IMha25f/Z8e77W5XQKcjfJFIzIdKlf16vJRBil78PmSNVm2fvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962804; c=relaxed/simple;
	bh=2aH6SvmLqRy6tJIdiVqp8KaMrpYIdczAVjN4CKeFIaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=plPTfRIPB/1ZBckv1wtQ4Jy9QBduXj2SgAFi8YTxbH7ayUvKnPau8JuRU+80arkE4CwQSf+aMcmbJxfqw3WKXkOFRJ0qPvPNyrrRF51K4qumjMMr0+c1opkUa20BNvPZEE8UBt1couOOzkkEThy7CcN5x5LMAPhrnwuKMQ+bW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXlXVjJJ; arc=none smtp.client-ip=74.125.224.73
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-667faef9726so218811d50.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783962803; x=1784567603; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kU9dUOIyZYAZxGiTvzJIgU4ETB+OZTGRaJ+al97KaCo=;
        b=NXlXVjJJ8PmRgwn//EwLxGp1C3PcKs/zMIyzaXV8Um6/IXVaWbAnDMId0sS8WdnVGK
         0T03NwlGZ16YhibY3xnW1RPXDWWmm3dkpZtVMGvBi6PguqK7r6qN3WcbAnGx8zJXlPJl
         yjL3DqdDgnSLDMBjWKZxBO3zRQ1hXhachcs2UyQ9IMFaknkCbwP2ASChzcIYYHJS1Lf9
         Bpjhz0CSj32BbGTCdD6Rkp1oeDqeVlZSXs/JJlKjmqi9YLH/9dh3jDYIP4b8u8jEUtaZ
         XIv9A7xoUfhRYmUZ8xuXuRN1Gqx3FpPC7E8gbZur8n1H1ZilDMpILzZz2w36sb8y4FQG
         OrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783962803; x=1784567603;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kU9dUOIyZYAZxGiTvzJIgU4ETB+OZTGRaJ+al97KaCo=;
        b=YsS9pnMnN0osEzyskQs2UQVb7breMSfh+chqLWznReSZxOZxY1yMBxMfcZkbOD8qXc
         CeBFNnn75HF7X4zaBaeZTZWsoRa4bLkg6mhz5wYu594i+xuePYxXRoc85orTg1RQBZ37
         J46sok92JRl60Wr4vDspchoJS7UpsWxMfGTfqiZA5TRveoUE8jNuQH95WnngBTT1pQ1Q
         MJ7uc1Qz0eECbYxv9dNiF6dHlDDHel3wMqEuheGRiY47csJsC0Nm/N9gpdx5b35bkOZ/
         gKI74W9tCv9g0fnrcVFhLXEdmqRS1+R2lMdB+tff62iRDwxTGtskoVFMEU2uWsRfRF3b
         9FXw==
X-Gm-Message-State: AOJu0Yx2LcCDLs/Rvl8rC5gur68WoB/eS/YtvGATqdEqXcQnkmAMW2C8
	5recgIsLXjIwMpBYati+lMaW7wb1pSpAvSIvEq0ESknxeQL2iC8GVBkTx/n4AOEX8NFaekM9ZDW
	enRrbEYBtOA==
X-Received: from yxdv9.prod.google.com ([2002:a05:690e:449:b0:661:4901:1901])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a53:eacf:0:b0:667:c39b:5466
 with SMTP id 956f58d0204a3-667d7bab744mr4816950d50.63.1783962802554; Mon, 13
 Jul 2026 10:13:22 -0700 (PDT)
Date: Mon, 13 Jul 2026 17:12:57 +0000
In-Reply-To: <20260713171257.3131493-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713171257.3131493-1-jmoroni@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713171257.3131493-7-jmoroni@google.com>
Subject: [PATCH rdma-next v4 6/6] RDMA/irdma: Enable uverbs_robust_udata
 compliance flag
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:jmoroni@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23159-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CA4874DF10

The irdma driver has been audited to confirm that:

1. Methods which do not accept udata input perform an explicit
   check for no (or zero value) input.
2. Methods which do accept input perform the correct validation
   to ensure that additional udata beyond the kernel's current
   ABI definition is zero, and to enforce the required minimum
   length.
3. Methods which do not return udata responses use the proper
   helper.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e87c879cecd..e544a6abcbb 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5552,6 +5552,7 @@ static const struct ib_device_ops irdma_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_IRDMA,
 	.uverbs_abi_ver = IRDMA_ABI_VER,
+	.uverbs_robust_udata = 1,
 
 	.alloc_hw_port_stats = irdma_alloc_hw_port_stats,
 	.alloc_mr = irdma_alloc_mr,
-- 
2.55.0.795.g602f6c329a-goog


