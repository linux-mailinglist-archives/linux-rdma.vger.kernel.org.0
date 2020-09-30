Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15B127F53F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 00:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgI3WkN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 18:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbgI3WkN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 18:40:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A953C061755;
        Wed, 30 Sep 2020 15:40:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y17so4131795lfa.8;
        Wed, 30 Sep 2020 15:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fhe1z9jtwJP0VpHDTUygA4zqKTE6joOsqm3YtyILkpA=;
        b=hakMyYZMu0di6yGMZyDRgNav9ssN5aczE/zS2vkg+jDQ/mLSEiWSn8UsWSzkEcE6fN
         eFHBb/VhpBaPFEcr6ei83OPTG/sxsI6ALVYtKCSebWuAwX38f/Z732d29XDwGwvXbGEH
         unKbil+Ttr/BsRXA7COs+xvNm9+D6jbh5MUuOl3kWYWfO3wA4B330eCWNyDPVoDarrTi
         tcBf/t+1pDLGYR5vtSK1u0qsUSuc+Ju153ijAzCXof/0DvpV2KjGjoJirxnDi+ALH5+P
         B9CM4Zwijp+JPNB4m9ZOaiujnrsUC8jT9LzLQNGFESQhgwSuv+0gGvfSuLJTiKH2pihb
         7WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fhe1z9jtwJP0VpHDTUygA4zqKTE6joOsqm3YtyILkpA=;
        b=TuLby4m0cvkHn1p7qxZdKSL0AK3qFFrN9bTZO4ABNnqvrB+lsn7M2PzJ7ck054v90o
         +6UA/YdZPwJJ/FqPeaQrAxWRrA7iPMIjeKJReIcqY6OUGKumvq1Wwwve/WbwNz/0Vnbz
         DKqxSZ8n+CHfRWW9Twxg2KskVhh1hSjgolbAf6hXVxF+8xcf3KejH/6lHtAiO8M+OLsZ
         RbU2qySaL6CkSAEyU1rS9bIL5ASBuih9IBmnk9OBlhhfu1L7SkqwPr58tIBLG9nTon0G
         /2TZrcB/JmLBZy7GDvcpkVfILioRUTRdfop/JfUxv0qfAp8YKL4aSUQ8Acn47lt/8pg2
         dOWQ==
X-Gm-Message-State: AOAM533fzlVgcGbBH+TirSEdr4mdlXkLmwuSohWG42MVFzZTq3Yf8BvD
        J4BTUu52+k1kR3T6pwR0n50=
X-Google-Smtp-Source: ABdhPJwexhyLpNfeNSaxynwqCF4RGK0ul3NCeYu5UXmNr+HzgPShXRkB9fg8JIxwDBTMLiBxlIfcsg==
X-Received: by 2002:a05:6512:2101:: with SMTP id q1mr1732072lfr.157.1601505611142;
        Wed, 30 Sep 2020 15:40:11 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-229-94.NA.cust.bahnhof.se. [98.128.229.94])
        by smtp.gmail.com with ESMTPSA id p10sm330893lfh.294.2020.09.30.15.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:40:10 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>, Qiushi Wu <wu000273@umn.edu>
Subject: [PATCH rdma-next 0/2] RDMA: Constify static struct attribute_group
Date:   Thu,  1 Oct 2020 00:40:02 +0200
Message-Id: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Constify a couple of static struct attribute_group that are never
modified to allow the compiler to put them in read-only memory.

Rikard Falkeborn (2):
  RDMA/core: Constify struct attribute_group
  RDMA/rtrs: Constify static struct attribute_group

 drivers/infiniband/core/sysfs.c              | 12 ++++++------
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c |  6 +++---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.28.0

