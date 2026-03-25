Return-Path: <linux-rdma+bounces-18602-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ0BNBe+w2mptwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18602-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 11:51:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC03234E7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 11:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2149630EE3F8
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 10:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAB63BC67E;
	Wed, 25 Mar 2026 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rteyyJqC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD953BE648;
	Wed, 25 Mar 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435266; cv=none; b=M+D2SreMPdzHZl6jK6wLb8nWMPN+rgFk9UVTEnEcCBLUGuO1HIzgeQKcbwjgKb0B0CLJBJbIrB95u3hkIm1n+y8dVMjnoVSeIagajv9CLvg+COgrrGDtBAGd/mZXRingmDsKHPkJVVGl06X610sGWk7gN+M24/gHG4Aeb40nvsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435266; c=relaxed/simple;
	bh=+dYSH5LNbLrtuQR/hiaQV7eLv638QDZcF+DngRslZgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dnXyANfniSxmAPTx/UlOOZC/HFX2CXwrEXIYJUpfsd9vJZjwZB5QLYYkN0kH6UKOIEP9LaUwL+r8ifBFb1tmQpe1rTg3QFy+fDbnuzIj1o8I7P8S6C38+VLk/gJ3mQeHGfGluL52St3yUW0RWfUlo/S11y+ZUJkbUN9jkDLsu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rteyyJqC; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vBi36DUPKhHftc09L76w66t0B5jFNMkK0AVfFTuKFBo=;
	b=rteyyJqCkBWM9xwD2Ir4jhQFGHjKE7oNPuy0s14foXOxAs2XfKDPi8aoVxP+5iOrRY5MH+QYe
	YgJdCBMyAFlWyz6EpbmAIWMlqoBmeDmdP9gJens6r1L5SpCaEf4AQags3EfKsHEYYe/6SorDuB0
	X+BTIB0VA3nULMOWLfYBKU4=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fgjvq6HBMz1prLY;
	Wed, 25 Mar 2026 18:34:47 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 459332012A;
	Wed, 25 Mar 2026 18:40:56 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 18:40:55 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li
	<dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia
 Zhang <wenjia@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony
 Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<weiyongjun1@huawei.com>
Subject: [PATCH net 1/2] net/smc: fix potential UAF in smc_pnet_add_ib for ib device
Date: Wed, 25 Mar 2026 19:03:51 +0800
Message-ID: <20260325110352.3833570-2-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325110352.3833570-1-lixiasong1@huawei.com>
References: <20260325110352.3833570-1-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18602-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55AC03234E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

smc_pnet_find_ib() returns an ib device pointer and releases the lock,
then smc_pnet_apply_ib() is called to use this pointer. The device could
be removed between these two calls, leading to a potential use-after-free
when accessing the freed ib_dev pointer.

    CPU 0                           CPU 1
    ----                            ----
    smc_pnet_add_ib()
      ib_dev = smc_pnet_find_ib()
        mutex_lock(&smc_ib_devices.mutex)
        list_for_each_entry() ...
        mutex_unlock(&smc_ib_devices.mutex)
                                    smc_ib_remove_dev()
                                      mutex_lock(&smc_ib_devices.mutex)
                                      list_del_init(&smcibdev->list)
                                      mutex_unlock(&smc_ib_devices.mutex)
                                      kfree(smcibdev)
      smc_pnet_apply_ib(ib_dev)
        ib_dev->pnetid[ib_port - 1]   <- UAF (ib_dev already freed)

Fix this by introducing smc_pnet_find_ib_apply() which performs both
find and apply under the same lock, preventing the device from being
removed in between.

Also refactor smc_pnet_apply_ib() into __smc_pnet_apply_ib() (without
lock) and smc_pnet_apply_ib() (with lock) for reuse.

Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 net/smc/smc_pnet.c | 63 ++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 63e286e2dfaa..91c0b1c473b2 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -245,18 +245,25 @@ static int smc_pnet_remove_by_ndev(struct net_device *ndev)
 
 /* Apply pnetid to ib device when no pnetid is set.
  */
