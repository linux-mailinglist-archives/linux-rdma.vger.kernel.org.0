Return-Path: <linux-rdma+bounces-9617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB14A9487F
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 19:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D2170B1F
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5813C3F6;
	Sun, 20 Apr 2025 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MgYvFlQX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B531529D0B;
	Sun, 20 Apr 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745170299; cv=fail; b=Sb+vWfOBCZUcfx5nJzsa9aOLuB3eBldVdXrB7kTi4OdCdy+OIG2fnIsMq/2BlwvsUbtLMW9IkPm3PfsnEGjK26Gnd7rb6ImXOco6bF7UaHZEEHtOKorxpaVd7SLjFAMMDpkE6EPvLDI7RDdI1Zmx09QF09k+YQa+0usRDcVL+vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745170299; c=relaxed/simple;
	bh=uDg1wSj4i5I/LZnRYZNpmNY+iwWmRf7AvpZmz3myKWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzO4ijsHTUafJEdYvsJmbGapwqBFdQ74zXT8ZpOKmTspRvDf1tJKv81PGM+ek3cHLEMfRdvDD0wMiEBNoNsHlXnhHu6XeMr5mIt3dWG7JvAqxskKyCv6nxYmDoZrmJ/FBKsbLgA2qBzAUMx1deW4ezlIUK+UyDBvKpsZ/cE6rcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MgYvFlQX; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VomT5Tq1ibQv7jeHHwfw4I26x0l9/NBGwobQvzHT3AYpQXvauUZMSLICxWSJitnYrsW/Mq/RIl/gtIUI4Vruq7Eo/QgKXryIZeUSeDKhebyoQFpaiSaBsjABa4KGxyihh7FZbwwpmkux0/IrX3W35CdIYvoig/UikCYriBr2YGtotLC83EU69dT/rh8vCGqCm0zWYbe0vf32o9uTvxZHSWFDv9pFyKVZRSlc9Abe5XdIURnX/paEiBDBITiz8wzkGwAbDS3NdmQkRNnz0NTeHm7Yn16r5Fu2kOtDSrmKmZdFXzkqEtQknnQ7h1MbN23tUHifzAIOrF8zfugwy6d0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUFrMkyAFmm5d02WGLe5COWFoQzRCFkfkxELtFYjjY4=;
 b=ZIal0PQIJT6Q54py+uNprFSVV+qeEMfl4cPaPu43tgXpcfgvk0ifRZJddnAyxiwySJfgyvSFsc5bmHGNFBIaoqNQt7u7vJlIUeOYcOoVFGqNFBDPU6L2SBEsCNcgWUvlRP8WY0/HSsaontYi/GpbFy8AvCpySyNdANawNiYt17pxRpBjfgN7hwncl/dE8xDHgtaJg3LKdvosoBRB7x8yhQBtyLovZ2su0GAesNF6m68VAbNo+D0HUKyb0nbipFr058F14y9XcccxibD/Dt117EpxAwIfV7cbtMiz3CXYrzVlYH4pM6iEf6PBqXsWcEYMv2VVO3ZKsb0jF6FcunQZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUFrMkyAFmm5d02WGLe5COWFoQzRCFkfkxELtFYjjY4=;
 b=MgYvFlQX6NWW/9z9b5hFnR91oM0XzRb6gCPSHkU2njcypid7x3Er1mTTunMS1BGp1UX7ElznpIIMhOtdkARI1Jr4PsY79gQtxmZEqgvNbZsLWsTFEsvr0orgssKRCEvakErLi7DU44wp+Kmje+LhHtM26V/jg81yl65ZjCg/IqdKvaZXRvmb++mWWMCA+qjPhFAQ18XHT1bQU/G1r0rjIfCnFRRSXkHIKrfRAUowKcUCzkj+mLqvu5tmw5AghLzG5Zm57xwwWvR8DKtwTFUXlBkZHa6LpUnf8sWzhM6y1KcbW0Oh/S2RSIvtwqhtxDovOeiYegPexw97yWxQQib3Ew==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PPF84D37DD5C.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Sun, 20 Apr
 2025 17:31:35 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.024; Sun, 20 Apr 2025
 17:31:34 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: "sergeh@kernel.org" <sergeh@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAAC8yAgAMUPoCAAV/nEIAAO08AgBRFfBCAABalAIAAPlyg
