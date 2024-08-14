Return-Path: <linux-rdma+bounces-4364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7074995160E
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 10:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D705B26169
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2024 08:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE213E04C;
	Wed, 14 Aug 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RTM+sWme"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A497A13C906
	for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622592; cv=none; b=MF2IbX+rRPXrMLaK8VluqeB9z2GgIo+7SkVpv3X9PcJ0tKFjwr4V4CeMzHjR0OeNfvSgfizSL4lcNrDy7mxKaaTv0++Z1c30/hJkfiSZ5bjYVlECoH8DHeYDfVE6kWKb/BqUuzaqa71kYgPCayzJlA4sRX/RZw8ovW8s6L6EfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622592; c=relaxed/simple;
	bh=TahX3B1Iuw1jEr2+u0UIDJab1OxyO54LI0+bMBFXKUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JaU2pWjZIlLBTVizNARZ6imV/FyJpEtLPPo183AiDh4YH/oiJ4lEI4SNcdm/fvdvBjajyIGBInLScWJb4Z9d5cAliTBkWyH4XIq9HGjeBJj48lgN3t+AOjwsRvvGP3AtWbIPwEMI5O0dpYMD5JUzpf5xztozAYyXVoKnX3YmKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RTM+sWme; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7105043330aso5211063b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Aug 2024 01:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723622589; x=1724227389; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+leSXdUbIYKI7LvY2C7MNiQQxTay47JkFU/iIQbOOFI=;
        b=RTM+sWmepYgyG4PlX0waSGrbV9UP7wYW4M2qCEe1UKHiO9dORm7umo+Q/Rc64n3XFV
         Z3tnQT2l6hlublrxsn5UgvIBO1QhvxY+oj4H48+H35YMD5qtwViquqonLMXGYiTiHzyy
         Kz+4sTLU5DyKRtNVCq0i9+R5RqKKCY8Aq0WU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622589; x=1724227389;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+leSXdUbIYKI7LvY2C7MNiQQxTay47JkFU/iIQbOOFI=;
        b=cCWk4JbEOZWpZPDgOZXzn0jaqVcbDmNJol6Lu0c2JjDYoqzJL/tg4t3WYT9wfNdVJp
         RICGU/Zc3xtPpWWpXNF0YoRUyZJLQVex3cockjogc1PZRHfIn5WpBRLalbY1pVKWn7J2
         43WQlm1T10K7Q0Rl298iCMNDU7JytSe/UQyIsLxtbMKzMxC6c0hIzY5HLkflIf/ZnGWR
         lDu8mL0PFthgmBoA0bODyBFANxOzOHK0cMNYw+lnsL+2q8pyZPhx2X5ZPapOAEBoenDN
         Vr6jbVFWd+OzCL/q+nwVPP5eglQx2eFx2Jn0j8YUvIeuh518gBflOZVmfPG1KXRyrBo7
         vm/Q==
X-Gm-Message-State: AOJu0YyCSdRO6mPYxqWn2UglLKWl8qaNVMGCPIWgcprhsM9LhXoC1jc5
	Wtv1dpGaFbcY19Sf0ulxR6Pb1AQYBMKy92mYaREJRvhUygizHu34hVIwuDvIxv5kGBCt6XxWU90
	=
X-Google-Smtp-Source: AGHT+IFSexejko0IQkIwSgib3iAXK4SrWzkS3lw/GfAxjtC7UjKkrEAIdtzHFd4rHHG4DloJ3tcy/g==
X-Received: by 2002:a05:6a00:1395:b0:70a:9672:c3a2 with SMTP id d2e1a72fcca58-712673b702emr2317760b3a.24.1723622588961;
        Wed, 14 Aug 2024 01:03:08 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([115.110.236.218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac40e0sm6782479b3a.216.2024.08.14.01.03.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2024 01:03:08 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH for-next v2 4/4] RDMA/bnxt_re: Enable variable size WQEs for user space applications
Date: Wed, 14 Aug 2024 00:42:02 -0700
Message-Id: <1723621322-6920-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
References: <1723621322-6920-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Add backward compatibility code to enable variable size WQEs
only if the user lib supports it.

Signed-off-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 +++++
 include/uapi/rdma/bnxt_re-abi.h          | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2932db1..82444fd 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4233,6 +4233,11 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
 			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_POW2_DISABLED;
 			uctx->cmask |= BNXT_RE_UCNTX_CAP_POW2_DISABLED;
 		}
+		if (ureq.comp_mask & BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT) {
+			resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
+			resp.mode = rdev->chip_ctx->modes.wqe_mode;
+			uctx->cmask |= BNXT_RE_UCNTX_CAP_VAR_WQE_ENABLED;
+		}
 	}
 
 	rc = ib_copy_to_udata(udata, &resp, min(udata->outlen, sizeof(resp)));
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 7114061..6821002 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -66,6 +66,7 @@ enum bnxt_re_wqe_mode {
 
 enum {
 	BNXT_RE_COMP_MASK_REQ_UCNTX_POW2_SUPPORT = 0x01,
+	BNXT_RE_COMP_MASK_REQ_UCNTX_VAR_WQE_SUPPORT = 0x02,
 };
 
 struct bnxt_re_uctx_req {
-- 
2.5.5


