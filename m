Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C292035540B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Apr 2021 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbhDFMgv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Apr 2021 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhDFMgu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Apr 2021 08:36:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A6DC06174A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Apr 2021 05:36:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hq27so21610263ejc.9
        for <linux-rdma@vger.kernel.org>; Tue, 06 Apr 2021 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6adHqUt9emWHWrwApdCggGYZKb11bki6anbVfcLvftk=;
        b=JD1Kw7MBkWdYO66HTZjntczU9PvcQY0Kxl3mYKc9BRTgRctceB3kjCwpRPE2LWJE4y
         9mGlFK2Uony8aEnDFBOGUTuFCtB1WlPQiycd0x9Wgf3ynn5Oh6Z9F9NUavBFAWQHboiP
         n1VPuMU1/hJirVt0l5XfXdrcqthTpNH/H9ryfYK9Grc+kokfrPQzg7NElamRb0xpTluQ
         //2UMoB2+b+sQd+7yC/1+R6F0FOkPXabYCaR1nydQW/EONgiRkEiB4byC7pMxzvJ20m2
         giiO4dl1nirD1Zq9U5jf0M6bYP5/pZYH52u5z7kQ/On5jA8qohNPv5uZyVDW9v/BhzZZ
         /oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6adHqUt9emWHWrwApdCggGYZKb11bki6anbVfcLvftk=;
        b=bJVruhr7xj9UcAmJdD7Wiz7LVxsqCXY8TOf0LJMOSu/VKfUqRtAhc3eqUE7zREQbuF
         keqJQs7Sx8rGJRcK+3chmdnNLX45ISJtCg3CfIXtbu7FpVVoH5Hq0T8hT0U4HQmj2CfK
         mwK1I32YA7xRnla3YI8/gJS3LsKsT+X0Y22Hv9AXmPuT1foYZo9qJ1xE02SwguYzcDhn
         39kqNLT8moP7pJwB+N1g9OkHRVh60vHbh2y2YfiNbnfKhfQ4CwznThQTg+HrnXx4t5YV
         YniEYWJIgLoqiSh0GxC7j6mqhmFb/L4Pm4mnsBHHEMKwuqb4zqwGnSbvA+nvj7AjgjHe
         MQ1w==
X-Gm-Message-State: AOAM5331mEn1i7L5QE2H9rfPlmhL8G8lXLLrULO8BU9MNdqTy3StJIqm
        Sh8RP5xnR2WMtZpYGIxSZ2vZBIwrR5su2xOL
X-Google-Smtp-Source: ABdhPJwOBVS8fr3ffUWaNkjK8ppKbeI2Ma7kdsgJZ8em/xdCZbk2y5EcmwEDdWbG0RBitRGS7Cl/iQ==
X-Received: by 2002:a17:906:130c:: with SMTP id w12mr7315188ejb.169.1617712601556;
        Tue, 06 Apr 2021 05:36:41 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id p9sm13738384edu.79.2021.04.06.05.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 05:36:41 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 0/3] Improve debugging messages
Date:   Tue,  6 Apr 2021 14:36:36 +0200
Message-Id: <20210406123639.202899-1-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add more information into the error message for better debugging.
The old messages was just like "Error happend" without detail
information. This patch adds more information which session,
port, HCA name and etc.

V2->V1: add new line after variable block as requested by Jason

Gioh Kim (3):
  RDMA/rtrs-clt: Print more info when an error happens
  RDMA/rtrs-srv: More debugging info when fail to send reply
  RDMA/rtrs-clt: Simplify error message

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 24 ++++++++++++++++++++----
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 12 ++++++++----
 2 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.25.1

