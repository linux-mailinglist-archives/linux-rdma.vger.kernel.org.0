Return-Path: <linux-rdma+bounces-6570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443519F48ED
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 11:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626B016C94A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873E61DE4E0;
	Tue, 17 Dec 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NEGJTPa7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B501D5CFD
	for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431530; cv=none; b=EQOMJL/u368OQJ1a1FGVhXUWJ9S3cgiQETrEmG7hpc5PgcMz6ZhoN9X5YtMaCcgY+3roiqvSN92/g601hdif1rRdkimkIyPWRU0u+l8ogGN+JRD6vh7iOBfP9G5lBOrbwUVTdA6mMesPQfsrvrDJesTe/y3PjYYZ8ulk57HozNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431530; c=relaxed/simple;
	bh=y85QLpFPWCm1SPAaBJxJl9LKgf0TqU5PP3yM58+Sntg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9SVLYTR2DNMDR+urcn74I6ZD2XO5kjQOXptDxoi4BVAZK5Ypzsbgl+/hTxgAzP9h8OH3OgEIta93ZG/H4GZ+w1IqR44Ts1NGdqBPh3NGgJ9uINco68js+hecm/MbggtoumKpNOtsqEYJ3fN7kVucdu2vGH1MTqiYPRQHuDacm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NEGJTPa7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-801c8164ef9so2703969a12.1
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2024 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734431528; x=1735036328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfS3v1Ah2unI8Gm5Pibjh5G2tHuFKyvOn4gp98jM64Y=;
        b=NEGJTPa7XLd25jawBEfcLCWSlJNVeQ0spazStFcJkEA1AW8glw6czHDfI+Elfh3cad
         5xSACCAVyVKd29aCMfeTo0yxVbx1Qa5FIjSvx3zLMKGwmsqC59DVS7cYhUW2xhHAJnKg
         uazZj0+inAkjVHsFEy8shQY1Zx9WvgyFfL/6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431528; x=1735036328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfS3v1Ah2unI8Gm5Pibjh5G2tHuFKyvOn4gp98jM64Y=;
        b=OWzi6/UpCAJtpVSoQJxfRVbOaOuexK4gr8C7xAa6Sojxd8uSUICgabAnu355NgBlRf
         4QZqFPRED0oWESymJIUrNbGMMOyMj932B6v7aGNa9FOomCI8Yqrt+IdpK2PUw39c4Ouf
         wTfInzjcDqGvTSxaWvf7CyC6DhSQBx9AcVBi60dmFqge78Bs2ebd9qbsknkFZ4lCWtNT
         veReTDoLf0jN9PYshK+7ApX/ArJFGhIcKKpYrWsvBLkBPWebotZjVPLSx+W24fCp6Fpk
         EzV92YEHexMP/9ORuXXxiwQWWP4yKMbJz15E3gM9TscMedeeUj8DH5Uay+eWQk3bKmAd
         RU0A==
X-Gm-Message-State: AOJu0YxX8rsUlyOCgxSW4gqbhYwwhx7JxQrcPj97MI9HzeyAt8g4n9gR
	+v5x9a+6o3PrRHPO2Z8i0hKrHwvEHSiZdNWQQFfQ9tlzMiVxq6+2WhDeJyI7aeTgmwkJayFCcEo
	=
X-Gm-Gg: ASbGncuy5UuDc67f5PTSJpZyr7sIqS92PIDMl//ZDRQjbzK6qwNZaviOU07oQgMcCE3
	tKTIshkC6+sUo6kLbveM2JUtR2395P+TV2XmuDBc4F7lJKPX7V33Vx79QKmDP4vKpixoRptlhgN
	CfW71/Xfid7ayGBSwL56l/bg3yYjdfyYSuWPpKd7MxAvpP5ljsL11dGF4+wnT1JaPbkheu219w5
	WYPQFdVVpM4WVMMwNfuEMMGSUCtrVOydMTi7HepMVqUs+FRfDSspZpNveK4PanHJSThktvvfte/
	I8hf9eLw5ori/8du4RZrixi/qbxz9KYgm4lDrsqB7gIITy9ANwXZJYtOzao=
X-Google-Smtp-Source: AGHT+IGn5ujEUI5Zqn0tJb4u9RjWGV/CQllW66F3ukryX5kIx117Z0+iAz7J5k+CfV6xUKwih0fjRQ==
X-Received: by 2002:a17:90b:380c:b0:2ef:83df:bb3b with SMTP id 98e67ed59e1d1-2f2d87bd46dmr3926273a91.8.1734431528258;
        Tue, 17 Dec 2024 02:32:08 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90bd8sm10764596a91.10.2024.12.17.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:32:07 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 3/5] RDMA/bnxt_re: Add send queue size check for variable wqe
Date: Tue, 17 Dec 2024 15:56:47 +0530
Message-ID: <20241217102649.1377704-4-kalesh-anakkur.purayil@broadcom.com>
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

For the fixed WQE case, HW supports 0xFFFF WQEs.
For variable Size WQEs, HW treats this number as
the 16 bytes slots. The maximum supported WQEs
needs to be adjusted based on the number of slots.
Set a maximum WQE limit for variable WQE scenario.

Fixes: de1d364c3815 ("RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 776f8f1f1432..9df3e3271577 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -138,6 +138,10 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
 		attr->max_qp_wqes -= BNXT_QPLIB_RESERVED_QP_WRS + 1;
 	}
 
+	/* Adjust for max_qp_wqes for variable wqe */
+	if (cctx->modes.wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE)
+		attr->max_qp_wqes = BNXT_VAR_MAX_WQE - 1;
+
 	attr->max_qp_sges = cctx->modes.wqe_mode == BNXT_QPLIB_WQE_MODE_VARIABLE ?
 			    min_t(u32, sb->max_sge_var_wqe, BNXT_VAR_MAX_SGE) : 6;
 	attr->max_cq = le32_to_cpu(sb->max_cq);
-- 
2.43.5


