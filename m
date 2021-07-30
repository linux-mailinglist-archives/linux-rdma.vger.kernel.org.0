Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E909D3DB92C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 15:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhG3NSl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 09:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhG3NSk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 09:18:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AA1C06175F
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b7so11305126wri.8
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I23W8uRoYmeDeWltvLdj9fSm/dRKdVOIpfqaw3NOMS0=;
        b=DB0dzy8CBrXuhgxjNZBDYqMMAxbC/RQ28vwrShzk//CvdvgYnS+l57vaWFEFtZoNYv
         JHMVr+G/ZOGuEHu/6mndAoUV0KuxuTyGTuwxV1Vu4mwsr1qlzCkMb9Fi2b9GmDVus/b5
         vmEuZEndwErXHQQqqJBUOjopmzy2fGrMWqOa2EHCUArQRX9P3QEDcqfOvAcG04ux0s5m
         mdZLB6YdwWxm379n48LeO+No3rtRHMDhT1WfklEQ2Mx3+u99o6/yD5r8Ae2/vggWSsgB
         zyQGyODsTcoPukFXfBPsgsrr/ip3VpNtJBR1OAnAqCfYVNl05VS1XB193PVcRiPbz/rP
         YfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I23W8uRoYmeDeWltvLdj9fSm/dRKdVOIpfqaw3NOMS0=;
        b=mA2z3CdG1WR9qnQYOgFmDcv4GGS4lMFXGImKyqLlpKIsdaq0sQ5LWWstj5ltXvuvoQ
         xWwnunM+U0fpS7GysoUo1A6qK5H9DKBzlQdNwj56YjG0yJcHf/Yj500zXpbes4OGEa4C
         EWRr2C5SN1migAg6iKVey5edG+78BpbVM43HpKAKUCn+EucgOUiaM5OKfr9z79O6iwKz
         ee1LYDuSLMvxLS1AAZ0nF2xIpJvScjwYvpSQEjPZk2RLy8azPaE4nCigAfCafqTgTzjp
         VRQMIwZPG/JLZMOAJxsAlbbPcTPSKCPAPJaeyp7k4l2GVMCowiz30EIDcP0EPCtOWwei
         LbDA==
X-Gm-Message-State: AOAM531JOyU1izYc54l80hWRb9uRmpaHwNhApyOE9n8+6PllAzgMwdBO
        jyNsqMDMQ+6/BhBGJRaLmRBAnplyVBzZ1w==
X-Google-Smtp-Source: ABdhPJxjWn1dOy4kXDQRqqh4jsx+SeuGbvHSTcpO/Jjn5wbvPFjZvWUW7ptVNSE0el183t/s406lXA==
X-Received: by 2002:a5d:5906:: with SMTP id v6mr3092308wrd.194.1627651114649;
        Fri, 30 Jul 2021 06:18:34 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:496a:8500:4512:4a6e:16f3:2377])
        by smtp.gmail.com with ESMTPSA id z5sm1626012wmp.26.2021.07.30.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 06:18:34 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 01/10] RDMA/rtrs-clt: During add_path change for_new_clt according to path_num
Date:   Fri, 30 Jul 2021 15:18:23 +0200
Message-Id: <20210730131832.118865-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210730131832.118865-1-jinpu.wang@ionos.com>
References: <20210730131832.118865-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Md Haris Iqbal <haris.iqbal@ionos.com>

When all the paths are removed for a session, the addition of the first
path is like a new session for the storage server.

Hence, for_new_clt has to be set to 1.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index ece3205531b8..e048bfa12755 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3083,6 +3083,15 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
+	if (clt->paths_num == 0) {
+		/*
+		 * When all the paths are removed for a session,
+		 * the addition of the first path is like a new session for
+		 * the storage server
+		 */
+		sess->for_new_clt = 1;
+	}
+
 	/*
 	 * It is totally safe to add path in CONNECTING state: coming
 	 * IO will never grab it.  Also it is very important to add
-- 
2.25.1

