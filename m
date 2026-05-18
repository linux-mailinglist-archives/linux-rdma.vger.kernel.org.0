Return-Path: <linux-rdma+bounces-20897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPcKMKDuCmo89gQAu9opvQ
	(envelope-from <linux-rdma+bounces-20897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:49:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 674FE56AF71
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 12:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB493118DF3
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 10:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B13E8C68;
	Mon, 18 May 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AF+PWkxE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3253EEAEF;
	Mon, 18 May 2026 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100677; cv=fail; b=hjCQLrxVxnGrpzL1hM9mihb9fG+uapUGX0J0ioLp/aPVOGIZ8oaodM0aPl1ea86ITr6lqZBj+D1bPmXLnL194ws19te4J1zws3vtpIyIPU7WEt+/7drSJ15ho+H1ceeNQO3ci0Svldvtgb0yQbzGWrtarCW3WY3X4Lj6cIgX2go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100677; c=relaxed/simple;
	bh=vXHgLqwzywTz7YxY07glvo/wF9/wONsPyWa4brb88Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCkwXVU7GCn8mDCurViBy9EFgULHXopnY2qdVp/SLylibfK7BsehWQSTVkan7lF/u4/7X8SgNGyBAxRGz73bY46Vn9awDJiVne+cDU0gLy/mbmB+vqOhhQIJkF+f5TAGoXD3UPFAFZrLhXKNRUGIyxtV5SoV7rdZAMOxiPIAlHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AF+PWkxE; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpJ220TSmhNv9Ra+XKIGbLz6UAiAzEZP8AnQe1Bcw2+VhxSep66bjmnrQGv9Ea3nwRIzqvLY2MLfuVNWOomZvJoP5MwcOEAsRNUZ1gXFJJu2X/DlkcUeOco74v7RC/pYCui6y+qQbCwgO0V7pwTKVFd5kzySYnhofzjP8cLt96WrrTBKDUldIHjZyEMSwui1e6xk9vieU1qjDfCxR3/kLf72+/AiEPvg8eCj7ucFmhY1El3d5WznU0zJws4JZXEgBTb96dI3O4Oj7Eb0xKHfn69NpJZHEqLkIZf0oCwuPW/eL0t8uVQ3PClAIU/C6VyBsGGWlAg4DO61Vbrs4QYL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak/LQubX8kYkGnJKw2fo0OttR1BmpdujRh1Y21r8Xbw=;
 b=Ce2xccI5jYTm4jOcGvqOs83svlgbi/4mCrqvsYMJqJf8SxfE9YOeYOAnEcTBJ3mSW7GgaSY/7WTsBzdylOGlenzC9uPXlODZDdZu8UbUDEdVvhQK9yQLYXaoMx0GB76MAFfQnI3qSOO4OyJtxlbVtKYW8jkLli+yvR5rSDMl1bXBpSP6gYFXU+Dkm2fBuDBrKzTEP3lDEr1JHJmPiRhl4QueqTuvmbceHAVuRl76aKR5E+xGMngaWEkmJ+ONhAqt7SM3FflTFSQDl/ASOukjDKMI9thK9tmWS4P7EzdOa95+gnvayN2QD27rXqNLXC7VxHvGl8HdGpx5IhqSlnFUjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak/LQubX8kYkGnJKw2fo0OttR1BmpdujRh1Y21r8Xbw=;
 b=AF+PWkxEgu1avwnX20N+L/4Aoav50kLgViLalyOnQun7ToC0P7wnuN4KyabQB2pOntXUbDvVwL70zR66G+bX4fBPlzKk0TaMPcWUuJWkAoLZV/OsMvQBI9W1g9jjsM2hrwfZtJO5i7klvs6f8y1BHVTRGl+ziwREHTo7p/4qM6rA1acsPo2qVf3Tz0OL03guP4OC/OirovwVg7o7WecvvpqUHasx2wuXaSnk2pAgbMdaGxX/x57m9sRU+n029Td5wudV09d8YyC8NtR6lohk11x6jiSUQvnGnL9HVGiRA1toOH0Gscep1MCV39BocGrDz1IqL+AiKeXVhpbexuRJKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:37:31 +0000
Received: from DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd]) by DS0PR12MB7928.namprd12.prod.outlook.com
 ([fe80::5420:4724:4733:9abd%5]) with mapi id 15.20.9891.020; Mon, 18 May 2026
 10:37:31 +0000