-static bool smc_pnet_apply_ib(struct smc_ib_device *ib_dev, u8 ib_port,
-			      char *pnet_name)
+static bool __smc_pnet_apply_ib(struct smc_ib_device *ib_dev, u8 ib_port,
+				char *pnet_name)
 {
-	bool applied = false;
-
-	mutex_lock(&smc_ib_devices.mutex);
 	if (!smc_pnet_is_pnetid_set(ib_dev->pnetid[ib_port - 1])) {
 		memcpy(ib_dev->pnetid[ib_port - 1], pnet_name,
 		       SMC_MAX_PNETID_LEN);
 		ib_dev->pnetid_by_user[ib_port - 1] = true;
-		applied = true;
+		return true;
 	}
+	return false;
+}
+
+static bool smc_pnet_apply_ib(struct smc_ib_device *ib_dev, u8 ib_port,
+			      char *pnet_name)
+{
+	bool applied;
+
+	mutex_lock(&smc_ib_devices.mutex);
+	applied = __smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
 	mutex_unlock(&smc_ib_devices.mutex);
 	return applied;
 }
@@ -305,24 +312,42 @@ static bool smc_pnetid_valid(const char *pnet_name, char *pnetid)
 }
 
 /* Find an infiniband device by a given name. The device might not exist. */
-static struct smc_ib_device *smc_pnet_find_ib(char *ib_name)
+static struct smc_ib_device *__smc_pnet_find_ib(char *ib_name)
 {
 	struct smc_ib_device *ibdev;
 
-	mutex_lock(&smc_ib_devices.mutex);
 	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
 		if (!strncmp(ibdev->ibdev->name, ib_name,
 			     sizeof(ibdev->ibdev->name)) ||
 		    (ibdev->ibdev->dev.parent &&
 		     !strncmp(dev_name(ibdev->ibdev->dev.parent), ib_name,
 			     IB_DEVICE_NAME_MAX - 1))) {
-			goto out;
+			return ibdev;
 		}
 	}
-	ibdev = NULL;
-out:
+	return NULL;
+}
+
+/* Find an ib device by name and apply pnetid under lock. */
+static bool smc_pnet_find_ib_apply(char *ib_name, u8 ib_port, char *pnet_name)
+{
+	struct smc_ib_device *ibdev;
+	bool rc = true;
+
+	mutex_lock(&smc_ib_devices.mutex);
+	ibdev = __smc_pnet_find_ib(ib_name);
+	if (ibdev) {
+		if (!__smc_pnet_apply_ib(ibdev, ib_port, pnet_name))
+			rc = false;
+		else
+			pr_warn_ratelimited("smc: ib device %s ibport %d "
+					    "applied user defined pnetid "
+					    "%.16s\n", ibdev->ibdev->name,
+					    ib_port,
+					    ibdev->pnetid[ib_port - 1]);
+	}
 	mutex_unlock(&smc_ib_devices.mutex);
-	return ibdev;
+	return rc;
 }
 
 /* Find an smcd device by a given name. The device might not exist. */
@@ -412,23 +437,13 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
 			   u8 ib_port, char *pnet_name)
 {
 	struct smc_pnetentry *tmp_pe, *new_pe;
-	struct smc_ib_device *ib_dev;
 	bool smcddev_applied = true;
-	bool ibdev_applied = true;
+	bool ibdev_applied;
 	struct smcd_dev *smcd;
 	bool new_ibdev;
 
 	/* try to apply the pnetid to active devices */
-	ib_dev = smc_pnet_find_ib(ib_name);
-	if (ib_dev) {
-		ibdev_applied = smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
-		if (ibdev_applied)
-			pr_warn_ratelimited("smc: ib device %s ibport %d "
-					    "applied user defined pnetid "
-					    "%.16s\n", ib_dev->ibdev->name,
-					    ib_port,
-					    ib_dev->pnetid[ib_port - 1]);
-	}
+	ibdev_applied = smc_pnet_find_ib_apply(ib_name, ib_port, pnet_name);
 	smcd = smc_pnet_find_smcd(ib_name);
 	if (smcd) {
 		smcddev_applied = smc_pnet_apply_smcd(smcd, pnet_name);
-- 
2.34.1


