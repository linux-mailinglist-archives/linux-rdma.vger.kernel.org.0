Return-Path: <linux-rdma+bounces-13524-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29229B8C0A0
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 08:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA7D587CC4
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9FB23496F;
	Sat, 20 Sep 2025 06:27:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B615853B;
	Sat, 20 Sep 2025 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349636; cv=none; b=fDMacmOhWkSUECMqVP5oudw9xa2lxD/2gAZyUEIDNiURH6A+OCJKCq4rPzkZXAY/bW1WinfxeEjmJdKJjAkFm40C1ajbisrFHsbc7axVdDBnQgHSZIkWCudBDQWwftVIPj/ZdKA3EOYdwPwmDAiPD9+yImJ+ooKdozi3JMdf8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349636; c=relaxed/simple;
	bh=FQZTH607l5fzGcJImyigH0Oo6hJ8MIfJh5u4sliZyAo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0+qPo8CouRhkGpiridfwbdqwEfhcyWFyyV8eVTHP2KoxK8cCx4Jq4IrGbZkm+e7OXjCedhed0jJ+TaSWa5rw2JTQ/bIbbXkrQOVV63BWhYTp/y36klcYko9WqzGLKYSIBKzx8JAaDybnJFutthHZ9DqFjDlwMXEdzO4EORH1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cTK7q2Mypz24hvl;
	Sat, 20 Sep 2025 14:23:35 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AFC21A016C;
	Sat, 20 Sep 2025 14:27:03 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 20 Sep
 2025 14:27:02 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>
CC: <syzkaller-bugs@googlegroups.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
Date: Sat, 20 Sep 2025 14:48:13 +0800
Message-ID: <20250920064813.386544-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500016.china.huawei.com (7.185.36.197)

#syz test

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2c9084963739..1b20f0c927d3 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -285,7 +285,7 @@ struct smc_connection {
 struct smc_sock {				/* smc sock container */
 	union {
 		struct sock		sk;
-		struct inet_sock	icsk_inet;
+		struct inet_connection_sock	inet_conn;
 	};
 	struct socket		*clcsock;	/* internal tcp socket */
 	void			(*clcsk_state_change)(struct sock *sk);
-- 
2.34.1


