Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB321538B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgGFHy3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGFHy2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:54:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C78FC061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 00:54:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so40839572wml.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg41grjtK0dPZ9HRHUDK8C62m0B8F+F5j8uuEVuuMCI=;
        b=PmksDmv4KZEbmkgdTOKUR6uOSTVc6e/Ywa0pF9G/QdyWFmsbRzayMaTNdqf5HP8gya
         6bYK8FY2yNtiGKoKfxZZNOODnIf7KSx4KqC8527brevzsm6ppj0SLi7t27d2nq4y1O0s
         nhDhP8JSiukWAfNqLpB0WAzmjz5uFL3MXplODYqwD78yiWPqVrP7FJhOK6Y4PMZ8iKGz
         Q9ehA/vUv9+zFIoP3IW5XsuSozxvUv4Ghu8l4ZxUBhrKZ5j73ZgWe4691z9B5m77HZr2
         H/05z++Z4HwfYZWQMCidy03eXVzq2PxRQT7nGdNIrPlE3AbEI2vF4lR+E6+8OXrJZbQz
         64kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lg41grjtK0dPZ9HRHUDK8C62m0B8F+F5j8uuEVuuMCI=;
        b=nF56uxpFjzhwrLu1WxT3w3z9D/vn5tgB6Tv5INpYAquL9+MzMWyUH13zL32idBZcVY
         4+XUj1PXkAz/vtXFV+EPZkr6Bp3vGB/7esECRfd6IXXTRoj5Q38jgAsVrV8lCaUa1y6D
         eFE+SNBV4OE2QgZ/fhoG4yOfBhNqQaRSL+zaDwml5Yz6jOtvJh67jMnKw6N+wi0sIbIe
         Mm8mQVA+2u8LT3VkqmynnJTLF3S57zZw4J5oN4yAskvbVIP3kN9PPio/k4SweEo3wasf
         SBf/Cjyael2nt2iTyGHsuGr1Dn3FYPfUtpeH54hk/6YJWTDJXlS6GTunaBzecbC+6+b9
         ySMw==
X-Gm-Message-State: AOAM530YXo6hfSpz1gsjIUcx2x0zes0CkAfyNVRVNzwES2pA59y1vKGz
        ikTK30ON9aGmCH0xXrGcITzIyiQPbMI=
X-Google-Smtp-Source: ABdhPJwPHAj/IiYrUMLypCQPjv/fJ3bR2zeFUTu9KZdFpWFfLAU6Z7ucmtKxtVh9oSxrF3nj2rz1pw==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr22381827wmb.108.1594022067119;
        Mon, 06 Jul 2020 00:54:27 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id g145sm15028147wmg.23.2020.07.06.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:54:26 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/5] RDMA/providers: Set max_pkey attribute
Date:   Mon,  6 Jul 2020 10:54:14 +0300
Message-Id: <20200706075419.361484-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set makes sure to set the max_pkeys attribute to the providers
that aren't setting it or not setting it correctly.

Kamal Heib (5):
  RDMA/siw: Set max_pkeys attribute
  RDMA/efa: Set max_pkeys attribute
  RDMA/cxgb4: Set max_pkeys attribute
  RDMA/i40iw: Set max_pkeys attribute
  RDMA/usnic: Fix reported max_pkeys attribute

 drivers/infiniband/hw/cxgb4/provider.c       | 1 +
 drivers/infiniband/hw/efa/efa_verbs.c        | 1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 1 +
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
 drivers/infiniband/sw/siw/siw_verbs.c        | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.4

