Return-Path: <linux-rdma+bounces-22225-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0Mv4HWe9L2ogFgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22225-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:52:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2554684BFE
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:52:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=Dn2Baihk;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22225-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22225-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4F0303CC2B
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF7C247280;
	Mon, 15 Jun 2026 08:50:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F53C4171
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:50:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513452; cv=none; b=kXgB8h+/pq+bYA8kCmnRep49tcqpBPsVlKP1nu6fgiNG6FIVFy6VnslSIwoccMQoSF7jtcXiwYTQg1636V7cmG9XpuMslyLXWF3U1lt8mQtMUCnb8egt0NhH2kmPg182G1PN2j317IKXSAtktvfpGeufiHEZXnE7ecT0tOnOVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513452; c=relaxed/simple;
	bh=Rn/ufL0hqyC5Vey8BQji5BJZm+oRSTxXo98e6B2TtVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhjJvFwLGL1cpf3/bx6LyHBzU65TK4p5ol4pTgeKok+dvzpCGTWTZkM2FYywR/slhRltnxoiZ3LqrNLvER5dQoOkqSMDQXzCA4jllE80aPi0MZO55P3z1nzlJA7y2Yb7Bz1bsgT9HejFffnmByXa/UoO0lYYN+xNxse3jFqiHq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Dn2Baihk; arc=none smtp.client-ip=209.85.208.51
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so2754278a12.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781513449; x=1782118249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjquPjnSxlH1NouQC11hdL93bCB5PiSU+rHY36k2irI=;
        b=Dn2BaihktOMFY4lr7bbqPlyRw6B3/Ww96DrN/dx9U6RGs57iJiIo1PL5M2kbBCFBGm
         u9Q61ueMZELP5+6f7yOMfbAKh6aLlvn/E5s1PR3mo67tKsEL3g29obZaB6kIxzOhVdCh
         LeZxbxAO5TBkwZjkvGT9+5Nc1sHJpk57mK9l8UUquFZH3ScW2bAS3bmFuNJYmdz8L7e5
         OM72WHD2fKqawP6P5tk5halUbNPxl9Emhx+ClW83HjFKRqqEjIvu3rqLFiWoN0FmnU0w
         /pBSCVagfQTm8Jzq+CRawVL5SZrgOHcxiEfVcoFi28kFQdjyVoITX1jaDuRnPeVETlkr
         JwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513449; x=1782118249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EjquPjnSxlH1NouQC11hdL93bCB5PiSU+rHY36k2irI=;
        b=cBSXoW+uGFIo60ExGko++o8JA4ysIZ4Gm71c57Ku409AajAauEIEmF4JRmnl91aWFz
         n3SDtQoUogdWBrtJPHWqBwkxmVpAmvAKKfXCCNSqsMALkCwFFVs3rf5SEDy2kKfkN2V9
         yCWxNZvgjWwRz/LkpNrCg7TE5KpvOPWhHQXfo42VxWwC+yPdUF8x+7alvyuyuJbxqMiy
         shH18X4+YOEBEMB4997QO5by55s2K1MRNPfsFIM2h2bniVxFF4x1yeR37EgB1hsPYtes
         luSJvlffWNlz28uUe3r0M2WiQIQLQvXK8hY6736xcL/anJfBZVqDQ3wh+IdXZ9YVOD2W
         4Bhg==
X-Gm-Message-State: AOJu0YzE0fG6B4Q447fGWKNdL/L6UMUxPJZzNvUDabT2BRc/cN0DsEs4
	mFD7/me0npR2O84Fex8jUN6gvvfgPyURvq9pyob7Nxoy0E7K9Xh080X+xLcS5F/fp4BjzK2YRIn
	RSiYq
X-Gm-Gg: Acq92OGupn8hi7JZ///UoZ9MANgspOnuecMX4UPrNWCMjT7MLwjJG2OzCO+Rz+ektze
	auBxz1DVkcBtCHXAGyX2439KGIEnJmlOsR3v1x1GOw4S+xbBIv87OdZgNK7lfWSEmliqTTylSHg
	/EWpMYZnHaFLQfq1/OoPL7GtSMegdJOBd159VTnL/wtZfhcx8oHHsnIhQPGtYt6CCEwbnSZwngb
	xJgjLrT3GfXXYgRHJ2czvEkpw3TTIClfKdCSgDgv8r5hY/jjFyQ+tiEX8bHWEaybDe30rPeBQRT
	5Gxe57+LrocHxQ88xiAWz8W0FJAvZ6KuuCl4b0BhoyU4ViTBStLh9Mn5bxjTKU8Gh0jDV6OETI4
	CaObC4e9fgE/Xwf+VcKONaT5zQHzmoBLiXm0C79lPqBXHHJJbsg2AMy5ZUofTeRmRjKmj7FMzGy
	v5mSvoVCfRh7GrThhUkP40QWauLXI4pZp8
X-Received: by 2002:a05:6402:4489:b0:691:affa:38cf with SMTP id 4fb4d7f45d1cf-693785f423bmr5920525a12.3.1781513448464;
        Mon, 15 Jun 2026 01:50:48 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-693794b36d7sm3142458a12.31.2026.06.15.01.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:50:48 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com
Subject: [PATCH rdma-next v2 1/6] RDMA/uverbs: Add SRQ buffer UMEM attribute
Date: Mon, 15 Jun 2026 10:50:35 +0200
Message-ID: <20260615085040.1396623-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615085040.1396623-1-jiri@resnulli.us>
References: <20260615085040.1396623-1-jiri@resnulli.us>
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
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22225-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:mrgolin@amazon.com,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C2554684BFE

From: Jiri Pirko <jiri@nvidia.com>

Apply the per-attribute UMEM model to the SRQ create method. Add an
optional UMEM attribute that backs the SRQ WQE buffer, so userspace can
supply it as either a VA or a dma-buf through a single descriptor,
consistent with the CQ and QP create methods.

mlx5 is the only driver that pins an SRQ WQE buffer via umem; it maps a
single ucmd->buf_addr region through this attribute. No other driver
implements a user SRQ buffer, so none of them use the attribute.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_srq.c | 2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_srq.c b/drivers/infiniband/core/uverbs_std_types_srq.c
index e5513f828bdc..0421bdd225df 100644
--- a/drivers/infiniband/core/uverbs_std_types_srq.c
+++ b/drivers/infiniband/core/uverbs_std_types_srq.c
@@ -192,6 +192,8 @@ DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
 			   UVERBS_ATTR_TYPE(u32),
 			   UA_OPTIONAL),
+	UVERBS_ATTR_UMEM(UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
+			 UA_OPTIONAL),
 	UVERBS_ATTR_UHW());
 
 static int UVERBS_HANDLER(UVERBS_METHOD_SRQ_DESTROY)(
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index 839835bd4b23..1fef1e86b302 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -189,6 +189,7 @@ enum uverbs_attrs_create_srq_cmd_attr_ids {
 	UVERBS_ATTR_CREATE_SRQ_RESP_MAX_WR,
 	UVERBS_ATTR_CREATE_SRQ_RESP_MAX_SGE,
 	UVERBS_ATTR_CREATE_SRQ_RESP_SRQ_NUM,
+	UVERBS_ATTR_CREATE_SRQ_BUF_UMEM,
 };
 
 enum uverbs_attrs_destroy_srq_cmd_attr_ids {
-- 
2.54.0


