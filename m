Return-Path: <linux-rdma+bounces-19236-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cESVGttf2mlB1AgAu9opvQ
	(envelope-from <linux-rdma+bounces-19236-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:07 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA363E070D
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CC94306A814
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225B42DA749;
	Sat, 11 Apr 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="AlUTRhbG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974092475CF
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918972; cv=none; b=GijmKUlPBE2kYWtRSgLqvp8AJjgpUFQ+lFj90JXaLg6smeGntF7uibTfsrD1f0s0C4ZmM4a1jhAdwUK7WZ3xah17lXyrnCSZwK1/UJQED6PflK+8nW/xIkSbnGzdg3djRsXlSMZ6LPkndoEpPkDeF6zSWrj/3xvOgWY0AeG7juI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918972; c=relaxed/simple;
	bh=8DNbnD9CKEkZGz6G7UQLk8serTU8XCTpz7Pa3Xpf3Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JC1wTrSK1XrBBj17iADnLpX98Ho/7r6LYwMEcX8SEixY+DFxz/O/ya3qDBb119w8v7APigsQUDC+N8DXFFAyJk6V40wKQ4h20ReSA4146HRRsQzCY0rsgfrURaIvEOTk+zXrteZ2OExljbv2t8mZhnsi1wgmaz6BjfdFXvyfpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=AlUTRhbG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so75394f8f.1
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918970; x=1776523770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RskGQRPZDRiU8iIvH1A32N6I8CEfMzwxLP6TXxC7WBI=;
        b=AlUTRhbGlVObFqOGySwvnD18pRuDdxrfL6HmNzcMy7Ul4ncXsIBLXxxbIhZsD4ZNJ0
         5S0S6BGMfXwqqPFqgsWy+ErR2XKxbMkZ8g8zXucmV1KPVFSH9BUMhev8oSfGK4haeUih
         0sSZvdPO5Ib1TaLg9kdUEpdmgfaQ56zslvqwWBORBLQfDltKTjNoWxvxSFlqqn3KlxnN
         JObJpaPYaXiSFRONFEMm7DvM17Xl3wWkY2CKvFpJxnypCc0gnMgwK7lBAudn+DTtmvRD
         mpGgFY8zE0vBCbVnWHTn18gSlBYebGrRzFkdAGTHo8xaccjStPVrGecWbCVk7wSeth4T
         euXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918970; x=1776523770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RskGQRPZDRiU8iIvH1A32N6I8CEfMzwxLP6TXxC7WBI=;
        b=fWaXWeu+PKVSGT507Od+9ZAT6ei6BxGOcSXNB8zh+Pi0w7nHaGFpov3ViBbNSJeX6L
         XSprQtjpOpwcXTrucvtzjupdvH11SGtA/2UPtiEZPYQj68ggcTZ9h0EmZKJSBPjQZFif
         RccsBtIYv/j3/78yokHmeQXIyHn0mDAPj9xsKACZLk2WlDnUVTXSj29pSroh081yelyK
         YG2Bi4ia/WZF1a40yeVNngeYskpYU0eyDlsKYdIO3q9kPbmjeVEunw5PJrFawDGTNsBs
         Yozhjyy4MS2ig9N6uO92N+azpmdjS7vETjifKtbjTHNVdT/gqBPLEXYQD15AlnkPkSiD
         vJiA==
X-Gm-Message-State: AOJu0YwLdMAZnTQg5iIFWMoRYZwkZcfvZydvRuid0K2bXjvfB9WOkGmE
	qcN6wwphjb0ilkxXkLF4GYBTQYpzR83JnH2wok8Fv63T47+sxhug4XxJVtphdcOSbD/vnsj/20s
	/LHXK
X-Gm-Gg: AeBDieuC8Uscdp4L0I1StgfqOg4lDcTlHLBgOl0hBtmzJ8Nki08G+XmBbTs+VVB+7ep
	Wz0mV1jKjp64yMxen6YiJkBWFMZ5mAq8+/OmFUU025KuIVnQgDQOLKNqZaj2Z3Z2ZbshDDb8uER
	xMhxxWVk629zuGDR3ErulKrRhoMvXMEth45Lia4yevqFTsp5dzzypASSKhxQLt8VJBliL8Kj0WB
	q8S1HR8D/1Vjm8QCC+AhU0bZa0kaPRy2Xus6CLC+lsbD3zO+uRtxpnY2r3chSoSFb2v4P2zcDJ2
	Yn7+rDJ4WWDQRbd8V9FrpnwasIkvPhi0C9LCtc0pyiFmBdIxU+Aw2dzNERig58Tqq3+UTSB/sCj
	t3vTrlZT3aLblku5RQzzMkNc8AzNDByGAPJzSxzACNAjwKc12IfsDATLSfBaPkCxKyhXFVss9io
	mhR3c6Nv2nljCTTdV5m6xSviII3Ezbga2lerZorQA2hYc=
X-Received: by 2002:a05:6000:2dc7:b0:43d:4d2c:9ef6 with SMTP id ffacd0b85a97d-43d642a78e4mr9778140f8f.30.1775918970034;
        Sat, 11 Apr 2026 07:49:30 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6f4bf2b4sm1332271f8f.20.2026.04.11.07.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:29 -0700 (PDT)
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
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v2 09/15] RDMA/uverbs: Verify all umem_list buffers are consumed after CQ creation
Date: Sat, 11 Apr 2026 16:49:09 +0200
Message-ID: <20260411144915.114571-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411144915.114571-1-jiri@resnulli.us>
References: <20260411144915.114571-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19236-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: EFA363E070D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

After the driver creates the CQ, verify that all user-provided
umem buffers were actually consumed by the driver. This rejects
requests where userspace provides buffers that the driver does
not support.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/core/uverbs_std_types_cq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
index c165ff5446f6..d3176032d0ac 100644
--- a/drivers/infiniband/core/uverbs_std_types_cq.c
+++ b/drivers/infiniband/core/uverbs_std_types_cq.c
@@ -222,6 +222,10 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 	if (ret)
 		goto err_free;
 
+	ret = ib_umem_list_check_consumed(umem_list);
+	if (ret)
+		goto err_destroy_cq;
+
 	obj->uevent.uobject.object = cq;
 	obj->uevent.uobject.user_handle = user_handle;
 	rdma_restrack_add(&cq->res);
@@ -231,6 +235,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_CQ_CREATE)(
 			     sizeof(cq->cqe));
 	return ret;
 
+err_destroy_cq:
+	ib_dev->ops.destroy_cq(cq, &attrs->driver_udata);
 err_free:
 	rdma_restrack_put(&cq->res);
 	kfree(cq);
-- 
2.53.0


