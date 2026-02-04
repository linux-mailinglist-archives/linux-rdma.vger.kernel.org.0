Return-Path: <linux-rdma+bounces-16496-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP5HIPy1gmnwYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-16496-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 03:59:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04312E113B
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 03:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EB9230FA721
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDC32DC783;
	Wed,  4 Feb 2026 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cNUHgBaZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD822D7393;
	Wed,  4 Feb 2026 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770173895; cv=fail; b=PasldvZov0c5z24IFQ+ZXpjJpXAjhiPzbcdVatCk1cDI9nt+jahmmZ9bxs6BTEBLjZAGrQv5ILXPyUY+0+kGozQJlObovCInrzHKPA2SzqCKqqsQNI4FBgJc3r5PqT4fApENW3ZnnCPiH/4mN8ycif8mY2wtXCPzDFbtGuBoDg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770173895; c=relaxed/simple;
	bh=cLr9FOYt8ybX1OZVtJTPtmUEqtk0l4pdETLekAo1LP8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZCZAVLFIfL8S6Tfed62mrtUF1OTQDgivRPr7JTw48t4hW5rnbI31Tk2gJlgQHopKO7a2jV2/HYzVEEPfpk3IHTRlsJgjPuTKQ5eKpRddmWNW/5XVylrVldfIf8qLlZlS8nqo5abvZc+UP9ck1V2CjbFIvaUi6AXO3hxsTFUWAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cNUHgBaZ; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDQeJTRWlL/3BDvjPYrxEHYRlJmDEz/n/vv23kU1E7R5PdAihn2F39alzycXizeibY67iFIiUMY4OqzhnVvyyjXkDc2O3haN7GBB8zlkFd5U3Qt+3Xpjbty6wFADJhpMlIEQZwZ7gmvtDEWLWQ2BWLifm/D2tWuKYVbbcVRCs8mUx1G2NFp3OHe8tOwpaNAaW9UhoPcQGnPvW+WlOYNptWSWJzu7yd3eCtDdgcAjgZS++0+BUs6YluqmSuTTc5T6tBA7nl+bbKRJFWaApDg0EidWGYEzwsnezfzKYpfBuHdXNQ+DaqwFNmZXHBjxs+x1kpjYed4gkq6KQGq/34gqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eoVIqVxp+PeC2vE4FfkEr3p3jepNKbRdV5uqAGMOlU=;
 b=nMZNSizi1QIOecerRh5mZ27yotu73FVLKWfpNoXbnBe2yFDYxf9j8rpON1UTHRELX5zR59eP431JyhNft5Tx3ZLicJYTqvi6znVG8wAQiGYOInTFjNKBFxNYHrItO7Y1QXm5UsayYJhJtQvrzWGxI+P4AUbBIsiEHOsjIIc0RjfTyg2Af3F4enMv3G8s/Hha7RJeOiZDmcAMj964+DkczdV0HNRr8BeWYT8b6G/XHm7VBkQ/Uc1UQIM5uyob/2Ls7SyqsbT1uekNZV4d5Zpd2D0gpucxbjrtO1FYYQaMRoXpIzTow6aYxZ/kVhAY+QGf5t9fIe/EPqV7d1B7aAMb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eoVIqVxp+PeC2vE4FfkEr3p3jepNKbRdV5uqAGMOlU=;
 b=cNUHgBaZfW0oRXZN2Kci5PhTNxMa5ARn1VlKaLhIz/93hbAyEEI7tMjl7mhGluhJWZ8ycQ/kS7BX4b081aXc9P5XeH5MuGCr3tZe2Z6WvUTkd2yIrJNTRtSagoDWrMPRnfLXgoIU/ikkxhAE0rIzrvQmpJCIgATp7ggpWkWBAEmP6l/Tg5JX5Y9k+1zUUfFRLsygYY0Uad4XFVk/QmvKl9Dw3q4/HTlMTFSxiQh72m3TD0J5+ZFF8UQGcEDQc8fqBMU1ePqmzSzRCYGTzRU3cUalCrqID2pFDJWoNyjmGatrloNVxbI+QRzosKBkaVmtHNImmnyW/4jVOEypiPKU6A==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 02:58:08 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec%3]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 02:58:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: "chia-yu.chang@nokia-bell-labs.com" <chia-yu.chang@nokia-bell-labs.com>,
	Tariq Toukan <tariqt@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"koen.de_schepper@nokia-bell-labs.com"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v3 net-next 3/3] virtio_net: add AccECN feature
 negotiation and correct ECN flag handling
