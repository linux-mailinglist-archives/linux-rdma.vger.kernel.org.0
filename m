Return-Path: <linux-rdma+bounces-9807-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D44A9CDE5
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EFB176C5F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 16:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB3019DF62;
	Fri, 25 Apr 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o188sV1y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D19992D;
	Fri, 25 Apr 2025 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597818; cv=fail; b=QlNSIjlBHvRwwwppLSMD5uRmdWkOxNSkAFDCyNZIw28rnee34y1HO2nNDNf4/DhL/4WORiGQf8nZnOrVD8DODOuoWHjcae+CAEt8mACUrnWD3jrCyoTpDTGcRTCQ4JhEKmoaZMJdlncKILAsCt4PyQhe05ISXUD+LU3u0mPa9HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597818; c=relaxed/simple;
	bh=Ms5CedXthxEEyn+9cslqqg4GAR27nWRX8ssW15vnQ2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sr+ok+jaWOD8G6XvxiuhxdYHC3awDdZqrqvsMzEskHcyCqeleZO0ikn86nBrIrEE4olSW7ChkUWQVXhAEFlW1uqTzWkkSbFmgq5fsj/sVyc3YJa/01kkN1UOKsO2d4rtYOSOrOib9e2/QG/7fYMsm0lnKnyWu6LZpeclXXBEkao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o188sV1y; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRbfh4ddpWWHg11ZJ6c9AzPmt1/DW1HCPbAwgI0ltZGYSKmQnzY1Q21tVdGdZB4QFoQUotHVfrOb3kGRYRo9rwIILEZGE8c1tmmP2041G0PqTSScEcpGrHvax3jvRPJaT3px/oifG/LizrM7ltaV7VBLQYtKVvF6V6qUxW04DX3pzkdp6q7Cvxi9A+b+PGib/gaWfBYEuiXFZJsfMLt2qlZDlgIs6oxnY+x6V9MTtjk5LpeBkKEVKLEzogMUDBQcQMRcuU+cuc95oIYWC8FGPXZ2feB9B4KOT1LLBMd6yMawWQfvpCv9Aus169oz5Z6jwBwsdVDPEnc34so2NTlijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYaiwg3s0yPyxXtqtNxAZsY7LZ7zKnaMpPW32dNtXmg=;
 b=T49PX9Qxz8wlMSwEK7/dum0VNpDAVMa9gPOAnNu9oveU5pBLBaxW7MOed3KnrQMlstt8+MiIYy8Ze4tMNKpwppF5STh56ZXlKlqChl2CsEU47HUK2qy8aTGd39WYHsenz2a5910efS7V2fCLNFbu0Sy1TTnUplr640z+/wvguN/ZnYXhfgcqtG7o9YuSf3bzllBvqjVZR9sQsc0I9fvgL8BpVMCAoY4fydVKH8ZMOHI+zTTFR9itpvzf3IDqRq7Box44SbKNxBn44DH+U13grdLOi2SlG2VF0DoHNG8ylDsz6X5Dz+ZAAzwQ33PL3xadJOh5skSWbeikKYceksTPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYaiwg3s0yPyxXtqtNxAZsY7LZ7zKnaMpPW32dNtXmg=;
 b=o188sV1ytPk50FLl4JddlOKiY0gfnVad1QbspYG+gyED74ccp+iOkCaUUpgBOYwkzwNPeLiqtrleYJJSU0in18hR8bVD/hW5TOKaebAZfDlPyudEdUMefwIrGXqXaUMRIYCIQuuHqVD7SOBCtmzrjRM7lu5k0wnoHVgoNl2t/0l1rWsZfljV2VjjHBWWIkv2TrZf1wr5kpTIB+Cmfr8NqdO3uIxxMw+h27PnkuV/yfndah0BrsAqqXQC3ZCQLjAWDtOPeDBfguoaQrpU9a17RMONxKjk/G4t/ciZjV/AAz6hMcTurvLNAKb4bTQkueNLmIU29ljg5knJnfIDZLQPsg==
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by PH0PR12MB8006.namprd12.prod.outlook.com (2603:10b6:510:28d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 16:16:53 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:16:53 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAACQIAgAAGW4CAAAvKgIAAA9QQgAAHfdiAAAeGQA==
Date: Fri, 25 Apr 2025 16:16:53 +0000
Message-ID:
 <PH8PR12MB720823E8768093F773E5569ADC842@PH8PR12MB7208.namprd12.prod.outlook.com>
References: <20250423144649.GA1743270@nvidia.com>
	<87msc6khn7.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<20250425150641.GA610929@mail.hallyn.com>
	<PH8PR12MB720850A641460067F7CC548DDC842@PH8PR12MB7208.namprd12.prod.outlook.com>
 <871ptgi6q4.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <871ptgi6q4.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|PH0PR12MB8006:EE_
x-ms-office365-filtering-correlation-id: a05df2cc-6188-46fb-705d-08dd8414978d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pnYfp1v/nCL8wRY5GunImuYceWd2EB3nfm6dCipTcAUviGz+EO+QiunoLWtm?=
 =?us-ascii?Q?eGRj+Cmc6rxm1sH1hNpmBDJ85fOgOLWPCehG7X+Akf0uN2z4/NpLkl6AAcDU?=
 =?us-ascii?Q?6uBBvca76sR1r63tCaz9KFjcMQa78zJfx7NO9Z0p2EBsjAwbkJIkhHnfQHg5?=
 =?us-ascii?Q?8M6GyYTRE741aOQuwsUD+AgMFfMXHUKC6Jz3M316PLIGBqYcNXExznK2hWx9?=
 =?us-ascii?Q?kquQdxQzJQPfJIVW7Xbp0n5k2Gpw2YjsNhiOBF0rsaSQT4RUilV3vx4prThT?=
 =?us-ascii?Q?y+d1B+NpBg2Sz5gtbw4JwDJZdGJOLzQ/Y2kjJrfuz1kxgvq+bZFOuMawCLbb?=
 =?us-ascii?Q?Ll/YUNDXgLxyubdRcu3HDtaaY3ojpLVg1XSSmfcrlVssZwkrXcrFINAOBWp7?=
 =?us-ascii?Q?aNI3kPi3KbUQzB+v+4zfOOlhBSkdWVMPxw+vhJDSs+O+qUkoVfNOaerUkRjr?=
 =?us-ascii?Q?/vfOuX2TO+EzK6cBjvrZPwV3VNMjd5PIWjGMwTfxPof5YG3e0GBcZJ59cxCf?=
 =?us-ascii?Q?4ybU6q1t6Iw1LkIq1M6RZhHp9htHp+HHNXlyAmgKeVoEVaIzXXDvTJQiHAeW?=
 =?us-ascii?Q?LTrxrIryFbQsp7nteIfvAEbkgE95bhezpcptiBeN1Xm+1dK0K5JGUSO9ude5?=
 =?us-ascii?Q?eo+i7jDozJ3f7Hdo0E/okznjuXKETrU5CDhaLdh1hlXVvgoI3DsYXPZPFqya?=
 =?us-ascii?Q?c/DM4rSO7JjJeEccAWIqi0Be6QprZUutkKw/RYTyJ5FuaM0pxLy87HlA93Qb?=
 =?us-ascii?Q?l5BUx/S7vlbaxK2TSw6N2skcTKS6YVwWc5KvaoCW2ZzOjfhrp7m4DkzdJqMj?=
 =?us-ascii?Q?1KT1qWc33jaNYMqhvfMQBQu2n6RWX8XdM1cKh+hm4mygYnq2lw10ZXBpkN8Q?=
 =?us-ascii?Q?4mXozit1BL+mNEFs9JqSit+h9IvownwnOVIa6JTHE/wpKO0+VXZS5hPxq0gj?=
 =?us-ascii?Q?fd7WWoicT8DdR4pf7H+rfatMoPIGabVdwbEDPUy3kDblIpWBvyw0sr3J/pTZ?=
 =?us-ascii?Q?UuOcg5uk5x0S4GUZv8P0LA5b7PAQikfKlhkHsDMLuJKRZrELAEvTHMK8sJvD?=
 =?us-ascii?Q?UgsDVP3AvgZyuQpQbi+rxsTSXdh44ycN+qY+T6W2q8Pbjh6qfcZLmy8/TEIN?=
 =?us-ascii?Q?q8fi+wdGYoKXnjfDrIPASNZuFKTvKba8us3mi4Npcs6oI4QMhTPZ84xkwuj/?=
 =?us-ascii?Q?EUUL3pGlUmkfyUrqOWYp5ToUC7Pc2luT2ii8YbM/uHGrpjN6gU0oJ4iABvBF?=
 =?us-ascii?Q?3IqYCGnRxR3/I1WDQ64PvNRxsxDA02PaX5eqo7d/H6ErC9gr7ktrnDg0nNlK?=
 =?us-ascii?Q?DzEnM5Z8bd7dx8Z2OE7esuTEls9ppleLTKaL3C6jlvz0uZgCfssoCewrrFda?=
 =?us-ascii?Q?m8Qliul/yTzIA+yKISD6K2qGYRIRWR2M2P2o5zkoT8VgjeyE1kn7SCDjWxym?=
 =?us-ascii?Q?smqXDPl8lCHRRqyXG7ErIAyPwpLKCiUVXANob0s6cEhCacMQEK8n5FKeaI+g?=
 =?us-ascii?Q?aN26+Tpc8eWkgUM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7208.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?egvsQKDFOl7ofjGdoK4xT4S/QzEymomDO4RNkXRQl3OT16BOhO2oL648viXv?=
 =?us-ascii?Q?RiMlhAgDlQfuOMIGJQdqbxfbzg91P2UeCEKoQ0kPO71Sfpvc+YBSKPLkBLft?=
 =?us-ascii?Q?0XkyHd6OAqHFRGbTwCxbq/mKzmihMsX9XraRshDqvWzaPNuPg7OcrU+s0dPU?=
 =?us-ascii?Q?OPR8HbcXZxcG9MucArF1k4ZD0C8RPl2+W/fph6fspLUnyBw378FHJ9wRh114?=
 =?us-ascii?Q?k/Uecsp4sqq0PP2L9vBmyk3PCM2jhSySPrZFrfftYxutEq3T0VJhCPFUzT9C?=
 =?us-ascii?Q?Os62F/avn4NYHKnKZdSw/oe5NO3xdyRMc0wZmRAARkr4FxeZgloFF+eQ8n+u?=
 =?us-ascii?Q?aaLcm5cdzzpGWb1I36bYToOADGbNPKkbN9yjA7IRKPXHbzGaUe7u4yDlo5cc?=
 =?us-ascii?Q?vPG9mtFBQPLidToOyTyPxC+a5WttGA9fLLQdlpird4UF3M5UMUgXMujKuZXM?=
 =?us-ascii?Q?JuME6JuZv+WEHiP4yb/nib+xyLAOC4RjgQZ7BfncDcmsuDx0wkcguO6zdTVR?=
 =?us-ascii?Q?Y5iWfcPRClVBHV6UDSQDQnKhF5tRMIFzb+YSdctvzsSn+xs+AEPKCO5TXGs7?=
 =?us-ascii?Q?69VaLzzblr8SmoUd8lYX7m4On2E95kxGUF03ylxZTTLB0rIdE7XtBF61O+zy?=
 =?us-ascii?Q?j2YLiUfqFWOhmOr2OwrwzmJpxeMnqREYlfdUJ1sVgKHyuGUdadiVnC5Y4zBc?=
 =?us-ascii?Q?DTgufS8O2C0FNz2XKv/XhspnX3rsQ+lLbMzPKK6fxOdh7EFJfAr3tAa3boQ5?=
 =?us-ascii?Q?vjvqe2NYaVmKSIbrKr1AzOb6Ire5CLSpDUA/5Sla5whIbGpiyTiO5NOwNsLE?=
 =?us-ascii?Q?+y7ZMVLaWeWDvJSK3B8LCP2rwH6TlGEg0i5puGf1Fa/U+5BnwqUVqefxBCQM?=
 =?us-ascii?Q?1Fw4FAQH0FRr/R0TQLxxWirAf1/oxYXzlL2DOYifNLdxkZMV87fCEod/7Rxg?=
 =?us-ascii?Q?q5L6nRSlGKoz5hx7J5dB+wwzmZVl7QA7pD0MsQ9L1tE7S4ixwNPl90slgBpj?=
 =?us-ascii?Q?zJbLH4PbpnPHevO+8WlwPhKMOpmRB4aoH+TvFR6hXRwzHmmoGWbaM0hBart2?=
 =?us-ascii?Q?8S4fLdSNswCApqEFJHyhFYGRJgtK0F+t7sQVJxZWkcVc2RU2T0twDmpc46T6?=
 =?us-ascii?Q?AsHJY7Oavrg1a02JHFZ9uiiDHuPOpuNQpf8ZGTtWA+mgQMdfwRdP16eZAIiR?=
 =?us-ascii?Q?QA/m0eRXJANe+O6G04tjyLHrsov3WFGPFN/SSTWt0BdQ+gUPHIPH2BjaXrB4?=
 =?us-ascii?Q?IgjA1PaCwfN26nems5j2hbxy5OGvR67IADfZE2XDmHegdsDPhcNO9Zf+E9pI?=
 =?us-ascii?Q?PFWlWA+QXLTf90G0JjiTzDPVFvd0AEuwQwx1eQTrk+Q8lfF3ioc/PL/ac9dd?=
 =?us-ascii?Q?anwrSksp1ln8e6y0IW9oYPFRaGQNwwe9+kaNsFQ/XIBOTMredBaJZtQN2+46?=
 =?us-ascii?Q?Wk0AMT4GfGK7O/ZwoXPwr+4rvMCnLQ2M6CcOC6jZ3i+gTQclemQ97wUi3ivA?=
 =?us-ascii?Q?oHeEp29HUplXdp4cxCgExKnsnVBsSOvLm5vBgCueNfFg/hZmDIfrjnpMniXS?=
 =?us-ascii?Q?5t/I4OaJo+6US2ash+xbyFIYafLUSGwavBaB/yZoaYzT5akA9pgSruVxrANH?=
 =?us-ascii?Q?xVvC8Wy4i+k1y5E0bHooe34=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05df2cc-6188-46fb-705d-08dd8414978d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 16:16:53.3036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAn6IDIi8ZFaCu2Q13ngcamcmHBczSlxJbjG56T2JndgOnpoOVnQJQ5aPkMo+CnNg1pZ4l9fxwV1GRQ6MiZDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8006


> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Friday, April 25, 2025 9:17 PM
>=20
> Parav Pandit <parav@nvidia.com> writes:
>=20
> >> From: Serge E. Hallyn <serge@hallyn.com>
> >> Sent: Friday, April 25, 2025 8:37 PM
> >>
> >> On Fri, Apr 25, 2025 at 11:24:29AM -0300, Jason Gunthorpe wrote:
> >> > On Fri, Apr 25, 2025 at 09:01:44AM -0500, Serge E. Hallyn wrote:
> >> > > On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
> >> > > > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> >> > > >
> >> > > > > 1. In uobject creation syscall, I will add the check
> >> > > > > current->nsproxy-
> >> >net->user_ns capability using ns_capable().
> >> > > > > And we don't hold any reference for user ns.
> >> > > >
> >> > > > This is the thing that makes my head ache.. Is that really the
> >> > > > right way to get the user_ns of current? Is it possible that
> >> > > > current has multiple user_ns's? We are picking nsproxy because
> >> > > > ib_dev has a net namespace affiliation?
> >> > >
> >> > > It's not that "current has multiple user_ns's", it's that the
> >> > > various resources, including other namespaces, which current has
> >> > > or belongs to have associated namespaces.
> >> >
> >> > That seems like splitting nits. Can I do current->XXX->user_ns and
> >> > get different answers? Sounds like yes?
> >>
> >> I don't think it's splitting nits.  current->nsproxy->net_ns->user_ns
> >> is not current's user namespace.
> >>
> >> > > current_user_ns() is the user namespace to which current belongs.
> >> > > But if you want to check if it can have privilege over a
> >> > > resource, you have to check whether current has
> >> > > ns_capable(resource->userns,
> >> CAP_X).
> >> >
> >> > So what is the resource here?
> >>
> >> That's what I've been trying to get answered :)
> >>
> > A. When a raw socket is created to send a packet vis netdev
> > (resource), the cap is checked against the process in [1].
>=20
> No.
>=20
> > [1]
> > https://elixir.bootlin.com/linux/v6.14.3/source/net/ipv4/af_inet.c#L31
> > 4
> > Not against the netdev's dev_net().
>=20
> There isn't a netdevide to check against.
>=20

> The resource is the network namespace aka net.
>
Don't find any difference for rdma either.
For rdma too network namespace is the resource.
=20
> The permission check is not solely against the processes credentials in c=
urrent-
> >cred.
>=20
> > B. Netdev's dev_net() is crossed checked to see if current process can =
access
> netdev ifindex or not in send() call.
> >
> > So resource was netdev, but literally the check is against the process
> > cap.
>=20
> Not at all.    The process (user_ns,cap) pair in current->cred is checked
> against the user_ns that owns the network namespace aka net->user_ns.
>=20
> That current is used to find the network namespace is irrelevant for the
> permission check.
>=20
> > And considering above is right,
> >
> > I try to draw the parallels between the two types of network devices,
> >
> > the check for rdma raw QP (equivalent of raw socket), Should check
> > similarly against the process's net->user_ns during QP creation time.
> > This will match #A.
> >
> > And process to rdma access check should be a separate check #B.
>=20
> The way you described it sounds wrong, but your conclusion of what needs =
to
> be checked seems correct.
>=20
> Eric
>=20
Since you described that net namespace is the resource,=20
current->nsproxy->net->user_ns seems correct for rdma case too.

