Return-Path: <linux-rdma+bounces-20500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNSyCnxJA2pU2wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:38:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D0523D03
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAD0E30972B6
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 15:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840737E2FD;
	Tue, 12 May 2026 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jlOb/4vP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749DA388876;
	Tue, 12 May 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599535; cv=fail; b=Yq0hbJkgDUr7U0glh6rX0IDbdxur9ooy8mrtXOpM+8LtPWFH29hXXClRyWwoacdPUPsOiZqGlXcD3rsQEvT65o0jrPggqpIZZD33FmQ6bOI9cf7pZ7lWkCphjPxncsueHhFJ7kI3ttWcsMYuUPhQCUD5mblDZBtjrG4LDjrDouk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599535; c=relaxed/simple;
	bh=utyAMgVXUUR2lAnvuVZFog3DH1RPJlXrx7I6hsWoquI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ld080Frg9clSLnPyVOIzvffIPS7tNik+dPAX/wJcrr9qR1slO9aHVOm2HbzzqOER6PeW76VDE7V5orCV2+GNTX32k9VGpfxYFK6KHKMJ/M/NX/8KJDwNML73tQNXBoLwgsoX5ProSyTCoNiAF50FEFCAIxuh7M4axMBi6p/hdQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jlOb/4vP; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdqe4YK2UxDU7x04MpRS5eX2pSKHJZEtcwaJPObyYh4t1ocOQF3dK9aKc/i4gTwq8CZlPknZBWU1LgS6WFTyc2byWb4wR2t1FPuckoN46tLgzddt6yhJRvp4bGOoeQ1lBSJB8y7xXqof8xlMfKPDXTDs6fsS13Na2SEBdfOTG378cNkWsTddtUZMyR0lraGIrQPCL8MYaSgqWqmegUrQRzl/wGAUPXrV1z7GHMPvw4yesjlMcer6U+YYsP9ltdGb1KyQEKPounNJFVoH0c7gK7M2jIEYJM+iG/t4vwk1su0ZXJcaXSMycuUl33SyhOL0den/WlkrlzgsIlXSPT7C1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utyAMgVXUUR2lAnvuVZFog3DH1RPJlXrx7I6hsWoquI=;
 b=HSr4o/kaNXRP87FpUeOjTjD4nQ2cz8nIN7A6Vuu4fYtgy4/rkaciJwmdWXn0UNWkzkeqDxPcp/btWfhooI1CyDx968wNpBud2mKZraqUi6Wicf8aplEyt/5fxqEkubmAj87/CLev3+82NQMxSWuenX4cXJlxBYpJKauwhWtgRpo/2WUr+hB2EsruQzumlMYyklUrh0/xXm/RjrkooDuEoGvtpswzBpdG9hEwlhoquEZma0gsybp9iejJ8XqDJQ+AyioTcT85znezv3lMgo5EvVIY45Wb7liV3GYE1IDdLl3LqYL/T8DcoTEFe3gXYh+7q+c+JP34Ll//EcviCs5POQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utyAMgVXUUR2lAnvuVZFog3DH1RPJlXrx7I6hsWoquI=;
 b=jlOb/4vPuWQSAyrbTJRebeJ1ydcXeG3PjPOO2w9DQS2ub261k8KurnYuiWUsEW3u0ydgykmFbNrpHfVr5xxgTMhWftejvr/e6gtvG8VOGcoVQc6aNIJoQra+Vq+ForYFN5w08CTOM00sgUHDGfuzg2s+TEHOkZAGaVUMvDtgSBvmQQy/UHCSrnMQHroM2ZnyGeGakv/C+pliRu4V5bHIf0EXNRw7y5TZQy/m0iljrLkgrj2wfIT7Lo+4XTsqnXwIVauKcHiU1JrzbR+aLavybZgRLv6Nso1bGZLuK3z+vqwc/QUvgn4xVMi5g+VUQOAbCe14yNr8l24HQx3ciKYe+A==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 15:25:21 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 15:25:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Mark Bloch <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, Randy
 Dunlap <rdunlap@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Thomas Gleixner
	<tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, "NBU-Contact-Li
 Rongqing (EXTERNAL)" <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [RFC net-next 0/4] devlink: Add boot-time defaults
Thread-Topic: [RFC net-next 0/4] devlink: Add boot-time defaults
Thread-Index:
 AQHc3VU8tJbglNPDbUazXOkyKNlt8rYBHYOAgAAlMgCAASTMAIACBosAgAACbACAAHEDgIAAZySAgAHul4CAAfKGAIAA8vkAgABSBzCAAAfYAIAAE+mg
Date: Tue, 12 May 2026 15:25:21 +0000
Message-ID:
 <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69> <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
