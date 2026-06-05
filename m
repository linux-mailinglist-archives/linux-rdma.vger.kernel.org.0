Return-Path: <linux-rdma+bounces-21869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yScCNwUSI2pxhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:14:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F60764A79D
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:14:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=sxe+DDPo;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21869-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21869-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8972C304DD0D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02E3A0E8E;
	Fri,  5 Jun 2026 18:11:57 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B263A75AC;
	Fri,  5 Jun 2026 18:11:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683117; cv=fail; b=SJnG2pHXX3S1Aw6fPiSUpOcaaswOLjmnFXzWErejh0SbmmcLg9cBsRp7AC6HIEw81sWWrwv2nnwCAp6I+n7R1rqmzPG3AyA4Bp0Qi499aVU5bEPXbaVeZI0ytk5YMBd04s73aeuF4dUNI6x5KHiJ+KKGpti+mChzlIaAAekQDtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683117; c=relaxed/simple;
	bh=XUdKELfHR0Vvjr77yA1zFiETp3lbfz7SjOS2SNNHBfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZkTVJq5ntGoSyptzEoY0OEsRsGnjiSe+/laj3rWU8gUcyp4PKXMAmNCsYLQy+jBcnfDu13veZm9H7uav0qn8Tq+9AlEWamy+uXE5ZJsNvghE99C+vtKmlVU0A5LlDxFi+WMimeMroSWvNPu0xQJCPIUBVn7tu+8r4erAq6k7y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sxe+DDPo; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo8xbONn6y/D/JWnK3BYmNV7Omd4f2PvYOKJlTLGbr4s+yfJnsTHl37NUW/SlSuhjb1XAYDs7xfl/cJS+i2Fb4dWmEZyallpvE1Pr1mmB/Aujak2XCjXmnMAL2F4+6hPaE06K45l/sanp54Se6RRlEGOD/V7CwzEtd9IyiuPexsIApqcpCP1zqENkbNVSGDORqH1PI0i8ZaDmbbayNZ/tHMWnpK1rN6m8A+iEaiJhGCAwqv8TcZ12crreNHn0jpCbbnJHgky86qwfVBMAKqvzXhjbzDiy5iolIs7BocXqFrRxfIAzlqYL0XCh+nAdY9uRFyvko5NT8LTkzX0AWFgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8LzT1SeYqLnJp7n0ocDF14XXGV2gFKqtsGqf5mcRRU=;
 b=raNfmtxNXfvXpG3FE8e4aTTD0rllT0sdmuax08u4HCUqFAZiPtyLhzk9TjbqOPTTShiCUnTKSj/dDNyqwGm6FMmEugzWUJSI3vfoQOPXFsZ+RiliY/5OuSk0s4Qf4AM7qxjR5455/IZpgluxsg+amwPibaK3akjcB5f7SR9ljbfpUV3HOCUwo7FRj9GVpHpbxrUda18Tjx+wnNuTWrYbEroFxnKuTknFAFPmYrF9aCZcw8xebJwu2T+fkIgk08W78yZG1I7Sn7XnIrsXVF9okMWOeSGBpNepafKqQ4obiIG3pEjkeDZYoGg88JixiXCmQrVEWyuvL1b9WVQ27Wsh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8LzT1SeYqLnJp7n0ocDF14XXGV2gFKqtsGqf5mcRRU=;
 b=sxe+DDPowi28VXsguaBfPfcaywAhbjg10sbxbhUZCnSGFghGAMo9/sqX1l9M+hRjDHwumCgCIDmTG64cCg1XxTN7qLdl918emSpXsq1a2G/uXTh7/+5dwTQ+VUFBvTRlGiw45zFANQ/K8x7DOaI8cMVxfG42MY+aApSF0pcDhWOTB5qgz1SfNDbhoCu13gvLr2Y9NKhETdYuMLgEUKv101gjyk4NLmjI6Dp3JJDoulDMc1OHOCNeKisttYdCQlkE0/vqtUdRrCfRlAeUWY+U36k/jt6z7K2FfZjgIMMoVSc7V0igG65WCm/CXDnm5rznZzjiT0tQew978Lkfkr0AjA==
Received: from PH7P220CA0069.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::18)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:11:50 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::1a) by PH7P220CA0069.outlook.office365.com
 (2603:10b6:510:32c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.10 via Frontend Transport; Fri, 5
 Jun 2026 18:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Fri, 5 Jun 2026 18:11:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:11:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:11:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:11:18 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr Mladek
	<pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Kees
 Cook" <kees@kernel.org>, Marco Elver <elver@google.com>, Eric Biggers
	<ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V3 5/7] octeontx2-af: Register devlink after SR-IOV init
