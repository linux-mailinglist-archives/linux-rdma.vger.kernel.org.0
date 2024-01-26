Return-Path: <linux-rdma+bounces-767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0513B83DD58
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E21F281FE9
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jan 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAEC1CD3F;
	Fri, 26 Jan 2024 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzVfUiwB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABFB1CF8B
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jan 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282532; cv=none; b=qQnQfKGdqxzZX4ca+RURz7BGchTgTYwaAyQTFQNm+/eNIV22nXCIC/okOHbwsxcRDGM4wDFyiRhYnzIiYYK1fAkJVWl27bTMhfnX/PkIeAE2hJ/9fW5xx/Y0keTMs3Ev2TIa4Fcmn6hpI15h5d67TQGBRUHQc4NVP5TT+GgpShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282532; c=relaxed/simple;
	bh=t2n7KNUGUzU77BEBqmOYRjm+oIuzJQkeDhTNCAq4zx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dNGEQSIxu5X6yCv/qBKwX5SEfbp4nE58n+gtQeh6oK//wWMMhDKx2F45FOQfHsokujkGHBMmbizTA10oLGqOSFjJlRGaD6GZSGE2CekfOIqPe97+I5glPoKhuQS26LZH6vsg65qXq7jnBRk4youDWSAvTl0+ZDXkIlHRokgw+nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzVfUiwB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706282529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IkTbDdKErsrbqQMEDhGqK5ts3+kvxqXuzsHApeWI9Ig=;
	b=dzVfUiwBmuHq7NbNVJhroT8AyAVyJOKVf6STWGskrfgnPNd3GL2YEi4iKrQT4fObb5Wg/y
	F8VCGrmXSABiI9wnEkKW7nauJNEPmzSZkbMi4m01WaTBXqH5EDscTFQgY6GsZ/X777UekV
	JdJLkXq3dj71ADXpqrhIiohbWUjRa8g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-GWKs3CcOOo2QEATqxHWtQg-1; Fri,
 26 Jan 2024 10:22:08 -0500
X-MC-Unique: GWKs3CcOOo2QEATqxHWtQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D0743C025D9;
	Fri, 26 Jan 2024 15:22:07 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.224.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6571EC15E61;
	Fri, 26 Jan 2024 15:22:04 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Brendan Cunningham <bcunningham@cornelisnetworks.com>,
	Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Mats Kronberg <kronberg@nsc.liu.se>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error (take two)
Date: Fri, 26 Jan 2024 16:21:23 +0100
Message-ID: <20240126152125.869509-1-neelx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Unfortunately the commit `fd8958efe877` introduced another error
causing the `descs` array to overflow. This reults in further crashes
easily reproducible by `sendmsg` system call.

