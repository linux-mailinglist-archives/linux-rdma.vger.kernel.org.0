Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9F11CA7F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 11:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfLLKWf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 05:22:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40866 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfLLKWf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Dec 2019 05:22:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id q8so516487pfh.7
        for <linux-rdma@vger.kernel.org>; Thu, 12 Dec 2019 02:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=srUmZ5nGc5H5JGVcKn10g3zhePJA5mjqmWAVqzIaByI=;
        b=M1pgLCkAppTSaGF6/sy4YYWAJsp539FsqZiwpY3oPZDFeiu8Esht87v16gxZ867OpT
         bPuLceGbTJCnKOozQyUOl4Kp+qcO2vgbcbmMOMvs2b3kAno5TAl0Cu9S/QpG/kfnoEYB
         dUbDcFxAdJdttnCoFBHwgb0zZw9/qJZKiziiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=srUmZ5nGc5H5JGVcKn10g3zhePJA5mjqmWAVqzIaByI=;
        b=hpvVV/Btw5ojXY8AlYXs7a9//t20JUeH4HtTbFTFzwyU3PRWoUr8cFlyJ40FP/xQbe
         xGjl343/bF5q/MVsbWvZf5cNCgEs1YzdJ2jlxPxGKHW+mx7ujOCwPkEMwF9cK/xfF+XH
         hyhLiYcdeiKLGvU12wY+R8NtMj1NL3nEaT6m1HWYFXnpju4oXmF59S56ZwrpBw5N2567
         9y83pP9cXGB9Z+nXOIYDrOfST6J/y8iq+mpUFSZocJFlHqYphbJhjgR/ufgCYpvQWbpj
         +g0crcaoDgarp6y+e1xS+tCl+GttG7LSXCvZND/fGAKHo5zTb/JD+Curw/yMiBAr1iNG
         4Bdw==
X-Gm-Message-State: APjAAAWMTnTdjIRgED8kmeDMJp0pLew8ajdUNMKaHhzvmJ2ERaGz2m08
        S0Is2SSrBBgbrdc26FLhcVkQqQ==
X-Google-Smtp-Source: APXvYqx1+ulWh3mdboFnVzx/bNazK6kweEu9Bzrj8wUlZhpMNpj0mQ/re0M3p4bwcxZb1X+yX6+NbQ==
X-Received: by 2002:a62:8602:: with SMTP id x2mr9005385pfd.39.1576146154733;
        Thu, 12 Dec 2019 02:22:34 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id m12sm6119290pgr.87.2019.12.12.02.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 02:22:34 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/2] Retrieve HW GID context from ib_gid_attr
Date:   Thu, 12 Dec 2019 02:22:21 -0800
Message-Id: <1576146143-28264-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Provide an option for vendor drivers to get the HW GID context
from the ib_gid_attr during modify_qp and create_ah. Required
for drivers/HW that maintains HW gid index different than the
host sgid_index.

Please review.

Thanks,
Selvin Xavier

Selvin Xavier (2):
  IB/core: Add option to retrieve driver gid context from ib_gid_attr
  RDMA/bnxt_re: Retrieve the driver gid context from gid_attr

 drivers/infiniband/core/cache.c          | 79 ++++++++++++++++++--------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 +++++------
 include/rdma/ib_verbs.h                  |  5 ++
 3 files changed, 65 insertions(+), 47 deletions(-)

-- 
2.5.5

