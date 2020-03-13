Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9F931846E5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgCMMbx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:31:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52401 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMbx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 08:31:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so9723853wmo.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 05:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=99OU5UGue76KclNdz7jp0bCEb+mNo7NyQ+ZvQuL8dMU=;
        b=Cn5axPSyS+tLgmu0OeVzES262XeQKYni8/M9WL0Mkm/4vtx+TvgF9ZDjVgbqtHtH9l
         mXeGogXZFYS5/fhiP2WknxuTnIuuf+3TJv+HjjXq3YVwll13oq1d8PTtsWMWb7W7+TBq
         dOD9Um0A7NIrDLLdeLBzWNaXCmianEFx4URDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=99OU5UGue76KclNdz7jp0bCEb+mNo7NyQ+ZvQuL8dMU=;
        b=Tli/UsLZw1j4sMIgYGVeCxjUXzdrLcFGH1lLvD4/+m6cKnAaJiT4h46cSsaU9s+KVE
         PxJA2JUBRVnAB3k/ghJQJimd7xkz/MT4DAYaNsnzwTsLVNzcMyPeJEwkC2kR3I1vEhg0
         /BwPuArjtYTv0IGPIPsJbCZCyt2JfwbWGdo4LbLM7PMaeYE5XohqpEusIOKjFmddpLoA
         zxSRzKo3qcFbM/H9+25QgegcMb5jO2XypCW8uUwdTURmzmn+HscUQqO64iNcSMzX4Q1v
         EwMkX2YkqKnMGQYTDhzLRuNfrpPpnnaLtN3tETSzzr59YiI3yP8fL7aMpyDfMBfrYCqF
         LU7A==
X-Gm-Message-State: ANhLgQ1fuSOrdRaTG8K4FTVbIMi0NdKm8UxCQ3nSvz4Pu3FPSV+KPFfd
        DFCAw/rU9PdI3gtpL6rFk3ceuw==
X-Google-Smtp-Source: ADFU+vtiaEWq0pnGFwEVEC2GgMCfAVe+fF07k1hJ7Dpt6EuPlf0B+lFGshEXbBG18ZpWpQart50b+A==
X-Received: by 2002:a1c:a714:: with SMTP id q20mr10666802wme.148.1584102710474;
        Fri, 13 Mar 2020 05:31:50 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g129sm18015910wmg.12.2020.03.13.05.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 05:31:49 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/3] RDMA/bnxt_re: Fixes for handling device references
Date:   Fri, 13 Mar 2020 05:31:31 -0700
Message-Id: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid the driver's internal mechanisms to check
for device registered state and counting the work queue
scheduling.

Jason Gunthorpe (2):
  RDMA/bnxt_re: Use ib_device_try_get()
  RDMA/bnxt_re: Fix lifetimes in bnxt_re_task

Selvin Xavier (1):
  RDMA/bnxt_re: Remove unnecessary sched count

 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  1 -
 drivers/infiniband/hw/bnxt_re/main.c    | 34 ++++++++++++++++-----------------
 2 files changed, 16 insertions(+), 19 deletions(-)

-- 
2.5.5

