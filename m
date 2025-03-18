Return-Path: <linux-rdma+bounces-8765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AEA667B5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 04:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376C3BE7C1
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 03:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE81A8F8A;
	Tue, 18 Mar 2025 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pNbCOzx1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B321A3A8D;
	Tue, 18 Mar 2025 03:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269393; cv=fail; b=CHDTNTlRlrqryyZB9XSZ+o9oS3UhaoObMIBODhfl18D+otqk/fnlI/IAvfI8bSRp73ZIWRg34xJoAM8y/M2EgIA2lG+qvECTByqzkLq7/REpDJ7ct6JlX7d5PJTG4aEh9oefsBdAesg/uENc4ZB89Gz0l7JD3zgHqDCroG4LdEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269393; c=relaxed/simple;
	bh=aOashsPcujbFsystbkpFG1Fct0VSFMhqtn7CoUI/BQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hpmg+qAdJUVwRl9eZUvDdoDOIfCS6SaIN5gIo0DuIzE670WJNxTDKM0/cYXqU93/pxlveMOf/2kytL28BZeuraeuoTonfq3hZZBQNd9E9sjfOux80dL/Xj5V03d3DEBm0YcWwg8pIIb7HGbLJQLBn/F4tBxO+0lCrXg8nxxgDa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pNbCOzx1; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP1voXKUH0mwyMVor6t79VF+6kcsakLWwLrJ+s7zgBmdaPacF0k0QMdsLju0y5AneFIdEU8V5+PR2v09VklMAko1mx6ErwfGDCSCnvp0YQHmPkhSizfqHA43H6tI70gnrYIMHWL1czTTOCxDae2WjbDNSPQIoX0omw+dZr3DbTD1NXexNdzGS9uJci7lOM8ymopcBvgrd7QsMsJx6NHRKij9SbWx4QWllo6Q4UGLx2H6s11jUqkb9snpZOVmd7DzC8c7zYWc0kyio+lWtXOopRzW1xKn6s8ghdllClZabSYlUEhfhNU0ju7qp1MXquWjxc2CqfDIvBZp69CDBLvRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOashsPcujbFsystbkpFG1Fct0VSFMhqtn7CoUI/BQg=;
 b=QNc1ddA8hF1sqHojsJ//KRQ2gRYXxl1pdUnLa16+3kHq61gcSj/qfeEveH0V1LX+0YebaU5qGKgWQ7sF0DGJll/tsZ/TI0XTtbUVfDUqEmUFH+pBrb7FcQivuRVga+ej94uBajyCPn9Ezu2sGHS+EAabmC0adLBgokOwB/Y5b9R7EiVATQz7NC8Lr13Qza8oQ6ZQCOVzP7CH6n9Nb/xnbH49yHAZMLmFgxOUv1exgfR41159+lvJfG3zvbWsyLdKnvVAd0gOkXFFqaOBI1lSnoYnrIQW+zW6XFJ9cehoj+5t8RcskIh7nDgRvZu+Mv+oOkCqHNFBZLgTInCL4fQ8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOashsPcujbFsystbkpFG1Fct0VSFMhqtn7CoUI/BQg=;
 b=pNbCOzx1zr7mXcCu6qE8aljoqFtpCbJk6y3U7THXlE3ynArESLZLlxiih2C9Z8NgN1Rt4vHC1XP5568bTcqexNil5gr/UKNuSLTwjxHYHOqEyLPMsaIi5HI5Yr70zpZbLLw1VJwyT3PFTGEbGCREkpXpxPeZ+MM4net3umSZPf0V0iYrJ4zACVfDGtGOnytypOhIFIjJOcRCwqxP1JdTkE3MuCc8Gv8L3D9axfDNFLDS3H5514/nI+zGEM96ER4tbr+J3MYRvEeupFrbFf8SHGWyIeE7ml7kg2as1o4r7cqAShf58MIG3ubPEfikfLNpe8ip3hLusVC7s+5jr/nIoA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:43:08 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::c06c:905a:63f8:9cd%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:43:08 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, "serge@hallyn.com" <serge@hallyn.com>, Leon
 Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index: AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALA=
