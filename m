Return-Path: <linux-rdma+bounces-20120-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHwVCUxF/Gn9NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20120-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 09:54:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7D4E4487
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 09:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 167043020FE8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B6C3793D0;
	Thu,  7 May 2026 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="HSEwHj8J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C913191C8
	for <linux-rdma@vger.kernel.org>; Thu,  7 May 2026 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140487; cv=none; b=IGm6f1aimwrB/Z8Q1et9KJL3OJHBhU6DXcjbTNbRepfNP5dempzDzp7dspRtfBXd7VY1vogEcSglemvc58GEg8oUWyGTp2PwW3RA2TNsMsuZc2j1+Gk0l9YMFNUlNzkOqKrzLaMmkHM2+pU0cU1UNZuOvT5U9F0ZwZ5i3k+Ox64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140487; c=relaxed/simple;
	bh=qc9u9/fYDnq3vimu3vL7M7+iTbPf5v+oJMZrF9Q4oEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoHHviNjF8NDJTy7gbUQRX4JnxChgsJHet7Rok+797xjcjkX3dXNOIsoOq+QF1gXQZ/UdafY6lVgU8jJ47ER4WUNy2KVrJcqzHiaJOw879wKFGuFTd2FVfKYMKYON7/dCIkqgQyj+ZbCvzmUrRHYFbkju0LOX8OM53gtre5uI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=HSEwHj8J; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891f625344so5607995e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 07 May 2026 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778140483; x=1778745283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=poCJ7kcu+gChRgoC86wgxQaZbs+9th6aVzlUcPl5Axw=;
        b=HSEwHj8Jnd1oOT4icwkoUEIJLNLQqDhK+tdRWCyLCmlmM0TRapXl+NMBN4P7EwhUt5
         96hbe5je3PYd1Ex5kOju7WQlENYMPlwrWlODtEX6B1vZJYCM1iRhfTAXeKQwU4siNeyH
         0VLp+dNQj1teuk1RTICT7O/TJs/7+QWVJvxU6vYizIqLUShUOeKzEh3kB6gZLqBZqE6B
         sER17nH1hiHyST/BcQcBTbJP6r4gQ+Xh8H6LvhmaED6im+w1+00snU21zpG6FjqpDC/p
         gwNw84GKccGxSLWaPaFXSll0VNX1ULkdepqlIBttfndsrcVqfFzO/mm99n/lJbFZBzTA
         vfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778140483; x=1778745283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poCJ7kcu+gChRgoC86wgxQaZbs+9th6aVzlUcPl5Axw=;
        b=SkngSu83d6PZ4huTO/Y/tVRRu8wTS5G0GSahTqBOA+mUlaUYsikS8X0/A3G4MO1hcZ
         c/ritdHguyJaU/MGA8cKsAMkAic5lE7lOvgiChWaP8LLz4qbIKna5Xdlj/ZCNKT7Tpc9
         94y3O3k8hGI1R+7qr2Mo/iNI+EywDnJ/5jGdfMVZIQg2mBKValqrqHXVfAo9fHL5L/8f
         0ASnQeSuPQ7eOuK39M2v60mUbg2F1fpe658c7pDEZ2N+t1Ib4HffNqhqKtzF26EUfG/c
         CCPTejJYGCHTY+FYFUomW8SDh3g6jd3uR8jR3R3Vv8YGyvI/MlJEqejL39iWb/r0jy4y
         zvkw==
X-Forwarded-Encrypted: i=1; AFNElJ9W4J356lcx94NIuJwGpmmykMuXqgbuAamw7AwwwMFdDnr2UxTdNORXy3Czc6ZYB0BdSFkYaKRY7xbj@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLqEXtQ7e8WiMS3tKkxfkOJ44arAtxAUBJsjhkouYQiP5uEdl
	keYmHxxc2YLbQr2dqN4HFLnUSNaMBG+TFO7YLconcY8SpMFrzwQ57D5O89KhdHXoslc=
