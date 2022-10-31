Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D445613EED
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 21:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJaUYX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 16:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJaUYW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 16:24:22 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C3112AD6
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:24:20 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13b103a3e5dso14722800fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Oct 2022 13:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8R0jv+CXtuiexc6mAIWR3rmEMhWPNvndEuBRBpi9L4=;
        b=SI3dkuIxGu2YSYIWoNRGTx3jd1VFQYjHz7Xdi14DOOGTXFWv6Y2JSwflOymw9Nf8SO
         S3AsbOrLe9po0d8pZyLQ9CjB+EJJ9UiaSY0YJIlaW6IoI1QUJquLlHmF19JMcDl8nvyU
         AQfnyxiW33cCXfAhaZirYdntMV50Ekw1+IaaZLxEIJT0zcl75KGhemM3kXsesebqarEI
         PvZW8hiwjkuNPus8DLFzko+zviQHBDAj+1FAxmGFN1SLDpzIIBznLZ6EpGEr/pyvYa3d
         TjJcN9MRPMBBEpm8PN4O47JE67tYkoig978+9CxRmonIe6IXVo6r8HVt/DmFIrMRo/X+
         oqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A8R0jv+CXtuiexc6mAIWR3rmEMhWPNvndEuBRBpi9L4=;
        b=kv14Ck44c4EA972Ds+JL8M943GwRBd7WV+tpxCRHk6YnwxVStpGLqIfif2cXThgGt3
         UYRF1Yoim0RjMyrv6cG4CWHnBgbkglH4EqUz+bH/lzgN6dF3ebE+HNFB1AIdnbFcGcwP
         6ty1HH5mKdsZGyX5iVmFFaVn/vfai930b7Jl8OjCSprw8ZCUDSIl1X7bbAk8FMKwzbz1
         ztMaJTzSTv96X8EskztK1bFxyEVOQ+JyPo1Qea7qMIjec60G7EK+rBdmuLBrLvBtfyO/
         NLnZFMpIKOw+pweSaY012wvMMJ7gsxd9O7/vfw3Y/OPallnnulxn3AVs0OBISjDOwQG0
         Ixbw==
X-Gm-Message-State: ACrzQf0TarvSjD9hi+86TUP4ZHbQdFPKtJIIX9B+6ayxNj2Rn76L3fUR
        AmOYKkdATssxXHPVdJRRRZU8WRNi2Es=
X-Google-Smtp-Source: AMsMyM67ql2ypF/02S6TeQPxYILgE1r7C/xpJkJdxBG1COITyayel2SHWxxARIy+WX8wVjmtPooDYA==
X-Received: by 2002:a05:6870:ec90:b0:13b:b20a:ae81 with SMTP id eo16-20020a056870ec9000b0013bb20aae81mr8472920oab.77.1667247860364;
        Mon, 31 Oct 2022 13:24:20 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-ce7d-a808-badd-629d.res6.spectrum.com. [2603:8081:140c:1a00:ce7d:a808:badd:629d])
        by smtp.googlemail.com with ESMTPSA id q3-20020a056870328300b0013ae39d0575sm3137910oac.15.2022.10.31.13.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:24:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v2 00/18] RDMA/rxe: Enable scatter/gather support for skbs
Date:   Mon, 31 Oct 2022 15:23:46 -0500
Message-Id: <20221031202403.19062-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series implements support for network devices that can
handle or produce fragmented packets. This has the performance
advantage of reducing the number of copies of payloads for large
packets.

On the send side packets are created with the network and
roce headers in the linear portion of the skb and the payload in
skb fragments. The pad and icrc are appended in an additional fragment
pointing at data stored in free space in the tail of the linear
buffer. Only RC messages are supported.

On the receive side any fragmented skb is supported.

This patch series is based on the current for-next branch. It also can
be applied to current for-next after the workqueue patch series is
applied without change.

v2:
  Rebased to current for-next from wip/jgg-for-next.
  One patch is split into two 03/17 -> 03/18 and 04/18
  Three errors reported by the kernel test robot are fixed
	04/18	Fix use of uninitialized variable in error path
	13/18	Missing static declaration
	15/18	Fix use of uninitialized variable in error path
Reported-by: kernel test robot <lkp@intel.com>

Bob Pearson (18):
  RDMA/rxe: Isolate code to fill request roce headers
  RDMA/rxe: Isolate request payload code in a subroutine
  RDMA/rxe: Remove paylen parameter from rxe_init_packet
  RDMA/rxe: Isolate code to build request packet
  RDMA/rxe: Add sg fragment ops
  RDMA/rxe: Add rxe_add_frag() to rxe_mr.c
  RDMA/rxe: Add routine to compute the number of frags
  RDMA/rxe: Extend rxe_mr_copy to support skb frags
  RDMA/rxe: Add routine to compute number of frags for dma
  RDMA/rxe: Extend copy_data to support skb frags
  RDMA/rxe: Replace rxe by qp as a parameter
  RDMA/rxe: Extend rxe_init_packet() to support frags
  RDMA/rxe: Extend rxe_icrc.c to support frags
  RDMA/rxe: Extend rxe_init_req_packet() for frags
  RDMA/rxe: Extend response packets for frags
  RDMA/rxe: Extend send/write_data_in() for frags
  RDMA/rxe: Extend do_read() in rxe_comp,c for frags
  RDMA/rxe: Enable sg code in rxe

 drivers/infiniband/sw/rxe/rxe.c       |   3 +
 drivers/infiniband/sw/rxe/rxe.h       |   3 +
 drivers/infiniband/sw/rxe/rxe_comp.c  |  47 ++-
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  65 +++-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  30 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 419 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.c   | 137 +++++++--
 drivers/infiniband/sw/rxe/rxe_recv.c  |   1 +
 drivers/infiniband/sw/rxe/rxe_req.c   | 286 +++++++++++-------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 209 ++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  15 +-
 11 files changed, 866 insertions(+), 349 deletions(-)


base-commit: 4508d32ccced24c972bc4592104513e1ff8439b5
-- 
2.34.1

