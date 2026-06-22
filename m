Return-Path: <linux-rdma+bounces-22420-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IAt8DZ48OWoepAcAu9opvQ
	(envelope-from <linux-rdma+bounces-22420-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 15:46:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 959776AFFAF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 15:46:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22420-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22420-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1A78300A108
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2026 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B347B3ACA77;
	Mon, 22 Jun 2026 13:46:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C022D7B5;
	Mon, 22 Jun 2026 13:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135963; cv=none; b=OwbMw3ejHijcJjuYZKJnIg+BlpSLhU4nFTqmL30evyJPL/4K/Y2BL3PVb5jnA0lUhPCm9fFKSEs7GRUoJ/pkx+NgRA+AY0SR4/Y84DHayANI0LRMhhGRT6KoFBM3Zx1NpipoBfvqvZkzwif+/dEKkl2s4Z3iXMviKxTwxkYUyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135963; c=relaxed/simple;
	bh=a/2YOkObeQGf7kdEKWIe5J44FDhZm5hBH01a0gkw6qE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QMmTYVwTNmqo9pmcWdrM97TPZmgt5LCyw42XugSYObmc1Ow1qAR4TZs9xaXLNCnS3mdod/kUCzIHSpVY14a+n80cPqDIcfXTD8a75unJF9Ta0oPna98rFIZI3bFvkW/Od4BKp3TdzzjC1dtOckNVKCYKdJdzQzXT+9ZeMare5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.74.238])
	by APP-01 (Coremail) with SMTP id qwCowADXfdaTPDlqFpC_Ag--.43180S2;
	Mon, 22 Jun 2026 21:45:57 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Kees Cook <kees@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] IB/iwpm: fix memory leaks in error paths
Date: Mon, 22 Jun 2026 21:45:53 +0800
Message-Id: <20260622134553.43186-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADXfdaTPDlqFpC_Ag--.43180S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykuFWUKw17XF1kWw4UJwb_yoW8Aw1kpr
	45Ja129r45Ww4fA3WUuFyYqFySqa97JasrGFyUKwnrZrn8Jw4Iv3W2k3WUXF45Ar1kKFsx
	Grs29F4qgFnFgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgsGA2o5IaJNOAAAst
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:fw@strlen.de,m:kees@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22420-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 959776AFFAF

In iwpm_register_pid(),iwpm_add_mapping() and
iwpm_add_and_query_mapping(), when the send operations fail,
the allocated message buffers are not freed before returning,
causing memory leaks.

Fix this by adding proper error handling with goto labels to
ensure kfree() is called on all error paths in both functions.
Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/infiniband/core/iwpm_msg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 4625abd29ac0..bac3d1f321ab 100644
--- a/drivers/infiniband/core/iwpm_msg.c
+++ b/drivers/infiniband/core/iwpm_msg.c
@@ -122,7 +122,7 @@ int iwpm_register_pid(struct iwpm_dev_data *pm_msg, u8 nl_client)
 	pr_info("%s: %s (client = %u)\n", __func__, err_str, nl_client);
 	dev_kfree_skb(skb);
 	if (nlmsg_request)
-		iwpm_free_nlmsg_request(&nlmsg_request->kref);
+		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
 	return ret;
 }
 
@@ -207,7 +207,7 @@ int iwpm_add_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 add_mapping_error_nowarn:
 	dev_kfree_skb(skb);
 	if (nlmsg_request)
-		iwpm_free_nlmsg_request(&nlmsg_request->kref);
+		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
 	return ret;
 }
 
@@ -296,7 +296,7 @@ int iwpm_add_and_query_mapping(struct iwpm_sa_data *pm_msg, u8 nl_client)
 query_mapping_error_nowarn:
 	dev_kfree_skb(skb);
 	if (nlmsg_request)
-		iwpm_free_nlmsg_request(&nlmsg_request->kref);
+		kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request);
 	return ret;
 }
 
-- 
2.39.5 (Apple Git-154)


