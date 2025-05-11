Return-Path: <linux-rdma+bounces-10268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A5AB2A30
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E791C172105
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBB25D211;
	Sun, 11 May 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TPTyHO63"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021078.outbound.protection.outlook.com [40.93.194.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A90E2F41;
	Sun, 11 May 2025 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746987392; cv=fail; b=IjxYnbSvQirEMZVOoGUXjpPvaY8Imw/lg7rKSHDYIOXj8SqAM5xbS3KXexdDtxFu9X80xDblN4VoauzYrf+iNEQPenfinleydzbdJBNFMlMB48z2JQcVmV9pXKe0yfe1R55Be19qNzjbIruVAEO+Ojz16a7RHNUXwnJKhrn2X4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746987392; c=relaxed/simple;
	bh=jYpuZeNDA63snO+sJLAaxcxJ5JCv5go5u9bDm35SIAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFQIXVSoLYWLHnrX0HZlnRyokycobwZwyUmQRFUBL+jVnsw3WRg1RyBTnk9K6zJnu/jqnxVao/A6yGMWn8Pyt5dxFlq5I8PDZMpCrNItU25dd/OxWp81bhIeC9MGXnZFEOqEJYIlHn8kMunLy4c92HH6c7rDzauKgm9VzkyYb0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=TPTyHO63; arc=fail smtp.client-ip=40.93.194.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyBQoyjTG3B/u2mJj3lhxjs4Y4lxNev5vYkr1Frpgi6biaISccTOiyznV/cDkGkw0qNvIBDFb5gwwL+wbAzFZpL7eK1PqiQVpDUfX2QElRd2auwMBrXhKl8fB+8YEyS8OM5j2Tv8fhsiZHcBE/0JdJp/1wrAW5/6zThtyB4DfP3J0+d7am6Lkvv5pn+aCTrzDhwtTkk/SwEl/NIv6raoNwEkPjwPsuN+LgJ83qyU+QnNA3c6H3FArzyqOCmoHA9DICyZ4AsnfDd0LSOmrZM1iVRtM0KNPBulCk7WEwXnQYRdTYSFL8gXmjONZKxj/z7Gf9aNnEu9shuS9jJEUm4trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4/8OdZrNBL5dpC0Y2AU3yXm0xUlt672g0oRNu66VQw=;
 b=y7yLuOr/oFjmAJJ2LUetk4UprMxYrgdBhs74d23Y8N5uFmEt90aVaLM+3dylVSuZehUw5Rkwl3jWNuR0teWuO3YCOzyR5qOKDaenIZ4YDopzjz8v2cAhEvut1hi40haU4dCqvRgE1l9z54DawIBa5fBcv9Pr26tfX9buTjuqpR3FKqjo0URNPekw/UHJqGSpbwVWhTY1OLUFIHzddjaM7Irgue+8NrFz9tOkl5cgLsr39OiWYZrSSzUpcD0EwdbHc3prwp2lb3JJYsC0KNH7bSzgHK9ZZ+78LE+snBzgN18B6Zy9+fH9prxej7uy2xs28vF+LvLtekcVNZhGhJP3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4/8OdZrNBL5dpC0Y2AU3yXm0xUlt672g0oRNu66VQw=;
 b=TPTyHO63nPIHrXQgTpnjJ+aXM08HMSjiqhe0oT6klatETw3VIxApp4v7YrIYEkIVbUaWp5PBunzz4IaF+6jgU3dqbm02Lmfq/4/7lPCSpyG9FmyZr+RldxZfWZlcoiGHl3QJ6rBJiOmwUVCEPqua0ML8HFuaCMKdZwcwGcOOoos=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB4002.namprd21.prod.outlook.com (2603:10b6:806:376::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.10; Sun, 11 May
 2025 18:16:26 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8769.001; Sun, 11 May 2025
 18:16:26 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v4 1/4] net: mana: Probe rdma device in mana
 driver
Thread-Topic: [PATCH rdma-next v4 1/4] net: mana: Probe rdma device in mana
 driver
