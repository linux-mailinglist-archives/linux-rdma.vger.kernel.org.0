Return-Path: <linux-rdma+bounces-13177-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268AFB4A32A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C973AEEF3
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40620306D52;
	Tue,  9 Sep 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGnEDM2O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E41235044;
	Tue,  9 Sep 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401933; cv=none; b=r7DNIF+dGTG95zkFu1gLxXW55XEGqlY2V7Nvfsfust9r4h4Cj/lYztNbtDaLo0OWRfKspdQnKQj+IrDBl10SZ8yhUdLdsotZKZAxQa+/IEqWtqMb6hrjGtV8+FwjrLqP73e5j4Nm0TuYxyTwsg3weB9/v8U6iNuOyts6sVhIeF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401933; c=relaxed/simple;
	bh=KVlFynD/KZmkbHRpxXJbCvEPT7and5zJ2SZIwAzXdvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xcri4HhnBvtJL1mxYnIublMt+7bHmbbMK0spTOchGccQSHn4Ry1xnY61yz9JB7KkguMM1cnVp5JQtBVKGsWtZ+Uj28HOTQ+pg2kPM5BmiGeCEhqcVIh886X9yfSDja9nHjoCJIQvnzj2Pb2uhQdd1DLK0HcPEC1Um4ytJ9TGJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGnEDM2O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588IKo7a030930;
	Tue, 9 Sep 2025 07:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vWUCdWdACL6jj/zlMERgKPOhY36Zq28tXZGn/gKQK
	SU=; b=sGnEDM2OPA9a0v0Y3XrMFTL3fEyhyjslSkyhJ780yR3GfFOtviSd6RYH1
	eE2ZQe0ApImNCLQnGDwcZ3CZltePzniMAflEkHuyB+lcRyZdoYxhrpwPwKx7LCUv
	Rrp/vvANPukmIh4+g5AbpG03ZW1rVSA3LDx4EFhOD6Tp73ffhlOO7QQKf+aFboDh
	jODkPI6KO4UBK5lIqutaLmQa8CC1GN/Lzein1z+ZXPjN1CQMKYLx3YbGLh82Is43
	RjwQugtByllRRdZZ74WGKQLK67J+4BUUyJdFJRoWZmfDVolaqGU7HY9QvJ46fVJK
	MvTHS/hheRYA3atMPx4J4Frc5r25w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyctycs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:12:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5897BoPo015898;
	Tue, 9 Sep 2025 07:12:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyctyck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:12:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5895LjcB020499;
	Tue, 9 Sep 2025 07:12:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0t0fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 07:12:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5897BvaU56689130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 07:11:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF3C720043;
	Tue,  9 Sep 2025 07:11:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD1AE20040;
	Tue,  9 Sep 2025 07:11:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 07:11:57 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 8D31FE1089; Tue, 09 Sep 2025 09:11:57 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net] net/smc: Remove unused argument from 2 SMC functions
Date: Tue,  9 Sep 2025 09:11:45 +0200
Message-ID: <20250909071145.2440407-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A5nJGg-45huZa9MfKbYiaY44eWRAo0NA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX8m+VdLur9tS9
 EuV5nNj7P72F9gdEsxpPXgUv5AT7w7Qm1JTDXxAtg3S5+9ddoPbdfCw2+0lnxKPT7nyqSv7xRaz
 NultpRVmsIfIFlqXTr8ABOhINZ2oA8k0puhw57NkIi07KpVWzY7krNmqyCF+Qs68mlxKI6MaKr8
 yell8j6Oew+E3Uy32VC7kntyTTQy3dGJ88VPc+yEIxmW/jvcBuX+4c/+3tJfiFSVg+H/arYfR7B
 TOvJ/ICm+47/YaNsnnT/ycaA9jD0G46yBiwAh3phQGkzcFawgXkDGMNkmW/WTZPDWSUWi16R6Or
 1fHMUWCYAWilx+KbCUWB1u+hzoSkk1FNex7DayFjgnuDP92TXS2IrVLk8OUG17D7GeTlQRFYIe6
 IH3UB9/k
X-Proofpoint-GUID: iWqDC6xXS4FtD670A2NIjIFe28u1Oj8N
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68bfd343 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=jK4AapCLPKrqRyuMZfEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

The smc argument is not used in both smc_connect_ism_vlan_setup() &
smc_connect_ism_vlan_cleanup(). Hence removing it.

Fixes: 413498440e30 net/smc: add SMC-D support in af_smc
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
---
 net/smc/af_smc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 66033afd168a..1ea54c09b3ac 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1096,8 +1096,7 @@ static int smc_find_ism_v2_device_clnt(struct smc_sock *smc,
 }
 
 /* Check for VLAN ID and register it on ISM device just for CLC handshake */
-static int smc_connect_ism_vlan_setup(struct smc_sock *smc,
-				      struct smc_init_info *ini)
+static int smc_connect_ism_vlan_setup(struct smc_init_info *ini)
 {
 	if (ini->vlan_id && smc_ism_get_vlan(ini->ism_dev[0], ini->vlan_id))
 		return SMC_CLC_DECL_ISMVLANERR;
@@ -1112,7 +1111,7 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
 	/* check if there is an ism device available */
 	if (!(ini->smcd_version & SMC_V1) ||
 	    smc_find_ism_device(smc, ini) ||
-	    smc_connect_ism_vlan_setup(smc, ini))
+	    smc_connect_ism_vlan_setup(ini))
 		ini->smcd_version &= ~SMC_V1;
 	/* else ISM V1 is supported for this connection */
 
@@ -1157,8 +1156,7 @@ static int smc_find_proposal_devices(struct smc_sock *smc,
 /* cleanup temporary VLAN ID registration used for CLC handshake. If ISM is
  * used, the VLAN ID will be registered again during the connection setup.
  */
-static int smc_connect_ism_vlan_cleanup(struct smc_sock *smc,
-					struct smc_init_info *ini)
+static int smc_connect_ism_vlan_cleanup(struct smc_init_info *ini)
 {
 	if (!smcd_indicated(ini->smc_type_v1))
 		return 0;
@@ -1581,13 +1579,13 @@ static int __smc_connect(struct smc_sock *smc)
 		goto vlan_cleanup;
 
 	SMC_STAT_CLNT_SUCC_INC(sock_net(smc->clcsock->sk), aclc);
-	smc_connect_ism_vlan_cleanup(smc, ini);
+	smc_connect_ism_vlan_cleanup(ini);
 	kfree(buf);
 	kfree(ini);
 	return 0;
 
 vlan_cleanup:
-	smc_connect_ism_vlan_cleanup(smc, ini);
+	smc_connect_ism_vlan_cleanup(ini);
 	kfree(buf);
 fallback:
 	kfree(ini);
-- 
2.48.1


