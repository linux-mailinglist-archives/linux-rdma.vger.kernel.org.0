Return-Path: <linux-rdma+bounces-20064-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNM1B8Ii+2lvWwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20064-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 13:15:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D14D9A41
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20D203015704
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC98C421A1B;
	Wed,  6 May 2026 11:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="cCkLHanh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1F13FE36A
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066092; cv=none; b=WQAgcbOBxkAi82aZ2rB6DLH8hcrQaCQycdyRDuMpYDs4WT/Duedg00azeUxQ0PpAm79QkVE+r2Mj/CeM9yP2TUAs++nbE52xTsWkAs5Bon63Qn29h8CCGKuDY6tDSJuCqI+TW3XO1YrpfgaZwt+cs1V4y40xltMZNk2Zh7SQ/r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066092; c=relaxed/simple;
	bh=kFCEoyk+Tha0rqERt7cXYy8pL1Nm/Nk/Mh9yrhm4FnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gk8j61RcQi4kIfPBLRRUmyKbHND7DCNnl0x6mLxB0ojXLSOvPMtUFXGt7oFY5AKaXQQZ6KUb0WgSqPyjzKc8K7X0qhk20j3/laDVDaNzRTDzz6ssIf7qoGOFEqhmiH8JNTkJjLXCgTj+Zn/t/ZLq0s/CK71hv0Z1AzUAIv+PPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=cCkLHanh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so509428f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778066089; x=1778670889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC7tM43MYRuiroJ3K1jb17xXNdXuvPOicAKqaPDyb5g=;
        b=cCkLHanheT4LEenqYeEhWQUgurS99Le7OWDIVitTagx/ldGLL0i7GH1ka7T9PR4dRe
         0CXqoHSJ70YleX+dOZrmabxabX8GLB7zeeTM64m8YZqikC/c8djnopLZiaKpcnWHaRrI
         WvZHdg/ngB0Fe9OVGk/PwgxgbC7UwxlI2+z1AAqbqHUw08n0Lpi3tnhJArSsrM+2DGpS
         Nw3u/4WJDs66NnMvT2kJpYPv+FZQwR4iNRDctfhz4UhwlmJpSJSP2TWC9AHRmpJ5LU/P
         fHkbrcss8zRreUH6gOnEjCqFIqtkh7HNHOGttCULvm6YAnn9U3Zml1ibgb4SGK03IkYQ
         RS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066089; x=1778670889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC7tM43MYRuiroJ3K1jb17xXNdXuvPOicAKqaPDyb5g=;
        b=fuOEzdVbxwVaPvNRgySelVRio3JIhHFYHtk5hLPSw3RsxAEEWNCY0MeW3qAUfgmMV4
         u7yOsNWY6Ih9cLkG3zWioYoho9cHrZPWs2RyTcJYpvPdvYQMjveXPUOh//StS5qy3y+2
         QRdujtFsbn7lN/7d6nJuWkhat3zg77bAUwQjqvpx5OJMAxTpSCQ3bsGlRiPaejnJlI0L
         gKI34RsHDw4ND5WJu+OHEQr67x/DR/TWWmEePjGXdxG9YsQsgr/GTIpYcrUPNNlvStyn
         9cBXRpP9NDJI4SltTSayj0QRMDbVlUuQ0rYqBpm2GKAWNp0JnFQg56ePJtgTDOWLh6uG
         6O7A==
X-Gm-Message-State: AOJu0Yx5PQ7/XHfqMRqNQTWDOx6zpBx0y6g6TrPJTjQv/st3eLNvX0ZV
	3lNGDvcEr8E/nftZAEW3blheQ1eLugjReBK2pFYLEdFlVqlondW06Q00WOvwVinlAQ+knsBJBIP
	CRRq7eYE=
X-Gm-Gg: AeBDietY1SNuv2bqv+ucALAgN2M2ugpTjIVgdiZ8XtSsaGJE01XBFWLEpUsLfIOFdcI
	wzrLfYs7F6BrMGopk2nHKydCfftjIygp1f1XvV1VZlBxOvNbKW1QlDAgc3gyhBiWWQ0agWm9NXu
	DbLw2dlea6grUdZN1anaXNAWNP8++f6tl9BV7OscmivfCG8JaOMFEnZYpMJPaLg/5XEqVwqWHc0
	EWNePiCKpAIYfGOlycalYTtERVjudb0d/EOcWw+pMiHRcUBD/Ut62Vhw2fW4UclRxQbrmJ4SvZr
	hB6Yxu/iSwVAEUXPT+LBRDDsFOE3pfL47OMYG8h/fYvnKRz09OtPuo6YAiummjgkiJWpV02+itg
	j9377e/o4UAO7nEuJReHhhDDlN80G/ZZZ2uzaq1V0+K8HwK5qV6F/KOHcE7UbNuXH8bbF4nkQAv
	H3z28a6US79mlxLEfPqDG/hlsd
X-Received: by 2002:a05:6000:40dc:b0:44f:da08:179a with SMTP id ffacd0b85a97d-45165d24154mr4628919f8f.16.1778066089142;
        Wed, 06 May 2026 04:14:49 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02f76sm11407486f8f.23.2026.05.06.04.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:14:48 -0700 (PDT)
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
	liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: [PATCH rdma-next v2 0/2] RDMA: detect and handle CoCo DMA bounce buffering
Date: Wed,  6 May 2026 13:14:45 +0200
Message-ID: <20260506111447.2697789-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 748D14D9A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20064-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
-EOPNOTSUPP to have more specific error code instead of existing -EIO
caused by DMA_ATTR_REQUIRE_COHERENT.

---
See individual patches for changelog.

v1: https://lore.kernel.org/all/20260505061149.2361536-1-jiri@resnulli.us/

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


