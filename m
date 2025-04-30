Return-Path: <linux-rdma+bounces-9936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53AFAA4ACC
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 14:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B6F981B32
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C221E8338;
	Wed, 30 Apr 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LT+NdPYm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184841EA7CF;
	Wed, 30 Apr 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015252; cv=fail; b=YkF4VIo/C5ANLXmaD7I1l3O35mBsnIDphvXaI2Eut0ff0ks/u3TV3ABQrgaGYUzEGc8trqV+O8hkyVOzrnHKZGWvf+6Vplpd+epsZ9tcoCwUUa8uo/4Y24JGhwEPshWRfyN7FP+LO69Y99RkTWq+nPz5vlkIEZpq06kx57g8muM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015252; c=relaxed/simple;
	bh=8NQh924MV3+zRaYs+WYpDoLyFXE+zIRFCeYU4m8lmAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RVUqJMI1nKZotyWGF/czLbQkMix6T/cQZggZOFFEMMETMdR9uENLfa+O69coEaLnaXWtQ6dGIMkO3dLNw+EL+SuNSKpyHj/vLIer99DS9ltRxLDyEcmKTL9w74o9ACx6QqS/dg9RjahqHCF7MwCUlevZGSV+GpH5fhUImx2RalU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LT+NdPYm; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnnWOVnjwMdXEa4+qX36kjnOaGtyOkUxNA9FCe0UrqQlTXdq52wTraJK1On4tmhiAARbJOQ8nGqPUjG2Nkq2uWMqssftx1BPEQtTIy3GGaWYSPnT91zPvMRwZ4GdKJkgX0SsS1OR9h1WpmsUK2Kn1CHR6CIRCnTT70Inc1tG9Ia2IuByWCnzfa51s0oQjI6iB8ELe0bawy2sdhm0uuAYU1GZ40AbbkKyNkSGJeGyN0TgJcmmmS5YgnLL4Dx0UbmFTfomDyOehXtAJH9jr+RHPLLPwcCflbNfFf47vZh8R5Sm2/FCQXMaLP00SNHGV5tmNRwApfDOhvvxho+gwoldFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+Bv6oayg/E2+Ziq28RHLzSWw973A4HlcWnIKJmmCAQ=;
 b=emJ5VV7PyUTPJuvjB64Bz9yWViSnLl9g7gGYlNgoOVSLB0eWW0V7ck25DTg/oirBB8vHS03Py6h1gwAVP9NtBK7DK0w79+c3gm5Ai3fKNX/wNmA4KT2V07LLBXjVQvv9Llw2CglvpL9eHfHQt0Y26nR57UQWBp9NySN0ANUr/BfND+LE58lm9p5scKL1cw6A7c14/AfVGVcasnqcyWvIab49nv+4Y6RzjwKHCb9GrWaLh0ksJGHAR+tGekNZEKK3ygyFO9Y1WDxRFYJbHxCJ+oQFZwMOGPBAm97JfMAAIDG+McCGvdmolDw8NT+7YJPrj2TSH49Ohy/aaoNSjpCsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+Bv6oayg/E2+Ziq28RHLzSWw973A4HlcWnIKJmmCAQ=;
 b=LT+NdPYmyIvDQBFvGttyh5MleOIoFTsTl6f7ZMUVVOhK255K7OD9Nm3DA8z2CY1BU57s2B5eYSq9pQtMusie8UeIszjZX0w5eq/yMIlZiPVFcldzpwGCliOpIkG3wDvpsBldlz48idzCCklg7mm8hGKkU3/358ByqBvm2nDPPgidjo2HeLa9rT3uAFKZ+8Xn8VOLlYIDRsKO8pVdOrjCh7Qai+iGkRR6iitq3C9BQhBdgBxf6R7LD8CXXyvZt2cqNjV925TxMM73nUUdYj+MbL2wVX3+/7xVI6bJ6Fek5ZN+JMahJ0wQs9uk0ZeThu2STlcxsDurSq+WSNiwbpo+Hg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 12:14:07 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 12:14:07 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Serge E. Hallyn" <serge@hallyn.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAACQIAgAAGW4CAABMnHIAADWkAgAAUtxWAABDagIAEnY+TgAEi6ZCAAR+mZIAAjhEQ
