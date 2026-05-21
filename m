Return-Path: <linux-rdma+bounces-21128-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PwQHwYuD2r+HQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21128-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 18:08:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4EA5A8E91
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDD3E33B47CE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CC318B9C;
	Thu, 21 May 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N62VWbPa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AA2C08BB;
	Thu, 21 May 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375415; cv=none; b=WR2HwLpraJNxf7V6I3E/FPxzGCsjYHFHWKxEkbLTSFn8EkVMgp+Z8KfOHrSPLTPzty5gnUMbFKZVNvjuwULels5Y3Oh1LAnLiVsNJMPFx1Jn3Fx5py8g/uqAdCwqSdzwgHGQsj8lif6bnZ2BqoT8WgZ/oRCpDjiAvb0WHhixmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375415; c=relaxed/simple;
	bh=xP7CJfTIejAfdAVRGd7RMiJaOviQ39NVPwTAMZglPc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfoTI5E9hnR4h0Q88DjEaWT4i/DUhYZHyS1HUiV6fuAJZiYJw4WtGGHCFx46QxHQPK6UCphzBrArdkISrF+JbvCFl6mPUOTVrcNkuQ+bgYJO19PiyA0i4MF2hTAeyuVAFNeebyrD7DgC/vYkUqIcAyNakArVx4TMs110GpX/ivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N62VWbPa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L3da8t032105;
	Thu, 21 May 2026 14:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Kd79+Q8RSCIQ0lsnfK7NO9/obXTHGBJwUeTnn628b
	+I=; b=N62VWbPaDEz4nz3bA9AudgUakA8dqtW28JtoctRCummEn4jkLM5igPjhw
	q6/ih9S91ZG+qZcFZiADa+MGK7NzQeiJR0Lskh+WAkI+8zAa0BuPsFzTmgzSDcq3
	lf1B5NUsklqHR28ImBZwVo9flCr2urPwlesjNViLj5eMiF2avlj5Y91Maa6/Wgaw
	iPJer2ToSGTSgNiWAis+9RtGnlDM106Q1SqAPUvGxG0vDme1Kq/cBPVHmxcjIzTt
	kFrd6T6EACi10eNDcXjzIqWtxzL5YcX66ECIdLlX2STFItNbWxngFx6WrIC3Yvd2
	lfvZrwpPfGHjb/vvUJ5XV/xLLHy9Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y7pnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:56:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LEs4DH009243;
	Thu, 21 May 2026 14:56:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kycen8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 14:56:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LEueOD52036046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 14:56:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23C7820043;
	Thu, 21 May 2026 14:56:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF1F720040;
	Thu, 21 May 2026 14:56:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 21 May 2026 14:56:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id C57DAE0616; Thu, 21 May 2026 16:56:39 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net] net/smc: Do not re-initialize smc hashtables
Date: Thu, 21 May 2026 16:56:39 +0200
Message-ID: <20260521145639.10317-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0NyBTYWx0ZWRfX/kxxoe6h8UfU
 Epd7Gj881HoLcU8sXRhxtNE3nBhwiO1q9e6i5qrTwTwjGDqXGcf4D57Lm/Pa+9oD2H7CS5j6kKw
 88EqYnbjgH9D4YwPSeYUCv5JH3JE6U0lfk7VLs1jvWhREYiKW7e7y7TmzNqoPJJ7sNx/zBf3kTs
 sfLYiRDJ/yC/1HKPHtRQpsogZXrxPGou4Pohh/WUnPCpVtFAkToN1NT2ii45c7B9vOrMnvjN2u4
 qZy/h5v+mFmvK0WclXdAsDSWlxViciYj1kEr/MAoJjseL46UkhoMI2eKadZpjb4qq9vEd+Jxvad
 IMBHLMZ/7JIR+F01qOppWkB76NB4bbJ5bZXRW9MMPLHnjtK2lEB2648n8q/muLObq0mlF+2ay0f
 IyDizMpA4glKft8vW4e4IFmqoC02ntzqeiUPyZbu63dv/wy3LUrnKL6niMkHDTcjliwYniunX+I
 944H2rEWfOvNF+u0KVw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0f1d2d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uTnNPQT6LuAJtcTOVOAA:9
X-Proofpoint-ORIG-GUID: B3MXXNGRvlM54cfMsoXrQImncGPKtHLH
X-Proofpoint-GUID: vIn2PzKk3D7yKdajrNTis6jZyufV9kcl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210147
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21128-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CE4EA5A8E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

INIT_HLIST_HEAD(&smc_v*_hashinfo.ht) are called after smc_nl_init(),
proto_register() and sock_register(). This can lead to smc_v*_hashinfo.ht
being reset even though hash entries already exist and are being used,
possibly resulting in a corrupted list.

Remove unnecessary and dangerous re-initialisation of smc_v*_hashinfo.ht =
in
smc_init(); it is implicitly initialised to zero anyhow. Add
HLIST_HEAD_INIT to the definitions for clarity.

Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
Suggested-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
 net/smc/af_smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index dffbd529762d..b5db69073e20 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -188,10 +188,12 @@ static bool smc_hs_congested(const struct sock *sk)
=20
 struct smc_hashinfo smc_v4_hashinfo =3D {
 	.lock =3D __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
+	.ht =3D HLIST_HEAD_INIT,
 };
=20
 struct smc_hashinfo smc_v6_hashinfo =3D {
 	.lock =3D __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
+	.ht =3D HLIST_HEAD_INIT,
 };
=20
 int smc_hash_sk(struct sock *sk)
@@ -3517,8 +3519,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
=20
 	rc =3D smc_ib_register_client();
 	if (rc) {
--=20
2.51.0