In-Reply-To: <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|DM4PR12MB5937:EE_
x-ms-office365-filtering-correlation-id: a7a3bf3d-3cd6-4471-6ad1-08deb03aae62
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|11063799003|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 G0mUkDWQwyiQNOtdOXNJsJk+GH7ERpLI4uJfaXM1BrO/KGsKSTPUaW1BE8ZsupdA3jNkJFLNQZJfN3eiCCFjrzQUdMKR074D+sKtYq0jfENhH7HXIusn/kT9mPMgavmAeMJgGO7aZ/p47cRIFhQxioxCFq5+Vu3sC1enGAozhJfxXYRh6ZO+dgVvaw5WHuZ7D09ZDODAtVTndmlKBWVify7exs1LCyrtZOv87Duo96oYko9Bwc8BcEalqHCfTcrvHjFInfg5Qm6vijh/gP4K3RXNWlSYfbO07ip1pgtuy/i3uf9snyGYGw6Trm1ci/jtWXxKy/xg23PoGN5Q4dzb9ZFFd0vyM4jECP7ilEO9sm42vYinIF5mkUTtt6oAzMBo96toI93lNFZhis3jooO30PYb+LK4yCumrD56yKnBoXzHWzTg1fVnxlgRZ46ziAOyCEYvf23Lj3jhWqsX3rLtpVSAgZt9qGJVe57jkilpFhu30i+jwSBibdR5BOjxFm3DLPXt5dkDpK6hNp5xdhGVtXmpJpKl2d8RNwtqbeNRu3SOTubYPZd4u+7mx32aGKqUEX5NAmrk0LjV551EydoR4hHA7p4FQXxMjC/lXUbA2w4ZFoyHNgzauKrhQoPRbL43K2hs0iEt3wWNg6w9umW0BXUbkNz45NnlAChA0tq4Rlmv1uzDAMez6NYuBhkcL+G/mKTzL/7ooZiP7ndEDhVLZ61lsitp287i92Wio9ItvCtlVAQ0Xfm6rOezhLt8iP61
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MeUoOilwjPlq1OGJCiux4IUQWtU7WkuiiaDPhqGvsEyEbngR798xMMqFwRTX?=
 =?us-ascii?Q?0j+5VrDi3rS0M8j0kw5+CMabT1yxQQEfAyk0zdlH9r2gT4FgBEIKv70FiLyl?=
 =?us-ascii?Q?jHOoXEo5TWVsGyG1ukUHT/JtRGr7pQ2YM3AYdDgwKkWQj7E/7om7pU6SETfu?=
 =?us-ascii?Q?x8tCgRm8v0e7dATT7QuvKtXgfcCPRCq+H6e7lH/nP2sz5NXqHWc8w/sqYL5Q?=
 =?us-ascii?Q?Kq5hcID5B/SW3dQ7+NODEvdTVp/YT57+I8FgVquvg3V3Divh6gJpR6IQP04/?=
 =?us-ascii?Q?YAHU78TKQBgyEdmm1x36bdVgulw8HRlA0PsRkzElVPwReYVLUYEvYdhFz3TD?=
 =?us-ascii?Q?nGW99ROuyZRAVw/hkdMcPmN+JM5FUNlzDyaLCAxNPyCY1VweFmCF5laeUOWI?=
 =?us-ascii?Q?w+2/14MR1gxFG5dj9r8oVGSBggaUD3Y0mos1wrOEUqs2pkiOq0sbSdylzhbC?=
 =?us-ascii?Q?KxnJ4TKZinOtIP0oU21IUJvLbFOjFRovOc2I753T06D21fd+JoFbxc0hLp0P?=
 =?us-ascii?Q?uI4uqF9iNhBUndbo9aro/3LOPKCMynvIUHd4B+gra5Cd/ROCinpaqi8b7b+m?=
 =?us-ascii?Q?jl6YBy+D1IarJgcowfleImftxGkRIfCFttOxHBbG36IZ0Tv4SjJXUF+xjzat?=
 =?us-ascii?Q?khXYSXwnkJhkk5T72lp43Hz6a0Jq8w687PuPSVSKlZ5hLLSI4rTPWqXcrpXF?=
 =?us-ascii?Q?xmDjlP/L3TpRkGnr3V3FmrTlxuG+lpIefL0pgraIcX2ojsRME4knkr8d71W+?=
 =?us-ascii?Q?2eWWb0rGN3mIw7vvB9KU1lhakwvrYe81rccjEWDHRVym/Hiax0zqdx1l9aZZ?=
 =?us-ascii?Q?FURUlBxlsgdVDK6RFZ/ZE7ok+Gaw1aKjQSb0rndD99UxcuofQMSjHSaBIEjt?=
 =?us-ascii?Q?ymKKI8/891MTqxJBB+neSYAk/XKiEvInuwSIP3XUA2suA1Xo27wWjBAHqSca?=
 =?us-ascii?Q?AOu3YV2rQHj22nz+stNXwHUoUomGzhii0Lfz17P8SEHSE/x+6Ffw/OpBmad8?=
 =?us-ascii?Q?QrVNodYmGH1xxdsaQq43ZBNIg+Jy0HqdhfHC8TBtKSfN2+To0f591pBHXrdM?=
 =?us-ascii?Q?oVKiFOgRbqXTSpFKuYVECOaoZG4YMfB1rRWJqVf8V367BkPmDuzAnL475bQ+?=
 =?us-ascii?Q?LENp2tNfNCI0HjJqE/RdOWE+zxUHjQKz0FsQ+JL/BUs/mbykc7OKSk1j8j0F?=
 =?us-ascii?Q?3aFqRvf7zFTWcVoVRKzQjLcQFVOqcfhIGepVGvXsvdbiqpjlH/3dfzt8mgMz?=
 =?us-ascii?Q?H8xzvkDJQriye7V1sp8kywOXo7fSVdzQ6oc+3elXfI36nJgZjjs2JFoOd+5B?=
 =?us-ascii?Q?WvDce/ZORSyTmuo35UjX90Y5FNWHBtcl/dRG0lcj4rlqajfrMJqLdzDOElki?=
 =?us-ascii?Q?ung+OObDYQO3hujyRTaPMvmmpIncR+6j8y2BTacy/v48R6zsTdGzFshSi06U?=
 =?us-ascii?Q?b0IPp47662vCpDY9JcvZE3ttZVMak6BQoodoFdRXcqi8B7NnwJq3tnKY5Olh?=
 =?us-ascii?Q?OJgSTCV2jndsJ4iZ+eLo3x3/EOa69+Elna0mYXZ9+3sOlU7OqDU25KJKyX05?=
 =?us-ascii?Q?Kmn2cgpYeq3IbE/tXhIgAZhEdMMZt/CiL5vKLLCjN+ndRc8SEfZOqRQHxAfi?=
 =?us-ascii?Q?4tOM25NsoDj3Ekcx6QklF0Ke2tj4ZhN9UPx8SzZdbybt+GsPRsFcmAXBCo+F?=
 =?us-ascii?Q?ADjXHBm6re+ArgNWjMxhtIRZA8kks5KqYk52Pxpk0SPwi+HV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a3bf3d-3cd6-4471-6ad1-08deb03aae62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 15:25:21.3408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaFY+XLGivcFBrhr8Zpvv6XR0OaKtoAwqEHd//HDtVuR5usYhMGYaU7CViEUEnpkfyR8G5/JujJFec5+8B/T7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
