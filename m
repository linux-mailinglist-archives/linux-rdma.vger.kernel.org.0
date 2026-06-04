Return-Path: <linux-rdma+bounces-21728-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uqMJHPXUIGo18QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21728-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D01D563C33F
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MlYptG7I;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21728-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21728-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5B930440AC
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A910266B46;
	Thu,  4 Jun 2026 01:28:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3526A08A
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536490; cv=fail; b=LUNQ+iT27vwhfMIwj1jq2ndZVX68GOKzejmyzQxWs5Z37anp/SskOeIhZ/39e7Fe4XAhZSU7bjiRMYp8R2PWH8Enz+NtD+bz3uH69uF/MHCIA3y1Oyz7UT6hYueltLMIlSdQGmClJ+iymCx602cCTA89j0U1IzbyRaGjv0/t3nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536490; c=relaxed/simple;
	bh=IJEOGHSFcD4C85RZoZgcGGJ768g6jcrI35mqE8r/LoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cqiea7Ngc74WvclzKbKpc/H3sBUJcRLPwvbDu0EZFle5LySlOrzwlz0fcHI30kjBUavazH4c+g0cjXTbYc1Egi7i8THVblU2REoVYtoia39ZC2/G3cgc/LFzewWBzL4ZQot7MnzkTEgZVIs7psJfXGumZ0glmPL7dXFxJNkHYS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlYptG7I; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfqznLUHQpdrIxxQa8+eq7AV++xj71cC4I3qhEyKmY+ASvIpage/b6/yGbXwWdjyqp/+5T9eSy/4zYaHP3/1SV5PWyttHVYYsKZzDpV+S8ZbRmBPvIp2oBwl8djpoy1cnfOwAqURH8HNBHLmydw0Bu3AYZncRTDst+my5oPvYzBVpDhA/fFOX5B5Ll22D4QO4NMHPxtOwrW0n+TrPkRbGQ2RihYYO2k6/PfgAeZM4el9YjepgkijwcaxnYH3V5Mlj8uqttGlNVsyiz3cNPezjriG5wnp4ZRzLAKQxFuyAZY036i5ejqR0kQGdw9DFhTL8JhTywg6W5sOYsCmuZjz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V63qQzWm0ZI6qds22bqDeDpZl121ecfDWJnEARpmwEs=;
 b=Ry/S+TjHyVCxcDCNs8zDAESIRoCgLCZJuT6N6ExnVXYLEdY4Z3sMWVnDifi60lm//KKrD2TWPKKXh0k0t416y2cllj5/YqEOeab8gkXtAME7A5uAsd0kBhSm9iwT2KEY202XejUFK7GoUWwajS1DThmzMy6rSn63St2Puk0NQAFRKeRuaIV4P8F62lrb2LC3gv2av8f4AdQHSqEfrVTWOI/rEpmyh86pQezYy5OcubKuk9PYlO43WZxs0jJmnmLCGYAqds7RBGpEOqViavwI6nQK9dK690h0WRkMNVTNmFjpK2YyHYzczu6SPbz2lnzq2JW1p63tIgrEXh9rKuLjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V63qQzWm0ZI6qds22bqDeDpZl121ecfDWJnEARpmwEs=;
 b=MlYptG7IveBzE337tV/GENl7kg/JlOaV9HDNs4x9KQxTDmB+rQuC2rP+YpLKQp0mEa+039e9ZrJE/Zv7qNg1FH1Y4NgNXyrgPteIzckhD608HbigAf2tReqm05YwMA7rCJ2U/xAx1L5JVXqECz705M9IFPXRBlMWaaNHoacZVIU4setxhF6dzyrxcu9CJq2TJqpAP+uFi9n7vAdGQ4Iai1QxW8jM9s1uyVLLa2LefG5Rhr7PoIGjIuPdmdMlpAx/gq2rHlQYxqqnCuT8gUFyIHqGlmvZ/oAQAgoEnguuK5hZVQNnAES5JmnPmdViPEQIurRBhQYSqFkEbeON3vaQpA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:55 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 04/10] RDMA/nldev: Fix locking when accessing mr->pd