Date: Wed, 30 Apr 2025 12:14:07 +0000
Message-ID:
 <CY8PR12MB7195FA1FCB7A02EF0217A669DC832@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<87h62ci7ec.fsf@email.froward.int.ebiederm.org>
	<20250425162102.GA2012301@nvidia.com>
	<875xisf8ma.fsf@email.froward.int.ebiederm.org>
	<20250425183529.GB2012301@nvidia.com>
	<87tt68cj64.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB7195855B870B5D00EACFDC79DC802@CY8PR12MB7195.namprd12.prod.outlook.com>
 <874iy6b9v2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <874iy6b9v2.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|BY5PR12MB4164:EE_
x-ms-office365-filtering-correlation-id: ab2e952e-ad93-4aec-81a0-08dd87e081d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kQ1+aOasprR1m3od7hRxEjQwZNQt44LyzIL8jHuYW6rqj78B5mqwECVet/OV?=
 =?us-ascii?Q?3Nzdi9LyGKjH9PcWJtfrMfuCJTEkgRebGjnJ+kD5Y7To/s1Ii5Z0mWfuQAc3?=
 =?us-ascii?Q?sv/BzXodaxmIHTfvRroWZTIXIzUuHDAKQFF+e3tnEEG1QS90RMeUKBv2t8cn?=
 =?us-ascii?Q?BKCcAKTcd8TJIdgsHN3AeHJsRues1/1vnuLViC06NXHREOjAHROMEazfOpDD?=
 =?us-ascii?Q?93bHQj9jHQq+/3EmLEIfJkcb5mh8mosckumV9xs4QFUEqxNYcd43phx2gesM?=
 =?us-ascii?Q?RT0NCyIdsXGHkTHkLqDcn1FK5ciywKkH7MW8SQMYsiTEEnmhy3YEJLo70J7x?=
 =?us-ascii?Q?7zi8VtgrrB5BdAYZvT8/jsMYagHCTGHsc1TnRQuYzsxLSz5NG0pUfTCULBBP?=
 =?us-ascii?Q?hJfslTIKVZjUgvTQAsuNlax0N8cVJ7oXxgIBagor7nhcqrTNaIno7PxK4Fuv?=
 =?us-ascii?Q?gn26mHItNo6ga7228h5C5dcZPD5DxyE/N7Ev6mgWAQzlqnCrrhbSa5PHioCM?=
 =?us-ascii?Q?qccrxq5SQjp6n+N+a7c/I8dEgPBuLj865gsDwfGzW4bZICVFfPpMTVuHQAiO?=
 =?us-ascii?Q?E4egzC/BMW620z1ln7/ICOTMFATAeTHKP8RzvKsj96b56Ex2mFgGjl5tBiZl?=
 =?us-ascii?Q?UnEXOOu51Lv9wNnf+aoAlQIv8J04mphCfR7HrMNCKOLeYA7+amiYp4CfWGWt?=
 =?us-ascii?Q?KgZQyc4pCFTiFX+vOm5xkS/2SdfqYEAeYtWARTtyvOZsDpV8OYwzCQEl95Oi?=
 =?us-ascii?Q?mNbSyRgXRj75J6j1Bps6v2j5xGgBMqBHRtgV7lpSonHRaUDqIxCIL2D8KXuv?=
 =?us-ascii?Q?5G7ecUcNTs1L2M9Y0bW1N1qvajechW0Th7yM9C2VVVQmQvaIwrPZ/cBGmezS?=
 =?us-ascii?Q?1ILa5LW81PZ60g2pyu9XZ/yLVGkOrHQa37JDF6ltHXH8L3LWZAVMsmECL3+9?=
 =?us-ascii?Q?GnMS9ASUSp9B3n74vN4orjfIySRxc1s6hiMonnibhb2b02D3tTR9v+/Qbncw?=
 =?us-ascii?Q?13jL4Sj6WD4d3Oqs6dIzONnemg1irl9hjnMsyOfhPUsWpq4iDRXVERrCGK5f?=
 =?us-ascii?Q?up4OJ6sOP2zMJh2J2FdDd9enWymFi5zdJRs//YZsK4oy9hlCcrYEQUtS8eaa?=
 =?us-ascii?Q?R5/VKbADE8/7LPsroeHwQw7MiqtJofaVM7anjObrNMXtvX0ZaGUGxz2NtwT9?=
 =?us-ascii?Q?NbH3iTNbbs/oIvB5ikjHi/Mzuh+kZwFiriHQ1DOWgN5wt5VwJgBzU2OG49Pd?=
 =?us-ascii?Q?FX0KB7LVBkFOv6V82PtpGPB08VXjQ8fQPZLjOJisiTjMtJcLr18uX8cg18gF?=
 =?us-ascii?Q?sPTNKSCC8gcrZhi8XZ7s7deL8tffFQtTQVrGl/se/coUxXnftUiXKeLE4CJv?=
 =?us-ascii?Q?6CGVAX6qBHVJTAhGhHR6wbkFu12I4NpbKSVxCKNZVzy7M9r1gvT2zoyK+Oy+?=
 =?us-ascii?Q?5PL6GaD1z/xT34h7stLGQ0rTeGt91AKFvdo5f6TxQEfcs9bxqy7DcbikCbXy?=
 =?us-ascii?Q?92SwZWj7zBLj/80=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mLzal2udNzdk/R4CdBMuUj+wR+dSjRiNK9/AbrUUgT9VTocJ09S6VhHdldh1?=
 =?us-ascii?Q?GODeecFdHujd43JWNU1ZkIHaqbQZOSz1Te6tTnP6FRvojyBO6eZeDo6pVdK7?=
 =?us-ascii?Q?MhRVJGFT718NOgKkD7Ik6QzTjOr5hRi2BmT/Qazm7e47p3kRg+GKJcJ9zmJx?=
 =?us-ascii?Q?MamOdKTGIA9+m8oHeavJNuDXnftA+glphRhS5BqOcbjtrTZU7O9USjhxqP30?=
 =?us-ascii?Q?Qc5dFHji0PNPvRdReViPDXMvYBVLctQ0k9Ugqh1VoJAJEnj+y3KPSRLDaFiK?=
 =?us-ascii?Q?IPMB14Fwe4UqNZ9EjI8aoQiAr7usyiOcouTI2JRCshY9A5j87mDOotW5zrAk?=
 =?us-ascii?Q?lGDcJ1cALlzPS8CEYJ8Ek05JUOV8ofllVTSYe1kXf2JRVkd/tR4AAZBwnmCs?=
 =?us-ascii?Q?wUb9nXyJBWrZmF22ZKaCk/uQ83wmi8/Q0nsP0MTWfCpDSlbyoWby/Yo1q5hq?=
 =?us-ascii?Q?X6QVUXocNgcWCP8yK2JNmvPydAMyTXJI/2AtYGnBtX0+lIXnOf2eh1qUxQyd?=
 =?us-ascii?Q?JwPVeXUgPQ4reBMx3hURC42XVXasesoziW0PfbRkX94KVz+tz7OFTFUmR8GI?=
 =?us-ascii?Q?ddQr5PV08vp6J40qDKJBMqw9x6DZdkbCW0qWIqcRlYCsfFIva4NdiSPDgLHL?=
 =?us-ascii?Q?vrFD+eVifVtX5Bn53E3eizDVdC75x9lPk0kCijhLxzL2xpN3kTtGQDXpDF1n?=
 =?us-ascii?Q?F3MVYoOXCxD/JqVogRe/FPoaK3yI6xGHk93eH5jj7NMqDPumfF8jUXicnFZW?=
 =?us-ascii?Q?WAUuTgrxuMQSK+U0bg/PVb08pZrPEh+LkePt3K+4xauNLlhA1mRYn7c8MG8O?=
 =?us-ascii?Q?OkSBsrQ/bAqTg423G2RxVchZc86CjNOBub5ZUBm68Aojcz+w9cy9hYZSIU5H?=
 =?us-ascii?Q?93z06zt0Nvu70vL18Su0N8ebUSWCCPW4m8LGK7f7PpxBXiFtOB0wR0FqUn6L?=
 =?us-ascii?Q?h9x0U+PyZJ9RGPn1lP8mBtLP9mhZy5vgJFlV9Sy8QooHDMML03P8ow+fDVgH?=
 =?us-ascii?Q?LNKUSkcv4xzquGmKHCI9oLqxE+Ds14UqwBAUTVqVnnoChpwROJ12/0/r+w6G?=
 =?us-ascii?Q?EfxMwskJj5xn4YhpDARqfZ4Ihu0vjLz6NJG8/jfmztkKYp51adBxHBt46Mo5?=
 =?us-ascii?Q?/vufVA7K3udqsYNISz1wXzSMrU0g/eYZFd5mivEyr5ZbkrBVV6T6FrVj9RIa?=
 =?us-ascii?Q?iP8OtRsXMvtxWO9gZG1uY/kt3DXqElTts3pPWo6CJhu+j5rY/D2EdEudCjc9?=
 =?us-ascii?Q?TgNIJit+1MVoGR05FUwVyElMAMQM7vlPqKkGXvrnBNxaTnTIsUMhuw7kUqkx?=
 =?us-ascii?Q?uoCR7ilv27mAIZKOBxm3OEXxQOqI3jsilQPgJGvpFXEfx74eFmjHQcdWnjha?=
 =?us-ascii?Q?RAuDcVKY2wrBl69MxPQ6T8Nf+J/+3X4YF/NgLm6B7ulEsmFexNCA6KOkP3CM?=
 =?us-ascii?Q?95cDrGmriWwCUwKDPXVJ0MQsONro5FSq/G0P3tpIL0sVj5gdgKKSSlyKkaAR?=
 =?us-ascii?Q?Cyia0/s86GWsshEZMGRK4A8z0ETJRCf01TyQHDme2auIIZwYIEzAILP2JbhZ?=
 =?us-ascii?Q?Uw+IwOoJ6+JLEuj3Hf8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2e952e-ad93-4aec-81a0-08dd87e081d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:14:07.6279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2MvDMnJKewJMJ2zVXyONiywXIKeFkvKZ9TFH09UIHkjWKTUdSQ5vOG8MerrVrm/Z8HweXK+/mbb9BJz08SuUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164


