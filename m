Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A552998A0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 22:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgJZVQe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 17:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731097AbgJZVQe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 17:16:34 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4800920773;
        Mon, 26 Oct 2020 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603746993;
        bh=/xhBsCL+k12r3N7Ulof17Skh13jaAwG6z179pPOrpWw=;
        h=From:To:Cc:Subject:Date:From;
        b=DjYlRos4yHWuQZiT39Y83mlUy17vCq/Zhv2XjW+svtFFNQsOkRKlczfcLWgrutnUd
         YnPUJ/S6wH3aLb86jMwfNHMBy9HMW4Yg1A44TBXppcJKgt6xB/Sf719nP4+srR2eC0
         Tx4lRKqwTKO+NrN1VIDnaLTPNBqGqVS6fvKovfWQ=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mthca: work around -Wenum-conversion warning
Date:   Mon, 26 Oct 2020 22:12:30 +0100
Message-Id: <20201026211311.3887003-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc points out a suspicious mixing of enum types in a function that
converts from MTHCA_OPCODE_* values to IB_WC_* values:

drivers/infiniband/hw/mthca/mthca_cq.c: In function 'mthca_poll_one':
drivers/infiniband/hw/mthca/mthca_cq.c:607:21: warning: implicit conversion from 'enum <anonymous>' to 'enum ib_wc_opcode' [-Wenum-conversion]
  607 |    entry->opcode    = MTHCA_OPCODE_INVALID;

Nothing seems to ever check for MTHCA_OPCODE_INVALID again, no
idea if this is meaningful, but it seems harmless as it deals
with an invalid input.

Add a cast to suppress the warning.

Fixes: 2a4443a69934 ("[PATCH] IB/mthca: fill in opcode field for send completions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/hw/mthca/mthca_cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index c3cfea243af8..319b8aa63f36 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -604,7 +604,7 @@ static inline int mthca_poll_one(struct mthca_dev *dev,
 			entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
 			break;
 		default:
-			entry->opcode    = MTHCA_OPCODE_INVALID;
+			entry->opcode    = (u8)MTHCA_OPCODE_INVALID;
 			break;
 		}
 	} else {
-- 
2.27.0

