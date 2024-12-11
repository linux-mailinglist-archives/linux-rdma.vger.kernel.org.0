Return-Path: <linux-rdma+bounces-6422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A79EC78A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 09:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813FB285D39
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556E1DC99A;
	Wed, 11 Dec 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FI986Im1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7387B8489
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906646; cv=none; b=FO/YEFSid8s27acb0ogBIgdwe6fGm2WcbCKYuofOnhn6YtFQCiHH87jvWdJQvznBWkeCCZPxvf4oH2tSEtOVbpH7skqTkIyCC9h9ELpFgWvPjg2feArgU4ySF/2Y1bKneBldFIllUpW2wz/DjmMi3ibj2j6nrlPoaXKWM//7DD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906646; c=relaxed/simple;
	bh=xkBNjvhWV8zMh/16s8VGDAewWWyZZduUKMRWl41YFHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhxpTB9OfNE+oHJDb7DgBCqlMAPC8lKu/Pvsw8VAmxWdcGvJw1MtwK5Q4ldUvBHnvDIDjgf32jWKXQ7OFlmC8IMaifPaA8TmzF/ymCytIWXG8UiyiI6vunNGoiWfbvMRGgGXFAvctkBNv5zCEXMlyZzl9doDi/yGiy0hV8bPNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FI986Im1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725abf74334so5341622b3a.3
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 00:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733906644; x=1734511444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61iMgu5WqnCRI74Ee5MYDKbvdnz5GHeF06t5FwAiwgo=;
        b=FI986Im1pZgEKu+MxqQ3pZCaoM2Fa4Xro1JOOID3L6Z6wtoxkIbB+fE+FSlMqjAnyI
         ci4kUaGUZ/8talilDBYdxchSe/6G5rlqBY9njtWd5k4Blxt38AODieoYw6Xv4FPOGtta
         nux2CNlQV50Foe8dyiqP8bIoTgNj4GYezLIW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733906644; x=1734511444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61iMgu5WqnCRI74Ee5MYDKbvdnz5GHeF06t5FwAiwgo=;
        b=DYielgLXRzftl/HYQmSZVwcgb7EOM+LRFV1tmIHpiAHGNfeNkbIwnwN09i0kGUPNgw
         6asptmLk6097zZWqcrd65dq+i1pD6aNzhNPjAkiqgaCDw8Pez2tpxV1Fo4AgMskl0ToW
         0PWO0rQfdQwYD4vmqMp0HLf27wyEtxAlyA0cxlhbekdNPceaIiYcZaMfMH8P15Jn2u1V
         usFfiOh4+Biq2TrybqgNW6Qd0MIQkx4GRqz47IgoyPS2ipjy2c6a6i2v1Q3LRDWrkzZ1
         7Q82RnOcwPFk6Cnpvyo5qMnFq1dhGe1qkiHSaDiWqESdgVvpEMU0WxfTUkMs1wHbYXA9
         spwQ==
X-Gm-Message-State: AOJu0YxFKsYt5TJlUc5EF9jw5fWPK4bFpEy470vBxmouWwEs9CE+aR1/
	dLk1R34MIN+03ZPZ5GrU4yFY+51hot27iKAaUJomDWaL5y2hL9JrxwhqL8HC/A==
X-Gm-Gg: ASbGnct2564wAGwz8M0HdwDY8CpsyttU9DdI9h5BJVjgpcOPpf0pn83F7LkB8e0tHFi
	IeuzNVe+o8EdSwnCxbnptJ34qcYeWPd3rm1uON+upnz/wqcrFqJTs6Llt/RLDoNA3y1veumXu2Y
	gt2OVbu78j1pn/YFmVmyWMxBLXWUTe/DswlG5X4isqlamOT7mcfpnvQheAtrRH/XdUQr3OWd8Bx
	/kqahgWN3FE9tpprSd54hi0uFUHSlsm8lLzc+T4fiphXfnzNMksDDhdSH4Iw/uzr/Za9jb67+lE
	+NN+UYc0KRYvhjR4o2Rny9TLRPf+Alzo1C18vOJpXUs3PSpAclLo1B3I
X-Google-Smtp-Source: AGHT+IHkLG6/+82OGOk3pAyj10ozFDE+7JpP2TTy42+X5maObXWe9wts8JjW0+rUqgsqs8g1OeYhzw==
X-Received: by 2002:a05:6a00:4f91:b0:728:ac38:4bee with SMTP id d2e1a72fcca58-728ed3b2978mr3547924b3a.2.1733906643756;
        Wed, 11 Dec 2024 00:44:03 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273b69ce95sm3653678b3a.66.2024.12.11.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:44:03 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH for-rc 1/5] RDMA/bnxt_re: Fix the check for 9060 condition
Date: Wed, 11 Dec 2024 14:09:27 +0530
Message-ID: <20241211083931.968831-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
References: <20241211083931.968831-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for 9060 condition should only be made for legacy chips.

Fixes: 9152e0b722b2 ("RDMA/bnxt_re: HW workarounds for handling specific conditions")
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 72f35070f671..093bfb748cdf 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2669,10 +2669,12 @@ static int bnxt_qplib_cq_process_req(struct bnxt_qplib_cq *cq,
 			bnxt_qplib_add_flush_qp(qp);
 		} else {
 			/* Before we complete, do WA 9060 */
-			if (do_wa9060(qp, cq, cq_cons, sq->swq_last,
-				      cqe_sq_cons)) {
-				*lib_qp = qp;
-				goto out;
+			if (!bnxt_qplib_is_chip_gen_p5_p7(qp->cctx)) {
+				if (do_wa9060(qp, cq, cq_cons, sq->swq_last,
+					      cqe_sq_cons)) {
+					*lib_qp = qp;
+					goto out;
+				}
 			}
 			if (swq->flags & SQ_SEND_FLAGS_SIGNAL_COMP) {
 				cqe->status = CQ_REQ_STATUS_OK;
-- 
2.43.5