Thread-Index: AQHbv2j5h1+oTGXcJkmQ8cQz0UlYdrPNwsBA
Date: Sun, 11 May 2025 18:16:26 +0000
Message-ID:
 <SA6PR21MB42311D71F057BAFBD68353C0CE94A@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
 <1746633545-17653-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1746633545-17653-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=715ad07a-64e5-4c82-a473-8db480e491df;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-11T18:16:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB4002:EE_
x-ms-office365-filtering-correlation-id: edc81462-784c-488b-b17f-08dd90b7f198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?n+QnuTwgejtRsTiRsVbhgO91JnsBwE1cFfR0+b2lnRydGQrXJwBiV6fjyRbr?=
 =?us-ascii?Q?48jm0cZ9hPG7BBcFHHgDohQMeNl2KjXh2U8Axc/gy0fEky660M8/PuK7aSrl?=
 =?us-ascii?Q?GiCaA8iQw4e1hVmXQ/ZP+l/npNhOTufv8ZPAW2ffScj4iRZllYebU0WFnxEh?=
 =?us-ascii?Q?ZnnGzmc475mENDkjlLTyGesvV++ZPyVwaqWs1mKK/+kweolcRreRkUEp1yid?=
 =?us-ascii?Q?DZ60oesAVCmwMGXvCc5kwSmJHFXp4TOZzwulpzuT+lIHg5kRChWdFuqWrCG5?=
 =?us-ascii?Q?5ufrydA0rsRoicf8wzFA+m2GKTXBlJZQdyDaCNVHBWqoM78DKGFx6Rq1dzT4?=
 =?us-ascii?Q?FINigtbzk+EWt0dhO8TCuEnI7czbx7nN2L8yk3nEWH3W7vIp/1kjc0b2f0zh?=
 =?us-ascii?Q?9BSqBx2ldOyg6lwC4k2HZYi3eJjqZZqNPK7kRxUFrrX4x9uCJs5MvU9ao9QK?=
 =?us-ascii?Q?Za6S2107IH77W6fgncGGQ5n0sHl+zyH8oX10J8xYaGF7/nuF3ZM1y7BJBiYP?=
 =?us-ascii?Q?5MweuSQvHVN+5lwP31jjQ/MyBjqqfIAk2N9O+NmVKpnmrI27/uUI83511UbM?=
 =?us-ascii?Q?odqMArkQ+0cOfRUSkykuvr0a56Pko62StZDgnitB4XF0MNANpjwILl9z9Qcg?=
 =?us-ascii?Q?3S2MLkAWfTzl/DI0nYs4Qo7qITgo4dgXzi0hUHTN9Rs2Hg0/9H7rUsS/en1H?=
 =?us-ascii?Q?O12ann/F/4Z95nq34tJ+Y1Vwskqi6dGquaX2PBatxTuw/g0Rio8+YM58AVRS?=
 =?us-ascii?Q?bSQBp+1+dLMznxneknN+GfmAcT0aeLlHKzi3nRreNY2EJ2hhinW35e/KzO7S?=
 =?us-ascii?Q?gevQwYKugHkn2Tj1Ua3aQ3XJHyxK8G8Fg4QdBJNTI5MMtbypfi2T3tCCJhT2?=
 =?us-ascii?Q?FdMiCdRROXMSiFPf6yL0KGFCKAwrbD6dkMobiyBkTMzcjDtfCTA4pE/vIS5I?=
 =?us-ascii?Q?Ks+DbIa0i1p4QfM7O9xawK6QPfbA8yQZOujnxhB/PZaajTW+DA7mqsCFOlPW?=
 =?us-ascii?Q?4prYdyrNXhBp+G94fCkLijd/6yrlBtN4bOcdThKQEbfanUr+f5mgX6tRvmfY?=
 =?us-ascii?Q?ZByWYh6nsRgyrCYKm177bh5LD+Ru6vcE2L4Qr1UbTLIjNDWFVqGO6Wi7mL14?=
 =?us-ascii?Q?4RSAHY40QNtN7Nc3Pes6eLNKGJUMVNXoWQpcpZK07eaXha755GHJSrEaPf0q?=
 =?us-ascii?Q?hEnxAyHWSt3/bP/XszPxTk60bBzjJaDAxaeRrnDbb5wmdfn8c1Fk6IA3KT0S?=
 =?us-ascii?Q?GNGIBX2un1hKqgxc4+PakY6hIRlc2gX0GvWdci0Hpg0dJtsQSXK4ihsN/9Bh?=
 =?us-ascii?Q?DxAnAd+5eHZBXXHKeKroBah//pv3kHzyas6y1bC/vFNDe6NdOhaKz75cdn4v?=
 =?us-ascii?Q?aCLNf+nH7VPkOJLN/9pRKPwrNi4ysDvQQ4vrCGUAzXjF/jekYWvN2fkBgUdS?=
 =?us-ascii?Q?maGqKSQe/lBQnGroMTke+3jucF8uuTI9oX2Csp5E/Rayczj7h3DNV6oAo708?=
 =?us-ascii?Q?qAjsyiJ+4g9BM3g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LGh8QCrKRSSdgKUrMKJTUCZuV6UmLzNDJUWHmt05X56oglA99GKXGn8QHBWz?=
 =?us-ascii?Q?ywyW9VRMapdl7If9cCPVXJiXKJmFvXfzJuHsVUt17Lvi+6TJcLWpJvEiL/Hu?=
 =?us-ascii?Q?STEc4boF6gqho4ahnhmRPfM2cTiXZ5DRDxl9/2TTgN+XO+NfRjHks31/3liS?=
 =?us-ascii?Q?rOxyeccqe7HHBRrUuYSzuk3T1ETo1zP+hDCkOJZ/2G+9AHs2r5oExZBUoK+6?=
 =?us-ascii?Q?7qMlzzb4MeWVc7o0PkgI0OzNvYUOXsPGfCbespGDIsxymcL8JJyvx97XPdMl?=
 =?us-ascii?Q?aAzkpeI4588aykLKD8z67e+vytjN5ouYZigxHB+oz4ndgOCJlAMh2zqoISy3?=
 =?us-ascii?Q?WBmbdQ/HiqWSXZRFORLcp1ya3YXeYLtXnkt+0dENzXdCiwN09Vf0KE0ZN1rS?=
 =?us-ascii?Q?p5WUakHYx8bse0mLx48oOivxh70vva24PRyZFaHGUs7SLY3j/t7eD1V6BcU7?=
 =?us-ascii?Q?gGDE0is1F4UAUBttd/InwOLYzJvB++5Yf74Z7KuUPxtGBs8bJ01YGEmC6EuH?=
 =?us-ascii?Q?tdTdKvoQ6hO4N3n2CAQwcAZm651IWzNyttOavyK23U566CHzZtZIZoHZXRVi?=
 =?us-ascii?Q?BShntz2xdnXqg0AMIp6g+eETZPMUSautbxzY7qew4Ig4k1pCQa/7Zq5/t+aT?=
 =?us-ascii?Q?cLxltNRcKGEr5FAmlhBcEcEURnLSxctrCHrDnyS+BG5II8oefUNdzUlc7Boa?=
 =?us-ascii?Q?0yZpiPOh0dNCH9i3IBngY8PQjdrKJf+3ZOBVfB3J8awSdzTd3PH29q+ldN5J?=
 =?us-ascii?Q?mMU/88P2hGVgeXufFgfe0+qVmHC1ky96ST0hXCk8hWw3K6/BB5CNE9XHnqGy?=
 =?us-ascii?Q?FGdLae6/EFCBJ0tyTA6TNEi4+8DxCaJbRIeQalLSlsJFNGCYu3xvkVcLN9FA?=
 =?us-ascii?Q?qFdZNoH9i3QeMWw409w3adgJvhFXZkx6Shyc4bu4/zH66jnTVol6QhayFuPu?=
 =?us-ascii?Q?sLe2alOogM4GTUjQNiC02mb8vwTRnVew1k12sXiEG/H45Kv1QcPSM4uf/Rwd?=
 =?us-ascii?Q?CDtDngEkwMNZwd8J3Y4epTT9zJORW1czBnzbA+2qINOno36mR1EKz+GMa8Qs?=
 =?us-ascii?Q?wTiIF5h4EgyXc2PFiD2jrSt9bqJcVaS4zNIKy8nUKpCq5P2V3URkxvIzOV9X?=
 =?us-ascii?Q?S7Au43vvBtfjqvRpYY8FpfTzTPUo5TOXyLJAgdfAsmIvMdwxk91MSZndnsUV?=
 =?us-ascii?Q?3LiqlJoIWVUgrBnhXCZ5EIvMIaBHyWAB3SbnZvfMeY9S89pHtP/MN8hmhSmJ?=
 =?us-ascii?Q?6LbreDrNAWv+EvbEd54kkGRbQ2dzpviHnAby/ILzUdPmZ9nchwmAb4/SqvNO?=
 =?us-ascii?Q?nsezzsaxdAWQZttstAN2rnIxB5airY48ozh/4g5dS7idpP9dpKDNreCrLC4E?=
 =?us-ascii?Q?UKmcH67HB9yti2u4/w0sjqqVhicol1mkAAWa6nhb9DVFZhP333l17bLZDlhx?=
 =?us-ascii?Q?j4MiWO3XQdbV5ay8NFUbfljsaF+lN5l351I8oZW30WV5QFdtu+oaolRLGfCc?=
 =?us-ascii?Q?6VcomVolkw87FEKqMY8DFVRQjsYshqeuB499hO3/wQZodUZftRO60oeWTiBL?=
 =?us-ascii?Q?j9Bu/H8vZCvxyAwbyNAV5jFhVXsNXWoPPdkKWDb6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc81462-784c-488b-b17f-08dd90b7f198
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 18:16:26.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dIDDUu5TOixuHf4lCeRGSy6WKUtH7xcSFEjNLsYjiY4Tt6u4RtyDn5bp1oq1KMqHTiBfraROMDALMfgx1IP/RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4002



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Wednesday, May 7, 2025 8:59 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>; pabeni@redhat.com;
> Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>=
;
> edumazet@google.com; kuba@kernel.org; davem@davemloft.net; Dexuan Cui
> <decui@microsoft.com>; wei.liu@kernel.org; Long Li <longli@microsoft.com>=
;
> jgg@ziepe.ca; leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [PATCH rdma-next v4 1/4] net: mana: Probe rdma device in mana dr=
iver
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Initialize gdma device for rdma inside mana module.
> For each gdma device, initialize an auxiliary ib device.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 15 ++++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 39 +++++++++++++++++--
>  include/net/mana/mana.h                       |  3 ++
>  3 files changed, 52 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 8ee1aa3..59e7814 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1005,7 +1005,6 @@ int mana_gd_register_device(struct gdma_dev *gd)
>=20
>  	return 0;
>  }
> -EXPORT_SYMBOL_NS(mana_gd_register_device, "NET_MANA");
>=20
>  int mana_gd_deregister_device(struct gdma_dev *gd)  { @@ -1036,7 +1035,6
> @@ int mana_gd_deregister_device(struct gdma_dev *gd)
>=20
>  	return err;
>  }
> -EXPORT_SYMBOL_NS(mana_gd_deregister_device, "NET_MANA");
>=20
>  u32 mana_gd_wq_avail_space(struct gdma_queue *wq)  { @@ -1579,8
> +1577,14 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	if (err)
>  		goto cleanup_gd;
>=20
> +	err =3D mana_rdma_probe(&gc->mana_ib);
> +	if (err)
> +		goto cleanup_mana;
> +
>  	return 0;
>=20
> +cleanup_mana:
> +	mana_remove(&gc->mana, false);
>  cleanup_gd:
>  	mana_gd_cleanup(pdev);
>  unmap_bar:
> @@ -1608,6 +1612,7 @@ static void mana_gd_remove(struct pci_dev *pdev)  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>=20
> +	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, false);
>=20
>  	mana_gd_cleanup(pdev);
> @@ -1631,6 +1636,7 @@ static int mana_gd_suspend(struct pci_dev *pdev,
> pm_message_t state)  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>=20
> +	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, true);
>=20
>  	mana_gd_cleanup(pdev);
> @@ -1655,6 +1661,10 @@ static int mana_gd_resume(struct pci_dev *pdev)
>  	if (err)
>  		return err;
>=20
> +	err =3D mana_rdma_probe(&gc->mana_ib);
> +	if (err)
> +		return err;
> +
>  	return 0;
>  }
>=20
> @@ -1665,6 +1675,7 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>=20
>  	dev_info(&pdev->dev, "Shutdown was called\n");
>=20
> +	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, true);
>=20
>  	mana_gd_cleanup(pdev);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 5be0585..2013d0e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2944,7 +2944,7 @@ static void remove_adev(struct gdma_dev *gd)
>  	gd->adev =3D NULL;
>  }
>=20
> -static int add_adev(struct gdma_dev *gd)
> +static int add_adev(struct gdma_dev *gd, const char *name)
>  {
>  	struct auxiliary_device *adev;
>  	struct mana_adev *madev;
> @@ -2960,7 +2960,7 @@ static int add_adev(struct gdma_dev *gd)
>  		goto idx_fail;
>  	adev->id =3D ret;
>=20
> -	adev->name =3D "rdma";
> +	adev->name =3D name;
>  	adev->dev.parent =3D gd->gdma_context->dev;
>  	adev->dev.release =3D adev_release;
>  	madev->mdev =3D gd;
> @@ -3076,7 +3076,7 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
>  		}
>  	}
>=20
> -	err =3D add_adev(gd);
> +	err =3D add_adev(gd, "eth");
>  out:
>  	if (err) {
>  		mana_remove(gd, false);
> @@ -3150,6 +3150,39 @@ out:
>  	dev_dbg(dev, "%s succeeded\n", __func__);  }
>=20
> +int mana_rdma_probe(struct gdma_dev *gd) {
> +	int err =3D 0;
> +
> +	if (gd->dev_id.type !=3D GDMA_DEVICE_MANA_IB) {
> +		/* RDMA device is not detected on pci */
> +		return err;
> +	}
> +
> +	err =3D mana_gd_register_device(gd);
> +	if (err)
> +		return err;
> +
> +	err =3D add_adev(gd, "rdma");
> +	if (err)
> +		mana_gd_deregister_device(gd);
> +
> +	return err;
> +}
> +
> +void mana_rdma_remove(struct gdma_dev *gd) {
> +	if (gd->dev_id.type !=3D GDMA_DEVICE_MANA_IB) {
> +		/* RDMA device is not detected on pci */
> +		return;
> +	}
> +
> +	if (gd->adev)
> +		remove_adev(gd);
> +
> +	mana_gd_deregister_device(gd);
> +}
> +
>  struct net_device *mana_get_primary_netdev(struct mana_context *ac,
>  					   u32 port_index,
>  					   netdevice_tracker *tracker)
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> 0f78065..5857efc 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -488,6 +488,9 @@ int mana_detach(struct net_device *ndev, bool
> from_close);  int mana_probe(struct gdma_dev *gd, bool resuming);  void
> mana_remove(struct gdma_dev *gd, bool suspending);
>=20
> +int mana_rdma_probe(struct gdma_dev *gd); void mana_rdma_remove(struct
> +gdma_dev *gd);
> +
>  void mana_xdp_tx(struct sk_buff *skb, struct net_device *ndev);  int
> mana_xdp_xmit(struct net_device *ndev, int n, struct xdp_frame **frames,
>  		  u32 flags);
> --
> 2.43.0


