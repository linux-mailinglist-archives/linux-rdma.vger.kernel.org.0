Return-Path: <linux-rdma+bounces-6538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3E39F305C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B01664F9
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E33204C02;
	Mon, 16 Dec 2024 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DvIaIwKM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1E204597
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351605; cv=none; b=mQ4b0yGRpG/plhS2y2aJeuIx8AB7JNLnttgMkoJeAGDoZbxOKzsqnAx1voiEdM/xDgYyMHsqWcBYq2xmH4Pj8Kx/cOrbj5i3zyJyMZsEgOj29ozYXG/1AbRJA4ZGIAN86/RwO9Iwz1vSQ3iz1l1hEJ47+8DUHtcaSW8ZE69aEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351605; c=relaxed/simple;
	bh=9UP4HQUzzJPu1A4Je2e1oDk4KEm4ECz5bNhxW4oU+SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khuVKawszL1p+lTYJrFagiaUL9c1m6Ki0tVppBXwy+JJv9g7wSRb/jxwfwLkrgBxIGFsM6ddgsN2jUfzGhlUNp2m5S68JFPVJ5MdZD96H41OfV3QW5XhZKxffVF01XQzVbyY22c3a/kUEieBe5LB4ASnCOyawwj8L/qMq5rb/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DvIaIwKM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216728b1836so27768905ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734351603; x=1734956403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjWvqlCs8qMFqAThuJZE7hZxssf7cq44rmT5+HL6yzI=;
        b=DvIaIwKMb24upDA22Hodx4RQiCZPFjvxfopl34A7I5IvgvzYBgDexONl6q+aOlVvA5
         Xjv642hEeB+BSpcYcu+85kXU9NMGsgrui/J2VRMNR2ij5LcF51XRFjRgZI57GGjmF6i4
         k7HUaR3NwoVB1q1Bld+DOoQAMRlLInVbmlwsFZUg2Nb/Zfq3JhRK2aMmqbpLNCpgRkkk
         Az4w6EF8RFlrHNk/s3/Eloj9Gw4r00l2sdZvpyotvZHW8hS1jsWIyKN0GEejmYbtwOHZ
         pwlzjBKw4GVXMWlwx9oaT2KywH2g2ZwSMrZ8q1V4TZwgy4QERxp1oK/GGeOrJ/V57QYy
         6oqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351603; x=1734956403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjWvqlCs8qMFqAThuJZE7hZxssf7cq44rmT5+HL6yzI=;
        b=gYpCzIsXC2gLj268BIOvMAv3SZ6PFb5zbizAsVW3bSVTjDwiv6gibnbYO3qAbmYpcE
         QmAq7zYD/Vo/2xLXNXFcQmQQCkndQwHRdRJ2OsqdTqepHsWnRxmuA0b0Df8rdh66EuiB
         aNsqL9KSMeW8qc6ZGSMUMhPKireH9jWPEtDa/M0DvimZzR9ztgJtn1qIEfPoA5j+O6GS
         MwNBN/RoOfc53J+aaqBEK7XOyAmkeJP9OFd+ZcJzFXaX4pnoA9Qqg2TbyRyuxLD9oiI7
         MmUYscAdpg0cGbOT1WazcOloIWBdhD/0de0+VTX6pTGgqAtDgV7SrOF320LE7Qm8oGIb
         kgiA==
X-Gm-Message-State: AOJu0YxuMqhn5QxpKkqO36QztYvp64xKAHOF1uRrGGwnPh4bBnnwh8x2
	stljt4o9AC46PAZqWnczYxCDjCJks6BNlpiW7Od83kyPcEB9mRBF6yehp0nEC1qIWeGa4K3QM6n
	T
X-Gm-Gg: ASbGncsC8EuRGFPHlAPme27MfFlZnSX3hL0lEbXVhDdCDxZaA9un4Ke99wPLHNflMx0
	y/UxSMLb9Rs6bkP82M7rx4Ll5F8cPssEmLfqktqDo2tOMFk0+HbZzpShmR3rOlYIfqdEBTuqvrH
	Q9ikpCUMNg811qPw3HqeWCsejw2GnxPXnvIUP+bp7/WIys1KAQ0wbqPB3qQOFMdlknlalCM1nU5
	Rc2uUNhb2jnAhdssYsGk9fBPSh8z/kkb5QWC3MnfXpX72s/KqLe+aaTcbh75qG52vP4GD+urBMD
	XuIo
X-Google-Smtp-Source: AGHT+IHLH7NOnSOpMVpdoq31O1h5pYS6xIo9n3y/rxHkJ8y16JCiuEPW9aEsLgAmPQCTjVEIM6HjGA==
X-Received: by 2002:a17:902:f60c:b0:216:7c33:8994 with SMTP id d9443c01a7336-21892a7a811mr188966815ad.53.1734351602790;
        Mon, 16 Dec 2024 04:20:02 -0800 (PST)
Received: from always-zbook.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e53fe7sm41188635ad.160.2024.12.16.04.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:20:02 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] RDMA/rxe: Fix mismatched max_msg_sz
Date: Mon, 16 Dec 2024 20:19:53 +0800
Message-ID: <20241216121953.765331-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User mode queries max_msg_sz as 0x800000 by command 'ibv_devinfo -v',
however ibv_post_send/ibv_post_recv has a limit of 2^31. Fix this
mismatched information.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index d2f57ead78ad..003f681e5dc0 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -129,7 +129,7 @@ enum rxe_device_param {
 enum rxe_port_param {
 	RXE_PORT_GID_TBL_LEN		= 1024,
 	RXE_PORT_PORT_CAP_FLAGS		= IB_PORT_CM_SUP,
-	RXE_PORT_MAX_MSG_SZ		= 0x800000,
+	RXE_PORT_MAX_MSG_SZ		= (1UL << 31),
 	RXE_PORT_BAD_PKEY_CNTR		= 0,
 	RXE_PORT_QKEY_VIOL_CNTR		= 0,
 	RXE_PORT_LID			= 0,
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5c18f7e342f2..ffd5b07ad3e6 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -688,7 +688,7 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		for (i = 0; i < ibwr->num_sge; i++)
 			length += ibwr->sg_list[i].length;
 
-		if (length > (1UL << 31)) {
+		if (length > RXE_PORT_MAX_MSG_SZ) {
 			rxe_err_qp(qp, "message length too long\n");
 			break;
 		}
@@ -972,8 +972,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
 	for (i = 0; i < num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	/* IBA max message size is 2^31 */
-	if (length >= (1UL<<31)) {
+	if (length > RXE_PORT_MAX_MSG_SZ) {
 		err = -EINVAL;
 		rxe_dbg("message length too long\n");
 		goto err_out;
-- 
2.34.1


