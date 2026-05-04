Return-Path: <linux-rdma+bounces-19926-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBeGOL+m+GnQxQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19926-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05D4BE593
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6D6305582A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CF43DE42F;
	Mon,  4 May 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="HXxx1+Yj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636253DE423
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903080; cv=none; b=ODvTVq1GCuWgQy91vyIwHfg0NnL0pWZMaDrIt0E7+g/y6jITSqi+XE47BXRdVq9AKL0b1i+P/cY5y8pzdNK+f2MKucN9EuB3pt5avFUYMimB5nKJCRNXsCnQt2/2tE2Ok0yh94qb61Pf2gOj+GNIe7S1SKRz1RQAq3/IWZzjr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903080; c=relaxed/simple;
	bh=rKoudYG4ZFZBYsazazBODGyKDIU2PtKwggK5yTTQy50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2SqiJ1DR3zqQV3+7ciQT4Jtcnd12ATr0ixfFJBnlLNijBcuiAgOX9AOKGDkeMkejmy4JXXyDg0EAjJF49o/fV999QHkWaxdEj+mMzMjht3vhKCpS4JMUIlyZe0I+xjgoiKRvHcvEvHu7X85rE2cRwF957TKrCRoiQtMejAF/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=HXxx1+Yj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso34419935e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903077; x=1778507877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKdXVB2G4F0HIS73eicCKD9fJgbhr2V8cKaC6AryIEc=;
        b=HXxx1+YjMRMqLh/8RHo5r0U37Os6z5xQFWsb2UFO6SdfUht4gw8wWv9/Mjd544aeoQ
         tYSZC+noZ5wWMxMh7vFCClvt/QtNBVuQROXRZOHYRRmlTo6C6CFvqbMBl8a+N/XrC58i
         r8K6DE5IOl1I8ens4EgYdWKJoqE4pC6le4z+2UiB5ocxuzvHXGj3hv2IF4RWp6ma4/K2
         UlWmlMnwaUoG4Jxymfkym8Am2oDXSSan4csfWhsGcIn91bgxXfi4uVDXG8hl6VRHw8Oq
         ClP6m6sUZho22VOJCmyxGBI+ZNIKIVsvt1xs53/sbOgQ6nWhff451O2qEh3VaiDoiolu
         eIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903077; x=1778507877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VKdXVB2G4F0HIS73eicCKD9fJgbhr2V8cKaC6AryIEc=;
        b=I2cAqArQ7wgQ4lI9a2iRFbhqfpULFRJdQQdUrpyBkMph4WSphd6LlyMkuddlqyDBsq
         ArSEjCSQkZN33k4TPyGMYKtGe7Tujwln9oaC5nnVeWbHq4nQgY5HnCLKwH9CSbWnYdEG
         L3mKCeb5HRtXyurpe5VRvTdqSkwWHhHrfah0xp2sy3tMRhgPFqUdstKOtm8U74rdyDSP
         3t3gaJrXF7YDk2ah0lf6nttyBDEvfJwW12yPObavL7tKGQVnKYMlJjTP+FEqcPHH1srW
         Oy2IG2Dnn1h3aoBzADlR5eUi0oQ1MsbnCLlvN2FgJrmiD6yRmp3GiG3dTTsLEht/IxBI
         M37g==
X-Gm-Message-State: AOJu0YzvuWoIee1BXKc9qjZAc5R3VodVeLkfZJqbeopiGLR6kI4+hPFr
	2OI4vyPlroZjyg1Tt/wKRMFCsIt8LhexWvW7lY6yfDQhsbCqKIpsOwhtt3WadaL2XHegUYb/Ux/
	g7dVaxD0=
X-Gm-Gg: AeBDieuTMvOqhALYzSw53fnEiFywc//As66Foj1+RR++3krk/3alcFXl9Z6uyzqP3Sy
	jslv+DZTuJrbJWk4dVABbyBKkpNOn61PA/T7NtDWtoNOykzs+aLrPxGlosUHKtSJq59EWZgpU2Z
	JKWUxPtlk7KckXSfIVZQFrI4OM082JEBzeGW0yPNQt6N6QNfD6Z/0GJpJLzkWvj0ruAK7zmfInZ
	TikHEkNQ+SM3e6RbOPRRYoVTMo8rHsu8b8pX4VDj1vDEnxb/AV5jqg5fqetNfJSuDNC86iYEqBE
	cwEhXn6rHy0SnkWXec1xhiGMOTCpabP7IMNijoPOUu/bGBhqJ+boJpwIPmGu/WAbAals9ZC8pmO
	2OH8rMMC5woMucGGYFmQiOmZvYaBTAbdlEADtrI8WCExNyXXlIdjR54DKn6V0Y7ZTi5jO17Qc5P
	o69vmvZeFNJhzcmW1KsLLZY/a1
X-Received: by 2002:a05:600c:c08a:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48a9852c5fbmr134420245e9.1.1777903076811;
        Mon, 04 May 2026 06:57:56 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c3422sm303472795e9.8.2026.05.04.06.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:55 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v3 13/17] RDMA/uverbs: Use UMEM attributes for QP creation
Date: Mon,  4 May 2026 15:57:27 +0200
Message-ID: <20260504135731.2345383-14-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F05D4BE593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19926-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]

From: Jiri Pirko <jiri@nvidia.com>

Apply the per-attribute UMEM model to the QP create method. Add
optional UMEM attributes for the whole-QP, RQ, and SQ buffers
that drivers pick from.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- replaced the array-form UVERBS_ATTR_BUFFERS attribute and its
  uverbs_buf_qp_slots enum with per-attribute UMEM attrs
- dropped qp->umem_list field, handler allocation, write-path NULL
  arg, and the umem_list parameter on ib_create_qp_user()
v1->v2:
- fixed umem_list double free
---
 drivers/infiniband/core/uverbs_std_types_qp.c | 6 ++++++
 include/uapi/rdma/ib_user_ioctl_cmds.h        | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_qp.c b/drivers/infiniband/core/uverbs_std_types_qp.c
index be0730e8509e..e44974abc6b5 100644
--- a/drivers/infiniband/core/uverbs_std_types_qp.c
+++ b/drivers/infiniband/core/uverbs_std_types_qp.c
@@ -340,6 +340,12 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_MANDATORY),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_BUF_UMEM,
+			 UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM,
+			 UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_QP_DESTROY)(
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 02835b7fd76d..839835bd4b23 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -159,6 +159,9 @@ enum uverbs_attrs_create_qp_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_QP_EVENT_FD,
 	UVERBS_ATTR_CREATE_QP_RESP_CAP,
 	UVERBS_ATTR_CREATE_QP_RESP_QP_NUM,
+	UVERBS_ATTR_CREATE_QP_BUF_UMEM,
+	UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM,
+	UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_qp_cmd_attr_ids {
-- 
2.53.0


