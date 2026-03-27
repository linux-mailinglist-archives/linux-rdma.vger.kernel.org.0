Return-Path: <linux-rdma+bounces-18731-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO/UAFxPxmk2IgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18731-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54641341CB1
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0716730D7DC0
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153C2FDC30;
	Fri, 27 Mar 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JX0j6qvi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com [74.125.82.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3AB3D3489
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603630; cv=none; b=ELzWr+NhxpOZ2vgMyV5gv+I3Yo2EJfOT07jOAlJ//rKEcLinWi6uYSWyFzuY+GEtZbNLXqPL3QmBA1ENNkKmfVovs5L0YY25btwnnH9kVWEwiACPqKFdEdxAkCVYcvj/MNBa2FzQlbFZMmsJVjPbcWs0A0A9hy/aftP16JfknW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603630; c=relaxed/simple;
	bh=QMAgrgO1mCIUznucBxL0y6wKFMaxWmt3H321dJNZtTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuXmfFBK0v9xL1qllZcrzDKMgY6hOunZPwRzGXztLnVBuqrRgTrNyD6NMMkUIXOmsmay+A1o89MtXg2fhpdcJNgQG8JuAYGoPBqIrOCmEHy1aPlT4QVJ8c36w1xMh9zuC55JfgtcNOXeHQcPhjBhAUs2DAABm/eHYquUgobXADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JX0j6qvi; arc=none smtp.client-ip=74.125.82.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dy1-f227.google.com with SMTP id 5a478bee46e88-2c17446ba8dso1069555eec.1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603628; x=1775208428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbMo+omYFvnfafxDz+TN25VYrV5uLdeTnphyJhj4mQc=;
        b=j1tXXcOn38mSPsVuK5NJcK/Fd6GgWRmfQPNLSSpA5VBiF6FZE3+n2MDaiyz8TOAeG3
         ePhSA3CPiXFXtyRWudWd6MzlavYNrTx8mDHysV0hRwDEzEZMba218uFwtm+WD28iduXb
         mNA2HP9eFKeC0eeB1NR8VtvLz8t65xnnsF0KeAQILct6/prZEtLVwoiJVfRJ0QmZ4zD5
         Nq7OyscSbj1Ju20FD3er5h/SyKfqLXs2GMaElakPek8oxTNXMi7izgyrxYcx7Mo/bNI3
         MDHGphBUY9D5uU1tLkNGuLp9lp5oc0YOnCf79Gu5BSt9GDEnjIoIVEUUTNtBuo3a58F2
         gYqg==
X-Gm-Message-State: AOJu0YzSQJQK+rfTtuckNEpyuVX+UrIunZfECyQsxqq44KY0qSLVCphd
	I+fhfQ1Wm7fdXU/Si0sbKYJ0WmunOVI5cRhNJGF4SiCLRevWd4++MZ8v7U5VFL3Z0WtFbtwNfJk
	AuQB+D5X/DMpI+LqcFc9t+U62jqexg991q1EDHC3Bvle8DX1lzRH2qjIhkZoK6Q/6yV7vRJ8b4A
	yfWZ6VbIYpht4g2edX+zRET8xI5i1Rzu157LxCiOslVoHNCqg/qnSIAI9Bcmwh/M2ZtK+VIy76F
	Y1aYunpJ/ybIUm2Qv5fGfGSXtNb
X-Gm-Gg: ATEYQzzK4ida9uBCv+YBd7+2SOXNa+XaBfXftFWV188IJ6toLfQGQJbHsLUsqfSj2EO
	aIFqRY4kWJ6r5h5RB55wLNtz/C1KWBqA0qKETdOyBDr4lDx/O7oJPSSCRpa7xNZ5RQkE5Ka1b7O
	iK4FV2Y4LAC20EW73QX3le+Han1XdXxCP0nZ8fDR8KSwgR4ashUUpbTedM7fR+3YA2OP3Mauh3I
	TRLM4ZA8SPaGpyi0OTjdK6XYYHPIbUzzWfQdTO9QFTWMhUVRHzsyy47HjOHR2OmvReyFV6ffADF
	jgRovgU5ApLu3f5iz1mGC6xOoinX5qcdUQMT7kf/Nt197SXWQelF+8KHIjcI0uPeQp/FUs3uLrO
	HdlQxS/JK07pM6AK91QwZPpbESFo4xoV0fs0nQntHXqvlMKusiMg/0J0PTSmNGPcXKYcgZOEf3b
	wQspGLaODxccUWvRHxU2ShLpRLW8NRVPpJ9V1yIo1MO0+WAk+AEgcLqRHwCOH62S2AmjkO
X-Received: by 2002:a05:7301:100c:b0:2be:17b1:e49f with SMTP id 5a478bee46e88-2c1771575b0mr2361432eec.4.1774603627860;
        Fri, 27 Mar 2026 02:27:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2c16ec4191bsm511735eec.3.2026.03.27.02.27.07
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:27:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-794b240c0d3so49622637b3.0
        for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774603626; x=1775208426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbMo+omYFvnfafxDz+TN25VYrV5uLdeTnphyJhj4mQc=;
        b=JX0j6qvi60PKSD0IeqXo4yGl7v6IW790dB4wK3Cp8vrHmBc3y+rDY4dpAaiymkDYA8
         saUo7ihLTERptfJtgGSPwEF7RNmzw88CuZimG8FOKKlT/miiOQtbzhZneK/A70XFLZ+9
         GGmi8YCePy4Ria2NgpMf4Nt6SYrV/OjCL0Bzw=
X-Received: by 2002:a05:690c:4886:b0:798:711f:a0df with SMTP id 00721157ae682-79bde385480mr11434447b3.13.1774603626373;
        Fri, 27 Mar 2026 02:27:06 -0700 (PDT)
X-Received: by 2002:a05:690c:4886:b0:798:711f:a0df with SMTP id 00721157ae682-79bde385480mr11434297b3.13.1774603625915;
        Fri, 27 Mar 2026 02:27:05 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm25718307b3.22.2026.03.27.02.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 02:27:05 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v2 4/8] RDMA/bnxt_re: Update umem for app allocated QPs
