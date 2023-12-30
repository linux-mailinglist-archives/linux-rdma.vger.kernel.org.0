Return-Path: <linux-rdma+bounces-507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CEC8203AD
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Dec 2023 06:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8F31F22195
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Dec 2023 05:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588B115BF;
	Sat, 30 Dec 2023 05:20:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271143D6C;
	Sat, 30 Dec 2023 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [39.174.92.167])
	by mail-app3 (Coremail) with SMTP id cC_KCgBXeNx+qI9l6wOiAQ--.22293S4;
	Sat, 30 Dec 2023 13:20:00 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jgg@ziepe.ca,
	leon@kernel.org,
	gustavoars@kernel.org,
	bvanassche@acm.org,
	markzhang@nvidia.com,
	linma@zju.edu.cn,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] RDMA/sa_query: use validate not parser in ib_nl_is_good_resolve_resp
Date: Sat, 30 Dec 2023 13:19:56 +0800
Message-Id: <20231230051956.82499-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgBXeNx+qI9l6wOiAQ--.22293S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry5KFWxAw45CrWUAr43ZFb_yoWDKFcEkr
	4vgrn2qr18CFnIkrnxtr4fuFy2gw4Yqw1fuas2qa43K34DXr9xWa4xXFZxCayUWws2kF13
	Crn5Cw48GF4IkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

The attributes array `tb` in ib_nl_is_good_resolve_resp is never used
after the parsing. Therefore use nla_validate_deprecated function here
for improvement.

Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/infiniband/core/sa_query.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8175dde60b0a..c7407a53fcda 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1047,14 +1047,13 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 
 static inline int ib_nl_is_good_resolve_resp(const struct nlmsghdr *nlh)
 {
-	struct nlattr *tb[LS_NLA_TYPE_MAX];
 	int ret;
 
 	if (nlh->nlmsg_flags & RDMA_NL_LS_F_ERR)
 		return 0;
 
-	ret = nla_parse_deprecated(tb, LS_NLA_TYPE_MAX - 1, nlmsg_data(nlh),
-				   nlmsg_len(nlh), ib_nl_policy, NULL);
+	ret = nla_validate_deprecated(nlmsg_data(nlh), nlmsg_len(nlh),
+				      LS_NLA_TYPE_MAX - 1, ib_nl_policy, NULL);
 	if (ret)
 		return 0;
 
-- 
2.17.1


