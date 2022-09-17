Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBA25BB5BB
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiIQDJE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQDJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:09:03 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA779836B
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:09:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id r125so8304816oia.8
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=d8cDJreXni7+PEUr5lHxvg36JAHe3zODSWiTzbHjXp4=;
        b=Y9VMGne5OyiiV7PLff4ko52uj075aniPCAhBJdzG1J6jaAORmpl3MYavZaccje9If0
         EHR18cVYtSf9PEZOZQzNJfVFby2w5jMsORSHi/+VPwyFT1xI86HsqUfMx353JvQ48NPX
         uiMLMr94qv+yHFpGJjSDK6YKY+fZBqgFXwvBnf9hYd4r0QlEH5KlfzxgV6kpEZWOlZtq
         kyj7EcY2rPVvj+UcDL5hJGvrCC0eMV1gpa0moHgAHHKtf2ZdNQjXh4UPO3LOw/uuAke4
         5GteD5wLnHT5Gc5lEkLIlCOzkDoZaKagJ+SiIbHmtXFt91rPZSsidagcD/cnJ7PlQpko
         LEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=d8cDJreXni7+PEUr5lHxvg36JAHe3zODSWiTzbHjXp4=;
        b=whcn+KZo90+M6T1HJKxWMUc3YKnGX1NwGsTXa3mYBZ3ie8O1rmxsAJxFwj5nYf78RG
         Uwy+DctJro4oo2T491WvqdvkUM9d+0Rkyup2UInEdxYsIb6D4dTo6OCyOD8w31zmWYHc
         dlHfe9GmTjWkzqCj4HFyiEk3SGE0JD6whuK7pHVbAsQ4uDz5pTL+gNlrl8css1etd4Kl
         Y5jLb8V/UvsyQawjCj38mSQ2JZdg+SOP+50I5nie4yTzzkIokrhA/rJuS0Rg7WzMDYI4
         LfGNmHkR41J9x2BOg389yiCnRedqbzJSHzzg7HZbsEATRaIC4SimgCYxce1lIj0Wk98b
         0IGQ==
X-Gm-Message-State: ACrzQf0CqhAmXZ2ZiHJE9VeY92cdR6skg0AEEm1UEhM6rfkjQrDNTNcU
        XPp+q/NrRkbnyDdtszgs7kKaEBL2C4c=
X-Google-Smtp-Source: AMsMyM7kB7vaHsFx//xRzt2zVE4lcF26Gj8n9JtpvPou+vfYH3FYNvKWd5tE5v72jk+20UFRBNpoIg==
X-Received: by 2002:a05:6808:130a:b0:350:72d3:ea3f with SMTP id y10-20020a056808130a00b0035072d3ea3fmr1591094oiv.191.1663384140992;
        Fri, 16 Sep 2022 20:09:00 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id 3-20020aca0703000000b00342df642fd3sm9875774oih.48.2022.09.16.20.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:08:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/13] Implement the xrc transport
Date:   Fri, 16 Sep 2022 22:07:07 -0500
Message-Id: <20220917030719.21090-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series implements the xrc transport for the rdma_rxe driver.
It is based on the current for-next branch of rdma-linux.
The first two patches in the series do some cleanup which is helpful
for this effort. The remaining patches implement the xrc functionality.
There is a matching patch set for the user space rxe provider driver.
The communications between these is accomplished without making an
ABI change by taking advantage of the space freed up by a recent
patch called "Remove redundant num_sge fields" which is a reprequisite
for this patch series.

The two patch sets have been tested with the pyverbs regression test
suite with and without each set installed. This series enables 5 of
the 6 xrc test cases in pyverbs. The ODP case does is currently skipped
but should work once the ODP patch series is accepted.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Bob Pearson (13):
  RDMA/rxe: Replace START->FIRST, END->LAST
  RDMA/rxe: Move next_opcode() to rxe_opcode.c
  RDMA: Add xrc opcodes to ib_pack.h
  RDMA/rxe: Extend opcodes and headers to support xrc
  RDMA/rxe: Add xrc opcodes to next_opcode()
  RDMA/rxe: Implement open_xrcd and close_xrcd
  RDMA/rxe: Extend srq verbs to support xrcd
  RDMA/rxe: Extend rxe_qp.c to support xrc qps
  RDMA/rxe: Extend rxe_recv.c to support xrc
  RDMA/rxe: Extend rxe_comp.c to support xrc qps
  RDMA/rxe: Extend rxe_req.c to support xrc qps
  RDMA/rxe: Extend rxe_net.c to support xrc qps
  RDMA/rxe: Extend rxe_resp.c to support xrc qps

 drivers/infiniband/sw/rxe/rxe.c        |   2 +
 drivers/infiniband/sw/rxe/rxe_av.c     |   3 +-
 drivers/infiniband/sw/rxe/rxe_comp.c   |  51 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h    |  41 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  13 +-
 drivers/infiniband/sw/rxe/rxe_mw.c     |  14 +-
 drivers/infiniband/sw/rxe/rxe_net.c    |  23 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c | 766 +++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_opcode.h |   9 +-
 drivers/infiniband/sw/rxe/rxe_param.h  |   3 +
 drivers/infiniband/sw/rxe/rxe_pool.c   |   8 +
 drivers/infiniband/sw/rxe/rxe_pool.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_qp.c     | 307 ++++++----
 drivers/infiniband/sw/rxe/rxe_recv.c   |  79 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 204 +------
 drivers/infiniband/sw/rxe/rxe_resp.c   | 165 ++++--
 drivers/infiniband/sw/rxe/rxe_srq.c    | 131 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  58 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  20 +-
 include/rdma/ib_pack.h                 |  32 +-
 include/uapi/rdma/rdma_user_rxe.h      |   4 +-
 21 files changed, 1338 insertions(+), 596 deletions(-)


base-commit: db77d84cfe3608eac938302f8f7178e44415bcba
-- 
2.34.1