> From: Eric W. Biederman <ebiederm@xmission.com>
> Sent: Wednesday, April 30, 2025 9:05 AM
>=20
> Parav Pandit <parav@nvidia.com> writes:
>=20
> >> From: Eric W. Biederman <ebiederm@xmission.com>
> >> Sent: Monday, April 28, 2025 10:34 PM
> >
> > [..]
> >> > I said "user_ns of the netns"?  Credentials of the process is
> >> > something else?
> >>
> >> Exactly the credentials of the a process are not:
> >> 	current->nsproxy->net_ns->user_ns;  /* Not this */
> >>
> >> The credentials of a process are:
> >> 	current->cred;  /* This */
> >>
> >> With current->cred->user_ns the current processes user namespace.
> >>
> > I am confused with your above response.
> > In response [1], you described that net ns is the resource, hence
> > resource's user namespace is considered.
> > And your response [1] also aligns to existing code of [2] and many simi=
lar
> conversions done by your commit 276996fda0f33.
> >
> > [1]
> > https://lore.kernel.org/linux-rdma/87ikmnd3j6.fsf@email.froward.int.eb
> > iederm.org/T/#me5983d8248de0ff9670644c57d71009debaedd6f
> > [2]
> > https://elixir.bootlin.com/linux/v6.14.3/source/net/ipv4/af_inet.c#L31
> > 4
> >
> > So in infiniband, when I replace existing capable() with ns_capable(),
> > shouldn't I use current->nsproxy->net_ns->user_ns following [1] and
> > [2], because for infiniband too, the resource is net namespace.
>=20
> Almost.
>=20
> It is true that current->nsproxy->net_ns matches ib_device->net_ns at ope=
n
> time, but those permission checks don't happen at open time.
>=20
> After open time you want ib_device->net_ns.  Not
> current->nsproxy->net_ns.
>=20
> At which point your ns_capable call will look something like:
>=20
> 	ns_capable(ib_device->net_ns->user_ns, CAP_NET_RAW);
>=20
> That ns_capable call will then check
>=20
> ib_device->net_ns->user_ns against
> current->cred->user_ns.
>=20
> And it will verify that CAP_NET_RAW is in
> current->cred->cap_effect.
>=20
> Thus checking the resource (the ib_device) against the current process's
> credentials.
>=20
> ----
>=20
> The danger of using current->nsproxy->net_ns->user ns after open time is =
the
> caller may have done.
>=20
> unshare(CLONE_NEWUSER);
> unshare(CLONE_NEWNET);
>=20
> At which point
> "ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW)"
> is guaranteed to be true.
>=20
> But it isn't meaningful because there are be no ib_devices in that networ=
k
> namespace.
>
True, but the resource was net namespace and not the ib device.
The capability is of the network namespace that is checked against.

But I think I can ib_device check as well.

> ----
>=20
> Because of the shared device stuff a relaxed permission check would actua=
lly
> need to look more like.
>=20
> 	struct user_ns *user_ns =3D shared ? &init_user_ns : ib_device->net_ns-
> >user_ns;
>         ns_capable(user_ns, CAP_NET_RAW);
>=20
> This allows sharing the capable call for better maintenance but only rela=
xing
> the permission check for the other cases.
>
Yes, this was the plan.

Thanks a lot for the guidance. If no further comments, I will send out v1 a=
dopting above suggestions.
=20
> Eric
>=20


