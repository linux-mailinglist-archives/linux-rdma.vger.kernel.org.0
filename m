Return-Path: <linux-rdma+bounces-15111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B04CD259B
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A88D30053D5
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Dec 2025 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A82EAB71;
	Sat, 20 Dec 2025 02:11:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F22E0926
	for <linux-rdma@vger.kernel.org>; Sat, 20 Dec 2025 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766196699; cv=none; b=qH977UID15aaF8q4IQQ353qpJ4MiSeeQCBHDjOzSspE/luZqZDQx1oClBpUaQtCUDaiDpoD2ZLdvYgPa993OlXjdJq+e3VItD6C2cLDhivbWdrNapgEPjudQTYX/QhgL61dvaRrST2JyWunjYgYwU/OXLues1isu1EDfAHR8lo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766196699; c=relaxed/simple;
	bh=TDHTZgVlW1GSIin1tanUkWYuVfOrl0J2iiC9+QKJzi0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jSK4bqK+UmFFHEhnnkRRp0pTzDdgCeGr/FcZipUmUPnC3y469zGYKorLQ+kmuvAXjtbZUlssKqJ1Q1S8d/i7P/VJVllyI6ms1y7R+KZj+x4QdihNV6MjXwUzz3iQc9WrsHPo3O72TW/4CJMVtd1c/pE1XSfXFRnI+GNGvfd+VYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5BK2BYNB061454;
	Sat, 20 Dec 2025 11:11:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5BK2BX52061451
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Dec 2025 11:11:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <80749a85-cbe2-460c-8451-42516013f9fa@I-love.SAKURA.ne.jp>
Date: Sat, 20 Dec 2025 11:11:33 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] RDMA/core: always drop device refcount in
 ib_del_sub_device_and_put()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Mark Zhang <markzhang@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc: OFED mailing list <linux-rdma@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>, Doug Ledford <dledford@redhat.com>,
        Yuval Shaia <yshaia@marvell.com>,
        Bernard Metzler <bernard.metzler@linux.dev>
References: <30ec01df-6c32-490c-aa26-c41653f5a257@I-love.SAKURA.ne.jp>
 <8f90fba8-60b9-46e2-8990-45311c7b1540@I-love.SAKURA.ne.jp>
 <1722eff3-14c1-408b-999b-1be3e8fbfe5a@I-love.SAKURA.ne.jp>
 <9b4ce0df-1fbf-4052-9eb9-1f3d6ad6a685@I-love.SAKURA.ne.jp>
 <13f54775-7a36-48f2-b9cd-62ab9f15a82b@I-love.SAKURA.ne.jp>
 <ace1ebe4-4fdb-49f4-a3fa-bbf11e1b40ed@I-love.SAKURA.ne.jp>
 <20251216140512.GC6079@nvidia.com>
 <10caea5b-9ad1-44ce-9eaf-a0f4023f2017@I-love.SAKURA.ne.jp>
 <b4457da3-be2e-4de3-ae16-5580e1fb625c@I-love.SAKURA.ne.jp>
 <98907ad9-2f85-49ff-9baf-cff7fcbc3cbf@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <98907ad9-2f85-49ff-9baf-cff7fcbc3cbf@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav201.rs.sakura.ne.jp
X-Virus-Status: clean

Since nldev_deldev() (introduced by commit 060c642b2ab8 ("RDMA/nldev: Add
support to add/delete a sub IB device through netlink") grabs a reference
using ib_device_get_by_index() before calling ib_del_sub_device_and_put(),
we need to drop that reference before returning -EOPNOTSUPP error.

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: bca51197620a ("RDMA/core: Support IB sub device with type "SMI"")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
The reproducer syzbot finally found was not for what I was investigating,
but this is a bug which I can reproduce and test using the reproducer.

drivers/infiniband/core/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 13e8a1714bbd..1174ab7da629 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2881,8 +2881,10 @@ int ib_del_sub_device_and_put(struct ib_device *sub)
 {
 	struct ib_device *parent = sub->parent;
 
-	if (!parent)
+	if (!parent) {
+		ib_device_put(sub);
 		return -EOPNOTSUPP;
+	}
 
 	mutex_lock(&parent->subdev_lock);
 	list_del(&sub->subdev_list);
-- 
2.47.3



