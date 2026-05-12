Return-Path: <linux-rdma+bounces-20490-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI9/Oac2A2ow1wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20490-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:18:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3B52231A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D84930E258E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067F239989F;
	Tue, 12 May 2026 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nXpNlKOi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C63905E6;
	Tue, 12 May 2026 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593721; cv=fail; b=WAxNhVYxEhXb9o/K/Evx0BQuywOondusOhJX84gR6gN+xeKCWCWKbPMleX6DNZnMq0vUFC3FLcr6pR6W+/RWJxyZdKEBqtRB5q8CprJg6oMZsJKc4H2n53tOtHQQResJDBdJrPUt9SIaXfJ0s8lY/pH+NZXcWHQkwLK0KucdiK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593721; c=relaxed/simple;
	bh=Gunwy2nYT/RnL4YTAa5VEYIayAnrpQXH0NdMw4KNBR8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0rYuWh/AVvkHU6NdDDL0DUDZi6pzYjnQx3o/yvh7hlSkjF8fzaKPoKov35XGlqLgYibuTuurvB8Ihaq4d41PQwGuDyzkgQ7u7FhaIf4tgtcrHr2rN6L8hdadIuog2I+VLiZHDY4Z6mraN77PN5378cMYSe42ge+wWUKVt5C8L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nXpNlKOi; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZiKADIaYcXiepioMyijxsptgspzGSvX+XQxgstY62RrlcSV/oGeUDUfRaY1MxQurLh52NZpBVtZPnfK37ivmS3hYqrqCR01zKLE1FTmTSQKFImjxJg+crK1+y3vn0zpFeRzGQVGdj4MEqTo6aD/z4lhx+brl808PfBViZ+8dAL0hKuam+82qdlEqODiZFdzKWqhsM9Ve4jSGBCHIwNpziNH39iMsvfIkd70dCCnnxOJqOCypS0yKeop2pmHKfW4Upkawa6xUa5qRDcNv0LHQn1RqLNLvP5IrlKGvOr4mKa3O3znFvqsU9tMC/7CN9MWBZsUA7+r5JEbnp7AmG9Cvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gunwy2nYT/RnL4YTAa5VEYIayAnrpQXH0NdMw4KNBR8=;
 b=JAdegnAcEFzjsUTty8Pmkdk6ZNSRP/YGcdtnLUduCNwu+x+8wI7Pf4RONp8CryLnkC0/IpnduthLt8fu9bKIqF1OzCR1URQ/gDSksBGn0TMHLpOtBcQc//ExpVcvtHIkhWH0pn3ENY1qDO6YZ82wxEesopDD98RNQDsoX1xbBZ9KnJZOYCBqFskSrgZdbjip/BLhnrt575BcgXBEMZNxtbOY577aufHCAxk3aOy8vXJpVRDpIQoz2u/N7fn6vphXDXBUfK6VWlx7nU3pPW60AIMn8UDMNVtHeNjDQz5c4qNpTOUnxutrLXrM9oj/QZ50qbG7RqyxGZmeK6M5t5VUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gunwy2nYT/RnL4YTAa5VEYIayAnrpQXH0NdMw4KNBR8=;
 b=nXpNlKOiDtAzwX1atd1ktqoIm/LJkKwX/sAgaEbWzu7f0ucEDKEY8H6mLCfHsPOAEnj4S7vfeo2hlPXMmjogtwPuPlUWYpSlKoVBsEz/K3M7ec9bAAwu6J1KfaLzMMcDXlvl7FOHud9vgr22Aee4oMHuPbORdCAjG5f4WufpIUmMbIZnEUJPfPl5G3Ai0EPbHCAAK/hO2qCU5mTwOySR8jfrap03H8vOvtLKVdjOF33O/Awz32WtqvN/55fJorZ4KCnHKS/2xKkYhxU0o7vOAaCRoXUluesYb2HGTu2WYyh4XOdRMG6uqx9wjgZnAzDgP1/YvMzsTp9uaL5JtqMYwg==
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 13:48:32 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::3981:4d43:82f5:adf6%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 13:48:32 +0000
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
 AQHc3VU8tJbglNPDbUazXOkyKNlt8rYBHYOAgAAlMgCAASTMAIACBosAgAACbACAAHEDgIAAZySAgAHul4CAAfKGAIAA8vkAgABSBzA=
