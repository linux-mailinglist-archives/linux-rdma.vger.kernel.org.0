Return-Path: <linux-rdma+bounces-18619-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCFaHcX8w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18619-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:18:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C95327BE2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3920E30A521A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5051A682A;
	Wed, 25 Mar 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O28w9xbU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1EF3C7DF1
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450855; cv=none; b=oBp5IsvFdfsg8RwhXgeFX/7uE3ZXkcaLtZIeBtLQq4cEXfFJQ7VcACJ616JubK7thQ0mXXksN1vbHQFaC+K6sGjgReRW5qKrW8+HNSuaYWfdoi0C6l75f5oqBNPT9MqAJt0LYurtiJraTO8Mo2ua47YgW+l83eHrNcJjIxhO58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450855; c=relaxed/simple;
	bh=lvQuXIvXB7dXER/zI/2IGzRLLXxVRzXo1HjSER+ro2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZAW//P2lFez+T7/yZsdz8QOo0oA6rZc2VhZpTl8IGMZK1OA4qvYiyVy8UP38wCXNtPwPZUCU07MO6bzi8SwlinqBTV5nkyr6d5mMt0DApLHPIsTh8GFjCjXlvIbwNe69Z2GATef8s/EkHU+GlKxNhvIRFP5NKc4WlrYR32cOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O28w9xbU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fda2a389so42662565e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450850; x=1775055650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RYE/pns+ALfJ2Ll65r+QmRQKkRIX9/ZKPVdoKnUHjw=;
        b=O28w9xbULowq9xv1OW+0Su6fXQbdYD9hgDY6qyN1pmSjlwhd1XtbyekS9/5fLzDQv8
         ec9X+XGNs5BCpfUYDifjAUrpSfxkeNFMKDsUyDEuaB1VaTLTfswvCCiz4Nvl8zIA3szT
         MHlLdGvCgn3koJ3YhxD5qr4AnTS1UgOqKhRjALYRtLvvaVKlPmVGfxgrWb396Wh1l8qz
         TrJe08CcXpZZGUTFWJnXYC8T4GVav9FH3AFfUDIkkphvLJJDKDI1Ygf3x1IR4Ekp3VLU
         eJBPwwXJFYwrdLtWNKcetWwcLCcDxi8QLgINavjhA9KP3LGK/+ScJs00m2RamUGvGG6M
         FGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450850; x=1775055650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RYE/pns+ALfJ2Ll65r+QmRQKkRIX9/ZKPVdoKnUHjw=;
        b=Wb18fhiUzAwxJVB8iqM5B3KrULv1e6pyVcpQeIHidfAEHUGOLDAG8r/02gglB25cy0
         Xfn53zzwPl9xElm+IT4OWFEKvq1+4uIzqZirkqrfdIhF4Cd61zx9KlkO8eqIfWGx1G3X
         GdjqQObUzrAqdI24mAbUAO9/RWzdc+7bbONXyMkv5imtFY5RvIuDpRuXxiWI1xOgIA6t
         vS1zMUwGvEQUaW2vDdtmV/+ypWiQ9CXn5B+4/JWp/kcGZlvLPkaKXevLOqCgODcz62Pk
         hNRm/x9ms+Is5X7kBlzt3jtnXg+2OJy62WiY/tpJoTlYo0U0qiqRRahKweZX+E1FIjbA
         8Sgw==
X-Gm-Message-State: AOJu0Yy0GQQvWEHRxB/3JAizSFGOMBQwKSd7t+7g2KutXXJ3b/vg+OCc
	ah9fPIWeZ5KVH2CXDfberzneOpl+SiuH4f9mxBj3Vi0dBn2PGISlre+LLZ74DCk5leHl1peSThv
	xr3XainQ=
X-Gm-Gg: ATEYQzzZ68rwbzpLKyW2q7JJh/7UdQ14vvdAcLJFjML/UPVKXrI428Qnp60kLbLWvQf
	8OmzAiyDpqMmoZreFO16exkarKz/bhZ3EpINpMuPSJHhk1XxEOVuXtiPdEGVuvexgL0RD/+pSlb
	3wz58Mr7447nPNY5kDthoLFGc4VZWD9c2ZAbk5dH7nUsZhal0nn6h9wEtPv3Vt11Vkoe15QfGEL
	QPU794MU+2JStFjGhyFG9qdWIksbDnkx68kYfkE73nBI3v7+61LvnXzBOeDErACtNG9wHTCQAEy
	XbwdUSVWM7PY6zi0F2jpdBcicyMqCPiALD1VnIf5OiH+D5CEYfkaVkWpJ0o/NqhOAI5dJxOiAwx
	Eo/NII/WZZhSOWjs4S/GXMSKHsYwtq8HusAH17JPeq0/pXcTVXHrx2KtYxeGT0xhdnuAufrndQP
	eDK3ZfNvk3flkRaQ==
