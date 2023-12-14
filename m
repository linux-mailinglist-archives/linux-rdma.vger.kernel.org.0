Return-Path: <linux-rdma+bounces-424-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296081286F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Dec 2023 07:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867AC1F21B7E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Dec 2023 06:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C6D2FD;
	Thu, 14 Dec 2023 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JfIBwr8b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB0F5
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 22:47:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d098b87eeeso70149315ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 22:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1702536461; x=1703141261; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=na/u4PTrX4yDEOWJowFNSaCIC9O3usVlRZm8m4vYA28=;
        b=JfIBwr8b4ed1Jqa42kzBeqCZRW9LLy4N7aNQq9NB5Zu9/mmKrYB8OPDen06mKCO34Q
         068CpL60YtWoFGjVwKS8qX8bK8zJn45NANppfGVcWN06e6V4kdAnFufL/7SBKF5H2ewK
         KPMabdqhvpE79LRH7dRMBo6nyhTwLizyyCkYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536461; x=1703141261;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na/u4PTrX4yDEOWJowFNSaCIC9O3usVlRZm8m4vYA28=;
        b=nV2I0NSkvpLFwAGeu1ic8hWnB6/UAAnp323PDCDTPUvbzEwre/pHh+tAKEAMt6/WLP
         hpNh5GDnkKPU6fjn4nKQuUtNkuERVZq+xwGikIR8TkdttO1c1oIkzIAFeRgQcMXjSrWM
         rJlliHCpLD4/9x7KQp88hk6dH7YtG7x+8NxG+g4gszc7t3/GNxhBQEG8BV90tVdeFO/H
         KeWesvArpba7+MbJ7Hk/jts0brEwJRCf4zZGqhm3ag0zYEj4Xdt1qSwyi5qwe5cO2Oz/
         QGuRghBIqf62g72nrn2mj7I+0e+Y+titWTWIsKUKT6Y5EDLXBq1qOzH0sGjrn1fRRFLj
         OYPQ==
X-Gm-Message-State: AOJu0Yw40QA8OOjK9OJar1mNnmiHHqmpnoYTb/uy50DpgfH9VmfZt1x7
	DCIl8QwI5POGnLBCyJmy8/OtsnvGiRpoKf/2Zfg=
X-Google-Smtp-Source: AGHT+IF67VrxLLbhT30nP5jiRFHc/CAetNekS6Z10alFnr5e0envDue3oOnhv/Ycq6Hwytd1WmF7EA==
X-Received: by 2002:a17:902:7ed0:b0:1d1:cc09:50ac with SMTP id p16-20020a1709027ed000b001d1cc0950acmr7405227plb.108.1702536460868;
        Wed, 13 Dec 2023 22:47:40 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902a70d00b001cf6453b237sm11637446plq.236.2023.12.13.22.47.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Dec 2023 22:47:39 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/2] RDMA/bnxt_re: Share a page to expose per CQ info with userspace
Date: Wed, 13 Dec 2023 22:31:24 -0800
Message-Id: <1702535484-26844-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1702535484-26844-1-git-send-email-selvin.xavier@broadcom.com>
References: <1702535484-26844-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fde419060c72a8c9"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

--000000000000fde419060c72a8c9

Gen P7 adapters needs to share a toggle bits information received
in kernel driver with the user space. User space needs this
info during the request notify call back to arm the CQ.

User space application can get this page using the
UAPI routines. Library will mmap this page and get the
toggle bits to be used in the next ARM Doorbell.

Uses a hash list to map the CQ structure from the CQ ID.
CQ structure is retrieved from the hash list while the
library calls the UAPI routine to get the toggle page
mapping. Currently the full page is mapped per CQ. This
can be optimized to enable multiple CQs from the same
application share the same page and different offsets
in the page.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  3 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 61 +++++++++++++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  2 +
 drivers/infiniband/hw/bnxt_re/main.c      | 10 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 +++
 include/uapi/rdma/bnxt_re-abi.h           |  5 +++
 6 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 9fd9849..9dca451 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -41,6 +41,7 @@
 #define __BNXT_RE_H__
 #include <rdma/uverbs_ioctl.h>
 #include "hw_counters.h"
