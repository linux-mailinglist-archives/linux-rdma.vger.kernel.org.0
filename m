Return-Path: <linux-rdma+bounces-13220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB18B50E0E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20EFB7B3308
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 06:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F72D0283;
	Wed, 10 Sep 2025 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aRaRwDcQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E431D364;
	Wed, 10 Sep 2025 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485963; cv=none; b=N5exfkeEcQ0PhHenHGS5gJgMNa2/M9N6pteyDFvdYvNgnEQZjqdWKKc75oWQbvxWncFYgB8Q0jAxA+yeBJ5i4cImwNoB6xjtAgHIOpXBLfn98TELQz5aSIRx5NEP6g8uizxYARCdepV9/jpKIvQV4n+pZ20ephBcRC8ApcMrH1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485963; c=relaxed/simple;
	bh=9Q6zS2/4O/eBnBIjlNDHY5Tf8xsuS6/6e3ZqTu7O1S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g77x5Cqnsh9zH688tE8Tr0DA0qHIGhMvS05HCMwHF/SeogE5Mm8nEk3rv0ThY5OVT4MWGw+zCAq6plVZLfvkBOuaNW5iW0PL7k7TtOhCi0zJ/MEX3Usu1yjrH/sZB9/eJauhI/V97R3TKZjxQ6FjwTAA4JOE3kBkom2QV8zGULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aRaRwDcQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589K5AGC007706;
	Wed, 10 Sep 2025 06:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D0n7V5zxRFqzihzn2VYWhbt8HqCQIPmJ+q7SchDP2
	/k=; b=aRaRwDcQ8QDMpKGnFHA5JDByOXy7jucdPeOOxTHUbOqyZwZctVadFb7MM
	E+Q/hfxr25IvV7AA8XEjRbbu730xEyTQjZ0lK5GKtfaj9sFW/KQ1LmHa+pEDtkTZ
	1d9G+w9+q41zkPP4g/8uiBNzQ3yhjnVfFgpjNe6JoPwaZ7IuHBti1dsE53AEPgUL
	8+CjMORLUKzaPZIEYM8q+dbeXMpMYH78sWHUvI3YLRe6LF1ldS2dgF2eHIsquqYw
	OS5H0Lu3J//P/vb2lm4Z52ICnpRgEC2a378CeJAZvFbi7UT7GIvdzZVF4yNML1nd
	kus3pUEar5Bm18DJuU6Tp+k4mr4RA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd153y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:32:33 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58A6NO4K022058;
	Wed, 10 Sep 2025 06:32:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd153v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:32:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A2eCcq017218;
	Wed, 10 Sep 2025 06:32:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmeusc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 06:32:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58A6WSM019923386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 06:32:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E42B20043;
	Wed, 10 Sep 2025 06:32:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD8E20040;
	Wed, 10 Sep 2025 06:32:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 10 Sep 2025 06:32:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 344B0E0677; Wed, 10 Sep 2025 08:32:28 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH net-next] net/smc: Remove unused argument from 2 SMC functions
Date: Wed, 10 Sep 2025 08:31:25 +0200
Message-ID: <20250910063125.2112577-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RzCPh5cJFFQDsUnJkmlDi6_gXhtsanvL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX1f/UQ9GV1+gJ
 38F6lTtzQu8ioz4HntSQdlqrJwYG+M2XfMVSvIsr6l+ytT2deOl02W9GSVvEoWJm+jqPJwU9Cj0
 m3Ps3vY7dvmZ90zmC3AfiVH6NKpz11hc2KVHL57/JUumb4KSt0GWRIuZHaVv6CjzYuP8WWW8cdg
 DBI0Qa9QfjQNNiKpzhdF3txQVvWl3X7sWG86kREPDHDH1l0Fv2joiKvilyatroI5gmuj6sS2H8i
 yvpaCJxaj8Ztpgy4jcX5xm+k7qes/iKc7Lrx8Lz4k0ku1vJkDpPE1kE4cUInQ9MMk6Lbn+yr4iw
 dRYRpbmBwkc2K56rNYMxHucDsCg7/DXOFAZ5RKIXdBppVRvyGlUKtOf5mMZKtdgMb+hKt/tEcgg
 vpIv5ifq
X-Proofpoint-GUID: E3b-I3fBK_IaxpB_Dr-QaPh4cTOyJmXa
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c11b81 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=SRrdq9N9AAAA:8 a=XXhYVPmdku_RaRXcbhIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

The smc argument is not used in both smc_connect_ism_vlan_setup() &
smc_connect_ism_vlan_cleanup(). Hence removing it.

Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
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


