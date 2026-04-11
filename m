Return-Path: <linux-rdma+bounces-19242-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P4PLe9f2mlQ0wgAu9opvQ
	(envelope-from <linux-rdma+bounces-19242-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D123E073A
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 16:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15EF3010BA4
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Apr 2026 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD5387361;
	Sat, 11 Apr 2026 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="EdwIvkmf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4B385520
	for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918981; cv=none; b=s6dDbCZsgo1GrBrDl9bJw87Y3ufmVskTMXqUx5FE2xJCXk6BhUuBl/YVopE87p5+f/ZJrljYKZBernzwqWAjj7sSQemRJx6115Wmnhkv63C1NdK7A1fDuoLtoaiF5fB7wt4BK4hp/PmJe+nOCH0ufkvbitidVk6dzKk8PLI+C8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918981; c=relaxed/simple;
	bh=godT7k2X+e1PdXl/Rw29BDv3iNIqjajs1iR3BWVwxUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1Tw67cMD4ez+KUbv8E4QBFFAXHKVsFA2jDjJQYlNHyCQIHSu5brVG1PoW0zrhdMmiYpcuByPi8TQDAz5Y8vLDol65ffRInIOvPbNLm4gBUeyb/iVP5PoLMiFcUDsfY7N35aGWBUX38jKKfVzzx7od2WWVBog0Wb4T8c0F+2PAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=EdwIvkmf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso45092585e9.3
        for <linux-rdma@vger.kernel.org>; Sat, 11 Apr 2026 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775918978; x=1776523778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5ipzGbeRNOC6hmb03JiiUWkZSTBejuxVT1fhubTzbw=;
        b=EdwIvkmfjSEymPk+bjZvdDzyUbANju6QTBlj6J93Yz+TCOldSytJWz8KEEJ8oOOD37
         L/RumUiKqvPYLAnSpiu9cxBqSsHgJt/GRtvn82e1K7MIo77Lxtb8hULy4Qgo7jr5N3qk
         AqDoeuhIyQPs93KpX2f3M0cW7k615HyB4Da27nE1v9JwOMaMgnl3ZtzEF6BTpUf/UkVa
         huTTHSyMSZc9dylCVG7SYr5bZc/gXvgwXxacJY7zUiF9Egfx6FPEABoBqhtUc/54ofBk
         cwkqWYBbPYY9UhXqU0QzkpS2f8aQX8vRhbEZIuhTIQFDLBeFGXRWf1zF2+KfLQBhpoey
         thEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775918978; x=1776523778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5ipzGbeRNOC6hmb03JiiUWkZSTBejuxVT1fhubTzbw=;
        b=edyXTibdsZ2O2jFRQR02BCR54OB+pkkIpAhq+Eyd18Qe62Dx5PjEX+JFXYPGAOM6cI
         RWzoePg+Il3t24zLF2ZrWZWLN1ysGiaQ0R9kMmmMc1fzuY4hYfd9hlP4Eq6pHq5svP+g
         dduUdRRp8wbudkEAMFbbr82i9Qc/o+cYWKfwaffrerfll2UTOLz3jilnvIV6KnObZz/o
         gRBbZmEY+gKzN8uqKAnIlVoCZIMsH7XruxmJdjz8WIlpo1GE90yOt7skCMVFnrV1LRIr
         wuHfPIISw1bSWHnRK8lEIvrPOF6is3AHZyA7jnfKFg3PtcUjSXGWYmYQp91gcQIXqn81
         L1+g==
X-Gm-Message-State: AOJu0YxPHLyzIMxbYLQeOxEvL3AaDXHrodVrIX8tSuAlxoFWAxvEif6O
	uLOJPliS7N1RehhyrS01/CitbajH3D7rFygpH+TaXIBluKgh6I9qgLErtPtwUUxtYd9Qzn2yQtY
	dAlff
X-Gm-Gg: AeBDievDAmhKPRblB01Dmz8dQkqpql9uyCeptcp1waYVHU8eQAaqICnN/JMxJRS6Zs4
	K/MFEOVhRr1Lv4eI0NZrsbgLxnIdu1H17slqfUfVXaTlKr6xZ4hKc4qy0R606Q7wHk5QtsroVOx
	VWijySWhdJyLFJtwdBEafwRp1sn5AE9zztl5dY1U9C5Wuytf2mjWA6Q/fKk5SOP38cLHs6Dli2j
	3kK/YUtkPqFQ01XIrS2P1xWxdYCE4NvLUFcCoQt4bDymNyUzdimQE9tAX249V2UPi+FA2Av+JFZ
	o5qyEuxiUDnmt8AHo9CbPEPLGg+MIeOKSAPg587mBptQu4ri2mICgorglGxGxU3z3kmEp9ZWpgZ
	+jXOxluT0T7ER9msSRqFQy33pJjvEQi2V8t0R8X0HUGcLd/JuoUtMKQDLdyniC1mRmmuErqmUAj
	GJvtSF+YwVJYje6hXkR3+IzbqNCZywVLPb53lE7VC5bE8AMZUXbhjF+A==
X-Received: by 2002:a05:600d:1:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488d67c720emr82477085e9.3.1775918978411;
        Sat, 11 Apr 2026 07:49:38 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5380feesm190312685e9.9.2026.04.11.07.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:49:38 -0700 (PDT)
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
Subject: [PATCH rdma-next v2 15/15] RDMA/mlx5: Use umem_list for QP doorbell record
Date: Sat, 11 Apr 2026 16:49:15 +0200
Message-ID: <20260411144915.114571-16-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19242-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 52D123E073A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Pass the QP umem_list to the doorbell mapping infrastructure for
QP creation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 3edfe44f911a..6010fbb43d7a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -1062,7 +1062,9 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, ucmd->db_addr, NULL, 0, 0, &qp->db);
+	err = mlx5_ib_db_map_user(context, ucmd->db_addr,
+				  qp->ibqp.umem_list, UVERBS_BUF_QP_DBR_BUF,
+				  sizeof(__be32) * 2, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
-- 
2.53.0


