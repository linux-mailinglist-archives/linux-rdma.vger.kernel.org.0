Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863B97E28AD
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Nov 2023 16:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjKFP35 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Nov 2023 10:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjKFP34 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Nov 2023 10:29:56 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD25125
        for <linux-rdma@vger.kernel.org>; Mon,  6 Nov 2023 07:29:49 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so2998257fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 06 Nov 2023 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699284589; x=1699889389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rLzBQbSUKYciLVHLwNqQ0FWT+UR06c5/tHhak9/t0rM=;
        b=ajy2tkxfQd80EUG0uVX8TQylMcJ18Zlz7+SnDKMMiua8tZACsfWkbr9XuLZ1vd+n9V
         wnSW91bMYaQ9QMvPQmpV+wsg/3czre9qP4ZMOGSZZzduZ8uptFN+CeRquizMpmd+4tA/
         rE+S7/bj9FaF3O2ausa2/RJ6Nt0hcLTSGEZNjDMIXQvX0YxL36dTLlXczYRsietSX5Ap
         yvnja+JFo3dUjNkMvBW7T4eaw1NfPNaWxVKPNtRMdgtjGzRr8d3Obs7h5oIU5VymZ8kb
         M+5G+oTHRRgjE6lF4/dZd6+UfVr4NXi7SriJTVWb14S5Qyfoen6ial9qvnRugD7c0lCa
         UKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699284589; x=1699889389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLzBQbSUKYciLVHLwNqQ0FWT+UR06c5/tHhak9/t0rM=;
        b=tUkd5cxFnLJ+Ysal6AlTkdT6PmNeWXQesPoUIOomWFqbz3VflI3cCIyQNmMvCL2W0G
         JEbEL1dShfZZ+FL2hOnypmyZ6BFy7MBAxKt4PGUEUCr8s16O1hs5vCEc3N1vhadIkyrC
         MI1W7Vfudm2WTcYMn1ADN11klUq/oD1b0ziGYQpBh3BCiCtuUf9IRzkVHcGYnpRqlXwD
         aDZI9WLSSZzdAUgr4Q0ikFyKh2Xl8Gfm+yCMotdXwroztuvLf/y0NQBVHuiHEP4uwGmy
         ySUcaB8oLCV4rhwgSOgvbPRYUm4kxe6EdkKQM1f1OrzNv6QCWcFk65SWDZlDP8Bfxm9r
         Cj9w==
X-Gm-Message-State: AOJu0Yyim0zj5hquMJXTxhzcxo1b9iBjQx4j4NiJ1nMxgzmT3pfGjtcZ
        GLQrTZtakWdmnJfQUcaum1Mem/an8S9ELg==
X-Google-Smtp-Source: AGHT+IG5VLrmU1RkY6PzkKsiQ9o3X2dHV6WTPrk1wTCPP2NQz6BfOjUcyzu3UGzCGM3DprYmdaqBWw==
X-Received: by 2002:a05:6871:4e47:b0:1ef:b391:e11b with SMTP id uj7-20020a0568714e4700b001efb391e11bmr11145oab.2.1699284588680;
        Mon, 06 Nov 2023 07:29:48 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-7d5a-f32b-d7fe-f16c.res6.spectrum.com. [2603:8081:1405:679b:7d5a:f32b:d7fe:f16c])
        by smtp.gmail.com with ESMTPSA id ds50-20020a0568705b3200b001e578de89cesm1438897oab.37.2023.11.06.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 07:29:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/6] RDMA/rxe: Make multicast work
Date:   Mon,  6 Nov 2023 09:29:23 -0600
Message-Id: <20231106152928.47869-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After developing a test program which exercises node to node
testing of RoCE multicast it became clear that there are a
number of issues with the current rdma_rxe multicast implementation.

The issues seen include:
	- There is no support for IPV4 multicast addresses.
	- Once a multicast MAC is added it is not removed.
	- Multicast packets are sent with the wrong QP number.
	- Multicast packets sent from the local node are not
	  loopbacked to local QPs which have joined the same
	  multicast group and were not the sender.
	- Multicast IP addresses are not created and without
	  them no multicast packets received on the interface
	  are delivered to the rdma_rxe driver.
	- The implementation in rxe_mcast.c is potentially
	  racy if multiple simultaneous attach/detach operations
	  are issued.

This patch set fixes these issues. 
---
v2:
  Respond to comments by Zhu.
  Added more Fixes lines.
  Added some more explanation in the commit messages.
  Fixed an error in rxe_lookup_mcg. Should have checked
	the return from rxe_get_mcg().

Bob Pearson (6):
  RDMA/rxe: Cleanup rxe_ah/av_chk_attr
  RDMA/rxe: Handle loopback of mcast packets
  RDMA/rxe: Register IP mcast address
  RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
  RDMA/rxe: Split multicast lock
  RDMA/rxe: Cleanup mcg lifetime

 drivers/infiniband/sw/rxe/rxe.c        |   2 +-
 drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
 drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 519 +++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_net.c    |  28 +-
 drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
 drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
 drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
 drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
 drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
 12 files changed, 288 insertions(+), 356 deletions(-)

-- 
2.40.1

