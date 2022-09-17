Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFC5BB5C6
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiIQDLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIQDLR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:17 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824A650730
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:08 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-127ba06d03fso54754260fac.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=d8cDJreXni7+PEUr5lHxvg36JAHe3zODSWiTzbHjXp4=;
        b=mAGACDAc6PTQLdcWUWUCaRcewJdW6z9jZvuJ+AQu6zoDp+XUm/xSLRP6g10t3sH6I2
         3Me+RZYmcMi5sdwOrZfbgZDbsP6b995Xg21WnX15MCU0IQvhOw+QloTVROur+9B7Eg32
         tNU5UPSjV71Ngsx3YvGXtOjUoITHG8J4soh9sNhEWTtsDarkb3RTT9oUgwscTnbJMeyP
         KYwEYDYyJUJjv13kwI67VFI6SQ/EvdobN3HcmPN9zUCtMPVbqgAeCkT7y6b/1f5nJgVe
         IFOz++nyuTyiiN9I7nzu1uOr8kK69cjhTs+b92RaMjTJSpKyTs0bR4RcXBAR5PfROZw3
         SfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=d8cDJreXni7+PEUr5lHxvg36JAHe3zODSWiTzbHjXp4=;
        b=5TZcvWCDo80bxLo/f/bI3zdOwpX4smXoq6tQWSHIukWkWshiZ0ok8xqUqFzmcvT6NG
         1vMN5pklcf2IPvIY9NZjhP0M3+mvj5InO1MjhdLKytoK9gtJWxVtPz/YEb1mMPf73MqD
         nqS9uSsdpwkMVYOSU3h5IZnay/wY8UtmvOtnmvhwQED03SC/dsTCduYbzKn7mWZrF4kr
         ngQRSWfkXXsqSupmX7j/TgTbc9d1TKgDAngZbaQZzaKHV8u280pSFk1VGpYUgyyp0Vvb
         uPSsSyunsxAIZLPVupE2gwTwqhfZztqXNLmL4lAtjZSJ+R2aH2df08DVGjjxvrYeEJ/e
         soMQ==
X-Gm-Message-State: ACrzQf0Vo6HlRemxWof2X15QKWw6WpUaaNatgdk0+4WKqTvxmrzH5Bec
        ks7l72zyrQBqWRKsx1tFi6gEvAxVzHY=
X-Google-Smtp-Source: AMsMyM7kdW95ojyan5m61opHaXs8gjmqzHbkUcNMyuKdrzejDJY/BL0me5l5vyxUmdyAUY6RSI1QWg==
X-Received: by 2002:a05:6870:a411:b0:126:7055:fc78 with SMTP id m17-20020a056870a41100b001267055fc78mr4657112oal.58.1663384267463;
        Fri, 16 Sep 2022 20:11:07 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/13] Implement the xrc transport
Date:   Fri, 16 Sep 2022 22:10:51 -0500
Message-Id: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

