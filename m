Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E67E7825C5
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Aug 2023 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjHUIsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjHUIsb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 04:48:31 -0400
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0351E8F
        for <linux-rdma@vger.kernel.org>; Mon, 21 Aug 2023 01:48:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692607707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SPqz+H7g/iR/OIUlA1mHX6CGPiBvcuHmgNQRXoxFdrI=;
        b=OlC3ahqZkmUc9FrYW35ZGUnHtHHPAuvdxMI/BZyk1UoccKkIVKmhmZOdUlTJeTObqsHFGJ
        HMArlOWBBheQipAt3TlV3eTR9cXgAAdAnEx0AKFBb1EHxIZMZ/VTiT9Jsc5MkA9zM++6No
        hnpglVll/Ta/ds+KQXwJoCO3UIKRZSY=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH V2 0/3] Misc changes for siw
Date:   Mon, 21 Aug 2023 16:47:40 +0800
Message-Id: <20230821084743.6489-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V2 changes:
1. add Fixes lines for the first two patches per Leon

Hi,

The first one fix below calltrace which could happen if siw_connect
goto error (I manually set rv to -1 after siw_send_mpareqrep to trigger
it) after cep is allocated.

[   97.341035] ------------[ cut here ]------------
[   97.341037] WARNING: CPU: 0 PID: 143 at drivers/infiniband/sw/siw/siw_cm.c:444 siw_cep_put+0x1c5/0x1e0 [siw]
...
[   97.341126] CPU: 0 PID: 143 Comm: kworker/u4:4 Tainted: G           OE      6.5.0-rc3+ #16
[   97.341128] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
[   97.341130] Workqueue: rdma_cm cma_work_handler [rdma_cm]
[   97.341137] RIP: 0010:siw_cep_put+0x1c5/0x1e0 [siw]
...
[   97.341159] Call Trace:
[   97.341160]  <TASK>
[   97.341162]  ? show_regs+0x72/0x90
[   97.341166]  ? siw_cep_put+0x1c5/0x1e0 [siw]
[   97.341170]  ? __warn+0x8d/0x1a0
[   97.341175]  ? siw_cep_put+0x1c5/0x1e0 [siw]
[   97.341180]  ? report_bug+0x1f9/0x250
[   97.341185]  ? handle_bug+0x46/0x90
[   97.341188]  ? exc_invalid_op+0x19/0x80
[   97.341190]  ? asm_exc_invalid_op+0x1b/0x20
[   97.341196]  ? siw_cep_put+0x1c5/0x1e0 [siw]
[   97.341204]  siw_connect+0x474/0x780 [siw]
[   97.341211]  iw_cm_connect+0x1ca/0x250 [iw_cm]
[   97.341216]  rdma_connect_locked+0x1bf/0x940 [rdma_cm]
[   97.341227]  nvme_rdma_cm_handler+0x5d7/0x9c0 [nvme_rdma]
[   97.341235]  cma_cm_event_handler+0x4f/0x170 [rdma_cm]
[   97.341241]  cma_work_handler+0x6a/0xe0 [rdma_cm]
[   97.341247]  process_one_work+0x2bd/0x590
...

The second one make the debug message consistent with the condition,
and the last one cleanup code a bit. Pls help to review them.

Thanks,
Guoqing

Guoqing Jiang (3):
  RDMA/siw: Balance the reference of cep->kref in the error path
  RDMA/siw: Correct wrong debug message
  RDMA/siw: Call llist_reverse_order in siw_run_sq

 drivers/infiniband/sw/siw/siw_cm.c    |  1 -
 drivers/infiniband/sw/siw/siw_qp_tx.c | 12 +-----------
 drivers/infiniband/sw/siw/siw_verbs.c |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

-- 
2.35.3

