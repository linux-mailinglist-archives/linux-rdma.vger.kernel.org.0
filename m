Return-Path: <linux-rdma+bounces-18730-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN4MMfdNxmmgIAUAu9opvQ
	(envelope-from <linux-rdma+bounces-18730-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:29:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D16341B75
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A949304A111
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9433D904C;
	Fri, 27 Mar 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UeZbKX//"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67893C1998
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603626; cv=none; b=CcTvwafzxzNnsw7ZItCzAVFH8ve26y03Czi1lCNMLWWZpmP4x3fEat9xuS4WD0JTE+qEP4l4DpYnecwvZQF/xnah552WKs2HsZ53c9IqzmWM5EvEClAuad99abBXJjuQuve6OKlrrzogVPGywWj/54gOgunaWZGfjJAaWymZ4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603626; c=relaxed/simple;
	bh=/BsDr+PeS3aHSvjXoAyvdH0d8ns9uDFh9T2D2YTQ8Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=St5XZ/JYcbr/DpAG8QaLKDGCt7dnHfeuFjbsT6Pzf2D5M3PpPjcb6b1gInWZRHE6N1RsEc1fW1FHZMyRrrXsT0QzuGDdJ0Do4s7lGt7U1w8pZ24nGgiPqW7Y9NkS8AhfH5AfPl2YxuJfo5RfBOhPn790LyTaqoMvZ2HBYSbQ96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UeZbKX//; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8cfc40e4158so230199385a.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603623; x=1775208423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz/emZIdSAHuM+/R+FZjeiRxTiuN0XZhormi4j7ftMg=;
        b=a8zgQeJQ5MJPlV4zSfQC6lstgRaTeSJOkaM9pnR0gR9J0oZfJl9nM/AjOI/LoGwp7W
         nWzLC1MWQppFX6MVDueDvuzucYfFcE5OmrDWxSdt68Zx6CNYFDRNE+NUq1r93TsJtG36
         NwHchTVax0rG9B4OFrDT/r8Mb7VV1Gv4vmhRv0T3581VR8M71PAGxxkLveqAjoK+/ZkT
         keQcoDBkiU6tqodyMCFtwCAkTZK6DQvGBr0GAnEqcrczij21iZfwwIHvmR88HzTLCj4A
         +fYxc00FjRXvxA6Y+Exb7nPmasLQpTKGWsxCAYze1o7URUlLFEkZreqvls9B03DlybxJ
         Atvg==
X-Gm-Message-State: AOJu0YyjeVabbvmnln7VoJipX6NlM4oWjnfj6gArhvXj+2TifgH9Hi9G
	kAJhHIphgQJvRNchMRJQ7JoEEsv1DVFWAKRVzCpUw9v89RIX468tdtYF8r1lfHBd/SV+XXXzMFw
	4p8oyLGsarG/xqo5kKt9SN61y3+p8haXnXuNuYdsQyKrmo3pDpUZg4+pLgeH6mAKQqZ8VmRCl9P
	bNToie8HFXS/6U/9f+DKeXL1bgYcP3B3MhbzJeB4t9975tnnXszUv6LyRMz7C1ET8I3wEXOJ53O
	8pLGEkE4w6hoChSNKPCRz5gUAt8
X-Gm-Gg: ATEYQzxSTw1WRuJkDmxy1+8DM41rfOTER+pE7R/PXBFl/REyAoGsltGmZ9dy/xMMjJ4
	o576+7ECRzZ6BUcXY1+7vXO9vmlq/3hBiZE6oMEMOiRIQUSo8lynVNHMyTOkHWASf8JoFrznb5G
	FEj6dp1HCahClNvcx9nEwsrXYBTCz36fYVd/b3+iS9hQc6g77m5IX/DRJAA4fTUejfTQ1kB5KCX
	B7G15K3kYkYXhXigsMtABSq4ora9139A2J0Z97IZzI1kuXS0uBCkYHmvZnuUbGnqXJb35Gu5795
	Q8Rnz/AwPTxmM4BPHvBJZsJb+YSgbuq3h3hDMRW3aO59tTJz4T7/YYQIy5qtxBj7cKB4Z4FMUc0
	jqIiB///2YJ5Yo6mLORj3PfbdhVFEy9ifjjxwF3xGWZ6r5ncPBzzLfGXGenLYe00mnYcg/3pP0H
	2u16MRvwLfRQVHo/v0
X-Received: by 2002:a05:6214:21e8:b0:89c:8a0f:566a with SMTP id 6a1803df08f44-89ce8ebcb3amr19841286d6.37.1774603623543;
        Fri, 27 Mar 2026 02:27:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89cd5847f00sm6317426d6.2.2026.03.27.02.27.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79a6e1a40c4so30803887b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603623; x=1775208423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz/emZIdSAHuM+/R+FZjeiRxTiuN0XZhormi4j7ftMg=;
        b=UeZbKX//JnMLqevzUN+3/19cXRR0XP5xnZu+FHm1BVLHRgaUFzYX3hfvv9LrcZBnJC
         g78uzFXsKJqvIgEEdfYq6B28YFF2yi0HocYUf5kRqhxreY9SabR2fzpitDawWzH0+tLw
         btscNsUvlm09v5xaPBF/kMzu85REV4I3z0R1Y=
X-Received: by 2002:a05:690c:e3c4:b0:798:6042:12f8 with SMTP id 00721157ae682-79bde13360fmr15103117b3.55.1774603622876;
        Fri, 27 Mar 2026 02:27:02 -0700 (PDT)
X-Received: by 2002:a05:690c:e3c4:b0:798:6042:12f8 with SMTP id 00721157ae682-79bde13360fmr15102957b3.55.1774603622424;
        Fri, 27 Mar 2026 02:27:02 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:27:01 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 3/8] RDMA/bnxt_re: Update sq depth for app allocated QPs
