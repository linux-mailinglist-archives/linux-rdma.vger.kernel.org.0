Return-Path: <linux-rdma+bounces-16780-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULBdM2isjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16780-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:33:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F352012C879
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 065B73008448
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323C2C08CB;
	Thu, 12 Feb 2026 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dc58XHUM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABEE42048;
	Thu, 12 Feb 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892387; cv=fail; b=Nx/WfLl4CdxecihL4r60QsWf/Af+Bip4Aq0ThMYdAYE6yjvgOBz6CI2XPnOURbe1F5dZv1Gv9DjM8+9fktJFV5ux6wo4GBtW6LIi7uF5bnL7Sqslh8kDgXvOHwBfLYVlb5ldzpa2mw48aqXPI18FC6bh6UpPyqST8u5AhCjrK5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892387; c=relaxed/simple;
	bh=NmGd8s2ALKWxjpapO9COXJ9I9Do1YKSwTbubzpeFP0o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twjf/Td/6A7OxT0c9VEgaeBhTZtyd+PJCOrcfKPozimhglkJaj0ZTAlNSxSzy64ghQj6vKBLZXF1/9tr4nJey1Nbulx4zpukjJ5vem48I8AjGHiy/5n2WZ/AqGmMQH8wLmfLl58/Ur+q/iGAu3pHwADmWycT43zX9iZjRZqXXL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dc58XHUM; arc=fail smtp.client-ip=52.101.43.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFsEB4KPW7EvgGox8uZskXH1zcvG6e1kb/szZVo34mPBKySne1a61jm4N6ZpfYgSDKwxsNPfY5rE01prHJrBk2UJVVGA0OFJenScyWghMPWnPNHcDZZy/GuO2pm8tTBc6bBE/7SGc42xSvO28WZMoul5HU+jGvB1LgamdQbrQyeVR6OH9emnNK9CvNMgRRVqfgG8dB/PgGElwZImZdj4Lk8U2IgaLBvRX3513DqjFOTkGcq6PdVbXncCQRHfzTFMrdNUFsXG8NhgP8mIN3qaj9jYIBOukU7usNLfOqXibOxzYQIHpS3o3MPX+GQWFiUIEcsom2rAQ190Gdb+wpdvOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2kuuzhtSc0aaECCuC3a2QVQisn/Mpt44u/YzjJeMDc=;
 b=Fj6Bi2Wgtg+JwMNMPhM5qEh7TSO/ZOjGRhMELSE9zUv3Oqguv592fsO1Jf9GOaAWW8/ENihS2mdZX4LIL3IGT99k8BUtplJFi61fi+s+iWki7ohM4XAoMjagS/G4Q8+OE2+2/iip1K3yEQliCI7TmUaVHfah99Ke5uP4J8GLZ0X7WKLEeqLaG4CmKpxsOwz5X9EjdAfd5nx2GDY/t7fipXV/zxt9hQ5cKn9L/Vm0BQr/NhPdrtTKgMe2wov3fRpPWQAcOMeNHLg+x4mrpvO5jQgF7bm67BYNQruZ0X/LrBLzGfRdSH5LJBAXwoshSGTHZjrujII1oZaNP535yq9OgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2kuuzhtSc0aaECCuC3a2QVQisn/Mpt44u/YzjJeMDc=;
 b=Dc58XHUMDlMLR/KQIJ/GId+5/e8WyskdL6XEqL6Yn0NNXL2XxBIwN2OCt/E8gUV9YoMTU+gljRwVCk8UG5to9vuzoLWr4jLe3RA/KNJKtu3T1pYztA/ybgbJG/9WlwWUTMjSlTRNhXk0FTH+mUw0lxrMakZPib7dpRXkrMPJQbyFR/SBkjehfJ46OyekkxH/896yM1UfRou/eq79bTGy+1QXIsJwKGlQ9NRy+PyNpp0DQdZo3ig2yuCUE0YPJ3r7b7kfEkAMmldq7SF6zic6UUuKqZnLujmpJSfEhXFk4GFWYpyVHtxC1NbNR9lcmvwqM0YFoyCBcQ+w9jpTMwHdwg==
Received: from CH3P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::13)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 12 Feb
 2026 10:33:02 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::3b) by CH3P221CA0028.outlook.office365.com
 (2603:10b6:610:1e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend
 Transport; Thu, 12 Feb 2026 10:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:32:53 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:32:52 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:32:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 0/6] mlx5 misc fixes 2026-02-12
