Return-Path: <linux-rdma+bounces-4790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704396EA12
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 08:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C74D1F25404
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2024 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390B613D52C;
	Fri,  6 Sep 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="G8c1MKb6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011054.outbound.protection.outlook.com [52.101.129.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF8513AD2A;
	Fri,  6 Sep 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603774; cv=fail; b=Oew1Nz4ElrLQg9x8GfzCn2hWICL9q943mdDWU2JTYG0Rx2eoHubqMZXAdWEmLeVawR3SMR/8hbkIzi/K6mAdibS53KLpr3ZAauw1uwrl94+sV44HI4XP7Bws2ZXpd3bYMFOOKCoM0OONQqzQ7txruNgAPdo9fAkCuu5r8U+rp+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603774; c=relaxed/simple;
	bh=uC5cRvKgFmldeJIBrYmKLkkVmZK7sRPaXNWAD5GCmrk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WVC+KTfjXcERSAiziAeWYMtIeqlRSMB3pbYTuCvuI7LeWgNHaskayCIUwEcIa1RbI672pn0xmtKh00uGtPCSF08kaI5uL1boqHDoRJnGmgErpgL9n+QMtfYdrTDYnKRpukdwJjxf1Km5q1McX/p8F8kJktTtDrg/cNoTh47M6D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=G8c1MKb6; arc=fail smtp.client-ip=52.101.129.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Guu2bzaOWPJwGpBwzcHmlKYmn4DwQT4/dhLWRCst9A5xq/GJDGVxt1JyurrxPwfs/rhl7FVrHXI0Qc6VVDVBMpGaYcXKu1TB0E4tJbB7wE4nq0KqHPaLNbHcCwv1JGV3MqFfbmCP58eBR8iQnO7C1tHxvtZpZrO+sPEpH+E+DFP3trCORXe8OqYpcwF7lql/+H7Z+jS/Tg4lbBvbrH1znrrYHeGIBgz9k0gUlvlTYDNAfUtZCKQZnKsercos7MeoHFl9TwE8ztHRk1ti3JudHtPo60CbdAYHOlRQ8c/KWsriUJf7s+jvZT3l95+4qy4IOz29TdtqNWQ8xL0GOUqqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uJ2IfTgucXMAaoAi5486N5++bLmntLwlDkxerFYTvc=;
 b=EKCL98SJmMvLYRQur10dKcsV30REa0Wtq/mfkMy23FiOVJreDpu5vbfMtzcAf47uXZFkQs8HIyJaAr2bcYesb8Pb8W72ygvgrwq6Em4IlROrVxkAjkKkT2mqPf84jPlJathnFyouQwQrNTNKAiy/pWe9k/+Rcc62RFNA50VUFkTkPmr/MKtU3j2fCXoX/3sOdOQREj4OeQXAOwPXGpBLMpeaCrYQMIZK3VhqW5vyNL73exLCbjsVx99IDS+ZWN66u9EGAWYqxfihtydX2smKBQ52tcYrN54fLPHBEnA6YNdWyjU5kYK14GVKx8cpFBsoUOwyngzawmrbREERkCBP2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uJ2IfTgucXMAaoAi5486N5++bLmntLwlDkxerFYTvc=;
 b=G8c1MKb6fKzvbH7kflzKRUWXHsPGOzTKkG5mShDCBCdai/PgpeWk23VXrwPRIXZ3ajG1DKjQzgzymF+aAljoFIU9m3bWu+AsCwQfb9iUgge/fE2/OpScipMxhbUtM21GIjZbDr3TRg3sbFS/tVwThg4Yxywy4ggkkwbOkifgdrUIVN2+/4Svq74F8ELio2ulQyptlmHmciInvdbgehGZZZ5qt7bP1LsTI0yCaXI1pGVWERBjCGHAOLjj2m1cmtzqT8pBykbRLVF7lPXhqvy5gEq7kgC6mhrdv+Gbe1AO4QhXJTzN8+tjdJfCGT0d7jnOQT9tp7UImeJ03rBX09UjtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB7315.apcprd06.prod.outlook.com (2603:1096:405:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 06:22:00 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:22:00 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Erick Archer <erick.archer@gmx.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	Shigeru Yoshida <syoshida@redhat.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 rdma-next] RDMA: Use ERR_CAST to return an error-valued pointer
