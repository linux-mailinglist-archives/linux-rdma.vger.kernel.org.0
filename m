Return-Path: <linux-rdma+bounces-18600-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFA3M3a9w2kRtwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18600-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 11:48:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61383323433
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 11:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97133047E7B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261A3BD638;
	Wed, 25 Mar 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6icw1ztY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0813A3808;
	Wed, 25 Mar 2026 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774435261; cv=none; b=CrrEsqyGXHtCx/Wo50BdadmIBAmhpo0moNNid+fOxBoSG606b7TwH3D7j7WsYMcBHP63Z6oc4hHkit0iNMiOuGLDGNTBDZuIEthXC3zUSwuugbMJbmsEkMoClGf9J6IrJKaIZ0ovi/fsDbaE1/OSf9q3tISK1gdvEiG6dGI3hDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774435261; c=relaxed/simple;
	bh=BcDi6nzVlQg2U3KmKSOB/wadPQ2QPbC8tRKQEuEiMYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBidy2QLy5S8z+pJ2qLjGpxunxAShbJEE0npO7eLIM2u0JzTngQ+AGgLShhG1IM9xLyypeX3H3jHn5+CwBDIE6j3HU/5P905ywif0brhsvUcS1Zokm0wHVtXa6FMCS/drKs7NM38gchfX3gIk7bCjy2x2rKaS0T9yWjYb62AV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6icw1ztY; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=M1G5PSptWXXzPLH9d87A5P5m9OW3Nt2u+CyKoMXaMeo=;
	b=6icw1ztYu295iNl9URcLYFKLnLJkQ37jl0EUZsh07i+gqmYgw5UxctCRRDBTVi1t/RC4+t1lA
	b13Aad1xfLWYs+AODVUzko+D3rTO3KY7eH8InFZ/kqM+p8/ENsiK2c7xcaSk4xlJpGF7lLF5g4R
	/A90cNHQSF0PpezVksdyjxA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fgjvw1ZZPz1K96l;
	Wed, 25 Mar 2026 18:34:52 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 8278F4055B;
	Wed, 25 Mar 2026 18:40:55 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 18:40:54 +0800
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
Subject: [PATCH net 0/2] net/smc: fix potential UAF in smc_pnet_add_ib
Date: Wed, 25 Mar 2026 19:03:50 +0800
Message-ID: <20260325110352.3833570-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18600-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: 61383323433
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes potential use-after-free issues in smc_pnet_add_ib()
where the device pointer could be freed between find and apply operations.

The race occurs because smc_pnet_find_ib() and smc_pnet_find_smcd()
release the mutex before returning the device pointer. If the device is
removed (e.g., via smc_ib_remove_dev() or smcd_unregister_dev()) before
smc_pnet_apply_ib() or smc_pnet_apply_smcd() is called, the freed
pointer will be accessed.

Patch 1 fixes the issue for ib device, and patch 2 fixes the same issue
for smcd device.

Li Xiasong (2):
  net/smc: fix potential UAF in smc_pnet_add_ib for ib device
  net/smc: fix potential UAF in smc_pnet_add_ib for smcd device

 net/smc/smc_pnet.c | 121 ++++++++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 46 deletions(-)

-- 
2.34.1


