Return-Path: <linux-rdma+bounces-19927-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNW0BM6m+GkExgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19927-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 661A84BE5C0
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4AA3057622
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717683DE420;
	Mon,  4 May 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Ot8yDRq7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025873DE422
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903082; cv=none; b=by4cmz5dCSOCGYuVBmA64y3QWXgO0BK7g1+4bXuszcMORmjitciUcKUQi1bnwb0aSlPWkxWtd5VVxxhcajmO++UiQ60hemWPpkjnGVkQK2Y53mZqdFUa9a0Kk1rMq6lhn3hkQbG8WvPg5Xd+F2OJmX4jgu7Zv+RKi6IMwC5hb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903082; c=relaxed/simple;
	bh=gABPEPrINVsmNm2kPuoC4XU+FiIuPDV42sEnHT594Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZrzRLa9UHu9TgwfG3xvfz22gMCWNk0hoAFQLDVufN7Z+e94XvNfrU5xiJUb7SvTK8VpNQdp4dNrINswcK0J8GyYNxS2yjpD9nHIkEFBm088an8hTjtsOaDMaHXuDdNvhfTc/MtL6n7NmJa/Cr0kewQC7iaSb7ZOUlUUxRLiTOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Ot8yDRq7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44a74032ff8so2042665f8f.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1777903078; x=1778507878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck/LWvFuXnQuEuDnYHrJV0AD8h/kdwztdGUOToGCZ4I=;
        b=Ot8yDRq7BMyj2WsHF/fvuYN3xSbl/NFMVmKPef/3h1FJHthKyH9+Kf8HQtOgPMV+Z5
         OlKW+zCprRektsdcjOI0+3Clr+2QAXzqejQ9O/UQPM30MK0N08eSYcuV9UARpO4rByoE
         3CAozHMLlwGcEayzqw6o3cpS4Dh0PZ1MDB0aTY9mgnnu6YMDqiVH/Echa7BBMkvzWjn/
         c2YRZ59svjCiqAMsgZbIIbiNj2z3Oma3OPDYOn4cRzsPNuOHlR9M0OttaDV5h0RzsaAD
         XzfTmUL9rH8DYxjzWuMlhIAnQUcl9eN50VNKh9CQ57V8QlAeUu58ZNGTLxabOex6Epkk
         gmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903078; x=1778507878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ck/LWvFuXnQuEuDnYHrJV0AD8h/kdwztdGUOToGCZ4I=;
        b=mR93Y2p8CiIQrlsYadgux2oCIQOodiHEmOkTUw+vIc8RQgajuIhU7ZFkASJzKWXjpR
         KCfN/mELwEVq6TDZRNYgUOdppQ3nGx0BFICdTxr5nv7gO5tN4Tf3RMRmD5gotHtiArmd
         RVflVp/NFTP2/Jhbpi0Gq4GGU/+beMLzh+ZgChlm725tFIbQPs4115712OhigAqg7zOA
         2ahYkj/6HCyq3xpqYNpnB9jDbMaFKDcgQEJ9exvdaPduXmpeTxyVr5GPrSP/pBPCt1rL
         0JDUGK3jaUAS+kYm53rNKABBX16wawATjSVU5MjXE4Tzxoze4UX0zk6mzd21d3U3HYDX
         gOKQ==
X-Gm-Message-State: AOJu0YwiKHCXdOCPGfGwBjLXyhIa8SS/pdBzzyEP3oN1+WmdesfkTvno
	ji8GVmjznfaFazm+My9W4bJU7TvU4wso22lFJOga1tROA+LtK2YihYZ6rfWFaM5bxaZ0zxe7ev8
	MSZ5mHFQ=
X-Gm-Gg: AeBDieukNbiMZ/Axloh3DFwFDhjMD6lG9C2qlH1f/9tv59Cpr4H3SRCtJtZF3Li4Zht
	At8qWhY05wFPiEO1/vwCFoKoxjhbE64vdmRm68/QTs9piknfp9b14ZPIzrsfgn8I40y+tXIUXGc
	DRDrunSTMLHhv1hF0EfAN776uxStPZ1nRM9k3SBguqbZmc51V0lgpomZp7cf+M5Qm3cB071gLP3
	gUaEME08cSmhK4OQUhLMdZssMQ32Wrh7o4C0ZpqD5cKHLK8dutUUhD7IDJkudEU3xQVLYjzwSXL
	1AOTlyJ2RcJvldlfByUylnu7yw6w73PVOEcg+yVox+z953OSwXoyMAoe0IZBYgm5kopMp7YJ9No
	Hm20cqZNIoF1RwBZCuboaQYYlll3vLKXiD94KuRS+teMssQuz1fMwNUbcRATMO+5+mWrr/1zFj/
	UqH86hDgCVWHwG8k0pZVuxxzGX
