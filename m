Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0538B40C556
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbhIOMeY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:34:24 -0400
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228]:46884 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237460AbhIOMeX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:34:23 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 145074E14B;
        Wed, 15 Sep 2021 05:33:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 145074E14B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631709185;
        bh=r16UCCMaD9QhoTEs1cTzWLFHLO8OROeUdK5RfjxiqN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHb8KMPvYRiP745en0ap2qoeEk4ecnv1Q5SD6XvvW1JxzMm2z27BbruXQrT2JDV7H
         DWK96t+jG7prg0GiJXFewCWv3CLBj7DFIGo7TkZb4w+dPp8HTgUnCIMOugVVuSTT4S
         FNERWM2/TbaGbbaV675dl9leuM55JWmvxukubP5Y=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH for-next v2 11/12] RDMA/bnxt_re: Check if the vlan is valid before reporting
Date:   Wed, 15 Sep 2021 05:32:42 -0700
Message-Id: <1631709163-2287-12-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
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

