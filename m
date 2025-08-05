Return-Path: <linux-rdma+bounces-12584-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE3B1B1AC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 12:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF113B700B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Aug 2025 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6658260575;
	Tue,  5 Aug 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Quct8g5v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8511E9B2A
	for <linux-rdma@vger.kernel.org>; Tue,  5 Aug 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388238; cv=none; b=pJHbOQANN6hW6S24b9RzJgDjFf8HbGourO2Jd9QZtwEn5A2a7FHng1uYyw0at0hJIlbc0Y9arl2qfpouyjWnKmI8DWRty99DfN51fdvBw2S+n/PpUuREfupvCx/XA3D4c1rZbbMfcXbegPj6bIrd5LpKyoPN1bT2h2AVSN5d0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388238; c=relaxed/simple;
	bh=CNrmS7EAFZvFmY1s89lKPQspEUkIhaihpAieRHPJ9uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqKKWeBDwZuTBni7QNabenXQmWJ0oe/Y0wy7xetXyXOJGJXYw7uIoOckEMq31uk6l/mOwv002ASh3kNVBBXaBy0dH2/NksPYHDl0xzdFU/KzBM86w3aMjWOALcsPvSvwPQNqVSPihg3VFf3791LWLky+UwQRUF1vP3aB5OK+4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Quct8g5v; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2406fe901fcso41458935ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 Aug 2025 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754388236; x=1754993036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFgbY2lco20Jm9186F7qrnNt9Ctc/EtaV9UA5tuRj38=;
        b=Quct8g5vAzU+4LyiG5rYb/0GJ61mUlgJDIbIiqGoWtzuTZUL5xwgFULYFY8IcJvaXm
         VPm2JfaMENrywl1lT6Nu55lB6YBISzyS2xHn/jV5qbGmKAgO0JbOMvSX/YnmTxjNRgHD
         ZFcs6JtJ6bCE+lqRBjV8jL+GCSVTVe2hgrWZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388236; x=1754993036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFgbY2lco20Jm9186F7qrnNt9Ctc/EtaV9UA5tuRj38=;
        b=GK8JJVBUnKqspZKjpoeikdWAIOcjtXhekYkxxV/ZX5EHNb3ujNRIX5DrbqQeeowP//
         xpn1UItlZjBqmHlSVZmXit1PDe3suMDZWDHoNX/DC4AQ31BXdRrpvDYCKN5S8GKdzYWu
         kWYa2N/JARscHSigmhZiNTKbJhX/Z8erBEcuM2ToxD9lPuTxx1d7AvzB45hg+HZOzw2n
         IwEtAYOtruddOoXXngeB0g17a013tjLaenJrPRfC4tYpow9BIj9lG/szLCx7nNhCphsa
         afkSo9fvQQsc5iS6qEKqz9yg7HEvzIBqX1chNsK0QpoO3CgRIZalhx0b3Jst24X0ZJZy
         QIXw==
X-Gm-Message-State: AOJu0Yy68QrfbPoLXPZwLi6uWNRPfXDMdpx1TP9h3dDJt/Xtzh7h0uR0
	HtBckKdtEr7l9c4l6tucnjhmzNGi1eJ0dysSNEbfRWmXGd3Bhtg4JRITxKtO9lR6SQ==
X-Gm-Gg: ASbGncvOWjZDADkHWdembmVJm/j6G4VHL5u8/c9WCzXztZpP0vuWdPd7tdUYM2oUoDV
	miHG/YQMvVHhg0PfvOgdV29yLZ1QP+pYvYIEjaSWBl6/v+PhrJcZmdy15FGWD/xWZv8MKov/bSN
	KU3GI1jLtcDHr3ExJAyzwISRxJNDqYpmDlbxEmMwftPOvkycxayd6wDj9oMdUU6LGsWbt2ajPCw
	shIQgZNp2uFoj2cscA7mBG+Jt4yIwqagOrsbjyQZOBzgNz/vwFBHAmDDkSsVq9O0qUqL8vUz4tX
	uLVE95OdzlWXj9ONOO8OHPMp/7V2F8fH/aiYx2YJQidztKdLZ3U95/NK+ura3t9tWEfbp8kV340
	srIo9twnw6XaSWUsPQBhqMkm6G0ICc4xUxc5NE/4xk8SWx0XWC5VQ/R+MlmiP9mvI7Zibj/LStS
	p7iDzVl8mwmGYM1tMozOY5/nT4/Q==
X-Google-Smtp-Source: AGHT+IF5a2BkieOehRbrOCgIudrW6cLsO8+7ZNDXKPEMj/EihMguhhcJUCHZL+RR4S4KvpwowJKVkw==
X-Received: by 2002:a17:902:c406:b0:240:52c8:2552 with SMTP id d9443c01a7336-2424705fd95mr202378165ad.43.1754388236276;
        Tue, 05 Aug 2025 03:03:56 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2423783a84bsm96838595ad.51.2025.08.05.03.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:03:55 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 1/4] RDMA/bnxt_re: Fix to do SRQ armena by default
Date: Tue,  5 Aug 2025 15:39:57 +0530
Message-ID: <20250805101000.233310-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250805101000.233310-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

Whenever SRQ is created, make sure SRQ arm enable is always
set. Driver is always ready to receive SRQ ASYNC event.

Additional note -
There is no need to do srq arm enable conditionally.
See bnxt_qplib_armen_db in bnxt_qplib_create_cq().

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index be34c605d516..eb82440cdded 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -705,8 +705,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->dbinfo.db = srq->dpi->dbr;
 	srq->dbinfo.max_slot = 1;
 	srq->dbinfo.priv_db = res->dpi_tbl.priv_db;
-	if (srq->threshold)
-		bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
+	bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
 	srq->arm_req = false;
 
 	return 0;
-- 
2.43.5


