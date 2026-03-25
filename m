Return-Path: <linux-rdma+bounces-18628-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPrQLHn9w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18628-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69D327CEF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DFFB3307F0B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCF3F9F58;
	Wed, 25 Mar 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UJnC/MXB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52694014AD
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450868; cv=none; b=ZvigLO6YY0Lq+Pbmz2m8XAlRkZVlxYoBlfRVnX/C3sZP3zOQ4slscIzK+b3N+TRJfnrOwgq8ZEVvL5u7zrbZs1tOpIkepXdvqf+myJO0V6vcmMwz+S3h6V90YkDahHtPQ6iczgCvj88rgcnBHzpLAA8fwDv7PBtS7wnuD8/nHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450868; c=relaxed/simple;
	bh=h55pF/3aIP66Ufk/LwqrXt9On/ljHwKv5ptrIMr1zu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBLr36uhIqXTRsrKfmOOFbDioDGtkqeaq9p9v4xMCsDl5I+iMPikDx7w6BSIUCqZz0gWRzJyiUQeOk2WiO4AzjI25ni+kGCT7qcm43kHIIu+eayZH5JBJwRjYv32o+Qt86NFcI1Bx5ME6i1gxpXiVAubWubIfmhrAFp75Hbxr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UJnC/MXB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48702d51cd0so53358695e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450865; x=1775055665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPpv9zbRk4Bmq+LcQhhA9FJWG06sK83DVKhExEbvD1I=;
        b=UJnC/MXBYmTVTbf3qpaGIxJE4QEl+HF786yw2rxdAEwaLjPGhutZ8HCNyWiMs1mhpR
         OMTRS/iYxSPG+sqxzj9BtkQLfn/xzWvNkzsurEG5LR6x1UrXcTDTVSpI9jnvlMX9y4Au
         8KMTlUkbZgjWYc7TRFHVhL3U3I4gMxjMvY+7TUeL/htHEww66coKxNYWKzvqb5xWIHbg
         OvhCf0GIlRSZGyRP44gpJXDZ9Sd7qg1Qgp1Kr28hTbyUFzt5LWPnHgv6G4/tly8trZMG
         xYjHy4j1fTK+olImI9OXqZ12//TpsMVpz4enHLEyHlwouqX4JjseYvCCNBHwEHlRcBZ3
         fXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450865; x=1775055665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPpv9zbRk4Bmq+LcQhhA9FJWG06sK83DVKhExEbvD1I=;
        b=pXb3oB/jVfcKZ5OZV5hUnGekrA8lwJ7gjxfPH+1sC2dz2wy7GI0UWJVDt31+Nb7kUf
         uvVqlzj9zEipuvnrE6g9y6iX8TyFkvXCP15cek+QOxqXV87eID9QsqovjCEWQT8C+vj4
         fhON+ELb+SBx98jgobo0Ci6NXDgJAWk7OX803r2O8/pBCBBWyo6YleCvoQTIZ/Hgq5JJ
         s1nal8OAMkhgc5kodBN/b09KFHwPV/oa7FkaDtAnVzC0TLdG3z2yT2inlhAqq9phtO0q
         HBzBVn6SIu1Ys2E1Y88k7FdTzKCN1rSxQ+q7zwuPExzo7O20X2Kqzh4R2L4MS/kll9OV
         NZBg==
X-Gm-Message-State: AOJu0YxwZTeINAhYbiA9UCVAuOpjG+yf7c/mHKB/7sN2CEWL0Tp0Kkhz
	W3x9+Ly0fAlqwcN8FSbwCo5ets52qDj/kKo7EFbLuJ4zpzTBlb1yydOJeFA699BxHRmUQYgmfs6
	Q1Dh3KjM=
X-Gm-Gg: ATEYQzz6ZPEwZcegnkwmCn/Zvam+BRzawR3V8T/Sie8hMf38bdASOGWRXLNiLCcWJXx
	Hv9M95SSWRDB8hekqREYhpAHXsRGFzaaE77ipb7ZoUzwzjs6dMH50k+e3y4sN6+odQ7WGG15+s3
	AL5Mh3rybZ94L5Qr/qoXcSVmcEAyOxc4BivToA1ZWTBDafhHl7Y4pHejxMf1e/DiR+HOaW5XEwh
	Gt4HxA1SUiV6PEOWicBvZRrMnpA0xuT9Ndpvy1sR9Zwpj0bJ1ymWS7zy8d+8UFPTvT5gGLb4/Ud
	nvs3BRD9IQaljO919le4eyBUFa9woljBVz7yqbwpQkC79xQSHD/Xk/739aGaGNCW+xDDcIoJQ+m
	94hQ7NPJGluLkgcJtLln1guB1/QjiwfxDhbnYsxrSavGxJNCVbexgBcouVPXpHwzYSR2ZJGDMEm
	FDfneAXGxEw7ftOA==
X-Received: by 2002:a05:600c:8489:b0:485:5981:1423 with SMTP id 5b1f17b1804b1-48715fbfcc0mr57178305e9.3.1774450865076;
        Wed, 25 Mar 2026 08:01:05 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b9179b212sm454507f8f.0.2026.03.25.08.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:04 -0700 (PDT)
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
Subject: [PATCH rdma-next 09/15] RDMA/uverbs: Verify all umem_list buffers are consumed after CQ creation
Date: Wed, 25 Mar 2026 16:00:42 +0100
Message-ID: <20260325150048.168341-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18628-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2A69D327CEF
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
2.51.1


