Return-Path: <linux-rdma+bounces-16421-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGKwEPq2gWkrJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16421-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A34D6633
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0DA30683BB
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99256396B78;
	Tue,  3 Feb 2026 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oesit4o8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA4392C4C
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108611; cv=none; b=HvsTckDE98stjGuei7KHQxzjyNUhbRAkdMgQyhtYb3n8NTtz/NiBfDA3voBIi6v9QBX9ywftV2CDB+cxrvK3r7ogIybnzvTuOI1gAGo0+5Dew2qJpmb4CJ6EIqjKcdk4Uv98qkHeDdOqz39hWxJisPNWwytNaBfzlDa7mfk1+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108611; c=relaxed/simple;
	bh=PhCvHDBf95uAz57zOAFrQzzUSh3AaEVLZtfa7sxzWvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRRmeUahh8CY/+nUAqoal6xUlmGqavpNvTHzK40kjQlvMLZhpb2hbdCfrqKcmUAuCEr422L0TevquM6z4bZS1nZXe4z2gaGi3wOecKNqMJ0KytPf1r/wc33Um/X/uHuwEaOTPSDEosLEls8V03LlrQq44Ilxr0KssrP5C7Q16FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oesit4o8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so51186305e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108607; x=1770713407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKzM9HHAq0N7uieF/b9yTpe1BafS725m2R/55nIoDIk=;
        b=oesit4o8d92E/R60SQyAw3aN/3rlVMs3JcG2bkQrMsX1njUIqKDWDZtzAUcA/KIsky
         rbUP7aq6lPLd50o5CdVdYNnYo1LCgKf1S0f+66kwBjp2CtqCR1Jit+LcQ5Sc1B5SPObj
         xqLd3dfkv6qIaIJ9LHUCpkmRFKyxTLQKqYRXUBC5d07lD6lRST5lGvgWh0CD7rwQKPyW
         uIM8xTW77vzVVFSnPas3RFNZce0j+EHWVmZps+Cz8WVTxXaiO2vAkJUh42ZInxlthZN9
         +b9U9+mFh+zTbBDKRvIhj1c+JRnfGuxpXQyAAIrpb5DybEyPDgCGarln/1BCJPNXxVX3
         h2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108607; x=1770713407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKzM9HHAq0N7uieF/b9yTpe1BafS725m2R/55nIoDIk=;
        b=KxlFodf5SJWnwjEvDf8JSrE7e4gIASO8PyXlKYiVeZ8GSD4/lPbVUBG4fMo1m3ynvd
         uD1wlrHi2PqxKXFu8oV3X29ESU0jM5hI2rCGhbCm2E9xrI8C0HzayNNir7KJgDfcnIOf
         EYlHH1BDH21wPoyHoYpPjjmRrH7piguzMMP6DZTk+im/reaHnvn74xaD9Gd3NfE9kdBd
         BWEUpxw1kuulr+jn6wTshrYT+Vt1aMBhg5WaiY2uaH+UghW6PL4BiMphYG+LQIVsMIjm
         GEVDt0KRRaUfGc60vWgBl+MvZoobfT+FfG5kFW1mH9GYKyO4v7GI93dMj/XcNNxsdf35
         tLIA==
X-Gm-Message-State: AOJu0YzsXH8c6waG5R8cn7wR3TjJx4GH2G5HUKAiDAfIsGaWWWb38xJo
	B7CxREWOakexo0A2ETVU9Q0I1I5IYRJDqaFy64Ew5dDkbNyPXmIoj2DEZLrcsQN9MsaP5f/83To
	dffCA
X-Gm-Gg: AZuq6aKKprQXpvGnJtteDJEMmVwsmSSDFoo3Cvm4jDi+qktjpqv9uQ+wS1e/B4580Sg
	t9jTZkIB2frqb/e6qvFo59s1c1da1Lf/ijj8wXy9QM5iPLhF2lIY5JoR7rjV29E917xLMUncGon
	uNH5jVNSeMcMaRyncRXcNOHAEOeJTynU0P9I6dcySmdvZbjuCufEI7HdwfC2qh3I6MnQCRwDs8p
	Ub36A6vsa6EdM8OzgfacK40zAfcKQKJHBOOH7jiuEKIrvnOXK6uYl0ekg8x2VgNuglzH37dVTU6
	yT3KQj/2WLAd6CG8llkTuvfDHC7/PMRj3/X1iUzhDo1mTqQ9To0Qb2ryMqVxeoa+z2R6uyZLf0p
	AfoU0JMsk8SnRZqCOqFNhmZgJTqVROCnSXtlUZ/GG2yPhM728Ufmp/nH5jPuSCZ/WP6xi2r0KBD
	9fdQ==
X-Received: by 2002:a05:600c:8289:b0:480:32da:f338 with SMTP id 5b1f17b1804b1-482db45cb90mr185908475e9.14.1770108607402;
        Tue, 03 Feb 2026 00:50:07 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051247ebsm49633315e9.4.2026.02.03.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:06 -0800 (PST)
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
	wangliang74@huawei.com,
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
Subject: [PATCH rdma-next 02/10] RDMA/uverbs: Use umem refcounting for CQ creation with external buffer
Date: Tue,  3 Feb 2026 09:49:54 +0100
Message-ID: <20260203085003.71184-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16421-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B3A34D6633
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Adopt the new ib_umem refcounting model for create_cq_umem and
the only op implementation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: Ifad1447a9cd688554f2eed3d41e96d62fc28ed54
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 3 +++
 drivers/infiniband/hw/efa/efa_verbs.c         | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index fab5d914029d..380e4e4d6fb1 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -196,6 +196,9 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_free;
 
+	/* Driver took a reference, release ours */
+	ib_umem_release(umem);
+
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_add(&cq->res);
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 22d3e25c3b9d..aca48825cd71 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1225,6 +1225,7 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			goto err_out;
 		}
 
+		ib_umem_get_ref(umem);
 		cq->cpu_addr = NULL;
 		cq->dma_addr = ib_umem_start_dma_addr(umem);
 		cq->umem = umem;
@@ -1300,7 +1301,9 @@ int efa_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_destroy_cq:
 	efa_destroy_cq_idx(dev, cq->cq_idx);
 err_free_mapped:
-	if (!umem)
+	if (umem)
+		ib_umem_release(umem);
+	else
 		efa_free_mapped(dev, cq->cpu_addr, cq->dma_addr, cq->size,
 				DMA_FROM_DEVICE);
 err_out:
-- 
2.51.1