X-Received: by 2002:a05:6000:2313:b0:441:1fa5:457f with SMTP id ffacd0b85a97d-44bb67cd185mr16048245f8f.28.1777903078239;
        Mon, 04 May 2026 06:57:58 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a9879ef89sm30090746f8f.30.2026.05.04.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 06:57:57 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next v3 14/17] RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
Date: Mon,  4 May 2026 15:57:28 +0200
Message-ID: <20260504135731.2345383-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504135731.2345383-1-jiri@resnulli.us>
References: <20260504135731.2345383-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 661A84BE5C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[resnulli-us.20251104.gappssmtp.com:query timed out];
	TAGGED_FROM(0.00)[bounces-19927-lists,linux-rdma=lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]

From: Jiri Pirko <jiri@nvidia.com>

Use the per-attribute UMEM helpers to pin QP buffer umems on
demand. The QP-type predicate selects between the BUF and RQ_BUF
attrs; raw-packet SQ uses its own dedicated SQ_BUF attr.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- changed to use ib_umem_get_attr_or_va() per-attr
- added ubuffer->umem / sq->ubuffer.umem to store umem
- renamed mlx5_qp_buf_slot() -> mlx5_qp_buf_attr()
- replaced ib_umem_release_non_listed() with ib_umem_release()
---
 drivers/infiniband/hw/mlx5/qp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 1bc279d14749..1b764a573dd7 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -938,6 +938,14 @@ static int adjust_bfregn(struct mlx5_ib_dev *dev,
 				bfregn % MLX5_NON_FP_BFREGS_PER_UAR;
 }
 
+static u16 mlx5_qp_buf_attr(struct mlx5_ib_qp *qp)
+{
+	if (qp->type == IB_QPT_RAW_PACKET ||
+	    qp->flags & IB_QP_CREATE_SOURCE_QPN)
+		return UVERBS_ATTR_CREATE_QP_RQ_BUF_UMEM;
+	return UVERBS_ATTR_CREATE_QP_BUF_UMEM;
+}
+
 static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			   struct mlx5_ib_qp *qp, struct ib_udata *udata,
 			   struct ib_qp_init_attr *attr, u32 **in,
@@ -998,14 +1006,20 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	if (err)
 		goto err_bfreg;
 
-	if (ucmd->buf_addr && ubuffer->buf_size) {
+	ubuffer->umem = NULL;
+	if (ubuffer->buf_size) {
 		ubuffer->buf_addr = ucmd->buf_addr;
-		ubuffer->umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
-					       ubuffer->buf_size, 0);
+		ubuffer->umem = ib_umem_get_attr_or_va(&dev->ib_dev, udata,
+						       mlx5_qp_buf_attr(qp),
+						       ubuffer->buf_addr,
+						       ubuffer->buf_size, 0);
 		if (IS_ERR(ubuffer->umem)) {
 			err = PTR_ERR(ubuffer->umem);
+			ubuffer->umem = NULL;
 			goto err_bfreg;
 		}
+	}
+	if (ubuffer->umem) {
 		page_size = mlx5_umem_find_best_quantized_pgoff(
 			ubuffer->umem, qpc, log_page_size,
 			MLX5_ADAPTER_PAGE_SHIFT, page_offset, 64,
@@ -1015,8 +1029,6 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			goto err_umem;
 		}
 		ncont = ib_umem_num_dma_blocks(ubuffer->umem, page_size);
-	} else {
-		ubuffer->umem = NULL;
 	}
 
 	*inlen = MLX5_ST_SZ_BYTES(create_qp_in) +
@@ -1352,8 +1364,10 @@ static int create_raw_packet_qp_sq(struct mlx5_ib_dev *dev,
 	if (ts_format < 0)
 		return ts_format;
 
-	sq->ubuffer.umem = ib_umem_get_va(&dev->ib_dev, ubuffer->buf_addr,
-					  ubuffer->buf_size, 0);
+	sq->ubuffer.umem = ib_umem_get_attr_or_va(&dev->ib_dev, udata,
+						  UVERBS_ATTR_CREATE_QP_SQ_BUF_UMEM,
+						  ubuffer->buf_addr,
+						  ubuffer->buf_size, 0);
 	if (IS_ERR(sq->ubuffer.umem))
 		return PTR_ERR(sq->ubuffer.umem);
 	page_size = mlx5_umem_find_best_quantized_pgoff(
-- 
2.53.0


