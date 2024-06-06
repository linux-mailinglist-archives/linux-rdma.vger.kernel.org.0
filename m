Return-Path: <linux-rdma+bounces-2947-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31258FEFED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B631C2400A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C471B3F3E;
	Thu,  6 Jun 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FLsJGeed"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6591B3F12;
	Thu,  6 Jun 2024 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684871; cv=fail; b=AgBRQW9Pzvi26lMYImxDPzfUAblb+spg+ck8//lvY8jYasBd1eXmMQifesMwpflJnb8EztRorF9sivh37cgG2JJcLFlBnAUBnVg1s+lUK04pTu0bCfd+scbKW6+2FaAU+aOUBt9G2LTc9Y3xl5yykrO07oH+VWUJ+CwKKezEDQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684871; c=relaxed/simple;
	bh=nuXw+mKVF58vlrbZPQCqkIoo03U4GQ8kJsOLwF8gJ3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UVdiq/O18epe79mBcfpwXBvSv2gBu5kda7bx+vpMtS4JmMeWZFaSUXYaeSVY/v2TCcDaPVKGfggr+yXtvaf7+AiiaAT4HHPwp3kE8hM1xt5OoXL6/X7wtEjb1htCDMv9Y3KwrkojSQOGz34MbEg7y4ZLO4T6Bu/L2FfgLC27GzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FLsJGeed; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSXOLAXKpvfxvXWDacHweLw1ap6ClFZVmO3yMlpcDDUOBDLQ31+SWwraChoSe+YEwI1KoNoFh4yVWYUd4rkzPU/yBAaBDEeEJ//oK4ExI0WBF0x8Q0V9+OjFjCZvsbf+/K6xdNBSif5VqZk8Mmco4A8cJ7COb7mbCMXRwJe2oT54E2Dy7ugu2Y7WtFOKdGu2Em/w6zWOrBbK9uPq72RkTy/qOp0+HMJSW/wDwkItad5pcgG54dtTxCjwfCyFJUDeR36MZ7VUeam33vLAhFiwXNJfYcin51dLAXC3V4d0XHbmrcD4ef1rHefvuIhUueLbhzQwWA5wAb96ET8g1DRC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lFTd0/k13dQope2W6dT2+/9+hW4KCuEFWcz5Dpp8Pc=;
 b=LA7XtUue66QWNJafM1YYWb/u/xhMInrIRxhYdUDXuNr/zgR0dmheYVIHVBmmw3Q22VffcM1fklVK4sonr7yhHJD+AHV/tAk7sjUO6axYGiJ7UZtTyNodAvz+3EtSjS6pdjDNFMTdcH9SYFHaldbUR2mESfRBdhSu+280EhbRaPgJutkKKAE3Ft4fnlnuF6UKTIoEyQP8djTIi83O9GHjfs1qIBsNjhXO3EDRAF9/QyzWbRqct4GNho5fUWt2fQPaK5RZapwjpcAzWEMAiXHk8wF2h0mrEoX5Ow3WkE/mNCUl1/UafffbeAmlUiNn3UHpyDytY33Q9i1t3ZfWMXElLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lFTd0/k13dQope2W6dT2+/9+hW4KCuEFWcz5Dpp8Pc=;
 b=FLsJGeedvF6pIYA3i/t4wvsU+difkjURWCWIbRk278bmhlsPSQl6IUjcmcKVVmrtLWC4dfpi1cV1vmQoiowA2hzSodcKx5eUpwjDH29vG1pS+1doCAnw07qmoxEl+Q4iVMat82Ch/yWfpnmN3VGi+cZCqQgTJfluxe41zBS2Izmu8nk/jEx6847uqV1tLMiWSxdqmU2Oh6fstHRoKZxaruwP0mGyP4WyGWBJ+/P+H7uO3wU+duTWF1PKAP8f4lrwl2JC1cTsGV+s8XnCvby5wVoWji/PODQAHIG+Ehi0Xy/T4MWGkoGAcmI1Ibj4Ayfn5TjNYTcoh3St6S0Dv7eRPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB9189.namprd12.prod.outlook.com (2603:10b6:a03:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:41:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:41:04 +0000
Date: Thu, 6 Jun 2024 11:41:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240606144102.GB19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB9189:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ebe90e-2c92-4ce2-f284-08dc8636b107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6ZacMwvtPs4v9hxNb6Qkk+VNs0MB5HU3rAGk4nY1MakExyTgI83ZoEtp8ap?=
 =?us-ascii?Q?Es+Wncy048C++kq1efjveHKRzwB7O1H41kM77wF6huGL6nqgioJP/p/cDPZ4?=
 =?us-ascii?Q?Bc7ucpZ3nGzOXRN2Y13FgDlV3F8o3saRi1diU/S1AVuULgYpQwaPmWYEi+Dz?=
 =?us-ascii?Q?hWq7ySGiZBuYw+q34j6phHRSl8HFP1LtUf3m1OuQDqXZdJSLlwuINDfC2L5w?=
 =?us-ascii?Q?h5sNhUWbHAnf0C3vUZhVwgdhdHu9aX4OH7buTvsvaTPRWH/SGY93JAWkDhKe?=
 =?us-ascii?Q?ptmSYHwXL6udMYV5AT0j9MBqJjDff9RZToF91nC0+Spc0XYPeJObB6QpeA3g?=
 =?us-ascii?Q?cNQtpE8P5Irw5kWQMCOBSrcrSj+hhve5VCnAB7vSujs4s5oMyurfZA5qFh0F?=
 =?us-ascii?Q?xi2CluFeJdQ7o21P3fa8IdQ0weIMv1DxVxjLS9QIoONVZg9Z5sSVErQ+piRC?=
 =?us-ascii?Q?ZhQRauQFRV731ZsSvk0ZId2w3q9gopu2PYa5Twwg/pm7eRCDCESieJfNiaec?=
 =?us-ascii?Q?G4FL6llsCsGsWhYCa1I0+t7SX49XfAWbWBTE5qEhDBsRF8d9zFzEVHB8bIE5?=
 =?us-ascii?Q?ix8XCyOY6iRpyknBXpIXDux86H/yyYRK4EKSoZTbmgzT5UpJSgZxICoB3lUi?=
 =?us-ascii?Q?jwvlXQCE0VrKQMR1f8PwC4Ex0YI6e3OUnGSUcC0XDzal0zI3xACujCG//o63?=
 =?us-ascii?Q?BL0R0vO8AJyd/dHgcEaeF2Caa387Rqr2jrY6TyaGP6wIoc3rI4w0l8R0Ebr4?=
 =?us-ascii?Q?3fbAGGYW5cyg1tz3yYJ7aLqJD/pGQTDNbr1Q11z6vcZr1UsiPk53tA8p61x/?=
 =?us-ascii?Q?kTWLxllG8Po9xFE+Ohdg1A4UTp5eFEuqtOSSNy6seSO3AyA0TsZX9Vut+zKe?=
 =?us-ascii?Q?me7n9tZFgQxdroWFueM5oEDlXaMfQOTLnRolSx4UuNP/XTU1qlXVHyaY6sYL?=
 =?us-ascii?Q?9fW/2aQD7GtUcU3i2MO+mZoSW/fpRJH/dcuWFsLiNH4rK7AZaa91b2cUsVQR?=
 =?us-ascii?Q?PErzE65+kuMmL+nBlIal7A0ZDc16SBNT+CZykVsNNYG+yO+R2ifcU/bp8eAT?=
 =?us-ascii?Q?aSMZ7sv8L41MU2nTbPU9cy26d3iU0cwupr6CgL/029/DzanpeE9lLj0Agxen?=
 =?us-ascii?Q?0geaYOqv7DbrDB6MdXJtFx1wdyzHc2umYFzC3uZy2+lwMLOJFfnmIHDJGXBB?=
 =?us-ascii?Q?mb9FKE02aqFeHGIrcfEUh7L0nmsC4lRc2NP5dXb53b2fNq3VA0XKweT3ECsX?=
 =?us-ascii?Q?HNL0jsRQ2OyTtWSn+dmjD8blTkWMOSUjo45e0JamTY2FErcVkmgyJvG4VEKS?=
 =?us-ascii?Q?/Dol3CX7+zAy4h240r9o3ckS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?egOY5GuiieeCfJH8PYaTm9rXtu9Yx2E5m9063h1jSCNbdFadXvPBJKWEw1N9?=
 =?us-ascii?Q?bWcFI3su+rwWRelT/oXDIAOftp2nGAYbCg50xElO1U/11Q+QsvxtTPzTgP02?=
 =?us-ascii?Q?pIEhnLwgc1kfBRLAybYqhstjDoERHdD4y8ruSR9pXptlGkwqutxpjfqJLf+a?=
 =?us-ascii?Q?ARkxlZOWLJvgJv0jZQToQWJ6941UkEuECWJ6AH0/MRSremixYDuPPox3Tgt7?=
 =?us-ascii?Q?dpU12sCmN+GbC825XqbuueHxrrJqlYPPNTntAsGQKNfxKXMOJixYX8b2jjOO?=
 =?us-ascii?Q?GfdeWFV/XLtAe3NIBwQJovhIQF1Kiby35tvrGfDrwaNE0mNg43Wh3LO0x7PM?=
 =?us-ascii?Q?h2HOCafNXpfj3WSHaaozUINJXbhtm3D3f7qIpTkPpRkStroAv+damgwiuguL?=
 =?us-ascii?Q?PPzP+s3i3ETPuL0Pn7hQxblOsGdiQPUfjlgiZS6REt02ALVBDxYaHMRUvZp5?=
 =?us-ascii?Q?sEyOr00lefcbYobB1IW01cCMof+HFGBZQIE0ln6TTa88Ow4Rix7mdi4bCtuI?=
 =?us-ascii?Q?mDoJC5w+OT32cKFSVqmYvLncoh7wdvyQ3eVGNu0RJiMa5GlexVQEpWokzcom?=
 =?us-ascii?Q?g7mb2H2552xalALnsujuA72vh07SHrZF+hC0VspYisUcRT9l2YTryY6gleUN?=
 =?us-ascii?Q?BvsKkwUwqqxc5EvvdWpALYG5ZYak/AzGqMWRFhVNnqI5nd6uizrY8TKj+qK2?=
 =?us-ascii?Q?J8lJ12fpNQ4fGl2DOUh/UiS09jTg2nQUNjszy08dlCN9mlcdN+FAWtgPLu5N?=
 =?us-ascii?Q?40gfhAMR2OdKYKYJCY5i85vzmG+O4MBXM9DzRxTjDY3hqd6EYcgLrx1krlMN?=
 =?us-ascii?Q?xehN2jj0A6byqBGOsBOVWckMV8pXlcBMVAw8H+X08QuBALDEuTp9Kp7ar24D?=
 =?us-ascii?Q?UEepTA6uC1HJeIGb14hGMFYKM4H3JyUgVp6bG7+k/4C436Zldu8b39UZq6uT?=
 =?us-ascii?Q?PEVClrMVaT21Fc88+owg0Tr462FvGo9XwzLBtchsx0m72Emg1NHKDW/E4FhG?=
 =?us-ascii?Q?h3XBg+Vw+lRw9BLrckpMjXwqH+yVuFjfdJwag6BjlO8diB2JfW+mkmrt48Fe?=
 =?us-ascii?Q?tABByWifFiU1Lq7bAv9AWbfC3UcN9kclUUHeotDyA2cNyFnxPW5itV769qvE?=
 =?us-ascii?Q?EpyMNnCQOl9DgZXSdpLbGyNsbDVF6I9LBLPKY64pMRPCUi8nXSrBr7YoO6Kc?=
 =?us-ascii?Q?BE/N7xzcc6qbXal8kMiE5MIqdLM/yAvAvLLa+ecqPaWi046aFGDwORIULATi?=
 =?us-ascii?Q?fxXrXVnYABJhsndlQGQBvvE5eScX9NqJ5PX4+oC6GYUrmJQZu3saD8H52O5l?=
 =?us-ascii?Q?3x8EGowqb6tUbiEuuE6u0benIc3G7xsI86LMcylPY3joRNJKr8rTpBbbe4Dn?=
 =?us-ascii?Q?YMSuyvSWD4N4QWxl6dLI7suI5reo7udLA1O6Y6Xu+/zrynLRJ14y3R2zTASa?=
 =?us-ascii?Q?xVI8ny5SoPw2OfwT+LImVR2Yp5AMkI0u7OZhHcQBKDqs7by3N561qD0Ta9xq?=
 =?us-ascii?Q?+iUFaGY9dKiYKyxL4PKwLn2gtaagiAlIxFLgQhtK2mJkugb6UMBJqJR3pqD3?=
 =?us-ascii?Q?i4Cq7yMDQbUQekLVqKyd1xoRN9miTcjflmNw6Hyd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ebe90e-2c92-4ce2-f284-08dc8636b107
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:41:03.8900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7lvoVL3cXAqr2kpY96Ig8sMaiuznYk/VEmakGhmqNc2p9md459HNoCbz3iho18Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9189

On Wed, Jun 05, 2024 at 09:56:14PM -0700, Dan Williams wrote:

> > If people come and say we need X and the maintainer says no, they
> > don't just give up and stop doing X, the go and do X anyhow out of
> > tree. This has become especially true now that the center of business
> > activity in server-Linux is driven by the hyperscale crowd that don't
> > care much about upstream.
> 
> "...don't care much about upstream...". This could be a whole separate
> thread unto itself.

Heh, it is a topic, but perhaps not one for polite company :)

