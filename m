Return-Path: <linux-rdma+bounces-6608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110689F5CEC
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 03:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993D7169232
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Dec 2024 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D1535DC;
	Wed, 18 Dec 2024 02:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X3nicI1v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2E27726;
	Wed, 18 Dec 2024 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734489427; cv=none; b=lMPVu0KTocswZ4fQ7J4GevwgPqPPxDk6skX+19desDfdPAp1jkyVBW7D0QWC7bjVz3V8yh0NL8wO5mz5JsPl3IZWMKK1dFBpEKTYXsIdixTOyTo5dP+w5HjGOmzcVLdzKlBOT3lqfnfk456MFI53GCHm00xv9Pf/sy4jvy1Cox0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734489427; c=relaxed/simple;
	bh=jaqbbLQoknIFQwmg10bJ1tjvgzlprTal8JU1aoAgPjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TwFssNAHCH3PeGpDXpcjngS5kxsJ/UeHrDGyJetC0svXWekmy7Ytr1OLahANkcVL/aZbU7GN7lo5TEik7Z9Xm106jvGqme++C037sW65SkI+EPYH/mEjp6ZA0VHx5I/wSBwI38vbZGy6X4a+G0zWKmnHb1cILNRdV9eAgEujqvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X3nicI1v; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hj2/9
	QDLoQo5a1w3izcY0WRs2JQA5rA7zdcu4wKx9SE=; b=X3nicI1vpb365lq22pvRQ
	AzUn3Q861mQflu+Gfc89s2gjJtLGVJzyobzS170k+LViaqVl26lM1Y+6CCMFTvIJ
	U8YEsqXFFwocnzwXguzlufnGuSk2Ds/DunelD1Oek0arVsgQrJABSNwIZIhnPCdZ
	4hCzHk0LS7r/PKfdnADT9Y=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDHj_wmNWJn4OtKBQ--.30105S4;
	Wed, 18 Dec 2024 10:36:25 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: bvanassche@acm.org,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] RDMA/srp: Fix error handling in srp_add_port
Date: Wed, 18 Dec 2024 10:36:14 +0800
Message-Id: <20241218023614.2968024-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHj_wmNWJn4OtKBQ--.30105S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrZr1rGryUWryUtrWDXrWDurg_yoW8JrW5p3
	ykGa4Ykry5GF1DK3WvvF1IvFy5G3Wjywn8Wr1Fv34YkanYqryIyF9Fk348X3WkAFZrAayU
	ZFy7ZrW8Gr48uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_miiUUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbBFR25C2diLHiOdgABsS

If device_add() fails, call only put_device() to decrement reference
count for cleanup. Do not call device_del() before put_device().

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: c8e4c2397655 ("RDMA/srp: Rework the srp_add_port() error path")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v3:
- modified the bug description as suggestions;
- added a blank line to separate the description and the tags.
Changes in v2:
- modified the bug description as suggestions.
---
 drivers/infiniband/ulp/srp/ib_srp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2916e77f589b..7289ae0b83ac 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3978,7 +3978,6 @@ static struct srp_host *srp_add_port(struct srp_device *device, u32 port)
 	return host;
 
 put_host:
-	device_del(&host->dev);
 	put_device(&host->dev);
 	return NULL;
 }
-- 
2.25.1