X-Rspamd-Queue-Id: 236D0523D03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20500-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action



> From: Jiri Pirko <jiri@resnulli.us>
> Sent: 12 May 2026 07:37 PM
>=20
> Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
> >
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: 12 May 2026 02:16 PM
> >>
> >> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
> >> >
> >> >> From: Mark Bloch <mbloch@nvidia.com>
> >> >> Sent: 10 May 2026 06:02 PM
> >> >>
> >> >
> >> >[..]
> >> >
> >> >> > I look at it from the perspective that from some CX generation,
> >> >> > switchdev mode should be default. So that is a device-based decis=
ion.
> >> >> > I believe as such it can optionally be permanenty configured (nv =
config)
> >> >> > on older device. Why not?
> >> >>
> >> >Because sometimes switchdev_inactive is needed and sometimes not.
> >> >Such knob is not device decision.
> >>
> >> That is what I would call corner case. In that, user can use userspace
> >> configuration to change the mode in runtime.
> >>
> >Corner vs common depends on users one talks to. :)
> >If fw has switchdev(active) as default, and then
> >And user needs to run switchdev_inactive, it will actually break their s=
witching applications.
>=20
> Can you describe the actutal breakage please?
>=20
Driver default was switchdev so all the traffic is forwarded to the switch,
and user didn't have chance to setup the fdb rules.
So packets are dropped but user didn't expect the traffic to be forwarded.

With this RFC, the device would start in the switchdev_inactive.
And user's goal is achieved.

> >
> >So, one needs to invent switchdev_inactive in the FW.
> >
> >Jakub's suggestion in this RFC is covering both the scenarios uniformly =
without above problems.
> >Single uapi for all the cases, so looks good to me.
> >
> >Moreover, do not understand how alternative solves such problems.
> >i.e. user is unable to configure the fw because driver is not yet loaded=
/up.
>=20
> See my other reply in this thread. I don't think there is a need to
> configure anything in FW. If we fix the behaviour in switchdev mode for
> non-sriov user and change the default, no fw knob needed. What am I
> missing?
>=20
If I understood your suggestion right, is it the devlinkd based solution?

If yes, then Mark explained that it has the issue of all drivers to be load=
ed, followed by user space to start.

