Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989771E5E9
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEOALK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:11:10 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38320 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfEOALK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:11:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so1281160qth.5
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvRrtRnP6kxjeCT7/zaUsi42Wm0dzFMHEoCnAof5sGY=;
        b=nZnW062rLnnIhNTpKjoN6HVnjIVZAn5izPgivdCP/jgOWG/zXThxK87ZdxXJMx8vsI
         ZL5BmP7ho43rTy5L5Uy2cxO4TfP7wOEecB5jeYlOM+8Wz8m1+W8BGQctcInAtWeeyJ7S
         BXJFiA321rUEqzLsCay0ByP1ZNWLHbXgQX/CU7gSbmh8NmYZeJpmILw4ZdmyQ82lHDf2
         mDneARE4tViXlqkDTDioigjZWpjr3vYQVKk0IJ3B2lK6l3ZKxWew7PAMK9BPgh6FBHQv
         yagQHOUgU+PWVgJt8GGRCcbKkAiukkxRXaeaWZjtU6mFDVsqRv+QUmSMKit1IzV3LNxg
         nNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvRrtRnP6kxjeCT7/zaUsi42Wm0dzFMHEoCnAof5sGY=;
        b=L6xriCyJilQuQbwI/SgovxYqa8KEDc0EEzQyqVA7PtCd5S+70CQ+WHjVlp8Lm7mgxY
         et30+4pRQqVtNKMgmVBkkj+CSMWqMfpykYVRvM05N+ufkLxS7VQxVNapMIrjyk4NIL74
         YEDDc20jjip/ikBS+75ZlD8SrWZUq6lO59gt/ZBPWnkPT5aGEKvpRHvLkuO9TmOrZbv8
         I12OnSIZlieNwfg3bzO5tajgBtCU7UwB6utxrmAgNBzmcXWu6OOKMDla/oA/npPgExcp
         VT206S91cyPP4HV2TgWp1FDB0qLuXzZE1BfncVSFs3Dxurbbf5usq2U9lEpVI/D+LOru
         3aow==
X-Gm-Message-State: APjAAAWuVVsplcID1aqNfUeaj8Ps3ZP97ZlhwIwA7aJm/Ol+GYU9Wg1X
        yQmwF2qs3JOKV2I+Y6yjhrrSZyfI2zw=
X-Google-Smtp-Source: APXvYqxoJS+VfGceeeSHULxRWLp358TMi4qlcZ0wGFmwy+CDge26baLLeUT1ijFiYQa1e8MWOGEOqw==
X-Received: by 2002:a0c:ba99:: with SMTP id x25mr31734561qvf.212.1557879069188;
        Tue, 14 May 2019 17:11:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t129sm135297qkc.24.2019.05.14.17.11.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:11:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001Mj-LU; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 01/20] ibdiags: Add SWITCH_FALLTHROUGH
Date:   Tue, 14 May 2019 20:49:17 -0300
Message-Id: <20190514234936.5175-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Mark this case as deliberate fall through

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/src/ibportstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ibdiags/src/ibportstate.c b/ibdiags/src/ibportstate.c
index cfe30655e67fd5..60afcb45a3ee07 100644
--- a/ibdiags/src/ibportstate.c
+++ b/ibdiags/src/ibportstate.c
@@ -48,6 +48,8 @@
 
 #include "ibdiag_common.h"
 
+#include <util/compiler.h>
+
 enum port_ops {
 	QUERY,
 	ENABLE,
@@ -578,6 +580,7 @@ int main(int argc, char **argv)
 				printf("Port is already in enable state\n");
 				goto close_port;
 			}
+			SWITCH_FALLTHROUGH;
 		case ENABLE:
 		case RESET:
 			/* Polling */
-- 
2.21.0