Date: Wed,  3 Jun 2026 22:27:43 -0300
Message-ID: <4-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: e4af7473-6a2b-4c76-b467-08dec1d87ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	uCrO9KF1jsuk8zzMBx39zX0TPujDLv55GIUrp2cahBtzCbbSrehC2tkWxb901W7yJHjXz2+27yG7/H6DS0FjrvFj+MtkCvGNVv3QUmlTvkRkyb8uVeyxMqBT1vgqznS7XZqtUnkSB00u7OOhIvx9CmBmmt+7ArdXFj7bsKRxqJ55cC78hOk6+3//0vEDyhIToE3RDtFqVE0hswwK43U9/j7UOMELBx0UxUmSipVHryiO2LQu40M39KKwNJlO0YNaF7VgryaDMpa5GsF/GJMPVHu7TJpJQrY1iZd1W8sCdGXeeqQprYxwJCzJVAkz5/DQh8NlETi4P+R8wUMNCs8ZBMx2HSg8U+bM86FxYFNZjem/87fNe5V9SEWSWgZ6s8e+CK/rCOt4/PkBSBvBOxhWzwMDqo8IAmYtTIBETGNuDamoSk0E+6f5+rhxL/dVYz/x8t0BmHUZoK4/3hbSXra7RVj8fOgRe9xD6uenRceQJ1moZ9e6tgA46SYHW+aTa8fosa2eh2EXZVWbAZAa4qLWI5U6AGxXXvOCexm7xQXBM4qZ5TzVB/z36Zf/CY1HB4d1eVVGdswRN0QN3zy+kMDUklaYd9YbeDQVXJascrUvVomlQa5vQKroW45JgJvKMDEI+33kEPG9WFBw0PGzLgwZIkYRhekr+3LSY9ETu+U1Bi0KTZOCLLKe3X6XL6xnq9lk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFRh/WDZTz6HMHwt75z6L3Lydr0Hz0zzKpYqfivXJsRBBtiTH0B10KlCGk/R?=
 =?us-ascii?Q?JO9PrgUWa87xgyKGanOZGi3ISFBsxBsn7Nl3wZQVPfNBCAHj7Ts4OSv2NTIA?=
 =?us-ascii?Q?YozHa/MiFsy4t6/QqpXWCnR2xeDFkoi1WwrMv5E5665qzyoNQFasxFAPGtCc?=
 =?us-ascii?Q?CB2a28c0pI8nKz9nb8/+P+6gGc6bCMXo6f68d77LYVoioqBWUsjLfS26yrz0?=
 =?us-ascii?Q?YGVGD/trMNbAHJylwALvNAdQA67Tw63X4I+bxsVefBEO+PFoEROU7BKvJcj+?=
 =?us-ascii?Q?BY5MiPaCQgesz5aY2KYFGMjkY5L6oWRXXOa7p+a+HgB4BmVhCCgK60CCIpLV?=
 =?us-ascii?Q?DmfbUT+AY9B2vdllvcQiMLDt9XpYYj/BqpLUKAYvlNdCSuQ79qwNE10BCVBq?=
 =?us-ascii?Q?w/ZeYUdDqplS0NYrb+rp2Oy7WSwdzWxdOLue+NBWzdun9gumK7USk24F2xhH?=
 =?us-ascii?Q?yRH2r0c9grUkgTzrMqHCbQ8O8fq9cgM2wqjlEbtbeQ1OXrIbLxLwdtbbl7l5?=
 =?us-ascii?Q?iecmFfYXGM7Z3rR5UZbM7M7P1rcmSY5730yRkkYxOmQb9WZnJuQZE9T4tlmu?=
 =?us-ascii?Q?hghhgmOIMjnlDvv+87uCGvuvvo2XO4mC28nG4EDjKh3bNkOopQi13RRBJImJ?=
 =?us-ascii?Q?ITf2IWSyta/LW00qfDoZakcpVIHHNcdo0CqOwP9l23V6mkB+YLPRrZmL90Px?=
 =?us-ascii?Q?CAIeTVGqBghi/DCioL7nCmSPawGFlW/OZTABe92lmzgtFrquTRrHiG81xCmD?=
 =?us-ascii?Q?b+nUsl3I5eRL40f2brnFVcdgs2ORupBI0GacMncivJdhP0yGdUhBg+XjfSzc?=
 =?us-ascii?Q?8k/A40sQXV5OwDGWdxUDLc3f2mYgnqRvgoNDhTunUM8LRdjDcDvxSXwjO5JX?=
 =?us-ascii?Q?Z5Dx0hCfgKSqFymfaOos1J807DzvdSkuUzHsHBPLjmVNnx62Wohw3L3F6iJE?=
 =?us-ascii?Q?KRdshcNZ2Uz+ExpkX2Q9OXB3HjKAyG7q2lzdLVQLq/dCtFHkdnFW0OfRu8qo?=
 =?us-ascii?Q?ykOI8tsCHvM5us4Z/0rX3HeX37AFfcHY++vBdecFRoLS3yyDyB5XXrWIis3b?=
 =?us-ascii?Q?StT0yzE9YYh57t1Sn9hzOS6EsIefNqqBG7aq7ssiJZxNQEScp1ZoqKA7RPUo?=
 =?us-ascii?Q?908i6iHD75UBMPt+zKky+3Nv4DLxIEWoJLvVPRPez3m4/x2kKEpvr7ls0Jfx?=
 =?us-ascii?Q?S5txEg6FzH1X5TcM3vEpnUb/LWnQtzKPioSvqgvp9/Tli5GHk/DNFsIQAgrF?=
 =?us-ascii?Q?U19B3Yz2A1/dyR9gMlmKrEfQCfq87zKUVitaeXB5lo1wXSzF7+ZDiqKK+mAd?=
 =?us-ascii?Q?4uoCFbuVWBT/iLTC143ZzS4uOfugDonSzd48axOxXy/VFZn1LQKD8nFBucCX?=
 =?us-ascii?Q?k5rj2BuLHEwake27IgjROG9D83jIUAESW9wr1N7TQSj+JHNBpt4VOBGhcHyF?=
 =?us-ascii?Q?ZlzAJlXHUrGOHks1suWo3TqR2CLIzAdxRxYeTNQ65X688+ivOOO9XaEQ+gNJ?=
 =?us-ascii?Q?yTsBDf/TN3na5FA8PrEX45HUOFyKJfQ8W6AE6xa60Ls7rwb9dsdaPcPl3vSB?=
 =?us-ascii?Q?6sfwmYTZ1HjT2LE1LW+MCF81C0/STvEdZE6/FN327zOkFyyrA8j4h2I31rGQ?=
 =?us-ascii?Q?j9QRABDkpQQk+hbY43vivBEBjdtkdbR6RRxNOspsTFqRIIV8AYGROGQUEZsa?=
 =?us-ascii?Q?eMV/baMWlcqPa9HOFm0Xo5RIpDu1BPtpAZuA9HyxZXMhx1YL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4af7473-6a2b-4c76-b467-08dec1d87ee6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:52.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qI3aicnFQSIAkUe1AkABHd4hpZZDQZJQ3rutA0+UfdljhSDyWhN0lcPZIt+No2k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21728-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D01D563C33F

