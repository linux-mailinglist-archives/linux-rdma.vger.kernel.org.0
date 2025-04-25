Return-Path: <linux-rdma+bounces-9789-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51967A9C9E1
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614521BA707D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F7E2512D2;
	Fri, 25 Apr 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qvVfddPq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11624E4A4;
	Fri, 25 Apr 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745586882; cv=fail; b=SXgqd5ZNprQtiBBwgrm8xXeknJRERrUetS925KYdPUdOQ54OfFBw8W/rfOIqMUVtkKx+ip6gRSdZscKgQh5y5CWGepph2cmN3aUxrVYQ94tKxmICvKH2sHNY9uUtlWdskv5MtnkJKSABef/gws6juxvHMwWUmECn0vN4K/P4oDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745586882; c=relaxed/simple;
	bh=Aqm824JoZD1yOd/ZrdvBpN03yWn+pA1sIxavUsr7tCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pR4HkAEtFs/Rbiri38dD4DGb9i6vBDhbXds0ysIP5zUE/gSYDkzvAQM+Yr6dJQk5wnX+MocCpupTlkcNci1rS3Jwodmtj9rbz6hkI6wmUaRXmpbZeO3Tov6HnaQ4T9yXS8pc92zZ3FQFfa/7i3ywWG4tVY59xh4Tug0wLAL19hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qvVfddPq; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgwJ22HSB9H+uFV9Tsl+bxbb3SvQUnEwHnDUxdTRCRoJwUnOA9zcBC91z54vBhwI6I656KM9gGQagIV+Ez8EdW38w8174pcQ2CE1oFNAtULvx8Dz7cP/0/qkdo/P/gWg8hbXhtaB4Vg3YWx/tAU6YTBRxhYcpdF+CQtlHsLHuSVjGJaE/i0oVweB59c9mpF4kS0sS5Hpid9ji/FBo+NsuAdzJY96qVeUtMLDd7adE7wo9yWS1yREZ/UlFgd1rR4e/Md5wQitE+dmI2dJn7TN/3GrqLToGCQhchlsMyG4z0JD8yoXH+zwN0RX9Ps6K/azqa9JRJ1SK72TectUb+4dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yGu/HfTzuflz6va91VTnUTr5arTZQPQ75y3W4SgSKo=;
 b=Qz9vvVgj/4oYtxVOmk2+GlXSIlHV8LIeMyqMiEf4xF2Q67/7Ff0ylGnl+ORLj268ilIZgD3q+tq/wKnYF7RF7M6iIb13rFNrvY1Nh3wKqfXwJuz6oWPlgCqvfWKho5XTShLZvY+hVqHBM9HQYAp01p36vKM6Qxa/gdXJMASuhCX0MvQ3LBjc7BeMjk9buqn8QIA6zp5L1AGCfSVL2X61faUMt+IlwhQCtPw998TFDI7fCh+9enAhyLBnEYxglTJqK3n1tJwKrHLGY8lQMFb+nFQoib5nd6NJ5aYH08d/pi6SSlg6DpcgQzqsqYgLRNzPXFMtSum4Mu6xcN1jr4zlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yGu/HfTzuflz6va91VTnUTr5arTZQPQ75y3W4SgSKo=;
 b=qvVfddPqMJM5Qhhc2Iss5ZQ6LNmuNm7cGeTyL8UpDEbRgGFxkO9e9yac1QA9vqV18a8TbfJFfr9DQK16QRdU3YFYd4j1J5c8vVmPTH6QZe+AfRyrhRQvPksLcCBmNyvikTmEviUnBFbbFpBncFmSTAT3y8MVC5uImCznXChjexXt86PCduYWyInzJi4pxdkMa0q3zdxjuNpoX7JyPMrYZ8z0wCf5WSEISPW9LINIaBz9nWo/BuaFiJwzjN0L0Txcbbhb/HIUNV6A5dhrNRajsjrQJVf2ZZFXDAMbMAXK7rX4HUVRXIccK4ngn7C8VjGZKOF5BcnOAJkKtrhFRIAS0Q==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 13:14:36 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.033; Fri, 25 Apr 2025
 13:14:35 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "Serge E. Hallyn"
	<serge@hallyn.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369A=
