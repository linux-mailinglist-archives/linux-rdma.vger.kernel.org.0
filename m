Return-Path: <linux-rdma+bounces-6002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D839CF332
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 18:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09881283F83
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 17:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157B1D8DF9;
	Fri, 15 Nov 2024 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P5pZgxis"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100E1D5ADB;
	Fri, 15 Nov 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692708; cv=none; b=RWIj+i9H11b4ZMkLfXJgkgaJFBXZVYZWGUKHteTUYzz6cfys7CRAXpwJI2ufI+Wp4fn7eXXDEOLg30KrVNDSJzCH5TzsL0zwikqjKNF8/pAO9ecxGWHq47UC18ljN4zJksesSjR6m+Wq7+If8eqJj9MGGV9bUNDO7vhNzHnDdyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692708; c=relaxed/simple;
	bh=QTWbwD3DKt0zr3HVsMrLQMkox5w7tN0rnElVWEnMM14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OvimdVVK4oUWB/mfjAg9eFYRsY/fmj9xovm82dQPGMtreRRc9dpromr6ZCFuddZom4pMcAY5qdatcYvqrAocql/9ha7xvM27YTm2JIqSQxvjiUuqPJLX3pirNL8/ijagOVVr0UQqBZcIodEWyT7LTNllL/ExgabqfmUHPBa4LIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P5pZgxis; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAYcWY008123;
	Fri, 15 Nov 2024 17:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=9bwZzCyAvLguoe37pSaNCSSBT7z9
	wKmcx4So1GTdFbs=; b=P5pZgxisEBU6TpexMjXjUUJAS4jxH9jyXTNIdgwdJ+l5
	MmiOXh2qqtn11eBm6Ym3R+u+SyZ0o5u/bRJgTcoIvmcOdR3xG14U2FzUgKO6TO5O
	2oAJWk+z1HvRX6lH1i9AMYLcoPcgHymjKabaDAnAsXWGUQXUYekVQ5p+Nj8rkppG
	d9c6psyCrmoVLUfFoBhNX5vttE9gfp8hnfjOWCaYgiMNdNjYmL515FF1cNtfm0jH
	l+WywwQhLRACCO6Yk5cwjuzZDAvo2zfAsAjylClZcNnI8k3amBmhCmuCOK4Hgfj2
	gZELWBG9DMdCmLCdk2KAe5FbOdWV+VwYQNGdN07npg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vvsn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 17:45:04 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AFHfs7v009421;
	Fri, 15 Nov 2024 17:45:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vvsn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 17:45:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8H6dM017821;
	Fri, 15 Nov 2024 17:45:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2n2se9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 17:45:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFHiwZb19726688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:44:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438C32004D;
	Fri, 15 Nov 2024 17:44:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CD2820040;
	Fri, 15 Nov 2024 17:44:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 17:44:58 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 15 Nov 2024 18:44:57 +0100
Subject: [PATCH net-next] net/smc: Run patches also by RDMA ML
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAJiIN2cC/22NywqDMBBFf0Vm3YiTFh9d9T+KFJOMdUATSVKxi
 P/ekHWXh3s494BAninAvTjA08aBnU2AlwL0NNg3CTaJQVbyhljVIiz6NXOIQaiupbqVnbqihuS
 vnkbec+sJlqKwtEfo0zIl3/lvPtkw7396GwoUXWO0GWmoGlSPme1nL1ktpXYL9Od5/gCTMqTIs
 AAAAA==
X-Change-ID: 20241106-smc_lists-b98e6829b31c
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Leon Romanovsky <leon@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m24rJp-3g8Idy14-TaxmhZLjBXES-qUQ
X-Proofpoint-GUID: LpD6NkObD4_44A3ElA8ZqYQXW7Vrk1nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1011 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150148

Commits for the SMC protocol usually get carried through the netdev
mailing list. Some portions use InfiniBand verbs that are discussed on
the RDMA mailing list. So run patches by that list too to increase the
likelihood that all interested parties can see them.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d157621b44fb919307e865e2481ab564eb17df..16024268b5fc1feb6c0d01eab3048bd9255d0bf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20943,6 +20943,7 @@ M:	Jan Karcher <jaka@linux.ibm.com>
 R:	D. Wythe <alibuda@linux.alibaba.com>
 R:	Tony Lu <tonylu@linux.alibaba.com>
 R:	Wen Gu <guwen@linux.alibaba.com>
+L:	linux-rdma@vger.kernel.org
 L:	linux-s390@vger.kernel.org
 S:	Supported
 F:	net/smc/

---
base-commit: 519b790af22e705ee3fae7d598f1afbb3d1cfdd5
change-id: 20241106-smc_lists-b98e6829b31c

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


