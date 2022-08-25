Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B15A1B36
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Aug 2022 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243838AbiHYVjH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Aug 2022 17:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiHYVjG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Aug 2022 17:39:06 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD2DC12E7
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:39:06 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo6242361pjd.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Aug 2022 14:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CngZ539gugg62FsOkdDqUkWXDobyOMKL3TWgPs7/Tgg=;
        b=NFr2IFPpaL1m4nNEKV7KlAuYx1p2tqXBSXYZFj6BbzCyovLhA1TpP1p1Et5NOdkKM3
         yFaEWs/SQgkWHYRACdZkKyiqeonGdn3qvudYLMxH34pIREKTY4hjkmMdH/OsDFaT0zPW
         dbb88NGeYhS5v+Na4W7VY1HM9T5J9zYCdG2AeazSI19lyY2REPfDvDTCzlRGj3629dC5
         wmmO8TpmYoS8gxtdELfLkNbaJvixZ3W2I9quXFSEOzzmeQOEXPJghDcVvIBA/1/KT341
         XagTSbhMHo89vgKGHRoDi0Ekx1/PgOWA4Cd0Fng1xhNy4Ju4MaTz2CMSrzB/o+qHIFWp
         JmDw==
X-Gm-Message-State: ACgBeo1Kxyem6sK8qoRCyMaKAgb0A3E7TSgORyyr7k7zwj3pqNWm8zF2
        qIucw/NEj7rsE05710wG0X4a2wx8i6Y=
X-Google-Smtp-Source: AA6agR7lI+szFEGAAYdCU9oCixg3S+PIijBH3yoFdP+EqFOGwmdkG+wZhOK/BCzk492WSXzzuagIHg==
X-Received: by 2002:a17:902:7c11:b0:172:71ea:e99 with SMTP id x17-20020a1709027c1100b0017271ea0e99mr952354pll.73.1661463545641;
        Thu, 25 Aug 2022 14:39:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:349c:3078:d005:5a7e])
        by smtp.gmail.com with ESMTPSA id n27-20020aa7985b000000b005379e480445sm111676pfq.94.2022.08.25.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:39:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] RDMA/srp: Handle dev_set_name() failure
Date:   Thu, 25 Aug 2022 14:38:56 -0700
Message-Id: <20220825213900.864587-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

This patch series includes one patch that handles dev_set_name() failure and
three refactoring patches. Please consider these patches for the next merge
window.

Thanks,

Bart.

Bart Van Assche (4):
  RDMA/srp: Rework the srp_add_port() error path
  RDMA/srp: Remove the srp_host.released completion
  RDMA/srp: Handle dev_set_name() failure
  RDMA/srp: Use the attribute group mechanism for sysfs attributes

 drivers/infiniband/ulp/srp/ib_srp.c | 50 +++++++++++++++--------------
 drivers/infiniband/ulp/srp/ib_srp.h |  1 -
 2 files changed, 26 insertions(+), 25 deletions(-)