Date: Tue, 12 May 2026 13:48:32 +0000
Message-ID:
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69> <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
In-Reply-To: <agLoeZtsSizR-R24@FV6GYCPJ69>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|DM4PR12MB6159:EE_
x-ms-office365-filtering-correlation-id: 1f8fafbb-e9ff-46f4-c047-08deb02d281e
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|3023799003|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info:
 NlM6xOZG57zptVcFEUOVgjyZI3mScXDiDcIp4QGlJsy/bM1NoSJKZ6Yf7OMJmr6QRCDHnRZuFfm9IDMke1dK2/vr+AXn1uFDUI7U7vTgIQ03UKiQ2yDOzNClAztGXVI8yioV8gJ8cTbYP+wQfA7f1rweJr9nchJoWK3MOfYinbkhPdhv8lBd8u/j/wm8FHhj57FYZuAnDwq5lWNH8tv8OrqpAvefrCGBz0awQI8Y88i7wthgyriy5mL9n/5WN37aNGBE7LSMqWXESibWiGHgkbZ+0O5nOoih+ihQBetiCiX8tbPxbjFA/9RY3SckNInU8YZLQx/R+TPzm/8r44ZR8oU3t6mOY83FOm89UILd9WUroz8Fo+qH3MlBSaWDomnPzN0GX4N+PDqiPY25P6EHf7Jgmw8QTjEiheP3lqjw6mjtczhc5sk4Mnll5I4Pjy10Bj031k0MwBCA7714+MEoUMdT91PwxRskqLpyaflCVCHHf9bC8OO6sQfdWBY34A39ce+n8qMF/on9dKKWa2YH0p5690xLW1+KS2a2nHVlEzucxI+SEx9s8GX4wTAdJdfAYJ5GK38Bp9KSAuu4QVcfW7w+ufBfn4VsL76kymwSBrgX566y1UIqqDSOopn+eDrBjkk1heGWoarX5YKx7iGxOYOEI6+GPJhYY9JcHLczAjYk5JL07xFHQs2dZtWd7CKRxaHDawbR28zcpXOlrs3fzA0NMqIXvf3ckDkLK4uEdEgI0rWdCXdek0X/F1Xs590J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3023799003)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ERhWXMbrcF5RoHX6tCPkmyXXaG0Av6V62SnEnT7lwZ1TFdy7fY8pcvkLrcvY?=
 =?us-ascii?Q?vDMtPeec3YttkS1E6BWFsnZD3esqxubrgJrrB+zgBbk78xSxeNUFfoCrgL3G?=
 =?us-ascii?Q?AM/ct0Kqn6CEaiB2lK/cjL1p4Q6tmy/MoQw3PFsyhgfxCReBCjM0mDIa1Utf?=
 =?us-ascii?Q?ZtmgTE9YcFIoTLD2Xi8UTeKdxoFjLdleUr9SnPw2bU+k93DxA7P1Z3E7So94?=
 =?us-ascii?Q?5kb1GkaPjewGpFnFusPpcPk68f0ZqJ96V7KyOol6YezmrqYk0/PT/FmEhblh?=
 =?us-ascii?Q?r9oIgFHEcsSdbOQeWTuOz99x0RW1APA83YET/ARWlYDnvR9SAkNXVPDOeIDe?=
 =?us-ascii?Q?W4+qYXBZre6Hw+Q79xWgV+ppGWgg1Tqb7A4AVoAiH5llb3biGzRhE7kpnRpk?=
 =?us-ascii?Q?llZK/go9Af6FZs410hI3M5KnNgYzxyDhJ4iKowGM0CRqLoG2PBuqFYQU65zO?=
 =?us-ascii?Q?dTvxxeU1bVTsQZoy0q2jphn5Sl1lF4Qj+57o2BXy95RHp4RoMo/HkQ0cpI6N?=
 =?us-ascii?Q?hb7HVTcvlFnvzFTTUyU2lcK2QgzzJszOysbpZwEg74NBHYrM10xMc/Wt+CDW?=
 =?us-ascii?Q?VJROWpBZ/57uYLhSZKqpvCKfZ9T1CPQ7LNfqOewXzD7Irq4jbKmE3g39Zy0e?=
 =?us-ascii?Q?2GY1m1K+XoLmysAn3Z/YjZgKFJmmnLr79Ep+BZCdyv/uqDkM+nBHR8aIdc9v?=
 =?us-ascii?Q?6uE7JfIzrZ0k5kb+puyv7tUCref6xO6i/eil7cfaaz4WMFPtXiBYQoVUqh6v?=
 =?us-ascii?Q?x0FSCh8DD49joBj2bFiX1fnmSP1TSJLDNdXoYE84JEL9MjJ4ex/WRnu6dcV+?=
 =?us-ascii?Q?TrCHdQQYcq3wptipC86ZBgH54/R8q2kxTmPemj6kOUKsQoUnC00wyr+7aMaO?=
 =?us-ascii?Q?Gk6ZfSABCJDg9uAuE/AOVVdRw6wdD/UKSELEJKfEVaJkOXbtgXOzJlD/vVO2?=
 =?us-ascii?Q?LaI19pjyqPJhzuPQ6OapaiCEOvBe+ojVzvwGh/xJCu2xhDLSkt2pCq7HlB1C?=
 =?us-ascii?Q?DXBTG0W1o1P8QEJegjX2g576ONvbGlT/B7HzMLZ2CphC6aw6eBhQuaNrHl+k?=
 =?us-ascii?Q?XSpcCI3bx/+nSR94aA4WWLlXkLoHC2+beqJRDM9qFRRpDp8tZy31Q22hLRAn?=
 =?us-ascii?Q?ev8jSwn0JKcNJ8LedzEq8x/FtTJ8xbtz+Vi9l5GQwHKR5O8qmlhlO63bSl4f?=
 =?us-ascii?Q?H5TFn8loK0ezIiwVzKEuHpxugitsSj3oqmPSbiL+YHZZaN/31pXswhuetR7w?=
 =?us-ascii?Q?hQefUNvkXz5lBk/Jn/gpFvK4t6m0RPnZC0RnW2FjDis2qY6SQrw+NMZNvWq+?=
 =?us-ascii?Q?7pzqDAHWgNqKY5qL8Xz3UF42mmoE9gNxeJb61Ak7xSIyXtw1wqKgVs0qaPS/?=
 =?us-ascii?Q?iiSqyxmWUbamSv/6QsNIcK7GzkrI12lUrr0xWcqW8kFXZF/agDRsaFtdw5M0?=
 =?us-ascii?Q?72pxFVTdanjrv97X85yATiQsWIijuM5aH6Arpg+k57yDmA8QoszP5ZcaZ8qI?=
 =?us-ascii?Q?FuQ3v3U8zFKe4133GWIRx9zIYRIhJEhHuLrmhlOL4EJZGMqocpmcoVM2Igkv?=
 =?us-ascii?Q?9ExNblM15qlAQ0KMAbYIbmtD1x6U861Z5QcD8HB2g7i7cY+gLiUjBJYz1zoi?=
 =?us-ascii?Q?ILldoghAg7UTA/MOMvS0Q4qmn8F6HH9Cn9k8amcIr4XVn8D1QQsNkeWqB5bL?=
 =?us-ascii?Q?MNwdagMyA3Em1L4Ap1qqec5A/aXeTuJak52c50jrexHfaXU0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8fafbb-e9ff-46f4-c047-08deb02d281e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 13:48:32.5757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbmWVvaZutyWoykdMB50SGYUkS/qasi23AAnwSz6KrW4xji3plVMDNOAzHvo4fD+cVEommNz4ijhP4r1ErWxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
