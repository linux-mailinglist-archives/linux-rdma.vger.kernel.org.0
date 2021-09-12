Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB1407F35
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Sep 2021 20:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbhILSRD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Sep 2021 14:17:03 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:34510 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234478AbhILSRC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 12 Sep 2021 14:17:02 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 1DC5280F2;
        Sun, 12 Sep 2021 11:15:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 1DC5280F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631470548;
        bh=r16UCCMaD9QhoTEs1cTzWLFHLO8OROeUdK5RfjxiqN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SKaKhGggqYS3nxvGtEv2xCpIZPiAUuNzx20YcPEwQJ2n7OKzJheGaJ85BQO9oN8qn
         wyeNkHnGi8cqG9WnpmKOljwlGrE5BPVQ+wGhPWN+MHqBiUJoqZWhPf2Z+wMiw5O+Xt
         HRlRpxfAFH2W9scM4VzSa8Xx/9j8Uamgcmusfp58=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 11/12] RDMA/bnxt_re: Check if the vlan is valid before reporting
Date:   Sun, 12 Sep 2021 11:15:25 -0700
Message-Id: <1631470526-22228-12-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When VF is configured with default vlan, HW strips the vlan from
the packet and driver receives it in Rx completion. VLAN needs to
be reported for UD work completion only if the vlan is configured
on the host. Add a check for valid vlan in the UD receive path.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 1cbc7e1..935dbce 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3364,8 +3364,11 @@ static void bnxt_re_process_res_ud_wc(struct bnxt_re_qp *qp,
 				      struct ib_wc *wc,
 				      struct bnxt_qplib_cqe *cqe)
 {
+	struct bnxt_re_dev *rdev;
+	u16 vlan_id = 0;
 	u8 nw_type;
 
+	rdev = qp->rdev;
 	wc->opcode = IB_WC_RECV;
 	wc->status = __rc_to_ib_wc_status(cqe->status);
 
@@ -3377,9 +3380,12 @@ static void bnxt_re_process_res_ud_wc(struct bnxt_re_qp *qp,
 		memcpy(wc->smac, cqe->smac, ETH_ALEN);
 		wc->wc_flags |= IB_WC_WITH_SMAC;
 		if (cqe->flags & CQ_RES_UD_FLAGS_META_FORMAT_VLAN) {
-			wc->vlan_id = (cqe->cfa_meta & 0xFFF);
-			if (wc->vlan_id < 0x1000)
-				wc->wc_flags |= IB_WC_WITH_VLAN;
+			vlan_id = (cqe->cfa_meta & 0xFFF);
+		}
+		/* Mark only if vlan_id is non zero */
+		if (vlan_id && bnxt_re_check_if_vlan_valid(rdev, vlan_id)) {
+			wc->vlan_id = vlan_id;
+			wc->wc_flags |= IB_WC_WITH_VLAN;
 		}
 		nw_type = (cqe->flags & CQ_RES_UD_FLAGS_ROCE_IP_VER_MASK) >>
 			   CQ_RES_UD_FLAGS_ROCE_IP_VER_SFT;
-- 
2.5.5

