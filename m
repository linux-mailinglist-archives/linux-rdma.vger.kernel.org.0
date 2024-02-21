Return-Path: <linux-rdma+bounces-1086-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DADC885D70B
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 12:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0733C1C22DA7
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Feb 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2053FB3C;
	Wed, 21 Feb 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b="W8/IYM/6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198693FE35
	for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515192; cv=none; b=OtVSv4yyT3YZS9uGCmPxEvZNKL5JF36aBaFI4zwCHN9KaVWMDENqZLydgWJsmj3fJvPI67uQyGVg/amsXq+uwN5b5O+BQBtJIymyveEVM4V0QIzNKOHSXl27YDH2j9qlw/zfJY/Mo+C3uwGwb34yLsJzngsvcacYvOvWl9B0+fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515192; c=relaxed/simple;
	bh=AZPSgLGPmZlUTQNC5yUSSSe+EzdV3PPVJMuuzRvVtEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBZmQECUw6L4wHgBUAm26j0Pv33k0PpvEkdsaXN6WrqG69dn6owLRlqWUuuce6RA5aATeHY+NpnFoickAqMR4t3S/hh7yJTiTHC9QsCtkwnngfS5JMoYZHvoSzZQFw/mdJZxZCHytxlddSRz+k/9v5M/2n5oHAMu6vREt6E7394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com; spf=pass smtp.mailfrom=bell-sw.com; dkim=pass (2048-bit key) header.d=bell-sw-com.20230601.gappssmtp.com header.i=@bell-sw-com.20230601.gappssmtp.com header.b=W8/IYM/6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell-sw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell-sw.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512b3b04995so576282e87.3
        for <linux-rdma@vger.kernel.org>; Wed, 21 Feb 2024 03:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bell-sw-com.20230601.gappssmtp.com; s=20230601; t=1708515187; x=1709119987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89775tDYEhM6RJnN4tnYYlShYVFrY4NEHIqGcTOLrbA=;
        b=W8/IYM/6tSwiHPQoIOEvL3zb17WkXvxHyBTeukSNSJG41kSYMd5hprw6deSuq32icp
         zuZuvqLpzGdc+VBvcyymTB3sBzfd2xAZNZlSb6O0bNbiNoBN3n5RHPVv4FgND2hqPj7A
         /d+xneif527krIb76B7W2orcmYrx1Ld1kqY1yNiwSPQRBs+cje6lsKlKe39eVZb3pLPj
         zuFMiW8RjSYo2ShCKN9FNcZ88HdDil+WnxOb+3Rq/pCY9jfekT110xtF0KtRu0RAaXYd
         rml+0JMUp4OTQgZE2hhgNUoJRAcWWaun6TD54yMR59ITeHiLmxYulkG7WIUn+WKkBfv4
         s1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515187; x=1709119987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89775tDYEhM6RJnN4tnYYlShYVFrY4NEHIqGcTOLrbA=;
        b=NwZzI5jXs+3RSCZRMl9pqUBcyj9ClkDGsQEueS6c4BRcow27Mm14hUs2jHDryLnO69
         nG//lQccIqEemjjb/wWUI8YscSUCXdMK++7nR+1clXHE5WgprsYGtwNmHvMPgHgje1bx
         x9iA0GnE6NwOAu6lUqmJwISILOl5MnadyRRoesZGeAqWCvk6VonuJ8LsAwegftNahHwj
         CynGU3QCBT75XrkN+Z2i0KWTUJ+F31I10W5YnwIxZy7IAGOcuNDVpXAsKAEtZDin/r7q
         ToVH7o7rdC3HdjYkAfad92fBZ1GODrs1C9EmsgSH/JPmEg2ygKjEIWQ5VCC2+aCWi/DY
         XIHw==
X-Gm-Message-State: AOJu0Yx7PDL6XQuiZ5kNzch+k4WyI4ssmge3f0A1ChvrNd/z6i4I5vvN
	HdiWoujID1WgPnyCPnxQPTHB0611rIGSrC3bOZnAGPPXftcONlhQcgh7wVJVgpFczADY8kw/c2U
	=
X-Google-Smtp-Source: AGHT+IGleKUt9qRZRNAKFFTuoGwk80ORd1bW+0z/VTjbwnrROBAJ9iHMqaJLFAOLOP/FlLUu0euITg==
X-Received: by 2002:ac2:520d:0:b0:512:aa89:961f with SMTP id a13-20020ac2520d000000b00512aa89961fmr5738346lfl.25.1708515187019;
        Wed, 21 Feb 2024 03:33:07 -0800 (PST)
Received: from belltron.int.bell-sw.com ([95.161.223.241])
        by smtp.gmail.com with ESMTPSA id p13-20020a056512312d00b00511812674dcsm1638416lfd.66.2024.02.21.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 03:33:06 -0800 (PST)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: linux-rdma@vger.kernel.org
Cc: Haris Iqbal <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Gioh Kim <gi-oh.kim@cloud.ionos.com>,
	Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Subject: [PATCH] RDMA/rtrs-clt: check strnlen return len in sysfs mpath_policy_store()
Date: Wed, 21 Feb 2024 11:32:04 +0000
Message-Id: <20240221113204.147478-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strnlen() may return 0 (e.g. for "\0\n" string), it's better to
check the result of strnlen() before using 'len - 1' expression
for the 'buf' array index.

Detected using the static analysis tool - Svace.

Fixes: dc3b66a0ce70 ("RDMA/rtrs-clt: Add a minimum latency multipath policy")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index d3c436ead694..4aa80c9388f0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -133,7 +133,7 @@ static ssize_t mpath_policy_store(struct device *dev,
 
 	/* distinguish "mi" and "min-latency" with length */
 	len = strnlen(buf, NAME_MAX);
-	if (buf[len - 1] == '\n')
+	if (len && buf[len - 1] == '\n')
 		len--;
 
 	if (!strncasecmp(buf, "round-robin", 11) ||
-- 
2.25.1


