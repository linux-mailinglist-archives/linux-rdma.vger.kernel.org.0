Return-Path: <linux-rdma+bounces-9611-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D20A947E0
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4722516DE90
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7091EA7D6;
	Sun, 20 Apr 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q0wEtefY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF832262A6;
	Sun, 20 Apr 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745152245; cv=fail; b=HDDaypH3F/dtOskONdOUrus9Ih9+Y+7ejMSb7h66vXVFD8RBzA9mxSD/sYOWhNMfJjwHEue8KEtQ3SpfaXDHcCc9E9fg9jCFa+3DKceOiRRJ2hWNhBYCMX2KCsHyTclWPLdOeA/SRGKaDVHnO0KaA85ud96LP8ItokKmt2z47No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745152245; c=relaxed/simple;
	bh=cvDvQOAwiDdUJouCuwQ5O2ucJV6fKREBqu+lPU9G1NA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pLlD12nTPhnp18UkgqHI+MIjMv9fsI6BStEHfdJjtQenKtywHYnE6aJi5gdrwCs/Fnt6myI0SqQzXjvz+HFFUqzYTC6rni1L9deoL6fvDcP3tv8gNQD1jghd5bD77lRaSPwGmJqLBLo2MXbdOhzZr+ZhcpqZ8ZhAnAqNodfj1lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q0wEtefY; arc=fail smtp.client-ip=40.107.102.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyRt833UX74VC8Wu1F2xNp/mn903PJlwIciQFLAiblNULx/8aF3GBjWA1qlflDh7rVTGs9KkJ5fndDTycA7sOWJWjX7BYFRAAvIEo60hBn3i0B3CgO248AZgF7VD/kFFxJjrctsGuzEapye6awjjZF0JzqVHiePU427V0XF0nKdRE3q0aaDN4DyVEAHubro0vq+NBUjQ6mvez/JA3gD1Gl9L+aASON8LzP5nKhZVc1n6JTHrBZEJASAXqqbFL+kOZrwcPY+a9gAK7sba736BmrpnLXJHEBLDgd04clbjVN6RKFHui3sANu3U3FDgBNbhvJ96YVxW9f6TwNMUQJMF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1PFYFY0hqjfItfqc3XpQr41LBZoxkaNT7qB6lHrukk=;
 b=zIloR/jkfbjzsNoUlCCKVtxSYnXeq43O2v21G1F23ibMYc3TzxVRxt2QEQsmlzI9Ly4u2RCayiaR8c/mZKdZhMuJOrT9K1IblxiuvB9VO2MxRj/6byoDyFWhcZ89yeWr2rnN0kihd5teaPr9iQpJmw6l3q0KTjkanX/juBMqyzLZjnIdcSI823hnrD1yyADQtKhEXOsq1wlkrmKla9VhlENUSWUW9LHZVIHR5ltrASAb4++iv8u4KJ4BLfX+LpT4GeRvZCuP1QxlfhequI9qmJLrs0QoT6ZTgJewdoyu09UxjvQEduAgaFnLLkQGNievsN1fsi+FoAZ6/ReEEOziPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1PFYFY0hqjfItfqc3XpQr41LBZoxkaNT7qB6lHrukk=;
 b=q0wEtefYxWaHbzzvyZNRynB5JLslWLYvPuxe1cdxwRtdEH8BJ84eDCVOs+WYQfBRMayM6Du+zkTOnfN3E4Nx0wFqxyATmPbQfBTxqxInzyuol2mWCjjPcskbrZ7R9AKtgonukIU9GsXSQ07pTR+T++WnIBfp/c68qLjif9it3SENy6KXK4bChF8SXmyxT66/sgVNGXUD343jwg9CqZKzS2XoQtoPG7WSx0n7hGyEYae4YwOZsgGAeNFkOlFtlyOFK7BFHLZJs7XdHJwVcQrrus2wprN51mcLqM4APlVI0XZDnx4JWDhBokFSwR77aHwwKWzKsPfrNbxxmzO+7rHAbQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Sun, 20 Apr
 2025 12:30:37 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%6]) with mapi id 15.20.8655.024; Sun, 20 Apr 2025
 12:30:37 +0000
From: Parav Pandit <parav@nvidia.com>
To: "sergeh@kernel.org" <sergeh@kernel.org>
CC: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAAC8yAgAMUPoCAAV/nEIAAO08AgBRFfBA=
Date: Sun, 20 Apr 2025 12:30:37 +0000
Message-ID:
 <CY8PR12MB7195E57FD82E93DB34976CA0DCB92@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250318112049.GC9311@nvidia.com>
 <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
 <20250318225709.GC9311@nvidia.com>
 <CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250404151347.GC1336818@nvidia.com>
 <20250406141501.GA481691@mail.hallyn.com>
 <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z_PlWIj3N2L6nPaD@lei>
