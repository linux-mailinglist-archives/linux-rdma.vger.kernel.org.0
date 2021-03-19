Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD51341F66
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCSObe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 10:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhCSObM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 10:31:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20A0164F18;
        Fri, 19 Mar 2021 14:31:12 +0000 (UTC)
Subject: [PATCH v1 0/6] svcrdma Receive batch-posting, take 2
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 19 Mar 2021 10:31:11 -0400
Message-ID: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

I found the problem with the original (now reverted) commit to
batch-post Receives. I've taken some time to split the change
into smaller pieces and update a few documenting comments.


---

Chuck Lever (6):
      svcrdma: RPCDBG_FACILITY is no longer used
      svcrdma: Provide an explanatory comment in CMA event handler
      svcrdma: Remove stale comment for svc_rdma_wc_receive()
      svcrdma: Add a batch Receive posting mechanism
      svcrdma: Use svc_rdma_refresh_recvs() in wc_receive
      svcrdma: Maintain a Receive water mark


 include/linux/sunrpc/svc_rdma.h          |  2 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 91 +++++++++++++-----------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  8 ++-
 3 files changed, 60 insertions(+), 41 deletions(-)

--
Chuck Lever