Sashiko points out that, due to rereg_mr, the PD is actually variable and
all the touches in nldev are racy.

Use mr->device instead of mr->pd->device.

Getting the PD restrack ID is more tricky. To avoid disturbing all the
happy paths, add an rdma_restrack_sync() operation which is sort of like
flush_workqueue() or synchronize_irq(): after it returns, all the old
nldev touches to the mr are gone and everything sees the new PD. This
makes it safe to reach into the PD pointer.

Link: https://sashiko.dev/#/patchset/20260427-security-bug-fixes-v3-0-4621fa52de0e%40nvidia.com?part=4
Fixes: da5c85078215 ("RDMA/nldev: add driver-specific resource tracking")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/nldev.c      | 15 +++++----
 drivers/infiniband/core/restrack.c   | 49 ++++++++++++++++++++++++++++
 drivers/infiniband/core/restrack.h   |  1 +
 drivers/infiniband/core/uverbs_cmd.c | 10 ++++--
 include/rdma/ib_verbs.h              |  5 +++
 5 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 5aaba2b9746ba6..02a0a9c0a4a6ad 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -695,7 +695,7 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			     struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
-	struct ib_device *dev = mr->pd->device;
+	struct ib_device *dev = mr->device;
 
 	if (has_cap_net_admin) {
 		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_RKEY, mr->rkey))
@@ -711,9 +711,12 @@ static int fill_res_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
 		return -EMSGSIZE;
 
-	if (!rdma_is_kernel_res(res) &&
-	    nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, mr->pd->res.id))
-		return -EMSGSIZE;
+	if (!rdma_is_kernel_res(res)) {
+		struct ib_pd *pd = READ_ONCE(mr->pd);
+
+		if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_PDN, pd->res.id))
+			return -EMSGSIZE;
+	}
 
 	if (fill_res_name_pid(msg, res))
 		return -EMSGSIZE;
