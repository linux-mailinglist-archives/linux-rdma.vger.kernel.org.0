Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E82482300
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Dec 2021 10:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhLaJdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Dec 2021 04:33:38 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:32986 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229475AbhLaJdi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Dec 2021 04:33:38 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowADXuBVczs5hKnZdBQ--.33612S2;
        Fri, 31 Dec 2021 17:33:16 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] RDMA/uverbs: Check for null return of kmalloc_array
Date:   Fri, 31 Dec 2021 17:33:15 +0800
Message-Id: <20211231093315.1917667-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADXuBVczs5hKnZdBQ--.33612S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF1fZF4DGr15Wr15Cw45Jrb_yoWkJFX_CF
        1kXrWDJw4DCF1kKwn7uw1fG34I9F4YvFnYq3Zavw13Gry7JFyfZw1xZ39xZrWxWFWUCFWD
        Gr47W3ykuw1DGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjItC5UUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Because of the possible failure of the allocation, data might be NULL
pointer and will cause the dereference of the NULL pointer later.
Therefore, it might be better to check it and return -ENOMEM.

Fixes: 6884c6c4bd09 ("RDMA/verbs: Store the write/write_ex uapi entry points in the uverbs_api")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/infiniband/core/uverbs_uapi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/core/uverbs_uapi.c
index 62f5bcb712cf..1e71925613cc 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -447,6 +447,9 @@ static int uapi_finalize(struct uverbs_api *uapi)
 	uapi->num_write_ex = max_write_ex + 1;
 	data = kmalloc_array(uapi->num_write + uapi->num_write_ex,
 			     sizeof(*uapi->write_methods), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	for (i = 0; i != uapi->num_write + uapi->num_write_ex; i++)
 		data[i] = &uapi->notsupp_method;
 	uapi->write_methods = data;
-- 
2.25.1

