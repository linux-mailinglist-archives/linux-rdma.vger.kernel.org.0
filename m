Return-Path: <linux-rdma+bounces-21305-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCJBHeGyFWpxYAcAu9opvQ
	(envelope-from <linux-rdma+bounces-21305-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:49:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E99925D7E53
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3C7C303E6F6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D43DA7EE;
	Tue, 26 May 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="bzj9KIjz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49613FF89E
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806528; cv=none; b=i65x0pqF5VRBeOUSZ0Y+QGYRgg5dH5XXs6mtRURROPkGcUABncD/f1O5HNWOwNeTziHco7JwgTGx4rtfebuzs4Xt86YCSAU4Ipajsft7/I/eObGlvOo7JpUFz+8uoyhThPCHbZPTW0c94/gQcJ9fGQVqmzF+MCepREx96Sa8NPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806528; c=relaxed/simple;
	bh=CdHNvdVyWwn4B7PYsPkfFQFpo97DkDkDhNP32go/344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlL4EvTWSFEy+PN5/8PR4mb6vCunQDLyqHm9n36uQz8LhjIHbsF0UMp22bGaTP80hkA7eEzG/KNhiUpJRe/+5H92jX0kH2CSwKC0ALZRUsWW8rMVx4YY3NaAoEdNYHh6v1JWGVHER3JwLUsBye1XkXVI7CPIl8DO/p+AnIxuSgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=bzj9KIjz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so112291385e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779806524; x=1780411324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=bzj9KIjz0W0QsQajDCJWoGzJMhdpBhMGfz0s5R817L/RY/qIMZf/KMbTgTyU9Zy0QY
         fk705bZPSTOpa2yPMlGyc4jKb0Qnt+A358dFRnNRw/cSg5sCQC5wwqGReWGkzVe2utPA
         sT7mlWEbBxhZ57oVttGSuuDpKcvw0wtiZsT0s6sKHR7qIKNr0ITeXcXLvJCETRHRqTjd
         KrVJDYw0N/LPlcsAKskIuCWEQWcfLD88+fUclPKS5VpkPaeim1ECXdlJ4TfyC0KdksHz
         MyW2rv1jB/m07Yb27yf3ovPMD1Z331HteLD0jXXGY7QWwFqTUreeMniTgGIijAO/15Uy
         suWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806524; x=1780411324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y99Ea4bAs50iTgic0X2Vf0N/VWbWanhuVBb4Ly3bw18=;
        b=jNNcVYPyYCqvqDLA5wqx5wEHmbx2buNRO0RBNuhA4zUS0S8O+ThqpKMsq2VHujHuAG
         HLKkWmn7g9R5PN0szHwJUBqrufq06dRVWzDlaX9voqm1Crxw/Z+sqg9VNq+ojUlhUCWI
         vuYDeaITqc3+2shCoHVvzihDRnTMQiNlU6RgCAF841xdpr/6tfKNjZOfZVIaKx5GjvC6
         mb1waCUJmA866rDmRwLf8tlUof6LXrXozUNZLJSmj07vCcIUzqRX2eJZVpHRxvhCUllu
         yqSmJ+/f9HZlD+x8tVi0tZ+v6PLCxVlHZVnEUJ300XyyMQ5/ai8HrqQi4/zPzrwrEPrD
         X3bw==
X-Gm-Message-State: AOJu0YwQUFVSowdgKq/ZUCmy29TsL59umsZxtYQXnaPBs/oPa5Mjik9Z
	7r15Hp2hztaoHP5BADKktpDu5hgFK2G0axZaoEuw7xVomDn8zxuk2NAcKeQ2j5YcujtktUQLSAB
	EDocZAzZz+Q==
X-Gm-Gg: Acq92OGXAJciY4oPiJc5lqzUbmfAe97bYNZajtbNWDWt9qxftCY+TwgtBNXxPmGQD1Z
	l3KemNrmV8Pc3ejayUmpYosGLtg56+PoWY63RSDpxMSeR0zhgZ5RZoo3l0A9DZeei9RDNEyCAg/
	7CjR5N5QqnVP7F8MOZdBK+QxUofInbwwWK/C/tI7+gFE1OIAhaPkH49hNPjbftOylBNdc4dq8h1
	iom8YbA+EgUXqE872FHgVo/i17xlpq33vUkvdpkVXDLseiXbxQrROMXvdMzyFIIzdv+b7rF0dRO
	Ys3B3q8UiQ8zQ0j5rpuSTwCiytzx3sKg92yu+0E/CrmYSqdxnDDJcATjoboml5U2IUxDAJbiEzu
	IYMsuTQVQQgJT/hOfBue5LVISvp+YZ4Q4CbOQPvOtkFCrm7UW9RQVUgsTUly99hxiUezytsVjAe
	hddrKdWoJPyWBdAkJnWztH/pz7v/kWjrNl
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr98029315e9.23.1779806523955;
        Tue, 26 May 2026 07:42:03 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm368484545e9.8.2026.05.26.07.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:03 -0700 (PDT)
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
Subject: [PATCH rdma-next v7 02/15] RDMA/umem: Split ib_umem_get_va() into a thin wrapper around __ib_umem_get_va()
Date: Tue, 26 May 2026 16:41:39 +0200
Message-ID: <20260526144152.1422310-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526144152.1422310-1-jiri@resnulli.us>
References: <20260526144152.1422310-1-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-21305-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,resnulli.us:mid,nvidia.com:email]
X-Rspamd-Queue-Id: E99925D7E53
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