@@ -727,7 +730,7 @@ static int fill_res_mr_raw_entry(struct sk_buff *msg, bool has_cap_net_admin,
 				 struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
-	struct ib_device *dev = mr->pd->device;
+	struct ib_device *dev = mr->device;
 
 	if (!dev->ops.fill_res_mr_entry_raw)
 		return -EINVAL;
@@ -1017,7 +1020,7 @@ static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
 			      struct rdma_restrack_entry *res, uint32_t port)
 {
 	struct ib_mr *mr = container_of(res, struct ib_mr, res);
-	struct ib_device *dev = mr->pd->device;
+	struct ib_device *dev = mr->device;
 
 	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
 		goto err;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index ac3688952cabbf..cfee2071586c16 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -71,6 +71,8 @@ int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
 
 	xa_lock(&rt->xa);
 	xas_for_each(&xas, e, U32_MAX) {
+		if (xa_is_zero(e))
+			continue;
 		if (xa_get_mark(&rt->xa, e->id, RESTRACK_DD) && !show_details)
 			continue;
 		cnt++;
@@ -276,6 +278,53 @@ int rdma_restrack_put(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_put);
 
+/**
+ * rdma_restrack_sync() - Fence concurrent netlink dumps on an entry
+ * @res:  resource entry
+ *
+ * After this returns any concurrent netlink dump threads will see the current
+ * value of the object. This is useful if the object has to be changed and there
+ * is not locking to protect the nl side. Eg for mr->pd. This effectively
+ * destroys the object from a kref/xarray perspective and then immediately
+ * restores it. The kref is acting like a lock to barrier concurrent nl threads.
+ * Callers must ensure rdma_restrack_del() is not concurrently called.
+ */
+void rdma_restrack_sync(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+	struct rdma_restrack_root *rt;
+	struct task_struct *task;
+	struct ib_device *dev;
+
+	if (!res->valid || res->no_track)
+		return;
+
+	dev = res_to_dev(res);
+	if (WARN_ON(!dev))
+		return;
+
+	rt = &dev->res[res->type];
+	if (WARN_ON(xa_get_mark(&rt->xa, res->id, RESTRACK_DD)))
+		return;
+
+	old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY, GFP_KERNEL);
+	if (WARN_ON(old != res))
+		return;
+
+	task = res->task;
+	if (task)
+		get_task_struct(task);
+	rdma_restrack_put(res);
+	wait_for_completion(&res->comp);
+	reinit_completion(&res->comp);
+	if (task)
+		res->task = task;
+	kref_init(&res->kref);
+
+	xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res, GFP_KERNEL);
+}
+EXPORT_SYMBOL(rdma_restrack_sync);
+
 /**
  * rdma_restrack_del() - delete object from the resource tracking database
  * @res:  resource entry
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 6a04fc41f73801..75b8d1005a984b 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -27,6 +27,7 @@ int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
 void rdma_restrack_add(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
+void rdma_restrack_sync(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
 void rdma_restrack_set_name(struct rdma_restrack_entry *res,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 91a62d2ade4dd0..22793e4b1895e4 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -47,6 +47,7 @@
 
 #include "uverbs.h"
 #include "core_priv.h"
+#include "restrack.h"
 
 /*
  * Copy a response to userspace. If the provided 'resp' is larger than the
@@ -819,6 +820,10 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 			ret = PTR_ERR(new_pd);
 			goto put_uobjs;
 		}
+		if (new_pd == orig_pd) {
+			uobj_put_obj_read(new_pd);
+			cmd.flags &= ~IB_MR_REREG_PD;
+		}
 	} else {
 		new_pd = mr->pd;
 	}
@@ -866,9 +871,10 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 		mr = new_mr;
 	} else {
 		if (cmd.flags & IB_MR_REREG_PD) {
-			atomic_dec(&orig_pd->usecnt);
-			mr->pd = new_pd;
 			atomic_inc(&new_pd->usecnt);
+			WRITE_ONCE(mr->pd, new_pd);
+			rdma_restrack_sync(&mr->res);
+			atomic_dec(&orig_pd->usecnt);
 		}
 		if (cmd.flags & IB_MR_REREG_TRANS) {
 			mr->iova = cmd.hca_va;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0ba4..46568a5221f403 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1977,6 +1977,11 @@ struct ib_dmah {
 
 struct ib_mr {
 	struct ib_device  *device;
+	/*
+	 * Due to IB_MR_REREG_PD pd is not a fixed pointer and can change. For a
+	 * user MR, this value should only be read from a system call that holds
+	 * the uobject lock, or the driver should disable in-place REREG_PD.
+	 */
 	struct ib_pd	  *pd;
 	u32		   lkey;
 	u32		   rkey;
-- 
2.43.0