Thread-Topic: [PATCH v3 net-next 3/3] virtio_net: add AccECN feature
 negotiation and correct ECN flag handling
Thread-Index: AQHclSfQf1F72vDnk0OFZ3Q1D/pxILVx2QNQ
Date: Wed, 4 Feb 2026 02:58:08 +0000
Message-ID:
 <SJ0PR12MB68063FA9A88458992B37F4DBDC98A@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260203161126.2436-1-chia-yu.chang@nokia-bell-labs.com>
 <20260203161126.2436-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260203161126.2436-4-chia-yu.chang@nokia-bell-labs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|SA0PR12MB4413:EE_
x-ms-office365-filtering-correlation-id: a5f152de-088d-43d6-1ea9-08de639939dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|38070700021|921020|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hPY5EYse5KhfYR2F+CBw/BYvtTcXZBsQjAZIKYJ5z/Gwof1IoVudbnUjf1KL?=
 =?us-ascii?Q?JGM8ud1GhljMvrJitSJIeLaDd0NWBdCERdhh2tDJj2SX2J4Uwx+wpwaSxHP8?=
 =?us-ascii?Q?odvd91Ez4coZOjUXh6z0U+lj2cFsN60WTUEDzAUKtVHzNn1qX3sma04BVnI1?=
 =?us-ascii?Q?qM6aTmqFQbz8meaDZQIoS6wChKqMotYbs4MY2xWozq0J6Djl+b9NiJNuooo5?=
 =?us-ascii?Q?WlLFM3Zft5MUnu0xJgRKzrH/P149zEKJgcrnpqasmFHE8JN7BbYj5cIUQv8O?=
 =?us-ascii?Q?mkSWWkzN+Xim2/xslVWhy0TpR9VOkxmnhstYYm4wcwW6AD5Rp+c4J7GVQ3fY?=
 =?us-ascii?Q?iQ9WGmTSJwsneqE3+e92/GCzxj6yOTlExeaUILLSkQN8HybST71F016DtP17?=
 =?us-ascii?Q?ImMX9QRX0E5weKTyAKxkoJ6RBzmyt9IjGiGulaQO1C15dsgviVc/7yIBNBzT?=
 =?us-ascii?Q?B3mjEVhLev8LRQe1tLVoIxUvwgBE/7Bk2WPm4i5n6k2geUqnxAfnoKws88EL?=
 =?us-ascii?Q?AMf2mHtxidbzrhdN1rvQQHOy52JrnLa3q53QA8Jr7lcndOalWG+UoSuoTMmM?=
 =?us-ascii?Q?MTZqJu6jedJJGmCyDthnoxIBhbcQZAyWqcD7f1iNMVjB4LsdNQsyUv4mbTtj?=
 =?us-ascii?Q?BEWZ0np6XRHr0tgTAMmmNg0XtXUQ34iFhYjMhQ22QNkhMivf9fgzSev92rG0?=
 =?us-ascii?Q?duppJUYqRbNmkGqd0QofPJzkr6FGKwmc5AwkCt60pq/5Guh6kvN2t6ZskZzw?=
 =?us-ascii?Q?/u/zgcEKY6wZT9zUSmdQgkmfOG94rPIjHJkqsrN/so9dyrQVyNU9bspnw112?=
 =?us-ascii?Q?0Ou+KRwU0NsShTgTj8uqTKKbZImvc+aAGizyE5XFLqeVjRCClbYT5tENOYzi?=
 =?us-ascii?Q?TAuShj93LwMxofhO4FU/WNbc8om9ExGd4FVBP+HO93ioNQkebT3Nm326Yxe6?=
 =?us-ascii?Q?E8hRWP/tbdwCHnAMNfExvGyFxpdKBCPN0fEVjVSArzkH7N4PFClNfW38XyWM?=
 =?us-ascii?Q?FGeqO9S9psi2m9zobHfZq4hXI3dultxIQfrXL41DmXbY1fpgTyUTFYjxOmMJ?=
 =?us-ascii?Q?JyE8xqQaBh2Icus3+nn1Fs0rg5CJDKlgJBqjZzr7Ev8dzxhQZgWeVov5Rtue?=
 =?us-ascii?Q?7tMZxpDFtU32G1NZAvGYUQr7KDaqO5X8hun0KSLs5BNRQh+iNs3Wxui4V+R3?=
 =?us-ascii?Q?WV3ZS60BBj/30gg6ct2Vs+KyULxgBWvxs72lX1gj976GW9vgoZSC3TfgvapL?=
 =?us-ascii?Q?2GYW78nt9zOG443N++Lul9vdyTSm1scfiiIYZ7CoEvZRQtC2xU6GDMyZ7+7m?=
 =?us-ascii?Q?LqO1obtddFznON8WuO7DoSJuk21fLqH9I7zR3UbeupDgJjrqDl3EeC/oFUrR?=
 =?us-ascii?Q?x4YFA/R3l9GK/7AiHZtfy6/T5UwJ5UDa7DdD5QEDt7cK/YMRA8Yd56Ru3t+a?=
 =?us-ascii?Q?fTGiOd9buUSeIObl+txF7NuI8ufry2ELQv0odneme23OegYr/SeSTl9PSQff?=
 =?us-ascii?Q?O+2oXUJDEZKdwHYQ5fRPgsd/sf02EJdlnFkyiKX1Ks5pi6lJNt1n9JCRxQ2x?=
 =?us-ascii?Q?cYez1zT6movuKoyuRvUYKb/w5HWyCNiXg/JEteJhPR9w0FRc1qm3iNMwTisY?=
 =?us-ascii?Q?iAOkmHSG26EDBoxPwJCWO76XG3alB1OBmfk7ArNMXlO/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(38070700021)(921020)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uATcTfGrRYyMz5Do/SxOvAZQNHVrBvLXeoABc7cPgR2SiKCXHpWHbvWkFN8Z?=
 =?us-ascii?Q?VMfFALZ2IxTEXyEIlPpWose1DUrm++4eG1WN6mgfq/5dUjMl0QMXtVrQu5xw?=
 =?us-ascii?Q?ydrq3SnVSjUr7ajQjDya/ci8e40MJ++TaAp9s0J3Expt6xCnadRk4R15SzHg?=
 =?us-ascii?Q?ccAdtHc95cPdJxEnf3TrCGPCy2VpezF2pBanWyalrik6W1cK04xYp09H+86E?=
 =?us-ascii?Q?8ueRWOuyLrtUMohc+BIa+yQKMzWUoL+O/DpLCTvrvocxqOjZql+m8kmp6Umj?=
 =?us-ascii?Q?ub2RjrYFu9IJA2iKt0dEYAo6VTwd3kGTYxfEZju2r8KTe8XSBRAl2t1l/d7G?=
 =?us-ascii?Q?v5xkpRw/WBa2FVcmXlqiU9cbJyQFiN9TpWiO6jAHuvYW1ch+F0scwDUhD3e+?=
 =?us-ascii?Q?hHGuufBmImEB1sJjMC097omCG2muGTrLEjk3ERXyCNMcY9s/vCM9vmuYXctr?=
 =?us-ascii?Q?UUWuZs+bOc+1l+sMJjUiXIrikrrUV4HOXyX4249A7dU8qyuwTVrdOkTRGn8E?=
 =?us-ascii?Q?5c7cG7vfxTWK1o5/m1kpwHbviQROS534WJgPB5xKlR1aRUp2CswWfuPlJjd2?=
 =?us-ascii?Q?i/byDYTLJKHcJD8i6DlxVGE0Y9UHQ9q6hfU8GXUibwV/BzjD9rT5GJKUisZI?=
 =?us-ascii?Q?nbJneuYi5mlPRD/fDxdMp0+Vk1PyrtKII2knB/v+aABTjM7prx8ChqsVW79n?=
 =?us-ascii?Q?/E3sVeDq8S9abZx6sC83PHkSMWcNyz3zqurOytSwtd8aG+ixUBR8dh/b564p?=
 =?us-ascii?Q?jlsGTytFXCvY9ipyfCdD2q/vGQeZrouhuTArGknxyLTugmWB997hRoL+ThJX?=
 =?us-ascii?Q?jafKkliSxGq7uUgjeQYmpP1wfh61TY5wVbQJkc65/mXDIGZKpHjWkSBCLYBl?=
 =?us-ascii?Q?3syrhpKIng65qZlwCZx2PUtSj4GGmCCeBy/NGxbhTpO2w9XK3SS0LUIMhDO8?=
 =?us-ascii?Q?ooUEDGh91lwE5aY5/mA7rQ6jW07i+V+2ThlEE4yuJigz4xZcd0MN+COvFz9R?=
 =?us-ascii?Q?rpSus9s2pL/c7u2zxJ1wgCCeQYtIctiwSRs1GZ87V5hpZba9LAkQ6FOD36pa?=
 =?us-ascii?Q?T50eZM7GRuLRoRto1mBcELw2dwMl1JfSF/x4b/Cd9jGmoGalkWqSuvbZrwH3?=
 =?us-ascii?Q?HCuSgso9plypxJqigpCSk/ckVI0grmv0HydSa7NsXAWSVJNsOHVW/9QDqFYe?=
 =?us-ascii?Q?k2htBydWKox7NMvt37egzysxGBlQVpKRoJj1bBn8XB1IUYdim2MTfxN402Qs?=
 =?us-ascii?Q?KanJavl4hVyyUNiK79ka30tC9MikSxE3FKmd5xPQDR3JA9B6RQ2Hxan+9Uot?=
 =?us-ascii?Q?xKkc7u7/HeiatwNBbDA5m+vG5poBfxoM13S0b6PzH6eGz62ikpzvmEQpcKT+?=
 =?us-ascii?Q?i/h3CwKLkljWRCjbWCZ5PNfZE0oSbBT+l8fRhwlVySYovblyYsAjT6jKMySM?=
 =?us-ascii?Q?ws3NYAJlI6UsVCDnjUzLkTj60XoPAWshcKScDobWxSWlIqHIVn2dNfr6Hf8n?=
 =?us-ascii?Q?QjHEwYxiuwTWK4EGbsbGqfuBM/HZFGmNzSWTGYMVuRO7IAHsl4718I8mY3J/?=
 =?us-ascii?Q?/6E6SQ3U0i5JxdgAeB/acz4YE0MX6sYWArVWgnbMbhwxYcfBQaAikyjog6XT?=
 =?us-ascii?Q?4Y9pO32Svsp76kPC7ONafeBbr+VxucKfIvr3nt7Yrnsr0vOUB47y1emvv4Gy?=
 =?us-ascii?Q?pNOkxBq7SDBzymsZ0LCBx8Hfv5aR/kC6xYavwZeB1+x/OytprpsTDhAgToy5?=
 =?us-ascii?Q?Epu7C5MBMe+fthdq4n9CKd0xpmAecKlByz9p37GBnNkRpzl2Jna/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f152de-088d-43d6-1ea9-08de639939dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 02:58:08.3814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN3D6mqsHHLXXcGeHfA12yJHuKtQFTJhzmgcaKKclepTrQslG5CyagCejz9br6aa6qM/PAdZ9NWpTsarWrak+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16496-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,SJ0PR12MB6806.namprd12.prod.outlook.com:mid,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 04312E113B
