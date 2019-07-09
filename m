Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9401163E3C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 01:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfGIXGR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jul 2019 19:06:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54800 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jul 2019 19:06:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so394698wme.4;
        Tue, 09 Jul 2019 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91fUQHii/1a1YDS2AGu/3oAuTobJa0WG8gMeTg5poT8=;
        b=vZi9H8tH8nR9vvCDEekIlj/01cwlJ0kraz+7vy+ML1+9tmYud/qEx35ME368EoEAjb
         5f5QtfSTXSHYJZ+4YFlIFldVjcs7oSKLsn9yhzKdPYHlbdfs+SDR4RW3a3q8Dc866Lht
         lzd3DQ9rH8zj4iLb78mmCS9jYLvBCMnaU9NOBmbtXH7MOt3HDJR87N9JI19MSnmG7fYk
         avhjmgymtnaueG+he/kscSzUsKvgSubX4Pw9OGq2uI4PGrC2hQGGyGDXViJFSUUcIirZ
         /vD7OD3pTzeSRlAKQorB6KoBX2aHTmBuS208J9OUPWt0EBejTBlnUG/2GwSOJiY52SdR
         RHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91fUQHii/1a1YDS2AGu/3oAuTobJa0WG8gMeTg5poT8=;
        b=mo/TgIVePIz7UMABTSPB5JFAFPJGY8UKmhDZPsmX5Fs+nC2F1BTLFWbS+RNkP7cwpi
         s34Oet2dB99BIfzsOsAukOQRLHOL3yE8z+NeKqZzhe9LkbPu8ZzK0qqyoI1GGsHvKBik
         ULleXCZETdL5KpJ+3CALxXwOCxj37SH1tYC1dCT9SL96Om6NdwlSXTuWcvN9HIiutNvx
         jBT/RmoOJ716S6NYxl/ywT8j9q+m5hzS3HLrlFPaosBu/cB2E16i8NcujcugwO3HwHk5
         qJFvZYGgWi5Q3JtnUN/X7U7Y2LVGLU5oQjnwI5/bMukD3/YETQRu7qdRK6jQteAKosim
         Byfg==
X-Gm-Message-State: APjAAAXZvnPZ88vuN4TCiSFTCyp81u8YtjNQuJ1dChXsXg0FBQGKTkIf
        voBG59HTVGk3a+ZlLLFyyNE=
X-Google-Smtp-Source: APXvYqzaIhdE758hZ2TcqMB8pD8H7OLoUuHWVpS23UvCFQ1IxVHbOs6dDuJgpv4ItB+QO6TB4ouQ4g==
X-Received: by 2002:a1c:3:: with SMTP id 3mr1750202wma.6.1562713574894;
        Tue, 09 Jul 2019 16:06:14 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id s18sm518142wra.47.2019.07.09.16.06.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 16:06:14 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in rvt_create_cq
Date:   Tue,  9 Jul 2019 16:05:53 -0700
Message-Id: <20190709230552.61842-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190709221312.7089-1-natechancellor@gmail.com>
References: <20190709221312.7089-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

clang warns:

drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
                if (err)
                    ^~~
drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
here
        return err;
               ^~~
drivers/infiniband/sw/rdmavt/cq.c:260:3: note: remove the 'if' if its
condition is always false
                if (err)
                ^~~~~~~~
drivers/infiniband/sw/rdmavt/cq.c:253:7: warning: variable 'err' is used
uninitialized whenever 'if' condition is true
[-Wsometimes-uninitialized]
                if (!cq->ip) {
                    ^~~~~~~
drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
here
        return err;
               ^~~
drivers/infiniband/sw/rdmavt/cq.c:253:3: note: remove the 'if' if its
condition is always false
                if (!cq->ip) {
                ^~~~~~~~~~~~~~
drivers/infiniband/sw/rdmavt/cq.c:211:9: note: initialize the variable
'err' to silence this warning
        int err;
               ^
                = 0
2 warnings generated.

The function scoped err variable is uninitialized when the flow jumps
into the if statement. The if scoped err variable shadows the function
scoped err variable, preventing the err assignments within the if
statement to be reflected at the function level, which will cause
uninitialized use when the goto statements are taken.

Just remove the if scoped err declaration so that there is only one
copy of the err variable for this function.

Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
Link: https://github.com/ClangBuiltLinux/linux/issues/594
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Updated the wording of the commit message to use proper terms like
  scoping and shadowing, thanks to review from Nick (let me know if the
  wording isn't up to snuff).

 drivers/infiniband/sw/rdmavt/cq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index fac87b13329d..a85571a4cf57 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -247,8 +247,6 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	 * See rvt_mmap() for details.
 	 */
 	if (udata && udata->outlen >= sizeof(__u64)) {
-		int err;
-
 		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
 		if (!cq->ip) {
 			err = -ENOMEM;
-- 
2.22.0

