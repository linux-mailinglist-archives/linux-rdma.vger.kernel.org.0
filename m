Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9442A58A767
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiHEHs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240211AbiHEHsy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:48:54 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083BDA1;
        Fri,  5 Aug 2022 00:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685730; i=@fujitsu.com;
        bh=AiBJl2291nXEWiXxn1/wC4wkcqyLBRlWNI6lthScviw=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=IOG5jBiimkh1iGRp78ZD5HBjTWbHYT5u+KDLdmlDZbOHvU5JUCFc1ZywavnEC6K0G
         Q4sZnS1GlpBNnBfXn+jXsQ5ZScF6z4vyeQV94S4XlK5HnOJrHz5E6J/fpomtAXmRgZ
         OHpKF2ukuyIcj/OcqpT8MoXS1W5hDRWx4IrUYgk4CPbqN6DFZB4wstYxX3cAt/AXah
         11vf45m6u58MMlovH/a4Kjucp0tfE2Kh0yvLYjDwKEdjutuNqxZQIhNav6tsU1eErN
         g4LfzGN29DZOwpWalFcqpenseTcsHvheK4oJbQLRYPh4irSpC9QPrVnBhxxTPUOIAz
         yJ4yKlX9r9znQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRWlGSWpSXmKPExsViZ8ORqJt0+k2
  Swdo7LBbTp15gtJg54wSjxZRfS5ktLu+aw2bx7FAvi8WHqUeYLb5MncZscerXKSaLv5f+sVmc
  P9bP7sDlsXPWXXaPxXteMnlsWtXJ5tHb/I7N4/KTK4wenzfJeWz9fJslgD2KNTMvKb8igTXj6
  /v4ggnsFRtvsTUwNrN1MXJxCAlsYZS423oPylnOJPHm+F1WCGc/o8SWg4/Yuxg5OdgENCTutd
  xkBEmICHQySjzqPwbWwiywmkmir+c1C0iVsICvxIGDE8FsFgEVibO9L5lAbF4BR4mGG49ZQWw
  JAQWJKQ/fM3cxcnBwCjhJHL0KViIkUCHxbf4hFohyQYmTM5+A2cwCEhIHX7wAK5cQUJKY2R0P
  MaVCYtasNiYIW03i6rlNzBMYBWch6Z6FpHsBI9MqRsukosz0jJLcxMwcXUMDA11DQ1NdY10LM
  73EKt1EvdRS3fLU4hJdQ73E8mK91OJiveLK3OScFL281JJNjMCoSilmDtvB+Kf3p94hRkkOJi
  VR3nPH3yQJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuANOgGUEyxKTU+tSMvMAUY4TFqCg0dJhPf
  0SaA0b3FBYm5xZjpE6hSjopQ4b8kpoIQASCKjNA+uDZZULjHKSgnzMjIwMAjxFKQW5WaWoMq/
  YhTnYFQS5rUCmcKTmVcCN/0V0GImoMVc/1+DLC5JREhJNTDFO1aIG2VV3V6YktOwm9HbPc/dR
  ceuoHh/5Df2qIyOSLdr/9oYfnfXr/x0d2+aiS7T16aPZQ/SLyuy1L5g7Gd8V9c+LUEhNe1Pu5
  DCRQkBy51Tbuw9e/q0fef3WwEvrf+Jp7yslBVaeOuyzPMvT9uKfixoSGh8mvRUY6pMkOL9z7M
  /aP6bYDr5q/ZM56nXDk6605orw8eb1Jri923fup0Rm3lfnsp2kgu7wRb2JijyH095yDOBgyrr
  Ln1gMXD8frcm/l/mK8G+hbIBj5a9OmF7c86BBfOUxURl+1YnOW1rkWnUuHTw3tncBbvePeHMX
  79upVFnz9Tw9fPOzJKanuGyg1e0hvNWhaq8gxprcb0SS3FGoqEWc1FxIgCWv5DYpQMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-3.tower-587.messagelabs.com!1659685729!166593!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19536 invoked from network); 5 Aug 2022 07:48:50 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:48:50 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 99C751001A0;
        Fri,  5 Aug 2022 08:48:49 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 8C81910019F;
        Fri,  5 Aug 2022 08:48:49 +0100 (BST)
Received: from 4527b00272f8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:48:44 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4 6/6] RDMA/rxe: Enable RDMA FLUSH capability for rxe device
Date:   Fri, 5 Aug 2022 07:55:33 +0000
Message-ID: <1659686133-2-2-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1659686133-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
 <1659686133-2-1-git-send-email-lizhijian@fujitsu.com>
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

Now we are ready to enable RDMA FLUSH capability for RXE.
It can support Global Visibility and Persistence placement types.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 86c7a8bf3cbb..3efb515ba735 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -51,7 +51,9 @@ enum rxe_device_param {
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_MEM_WINDOW
-					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_PLT_GLOBAL_VISIBILITY
+					| IB_DEVICE_PLT_PERSISTENT,
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
-- 
2.31.1

