Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF427F1E09
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 21:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjKTUfI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 15:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUfI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 15:35:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F8BCC
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 12:35:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32daeed7771so2948021f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 12:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700512502; x=1701117302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPLnd0zEgbH7opmyuQy8S4pPsVDIAfLM66/Z+vuHytY=;
        b=SbYlivgMfaDf5vYdNLtzZUzWp1M4O86fvTZA1I/Az5yy/rByWXm3jYk2BS0LPtE7RT
         IMOYs9OQGcHkXA3AvikNnSd8sbYbFn/h7+noFlkqzc77JIp8FSjlkCzk9lTHmoSHWU1J
         m+y03Yc3YML4qT7suZ37P5AlsQmu4qBcxz4w0EQ2XR0GmLbeg+EQY9n7S3F1fCgjKlUu
         XJq9bvd2X7Ag49FzextEBuwrb2Lzwlu2qpMoaUPdOVYpRP3rWa8Qzp0Mqjenccmr0rqY
         nfNQm7OSf074X34EyhL9vaYWCNuYfYy+69XDzhjTuWUMsmAXkez30rM6CaTCCniNe97H
         iy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512502; x=1701117302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPLnd0zEgbH7opmyuQy8S4pPsVDIAfLM66/Z+vuHytY=;
        b=MglJ+Jmlk0DYlMDCmiGP2HFMC4Dwvxg5nRMiaMfDvlN0NsA7SPVq2JYf1ohTWXLoWO
         6AbYREptH5kUN8bP5SXHoTQIVn3fLhKVyF/RVBCo5cwOz9+1YObHS4uGrT/tzMEMmW4m
         IC9wWCR04FYXkYpxQmm+zU87grVl98RpCaeitWdOtq4vUcMUMu9imQi9jfbAee12SlvX
         qfG9OsusfbhtJASwFRB0Fx74I/HhabpXSVxqCgunbz0YjKMjv1meQPkIqxAnEAg0/HSA
         FLej+bp+EcDtR8Q274cnSlzLWxn7Vi/E0uUalkrW+yG3c9TCfXM9nmwGbkdjolwPZJK0
         G6dQ==
X-Gm-Message-State: AOJu0Yze/xHuMKOj+M+Zgd/9aIpC4Gdk9LPPh+uJi/qnqrDvc1AeYkxK
        3ph/1VJjc7+W5YS5uhVtTkNewatc7tduy2CyELc=
X-Google-Smtp-Source: AGHT+IF2VUg2LtO8xN3K8kNRHtPn3ueKLwR8b7b5VFa1MPgRBb7aKU46F/b4vfMqjC0VvGqxQh3MYA==
X-Received: by 2002:adf:f4cc:0:b0:332:cb97:2cb6 with SMTP id h12-20020adff4cc000000b00332cb972cb6mr1303173wrp.21.1700512502438;
        Mon, 20 Nov 2023 12:35:02 -0800 (PST)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:140b:5d00:621d:e8e7:5d04:1c60])
        by smtp.gmail.com with ESMTPSA id x11-20020adfffcb000000b003316b8607cesm11258241wrs.1.2023.11.20.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:35:02 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca
Subject: [PATCH 0/2] bugfix for ipoib
Date:   Mon, 20 Nov 2023 21:34:59 +0100
Message-Id: <20231120203501.321587-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We run into queue timeout often with call trace as such:
NETDEV WATCHDOG: ib0.beef (): transmit queue 26 timed out
Call Trace:
call_timer_fn+0x27/0x100
__run_timers.part.0+0x1be/0x230
? mlx5_cq_tasklet_cb+0x6d/0x140 [mlx5_core]
run_timer_softirq+0x26/0x50
__do_softirq+0xbc/0x26d
asm_call_irq_on_stack+0xf/0x20
ib0.beef: transmit timeout: latency 10 msecs
ib0.beef: queue stopped 0, tx_head 0, tx_tail 0, global_tx_head 0, global_tx_tail 0

The last two message repeated for days.

After cross check with Mellanox OFED, I noticed some bugfix are missing in
upstream, hence I take the liberty to send them out.

Thx!

Jack Wang (2):
  ipoib: Fix error code return in ipoib_mcast_join
  ipoib: Add tx timeout work to recover queue stop situation

 drivers/infiniband/ulp/ipoib/ipoib.h          |  4 +++
 drivers/infiniband/ulp/ipoib/ipoib_ib.c       | 26 ++++++++++++++-
 drivers/infiniband/ulp/ipoib/ipoib_main.c     | 33 +++++++++++++++++--
 .../infiniband/ulp/ipoib/ipoib_multicast.c    |  1 +
 4 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.34.1

