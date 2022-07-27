Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF35833B1
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jul 2022 21:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiG0Te0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Jul 2022 15:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiG0TeY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Jul 2022 15:34:24 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C043DF3F
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 12:34:23 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id s206so16705443pgs.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Jul 2022 12:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mP3HC3whjoeIFmHziJ/RuBv0JzbMyAUyXan0Xuf/52U=;
        b=hatZ4uJYrRPtFDHeJvm0kyc63oxgLHtweZ92vI2AoinS+s4TigrSN4A0xk4K0TR5H4
         leSRy0vwJ92ORtqtdXhmPh70sKz+PQE4skLsIVO40JKN4fDximDMinUesYvvCGwv0VlJ
         i9JGJMXQr1vf6sYmaSYQyYN/IlW3o5XG943DUqwQoXQqWjOrhwvi5Ne79kkk8LicuuMn
         c+d+CjZ8EsITfRd8j+CJzC1rqlbiOnfPNvL7WVV9d+fWm0sCUdW4KXWGjes5BFimmSD4
         2OO8JhvdV7XjFofCJeyfrHMTnnx/pgKqpnOxiQ3OGvnpDgKYCWtN3zhCzq0/jnfc3TWM
         bsPA==
X-Gm-Message-State: AJIora+SVQRlQ33HNfoNbHjZwFU4fuSN4uEXm7/hHQkvqwydOLjLUput
        uSYdGveAZMp9ft0zSGBAuUE=
X-Google-Smtp-Source: AGRyM1sJkBPFkjO1Vx6ZLN/IM6iQJTUCjigvSsfK06XasDXnKdKWJuC7QUOcDFKvBn2kNVCCBqmMJw==
X-Received: by 2002:a63:d244:0:b0:41a:6769:104a with SMTP id t4-20020a63d244000000b0041a6769104amr19839538pgi.525.1658950463091;
        Wed, 27 Jul 2022 12:34:23 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a84e:2ec1:1b57:b033])
        by smtp.gmail.com with ESMTPSA id y28-20020aa7943c000000b0052b94e757ecsm14221542pfo.213.2022.07.27.12.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 12:34:22 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>,
        Hillf Danton <hdanton@sina.com>,
        Mike Christie <michael.christie@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Fix a use-after-free in the SRP target driver
Date:   Wed, 27 Jul 2022 12:34:12 -0700
Message-Id: <20220727193415.1583860-1-bvanassche@acm.org>
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

Changes compared to v1:
- Left out three BUG_ON() statements.
- Added three WARN_ON_ONCE() statements.
- Removed an unnecessary if (!sport_id) statement block.

Bart Van Assche (3):
  RDMA/srpt: Duplicate port name members
  RDMA/srpt: Introduce a reference count in struct srpt_device
  RDMA/srpt: Fix a use-after-free

 drivers/infiniband/ulp/srpt/ib_srpt.c | 148 ++++++++++++++++++--------
 drivers/infiniband/ulp/srpt/ib_srpt.h |  18 ++--
 2 files changed, 118 insertions(+), 48 deletions(-)

