Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E702657B348
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jul 2022 10:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGTI4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jul 2022 04:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTI4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jul 2022 04:56:34 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843DB20F73
        for <linux-rdma@vger.kernel.org>; Wed, 20 Jul 2022 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1658307391; i=@fujitsu.com;
        bh=dTj1qxjDqx5X1kTK8QMKTtFknLOaTsR2qPoxM5kePd8=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=tSC3ZwOmQwCsyguul0dOKcXZXGNDnzdREww63lAJvVRzfbWbURqOPTLCeyECvtFJ7
         wz6HetEsTg2WhM7lVoRsyyR9efP9UHqWtIMdOvexTSIpzzDAHnXNj52kLvZ6TMOQXM
         67VBeA1EP5nM7rRvJ3QmtGBGV3hK0iHnXiBwGqmO4DQPZZLwb9s8FWFK4ggS2J1m31
         33pona2Zf/WVyNIXAJnpNKA7oD9zsAjK9r0Dn7C4xNlsBm7je1OwS+JiaM/wnTp6y9
         SFU9qpFGo0lrT5uw8ulb+reDcuNQ20bh3mmp2ALhb63e3YGj2DPF/Uu67x73D/RyAo
         q8yBsgln3CIgA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRWlGSWpSXmKPExsViZ8MxSdf+8PU
  kgy9bOC2OrdzMYrHgw1sWi5kzTjBaTPm1lNni2aFeFosvU6cxWxyfco7dgd1j56y77B6bVnWy
  eex8aOmxsGEqs8fHp7dYPD5vkvPY+vk2SwB7FGtmXlJ+RQJrRu+2VraCxZwV99d9Y2xgvMrex
  cjJISSwhVHixuQwCHs5k8TL7fIQ9j5GiW3vUkFsNgENiXstNxlBbBGB64wSj7bIgtjMAr4SF8
  8fZgKxhQX8Jb7cuckKYrMIqEr8f3ObDcTmFXCRWNW6CKxGQkBBYsrD98wQcUGJkzOfsEDMkZA
  4+OIFM0SNosSRzr8sEHaFxOvDl6DiahJXz21insDIPwtJ+ywk7QsYmVYxWiYVZaZnlOQmZubo
  GhoY6Boamuoa6xpa6CVW6SbqpZbqlqcWl+ga6iWWF+ulFhfrFVfmJuek6OWllmxiBMZASjGz0
  A7G9X0/9Q4xSnIwKYny2iy+niTEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgrf6IFBOsCg1PbUiLT
  MHGI8waQkOHiURXl2QNG9xQWJucWY6ROoUo6KUOO8jkIQASCKjNA+uDZYCLjHKSgnzMjIwMAj
  xFKQW5WaWoMq/YhTnYFQS5v11AGgKT2ZeCdz0V0CLmYAWT3K6ArK4JBEhJdXAVPpz2ayv89S4
  RbSqrvkfENsvxBi5TfenR9orXd1HfjLW+7nlHZXlI5x6DUuYX6hLnFnRYXU3KGi6D+PXOexzF
  TlnK89ktDG84H9N5n15gvgr5//2thNz7k57Vys3de/mvgWzlq1xUXvz0ef27VKr6YJh5uuYz4
  jbz5i7+fD6eamTquLO7l2mwnoiY/su8a/HbR98aBXIbtnWGpQeNjNkherv6IUxC6YvXnLcVHz
  3QpGLd76+Ouo0K2zagn/VBm9ZTKt3axx2cXoTzvznQuCuumwR1zqXT2cctgWt2dhoWyhapd+r
  pHPdc892gW2GZTUWAp57X6wSUbpzxbzi7Bbm2upZ19/fvRjI8+bbwZINq5VYijMSDbWYi4oTA
  RZWWPx8AwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-13.tower-587.messagelabs.com!1658307390!70340!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5809 invoked from network); 20 Jul 2022 08:56:31 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-13.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Jul 2022 08:56:31 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id ADEAD1000CE;
        Wed, 20 Jul 2022 09:56:30 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 969AC1000C2;
        Wed, 20 Jul 2022 09:56:30 +0100 (BST)
Received: from centos-smtp.localdomain (10.167.226.45) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Jul 2022 09:56:26 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     Cheng Xu <chengyou@linux.alibaba.com>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RESEND for-next v6 0/4] RDMA/rxe: Fix no completion event issue
Date:   Wed, 20 Jul 2022 04:56:04 -0400
Message-ID: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No change since v5, just resend it via another smtp instead of
Microsoft Exchange which made patches messed up.

It's observed that no more completion occurs after a few incorrect posts.
Actually, it will block the polling. we can easily reproduce it by the below
pattern.

a. post correct RDMA_WRITE
b. poll completion event
while true {
  c. post incorrect RDMA_WRITE(wrong rkey for example)
  d. poll completion event <<<< block after 2 incorrect RDMA_WRITE posts
}

V4 add new patch from Bob where it make requester stop executing qp
operation as soon as possible.

Both blktests and pyverbs tests are passed fine.

Bob Pearson (1):
  RDMA/rxe: Split qp state for requester and completer

Li Zhijian (3):
  RDMA/rxe: Update wqe_index for each wqe error completion
  RDMA/rxe: Generate error completion for error requester QP state
  RDMA/rxe: Fix typo in comment

 drivers/infiniband/sw/rxe/rxe_comp.c  |  6 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  5 +++++
 drivers/infiniband/sw/rxe/rxe_req.c   | 16 +++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_task.c  |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
 5 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.31.1

