Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42F027450C
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIVPNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 11:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgIVPNy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 11:13:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BEEC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 08:13:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so17485338wrs.5
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3+yuya+P/LX/yzku7z4IMsJiACj4i++IXJX3Bf2IIkE=;
        b=02MPkMue/Ow3RGgRAfuyD1ekRC0flWM+NW7AxthcuHGw94zn383EDlPtEwxUS1fUF3
         G/pehPMLKVx2cPK8n14kDNmzrVK6/CYIn3pj7ni8FRMtHRLVTxUWeqs11EH6FAHtzg5C
         tctaSGQjDQnQL6+N6nomxGrGZ1n0MDjSwuZgYqHjFD3e0zybHJwe7SCmnl5L+jIwYaXm
         D+JhzCP4Wa66KfNIeRFCYBvme78tsy3ih4iXjFFtPOqK38b21/Lq7XIdgydnlj530/7B
         WkHD9LgHOgizPT7uYJG7Pl9PtXs/Vup4ZrnwWWMVZ2fYRbxDP0Mbe4fglmlS2bGwSL/F
         qwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3+yuya+P/LX/yzku7z4IMsJiACj4i++IXJX3Bf2IIkE=;
        b=cHCqkaPYgLbnRl8eoJ8d02nCMTaAIcEyr7+sHj8iAZzRBZb3r+fQ8/3L9hyTu2R+y9
         AsX4/zODrPIeuWG4lr1zuQa2XmQnQAuehitMNzdaaCILv9TRCKq6IhWAmS093hQgAMan
         0t7J+yyXb2jBuT61Lq5/Fsv8uzBMizZHzHvaQfU+YRn3d3phKutPHvLUUjukpnWSCm2k
         6+00fHEiP1KUgkcK8oOC4fqci/m3MKjSFWl/5Ov6Ia798KMtB+xE6UyC33lgA5cjNIdD
         0JcGg6oU9wV5YGcKP+2P6UFAv2pNwM8iR196WlMcoOd/NkXzBT7LLPjljsnvTW/nAk3p
         jxww==
X-Gm-Message-State: AOAM532KS/RHOmARhmxMsQ7kRNqYsiYBVBQm+iV6iZdybwQrF6/IX+co
        Rdd3dBPq96e6evz3lKDd0zLuux1UkzSdqg==
X-Google-Smtp-Source: ABdhPJwMBKc51uq03tzDp1SuRMfDy8hN3wECXWEUpfh7D9uRDdaC+REr7coZd+dsO+W/yDEqB3sx7Q==
X-Received: by 2002:adf:e601:: with SMTP id p1mr6383682wrm.172.1600787632935;
        Tue, 22 Sep 2020 08:13:52 -0700 (PDT)
Received: from gmail.com ([5.102.224.127])
        by smtp.gmail.com with ESMTPSA id d19sm5091838wmd.0.2020.09.22.08.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:13:52 -0700 (PDT)
Date:   Tue, 22 Sep 2020 18:13:48 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: RDMA/addr: NULL dereference in process_one_req
Message-ID: <20200922151348.GA4103095@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The Oops below [1], is quite rare, and occurs after awhile when kernel
code repeatedly tries to resolve addresses. According to my analysis the
work item is executed twice, and in the second time a NULL value of
`req->callback` triggers this Oops.

After many run iterations, I did managed to reproduce this issue once
with an isolated sample kernel code I posted at this address:

    https://github.com/kernelim/ibaddr-null-deref-repro

The sample code works similarly to the client code in the rpcrdma kernel
module.

Is it possible that once a work item is executing, the netevent-based
side call to requeue it in `set_timeout`, puts it on another CPU while
it is still running?  Otherwise it is hard to explain what I'm seeing.
My sample code also attempts to inject a notifier NETEVENT_NEIGH_UPDATE
event to trigger this, but it did not increase the frequency of
reproduction.

I'm experimenting with a fix [2] but I'm not sure it would solve this
issue yet. I'm hoping for more suggestions and insight.

Thanks

[1]

[165371.631784] Workqueue: ib_addr process_one_req [ib_core]
[165371.637268] RIP: 0010:0x0
[165371.640066] Code: Bad RIP value.
[165371.643468] RSP: 0018:ffffb484cfd87e60 EFLAGS: 00010297
[165371.648870] RAX: 0000000000000000 RBX: ffff94ef2e027130 RCX: ffff94eee8271800
[165371.656196] RDX: ffff94eee8271920 RSI: ffff94ef2e027010 RDI: 00000000ffffff92
[165371.663518] RBP: ffffb484cfd87e80 R08: 00726464615f6269 R09: 8080808080808080
[165371.670839] R10: ffffb484cfd87c68 R11: fefefefefefefeff R12: ffff94ef2e027000
[165371.678162] R13: ffff94ef2e027010 R14: ffff94ef2e027130 R15: 0ffff951f2c624a0
[165371.685485] FS:  0000000000000000(0000) GS:ffff94ef40e80000(0000) knlGS:0000000000000000
[165371.693762] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[165371.699681] CR2: ffffffffffffffd6 CR3: 0000005eca20a002 CR4: 00000000007606e0
[165371.707001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[165371.714325] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[165371.721647] PKRU: 55555554
[165371.724526] Call Trace:
[165371.727170]  process_one_req+0x39/0x150 [ib_core]
[165371.732051]  process_one_work+0x20f/0x400
[165371.736242]  worker_thread+0x34/0x410
[165371.740082]  kthread+0x121/0x140
[165371.743484]  ? process_one_work+0x400/0x400
[165371.747844]  ? kthread_park+0x90/0x90
[165371.751681]  ret_from_fork+0x1f/0x40


[2]

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 3a98439bba83..6d7c325cb8e6 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -636,7 +636,8 @@ static void process_one_req(struct work_struct *_work)
                        /* requeue the work for retrying again */
                        spin_lock_bh(&lock);
                        if (!list_empty(&req->list))
-                               set_timeout(req, req->timeout);
+                               if (delayed_work_pending(&req->work))
+                                       set_timeout(req, req->timeout);
                        spin_unlock_bh(&lock);
                        return;
                }

Signed-off-by: Dan Aloni <dan@kernelim.com>

-- 
Dan Aloni
