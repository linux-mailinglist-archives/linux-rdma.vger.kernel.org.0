Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DB74B79E4
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 22:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiBOVFe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 16:05:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiBOVFd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 16:05:33 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8240E2A720
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:05:23 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so326091pjh.3
        for <linux-rdma@vger.kernel.org>; Tue, 15 Feb 2022 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NG1NtLjDLOqFDQn3g8SS4xROmde+3nnIR3F2M3XJICQ=;
        b=j/gQoeeap9QxgnZ7md6zciklQBZ77Bip/Kw/udXUyFwYxqgSfRove/q2famvkM+Zce
         kI6VZOW2jOEunplfzIvwFD0vuzWr7EN7JOWtVS79Y40xNX6VIco/76hEviJp6ERyU/jt
         45UWoXLfmh5QF1xHKiFCm/lWR3tKUwEbH1mR6BB8pXfXGsNyIwwNELTFp2ioypd5BKm6
         oALij6nEGe4jbpC57sbnXzEI2XSolWfLiUrc2VmCJH3BnFuFksfUpIQzntf6Gs4e9iCk
         fL05kw7Cmr8vlZ1Gp8FjCjgrToouEvPEooc9CKUPUL+TAmdLNPGBugTbMbIjnfaumN5B
         FIGg==
X-Gm-Message-State: AOAM530cneAfa+ZUta14B43HFOzegpwpHeHYxHihmHBrDTev72nb8AHB
        YgpNqc0oInvCbtshVicVtKazMCrk/z/8FA==
X-Google-Smtp-Source: ABdhPJw8/rncUSZYkiuyrXAprxB3tcKYC8FT8/1VnV3vbz2qtO2t2ApEFyU7mcfybqG8Z8iIDBi29w==
X-Received: by 2002:a17:902:8a90:: with SMTP id p16mr740947plo.60.1644959122890;
        Tue, 15 Feb 2022 13:05:22 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id i10sm19223888pjd.2.2022.02.15.13.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:05:22 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/2] Fix a deadlock in the ib_srp driver
Date:   Tue, 15 Feb 2022 13:05:09 -0800
Message-Id: <20220215210511.28303-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
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

This patch series fixes a deadlock in the ib_srp driver that was discovered
by syzbot. Please consider these patches for kernel v5.18.

Thanks,

Bart.

Changes compared to v1:
- Dropped patch 2/3, the patch that converts a spinlock into a mutex.
- Simplified patch 3/3 by removing a flush_work() loop.

Bart Van Assche (2):
  ib_srp: Add more documentation
  ib_srp: Fix a deadlock

 drivers/infiniband/ulp/srp/ib_srp.c |  6 ++++--
 drivers/infiniband/ulp/srp/ib_srp.h | 11 ++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

