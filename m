Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2936AA3C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 03:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhDZBRm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 21:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhDZBRm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Apr 2021 21:17:42 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55DC3C061574;
        Sun, 25 Apr 2021 18:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=0v+gGlsgWk
        GhWcbNz7Yh3dkRK5Cr6bLU3TvKFSb3Zos=; b=cvrsm4zkzGodFZ3GKYypDQn1sx
        vOM0x51y00nyfJGPKBhLMera54z5oyOJAtPEeAIzkd2YziJeJD+4IFIsvuwRwFDb
        psZBbd9RGwcvayagqfQSYhytR5HWiFoV+DsrkX98ppfyqxROSIYvGzwKfs6EMuDZ
        c6uDS6ASScHjDcxLY=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygD3_T2HFIZgEEZGAA--.90S4;
        Mon, 26 Apr 2021 09:16:55 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH v2] rdma/siw: Fix a use after free in siw_alloc_mr
Date:   Sun, 25 Apr 2021 18:16:47 -0700
Message-Id: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygD3_T2HFIZgEEZGAA--.90S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7Cw18Zr4kJrWfJw18Zrb_yoW8Xr1kpF
        48Gw4akrWDXa1Duw48AFWDWFWftw4kW3Wqg3sxKay5Zrn8Gr40gr1kGry7W3Z5AFyDGana
        qwn0yr4qkF1rGr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
        0VAGYxC7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUmNtcUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Our code analyzer reported a uaf.

In siw_alloc_mr, it calls siw_mr_add_mem(mr,..). In the implementation
of siw_mr_add_mem(), mem is assigned to mr->mem and then mem is freed
via kfree(mem) if xa_alloc_cyclic() failed. Here, mr->mem still point
to a freed object. After, the execution continue up to the err_out branch
of siw_alloc_mr, and the freed mr->mem is used in siw_mr_drop_mem(mr).

My patch moves "mr->mem = mem" behind the if (xa_alloc_cyclic(..)<0) {}
section, to avoid the uaf.

Fixes: 2251334dcac9e ("rdma/siw: application buffer management")
Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 drivers/infiniband/sw/siw/siw_mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 34a910cf0edb..96b38cfbb513 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -106,8 +106,6 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 	mem->perms = rights & IWARP_ACCESS_MASK;
 	kref_init(&mem->ref);
 
-	mr->mem = mem;
-
 	get_random_bytes(&next, 4);
 	next &= 0x00ffffff;
 
@@ -116,6 +114,8 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
 		kfree(mem);
 		return -ENOMEM;
 	}
+
+	mr->mem = mem;
 	/* Set the STag index part */
 	mem->stag = id << 8;
 	mr->base_mr.lkey = mr->base_mr.rkey = mem->stag;
-- 
2.25.1