X-Rspamd-Queue-Id: E7D3B52231A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20490-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,SJ0PR12MB6806.namprd12.prod.outlook.com:mid,resnulli.us:email,nvidia.com:email]
X-Rspamd-Action: no action


> From: Jiri Pirko <jiri@resnulli.us>
> Sent: 12 May 2026 02:16 PM
>=20
> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
> >
> >> From: Mark Bloch <mbloch@nvidia.com>
> >> Sent: 10 May 2026 06:02 PM
> >>
> >
> >[..]
> >
> >> > I look at it from the perspective that from some CX generation,
> >> > switchdev mode should be default. So that is a device-based decision=
.
> >> > I believe as such it can optionally be permanenty configured (nv con=
fig)
> >> > on older device. Why not?
> >>
> >Because sometimes switchdev_inactive is needed and sometimes not.
> >Such knob is not device decision.
>=20
> That is what I would call corner case. In that, user can use userspace
> configuration to change the mode in runtime.
>=20
Corner vs common depends on users one talks to. :)
If fw has switchdev(active) as default, and then=20
And user needs to run switchdev_inactive, it will actually break their swit=
ching applications.

So, one needs to invent switchdev_inactive in the FW.

Jakub's suggestion in this RFC is covering both the scenarios uniformly wit=
hout above problems.
Single uapi for all the cases, so looks good to me.

Moreover, do not understand how alternative solves such problems.
i.e. user is unable to configure the fw because driver is not yet loaded/up=
.

>=20
> >If it is placed in the device, orchestration needs to yet use additional=
 vendor tool to configure in the device.
> >And that theoretical tool cannot even run yet because driver is not yet =
loaded.
> >
> >That sort of defeats the purpose.
> >
> >> This is a deployment policy decision, not a permanent property of the =
card.
> >+1
> >
> >> The same adapter can be used in a regular host/RDMA setup or in a
> >> switchdev/offload setup. If we store this in NVM, that Linux switchdev=
 policy
> >> follows the device across hosts, kernels and use cases, and can surpri=
se the
> >> next deployment that just expects a normal NIC.
> >>
> >> I'll send another RFC v2 with support limited to:
> >> devlink=3D[...]:esw:mode:{ switchdev | switchdev_inactive | legacy }
> >> and let's see where we land with that.
> >>
> >This looks elegant to me as well covering all eswitch modes and still sw=
 is in control.

