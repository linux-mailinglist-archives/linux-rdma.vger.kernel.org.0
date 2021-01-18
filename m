Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8322FAD60
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbhARWkQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 17:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbhARWkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 17:40:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE43C061574
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y17so17907860wrr.10
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 14:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVxbsDGS3JFaJ0icMQqNqXmkLsPwbgoGgAdrXMuR54g=;
        b=BJZMd4jgGhrymjBh0jClqc37EWs+BTv++x4YXoKI+zXAPWo2CDsptU8AntH19T6aO6
         k+iC/V/QCpopJqY5E015+SSGo/DJHDoSXdmPmtbbHLiBlyPghgk0Ygj7mR33aogVPUOI
         yCeE/hdCD3wfZDBHPTwDdxXvLyPEqmbQLrXJJa8G5VjaU8Vt/cQY2Ocze6e7LuRkx72G
         3ZGpVAJbIrz7Wb+VVzNfe90pMW3szy44wRvbWk9bZlAj6e6/RnRYl32GmuzhUpwDhvSx
         Eo04Nj+4wZj7RvxW7kWPBPNTVg2F541Wx7Vdin96nsE6nz3LGEkWGjeHo9M/PrfpX0ms
         5rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EVxbsDGS3JFaJ0icMQqNqXmkLsPwbgoGgAdrXMuR54g=;
        b=eLROWAWSIlI2EJKjLshtnN0ikDxpMXWcJxeLnFpDqCCdIpvWauaIoCYJEFs4Pb4rKJ
         4giNLkPwIfwirLKhiXAco3w5ZAiiqQCkHWL463ZaaSYntkQoE9dE/MFmuAmEjgcQeETk
         O5z+xRN+uHyT8WNLssGuL4g2ExLxabh+TcmgM9CW73pLR/C6Q3aVJTpRf0U9xIJBotEe
         eeowxWcid5wp3fa1xSdLsCg1rLNWUhdlJLAin+EZBcYHK2XE59qZkGFqFmWlBwFeZync
         Ruk0+UwkzK4fYkegawy0OZqfydho0LJcCq8nVQW228h4hUZG0oP9edSvGsRvh4z1aNP1
         JFkw==
X-Gm-Message-State: AOAM531dH1WOnu6ewlVfZDdziLASdq2LjOOVu3JXIgE7k9XQhoBy3TK9
        CW20HFEUqQy94C9hL30kK1SzJQ==
X-Google-Smtp-Source: ABdhPJwELBT80oBdZqfeNka6TZE+mx3kdpah45WiZQjwFSbWKc26sucdfpr3IhnN2x9XQhIN1+SXpA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr1440401wrw.73.1611009572864;
        Mon, 18 Jan 2021 14:39:32 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id l1sm33255902wrq.64.2021.01.18.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 14:39:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Intel Corporation <e1000-rdma@lists.sourceforge.net>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH 00/20] Rid W=1 warnings from Infinibad
Date:   Mon, 18 Jan 2021 22:39:09 +0000
Message-Id: <20210118223929.512175-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is set 1 of either 2 or 3 sets required to fully clean-up.

Lee Jones (20):
  RDMA/hw: i40iw_hmc: Fix misspellings of '*idx' args
  RDMA/core: device: Fix formatting in worthy kernel-doc header and
    demote another
  RDMA/hw/i40iw/i40iw_ctrl: Fix a bunch of misspellings and formatting
    issues
  RDMA/hw/i40iw/i40iw_cm: Fix a bunch of function documentation issues
  RDMA/core/cache: Fix some misspellings, missing and superfluous param
    descriptions
  RDMA/hw/i40iw/i40iw_hw: Provide description for 'ipv4', remove
    'user_pri' and fix 'iwcq'
  RDMA/hw/i40iw/i40iw_main: Rectify some kernel-doc misdemeanours
  RDMA/core/roce_gid_mgmt: Fix misnaming of 'rdma_roce_rescan_device()'s
    param 'ib_dev'
  RDMA/hw/i40iw/i40iw_pble: Provide description for 'dev' and fix
    formatting issues
  RDMA/hw/i40iw/i40iw_puda: Fix some misspellings and provide missing
    descriptions
  RDMA/core/multicast: Provide description for
    'ib_init_ah_from_mcmember()'s 'rec' param
  RDMA/core/sa_query: Demote non-conformant kernel-doc header
  RDMA/hw/i40iw/i40iw_uk: Clean-up some function documentation headers
  RDMA/hw/i40iw/i40iw_virtchnl: Fix a bunch of kernel-doc issues
  RDMA/hw/i40iw/i40iw_utils: Fix some misspellings and missing param
    descriptions
  RDMA/core/restrack: Fix kernel-doc formatting issue
  RDMA/hw/i40iw/i40iw_verbs: Fix worthy function headers and demote some
    others
  RDMA/core/counters: Demote non-conformant kernel-doc headers
  RDMA/core/iwpm_util: Fix some param description misspellings
  RDMA/core/iwpm_msg: Add proper descriptions for 'skb' param

 drivers/infiniband/core/cache.c              |  9 ++++----
 drivers/infiniband/core/counters.c           | 16 +++++++-------
 drivers/infiniband/core/device.c             |  8 +++----
 drivers/infiniband/core/iwpm_msg.c           | 16 +++++++-------
 drivers/infiniband/core/iwpm_util.c          |  6 +++---
 drivers/infiniband/core/multicast.c          |  1 +
 drivers/infiniband/core/restrack.c           |  4 ++--
 drivers/infiniband/core/roce_gid_mgmt.c      |  2 +-
 drivers/infiniband/core/sa_query.c           |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c       | 21 ++++++++++++-------
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c     | 18 ++++++++--------
 drivers/infiniband/hw/i40iw/i40iw_hmc.c      |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_hw.c       |  4 ++--
 drivers/infiniband/hw/i40iw/i40iw_main.c     | 13 +++++++-----
 drivers/infiniband/hw/i40iw/i40iw_pble.c     |  5 +++--
 drivers/infiniband/hw/i40iw/i40iw_puda.c     | 13 +++++++-----
 drivers/infiniband/hw/i40iw/i40iw_uk.c       |  5 +++--
 drivers/infiniband/hw/i40iw/i40iw_utils.c    | 22 +++++++++++---------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 19 +++++++++--------
 drivers/infiniband/hw/i40iw/i40iw_virtchnl.c | 19 ++++++++++-------
 20 files changed, 113 insertions(+), 94 deletions(-)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Intel Corporation <e1000-rdma@lists.sourceforge.net>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: Taehee Yoo <ap420073@gmail.com>
-- 
2.25.1

