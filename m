Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B45108A25
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfKYIjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:39:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39656 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIjz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:39:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so13694033wrt.6
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zobNx66wwQBlZu+6UIRAS1eOYU8StglXXUv9aS64wd0=;
        b=R2r+6+ObS5Q+W6rEaskbuiLaAA90ShfxocLBeDaR+TzQ7SXG77nIfBqNIDYNZewPtW
         JEc3y4U43VhGckNIgEV8jIosWwno+DKb+B9lAo2PEdqhKilUoFj5xibaDJ/VMZY+zJbO
         abE2zwZuSP2g28baE3nYTPFaEIsnHVcB+Mvo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zobNx66wwQBlZu+6UIRAS1eOYU8StglXXUv9aS64wd0=;
        b=BcEx2H3v3fYLpZL2ek+KqzZ2ST7BD14xeVNtXzoRr8ZjFsd68EfwYXomQJs9j0Ij2+
         p228TT6K1V89tTPQ4aoAJkq0A2BaO9IYRTHBpcpe6ZfGOvmiFL+MuDW+MOFE9aYSCxYR
         sDZjtUHC8IB7lWn/FYDXc5n7cxjTmYkiwh/gKbqdHFO/aVs4lpg+Jr87K6PyDS3222i6
         p2V3gQAAtJOpTnnBdElMx5mHTtZjemFxgQjRwKEU2ZuO40lnYRkC+wg2AMT9O7I5Atgf
         J+uYdp2viygk409I4IlGMtqKcFsi9DD95G5Hoj5yARzCrRvCQ0QxHAyCkw7EUuD9mSBH
         dyrg==
X-Gm-Message-State: APjAAAVVZYrAME4Gn96rjzYBZY4gL0dvIwjdNc4dg4bw6etKwJw9siDN
        i+MfEV2llSrOrzlb8mD1n1BzlA==
X-Google-Smtp-Source: APXvYqyXqNsQ8WmK+Qk5FLOsByavvdDqbPrz5dpxV0kfNR4Dm0M8EPeWz/xOxqOmfo12mMRZhbOQUA==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr29052464wrv.376.1574671193586;
        Mon, 25 Nov 2019 00:39:53 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:39:52 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/6] RDMA/bnxt_re driver update
Date:   Mon, 25 Nov 2019 00:39:28 -0800
Message-Id: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes couple of bug fixes and
code refactoring in the device init/deinit path.
Also, modifies the code to use the new driver unregistration APIs.

Please apply to for-next.

Thanks,
Selvin Xavier

Selvin Xavier (6):
  RDMA/bnxt_re: Avoid freeing MR resources if dereg fails
  RDMA/bnxt_re: Fix Send Work Entry state check while polling
    completions
  RDMA/bnxt_re: Add more flags in device init and uninit path
  RDMA/bnxt_re: Refactor device add/remove functionalities
  RDMA/bnxt_re: Use driver_unregister and unregistration API
  RDMA/bnxt_re: Report more number of completion vectors

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  16 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |   4 +-
 drivers/infiniband/hw/bnxt_re/main.c       | 246 +++++++++++++++--------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |   7 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |   1 +
 6 files changed, 154 insertions(+), 132 deletions(-)

-- 
2.5.5

