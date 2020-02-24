Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93C216A44B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXKuH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:50:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33447 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXKuH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 05:50:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so9831206wrt.0
        for <linux-rdma@vger.kernel.org>; Mon, 24 Feb 2020 02:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JucBKVLKFNic6Wu45NykR/Zo+NYveIebWyMIKevmjJE=;
        b=NBJmIaBqxuk1UQtwKVtsqG4Zx0xyzIVIAELEJ9iOC2xFtapx+BlaMwHLnUm1624JyK
         y4DbnvTE9XKBCduEOcK6chzFivG2DfMSymmqETmnEvC30/9eixibH3mfIOmnEeaLhtEK
         wb8N1nDcMdAUlhWSZnBx5h6P+uIVPt3MnMDMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JucBKVLKFNic6Wu45NykR/Zo+NYveIebWyMIKevmjJE=;
        b=QgICy4E8j79alwvKwkp/93nfxz4MEQx5OOzi64CaExIZhMHWpyKIpuU1yRFHHSNL7/
         LcsqrhJ2eHRpo+mOBz7QLp0RXj7ycbeLuzQFXCvp9kxs17dzcig4r+9Y4PZEpbBnTbIl
         CjyMN6HZEWG8EE1Vv2w1TEXHcveE+SjLnoF9y4td3W9ZB5ODOXy6kdoDOBYo6CwTmY4Q
         WiSpz8yQBqriWKS+0KkP0NUre41w7vlCl/teZngndC8XbEQfdoafaXC4olr+oU8tZSXX
         gccu2T/QckNapEjzloLBBKtlTYuEgWafZ1jDPQjEYvUK3BNn+d7P7c9U1XHw4qhLkJTc
         Qa0g==
X-Gm-Message-State: APjAAAUq75CSbLB7oDnzxWLOXy+xL1RhbzbphJ+lpN5HkDlj0ZqGj5RG
        +t8/yeXaiut8ghNeBjs7lp34vEhcwAc=
X-Google-Smtp-Source: APXvYqwwQl3rMw8yKRXIKYzmG9lQVaztTRcct93IdwrcbQ0D+AeXqY0nakvGbfLEtgJdZnYlnKF41A==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr63815043wrq.176.1582541404743;
        Mon, 24 Feb 2020 02:50:04 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c9sm18096426wrq.44.2020.02.24.02.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 02:50:04 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/3] RDMA/bnxt_re driver update
Date:   Mon, 24 Feb 2020 02:49:52 -0800
Message-Id: <1582541395-19409-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Includes code refactoring in the device init/deinit path and
use the new driver unregistration APIs.

Please apply to for-next.

v1-> v2:
 - Remove the patches 1,2 and 6 from the v1 series.
   They are already merged.
 - Added ASSERT_RTNL instead of comment in Patch 2
 - For Patch 3, explicitly queue the removal of the VF devices
   before calling ib_unregister_driver. This can avoid command
   timeouts seen, if the PFs gets removed before the VFs.
   Previous discussion - https://patchwork.kernel.org/patch/11260013/

Selvin Xavier (3):
  RDMA/bnxt_re: Add more flags in device init and uninit path
  RDMA/bnxt_re: Refactor device add/remove functionalities
  RDMA/bnxt_re: Use driver_unregister and unregistration API

 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  16 +-
 drivers/infiniband/hw/bnxt_re/main.c    | 249 ++++++++++++++++----------------
 2 files changed, 137 insertions(+), 128 deletions(-)

-- 
2.5.5

