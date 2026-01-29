Return-Path: <linux-rdma+bounces-16192-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDZlM7o0e2lJCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16192-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:21:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06007AE919
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E3303017251
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E538933D4F9;
	Thu, 29 Jan 2026 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HRx8KoBn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9F32749ED
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681945; cv=none; b=QsfhH6nzZ6T0Op4+WkDR372mwcBOESYmFqLBFbXlaJx5FneAp23wp7cP0t0HIcejbavCLYsMYGuxb5pcSO+zbgCJ37KGkXA/+tM3/rYmH8udBtR1cruSYk+EK1n9xHY7Ot7T6+dA5WhlG7oGmAF5lzBUoW/EMtkIZykXqxKqMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681945; c=relaxed/simple;
	bh=s9SMeCBIy5OHALS/2Qsmcxx9kO63PUBvELqIlT4pN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqFFd1LrkKQW5O1UkImvelnB3D0aqi17Swo2Ut+NV3iEqP6ECIVtHrDhAip1ucfx/STt1os2UMC3vwbnCrH1qSptJ86BzQYlAKh/uFdoV1xuqf8Xeq83J+HpmEUfpthtIIMDEupxbkx0UqBRLOCHVX4jIMHLdsGmyXMvj04qsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HRx8KoBn; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-649389b1cc5so674931d50.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681943; x=1770286743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IvWcmc/rx7KaHrgU4HNIJiVjz2WDq/r/o3jl1SWxQ4=;
        b=S3GwAFrvtuFb4IvrzJIDyqGm/W4gEI4YfFSlP7D/Sglzh+PurG1AI1+mcP7cm/5ROC
         rQkQku3ZEruslO0UYnDWp3z5yC+K6tqLOMrrzjRlK6ZFJbtqUJF1YKnxE+8mUvgoxzzJ
         ZRxchJ7sRe5HZOcXF0IdSsvxTL51UZkRzLDMzMZbQQCKnq01ICClUiRikdEP3CEdt3pB
         6WCox6Lbh1VPWwwCzu0SMaN6HiM9ZuIYnMjgdFWq0NjC6zpbraVOV0Z6R2yKRtQlH8Jm
         llj+ThhEcJ1XRf1DixQysgtFkb7Vbzsy7d44EyKa6Nf6UC4yQeifazat5Bry+eKX9qLC
         l72w==
X-Gm-Message-State: AOJu0Yw2EoV5ehJgHy8i7MM45i05iK9l7V5BhgrO930SIs+frY9prurA
	cjzrhuwaDe8UYWFLTodKR5+bb9qPP3t4WcGo6f6NKqAq8ygd+f4hjEylLwF20Q/+sYPkR61y+9U
	7nPDID2LvBnWtM8tbWz8Z/F7y3Wff8k1ACsc5nbylPItTsBo+I8MKmjZDbgyQubVu4w4XtJ/t7f
	b+y73RKg5Bwml5PJuMw9WsygEqcegGlA2WD82OSgosSWjliJCZconzcGTIosVPAjCq/AOugoJ8D
	CNKAVbM5TDAGOcTcmDqfsLayldRnw==
X-Gm-Gg: AZuq6aLI57g037nWlQhizGpITk49atVJKPdaEoma7ftEhK71bYHngrQCyla6v/uGJUl
	ZDcJgd9q280q5VXBamz1CBTp+BjtzaKIlnS2gESmiooBt/TGh+4bQ7AhlaWIB8mJsqvzo+snedo
	Kce8CTmKpfmGxBOznfGNnhmtyRFxO8/y4cXC2EHnX5ZiCyIXD2Crcx3JfxjR6lMYgmhIsbevo/S
	jQFgmPYLC/ZLxYVo2x/jQ6a10kHhw+bxn2X+kZI/0OplTAazA19D2J3fJyTC0lsCQLgQyTX06bH
	z9Gjp7Irc+hWtMzrlFm9CLsrTRs82McHyq39JIKzTN11CV8dvfDMKaaj2h4GfQ1WbMSTv04Jb0O
	LkcNF4hg9VtnD3rNCY5yXyajQiKcIDzcHnV2jNnchUL7ijUNgLMqEgb4V1jehFX7Oo45Cj8fDAN
	NsrN46JoKEMHM4CstrN/gsxWljijcZAmc5B4CGc+z1c2/JPcCLVPfHlrDVvA==
X-Received: by 2002:a53:ac84:0:b0:646:68b4:a7e with SMTP id 956f58d0204a3-6498fc1408amr6485273d50.18.1769681943345;
        Thu, 29 Jan 2026 02:19:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64996097c05sm450426d50.7.2026.01.29.02.19.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:19:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a13be531b2so8167805ad.2
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769681942; x=1770286742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IvWcmc/rx7KaHrgU4HNIJiVjz2WDq/r/o3jl1SWxQ4=;
        b=HRx8KoBnJEDTgFfyLIRwozGNWvR2KVbrsgYJ7wQ3cpOmCzqgIxcPYnJagyJgUYGT2o
         Gdm2TNRmVFiHMXYeuqa3Id1DdSavdtcCAe3MQ5DIJd8TjBevPTbwfPi0ilx2G8XZ/qlj
         462O4+1fvegmCDbuYHBSFP7Y475JvsWnnZ8yI=
X-Received: by 2002:a17:903:1206:b0:2a7:a98b:9fa7 with SMTP id d9443c01a7336-2a870d96a7dmr75401435ad.25.1769681941676;
        Thu, 29 Jan 2026 02:19:01 -0800 (PST)
X-Received: by 2002:a17:903:1206:b0:2a7:a98b:9fa7 with SMTP id d9443c01a7336-2a870d96a7dmr75401305ad.25.1769681941270;
        Thu, 29 Jan 2026 02:19:01 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm46155295ad.3.2026.01.29.02.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:19:00 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH rdma-rext V2 5/5] RDMA/mlx5: Support rate limit only for Raw Packet QP
Date: Thu, 29 Jan 2026 15:51:33 +0530
Message-ID: <20260129102133.2878811-6-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16192-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 06007AE919
X-Rspamd-Action: no action

mlx5 based hardware supports rate limiting only on Raw ethernet QPs.
Added an explicit check to fail the operation on any other QP types.
The rate limit support has been enahanced in the stack for RC QPs too.

Compile tested only.

CC: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 69af20790481..0324909e3151 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4362,6 +4362,11 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 	optpar |= ib_mask_to_mlx5_opt(attr_mask);
 	optpar &= opt_mask[mlx5_cur][mlx5_new][mlx5_st];
 
+	if (attr_mask & IB_QP_RATE_LIMIT && qp->type != IB_QPT_RAW_PACKET) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (qp->type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
 		struct mlx5_modify_raw_qp_param raw_qp_param = {};
-- 
2.43.5