In-Reply-To: <Z_PlWIj3N2L6nPaD@lei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH7PR12MB8055:EE_
x-ms-office365-filtering-correlation-id: 6b00cd97-e68f-4abd-4e44-08dd800727a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xP9vN67b6eAKkC86VEvcibkPqtIE6US0s4RSq7qvtZr6JhIroZPrRNVeJvd5?=
 =?us-ascii?Q?yYgDe1ZdijSx6SIMdgqLq0LH4FnZfnbnGg2PG2grMDOBpskRIjTRBWFnyDa6?=
 =?us-ascii?Q?17GtvnoAWR91zuxo/5KrmAIqBrz8jpwjAwUwnCoV4y5Fp43kjQ0BEJpAJRp6?=
 =?us-ascii?Q?AwmG49AFUoAVYLS6EMcS1+Zdj0XKANXtDM4LWwjFH1Y94QDIEaPykgRao7qQ?=
 =?us-ascii?Q?h+IOm6y79zxBqChqSmwwP0cB0/LDMWZwYQZSWllZGyNYKtHCE6UprlpRuWPb?=
 =?us-ascii?Q?trQTzDxQ14nLZUnNV314RJViW2BFWIjBmOQ4TEV62QGdvtvhcZvlZlNGr0se?=
 =?us-ascii?Q?Z1+MgzOqLCoWJqDlzfAs7Omu5C8jK5rB5lGUeaXpFLVMNsddf+H8mUXvgXJY?=
 =?us-ascii?Q?cGck52ErJA5hXlZcbzuXONuLfD4KA+Y7zPFSldjvywYUcEqHbl/m8j17sbPc?=
 =?us-ascii?Q?XHHwYK43BJkqNJss39P6tXAy0mYbJgt5vGYSlNrGr7gc7zNZZGWo9Pm/8J4J?=
 =?us-ascii?Q?sFmIey7Ds63s0ix8B9qpftHWcreejSrsMQAHcBxMB3UZwsiPGdAxXAGw7/wY?=
 =?us-ascii?Q?VrmEAZHoGynkHburD1uyel/sgdP2A3KQJfW/hG9FwDGP859NB9VBFEsN+Dug?=
 =?us-ascii?Q?xpqgoSWah0nYtdgHo/zjBjgRcf6xIfyXjQYVvvTD9wLc1JLL4p478folC8TO?=
 =?us-ascii?Q?urrFOPHzrICnYYOfisbA5dj2+xvhseiF2ORIZfqv/1qCPCrKEskuEGqr09RM?=
 =?us-ascii?Q?EOjxhk5G+xCact/JYHtu7/bRhvKUUCY7RWwjvjuSPAz+cQ+GAO6wfBaGwZ8M?=
 =?us-ascii?Q?aCJvTwdhYjCo7O9JCdDdiMF6xP3dckNUaWtVbPdqYsqqSrs4iZm73IwaGCTz?=
 =?us-ascii?Q?8SF+e4hZbF7YrOCMcV1hAylE/YlfBTk38wZiERq4DTdm0VXoM2Xt9XRaKT+G?=
 =?us-ascii?Q?xsS9PVfissVeY3fOwwoS0iUQ394pY5pGopdzozVuxf5TAK4GwtRznMw+xY8W?=
 =?us-ascii?Q?ZFWgOT3wFA04cpOS1+QXH/vDdIuO1Jy3OMcdHD+6UW7y6gntKZdERfmvOKrn?=
 =?us-ascii?Q?mfaudO88Y8DOkqPpgsNvBZg8FUIKeTqk0/NxwwOapjNUU6JKVeyFvmItwW8X?=
 =?us-ascii?Q?qu9blq9nWLyt15VqSb4Q7iJK+yedGWMStlEqSEGsnMyMnrAlqQJvFMufysh1?=
 =?us-ascii?Q?yWe2MXsTpA6MhUZzYdp4GryJ+BRYgZzyquagUjzt8oeBcGQ9PJZ4O4qE3AxX?=
 =?us-ascii?Q?JbSL7Qh8/vGlQSapTvuMxzKx6kVcmGLi93/thLnYW2QNB95IoKNthCETDxoy?=
 =?us-ascii?Q?oQ9IxQqk0KCJwVSpIBBiHdFassCdywKEMvdNxqhie+r9C+dtxTGROmaumhU5?=
 =?us-ascii?Q?ByIGPFdGz/6ksuIzYZaOPBYa+WBSrS+n9BSmWtQdqphG6dDtakBFPCC+hsOT?=
 =?us-ascii?Q?X1qPFswPaqQ1KHR266vMtMuwgkw9JfWc9M8uiZD/8LMz+8oc2OX1XinOtwHu?=
 =?us-ascii?Q?CtrIsw1QvjT9QeY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gh3AlSCDA98K7secM+oqCiBtlLjL3Dg9kEseNQi4jviPA79oEuukV5qc9YRA?=
 =?us-ascii?Q?kIBktF9+dHoYXyJ5FKs/N6L7bfNFC/9iky+5ZcawfaJ6pJ+plstCjNB5YRzo?=
 =?us-ascii?Q?z7JaRIWTKeV//FirJEfYjNNYwxlymEBSkuBDGh30a+aBk2BR+Oxrrp1Y61E5?=
 =?us-ascii?Q?9KrUkx4VjOT/v+dTvOrWLX4ishdIPyajHYMByapGUmCA9aKEXA+8iBO5DBiP?=
 =?us-ascii?Q?zuAkFlhBydVG9vMl1H3EiEIkkqDi972oYnR8fEvVkyL5sjZ639hdV9gzsL7d?=
 =?us-ascii?Q?uWkBgEajH9wA5rg/QwQaNYkzU2GXzGQXvVT2YyvUzxULUrVp/WBGETIJYvVP?=
 =?us-ascii?Q?AFe34Mxx+lXZMVptoqPMjYiHYuhL73x/H9vXexc8xsd88+i2TILyXCDpvG2G?=
 =?us-ascii?Q?e4zU1N1vQzxfDFXm59+3nFqsb4Dy50RMGc7G4ZmRjdZB+8Ln/uSU7wiQRJ9z?=
 =?us-ascii?Q?xHmB5BSoLFjnA9SWMCClatWFYIt7r2VegeZpypKwkKaMUU+KQOodvN/19FQC?=
 =?us-ascii?Q?t3OUXqY+PC+81vjNWwKDpWg8ErqRkjKVg/yI/sxMos701ZAHDeIai/wDm1CL?=
 =?us-ascii?Q?1QQ8xB3PWNRWDYRlG33s0VTsgifhSKRp387WbsHV87nTMlTx361Cklj0kMWI?=
 =?us-ascii?Q?e0EaWmyviKz9i656rF/q4MChQLCQsbGMRY7EVxzc3k8RmjU9kIZSff7v9Vmq?=
 =?us-ascii?Q?kHTqYhl1/6UU8swOf0torj3GtSfYke9ZxT+09JlT3EJ9Wi3WkYgp+IDZt1UB?=
 =?us-ascii?Q?k+wzOVBnGrc6CP/qfW7+9gYLpFodL9UbxU36oDcphwf3P/oKjOXU63XciUpV?=
 =?us-ascii?Q?R4w+iw+df0KtyLjc4MFZJ2kA5loQ/ZOw+vAZaTVBvKX9FBcxi8him9Br3fqn?=
 =?us-ascii?Q?mLqgkD6EqO8GgcwGiaF9j+hpf0jkw94kQPHywa/7twg8YFMw3KyCzd04P8Mh?=
 =?us-ascii?Q?Xq8IfOYs55JktlnZNJcZY0N8O1FQtMPpJzTN2mVVBFOmjQ+nKUQHJq3S3ik7?=
 =?us-ascii?Q?XIukpgVCaUwi2dJhBFrVKOjCNs4ClmrO+KsxXnxjLGXav0X5YeakuN77DV+h?=
 =?us-ascii?Q?d7IOO5+rsMMc85jWP/f3KUfzUQXPukwmrSzKm5/xIXAZoKr7CjJRGNouC7AV?=
 =?us-ascii?Q?xp89tiCYa7Y/q/Uueb9+cTpZRcHXKwPRxEeZYIlMQkG+IE0YXQcyiALwqM7L?=
 =?us-ascii?Q?gUIbubke0D/apnd/4papxj9QtDT8xm3E+B8bzdrrxuzUeLemnOrQKRdOlrO0?=
 =?us-ascii?Q?Oea0uSHt2W1nYQ23VvLG1msMw5I6D5XKIdIQxN011LuV7iLWTRymFIFE67kD?=
 =?us-ascii?Q?7idwyD2TFlxXL+hAtCfBL/8XsriAbI+vAlRRF97FR7/QIkEJtnkNmOA3hSU8?=
 =?us-ascii?Q?iRQkfzaZ1kvfl12oYLM4UaV5xxe3VB4a6wctAm3CbeqL9Md9I2v7prFkiW6s?=
 =?us-ascii?Q?Ia/XfRdOdwvk9q71pUjFfLNqiJSn8gliC1nj0VaQaKLI9QhkrFrPEr6Mywqo?=
 =?us-ascii?Q?0MxETg39JAgWx9029p8Fqy8tfEng1hCdrU0pFS/8G5iFnryBksqZVfF2shgy?=
 =?us-ascii?Q?Xvc3D9EjjlKME9MnGv/TGcvPF0ZLEXFi0I/RwUTyIx2ifWu5/Ob7GfjfaVSi?=
 =?us-ascii?Q?SIEilNUC49F9yc/X/TfBpwt9t+i+TgYiXST8Qz0yCZ6P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b00cd97-e68f-4abd-4e44-08dd800727a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2025 12:30:37.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEUZJD5zv4AW9mPIycwDW3l8PUz/KjVroCVJmwbjJdURY+hCi4HkIGKqkmHwzgzapHJHjpD75l6oxPhsEjPxzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055