X-Rspamd-Action: no action



> From: chia-yu.chang@nokia-bell-labs.com <chia-yu.chang@nokia-bell-labs.co=
m>
> Sent: 03 February 2026 09:41 PM
>=20
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> virtio_net currently negotiates ECN-related capabilities through
> VIRTIO_NET_F_HOST_ECN and VIRTIO_NET_F_GUEST_ECN. This is not sufficient
> for flows using AccECN (RFC9768), because AccECN requires preserving the
> ACE signal (CWR flag is part of it) across GSO operations. Without
> explicit AccECN capability bits, the device and driver may treat AccECN
> traffic using the RFC3168 ECN offload logic, causing the CWR flag to be
> cleared. As a result, AccECN segments may lose their ACE signal integrity=
.
>=20
> Fix this by adding new AccECN capability bits for negotiation between
> host and guest: VIRTIO_NET_F_HOST_ACCECN and VIRTIO_NET_F_GUEST_ACCECN.
> In addition, translate the AccECN GSO flag correctly between the virtio
> header (VIRTIO_NET_HDR_GSO_ACCECN) and skb metadata (SKB_GSO_TCP_ACCECN)
> to ensure correct ACE signal preservation bwtwen virtio_net and the
> socket stacki.
>=20
> This corresponds to discussions in virtio mailing list:
> https://lore.kernel.org/all/20250814120118.81787-1-chia-yu.chang@nokia-be=
ll-labs.com/
> And it was suggested to clarify documents of SKB_GSO_TCP_ECN and
> SKB_GSO_TCP_ACCECN first.
>=20
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> ---
> v3:
> - Update commit message and title for clarity
>=20
> v2:
> - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
> ---
>  drivers/net/virtio_net.c        | 14 +++++++++++---
>  drivers/vdpa/pds/debugfs.c      |  6 ++++++
>  include/linux/virtio_net.h      | 18 +++++++++++-------
>  include/uapi/linux/virtio_net.h |  5 +++++
>  4 files changed, 33 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..103fb87c690e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -75,6 +75,7 @@ static const unsigned long guest_offloads[] =3D {
>  	VIRTIO_NET_F_GUEST_TSO4,
>  	VIRTIO_NET_F_GUEST_TSO6,
>  	VIRTIO_NET_F_GUEST_ECN,
> +	VIRTIO_NET_F_GUEST_ACCECN,
>  	VIRTIO_NET_F_GUEST_UFO,
>  	VIRTIO_NET_F_GUEST_CSUM,
>  	VIRTIO_NET_F_GUEST_USO4,
> @@ -87,6 +88,7 @@ static const unsigned long guest_offloads[] =3D {
>  #define GUEST_OFFLOAD_GRO_HW_MASK ((1ULL << VIRTIO_NET_F_GUEST_TSO4) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_TSO6) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_ECN)  | \
> +			(1ULL << VIRTIO_NET_F_GUEST_ACCECN) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_UFO)  | \
>  			(1ULL << VIRTIO_NET_F_GUEST_USO4) | \
>  			(1ULL << VIRTIO_NET_F_GUEST_USO6) | \
> @@ -5976,6 +5978,7 @@ static int virtnet_xdp_set(struct net_device *dev, =
struct bpf_prog *prog,
>  	    && (virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>  	        virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_CSUM) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) ||
> @@ -6635,6 +6638,7 @@ static bool virtnet_check_guest_gso(const struct vi=
rtnet_info *vi)
>  	return virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO4) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_TSO6) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ECN) ||
> +		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_ACCECN) ||
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_UFO) ||
>  		(virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO4) &&
>  		virtio_has_feature(vi->vdev, VIRTIO_NET_F_GUEST_USO6));
> @@ -6749,6 +6753,8 @@ static int virtnet_probe(struct virtio_device *vdev=
)
>  			dev->hw_features |=3D NETIF_F_TSO6;
>  		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ECN))
>  			dev->hw_features |=3D NETIF_F_TSO_ECN;
> +		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_ACCECN))
> +			dev->hw_features |=3D NETIF_F_GSO_ACCECN;
>  		if (virtio_has_feature(vdev, VIRTIO_NET_F_HOST_USO))
>  			dev->hw_features |=3D NETIF_F_GSO_UDP_L4;
>=20
> @@ -7169,9 +7175,11 @@ static struct virtio_device_id id_table[] =3D {
>  	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
>  	VIRTIO_NET_F_MAC, \
>  	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, =
\
> -	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6=
, \
> -	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_UFO, \
> -	VIRTIO_NET_F_HOST_USO, VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6=
, \
> +	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_HOST_ACCECN, \
> +	VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
> +	VIRTIO_NET_F_GUEST_ECN, VIRTIO_NET_F_GUEST_ACCECN, \
> +	VIRTIO_NET_F_GUEST_UFO, VIRTIO_NET_F_HOST_USO, \
> +	VIRTIO_NET_F_GUEST_USO4, VIRTIO_NET_F_GUEST_USO6, \
>  	VIRTIO_NET_F_MRG_RXBUF, VIRTIO_NET_F_STATUS, VIRTIO_NET_F_CTRL_VQ, \
>  	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
>  	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
> diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
> index c328e694f6e7..90bd95db0245 100644
> --- a/drivers/vdpa/pds/debugfs.c
> +++ b/drivers/vdpa/pds/debugfs.c
> @@ -78,6 +78,9 @@ static void print_feature_bits_all(struct seq_file *seq=
, u64 features)
>  		case BIT_ULL(VIRTIO_NET_F_GUEST_ECN):
>  			seq_puts(seq, " VIRTIO_NET_F_GUEST_ECN");
>  			break;
> +		case BIT_ULL(VIRTIO_NET_F_GUEST_ACCECN):
> +			seq_puts(seq, " VIRTIO_NET_F_GUEST_ACCECN");
> +			break;
This hunk should be a separate patch for the pds driver. It confuses with t=
he subject.

>  		case BIT_ULL(VIRTIO_NET_F_GUEST_UFO):
>  			seq_puts(seq, " VIRTIO_NET_F_GUEST_UFO");
>  			break;
> @@ -90,6 +93,9 @@ static void print_feature_bits_all(struct seq_file *seq=
, u64 features)
>  		case BIT_ULL(VIRTIO_NET_F_HOST_ECN):
>  			seq_puts(seq, " VIRTIO_NET_F_HOST_ECN");
>  			break;
> +		case BIT_ULL(VIRTIO_NET_F_HOST_ACCECN):
> +			seq_puts(seq, " VIRTIO_NET_F_HOST_ACCECN");
> +			break;
>  		case BIT_ULL(VIRTIO_NET_F_HOST_UFO):
>  			seq_puts(seq, " VIRTIO_NET_F_HOST_UFO");
>  			break;
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..0cf86b026828 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -11,7 +11,7 @@
>=20
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
>  {
> -	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
>  	case VIRTIO_NET_HDR_GSO_TCPV4:
>  		return protocol =3D=3D cpu_to_be16(ETH_P_IP);
>  	case VIRTIO_NET_HDR_GSO_TCPV6:
> @@ -31,7 +31,7 @@ static inline int virtio_net_hdr_set_proto(struct sk_bu=
ff *skb,
>  	if (skb->protocol)
>  		return 0;
>=20
> -	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +	switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
>  	case VIRTIO_NET_HDR_GSO_TCPV4:
>  	case VIRTIO_NET_HDR_GSO_UDP:
>  	case VIRTIO_NET_HDR_GSO_UDP_L4:
> @@ -58,7 +58,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>  	unsigned int ip_proto;
>=20
>  	if (hdr_gso_type !=3D VIRTIO_NET_HDR_GSO_NONE) {
> -		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> +		switch (hdr_gso_type & ~VIRTIO_NET_HDR_GSO_ECN_FLAGS) {
>  		case VIRTIO_NET_HDR_GSO_TCPV4:
>  			gso_type =3D SKB_GSO_TCPV4;
>  			ip_proto =3D IPPROTO_TCP;
> @@ -84,7 +84,9 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buf=
f *skb,
>  			return -EINVAL;
>  		}
>=20
> -		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
> +		if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ACCECN)
> +			gso_type |=3D SKB_GSO_TCP_ACCECN;
> +		else if (hdr_gso_type & VIRTIO_NET_HDR_GSO_ECN)
>  			gso_type |=3D SKB_GSO_TCP_ECN;
>=20
>  		if (hdr->gso_size =3D=3D 0)
> @@ -159,7 +161,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
>  		unsigned int nh_off =3D p_off;
>  		struct skb_shared_info *shinfo =3D skb_shinfo(skb);
>=20
> -		switch (gso_type & ~SKB_GSO_TCP_ECN) {
> +		switch (gso_type & ~(SKB_GSO_TCP_ECN | SKB_GSO_TCP_ACCECN)) {
>  		case SKB_GSO_UDP:
>  			/* UFO may not include transport header in gso_size. */
>  			nh_off -=3D thlen;
> @@ -231,7 +233,9 @@ static inline int virtio_net_hdr_from_skb(const struc=
t sk_buff *skb,
>  			hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>  		else
>  			return -EINVAL;
> -		if (sinfo->gso_type & SKB_GSO_TCP_ECN)
> +		if (sinfo->gso_type & SKB_GSO_TCP_ACCECN)
> +			hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ACCECN;
> +		else if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>  			hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>  	} else
>  		hdr->gso_type =3D VIRTIO_NET_HDR_GSO_NONE;
> @@ -282,7 +286,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  		return -EINVAL;
>=20
>  	/* The UDP tunnel must carry a GSO packet, but no UFO. */
> -	gso_inner_type =3D hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN |
> +	gso_inner_type =3D hdr->gso_type & ~(VIRTIO_NET_HDR_GSO_ECN_FLAGS |
>  					   VIRTIO_NET_HDR_GSO_UDP_TUNNEL);
>  	if (!gso_inner_type || gso_inner_type =3D=3D VIRTIO_NET_HDR_GSO_UDP)
>  		return -EINVAL;
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_=
net.h
> index 1db45b01532b..af5bfe45aa1f 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,8 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_HOST_ACCECN 25	/* Host can handle GSO of AccECN */
> +#define VIRTIO_NET_F_GUEST_ACCECN 26	/* Guest can handle GSO of AccECN *=
/
>  #define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level =
statistics. */
>  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notifi=
cation coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coale=
scing */
> @@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV=
4 | \
>  				       VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6)
>  #define VIRTIO_NET_HDR_GSO_ECN		0x80	/* TCP has ECN set */
> +#define VIRTIO_NET_HDR_GSO_ACCECN	0x10	/* TCP AccECN segmentation */
> +#define VIRTIO_NET_HDR_GSO_ECN_FLAGS	(VIRTIO_NET_HDR_GSO_ECN | \
> +					 VIRTIO_NET_HDR_GSO_ACCECN)
As Michael suggested, given this is yet to be approved by the virtio-commun=
ity, can you please roll this patch later to net-next?
This way your rest of the 2 patches in net with fixes tag and new comment f=
or ACCEN in net-next can proceed?

>  	__u8 gso_type;
>  	__virtio16 hdr_len;	/* Ethernet + IP + tcp/udp hdrs */
>  	__virtio16 gso_size;	/* Bytes to append to hdr_len per frame */
> --
> 2.34.1


