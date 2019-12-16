Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0909111FE6B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2019 07:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfLPGUR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Dec 2019 01:20:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfLPGUQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Dec 2019 01:20:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so5754700wrr.1
        for <linux-rdma@vger.kernel.org>; Sun, 15 Dec 2019 22:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d1iDJ5zfNlwdLYrAkotFmYvg7zKeWDrXSicwQP2oJco=;
        b=Zh/bZEFA7gj9ANnvWag9cqSIXNpoMlwq1ZzAnICXwicV1PUM4kZQoP0B7ViIJJPfbu
         BBDHptxfR3XPbR+x/AaaqDMx4jfQACPBz6FXFg53K/+teGnZjpm1UypVjQA7RfXCx+zJ
         O5fR0i8jextdZp82pxwI6wAISOMshPYu1EVpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d1iDJ5zfNlwdLYrAkotFmYvg7zKeWDrXSicwQP2oJco=;
        b=YD0j34pLlmxX41AITFr82BNKISwBlD4AEGW0weiDVwTbmKueh8nv/vPSS2OwyzPPEd
         95XjNqDLOQUSPpVXh0r6WPzr1crfxKp0Xx4v/kYDoGY1h9orUbvZtl5QxGf490Ik5pSd
         RdVzv9+Nz4cSWD6pIMM80ax7pq6Cgze1nvPs6ZdNogLiMxl3h4AUP3AMGMWCOWW8rLfF
         JChbLV1rsdlL0buN60pgnWKcBiMSn3I7ylhYWl8ZwSuAUxQWHThrUPvenxD6HdPJPPlC
         lMWN6qTcayUMGYetxVQ8IjtBkekYLTz9XVQf9ESaZCASUhxe5yzyaLJQm1ra6vUZCbJe
         edkQ==
X-Gm-Message-State: APjAAAWRIAYOWUCUsGkDMcVTp0FgfFHxyzQ60szg2DUBxObu0xh5UT7D
        ohwuja3uZ6tuAZnjmyjYj/fbug==
X-Google-Smtp-Source: APXvYqxhmfcD8lCN7YfAfYDmUW/ZNqDBnQsqgFtjV1v9aUqlsUqQEcIk+E8k9B6z33CmfL4WxM8Wwg==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr27236211wrt.4.1576477214519;
        Sun, 15 Dec 2019 22:20:14 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 60sm20663639wrn.86.2019.12.15.22.20.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 22:20:13 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/2] Retrieve HW GID context from ib_gid_attr
Date:   Sun, 15 Dec 2019 22:19:59 -0800
Message-Id: <1576477201-2842-1-git-send-email-selvin.xavier@broadcom.com>
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

v1 -> v2:
 Addressed review comments from Parav

Selvin Xavier (2):
  IB/core: Add option to retrieve driver gid context from ib_gid_attr
  RDMA/bnxt_re: Retrieve the driver gid context from gid_attr

 drivers/infiniband/core/cache.c          | 79 ++++++++++++++++++--------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 28 +++++------
 include/rdma/ib_verbs.h                  |  5 ++
 3 files changed, 65 insertions(+), 47 deletions(-)

-- 
2.5.5

