Return-Path: <linux-rdma+bounces-6571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BDA9F48EE
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B94189112F
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3AE1E0DFE;
	Tue, 17 Dec 2024 10:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OaHsYBVn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6481D5CFD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431533; cv=none; b=WpMyp39iAvS5ZZEABZmAplRsWw2s3OPTRwFdXJGrQa030eVvY1VSbX84GGzclKi3y8p7ucMMHUClr1PvSTMxf/sPMybN10KLSQBe+Kt0m1J4De9bRb9le6SXVUVudyAnWrE9j37J3G2ogjigCKHGzylHlSYKA9BbiPu8T3+QDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431533; c=relaxed/simple;
	bh=XHiOVFLZ06T5q3BE0Zu1glRuAYkfyQRuGgjXz1Z03ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvZdyh8TG6PSaZPcxA8386eE/t4iIPif9ZxHxwtuC61DowctY35z1pPxz2EFnME5RClbh3CNQ9US0bTpFA1u1GYdEtPTJv4zU/MxnKqkyTPOYkmAo7DCvlQm6sviZBQyE2mDtgnkdLdXsfCX8YM3mckTU9O7s10/27M1ixhHy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OaHsYBVn; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so3022898a12.3
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734431531; x=1735036331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNeah9zdJLY6DYTaEPfaWXhKwCdAB7QZT1nhVMKmi38=;
        b=OaHsYBVn29zYf1dxusIPLzv/7d+l+G8ZC89fIJ81NZnfYbHoxjCdQJ4Qf7lpwGJiEl
         qRvdUF96OO4t00RHN/SM1n75HikasMTV2dH87Z9xfwv/06rT9ZsbChuuMo9PU6ReHEpO
         74QTcEaYaLX9KuD9GGiqoyuQ3uwlSnDdtJXXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431531; x=1735036331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNeah9zdJLY6DYTaEPfaWXhKwCdAB7QZT1nhVMKmi38=;
        b=SJKEgjcoTUOx7w2w+xy0iRnU+FlPSjk3wrF9oEWHW2dHTd6R6/JYiqVbQlmsE69GoL
         GFesA8UbqTTeL6GBOXjELbfPDFAnrV1k/bn4k387TqyyJpJQvSDu4ZywYBfNx9pa0ESN
         bvAM6WCY9u5aXEhu8M2rLkHSXjF0wfsslS8L16pWUx4ZdvI1HuLhWQFCNwv/YGTK0SHI
         i2xrSZ+yvgCeSZBJcDOz63s9RQRxZWm84lK36C5AM/gu8g5tKO8dsBs7mgPlFDeYwUZ0
         rC+MCcJpAx7m5M6VeiN7XCnd9UO/5clt+aq0bDBlilsjWtobeT0tXC1mjP2rCzBwp40Z
         v0+g==
X-Gm-Message-State: AOJu0YwLmqki7YDL65yZ0aYNCTC03Sld8MxFHFaGpp2Xr3jYpYcwLgci
	DKo1wmt6nd3ogIL3mmoBXsQv/jk9G+5COmh2k1EU5/2XTY/Bp/nE0S7pEy1VWw==
X-Gm-Gg: ASbGncsSmy5S74gL0gno2SN4qAg7/ZuCewcs9TLXhFEGMU+6Ze86jDYuVvIIFB/QKCD
	5PxTStrSCdFA50ChuAwxycv95+k53oDMZDtIGnF4AVe9PMjSslHwyjQwZx4Bn6XEeUvI1aK7FGn
	zBYvN9b7DeTbGd17cmKj4FJ8/zkUpn/ESPWGYH9uxtKThLsZUc9msS4Y9tzcbwGpyO7oGvietyO
	j7S4twFa6R7N/c7hqF8ZKTsSv/eDYIXJNvo++Ugp9q3EbA4gL4OxoSDhlsGosFCMWNLqt7DTwRC
	29hpPtBYmkHD7PZFlxD4E3N6p3RN8fbsKxYgdNPDJ3U5Z9d8mRw1JAgM+zE=
X-Google-Smtp-Source: AGHT+IHb6Ur3lJgGM7rPayGxEdiWS+1Jxj11gZGhS3YyamEpbYQ0kqSBp8zmjMft+uwq6aaTcNjOcw==
X-Received: by 2002:a17:90b:53c6:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-2f28fd7017cmr23887548a91.20.1734431531614;
        Tue, 17 Dec 2024 02:32:11 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm10764596a91.10.2024.12.17.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:32:10 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix MSN table size for variable wqe mode
Date: Tue, 17 Dec 2024 15:56:48 +0530
Message-ID: <20241217102649.1377704-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241217102649.1377704-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>

For variable size wqe mode, the MSN table size should be
half the size of the SQ depth. Fixing this to avoid wrap
around problems in the retransmission path.

Fixes: de1d364c3815 ("RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters")
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d8a2a929bbe3..951ad90f5aa9 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1033,7 +1033,12 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 				    : 0;
 	/* Update msn tbl size */
 	if (qp->is_host_msn_tbl && psn_sz) {
-		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
+		if (qp->wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+			hwq_attr.aux_depth =
+				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
+		else
+			hwq_attr.aux_depth =
+				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode)) / 2;
 		qp->msn_tbl_sz = hwq_attr.aux_depth;
 		qp->msn = 0;
 	}
-- 
2.43.5


