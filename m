Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19DF3A41BF
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 14:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFKMMi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 08:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFKMMg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Jun 2021 08:12:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6604C061574
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r7so22441043edv.12
        for <linux-rdma@vger.kernel.org>; Fri, 11 Jun 2021 05:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gw8AkKCWJ6avoTNeQJDhqVUrYvZ16rNrP2dEWhslNug=;
        b=FBQpJXaf1nOr2Ro5d+C3hS0r+cIm/HJ2DxNLW5jL7RIr2EQbit+0QE2qvDHubHzuIW
         Uox+CQp92g8J2/K3b4HrZz0b7OOyut2YtElHPQHnnPXiN9QDbm3KTAkPZ/xewYILCiLj
         y0wxLLp/flecE3S7juh+UwW2ODHnUjR8muHUjEtKNYvkgGoVV1te/M6OZ5kis74hjlaX
         1E/j1MwKZ45c96shWioVS1WkDoihW6JiYaJcxQK2H77zZgGmIq/h8DS4eebJfaQF0ex2
         LlST1p8n/nbLWOVBnCo2v/DpbtbWSkEFqo3DTYkdVwuqvfL0k/jPQSVgZLAtwLBW3bt+
         buqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gw8AkKCWJ6avoTNeQJDhqVUrYvZ16rNrP2dEWhslNug=;
        b=Fdo3kIJqCK/Gw0ry8TQR1fJzt3TdA1apjJpnahCeLbvnKSFI5xw7h7oL5yo0sbyEKD
         RuHyIU0coGiB5QwWVdDhpRoCuvTFze+4phgVv1OqCCFpcHJ4vh+Zr5ulag4912ZwJnXJ
         E8+tQtGe55RogaRgGSe2xwyFN233Saexag4n8d/FVgXKI8am4rKQCEEjXEAfGSd20VG0
         Wf/fFkFyJUUxBxH3tAjbYrCraL/aIKquSsuqvmckF71epawclu5q6L1fh83NZ6jvVWZJ
         eIFczDp0xKEUyAycd9CEftQ7GrdQSXg0IYqTQZl4O/y9PkY5RSbzgIxstUJUG99VCgsZ
         u1Kg==
X-Gm-Message-State: AOAM531GpIaz95jaBZAwWmvQs2jJwczGhb3KvnuJraynobu2Mx7g6yPM
        xHiKlJl9vZAlHwVPKSqlxJ0D/sQckSaB+g==
X-Google-Smtp-Source: ABdhPJybMygwUGa5YtFgkp7/UZQVxsx3zeQGTV3CoslrWn54l3dUlj2ksJhKth5G4Hy/xCYFzRCMeQ==
X-Received: by 2002:aa7:ce82:: with SMTP id y2mr3380568edv.264.1623413436036;
        Fri, 11 Jun 2021 05:10:36 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4954:2e00:fd6f:fc71:2689:4a7a])
        by smtp.gmail.com with ESMTPSA id n11sm2084116ejg.43.2021.06.11.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 05:10:35 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCHv2 for-next 0/5] misc update for RTRS
Date:   Fri, 11 Jun 2021 14:10:29 +0200
Message-Id: <20210611121034.48837-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include following changes to the next merge window.
It contains:
- first 2 patches are for reducing the memory usage when create QP.
- the third one are to make testing on RXE working.
- the fourth one is just cleanup for variables.
- the last one is new to check max_qp_wr as suggested by Leon

v2->v1:
- A new patch to check device map_qp_wr when create QP.

v1: https://lore.kernel.org/linux-rdma/20210608103039.39080-1-jinpu.wang@ionos.com/T/#t

This patchset is based on rdma/for-next branch.

Note: I tried the patchset for fast memory registration on write path can still apply.
https://lore.kernel.org/linux-rdma/20210608113536.42965-1-jinpu.wang@ionos.com/T/#t

Guoqing Jiang (1):
  RDMA/rtrs: Rename some variables to avoid confusion

Jack Wang (3):
  RDMA/rtrs-srv: Set minimal max_send_wr and max_recv_wr
  RDMA/rtrs-clt: Use minimal max_send_sge when create qp
  RDMA/rtrs: Check device max_qp_wr limit when create QP

Md Haris Iqbal (1):
  RDMA/rtrs: RDMA_RXE requires more number of WR

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 50 ++++++++++++++------------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  3 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 10 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 34 ++++++++++--------
 drivers/infiniband/ulp/rtrs/rtrs.c     | 24 ++++++-------
 5 files changed, 65 insertions(+), 56 deletions(-)

-- 
2.25.1

