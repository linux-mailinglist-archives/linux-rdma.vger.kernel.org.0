Return-Path: <linux-rdma+bounces-21382-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BjpCJMlF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21382-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D75E831C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE2F305A86A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36C044CADF;
	Wed, 27 May 2026 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="zJJ8N9bP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F044BCAC
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901802; cv=none; b=leD1Oa1FoB+GiY7jSdacV/3g2jL94b3IG00lKc0o3Sbw/OsZ6mNfhb5WQFTNRWFARpw/nH73rypCSSupoc4RzLOQx5NCR97nEamvO4aC9OdjVgKa/5gctyUdzG/BWJCI/9K4K5hy0gX/CDqpWUvA+VTed+q3DXpw26P5VfL9iF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901802; c=relaxed/simple;
	bh=CdHNvdVyWwn4B7PYsPkfFQFpo97DkDkDhNP32go/344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eORrKupp9zJkvLci3GRY9l9GIFU9th70D7KDKPh9hyZMqbZ7Y3pLrlTzfAAjAu9p/QeRMKxiEhCqb5ZnRdV7+JtCtLRV+mbzsLft0WcuYl9Yvb00j3t8ojsMRCAEkGnobPQa5cnuJdHRidZraD8sBeNu3N7HT9brhn+7idJ/2dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=zJJ8N9bP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45e7c636e74so6382933f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901799; x=1780506599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=zJJ8N9bPFCWlcQXkm0+EeVwnOMYYxbGpyG0HgtrV5qGGv7Sgp2XZaTTs0ZM2dQJUci
         Xu4Sos3UEd6YGAqJQbMx71l6IrGLYXzQecT63JXq5i3r8cN5UWj/Eucoh0Y3cCUD1llA
         wb6vzgQMzJNKAEkwVOtJCGSNic+jSTDCOOw84l0H4vbHy6nisvQ4ipN9JgwlBIOgOEEM
         IwzLibZNSQMwTXHPV2Jg6o7DlDlXNVbTH4rmrn7HZIwVnYTaEEMWRyiN103iQRdgfTJB
         KHK95cCVGUpUEoAsO3xJIwmH/uABeYrtuBV19rS8bjX5wsAUPRyWzRafzgbEbpUg1XUk
         UIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901799; x=1780506599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=Py+hYb2EPfsivFzUnqDH1kg0GkiceKS+AmyzeM6gegd3ZQdmfiforsuPEacT7YDkr6
         so2hzVyXelG0mJKHgL62vQD4uek0DyXumgRXoVmjCaiBk+8Tw9CjEm642FOZKHuoykF/
         oBZCrXyT/d2jd3mKPk+kx7iWIlmMBw+dVDjsvFFhk+ecH++pGdeTbssvRcpIUmcTA+0d
         uerNiG+apT4/jQvR83w2m2ZPD4CtgF9tIqWtBNvvJI+jVk8oEnquzCuqxl7bUtx5n0wx
         4+kV3iRAhuQ95TLABG/1Bl0voX71phuXf9zfowaeg/i22UrurUtDF1nt4Hp3214bCfE8
         sm/w==
X-Gm-Message-State: AOJu0Yy1QDiL3TcCvMAGpKjBFQeKqKf+Eqgd7XzgXUOgZN6mKAe9OTLp
	KbaWfqk2/XK/s0rcTBumUJhDVviKetEYCHM6CojNPMuK8RrXXwweZjx8BHiryxmM2uUvJkFCUAY
	7yD4NZ4ne4Q==
X-Gm-Gg: Acq92OGSVB3+ZHEV0WNQUWWuDaVgvDF5GH8nmmC2iUANhCI6DilaIJm6Mi7ejsg0kt4
	BzJAiwJlg8FK2U6uQSixYu2pGFMa79QENN9ButsUNvLn4DBsebWNOxYUPmGNLzwhegGTbX01jhA
	1JYLhUCAhPuQ373WMXTxl+flDz+xf1o2vRjxgromuKOcVQvx0KSNNq7vJDJk1ciUCS7C9AU4+XG
	pPHzkkMKslbz6hoVn7jvckijk53BNh2TsTbydW8+6UQBSvjoAWT0E189LfzAi36sklpJkGSrpg/
	JlKw7ZIUY/owldf9EQZA6Guy6D3yYlnQ2g2fkmZ1CduJUVbxnerjfTqCrvRWhwjbjtkQMGmpyie
	zbebUfWf9eVJXn5zGn29oaoVOEhui1dEoFGxVMTtI2KrTumVyi552HCgEF6/TDhFgmRNQ51pXer
	Qd8q/a0YYYDxwgrZM0Xg1K2xyzNQunIsGdpxipcpAWBg==
X-Received: by 2002:a05:6000:1acb:b0:45e:a225:6dfe with SMTP id ffacd0b85a97d-45eb38a64e2mr45776447f8f.25.1779901798821;
        Wed, 27 May 2026 10:09:58 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a28casm10547644f8f.23.2026.05.27.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:09:58 -0700 (PDT)
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
	selvin.xavier@broadcom.com,
	jmoroni@google.com
Subject: [PATCH rdma-next v8 02/15] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Wed, 27 May 2026 19:09:35 +0200
Message-ID: <20260527170948.2017439-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527170948.2017439-1-jiri@resnulli.us>
References: <20260527170948.2017439-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21382-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE3D75E831C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

The follow-up patch is going to introduce ib_umem_get_desc(),
the canonical desc-to-umem helper, which needs to pin a userspace VA
without going through the exported ib_umem_get_va() helper so later on
ib_umem_get_va() would use the ib_umem_get_desc() flow too.

Move the existing ib_umem_get_va() to a static __ib_umem_get_va()
and have ib_umem_get_va() as a thin wrapper that calls it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index b253090bb1ab..0056f23af57b 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -153,16 +153,9 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 }
 EXPORT_SYMBOL(ib_umem_find_best_pgsz);
 
-/**
- * ib_umem_get_va - Pin and DMA map userspace memory.
- *
- * @device: IB device to connect UMEM
- * @addr: userspace virtual address to start at
- * @size: length of region to pin
- * @access: IB_ACCESS_xxx flags for memory being pinned
- */
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access)
+static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
+					unsigned long addr, size_t size,
+					int access)
 {
 	struct ib_umem *umem;
 	struct page **page_list;
@@ -275,6 +268,20 @@ struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
 	}
 	return ret ? ERR_PTR(ret) : umem;
 }
+
+/**
+ * ib_umem_get_va - Pin and DMA map userspace memory.
+ *
+ * @device: IB device to connect UMEM
+ * @addr: userspace virtual address to start at
+ * @size: length of region to pin
+ * @access: IB_ACCESS_xxx flags for memory being pinned
+ */
+struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
+			       size_t size, int access)
+{
+	return __ib_umem_get_va(device, addr, size, access);
+}
 EXPORT_SYMBOL(ib_umem_get_va);
 
 /**
-- 
2.54.0


