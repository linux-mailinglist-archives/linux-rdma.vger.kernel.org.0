Return-Path: <linux-rdma+bounces-16375-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHN8M8oSgWkqEAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16375-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 22:10:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D32BD18D8
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 22:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA6583034571
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 21:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919E310652;
	Mon,  2 Feb 2026 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="n+bdpNIl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37201308F03;
	Mon,  2 Feb 2026 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066575; cv=fail; b=K92dZba5m0IgxWc7BHGmRqibXwly/VNnQUWZJ+C+o+1q1G+zqIn5hDC9o5/V21CIclPYvE5jw7jLKqgv3sIi7ahzGdEUQwsFxq5ZemfuhqKv8zh3yKfZpvIBg+b6K4dS0GSeepQPXA9VM2wjFPeuBSzHRrmUSfDo3DgwTUxBcFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066575; c=relaxed/simple;
	bh=xkq/S85vUyS5iKg6ayGv0WbkmpBE1rwr1ETMqJ8H4X0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TgAdQlBTK7rbuL+3+zyEGeyRTvd/i40lQSZkRSbJ+6AZU/GO5LAh38G/LzFH1rVphQL+rPGlTNBT5ZkcRm8/QnRvutZA9SPp1rqlFP6sA3UT+w2anjPhZ8uECV8f+cHcg6efPdazyHDLpsFLLKU2PjoWuaU2tgfgAR7mg0Hfjuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=n+bdpNIl; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqnCQxIN7V+p6B6ZS1VYLHX0O0XcazzB76qFhFlTC5KzSOOCPnMw0e+dvE3O1a1FuGOL5qBaR7146qO2Uv76IjdtF88NqdA6lUvKPv8vxX/1PHHP8KP1mgCF7lVOetJHm5DhoSZWFSvHVz/rNqNV2XyFv3udTIm7nxj0OBXN4iYj3i1dhWNKG+uTobHA3oB6NzEzxJblRsHjFdyEnud9rjEzsS6ScwPYdQkZ+jInyfHTowADjlDZEc+GiFr6r1AHl9Hj223rRtR3PnCIX2jFCm9yjArsu9DdKyckRceW9x2cxjS/NiciajI8x627CsQSkBo4D3Qe60m93BrhPfX3bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LjomvUGWsd66Y9jbHaXhqlS99ya+BKpyCpHOt2HV91k=;
 b=h1TmUKmbPfq5t0ikyfcM+0wT0I5y83LXNDWjG7ad5sG8+GOiPeitQHlU9hKfgmefNtN7oCWnhDdI28E9xxCjJIcr9WptWxvuylwNJmHSNrsa+xJIoDJ+mwaFA7UzyHVnQr/zVUfU2ibZED/UyWmPTprNML8UmcEwZnY55mj0E0LNELuiasbPN1oiDySyrGJmsYV+ye7ZuMQU+Jl3xiz5PJkih+UU6TzHc0/7HEhEDfsqW9XrjHR5cME4v119L4Y7e+G3KICG9QZloIv89N5L89pmtTy3gB2Kbs3vcWoQfPiTXBKezZJglnfX23sRXI6dlYPTJipxAOGydhRjr16nYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LjomvUGWsd66Y9jbHaXhqlS99ya+BKpyCpHOt2HV91k=;
 b=n+bdpNIltcIpNRx1XuGyHQxXE2vqLMLboWUzGrP9J15t+YDmeDrm+qe79UQmpTLgvw3NZWAHACCznXd4R9Jqk4KCMLnGKFXgiDfsu14FeUYieOrXyttDLmnLl0OWbXG0HXNLxhrwT19A+d+SEIWK2cSRneMR8rdEO4IOvdo4S4fheDzNamZlYwA0t3nQ8oTwZ25Ja6DkHJK5VXdai3j4eosfXIqZCB5ajrSq7lQGWH3l5AjmMKbyPtZLx7kVTH09S54Bo0WIB81t3gUoRIGV1kLlnfoNLyG+1Na2EXz7UucHCtC5kZLzCmd8dFI7d26yGoiYFqOfs7QzNZbLp28X9Q==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI0PR07MB10807.eurprd07.prod.outlook.com (2603:10a6:800:2c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 21:09:28 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Mon, 2 Feb 2026
 21:09:28 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "mbloch@nvidia.com" <mbloch@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
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
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Thread-Topic: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in
 virtio_net_hdr
Thread-Index: AQHckwSvr7yGsOyrpUmxwtqxbyNbCbVtkSqAgAIPIWCAAAnvAIAACFrQ
Date: Mon, 2 Feb 2026 21:09:28 +0000
Message-ID:
 <PAXPR07MB7984B37862D3FBBE363AE5A8A39AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-4-chia-yu.chang@nokia-bell-labs.com>
 <20260201035912-mutt-send-email-mst@kernel.org>
 <AM9PR07MB79696F945D8DBEF370CD4DC6A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
 <20260202121830-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260202121830-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI0PR07MB10807:EE_
x-ms-office365-filtering-correlation-id: 593589ab-4a2a-4b6f-1ad1-08de629f5a2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YeyKsOCZaSFMioY6hQHSapN5iBu/3Of8jK8KwV1H9VRc9LkKW8ALnro6VC7w?=
 =?us-ascii?Q?DvJb8Wss6RBD0Ig0ZYjBKDD7KwwR/Y7XGPFsY79n/CVNEE62ccD7Ny45cZRw?=
 =?us-ascii?Q?Nehs4jtAD7xlc0AR/MzdIPpQFKXL+RlZnKlQt9EaxQiyaZHRZL0H9JrwUCkr?=
 =?us-ascii?Q?y95JEMKyo+qNlN9GLuUjLBmRUxn0Gr2FCUt5t4zviJXu900xjJRrjKYGYtJd?=
 =?us-ascii?Q?T+7LMxj2s6jH9RG1oXdTWTRueaieX5G8EE8UOA1TECK6xp8D3NVgnpo99T1B?=
 =?us-ascii?Q?0m6/Rn27iOE2a0/7ZUPlSiOVTl+Tb9rYYVbBZKprcjnAPoXQ1y06OdjGmYwY?=
 =?us-ascii?Q?Y0IEeYGBoTz8N0dmRSmpLl2Who5V6nzNAgmnwZraZFiPyTOSYCE0zb77hYZu?=
 =?us-ascii?Q?SMUn7MBNTnumV9nNafSYFdLUm9rzaNzvxvKjJaV8KWGfQ0JdiwMmUSjfYxQs?=
 =?us-ascii?Q?dVSP2dAAZRYRoQohuQ/HPsNV6TCAgo3rCWoG1SzBdbK4qCf+ji0Tos9n4pdI?=
 =?us-ascii?Q?GnUBvSVtBSGcYVqSKwVuAc6bj6hw+x6LN9UeB2miZddEVskAzePHnVlagrmP?=
 =?us-ascii?Q?ZuDylbP3b5M0lrnd/uCDjEysmZHmrZtan+14RnNOE5PUuljPjTCJkmZYzNbE?=
 =?us-ascii?Q?51EjNI4aMCmUOLB0/3Rq/9mJsNtwDl1SFzOIIVbd5g4pLj+acuIL6RcoNbn/?=
 =?us-ascii?Q?x7p/BQEqK+YkXiGWBLXvr+/v794X1nP5Q/VWy4CJaOH4EUCaNL/l04a89Krj?=
 =?us-ascii?Q?dInhR75QIQvXLufjDHNjJjob8XNBmNTLSws9Wojkqrl0JGbc18pqxnFoeagC?=
 =?us-ascii?Q?rmAwmCFjUgKyqSX5sOrwvrZPJizpIJ52zOlRJuCBIDPSYicqT0qjmHLxXYtQ?=
 =?us-ascii?Q?kE0UHxxtFRumWo+BLrG686d1uwQX0s1vUjI55M7zU/+zd0P/9YY6TBa7Avvp?=
 =?us-ascii?Q?HtdX2ogYfmvmiKcQYI/73gcr0YK/qbif+mzC4mz/U+XRHPUrcWKlUv4/e/Mb?=
 =?us-ascii?Q?AwVyENa0uI4NZeZch6T7yaLka8FMnS4SzWdfJ3+1KCxpIVQQ+3cI30KXJ71U?=
 =?us-ascii?Q?hhNypnbuMEohjnOJ26Pu76ZyjGvaJXbXk+4ExKMdZq4pAdhHj3auuVT9b7xu?=
 =?us-ascii?Q?Eudo1egYCk5ted8vGF5h6Y6klm4zTdPrq3lenKDu43bhb2HXSmx9UOjuU4b4?=
 =?us-ascii?Q?ULMf8m8WVe7XZJdsP4hTGOjAYLRWIQ6W3WFypfvPoboU70UOxp33TWW14pXe?=
 =?us-ascii?Q?ViTsOCswTQB2SGkYGWiZ5KDeIsEt5QeiiVpDxB8EhaMsCszo/axiidsBILOX?=
 =?us-ascii?Q?AZRovFCEoPKW6Pct/PJ8hwBL95DUABKQF5H0ORizfKBNflnBIHk51WUfLWDH?=
 =?us-ascii?Q?IFvRjD5mONEHTvff2L4zESbm88OQaG1e65LMtnxa22+rgSw+yucD4LJd0j9N?=
 =?us-ascii?Q?IAB5Cg9vOXv2wVrAP6IpCLhn6vI4Gbq7VsB/TQDMT4rohpTQd84q/Yy6+aFw?=
 =?us-ascii?Q?9XMh3SdAWz+0Fx5uttK+cF0rF4abM6q0Lu0m9iqkqiPD185TKhugQZGi6Fbc?=
 =?us-ascii?Q?mwtn9GFYCmT6aXEtsB6URIN3JOsZtiBW7e4Ng8Ee?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UfMBdPQDbk1z8w+0vOJ++gTIw1bQXZhOdljtqVIJuiSIJyF4bgD85tdU9Ao+?=
 =?us-ascii?Q?YUrovmls2Oun00qeOKSsSQ0Gl/WiHRUqv/FZFAMWPmu8jKSs3rbIftasoODc?=
 =?us-ascii?Q?CDZ3RE4oX1BEh6jOxH9bAH6qUreIsmGu7mjZ9LhWSOgL/WxxtWN3gZ0hQsH9?=
 =?us-ascii?Q?xgq6Woz4jnIaSCcLAiwBNka96cIdMyPAkKd6lcMKiku/6bGYSBpwSpPly2Bk?=
 =?us-ascii?Q?WdKGSQ2Q3r+ct/DrirgP6F6eGK6eA4nFaNcr1/FlKzrbbr20xoW4xxG/KNTB?=
 =?us-ascii?Q?nZ9dtl78UQF5b1LGWI5dRXJi2lfpsDesZiE4R/8F97Wt+478FF4IdDBKNwUl?=
 =?us-ascii?Q?vexCYN4FUFjrr08oP7TJLGkgewjtpSmLk73fCrqL3mnBx3qSd3hec+ufD++7?=
 =?us-ascii?Q?LOkIDCofzNSZUMCcH24HtJSH3MrRELiVx//nqbO8vQaTx7t0GbKSogNObNlO?=
 =?us-ascii?Q?GD/rZE3+KIkCvgkdwxL+t7NNiCuKI2Uld2qTqdUzUUQtckJpaqAZocxCwuVI?=
 =?us-ascii?Q?d7PIqPIFjqv5WW3Vb104aOKM9KrT2HJAZS68TgRJQiz4YGLCg6KL7RvgrnCR?=
 =?us-ascii?Q?QqY1nWzby7Ez+/vF3xeOAOdnsCUhQDNkoBVkNR3Jdo80VqapGWWqUClQ5aAf?=
 =?us-ascii?Q?/01e3tlkd6Cx420irS94hO8KwKfYCfFQ95DCXgE7eEbkkWdW66nBdcCc+y4T?=
 =?us-ascii?Q?ZIJx+SWA2/X58MoE92nktHpBo+xKZjyhvRhsSxZ3SAmW68F0mNAYfDCv8RQc?=
 =?us-ascii?Q?2RZGUzQRmcei7nsLRq/TQzXMySp9y8/SDLArz7+ab2r8zpZABqM7uL4gtK0j?=
 =?us-ascii?Q?BdgX+mF1uWNdkh6hS73IgkFg0NWAAw8Cp5n/GltetPe/GEDwULOx4yK3LPYI?=
 =?us-ascii?Q?oYSaM5M1l68Aa+5KRck5v4uulD98zC17Krs8PnXZCFRPJBsDG8y82I0cu8lH?=
 =?us-ascii?Q?One5ytKLKB5gsJtMPOkBgBOFD9R8UaPWZ0H3bbMqRJen9TdUzlw+FjCaVwon?=
 =?us-ascii?Q?sf9QJowiuKJXMtbwksmbNR/o2JF/EwGAXnJUHzajQJf6gQkJW6WeULt7Ug67?=
 =?us-ascii?Q?2nJziZWVd35UiggCG/xNC+v6/6yg5gQRYjJ00dlsyc0iSSFe8DR2HGpO1Gfe?=
 =?us-ascii?Q?icGlP+xWQKU4Mm72OYmi/2KWP1POiKcn+ElP1xRzkSK9bJqagJZMigjSYiLk?=
 =?us-ascii?Q?trXwzzNGpZPK5z9O5w9sec6oRtEK+bRuL5ulO21FIf3r3ZNJZl+5d0wrqMqC?=
 =?us-ascii?Q?lrpEEy4nlVa6RoXRkaaNBE56zkDGeBQCF1iaDmL+ZfPFra1hAzee/+eRIILO?=
 =?us-ascii?Q?QYwGVwnlMOUmeSpDIQX0z5lILlFofuu82SeiGdgsUsK8yHGrxemIMjf+z7hj?=
 =?us-ascii?Q?w96iW/GdG/Wztcxcfir+mI5Vyb7gejx7B0cz9JoZ8OrhvdMck7dFvdrxloZt?=
 =?us-ascii?Q?aKW66faycEbIq4dj7nktjj9nd1pHiukK0qWpmE7W38zXB8ZbsT1HQwRQkhU2?=
 =?us-ascii?Q?yoEbT35Sl6jIfwSKKZoUigd2L9N8XrVuV2jneFu3vgbrnwVr+2xkQUclPAj0?=
 =?us-ascii?Q?fbx1gIZerWGaMrQlsGMV68o9Rzr46Oz/R5YLMh4Qerhlh+bOYLFr+/+1D0Xc?=
 =?us-ascii?Q?PToD/O1RuLoBWsTddoZwQUlqHfk9k5gsV0hF08lLBZ5Z0eZOW7T/geIy4uag?=
 =?us-ascii?Q?VoHAxU/YxYo0+WPdsQ+CKZr4IT+1Kapu/0XjowIFJFPd+Cf//L14IIIAao8U?=
 =?us-ascii?Q?VLPI5uJzRuSgC6BDucPXi7AaxYH/iK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593589ab-4a2a-4b6f-1ad1-08de629f5a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 21:09:28.5121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtBBou0Yj+VZ41rnCedkIskWWA9dTgvC8gWbcnw/q+xoClo940lnu4n0y95Q8ycmcdsbudP4VesiZ5tuX/0sAxVB85InO4AIfRm9g4Wy/dGC7zFzh25zARgbnB4vhvWz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10807
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16375-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D32BD18D8
X-Rspamd-Action: no action

> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>=20
> Sent: Monday, February 2, 2026 6:20 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org; shaojijie@huawei.com; =
shenjian15@huawei.com; salil.mehta@huawei.com; mbloch@nvidia.com; saeedm@nv=
idia.com; leon@kernel.org; eperezma@redhat.com; brett.creeley@amd.com; jaso=
wang@redhat.com; virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com=
; pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@vger.=
kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@go=
ogle.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.com;=
 jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; xiyou.wangc=
ong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch=
; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@ker=
nel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.c=
om; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.whit=
e@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsso=
n.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vid=
hi_goel@apple.com
> Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag in vir=
tio_net_hdr
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Mon, Feb 02, 2026 at 04:56:38PM +0000, Chia-Yu Chang (Nokia) wrote:
> > > -----Original Message-----
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, February 1, 2026 10:18 AM
> > > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> > > Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org;=20
> > > shaojijie@huawei.com; shenjian15@huawei.com; salil.mehta@huawei.com;=
=20
> > > mbloch@nvidia.com; saeedm@nvidia.com; leon@kernel.org;=20
> > > eperezma@redhat.com; brett.creeley@amd.com; jasowang@redhat.com;=20
> > > virtualization@lists.linux.dev; xuanzhuo@linux.alibaba.com;=20
> > > pabeni@redhat.com; edumazet@google.com; parav@nvidia.com;=20
> > > linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org;=20
> > > dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org;=20
> > > netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com;=20
> > > kuba@kernel.org; stephen@networkplumber.org;=20
> > > xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net;=20
> > > andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net;=20
> > > liuhangbin@gmail.com; shuah@kernel.org;=20
> > > linux-kselftest@vger.kernel.org; ij@kernel.org;=20
> > > ncardwell@google.com; Koen De Schepper (Nokia)=20
> > > <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com;=20
> > > ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com;=20
> > > cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com;=20
> > > vidhi_goel@apple.com
> > > Subject: Re: [PATCH v1 net-next 3/3] virtio_net: Accurate ECN flag=20
> > > in virtio_net_hdr
> > >
> > >
> > > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional inf=
ormation.
> > >
> > >
> > >
> > > Thanks for the patch! Yet something to improve:
> > >
> > > On Sat, Jan 31, 2026 at 11:55:10PM +0100, chia-yu.chang@nokia-bell-la=
bs.com wrote:
> > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > >
> > > > Unlike RFC 3168 ECN, accurate ECN uses the CWR flag as part of the=
=20
> > > > ACE field to count new packets with CE mark; however, it will be=20
> > > > corrupted by the RFC 3168 ECN-aware TSO. Therefore, fallback shall=
=20
> > > > be applied by seting NETIF_F_GSO_ACCECN to ensure that the CWR=20
> > > > flag should not be changed within a super-skb.
> > > >
> > > > To apply the aforementieond new AccECN GSO for virtio, new featue=20
> > > > bits for host and guest are added for feature negotiation between=20
> > > > driver and device. And the translation of Accurate ECN GSO flag=20
> > > > between virtio_net_hdr and skb header for NETIF_F_GSO_ACCECN is=20
> > > > also added to avoid CWR flag corruption due to RFC3168 ECN TSO.
> > > >
> > > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > >
> > > To the best of my understanding, this is a new feature - support for =
VIRTIO_NET_F_HOST_ACCECN, VIRTIO_NET_F_GUEST_ACCECN?
> > > The commit log makes it sound like it fixes some behaviour for existi=
ng hardware, but that is not the case.
> > >
> >
> > Thansk for the feedback, I will update commit message in v3.
> > >
> > > > ---
> > > > v2:
> > > > - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
> > >
> > > but where is v2? this is v1...
> >
> > I shall update this version as v2, will do at the next version.
> >
> > [...]
> > > > diff --git a/include/uapi/linux/virtio_net.h=20
> > > > b/include/uapi/linux/virtio_net.h index 1db45b01532b..af5bfe45aa1f
> > > > 100644
> > > > --- a/include/uapi/linux/virtio_net.h
> > > > +++ b/include/uapi/linux/virtio_net.h
> > > > @@ -56,6 +56,8 @@
> > > >  #define VIRTIO_NET_F_MQ      22      /* Device supports Receive Fl=
ow
> > > >                                        * Steering */
> > > >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23        /* Set MAC address */
> > > > +#define VIRTIO_NET_F_HOST_ACCECN 25  /* Host can handle GSO of=20
> > > > +AccECN */ #define VIRTIO_NET_F_GUEST_ACCECN 26 /* Guest can=20
> > > > +handle GSO of AccECN */
> > > >  #define VIRTIO_NET_F_DEVICE_STATS 50 /* Device can provide=20
> > > > device-level statistics. */  #define VIRTIO_NET_F_VQ_NOTF_COAL 52 /=
* Device supports virtqueue notification coalescing */
> > > >  #define VIRTIO_NET_F_NOTF_COAL       53      /* Device supports no=
tifications coalescing */
> > > > @@ -165,6 +167,9 @@ struct virtio_net_hdr_v1 {  #define=20
> > > > VIRTIO_NET_HDR_GSO_UDP_TUNNEL (VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 |=
 \
> > > >                                      VIRTIO_NET_HDR_GSO_UDP_TUNNEL_=
IPV6)
> > > >  #define VIRTIO_NET_HDR_GSO_ECN               0x80    /* TCP has EC=
N set */
> > > > +#define VIRTIO_NET_HDR_GSO_ACCECN    0x10    /* TCP AccECN segment=
ation */
> > > > +#define VIRTIO_NET_HDR_GSO_ECN_FLAGS (VIRTIO_NET_HDR_GSO_ECN | \
> > > > +                                      VIRTIO_NET_HDR_GSO_ACCECN)
> > > >       __u8 gso_type;
> > > >       __virtio16 hdr_len;     /* Ethernet + IP + tcp/udp hdrs */
> > > >       __virtio16 gso_size;    /* Bytes to append to hdr_len per fra=
me */
> > >
> > >
> > > UAPI changes need to be added to the virtio spec.
> > > Pls get this approved by the virtio TC.
> > > Thanks!
> >
> > There were some discussions last October in virtio-comment@lists.linux.=
dev mailing list.
>=20
>=20
> That's it I could not find it. Could you include the archive link pls?

The email thread I found is https://yhbt.net/lore/all/20250814120118.81787-=
1-chia-yu.chang@nokia-bell-labs.com/T/#m62dd5e559a68e8d3e5872e85d37c924f65f=
c7033

There were discussions about updating the documents of SKB_GSO_TCP_ECN and =
SKB_GSO_TCP_ACCECN, and you can find it in the first patch of this series.

>=20
>=20
> > At that moment, it is suggested to make Linux kernel accept new comment=
s for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN first.
> > So, could virtio-spec colleague give your feedback? (Parav?).
> >
> > Otherwise, the CWR handling of virtio will be wrong after all Accurate =
ECN commits are merged in Linux.
> >
> > Chia-Yu
>=20
> if there's a general agreement we don't need to block linux on tc approva=
l.
>=20
> --
> MST

Shall I also submit patches to virtio-spec? Please suggest ways forwards.

Thanks!

Chia-Yu

