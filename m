Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5BA2163
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2019 18:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfH2Qvg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Aug 2019 12:51:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35748 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbfH2Qvf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Aug 2019 12:51:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so4564453wmg.0;
        Thu, 29 Aug 2019 09:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROs74LHAAGb3AWiHq6/1CR6l2I0sb4RXNCxoGizOtu0=;
        b=OQexBvmKcQJh1mOOo/yLi69MnMVqYp237omrwKSC7XANirKosrG6sajmraWbdTzanI
         h5tzP2KiP8XycP+46XMar0s9fIh7q35oBu6XHl0HS2Pr0BIhLio+QubhORwe/aESbsr8
         CRaZGMGWttIfTQicr4A/MKs0gIrJhihtF+xC8B8QeV+IzpnXRtq67qNQUe8iDHijok9R
         FNsAWXxcFi/19sQtw4Q+5oPBKNZQ+oXnUd8vAzZ6m/PxrDj3eH2D0soCPOkQDnxPumhp
         vurlIaqQfvtdzAsjiFI/H5IEn0SKTdxjur3Fo6BbKgwE3dd67fwtZWrNko5sBDCXHYCK
         /aVQ==
X-Gm-Message-State: APjAAAW32ylzlNVaCzBlEvquoWbNunihiv7cTjvFCWgNqFJKVebwrN0S
        FF4tLBwnHXj/e93rs9MRcAMJwqaaq5A=
X-Google-Smtp-Source: APXvYqx1hGa8eiE1n5Y6dWRDwVmlUhfIhlVLSABr36xRlgMq0/LqySvRcvZj2+1+YFB9w8Tb7sKdMg==
X-Received: by 2002:a1c:6a0f:: with SMTP id f15mr523220wmc.147.1567097493996;
        Thu, 29 Aug 2019 09:51:33 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id o14sm8340770wrg.64.2019.08.29.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:51:33 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-rdma@vger.kernel.org
Subject: [PATCH v3 08/11] IB/hfi1: Remove unlikely() from IS_ERR*() condition
Date:   Thu, 29 Aug 2019 19:50:22 +0300
Message-Id: <20190829165025.15750-8-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829165025.15750-1-efremov@linux.com>
References: <20190829165025.15750-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

"unlikely(IS_ERR_OR_NULL(x))" is excessive. IS_ERR_OR_NULL() already uses
unlikely() internally.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/hw/hfi1/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 646f61545ed6..1c52b19dd0f8 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1040,7 +1040,7 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 	if (cb)
 		iowait_pio_inc(&priv->s_iowait);
 	pbuf = sc_buffer_alloc(sc, plen, cb, qp);
-	if (unlikely(IS_ERR_OR_NULL(pbuf))) {
+	if (IS_ERR_OR_NULL(pbuf)) {
 		if (cb)
 			verbs_pio_complete(qp, 0);
 		if (IS_ERR(pbuf)) {
-- 
2.21.0

