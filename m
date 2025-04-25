Return-Path: <linux-rdma+bounces-9801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDCA9CC73
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B43A03082
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE9526981E;
	Fri, 25 Apr 2025 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQE3tHYs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F44265CBC;
	Fri, 25 Apr 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593514; cv=fail; b=ZswSF4fjs23MvyRzhsniJaXD3+AwcfTF3XCXbLM+xMxSmgdH365Tcti0ibZsx1Ahj616BoszjFnADDN4eQul9uwcMyk+sxBMz4NswvK8XJ7eKV3TN1OTAHbPQPYN4b6xi3YtwE5o9vAyxanhrYfw4Dlfw6MIHsKtUFa4LMttTKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593514; c=relaxed/simple;
	bh=UIjKjizgMDZsg79Lvt4v1plLgyoDM9SW2fdnC7a3bLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Th1mizZe7JvEEq1g9Ke5JT6I6DfGnsQxDsHtCRz62WVmBO6C7mcYZNP+8ixEm4lf7hVtoQ+Sy9sP/aWMSmKkpfwRn62QODub84ckG2hIy7DoJIFfoXgaD5wKt6SeZ2YH+ParJdh3RdrsuEv/OJE6IMKt4tkvryZzRoJ/3WZ7iLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQE3tHYs; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdbEWe9M01mXLQKjBmliyXhoQ5meiCKg0425/sSLq7zvHV5qUdGu525ah6o8WagVGjexk/J4Ww4wSkreoPH431OldITj0yMmaWbo4rf5yjPAuYldYH9RmhvWbwl90RktbbjTdOabsOCEJo69UkQmwOJluVPd9h/ac3PoekCl343R1HkTf1Tp48G0MrMz1oGOnzC2OybwirKJBiJ+QLgdJs5t0BWNTeinh1lMU8Pdl3pNKhCTRwfeXB6tQIykhntxLlsZOJqD8gpcGXPFSJrn4zPINRMJDvU2dn7CG6ZKZ/jplTTl6/Cv67Yia818lW1T94p2gt3TY4MqF0KHpdJVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQQVGnScKDOhYhFVeki7waVYNMbDw+moG9XsL0y1xLc=;
 b=SFl+dp//ajhrWjKPCii2mjUeovI/q+caG4oJn/NtZz1VHwSqLBx82WeBrfQRU3iZ0I7QNluRRlqEDL+p+9/PqvKqC1Yy7VKjzEQOn4yTZxjTxEa1+V7q+ZkfM8QJvT8cnqkJ5/uURhyGaL+sefGtgg3pEDl8o7nGtykVECmoxbbLpj0ZYV2lkhvH7U8HSn3da/q+iLhwbERK58nDmjQjd/TMDjSCS/NEdrIjYkA2NKwMGwg1UGtIsZAkLZQdiQXPD1Z0cg1Eacgaq/yW8lyOWkEcc8reSUIELrSU9VQPDEWpi3ZtiQYWAvCYXSyj74Pp645Hy+ZUIkeFlTyeCqCItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQQVGnScKDOhYhFVeki7waVYNMbDw+moG9XsL0y1xLc=;
 b=MQE3tHYs6B275l+9P/8I2XWtP0Ol5BfFunHHSicn+nkoZbvULnIvQzZOP3ERk/ZU565SNx3Z3imBaxUG8/JfyohMhLyZCgB1kx+E7zWG9sjFU+A7x8yS3pMQ0wIIaO0mzlN0BI5qHQ1wjx75rps13d/VR7mDS9VGOZG69Mw1Yto4cPee8yxzO5jIJcB8iPg9XxM4/NdrB5iCaK0Y0uc0DJH2reA9lor1AwCgvlMUOfoPdO74Wtvlh4r7pbfxIVnaZPhE8Iu1jSzT9EYQ99mww6QfX9b2FFAysDw/MqSvn1wJVdXKdtUK4Eg8FUtoXuePTO2JZt9I4p7Za9tfJKDEgA==
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.28; Fri, 25 Apr 2025 15:05:07 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 15:05:07 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Eric W. Biederman"
	<ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAABCOggAAGQgCAAA+a0A==
Date: Fri, 25 Apr 2025 15:05:06 +0000
Message-ID:
 <PH8PR12MB720830D473CE31DB24BF36A5DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