Date: Mon, 18 May 2026 13:37:27 +0300
From: Nikolay Aleksandrov <nikolay@nvidia.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5: implement max_sfs parameter
Message-ID: <agrr57EgAsBANKAO@penguin>
References: <20260517112700.343575-1-tariqt@nvidia.com>
 <20260517112700.343575-3-tariqt@nvidia.com>
 <IA3PR11MB8986745A7DF8DFE5EDE7D6F5E5032@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986745A7DF8DFE5EDE7D6F5E5032@IA3PR11MB8986.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To DS0PR12MB7928.namprd12.prod.outlook.com
 (2603:10b6:8:14c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7928:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b951261-818e-4853-8be2-08deb4c976e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|11063799003|4143699003|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	BW0paEDCNPJUQ97rtWN/a0fmA9eTyFClDZOWYDLH+ZclEEOvz7MGONdhISKonhqTib1U1zc5ZNg12rVI8pAXjECww8LykL+Hmy7jzfQhHDaXbFMcPfemsaRJskWKqARX0dxPEmPArH0aFTSKH2UF295k41uKjATYMwfqg5sb60JhkGgvB+56wZ2rIDuzSky4KRbRR8BxikhfBIrXkiWlTWIUL3AZDdckRGRAnjYtCcG35w/JPBpVf8WuqmsCMu0ZPQJS3WVMG1eJ4scNW7jhdLTuL/+cyzowlKEVdxGYC2LJRQIiy8ldWZOCRLBs0/6TbH7sRjoa4ak17cnce9izkKPJIA7v/2dwp53vHhsi+QzoOGbkh4rSeyG5ONhiYFYejj/FCFGkfTssr+VIQU1YyuouCS1LcP4iVdn0M/m4nj4Ri26u1+gqDjrW9/u2NeVa7ThCKIwklZZTXsgsKN1VxaB6qO9rhYGMGs5HoFM673hqeXfAmPJfR8cMolWWYWaa3tSKTiseuJ+YrjeXl1jBPZi9/68Q+oqQ0NhB65/YcZuElDupdYIUVL2zfA0aVY2Q1Avc+SvgpSZz8Ixsd96md6OR8JKi0jbsrb/CCGd8HdqVXYaf92qQC1Y/cVvj3FK6W6phEZlXXWSkxCsHHfye6Z2r3mzlWNmm5WJSgsBHAn9fztuElsGwgirZe5nnoqQZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7928.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Df0zzaHT0xKYrOcEGX7IWnsMNRFQqwmBUga9vTJ94UbfMTWIPRzIL6DbiUf?=
 =?us-ascii?Q?KqXPFb84o3jpJ56188rhEhxBLbEKb6vIg2EGHoiRQFcPVeWakMXehONtyXIx?=
 =?us-ascii?Q?UCWvZNYDwGy2cimv8h357YgTsjWJOGw2hH64P5j6IJtmW2IcMckR/rCtmINd?=
 =?us-ascii?Q?3xRDM/eF+oncVQf/Vk40BmjG/Hz3zBNVQkqUM3d8P64Q3uzE88JGdFhq82uS?=
 =?us-ascii?Q?gLE0rvRiKw51AE8FuMeKk/AqpyI1jrb/+ysnjAnF01vZPyas1dgmPs+9lKWH?=
 =?us-ascii?Q?njwcTmPVZkhKlPO5rDg26QpV/L+zGMynF/QkSiznRRzvZlRQlhjvqs1sYzrU?=
 =?us-ascii?Q?HkcuFlbk2kCp2lyEag6DMBaIS2XXpRg94vmh5BvSWrZtoX5eAlS7Uj8OujJY?=
 =?us-ascii?Q?s0gGcIm7mKHKcxyylKgmH+3FmT/Tv1PRlZP4VrBg0WB+lkFaUhwHnB8Y+nVw?=
 =?us-ascii?Q?Eid8Cd1NKvb9bSePWiVyHW92OsQF266XGa6Lk8zsDr7/O11Z3Lw0kKozdznx?=
 =?us-ascii?Q?KwhNdMH9O59JvgbwqUNCXClIW/PhYpkCM6nozX71mlMAYZm0D0fDugqgO8KK?=
 =?us-ascii?Q?C+bRxKCAur85Y2HfWKPDhdRobdNEp66rN2BDQ93NO6T7V85XszUD435x94if?=
 =?us-ascii?Q?26kJrI2s4qOGUg1cDrMsSMxRUkyrOD2mA07/AnLWjR6HeFwnrKwUM5Au80VB?=
 =?us-ascii?Q?kbiXqLW0zvlxqz0G/4lban7cLA2svDUk+nU0mbINWmA0ofjOX2iCxviGHfaL?=
 =?us-ascii?Q?RT9wN/jakuCaudvJCNs0caHM1L+1kB6V+C8hmWeJH2IKTbSHjbScpxQbEa+i?=
 =?us-ascii?Q?H2zaB1WjR3U9AHLBroY36gKpkZaF+CcZYy0ClqoyzSMWezWo9n6HDcXCrgu5?=
 =?us-ascii?Q?TzkV/09zZieDhuQrBAHQZlZ30RTyATT6hHkvK9eS1NJ8PsUPMnztLp74qElT?=
 =?us-ascii?Q?uSCfkf1CUi8K+Uyf1jz2XDimfeBAlUBtyqsj22sQAmhnThUygULJdram68pH?=
 =?us-ascii?Q?2y+oj2m0HgPAjEKbXvt3x33BIHZI0EOObDsqsD3o20TnbZMwTAEMaj1IXxYb?=
 =?us-ascii?Q?3bEw7v9rOtokewy60kQ2uZRchPRyj1Ff1wx4GaiRFaItguGxUu7aKEwd1Z+U?=
 =?us-ascii?Q?NzJMASRuw4pLDFEYe3/YeRKCzRSQJM3iIJviE8ErhzHDjmsWJv6fKkQ2pGH6?=
 =?us-ascii?Q?ool04gtjB+mRGjVyaMWc9mggV3+oXqlOvdJwg74WPqgiYH9GEIvCXNFzV3la?=
 =?us-ascii?Q?wRLGqAltJdlmHEweS8FQrKA9zcid5/126N4s2wQiKftkU58wV7V5ggqPQzcX?=
 =?us-ascii?Q?2orT6UooFDnwWrVKiOYtOWDnVBOV8KkGCZXWtBIYIxVgf7tny/Vrfo/A9fsR?=
 =?us-ascii?Q?dXrr77g+v+iIBITm41m9Iziwhv8qVW9InQjZ110Jrkq982plE8gloFaMyI0G?=
 =?us-ascii?Q?vYLVecVoWjpb9Rs7BtHdswk4JntF4eaEF3mAokfHkph8DUiNvTqP1EZRZxSm?=
 =?us-ascii?Q?dEZun+t+h4Km1hwm5s2v0hVIYeyv6dNszNB30FpyZUymmCoaHTttMeDI4JsN?=
 =?us-ascii?Q?2Td8JvdZssx3D+Dr2vN1ZKZZCxK5+s4il4jqtPSNxBuWoCDN0GcAAfnAOIJZ?=
 =?us-ascii?Q?ESTtUK9vmb+wPHgBoOrsC9quZM1zEOgEMsLtcLTabEBJX5PxbUwzdnmWuY+1?=
 =?us-ascii?Q?j6jZUKG9JTRh3Z2JeleWvlPP1ogeTfGhzL/7Yy5xVajqknxWnwjEO75HkVlU?=
 =?us-ascii?Q?RSBAM+rB3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b951261-818e-4853-8be2-08deb4c976e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7928.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:37:31.1361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7fSFTpnmp2Fw4oK+N2O7Y8vFAZytBdrR4z2YiJy+nx1mvSFuc3Rsx7p2ITNpb9kVfjIgi0lLDgY3J6Ey+iVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287
X-Rspamd-Queue-Id: 674FE56AF71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,resnulli.us,lwn.net,linuxfoundation.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20897-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolay@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 09:05:52AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Tariq Toukan <tariqt@nvidia.com>
> > Sent: Sunday, May 17, 2026 1:27 PM
> > To: Eric Dumazet <edumazet@google.com>; Jakub Kicinski
> > <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>
> > Cc: Jiri Pirko <jiri@resnulli.us>; Simon Horman <horms@kernel.org>;
> > Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> > <skhan@linuxfoundation.org>; Saeed Mahameed <saeedm@nvidia.com>; Leon
> > Romanovsky <leon@kernel.org>; Tariq Toukan <tariqt@nvidia.com>; Mark
> > Bloch <mbloch@nvidia.com>; Vlad Dumitrescu <vdumitrescu@nvidia.com>;
> > Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Daniel Zahka
> > <daniel.zahka@gmail.com>; David Ahern <dsahern@kernel.org>; Nikolay
> > Aleksandrov <razor@blackwall.org>; netdev@vger.kernel.org; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > rdma@vger.kernel.org; Gal Pressman <gal@nvidia.com>; Dragos Tatulea
> > <dtatulea@nvidia.com>; Jiri Pirko <jiri@nvidia.com>; Nikolay
> > Aleksandrov <nikolay@nvidia.com>
> > Subject: [PATCH net-next 2/2] net/mlx5: implement max_sfs parameter
> > 
> > From: Nikolay Aleksandrov <nikolay@nvidia.com>
> > 
> > Implement max_sfs generic parameter to allow users to control the
> > total light-weight NIC subfunctions that can be created using devlink
> > instead of external vendor tools. A value of 0 will effectively
> > disable creation of new subfunction devices. A warning is sent to
> > user-space via extack (returning extack without error code is
> > interpreted as a warning by user-space tools).
> > 
> > Signed-off-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> > Reviewed-by: David Ahern <dsahern@kernel.org>
> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > ---
> >  Documentation/networking/devlink/mlx5.rst     |  7 +-
> >  .../mellanox/mlx5/core/lib/nv_param.c         | 83
> > ++++++++++++++++++-
> >  2 files changed, 86 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/networking/devlink/mlx5.rst
> > b/Documentation/networking/devlink/mlx5.rst
> > index 4bba4d780a4a..283b93d16861 100644
> > --- a/Documentation/networking/devlink/mlx5.rst
> > +++ b/Documentation/networking/devlink/mlx5.rst
> > @@ -45,8 +45,13 @@ Parameters
> >       - The range is between 1 and a device-specific max.
> >       - Applies to each physical function (PF) independently, if the
> > device
> >         supports it. Otherwise, it applies symmetrically to all PFs.
> > +   * - ``max_sfs``
> > +     - permanent
> > +     - The range is between 0 and a device-specific max.
> > +     - Applies to each physical function (PF) independently.
> > 
> > -Note: permanent parameters such as ``enable_sriov`` and ``total_vfs``
> > require FW reset to take effect
> > +Note: permanent parameters such as ``enable_sriov``, ``total_vfs` and
> > ``max_sfs``
> I think one ` is missed after the ``total_vfs` ?
> 
> 
> ...
> 

ha, good catch! there's a missing ` indeed :)

> > 
> > 	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_CQE_COMPRESSION_TYPE
> > ,
> >  			     "cqe_compress_type",
> > DEVLINK_PARAM_TYPE_STRING,
> >  			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
> > --
> > 2.44.0
> 

