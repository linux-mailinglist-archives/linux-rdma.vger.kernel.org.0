Return-Path: <linux-rdma+bounces-20556-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEHTGDcxBGo/FAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20556-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 10:07:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2B52F54A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DED92300A644
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1BB379C5D;
	Wed, 13 May 2026 08:07:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60326FDBF
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659625; cv=none; b=FE6h7cHMvjE0Eg17Mq+ib2D21l/aC2ABSq2pIZDrzM5z168HkNtJ59bS4XOUvCASrKDwcsRVB76TTH29j2HjpqkduOPIAuBr5Zm5RBuL8hORMfs/+OhukeAXaREN56lHqwUV9lnb6P2/gxlj+78Vg62QFIAZhqr77nLlRX9x/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659625; c=relaxed/simple;
	bh=tmqTPamkIQDLmmtU2g5kNTWed0VtOG5YqK9ehsaoojA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2mVJ75RKUgpzjBsgwn5Uawt/cz7/kMRAO2GSroY9dkH/uTd078o7pcaNp+gBRT0tWt3ZVUWexd0pF+ZWmcam+v7qHaXgfbNpfUsMaJpk317W67LXtG1lq6lUzFkM+WFp4bpEe9rk3qzI+XbfpIWLV6MjkUHVTXLRgHQ5M1yQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b3ada54c4ea211f1aa26b74ffac11d73-20260513
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:b9bcf7cc-b098-431d-94df-7a2c217e88eb,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:b9bcf7cc-b098-431d-94df-7a2c217e88eb,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b2a0b949ebf2ce2628d15ea628679c2a,BulkI
	D:260513160655UJ3NIIUJ,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|850
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b3ada54c4ea211f1aa26b74ffac11d73-20260513
X-User: zhaochenguang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 898377755; Wed, 13 May 2026 16:06:53 +0800
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	Etienne AUJAMES <eaujames@ddn.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Maor Gottlieb <maorg@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] IB/cache: Check GID table references before attempting deletion
Date: Wed, 13 May 2026 16:07:07 +0800
Message-Id: <20260513080707.3929955-1-zhaochenguang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 86C2B52F54A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DMARC_NA(0.00)[kylinos.cn];
	TAGGED_FROM(0.00)[bounces-20556-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RBL_SEM_FAIL(0.00)[104.64.211.4:query timed out];
	TAGGED_RCPT(0.00)[linux-rdma];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[kylinos.cn:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaochenguang@kylinos.cn,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[kylinos.cn:query timed out];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,kylinos.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In the NFS over RDMA environment, repeatedly performing frequent
ifdown/ifup operations on the client may cause df -h to hang.
The kernel log reports an error:
  __ib_cache_gid_add: unable to add gid
  0000:0000:0000:0000:0000:ffff:c0a8:0115 error=-28.
Error code -28 indicates the GID table is full.
The call stack during ifdown is as follows:
  put_gid_entry_locked()
  del_gid()
  _ib_cache_gid_del()
  update_gid()
  update_gid_event_work_handler()

In put_gid_entry_locked(), kref_put(&entry->kref) does not
drop the reference count to zero, so free_gid_entry()
is never invoked to release the entry. Subsequent ifup
attempts keep adding new entries into the GID table,
eventually exhausting the table capacity.

To fix this, check whether the GID entry still has
outstanding references in del_gid(), and only remove
and release the entry when no other references remain.

Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/infiniband/core/cache.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 647a547e2d7f..c71522fbf89f 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -596,6 +596,34 @@ int ib_cache_gid_add(struct ib_device *ib_dev, u32 port,
 	return __ib_cache_gid_add(ib_dev, port, gid, attr, mask, false);
 }
 
+/**
+ * gid_table_is_shared - Check if GID table has other reference owners
+ * @table: GID table to check
+ * @ix: index of entry
+ *
+ * Returns true if the gid table refcount is greater than 1,
+ */
+static bool gid_table_is_shared(struct ib_gid_table *table, int ix)
+{
+	unsigned int refcount;
+	struct ib_gid_table_entry *entry;
+
+	write_lock_irq(&table->rwlock);
+
+	entry = table->data_vec[ix];
+	refcount = kref_read(&entry->kref);
+
+	write_unlock_irq(&table->rwlock);
+
+	if (refcount > 1) {
+		pr_debug("%s: The GID table is still referenced and cannot be deleted.\n",
+			__func__);
+		return true;
+	} else {
+		return false;
+	}
+}
+
 static int
 _ib_cache_gid_del(struct ib_device *ib_dev, u32 port,
 		  union ib_gid *gid, struct ib_gid_attr *attr,
@@ -615,6 +643,9 @@ _ib_cache_gid_del(struct ib_device *ib_dev, u32 port,
 		goto out_unlock;
 	}
 
+	if (gid_table_is_shared(table, ix))
+		goto out_unlock;
+
 	del_gid(ib_dev, port, table, ix);
 	dispatch_gid_change_event(ib_dev, port);
 
-- 
2.25.1


