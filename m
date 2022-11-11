Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA98162528A
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 05:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKKEav (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 23:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKEau (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 23:30:50 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7A42F68;
        Thu, 10 Nov 2022 20:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668141047; i=@fujitsu.com;
        bh=qfFZQbTvGV8YnMkJ2TiYg0iJaPMZtX/qYQUzFkFbqog=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=koQX9oOH6fRK3ZlKT8cKu16lj1Ik96huRV64Nnvf/sU8IF64ulhn14Vdch0JQ4jjf
         267+oJs9BoDTS2deY5xKx44th9NvUVy2Io6pUemV2KySMbHIhiBm/ofPxUgLiJkJtI
         yATqyYu7SxqA/0QJ4UpRUvBfqQQdt5UrgkBnDpdjJIX9My9UIj9Yzgo8b+S4dfJasA
         IcQoSJf+hryfg/8TMFQcECn4hPRFBv0toJJs5tVRS+6HhpE+f2L8jngjT33TmPRTXU
         fsDP2jq84vc6wSHx2sF9HAO+UX4+Tle3lISfwWQ01r5KUZulkGLpo4YWlKDiOn5iy5
         ahVZFEehuKcGA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRWlGSWpSXmKPExsViZ8OxWff7+dx
  kg6sLmC1mzjjBaDHl11Jmi8u75rBZPDvUy2Jx/lg/uwOrx85Zd9k9Nq3qZPP4vEnOY+vn2ywB
  LFGsmXlJ+RUJrBmX/01jK7jKWfF51Rb2BsaFHF2MXBxCAhsZJSaebGCBcJYwSVxtb2OEcA4wS
  qxcs4e9i5GTg01AQ+Jey01GEFtEoJNRYltrGojNLOAmsenNbLAaYQETiRW/LrKB2CwCqhJLns
  1gBrF5BRwlVs7cDtYrIaAgMeXhe6i4oMTJmU9YIOZISBx88QIozgFUoyQxszseorxCYtasNiY
  IW03i6rlNzBMY+Wch6Z6FpHsBI9MqRvPi1KKy1CJdQ0u9pKLM9IyS3MTMHL3EKt1EvdRS3bz8
  opIMXUO9xPJivdTiYr3iytzknBS9vNSSTYzAkE4pTo3ewTh32R+9Q4ySHExKorz7bHKThfiS8
  lMqMxKLM+KLSnNSiw8xynBwKEnw6p0FygkWpaanVqRl5gDjCyYtwcGjJMIrvB0ozVtckJhbnJ
  kOkTrFqCglznv8HFBCACSRUZoH1waL6UuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHnjQKb
  wZOaVwE1/BbSYCWixXWoWyOKSRISUVAOTZpb84sP2u1b8XNH9NXiX0kNXVr/tJ1qKIvW25ufm
  i65/ItKv7mLixDYhImxfYVxi4PM+I53jCXoxM2UnzN745OCCRQWOR9f0Jp57IV+WnWUvxm0Ys
  EqrQvek47Yzr/R3/9G5c84gUiNx2d5S+T3LJq6z1eAsqmObpNa7XXnaz9Tapc5zeCvMO9jUrr
  1xXr3b6v6Fa1GRUldaN2SF+jdLTrWwl7y44dLJz91/viVe/Bbsf7FTLjJauqX+0LLOqRp5l6/
  uvq5zzT3v9J5p3evWPm/8PqFKp/+jiZbzOb61XjkdOVOuHjXZduWXof+uWZknt/jsWdCkcGW5
  6ylHc6nrP4qLHDZInzuwf6eGnqG8EktxRqKhFnNRcSIAKDsId2QDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-6.tower-732.messagelabs.com!1668141046!636325!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29744 invoked from network); 11 Nov 2022 04:30:47 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-6.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 04:30:47 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 80115155;
        Fri, 11 Nov 2022 04:30:46 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 737F7154;
        Fri, 11 Nov 2022 04:30:46 +0000 (GMT)
Received: from bc0da1a9c27e.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 04:30:43 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 0/5] iova_to_vaddr refactor
Date:   Fri, 11 Nov 2022 04:30:25 +0000
Message-ID: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
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

Background:
iova_to_addr just lookups at the map which is constructed and manages the
relationship between iova to vaddr when MR is registering. By conventional,
we should map the userspace address(iova) every time we want to access it.
Please refer to the previous discussion[1][2] for more details.

Refactor:
In this refactoring, we will do the map every time before the user really
accesses it.

patch1,3,5 are cleanup and preparation.
patch2 is to make all subroutines accessing the iova use iova_to_vaddr() API.
patch4 is the refactor.

[1]: https://www.spinics.net/lists/linux-rdma/msg113206.html
[2]: https://lore.kernel.org/all/20220118123505.GF84788@nvidia.com/

Li Zhijian (5):
  RDMA/rxe: Remove rxe_phys_buf.size
  RDMA/rxe: use iova_to_vaddr to transform iova for rxe_mr_copy
  RDMA/rxe: iova_to_vaddr cleanup
  RDMA/rxe: refactor iova_to_vaddr
  RDMA/rxe: Rename iova_to_vaddr to rxe_map_iova

 drivers/infiniband/sw/rxe/rxe_loc.h   |   3 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 128 +++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_resp.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |   1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h |   6 +-
 5 files changed, 62 insertions(+), 81 deletions(-)

-- 
2.31.1

