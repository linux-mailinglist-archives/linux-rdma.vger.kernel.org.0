Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4665CD6896
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2019 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfJNRii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Oct 2019 13:38:38 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:39496 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfJNRii (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Oct 2019 13:38:38 -0400
Received: by mail-wr1-f53.google.com with SMTP id r3so20708468wrj.6
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2019 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CxHTdXjYKR57qJan4BQFwhSOrDPGmGzaVkVA1OH93q0=;
        b=UzdEcdthW3h/X0guR35WVQSD1plkW+kQFWvU1z+mJmGQo1gdCjIv0MLcsrP1kFWTLw
         Qk1OQwOh5Q8RqVZlvYRleO+xElqEmcXBSHPbHSCkW4Dn+UoapBc2ZXGxP4zeAsw0aNDu
         ysVJXCYffs7h9tYSbsxyhlBX4IDtDHHhdZaumkO5Os9GJzN++Epg6CCK/zWDO3Br+Lpt
         E/omJnp/ya62OYL3R3WAcQGGUWG32Mhqx9GkcNr8zGRgBF3oMSicSFN+TFWk3HYfNLxh
         TOWWizRrDszjg9Bf4yUJKQ0yRGCND5u3UfcMWG9zxt8bTy3XQ4Zw4QOUUX6Ma85QX9fD
         H0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CxHTdXjYKR57qJan4BQFwhSOrDPGmGzaVkVA1OH93q0=;
        b=DFqgTPMTvwe89cHhf81CVyD5cOo8edoFFZa48suw7ZDuafAhMgEK8anAIMDMlFVtbX
         u3ADqW6uwLHvMKLgDpwj7X6f9I9N2bcs91S9VQ3esmud7uG0x7tIzylH3iZdUAd7mhlN
         P2znP+F6lAbOtQQLFNG0TzDasX3GLijD1pkQDdvtdSZ6hFHxb9vh7c4ANI4fUpa+dqaS
         ZDNGjdbiGN2EYx36+LnoAD7ssr7r8zVeBQfTg0tSIrNYJzx6OKp9sdVCTh3tEVVhA9dy
         du3C2PjOPfitnNPneAyDP8XikLsPs0aJnMgbafN4RmI6rgfChY6jnsLtbcChG1WZ7+53
         ZEZw==
X-Gm-Message-State: APjAAAUjopuqZos5Q8KuCdStnXNmQmKMRlOVxppmQz3M0nULZSBtnFAo
        dDYPy0NucL5LoCDq9HwTzm2ue1b0
X-Google-Smtp-Source: APXvYqxjiaNUMK3IHAkgYNsK45Gi6HRPh+ZkiF5E0SRptnr/gv+yKeuFrfDZ5ZClpo27/5urTpyp4A==
X-Received: by 2002:a05:6000:12cd:: with SMTP id l13mr15795050wrx.181.1571074715509;
        Mon, 14 Oct 2019 10:38:35 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-179-0-252.red.bezeqint.net. [79.179.0.252])
        by smtp.gmail.com with ESMTPSA id 36sm24981585wrp.30.2019.10.14.10.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:38:34 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/4] RDMA: modify_port improvements
Date:   Mon, 14 Oct 2019 20:38:13 +0300
Message-Id: <20191014173817.10596-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series includes three patches which fix the return values from
modify_port() callbacks when they aren't supported.

Kamal Heib (4):
  RDMA/core: Fix return code when modify_port isn't supported
  RDMA/hns: Remove unsupported modify_port callback
  RDMA/ocrdma: Remove unsupported modify_port callback
  RDMA/qedr: Remove unsupported modify_port callback

 drivers/infiniband/core/device.c            | 2 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 7 -------
 drivers/infiniband/hw/ocrdma/ocrdma_main.c  | 1 -
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 6 ------
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h | 2 --
 drivers/infiniband/hw/qedr/main.c           | 1 -
 drivers/infiniband/hw/qedr/verbs.c          | 6 ------
 drivers/infiniband/hw/qedr/verbs.h          | 2 --
 8 files changed, 1 insertion(+), 26 deletions(-)

-- 
2.20.1