> > Linux maintainer's don't actually have the power to force the industry
> > to do things, though people do keep trying.. Maintainers can only
> > lead, and productive leading is not done with a NO.
> > 
> > You will start to see this pain in maybe 5-10 years if CXL starts to
> > be something deployed in an enterprise RedHat/Dell/etc sort of
> > environment. Then that missing X becomes a critical issue because it
> > turns out the hyperscale folks long since figured out it is really
> > important but didn't do anything to enable it upstream.
> 
> This matches other feedback I have heard recently. Yes, distros hate
> contending with every vendor's userspace toolkit, that was the
> original

I'm not sure that is 100% true. Sure nobody likes that you have to
type 'abc X' and 'def Y' to do a similar thing, but from a distro
perpective if abc and def are both open sourced and packaged in the
distro it is still a far better outcome than users doing OOT drivers
and binary-only tools.

eg one of the long standing main Mellanox tools that is being ported
to fwctl is open source and in all distros:

 https://rpmfind.net/linux/rpm2html/search.php?query=mstflint

Projects have already experimented building tooling on top of it to
make a more cross-vendor experience in some areas.

In my view it is wrong to think the kernel is the only place we can
make generic things or that allowing userspace to see the raw device
interface immediately means fragmentation and chaos. The industry is
more robust than that. Giving people working in userspace room to
invent their own solutions is actually helpful to driving some
commonality. There are already soft targets in the K8S that people
need to fit into, if the first few steps are with abc/def tools and
that brings us to an eventual true commonality, then great.

