Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BD72ECD53
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbhAGJwV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 04:52:21 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:46318 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbhAGJwU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 04:52:20 -0500
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-76.dhcp.broadcom.net [10.123.156.76])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5D7CE7DB2;
        Thu,  7 Jan 2021 01:43:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5D7CE7DB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1610012612;
        bh=uiI0G8/blJuQqTC1YjT/ooHBOoARNDvS4SkmH7pTOyE=;
        h=From:To:Cc:Subject:Date:From;
        b=MVExLvmuZGNt8BePs+CB3rq2yDoTS2YZdpGJZVhrqL5PkjDy/q1XanJaQD0hBpJdr
         B2RKePw3kg1b256L9p3Eb+jWRlWMwjxWV0yDQqAjZENqYlfNkAuPsiANatsz6K0GIW
         2gsZ8ptSQZ6mYMjYItSUZC+lGKkGgLxxSgnpODAA=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/2] RDMA/bnxt_re: Allow bigger user MRs
Date:   Thu,  7 Jan 2021 01:43:26 -0800
Message-Id: <1610012608-14528-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Refactor user space MR code to handle bigger MRs. Removes couple of checks
that prevented the bigger MRs.

v1->v2:
 - Fix the build warning
   Reported-by: kernel test robot <lkp@intel.com>

Selvin Xavier (2):
  RDMA/bnxt_re: Code refactor while populating user MRs
  RDMA/bnxt_re: Allow bigger MR creation

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 49 ++++----------------------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 29 +++++--------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  2 +-
 3 files changed, 14 insertions(+), 66 deletions(-)

-- 
2.5.5