Date: Fri, 27 Mar 2026 14:47:50 +0530
Message-ID: <20260327091755.47754-4-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18730-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D0D16341B75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, there's no need to reserve extra slots.
The application accounts for this while allocating the SQ.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 61879222248d..9a101f862c32 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1542,7 +1542,8 @@ static void bnxt_re_adjust_gsi_rq_attr(struct bnxt_re_qp *qp)
 static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 				struct ib_qp_init_attr *init_attr,
 				struct bnxt_re_ucontext *uctx,
-				struct bnxt_re_qp_req *ureq)
+				struct bnxt_re_qp_req *ureq,
+				bool app_qp)
 {
 	struct bnxt_qplib_dev_attr *dev_attr;
 	struct bnxt_qplib_qp *qplqp;
@@ -1583,13 +1584,18 @@ static int bnxt_re_init_sq_attr(struct bnxt_re_qp *qp,
 			sq->max_sw_wqe = sq->max_wqe;
 
 	}
-	sq->q_full_delta = diff + 1;
-	/*
-	 * Reserving one slot for Phantom WQE. Application can
-	 * post one extra entry in this case. But allowing this to avoid
-	 * unexpected Queue full condition
-	 */
-	qplqp->sq.q_full_delta -= 1;
+	if (!app_qp) {
+		sq->q_full_delta = diff + 1;
+		/*
+		 * Reserving one slot for Phantom WQE. Application can
+		 * post one extra entry in this case. But allowing this to avoid
+		 * unexpected Queue full condition
+		 */
+		qplqp->sq.q_full_delta -= 1;
+	} else {
+		sq->q_full_delta = 0;
+	}
+
 	qplqp->sq.sg_info.pgsize = PAGE_SIZE;
 	qplqp->sq.sg_info.pgshft = PAGE_SHIFT;
 
@@ -1738,7 +1744,7 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 		bnxt_re_adjust_gsi_rq_attr(qp);
 
 	/* Setup SQ */
-	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq);
+	rc = bnxt_re_init_sq_attr(qp, init_attr, uctx, ureq, app_qp);
 	if (rc)
 		return rc;
 	if (init_attr->qp_type == IB_QPT_GSI)
-- 
2.51.2.636.ga99f379adf


