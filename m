Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81DC31A004
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 14:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhBLNqI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 08:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhBLNqH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 08:46:07 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A71CC061574
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id z19so2466876eju.9
        for <linux-rdma@vger.kernel.org>; Fri, 12 Feb 2021 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGiSxe9L3WjQzoOuylQQ+8Z5J9c/FCWDLXA25lAE/0k=;
        b=i2lm0jJtT7CvEq7U62oxq0k7s67OFm2CcOzQn/vhur3dh7yWjWbWDJ+Bqaph/fTIYK
         Eza3siFcRPRR1ZATQ02mk0m45vizGXhnMWGb59O4Bq3Fwh9WVwq2xZydb0WfuCfvLWbm
         Yo+MZ07nni0jSDi7B59fEMh1bEOcM9LwPh+Kv1D5ntYcuvhZUjx7CsTPH1TO/6zqHVsz
         nV381914lkOsZYVWE6HysBZaP/eJU6WLQ6RcOSVqRBQuWaHWUTPy04aHXTRfkwNRvx2t
         h0SXpO8mwa9uaPdUwTR0wheF0eD/TK/FXEwcgFhchu3vIxC+jgyKmCvenJHcrYrEwr31
         xxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGiSxe9L3WjQzoOuylQQ+8Z5J9c/FCWDLXA25lAE/0k=;
        b=DWL+bjH9RGMMwvV11lVlTBHBAyHNEeMxmgmM4t5zVhUqQ1cJ+Q2mVelnFgv9HUaAUL
         LCH/HEIDl9MutWsOBwThM2Styl7hZX5pqru9CLihFXVK88QNAQ+LmnL0s4HDVN+mAUE3
         ttv+2VcoOKMD0klYaglbVoaL+iUZuT/uLHRpm73rM0dua86qtxoeGd+X4NppTByO4uAA
         Em92bDIWRnLhgG+JUwM2L4JnlwJ6fMDVaXMEIRnyRDGAUpZw3ITzBvWDos/H+zPtdGja
         YBAAuPU30FtKM6Y1X04jN0DxAVNVfP5CvXZQ5q48kZSeXTh9Kqo7ngGDz/vxDz0wbP5s
         Wp3w==
X-Gm-Message-State: AOAM532Q+l3aZctPiFVjXlXP3MaCucZDOeZVYEUM2A8nSGQDydveBEsF
        0fZ4dBwCoDeBt1kY3R1pWOTJV8LmTqKIIQ==
X-Google-Smtp-Source: ABdhPJzHtBjQr3qLCe6GA132qqs+WYQkGmJSXjHAf6qZLneeUWl2D9kLO/BIu1IkvLCUAvg/E76DMw==
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr3156697ejy.63.1613137526173;
        Fri, 12 Feb 2021 05:45:26 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49fe:3100:e80f:dbb4:eac5:c974])
        by smtp.gmail.com with ESMTPSA id o4sm5856197edw.78.2021.02.12.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:45:25 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCHv2 for-next 0/4] A few bugfix for RTRS
Date:   Fri, 12 Feb 2021 14:45:21 +0100
Message-Id: <20210212134525.103456-1-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug,

Please consider to include follwing bugfix to next release.

One bugfix for KASAN splat due to we use wrong structure type when send
RDMA_WRITE_WITH_IMM opcode from me.

One bugfix for allowing addition of random path to exsition session from Haris.

2 bugfix for memory leak from Gioh.

v2->v1:
- collect reviewed-by from Leon for patch1 and patch4.
- adjust patch2 as suggested by Leon, also add missing mutex_unlock before
  return and misc cleanup. 

Thanks!
Jack Wang

Gioh Kim (2):
  RDMA/rtrs-srv: fix memory leak by missing kobject free
  RDMA/rtrs-srv-sysfs: fix missing put_device

Jack Wang (1):
  RDMA/rtrs-srv: Fix BUG: KASAN: stack-out-of-bounds

Md Haris Iqbal (1):
  RDMA/rtrs: Only allow addition of path to an already established
    session

 drivers/infiniband/ulp/rtrs/rtrs-clt.c       |  7 ++
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |  1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  4 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 91 +++++++++++---------
 5 files changed, 66 insertions(+), 41 deletions(-)

-- 
2.25.1

