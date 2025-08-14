Return-Path: <linux-rdma+bounces-12759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5532AB26419
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F287A0032C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444C829BDA9;
	Thu, 14 Aug 2025 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AIUQRVvS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EDC1EF39E
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170413; cv=none; b=f69XrnBHUMeWbko3n/yp9Xd9q3775vBP6eACksVzjCoQ0RDsSKAPQkUelYtw0XcIQzdUtRFJxEUm8Zz34o5Qmd2BgEEehABfJFENpbMmRlaZQ8ZTgIWGlNPD6RDOzczxIWE1YZhhXHIBnYun7i6bk3Rbq+kDNUaX7sTebauT8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170413; c=relaxed/simple;
	bh=Q9+9k/jpqPFGAMNwTBb6KANZIJ9m2D8/O/uC9S73kIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkx5GXc0yEDxfYlPlHO4K7wp35qrv+Etk2QoiA9vXv04jhBvqGBWRVJjNESAFMCxfJ+esaZwMmtpGgUhLbQPn18t2atcaVtFH3mrGfCAL59VWNTCqfmxabZbyR9wT1Q36c1XqDbVSE7cz43KhLXX+vBX9//W3PeCPcqqQDIHyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AIUQRVvS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4716fb8e74so651320a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170411; x=1755775211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjkQnQqYnxqn8wqZu5Ai0EuRQySnkAI970TolqS1EgM=;
        b=AIUQRVvShakd1pggSUkf+DGqJb8kYZflwSPaMiqUMFktaKsnVj6/1KfHJvnEYsT7+h
         ianXpfEfP+x+bWKN58NYJ3PI15LA7FpO8LLFcg3CU627lNCJxJ/soBZlif4mdKTj+oYa
         Mtc5oPSzcVnj4K231slP1OATwHZZmkqONbCM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170411; x=1755775211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjkQnQqYnxqn8wqZu5Ai0EuRQySnkAI970TolqS1EgM=;
        b=FRP9Fw8u679SzsLFPFWHI+BYF4iQGhuJWjgfuD6k9G9DHATWm8If4x1bbAMN8Af8AB
         iX9GpRl0ijwyzkYv9oS3paVDkLHCeKzNjlZZghOADAHkXHf1lg3rHomfBOUS+woGgZYc
         4kPLg9TKw6WwK2MJmmwIw+myD9cTGso2anYqhqcChmdVuxpscVVTPM4BdjOJLDhnz5Av
         pqL8MuqfSB9VDrTHEibONfIhKJpff9xM8/7i1bPgzX7EpgqCMHo58KUo/+mlLNrV5rPE
         XM5yG4IpHUxgLup4QhiFuKArKkXHsxPWR9w1G82cPBhz4e6DOfgbRxLIBgsG204NfVbg
         t1/w==
X-Gm-Message-State: AOJu0YyItAne6xSS2o6eKGLruO5BOUmKE00ryDV32L9mItq96eCkbQKc
	hlCdk1qFFvzFwRya9keRapqj/Pi1TcCSN5rE1HeAQrXPpXK2DztXk1sVYIMiLqFxPQ==
X-Gm-Gg: ASbGncsJOrYzJOdImfDckSN/+l1o7wBQJn39ntn+Vckw4VqgjiAn16MhnQj/K+tqFRV
	n+VYApZEOl81qc7NfDUAhD+pySK2uYnAvYJdKYgVoXVL/DWjvib3WvNBqYB71Z+5KMv56iEpniG
	DCvZEaRzL+AaNiw9+2tJ3JLf5+HehG4QedHmYb9YRhcL+bmqL94Q128r+wCh4jv9ZTofaTz1Jyu
	b1DMg9Mf8LtBHb8RFanawmHK62EdH9bTUNRxMdw5HMeMKge07e1cBO99O4VE5b8CY1NQVmeDUkO
	xtblBlYbITlfmDg0utIB+UFm+YXff/1JX41/IHEg0SjmCHesSXJlifTI9QsBBONGZYUY5+t6bZk
	r1PVz5ftujXNLEapaTsljZngURFG8GdLA2x3OdRGXD5akfR3FDDLJesXCldoA284SDVyWvyTIAd
	gotL4cX4qxtN6iXXP7e8lAG4E93Be9/A==
X-Google-Smtp-Source: AGHT+IF9i1HrR0S0S7wF2u8+xBfyDPKOTrB6eVCFAwj16fcDgJm+XIaFuE4Na1LyoLjfSUhYaQssRg==
X-Received: by 2002:a17:902:e78e:b0:235:f078:4746 with SMTP id d9443c01a7336-244586dbef9mr40478715ad.42.1755170410977;
        Thu, 14 Aug 2025 04:20:10 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:20:10 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Abhishek Mohapatra <abhishek.mohapatra@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH rdma-next 7/9] RDMA/bnxt_re: Report udp source port for flow_label in bnxt_re_query_qp
Date: Thu, 14 Aug 2025 16:55:53 +0530
Message-ID: <20250814112555.221665-8-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abhishek Mohapatra <abhishek.mohapatra@broadcom.com>

The firmware doesn't capture the flow_label. Therefore the value
that's always returned by qplib_qp->ah.flow_label is 0 whenever
a qp is created. And as per IB spec, udp source port can be reported
for flow_label. Hence reported udp source port for flow_label in
bnxt_re_query_qp by populating the value of qplib_qp->udp_sport
into qp_attr->ah_attr.grh.flow_label.

Signed-off-by: Abhishek Mohapatra <abhishek.mohapatra@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h | 1 +
 drivers/infiniband/hw/bnxt_re/roce_hsi.h | 3 ++-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 37c2bc3bdba5..98bc8b6290f1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2305,7 +2305,7 @@ int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 	qp_attr->pkey_index = qplib_qp->pkey_index;
 	qp_attr->qkey = qplib_qp->qkey;
 	qp_attr->ah_attr.type = RDMA_AH_ATTR_TYPE_ROCE;
-	rdma_ah_set_grh(&qp_attr->ah_attr, NULL, qplib_qp->ah.flow_label,
+	rdma_ah_set_grh(&qp_attr->ah_attr, NULL, qplib_qp->udp_sport,
 			qplib_qp->ah.host_sgid_index,
 			qplib_qp->ah.hop_limit,
 			qplib_qp->ah.traffic_class);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index dfe3177123e5..092310571dcc 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1492,6 +1492,7 @@ int bnxt_qplib_query_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	qp->access = sb->access;
 	qp->pkey_index = le16_to_cpu(sb->pkey);
 	qp->qkey = le32_to_cpu(sb->qkey);
+	qp->udp_sport = le16_to_cpu(sb->udp_src_port);
 
 	temp32[0] = le32_to_cpu(sb->dgid[0]);
 	temp32[1] = le32_to_cpu(sb->dgid[1]);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index ab125f1d949e..074c539c69c1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -299,6 +299,7 @@ struct bnxt_qplib_qp {
 	u8				smac[6];
 	u16				vlan_id;
 	u16				port_id;
+	u16				udp_sport;
 	u8				nw_type;
 	struct bnxt_qplib_ah		ah;
 
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 024845f945ff..f9ac37335a1d 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -788,7 +788,8 @@ struct creq_query_qp_resp_sb {
 	#define CREQ_QUERY_QP_RESP_SB_ACCESS_REMOTE_ATOMIC 0x8UL
 	__le16	pkey;
 	__le32	qkey;
-	__le32	reserved32;
+	__le16	udp_src_port;
+	__le16	reserved16;
 	__le32	dgid[4];
 	__le32	flow_label;
 	__le16	sgid_index;
-- 
2.43.5


