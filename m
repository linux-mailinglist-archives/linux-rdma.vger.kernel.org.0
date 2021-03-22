Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6823034397A
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhCVG35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 02:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCVG3g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 02:29:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A412C061574;
        Sun, 21 Mar 2021 23:29:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id c3so9514153qkc.5;
        Sun, 21 Mar 2021 23:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7S8wszVCZutB0BgR+3NxA4LGclj2tYSSOUAwHuVGVkk=;
        b=nrvzg1mykiPUEFA9Wu6/ac6jSk2R60PsInBNV6/fmIanXo9AaBeQIsZsmKxxNzkFDq
         mdurS5wRrDIks9gZt9KtNWGIDAlMvr0KDfYtD4V8Yj4Q93xyTcQzoHhA933HuBR5jP7e
         TwgnyEQsXF9SxH4nM0GQxQAYmi4tD9d9lMkGpVjxgsOX8s1TBlS/BCdHzi2LpSr/nRP2
         /LMPYlXPMuiNupsf4S5lJVlm/RZJBRfxHdANt7dhpOHF1fB4KStR17jzbuokwCXbUe0o
         WiImK+33kw/NfK9ezxEBm+Z9H51A3JGgwjtYJ4i64HrEyaGNNy4NcpZXQnpML6biI6nw
         LjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7S8wszVCZutB0BgR+3NxA4LGclj2tYSSOUAwHuVGVkk=;
        b=KMPFchQZiDoIqteQMyh6kYY8ppvmdJ8b3y3uvwCZjB+Ntjz5Xi5YIPDWz26Qt+6u0Y
         DQF5UJwR/gx8/rMx+VyxHfmxvNaOAiUy7/ZK3JREX732N8tEvnpTWuxiMUJCESg+1vs1
         8CldxiQ54vsi1gB7Kr/DFDJ4FeaQG5DYXE+ZOv7YFXAq9O9qsS5YBA+4G/YE+uREuqGl
         IuUdD21dJJIZeMO8MIGs+zt6iobq7OuYIVg36H4n2bmnyNnOkvPTz4nOp8yoSaLeF0Fg
         clwdbzhsy0aMPPpRNkWhzfh58uxDIMOeUOl6yZ56SiNCITT0j2fWxrOzJCvEqt+uO2dN
         46uA==
X-Gm-Message-State: AOAM533iZHZDmHDIJHuwn95zXfzkpqGxbGhvDbqHfu9sDUzhwv1ykNjq
        xUxKV2NMvc3X2IVjeO248Ig=
X-Google-Smtp-Source: ABdhPJyYnRBlk1TUKa3o8Pw8P9ZqdtMJgf9PyM5B6FkI1HFjpriOd9z6NgVG9zmMozsy/TSmZTcbxQ==
X-Received: by 2002:ae9:f10b:: with SMTP id k11mr9610572qkg.62.1616394575406;
        Sun, 21 Mar 2021 23:29:35 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id r17sm8424544qtn.25.2021.03.21.23.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:29:34 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] IB/hfi1: Fix a typo
Date:   Mon, 22 Mar 2021 11:59:23 +0530
Message-Id: <20210322062923.3306167-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/infiniband/hw/hfi1/iowait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
index d580aa17ae37..377e00a109c2 100644
--- a/drivers/infiniband/hw/hfi1/iowait.h
+++ b/drivers/infiniband/hw/hfi1/iowait.h
@@ -321,7 +321,7 @@ static inline void iowait_drain_wakeup(struct iowait *wait)
 /**
  * iowait_get_txhead() - get packet off of iowait list
  *
- * @wait iowait_work struture
+ * @wait iowait_work structure
  */
 static inline struct sdma_txreq *iowait_get_txhead(struct iowait_work *wait)
 {
--
2.31.0

