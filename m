Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C066762528D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 05:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiKKEbA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Nov 2022 23:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKKEa7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Nov 2022 23:30:59 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82F68AE6;
        Thu, 10 Nov 2022 20:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1668141053; i=@fujitsu.com;
        bh=t3W7ccYeAWOB7TN9rQwLcUW5c4OzST5kRuF91e5+TEI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=w+eLUlGxhp3aQOon3jqrxU1B0Pvb0BSHUPchD8TxSSUUF0t6GUk6cyBM47nhJkanb
         SFoBFZIA8AZrwRWNUtzLBZygLjyzTkiN32FpF84hzFUXZd/uB9IFbPJ7Yg3N0AiIhN
         +ul9fkq7sBLYigtcBT3FZbK5BxI7VFBcQ2CIxPBFZ8KNsmA9umBOab6jg1bUqZaz8J
         ALf8R4vGeUAjL4AzoC+q2baJ6nDkWqoNu9CNCh6i8RWw5MqoeWCnEptrCC2XVxz/C1
         HhA6bqXFF57/z66htCiJ/FFeb0ED5vhVG4Xc5/Yjf5xitZ9l0EaJlM6KmGvP5TD1CN
         wVZqSPxcX0kWQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRWlGSWpSXmKPExsViZ8MxSffP+dx
  kg+tP1S1mzjjBaDHl11Jmi8u75rBZPDvUy2Jx/lg/uwOrx85Zd9k9Nq3qZPP4vEnOY+vn2ywB
  LFGsmXlJ+RUJrBlrW34wFfQJVPy8UtrAeJuni5GLQ0hgC6PE/YbjLBDOciaJ419ms0I4Bxgll
  jx5y97FyMnBJqAhca/lJiOILSLQySixrTUNxGYWcJPY9GY2WI2wQLTE+euzWUBsFgFViROnX7
  OB2LwCjhJ3G3Yxg9gSAgoSUx6+B7M5BZwklt/5AlYjBFRzauYdFoh6QYmTM5+wQMyXkDj44gV
  QPQdQr5LEzO54iDEVErNmtTFB2GoSV89tYp7AKDgLSfcsJN0LGJlWMZoVpxaVpRbpGlroJRVl
  pmeU5CZm5uglVukm6qWW6panFpfoGukllhfrpRYX6xVX5ibnpOjlpZZsYgSGf0qx+skdjBuW/
  dE7xCjJwaQkyrvPJjdZiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSv3lmgnGBRanpqRVpmDjAWYd
  ISHDxKIrzC24HSvMUFibnFmekQqVOMilLivFbACBYSAElklObBtcHi/xKjrJQwLyMDA4MQT0F
  qUW5mCar8K0ZxDkYlYd64c0BTeDLzSuCmvwJazAS02C41C2RxSSJCSqqBySVfN4OXib/7kLwc
  cxvDPO8DwmyfX/84dmp6Zlx88bmFi3feFlj3Lqvv7u/7+yw7ksw7P+aVnHacsuyzz7tZfT0Sz
  e/Pc+yWi3zy+dCfg39Oaev5fQp+c0m3SeG8vM/i1Pw1/84qhZt5Tyn0LX5jGi5rU7zfm+1Fhk
  nw3YXt4pP5XF5dWpf0ouvxMxO/NWYzC3J/PKvLcFP+52DXevLLtJkLv64/uyjTNGjzS97+G2/
  ktScuFrp3LENCddnTgLM5uzl/dE1hOTizs+cQr+r8lTOqbupcCp8oPmP5Oq0gjjU/NrlsF8lJ
  1l5+/8F7i1vn2S4Wp7IKXHTOMP96W3w/z+xHb39yZc5beaXni4lTzEUlluKMREMt5qLiRAA2f
  es1egMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-20.tower-548.messagelabs.com!1668141052!16817!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9145 invoked from network); 11 Nov 2022 04:30:52 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-20.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 11 Nov 2022 04:30:52 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 56B2C1000D5;
        Fri, 11 Nov 2022 04:30:52 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 49A7A1000C1;
        Fri, 11 Nov 2022 04:30:52 +0000 (GMT)
Received: from bc0da1a9c27e.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 11 Nov 2022 04:30:49 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH 2/5] RDMA/rxe: use iova_to_vaddr to transform iova for rxe_mr_copy
Date:   Fri, 11 Nov 2022 04:30:27 +0000
Message-ID: <1668141030-2-3-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1668141030-2-1-git-send-email-lizhijian@fujitsu.com>
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

Make the code more friendly and readable by using iova_to_vaddr()

This commit also remove the err1 label in rxe_mr_copy().

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 46 +++++++++---------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index f6366a635b92..cf3ce8d293b3 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -289,13 +289,6 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
 int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 		enum rxe_mr_copy_dir dir)
 {
-	int			err;
-	int			bytes;
-	u8			*va;
-	struct rxe_map		**map;
-	struct rxe_phys_buf	*buf;
-	int			m;
-	int			i;
 	size_t			offset;
 
 	if (length == 0)
@@ -315,49 +308,36 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
 
 	WARN_ON_ONCE(!mr->map);
 
-	err = mr_check_range(mr, iova, length);
-	if (err) {
-		err = -EFAULT;
-		goto err1;
-	}
-
-	lookup_iova(mr, iova, &m, &i, &offset);
-
-	map = mr->map + m;
-	buf	= map[0]->buf + i;
+	if (mr_check_range(mr, iova, length))
+		return -EFAULT;
 
+	offset = (iova - mr->ibmr.iova + mr->offset) & mr->page_mask;
 	while (length > 0) {
-		u8 *src, *dest;
-
-		va	= (u8 *)(uintptr_t)buf->addr + offset;
-		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
-		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
+		u8 *src, *dest, *va;
+		int bytes;
 
 		bytes	= mr->ibmr.page_size - offset;
 
 		if (bytes > length)
 			bytes = length;
 
+		va = iova_to_vaddr(mr, iova, bytes);
+		if (!va)
+			return -EFAULT;
+
+		src = (dir == RXE_TO_MR_OBJ) ? addr : va;
+		dest = (dir == RXE_TO_MR_OBJ) ? va : addr;
+
 		memcpy(dest, src, bytes);
 
 		length	-= bytes;
 		addr	+= bytes;
+		iova += bytes;
 
 		offset	= 0;
-		buf++;
-		i++;
-
-		if (i == RXE_BUF_PER_MAP) {
-			i = 0;
-			map++;
-			buf = map[0]->buf;
-		}
 	}
 
 	return 0;
-
-err1:
-	return err;
 }
 
 /* copy data in or out of a wqe, i.e. sg list
-- 
2.31.1

