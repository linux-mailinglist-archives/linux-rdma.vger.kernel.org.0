Return-Path: <linux-rdma+bounces-18634-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OLGJKL9w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18634-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:22:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A734327D43
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51054334C8D7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA353F54D3;
	Wed, 25 Mar 2026 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0mYtvxwn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74A3F9F31
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450899; cv=none; b=dlBpFvgDq/YisBR7a1T2rppDlBZ8GkqWvMTx1m2Kark2VFB45CIiYDa24EfivVIi78cvHHfki0lAX0uztMKOSY28BZjD4LwE+AQngeDdKsJVwWaR79j8vTCAz99S90WOvo+FbkmGymErNwHcoD0uZ9RK6ZWwpdGqMuTF051cq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450899; c=relaxed/simple;
	bh=BS8AbkwPeTYs/9tnq0vBWgB/Bx11l98twIn8qnGsZX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3/iB9yIMcjsewKazMRtqHVTgDiDbUzj9nAH1OENoqtx6s+AJ/CFerC6EqPwIm4MApxyw0478tSN2o/15zVW82tCa1TMCMfXVOFIO31fvkMNy3KOgVkgCOH8Wu70vh4Buar1DSTqD19MhNW+Z9X5dC4zphBasLk1aFW9u5TnmTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0mYtvxwn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso5480007f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450897; x=1775055697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEvXhjgvnZ0tfTmv/mBZbkKVH7vH3H9LCKo2oR/dxZI=;
        b=0mYtvxwnYqcM0To2Bwqkt6y30BoTGaOcc2Y67bPAZDtseTeJ2tTNgX6iXC0F/sy9C0
         qm7M+To3zUEVMQhggo8182lybsWDSpOR/bap7eKl6Wf3+YVAE9p4izo7FSqLTHXZLdM9
         7rHzWTwGSLsg0Tu05FqxG1UHao8aM1KO+cjo+OJmxwxyDppI+vJo8KQq1kR/wPk2Hc5k
         Aw9p/i5rhTOpqr77Tz7Kg9kDU0HiVkcjrvKxnSfsnMON1bKRUHXRB6wDp8zo9xWhXHwq
         h1c2k5q/rvObCmKkYdbK2rU+7i1fq7hlYoNvqDJUyojuOfeGs7O4TgSPBI4srxABltcT
         cHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450897; x=1775055697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vEvXhjgvnZ0tfTmv/mBZbkKVH7vH3H9LCKo2oR/dxZI=;
        b=quGxnYeyKL3c4w7/KkDMib6TXDNukjwQDjrz7mhsb2wybpgeEa4lg0VzA33U+N2Pav
         D40lXEvyo9FUeN+sVXmle9Da4/cXNVJjbAm3mwb+KUbdJCAFWdnF93wSAQYZ5V8jWPb0
         OmrUfzQzXhBRP98xfcCAKhAIMxq3o0MYq3AvPlmWuTZmewc5RvMzmuQO+vfbq2e4O3P9
         4Yq2S48MKOKKuOtF4CNyrh+IjhPLDXJkG4NKc1g/LXndq2Av/TGwH4zmzEBxspLFRIux
         wYYU/Qja267VK80w82gQu43eDd/p3cCt+ruExTxplsDawWz28I8Z4jzFnoAFXfxFujeP
         raHA==
X-Gm-Message-State: AOJu0Yw+/gnhrs2L6OtxseGNhGR1JThCRTOxSNSzQLhgZ0xfNnmtwxgJ
	tMzWNpFpWtMMkE34H/B7hZ3tPylPVi8ktk7Cyq46eqZZ1NMUeq4HBtt0f4EQeR7JQIc+wPR0xNT
	j+uXwYLg=
X-Gm-Gg: ATEYQzyWlhiCF2Wou65ya6t+UIzdRqcu8BySbM3K+xlGThKP3v+VSVs/fWP2WxiYjx1
	sdqqcaGfw+Xiw4CjQDQLUSs9x8gU9H3f2CYrL2FF4vfYXR1LySOUJBKCubMZKpgc/ThbPwBEsuc
	QkIMr4IreDFHGbOqJgAUejd2w2MtFqZQCicic0YXB0q4IMk2MZYuW19w+06UwbXFQKxz0qv5h0j
	pVSBdo5No/rSJuOSjPtTIuzwRmWjCYflwn520NSXb7iPRvTsac2gLLIXKohYz5lOO02GVIlFM7v
	X13SY4raRzRlXUzNqQtzndvMkqWwsalBpQqBY77HgCfS3tq22w7OX+qD5fEvLFGXSpAxtQgKMQa
	c1ojCz+WBA4bxZkvOW1zaf1f+LkEZ2STI4zpwxklS80nJa160e+UkTXkCA8h6II9KG053cr8z40
	/9s0RUyOeRkf5v+cs7WgnrRkcQ
X-Received: by 2002:a05:6000:1a8e:b0:436:369f:39f5 with SMTP id ffacd0b85a97d-43b88a1d793mr5254716f8f.43.1774450873579;
        Wed, 25 Mar 2026 08:01:13 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf069sm281292f8f.22.2026.03.25.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:12 -0700 (PDT)
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
Subject: [PATCH rdma-next 15/15] RDMA/mlx5: Use umem_list for QP doorbell record
Date: Wed, 25 Mar 2026 16:00:48 +0100
Message-ID: <20260325150048.168341-16-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18634-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1A734327D43
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
index 318ab6f346e8..88a2e7f47d94 100644
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
2.51.1