+#include <linux/hashtable.h>
 #define ROCE_DRV_MODULE_NAME		"bnxt_re"
 
 #define BNXT_RE_DESC	"Broadcom NetXtreme-C/E RoCE Driver"
@@ -135,6 +136,7 @@ struct bnxt_re_pacing {
 #define BNXT_RE_DB_FIFO_ROOM_SHIFT 15
 #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
 
+#define MAX_CQ_HASH_BITS		(16)
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -189,6 +191,7 @@ struct bnxt_re_dev {
 	struct bnxt_re_pacing pacing;
 	struct work_struct dbq_fifo_check_work;
 	struct delayed_work dbq_pacing_work;
+	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 758ea02..7213dc7 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -50,6 +50,7 @@
 #include <rdma/ib_mad.h>
 #include <rdma/ib_cache.h>
 #include <rdma/uverbs_ioctl.h>
+#include <linux/hashtable.h>
 
 #include "bnxt_ulp.h"
 
@@ -2910,14 +2911,20 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
 /* Completion Queues */
 int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
-	struct bnxt_re_cq *cq;
+	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_qplib_nq *nq;
 	struct bnxt_re_dev *rdev;
+	struct bnxt_re_cq *cq;
 
 	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
 	rdev = cq->rdev;
 	nq = cq->qplib_cq.nq;
+	cctx = rdev->chip_ctx;
 
+	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+		free_page((unsigned long)cq->uctx_cq_page);
+		hash_del(&cq->hash_entry);
+	}
 	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
 	ib_umem_release(cq->umem);
 
@@ -2935,10 +2942,11 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	struct bnxt_re_ucontext *uctx =
 		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
 	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
-	int rc, entries;
-	int cqe = attr->cqe;
+	struct bnxt_qplib_chip_ctx *cctx;
 	struct bnxt_qplib_nq *nq = NULL;
+	int rc = -ENOMEM, entries;
 	unsigned int nq_alloc_cnt;
+	int cqe = attr->cqe;
 	u32 active_cqs;
 
 	if (attr->flags)
@@ -2951,6 +2959,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	}
 
 	cq->rdev = rdev;
+	cctx = rdev->chip_ctx;
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
 	entries = bnxt_re_init_depth(cqe + 1, uctx);
@@ -3012,22 +3021,32 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	spin_lock_init(&cq->cq_lock);
 
 	if (udata) {
-		struct bnxt_re_cq_resp resp;
-
+		struct bnxt_re_cq_resp resp = {};
+
+		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
+			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
+			/* Allocate a page */
+			cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
+			if (!cq->uctx_cq_page)
+				goto c2fail;
+			resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
+		}
 		resp.cqid = cq->qplib_cq.id;
 		resp.tail = cq->qplib_cq.hwq.cons;
 		resp.phase = cq->qplib_cq.period;
 		resp.rsvd = 0;
-		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		rc = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
 		if (rc) {
 			ibdev_err(&rdev->ibdev, "Failed to copy CQ udata");
 			bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
-			goto c2fail;
+			goto free_mem;
 		}
 	}
 
 	return 0;
 
+free_mem:
+	free_page((unsigned long)cq->uctx_cq_page);
 c2fail:
 	ib_umem_release(cq->umem);
 fail:
@@ -4214,6 +4233,19 @@ void bnxt_re_dealloc_ucontext(struct ib_ucontext *ib_uctx)
 	}
 }
 