Date: Sun, 20 Apr 2025 17:31:34 +0000
Message-ID:
 <CY8PR12MB719571DA9CE095E28B4A7E74DCB92@CY8PR12MB7195.namprd12.prod.outlook.com>
References:
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250404151347.GC1336818@nvidia.com>
 <20250406141501.GA481691@mail.hallyn.com>
 <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z_PlWIj3N2L6nPaD@lei>
 <CY8PR12MB7195E57FD82E93DB34976CA0DCB92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250420134144.GA575032@mail.hallyn.com>
In-Reply-To: <20250420134144.GA575032@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PPF84D37DD5C:EE_
x-ms-office365-filtering-correlation-id: 5761d800-d211-48b2-44b8-08dd80313294
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JwNHyIurM8uw8y0CXmtO6h2sQB5JLkEjttT0Tn4gkwZUfydMxTZO6iErPMAK?=
 =?us-ascii?Q?EuqAJUq48StNKJ2a9m0zVeZm8WQ8A0s+qBBROvQZm+qcvMuHwTjaCyy4zLQp?=
 =?us-ascii?Q?4Jy4M0mcyzOsRv5xTA/WTXj/OdBd5rHvJfJcVEyQL8J/mS2X3MGUUK3rhBbx?=
 =?us-ascii?Q?CSX5TtgyK9y8Ny5ufgVZbgBugFE04jtCP9WPXTiziASo7g7+mU5Ztsk6QMwZ?=
 =?us-ascii?Q?FPWynpufL9Xw/Trm/x9WTRqUNJCsUAKr/MH6+ybH50KQOcr91R8maEsAVLbq?=
 =?us-ascii?Q?QYsRACcwY0+kGx/k3PyGFOjoZrcgL7bIKRzIrcmksxhpuTxlIn7HMZPCnzkl?=
 =?us-ascii?Q?C4iBpHWd6e2ZigCEHNF0A3KLOlvLzhDvkyyquLEff3I4ivvbtNSQ7xea3bYm?=
 =?us-ascii?Q?diL8eNQAfDxSy9HruxGSm3hqOjUSc63791mufv484HUzmfLT37bIVWLEXzHB?=
 =?us-ascii?Q?uQlivCtZ95fZad6y0freQpsRoFKroOvn1DFOWfNrK6Ng+D0CvOmbkvktyCeK?=
 =?us-ascii?Q?5ZjJcUAKGH7RVQ/CdwG98ynpuHqczA390aasOS2IUWBQgoC8nigI08nd1pQv?=
 =?us-ascii?Q?cR5uEslg5F4UYeQpRgh3cqzxFt6p1Amr+3jflfdf9nbBrYTvytgLrN3ALsu/?=
 =?us-ascii?Q?N4tycpBZVy06o57/CRaBYV3ZlirBUhMFEV8CgsaMOrxerrCTOd5WDsGNQF0c?=
 =?us-ascii?Q?B6pgZLUGkN2QJ2b15cwq1/L3nrreg69ksIA9DgjplOaWKbcOqRlynWdQ3Qys?=
 =?us-ascii?Q?DzwYXNOf2rJ5+4bZWbcM9DVwU/Ovdc5q+UaUNoTPkm196MmgfdOODlz092qp?=
 =?us-ascii?Q?a1cMa5iL9QUHUhMkvBtMQGfghjDaEqBNY11qShYbKcXIFaZpkUpF6tR0xjN9?=
 =?us-ascii?Q?TdLBtrUzH6sZ+3gHyHefu2GhDXuGPBV4qOYSYgdmdsg6SDAUy+oXtoXVrgxL?=
 =?us-ascii?Q?g82qg2/p5Ug4+b0pQpgGwEC1i4+JYdMItehOMA41lM6ucy/Ui7dUGxaEJzqP?=
 =?us-ascii?Q?iVE/IYePisPETHa0lSDevCg27m1kRKiCrQoUcnUgkt0v7VtIwqE54y0tKRZy?=
 =?us-ascii?Q?9z+cN8KKGOTzwhQ/yxHessezKHZHVNiccX13jNS5CZjwYGCzXKR/AfDobCIL?=
 =?us-ascii?Q?LJ+WsDwQiT7qiRIXuHST/7ApINaNteHzGga+/KyhXSDz7U2RJPNxuPVLvPX/?=
 =?us-ascii?Q?osL8cZJ08Q0WrQrt9bKVXr8wOYbdSVvJYOM0CJoOIJnsIU0sDZfelwODcjhm?=
 =?us-ascii?Q?H9Sf/fSdjwulm/m6G1p10sCAtFZCFPUJ36cPcYxGu6zjBmPj0wd5gcFixksN?=
 =?us-ascii?Q?nebaZb0EnaKUxsfc7IX7nkUIsFrPdI68XgDRpa9vyVmDlsNfn4GFpA3PQkCy?=
 =?us-ascii?Q?nTngrnJ1eNpwG/zNWBKF/Lfenh5cQKYPedSqY1G9tqZQN0WvSKIjDk3F6Pr7?=
 =?us-ascii?Q?17xZNc/85srpQBlJ/Pzj10rXbbanoaOVLJ2A7WNqZ7+WiMBB4/8FVTLUHWdw?=
 =?us-ascii?Q?mBiE9WzgqetNMnA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zeEf04vRU3cv4zQkFpGOLA4CQAEUePmo8dOcPPgcIRi9OgDabMUtfB74O8ni?=
 =?us-ascii?Q?jV5sFeX8cZgrT8JeUeiHIjPJ21UewMt4+OH7aTJXicS+KE3OQG2P+3R3Vasb?=
 =?us-ascii?Q?w0wzDay+9zTHVSsfXYYP6xJtrcVHCiNQDSOa4NM6NPQmK4PszUweJ9Rw6tWh?=
 =?us-ascii?Q?GtaHGZ/5HA0rqyYnt8JaZGlbL0Qrd4vEbm/hyvgcpUr7+xOv4opY/xVwlB5f?=
 =?us-ascii?Q?P8l6NMU8hPeHOE+fGhiWkw1FZ+FwjHNqP7OINy+pkFDfbn9QY4zFRqYr27tO?=
 =?us-ascii?Q?Q9jLURiyG3uE7uaNhL4rYsaDAj+cZubwfU/72ivQt4OONLL9IOv69wyIeIGk?=
 =?us-ascii?Q?vwhO42HtA3pHuLJNNAxqxfPlaQqZu+TefF8SaOdjgVe2f0kRitEmb0FzgomE?=
 =?us-ascii?Q?WrlPJyyTjN2EhOcoSbFKRDQVNrZ9v6TAuzrGpZlWboBcQTCufdYlsrXQJVxV?=
 =?us-ascii?Q?q+k1w9iWGWSMULhr+S+xcefQNZ3HHPUD9fwLxqRZVYn3L5I9XpxgTBQfYsHr?=
 =?us-ascii?Q?uiAPwHm26/CoZ6/ugczoHgSv4sK2jfvkmOXCI59P3gMAOH5yHaZY6vSKyy37?=
 =?us-ascii?Q?pGrd4VIpYGo5XBA0QKEHdSH3zS77fbDyPE/BgthKjzMCag/mG+ny/b0wKD4e?=
 =?us-ascii?Q?+/Nra46vfdmFtTx3Gpy2mn1jhSYvTa9TC6ox8jlPsOCXKxWzdRHp4WZ0qTsb?=
 =?us-ascii?Q?n/zOngFY7989OcmRGj25fN0VK/niPkQ+OTUwzmtZFZfz8iIpLY8ZVl1QX0Ub?=
 =?us-ascii?Q?o4QzapGbjdJUnZ77v2UxXxq1JdoNsvUeTXZmWxkstHDwC9DZxcKjFzOh7Rsy?=
 =?us-ascii?Q?qhQT7BMOsZLLgDxeyX+Y9ip2FMzllLKIiEJbieg86UY0sTPv3H6Qm2rysa77?=
 =?us-ascii?Q?eHqSd5MyzjbrQ3gneoYbIcK7SyppzPIUXT63G6/deO32AVcS9IU71bZ2tW85?=
 =?us-ascii?Q?abbl38G7QMsiQUg0g1kwB0MMEkBOLXaN4lZywlrf791Xc9M5D9chdIJ/TlOH?=
 =?us-ascii?Q?BivUUWbzDZj03sMDlWk0ZH/QWYNLNzXs2rC4vpWZ+zV5s4pI4geQaTld10BU?=
 =?us-ascii?Q?jq9JWlmO23S36cLWAUkege9Ya5Ypt/y2oXf8KkoPaDvRg5UfDs8CMX/S6WbE?=
 =?us-ascii?Q?sdu/r6G0Vp8wZbSBMIzEhJxYuzF2BFe8/nPscwUzmTzhLdezn0Tu9N/Dyr4F?=
 =?us-ascii?Q?03E7t5QOPpmwIoS+rl1dr6RC5uylSORRgolHgZ7rtYMJPo3eJq2DaLaEgAc4?=
 =?us-ascii?Q?7CitC6fEm0Y0rEHDPIO5hELXnRkWW9kG2sl0LxeYNCDtdwcBhFcNM+I6tB4g?=
 =?us-ascii?Q?JinZ1U8gDVJdnOiK/mm0JOSFh6QQPmV5AGMq2GupyqDGMrs2bpjOO7MAkhIi?=
 =?us-ascii?Q?iMgC02B4N9z7ftRP6SMbEFL+YLfVsVPNwngL9Y7EzdIiD6Zb4+MpqPPCnuIE?=
 =?us-ascii?Q?12+qbi7BWQWAn7lGuKY3xqmMTsVGwmJLOzUL7jsaJsq81L6nPYXzCRfdeNAi?=
 =?us-ascii?Q?n+LonJCrva9E/fhxuuxFYM3GL5EMz/IffumM3jg1QXKI5xbH17tZ3CBJjMSI?=
 =?us-ascii?Q?3b2UGvVwE1EuJ5EbKYg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5761d800-d211-48b2-44b8-08dd80313294
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 17:31:34.6264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deMH+ONVMRU4OEAE+jKanYS1a2NDxZJDgYbWald5XrSbVY/nP5lywTnnRvcR46x+GnGa1DzCXrkiw4VrP9pKiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF84D37DD5C



> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Sunday, April 20, 2025 7:12 PM
>=20
> On Sun, Apr 20, 2025 at 12:30:37PM +0000, Parav Pandit wrote:
> >
> >
> > > From: sergeh@kernel.org <sergeh@kernel.org>
> > > Sent: Monday, April 7, 2025 8:17 PM
> > >
> > > On Mon, Apr 07, 2025 at 11:16:35AM +0000, Parav Pandit wrote:
> > > > > From: Serge E. Hallyn <serge@hallyn.com>
> > > > > Sent: Sunday, April 6, 2025 7:45 PM
> > > > >
> > > > > On Fri, Apr 04, 2025 at 12:13:47PM -0300, Jason Gunthorpe wrote:
> > > > > > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > > > > > To summarize,
> > > > > > >
> > > > > > > 1. A process can open an RDMA resource (such as a raw QP,
> > > > > > > raw flow entry, or similar 'raw' resource) through the fd
> > > > > > > using ioctl(), if it has the
> > > > > appropriate capability, which in this case is CAP_NET_RAW.
> > > > > > > This is similar to a process that opens a raw socket.
> > > > > > >
> > > > > > > 2. Given that RDMA uses ioctl() for resource creation, there
> > > > > > > isn't a security concern surrounding the read()/write() syste=
m calls.
> > > > > > >
> > > > > > > 3. If process A, which does not have CAP_NET_RAW, passes the
> > > > > > > opened fd to another privileged process B, which has
> > > > > > > CAP_NET_RAW, process B
> > > > > can open the raw RDMA resource.
> > > > > > > This is still within the kernel-defined security boundary,
> > > > > > > similar to a raw
> > > > > socket.
> > > > > > >
> > > > > > > 4. If process A, which has the CAP_NET_RAW capability,
> > > > > > > passes the file
> > > > > descriptor to Process B, which does not have CAP_NET_RAW,
> > > > > Process B will not be able to open the raw RDMA resource.
> > > > > > >
> > > > > > > Do we agree on this Eric?
> > > > > >
> > > > > > This is our model, I consider it uAPI, so I don't belive we
> > > > > > can change it without an extreme reason..
> > > > > >
> > > > > > > 5. the process's capability check should be done in the
> > > > > > > right user
> > > > > namespace.
> > > > > > > (instead of current in default user ns).
> > > > > > > The right user namespace is the one which created the net
> namespace.
> > > > > > > This is because rdma networking resources are governed by
> > > > > > > the net
> > > > > namespace.
> > > > > >
> > > > > > This all makes my head hurt. The right user namespace is the
> > > > > > one that is currently active for the invoking process, I
> > > > > > couldn't understand why we have net namespaces refer to user
> > > > > > namespaces :\
> > > > >
> > > > > A user at any time can create a new user namespace, without
> > > > > creating a new network namespace, and have privilege in that
> > > > > user namespace, over resources owned by the user namespace.
> > > > >
> > > >
> > > > > So if a user can create a new user namespace, then say "hey I
> > > > > have CAP_NET_ADMIN over current_user_ns, so give me access to
> > > > > the RDMA resources belonging to my current_net_ns", that's a
> problem.
> > > > >
> > > > > So that's why the check should be
> > > > > ns_capable(device->net->user-ns,
> > > > > CAP_NET_ADMIN) and not ns_capable(current_user_ns,
> > > CAP_NET_ADMIN).
> > > > >
> > > > Given the check is of the process (and hence user and net ns) and
> > > > not of the rdma device itself, Shouldn't we just check,
> > > >
> > > > ns_capable(current->nsproxy->user_ns, ...)
> > > >
> > > > This ensures current network namespace's owning user ns is consulte=
d.
> > >
> > > No, it does not.  If I do
> > >
> > > unshare -U
> > >
> > > then current->nsproxy->user_ns is not my current network namespace's
> > > owning user ns.
> > >
> > It should be current->nsproxy->net->user_ns.
> > This ensures that it is always current network namespace's owning user =
ns is
> considered.
> > Right?
> >
>=20
> Hi,
>=20
> That will depend on exactly what you're checking permissions for.
> It looks like ib_uverbs_ex_create_flow() gets passed a uverbs_attr_bundle
> pointer that has a context which holds the thing you're actually checking
> permissions towards?  And I'm assuming that that thing is actually a file=
? =20

File is just a conduit calling into the kernel for a specific device.
And ucontext is first object where other objects are anchored such as flow =
done using ex_create_flow().
So what we really want to check on the ioctl() is, if the calling process h=
as necessary capability in its user namespace.

> So
> again, if the task can create the "thing" first, then unshare its network
> namespace, then cause this permission to be checked, or if it can accept =
a file
> over unix socket or whatever that someone else opened, then current-
> >nsproxy->net->user_ns may *not* be relevant. =20
As Jason explained, it can receive or it can unshare too.
As long as the process invoking ioctl() has the capability, it should be ab=
le to do it.
Jason explained the rdma fd  model in [1]=20

[1] https://lore.kernel.org/linux-rdma/20250420134144.GA575032@mail.hallyn.=
com/T/#m1c84babbc593b255c6a4fdebb6c65651717a75f7

> If, however, the flow, later
> on, will ensure that any actions are only relevant in the current network
> namespace, then you are correct.
>=20
Indeed. Flow and its operation are in the net namespace of the process.

> I just can't tell in this flow.  I"ll try to find some time to track it d=
own more.
>=20
> -serge

