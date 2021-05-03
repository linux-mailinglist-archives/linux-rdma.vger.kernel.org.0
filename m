Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E933711B9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 May 2021 08:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhECGtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 May 2021 02:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhECGtR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 May 2021 02:49:17 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA6C061756
        for <linux-rdma@vger.kernel.org>; Sun,  2 May 2021 23:48:23 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h20so2294574plr.4
        for <linux-rdma@vger.kernel.org>; Sun, 02 May 2021 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=COVqszlNJard7bUu4+ks4yO1w9lOMnS489/lJ5qSl8s=;
        b=elx7maC22nnoisv8YS39tZ93cfHKqaOyjRcOQpx1HM99ERkdnG/O3fI1hobu47AU0C
         y61Pk8992mU6eh/7P98KBBzd/xxRtiNyyh2Uvi4vW3VpNwrPzJHwUV3I6C5yvDK6fXLR
         gv4L79yuXy8bsWu7ES1sMR0LxZ3uhxdZ/a/Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=COVqszlNJard7bUu4+ks4yO1w9lOMnS489/lJ5qSl8s=;
        b=eeQVB9QcNNLvlIGacij99yxHgKlDMZliqQRavZH+0kjDnSoVeaXwWBjNGxJFO8Ki0Z
         LvAXMRMEBLh2pAQyBAAjwK2JwtMc1FB6Yy0GDOrSTPwYbaK9DYqhbw4dXmWX4/DB6xYT
         tRmlHP5TAj+vT6IU9Y8HXPsvD05yrCKVXqigkCwwB1h1qBglhYK4Tx9M1QArRqgEk1D2
         Ufkp92UFe3RqjBKSAvLEtcBbO2r19PgLMsjssX9/OxWVYZfKaDHDOBKFUYZwMkm9Y2qw
         m/JvI4BPUaKTzOrKubyP9IAr0Bu7lVsnLh9mYvJg/ipOE5FHn5aWdcsGIiwoia/1V5a+
         I04w==
X-Gm-Message-State: AOAM533nNVph+SQzt7VN3MQbQTU2K7XzhAeemgMi2xQU//Y0G2fmGhMA
        3DDmoZR3yzTfRz4/oPDLmPNTqjgon9/LB54ZfzCAW2yzYu8ft4QjgE8bVDpiUK3cHGMz25jbgmA
        WyYq/15nJEnmGP7tfkEPEQgbiJLGfXs/ZjMN9qgXo/BU5orkwzJ5jrqSoDGuGmqjmCq9vc47Aqv
        uy4WepTCkT
X-Google-Smtp-Source: ABdhPJxbZcCsodQZ7EcGhzhhncC1vhcEaGee235AN+XzRLJ8f4Ryv3ZSztWyn0lWsMA80MQBbLqOkA==
X-Received: by 2002:a17:90a:5806:: with SMTP id h6mr19476504pji.14.1620024502475;
        Sun, 02 May 2021 23:48:22 -0700 (PDT)
Received: from dev01.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i9sm19585389pjh.9.2021.05.02.23.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 23:48:22 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [rdma-core 4/4] bnxt_re/lib: let bnxt_re_dev store device attrs
Date:   Mon,  3 May 2021 12:18:02 +0530
Message-Id: <20210503064802.457482-5-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503064802.457482-1-devesh.sharma@broadcom.com>
References: <20210503064802.457482-1-devesh.sharma@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000a610805c167594b"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--0000000000000a610805c167594b
Content-Transfer-Encoding: 8bit

