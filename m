Return-Path: <linux-rdma+bounces-22645-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZCkyENkTRWpE6goAu9opvQ
	(envelope-from <linux-rdma+bounces-22645-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:19:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C11656EDFEF
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 15:19:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b="B+U/l4YF";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22645-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22645-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467C43290EBC
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 12:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250C480DDC;
	Wed,  1 Jul 2026 12:40:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657671A680A
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 12:40:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909628; cv=none; b=MeKWAGGO+Y26Ykq4w9Vcw9LgDiJFe0oNsYncLI7VGDTypD/uNjR2Od15yUNEMbSq02UvabwVtIFToFw8Y9+XOVH2wyWfLZoRng9OetCMlwHqTTHKqLTQIapxZB3LOponeXZGgmNJJymsuYzLwFXCRhAiWCi+LDvk3ca0EPQciHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909628; c=relaxed/simple;
	bh=Rn/ufL0hqyC5Vey8BQji5BJZm+oRSTxXo98e6B2TtVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhENyAV6p6yKANJD9CCWtUHbVgH7b+zOBInq85oiXARGoTq8RrKRyxC6FjX786ho8a1xeJS1nZO6jgBBNXr+sTz7u69H8vHvlIB2hLF7bs2Rp7pYWDPpC0DT/LQf3hNy8e0BPDG11X2iBQGFjIwaYhuMuWqIUrzqvuYunwvaov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=B+U/l4YF; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47362928f65so598727f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1782909623; x=1783514423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjquPjnSxlH1NouQC11hdL93bCB5PiSU+rHY36k2irI=;
        b=B+U/l4YF9R5FycNmSf3GLWWbI7gxThhgugKx7oan1gDkWD6oG+NaDOn6/z7s/XqIC+
         r6FCCx6gGge+A8m8B1pQ+/boEsvvCegZ+pzAxbbI/4yKFzw7QAjnNahcucizf7Sccsq5
         cMnXYh5dKViu/QytZcvIQc+SbauKPm5pUWc73w7Ikbr/TDTwVWNSXSlvD2w4W93GqkLa
         bFwK+uDW59AEi/HlHYsEEFQpH1yFsjkiZHzw9Vn5es5sFAdI0NJWCJkD5Ux9mvT7nCf6
         2fhRtbPmKwEekaUQveNwQPy36Tt5wnnvDwlI6ZCGkn3oYus0jBNYz++/QHSkMsc/X+k7
         oP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909623; x=1783514423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EjquPjnSxlH1NouQC11hdL93bCB5PiSU+rHY36k2irI=;
        b=MTpYKfZuTUaTzh7HZWEG3gAsGSBcVYpv9t4inOAJWQ+RYRa2KYW4Sy0gSB+K2gfexU
         XnngSsFWlhhDG8MIXat2LR/eI8MfBi7Hmi9dJ24RfGAbM4sVvaO+jZBZJd6eK171nB72
         gyEFV3XtlhHIclzotHD4YMFJFyqZmtmZj/AHPWoz+XxVNDvrbOPz8q5r+OLC1a6h/OGQ
         kS9ERvJAi6KFpl78tJYvJSrZDnGCJGQasVqPXz8glwzETgr4NNtZi0Qb60wyQ+jP3QST
         DPx/BRI89xyt8o5CgUXyPTIFZox4/RXUxfmkK2wxRJyQw6S1jBojc1u0eCcPEY/pPXrh
         ugSw==
X-Gm-Message-State: AOJu0Yye7umWkQOjkrDWDjTzOz6mEsQxEaIulkW9bnAhV5G1fVeFjuFt
	0mo+UQvR/YukG0C8CN6CFoy7Zdr0ChEDl6btHBDO7y+wahs/fQA1wgmS3BfxgjXFOTtOgBUUF88
	m5+Zg
X-Gm-Gg: AfdE7clADuQnjK0g9QyPpbo5RreX4X+SElzV6CRiMaf5d0BJEx3YYoVy4aH2zIYx/5b
	V+p/A0z5qL1aMIorq++EOpV4qftYF2xvh+BS069ISx6UJrq9kbkid1P0PeHyWatmFpmnLw8CXa8
	/UWfw3B0pUlB8gfz/lqNuwZAYysvRikp6X/heO4MDRtwjyCpphk7Rl1jloRobwooIbXDXMK00Lw
	kTawUzgaOptWsx+ss0k94z5PnEI6wK/+dBvjiCytekMEkgBAVzSUJbgK1qtPh2FoXxj7wenBVc2
	B4eP6H+zKyiSWcudcldV1ORYyAICnMoYevJzK65hnyWIexIE/WKruLof3Mmo/1eAH7aR77TCXF0
	pFHCviCrVqt7ZdHn/MoQtdf3MicctHWEFekmkeW/uCwa4J/P9HAMpm6+Jio/mh3rEcask5krVXB
	PXRvyj/31pC2H354J3IzadHw==
X-Received: by 2002:a05:600c:350f:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-493c2b6e607mr24274435e9.19.1782909622677;
        Wed, 01 Jul 2026 05:40:22 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4da247sm71146375e9.7.2026.07.01.05.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:40:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v3 1/3] RDMA/uverbs: Add SRQ buffer UMEM attribute
Date: Wed,  1 Jul 2026 14:40:13 +0200
Message-ID: <20260701124015.64350-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701124015.64350-1-jiri@resnulli.us>
References: <20260701124015.64350-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22645-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid,resnulli.us:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C11656EDFEF

From: Jiri Pirko <jiri@nvidia.com>

Apply the per-attribute UMEM model to the SRQ create method. Add an
optional UMEM attribute that backs the SRQ WQE buffer, so userspace can
supply it as either a VA or a dma-buf through a single descriptor,
consistent with the CQ and QP create methods.

mlx5 is the only driver that pins an SRQ WQE buffer via umem; it maps a
single ucmd->buf_addr region through this attribute. No other driver
implements a user SRQ buffer, so none of them use the attribute.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_srq.c | 2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_srq.c b/drivers/infiniband/core/uverbs_std_types_srq.c
index e5513f828bdc..0421bdd225df 100644
--- a/drivers/infiniband/core/uverbs_std_types_srq.c
+++ b/drivers/infiniband/core/uverbs_std_types_srq.c
@@ -192,6 +192,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_SRQ_DESTROY)(
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 839835bd4b23..1fef1e86b302 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -189,6 +189,7 @@ enum uverbs_attrs_create_srq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR,
 	UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE,
 	UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
+	UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_srq_cmd_attr_ids {
-- 
2.54.0