Date: Fri,  6 Sep 2024 14:21:36 +0800
Message-Id: <20240906062141.1845816-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 974379df-ee78-4e1a-86be-08dcce3c3743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Kc9LpLKU9cEIdfsPXoKNaAPOLWJwvxKuQ2PanImX0Uz6pZBQiarIIjpFzY3?=
 =?us-ascii?Q?bH+06YgwB2tFPX4rMqanMRXSMTpwRi6qnKO/bylwDfhxzdXKdF0qVP46SsZI?=
 =?us-ascii?Q?wlgDea19peTVYPZIDfBdXLPxK06DmuyWDAXUtjAJ/uYaqLiXf+zOV+aCcJpE?=
 =?us-ascii?Q?DtN6LHTvqZk35ggI9t3ESsCPz23Jj6DNuVTQnBFPfI5iT3ovgNLV2jmaJlzX?=
 =?us-ascii?Q?h4uQTNnRHszvnm1SorMa6DbagqRXYjD808OL4Upw4FwlDci0MCYr6Hn0Mr1q?=
 =?us-ascii?Q?rR2Y6F7rlbfogd40en9qnXg6imyZ5SaSku53pv+iaKi4pWNqtliseJ7bBYWq?=
 =?us-ascii?Q?texPbG4f960MEmCDyr4f9dp7KDZj2mpjPNb3miFFzBIz7g4EZ2VDjo2X6gpr?=
 =?us-ascii?Q?a87LYmFRAxzzN2tvs1NECngt6u0PGfjqb/KP3dHGkatvNkbu/4x5zP9ILyVv?=
 =?us-ascii?Q?iirIWg5Ac7bmcTb/tu2vPIOzpe3Ck3YcyMhU6Oaw1+0xTAsbAzHYmJB+En4y?=
 =?us-ascii?Q?2R61HM/KqTM+3ewWoOc70DmvLR5VbeUTuyPK7wUPvJTzCZL2oeWf0EDgftcD?=
 =?us-ascii?Q?iUWa+KMRHq1Mi8v2XQho7wmUHIa6d+RHXfA4zOxbSWUTyDuJ6l50g8wVvv6P?=
 =?us-ascii?Q?VqZ56ZMqgv9GRH6s8oxEnxYXgj2wTrUTAn9tXm7d1LCDzrSx2Ipvqys/tQog?=
 =?us-ascii?Q?rcdVxPRtXnu6v1AHnUQZXBpRPBGcpzG8r04QCc4rzEWDMCn62vQCXpj6UwIJ?=
 =?us-ascii?Q?nEy8uuEZGLu7vVnCah8rQ+lQioO70gWSC8UpfXqcPh/LAdAU/wQDOGaDqjVA?=
 =?us-ascii?Q?otxTwemt14uBL+ezM89pe+spC2Y3q2eynqufjqsbd1sn8br6c6ui62+kcgmT?=
 =?us-ascii?Q?uS8750Me72BhgMHTLdmCZawtkKLxdNqPlcTjFPuarfFMWUPgrWkWRwyP+fnA?=
 =?us-ascii?Q?6Cj08XkMowCcce2dF9XnrAPjzQqpLESJBQMuqM2X9WjIAbWpMhRgtgJUoXPT?=
 =?us-ascii?Q?b8alJmbKTaYO6aYMLEX2LqKSelGHedHl8RNz3x99gCWQWQlIIHkPzAjtsJwq?=
 =?us-ascii?Q?xH0r4rq/9GLnRd/35ubfKNCVqo4hZqToqktAAK7y8tGKEz76jaQ1BZ0jdFf4?=
 =?us-ascii?Q?0Mnv4r/c4JdHrFQRiRZGv+Q2ktd9NLJKSEr47slEBs4Hga0AvZfVJfEXUN88?=
 =?us-ascii?Q?wu+nW9rlghb45ppAvQKw5xDMJwMYqQqncDEURqPz8PKf5Rx9iu2XGubQNoCv?=
 =?us-ascii?Q?z8H8QrlfcqznxE1BFxS3PL2UAu6vf/vaered+AfJfxdZ1dnWgo76Wu7k83wh?=
 =?us-ascii?Q?4OfCgIR3Lm8cV0AJ4Z2ifK15v2fC5sLprWl+t/Zn4FrjtoocIxQ6LYqzZgv7?=
 =?us-ascii?Q?KaPbw+sxxccQbRprIhW3GohAEe5DKKQUpGoWx3QQYoiSj71nuLVSlua8kccJ?=
 =?us-ascii?Q?fGdPmlz6/ro=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7J9dF1lZrcQ9NJQUfRkw6G6C2aR4oRFmoUaorQTOOW1XKsr7buZPRjkw3clm?=
 =?us-ascii?Q?QaZ0p5joc9t4lnM5t+VEWAZcPG5UjH1MDI3CmSTgOhE/dSRIpqouxN7lpwL0?=
 =?us-ascii?Q?6c34XSQNIjTxTAnppRyKIXuoqXpEfWjLAXbJI5sHHMcjscyN94bA25UkpZCv?=
 =?us-ascii?Q?i9lFJTkmtTvctRQgXnpZicsxmh0754LU/ToCQsz5uq5lf2tAVGQKSI5Hpwbm?=
 =?us-ascii?Q?hkgQVZb0BDtNhXfBaPsjRjnQutNGmPmMLDBUTs5rXWuj3w9xmzm7PwAj08b0?=
 =?us-ascii?Q?k0n4zE9uNiMkPRvFb15b98yuChq/nFm9u78hF2EL3Lvk84goPdCki5Oe1TJ0?=
 =?us-ascii?Q?4XnEFlPprMyxNEK7OtXpsw9NuyVrPVk1kFPbp9R96nXEirkgtgR6hp6qsPiN?=
 =?us-ascii?Q?Fi/vBuydz3DbzCfSk96yjXEFLhTYM/Z9JnltqHnLCv+cTdbPODjRL1nmXTTe?=
 =?us-ascii?Q?ZIsYEuvCgwzWwU43BpAAQM93yW/FuSdvl7zblOwSw3ly0PffakiBxEic8/UI?=
 =?us-ascii?Q?wSW1rRRU86AFTgm2KYOsyr8EkCeY1jAtOJYh5zXLL5xngqUK6XWGfPQatNEV?=
 =?us-ascii?Q?4uBvUxKBhBlYoYTQwWkGE6c9XnqWhCcgF9mJbDHSdGq/96+XBKVRRC/rUX/j?=
 =?us-ascii?Q?yR4nA9o6CHlx09ErPLUTKrkYl3VmmivPP9Sxcksbuno1sCTI5zRumKDkAp2O?=
 =?us-ascii?Q?ebZyuGhncbkmiwzSKNDzTf4v13nLVlr61aLd/SUm1/UF/V5qAKc+hunFi7L/?=
 =?us-ascii?Q?QUXvSBAI5T1D29WFHSM0vIB0IZeyzptsW/Z+z8YxWRmxZspdKM4SnxIJ1Laz?=
 =?us-ascii?Q?JMpp6jXAVimodvdaqZaMirifsZtc6kCvR6jFMxmtd4tPr46tB2eu4hbhi5Px?=
 =?us-ascii?Q?pARA4DM7ZPB1Z/RWwRf3ekyGLdJTH6PIKYNg9n3QvgjbJ2s008602MOThCw6?=
 =?us-ascii?Q?+XI+MV/E1kdCHfLrPaKEKAb62IdJKllVbOl9+mWTwIF5QN1I4NfE2rB8ag5a?=
 =?us-ascii?Q?dTkMydtapJg71EyZJEu9iJf6O6WGDWBSMOu14tH5MDbPdWFyEMjwNW1J0+Yc?=
 =?us-ascii?Q?KVErhDQtEg6zhCbOVtPxhvAgknTJ0EQ3fM++yXI/NXGLqeBU6HdM6KYsXs6g?=
 =?us-ascii?Q?PwhYqwkvwCZHr27RbccSWMYmHja0GZij65b6iDWqvDasn6K3iAZV32GnAGPM?=
 =?us-ascii?Q?NOOxoRx9UtOsFl05cqM4Yr/A2l5FlAJUFlePfjZKbRwsW6S06n4okH0+eHnL?=
 =?us-ascii?Q?Gc3qJ442uVytPdwbGhoCpgbP8QS9jxBAzyu47umF+7n6JFD6LlVHP1djYpMm?=
 =?us-ascii?Q?ApIC7pSiIaNR2khV88Y3s+bANYb3Nzt+cgK6THH1XKb8isBTFFx2knJDdDKd?=
 =?us-ascii?Q?gqDZwnY2ihZq278ZMKP/hmqOHqExLohHpqjHjN1cSOsbt9eJJYrqy+kDH+Q3?=
 =?us-ascii?Q?e/VgrQ5DVVgIPkvQj4IWv8DbneppgpXG/v8YBAHY74/Zp47/Sx3bgY3Z2f6o?=
 =?us-ascii?Q?QpunlfV5R/JuD9KaggDBqXBgXywWljF7sinVm+TmoDTXVI063026Akng5cI2?=
 =?us-ascii?Q?mQPyVK6gOnzKPnjtB8ybA69jq100qcTGB6Fkrg73?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 974379df-ee78-4e1a-86be-08dcce3c3743
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:22:00.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8uBCGiybDjUH8UlT49u03E2FNaHaj51Z5CSrG3n3uQwcttJXi8CLGmOny4tqKnxjspLANz1GJj69A09ornH+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7315

