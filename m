Return-Path: <linux-rdma+bounces-22120-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TI08MSrRKmrhxQMAu9opvQ
	(envelope-from <linux-rdma+bounces-22120-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B64672FD7
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 17:15:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=ErFA6y33;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22120-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22120-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13CFA30D82AE
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA183F8EDF;
	Thu, 11 Jun 2026 15:12:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE73F39FD
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 15:12:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190772; cv=none; b=cRKjncn63zwFUmREmcWVvMyeJJlEkghzrdTK05XhqMbTZyjO9WuzpZx8E6N+EWh0fndEhHtMdZbSQAoGYs8p8LEs/GDXLTWb1sedNRU0Ku1HzQ21XmvAt88Rdeo9l0BCJOu/ZoPZwczfCdvZp9hT1A9NRmpCAncnqWko9fe/heE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190772; c=relaxed/simple;
	bh=rFToR0OJiEw5Zn1LbSBKY5mtue5T1c+WEeJGU2OQOeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7z7yx5CvFX6Zsdmn6X5Yk6aPtLYsAAVQV12wtRXbaWOz7MPe8SoSUq/V1ONDYKrTJ9g2P77LlJ4VHeCmAWAmkjTPU/lnXwDTd/4cv6ErchdSz8F7Lghzu0TSxUYwgn5bKfehB8dg+empf3CR4GheZ4c8dDz+nwFVBH4M/PZCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ErFA6y33; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so6417441f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2026 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781190769; x=1781795569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBWHE2g3f8nK9dhNsa1t+Ue9WjpSgZ3MwHYKO3zrcZI=;
        b=ErFA6y33qjrEiN0OW95YhJByE6NdD9wO3xL4OhzHjE4fwCTWrWEgadwO2+R901vZjc
         fgaIVvJ9K1jRMArHYHJCWqCRelwiJtEzcWi7ecKhsoxJUmLTDZtwMKyavnJ8q2Ag1eWo
         ZdMJjqnaaZ2ma9S9v7H/9KAJX+/pTEK9lQsEmH/4Zxeura3gg2m1JhCKYfnt0l1PThtF
         7ZuJHrckhKALNjAS7w+F38vZlJRpBjefABKUXfqxo5BVAtusN12i3NZsZtM8yXgvsLUr
         S5INoTrtcXBnvr4N3sAk4bdMl3Zf3LwrimnYvk1SMFHuU2TWwVWR/UWDkciXVeEqHXeE
         Zg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190769; x=1781795569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NBWHE2g3f8nK9dhNsa1t+Ue9WjpSgZ3MwHYKO3zrcZI=;
        b=G3UiY7+C90VDAwHfAXKnuSMJE611LxVA4Uc70PHfp1rBnJ8oiAn6aGndqMz5K0oijv
         8J5QBB6KZw9pvl2KR7CdWX4vZHsjNxH1tv2wL6evzNTzGJ3EvSLYG9Op+pKPzTwTDGQQ
         iRGsvSI/uCy5x/pbmh2+Wy9METQIJgB2b7zsgdisKvBNowvBECH9ZTZv1bH2tfzFy28k
         dCxteotX29Sfj91ja3f2JPk66JVaOBAQm9QsQV0YAONerJ6KpFzBtPqspdXGGO9eGEC/
         TxYCRhYDdDZbY9GDYburv8umL+zJJfNF45uHSz3OPNktvNBDsmYtdA8yi1NM6gEeru2d
         HruA==
X-Gm-Message-State: AOJu0YzEDuPoVo+PehuE++Q2BjOORjXve1n5gRdraG6hNv5oamkt3hJp
	O4TG5Gi5ei29OiVUAGPOJxbVOvgiz5ecEIMdo+gKQKR7jNVo+TO33M3T7Gs5I2fWs+mignRGcV9
	MibzsGc/YhA==
X-Gm-Gg: Acq92OHlYVI53TW74kU2Sn0ODBjZeJEG3QTBUErj9waIPnCxgKHp0Hsf7gb2vfcO59s
	WF92/+HQoO91vJYJO1mOJDsaCLzel4CGyOaKRuqPo1bLxbYOfjCtK4du/gLsLWFqHDP7PNBNTB6
	UifnifRf7YyV+N9iFBrq3H7pvQx6iK39Galrunhl2RVJOHQk83C1HB8xhtCKMCkTyA8qTzXA7Ui
	CcB6qoeMQR7mqj+ogdAmM/oKuZKL4uQqNcDh3mX45F9+rQ/BpSTGvTJ+0+cdaSSgZbQ0D4DteDX
	PKIaDIjpk6XiDmG9o80EFt4qhY5TlSNIKIjM8qmMhhv2lc7w7pYjPYPS6TG9ewj+OEvKUQVi+5K
	IgZQTIsOsNn93hrmImDKWuHpniuc4RHgSQ9isbeCzZkAztrqS28NrSe0XPxXvrnPyg7VWS5/7uF
	2RBfckTeWgAhjnO/D4+XxLrbL+5abVcbNOA17SIsotYko=
X-Received: by 2002:a05:6000:1841:b0:45e:ea68:523b with SMTP id ffacd0b85a97d-46067598d52mr5479740f8f.10.1781190768834;
        Thu, 11 Jun 2026 08:12:48 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ed944sm84321615f8f.13.2026.06.11.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:12:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	sfual@cse.ust.hk
Subject: [PATCH rdma-next 5/6] RDMA/uverbs: Add CQ resize buffer UMEM attribute
Date: Thu, 11 Jun 2026 17:12:28 +0200
Message-ID: <20260611151229.879514-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611151229.879514-1-jiri@resnulli.us>
References: <20260611151229.879514-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,m:sfual@cse.ust.hk,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22120-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,resnulli.us:mid,resnulli.us:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26B64672FD7

From: Jiri Pirko <jiri@nvidia.com>

Add an optional UMEM attribute to the CQ resize method that backs the
resized CQ buffer, so userspace can supply it as either a VA or a
dma-buf through a single descriptor, consistent with the CQ and QP
create methods.

mlx5 is the only driver that pins a resized CQ buffer via umem; it maps
a single ucmd->buf_addr region through this attribute.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index 43530e55f128..62af4f64b7ad 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -269,6 +269,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_RESIZE_CQ_RESP_CQE,
 			    UVERBS_ATTR_TYPE(u32),
 			    UA_MANDATORY),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_RESIZE_CQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 DECLARE_UVERBS_NAMED_OBJECT(
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 5d2451a03a83..7cab5daefe63 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -129,6 +129,7 @@ enum uverbs_attrs_resize_cq_cmd_attr_ids {
 	UVERBS_ATTR_RESIZE_CQ_HANDLE,
 	UVERBS_ATTR_RESIZE_CQ_CQE,
 	UVERBS_ATTR_RESIZE_CQ_RESP_CQE,
+	UVERBS_ATTR_RESIZE_CQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_create_flow_action_esp {
-- 
2.54.0