X-Gm-Gg: AeBDietv/HPa1PcXuWmkBnRlGI6SriEnyTfJ0+yqK/k4ZK2c02Op0zVK9P59U/3p2dy
	27WtCLXQjUEIee5DjvlVcMdUA/J34NE9N7pqysU+/SvVuWOF9sLpLcJ3tJFcLcGZOk6IbYwo8Jr
	QnvUgKWTbHcMJVIFRstCKMVjl7q33cTGDOY4y6QHc/y0CzJeCDqDNkav/C5aKbDdkiOBbPpe2Qz
	IMaPUhu6lF9HVgn/ag8Qal/DcL5jP345jiU1XeynClIGElP1jEocWpq9/1xL2OjU9TN4iPPWLOu
	Rv7uBlPnQ1ayAOOO2bGmeYVaNJJwiJldg1dyWgEYO2Kb6+qW3N9VFe0Y9YewxdeTdx45xY3nLUq
	n62OyWI4dVDaxwIUsHMSuWETEZR/+OL+QS/fFWaXXPvvsBnlcvREIqFix9HKnjoOnZa6yhj0SID
	RWtX/RxLhmxqLJwkM5EbPYkvLrzUIDxozj0VaOxxLdkkum8D1Rgk+M1qcXh4iLuSk+KoSffbYYs
	OuVhgqaDF8/yLTsiTfSrEW1kPRtOBBFd0t6
X-Received: by 2002:a05:600c:630f:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48e5dffab3dmr27996655e9.10.1778140483410;
        Thu, 07 May 2026 00:54:43 -0700 (PDT)
Received: from localhost (p200300f65f114e08ac341e0bb79e5496.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:ac34:1e0b:b79e:5496])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e52f5d299sm53030595e9.0.2026.05.07.00.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 00:54:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMS/hns: Use named initializer for pci_device_id array
Date: Thu,  7 May 2026 09:54:37 +0200
Message-ID: <20260507075437.2669363-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2637; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=qc9u9/fYDnq3vimu3vL7M7+iTbPf5v+oJMZrF9Q4oEw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp/EU98pn4uHpul9V46gnE9oLXmfPXGkj3f86qf aJF1KUX4P2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafxFPQAKCRCPgPtYfRL+ TsIdCACUjz39qCpxyPvtcE0wlZ1NDHHQL1yMsC3NPpKNLzSDopm/8IH18uqAtAfKAY/msRWzF/l seUyxueUtsJ/VY4mV9XM7GOX+4O04PCNCpeeH47J3m2xky966xnzFWn6FnL2vHumAxlfqxYIN7d Qv2wY7LW+K7YxhS4wLb3pyYOvyaOWNvCk2Cjvb3hevX8EYgQMd3gR4WgKMbpOJk9HKRUhXgqkuG cWGuwPR9CsQ5f43gX9x4XzfOYGSS+73011JrWNUwng28yr5db7OZJSbZZ/abmVAhBL3Cv8PRxiD 5MJzY2UeNInp+tyj7LKBjRDWwta0T8xniDGs0W7XTiqPMIn0
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0A7D4E4487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20120-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

While being more verbose using a named initializer yields easier to
understand code and doesn't rely on the two hidden zeros in the
PCI_VDEVICE macro.

While at it, also drop the explicit zero in the terminating entry.

This doesn't introduce any changes to the compiled result of the array,
which was confirmed on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

while being a cleanup that can stand on its own this is also a
preparation for making driver_data an anonymous union that requires that
.driver_data is initialized by name and not by list order. The union
allows to make better use of the C type system (see
https://lore.kernel.org/all/20260507074102.2654314-2-u.kleine-koenig@baylibre.com/
for an example), but inifiniband won't profit as no driver uses a
pointer for driver_data.

Best regards
Uwe

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 32 ++++++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fa36700d0db2..cfe5269ba6a8 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7249,16 +7249,30 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 };
 
 static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA), 0},
-	{PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
-	 HNAE3_DEV_SUPPORT_ROCE_DCB_BITS},
+	{
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_25GE_RDMA_MACSEC),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_50GE_RDMA_MACSEC),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_100G_RDMA_MACSEC),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_200G_RDMA),
+		.driver_data = 0,
+	}, {
+		PCI_VDEVICE(HUAWEI, HNAE3_DEV_ID_RDMA_DCB_PFC_VF),
+		.driver_data = HNAE3_DEV_SUPPORT_ROCE_DCB_BITS,
+	},
 	/* required last entry */
-	{0, }
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


