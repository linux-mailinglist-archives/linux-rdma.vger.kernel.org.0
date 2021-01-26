Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD00303DDB
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403958AbhAZM4D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404114AbhAZMuI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7225C08EC2A
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:59 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so16324509wrz.0
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9JTe+jRXALQKf3yY8IU1E8sEuYfjFJES4qTh1TiteyM=;
        b=Meed0fqrtuRP5qb5w4GuMUsUbI4hj7GoqnFzKuoS/e3WeCj7/a6Vycj84cMinxtPCw
         mq5Y6noIM+LlWPZIfLKcIWyC/6ebjVbujaY0qIODGLptYZtWVdabraN2Sb7nhLtyYjpf
         J3LUIM3YmQZiyxmeORHTTFS8EppCtc4iMOrS3KbnvTyf/mlz/GQR9/r68lVL8ifUnTmc
         FhXWaWMCHTBlL94wQJTfshMfsUensOj+fwqvd4y4xWndBKylhMVyRpTPFCXNHG2zBjUZ
         mX+iDtpIaSMOSav7tet0FCTqiwHdloM/KiX9XVvdew1WtpXZik0LiiYCqTZtix7MxzVO
         tgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JTe+jRXALQKf3yY8IU1E8sEuYfjFJES4qTh1TiteyM=;
        b=pg5nttBYg2xNwg2rFo5ZmjiHH2upUgdbx41I9Oini5uARJOgiN83COFRworVpN6n86
         DZ2SKQDE1llpOua8x8eHUqyoFHB0GguiPxT+FT8gmys1TQnRl1l31WtScc/hiJCzaAoI
         eHkSvGjdludRngtFqhnlLu1JfoTaKrVuWLPsIbPPeTZpW2xZOk+VH2rSWa9krPnu7IGX
         FosxA3Sktas2Ju3z+hu90zvQ+hlFqgeSsO/bcBP1KqIYMvGac1+EuR2kc3wweWahkarJ
         fU/G7xNVBrW37tJt1s1B4t1btUIFODsKMCxsFam6+cXsJAXEFhk72KPWmKw78icNalDX
         U1fQ==
X-Gm-Message-State: AOAM5316DBigY0x+k/tcHrajJyMUIQJvmNTgexHSRPc5naFmIup8YouR
        GNW8A6sr4WEr66ALgCSq+RDzMg==
X-Google-Smtp-Source: ABdhPJy1jf9vr6ciXCO7+QCbDSXqsRfYt98g7N9DvzH95d3RzqN0DIBwvucSHQbJf5P4sRL0S7d3Jw==
X-Received: by 2002:adf:dc89:: with SMTP id r9mr5907515wrj.52.1611665278654;
        Tue, 26 Jan 2021 04:47:58 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 20/20] RDMA/hw/hfi1/rc: Demote incorrectly populated kernel-doc header
Date:   Tue, 26 Jan 2021 12:47:32 +0000
Message-Id: <20210126124732.3320971-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/rc.c:1388: warning: Function parameter or member 'packet' not described in 'hfi1_send_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:1388: warning: Function parameter or member 'is_fecn' not described in 'hfi1_send_rc_ack'
 drivers/infiniband/hw/hfi1/rc.c:1388: warning: Excess function parameter 'qp' description in 'hfi1_send_rc_ack'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/rc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 7194236aec8fe..0174b8ee9f00f 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1376,9 +1376,8 @@ static const hfi1_make_rc_ack hfi1_make_rc_ack_tbl[2] = {
 	[HFI1_PKT_TYPE_16B] = &hfi1_make_rc_ack_16B
 };
 
-/**
+/*
  * hfi1_send_rc_ack - Construct an ACK packet and send it
- * @qp: a pointer to the QP
  *
  * This is called from hfi1_rc_rcv() and handle_receive_interrupt().
  * Note that RDMA reads and atomics are handled in the
-- 
2.25.1

