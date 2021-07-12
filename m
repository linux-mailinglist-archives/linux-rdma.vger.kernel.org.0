Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D4F3C43D4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 08:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhGLGKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 02:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhGLGKl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jul 2021 02:10:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F71C0613DD
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n4so157750wms.1
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jul 2021 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Onc/5eS9KWdA/2NhGa4fpePiaaNTaPXYl6aJQvZffHQ=;
        b=dUjThzz6wMwydBdvW0F7QPIluVb+iMAbfD19YX70WfZImUAwbZaVOkn7mN/reW5MAM
         jl2CgpwTufNlejNkS4jmfi287FE5LhQtwqG3txGRJnZPkvru6n/US8L5et3CtHTr+mGw
         CeC+38xLe9Lou33r70k/6oQB/W3MfwFEv3nhIF0VpC1z9lpNv+I9okhjeRo51p9mWJ9y
         AIbZo7/E1uENnNI9yO//N+MRcpAowsD+C7mQB8pETLmyFTntIbWdLKIgU1SB5bZMf9vo
         1svuTQknBKZE2Jh3su2xrftkyFIjQtI7zKBHsI8IROS+4tvNAiOTVZsC7fQR2eL1oBxC
         SjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Onc/5eS9KWdA/2NhGa4fpePiaaNTaPXYl6aJQvZffHQ=;
        b=ZnYEF1EYC92LIuH7KzZFZH11hg83jGAMgTFRzFK16241KXF/fZpolyUDAmPU+CCkTT
         JC4mONqVL8nADEyXaLtlulFwHgVMUw8+ggivmB6w5L+bL8sdpzJmnv0aE1vxnM3ww3Br
         0Ume5L5waEn2qQipwqcNy3DzZM8ZzuO/dSZBd8/VR8IrKUNeQ/KHZatcaymt8hvQaj7A
         3rP9cu4ayZSF/mpXhtfSiH5yvawpbykan5r/q4lVyklr4nUQ7xBn2Cqmr7+56FZO2KbG
         dgO01fwJ6Yv09TvFOVYexyTs69oIlPPur7NWZgN5y2GlS2k/m1TVbt2DDLIyPcGjd7Iv
         5CfA==
X-Gm-Message-State: AOAM532apHlAbTK/1evgy/LmP8sgCehRd/8JI6GHrloMwh66cjpUC43i
        9eYOo6GXAL9fgiojHaE+SrXpE+fWOGGJ+g==
X-Google-Smtp-Source: ABdhPJw7ADQwwTS7VhLlEaiwncgcfNCqUHsR5kMf++zOCs1jEjHCbEWLQRrH4VYaNXlvd2FBsjIpSg==
X-Received: by 2002:a05:600c:354e:: with SMTP id i14mr1358663wmq.96.1626070071794;
        Sun, 11 Jul 2021 23:07:51 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49bc:8600:895c:e529:e1b8:7823])
        by smtp.gmail.com with ESMTPSA id s17sm13344245wrv.2.2021.07.11.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 23:07:51 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCHv2 for-rc 0/6] Bugfixes for send queue overflow by heartbeat
Date:   Mon, 12 Jul 2021 08:07:44 +0200
Message-Id: <20210712060750.16494-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to upstream.

This patchset fix a regression since b38041d50add ("RDMA/rtrs: Do not signal for heatbeat").

In commit b38041d50add, the signal flag is droped to fix the send queue full
logic, but introduced a worse bug the send queue overflow on both clt and srv
by heartbeat, sorry.

The patchset is orgnized as:
- patch1 debug patch.
- patch2 preparation.
- patch3 signal both IO and heartbeat.
- patch4 cleanup.
- patch5 cleanup
- patch6 move sq_wr_avail to account send queue full correctly.

The patches are created base v5.14-rc1.

Since v1:
* rebased to latest v5.14-rc1, target rc instread of for-next.

v1: https://lore.kernel.org/linux-rdma/20210629065321.12600-1-jinpu.wang@ionos.com/T/#t

Jack Wang (6):
  RDMA/rtrs: Add error messages for failed operations.
  RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
  RDMA/rtrs: Enable the same selective signal for heartbeat and IO
  RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
  RDMA/rtrs: Remove unused flags parameter
  RDMA/rtrs: Move sq_wr_avail to rtrs_con

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 11 ++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 19 ++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  2 --
 drivers/infiniband/ulp/rtrs/rtrs.c     | 23 ++++++++++++++++-------
 6 files changed, 37 insertions(+), 25 deletions(-)

-- 
2.25.1

