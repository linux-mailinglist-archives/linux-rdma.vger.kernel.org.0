Return-Path: <linux-rdma+bounces-20843-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEveFgTNCWq2qAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20843-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:13:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8B56182C
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFEAB300C907
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DF2F531F;
	Sun, 17 May 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="tCIvdjha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5862405C32
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027200; cv=none; b=S3AytHbHJFJfkTwRyR+ZLHViB4cT9nD3isVr+bKhXTXGgJ/9FPBn7KXH3VYpiHZd0q/8l8Ec4FuGM7l2mg5Rt4yWMzObtx+0zsE9VcGIom4vXoSFSGQd9YoXEDGDUfj/23ApKCBlSs5q+qVrPcjGv6fQIze2wBkq/vf9b6G6B68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027200; c=relaxed/simple;
	bh=7Z2jQw1yVEAFTE/oIYhiiWYV3ZZ0CmIGLCrSAkPQMRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KBveFn+4O+U/ztHjL1JQlu2quQnj87252BihMEfUOLq0yHLexx0ruxXX1C9nH1SsoCDJi6Aqz1xqsuvcfnoOj9IEYMY5AdFC741TyVznxuRT0GqOUpfd+84CP+4Zvd4WUF5OF5uNEnXMil6UcMAEI9xN057tfRhMWi1PVW9az2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tCIvdjha; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso12715215e9.3
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 07:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779027196; x=1779631996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6cglMBbWtUxIRrcnLtmdyzOFZg1eNtjCOcIv3cTjD0=;
        b=tCIvdjhaSPEE7P9pKzncaFLPYGR9x+YSJrBpgGMKu2EEcCQpyV3R/24L5EWMsj3ZM0
         9lhmR9EF9SjuHqW8Wuwh4px6s9lr3WGtrAa9dS2YAZWBbAfMbZ8wF+3MnCrGb5+ONK3q
         +5SlP4yIFuBD/vpaiQphawuuxFSt3i/St1w7g40DgACQNHqdzadn6+NS4kuWD7Q6gdzZ
         sJvKeQhpszxKFhu13pEGPocxlNmFQbot6r5sQE5/64EFjYyQw+Wwxj2mX1/yYkmEndCi
         1uaRqIhUTh2tR71yf/1ZgsYU2HewGPLLg40y73latRPfhrNMiawpEo1nAKRtnI910d2X
         ASyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027196; x=1779631996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6cglMBbWtUxIRrcnLtmdyzOFZg1eNtjCOcIv3cTjD0=;
        b=JkTM7lTocHWYicX8eMOHE/rgXjULfHihwA8VezMYv6WUHSuNwLnefN1OPICsA5UZhX
         7O/07Co7wkU/zdL8H4qg1mH9tZ9MekAtRfA2OAaCvItKylSCMW4++t1bPZ9xjYZRt96Y
         wIQ7jZJK6iVZMRa/Hrpt8HE27nMx57nvgnDWfTL/Eq5UBtDKCvKQdwjDm/AbIpMLCidG
         Jp4ulo5CiG5m+CMmAOU2n+tJCKDZTRY4wt7msv3hdz0FfyUXF74HwZ+vE9Q5EFZ29QLk
         cn5chXCMnh8hUVEIAICicQSwwMIJ4J2PX+hGVBHb2OyK+VIUJHESrTcUlGAJHD5jH/h4
         O1nw==
X-Gm-Message-State: AOJu0YyG3sbOUPEnQC0P5VQW4bZMVtyA/Qq8fUGUKyIRsPGYsaF4lzY0
	JOqOXzte4RW4Lv35/QTctcUOdGzy2jIfK3V6dpqp+vkM+GCvPS8YIeHX/GNPANTF7iMkQl4VDkT
	+0VzF+b8cBj6BODA=
X-Gm-Gg: Acq92OEOCA6GlztuntV99SKIvXLGY8AoTUbmbs0n5xKYIn3JPDmxGm0UGcTtW6EBTEW
	XyqC9QZ17YNvf68MwvV8v9QE1LXPXHwhlGm/J/661PGyEU0f/aDqNyCCOArBr2JHUdmqCBa9QXB
	eEE+MUC1lN7AeH3AGepiRjFuozw4MgSXlmXiwQB/KEFH0CAJ/5kIA0FppIYJULdOQIStLp1bct3
	nCEV0F8ttZE9sNa/wxD2VGwObahuFl9NtxU76j6MF/0kqfrdwvyLX2DJWfRh1rGt+tH8qRxd7Zh
	SxYohILGG6X+M9QFqGHAlceg0J7HYyiNCTti6W96xjcGCUhB6mCia5NqTThuv8BCBcDcbz+WvV4
	RxAXv5kWHuMLlER3RkqEfAUTBV+iSH8w0GbtFRJ9Ufc8C3yTcJVCEV1C7fs2du7R2R0u1fRs92g
	BA00ePXu/Q3ZsKVXnrM8BsajeSmf70Sd+T+hKCnibrW6U5T9kQsKIW
X-Received: by 2002:a05:6000:1863:b0:441:1fa5:457f with SMTP id ffacd0b85a97d-45e5c5bf256mr16624335f8f.28.1779027195800;
        Sun, 17 May 2026 07:13:15 -0700 (PDT)
Received: from localhost ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm29945728f8f.16.2026.05.17.07.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:13:15 -0700 (PDT)
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
Subject: [PATCH rdma-next v3 0/2] RDMA: detect and handle CoCo DMA bounce buffering
Date: Sun, 17 May 2026 16:13:09 +0200
Message-ID: <20260517141311.2409230-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABA8B56182C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20843-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
where available. Plain ib_umem_get() is made to fail early with
-EOPNOTSUPP to prevent silent misfunction.

---
See individual patches for changelog.

v2: https://lore.kernel.org/all/20260506111447.2697789-1-jiri@resnulli.us/
v1: https://lore.kernel.org/all/20260505061149.2361536-1-jiri@resnulli.us/

based on top of:
https://lore.kernel.org/all/20260517063006.2200680-1-jiri@resnulli.us/

Jiri Pirko (2):
  RDMA/uverbs: expose CoCo DMA bounce requirement to userspace
  RDMA/umem: block plain userspace memory registration under CoCo bounce

 drivers/infiniband/core/device.c     | 9 +++++++++
 drivers/infiniband/core/umem.c       | 3 +++
 drivers/infiniband/core/uverbs_cmd.c | 2 ++
 include/rdma/ib_verbs.h              | 3 +++
 include/uapi/rdma/ib_user_verbs.h    | 2 ++
 5 files changed, 19 insertions(+)

-- 
2.54.0


