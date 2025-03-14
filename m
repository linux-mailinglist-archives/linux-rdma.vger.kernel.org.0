Return-Path: <linux-rdma+bounces-8706-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B68A6157A
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 16:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BBC1706A1
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383F202994;
	Fri, 14 Mar 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJLO7nu5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3074C126C13;
	Fri, 14 Mar 2025 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967846; cv=none; b=eBB67SdLha1N/oSAp/U5hCegm/C+xlQCiQHdaHUppaDG1pCWN8JU20PNIk3vLyoY0ZSWI1MkriOyAgWEPnQ64xbUUZUAymJps7MZhSgJI9nFGyEuxtHFG5xK9q4ig1VrcUARqxniNzOUdIbPkLSxBFcfSc1pv6ktCeGLMwgeyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967846; c=relaxed/simple;
	bh=Ll4feJ3S6JRt4AKEObqjw+W/6+NuZS8u+iuU+DkbJ58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mgRW8NzEPzyXVUBDxXaWMgoKDVoVhHPix9LPM/lrW3kb0mYd3xkXQ+9QXdLSBBsiRQSbhrB8ZVFJvbnOVXWfMbj5yjhv/28fODiucKLuj2RSrlEgZPhgeeztnHIdmR26Za0JbQDbdw0ZgdxUCfRrrtR0dC+tAaB66oXSKbn3JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJLO7nu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C4C4CEE3;
	Fri, 14 Mar 2025 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741967845;
	bh=Ll4feJ3S6JRt4AKEObqjw+W/6+NuZS8u+iuU+DkbJ58=;
	h=From:To:Cc:Subject:Date:From;
	b=BJLO7nu5dQ3UAg06mFI21wzSEci6HWuSN30iChfh+n+wdNEt59D0PdIkZWRgzoJ/O
	 01WiUaAud9GimBCtxte8NipCSL6FYCLQu2WkbjuCDokJOddMNkg40EOhemJp2K+/38
	 0axduSYF+qIzEN7J+anPXaCJFHvSMW4nYxq2dN4Kxe0BPHKfmciBUGA0PirKVCQagI
	 oIYX9E5ciWqDdeuBX02MTjuFqkPe/PrwVTsuMarX+9NpiApduyANApz7SJCJWz03+V
	 D7YZfKZOgssEnkP1aU1L0VdWRbh2eXhwKOcyerRUiUYS61Q3d6s4KMwKhU8QbVo4xb
	 rKwMWKIxL1nNQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Chiara Meiohas <cmeiohas@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] inifiniband: ucaps: avoid format-security warning
Date: Fri, 14 Mar 2025 16:57:15 +0100
Message-Id: <20250314155721.264083-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Passing a non-constant format string to dev_set_name causes a warning:

drivers/infiniband/core/ucaps.c:173:33: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
  173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
      |                                        ^~~~~~~~~~~~~~~~
drivers/infiniband/core/ucaps.c:173:33: note: treat the string as an argument to avoid this
  173 |         ret = dev_set_name(&ucap->dev, ucap_names[type]);
      |                                        ^
      |                                        "%s",

Turn the name into thet %s argument as suggested by gcc.

Fixes: 61e51682816d ("RDMA/uverbs: Introduce UCAP (User CAPabilities) API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/core/ucaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucaps.c b/drivers/infiniband/core/ucaps.c
index 6853c6d078f9..de5cb8bf0a61 100644
--- a/drivers/infiniband/core/ucaps.c
+++ b/drivers/infiniband/core/ucaps.c
@@ -170,7 +170,7 @@ int ib_create_ucap(enum rdma_user_cap type)
 	ucap->dev.class = &ucaps_class;
 	ucap->dev.devt = MKDEV(MAJOR(ucaps_base_dev), type);
 	ucap->dev.release = ucap_dev_release;
-	ret = dev_set_name(&ucap->dev, ucap_names[type]);
+	ret = dev_set_name(&ucap->dev, "%s", ucap_names[type]);
 	if (ret)
 		goto err_device;
 
-- 
2.39.5


