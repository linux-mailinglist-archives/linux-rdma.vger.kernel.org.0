Return-Path: <linux-rdma+bounces-16616-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SELNL7hJhWkN/QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16616-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:54:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20773F9185
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 02:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E73301DBB6
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3A19C54E;
	Fri,  6 Feb 2026 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W3XJzqe2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130A23EA85
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770342702; cv=fail; b=URE6FsnORp/KbCe+DOs7UnRSy3BMcTR8Qvmrp421jZ2e1DP00hxYnmUTQbELjhpr10xtXwdN+Yvhj/oY1tIHL5CZOhRf0h+bOOOZAGzo95oNt7DmgeCM7aiR+r8pesiAwCgLIdBYB82tzfqKYNKvQobbGB0yTZf0OlbtXED5qRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770342702; c=relaxed/simple;
	bh=8bxBa4C6eyYtDky25AKT6nQWlV7m5pY+5v+FRdCL67Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lcxoLzcC0fhltPryOmOFx7NdLbCkvipC97DhEZeMIISv1ByBJ1hCDzIMqraCgMFRZk2fiwkEzHSAJZSfbcd3ORckIPF7XlLZITcJHJHCl4F/6AowKuDgjLB3ThS+S3ufAVL60Z3C+ptzHlmqRxelaInynhWy2HfPjJw0E/zD34Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W3XJzqe2; arc=fail smtp.client-ip=52.101.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfNNsSHf3OyNSZ2YXHv9wEGjpcKkqAj2ED5hUy4fmvmSYIpf/2TSQlYymbJUp5Lxt5UTVS33kF4QqYQ4vM4S4Z6eWw+cjBS5VlnX7lja+lYBi1OLAc2GXzAbg2U0rpLl1SY+S29TFP5I5ddG3eE33ZSGjB5KmlDOqgfPmyvOkdH38UzkuP/ySL8nOrNoJFvIyc2T69pgFOjH8OEoveyQ8Tc5pHAWN0lPlCb5zfB/pg8G01qIp7VPAUJcMYd76W3zMLO8jB3k8d5Vyuqw+hNcBl6rf19R7+vl7kdZVTD6jRk2pEiycNubHWaNwAy9+aOnj7/IsFe+wY+bw5rpKQipAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0D3H2XcB+vYGVUA2pQZMtZOqjktwYko2FANrD4Km/s=;
 b=hSppUq69KYj9tyJTERzE2hIGghjxVC7L2D5kPAVP7poo3+pPcO7KjmczvUv0EZG19huOhX98C78R/GYX/CgOEOG/F9hRA/U30Bg3mbp05EFuxpp79laHEq1oqmnvsDZWfh0L4wSYRPoXKRyg1zmCJO8dewEo3Loeev7rtzUZ5tTkbFvNDDCenKdaOnbCAx29ndkUvEP3coGbHT95b/W+ViT51aRlOQ0JY/y52ugTTdIUvvj80CPEhJx0u1FQS5X8WvI3gzmRuALaestpK/iti+YPjw3+TE2ajJ9zUjddrnhaimN6NXH3XVJF6aXVH172J/KQ/c+dL5AlbJxTJ4+qyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0D3H2XcB+vYGVUA2pQZMtZOqjktwYko2FANrD4Km/s=;
 b=W3XJzqe2tGvy6CHggQxLAT8xBvaAzKBnF+96QsZ/hM1kGPjkBNA1bp1Rw9MX6gOQu/SUAFOfMjeZYlNFJeh+7WoPF6Tag3Lv5nD3okKfg+87+yKIbDsmzg4N/oc6Y2UMh0lwyfvNoSEcUM7adYh3ivsG55XZycLzoDRqHYQRtAIFDoP8SURBA3jcW8Xbe3Og9fi3OvAQK/IFr1qkYPYyS/d46juoTp3lNnWoY21SCMB00GHmL73m5esLUDzimWts9S3YJ3GMQT2gKjY7wsGPdiOTwpKKPFWuXxOpkWovKpfC6MdUKSAGEi8Fzt97Kbew6qOdfoG7sORT0WuNp3eTtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 01:51:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 01:51:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 04/10] RDMA: Add ib_is_udata_in_empty()
