Return-Path: <linux-rdma+bounces-18457-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YENICvRUvWlr8gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18457-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:08:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D62DB99E
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68C730E7943
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02ED302163;
	Fri, 20 Mar 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ua04ydyd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96029CB24
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015442; cv=none; b=CNRSDqfWQttmHoOl8016jjcK+lGfTtompLNOsl1d50KDzkdY2lkH9yr3yABqLSQBtIiQjPFuaPku4YKl+0bZYe4ggZLFPamAMCzDnaQoBv0I8TG38QLgOJc++lMWaUjj7oWwNdLjDudxOORsXsTdb+xWNJvWDaibEoZUB3Yz4Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015442; c=relaxed/simple;
	bh=4b5DzLM2iYYnlLL2NRQFI+6MSyRB2q/XpjpOUmzOPrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFxEI52zumlSKRmizH1yQ9XzVODw1rz3TxayVS90K0rEaInyYleqqjCezAFLpHdEEIK1NdY6k+OA4dYgYvNriyAaocZqZpjRE93FX6jF27iJrjKhnf7eMBvfJwQNJr3EaVtmtYFkgpPGhK47Kyp5Dzc1M+vVGXhAD0jnaptKpMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ua04ydyd; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-415b23dd6e5so248701fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015438; x=1774620238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AC8tEPr7uI2zSH0KNpgpheyDtm+1Xw8JdKeQvH/6eOQ=;
        b=W7USBHULiEDvuYapDThOL/xKZLRTVm3CclwD94z7bmB+lPb6+lOmtwULx2E6hDHqei
         8xyIQIvwYe6DkXQ7GxThrildI8/1Jgd/zNvb2iCBHlxOu4mS9L7OaQRKiXY7k2LW49qb
         WkvvvXInIfSQKkjB/3o608JDcsm1Git84DEHWGq6JBuY1dqN+Fi0gt1WqymH7aVTZO2g
         pIXd1VSFCoxvs2laFsYWKNn5dxpdaCY+Wt6hYniPu9+qewfYW7zV/YMga03vKC0Ysi3F
         TcgwSakhbS+XTwIzb0s3mdiS/MDMwr0Bh8qydzJ+1l+3KX8STdaMuRagR++bSW8Wmelt
         152Q==
X-Gm-Message-State: AOJu0YwMW2H6m0Yn5lofVUerxe1I81nd/Ml/oh/NOPH+15h6xb37WP/Q
	s0xVwaAxsAqeTyP9b3414bLLWofVJKtVvJ46XmbVlqlzlpGTCEW7PF0BdYUjbc4fKtq+5CirTu4
	dM2GKjXN0HEgbPb0q+6ihXN3+qhp9X0E1g7Rb6Ldvg7dV/mK3nAfOfPSxO5u6GfrthkS5WAtsX9
	g8QKMtdk8gzoCNBsnkQN3SmqNQi/pF+8N7kl2kP5axL5z8sel8+N9Gw/X5TJF3Uw8DVDSUQV+3v
	fEo5blsO0ZaMoe2unmLrmeOxsr7
X-Gm-Gg: ATEYQzz6SDXCfEQBJj3klwnVQLL0eluSXO8ygju8znvLY5w2n23x0Hvd/K7bjewiqtf
	D8qOYRs3jlYKvjpls4EzP7WUBXb4QvTa7tGmT75XFQfzb8wFl7wfUTJXRtmtu4r8KIsV9nz2DP4
	HCB+iP47wUYqGrUt9hRvdw7LVDXXhK/JzOu3DSn5iuQ32m+AkW8hn+8oNaOV7x6Won+R8690O+X
	3p71D7hwW3LyNUHtwO71AzIbmqxUL0MhVUDo1euM+saMYiysiJaxPz7+EQLo2nHxPW5qu22XA9i
	VLjAiIzTsVs1rRu0gtOXWL4Omh4LKtz7t9aNaru0ZcAwErjeA3KsW0MJf2DhOvYGqIk1mVpvroF
	BYWNUhUNqUm50+vpcyUD5ho2KZfVX9I/MBtAuHWqZf7W6BXtJB+7SMaQEPYsJ0ecR0bX+ZaAdzT
	MfWxZrwyGgYXFBVM4iEk4vS0W7qQhVz7+a/Iw1I7lzuHhrV3LPO1FANcHj+/pVfVD1R1C682s=