Instead of directly casting and returning an error-valued pointer,
use ERR_CAST to make the error handling more explicit and improve
code clarity.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
v2:
- Additional modifications in file /drivers/infiniband/hw/irdma/verbs.c
v1: https://lore.kernel.org/all/20240905110615.GU4026@unreal/
---
 drivers/infiniband/core/mad_rmpp.c   | 2 +-
 drivers/infiniband/core/uverbs_cmd.c | 2 +-
 drivers/infiniband/core/verbs.c      | 2 +-
 drivers/infiniband/hw/irdma/verbs.c  | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 8af0619a39cd..b4b10e8a6495 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -158,7 +158,7 @@ static struct ib_mad_send_buf *alloc_response_msg(struct ib_mad_agent *agent,
 	ah = ib_create_ah_from_wc(agent->qp->pd, recv_wc->wc,
 				  recv_wc->recv_buf.grh, agent->port_num);
 	if (IS_ERR(ah))
-		return (void *) ah;
+		return ERR_CAST(ah);
 
 	hdr_len = ib_get_mad_data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
 	msg = ib_create_send_mad(agent, recv_wc->wc->src_qp,
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 1b3ea71f2c33..35a83825f6ba 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -192,7 +192,7 @@ _ib_uverbs_lookup_comp_file(s32 fd, struct uverbs_attr_bundle *attrs)
 					       fd, attrs);
 
 	if (IS_ERR(uobj))
-		return (void *)uobj;
+		return ERR_CAST(uobj);
 
 	uverbs_uobject_get(uobj);
 	uobj_put_read(uobj);
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 473ee0831307..77268cce4d31 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -572,7 +572,7 @@ struct ib_ah *rdma_create_ah(struct ib_pd *pd, struct rdma_ah_attr *ah_attr,
 					   GFP_KERNEL : GFP_ATOMIC);
 	if (IS_ERR(slave)) {
 		rdma_unfill_sgid_attr(ah_attr, old_sgid_attr);
-		return (void *)slave;
+		return ERR_CAST(slave);
 	}
 	ah = _rdma_create_ah(pd, ah_attr, flags, NULL, slave);
 	rdma_lag_put_ah_roce_slave(slave);
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 6a107decb704..1ae336800c63 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -3037,7 +3037,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	if (IS_ERR(region)) {
 		ibdev_dbg(&iwdev->ibdev,
 			  "VERBS: Failed to create ib_umem region\n");
-		return (struct ib_mr *)region;
+		return ERR_CAST(region);
 	}
 
 	if (ib_copy_from_udata(&req, udata, min(sizeof(req), udata->inlen))) {
@@ -3048,7 +3048,7 @@ static struct ib_mr *irdma_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	iwmr = irdma_alloc_iwmr(region, pd, virt, req.reg_type);
 	if (IS_ERR(iwmr)) {
 		ib_umem_release(region);
-		return (struct ib_mr *)iwmr;
+		return ERR_CAST(iwmr);
 	}
 
 	switch (req.reg_type) {
-- 
2.34.1


