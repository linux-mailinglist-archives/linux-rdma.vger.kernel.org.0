Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7061B246011
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 10:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHQI27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 04:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgHQI25 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 04:28:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64EC061388;
        Mon, 17 Aug 2020 01:28:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f193so7862343pfa.12;
        Mon, 17 Aug 2020 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x8evKrk5UTptz0Yl/xoXI0xb7S5S43nzgBX3Fa/3la8=;
        b=jf6gg8dQF26Rfb7q3Nda96UqWHrp1nZawwFxbgXJ2DDwP0hk0afo/fp9yFkSIEug2d
         FFf9TdKNea4f2Qdm3DN63aEUbDD3jMENBs3Kvq1CStzsrLMRd/cdo55b4Z1qa1/SVGv/
         A/Oq7ryhH/lTEskCww2q2CAYxAUccZfHOXemShmmJYnHhZ5y02yvQeo3g5CIeehWP1Iy
         WLdcIH041dQFfPIm6hraWKlAwukPz8aBZXVyyGT0/72r92TM3pRpSXOwsU0wVwVv5WhQ
         WZJUvm6Kw7bLNR33GeW4gfGC2+9xpYbXTB93so5iB2iY3FghwpnHgZnqRu89WCRYg8Eh
         7p0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x8evKrk5UTptz0Yl/xoXI0xb7S5S43nzgBX3Fa/3la8=;
        b=e2ib1+LdZR5OCqkpNjZ8I2VTbh+snLP0EcZCp4l8C7LzCStHhRIQ81JjD7f9qZs1HW
         q13e1nE3vkEiwkhPV7TbP10V7Y42pDT4NNePmdehVQ2IKTngINIPBLNfXnX+H3QsK/lB
         gNFNHSIqR09zLUncKEGVv3Nlj7DmCSX6OhEfQWBrcx9wzYG7ll2ZK0EKxC6uej+7fJO4
         qNy6mI+4i1UAreA6I9EVTy8Qn0n/ZM0GbL/FGOlv+8zSfRpwBYly17W+fALTls0tizWp
         d1O6Mm7IDDl294AM2VBOpBNMQJi3cHy7uDPhg+HUNeu4VEaTtwbLloWVFyqhXcB2JPqj
         TSYg==
X-Gm-Message-State: AOAM533xsHE/kynYeD0OAZgFWpBjwUXYVXvsdDFztIR77e6B1dHWQo2a
        S2laVybNc8fCj5JXXP8cLmM=
X-Google-Smtp-Source: ABdhPJx+LNKI0Wabg9YgWGbV4sQU4RVhhj+dPVTE3ktCv9MmPYDafNxdNg0DJKIk619EVPNuPKI5Uw==
X-Received: by 2002:a62:c582:: with SMTP id j124mr10865376pfg.21.1597652936979;
        Mon, 17 Aug 2020 01:28:56 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id r7sm18948102pfl.186.2020.08.17.01.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:28:56 -0700 (PDT)
From:   Allen Pais <allen.lkml@gmail.com>
To:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com
Cc:     keescook@chromium.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 0/5] infiniband: convert tasklets to use new tasklet_setup()
Date:   Mon, 17 Aug 2020 13:58:39 +0530
Message-Id: <20200817082844.21700-1-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts 
all the infiniband drivers to use the new tasklet_setup() API

Allen Pais (5):
  infiniband: bnxt_re: convert tasklets to use new tasklet_setup() API
  infiniband: hfi1: convert tasklets to use new tasklet_setup() API
  infiniband: i40iw: convert tasklets to use new tasklet_setup() API
  infiniband: qib: convert tasklets to use new tasklet_setup() API
  infiniband: rxe: convert tasklets to use new tasklet_setup() API

 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  7 +++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 13 ++++++-------
 drivers/infiniband/hw/hfi1/sdma.c          | 22 +++++++++++-----------
 drivers/infiniband/hw/i40iw/i40iw_main.c   | 14 +++++++-------
 drivers/infiniband/hw/qib/qib_iba7322.c    |  7 +++----
 drivers/infiniband/hw/qib/qib_sdma.c       | 10 +++++-----
 drivers/infiniband/sw/rxe/rxe_cq.c         |  6 +++---
 drivers/infiniband/sw/rxe/rxe_task.c       |  8 ++++----
 drivers/infiniband/sw/rxe/rxe_task.h       |  2 +-
 9 files changed, 43 insertions(+), 46 deletions(-)

-- 
2.17.1

