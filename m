Return-Path: <linux-rdma+bounces-19984-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHxRHz6K+Wnh9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-19984-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 08:12:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC00A4C71A8
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 08:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A8D530071F1
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 06:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235EF3C9EFB;
	Tue,  5 May 2026 06:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="MY9hub9d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199F3C7DF0
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777961518; cv=none; b=YNpuTQ5DNYXMZv/Y3OgseOODDSAeGrI0AaZV8X30IHt33X0C2yALBLH0GBwQTLtNzyaBvRhfESOkPkZvAA0nyyvcP1PI4arHEazKisnID5EXGUOtkHNjeupnXFfteZ1/Qnd+FT3eYRbM52+ApJg6rFiqClfb8kkBjg+8I44mJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777961518; c=relaxed/simple;
	bh=1fDy67ZIt+76U7ELVPRK6oH0sf4xFnIRSwmuu1Y1qGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePyd/JK5MPyyf1VBNezxTT1uunABLfcfBSJw0S071WUgD2Pg1TrVPo31fHlbv7iOqcixCzpSG3tfYnKkTc5GvAozNHZ63Q9NI1NpnllXdR3jN5H2x158VneN8rSP+VoHiagf26ehQytwIWiN9LhTcjnbrcM8+i9FsvRS449PMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=MY9hub9d; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0046078so40498645e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 23:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777961513; x=1778566313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFZnVBw74yDv2rII7+QCgPiDcxwzQQhR7d5tsxCR0Dk=;
        b=MY9hub9dwF5mY0+7Tq89f2bw95ePJfL1YnVGYkwwN/IpLBPR0HNfu6e/Gzt4hGiWkM
         6ItcPQlB8m8+0JichddQiGjkrNbM04ZrXqx9R+Pqs63lkXS/6BzJQpoY36bDDeAMBqY7
         xyEBN3tX6S4A++n/7mcmTFv3NNkOQy7KeFf9uxcjavS9E3zDMMx/uITPBv8K7uXIWueP
         VQO547sNd0wBpBqu8ON+jMgHboE5Z/D1gOINT+DB9FAlGhWTt5QnTlb1Wu9kIKy956zu
         p9JC2/bI9d0rGFAg+Z5y6tdrSnvHcWXFnKI4QtiKDxopflGq03D/05YV4o4QzzRpT0Kp
         MrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777961513; x=1778566313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFZnVBw74yDv2rII7+QCgPiDcxwzQQhR7d5tsxCR0Dk=;
        b=hD+8Wtxz+j/UT2s+u52lJxNq8HO8V4FTlrGxY8Sjg1jHmr8Ror8jf86b3etKBErbCP
         1AwrKd4fvT15NmILjo6IVmDYeHBoa2D6IdHEYLVRBwT8DxaWaLHZkwlk4WL5dGGd2xCS
         3SlKVUYMqahNXxfwEpXhWu5LQPOallu3QbCSk9pHvLVn1f+Re4JcMyYSK4tqYS5AwMHl
         fCuc9U6p7C3XhxPGQUw8ugvq4MQSq+HP45i+4QnXH8BIvdjo9B/Xs4DAk7mS4K6t1gzk
         NVgmZG6tl7wtohK2jnCj8ZhX+4+bWztd3aminProK8kSjLY9KsPLDMVwWTv9fqoNDqlx
         Y3Qw==
X-Gm-Message-State: AOJu0YwIGDMPnd481CarkdKPP6cM/I8tVYFn8n1j2+p2W2qL8X+oOxkO
	rdaA9COy3IzOD9GVsysTCCeSFpyk/7fQJoSJHleoinU27eaVRT/Vkm6EOpFV3M+eQp7vfPOPhYp
	9FmhC
X-Gm-Gg: AeBDietM32e9INIhl1G+ctMDk8Q83n1lN1M7JNy5Yl0+LRod32oGoWo5r/KcM+pTMr8
	RXpDE03RN+oAJVgjLAJ54Y1+Uu9pcoiyvT9ZOli4HTHaUK2vJhKx0Vg5dHR1IaLIq3yEZfrpF+z
	VsqvMVZsE9NEbO8YkvNaeaETXEXMSBeoNIv/DxTW25/WBoKwVRCZyku3T1pRW0HiKLErK4M7Hud
	kxYwFqo8burmCCLSbuA8D6CNvX/cpASO2iTA8zy3YyimX+/VFbgxg2bVNPz08AWaSZN2MB1joGW
	IGXwbZmwJG/M4tSGQ7zy5DtxdXBO4m8JPg0g1mFNPs3gSKlTW9wuowoMio3YyA+BYVeX5q38Rxe
	QF+DVwu0vQsPe86zbF5LOXCEgvFYOCVoTK6JOpUUgNKT7bS2e9hUpu+WAdOftWdRWRgx/LAWwwy
	WzyydGe8iye+gxegTFPUBFZYnjH0sXewA1Mu3QpjiMrLvSN5iNGfk/O7Jl
X-Received: by 2002:a05:600c:c058:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-48a9866f1f4mr153503405e9.25.1777961513158;
        Mon, 04 May 2026 23:11:53 -0700 (PDT)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm357926655e9.15.2026.05.04.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:11:51 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	edwards@nvidia.com,
	kees@kernel.org,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yishaih@nvidia.com,
	lirongqing@baidu.com,
	huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn
Subject: [PATCH rdma-next 0/2] RDMA: detect and handle CoCo DMA bounce buffering
Date: Tue,  5 May 2026 08:11:47 +0200
Message-ID: <20260505061149.2361536-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC00A4C71A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-19984-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Jiri Pirko <jiri@nvidia.com>

In Confidential Computing (CoCo) guests, the DMA mapping layer
redirects all device DMA through swiotlb bounce buffers to keep guest
memory encrypted. This is transparent for regular devices because the
CPU copies data between the bounce buffer and the real buffer on every
DMA map/unmap cycle.

RDMA breaks this model. Once a memory region is registered, the device
accesses the underlying pages directly for an extended period without
CPU involvement. The swiotlb layer never gets a chance to synchronize,
so the device operates on bounce buffer memory while the application
works with its own pages - the two never see each other's updates.

This series adds detection and handling of this condition. A new
IB_UVERBS_DEVICE_CC_DMA_BOUNCE flag is exposed in device_cap_flags_ex
so userspace libraries can detect the situation and switch to
dmabuf-based memory registration using "system_cc_shared" heap
where available. Plain __ib_umem_get_va() is made to fail early with
-EOPNOTSUPP to prevent silent misfunction.

---
based on top of:
https://lore.kernel.org/all/20260504135731.2345383-1-jiri@resnulli.us/

Jiri Pirko (2):
  RDMA/uverbs: expose CoCo DMA bounce requirement to userspace
  RDMA/umem: block plain userspace memory registration under CoCo bounce

 drivers/infiniband/core/device.c     | 6 ++++++
 drivers/infiniband/core/umem.c       | 3 +++
 drivers/infiniband/core/uverbs_cmd.c | 2 ++
 include/rdma/ib_verbs.h              | 3 +++
 include/uapi/rdma/ib_user_verbs.h    | 2 ++
 5 files changed, 16 insertions(+)

-- 
2.53.0


