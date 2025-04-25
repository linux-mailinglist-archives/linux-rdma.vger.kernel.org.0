Return-Path: <linux-rdma+bounces-9803-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F17A9CCDA
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050B35A7467
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ECC279334;
	Fri, 25 Apr 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ECeFtYtb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4725DCF3;
	Fri, 25 Apr 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594868; cv=fail; b=p/PoRup/neayR7Q7znqJ1+RsY55Ez9EwpLAxqOzacNNG7FSGDT1TxhTEb8fDIXrkaUvxXHa9YjDI1/dP/0X5a13l5GuBkx+exdfyD78SptNQrUmal6p6FSOyavFPbujTD3k6jWv6Zyq6S2ni9c7Mi03vOOyvgMe98QrkjyMk7Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594868; c=relaxed/simple;
	bh=asuke/u4bMe++/5XfzhD36Y7Xa0WJlI0q58AMs1qayw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lR9th2p9iXgTmJyE1ib7Wxn6X2lo39U1Gi+jD9RhmQKS8lACWlUSDDvyHfDzyD1aYQ9PYKehf9kGt5PDanIWBrdFLYJUkyMxCUo4tQyg2YZR7U8zj24/LWkWyuAMiUSjDSz6Sifyu7ArgVCzuQM6EKsxHoHQgxtXdc2txNJoVkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ECeFtYtb; arc=fail smtp.client-ip=40.107.93.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRzEWH+k5onUyuDLc2739P9LtbZsmZOTfizuoCnK1TGUVJaalHawi/BBePnibEAtPqO29WcRgzx7+HqLL+0Kg8FO5Tho+Y9m4Xh8CxI2ZKT5ZPPQx4yfiWBwSWj76ULcmlbK/GVCEf8hKDG/HrhH/Qkx+irQUK5iX+5sVFND63Hb2mxT1azB2T7M2FmDYWvw2h6jg8Uoh7wgAAyLxx7Ke1NdVHeIpm1EpsAl0RUcmPRAo+BpHSSx7jlApdn92KIVPf1l0RxreqULa1QHLQx9JuITMhlUj/OWuOYA2eV3Hgke0zokjpqkEOJL5Acb3wjYNfFK7hWMAaj6mvvR5d07Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9twac5cv1u5lx/PPHZBh2P440/MUk+Qva9V4pP4sg4=;
 b=LVVjLXFAzkvQZitkV5C9nH2yTMFEWxjRELJwlu0rM7CBfgtn+Lgabv/IfRN6QxwiWb7fPMb6RxFxxdg4A4zSFhI19u99A8v3M0RiNChOTAmOuWmB+R1/fVAmjHtQZHlAOz+p/HpfErPxeOY5UxJeis70p59LTA4Zme+sh6NFqt9IfwIwQ4jIvI7N+4mXXatZkJOX7FfMzQHYGb+WK2gSOXmshwt2HjLjvKnrrER6wKL4Kx6UhnyHe0Os74wIUk2uMIu4PnV/2HAxLTgg4J9T+/acDTLuC5VA4CFXHTBIq9TpphFnsOMIHkQ302KVzWDsvZXRT6+LwA7GgXm/9GFjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9twac5cv1u5lx/PPHZBh2P440/MUk+Qva9V4pP4sg4=;
 b=ECeFtYtbJLjgz13nt0MwpT40E1VTZ9uoJuvUQhpQ9R4rHV3CXXVj4MCPk3AyMrhx30zmlTOGY52nyHLk3jLKIC1B8xtvM+C2SkUi/Q/Q301zeVVQkbE8ShnmEemM5qNy5WzrAxZ8ibPs29P+KpxqdibCUn885+WTMmzU8hkqudzeCk7GqWxYoB0Kq/UUZ4Ht9uk62p8LsS3YGVbIjmb0z5Cr2OnCxuVFge/o8Kxu/xnhJLnLxso55+fZIbvAC9BCB+t8WpSAy2OPVD9+NV+caVTJcjLh1uwAxv151vb0B2g5yiW7R9Tk1lmpWKiKl73mqQhyyb1ujqozwNmH9Gd6ZA==
