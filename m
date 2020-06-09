Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2771F363E
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2020 10:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgFIIlP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Jun 2020 04:41:15 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:35246 "EHLO
        mail-m971.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgFIIlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Jun 2020 04:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BNhmRuSCkW+4oswIR2
        IkTvF4T2FFDKrw3MSrNCdlxZs=; b=eBbibN2N0j6pkfvQeNqpVvWONEZKTM00+K
        YU9uuI8TV5Ne27Ut65NFO1YXusomrSijHKeCJJ84mrYSGpwVqFmDmJ0PM6XriPmO
        ZBU7VF6N18H4qkGIfgG0B3i/Nvl2i+v83B7UeBDQJEV8x9OsvX7PPpjxXV3k/cZh
        sHyL/qDU4=
Received: from ubuntu.localdomain (unknown [123.8.233.176])
        by smtp1 (Coremail) with SMTP id GdxpCgA3svUbS99evuGdCA--.8544S3;
        Tue, 09 Jun 2020 16:41:03 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Xidong Wang <wangxidong_97@163.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] RDMA/core: Don't copy uninitialized stack memory to userspace
Date:   Tue,  9 Jun 2020 01:40:57 -0700
Message-Id: <1591692057-46380-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: GdxpCgA3svUbS99evuGdCA--.8544S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3GFWUGFWfXw47AF13Jwb_yoWfWrb_ur
        nYq3WxWr1UCFn2kry3CF4fXrZIqw45uw1fWan3tw15A345J3Zxu3s2qFn5uw45ur42kF98
        Ar9xt34kWrs0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUKsj5UUUUU==
X-Originating-IP: [123.8.233.176]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/xtbBFR8+81Xlk8TEOQAAsd
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: xidongwang <wangxidong_97@163.com>

ib_uverbs_create_ah() may copy stack allocated
structs to userspace without initializing all members of these
structs. Clear out this memory to prevent information leaks.

Signed-off-by: xidongwang <wangxidong_97@163.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b48b3f6..04861e6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2481,6 +2481,7 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	uobj->user_handle = cmd.user_handle;
 	uobj->object = ah;
 
+	memset(&resp, 0, sizeof(resp));
 	resp.ah_handle = uobj->id;
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
-- 
2.7.4

