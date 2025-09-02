Return-Path: <linux-rdma+bounces-13035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A514B3F82D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 10:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0392163B3C
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49672E1751;
	Tue,  2 Sep 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WoI5r/fS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2232F742;
	Tue,  2 Sep 2025 08:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801259; cv=none; b=G1ID5IkpPsa2ZkpkAwy8dwqhbpyn+C0swTACAj1jwmfgBFHLfot9ZiTahaVmNr/buYINdsvifOZyBPkNbmB00xL50dA5yJMtpDW035/x5fL2rf0omWH8cbANztij4f9g3yDAUlybjOFiAnEFoO3nzhSX5k9YJtz/HkkTJhIH9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801259; c=relaxed/simple;
	bh=D8OIdhXFuRGa7UfoefPOXP3in9B29f1uaJHaCA6W9u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PYY3wHMfsi7iM7soS390LjrTxGJ04dxpWnvGysBdmSIGz5BMVgw41cSODdaUJNqjsfCgGfzXuNzsaaIo40aMLkx8qYiC9jpddjoD74uy5OUUiqPRRq+OwBvljhntLFoIiG8O9ycGLiQx45Xd1zRROzAb8woIaA4W8xudhsKGuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WoI5r/fS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581NLNDg025039;
	Tue, 2 Sep 2025 08:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z0qPA16BvJpAlEaHebuDOs3myh44Mx3IODFgZVwQ3
	dQ=; b=WoI5r/fSisgvq/ATEZGSAVgRBthlcggmrDXypZmAqPRyNZywZszn7JyzQ
	h+ENrNAvJ4rjLgoVzazJdeXxL39w+huCVhGffsEOVoEkhMl3bxvsqoB1gGg/KJcD
	UGJll6YLP6E5sojBef8eDgN81v8iKLit1ywqcl8ABx7JlA/uMIzip8rWFlI9bH/i
	tKU4HrM8dnNN09Z0duJjJOIdndZIfVIOgW2TOomZgtuk5MkAxLkjbV3rlABUBVKb
	UBesHP8WvMOmSjLepNczuC/i7A9kV/qsYD3LwoeNp1a8ZgVZ/0Agywo6DycA8fyD
	ow3ul4T8XjAOuEmashObWUAfI142w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd53hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 08:20:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5828K3U3017610;
	Tue, 2 Sep 2025 08:20:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswd53hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 08:20:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5827ABla019924;
	Tue, 2 Sep 2025 08:20:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmu1tdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 08:20:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5828KirD20709708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 08:20:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 820D520043;
	Tue,  2 Sep 2025 08:20:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FE1A20040;
	Tue,  2 Sep 2025 08:20:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Sep 2025 08:20:44 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 3C731E038D; Tue, 02 Sep 2025 10:20:44 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net v2] net/smc: Remove validation of reserved bits in CLC Decline message
Date: Tue,  2 Sep 2025 10:20:41 +0200
Message-ID: <20250902082041.98996-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68b6a8e2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=48vgC7mUAAAA:8 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8
 a=LEj5UjtMw8U8hYbBKdQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX5X/PJ7sh00gz
 RosIGL/GR4fSmNUgdxMcmhxNzxfG3caIThRiOefLvrBjVUg64o5Y0S2j7A0rCBIB2vwmJiV0mVl
 Lowt2Y/0nca9G8Lt5Rt3nupGIcrvxMBO1H79uDSK+ABNltcBiI6OsY4+pHnwp59zX4Oo4NzjmQn
 m8e+uMuFjl8tifHmExL6hBD/qvwjusRvPuJohCDO+eKCJptwqY4qHt1xs4tYTXX34bBS2DiUG6W
 trGQnfGBuBBznGWzRrrmQ+eM+MbqYrlC8Ng2Gv6qrStPdTOY5hY9yYT3waUEF2hM/xsRN/y2021
 FLWFUmI0eZGDQoseEACDUZTlE9VpF2b0ecHW+gGfxKm+HrrQTA0xdS/+RH6voUIcEEan86JpPgK
 BoHzPUnL
X-Proofpoint-GUID: 29qBXT4G38eKB9rw_XwPgZdDVhQVzdHd
X-Proofpoint-ORIG-GUID: NGTOjXPxRiRu0eUwXPH73OlTxt26l5oU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

Currently SMC code is validating the reserved bits while parsing the incoming
CLC decline message & when this validation fails, its treated as a protocol
error. As a result, the SMC connection is terminated instead of falling back to
TCP. As per RFC7609[1] specs we shouldn't be validating the reserved bits that
is part of CLC message. This patch fixes this issue.

CLC Decline message format can viewed here[2].

[1] https://datatracker.ietf.org/doc/html/rfc7609#page-92
[2] https://datatracker.ietf.org/doc/html/rfc7609#page-105

Fixes: 8ade200c269f ("net/smc: add v2 format of CLC decline message")
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
---
 net/smc/smc_clc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 5a4db151fe95..08be56dfb3f2 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -426,8 +426,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 {
 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
 
-	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
-		return false;
 	if (hdr->version == SMC_V1) {
 		if (ntohs(hdr->length) != sizeof(struct smc_clc_msg_decline))
 			return false;
-- 
2.48.1