Making a change to let bnxt_re_dev strucutre store
the device attributes once for entire life of device
context. This change saves a firmware call per QP
creation and speed it up.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/main.c  | 31 ++++++++++++++++++-------------
 providers/bnxt_re/main.h  |  2 ++
 providers/bnxt_re/verbs.c | 25 +++++++++++--------------
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/providers/bnxt_re/main.c b/providers/bnxt_re/main.c
index a78e6b98..1779e1ec 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -129,10 +129,11 @@ static struct verbs_context *bnxt_re_alloc_context(struct ibv_device *vdev,
 						   int cmd_fd,
 						   void *private_data)
 {
-	struct ibv_get_context cmd;
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(vdev);
 	struct ubnxt_re_cntx_resp resp;
-	struct bnxt_re_dev *dev = to_bnxt_re_dev(vdev);
 	struct bnxt_re_context *cntx;
+	struct ibv_get_context cmd;
+	int ret;
 
 	cntx = verbs_init_and_alloc_context(vdev, cmd_fd, cntx, ibvctx,
 					    RDMA_DRIVER_BNXT_RE);
@@ -146,9 +147,9 @@ static struct verbs_context *bnxt_re_alloc_context(struct ibv_device *vdev,
 
 	cntx->dev_id = resp.dev_id;
 	cntx->max_qp = resp.max_qp;
-	dev->pg_size = resp.pg_size;
-	dev->cqe_size = resp.cqe_sz;
-	dev->max_cq_depth = resp.max_cqd;
+	rdev->pg_size = resp.pg_size;
+	rdev->cqe_size = resp.cqe_sz;
+	rdev->max_cq_depth = resp.max_cqd;
 	if (resp.comp_mask & BNXT_RE_UCNTX_CMASK_HAVE_CCTX) {
 		cntx->cctx.chip_num = resp.chip_id0 & 0xFFFF;
 		cntx->cctx.chip_rev = (resp.chip_id0 >>
@@ -159,7 +160,7 @@ static struct verbs_context *bnxt_re_alloc_context(struct ibv_device *vdev,
 	}
 	pthread_spin_init(&cntx->fqlock, PTHREAD_PROCESS_PRIVATE);
 	/* mmap shared page. */
-	cntx->shpg = mmap(NULL, dev->pg_size, PROT_READ | PROT_WRITE,
+	cntx->shpg = mmap(NULL, rdev->pg_size, PROT_READ | PROT_WRITE,
 			  MAP_SHARED, cmd_fd, 0);
 	if (cntx->shpg == MAP_FAILED) {
 		cntx->shpg = NULL;
@@ -168,6 +169,10 @@ static struct verbs_context *bnxt_re_alloc_context(struct ibv_device *vdev,
 	pthread_mutex_init(&cntx->shlock, NULL);
 
 	verbs_set_ops(&cntx->ibvctx, &bnxt_re_cntx_ops);
+	cntx->rdev = rdev;
+	ret = ibv_query_device(&cntx->ibvctx.context, &rdev->devattr);
+	if (ret)
+		goto failed;
 
 	return &cntx->ibvctx;
 
@@ -180,19 +185,19 @@ failed:
 static void bnxt_re_free_context(struct ibv_context *ibvctx)
 {
 	struct bnxt_re_context *cntx = to_bnxt_re_context(ibvctx);
-	struct bnxt_re_dev *dev = to_bnxt_re_dev(ibvctx->device);
+	struct bnxt_re_dev *rdev = to_bnxt_re_dev(ibvctx->device);
 
 	/* Unmap if anything device specific was mapped in init_context. */
 	pthread_mutex_destroy(&cntx->shlock);
 	if (cntx->shpg)
-		munmap(cntx->shpg, dev->pg_size);
+		munmap(cntx->shpg, rdev->pg_size);
 	pthread_spin_destroy(&cntx->fqlock);
 
 	/* Un-map DPI only for the first PD that was
 	 * allocated in this context.
 	 */
 	if (cntx->udpi.dbpage && cntx->udpi.dbpage != MAP_FAILED) {
-		munmap(cntx->udpi.dbpage, dev->pg_size);
+		munmap(cntx->udpi.dbpage, rdev->pg_size);
 		cntx->udpi.dbpage = NULL;
 	}
 
@@ -203,13 +208,13 @@ static void bnxt_re_free_context(struct ibv_context *ibvctx)
 static struct verbs_device *
 bnxt_re_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 {
-	struct bnxt_re_dev *dev;
+	struct bnxt_re_dev *rdev;
 
-	dev = calloc(1, sizeof(*dev));
-	if (!dev)
+	rdev = calloc(1, sizeof(*rdev));
+	if (!rdev)
 		return NULL;
 
-	return &dev->vdev;
+	return &rdev->vdev;
 }
 
 static const struct verbs_device_ops bnxt_re_dev_ops = {
diff --git a/providers/bnxt_re/main.h b/providers/bnxt_re/main.h
index d470e30a..a63719e8 100644
--- a/providers/bnxt_re/main.h
+++ b/providers/bnxt_re/main.h
@@ -166,10 +166,12 @@ struct bnxt_re_dev {
 
 	uint32_t cqe_size;
 	uint32_t max_cq_depth;
+	struct ibv_device_attr devattr;
 };
 
 struct bnxt_re_context {
 	struct verbs_context ibvctx;
+	struct bnxt_re_dev *rdev;
 	uint32_t dev_id;
 	uint32_t max_qp;
 	struct bnxt_re_chip_ctx cctx;
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index 4344b3dd..7f98c260 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -777,25 +777,22 @@ int bnxt_re_arm_cq(struct ibv_cq *ibvcq, int flags)
 static int bnxt_re_check_qp_limits(struct bnxt_re_context *cntx,
 				   struct ibv_qp_init_attr *attr)
 {
-	struct ibv_device_attr devattr;
-	int ret;
+	struct ibv_device_attr *devattr;
+	struct bnxt_re_dev *rdev;
 
-	ret = bnxt_re_query_device(
-		&cntx->ibvctx.context, NULL,
-		container_of(&devattr, struct ibv_device_attr_ex, orig_attr),
-		sizeof(devattr));
-	if (ret)
-		return ret;
-	if (attr->cap.max_send_sge > devattr.max_sge)
+	rdev = cntx->rdev;
+	devattr = &rdev->devattr;
+
+	if (attr->cap.max_send_sge > devattr->max_sge)
 		return EINVAL;
-	if (attr->cap.max_recv_sge > devattr.max_sge)
+	if (attr->cap.max_recv_sge > devattr->max_sge)
 		return EINVAL;
 	if (attr->cap.max_inline_data > BNXT_RE_MAX_INLINE_SIZE)
 		return EINVAL;
-	if (attr->cap.max_send_wr > devattr.max_qp_wr)
-		attr->cap.max_send_wr = devattr.max_qp_wr;
-	if (attr->cap.max_recv_wr > devattr.max_qp_wr)
-		attr->cap.max_recv_wr = devattr.max_qp_wr;
+	if (attr->cap.max_send_wr > devattr->max_qp_wr)
+		attr->cap.max_send_wr = devattr->max_qp_wr;
+	if (attr->cap.max_recv_wr > devattr->max_qp_wr)
+		attr->cap.max_recv_wr = devattr->max_qp_wr;
 
 	return 0;
 }
-- 
2.25.1


--0000000000000a610805c167594b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICRIpHsn+cK87dL93eTtrpkeChvg
E8YuGBsqd8X5aBnOMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUwMzA2NDgyM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAAFvXwdUhf66jmoDDQCgQfC8tlCaVZtBBK+r7/XGCd6GEN
X9Bvyk727cWkEj0Xmi3/WB3vS7XWOTE42A7gMadTJov8q1Q1kFO9cxhrk3ixEaVoMTtxosX8G3UJ
uSITSYIfXuRCsMIGp0c7BXcXOjcYBcjOhYzOf5Z9cMnXu8cMFWc6iVH2Ehw4SluxjrWe5+pQr4SR
jVtz+MtFiQ65FoHtmqJpfEqVDv6Wwtr6R1vYh4wjgVyIeGFva+iMAiOMo9WrvbjSbB5ZSxJ+4EX3
kkRueqIVJqOtdiPVlTYLBFMhFA7J+beExNaZI6w84okweoUFbXlA2zR8eAO/74s7n6nU
--0000000000000a610805c167594b--