Date: Fri, 25 Apr 2025 13:14:35 +0000
Message-ID:
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250422124640.GI823903@nvidia.com>
 <20250422131433.GA588503@mail.hallyn.com>
 <20250422161127.GO823903@nvidia.com>
 <20250422162943.GA589534@mail.hallyn.com>
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
In-Reply-To: <20250424141347.GS1648741@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SA1PR12MB8859:EE_
x-ms-office365-filtering-correlation-id: 97807fbc-b4cb-4806-a2ce-08dd83fb204f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4DFcGFIVtrJ5jGtze7MaV3nniytOEPR++tzIZRfaPSpyhToeWqX9gsXXJ0SO?=
 =?us-ascii?Q?IrksZwyba4zmRvpBeibjOwW12GfYR6jfGoSPOCX0l50NHEbjDnr24Tiscd48?=
 =?us-ascii?Q?zOGzEGtt7st0sEVWEW+4Ex2vpVkHRzen4CEGlao9dd2pG/a4Ismxe+Lt0d7s?=
 =?us-ascii?Q?jzpJewnh1ibHsSq7vm7mkhHWl0m2LZHpNDML9CRMyB14B8eSTgk1DYFbCb8q?=
 =?us-ascii?Q?ms/hQWi/Etud0rP0bmGLSxX2pc0gXp4HqYFU9mrxXK5V81IpO8WcZPVVb1yw?=
 =?us-ascii?Q?ymOFi+fkeoWtA1NYa7GeiDJVX9m9WZ6CPy99V/RsQaHY8HJdN7P2IoYAGwIv?=
 =?us-ascii?Q?AHMCp6jVBTnz/OpUkvMk2EkqnUXq/+rcFoMYFuYv8iqs+DES5cf34izS0Gqz?=
 =?us-ascii?Q?zSKKv4l3SZFq5HhWrosh++gTXIg3DB8u1lvJKPz2cV2fte7QlvJeIT+HPFt5?=
 =?us-ascii?Q?gd2g5QpYUe4DWGiP61kCVDyuz0ISU/82v0Rv7yR9nHRJ/clvJ+0q1TUZzvcN?=
 =?us-ascii?Q?bPj2WRqSshQTUalqdFs79+sH1OnUU5LRUo2yOJ1INxm24WOEwYXWPB2nDyCv?=
 =?us-ascii?Q?izmdokavIDukelOkOli9tZGsa15F11KYexzoZc1xT0rVHmxPjzo6LQ1Osrvh?=
 =?us-ascii?Q?gW5hSATdudazcdVz2UNhRst8pGcWgK0GuyRAurtFloRN297ZSLS/5801UoC6?=
 =?us-ascii?Q?bMzwgL3W3MTYvdIFCsc5pDjsWfEMzd3p9aCd9Q87DyVtAQf2GKjoYiHJSJeS?=
 =?us-ascii?Q?UgH6+BS9l93fhIsAAOFYVvLnL69JbebT3XCewdQWvoH+MDMMCFy3VL1e/LEK?=
 =?us-ascii?Q?KsYbaK7m4L/X/qX2iMhWK8mzt50SHxwp6TgC9kl8CTh/E47n6y8P5cW8hJrx?=
 =?us-ascii?Q?eXcKDMlkxqwOCy6bs0KAkKBY9wMa2MyBlDVmqNm4JCafui3I4czGmWdY+4gM?=
 =?us-ascii?Q?DLc+ix7fNUGZ5kykf6U9kSwfIYIFJkTRu1NeZe+eK4GPUHhQmMHK9RZ3uupQ?=
 =?us-ascii?Q?nSeUvnfgLoIQyQEqiRdlGk96Wzg1kmMJTVWmSaR7hFcEkPDF77pcwlo2/84J?=
 =?us-ascii?Q?K9pXz7oPRJbo+BBFxlv+b3n3mAsDLyjT9mFQ5DQATbIGF5Cnd2T5Dwwg6ZoS?=
 =?us-ascii?Q?YQfLIcUdxfcB6bOdTPp99Al/5F1o37AOM9ADqTeXjwNxRfam2d3L7HXYTM+g?=
 =?us-ascii?Q?fYsC2RHBJMVCwXKX54VHZc00Vnlurz8+hv0qilfSbesCbiAC97lhqhOyREhd?=
 =?us-ascii?Q?hCCgZdnuxdSA4B/8ykgWlWBK+od9UZDaK+T6r4cr2FuMILn+DPbV2tATK5O9?=
 =?us-ascii?Q?taodWzjHmkNvn43JmmHKq1CZADOv4oI3jaWSPAG9O/LRIecaHvA310Bu6mRI?=
 =?us-ascii?Q?4iwMW906CIovEVwQuLym1iY4WLpEGOUJMWQHRxBbCcOvngaVLM5XP2dHJaLW?=
 =?us-ascii?Q?ShR57964phcPhspwEKDNZxaV5bIf81IWng4jWlJctZbYCYeQCO1uvKlPXNV3?=
 =?us-ascii?Q?H923gmd07GqxgKQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AP2J1No/zSP/NNwYm5sx5MCATbwK7qJFOSlV5nV0AUjtU6PUzTtHpFUznG88?=
 =?us-ascii?Q?elI9lIlsOPKxeY2I8bLE16Za2Spfch3EqJRvkyCuUArWB838RL3Fs5k8VrLW?=
 =?us-ascii?Q?wVjQKyA5DO+TAjt9bDvExSjkLk4YG1alYyZ2X7mziz9w8ovoCWwYT+wzN6Ef?=
 =?us-ascii?Q?E6Ox72Jd0T9VYJC7VvRUWW/Oj9K7RuchBLoLT5JDRpuanq/zvHd9VPUNPXXO?=
 =?us-ascii?Q?XDeqmi4VxvhHT5yJ34GpyoSgLGnbgrEYqOr6eUkMP9jcQzI2P0nzuMMR1tOQ?=
 =?us-ascii?Q?us8c+JzENymFeRb0eECirj/iHpP3yvdTQjF77ES46M13jfc6d8Ug3apRO5VO?=
 =?us-ascii?Q?ivinS9WXIo4tBsZqvf6xF6YFcTBIheNfLbp9pQdlZbW9WvFbKHT3FbOTmXCY?=
 =?us-ascii?Q?GzRA8H3rskgDy6kFAkQtmAURLA6wxI4iG6SKKnbgik1DMDHj1fBSQ/AbWzdh?=
 =?us-ascii?Q?3m0SS+LjdD3vrDQKMIdwa7D6ED4S5jQUy3QRPXj6MP8mAQ4D84J3ex5C9nq2?=
 =?us-ascii?Q?/NUWtgbdyDL+KEKnvsx4YZoHJdsrSmWxANDSejlZUmahPDzV0DVzCqDenxWx?=
 =?us-ascii?Q?/jMXnT2zt54WjFHEXjc2KfTuVzk5SRq9RSmQMjSwdKrDnrWotonI/jGlqVES?=
 =?us-ascii?Q?cJFR2f0aMi167oDUArvuX/LX4Er2ELz3JQORbUurkD+3ZnbZAPXy8lvqLBby?=
 =?us-ascii?Q?kg2P092jp9j3BHpNZAywTtJEwk9/NEzrPH4FzeJEbSIwAh6EMvV0QeKa+TPK?=
 =?us-ascii?Q?ot5YzlHKKz5MurL3bWVCN3tCA9a1R7yqLnGAaaObDbu9IKarp2q7TdoqYLRy?=
 =?us-ascii?Q?kbcJSWlXMzlPyj+c4FFHcSYRlH+IiucZJZC8h0ZJmdHPNyt+4NB+dN5u5vVy?=
 =?us-ascii?Q?czuiSOIl4X+Cc5hOMiuUSjzL2dIdE+amIoBbXt6zVgaE7vTEMQTzmYsa9OR+?=
 =?us-ascii?Q?qytf/5XfjWn3mMiTBGAm2lwoMRrjyeSW4zVRiQ5Hzb7HmRg9JiQxLUKgWBRM?=
 =?us-ascii?Q?Vy4pTeqZUGXuOEaR1noIN/+QTK4vYAGFMNoUXsZR1tuTqh0ndJstMWSZLwOg?=
 =?us-ascii?Q?6VZgS/tKsoYc6inor+ofLlkArelPdmmtio4V/vYn7CGxMqTHIpPzdBQK6d4v?=
 =?us-ascii?Q?iNozgpU6374K9I+shv9LkrpYWOMVeBRgRH3/WLiiMQmRwRVujHiJLzs+ecwO?=
 =?us-ascii?Q?KaLq/oNg5QzFWqh8uSjhcXb6oowVbbXTJiNpqWlRtxXZlGG5vMkGXqQdJKLE?=
 =?us-ascii?Q?+mBx1gAEEaYrsQdbLTH6ExG90GWB1Qur4P6Lj2rCRx3ZW3XkUly88gJTuMtD?=
 =?us-ascii?Q?5ZF7TD91jMS/NKjdOwBGJxiqrXrbK1ESp+3ecDUuiP7SDiKNEQVduk2OUQfV?=
 =?us-ascii?Q?daoRmVIT5gSyIQ8Uh4K2dOEowqoVI4bZM2URNDiTTSDYWZ7zTDgHn7t6Wpqq?=
 =?us-ascii?Q?+aG6LPNIse07kSg1oCBDtsS3KErhu3PF4Owy6+ZOvFRVzSbTX++0YkdPpcjS?=
 =?us-ascii?Q?tr7E+TPpIqyAgGa76ofo11CknhPiNMEEaTRkqPYjvG5SLYLuy16GepFsfUKb?=
 =?us-ascii?Q?VUx7cxCV+dZ7AU7E7yo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97807fbc-b4cb-4806-a2ce-08dd83fb204f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 13:14:35.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: osIJt3rODhV8H1ijKLy3DGXIdO1EhQrjkmEjRYA1RaTQE7hc6Ya+r3AWmhTfCwHI2KXmmcWBcbVhrg9mNcHhQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859


> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 24, 2025 7:44 PM
> To: Parav Pandit <parav@nvidia.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>; Serge E. Hallyn
> <serge@hallyn.com>; linux-rdma@vger.kernel.org; linux-security-
> module@vger.kernel.org; Leon Romanovsky <leonro@nvidia.com>
> Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
> opens the file
>=20
> On Thu, Apr 24, 2025 at 09:08:17AM +0000, Parav Pandit wrote:
> > > Since ib_device has a namespace and ufile is tied to a ib_device,
> > > can we ever have a situation where the ib_device has a different
> > > namespace than the ufile's? This would mean we changed the
> namespace
> > > of the ib_device, and IIRC, that means we revoked/disassociated the u=
file?
> So the answer is no?
> > > This means #4 and #5 are the same thing.
> > >
> > Right.
> >
> > > Can a uobject affiliated netdev have a different namespace than the
> > > ib_device?
> > When a uobject when created, it is not affiliated to netdev.
>=20
> I'm asking about when it does have a netdev. When you create/modify a QP
> and give it a gid index, for instance.
We don't have a check.
Usually once the rdma device and associated uverbs char device are assigned=
 to a respective net and mount ns.
So to protect against such privileged user error, net ns enforcement would =
be good to add for exclusive mode.

More below.
>=20
> > > The netdevs arise from the gid table, and the gid table population
> > > should strictly follow the ib_device namespace, yes?
>=20
> > I wish it this way, but unfortunately, rdma still have ancient shared
> > mode for example single rdma device + macvlan.  Until that is
> > deprecated, let the gid table entry's netdev drives the QP modify as
> > done today.
>=20
> I have been ignoring shared mode in all of this analysis. I don't think y=
ou can
> make sane statements about container security in shared mode.
>=20
True. one option is to check in modify_qp() and other friend callers net ns=
 checks=20