Date: Thu,  5 Feb 2026 21:45:38 -0400
Message-ID: <4-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
In-Reply-To: <0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 5363afba-9629-40a6-7219-08de65224380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hPqehdZulgYI9/CssJuS8J5Rj21QEXu1bVXOpvfuAUGgrpBCD4nQljlifvQe?=
 =?us-ascii?Q?SjKYeHJdT+lCCWYQU2bJrjMXE4jU7ylzt7ofXVu/5WprjIo076XkgULJVO6u?=
 =?us-ascii?Q?d8RPqT9vF+HvYoAjayC/HuFTY3ayQdH+Y08H0RhXnyT3Dy1tkmeKkcs/cnsC?=
 =?us-ascii?Q?tyGl2Uo89B/Qvesb2WKbGK31SiRFqSCrITlNdZQ9gPy2eX4Q06CmpftBVkC8?=
 =?us-ascii?Q?441/6F4E+APbp/W0uA7yaS6JoVSoYfMB8joH4Z0vHgvm6pBJVPdLBv+kngx9?=
 =?us-ascii?Q?l/yQQHd9P7qOXsnyTo0VUL6Xs2B67aF60as9WywqBMXB/oDNLTJMKc3iidYy?=
 =?us-ascii?Q?eVhFdmkGl8ItmvOGYYqvRsPlP5BL3GND7j2A1VJiFraCb8RLwSJqutTs4BEe?=
 =?us-ascii?Q?DCpV+E/Bpv3Ov5XUJ0RioWRwvDe4dBtqWv639MVoX26xgBRfeZacDUm3Z99K?=
 =?us-ascii?Q?M77K0mjJw3I2IwJFal3msCBcQYpnr2BPgRPSTnuaHI/M7KXdoJVs9MAwGsGB?=
 =?us-ascii?Q?XjbRmRObsIls1Yc70y7Tk12jfebdc6B5oX9Iiu+tqMVQFty7Qhs3MmE/ds+f?=
 =?us-ascii?Q?UHDHeR7i6sXHCtvIc6tQVm3yXYI97Pd4bmsyZqoHFzlu3C4GcxRbjLlh/+yP?=
 =?us-ascii?Q?jUHZjVQHAhi4ykNeqTGUCEtWiBBV9lUZaoE2Toq65u9klcp3KGYVWnP+zTDq?=
 =?us-ascii?Q?a2j50yC/pPpvGdFDXt85a0VAdiGt/yoPzA+WrAJoWhZK80kfvi3vqMkkrD0r?=
 =?us-ascii?Q?oungujk7g9+K3Z+xOIEjlNvKh1uKgydQeL2/+pc9HJN7b3f6Qh6Yot/0F7nB?=
 =?us-ascii?Q?a6bcuFMa8+xn8g+eufW1S5HOyK1dNgVg5r9VUNA+EdJV4GpMG892sCNhGq2h?=
 =?us-ascii?Q?WioLVVZVK7FcNACNDM5s8s2g3o5naMduoTnf2OjEAjAysi/byWsolCllB9dE?=
 =?us-ascii?Q?kSdtlkDXF1FpFP36Isa4ff4nqL1xLg+pxJbEBH8KyHniY9oN+juKWqcoV3Of?=
 =?us-ascii?Q?wkyAK1DJ2hRhsy1v3VDw0Pxuzqk1QAVEGd/1lt5Z1kVNbDP7FNuwmufi3gB1?=
 =?us-ascii?Q?S2vMFD4tLIR3aHu7FonwoA7U17/UlxgpCvOmuEBLm7sjNaZOX7FkVg/r3VSw?=
 =?us-ascii?Q?A9nYW7hYK4vJqY+fNd22aN9PR20YVxCezI7mmnKGKBnnxocaNWQRRiiCMTm8?=
 =?us-ascii?Q?wmchM7sR2FUKBySVRW85ZCMbA2tdPAak+v2UegvSE6UQONrpxAkeRkLWLdTW?=
 =?us-ascii?Q?kGV8A2OVth7yhxI4Eibt6TLsMY7Yz97iYO8ltyeVpm3ne4AIMq/W1exFMQcO?=
 =?us-ascii?Q?Ixxr0acbmc3i9rNfb1Nn/bg6OUEQWMwKj+dnofzPsB6Hcr5WcBIkXAh6FtAq?=
 =?us-ascii?Q?ox9OAG49tIYc7M0nvIFS0fkbX0HS16KeUSWD/bbs5BlYCBm69b4p7V2dp8nb?=
 =?us-ascii?Q?CrQcIhbylVqSPiloikuTaKp8MyaJNk7MBvnqw5uxy/9903sVXJrJG9dPWYy9?=
 =?us-ascii?Q?/4D5mnCqscjEGOZ2r51QQer0+rd3IEvTaM5MA4RbKEXLcH4sjJ0g7V3bgSy3?=
 =?us-ascii?Q?7AZiTRMxFU2kxUkL5hY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6XCWe52X7Uv4tRqZUWUg0rJNwvc34iabjLUbJBazPLFHLdNmeXu3khos5sGR?=
 =?us-ascii?Q?kcGksRZvXZU8HwFcXu4ShCKRyRoN9bmkATi5CSca+pvokI6EhpwVEn6vt8oq?=
 =?us-ascii?Q?2mYRvArzy9f5XR7Jv2YfW5RFsRQygJgLnx/D7x6pTlZa8vO/2dMVCcBc/VTq?=
 =?us-ascii?Q?QxI3m7YH+mI050YHUyMynE+WeXKV39R022elnLF4yMtKytjlc/mfbsuZ9wO7?=
 =?us-ascii?Q?GGYF7fbuM3e+Hvqp/yR3j+T8Z/DAYXqCk+w0uxNIRAenwJnHrqPujEG1zB8u?=
 =?us-ascii?Q?u6ILAOOCS5XLF/NN84kmesGpI7icjvWG5dk3O3a1ui9eJxSaL12IjLuBwwuy?=
 =?us-ascii?Q?Vvh+O7b5/95Lv65lBNFJks0YbW19jqeYKRSX/ofs0zU6Xn1O8aP1RjRXFWmx?=
 =?us-ascii?Q?0HLP1/wC6XlCzZcvVV/0xRB7zdw27+uwkOHobXyJ7VHOqqFd0FZvOX3eSlX1?=
 =?us-ascii?Q?d5EB6KkEOtuUsv+YbMcp0Yug2wtiBpFeCAK8gEjEdUptjUPhdnt+96lAJBtB?=
 =?us-ascii?Q?LVlHmcXfPnUI0zHLv0vQNlwb1OkVNYL114PKkjf2qL+6cTPwQk/TTmTSPiwL?=
 =?us-ascii?Q?4gwlw+8WxIVONyZY/UsuJ9nafdagN7VsXuGUxyjzYziyu3YjzNrusuQSK6JX?=
 =?us-ascii?Q?Gp/ln+yWcjKVINLljfGJijUyWQYhh02j/KCF+x2Hpy38IXX9t2z+METjc+pT?=
 =?us-ascii?Q?wgG6AXGNOwiub6cEOKAk4Ygb5PRwAXUbFLAOgNs1mBuANj0ySyvoWh774wps?=
 =?us-ascii?Q?fQDaD4w8cTD6yGRJwfGqv34FQ5fBoLn7I0mhy4OtFNmayb4alrhzGTX8YQDE?=
 =?us-ascii?Q?42eWWTncqC9egvSsH0iQl1c6WtioB5tAhxdeu3JsmUxf9dK7qkARH+Objyfj?=
 =?us-ascii?Q?0O+Gc1+vZIvIzrk0mWK2bmux7Byu8IyMKqp1YRXcm2erccU6984Xi198cN7f?=
 =?us-ascii?Q?hqHQozjsKTSIA5OeFM1aMffgonW+ACL7HPCn2HDnjC1smtiSYDs7lunKmTZu?=
 =?us-ascii?Q?N4Rcee/uVmqGoUztE96v/FhPtqMNt6WUXRQecMEsCQWjWetidmq52u+ff6Zy?=
 =?us-ascii?Q?uuMhVYDQG13t/mKEnp9UdRqQOrI37v/gghAhzKGsHvepXDiIN4TDxphk//22?=
 =?us-ascii?Q?0RSS7DeayXEw7VZs82XKwBGPMsqoE+VTfqCf1X7rPEi3/tKV/1HqRPrsQDUt?=
 =?us-ascii?Q?LtDs4MMQkLUGH15qL6NzBmG2gdpAOGy9jpvr4++W0rc4M9lwr95Y7VzMk/4R?=
 =?us-ascii?Q?YSnSRfL/ogObhLUChHIBekONQwBE+oDAfTk67PRtd++cJ/G5AeGTdMOOmjX4?=
 =?us-ascii?Q?RZxkCrCYb49WyZDf30KCSrWJANN/Cw7pL+h109mmlLT1KpqOmIlMU4Na0xfb?=
 =?us-ascii?Q?bsoSy0Ks5Mm3pl1rkxz8lxMtRCKp4EjAoZ9KDwdZbo3F7Ksy3T07my+DmLB7?=
 =?us-ascii?Q?uTdLqDAXP3XC0uaA65AkBSl+znsmK9MaJH5rJoDOwS796WDsftiHMzsYDVKt?=
 =?us-ascii?Q?Q1nh+fPTrmV4dURhBpCNSFITAJ8W+tDefyRe8bwGAAWUZkXmazuwz9jV+wdJ?=
 =?us-ascii?Q?HjMNWGbZukkzvonzJyh7oQgo3Zes+uOimdoJiuoi1M0svQRHUKwbInBD6ZnP?=
 =?us-ascii?Q?J3xx+IG34ZsV+apRBFSc+wlh7gPLI7XTl9Hhnh1XDKEsbiRiWZmMvqgAe8Jn?=
 =?us-ascii?Q?nyL6k4HWyc+RLfAoPFSxkxiHGDCyUyOzJTPZyRX1uty4RBGaHoGi1OvZcLI7?=
 =?us-ascii?Q?UVwxZ7zb2g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5363afba-9629-40a6-7219-08de65224380
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 01:51:37.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt1uea7fcJvhG1LzgsKplSoCBzvJ95TTSWmOx4aOJQJxiv0/8ztHMNm+8V8SJl4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16616-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 20773F9185
X-Rspamd-Action: no action

If the driver doesn't yet support any request driver data it should check
that it is all zeroed. This is a common pattern, add a helper to do this.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_verbs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c0dd82a77e7a13..973d9ec6875e63 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3119,6 +3119,20 @@ static inline bool ib_is_udata_cleared(struct ib_udata *udata,
 	return ib_is_buffer_cleared(udata->inbuf + offset, len);
 }
 
+/**
+ * ib_is_udata_in_empty - Check if the udata is empty
+ * @udata: The system calls ib_udata struct
+ *
+ * This should be used if the driver does not currently define a driver data
+ * struct.
+ */
+static inline bool ib_is_udata_in_empty(struct ib_udata *udata)
+{
+	if (udata && udata->inlen != 0)
+		return ib_is_buffer_cleared(udata->inbuf, udata->inlen);
+	return true;
+}
+
 static inline int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 					     size_t kernel_size,
 					     size_t minimum_size)
-- 
2.43.0


