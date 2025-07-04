Return-Path: <linux-rdma+bounces-11895-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59531AF86D2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 06:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86AD1C21F59
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED3619D8A7;
	Fri,  4 Jul 2025 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HxJkYPsh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C459615E5DC
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 04:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751603588; cv=none; b=SHVIw97CDovXvH+qZyvtFA6SfHEAatv2K3wcE9TJmq9Fb9T83eER+hhV9FANP+1wVG7BxCHDNwYll+S/T6yIcvrd93pucT0R1D+e/SHwT+yyzAr4xHQ2M83Co/4sHwFheuPS7zsNoDb7PLqiv8hHwU07haa0SzXDn/UZXjjzOLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751603588; c=relaxed/simple;
	bh=5OpbGp/Kl1rMTLG9WysXZLFgsJxqzpVZ7uUcEO1N1Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUAFAfJDBsuBSJ9ZtZC1QhfHXTZELptiK0bzYWLnRwMwDMfOAI6jtlDiOq4dXiRDqUDJMoPpaBM166EFfy1oAqJ/aAmstV8fHgPpIMSbavcBqJbyJFxf3KM9reri9UUu7QD5vCPEy0joWS770NGLRmWEryz1O5i7AdaA7TzNrdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HxJkYPsh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237311f5a54so6103965ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 03 Jul 2025 21:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751603586; x=1752208386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDRfzKiG/IcasUC5i+dotA029G2EIVBL6RmOhttNuJY=;
        b=HxJkYPshEqo/QILMXDlB1XzKHSfX2J94DPM6hMxIV13SDK5Y/2DsO2ucVJzLin+O3l
         JxZmrtTjx2NeeFW32X+OnuV7GC0BmM0Xifv46wWzFXPNkub5Lg8JjESSePqEk3w5AcYi
         FpCRRCaK7CONyW3qa8BRnCBPOe8vl4eheWwqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751603586; x=1752208386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDRfzKiG/IcasUC5i+dotA029G2EIVBL6RmOhttNuJY=;
        b=YJ71T5U4zpETULRPmF4jq8W4fOgLqk6nCSdpgOwnV1agdYYAQORPnlbbg3saxq1WYD
         vxBxIt7cCf/O4vV2c+NhiiHFt2yLPLioeT9/vyGOI/Yv6o9BjzFT8pZvc6oSqCMheeGI
         Q4ik5vK7OKSNbmFr1FNFnGwmdOjnkKFS1aLGNhBLa7lrTrNZyVe1Dn1CPr3t3K7ekRxm
         0nndmZytylhn5gE+C3QC9gk9VRVnjIX3XHJErZoKKUBERVuCowMbkhsOmF/K8okC3Okg
         HktnnOWQgn+7XfKeMzT2E2HEwpPX3GnGYu4GTX1wjpAlB171yRioSJ+WFrwFXp/rApNS
         hnVQ==
X-Gm-Message-State: AOJu0YwaIvOdQwSlEVxycVpz3zDZH/t4I2B8uIFWvkCyLiR4LAIuN1IE
	jUo7s3v5yMGlMh9SCOxuxxYsOh1PD9ScpA6f3U1pzC/GNnl2GrU7usC8Fw0SFIx1YA==
X-Gm-Gg: ASbGnctpg88CrU4JbJ2jPTI1Z5NlG7GN/z5e7QQ1w1vxWigeJD7Hm+eTUMXLnq4MmUB
	HemuoKRno7wTdXitgyLFLEzuC60+5llYwSLt0q6Vd7AQ1WQG4QrcZEjTrSa5wcMCYpV2xhFpdOk
	LT1++oW5Mo8wvaUAxm3k3SZ2f2DMvbwhvwwh1OeoxdteaPJEuMRG0bm8UbEB0pZpL8ct2hp143J
	FccIz+mbwQ42G4rxGYZ9Ouk1Vt9GwG9R4cy8VYNuiCtEOSmgQqApINaZnCGgSvoi7irkPsYTBDu
	6QllFwIlv8qHUKfp+Ww8tNPjKX7pTPpyAoINrWrEgsZ0wMso9PD9qdF1FnGL8+uN3eF5ly7z2P9
	+4u7L94s3F4jRL+e0GnIWZy04W3HX6T8fNnf9qE7sFkMY60Nkx1F8VjsZvZEON8Ocwg==
X-Google-Smtp-Source: AGHT+IFdzwq2TXbcKCwbj3VFaG05pN4Kyx9xX7MjzpyZxhJ9Ahm3VZZCIaQ+A+F5eqbRHf569q8XHA==
X-Received: by 2002:a17:902:ecc1:b0:236:748f:541a with SMTP id d9443c01a7336-23c873ac226mr13699915ad.0.1751603586082;
        Thu, 03 Jul 2025 21:33:06 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74cf48sm976223a12.77.2025.07.03.21.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:33:05 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Shravya KN <shravya.k-n@broadcom.com>
Subject: [PATCH rdma-next 1/3] RDMA/bnxt_re: Fix size of uverbs_copy_to() in BNXT_RE_METHOD_GET_TOGGLE_MEM
Date: Fri,  4 Jul 2025 10:08:55 +0530
Message-ID: <20250704043857.19158-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250704043857.19158-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since both "length" and "offset" are of type u32, there is
no functional issue here.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Shravya KN <shravya.k-n@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 063801384b2b..3a627acb82ce 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4738,7 +4738,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 		return err;
 
 	err = uverbs_copy_to(attrs, BNXT_RE_TOGGLE_MEM_MMAP_OFFSET,
-			     &offset, sizeof(length));
+			     &offset, sizeof(offset));
 	if (err)
 		return err;
 
-- 
2.43.5


