Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792A723FD1E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHIHYr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgHIHYq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 03:24:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95869C061756;
        Sun,  9 Aug 2020 00:24:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so3238822ply.11;
        Sun, 09 Aug 2020 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rlCw9bXNz9amSiyruivuB3SKCYjIcaIfTwgEtm92qW4=;
        b=jUBeK3xAvto7PSUx2HYYsmFHvicywYI+71jRXaFkgIUUbmk9vB/d9Aa95hlzr/lV1K
         5zvwZehnn0cJx0I0FiLh100a1z3ZNfb+1Z0mcKu8agANAm5CzpLUitLJSP8GuyuaXyxN
         U4/M8Dtf62WRdfOcmcenjPcQENnXoo1LczVOe+hhE0jhGbTzMcluRRdZpF/E6Pp9frFt
         YV0Hrx+5GVLWPdIXTNF9RB9I+9uckf/jIOKPz7xANgvwpPAeOUldXMkNvz1PxiYlQQ97
         /O2YWFFdHP3gkz4dcsKe53OyzUaN1FTUj8QzBEgIHKtOLy7NWhLcc4h/d21qs6J+WBZ1
         HMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rlCw9bXNz9amSiyruivuB3SKCYjIcaIfTwgEtm92qW4=;
        b=qTUKrpmv01tYAvUs3F/I8ptG+rzTVpmIOpAQerhWLT+aoLtjsjV80EwureuWatS/7k
         7zVB22vnhUyqzUb5bAoFJHSai1rA9M77bFIppo8dRxrPHYwtTzU8XTAdasFVdocKdpaE
         B/GZMNNcVOnXfwOc/vBr8wg5UwV6KrCcSU8xtIi0whKJixa0DcLsGl87XgCxOKpJQ4wu
         aQZCGv8MfhilQojFn0jbizCH3dUdbuz68fboKwD3u18unUoSF/yO53bd0RhIs2+gS8To
         vqvfM/SbzF5JpdHvcVHrZzks6aHksN1TYgyhC9tkRZlzHNDRgvgLT92kbI4A093evuC2
         YNdA==
X-Gm-Message-State: AOAM530WJaXu4sbee6A6EfPODkSDqv3qJZhM3a3wTGXdAe0cBbv7Sc+w
        OUGK7gd3r0/eTkkV6q/V4/ofxn8OCX4=
X-Google-Smtp-Source: ABdhPJxuKuH6lag//Z3lCgAfLwYaAPCgKfW1uCamkewUti6WnhVFWc3MOF6OUpwZx60wnjApbHFjXg==
X-Received: by 2002:a17:90a:202c:: with SMTP id n41mr22176095pjc.126.1596957886122;
        Sun, 09 Aug 2020 00:24:46 -0700 (PDT)
Received: from blackclown ([103.88.82.9])
        by smtp.gmail.com with ESMTPSA id gl9sm565272pjb.41.2020.08.09.00.24.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 00:24:45 -0700 (PDT)
Date:   Sun, 9 Aug 2020 12:54:28 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 0/4] Infiniband Subsystem: Remove pci-dma-compat wrapper APIs.
Message-ID: <cover.1596957073.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hii Developers,

	This patch series will replace all the legacy pci-dma-compat wrappers
with the dma-mapping APIs directly in the INFINIBAND Subsystem.

This task is done through a coccinelle script which is described in each commit
message.

The changes are compile tested.

Thanks,

Suraj Upadhyay.

Suraj Upadhyay (4):
  IB/hfi1: Remove pci-dma-compat wrapper APIs
  IB/mthca: Remove pci-dma-compat wrapper APIs
  RDMA/qib: Remove pci-dma-compat wrapper APIs
  RDMA/pvrdma: Remove pci-dma-compat wrapper APIs

 drivers/infiniband/hw/hfi1/pcie.c             |  8 +++----
 drivers/infiniband/hw/hfi1/user_exp_rcv.c     | 13 +++++------
 drivers/infiniband/hw/mthca/mthca_eq.c        | 21 +++++++++--------
 drivers/infiniband/hw/mthca/mthca_main.c      |  8 +++----
 drivers/infiniband/hw/mthca/mthca_memfree.c   | 23 +++++++++++--------
 drivers/infiniband/hw/qib/qib_file_ops.c      | 12 +++++-----
 drivers/infiniband/hw/qib/qib_init.c          |  4 ++--
 drivers/infiniband/hw/qib/qib_pcie.c          |  8 +++----
 drivers/infiniband/hw/qib/qib_user_pages.c    | 12 +++++-----
 .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  6 ++---
 10 files changed, 59 insertions(+), 56 deletions(-)

-- 
2.17.1