> From: sergeh@kernel.org <sergeh@kernel.org>
> Sent: Monday, April 7, 2025 8:17 PM
>=20
> On Mon, Apr 07, 2025 at 11:16:35AM +0000, Parav Pandit wrote:
> > > From: Serge E. Hallyn <serge@hallyn.com>
> > > Sent: Sunday, April 6, 2025 7:45 PM
> > >
> > > On Fri, Apr 04, 2025 at 12:13:47PM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Apr 04, 2025 at 02:53:30PM +0000, Parav Pandit wrote:
> > > > > To summarize,
> > > > >
> > > > > 1. A process can open an RDMA resource (such as a raw QP, raw
> > > > > flow entry, or similar 'raw' resource) through the fd using
> > > > > ioctl(), if it has the
> > > appropriate capability, which in this case is CAP_NET_RAW.
> > > > > This is similar to a process that opens a raw socket.
> > > > >
> > > > > 2. Given that RDMA uses ioctl() for resource creation, there
> > > > > isn't a security concern surrounding the read()/write() system ca=
lls.
> > > > >
> > > > > 3. If process A, which does not have CAP_NET_RAW, passes the
> > > > > opened fd to another privileged process B, which has
> > > > > CAP_NET_RAW, process B
> > > can open the raw RDMA resource.
> > > > > This is still within the kernel-defined security boundary,
> > > > > similar to a raw
> > > socket.
> > > > >
> > > > > 4. If process A, which has the CAP_NET_RAW capability, passes
> > > > > the file
> > > descriptor to Process B, which does not have CAP_NET_RAW, Process B
> > > will not be able to open the raw RDMA resource.
> > > > >
> > > > > Do we agree on this Eric?
> > > >
> > > > This is our model, I consider it uAPI, so I don't belive we can
> > > > change it without an extreme reason..
> > > >
> > > > > 5. the process's capability check should be done in the right
> > > > > user
> > > namespace.
> > > > > (instead of current in default user ns).
> > > > > The right user namespace is the one which created the net namespa=
ce.
> > > > > This is because rdma networking resources are governed by the
> > > > > net
> > > namespace.
> > > >
> > > > This all makes my head hurt. The right user namespace is the one
> > > > that is currently active for the invoking process, I couldn't
> > > > understand why we have net namespaces refer to user namespaces :\
> > >
> > > A user at any time can create a new user namespace, without creating
> > > a new network namespace, and have privilege in that user namespace,
> > > over resources owned by the user namespace.
> > >
> >
> > > So if a user can create a new user namespace, then say "hey I have
> > > CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
> > > resources belonging to my current_net_ns", that's a problem.
> > >
> > > So that's why the check should be ns_capable(device->net->user-ns,
> > > CAP_NET_ADMIN) and not ns_capable(current_user_ns,
> CAP_NET_ADMIN).
> > >
> > Given the check is of the process (and hence user and net ns) and not
> > of the rdma device itself, Shouldn't we just check,
> >
> > ns_capable(current->nsproxy->user_ns, ...)
> >
> > This ensures current network namespace's owning user ns is consulted.
>=20
> No, it does not.  If I do
>=20
> unshare -U
>=20
> then current->nsproxy->user_ns is not my current network namespace's
> owning user ns.
>
It should be current->nsproxy->net->user_ns.
This ensures that it is always current network namespace's owning user ns i=
s considered.
Right?

Sorry for the late response.
I wasn't well for few days followed by backlog.
=20
> -serge


