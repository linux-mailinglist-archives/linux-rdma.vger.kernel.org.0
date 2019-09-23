Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2680ABB259
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 12:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfIWKmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 06:42:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39343 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbfIWKmN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 06:42:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so13352307wrj.6
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2019 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwAJr2s9U1khq9jdNyA1nObdLv0G2niR6zNHccVJPOs=;
        b=N/xXttdCUD0d11EUbJPr2k88hcdOUPZGw7xNXfqBbhL7qJASs2o0KQ9khBI+qkXKVl
         Ic6EzhjRdMXUSM+w6lPCNn9infd8+fjSxwOjSY623WUGHc6cDdb2Kmk/W5i3Sk93xfjt
         nV6Mt7P1Qnxk3XRjvSrX6Zk39NhBoIpixMs3yjHF/5vcC3HGdVeR5uABjkyh544JqTWr
         fypo3T9bidMhpn6GJS0VK3akkpz7wukfz6OlO2OdQl0pa1hMCJ6OvNaQRJ3xPd4cTYtO
         BPbwT/Qg46BzjSg0sg9XnDrThnBIS/r1HKeuBV+ZiF8yx8DmWpgKljlTXUEy+UdmeKHw
         h1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KwAJr2s9U1khq9jdNyA1nObdLv0G2niR6zNHccVJPOs=;
        b=YchDCy09ENiIemP+o6kyJ5nMgj2cmmgTLXgKjZZIW187qFU4ETWFM3sAu1bgNyoViq
         h4O5nVJKELLp5ry8TYryl714rTpK0ToxKw97FkBE4AhzpFzgEyownG1f3aug2f3nSTjQ
         EOC9XqcjyTahUr8jk74uNm9xlSZgnvJxZvMPQnHIbsC9t6jyarNyl97sDGGTmJyijpQL
         MB3lCMun1BVc1elRnhK8xOTEJcTi/dthrfbHvljn/v9D4Pfi3qBTh2meR/VBcgEZr+F1
         7IbYfVxb/2Fod/m/4C2sG33mFYk4DE/MDWdTluttvxGxyPu+OMXCWCChGzHLfxX1NXHV
         pyfQ==
X-Gm-Message-State: APjAAAW7IWY7Ro+QRiQB5tLFwVcDrS2ls+bpbOvhaQAcH7u5ehxzCPLJ
        PFiAntlYxzXwzUQ3W6s2xSOhc+GF
X-Google-Smtp-Source: APXvYqyjE0hTaQYgTdEnZPSNMMpSsPXQ7iebXwC9xyb2+0K+0lOYKosiQW0nwdRGJiuleCjbXUpMZA==
X-Received: by 2002:a5d:5048:: with SMTP id h8mr20553266wrt.280.1569235330853;
        Mon, 23 Sep 2019 03:42:10 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-41-92.red.bezeqint.net. [79.181.41.92])
        by smtp.gmail.com with ESMTPSA id u22sm18508427wru.72.2019.09.23.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:42:10 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Moni Shoua <monis@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/3] RDMA: modify_device improvements
Date:   Mon, 23 Sep 2019 13:41:55 +0300
Message-Id: <20190923104158.5331-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes three patches which fix the return values from
modify_device() callbacks when they aren't supported.

Kamal Heib (3):
  RDMA/core: Fix return code when modify_device isn't supported
  RDMA/bnxt_re: Remove unsupported modify_device callback
  RDMA/rxe: Verify modify_device mask

 drivers/infiniband/core/device.c         |  2 +-
 drivers/infiniband/core/sysfs.c          |  2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 18 ------------------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  3 ---
 drivers/infiniband/hw/bnxt_re/main.c     |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c    |  4 ++++
 6 files changed, 6 insertions(+), 24 deletions(-)

-- 
2.20.1