+static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq_id)
+{
+	struct bnxt_re_cq *cq = NULL, *tmp_cq;
+
+	hash_for_each_possible(rdev->cq_hash, tmp_cq, hash_entry, cq_id) {
+		if (tmp_cq->qplib_cq.id == cq_id) {
+			cq = tmp_cq;
+			break;
+		}
+	}
+	return cq;
+}
+
 /* Helper function to mmap the virtual memory from user app */
 int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
 {
@@ -4442,10 +4474,12 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 	struct bnxt_re_ucontext *uctx;
 	struct ib_ucontext *ib_uctx;
 	struct bnxt_re_dev *rdev;
+	struct bnxt_re_cq *cq;
 	u64 mem_offset;
 	u64 addr = 0;
 	u32 length;
 	u32 offset;
+	u32 cq_id;
 	int err;
 
 	ib_uctx = ib_uverbs_get_ucontext(attrs);
@@ -4461,6 +4495,19 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
 
 	switch (res_type) {
 	case BNXT_RE_CQ_TOGGLE_MEM:
+		err = uverbs_copy_from(&cq_id, attrs, BNXT_RE_TOGGLE_MEM_RES_ID);
+		if (err)
+			return err;
+
+		cq = bnxt_re_search_for_cq(rdev, cq_id);
+		if (!cq)
+			return -EINVAL;
+
+		length = PAGE_SIZE;
+		addr = (u64)cq->uctx_cq_page;
+		mmap_flag = BNXT_RE_MMAP_TOGGLE_PAGE;
+		offset = 0;
+		break;
 	case BNXT_RE_SRQ_TOGGLE_MEM:
 		break;
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index da3fe01..b267d6d 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -108,6 +108,8 @@ struct bnxt_re_cq {
 	struct ib_umem		*umem;
 	struct ib_umem		*resize_umem;
 	int			resize_cqe;
+	void			*uctx_cq_page;
+	struct hlist_node	hash_entry;
 };
 
 struct bnxt_re_mr {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 7f4f6db..eb03eba 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -54,6 +54,7 @@
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_addr.h>
+#include <linux/hashtable.h>
 
 #include "bnxt_ulp.h"
 #include "roce_hsi.h"
@@ -136,6 +137,8 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
 	if (bnxt_re_hwrm_qcaps(rdev))
 		dev_err(rdev_to_dev(rdev),
 			"Failed to query hwrm qcaps\n");
+	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx))
+		cctx->modes.toggle_bits |= BNXT_QPLIB_CQ_TOGGLE_BIT;
 }
 
 static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
