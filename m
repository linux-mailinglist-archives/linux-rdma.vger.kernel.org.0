Return-Path: <linux-rdma+bounces-19722-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GkmFVDG8WnnkQEAu9opvQ
	(envelope-from <linux-rdma+bounces-19722-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:50:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C144915BB
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 10:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28D393011C60
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038F3A5436;
	Wed, 29 Apr 2026 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NPhT++I9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012039.outbound.protection.outlook.com [40.93.195.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6EA1DF25C;
	Wed, 29 Apr 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452614; cv=fail; b=AAk2MM9M1UKmkZrvZayKTH11TaMzN38K2eZyeEEG7ypGtO0uyl1U6YhTJWfBKPvNchF3nv0vkoeWGkfJgKphiDsSDQ+utahX2Lyn/Y1NowjntG7sZU8ailU7hF7Am7ELUljHt8Wyh/dYYwcoDEwsF0tW+ETL7gXn2MEo/v9zy0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452614; c=relaxed/simple;
	bh=U9GDGmXzm721GlUWUJsZ7kBptrw7QHqxCyasKc15KkE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KwPzUNpnkmOr/cAyyov75CS+NZJbDOWooFKX++eVEtST8RuvabJts1YcV1aiFFhSpIdY5cEZESA5ItNPMIEgkUoOMqYU7rHsCNbIr6rTWSBPzW/bWcetoMNnKzJxo0FSYDN39mv/pIYzDIvhw+HjuYQwD+HZjdA8KnwdDjtbpm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NPhT++I9; arc=fail smtp.client-ip=40.93.195.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hY83tl5zWYmkRsL3redkyiMshVBG8QXjdSvPfPVrXUJPRSmVKGsyuvV5LKptsV1zjds1nRtqa8MyX1FgoWBsgJXwBXWo8g11EgirgKS/kiJ23ObBuTws/vFRTgOIJ1WsHlhWIgtmOu6Bni4JDCMOTDBIzaMZxamf0SMsxTtmubohvsBvCnBQpBjfej8fLNqhfBr4EOI3FVUif5bsE9Fd4MfIlpEtH8U+nx+qkKNq87wFNArIAaSRcnialtv32XpYjXhtkSB10FyV0qhhKt7lw3MwjXoYtfgZD2RFhML8iqU51OAqzkYd1xd7qd+IH2JL1RjUbqb9nVhrHYAhPhQ1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQLqNpxiHzqyaKJUMH/ez6l3d9w8YGE6tFHvQC8fbEY=;
 b=vJhOqWRWIc3IQAEEVTeL7ES/gLOMjUB/eaR+Hdyl/0XbdSg9kvuqhVmH0j73CWfZreZJcaG1C1UBir7eIw07re49Csp0kKFvbHJzW+0/vNDm9LA+OxUa3ZLYONRb36AbUmjjjK7glbzZLQEdfKRYOe0Z44LsawY715OVPqo/DtGmzis6z6w7sGRl18xpQHjb7+NlQexyWPDWQzA2753UobGokdiv7NlqB6A6ZD7OCTKsRNCc5RDq/7o06TJy1urhA6ECNrnLwpWeGIwL6muyC3e4HJOS2C+LPeFY6N90XFFJXviuHnlfE327C8n3TQeYIUfMFBiNvnbo7qK6+kEbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQLqNpxiHzqyaKJUMH/ez6l3d9w8YGE6tFHvQC8fbEY=;
 b=NPhT++I9aYe94KXmaTkNzJpcXCIz08FXGmgBNzxntYhFXPUjuBPfKNZZF/yZBwzQ/UnZCV0XBLC0Qp/LDbbax0Y8pn+muubh+6FhC6Y0PL8wt4kqOPb/nI2V4+d5g89wSospsBttq2RjaPQlVDj2TQ0xX7he78jgQTJvWHGcLp/pYhP/Zme1QJah89jJmapjcSewiCZ5uMLMI5rVnQCCvZ9W9ggkcoBsq6LIxQE+OkGX7sxh4CvVzpvoK3Zb9lY5FivGoS9+jK1UnafShz1DKH4+uX1So0jR442T0EoatrmtOYXH0ia7ooYi7batgGILCw+p1Q2NXjvP6fvyy8TiKg==
Received: from PH7P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::24)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 08:50:06 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:510:32a:cafe::47) by PH7P221CA0027.outlook.office365.com
 (2603:10b6:510:32a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 08:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 08:50:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 01:49:50 -0700
Received: from fedora (10.126.230.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 01:49:19 -0700
References: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>
CC: Michael Grzeschik <m.grzeschik@pengutronix.de>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, "Johannes
 Berg" <johannes@sipsolutions.net>, Markus Schneider-Pargmann
	<msp@baylibre.com>, Steffen Klassert <klassert@kernel.org>, David Dillow
	<dave@thedillows.org>, Ion Badulescu <ionut@badula.org>, Mark Einon
	<mark.einon@gmail.com>, Rasesh Mody <rmody@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja
	<bharat@chelsio.com>, Denis Kirjanov <kirjanov@gmail.com>, Jijie Shao
	<shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Fan Gong <gongfan1@huawei.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Yibo Dong
	<dong100@mucse.com>, Simon Horman <horms@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, <nic_swsd@realtek.com>, Jiri Pirko
	<jiri@resnulli.us>, Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano
	<venza@brownhat.org>, Samuel Chessman <chessman@tux.org>, Jiawen Wu
	<jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, "Kevin
 Curtis" <kevin.curtis@farsite.co.uk>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Thomas Fourier <fourier.thomas@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
	Zilin Guan <zilin@seu.edu.cn>, "Marco Crivellari"
	<marco.crivellari@suse.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>, "Philipp Stanner"
	<phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Yeounsu Moon"
	<yyyynoom@gmail.com>, Denis Benato <benato.denis96@gmail.com>, "Peiyang Wang"
	<wangpeiyang1@huawei.com>, Yonglong Liu <liuyonglong@huawei.com>, "Andy
 Shevchenko" <andriy.shevchenko@intel.com>, Yicong Hui <yiconghui@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>, MD Danish Anwar <danishanwar@ti.com>,
	Nathan Chancellor <nathan@kernel.org>, Sai Krishna <saikrishnag@marvell.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Joe Damato <joe@dama.to>, Double Lo
	<double.lo@cypress.com>, Chi-hsien Lin <chi-hsien.lin@cypress.com>, "Colin
 Ian King" <colin.i.king@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>, <oss-drivers@corigine.com>,
	<linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>,
	<brcm80211-dev-list.pdl@broadcom.com>
Subject: Re: [PATCH net-next] net: Consistently define pci_device_ids using
 named initializers
Date: Wed, 29 Apr 2026 10:48:33 +0200
In-Reply-To: <20260428171845.2288395-2-u.kleine-koenig@baylibre.com>
Message-ID: <87ecjyp2wl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac9ec40-87ef-4187-449c-08dea5cc4ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8bq0fNVdErK4WgmgmX98zjVtDpNSMsWKivTTVE/IWpgFq4XTAVxIR+7mnHc+8pTKVppfzGkS2zTLghNh7Z9DhHJO3ZOKX44mLzsWK+m9v0E5NWcrb88pylNU6dG36gTOli6l4HuVkIn0XvCy3qQ/pPaZVoYC82p+z3UF7oTe6T+knQjdscNOJPh9idGYCFavt2NuXA/lor0NrB+sPfPQmqY5Mu6SMLqOvGqvqDTKueQOoxfUGU2Ek5qbVIWl2iVJ/lGI7M8Pur5M4Df0kqel+/AINfIKeL2cLddQcwQZzKnDyJtcOGeEzVdWGCIYAsIROPoDbdlK4nCRVsfGtAZFsG/oTmU/7hOnSBcpq1icWtuJIma7ITowC+DOYVCMjMxxvlrzDlD5HicAsKOQ4w02itJq6FeJIDFqHBV/q+fq+rCvQftHBAK9GVCCpykjCpGQK+wrtBnwOWBjVmWHpSL+aeLnG2X9jm0RvdgjUvGv7boFFVCioEt5Ip8glLwqNzUeSIKzZAy3EV2DO5N/CScCAmLXDAH6vPJglncPs31dOCDxS9XO+bVo1Fb9eqmbZCQAU7f2agqt/jkMWKmvQAksZG5MBCqYh5SilJwcYznME4NBp0ZiuZSNN8tWgrO/XJ1KldanvFnhbE5d1Z6Sdn7EVc3swY0voLaf5yam8+H5JG53r7li13LRLIV8vN4cXR6FJc5tdpFaKEr9yQs6Wa0QFv/m5/AOzZEEg91q9PQFji6FDPE9u/PIeU/xRwBM1PmFgPMPpUQ5XI6H9h0AemLJWA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P3sW3KbOswvfaIRcmHKUoye/TZNkZp5JpakbOBbshdfFspxo1WuSGKTEK14QvYoPD5HYD09YWWQrCxOo2d84gwqhplgVUau8IEHk9Mqr7hb+5SdvRZGZhh3E2p2gus3LQ6Ql977h7ox8bdUKwS2gz7IV0VoAl+HDuvOfxoL7ED8/SgBRDG0BpdXOa1FaA9wcEp5MGeiPUIBftyrGqz9Nh6og4hHSkR8TPLBTjbpeONqYKpcVdoly5KgasMYIn8fThqg3YUeVnTSYwAV/zEG0qkKsNaYLqhlRFPRX53AmbDDSvhCufFpNd9jZbI1yPq2rdE31uJVXoQPzxGXyElqkUAKrjxrxfeJV2bJkcRlKBrd62uqNPYrOfNAu3RB1+v7NgEaQdZqqgFjt3Hj7/02rpODLO2/gIWw/u7Cp3ZCx+KLsJZJp8As6IWnmmNquFuju
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:50:06.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac9ec40-87ef-4187-449c-08dea5cc4ffb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
X-Rspamd-Queue-Id: B6C144915BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pm.waw.pl,sipsolutions.net,baylibre.com,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,infradead.org,ti.com,dama.to,cypress.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19722-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[85];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[8]


Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> writ=
es:

>  .../net/ethernet/mellanox/mlxsw/spectrum.c    |  16 +-

Reviewed-by: Petr Machata <petrm@nvidia.com> # for mlxsw

