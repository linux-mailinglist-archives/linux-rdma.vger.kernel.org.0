Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6C647E1A0
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Dec 2021 11:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243241AbhLWKmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Dec 2021 05:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbhLWKmc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Dec 2021 05:42:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C7EC061401
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:32 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w16so19634832edc.11
        for <linux-rdma@vger.kernel.org>; Thu, 23 Dec 2021 02:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAYaGVyPEuqw2dAq1xGlRKEPdbAFxK6eBMoAKmngwoU=;
        b=K1UaGEYB3XZotp+GATisUkAaxtkOCTY4Pubm7g/VCby0mk8TO3P+9H5vavHHAWnqvU
         Ap3A9TomWYcxDaD5mo9ZZDCXGxcVT/MFzg+bZRbAEwJpJbeFcTffMDUeQdSGASz6eKV+
         krByTY96y6c2uqVHTdCefjqjvJiS7smVk2iNJE715FT5t0momDfWpDH2p+KQkNxac/yH
         Uhby98/1rJnVOfbCvrmrPgIx//fI3GNyP4+2jWT7bBJe+WqG5ouwX+xVOVAK1XgDlc2B
         T+nvsYPtnJY7+1bf9XBihljvJSXEZ63ZJEcqG6O547e0I6kSiiwLwwlEeuw2yqqxa6Wk
         yz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAYaGVyPEuqw2dAq1xGlRKEPdbAFxK6eBMoAKmngwoU=;
        b=dzsCYU6boXecvfauWNEfcwEwYE3e2uuyFpLLElljBCAjH+cvyPxyZxiFtGI/CT9iId
         dqdNFcfYl1vmuopd47E4VW8k0Pcm5Qw63lJyjrT/zvmpkAQ2vWJjZ06keujaJwA8H39T
         5PozsDjkJxuc0/GIflxnCcGdt0ZQ3HWX3NB8Iu6ynw6R4aHkwWGTkjbh5+UZLwfHe0k3
         QOyJdtcPzXLJNdFyS0XWtWhM2QzuvpiSQ1JY8XpvDgmnhUU6nBVHFpk5aqtBaH743Xeo
         fY/F5d38VMKCSA2phPchcriZjcqJRGFp17nXueoX/1XkSyxnChW7zL1j2g2lLxLuDN7+
         bMrQ==
X-Gm-Message-State: AOAM531auguHu3xoZuby3uyYPkScULZsTS4MqERqqTBZZTRGwIxxtgAW
        GpqGJ7hjLSuSxDQRUUkrGgxPDOD/8wqP4A==
X-Google-Smtp-Source: ABdhPJxd32BMUyGX+8WIl/jjL61xqvS+vIdO9vI0iA/T9Y3okuWOPxNEF/7JvNDF7CqAMyGdVgn1tw==
X-Received: by 2002:a17:906:6a03:: with SMTP id qw3mr1522069ejc.128.1640256150539;
        Thu, 23 Dec 2021 02:42:30 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4536:ce00:c42a:2c1b:a58b:ae52])
        by smtp.gmail.com with ESMTPSA id ho14sm1627224ejc.73.2021.12.23.02.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 02:42:30 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: [PATCH for-next 0/7] RTRS renaming
Date:   Thu, 23 Dec 2021 11:42:22 +0100
Message-Id: <20211223104229.23053-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

This patchset from Vaishali, renames a few internal structures to make
the code easier to understand.

rtrs_sess is in fact a path. rtrs_clt/_srv is in fact a session.
This is a mess and makes it difficult to get into the code.

The patchset is based on rdma/for-next:
c8f476da84ad ("Merge branch 'mlx5-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux")

Happy holidays!

Thanks!


Vaishali Thakkar (7):
  RDMA/rtrs: Rename rtrs_sess to rtrs_path
  RDMA/rtrs-srv: Rename rtrs_sess to rtrs_path
  RDMA/rtrs-clt: Rename rtrs_sess to rtrs_path
  RDMA/rtrs-srv: Rename rtrs_srv_sess to rtrs_srv_path
  RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path
  RDMA/rtrs-srv: Rename rtrs_srv to rtrs_srv_sess
  RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess

 drivers/block/rnbd/rnbd-clt.c                |    4 +-
 drivers/block/rnbd/rnbd-clt.h                |    2 +-
 drivers/block/rnbd/rnbd-srv.c                |    8 +-
 drivers/block/rnbd/rnbd-srv.h                |    2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-stats.c |    8 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  145 +--
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 1083 +++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       |   41 +-
 drivers/infiniband/ulp/rtrs/rtrs-pri.h       |   14 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  121 +-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c       |  664 +++++------
 drivers/infiniband/ulp/rtrs/rtrs-srv.h       |   16 +-
 drivers/infiniband/ulp/rtrs/rtrs.c           |   98 +-
 drivers/infiniband/ulp/rtrs/rtrs.h           |   34 +-
 14 files changed, 1138 insertions(+), 1102 deletions(-)

-- 
2.25.1

