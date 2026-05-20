Return-Path: <linux-rdma+bounces-21051-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJVrIi2RDWpyzgUAu9opvQ
	(envelope-from <linux-rdma+bounces-21051-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:47:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25458BEC2
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 12:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5637030234CE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD03D9696;
	Wed, 20 May 2026 10:46:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238333D9DAD;
	Wed, 20 May 2026 10:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273977; cv=none; b=rC2Rn9+lVQEggFnhZzOmTLEkHa/kf3GEO/1jXi0MIES2AIptqu2c75vP8hg0cl1KTH3PB2IWG0H2/67HV7n4TJsnHtHsnJW4XLEbhU5zlOZs5dccIdE095GUccfmiikvRwZCeCAHXneYyWmPmve+YdBLsqhMGpigHP0qFzefU0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273977; c=relaxed/simple;
	bh=GnS7+ybU8IsX2qBj8VC1AYX9aEm3OqeiV8nTh415sA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUE9WYPfneGLHS8iMY8FJWjKNzAT4zSAFRrTJfg+GmNFnUdR+KjSu+4F5VCR5aswt/gXIRr1PqyXqU5115czKMYJqhAmgIUp3Se/pfuM3OqULfHCiaFXtgAHxvkEWYTwlaFz9jdmM6SYdWvvjOH9B7+KnDMYdsYyq4tJNLOWUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1aee89d8543911f1aa26b74ffac11d73-20260520
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:65123272-6898-43e0-91e7-1c9540db6110,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:65123272-6898-43e0-91e7-1c9540db6110,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:84131f3ad58c7070bbe2418b98cbd924,BulkI
	D:260520184608WV6TKS8E,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1aee89d8543911f1aa26b74ffac11d73-20260520
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(183.242.174.23)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 119115093; Wed, 20 May 2026 18:46:06 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next 1/2] RDMA/counter: Fix num_counters leak on bind_qp failure in alloc_and_bind()
Date: Wed, 20 May 2026 18:45:45 +0800
Message-ID: <20260520104546.1776253-2-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520104546.1776253-1-cuitao@kylinos.cn>
References: <20260520104546.1776253-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kylinos.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cuitao@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21051-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 2F25458BEC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When __rdma_counter_bind_qp() fails in alloc_and_bind(), the error path
jumps to err_mode which frees the counter without decrementing
port_counter->num_counters. The only place that decrements is
rdma_counter_free(), which is unreachable since the counter was never
successfully bound.

This leak accumulates across repeated failures, permanently preventing
the port from switching to AUTO mode (-EBUSY in __counter_set_mode())
and blocking the MANUAL→NONE auto-revert in rdma_counter_free(). When
the mode was NONE before the call, the MANUAL mode set by
__counter_set_mode() also leaks since the revert logic is never
reached.

Add an err_bind label between the num_counters increment and the
existing err_mode label. It decrements num_counters and mirrors the
MANUAL→NONE revert from rdma_counter_free(), ensuring the port state
is fully restored on bind failure.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/counters.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index c3aa6d7fc66b..5ddd607d5fbe 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -198,12 +198,20 @@ static struct rdma_counter *alloc_and_bind(struct ib_device *dev, u32 port,
 
 	ret = __rdma_counter_bind_qp(counter, qp, port);
 	if (ret)
-		goto err_mode;
+		goto err_bind;
 
 	rdma_restrack_parent_name(&counter->res, &qp->res);
 	rdma_restrack_add(&counter->res);
 	return counter;
 
+err_bind:
+	mutex_lock(&port_counter->lock);
+	port_counter->num_counters--;
+	if (!port_counter->num_counters &&
+	    port_counter->mode.mode == RDMA_COUNTER_MODE_MANUAL)
+		__counter_set_mode(port_counter, RDMA_COUNTER_MODE_NONE, 0,
+				   false);
+	mutex_unlock(&port_counter->lock);
 err_mode:
 	rdma_free_hw_stats_struct(counter->stats);
 err_stats:
-- 
2.43.0


