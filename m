Return-Path: <linux-rdma+bounces-16338-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEmqGPSwgGn6AQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16338-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:13:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FE2CD335
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 15:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F817300BC46
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2786C36AB59;
	Mon,  2 Feb 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lm69v6Hi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5903C0C;
	Mon,  2 Feb 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770041436; cv=fail; b=jlKuoE9h7ey9uIIMqP8Zj8FuZwClgqo+JMXg+CPPs7hYoOG6KMHjrP2KAbMRxsV6xLySsx1r0c2lxDysuXLPIMATqcbn4NK8BC/1F8rgH0hd44Pdd+gAPU/fhSoV016pg/2PsCVFWLBRmub++k7CakSBZBwQ1bBbq063+kDWs3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770041436; c=relaxed/simple;
	bh=0/pjI7LEPLjoCvOWp7H9JcjXyC8yVewW9SjWbv9z/54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=McYtHdehjSStyGTaSQy8q4eZ/7rTNVRvEXSnVXzXtfkAxmcBs0pOVW9k/JTtc2ZnVQ+cauAhNLL6MCyF+QxovrHoL1LKY0OOfvDgfq8QBXet+7qcGMwP9i8el8dosM/2V0yr7kBZpLGsfbBdQFQHDnfkoWLuJwPwWOk2D4sbT+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lm69v6Hi; arc=fail smtp.client-ip=52.101.69.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJG1byOQpAp/Iv3o4OETOTmxiyHbnGeoyF40QjiXdZaJrfE4JwmnNQXoTiCIMp0G7MMQGZ3I7OuAGUj4X9JjrOoruV8HvqRDcHH98eM164AMTUzo3EP5QKnzHArmmwp/s0z4GmUutvSP5lRGnOPLZb1YqPN5CIQQ+ji4NKslowcd3/f8R2NKtzUwfgOMUjWOxbcnReKVZfKNg9IsVjTiP/DlUqJPzz60SpYH7u1BDrtk3qQe0aGYYYQRfin6bEmKla8ctYxiO0vi/JeERNbDKhP1DxvqTIQ9hn68QSiSFnt4gNHHMQwzAMG9IMOrK862cLyJl35R4H+RUZnBmhKKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAP2zJ0LnNt/RLKRLAZpoEbj0KC/+3mwh/02pXWGOOw=;
 b=S27jWXNkA5VK2Sg9Ir9ygsQT3tULqi3Xf8dxSh2sKOZNAtKWUJPyzkKTwOlLWSsLBKA7iDW8IzO+WRfJC/TqSkL6rCSBW6lWIB7QCvTPl/MXS8t7PI/949wI+PVD8rvFT6zhlkvMPeAhN1kndAmePrU+RE0Qr6hEJfEtlzFHDVYV8gyDoFyR1rPehbhy+vEH04kHD6Jf1ru9Ri6LSKUKgNPJe1zH8cieSK+/YbriVtgWCwcjbLyv9Nx4qV89APqJ00UlUtn2u+uA6p+lgMovPUXChi+OFZAr337TJH98/fmb9guHXZxkUM+oa0/f5FmVuYuD1HljwnpJLwX7wGc/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAP2zJ0LnNt/RLKRLAZpoEbj0KC/+3mwh/02pXWGOOw=;
 b=lm69v6HiJUnc/NxzAjBMRmYCfTjqhPmtsfFvU8+V0yFy5/opsZ3Niol5XY7fL/FuZLLmsablVYIw82hC8afhKSGx4k6HqAcpeitjw1esXf9IPqm+w+xKKBAvc4RsUCWzVOSSwS5mp1JRtyBxr95r2P9Bl4V/r+fHvDMCjB3WJ4xOfU8SCg1HqAhKYDiqvQc9Ai1hv3wzZBMdyZwbiLVTY9A583Pso3tplNxKEzHSnzHIcJOo42Gc8jPpXaAiDPd7XQ8VmZAh8MDeD7MFRfo1w4T/0gyyHNRFV6Mc8B7+8LoneOrfUUDmACHI/j9cl0zOaIEO8meWmiyu4HoaNU415w==
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com (2603:10a6:20b:302::15)
 by AMDPR07MB11453.eurprd07.prod.outlook.com (2603:10a6:20b:739::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:10:31 +0000
Received: from AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b676:5e6b:e3e7:4bbd]) by AM9PR07MB7969.eurprd07.prod.outlook.com
 ([fe80::b676:5e6b:e3e7:4bbd%5]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 14:10:31 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "tariqt@nvidia.com" <tariqt@nvidia.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "shaojijie@huawei.com" <shaojijie@huawei.com>,
	"shenjian15@huawei.com" <shenjian15@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "mbloch@nvidia.com" <mbloch@nvidia.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"eperezma@redhat.com" <eperezma@redhat.com>, "brett.creeley@amd.com"
	<brett.creeley@amd.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"mst@redhat.com" <mst@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "parav@nvidia.com"
	<parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
	<kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
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
Subject: RE: [PATCH v1 net-next 0/3] ECN offload handling for AccECN series
Thread-Topic: [PATCH v1 net-next 0/3] ECN offload handling for AccECN series
Thread-Index: AQHckwSqNJd+cLpfckquPKO4yVYjJrVtAgcAgAJyxvA=
Date: Mon, 2 Feb 2026 14:10:31 +0000
Message-ID:
 <AM9PR07MB79692171B9BB1BC2C2C0B888A39AA@AM9PR07MB7969.eurprd07.prod.outlook.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131164516.4a423230@kernel.org>
In-Reply-To: <20260131164516.4a423230@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR07MB7969:EE_|AMDPR07MB11453:EE_
x-ms-office365-filtering-correlation-id: bbc26924-4047-46a2-b2d5-08de6264d339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xBsinDcdjbws4a8HIucfQz7pOSav191l7a9ypBIC3KI9zGV6EantkLHh7nx1?=
 =?us-ascii?Q?tyAUMnaJ59zY4ycpMYwI7d1HYFjaY/tJguG8QRWEflSUwxV51rUsO/t5PSw2?=
 =?us-ascii?Q?drah2UFwGeRbUmZk72vDSEgEBP6AKed+CxdLCKdI77FMrWjApygrIrSpjvTj?=
 =?us-ascii?Q?ePH80lg/U9FM1oqctzVqjvdGjgPSbI20MdvO/fce79makQCHxwr2k7QOcKKo?=
 =?us-ascii?Q?AL5cwu4+JejGy104HDyHxHU93lS0+qB+UhT4TYJd4YOq66zFhOSB22zl2bB3?=
 =?us-ascii?Q?1fkoeQHp3/s65S6gRYQDz8/y7Fyvuv1nO8uXFafc7veYsQtAoPCo27d/85IR?=
 =?us-ascii?Q?yNu0Qyt3o1W6WO/jdLowAGKpSrY05pj0O9nheP04ptA7urDMsY9yPmPYZEJk?=
 =?us-ascii?Q?vbvZ/xL4OlIzV0aF8TigyV2TwTKi8wDd+EsS1SPRnid1MAWzBvUJuAjS3aCa?=
 =?us-ascii?Q?lWD8jOK6Jg+oqqGjtukwNg9ur8HeBmPMtbu8Bd11Gl/m7MUow6RqNoUh1awe?=
 =?us-ascii?Q?DT4HDTJxBD3EyXsAYq2dfGfu7PzleGESn44YeShnC9TTnu0jzbImhiDMkSZ7?=
 =?us-ascii?Q?2tWl2xePdg0eLZ9JDEFaxQveX8DGwSP3F489la6uebX4zhaaAb0QXBj0Cv8v?=
 =?us-ascii?Q?I4Auv0uf12+yn2J3hIymgB9KKuz+xZWXMsT4K7BSPllif00xVur0DdpcTk/H?=
 =?us-ascii?Q?MXlqVUVxuPVdxzoM8ASwm2enPsCL3k0q3w7BdQiWApgG73hS48s3yPrSm+vH?=
 =?us-ascii?Q?1PrLdRzjz/sJPvJq+foModqIQRqpWKCWvIAO1NQaU9KHKSDxFwNPtEWNjqWI?=
 =?us-ascii?Q?ktFvMeiBKOFQnHojkfGlm0O6cxj9LDrmyU1/87Az9DzJJPSPqMxMN/cGzbjI?=
 =?us-ascii?Q?Y9Pc7MiUShDnpKZDe3LMDan/Wdd91wzXtDF4BqQjfOV9+IV6Z7IJqTrUGwzo?=
 =?us-ascii?Q?ETXrr89z2fVxhANWyuzM496B0k9l0stxqZmRmSdu3+Mfi5IdslPNDKHN5vFJ?=
 =?us-ascii?Q?0flwntJrxRdXJ2PeigQjc+Py2Lz5rrURZHLzFxcU51BmgseKRX0kQp4Uz7A3?=
 =?us-ascii?Q?BytV1vItUj46aoaCoCHDk/HBdaSqRppMzbE4Opx3G/ZWjF5P4heI97taMZph?=
 =?us-ascii?Q?CjWFqJ0p9gQ3oraKcYTUvgP7840xfdOnJv7biGxQjd+8/TArhAabkVSiuOs9?=
 =?us-ascii?Q?nO9MN3ZmKmX67U3/4nXjs6f78UZLnREN/ghG1OdwemUZj8baFmYe9SnljIt9?=
 =?us-ascii?Q?sY+xuvX9WIewpnyjNXWj9E2taMZlPkUoiQpCI9XrG64g2FSh3jeVlAKZlPF8?=
 =?us-ascii?Q?34n+qyjPkr9sEgKeJTGXSOibZ/tlWBcBICq4ZazFwTBm10Zjy2u5ga4sMaGs?=
 =?us-ascii?Q?IaKOigQYOnePzsqgiWfh3qveXyyK8ae9Yy2MkQYpUbbfdAHxQhMc7CnRS19Z?=
 =?us-ascii?Q?EQKo7dbnUWefF1k2+YkHR/EdEzpKqDofQ3f/cfIR0bk8cDtZM24MvSFLbdvz?=
 =?us-ascii?Q?1pGZbP1NexRLLiVT6HeRW99Kr6Aq5PCgqYI9gO8l0FjbXyYGeMw8hBkIOdPV?=
 =?us-ascii?Q?lN6v84vyX1KwYugWqJjRuBbJ+4QQtqlSnokuzWfn4EbB3w+OLJ8yw0fihoj+?=
 =?us-ascii?Q?LDMDW0xTR99gSRiRNAi7a8Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR07MB7969.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?32yFSAG2nX1cAT1bUj7i6jWZSdC7Ti8IKN85QrkVSGQUjQtTJnMwN70lmWo0?=
 =?us-ascii?Q?M+nT2VqLCdDF//o9R/hwyazFH4ZOhVgbkTOz3RFsEtB+KXHmBY9m4YFCbi3p?=
 =?us-ascii?Q?g2UI0dfKEGk5REq5iuvd1asKLuVW6H8QLrKSbceo/t5qkIMUYNdYu/X/jM0o?=
 =?us-ascii?Q?EhdzPRnpy2oFEtWQYG9mkrAhCUjmr+pbqbMVcYB7efEfTHD87tsukKdPE3m8?=
 =?us-ascii?Q?KttiDl2Fc92S4sWyddJW3jR3smPWNsaYVqSa/WXmJH7Zk6ZA53WojytTGqk2?=
 =?us-ascii?Q?wE2zRWYvWgiVC2hWDnCY8glICFDk7ZJAeAd3qVkYC3zOshPxAN3QvEmYZH4X?=
 =?us-ascii?Q?2syJfvz0xXQuYt/64KB3Ii/20JMDP/mIVXZeSHVFQGSpMpMloea9Hsll0z+y?=
 =?us-ascii?Q?zMbVtuz+VrnPTIoHF2rAUTUV0NVwmZOmJFVUEUCXMMPjGiqxXKBP3IHngLpl?=
 =?us-ascii?Q?qLYMNlPFzCHcxKUtyaWaxqWLLorsCV/5sYkk2A0GxA9JUrmgqyFkZYpm+lcY?=
 =?us-ascii?Q?JxGxvM+zuZkaqurECtqPiS2jl3IHjjp0XiiTCJKB5E5wLoc+dIWW3X5L3l1k?=
 =?us-ascii?Q?Nv0thTJiafKAoNjypTiMgHdFwPI+yra93vMowkDWQ20Cts96FyXBygcz8k4f?=
 =?us-ascii?Q?M79Gt5BPdFRhu+etuiSX0qEQfLdQs/FlMJB1da7NFDBXpQteUZg+yB8gTTpR?=
 =?us-ascii?Q?8GrEEbpEIj2V7YM8FdpAhAt8PlJhGT3QIiB3MKvmn4cBkQHEGYhH/eMFDF2x?=
 =?us-ascii?Q?tHXQoeclMWNSF75PBB9t9ALg7dOzFHfGWJ3227QidR8ki6ikLIax3o4QmPP/?=
 =?us-ascii?Q?MfrzA2qxemmzuayErA5D1xzntDaLBUOAeroGA0M47p+ph4jHHgOniNXKjWbn?=
 =?us-ascii?Q?yASyIULEeD+RZMEc8jswEfrV+6qXKA4XDkyEwLqwePhBr/Vvdxzg6FoV0VdK?=
 =?us-ascii?Q?CVu7McSGhNTkZGVTWnFFM24Cs8SZ2jWv6mkS6plq+meP8QcN2Wi7DmVfQDM4?=
 =?us-ascii?Q?EF3rEviySN0gYuoefa/rewHExfAmOPNWzGSEyZkvonrhwP7fTqacAJMumdvT?=
 =?us-ascii?Q?lansFOMTsAXTCJxYp76AEK062QKhNmve2mZlc7g74mHkTXkDkjIrCRTXojXd?=
 =?us-ascii?Q?ZZKmjtIR8jAk3u+yCw8T+FHI4UAyJN1DpbWQbeOTXtZE98k/yu9WLBKqytAJ?=
 =?us-ascii?Q?LccEERzfw4636DvaZX52wycnZA85GcnSsqWu2qdcW7DgWwGp4Pn6KASH9eIk?=
 =?us-ascii?Q?1IAYmbJg0vMhAAkVIu/JrUg6dbNLE4rfJUbt5kCbESe8U1E2uqHXA0wywBim?=
 =?us-ascii?Q?/0AJZCyPUjBI7jxPa3nXFWSWrDb+cnIpDX4wPY51gjW95as4gXNmhe3ficou?=
 =?us-ascii?Q?+46zCozwcXtqMv9TIIhY0+Tj0mQp04aBwgJAc00SVzYnndG0ZVkeYPXm6HaH?=
 =?us-ascii?Q?VOlRxk0ZxEc1sz4acZIkcrve55/EvBqNBOsjxFFfNdlWBtzwNAqX+WU4kEZT?=
 =?us-ascii?Q?mSU6lpE2FLxjXmRRB61nmlGDpgUgFuRKMk7GIVjZccCpyUKzzJQ5FyViB/5B?=
 =?us-ascii?Q?7PrXfVbijmEvBzOnN6WLqDUNQuQVBPlNEkamgiNoF2e/rCTdipG/Dgs0DKT8?=
 =?us-ascii?Q?pnjkjvtrk5jT5zgq69C88xdFXm0m1kHHG4XzREMADjKAVrBTymA9+CaocHpe?=
 =?us-ascii?Q?nydCvdQc5QX/k05sQamH1NiJ4V6PweeQ1TcxKiapYEBM84bc1CSO233nIncU?=
 =?us-ascii?Q?lweCwI8SJ5dPUYlzFUaXiFbYZUsN2GQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7969.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc26924-4047-46a2-b2d5-08de6264d339
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 14:10:31.2991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lz+OGeQ7KOcaPyyeiokoZEbMOVmKmELtJTs2zHUUDLKrXOKU6iw4DaDHDTzS/fpbcbd451//PLSKHeAIUpocFB04J8kLMgCvU1UVl4P6lasGc4qGQUG4hnY6biAafeUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11453
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16338-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3FE2CD335
X-Rspamd-Action: no action

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Sunday, February 1, 2026 1:45 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: tariqt@nvidia.com; linux-rdma@vger.kernel.org; shaojijie@huawei.com; =
shenjian15@huawei.com; salil.mehta@huawei.com; mbloch@nvidia.com; saeedm@nv=
idia.com; leon@kernel.org; eperezma@redhat.com; brett.creeley@amd.com; jaso=
wang@redhat.com; virtualization@lists.linux.dev; mst@redhat.com; xuanzhuo@l=
inux.alibaba.com; pabeni@redhat.com; edumazet@google.com; parav@nvidia.com;=
 linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kerne=
l.org; kuniyu@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave=
.taht@gmail.com; jhs@mojatatu.com; stephen@networkplumber.org; xiyou.wangco=
ng@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch;=
 donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kern=
el.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.co=
m; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white=
@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson=
.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidh=
i_goel@apple.com
> Subject: Re: [PATCH v1 net-next 0/3] ECN offload handling for AccECN seri=
es
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On Sat, 31 Jan 2026 23:55:07 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > ---
> > v2:
> > - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS
>
> For the future:
>
> Quoting documentation:
>
>   Limit patches outstanding on mailing list
>   -----------------------------------------
>
>   Avoid having more than 15 patches, across all series, outstanding for
>   review on the mailing list for a single tree. In other words, a maximum=
 of
>   15 patches under review on net, and a maximum of 15 patches under revie=
w on
>   net-next.
>
>   This limit is intended to focus developer effort on testing patches bef=
ore
>   upstream review. Aiding the quality of upstream submissions, and easing=
 the
>   load on reviewers.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#=
limit-patches-outstanding-on-mailing-list

Hi Jakub,

Sorry for my miss, I was thinking to submit up to 15 patches per series, wi=
thout considering the overall limit on net-next.
Will be careful next time. Thanks.

Chia-Yu