@@ -1206,9 +1209,13 @@ static int bnxt_re_cqn_handler(struct bnxt_qplib_nq *nq,
 {
 	struct bnxt_re_cq *cq = container_of(handle, struct bnxt_re_cq,
 					     qplib_cq);
+	u32 *cq_ptr;
 
 	if (cq->ib_cq.comp_handler) {
-		/* Lock comp_handler? */
+		if (cq->uctx_cq_page) {
+			cq_ptr = (u32 *)cq->uctx_cq_page;
+			*cq_ptr = cq->qplib_cq.toggle;
+		}
 		(*cq->ib_cq.comp_handler)(&cq->ib_cq, cq->ib_cq.cq_context);
 	}
 
@@ -1730,6 +1737,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 		 */
 		bnxt_re_vf_res_config(rdev);
 	}
+	hash_init(rdev->cq_hash);
 
 	return 0;
 free_sctx:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 382d89f..61628f7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -55,6 +55,12 @@ struct bnxt_qplib_drv_modes {
 	u8	wqe_mode;
 	bool db_push;
 	bool dbr_pacing;
+	u32 toggle_bits;
+};
+
+enum bnxt_re_toggle_modes {
+	BNXT_QPLIB_CQ_TOGGLE_BIT = 0x1,
+	BNXT_QPLIB_SRQ_TOGGLE_BIT = 0x2,
 };
 
 struct bnxt_qplib_chip_ctx {
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 9b9eb10..c0c34ac 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -102,11 +102,16 @@ struct bnxt_re_cq_req {
 	__aligned_u64 cq_handle;
 };
 
+enum bnxt_re_cq_mask {
+	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
+};
+
 struct bnxt_re_cq_resp {
 	__u32 cqid;
 	__u32 tail;
 	__u32 phase;
 	__u32 rsvd;
+	__aligned_u64 comp_mask;
 };
 
 struct bnxt_re_resize_cq_req {
-- 
2.5.5


--000000000000fde419060c72a8c9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQfAYJKoZIhvcNAQcCoIIQbTCCEGkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3TMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVswggRDoAMCAQICDHL4K7jH/uUzTPFjtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDdaFw0yNTA5MTAwODE4NDdaMIGc
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xIjAgBgNVBAMTGVNlbHZpbiBUaHlwYXJhbXBpbCBYYXZpZXIx
KTAnBgkqhkiG9w0BCQEWGnNlbHZpbi54YXZpZXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEA4/0O+hycwcsNi4j4tTBav8CvSVzv5i1Zk0tYtK7mzA3r8Ij35v5j
L2NsFikHjmHCDfvkP6XrWLSnobeEI4CV0PyrqRVpjZ3XhMPi2M2abxd8BWSGDhd0d8/j8VcjRTuT
fqtDSVGh1z3bqKegUA5r3mbucVWPoIMnjjCLCCim0sJQFblBP+3wkgAWdBcRr/apKCrKhnk0FjpC
FYMZp2DojLAq9f4Oi2OBetbnWxo0WGycXpmq/jC4PUx2u9mazQ79i80VLagGRshWniESXuf+SYG8
+zBimjld9ZZnwm7itHAZdtme4YYFxx+EHa4PUxPV8t+hPHhsiIjirPa1pVXPbQIDAQABo4IB2zCC
AdcwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAu
Y3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0
cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBA
MD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNybDAlBgNVHREEHjAcgRpzZWx2aW4ueGF2aWVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU3TaH
dsgUhTW3LwObmZ20fj+8Xj8wDQYJKoZIhvcNAQELBQADggEBAAbt6Sptp6ZlTnhM2FDhkVXks68/
iqvfL/e8wSPVdBxOuiP+8EXGLV3E72KfTTJXMbkcmFpK2K11poBDQJhz0xyOGTESjXNnN6Eqq+iX
hQtF8xG2lzPq8MijKI4qXk5Vy5DYfwsVfcF0qJw5AhC32nU9uuIPJq8/mQbZfqmoanV/yadootGr
j1Ze9ndr+YDXPpCymOsynmmw0ErHZGGW1OmMpAEt0A+613glWCURLDlP8HONi1wnINV6aDiEf0ad
9NMGxDsp+YWiRXD3txfo2OMQbpIxM90QfhKKacX8t1J1oAAWxDrLVTJBXBNvz5tr+D1sYwuye93r
hImmkM1unboxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIw
Agxy+Cu4x/7lM0zxY7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIML+yaC8EzTX
SGpSzeM7SC0HHHx/iHvfEhMp37ZwBbcYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMTIxNDA2NDc0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJ
YIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcN
AQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBO50PJV0csq8nGqfh8PogDqKqNkKF0
7WyOr94yzphAfie2Yvlnw1sOjfXJRm5yXiTQzkm7G54C+iacKT/4MdPrhENb7F3csps2iLQxMlpS
SY4S0LPDxiZbLXLVcNrurcaX6Ez1NfINEcqsek3EH+wlF5t8/H1ZSqnRTly18/cP+FZhYacvTDlx
HEGeMcIOoEVSZuv66jfUcbSFP4jYNSc/O2T0zEHYqJ2gq0rIkBxVgMlo6wBbXYNUA6Cq85l/PXr0
0rW7ZmbaPCbgsIJNYfwVecubn7mCOsW+zwKdnexcmT1vqWKx/pPgdJzKN/Fcv/68W7ynDo8UNk8p
dvMT3LJW
--000000000000fde419060c72a8c9--

