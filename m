Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F083AE2E7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 07:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFUFz6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 01:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFUFz5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 01:55:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B964C061574
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:44 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l1so26756846ejb.6
        for <linux-rdma@vger.kernel.org>; Sun, 20 Jun 2021 22:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h8KYEcCDoHvDnbdlK8Zw+53dISNcQP7q2A6ntAj0do=;
        b=FXw8lMzDKone6KFfTTsAfHVs5a+nufQrnVV3uOshJGeBxFIUKfA8BgT7hp7u/dGSWJ
         smeH1pYBD/SK5jQ9IVt1a+QPPBdMp4uXLrYYcyjnTHU7wN3aJFm6dVkwBerG86B0DyfU
         czTE8TWy482H+SRMWRGb8GeWaamp3z0U6J5J0+vWyA5RqDL6/s1hY2tasMC4FwPW0h3w
         miUO4WxImqt0Y2jHZn1k5UJQsO98mIl4xTqcrZ+oWfcAYyUGfn8DMRvnB+BOZalBNyxY
         Gx+1bvUZCbYin7CypQ7iviAWPezt9iO0oqSuXoSok7j8CZ75sTBqvqCV32JYBr2mYHlI
         camQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2h8KYEcCDoHvDnbdlK8Zw+53dISNcQP7q2A6ntAj0do=;
        b=nDtam3nJtfrSE5Kss9aei38+Za2qS947RS2EF0UyjIArvhM/gVAj8Cf/SzKhO2rGjW
         8p0GgNli8Yd5sxNTwm6OSlKaHP5G4aYr5xPKOK7cArXAAFVkmEwsSsLmsGLO5iokTfFc
         l97jyBhzx8bIac0gPamECPY0/1jimaGBAXA4OlGJOPIj2d2jwAn7h0n0eSoPygC0b77b
         B1rxojbrYfBoMNtg250E3jry5Yf1CN7s1kV2loDarsHPB8veVXflIDvd0pXfMTwB+a1X
         w5G2iEAGHmLVT1cLxpCKDnOOqu80tNXYkJxm4D8In1QWxu9X7M/LR4nUBsDmi9ePcb2O
         NRBA==
X-Gm-Message-State: AOAM530bzzO70M6GTsGZxPgc9mWOMo+aGHPuPnjUJwlvvL3Qg+i/1cG2
        iZjbF97berC0RQaL2BO7CVpTU8Qt7rfM9w==
X-Google-Smtp-Source: ABdhPJzAAqBLUNvMpdjofEdzPKC652f+2WRmkm6IwvQZK53UP1dkbvAHsD/5+R8jnfU5VLFMW+IvyA==
X-Received: by 2002:a17:906:3845:: with SMTP id w5mr23415150ejc.518.1624254822545;
        Sun, 20 Jun 2021 22:53:42 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:49f3:be00:dc22:f90e:1d6c:a47])
        by smtp.gmail.com with ESMTPSA id i18sm1919617edc.7.2021.06.20.22.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:53:42 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, axboe@kernel.dk, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCH resend for-next 0/5] RTRS enable write path fast memory regitration
Date:   Mon, 21 Jun 2021 07:53:35 +0200
Message-Id: <20210621055340.11789-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Doug, hi Jens

Please consider to include following changes to the next merge window.

This enables fast memory registration for write IO patch, so rtrs can
support bigger IO than 116k without splitting. With this in place, both
read/write request are more symmetric, and we can also reduce the memory
usage.

The patchset is orgnized as:
- patch1 preparation.
- patch2 implement fast memory registration for write patch.
- patch3 reduce memory usage.
- patch4 raise MAX_SGEMENTs
- patch5 rnbd-clt to query and use the max_sgements setting.

As the main change is in RTRS, so it's easier to go through RDMA tree, hence
send this patchset to linux-rdma.

This is a rebased on the top latest rdma/wip/jgg-for-next commit
7e78dd816e45 ("RDMA/hns: Clear extended doorbell info before using")

v1: https://lore.kernel.org/linux-rdma/20210608113536.42965-1-jinpu.wang@ionos.com/T/#t

Thanks!

Jack Wang (5):
  RDMA/rtrs: Introduce head/tail wr
  RDMA/rtrs-clt: Write path fast memory registration
  RDMA/rtrs_clt: Alloc less memory with write path fast memory
    registration
  RDMA/rtrs-clt: Raise MAX_SEGMENTS
  rnbd/rtrs-clt: Query and use max_segments from rtrs-clt.

 drivers/block/rnbd/rnbd-clt.c          |   5 +-
 drivers/block/rnbd/rnbd-clt.h          |   5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 143 ++++++++++++++++---------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |   1 +
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |   3 +-
 drivers/infiniband/ulp/rtrs/rtrs.c     |  28 ++---
 drivers/infiniband/ulp/rtrs/rtrs.h     |   2 +-
 7 files changed, 119 insertions(+), 68 deletions(-)

-- 
2.25.1