Date: Tue, 18 Mar 2025 03:43:07 +0000
Message-ID:
 <CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250313050832.113030-1-parav@nvidia.com>
 <20250317193148.GU9311@nvidia.com>
In-Reply-To: <20250317193148.GU9311@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|IA0PPFB6B4D32F9:EE_
x-ms-office365-filtering-correlation-id: 6b397377-fc06-471f-ab97-08dd65ceff79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zqeOdU5bICxSdGfoyfEUVRhAtV7tfIOJ0vJ32m/VqF1G70h+T4QQcCRf8QUL?=
 =?us-ascii?Q?IauDvd6pksF5jAOyOGgA4UtOMbDVvqx60D9HYBR/WW6dccaFrjjTCVyJb80E?=
 =?us-ascii?Q?AX096KUORO1C6PkIJSDjfgGgnK3dZebcsH9jpV+9hHQ1fH9COU6j9J99fCp7?=
 =?us-ascii?Q?CksUSuw2rcEGDAK4DLtuJ1mn3Ov65QznYlsKtykJ4jbEgGhAtO5p+E652TM9?=
 =?us-ascii?Q?LhxBl14I8wvhYUrDi4z3szK4xKApcckOS2thUhIDTJ061MWKrfMho1uXELiX?=
 =?us-ascii?Q?qZdha5c9xj3YgMAkoDaxKJkRVg+LrOCou/S7XQzyYMLyrXMlHHOTkQuiF4UQ?=
 =?us-ascii?Q?SkXwzGoi76JMnLmBZMK4CdJcwzA98VfkXdHSDKlbQrQ2WBp/N0G4wv4EbrRk?=
 =?us-ascii?Q?y2yDMME48liEoJdUDN8hWB5yPUM3uEkstMTeneIzJ94XfAtWn9eKC6j6oj2f?=
 =?us-ascii?Q?lkXlkZHB3nSeORVspsgIL4EGJoIkxeBHnY21Aoqq2Tz3KIYpSb8k5KlIeVzi?=
 =?us-ascii?Q?LI6f5Icqvo0TIA0cPw3x5vmAUd4c5oI4YTBsuWE3dZXHRqvG6iWf7WDJV9xb?=
 =?us-ascii?Q?SB/uwytj/VGCa3z8XRcFig+oWHU/CcrJtOp7K2+6uU7hNvtONEgW7XIXtGXQ?=
 =?us-ascii?Q?Rp6KA/VinEZGZp/uvkT0ZD7Cebww7LlsAhjQmPxgZTqE8MBUUR4mp3aycYqo?=
 =?us-ascii?Q?6Hp2n9S+j8FaUxyIi2k6dhY43uyTDH5l3JuCVaA6pRjIVg3wu3lJBSmFMdKa?=
 =?us-ascii?Q?K4Pjr3UTlT1+Vv29FdPwC18xX/ZU55gDMMJdwUDdnz+0eLd+xnXd0xD7ofnV?=
 =?us-ascii?Q?DTAp+c+J3230SzCn0nfKPqfXxnW4fvpb0kc83O+TAnrqUmsPlSgY+1C3Hmbh?=
 =?us-ascii?Q?4rojCW/NBK42tlj8ckoV9dU8J9EomQzTvWwqlva1xpOip3/hXOdlxs+Vh7W5?=
 =?us-ascii?Q?4fbH1S1UYXO1++qC65TR8vDpyu0Azga/4nuDPEnm8aCJmVv/oF9UuF3ynb5H?=
 =?us-ascii?Q?jbefKuluoNJYherKmF2nypWxW7pFKZCo2Ot6MfNRzr2e7kdO7Ayi2nLXF8Lu?=
 =?us-ascii?Q?jm1lWXnzTVACGYLk2Ol210M2gDiqG8uTXC5Ooq2hEc02QkO3/ouiimywRG5y?=
 =?us-ascii?Q?Dqlb5Y2IHurmcV5JFFWGM/znZVLa2zPVnLjc/kv95Jsv/xFI1/dIS7QbV4JR?=
 =?us-ascii?Q?DfQucUqqIuhT0HWipQHpjHPAmJ0sWA4MHtP817ZEQf2VD8QqzaXLst2y6XnE?=
 =?us-ascii?Q?OeMjg/774MrZm2H0xDztPgkPEN+OzEBy1WwGZM7yYIcZiXCdIiSitQV8sUGr?=
 =?us-ascii?Q?T0JSUVCXLAoRV3LY/QNnuoWroVAtk4laMWskba/rYyBH4J9g3n64/Wr54FKP?=
 =?us-ascii?Q?yVMfzUJ21LqodMxMfoR1csal+GI32mbf+OZsLWpX92eHD6UGCmev+2Uuz1GP?=
 =?us-ascii?Q?LEIIy1EMcUsFZx51chtSb/n1QGUupxPi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eP+a6SBbl1Fq1YYHhEQjwdGHX17o8QAtTuIbKsLzA87UdTf4lgqTMALXMJRx?=
 =?us-ascii?Q?vuCoZvrCsFvqRe1zgJoZ0F3rwGyuOmrNFLe3ZvTTmIo8QIZ9cfY2mFbq+5mc?=
 =?us-ascii?Q?CG1mX1xssES5+Wi+UdunQ4Tbq1MEW6ig7DcqznqtZBp5rEzGaeClY7AZ6AKC?=
 =?us-ascii?Q?vJcJhjIQvQfW1jWlodiyaOLV8TbHQWZgtriHm2MCIi65KqzPAxnOI8FaOFX4?=
 =?us-ascii?Q?BcTNmn2IxKN4zff7WM2hkDaNmR8aPIRe3l54cNgJorsF9A3KHogfnIuqrNE5?=
 =?us-ascii?Q?8qMZ/KJ2aZPwUx98uRfdUHp8o79I9dWgA29JvUgBn6EsVjdaXG2lN5FeCPfF?=
 =?us-ascii?Q?/UKGRtGn6dPaSzqSFg2T8aZ0kaY4FFYdJOcAAOwlXHAm/zFtee4YiDq8DNpN?=
 =?us-ascii?Q?AUabtLVn9nXyR1exaX0pCge6O6zzFLT5+hkgDb0qZ5/BaTf/0Pe9cRQ5W3i9?=
 =?us-ascii?Q?Z5WW3AuIplbDbEEDxUh6ZvUumJIEh0B5yRaYsx9mLbd8DhFBPFztraTQFw+Q?=
 =?us-ascii?Q?BXlR9UutnUtvk+hXg0O0dCiYLD8bl7O+7+V85RCAs625cDe+xrNOcLUW9X1b?=
 =?us-ascii?Q?foGooo7letgFRCrfYW0uSjIRbaTLrf1N8tY3QFqDrKlQzBMhdZcepr4XX/m/?=
 =?us-ascii?Q?u38ih/vwTMoLRvCskj8MZ/GUlA+xOT0PC2meGWhf/6hv4CyZNU/Tj3vFZZEU?=
 =?us-ascii?Q?aX93tYRSafDFoNv/vZhX7QE5KKhCxzJHv/eBjy3Zk+2YKQfdcnt+vFAqUGGd?=
 =?us-ascii?Q?xWmCmope47MUoOs0buisVmOghplk3iDB/qPuJy+/l9qxAs2HQftTN6UtezdP?=
 =?us-ascii?Q?sTHse2TG3CFnNQrlu9a+rWANDNqS29/AYLop9QyUDV/k65TIHPP8n//MgYuz?=
 =?us-ascii?Q?gB49XFgihmdCliT2aFGbePvoWYOQBKL6GZN2rgciML4ULczsvo24pYksNeZa?=
 =?us-ascii?Q?mPt1ZA6oLwzWTbebIfzi6Pl89yLxrpd9wwuXmI9QtpgkmWyRVYR3vxHxqnAq?=
 =?us-ascii?Q?IaVHw5Oi3ci4ukpoNkD8AoHudev/8/Lj1GAZV8hl9+3fhx3X8geMpFVnmcRU?=
 =?us-ascii?Q?gNYo0cUaWklIwgvlGFnf4STuDxhIa1Q4mBxiwRiT8+Ory3cE5b+ua9B7KeP6?=
 =?us-ascii?Q?cYVwxuOzK+CLKltq8gsmX01d0MJUS6GqzNDe6Jlly/dN6Qzh8lkKtggEImS1?=
 =?us-ascii?Q?TIc3E7L51G4b5afqWLkLwUKwTI99Jcijk39wpmpTrljlCE8XR2gJdqdpaKEV?=
 =?us-ascii?Q?41yZzBphUINlMJcqj0l3ZRodbPMBReflpcyahad8Rd4s7Beq+rnrcMVLhEb+?=
 =?us-ascii?Q?SQf0Wi/CKUPxMk7WBY0FVxIEYJ0tgRUY8SZTRqQ9wwV0WzXpbFehXv3tTQOm?=
 =?us-ascii?Q?90QnccIE8QybAVusurwa+4mr8p2k8ZYusnhcWkHhZucmIXYVEUKCnkm3vzci?=
 =?us-ascii?Q?kN/iNa+GpEls+Hab5kdlACcut6Z+m5VSnUREXi6BhC/mWdRY1YY064L2X3fF?=
 =?us-ascii?Q?7OdqomotGDCZr120WawJK/4Q0S2EHWOIC4myeLxp0OMQh5zjA2IfP07GHOAZ?=
 =?us-ascii?Q?Bdb8UAniBbkFGxOCnF+9ZgWfGGjTJKZ69RDDU+EzvdOtIGcKSIdqxJcmTVoX?=
 =?us-ascii?Q?uKckgTmfCxuGNgENz3DxMpUaVwYPuOsXTeMNPi0InwIA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b397377-fc06-471f-ab97-08dd65ceff79
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:43:07.9951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1TIF9cDD90uGKsKOpUjnHPvAKgm0F4nPvDUBnRT09yL9HFXilTGlzaCn+ZzyCzuvzLA8ZekTqKUBih5M6oV+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9



> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, March 18, 2025 1:02 AM
>=20
> On Thu, Mar 13, 2025 at 07:08:32AM +0200, Parav Pandit wrote:
> > Currently, the capability check is done on the current process which
> > may have the CAP_NET_RAW capability, but such process may not have
> > opened the file. A file may could have been opened by a lesser
> > privilege process that does not possess the CAP_NET_RAW capability.
>=20
> > To avoid such situations, perform the capability checks against the
> > file's credentials. This approach ensures that the capabilities of the
> > process that opened the file are enforced.
> >
> > Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> >
> > ---
> >
> > Eric,
> >
> > Shouldn't we check the capabilities of the process that opened the
> > file and also the current process that is issuing the create_flow()
> > ioctl? This way, the minimum capabilities of both processes are
> > considered.
>=20
> I would say no, that is not our model in RDMA. The process that opens the=
 file
> is irrelevant. We only check the current system call context for capabili=
ty,
> much like any other systemcall.
>=20
Eric explained the motivation [1] and [2] for this fix is:
A lesser privilege process A opens the fd (currently caps are not checked),=
 passes the fd to a higher privilege process B.
And somehow let process B pass the needed capabilities check for resource c=
reation, after which process A continue to use the resource without capabil=
ity.

[1] https://lore.kernel.org/linux-rdma/87ecz4q27k.fsf@email.froward.int.ebi=
ederm.org/
[2] https://lore.kernel.org/linux-rdma/87msdsoism.fsf@email.froward.int.ebi=
ederm.org/


> Jason

