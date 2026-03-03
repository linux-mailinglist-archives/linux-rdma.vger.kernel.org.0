Return-Path: <linux-rdma+bounces-17417-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNzqOFi5pmk7TAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17417-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 11:35:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5B1ECB4D
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 11:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F00D330B19E4
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F15239023C;
	Tue,  3 Mar 2026 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T4vDlGhL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0819E96D;
	Tue,  3 Mar 2026 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534055; cv=none; b=ZV0/PV6x03nYwSlcVqvNizeypKSZxGiJg++XfTdXpWtlMxQz0+ibl2SOK1eu3obgaEGzsTifQpEYh9EwnjBy8lVpqylUcxFYvmGr0HF9NpHJtbucJ5J9hcQOv7XUOoWsJ1VTyosvBcZ5EJeBAl9F7YVjy807xv6vW1gImEkT0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534055; c=relaxed/simple;
	bh=oDrNevPkvqqMEpieXOAsHDn6TXgbHwiuvrvEtRtELBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P0h1fd2RpNtSdZyOqdXTIUa97+gEk1BbHFvcXGQcnMnuqs1BwS0Gg13RvweBOvzay23+26wMju8C1SiXFnNXyGaKXVmbwCvnv7g2d42ebXrOyXx5gqJtk3hJenEHmPy5Pb7F+qPrmZA3jJSTwdktyLkXTx9mTNjnZRVPmDXBLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T4vDlGhL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6236iduU2167523;
	Tue, 3 Mar 2026 10:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=utIdR3GXOhbcnpq912eY1lubpCZo
	9Ksbpf962jtL08Q=; b=T4vDlGhLdJNME2gJWFz1Lrq7RQapj07jLTXWStnJqb2S
	4+F5L9MZj7G70pCwqoSxkXdoh2iKa85W0QcQCdZe+1hf1G5+CKHuPkkjPfHy/UE6
	bOlM18VsimQrR9c0IjG9QQtrQfuyENUAh2frdN8rSL7atIF/9GUOBqQaQiKXmGFB
	x5SDY98b6KSeFFcPe/o0/X6JzPHSEC5AO+8O03LG+5GP8+bqaGYXKpAbjewmuhTj
	+It9kCocprAbpL4jlO9vzH5oEvvkSZDkaU42faWudVIGFte31imsZNJf5AkCGCoR
	UqNB7K0qlnWwfqowb4h5OK5RygdJY2pHo2iS6fLJ+w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbt82j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 10:33:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62398VnG029016;
	Tue, 3 Mar 2026 10:33:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaps202b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 10:33:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623AXtm129360650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 10:33:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021F720043;
	Tue,  3 Mar 2026 10:33:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA15320040;
	Tue,  3 Mar 2026 10:33:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 10:33:54 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 03 Mar 2026 11:33:39 +0100
Subject: [PATCH net-next] net/mlx5: Allow asynchronous probe
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-parprobe_mlx5-v1-1-18194f2a1a3a@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAK5pmkC/x3MTQqAIBBA4avErBNM+4GuEhGWUw2UySghRHdPW
 n6L9x4IyIQB+uIBxpsCXS6jKgtYduM2FGSzQUnVSi218IY9XzNO55EaYStplenq1moDufGMK6X
 /N4DDKBymCOP7flofUl1pAAAA
X-Change-ID: 20260303-parprobe_mlx5-d10d2a746d3a
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aWjlHxNs5CFXt-zwwUAnzBxvShN87EDM
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a6b918 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ij1ewOFO8_1s4h9LyxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NyBTYWx0ZWRfXyoE4OX3HOLO0
 ZMGW32NAFORv7jfmLO4n+Eh3IsMgf2qxnWFwHNNnlvDfhf+ZETpMXevuGLlFlGQq2bbgue32Sr0
 rvZYeKRSB5KcS7yD2gGk+oZCoVuHNdsJc2I2GUr6s5nyoNq0pRpPDiNsRj634E4pa5B7NSXyCtF
 30eGM55Hc9GT3U1bL2br/7WR4H7Dg4bZv4XeU2razgFjR9hJW7fvMAObecvwjGVuOfoBPBIIuq/
 xwYdHB5PjxVOv7jNvp1/Wa0xKGShtrPlGThOJKQyHWmMLI8M8LldVpaeLj4PYf90fqzEnzVCkkh
 Ec7Iv2ZFrlMP5c6JcdZAQJqwYfxtkrLYorxDfO1J1RyiwxEi3MqHgIReG/bWIR8TOhqn8uGVw4+
 scka0B651FQJDApW80XmMgAcp3FnIOCcB+lycHFgxcASyxa2la+IrLxP68qaSn4+Wix9e1uYTPh
 xKwdwEA8vWj+rTUfxcA==
X-Proofpoint-GUID: rBXA3B8Zx2rtH99qfTDovVJzbFOuOMqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030077
X-Rspamd-Queue-Id: 90F5B1ECB4D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17417-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

Announce that mlx5_core supports asynchronous probing.

Tests on s390 - where VFs can show up isolated from their PF in OS
instances - showed symptoms of "mlx5_core: probe of 00e7:00:00.0 failed
with error -12" when booting a system with a large number (> 250) of
Mellanox Technologies ConnectX Family mlx5Gen Virtual Function
(15b3:101e) PCI functions.

Turns out that this is due to systemd-udev's time-out supervision of
"modprobe" killing the sequential initialization of additional functions
if probing exceeds a default of 180 seconds.

According to [1] device drivers could (slow ones should!) opt-in to have
their probe step being executed asynchronously - and interleaved. With
the mlx5_core device driver announcing PROBE_PREFER_ASYNCHRONOUS as
proposed by this patch, we've measured 275 VFs being probed successfully
in about 60 seconds.

[1] https://www.kernel.org/doc/html/latest/driver-api/infrastructure.html

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Hi all,

this patch helps to speed up boot times when there are a large numbers
of Mellanox/NVidia VFs in a configuration. Although we've seens real
issues, I'm hesitating to declare this a fix of commit 9603b61de1ee
("mlx5: Move pci device handling from mlx5_ib to mlx5_core") primarily
because the concept of asynchronous probing with commit 765230b5f084
("driver-core: add asynchronous probing support for drivers") was
introduced only later.

Thanks,
Gerd Bayer
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index fdc3ba20912e4fbc53c65825c62e868996eff56d..b53fc3f2566acf5a07cb8df649124c4a87f3e043 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2306,6 +2306,9 @@ static struct pci_driver mlx5_core_driver = {
 	.sriov_configure   = mlx5_core_sriov_configure,
 	.sriov_get_vf_total_msix = mlx5_sriov_get_vf_total_msix,
 	.sriov_set_msix_vec_count = mlx5_core_sriov_set_msix_vec_count,
+	.driver		= {
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+	}
 };
 
 /**

---
base-commit: c69855ada28656fdd7e197b6e24cd40a04fe14d3
change-id: 20260303-parprobe_mlx5-d10d2a746d3a

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


