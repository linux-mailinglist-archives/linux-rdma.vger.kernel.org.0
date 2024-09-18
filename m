Return-Path: <linux-rdma+bounces-4980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6297B6BE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 04:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53038282014
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 02:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9142048;
	Wed, 18 Sep 2024 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="raMoa5ft"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DC41C79;
	Wed, 18 Sep 2024 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726625815; cv=none; b=MckKmOnAXl3Ju2vZd+SklxG3LBSe6Z7i1VWeUtC8ni4MiFo+t0hrWxWamo5cHwBBmRaIaCdvcVsHggKu6aGfDuQ9eBLeKjyOf7ur1u3jZVgxilB9P49EDg9WMv0mSRzy+5MsetbO4pFpfX9+tQOA56f3XtwPnw++2QlmT1dQj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726625815; c=relaxed/simple;
	bh=4C9Ht1EBlLpV0cIxDh91gHaRUlOpXC6nq2v9gSS3vY0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=spS4f6hZPr1idJ5BrXFToSS8316LYRdaiERWK0qsOc0n9kaf4kvgBNZQrcJg5WSzg8KFPfcgw0LfjhodOtaJxdQia0qVCb0faGd+0uLXdTcOWzurewHhgsDaNHOqXNVXJJEVaHJkgri2vFYdM4nbAQKyUMUMJvxUIjF9V+Posxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=raMoa5ft; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726625810; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=26lXBlLla4cdOKVAJLtZkE/DW3VbondK5ccXaSRzzHQ=;
	b=raMoa5ftoR9x9fC36nWiL4bywHQErQrKMEUMLRT9qXVn8XiCFhWJNX7GR1GK4fm3/uYQpVtRy4I3xLbUAqdyCDNxkz+HuuuCwa5K6WKSos3pmBY0WfgWc2cDor/Aa+lldpTHAu2wkw+76GQ1a+/tdv+kAJbVF53pxgaOmLWngQE=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WFC8dO._1726625793)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 10:16:49 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: selvin.xavier@broadcom.com
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] RDMA/bnxt_re: Remove the unused variable en_dev
Date: Wed, 18 Sep 2024 10:16:32 +0800
Message-Id: <20240918021632.36091-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Variable en_dev is not effectively used, so delete it.

drivers/infiniband/hw/bnxt_re/main.c:1980:22: warning: variable ‘en_dev’ set but not used.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=10867
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index adff9e494c9d..777068de4bbc 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1977,7 +1977,6 @@ static void bnxt_re_remove_device(struct bnxt_re_dev *rdev, u8 op_type,
 static void bnxt_re_remove(struct auxiliary_device *adev)
 {
 	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(adev);
-	struct bnxt_en_dev *en_dev;
 	struct bnxt_re_dev *rdev;
 
 	mutex_lock(&bnxt_re_mutex);
@@ -1985,7 +1984,6 @@ static void bnxt_re_remove(struct auxiliary_device *adev)
 		mutex_unlock(&bnxt_re_mutex);
 		return;
 	}
-	en_dev = en_info->en_dev;
 	rdev = en_info->rdev;
 
 	if (rdev)
-- 
2.32.0.3.g01195cf9f


