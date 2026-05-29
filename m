Return-Path: <linux-rdma+bounces-21504-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBvxLU6ZGWrVxggAu9opvQ
	(envelope-from <linux-rdma+bounces-21504-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE05603114
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0E530C0B24
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7933AD91;
	Fri, 29 May 2026 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="q+j+l/GV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B6330B09
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062212; cv=none; b=NCdDb1tJg3+2BT8MQNCoQAY1GaBrTAwnHrR0/xrq0JJUbe8hDdDa9pfYW5lljjwrrqCdeVCMWhcdLNUsplN6hDhEi/GAsxH0Pu4rBPAnO1OMCRdmHbBm12rVHRaauNoG29eYA7fNOdbzKnXE5ciVCezBvEoNZUgmRR+QkiaUHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062212; c=relaxed/simple;
	bh=0Kv3UPS6Yt+YKvnJ5UCVUo+PZ58lI3yz9w2NLBPoR/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSdLBHHgtrElSkhQvWyK9UbrlZBYOt9Qa8G5f4dpRicMzlw9AjxLyby1nqepe9OuV8U5u4AW5DIEX3MKfNaolQ7nOmYBbxZjq+irm2rTdaMhrr/VRsQYafKeJzoKGwXk0GCiew4u/9ryr3TfsO0Acw+YCajb5bTVvJyx6OtMndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=q+j+l/GV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49048e043e5so61386425e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1780062209; x=1780667009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGTqqVvbBJikoOBP547zOKHJKUDXjx/seK1tJdXLmL8=;
        b=q+j+l/GVN5MIRYt8wSt3PTzohpGU6F64mtQFUZAiw9TNlWQafB3GEyOmq8IqZSvczn
         MMNzbfgln4ZXN8blJMu+lnO9Y+0hUBGm/FPjaPkF9qLJ1Qjupag/sXNfHyJ2NSbMWn5l
         BZ8P5WRcBxJ6m31RvmoMqeznbsEX/oCoDzWQhJ/UFA7x6/r6kalTOtVNJcjmHZFVcG+6
         JolbhaLMlOeYqmr6IU2ozF7Qftx3snmUriZGPi1Pe44wcY4HaHKn8kZameS6/jC4zyXl
         15ukcmIeAS0nSMe33ZtSFWEeEy0qmf/y1nJdPu0a81z1Nu8+HSSYo3ClLGpc5wXO2M4P
         OoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062209; x=1780667009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gGTqqVvbBJikoOBP547zOKHJKUDXjx/seK1tJdXLmL8=;
        b=nxf72iVwqJu7FBcrAPStoPs/fD8aepJV/3QEMxCRrhkzOnGdCYwlz2GegzcjTAEkDX
         5HLLYvczPFUFnAorjLjLBUtlqTqZdRDT+DaqFTsrNoB166gHr00cYJsSKV3d3dxCbUxZ
         6IhhFk418ggWCXpEvmjg2QQ4UaFD6pJe3zDLbZEW6E6/KrcZX0RJAhtYtdJfnGoHCOvL
         G/n8cOcOxWdsSqGzIEHLx9kh/q4yLQLIi613L5nhNu7aIZnl263TLKURoXUmkvkHBLCG
         D42bGpBEeI79Qklk5dTQDkFCuinFYqLZvhlVbWR6AxmtN9t5TsAfMLj26Bki1ND2MrF/
         ZNwA==
X-Gm-Message-State: AOJu0YxR//Rg+J66f5bhiaH2tzmSzm112SPnsIs47+cDF0h9O8DcTexm
	LyJwNfDlpu7Hzk+mzeA/B85AsMQoL9VPg9TbXAN3/60Z/JcSgzO0xc+cy2k0sHJ4jQmeScK2Cbe
	zjs6ivOzoYQ==
X-Gm-Gg: Acq92OHN93Ldggr0xbL6uPeMCvYyb/X/dVymt5wLeHPG9HqbdQOgqehZ4IcB2tUvSn1
	Fh9l+t34Kw+3l4RTdfrMzjy3TWT9634FbLTsne0kenrWw9xcaHhlLx1Dzu2wvjV4J8yLLiY9aU/
	4Zxea4OYGG2lnqR944uBzx2vayOspBkd8KH4wt+6k2Mao3X6jc2VmpfBTCBAh1JZEd/Up8chMKa
	76N9X8X/+sUxv91zmg7IXHcOzXc4G/o4pyfJz+ftOX+Kb82Q8dM+XHiTVXccmCLaBfNyy+nncfC
	MtXfs7jZwc3EkNnBp55oZ0ijCPM/bHwU3aqD83eC6kNk0VrurrVRFommTSQp7UslCDrhrSiVkki
	k9bax24Rwgcp6lA+nK+dlaadVwKQpXeSKd6amM3fWs2+9iG1xD5sGQj2ggVT/93DBEMb/MFd0ac
	rVehmdrFTdZZD38B+o32m/f2atlTGnasFhBU+dLcGYZ4M=
X-Received: by 2002:a05:600c:1550:b0:490:846d:e2de with SMTP id 5b1f17b1804b1-4909c0bedc5mr56010355e9.28.1780062208996;
        Fri, 29 May 2026 06:43:28 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm64214385e9.2.2026.05.29.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 06:43:28 -0700 (PDT)
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
Subject: [PATCH rdma-next v9 04/16] RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
Date: Fri, 29 May 2026 15:43:00 +0200
Message-ID: <20260529134312.2836341-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529134312.2836341-1-jiri@resnulli.us>
References: <20260529134312.2836341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21504-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 1AE05603114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

ib_umem_get_va() is now redundant: ib_umem_get_attr_or_va() with
attrs=NULL and attr_id=0 covers the exact same path. Make it a static
inline wrapper instead of a separately exported symbol.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- rebased on top of ib_umem_get() made static
v2->v3:
- new patch
---
 drivers/infiniband/core/umem.c | 15 ---------------
 include/rdma/ib_umem.h         |  9 +++++++--
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 7d2256583bc7..680bdbbc5984 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -438,21 +438,6 @@ ib_umem_get_from_attrs_or_va(struct ib_device *device,
 	return ib_umem_get_desc_check(device, &desc, size, access);
 }
 
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
-{
-	return __ib_umem_get_va(device, addr, size, access);
-}
-EXPORT_SYMBOL(ib_umem_get_va);
-
 /**
  * ib_umem_get_attr - Pin a umem from a per-command UMEM attribute.
  * @device:  IB device.
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 0f373679ea81..908eafa52840 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -83,8 +83,6 @@ struct uverbs_attr_bundle;
 struct ib_umem *ib_umem_get_desc(struct ib_device *device,
 				 const struct ib_uverbs_buffer_desc *desc,
 				 int access);
-struct ib_umem *ib_umem_get_va(struct ib_device *device, unsigned long addr,
-			       size_t size, int access);
 struct ib_umem *ib_umem_get_attr(struct ib_device *device,
 				 const struct uverbs_attr_bundle *attrs,
 				 u16 attr_id, size_t size, int access);
@@ -93,6 +91,13 @@ struct ib_umem *ib_umem_get_attr_or_va(struct ib_device *device,
 				       u16 attr_id, u64 addr, size_t size,
 				       int access);
 
+static inline struct ib_umem *ib_umem_get_va(struct ib_device *device,
+					     unsigned long addr, size_t size,
+					     int access)
+{
+	return ib_umem_get_attr_or_va(device, NULL, 0, addr, size, access);
+}
+
 void ib_umem_release(struct ib_umem *umem);
 int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		      size_t length);
-- 
2.54.0


