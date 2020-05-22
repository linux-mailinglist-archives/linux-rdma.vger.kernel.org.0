Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD641DF148
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2020 23:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgEVVdu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 17:33:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35350 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVdt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 17:33:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id t11so5606324pgg.2
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 14:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=34AChH+eKwTw5PllRbql9gtvgE0mGL0n5Xargw7Ku+c=;
        b=SZ8j01Qo3z4RIxYdM3MpZk+up382p7+NeFLZsaMlcNH/935Adm95BU/hSCn1UNUQQn
         HkpnGp2hr7QBsc5Sjt+3vPkcyiQTZXp6q0vUb7m5CWYToNSPB/Hqvv5nEX/mCQDXLMSN
         nkuqrVeOsfelptsTQQirGZbnDezXVlb9xDO4XnYhRN3D0GXPYERMNIBphTVYgv1p/oM3
         JENw08vIjXn1fT0BR3It5HgyMOVFdqtyNrkFiP3/axbgfL0Xz5AUZKswFOQz56eEjXvs
         okocQA0+j6uFHxGmGqrpNtXBBd/XYOCZSGRgvIwMg0eXZPQIXm8Vj5vN14U3OjpwqW6Q
         CUTA==
X-Gm-Message-State: AOAM532O6M5+xxSSZPSpn1j8IAgRp0XpR5FFkmI/7qy1b14O/t7HBVXI
        0Jlg1gx9K1wH+k83VTLwaE0=
X-Google-Smtp-Source: ABdhPJxdanv2GEPtjNSuZvCzDsN2d1G+ZrDYyhah2spwFXPQZHBExphpVUunYFu0AQG51yShVjQ0uQ==
X-Received: by 2002:aa7:85c1:: with SMTP id z1mr5510450pfn.184.1590183227979;
        Fri, 22 May 2020 14:33:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:b874:274b:7df6:e61b])
        by smtp.gmail.com with ESMTPSA id mn19sm7480755pjb.8.2020.05.22.14.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:33:47 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] SRP initiator and target patches for kernel v5.8
Date:   Fri, 22 May 2020 14:33:37 -0700
Message-Id: <20200522213341.16341-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

Please consider these four patches for kernel v5.8.

Thanks,

Bart.

Bart Van Assche (4):
  RDMA/srp: Make the channel count configurable per target
  RDMA/srpt: Make debug output more detailed
  RDMA/srpt: Reduce max_recv_sge to 1
  RDMA/srpt: Increase max_send_sge

 drivers/infiniband/ulp/srp/ib_srp.c   | 21 ++++++++++---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 44 +++++++++++++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  5 ---
 3 files changed, 47 insertions(+), 23 deletions(-)

