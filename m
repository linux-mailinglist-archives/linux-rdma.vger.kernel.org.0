Return-Path: <linux-rdma+bounces-2593-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAA8CCF98
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26E4283F25
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBA513D51A;
	Thu, 23 May 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SXD6Yrut"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1591947A7C
	for <linux-rdma@vger.kernel.org>; Thu, 23 May 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716457636; cv=none; b=KtvrePV9AewU67O0V+f2m/Gp/kVz1zFa1PYi/56jzEm/j8JIiCuYY6B1Oapq0fmClu3I+vaodGant03YHc1y4HPrs2V8uyFckR0q/otnS886ZljVFZYOEMwbw3iBdU9+t6hcAnKEC7KNpnlF5l9yY2My6Vd+jHe9umQQ2e9uE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716457636; c=relaxed/simple;
	bh=aEa9JRCEznIO9rQuFDW9rJrJZ7VjRaMHUpoVBknnNRs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bpdFlxE4gd/6F8/zTXgPn7KzR/5URvhF+cGz/hPwAbQw+fBfkZ0LeBXhRAxZeJrB66pOVa1AlsNL8NW/TShKwoFRKqmnyuD3zr9NS19lJBXBgbavVmY6I6XhsXLrENazR3omIm7aTinBy7aZv3N+jv6AJV2bdECa76+LJlkejFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SXD6Yrut; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=YXO3H
	hMlfsk5G4ljYbZ+SxdncPfny03KGtaI2rUfFxI=; b=SXD6YrutQgGr4ZBD1R5jw
	Fjz5vApe469KsOjwUN0k1Y+Q+NwAuIAnjySdzrcwe/lkK6TsW546z47BcxqNdWXz
	YOKOgE785TV3ZC7VyXCeBxzSH86Tpwf8y+Fbe0wbmSFn5Pp/3kDVfqLv6b4NhDxX
	pONlTNXGHTQLzGTRhD9sJs=
Received: from fc39.. (unknown [183.81.182.182])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wCXL3qAEE9m+9WXBw--.6214S4;
	Thu, 23 May 2024 17:46:42 +0800 (CST)
From: Honggang LI <honggangli@163.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	rpearsonhpe@gmail.com,
	matsuda-daisuke@fujitsu.com,
	linux-rdma@vger.kernel.org,
	honggangli@163.com
Subject: [PATCH] RDMA/rxe: Fix responder length checking for UD request packets
Date: Thu, 23 May 2024 17:46:17 +0800
Message-ID: <20240523094617.141148-1-honggangli@163.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXL3qAEE9m+9WXBw--.6214S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1DAF1rCr1xWr1UXr43Wrg_yoW8CF48pa
	98t3W5Kr48XF12va1vv3yrXF4rAFyDJF1xKrZFq3s09r45Xa1aqFnI9FWYqa98JFnxWayS
	vr1Yq3ykWw45CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_JPErUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/1tbiDwbnRWVOEFZcwgAAsY

According to the IBA specification:
If a UD request packet is detected with an invalid length, the request
shall be an invalid request and it shall be silently dropped by
the responder. The responder then waits for a new request packet.

commit 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length checking")
defers responder length check for UD QPs in function `copy_data`.
But it introduces a regression issue for UD QPs.

When the packet size is too large to fit in the receive buffer.
`copy_data` will return error code -EINVAL. Then `send_data_in`
will return RESPST_ERR_MALFORMED_WQE. UD QP will transfer into
ERROR state.

Fixes: 689c5421bfe0 ("RDMA/rxe: Fix incorrect responder length checking")
Signed-off-by: Honggang LI <honggangli@163.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 963382f625d7..a74f29dcfdc9 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -354,6 +354,18 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 	 * receive buffer later. For rmda operations additional
 	 * length checks are performed in check_rkey.
 	 */
+	if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
+		unsigned int recv_buffer_len = 0;
+		unsigned int payload = payload_size(pkt);
+
+		for (int i = 0; i < qp->resp.wqe->dma.num_sge; i++)
+			recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
+		if (payload + 40 > recv_buffer_len) {
+			rxe_dbg_qp(qp, "The receive buffer is too small for this UD packet.\n");
+			return RESPST_ERR_LENGTH;
+		}
+	}
+
 	if (pkt->mask & RXE_PAYLOAD_MASK && ((qp_type(qp) == IB_QPT_RC) ||
 					     (qp_type(qp) == IB_QPT_UC))) {
 		unsigned int mtu = qp->mtu;
-- 
2.45.1


