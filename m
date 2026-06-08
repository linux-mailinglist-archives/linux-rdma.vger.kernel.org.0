Return-Path: <linux-rdma+bounces-21952-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hLHIG5SgJmp6aAIAu9opvQ
	(envelope-from <linux-rdma+bounces-21952-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 12:59:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D46556AE
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 12:59:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21952-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21952-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 989BF33D73FA
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C380D3BC69C;
	Mon,  8 Jun 2026 10:30:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3C3BB12F;
	Mon,  8 Jun 2026 10:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914614; cv=none; b=fjG3cT71wTOpOFsZ0ONNY+McHGTypA3jrS2d2Ec5lZ6t5aAVBPL9IxVpgPJWgpwh1Zmluq5XrywRQMkcB0wCJ+qP5HH2ewUD502uzkIiSPU5BDwZmooajS9W5bw/8ueDzAbeMVX3Y3qfwwWFXvnl4ySgsseNZwq7eTM0FYpr68c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914614; c=relaxed/simple;
	bh=44CzTcwldjEHT7AlGFPeHrLvDMTApNCyxxJ4uoYC2P4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TppHhqrgqJhpuLVdq2pu0PWZOyztAUPxtep+GkblYUQ2Qs6TGSE+8J4SmQsIkXFm1tQxj40r2+Ytz5fuYLITXvOvbPWSrXW3N+4+6f+WJIy2ytOHtx/dZW+ncsWVMyGz5su50EVXk3sRm8gyYYlBw/1ll+mCyUX9dRDqe4dcPBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABnus2wmSZqcdayEg--.38019S2;
	Mon, 08 Jun 2026 18:30:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/iwpm: fix kref bypass in iwpm_register_pid() error path
Date: Mon,  8 Jun 2026 10:30:01 +0000
Message-Id: <20260608103001.142648-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnus2wmSZqcdayEg--.38019S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4Utw48Kr4DAF4kXrWxtFb_yoW8Gr47pr
	W5Ga12krn5Wa1fAa1kWF90vF1rXws7XwnrGa4DKw17JrnxX3yIy3W7Ca4UXFs7Ar1kJwnx
	WrsruF4qgF17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5uc_DU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwMA2omaa0jsQADsc
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21952-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,iscas.ac.cn:mid,iscas.ac.cn:from_mime,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA2D46556AE

iwpm_get_nlmsg_request() returns a request with kref_init() +
kref_get() (refcount=2, one for the caller and one for the
iwpm_nlmsg_req_list). On the error path, iwpm_register_pid()
calls iwpm_free_nlmsg_request() directly instead of using
kref_put(), bypassing the kref mechanism and freeing the object
while the refcount is still non-zero.

Replace the direct iwpm_free_nlmsg_request() call with
kref_put(&nlmsg_request->kref, iwpm_free_nlmsg_request).

Cc: stable@vger.kernel.org
Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/infiniband/core/iwpm_msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwpm_msg.c b/drivers/infiniband/core/iwpm_msg.c
index 4625abd29ac0..672b0c33a6de 100644
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
 
-- 
2.34.1


