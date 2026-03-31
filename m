Return-Path: <linux-rdma+bounces-18820-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOuIDQ8ny2mmEQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18820-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 03:44:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A183631F1
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 03:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE78F3008250
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 01:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE3C3630AD;
	Tue, 31 Mar 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIcVmaqj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1CB29E10F
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774921484; cv=none; b=RjMMXC7mTOfULSoycCT8ofnwQ8sFjKaMErX7CcnhqdYKKzsjcQRkaUlN47Byrijlmh+gKUHwEG3tmVnT2rJZG6UYzsNTFxGjmvZXtS5GHFk8fQ7Bx085B6CO/TAR6QlgrNHC6HJpBTPoLjTNeEBsjI3nBrxcxxmB2H1o5r7YAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774921484; c=relaxed/simple;
	bh=CAd9CsIw5uBt745HRHWccms+aIxJBHEFfd2l1zBYTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABsKg41ED650sCL7GrVRsDOir/ZH67obB1rr0WBoNcp0w3mMSNC3Yeubj+fvsUel+7uDU4X5IsoV0GRlE4D7mEMh3LOpnoiTW5LVEIBE2eVMAfX2B6tA9c4SCOmeU+9fxO7QLX6Gxuy1kl2EM+p1Gg/welcomJsD2KkppsVhmHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIcVmaqj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so51184205e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774921481; x=1775526281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0u4XGipzXcrllq+GKNKoK9rSohfYPlxp6GgA+a5PaTE=;
        b=MIcVmaqjrhMqGBtGDV+XNGriWFUzjAaNjHQgsrprhIxfVatsbU/KfxniG/QK/ZT4pq
         pl3l9PFkASgaonv9f3ryJmsfxcsQvIRl/MYZusdS1Steud9ELG2rzL938MSAgIfiChxw
         nxH/Nllk0XaA+Wn0OGOzri3oe/fZsORFwWOOXW52aSgvTEkCbiyUclCcsyNS03tMoA2b
         0pG1u2vUCTsfBDiZv3FgMOeo2I7zqufZJkFXxGlANMffMVQLqfoDQXRfNUFdiwZd94/7
         F3zIU4YQm+9m+70eBdTuKYZxn88mDJE+x9jml9PlsxHdh2HuKACInDEWR8aCOmokM6xd
         rdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774921481; x=1775526281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u4XGipzXcrllq+GKNKoK9rSohfYPlxp6GgA+a5PaTE=;
        b=Sz+6/ePWAXGnNL2PYMxZxxpczaVpZOVkJt2qicWDRVFB9R00Rj/QZ8S3Ss/Qpt1J17
         Jq4zNLxLOthBa/gSwEsu2Rg/hr7Ck9GfqlPBG0+LFCbaiptQrOfkimeryliPAwZyYcWp
         0FxXp0r5zU+xFPpL71ryoaBMwm91bF6AMpjGzmbagZB6oN8s+lBdH02C9wm22gks82GZ
         hFRxCkqqCfAvqSLufSodbXM9TisggLOP8ivUU1Gu2HCdrRrceOe3su7w6TDPGnzwAwWE
         QhdpOr46B9rdlTWh8qwsX7FIOtTM84RNOC9SGwZ7n1L1hBQteSM503W62DKT2qcwQYYn
         /1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmvK3VgXZqztrPe1KYkocohBPjEqMxF+XPzS/vmF/sKeC45qEZWn14PUABMQnWmsR7AzdXOyhnRT4O@vger.kernel.org
X-Gm-Message-State: AOJu0YwOoGp+oIbDqRf2KDT+HUt+1W8XZQLM2mk7bLLp/ArW5AYiFBlI
	k4k++KeHsRGIhNL+g97LHWKCHZzSI/M6BMd1YQ82RraA0VjYEGdlD6Nh
X-Gm-Gg: ATEYQzyP0mzqaJXGVc8q4axLU/d/sHxNLXj/Y2HxVLDC4Ry4HbsRNEvjGAv/am1Abva
	dk9ANUQFGxkIoGCROhBzFZWcyAwE+YH4sBOYGGNjxmSYAWT13Ia2mOvWrIPOKl5iS+t2we+mzUt
	84wOUPkc1CgyKiJBzgJgIoZwIxudAUAO1hnFdNo36W/e3jHNMVZt7nKI8T7+4UNlFXK7I1QQJxo
	DG5iDRrvzo8bsoYClw43v3bxwegqZ3OA54Je55dLh2qYG+BWxD/OhhHyKLq9b8qTqAY8mxc0tMJ
	Z1phv5fcPA1Om9nPIBBRh+vR6tgM/bToFmxP8m2VC+SxQSonMckzY0IslgQpl8cUUAqJFci9Qpe
	jTTNphm/nkn45e+YMioBa31/V42f5i8TCLky5RR868+ZXqsKE0tnt2/5JuJXEIBFTOlIxhc5vcF
	mZE7HCoeLxjH7oEC3heIizP6O1WWUDLmfJcyImOD+KNssJzXGfDs3W8TvOA5wl6a4JD9aT4prLT
	xbg0gqqStvZLkvVjFiv2Gq1WASdB66cgfJPAEuR96HxVw38UZ+/mN9qNcM=
X-Received: by 2002:a05:600c:4744:b0:486:af22:4a2a with SMTP id 5b1f17b1804b1-48727d5a2e4mr239523885e9.7.1774921480961;
        Mon, 30 Mar 2026 18:44:40 -0700 (PDT)
Received: from DESKTOP-NQ2T5I7.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c84988sm284035275e9.5.2026.03.30.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 18:44:40 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Haggai Eran <haggaie@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH] IB/mlx5: Fix potential NULL dereference in query_device
Date: Tue, 31 Mar 2026 02:44:27 +0100
Message-ID: <20260331014427.11756-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mellanox.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18820-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0A183631F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Smatch reported an inconsistent NULL check for 'uhw' in
mlx5_ib_query_device(). While 'uhw_outlen' is checked at the end of
the function before calling ib_copy_to_udata(), 'uhw' is explicitly
checked for NULL earlier in the same function.

If a caller provides a non-zero 'uhw_outlen' but a NULL 'uhw' pointer,
ib_copy_to_udata() will attempt to dereference 'uhw', leading to a
kernel panic. Fix this by checking the 'uhw' pointer directly.

Fixes: 4835709176e8 ("RDMA/mlx5: Don't fake udata for kernel path")

Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..471dc8df4a52 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1353,7 +1353,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			fill_esw_mgr_reg_c0(mdev, &resp);
 	}
 
-	if (uhw_outlen) {
+	if (uhw) {
 		err = ib_copy_to_udata(uhw, &resp, resp.response_length);
 
 		if (err)
-- 
2.43.0