> distro feedback motivating CONFIG_CXL_MEM_RAW_COMMANDS to have a poison
> pill of WARN() on use. However, allowing more vendor commands is more
> preferable than contending with vendor out-of-tree drivers that likely
> help keep the enterprise-distro-kernel stable-ABI train rolling. In
> other words, legalize it in order to centrally regulate it.

I also liked Jakub's idea of putting a taint in for things that were
likely to have an impact on support and debug, I included that concept
in fwctl.

> > >   Effects Log". In that "trust Command Effects" scenario the kernel still
> > >   has no idea what the command is actually doing, but it can at least
> > >   assert that the device does not claim that the command changes the
> > >   contents of system-memory. Now, you might say, "the device can just
> > >   lie", but that betrays a conceit of the kernel restriction. A device
> > >   could lie that a Linux wrapped command when passed certain payloads does
> > >   not in turn proxy to a restricted command.
> > 
> > Yeah, we have to trust the device. If the device is hostile toward the
> > OS then there are already big problems. We need to allow for
> > unintentional defects in the devices, but we don't need to be
> > paranoid.
> > 
> > IMHO a command effects report, in conjunction with a robust OS centric
> > defintion is something we can trust in.
> 
> So this is where I want to start and see if we can bridge the trust gap.
> 
> I am warming to your assertion that there is a wide array of
> vendor-specific configuration and debug that are not an efficient use of
> upstream's time to wrap in a shared Linux ABI. I want to explore fwctl
> for CXL for that use case, I personally don't want to marshal a Linux
> command to each vendor's slightly different backend CXL toggles.