with netdev and current->nsproxy->net.
(and not of ibdev).

Or 2nd option (preferred) is: to perform the checks against only in the exc=
lusive mode,=20
against the net_ns of the ibdev.
Finding this better, as you also suggest that further below.

> > > Can current have a different namespace than the ib_device? I guess
> > > yes, the FD can be passed around. However this would mean that the
> > > FD caller should not be able to get any gid table handles as none of
> > > its ifindexes will work. So
> > > #1 is !=3D #3/#4/#5
> >
> > Well, it can pass the fd after the ifindex is resolved (i.e. after modi=
fy_qp).
> > If fd is passed before modify qp in different net ns, its can get acces=
s too
> because rdma device got shared.
>=20
> That's all fine. The uobject retains its affiliated netdev.
>=20
> > But that is the case with raw socket too.  The difference is, every
> > send() call checks the ifindex, vs here its checked when raw qp is
> > created.
>=20
> Also I think fine
>=20
> > We can add the additional check in the sysfs and in modify qp, but
> > very long ago (2019), we envisioned that users should use only the
> > exclusive mode.  And hence, those checks were not added.
>=20
> I think we should ignore shared mode, it doesn't work sanely with
> namespaces.
>=20
> > > What other NS users are there?
>=20
> > Incoming rx IB mad packets are looked up in the GID's attached netdev's=
 net
> ns.
>=20
> Ultimately a GID index should not be delivered to a userspace that does n=
ot
> have that GID index in the objects affiliated net namespace.
> I wonder if we are missing some validation here
>=20
I prefer to avoid holding a reference to the net namespace under uobject cr=
eation time.
I think its wrong to hold reference to net and user ns in syscall() object =
creation flow, but cant prove at the moment.

Better to enforce net ns checks when adding the GID.
This is where GID, netdev association occurs.
So if the netns of netdev and ibdev do not match in exclusive mode, we wont=
 even add the GID.

And for some reason if netdev moves out of net ns, we remove such GID entri=
es using usual callback via del_gid.

> > In-kernel ulps (nfs, smc) do not seem to have the interest, but they
> > do not created uobjects nor they access any uverbs fd.
>=20
> IIRC we have open issues with NFS/SRP/etc and namespaces, the kernel ULP
> doesn't have a way to use a namespace?
>=20
Nfs and srp initiator has net ns awareness. Rest all are in default net ns.

> Jason

Maybe I missed the user ns conclusion in discussing net ns enforcement.

So let me summarize my understanding:

1. In uobject creation syscall, I will add the check current->nsproxy->net-=
>user_ns capability using ns_capable().
And we don't hold any reference for user ns.
This will be only done for the selected objects who need cap enforcement.
Can we proceed with this for user ns cap enforcement?

2. For net ns protection in exclusive mode, few enforcements to be done for=
=20
ib device modify_qp, sysfs, gid query. This will be a separate, unrelated p=
atch(es) to user ns.

3. Do not enforce things in shared net ns mode.

For #1 and #2, will send two different patch set.

Does this path look ok?