Date: Fri, 5 Jun 2026 21:10:28 +0300
Message-ID: <20260605181030.3486619-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605181030.3486619-1-mbloch@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 991af997-5fbe-437e-652b-08dec32de9e1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	WOD9XKmi1mIAlyrt3OuZnW2VlCIwrv/zsxf907axEY0+yJOeCNRA+PeIXhfi7ECKgExMHmqfqtkK0NGqwAMqUElbhClxoo7OlvAIGtbcArjs0xc7Bqiw2BSXlf4wzNhR3hQow4q5eS2X+nJcyjN62yWQDo9cShuKq0NmxTq23ud1m6EhYXT5CnO8FbIrA0vFVmZ+HYlKL8J4bEWFGKUgptmxvGiXr8u2imq6E7FDLeDo9LCoToE9VsDkslLo7uqMXGnWhpuMIrxA6cN6UHdr94ofzGdu4lL5MNETKBUUPzxQ9L0NrjxIpn9ojnSzh/CQr+NiajRb2A47r/hSg/gi+gDnwmiQl0BrnMYpJMZF7jASx3Or4ZaL4cTuktR17DaUYDd63TNvZBXq7MxM5rkZs6TyRkwbRDutUCxL5T3AlfoI3NgwvDtC0dfJbqnCGk7CkjQAoGz+t6I4i2GanQAHOEFwafQuiCEXcSyE4HPzVkQoX90z+N4wgx872HlyL1L0sKAUWJRraQ+hrNK3gRrWzCaNIY+nyQG3s81qsKW+rO7VZU0MOFdiex3w8Eudv0MEKWBkKV4kzC6bN+D5R46nkxy2O9Sr/gutFz+pzxmtw1xuJzpFdSxNeHuHetwJPww+1LW5pSaw0zoe5q5WI3q41ysQf/BtwUJmK+2B2IcD9Ad/Jw+UREsVWvBFRb+P8NuNUTvkhUqXFNE5DeWAKKYZqjtVuNQ4Vcwf+T5/YstHPdU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5xC8XNgVSNoZmHewh6fhVtU6C42NyHorVq/57G0dBJ1m42T43NmoEyLdjOTnh+Za6FabFe+qm/lLNWP3fa+o4qlFPZKovMGPd3443EJDL8w8Zv7xRhSPD3D3ybj5r6+ee2PZIzqJeSprVDmYQdSneLywSS+UNp8IV/sum5xukNEmh1hJqBa4RaaQrWP3Ri2Ry4/JyBMAK/RwyIDkzjFeQ43edErrkNTOsLDfXUOR636jXD3Bqdh9b1CJMQOsVyzvIz7j8Tp1hzdTrdID21LhG9dWm5vfaaAJuYKWs8ws+Ah9xUkiV5IO+cOalj/Z7oMyh7U6O2N8YxfiVOuF6dLKq+l4AVftwYqMfPyd/GTnVGaIclfn/RF2w2FfLLleu7rNV6EvjhRO6lO/z4Hx2/rY40TLg+35NsHGbikHTbT0h3HJRYJLY3vwbmGuQmFBX9oH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:49.7348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991af997-5fbe-437e-652b-08dec32de9e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21869-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.intel.com,linux.alibaba.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F60764A79D

A later patch makes devlink registration the point where devlink core may
call eswitch_mode_set() to apply a boot-time default eswitch mode.

Move octeontx2 AF devlink registration after SR-IOV is enabled and the
representor switch lock is initialized, so the AF eswitch mode set path
sees the state it depends on.

If devlink registration fails after SR-IOV setup, unregister interrupts
before disabling SR-IOV. This keeps the AF-VF mailbox IRQ handlers
synchronized before the AF-VF mailbox workqueue is destroyed.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3cf131508ecf..c2b52eb4ffab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3545,6 +3545,7 @@ static void rvu_update_module_params(struct rvu *rvu)
 static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
+	bool sriov_done = false;
 	struct rvu *rvu;
 	int    err;
 
@@ -3634,26 +3635,27 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_flr;
 	}
 
-	err = rvu_register_dl(rvu);
-	if (err) {
-		dev_err(dev, "%s: Failed to register devlink\n", __func__);
-		goto err_irq;
-	}
-
 	rvu_setup_rvum_blk_revid(rvu);
 
 	/* Enable AF's VFs (if any) */
 	err = rvu_enable_sriov(rvu);
 	if (err) {
 		dev_err(dev, "%s: Failed to enable sriov\n", __func__);
-		goto err_dl;
+		goto err_irq;
+	}
+	sriov_done = true;
+
+	mutex_init(&rvu->rswitch.switch_lock);
+
+	err = rvu_register_dl(rvu);
+	if (err) {
+		dev_err(dev, "%s: Failed to register devlink\n", __func__);
+		goto err_irq;
 	}
 
 	/* Initialize debugfs */
 	rvu_dbg_init(rvu);
 
-	mutex_init(&rvu->rswitch.switch_lock);
-
 	if (rvu->fwdata)
 		ptp_start(rvu, rvu->fwdata->sclk, rvu->fwdata->ptp_ext_clk_rate,
 			  rvu->fwdata->ptp_ext_tstamp);
@@ -3662,10 +3664,10 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rvu_alloc_cint_qint_mem(rvu, &rvu->pf[RVU_AFPF], BLKADDR_NIX0,
 				(rvu->hw->block[BLKADDR_NIX0].lf.max));
 	return 0;
-err_dl:
-	rvu_unregister_dl(rvu);
 err_irq:
 	rvu_unregister_interrupts(rvu);
+	if (sriov_done)
+		rvu_disable_sriov(rvu);
 err_flr:
 	rvu_flr_wq_destroy(rvu);
 err_mbox:
-- 
2.34.1


