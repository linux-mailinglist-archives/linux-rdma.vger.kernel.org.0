Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054FB5981AD
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiHRKwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243983AbiHRKwp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:52:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E186714
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:52:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e20so788655wri.13
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=RMX6NQy5TmaoJwVuQQyzecsTkgYpDVpBpq86MnX7j48=;
        b=NKNIyxfIq0MKjsOBV8AS+iue86Q3AGbmDnP7/hgnLtSgnNRoSSMUSmJiUH0xM+fMjb
         arITv1NMao+rDER0QCMKSuqj3tOsAEyKTXrTV7VHvRSbmGWz8vlZI0koqSbJbJOTSjyu
         /9sMew0GtoC5BGAQa6x3Ki12nATEypfEluGzImzGDt0Ib314/oXaITaWlJIfCNHVy1H3
         9T6JHK4Hzphpi7dfe3J3INXdgmj1hu4jv23XYQ4sznFXPeAd7upAXU8Im8BFinAi7E0b
         47lj/xBaDgho9w//+j1bA7UNOttx/V1cIzGilToKdvysSR5L0v3IPxjIp4j2qWJ5JSuy
         E00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=RMX6NQy5TmaoJwVuQQyzecsTkgYpDVpBpq86MnX7j48=;
        b=sJeeSE+5919EaVreGYzNCLyH/aya7vzycQSd8KDTQTLCEL0cgsCOIHSh6eZ1EtBSkb
         Ha4ZBWaaarBlqbFVswWAq+h+c+aQCHDvMhbFw3hAJuGbSlmM3VCtKdD9Lb5LrFQL1CbT
         LN0iEmNKNgn6evxVb95oTsAnt1fFQlGpK23DyM92u2j8UwBe3GefRmgKHRr546YnESTG
         tQsRvkGD0+Tbqe5WVmCdV/EDukzVJVwqe7r6OdQP1WGatrcvNdfezHSIDLr+Q9GrE/Ws
         5B1kSQbbFFzWgKqvyJ3h5Lvwla0iNQ9Mt703C5KfD0HZP5Dl2+J/x1fG46kIThWVS/Lo
         nUsg==
X-Gm-Message-State: ACgBeo1tR89vWFoRFdPdIZ+s/xYnT7J7umSw1AntbyBogrAfm2BhH1Nl
        hnWoYTgdLADHOOxsTgk+r0MRqkHKPiMIuA==
X-Google-Smtp-Source: AA6agR6tEd6FTeVKIyO5rcAVoE+UX1/YX0ta5czFvA8QyCSc03CpLeLrSnrbpKkKBl/6jurPSDnZ7g==
X-Received: by 2002:a05:6000:993:b0:222:d509:4b5b with SMTP id by19-20020a056000099300b00222d5094b5bmr1336406wrb.52.1660819963468;
        Thu, 18 Aug 2022 03:52:43 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm6233583wmg.5.2022.08.18.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:52:43 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH for-next 0/2] Add trace event support to RTRS
Date:   Thu, 18 Aug 2022 12:52:38 +0200
Message-Id: <20220818105240.110234-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

The patchset is organized as follows:
1: Adds trace event to rtrs-clt
2: Adds trace event to rtrs-srv

Santosh Pradhan (2):
  RDMA/rtrs-clt: Add event tracing support
  RDMA/rtrs-srv: Add event tracing support

 drivers/infiniband/ulp/rtrs/Makefile         | 10 ++-
 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c | 15 ++++
 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h | 86 +++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  7 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c | 16 ++++
 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h | 88 ++++++++++++++++++++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  8 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |  5 ++
 8 files changed, 228 insertions(+), 7 deletions(-)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt-trace.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.c
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-srv-trace.h

-- 
2.25.1

