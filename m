Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1768122D9A3
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jul 2020 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGYTum (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jul 2020 15:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGYTum (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jul 2020 15:50:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5101FC08C5C0;
        Sat, 25 Jul 2020 12:50:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so9458588qto.2;
        Sat, 25 Jul 2020 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e08VaL7U6vcRwt77EFzQ26KfIcvSUB32fpWd9IVs9Bs=;
        b=kt77VASDEmQbVAz4Uvdk29D1TC+84NUnd+mgBDeBIxhJSHHVN1GNaYwHzRUJnVgwYJ
         L5FlOI/L7SKhAaXsF4O1W4MJAdo28oYFcGKqYUr+rNQNphq5ls1VVvOn9mCbap4Ig0Gy
         rDgrrXFHn2Wyd1K68kMWEzpRjAGS+65G9lo87TtBYE6UP4JjwJzl4yqG4JJfRroRSLLl
         WYEf+9YwxqVa6hUzNhIkZzHsM4efa2a4x9qYTfdChHwKUF1IDIzYY+Bc2ee2nIIQFeA+
         KeE2C3Pf4APGBDVnJhPQ4CICyYxIGAvcpDMU4gxqHclzRWoUiVzkk6yiIPsIa2V0ETiG
         uSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e08VaL7U6vcRwt77EFzQ26KfIcvSUB32fpWd9IVs9Bs=;
        b=Y4ww0omLJvOj55Uz7ascDlGdUa1agLei3pnxJvJBGCwatvhJmCkByWixoKh62AGFdb
         QRehinTvfYkU/Fmv+DzyNIei02Q8xQbQkYWpwhZ58GZ0NkPV6ZPTjtEBHImrTInOeQJM
         VDt57DfiKJ2x4cERlds7P2bNwhmeKO5qp3PCgyJiZV7Gl0I+idj+wBG8XwLTslf5gP5v
         /2SiT+HAd+ehchHFgs/C5cPZZnMsq4qCMa6DEOabl2VI4SojAh28K4nzd/w80rYKYOIO
         dabSPDPAgmaXTgx/6JNIXR9MDcMeqMhKNi4O2JXVF99quMYpxpPx2kOocG8Nf5FisYqm
         uj9w==
X-Gm-Message-State: AOAM533MgznChcmuzKTHj0AAmXEqMqYkmn3f44VHIvvXePEUrtne0Py/
        LZAVpgQPauau2/5ke4/q/IKU5UtaHw==
X-Google-Smtp-Source: ABdhPJy2dOu0lT+ZNEf0I8fySl5RLPKWHC67dEp991MzbpceBkId+9TlOp8LdSJkMc9uH8ZrYznGdA==
X-Received: by 2002:ac8:44b9:: with SMTP id a25mr11234149qto.356.1595706640781;
        Sat, 25 Jul 2020 12:50:40 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id h144sm12680373qke.83.2020.07.25.12.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 12:50:40 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] infiniband: Fix uninit-value in ucma_connect()
Date:   Sat, 25 Jul 2020 15:48:39 -0400
Message-Id: <20200725194839.623653-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ucma_connect() is reading uninitialized memory when `in_len` is less than
`offsetof(struct rdma_ucm_connect, ece)`. Fix it.

Reported-and-tested-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=2c85ca2b1aedb22ed1029383751e36cee3f7d047
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/infiniband/core/ucma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 5b87eee8ccc8..a591fdccdce0 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1079,7 +1079,7 @@ static ssize_t ucma_connect(struct ucma_file *file, const char __user *inbuf,
 {
 	struct rdma_conn_param conn_param;
 	struct rdma_ucm_ece ece = {};
-	struct rdma_ucm_connect cmd;
+	struct rdma_ucm_connect cmd = {};
 	struct ucma_context *ctx;
 	size_t in_size;
 	int ret;
-- 
2.25.1

