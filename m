Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7B250737
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHXSOy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSOy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:14:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD7C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x25so5252062pff.4
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IG2UD6cWot6QakSCQu81xwXqzwa8XgoLOQnIkyJmFcQ=;
        b=HrqjN07y9crkBrorqApzITZDhMFRQGEAsIRcyXJ4lV5MrZ7t6oda3lqqZ8oORbf+9W
         o60KzyVonIkU91kRMeimK6KvOvakw3HX75Gh48oGYBA1FRiXSIawGyF8zj+EcmTU12V7
         UM7C6NXU9afBpXieCKBehL6bygZlRAbs3wJEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IG2UD6cWot6QakSCQu81xwXqzwa8XgoLOQnIkyJmFcQ=;
        b=n+zE5lPrmXPgvHUAo08DnYrywiCuOWsQQaNK6Fi1RBPs+j9QUvSME8sfpwhs6ZRg5m
         2huNLMKYxNhUOMoezPDoFPezvTemq/Cz1gIY6j/cosurHXsmN3HlrQfq/l8z8hxmGo8+
         emkoctGeFsgcilaNC6yJ11LTNcafoj1EqjuKnNck5nRwTGP49VJcGcofAYLu9XSR/04F
         RG9wVjrmAiWs7woleDRSeECR9n0MzoWVF/tjQhWRANe704sh8n6UvFLsAHIWvcKEzzmp
         P1fvD2rd30j11u8gTcbM6Hb+Qo31LS9Ou+OdQE3973ywhV74EcAHgJPdUPvcjQ2KXl+I
         o6xg==
X-Gm-Message-State: AOAM532zzUcxTf6Z7wvGclUw0/kFaM7L0LHWmdq8t1tm8DbuZcuQPPW/
        dh8ew8E8VbBB0A8i4zsaBfftAA==
X-Google-Smtp-Source: ABdhPJzp2j1WBUYT8rPnbsMZOwDxICxXaBTrW1gnSR2unvwyolUmYMDOp6mIsVHcdlIRYP0b4ofc5Q==
X-Received: by 2002:a63:2482:: with SMTP id k124mr4072350pgk.332.1598292892599;
        Mon, 24 Aug 2020 11:14:52 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.14.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:14:51 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 2/6] RDMA/bnxt_re: Do not report transparent vlan from QP1
Date:   Mon, 24 Aug 2020 11:14:32 -0700
Message-Id: <1598292876-26529-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
References: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

QP1 Rx CQE reports transparent VLAN ID in the completion
and this is used while reporting the completion for received
MAD packet. Check if the vlan id is configured before reporting
it in the work completion.

Fixes: 84511455ac5b ("RDMA/bnxt_re: report vlan_id and sl in qp1 recv completion")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 2f5aac0..0c5fb79 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3264,6 +3264,20 @@ static void bnxt_re_process_res_rawqp1_wc(struct ib_wc *wc,
 	wc->wc_flags |= IB_WC_GRH;
 }
 
+static bool bnxt_re_check_if_vlan_valid(struct bnxt_re_dev *rdev,
+					u16 vlan_id)
+{
+	/*
+	 * Check if the vlan is configured in the host.
+	 * If not configured, it  can be a transparent
+	 * VLAN. So dont report the vlan id.
+	 */
+	if (!__vlan_find_dev_deep_rcu(rdev->netdev,
+				      htons(ETH_P_8021Q), vlan_id))
+		return false;
+	return true;
+}
+
 static bool bnxt_re_is_vlan_pkt(struct bnxt_qplib_cqe *orig_cqe,
 				u16 *vid, u8 *sl)
 {
@@ -3332,9 +3346,11 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *gsi_sqp,
 	wc->src_qp = orig_cqe->src_qp;
 	memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
 	if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
-		wc->vlan_id = vlan_id;
-		wc->sl = sl;
-		wc->wc_flags |= IB_WC_WITH_VLAN;
+		if (bnxt_re_check_if_vlan_valid(rdev, vlan_id)) {
+			wc->vlan_id = vlan_id;
+			wc->sl = sl;
+			wc->wc_flags |= IB_WC_WITH_VLAN;
+		}
 	}
 	wc->port_num = 1;
 	wc->vendor_err = orig_cqe->status;
-- 
2.5.5