[ 1080.836473] general protection fault, probably for non-canonical address 0x400300015528b00a: 0000 [#1] PREEMPT SMP PTI
[ 1080.869326] RIP: 0010:hfi1_ipoib_build_ib_tx_headers.constprop.0+0xe1/0x2b0 [hfi1]
--
[ 1080.974535] Call Trace:
[ 1080.976990]  <TASK>
[ 1081.021929]  hfi1_ipoib_send_dma_common+0x7a/0x2e0 [hfi1]
[ 1081.027364]  hfi1_ipoib_send_dma_list+0x62/0x270 [hfi1]
[ 1081.032633]  hfi1_ipoib_send+0x112/0x300 [hfi1]
[ 1081.042001]  ipoib_start_xmit+0x2a9/0x2d0 [ib_ipoib]
[ 1081.046978]  dev_hard_start_xmit+0xc4/0x210
--
[ 1081.148347]  __sys_sendmsg+0x59/0xa0

crash> ipoib_txreq 0xffff9cfeba229f00
struct ipoib_txreq {
  txreq = {
    list = {
      next = 0xffff9cfeba229f00,
      prev = 0xffff9cfeba229f00
    },
    descp = 0xffff9cfeba229f40,
    coalesce_buf = 0x0,
    wait = 0xffff9cfea4e69a48,
    complete = 0xffffffffc0fe0760 <hfi1_ipoib_sdma_complete>,
    packet_len = 0x46d,
    tlen = 0x0,
    num_desc = 0x0,
    desc_limit = 0x6,
    next_descq_idx = 0x45c,
    coalesce_idx = 0x0,
    flags = 0x0,
    descs = {{
        qw = {0x8024000120dffb00, 0x4}  # SDMA_DESC0_FIRST_DESC_FLAG (bit 63)
      }, {
        qw = {  0x3800014231b108, 0x4}
      }, {
        qw = { 0x310000e4ee0fcf0, 0x8}
      }, {
        qw = {  0x3000012e9f8000, 0x8}
      }, {
        qw = {  0x59000dfb9d0000, 0x8}
      }, {
        qw = {  0x78000e02e40000, 0x8}
      }}
  },
  sdma_hdr =  0x400300015528b000,  <<< invalid pointer in the tx request structure
  sdma_status = 0x0,                   SDMA_DESC0_LAST_DESC_FLAG (bit 62)
  complete = 0x0,
  priv = 0x0,
  txq = 0xffff9cfea4e69880,
  skb = 0xffff9d099809f400
}

With this patch the crashes are no longer reproducible and the machine is stable.

Note, the header file changes are just an unrelated clean-up while I was looking
around trying to find the bug.

Fixes: fd8958efe877 ("IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors")
Cc: stable@vger.kernel.org
Reported-by: Mats Kronberg <kronberg@nsc.liu.se>
Tested-by: Mats Kronberg <kronberg@nsc.liu.se>
Signed-off-by: Daniel Vacek <neelx@redhat.com>
---
 drivers/infiniband/hw/hfi1/sdma.c |  2 +-
 drivers/infiniband/hw/hfi1/sdma.h | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 6e5ac2023328a..b67d23b1f2862 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -3158,7 +3158,7 @@ int _pad_sdma_tx_descs(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 {
 	int rval = 0;
 
-	if ((unlikely(tx->num_desc + 1 == tx->desc_limit))) {
+	if ((unlikely(tx->num_desc == tx->desc_limit))) {
 		rval = _extend_sdma_tx_descs(dd, tx);
 		if (rval) {
 			__sdma_txclean(dd, tx);
diff --git a/drivers/infiniband/hw/hfi1/sdma.h b/drivers/infiniband/hw/hfi1/sdma.h
index d77246b48434f..362815a8da267 100644
--- a/drivers/infiniband/hw/hfi1/sdma.h
+++ b/drivers/infiniband/hw/hfi1/sdma.h
@@ -639,13 +639,13 @@ static inline void sdma_txclean(struct hfi1_devdata *dd, struct sdma_txreq *tx)
 static inline void _sdma_close_tx(struct hfi1_devdata *dd,
 				  struct sdma_txreq *tx)
 {
-	u16 last_desc = tx->num_desc - 1;
+	struct sdma_desc *desc = &tx->descp[tx->num_desc - 1];
 
-	tx->descp[last_desc].qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
-	tx->descp[last_desc].qw[1] |= dd->default_desc1;
+	desc->qw[0] |= SDMA_DESC0_LAST_DESC_FLAG;
+	desc->qw[1] |= dd->default_desc1;
 	if (tx->flags & SDMA_TXREQ_F_URGENT)
-		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
-					       SDMA_DESC1_INT_REQ_FLAG);
+		desc->qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+				SDMA_DESC1_INT_REQ_FLAG);
 }
 
 static inline int _sdma_txadd_daddr(
@@ -670,13 +670,10 @@ static inline int _sdma_txadd_daddr(
 	tx->tlen -= len;
 	/* special cases for last */
 	if (!tx->tlen) {
-		if (tx->packet_len & (sizeof(u32) - 1)) {
+		if (tx->packet_len & (sizeof(u32) - 1))
 			rval = _pad_sdma_tx_descs(dd, tx);
-			if (rval)
-				return rval;
-		} else {
+		else
 			_sdma_close_tx(dd, tx);
-		}
 	}
 	return rval;
 }
-- 
2.43.0