Received: from PH8PR12MB7208.namprd12.prod.outlook.com (2603:10b6:510:224::7)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 15:27:40 +0000
Received: from PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42]) by PH8PR12MB7208.namprd12.prod.outlook.com
 ([fe80::1664:178c:a93e:8c42%3]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 15:27:40 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>
Subject: RE: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Topic: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Thread-Index:
 AQHbk9YLoK1pT4atn0WpWWxcsGvDt7N3vsYAgACIALCAAIEngIAAkUBrgAAxToCAGipgUIAZ+iMAgACAGGCAACPuAIAAA3qQgABFyACAAUU9AIAAB8qAgAAxbYCAAAUbgIABS0ZQgAAqToCAABIpe4AAAEUAgAAOzYCAAQq5sIAAXSeAgAF369CAAA4KAIAACQIAgAAGW4CAAAvKgIAAA9QQ
Date: Fri, 25 Apr 2025 15:27:40 +0000
Message-ID:
 <PH8PR12MB720850A641460067F7CC548DDC842@PH8PR12MB7208.namprd12.prod.outlook.com>
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
In-Reply-To: <20250425150641.GA610929@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7208:EE_|MW4PR12MB7263:EE_
x-ms-office365-filtering-correlation-id: a9236867-16b2-4254-4ab3-08dd840db78b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SP/dntD4zBeKhOq0ox1dCg6YghQfdVi3h6yHVMXBokXcc7f+4NV43/RNnqT5?=
 =?us-ascii?Q?zBU4JXWKINlWps9pPtyOAjpXnSLGUf/53i3LKIwyrr1uMfJk4s7VuXvxFxyY?=
 =?us-ascii?Q?Kr8/Eigx0uh0FWiz1MQdi9Ss5UnsQBVbAtlYoT1YjhpWqJjPIax9gl/BnHoR?=
 =?us-ascii?Q?46x8buBMdrTSZa/zfiCDbIBt4ILq4stL9Dld/owC2lp/6cg1N/0186/nW7VA?=
 =?us-ascii?Q?AzZqzYpmSgRSVHfA6ol67B/z66vnQhvigszdFxAsyoeO2SkxUCzYrUtvjYCI?=
 =?us-ascii?Q?KRUYPfyDov02GBH+M2zfYqHMGIeU3Dw9tbHKCHmvEOtjD4lqlr5zdm2y/W8n?=
 =?us-ascii?Q?9f0AAiG5aMqjCBKAy7rVBbIh5Sc5kEA9a4U31mRziy6wWWkhChURLHoSlQCp?=
 =?us-ascii?Q?7eDZ+lQSfLIIPBf6aHQ+87pjHuYYndQVWXcAd7yP81wZeQB5BEeGhDeXT+bs?=
 =?us-ascii?Q?qZEqI3gTobMV+776GFd6bLk0YaUiL3myP2oD0FXtBQiMkeUejjoSOg+q57IV?=
 =?us-ascii?Q?iMse8v+JIqqTufgengeujiQGU/xUZTpmFK0GOfnGpzJM3ZDz9uMwIFjCXNux?=
 =?us-ascii?Q?1RtL+waM304eYEQTEs+QzhPaRLk+evmtDWLX957g9+TO0GAHi6GePIQnyalW?=
 =?us-ascii?Q?T/HRDawe57x/ueqNLGz2YtVU7SNqsGQ8EOCiu18NxtWYy+aAgv+U9bkzEreC?=
 =?us-ascii?Q?Ij2V16UIOA8hz0S/KfPI4ipuULunaie0dUPDgb3lZmQR/tN4q3mEc4NmbyJ6?=
 =?us-ascii?Q?VCy6EuYtD1wz5cmSYEAU3AkOsdXbp64FaU3tsAcPkIAvgFleXLWFaa9GK9lG?=
 =?us-ascii?Q?L9Fh799aOOFdB3Y9tMzo16qs7TuxDYyawZcacNfGqbW5/VGxCk64iWzKfajh?=
 =?us-ascii?Q?/hZxG+ceChYKyDYdT26Sv50gjnkU35HIDRYJuuc03wgJxjELp0ElJ4axsVM1?=
 =?us-ascii?Q?fm4EpVgIM68IUReo5kG1d18OWCCff7LIWtahSpYSOaibfINojwZ/5KKKXG+2?=
 =?us-ascii?Q?eTgbsYyZFY2McYstwrLXVedFRPyS/FJQTqoLwiGHH5S3s4KfqLHZwwe3V7lc?=
 =?us-ascii?Q?U0QkLeXXap76dILJHyxr9CbhOg3R/q21ekLqE3dcB1II381idXjLfj53Erqn?=
 =?us-ascii?Q?aVbYljCYr0+IEaX0vOP2Y1cSwro12ID5iaynL3XFFtPEjesfkY2uhIAeq1s1?=
 =?us-ascii?Q?n0iqlJrtNXuJ0BxwN0sm0oHXVNA3m37hPSbq+ToU0jEwKVxLUaKLeSqi2/tT?=
 =?us-ascii?Q?ydTdFtXVP3YwFHipvBalFpsMfH7etaexUfqS/8fFpY3M2nG/NVJ86ENAysjB?=
 =?us-ascii?Q?uA/3YfQNFfk1Mf3flwL+TyCwQD7bi/ZflO8tCR1+O5rXXRaZmSdvcnMbp9JN?=
 =?us-ascii?Q?mbS/A17rfTC0qXhSZPcsR4LPATSc9QWKY3QIsuq1apukhM+fadlQ6TruF3/g?=
 =?us-ascii?Q?8I5TZ2bL/Q+XVbGGT5UanJuBcJkwBWYEnPIUUevEKYBy6JchP/0L6ZBk8BoN?=
 =?us-ascii?Q?EO8hy6j3pLlqkb4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7208.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?G5LrMO3S/z1khmvpbWACITLDCxcZxIz5vR6u4pcgcn17Ksbk6HzthU30jT8x?=
 =?us-ascii?Q?LCLcwGjAEfsz69JFIQheuf2x+AHiwmntisrLCLir46nhZK9pjCCtwL0/aPCx?=
 =?us-ascii?Q?qhCdDslRdxhYHeL578FA2ycw8A9GJkeBcX5QRTX4rz5Co/2gn0pnbSeQPNeP?=
 =?us-ascii?Q?xWw1gArbjf5hlHH4G/FIOZxB1p4qxAcIkywcErHaycT8UOwuKT251s/OPgH2?=
 =?us-ascii?Q?L1CWW6H5e4fYRveQJqs0FAITKgU+SaFGASTOcADd1u3GhyNYSVmGYsAfl41N?=
 =?us-ascii?Q?YxDlRHGCZypW/BmdQbDd/DhIxJmNNKCwAilXL/0Ab3atIX7lOj5iR7DoZ7tE?=
 =?us-ascii?Q?vIQhP5gZYf3gF9w2zKu98NxfwUF00Dtj6h9W4jCDelKse3DH8j6vyRngIMAc?=
 =?us-ascii?Q?48aBwrvxpHaQ2C91hcXGEoRYNDWINcfC/JDPC+YEWZO2Abau8IPyniI7M5j8?=
 =?us-ascii?Q?v+UNu0PlY54dNSNskZbhbb50B3H6vTgUWt4jhk+x/RFtU+Vib6dXqzOC/y0q?=
 =?us-ascii?Q?szJTfV/tO5xG+BECZlQlHlHc+CxCoYsPzmlEDvvI92+VohmKLSBz7fEygrf1?=
 =?us-ascii?Q?SqmW9loejTG7tJTSiCg5pHEV7KSUc0GHQ5obz9ImYH2/upM73svG4UV14e55?=
 =?us-ascii?Q?4zJyFKVbhae2/xWv2wD1bCV92Juwsf228+9BtLPY61Ikl8bysi4ZSec3AL4e?=
 =?us-ascii?Q?NplN3kfsZFU1sg2C7O7JILW7sr3JmLRFwlpjmDY3TTMROFe2I0lWGKLutwHC?=
 =?us-ascii?Q?5MnRXCPAoU8iRPePqiPNOQvbDnCGzfuhDvWFA600Es2tGAkCUHSYoRi6GX6F?=
 =?us-ascii?Q?cMam0kicPOg/FN74zw6GXhjn2YjyzvlKud+fYDSobWcfVgft2Hete0ESQmHC?=
 =?us-ascii?Q?KUps71uVp/OOdJdIWKqaF8KSEAa9R7L5fRnkPo/D8XigI0Vp150hjs1K+Wrx?=
 =?us-ascii?Q?CR9x3kgKn48tgLO/snidbW87nuCIA8bIu1vRi6ACvQjorHhhqdXNAwVKdMQM?=
 =?us-ascii?Q?9H019UN+hXdLcWEUPmgPxW5jpGd2Ft+lTmblXHp04IOnkUiyCZ7003LLirQ9?=
 =?us-ascii?Q?AYMW0sjj3iEC8OnRkpRVI1wZMGX+NxJft3sHBiOzRDr9EHVeQZ5BLSLdVfeu?=
 =?us-ascii?Q?mJODbyJOLqbRr8L2YxeSWe8sGxUGhqs/FmiWw1flc4VO2gnuvFUmPhWdV9+D?=
 =?us-ascii?Q?cZfyYA3WM8vHrTLKoPfJAQD8BANPwaPgbXn89qtQDKZWV6SpPk5t7OZDyZJP?=
 =?us-ascii?Q?axL5EiCjFWZLXnjjGnT2VkradYV1k9EMVvEoaxCHJIj3mG0x5NKUHdqoeDGC?=
 =?us-ascii?Q?K3aLFqTdFMstVTUAWeGR/rREATxS0SXnfH3o7vTKjS4w7vxoCu308P2M54q5?=
 =?us-ascii?Q?Z23Plh+JaLasKQjq2IC9LitqLC6Io9LGOuvl1V0u447HmViFofE7xWxXx2SA?=
 =?us-ascii?Q?n/v+aZ6fIV2smliLqOGN8x+YZyD2SFgJ0Fc0slDk1QTVd+HGy5iIW2dH64Sh?=
 =?us-ascii?Q?GxoVLwYcDZqpKmxbYp+5e/qaqjOAeRhN7BgT/1OqN6IJAU8u40bGdyqgU/nw?=
 =?us-ascii?Q?rL8ZN4TyZibdBDuCNls=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a9236867-16b2-4254-4ab3-08dd840db78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 15:27:40.4927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw8aDmhpuJFG//qPiC6ix8qlEOmvCdfrRWVP2Uj7EAS5/E/r4ZNLKPPpqNS/oV5uu+rL5gddtPjUB7/m9rLR6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263



> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Friday, April 25, 2025 8:37 PM
>=20
> On Fri, Apr 25, 2025 at 11:24:29AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 25, 2025 at 09:01:44AM -0500, Serge E. Hallyn wrote:
> > > On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
> > > > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
> > > >
> > > > > 1. In uobject creation syscall, I will add the check current->nsp=
roxy-
> >net->user_ns capability using ns_capable().
> > > > > And we don't hold any reference for user ns.
> > > >
> > > > This is the thing that makes my head ache.. Is that really the
> > > > right way to get the user_ns of current? Is it possible that
> > > > current has multiple user_ns's? We are picking nsproxy because
> > > > ib_dev has a net namespace affiliation?
> > >
> > > It's not that "current has multiple user_ns's", it's that the
> > > various resources, including other namespaces, which current has or
> > > belongs to have associated namespaces.
> >
> > That seems like splitting nits. Can I do current->XXX->user_ns and get
> > different answers? Sounds like yes?
>=20
> I don't think it's splitting nits.  current->nsproxy->net_ns->user_ns is =
not
> current's user namespace.
>=20
> > > current_user_ns() is the user namespace to which current belongs.
> > > But if you want to check if it can have privilege over a resource,
> > > you have to check whether current has ns_capable(resource->userns,
> CAP_X).
> >
> > So what is the resource here?
>=20
> That's what I've been trying to get answered :)
>
A. When a raw socket is created to send a packet vis netdev (resource), the=
 cap is checked against the process in [1].

[1] https://elixir.bootlin.com/linux/v6.14.3/source/net/ipv4/af_inet.c#L314
Not against the netdev's dev_net().

B. Netdev's dev_net() is crossed checked to see if current process can acce=
ss netdev ifindex or not in send() call.

So resource was netdev, but literally the check is against the process cap.

And considering above is right,

I try to draw the parallels between the two types of network devices,

the check for rdma raw QP (equivalent of raw socket),=20
Should check similarly against the process's net->user_ns during QP creatio=
n time.
This will match #A.

And process to rdma access check should be a separate check #B.
=20
> > It is definitely not the file descriptor.
> >
> > Is it the kernel's struct ib_device? It has a netns that is captured
> > at its creation time.
>=20
> I think that's what you suggested before, and it sounds like the right an=
swer to
> me.
This also works in my view. Its slight deviation to how net stack does.=20
and trying to find a good reason of why should it be net of rdma device?
Is it because socket is sw resource vs rdma is device resource?
Couldn't convince myself given that the capability is of the process and no=
t the device.

