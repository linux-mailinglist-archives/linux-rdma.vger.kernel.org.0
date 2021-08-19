Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DA3F11B0
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Aug 2021 05:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhHSDcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 23:32:19 -0400
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228]:51436 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236605AbhHSDcP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 23:32:15 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B228A80F2;
        Wed, 18 Aug 2021 20:25:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B228A80F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1629343557;
        bh=OK3B8NVw+wfpP/rBxiBzCCjYYwhZZO2NyQe0K3H+zME=;
        h=From:To:Cc:Subject:Date:From;
        b=cezVqoiYO4YdeU/8xxQvTh5VS9GZtES8QnEKqhurlyTKipO+gVjmomqK/LAtQk/Bb
         I7/MpK+fcNyT2J4q7rjukRsTNrPBO8B/hmMGOx063F8IDNkkpVGuGb4Ed5w2Pyftry
         D/vfcmrOG/We2HbXfVzfH+1P+BPgNAu4eEMiv7f8=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc v2 0/3] RDMA/bnxt_re: Bug fixes
Date:   Wed, 18 Aug 2021 20:25:50 -0700
Message-Id: <1629343553-5843-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some simple bug fixes

v1->v2:
 Fix a build issue
 Reported-by: kernel test robot <lkp@intel.com>

Naresh Kumar PBS (1):
  RDMA/bnxt_re: Add missing spin lock initialization

Selvin Xavier (2):
  RDMA/bnxt_re: Disable atomic support on VFs
  RDMA/bnxt_re: Fix query SRQ failure

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 1 +
 drivers/infiniband/hw/bnxt_re/main.c     | 2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.5.5

