Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D153E296A
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Aug 2021 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhHFLVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Aug 2021 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhHFLVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Aug 2021 07:21:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2636C061798
        for <linux-rdma@vger.kernel.org>; Fri,  6 Aug 2021 04:21:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id go31so14549401ejc.6
        for <linux-rdma@vger.kernel.org>; Fri, 06 Aug 2021 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7DyNm0iQRGOW7AOkX1mMbfEa4OlHJHGoqn1ua301NQ=;
        b=P05UeZ8nYVx+OggjZMeU9s+1chQRgORpaSo2pXT5IGFwwCrh14KOiwjYx2uwJ7HR3/
         +VfxpZ9WbrW51JW5/8NuW+uL7VwpEkqCZfuD8vZZYEblVc4QwKw3U4KvDaNuKkLrH1fD
         O/PEHVdvkXFGjCJdgTAd7Yuh1P+jHNyjt4pEYcFUSCQ7Pj0/aVDB3u3RBGpDYppq6orj
         AzwbAk+zUNcZBDtmhjuKjUTkl9WbuaTiGNieIO55pc2JalC59zZK+srxnkN5GWXPNeiE
         YByCtGmXndFaFhpqcHI/7Y1Dj/iybHhELXFYVmpAr+n/askU9MghtR6BwJ+BcNEU2dHM
         W2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7DyNm0iQRGOW7AOkX1mMbfEa4OlHJHGoqn1ua301NQ=;
        b=V3nvPUC1hIV14PZTlISEQ7G7YBKqR+WP794avaz+CxfLCoNzkRiFfPkOJpY7hEgIHS
         mYXitoejdipTPRWfMfAtxh+6X5gFAvPFZ97tUX8mW+1wCv27UVZUTudPu/sf8X5WAc15
         iEXI7hfhn72Qr0PpyRy7MDyvk5Xfwbs50HKQfWXTX3lOBWfYtdyy80buEYH0O6lzoFqI
         nI1OTFQg29w7SrV3aiPXk7kwHFrf2/1wpNbAkwAYClx+S9tHM20XW9R6o1YeJTLJS/V7
         +U9i3+jAabzkSBCnxhSos9uItRQ2dxnPUC9A368/FMmpLfKnIIo3oI6POgaa0a2F5eVy
         S2CQ==
X-Gm-Message-State: AOAM530Jt18pZJ6HNE0xzOTlHR9JHo2XiViusMz5QTsF8OxgEx9xmYF5
        BypPcrSLAbKQyAo2R++YrWRShcxzePLNRg==
X-Google-Smtp-Source: ABdhPJy61lpR4L4R+UaY+dueISxGUkcpPq0o3RbkREKtSR4u07CXhdGVIG/xVCMpp0hCqv6v8Aj/HA==
X-Received: by 2002:a17:906:7f8c:: with SMTP id f12mr9359743ejr.344.1628248889280;
        Fri, 06 Aug 2021 04:21:29 -0700 (PDT)
Received: from nb01533.pb.local ([2001:1438:4010:2540:9e61:8a1a:7868:3b15])
        by smtp.gmail.com with ESMTPSA id q11sm2794729ejb.10.2021.08.06.04.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 04:21:29 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 0/6] Misc update for RTRS
Date:   Fri,  6 Aug 2021 13:21:06 +0200
Message-Id: <20210806112112.124313-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.

The patchset is orgnized as:
- patch1 bugfix for corner case.
- patch2 remove unused functions.
- patch3 Fix warning with poll mode.
- patch4 remove likely/unlikely.
- patch5 Fix inflight io accounting when switch mp_policy.
- patch6 remove void cast.

Thanks

Gioh Kim (3):
  RDMA/rtrs: Remove all likely and unlikely
  RDMA/rtrs-clt: Fix counting inflight IO
  RDMA/rtrs: remove (void) casting for functions

Jack Wang (2):
  RDMA/rtrs: Remove unused functions
  RDMA/rtrs: Fix warning when use poll mode

Md Haris Iqbal (1):
  RDMA/rtrs-clt: During add_path change for_new_clt according to
    path_num

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |   4 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 145 ++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   6 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  79 +++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   4 -
 drivers/infiniband/ulp/rtrs/rtrs.c           |  17 ++-
 6 files changed, 135 insertions(+), 120 deletions(-)

-- 
2.25.1

