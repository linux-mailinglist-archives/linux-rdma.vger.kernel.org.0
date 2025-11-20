Return-Path: <linux-rdma+bounces-14631-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43AC72B8A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 09:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0529E357570
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF693081A1;
	Thu, 20 Nov 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DOGDxEXf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4722EE617
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626013; cv=none; b=X3li7uIL/fVTp4oaNn+NyHMzyN1Zl//wvvWkv+VUlrDXuBd4DYABg2V5acdxx+53tvM7qmwxHGE5V+l7v4o5TXu3dGUFJoEnI4wzrX+10WDzkNZpcp9dW9MpfjsJlC2cj5/wMYCWik7Gv+ykIxm3gAnBg/SUGqnGpZmaPYlTJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626013; c=relaxed/simple;
	bh=xC4tw6ruiqiQ0SLFPGurYiUYYtJ1uYDiQV6ghiBg6+4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=gY9NxDLwn2NtwlVsbv8COEwgGvsbP2hJimC+yK4ae1ws3D4zZOcSrqUq22m8fzCbKcIH1YaSFUbtkiUyoDeNmkq4Y+dKiWqz4YLWPR4E68XZ+Sz0rTqrbhGHXZT3O+1Szag5R+N/EJRl5KXTWEgNIpGk+SgLXagyOGCZq0jKA+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DOGDxEXf; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-88056cab4eeso3345176d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 00:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763626010; x=1764230810;
        h=message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPZpKjuReuloaTrnxM3BGvjifrrIBcp8jkBNhhtV/SA=;
        b=mRtNtoshrkJOUsiUof0AoWApEcFNBO1ZkeCFa5K+d1MvxR0LIOPy14HqvdR3sZr6rI
         tWaU7jhoT4w9owBcTpWBWvQU8/Ez0dbwTbduS3z4gb3bQw6DGE+IHEwr0hgFG1kAUOXN
         vEAmP/5KaR8fYhl5iAxcIeQ2ny6hMoCPXQkjaLc8EUKV9vtU4W2GhgXSIl9sq2wV5ZA2
         FQfZ+pCanQkLRNJfqA5xkY5l4+lPnLTDM01YFoSZ+XZXMh0A5Tgsc/T1mdgF8m13epdI
         TufO+oUsSlNOBksm2gaYLtfERXCoSSWtvPbJkx52ivfXvU7+XcmSTa3iWStV9kAaI4nM
         Kc7Q==
X-Gm-Message-State: AOJu0YwbC2SLJVIRSlkawzrZolhS5FOMxHVWeVfuR3pDbtGyWxlQSW25
	NiC4dJ0X95K2oN5sR0eg1XjWnHaD3QDh6kOCWcdqlQvNYNXD0is2Go6mQ38PxxLmcYk/k/Ik03x
	rC91QkWCT78jgWfoOt3VO91OGx4us5dM5XYyEsulHiEy0zGyZu4XX/cV1F+jtZF63eQGh4zQ3xG
	8C4NZskVy7YOutdw0AZyVLb2Zvnbibk2Y50kDxudZgHaX9+Rvs5q8QSh2vPWM70C0KYwe6oE6V2
	ZzBNvMZ/Wjm+wk8qA==
X-Gm-Gg: ASbGncsEnUpL3qY6wDShjU11e3+Qc4eHgXbQVSubJZ65TkJvmWd25Ma01ep+0Wf4YdQ
	UFS/v4NYLMbBLFHENpSmIJ9Jwi6CWHszou6KRd2RfigB2YaOYJOSYAqELPU9ZdqM3rB8xz+0gjJ
	GbkryN8cenx2BSwQFj1QqOtJZYwIL8bTfGGtGbQHABvP8+FknK2JGg6LRWEpLG1ZibCawcXw9KK
	vl6WYHiXy1d3Qth4mz8hS8lPv3KBrLvbYLq3NbwEcrYNcU9tt7guhDtzZSr695kmVhVhB/4+X/S
	XlRzGJNxQ7EVUV+fTggMjfTefYiLba+Z/z7UbVevu8ZQADwDUFjJabbmGc6plj9zwShg3tvrdHI
	b956J3I7Lhhz1KOcJZBc2XtP6oXhI/BsYUFbFMLIsqtTdSdW4qnmbgARSbrzMKCWhus6ei5ZnNg
	vetUoNNKXL5JKA/9xRCQFOKRzQfS+Ir8E5+ZvPdjpVbpGwPg==
X-Google-Smtp-Source: AGHT+IEZPjfgGdL4Ztj3oNHTY9wCEuL4/PvScIWtXNn6c1Ic8DuYSLSVjNCmbXh4vI1/rphjTRNsKlqhDfuF
X-Received: by 2002:a05:6214:428c:b0:880:5548:93a0 with SMTP id 6a1803df08f44-8846e08b41cmr31117706d6.21.1763626010450;
        Thu, 20 Nov 2025 00:06:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8846e5b13ffsm1843556d6.28.2025.11.20.00.06.50
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:06:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3438744f12fso1916872a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763626009; x=1764230809; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPZpKjuReuloaTrnxM3BGvjifrrIBcp8jkBNhhtV/SA=;
        b=DOGDxEXfJG3Ztw5Cmdm5uEJ3G8sgdN6aoLz67RThMoUVpe+7nQa+rIzmUAxo2ixc1c
         ILDub+NUSqQLMbOm41lbLHV7sWv7gTfoPmiHy9H/uy+FjHxr8ddEFTTlxpHuOZf4m3II
         iMj+gavo6sHa9Qe8+oxW6VwdOH+kEgghu9kSE=
X-Received: by 2002:a17:90b:3947:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-34727bdba56mr2651392a91.6.1763626009272;
        Thu, 20 Nov 2025 00:06:49 -0800 (PST)
X-Received: by 2002:a17:90b:3947:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-34727bdba56mr2651372a91.6.1763626008893;
        Thu, 20 Nov 2025 00:06:48 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727c4baffsm1549119a91.12.2025.11.20.00.06.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Nov 2025 00:06:48 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 1/2] RDMA/bnxt_re: Fix the inline size for GenP7 devices
Date: Wed, 19 Nov 2025 23:36:54 -0800
Message-Id: <1763624215-10382-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Inline size supported by the device is based on the number
of SGEs supported by the adapter. Change the inline
size calculation based on that.

Fixes: de1d364c3815 ("RDMA/bnxt_re: Add support for Variable WQE in Genp7 adapters")
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 9ef581e..a9afac2 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -162,7 +162,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw)
 	attr->max_srq_wqes = le32_to_cpu(sb->max_srq_wr) - 1;
 	attr->max_srq_sges = sb->max_srq_sge;
 	attr->max_pkey = 1;
-	attr->max_inline_data = le32_to_cpu(sb->max_inline_data);
+	attr->max_inline_data = attr->max_qp_sges * sizeof(struct sq_sge);
 	if (!bnxt_qplib_is_chip_gen_p7(rcfw->res->cctx))
 		attr->l2_db_size = (sb->l2_db_space_size + 1) *
 				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
-- 
2.5.5