X-Received: by 2002:a05:600c:8489:b0:485:5981:1423 with SMTP id 5b1f17b1804b1-48715fbfcc0mr57158445e9.3.1774450849464;
        Wed, 25 Mar 2026 08:00:49 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e6cb655sm310975e9.14.2026.03.25.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:00:49 -0700 (PDT)
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
Subject: [PATCH rdma-next 00/15] RDMA: Introduce generic buffer descriptor infrastructure for umem
Date: Wed, 25 Mar 2026 16:00:33 +0100
Message-ID: <20260325150048.168341-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18619-lists,linux-rdma=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,resnulli.us:mid]
X-Rspamd-Queue-Id: 07C95327BE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

This patchset introduces a generic buffer descriptor infrastructure
for passing memory buffers (dma-buf or user VA) to uverbs commands,
and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
bnxt_re and mlx4 drivers.
Instead of adding per-command UAPI attributes for each new buffer
type, a single UVERBS_ATTR_BUFFERS array attribute carries all buffer
descriptors. Each descriptor specifies a buffer type and is indexed by
per-command slot enums. A consumption check ensures userspace and
driver agree on which buffers are used.
The patchset:
1. Introduces the core ib_umem_list infrastructure and UAPI.
2. Factors out CQ buffer umem processing into a helper.
3. Integrates umem_list into CQ creation, with fallback to existing
   per-attribute path.
4-7. Converts efa, mlx5, bnxt_re and mlx4 to use umem_list for CQ
   buffer.
8. Removes the legacy umem field from struct ib_cq, now that all
   drivers use umem_list for CQ buffer management.
9. Adds a consumption check verifying all umem_list buffers were
   consumed by the driver after CQ creation.
10. Integrates umem_list into QP creation.
11. Converts mlx5 QP creation to use umem_list.
12-15. Extends CQ and QP with doorbell record buffer slots and
   converts mlx5 to use them.

Note this re-works the original patchset trying to handle this:
https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
The code is so much different I'm sending this is a new patchset.

Jiri Pirko (15):
  RDMA/core: Introduce generic buffer descriptor infrastructure for umem
  RDMA/uverbs: Push out CQ buffer umem processing into a helper
  RDMA/uverbs: Integrate umem_list into CQ creation
  RDMA/efa: Use umem_list for user CQ buffer
  RDMA/mlx5: Use umem_list for user CQ buffer
  RDMA/bnxt_re: Use umem_list for user CQ buffer
  RDMA/mlx4: Use umem_list for user CQ buffer
  RDMA/uverbs: Remove legacy umem field from struct ib_cq
  RDMA/uverbs: Verify all umem_list buffers are consumed after CQ
    creation
  RDMA/uverbs: Integrate umem_list into QP creation
  RDMA/mlx5: Use umem_list for QP buffers in create_qp
  RDMA/uverbs: Add doorbell record buffer slot to CQ umem_list
  RDMA/mlx5: Use umem_list for CQ doorbell record
  RDMA/uverbs: Add doorbell record buffer slot to QP umem_list
  RDMA/mlx5: Use umem_list for QP doorbell record

 drivers/infiniband/core/core_priv.h           |   1 +
 drivers/infiniband/core/umem.c                | 248 ++++++++++++++++++
 drivers/infiniband/core/uverbs_cmd.c          |  18 +-
 drivers/infiniband/core/uverbs_std_types_cq.c | 158 ++++++-----
 drivers/infiniband/core/uverbs_std_types_qp.c |  26 +-
 drivers/infiniband/core/verbs.c               |  26 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      |  23 +-
 drivers/infiniband/hw/efa/efa_verbs.c         |  17 +-
 drivers/infiniband/hw/mlx4/cq.c               |  21 +-
 drivers/infiniband/hw/mlx5/cq.c               |  40 ++-
 drivers/infiniband/hw/mlx5/doorbell.c         |  41 ++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 drivers/infiniband/hw/mlx5/qp.c               |  76 ++++--
 drivers/infiniband/hw/mlx5/srq.c              |   2 +-
 include/rdma/ib_umem.h                        |  54 ++++
 include/rdma/ib_verbs.h                       |   5 +-
 include/rdma/uverbs_ioctl.h                   |  14 +
 include/uapi/rdma/ib_user_ioctl_cmds.h        |  17 ++
 include/uapi/rdma/ib_user_ioctl_verbs.h       |  27 ++
 19 files changed, 651 insertions(+), 166 deletions(-)

-- 
2.51.1