Date: Fri, 27 Mar 2026 14:47:51 +0530
Message-ID: <20260327091755.47754-5-sriharsha.basavapatna@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18731-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 54641341CB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For app allocated QPs, use sq_umem and rq_umem provided by the
application via uverbs layer. The uverbs layer maps these app
provided buffers before calling create_qp(). Use the new API
ib_umem_list_load_or_get(). The uverbs layer frees these buffers
if there's any error during QP creation or when the QP gets
destroyed. The driver must not free these umems, so delete the
driver function bnxt_re_qp_free_umem().

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 45 ++++++++----------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9a101f862c32..b249bc2d2583 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -995,12 +995,6 @@ static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
 		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
 }
 
-static void bnxt_re_qp_free_umem(struct bnxt_re_qp *qp)
-{
-	ib_umem_release(qp->rumem);
-	ib_umem_release(qp->sumem);
-}
-
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -1047,8 +1041,6 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
 		bnxt_re_del_unique_gid(rdev);
 
-	bnxt_re_qp_free_umem(qp);
-
 	/* Flush all the entries of notification queue associated with
 	 * given qp.
 	 */
@@ -1196,47 +1188,44 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rdev, struct bnxt_re_pd *pd,
 		bytes += bnxt_re_get_psn_bytes(rdev, cntx, qplib_qp, ureq);
 
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qpsva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_list_load_or_get(qp->ib_qp.umem_list,
+					UVERBS_BUF_QP_SQ_BUF,
+					&rdev->ibdev, ureq->qpsva,
+					bytes, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem))
 		return PTR_ERR(umem);
 
-	qp->sumem = umem;
-	rc = bnxt_re_setup_sginfo(rdev, qp->sumem, &qplib_qp->sq.sg_info);
+	rc = bnxt_re_setup_sginfo(rdev, umem, &qplib_qp->sq.sg_info);
 	if (rc)
-		goto fail;
+		return rc;
+	qp->sumem = umem;
 
 	if (qp->qplib_qp.srq)
 		goto done;
 
 	bytes = (qplib_qp->rq.max_wqe * qplib_qp->rq.wqe_size);
 	bytes = PAGE_ALIGN(bytes);
-	umem = ib_umem_get(&rdev->ibdev, ureq->qprva, bytes,
-			   IB_ACCESS_LOCAL_WRITE);
+	umem = ib_umem_list_load_or_get(qp->ib_qp.umem_list,
+					UVERBS_BUF_QP_RQ_BUF,
+					&rdev->ibdev, ureq->qprva,
+					bytes, IB_ACCESS_LOCAL_WRITE);
 	if (IS_ERR(umem)) {
 		rc = PTR_ERR(umem);
 		goto fail;
 	}
 
-	qp->rumem = umem;
-	rc = bnxt_re_setup_sginfo(rdev, qp->rumem, &qplib_qp->rq.sg_info);
+	rc = bnxt_re_setup_sginfo(rdev, umem, &qplib_qp->rq.sg_info);
 	if (rc)
-		goto rqfail;
+		goto fail;
+	qp->rumem = umem;
 
 done:
 	qplib_qp->qp_handle = ureq->qp_handle;
 	qplib_qp->dpi = &cntx->dpi;
 	qplib_qp->is_user = true;
 	return 0;
-
-rqfail:
-	ib_umem_release(qp->rumem);
-	qp->rumem = NULL;
-	memset(&qplib_qp->rq.sg_info, 0, sizeof(qplib_qp->rq.sg_info));
 fail:
-	ib_umem_release(qp->sumem);
 	qp->sumem = NULL;
-	memset(&qplib_qp->sq.sg_info, 0, sizeof(qplib_qp->sq.sg_info));
 	return rc;
 }
 
@@ -1760,12 +1749,9 @@ static int bnxt_re_init_qp_attr(struct bnxt_re_qp *qp, struct bnxt_re_pd *pd,
 
 	rc = bnxt_re_setup_qp_hwqs(qp);
 	if (rc)
-		goto free_umem;
+		return rc;
 
 	return 0;
-free_umem:
-	bnxt_re_qp_free_umem(qp);
-	return rc;
 }
 
 static int bnxt_re_create_shadow_gsi(struct bnxt_re_qp *qp,
@@ -1985,7 +1971,6 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 	bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp);
 free_hwq:
 	bnxt_qplib_free_qp_res(&rdev->qplib_res, &qp->qplib_qp);
-	bnxt_re_qp_free_umem(qp);
 fail:
 	return rc;
 }
-- 
2.51.2.636.ga99f379adf


