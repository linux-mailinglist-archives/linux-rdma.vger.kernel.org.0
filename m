Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337772ECAA3
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 07:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAGGr3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 01:47:29 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:33964 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbhAGGr3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 01:47:29 -0500
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-76.dhcp.broadcom.net [10.123.156.76])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 118897FCA;
        Wed,  6 Jan 2021 22:39:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 118897FCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1610001565;
        bh=Su/6O2QNoi/dqn2QzijKijGkmBMOggGVoKuSImZTITo=;
        h=From:To:Cc:Subject:Date:From;
        b=GLq7rLhfeSPjnW7GkDgqKIvUUXYExkyClgCJeON8r2NQOGFSaYTpygq6HhokQtQDL
         6gV4LR5wkRKdEEPARblGC1jepc2xmt5gH6RMuuSw81oleDmtcB3wbnYChWwJ0ewj5L
         XPwc/MwV90PV0ogPE1cJsbUftCJFlWMJ8i4T+WWY=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/2] RDMA/bnxt_re: Allow bigger user MRs
Date:   Wed,  6 Jan 2021 22:39:17 -0800
Message-Id: <1610001559-13193-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactor user space MR code to handle bigger MRs. Removes couple of checks
that prevented the bigger MRs.

Selvin Xavier (2):
  RDMA/bnxt_re: Code refactor while populating user MRs
  RDMA/bnxt_re: Allow bigger MR creation

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 47 ++++----------------------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 29 +++++---------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  2 +-
 3 files changed, 14 insertions(+), 64 deletions(-)

-- 
2.5.5

