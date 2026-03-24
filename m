Return-Path: <linux-rdma+bounces-18564-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GKSJzSEwmlneQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18564-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:31:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070030844A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 13:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB79630D9A51
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 12:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBDC3F7E70;
	Tue, 24 Mar 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dkUHMv2J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192C3F54C7;
	Tue, 24 Mar 2026 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355398; cv=fail; b=TYqj14Foz3AJREHGe0NcOUrNvOxIRRWMXF1KVCL1bTDU4C0g90IFnDqzMWKPsg1GUN37yiXoyEaa2QPLekMYd4uJnEsO+GyDYSSOFeMZTRNdBD0FwLH1SuCYCBgfwFlzPrIM32fad3eMjDWWAM84WPMdltF9H1fRh7UizfzPfp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355398; c=relaxed/simple;
	bh=Qfam0pjAJ4JeePHqpDMBCELXhaDmkDK4IOA556Vw1hw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/VZFnYAWojQft6h8RgEbOmbip4GgGD1fShHgOEGZp3D1jVpvruj0qDt0lH+1TWy/trfPnz3ycoxO+N1LEypfo2rV+xW2jzgu2Tf5WcaMiPzQBR9BjdGxNoEJAP4I+gdKHdoumIEaWvT80TZJIUd81GDpBYeF9LX5RcTclnPnQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dkUHMv2J; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9tkuNZW0jEnq2wBAWDahHq2rHGNSKqan5g5u/9XQUmpCvEpOrdGY7pa6X1f/+xh9QIZTzEyjc59K16kML1mJe+vShxPK+koozhzeVZBG2ryiNb+of+W8YjGPw0ETHPmACOC9uNgDWCR4EzGOkIiqf+q210QkmhNvjxOdyhfRXAPt9BkPBOJ3JjP3OXrz6WvGVOUeynOxwDRRV9CH7JT3SaIFwv9kkTInhKYLPtFjBDhSqr2+yB23cdEjW+XYrXcY+ArlHUu3OnaF0+dCT7OCTl1Y1QNeXgKBJZW/6RPEgaM7GtgCKz6JOMtZgJqW9ciY9h/SGSXAEcNcBZNX3Edgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX38ICwQbDUekLaBrN4+CPacgxjB1vtaOcFqnzTTwOg=;
 b=U8uNQP2qt5q8w7iZ0Aao1TMrwx4pEKxK9s3gdDbKHQoHT0p1vRuG7eg/h1wssPryncMSuptFW+v0LxGAiSAP+VnnVuywTPs0yuhMW6HCywRpIVPF3Sx8KnGv+aKG2KmyED/riHoTuLZr29vthWlrBIyFPs743PvotmVCeV8c/z+9Z3uSetYH1cYpjue/1iZlqMfQIT46cFTXorhxs3qDgTdMOyNURFsOTY+1NxpFW4mBdMlSDZua87KefDdiSzogfQnrR7APeC5/HJmOI0MoSOb4TQLls8JcbLnTmSHEE0BZWG3Rpgeuco4uGgbK3ovAo/ZwRe4WCTn6LGXhfNdVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX38ICwQbDUekLaBrN4+CPacgxjB1vtaOcFqnzTTwOg=;
 b=dkUHMv2JAjAB2hYEPbwCPW+UkzgFCAzGBzJSUpHZeYFCVPH/XOOmb+lkN5p3MQWKKdS3dFT1kW5oG/sxVq8kSy7dBTTomDvzwPrBoCdpvjsTldORrTqL4EO/OkFbrOw9UKM8d7x8ftpvWA31ROaJJmPl89Nk3TLHD08cFnbZAsaP0edDDH+zV4KkLkQX4qbfRmzAOcIwSXoKs8H4y4lXvtfd5ckyhAf+/ftrbKTxwAt1EZjrMSYbVjq1y/dB+WoCXCyAwLBXXGsqudEpxdEXVBlL+V92GXQNKtxJ5RtVJlGIeMkQjgPghcc+JOF2HEck2PPWdr1i+h2z3Y2t2uc8CQ==
