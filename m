Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91F581BA1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jul 2022 23:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiGZVWH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jul 2022 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZVWG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jul 2022 17:22:06 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA22E9EE
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:05 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id q22so9048840pgt.9
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jul 2022 14:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPFY4BKtVpY3SqyUsNsQSoWEDyTjdgDbiZB3gFIzutk=;
        b=qJ0peNxC1YhW4U95cmTzMchXyJdrM2qi6zVVuPdsVkujqh73S1muhs7DtPmfQhc5BA
         yTfzZWyedAns0ZHAVN+XhwnDr4dngMHQmpp0GhdL25UxRTYwS/BVUaftiyMMD4r+AI6p
         /4IUURi+K1OwuMvi8FnMsjON0jgynjhJmywePxQravANS/syYgwWD1W9bPutk65wonIA
         psQ4IDWtl5BLJmwKbRyvgF6gxMbUzT7Fpz422xdSJCwn2HZBZZNTUQVyN+ervU0l08il
         0RrBwf5wrI0d0iIK00b0gA5BTuMfUBkn2HL+AAMQsMRppsYEphHY7vwPEBwlF83jQ6lp
         mt7A==
X-Gm-Message-State: AJIora+Ga8zkuOK1psN7ZU8w3H9V6tPnFGIAfOamiwP05r8o6YQo+T3w
        iCnf7e8Eem2JUDTvfQt/OF5zKeBUHzw=
X-Google-Smtp-Source: AGRyM1s6yuUjVJgIhjS/7uqfBaNLLSM4XWPOy9eIfvw4/K5zhNYE166I+0wf0UrMZZeH6DPPvZV71A==
X-Received: by 2002:a63:8c47:0:b0:40d:2d4:e3a2 with SMTP id q7-20020a638c47000000b0040d02d4e3a2mr16761912pgn.2.1658870524931;
        Tue, 26 Jul 2022 14:22:04 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:34f4:7aa8:57:d456])
        by smtp.gmail.com with ESMTPSA id g5-20020aa796a5000000b00528999fba99sm12398983pfk.175.2022.07.26.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:22:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Fix a use-after-free in the SRP target driver
Date:   Tue, 26 Jul 2022 14:21:53 -0700
Message-Id: <20220726212156.1318010-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

A known issue in the SRP target driver is that a use-after-free is triggered
if an RDMA port is removed while a LIO target port is still associated with
that RDMA port. This patch series fixes that use-after-free.

Thanks,

Bart.

See also:
* Commit 9b64f7d0bb0a ("RDMA/srpt: Postpone HCA removal until after configfs directory removal").
* https://lore.kernel.org/all/17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com/

Bart Van Assche (3):
  RDMA/srpt: Duplicate port name members
  RDMA/srpt: Introduce a reference count in struct srpt_device
  RDMA/srpt: Fix a use-after-free

 drivers/infiniband/ulp/srpt/ib_srpt.c | 151 ++++++++++++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  18 ++-
 2 files changed, 120 insertions(+), 49 deletions(-)