Date: Thu, 12 Feb 2026 12:32:11 +0200
Message-ID: <20260212103217.1752943-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: ce25d16e-d42b-4e6d-f7b3-08de6a22197e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K24veEJ3Zmg1RXVESmpqSjFKMFloVXBUZlE3bjk3MFcxcTFEUEkrbHoveW5E?=
 =?utf-8?B?Z2FpczdlaVBzUkZCY1A2NHRrbG9rdFhzd3d4eDhnYiswUHpVWEl6eGJhVFlT?=
 =?utf-8?B?NlpmUVZFWUtpTGxRUjU4R0VxVTBhd2d1b0FrSkx0WjY2dzhuWDRRdGw0blpD?=
 =?utf-8?B?Q3hlTmVBREFqZ1I5WC9OeGhsVzRIbE4vMnpnU3drbjhwSkpaR3M2Z0xHMnVU?=
 =?utf-8?B?amorbGwzNmlTa29LVkVISlNJVnF6WDk5N1JqQ0xBT0cxdU1SZFBYR1cxNU1h?=
 =?utf-8?B?Z0ppUkMycmJRU2xqQzRwN2lGZXY0S2NNbENSRURYbFVtN0pWUkJyb1NZQkM3?=
 =?utf-8?B?RWVla0ltTFJCZWczL3VUaVpGWm5xK09ITFdxQkdBWFdTUDVLWlJ0M0E1dVll?=
 =?utf-8?B?ZG5XUGdSQWQ5ZmxISGJaQUtlN285WGVXTEt4c1JLcDNVT0g3Z1BGWVhLbXdD?=
 =?utf-8?B?bkdISHVZbnpRcUM1MFBrakN3RkMzWFBjOXh1eHJUWEFlWFZoa01ZTVUrMkt3?=
 =?utf-8?B?Z1BQQUNlNStlSFJSWktWcHNONEpQMXJSdm54MmpSRFhCOVpKam1kL3BzR2Uy?=
 =?utf-8?B?K2txcTREVURZbm9UTXQ0SUpiVnd2MDRNUkdORDJ0VnJGL3JiSlRxVVdlUjBx?=
 =?utf-8?B?VEFSWGM5NlhWMzZwVlY5ekVDQlk4eWJtNDE0L0krM0F3TzF4VlJQcDEwbEgr?=
 =?utf-8?B?RTZmTHlzMXlwS0NTVThtdFlFdDJLNGJNZW9FaXllVkZ4UGhUaGlkYURMZjl1?=
 =?utf-8?B?VjErWmRsSWxGQzVUZFpSZ05hZlJpY2xZVWMxSjE1ZmtxQThhazVsQTVIOEFw?=
 =?utf-8?B?SE1MT2d1UkNFZHZxeGpNdDRERXgyOXhFRnZ0a1lYcklHcVN6NUlnY1B4Kysr?=
 =?utf-8?B?NC8yZ0Z3eDJQZXdoSHFRQ2lmZTVGRGI3aHdyMVhtSzMwUnRWT1JocVN3K0Rn?=
 =?utf-8?B?bFdwOUVJRDM5SHZ6bXhJVVJhR2pPWnBEZDBWU214OFVrZmFieTVxdWZuUTRU?=
 =?utf-8?B?NzhFbVZuS0VkdVNWemRaaG9wUWVickhIRHpCTFhEZVBJOXpDeW0rNld0Y3FS?=
 =?utf-8?B?YWhRZE1OeURwdmp3UEZkeGF1QlVyWG5MYW45UXh6VEhoaGdQdG5QbS9wTExS?=
 =?utf-8?B?ODlwNWJVTjBsTzBNSWZpZWVES0xuWExraCsyUDhBa3MvN2IzL1d2bVJ3WmpM?=
 =?utf-8?B?OENBOXBzRWN4TitRY2Zua1JMdnhpQk1ITUI4WndVMHp0YmlxU21xQlR4eDd1?=
 =?utf-8?B?N1RMamRYaU9MMkhsSTFJRHFaN05Gb0ZFRytaYklzUGdWMEEyZVlZNFNuWXVj?=
 =?utf-8?B?cmU5dG02UUlUMGZDdDJZV3hhcVJ4ZXFpZTdOdVROcktTY1NGVG9CUmVWM2Vj?=
 =?utf-8?B?dnp2R0FBOExCODN2V2FmYVlRQ2NFRjdidWdYYk9vRno3QmxYb0RLdENmRmlV?=
 =?utf-8?B?bTZTNlM5R2tpRC9xekU2S0IvWHNiTEhGOGh5SzZHUDBvdUtNODB6WU8vZmR1?=
 =?utf-8?B?T2tDRXp2dmFyYkczcllmZDZVZjlXY3l3UExaRERpUUkwK2xlNDFRaHYxTTEv?=
 =?utf-8?B?Ry9BVmwrRmFtSEk4K1d3QmxEMzdZNXVQQ2U2bWNud3A4OTVRdm9hdytlRVlt?=
 =?utf-8?B?d1NXcHo0TnZ1UkFzZ00zVGs0MUxHbnE2Nkh1a2t0a1NVak1HMllZY2s1NDFJ?=
 =?utf-8?B?Z25HdXdBTTFyNFo1bk9QbW9Ic0dyWjlYY044OGlEVEE1ai85bXI0UElFWVV3?=
 =?utf-8?B?OHArZ3NLbjJza3NyNEFDKzFvVWx3Y0lyYjBxWitvb3Z4RWdGNVBzaGhudWh3?=
 =?utf-8?B?QWNRS3RCNEMxWnVCa1BhNVJscWhHUldjeFhQa0JLMkI2Vy8xNUJ5TlR5eUlY?=
 =?utf-8?B?ell1RlkvbXMvL2FabjZ3VWZrQWpyWG9jWFo5dFB0RUZDdjJtN3hDRHNzOE11?=
 =?utf-8?B?ZXZsWHh3SjlwK2xFdXNEd3lJNFVMcmNLemhSRExERVZDYTkydGV3WjlxWTl6?=
 =?utf-8?B?VkZMUFVhWEljQi9uZ2lMc0RmWjJKbzBDVXV1VFJIQ1RsQm5IazBqY2hLc01o?=
 =?utf-8?B?d1VtOG9oTmdOa2JxTWMzS3dsZkJYcVlvUEhQSkFqRWVIUzNyRWZzMXpxQUcy?=
 =?utf-8?B?U0wwb0JsWGFhbkx3ZG5CdjJIMThaM09IRjBQeWVSM2FKbEhPdmFMV2FWd1V3?=
 =?utf-8?B?eEU4ZElWVDNMaEdLQ2tJMFF1YXZrNjhTemNKWmVMcjFqUmxUaHFaK0VEd1JM?=
 =?utf-8?B?VlY5STNLVGsvZkNMZEtCNDdYMkdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	afvvH7dj0X8kop72TTwHBBXaVDfBwv1C4hctY5Nfyqabp49/vnGSzmGIBePF7m1NDBKyUlIh42F+5nRmLknOa/tMW9u5KFzQwsI237PHaVN5B08/p0nGqbez8utm35Lb4DWVPt0YxPp4C9GxFZ63ZS5g3I0VoIOX2xhFtDcNVfpuJVmTKzCxfMeAgsS2wG24b+Eh4/8zkpplLLJDqRtSdUIa1+i8DzS/vDjkosD74XC3c6uo2dUIvuKO0wFvNkgF0EDBJEbKuAFGFbjbleTN7vYAkusu7c5WCQcpxwlBZVSyhay8XiqloUHKSr+tGvR1GuizlIQcKbWSp0uxI1bS6BJkPsdJLNC+5gRz0X3fOZ5eviH3iO+CeAqt7wvsu/6a8fIjPadv7onKr5jmwAYpZxk36aS5s2tj4lhNVHQ58R8ByKWlo8d5A68ArTrqfsVx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:02.0639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce25d16e-d42b-4e6d-f7b3-08de6a22197e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-16780-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F352012C879
X-Rspamd-Action: no action

Hi,

This patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.

Cosmin Ratiu (2):
  net/mlx5e: Fix deadlocks between devlink and netdev instance locks
  net/mlx5e: Use unsigned for mlx5e_get_max_num_channels

Gal Pressman (3):
  net/mlx5: Fix misidentification of write combining CQE during poll
    loop
  net/mlx5e: Fix misidentification of ASO CQE during poll loop
  net/mlx5e: MACsec, add ASO poll loop in macsec_aso_set_arm_event

Shay Drory (1):
  net/mlx5: Fix multiport device check over light SFs

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 14 -----
 .../mellanox/mlx5/core/en/reporter_rx.c       | 13 +++++
 .../mellanox/mlx5/core/en/reporter_tx.c       | 52 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/en/tc/meter.c |  8 ++-
 .../mellanox/mlx5/core/en_accel/macsec.c      | 14 ++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 40 --------------
 drivers/net/ethernet/mellanox/mlx5/core/wc.c  | 10 ++--
 include/linux/mlx5/driver.h                   |  4 +-
 9 files changed, 80 insertions(+), 78 deletions(-)


base-commit: bf9cf80cab81e39701861a42877a28295ade266f
-- 
2.44.0