Personally I think this idea to marshal/unmarshal everything in the
kernel is often misguided. If it is truely obvious and actually shared
multi-vendor capability then by all means go and do it.

But if you are spending weeks/months fighting about uAPI because all
the vendors are so different, it isn't obvious what is "generic" then
you've probably already lost. The very worst outcome is a per-device
uAPI masquerading as an obfuscated "generic" uAPI that wasted ages of
peoples time to argue out.

> At the same time, I also agree with the contention that a "do anything
> you want and get away with it" tunnel invites shenanigans from folks
> that may not care about the long term health of the Linux kernel vs
> their short term interests.

IMHO this is disproven by history. The above mstflint I linked to is
as old as as mlx5 HW, it runs today over PCI config space and an OOT
driver. Where is real the damage to the long term health of Linux or
the ecosystem?

Like I said before I view there is a difference between DRM wanting a
Vulkan stack and doing some device specific
configuration/debugging. One has vastly more open source value than
the other.

> So my questions to try to understand the specific sticking points more
> are:
> 
> 1/ Can you think of a Command Effect that the device could enumerate to
> address the specific shenanigan's that netdev is worried about? 

Nothing comes to mind..

> In other words if every command a device enables has the stated
> effect of "Configuration Change after Reset" does that cut out a
> significant portion of the concern?

