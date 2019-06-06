Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 346F237C74
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfFFSou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44331 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfFFSot (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so3861354qtk.11
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDhglHPFaykanjjoF1gAri47ISjb+fimKQAKOR+h9MI=;
        b=PxwcFgRpu1yKtgG+aowdw5x+8tofPqN/iG+sZlMS+1BEgLEa2wfuOLDwkMIpgzpwcd
         07df04JSrSYFDPlOBaTxTsHwx7kBZmstHd0a4oVfpGuC/g/Bhpf3Lt5nSoYeD6uPrpsQ
         QII6+kEeEkW/MUSdxlhOd0i2T95D5HdQdwlL7Ozqf48joL6SQYTkyLT5peB4+TMiTij9
         aIRgom5VV0qkHk9b2ZOSyXv7P9Z7i69saCcXZ47LPPfmx+ZPD9nsxaz5ycev8w2P6F6R
         TEDZZY+v7m2CrZJVilSqXEyPa+l6AO++F7IzKVzBSzLlDLqpq+DAzeUJPhu5fEg2sxO9
         4usQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDhglHPFaykanjjoF1gAri47ISjb+fimKQAKOR+h9MI=;
        b=s2SHtyQkaz53/um8aMerbpTKZoY58fUAApYDehvPsIOMYcJxem/r5f87t4nLXBrmLD
         7bwNfOLQWgBaPnjYCxg2Hhpsvd+SnussJGiLbvWrEIh926PFpBQWdkLXFBkgpQ/pwVt5
         KIQZmK9hoYiMxs6HjnTqHVc1WPMZ6XMAOy16RuG5abWLNVrpXtS225BJc+33cOA+6Wqx
         lGdSQJXzEpFFKBnan1m78Q3TgL8iu0VuFyemzKivhdau6xD3A9a26KTUP797kLuBXRp4
         z1KBjgIf4FdznCMhdOBhQVPNB8VwqdmW1YWR7sDUKVALtvgVn79pJLDCi62vXO0QpkY2
         ezvw==
X-Gm-Message-State: APjAAAWgDg0dQka4wBcZfXc2+YyaHzTwrzD5ZzmS4qecNuk+jxyaWwpC
        E1LgKw/aiCpfrlEvTWEzVez4c/xmaGKx2w==
X-Google-Smtp-Source: APXvYqyc+KhO/w9mb/yqATHQoXsEv3qzyCLAVUEuPTK/WR5bBDKxmiMb1le/dUnjSV/gm3c3d4B8Pg==
X-Received: by 2002:ac8:f0a:: with SMTP id e10mr39961260qtk.325.1559846689071;
        Thu, 06 Jun 2019 11:44:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w34sm1260252qth.81.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008If-OA; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 07/11] mm/hmm: Use lockdep instead of comments
Date:   Thu,  6 Jun 2019 15:44:34 -0300
Message-Id: <20190606184438.31646-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

So we can check locking at runtime.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
v2
- Fix missing & in lockdeps (Jason)
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index f67ba32983d9f1..c702cd72651b53 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -254,11 +254,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  *
  * To start mirroring a process address space, the device driver must register
  * an HMM mirror struct.
- *
- * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
+
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
 		return -EINVAL;
-- 
2.21.0