X-Received: by 2002:a05:6871:580a:b0:404:3ecf:9ae5 with SMTP id 586e51a60fabf-41c1147ff14mr1921333fac.40.1774015432529;
        Fri, 20 Mar 2026 07:03:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-41c1493a99esm347307fac.4.2026.03.20.07.03.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:03:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829b8bb5173so302707b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 07:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774015431; x=1774620231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC8tEPr7uI2zSH0KNpgpheyDtm+1Xw8JdKeQvH/6eOQ=;
        b=Ua04ydydXyLbHLAGRfzrDoxTZlSMFlHQbxUu6tsVTyRUf13PuHJpAVbNd6rKXHRtg9
         7shp5LyWzMGYJmQEUGcV9/OQe+cMGX+pc9kfklRYMMOgUKelz8Iv611ZGgk8WDZm9c5E
         mExBmeiIZ1lHNQiVuBjJs32+2cisPyFeS8kDA=
X-Received: by 2002:a05:6a00:bc0b:b0:81f:3c7c:8591 with SMTP id d2e1a72fcca58-82a8c382388mr2282959b3a.50.1774015430678;
        Fri, 20 Mar 2026 07:03:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc0b:b0:81f:3c7c:8591 with SMTP id d2e1a72fcca58-82a8c382388mr2282918b3a.50.1774015429984;
        Fri, 20 Mar 2026 07:03:49 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2136099b3a.45.2026.03.20.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:03:49 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 5/9] RDMA/bnxt_re: Update msn table size for app allocated QPs
Date: Fri, 20 Mar 2026 19:24:33 +0530
Message-ID: <20260320135437.48716-6-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
References: <20260320135437.48716-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18457-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A03D62DB99E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, the driver shouldn't use slots/round-up logic
to compute the msn table size. The application handles this logic
and computes 'sq_npsn' and passes it to the driver using a new uapi
parameter.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 23 +++++++++++++++--------
 include/uapi/rdma/bnxt_re-abi.h          |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index b8da3ae81043..ba49ca108b7d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1664,7 +1664,9 @@ static int bnxt_re_init_qp_type(struct bnxt_re_dev *rdev,
 	return qptype;
 }
 
-static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
+static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp,
+					      bool app_qp,
+					      struct bnxt_re_qp_req *req)
 {
 	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
 	struct bnxt_qplib_q *sq = &qplib_qp->sq;
@@ -1687,12 +1689,17 @@ static void bnxt_re_qp_calculate_msn_psn_size(struct bnxt_re_qp *qp)
 
 	/* Update msn tbl size */
 	if (qplib_qp->is_host_msn_tbl && qplib_qp->psn_sz) {
-		if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
-		else
-			qplib_qp->msn_tbl_sz =
-				roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode)) / 2;
+		if (!app_qp) {
+			if (wqe_mode == BNXT_QPLIB_WQE_MODE_STATIC)
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode));
+			else
+				qplib_qp->msn_tbl_sz =
+					roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, wqe_mode))
+						/ 2;
+		} else {
+			qplib_qp->msn_tbl_sz = req->sq_npsn / 2; /* WQE_MODE_VARIABLE */
+		}
 		qplib_qp->msn = 0;
 	}
 }
@@ -1775,7 +1782,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 			return rc;
 	}
 
-	bnxt_re_qp_calculate_msn_psn_size(qp);
+	bnxt_re_qp_calculate_msn_psn_size(qp, app_qp, ureq);
 
 	rc = bnxt_re_setup_qp_hwqs(qp);
 	if (rc)
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 40955eaba32e..db8400f2ce3b 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -135,6 +135,7 @@ struct bnxt_re_qp_req {
 	__aligned_u64 qp_handle;
 	__aligned_u64 comp_mask;
 	__u32 sq_slots;
+	__u32 sq_npsn;
 };
 
 struct bnxt_re_qp_resp {
-- 
2.51.2.636.ga99f379adf


