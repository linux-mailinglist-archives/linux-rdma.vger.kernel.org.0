Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E665B19A8
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 12:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiIHKJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 06:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiIHKJP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 06:09:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1BE42C3
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 03:09:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D000DB81FB9
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 10:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17777C433C1;
        Thu,  8 Sep 2022 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662631749;
        bh=B43WY061/TZn9/3PnQgW/uq97u3QPi7wo3TPJOdXjrE=;
        h=From:To:Cc:Subject:Date:From;
        b=qrLSDhiMd6P1M+pM0UtqiS37l2j+ScYDj2xwLcMdaseS3mjbGzd/iT0qnakOj71tK
         OpHDptIV8sJKiTNIJ+mS4IyK/aGyHZnJB749MSP1tfFpgkaec1vSzvgwquKeAitmq1
         8yU5gdh9TdwoKwiLVstJpK9UfQoUmJvREZmaUNVVFJFmhpTX6ktZHuCP9RJteH9EWT
         LJZ4JUJd2glLbTFEw/7zeu6ARFrauZgxsnrMOdDpgQs5UMN5dnewZNMGP35MsgUDZ3
         kjDVwAGJmtk0C+pgZYLCfqK3PN6XvD7PsPtV2PtMtJHhk1hvrQHuiyi2ZAD4MeJaBQ
         UpX0HfUzwGmOw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next 0/4] Support multiple path records
Date:   Thu,  8 Sep 2022 13:08:59 +0300
Message-Id: <cover.1662631201.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

From Mark:

These patches allow IB core to receive multiple path records from
user-space rdma netlink service.

Currently only one GMP PR is supported when doing a PR query. This means
in a fabric with multiple subnets, when a packet goes out of the sender,
it’s assigned with a LID to a router as its destination LID. The current
solution selects a specific router per destination, means that there is
no advanced routing from the sender towards the network.

This patchset supports to receive an inbound PR and an outbound PR along
with the GMP PR. The LIDs in these 3 PRs can be used in this way:
1. GMP PR: used as the standard local/remote LIDs;
2. DLID of outbound PR: Used as the "dlid" field for outbound traffic;
3. DLID of inbound PR: Used as the "dlid" field for outbound traffic in
   responder side.

The inboundPR.dlid is passed to responder with the "primary_LID" filed
in the ConnectRequest message.

With this, the user-space rdma netlink service can set special DLIDs
in inbound/outbound PRs, to select specific routers for datapath
between the 2 nodes.

The following cases were tested:
- New kernel with new netlink service that supports multiple path
  records;
- New kernel with old netlink service;
- Old kernel with new netlink service;
- Client side new kernel with new netlink service, server side with
  old kernel.

Thanks.

Mark Zhang (4):
  RDMA/core: Rename rdma_route.num_paths field to num_pri_alt_paths
  RDMA/cma: Multiple path records support with netlink channel
  RDMA/cm: Use SLID in the work completion as the DLID in responder side
  RDMA/cm: Use DLID from inbound/outbound PathRecords as the datapath
    DLID

 drivers/infiniband/core/cm.c              |  39 +++-
 drivers/infiniband/core/cma.c             |  88 ++++++--
 drivers/infiniband/core/sa_query.c        | 235 +++++++++++++++-------
 drivers/infiniband/core/ucma.c            |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c       |   2 +-
 include/rdma/ib_cm.h                      |   2 +
 include/rdma/ib_sa.h                      |   3 +-
 include/rdma/rdma_cm.h                    |  13 +-
 9 files changed, 284 insertions(+), 110 deletions(-)

-- 
2.37.2