References:
 <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423144649.GA1743270@nvidia.com>
 <87msc6khn7.fsf@email.froward.int.ebiederm.org>
 <CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250423164545.GM1648741@nvidia.com>
 <CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250424141347.GS1648741@nvidia.com>
 <CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250425132930.GB1804142@nvidia.com>
 <PH8PR12MB720834D2635090B376790F30DC842@PH8PR12MB7208.namprd12.prod.outlook.com>
 <20250425140642.GC610516@mail.hallyn.com>
In-Reply-To: <20250425140642.GC610516@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|DM4PR12MB6592:EE_
x-ms-office365-filtering-correlation-id: ffc8eabf-6cc8-43d0-eb80-08dd840a90cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?izjtCur67KDZaSPkUqsE4WLVh4upYAOGmws7BcbU8n3mhP9qBzVfrnkcU3x2?=
 =?us-ascii?Q?bzo314Eoz8rCNxn6rT/jUa6c4O2Gz2An8sNha/jKcgxAYWZua+95NOPyo/vt?=
 =?us-ascii?Q?D2gziaJFNCvnp3UGq0rVO6vGa1s6NAy4burGiY0pTDuSB6yCwSsjfAY8yTB6?=
 =?us-ascii?Q?C/LqnyGSZTcqG5YFF19sB1G0akR2foFvEOpIBbNdYutTTckrHS6cRUC3rWk+?=
 =?us-ascii?Q?8nwHU8II+CuDJ15ZtjIL9iHUJIT3/S8vj16yvtrYgKQkhG67WKb+mSnizy/O?=
 =?us-ascii?Q?fQzU1iY7iDrtUV9eHCRATq+ba3J0q57vmHZylrUbRJGhB8RwaZgT50ugLP6n?=
 =?us-ascii?Q?8PcfE5gb9Dz3mGHjtoB9jkJ9btzGdvAU0sC1deZLYs3IAU/FmmYQj0X+It8H?=
 =?us-ascii?Q?kbHkRR7ov/DxBu9o2/ClOjFZTpriaxbWWAAz7WKDMNpB4qGn/tFiwV35qnjw?=
 =?us-ascii?Q?NYpL+R0cMn6XoBhM5lD7wjzD0eX7tQw72pyUayfcCWPWQFGN/I9qoAmSLF/2?=
 =?us-ascii?Q?e+vjvFH/77zYgfHkKyFJEFMIMT30gGvfXlw+LtCOMIF3Cp+w1HLOLknBPA50?=
 =?us-ascii?Q?AKJp/i+QwiP5rNgxuBQxPSsH+gHBsm64Cmo5ZYioP5ogdMBUmgijmNb9MXM9?=
 =?us-ascii?Q?4ReFapPAS2Z7hT0uORQ+HCW9m1QR+9ljZIxnmHnVhFJENP2BI7atSieVhXUQ?=
 =?us-ascii?Q?zLBzRe4J6hO0l+FIINq1DP4sb17m+Y72f4rRrSvDSQ9/aEMu9pI9VuckmbEa?=
 =?us-ascii?Q?MmDc7mZny0wfPia5QmYxXgxYinSnusCwOf35i6sCttlkEYO/KGCpiHaFWXFA?=
 =?us-ascii?Q?oGTE6zZWUuvuyX3J/UICdOAmlqsvK8K3pHeDxR4dH2Gmz04KzFUoS/E/amys?=
 =?us-ascii?Q?QNRL8GDtnGQfTrDgoJhPj6BDlYMOGDXEirWN1gE6/K0wEh+xKZfr+VbnuQOp?=
 =?us-ascii?Q?94huMhymDBY5CwJuP6QwP9k5i4+UynlBwGA17OQnDC5IEMzgirXSEi+b5n0U?=
 =?us-ascii?Q?ckYhlNSgk7F35umtd90/4YGzocQ3KOSXbG687NX2t/Msdsph0ktaz87yR8Nb?=
 =?us-ascii?Q?oSTw0ELUUNtwllqCNOfnKUqLsYUyPI0tUu0xm3ZfG4RulJbYBjVIXAbPE0Ka?=
 =?us-ascii?Q?uYlNacRMF3VbLzrnjwjprZcjHDK7fgiIQt7b9z/Nr0JfA18mLBeusm3j/Re5?=
 =?us-ascii?Q?znyqXmW9QAhv8DZ/gVxqqPMyOvlhWzRDtC7I1r/SfD/zH8rqxvh/9GF7ZENE?=
 =?us-ascii?Q?3AzYN6vTs4B/lhqA4HHKxN4KVDt72yp1x+5idi3aaOexlKVN7FmyOu3I8s5Z?=
 =?us-ascii?Q?Dtgm2GSQP4sfRKlvq7zAcfQ3I3Du5xIsoHExsRRnlOnIom4Jc1hZ0SBBJBTQ?=
 =?us-ascii?Q?Qa81oDUrIT7VE0Yy6+7TKWp0FLZ97G+sht8qNNX4HPEWhFo3jQ4ewz5ag0qF?=
 =?us-ascii?Q?8mGgR0q7qVV06Ny27VTDq188IZ/tPgdvAEIRKo7KP9/eylbaJ7SSgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7208.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jBX0r0qfNWTKKAbU5k5rJLZuOA8R4qS7Pz4SaH3JwFY4RYsA7KUYtmFrsn5P?=
 =?us-ascii?Q?hKy0cLadflINTMGPX7jBpygyr04DLQpAQ7vJInTyCbbaPFic1msXa7Jajfau?=
 =?us-ascii?Q?P5uuTX6+y8MVpMfEA2yIpNOZqjLmVKIzJNk5+IziX86KQ2+mDtI6TFN3oFxh?=
 =?us-ascii?Q?hOGYL4x5W+bSRBPu0WW5VCj9FPwEDtalhJRSMQ807cC4aqJR0015nr6LQLsJ?=
 =?us-ascii?Q?jyUaP9NTRlhrQTaG+K/y0bVM74CMMlwfejwKYCDj0Awq+sm+LpcgcNjVIXDZ?=
 =?us-ascii?Q?KzBB0OO7CU6uUw6YVRw65oFqkUbYl7yLIaIAyxcJqE+El7Vvy62ZMi3tsnAo?=
 =?us-ascii?Q?aTnjMoHQw5Tbozjq+CYtZmPcNH6S9pnEVZqEftrvVc0URy2HbuB3oYcF7fv3?=
 =?us-ascii?Q?G1vq+SzngrNZlzSagBB2AR3ui5dPjm9xkeryuF21s5Fn/tIku6ahcHY4f6Rx?=
 =?us-ascii?Q?zxmEaQCIVJM+iGRqtl55lqtiOUPbrNaBA48PiQt9W6k4YTPe5GffrOBSE7SA?=
 =?us-ascii?Q?Hj6rTcae4DjaL3whPjBbBXL8gerbKcWq9yTIsf3JQ7RecKKDV+MHTTGgeVgZ?=
 =?us-ascii?Q?j7hj6AGiAQV7ilzEznhKtSbEGZJaR6XLjzS7x+3ryPNj/ImbfIWmV8eU17xo?=
 =?us-ascii?Q?wa/hs1bfOYjhC5qXt6bvcinbMB12IKfNyfFyhuaaxoT5ZC3UqrH2gVwfo6vD?=
 =?us-ascii?Q?4F/x5zRMUoljWsv0lLcmrCada8+O8VzNKL6x1L/bqxj8g6hCe11m9a0zbJyn?=
 =?us-ascii?Q?BTysNpsPyCBLA1DW8Xf6kl2/AnWrkTAJB1yYETy3YR0k/9Ci9MganuL51y4I?=
 =?us-ascii?Q?mvroxCL9Hg1b5x85f3mEwP6LoFMqVJZ16A7tNQaI0n0Q5hQbPTF2gu01r8EI?=
 =?us-ascii?Q?sR1HIrPhUQxsa9HrV3KnLrkBCXUx+Qeloudyr3sGoQwq57XBsZLuLbrAFF6a?=
 =?us-ascii?Q?7avqjKmIYLT8XKiQLB8eOTDn5UmJWrUHPk+LfvdkYaKSfoKekm9YrGBd1y83?=
 =?us-ascii?Q?9sIXuKQDPFUOUS/TMt+gN7401U7YIonuJpnY9urkWFFIlmSGAh65Lqv4TGHH?=
 =?us-ascii?Q?C5cHhH1u9R1zLVhdysErdow5cSLSnoM7BQATlbOaZiArApBFjvLTXQu5A4/1?=
 =?us-ascii?Q?7pViNRN9UipfCYnrrV1yozcb4qsjg8aJDcMvpxUNfXepGveDv+NCRWPMbP9h?=
 =?us-ascii?Q?5ieHI+I9SHvr7RdAdmp31vRzrE8334+ILyf21OWOs0UOB8Kg5U9G8hVdOT/z?=
 =?us-ascii?Q?eBw2/9APQvBwMyAUMiPv2afD3f8qLad4wnuM7Y0CLAMOCvbg4zYtV1mix2aT?=
 =?us-ascii?Q?PELelc1ARMK5MyBq18QwcZoqNzMbA/AUV3rjKqB7n7AjaWz1M7KXNEfKv2gj?=
 =?us-ascii?Q?Ef46H0UnqYkFx0t6V97iBWhFzOZyNZ3AezVTrMQ88VkLe/aSDbocRiQ+DLUc?=
 =?us-ascii?Q?InyfDtoc8ODiwcoiYmpd3fxFDKfneQiRBjhNNjb1IOPAE/frPh59PQCMnfQe?=
 =?us-ascii?Q?0k6R3wYx1MfAdpwVOWGZ0/RZhRhMe2MNzlJfB7+wNRkkSMG085orJGlObI6A?=
 =?us-ascii?Q?0Z8VlM7rJ5ah3NaQ2Zk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc8eabf-6cc8-43d0-eb80-08dd840a90cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 15:05:06.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L2Zu3xGEpTbpKM0VAXMMdDs4GEv95iooyg4qr0O1X+pHaSF7aqBAJwWOB9yKn+1MNbsqoB3P/o6cvwrW9ALyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592



> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Friday, April 25, 2025 7:37 PM
>=20
> On Fri, Apr 25, 2025 at 01:54:07PM +0000, Parav Pandit wrote:
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Friday, April 25, 2025 7:00 PM
> > >
> > > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> > >
> > > > 1. In uobject creation syscall, I will add the check
> > > >current->nsproxy->net- user_ns capability using ns_capable().
> > > > And we don't hold any reference for user ns.
> > >
> > > This is the thing that makes my head ache.. Is that really the right
> > > way to get the user_ns of current?
> >
> > > Is it possible that current has multiple user_ns's?
> > I don't think so.
> >
> > > We
> > > are picking nsproxy because ib_dev has a net namespace affiliation?
> > >
> > Yes.
> >
> > After ruling out file's user ns, I believe there are two user ns.
> >
> > 1. current_user_ns()
> > 2. current->nsproxy->net->user_ns.
> >
> > In most cases #1 and #2 should be same to my knowledge.
> >
> > When/if user wants to do have nested user ns, and don't want to create =
a
> new net ns, #2 can be of use.
> > For example,
> > a. Process1 starts in user_ns_1 which created net_ns_1 b. rdma device
> > is in net_ns_1 c. Process1 unshare and moves to user_ns_2.
> > d. For some reason user_ns_2 does not have the cap.
>=20
> (d) is important.  "user_ns_2 does not have the cap" is imprecise.  Proce=
ss1
> after the unshare does have the cap against user_ns_2.  It does not have =
it
> against user_ns_1, and since net_ns_1->user_ns =3D=3D user_ns_1, that mea=
ns it
> loses privilege over net_ns_1.  Which is what we need.  Because otherwise=
, an
> unprivileged user could simply unshare the user_ns, be root there, and no=
w
> tweak networking.
>
Effectively, since process_1 lost the privilege in user_ns_1 after step #c,=
=20
if user wants to tweak networking, it must have a rdma device in net_ns_2, =
created by the user_ns_2.
Right?
=20
> This all stems from the original requirements for user namespaces, which
> were (off top of my head)
>=20
> * unprivileged users must be able to create user namespaces
> * root in a user namespace must be privileged over its resources
> * root in a user namespace must have no privilege over any other resource=
s
> * user namespaces must nest
>=20
> > By current UTS and other namespace semantics, since rdma device belongs
> to net ns, net ns's creator user ns to be considered.
> >
> > I am unsure if doing #1 breaks any existing model.
> > I like to get Eric/Serge's view also, if we should consider #1 or #2.

