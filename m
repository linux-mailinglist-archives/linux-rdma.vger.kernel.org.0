Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778E8213CA1
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgGCPev (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPeu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 11:34:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669E0C061794
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 08:34:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so32406529wmi.3
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVDnIsaL7bvcyTwLTXR3TjZOW4wb6ajcgEwsvm0QPI0=;
        b=Kxk1Hi9rGHh5jPAHn/FwYdh3+wuvZu4ir7kyGevD0kl+0wPZ79loCI/Tc0gUsCbAZq
         eHXU+7hYpKHMnyHK7lNKtWL1D7IqSLNNPmAImwHL51aEBI6WaPgmlfAydns3+hNbIWfY
         LQZBybJ6ooAx02mzQ41hTDuO2CB1eF5rlj5sSb1ZfRjRc3XnuU1IPn5QxmiXlAd2JlBp
         BV5gPVe34rAYauioFa843qMUNX6zdegP7FOHyno2++L37YSKIguf48U9NgsYZ0jET0xc
         gPpLxDXkGT22hRMXJeXs99DggqUWHQmuT6i1kePZxehrf45li6qIpWEI4rBfUjY1d6dV
         qm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hVDnIsaL7bvcyTwLTXR3TjZOW4wb6ajcgEwsvm0QPI0=;
        b=fbrtL59lqq+X4t+CCbLskaO9QqrSWiAuqCdpJDhaapIZgTjZn3pi//Uap0yFaPBh8I
         gUlpcRGpjBOe/4quzpiNItjEJgA4PGMdeI99dnsyiAnsLS0MifoOU7TEPhQPlkzug/zW
         CKu/Lsz/mQDQkR1AjExg5SQxy+LCzVUCkHj0ExnbirL80NG7+upVc1SqPGhFRMgoMa69
         u0hCsTxVHpq0s08G10vJbaXjRrbE8chk+6Go5Pj5cUZtOIPcC7D3uSklrzJXkPmU1Ov+
         x4/eaGPsh343dnCsJoSpEfYFJfamZL7RA94C3/CIQe5W70Siaob01bjUFVm4TITiuc+K
         9qxg==
X-Gm-Message-State: AOAM532inUgyEZCEHZveoEN5g9NBBM5+rztHLOKZVhUCO9CBdVogoLYg
        Q3UdomAlNocEvAesRvse7ZusfaWnTBQ=
X-Google-Smtp-Source: ABdhPJwBaa0xtrz9VSqIO2aAaGBa7vV3BrIAbPObEGPP84J22cZhQnduK0kqvQ0xDxAN7ndbYJll5Q==
X-Received: by 2002:a1c:2157:: with SMTP id h84mr36449232wmh.35.1593790488774;
        Fri, 03 Jul 2020 08:34:48 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r1sm14083225wrt.73.2020.07.03.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:34:48 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 0/4] RDMA/rxe: Cleanups and improvements
Date:   Fri,  3 Jul 2020 18:34:24 +0300
Message-Id: <20200703153428.173758-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These series include few cleanup patches to the rxe driver.

Kamal Heib (4):
  RDMA/rxe: Drop pointless checks in rxe_init_ports
  RDMA/rxe: Return void from rxe_init_port_param()
  RDMA/rxe: Return void from rxe_mem_init_dma()
  RDMA/rxe: Remove rxe_link_layer()

 drivers/infiniband/sw/rxe/rxe.c       |  7 +------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  5 ++---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
 drivers/infiniband/sw/rxe/rxe_net.c   |  5 -----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 24 ++++--------------------
 5 files changed, 9 insertions(+), 38 deletions(-)

-- 
2.25.4