Related to configuration - one of Saeed's oringinal ideas was to
implement a devlink command to set the configurables in the flash in a
way that mlx5 could implement all of its options, ideally with
configurables discovered dynamically from the running device. This LPC
presentation was so agressively rejected by Jakub that Saeed abandoned
it. In the discussion it was clear Jakub is requesting to review and
possibly reject every configurable.

On this topic, unfortunately, I don't see any technical middle ground
between "netdev is the gatekeeper for all FLASH configurables" and
"devices can be fully configured regardless of their design".

> 2/ About the "what if the device lies?" question. We can't revert code
> that used to work, but we can definitely work with enterprise distros to
> turn off fwctl where there is concern it may lead or is leading to
> shenanigans. 

Security is the one place where Linus has tolerated userspace
regressions. In this specific case I documented (or at least that was
the intent) there would be regression consequences to breaking the
security rules. Commands can be retroactively restricted to higher CAP
levels and rejected from lockdown if the device attracts a CVE.

IMHO the ecosystem is strongly motived to do security seriously these
days, I am not so worried.

> So, document what each subsystem's stance towards fwctl is,
> like maybe a distro only wants fwctl to front publicly documented vendor
> commands, or maybe private vendor commands ok, but only with a
> constrained set of Command Effects (I potentially see CXL here). 

I wouldn't say subsystem here, but techonology. I think it is
reasonable that a CXL fwctl driver have some kconfig tunables like you
already have. This idea works alot better if the underlying thing is
already standards based.

Linux subsystem isn't a meaningful concept for a multi-function device
like mlx5 and others.

Thanks,
Jason