Received: from CH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::29)
 by SJ1PR12MB6147.namprd12.prod.outlook.com (2603:10b6:a03:45a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:29:49 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::3d) by CH5P220CA0006.outlook.office365.com
 (2603:10b6:610:1ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:29:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:34 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:29:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Mar 2026 05:29:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, "Shay
 Drory" <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jiri Pirko
	<jiri@nvidia.com>
Subject: [PATCH net-next V8 01/14] devlink: Update nested instance locking comment
Date: Tue, 24 Mar 2026 14:28:35 +0200
Message-ID: <20260324122848.36731-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260324122848.36731-1-tariqt@nvidia.com>
References: <20260324122848.36731-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SJ1PR12MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 57012da9-0149-4031-c0c1-08de89a10a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	kFlKwX5robKviFmD2QfB+TfW6zblyZMrA5IXDOWExZ571DnLgDGe6jzxaz2ligK1RS1bwDwOasEy0iS8rELgPyNur2h/3A60Pmo5RC1MiK18qKI0ywTRjkdj0ILMhGLf8uN7Zz6mxsG08AmqgigcVP3SOze/LpfLM5iQ1GEm1+Q1NykpfK3jsQwmyweRlux7kh/pu4SzULdM11UXoVXgccV/boz7DI7cw8wmjLgazbPdWiXJuOeyCUa9kiKOCkelYG2N9xKZYiVW2zBW4ArIjAZ0JTSLtrx9Jt2CMVyHpab7RzFUI019vN/3P0YjHHSDYSfYIWm8de2jyylus/cY/QmfQHrUZ8Y/GosrYYozFG2lpZS7H/FCQWFD0HYzzIzAtcTFKRi/BrZBLatzYKIfXIxbLKSpi1rrUcY29P+9dXTF1z+b//vn4rW1aqPFzUjlHXC6q/oCoyBFLxjvb72wMDjYsTWsuEsC02HWmQoaFJAuQkTmKDFdKeIkMNHlu9+KBiPQU/YoWz+MBRY1H8e2Gp2GI1t4smIBbAqJqVqg2aov3orTHkT96aolNW+tj//rF2LnQU430dEavfb3fvhkgNIFm5hFffLNOR1pHeqbZQXNE/HtCmN+A5TUmF3eW1iB5W2iLk1dCU7iho0RP6Its/qvVWWJdFABTX1dcP5LZUyh0lOOIJ6qfnfqMVgBPFu8g7nIbNRCJ8jSuPFor9N3aPNOYJUaRVdrOrDWGyA7ZJBBJYOCv5+nRXxQx4m0IaPS9hDcSocFRwzgEKOV5RB/bw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7kkdt6SJyhE+9YtXTGEJMGw74eEVo33J3SJ+wQl92yxMTrB8ebql74nrgA/i3ZM0/9K+KDwaQWqOIlpIy6X6xWw0udVo/NLU+aob1FgOmKkpiwJ/4OkVOMxei5CBAqxG4oEDVwao8C8d9O8EEp++TflhzvNThuV9BUPNQ7YKw6neGJSiVQR8ph7dhjngtZIA3BEKoVjnlpieDerj4snypVR8YK66EILQR6rmsaaQV6HjPs9PAjbWClCtLRY1BN00WJAW6AO8KPe2KZQnthoS3URk39tK5hZT95wQVMrvvX+TmNqPRK2D4+pZm2uy0c17XcNTNCO/Pv1NFJvwMHbfs3u8TvCM2ybo3S1NbEdIh0w7yreIzthG5TR216rydR5trC3lBe2A14Mf7dPvq+Rw1miMM5bhSA4lRBRZuQGdmMg4PRtDKkEoFNoz6xAL1WeL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:29:48.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57012da9-0149-4031-c0c1-08de89a10a77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6147
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,google.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18564-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2070030844A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Cosmin Ratiu <cratiu@nvidia.com>

In commit [1] a comment about nested instance locking was updated. But
there's another place where this is mentioned, so update that as well.

[1] commit 0061b5199d7c ("devlink: Reverse locking order for nested
instances")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/networking/devlink/index.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index f7ba7dcf477d..2087c2de5104 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -31,8 +31,8 @@ sure to respect following rules:
 
  - Lock ordering should be maintained. If driver needs to take instance
    lock of both nested and parent instances at the same time, devlink
-   instance lock of the parent instance should be taken first, only then
-   instance lock of the nested instance could be taken.
+   instance lock of the nested instance should be taken first, only then
+   instance lock of the parent instance could be taken.
  - Driver should use object-specific helpers to setup the
    nested relationship:
 
-- 
2.44.0


