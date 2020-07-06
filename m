Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85040215464
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgGFJLb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 05:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJLb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 05:11:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B495EC061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 02:11:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so31908998wrs.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wWBR+djpnHCOMqNDzsjcHt0/iSNyPaiuYFBpGMaUEc=;
        b=T9KDgU7BmaLHKklVtAr/3lpJiELPEP1gVhgo+Y3k+kn6kDCrJB4lqG4YebS6lK808X
         8csnUd4WcfL4aUQEuxFIgnuB/SOn88xTQ53yuMQeOJLrBBY/jpZnx/+FN7AOLWzpxP2r
         MsHcQG4pF9yMZ6TqSpqozI/pxK1H+ZkKwiNpfPKM7MBf7VUI+1EbaLxmQIyJ16OzRO7Q
         IJ8VGZatGN7kdiwYWzrFKULqU+K2BAR0D6ZlT57p4Or7Osnf57t/rEmahhbOGskDPGjj
         kn37A9QOBTIw4w5GDUtXoUpj8+vgpKaP7QPuvL6m/WkeQE3cI2IKr4fSnJSDFXacAk5+
         uaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/wWBR+djpnHCOMqNDzsjcHt0/iSNyPaiuYFBpGMaUEc=;
        b=PzTuYpKBGRNmJ0ga54JUrzo6Y4cokCFK8PUDU9l/JRrNlD7uF5JjGlEXQ9uIAVKrXv
         Tojzoo6s8zF4yH2IYeFv99Ylll/er1wS4uirvztGzIwECrh+c9KLKOl6vb3CmTDQX/Q4
         FExI1C7ynfIP8RIH3ZGzcAGKIBoociMb4zPz5pZQkMuDzz2bS9nwlzrkO4/9KzQK08VB
         aEBeSz7YNRFAGJXx9tso8QTWlAxPxj1Ei/g0eg54YUz+M2vi0NA+lnFhzJavzysYnQq7
         1hP68KOQpPrEBI317se3O49GvuSHowoG2ydQiHfuCzEgxp+vV/yb10jN5/uhLpOWkuY9
         6g+A==
X-Gm-Message-State: AOAM5304qwWeNOrjCmSZSeN/LFapNLY+fGp1/yz3d17Pf6K9msd2WWkJ
        YUBLxCCLqOKObDuNxgIVlGAEZ4e5UdQ=
X-Google-Smtp-Source: ABdhPJycglE/x9YPTflBICoVkmNrKt/jz9oV56Afqf4qfFP5uiWBTQTpMEUvOY1drD9qUJM6UEhALQ==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr12386666wrq.216.1594026689301;
        Mon, 06 Jul 2020 02:11:29 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id j4sm18826867wrp.51.2020.07.06.02.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:11:28 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc v1 0/4] RDMA/providers: Set max_pkey attribute
Date:   Mon,  6 Jul 2020 12:11:15 +0300
Message-Id: <20200706091119.367697-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set makes sure to set the max_pkeys attribute to the providers
that aren't setting it or not setting it correctly.

v1: Drop the efa patch and target for-rc.

Kamal Heib (4):
  RDMA/siw: Set max_pkeys attribute
  RDMA/cxgb4: Set max_pkeys attribute
  RDMA/i40iw: Set max_pkeys attribute
  RDMA/usnic: Fix reported max_pkeys attribute

 drivers/infiniband/hw/cxgb4/provider.c       | 1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c        | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.25.4

