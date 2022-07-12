Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24AC571758
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jul 2022 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiGLKbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jul 2022 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLKbS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jul 2022 06:31:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DEACEF8
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g1so9506398edb.12
        for <linux-rdma@vger.kernel.org>; Tue, 12 Jul 2022 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9dMcLv8PVXPjUgwLHRMONpy9bkg+PbPgBqx1+/vM5c=;
        b=Ep1BjMEstgNO/rV5gQ7eMoL4ivQzK5JciHu6p2+PmG0VJdw3TahHZK3bakmGa6Zg1+
         08Z7UF5ZyjI3QKRbU6fT3pVVmWhXtkILFdw4x4yXnocDMetMmGQLVzxlOAYX+ZAiEfhz
         RcpCOvokfJXGXBEgaKPukUYKLgNM2/IcxbPv9S9rFfz2kigkTWfWXDAXuBP/LfRBh6jf
         YvG4BJcAkJnP6J0C64BdJ2O4Nznevbo/NXRXa0aQfpjcFqsTn3h5fZ2nPZ/dGbMoDICx
         7aKg3SZ/2kWEgOKN+rW0kGQfuV2flx6zdmTJFLx+4eaVKzXCOPix2CC34SKbz5nKBbJ1
         bg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9dMcLv8PVXPjUgwLHRMONpy9bkg+PbPgBqx1+/vM5c=;
        b=nYLPqzSpCOPHZC42Vyw14D5n0AINhe+8idWaSwhQrPUvTlpQYyam2Zrf9slxV+dnOu
         kCrHxa1r0G8+xHWlPrXIfZntbB4jWSS1nCk1HFHTDaweRHMtuUfhVwzyAvBjW1WmLLgh
         1JmECkqbaLvJtKSZQc7MwA1p+CzCcuRlFCPSIHM7IReczqdS4fii4lr5FXpkA36H7/y7
         W/tNOqEKyHZiQmEsymVhglGVmKt59Lb3k3qr26YkKm7MZEhN2QchSspKPqEuP9h/cJS+
         wolw0wYcSsdBIsB7/FLuHXhKMpqdWWVFqbjGYfIYaRbAMp5igfaTktGkqiJw2QFRVP6w
         rChA==
X-Gm-Message-State: AJIora97HMTsI9EiGm7nWEprctu0kecV20NBCeLHXNLbOsGpgrxNiKer
        NjSofDEIQ8KyPIeaEa33lHgnBsdhKcrJ8A==
X-Google-Smtp-Source: AGRyM1tKbv8nrjVaq5/T732BlRHhiSfLQY8FlE1vjG9VYv5IfODdp0dZnAISwwgmrnCNMTFgr8i/fg==
X-Received: by 2002:a50:e608:0:b0:435:be99:202c with SMTP id y8-20020a50e608000000b00435be99202cmr30289719edm.407.1657621875651;
        Tue, 12 Jul 2022 03:31:15 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n18-20020aa7c452000000b004355d27799fsm5763419edr.96.2022.07.12.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:31:15 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 0/5] Misc patches for RTRS
Date:   Tue, 12 Jul 2022 12:31:08 +0200
Message-Id: <20220712103113.617754-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

Please consider to include following changes to the next merge window.

The patchset is organized as follows:
1: change to make stringify work for a module param
2: a change to avoid disable/enable of preemption
3: replace normal stats structure with percpu version
4: Fixes some checkpatch warnings
5: removes allocation and usage of mempool

Jack Wang (2):
  RDMA/rtrs-srv: Fix modinfo output for stringify
  RDMA/rtrs-srv: Do not use mempool for page allocation

Md Haris Iqbal (1):
  RDMA/rtrs-clt: Replace list_next_or_null_rr_rcu with an inline
    function

Santosh Kumar Pradhan (2):
  RDMA/rtrs-clt: Use this_cpu_ API for stats
  RDMA/rtrs-srv: Use per-cpu variables for rdma stats

 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c | 14 ++------
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 35 +++++++++-----------
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       | 21 ++++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv-stats.c | 32 +++++++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 32 ++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       | 15 +++++----
 7 files changed, 78 insertions(+), 73 deletions(-)

-- 
2.25.1

