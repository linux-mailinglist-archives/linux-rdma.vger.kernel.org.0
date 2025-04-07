Return-Path: <linux-rdma+bounces-9193-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A054FA7E634
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99A63B0C5F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19C120DD7E;
	Mon,  7 Apr 2025 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SJ8AwN9p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C79207E15;
	Mon,  7 Apr 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042352; cv=fail; b=AiPJq2KJ8d84EwvXhCz/AU8qKKEIlAczBpF1XQnAPZPeyTfSAkRhEQ0ol86aAS34tILzw4xvCkGpLMouWCabW8Wh4V6I8jyx5AulINmDZ4LH9mGgG5LGBDRUrwAdArE41ZX69NF8clVfCkmoSXYqXAWC53IMotOFvImixCqJOdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042352; c=relaxed/simple;
	bh=2K4D6I56Uwtv1o+8sLNiVmu8lcpLV70vpByA+dTE6nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jy0HUHq+cEZCHvXaLGoJaz6mh+GmtdsBOzBlwB85D69G7dPr/5M5UQXEOY6Cdk5xkIjUSTlNFjr8vMtVLGAINqp5Ey+tFYNGAaN2ODCDKfDl94fi3VkmqBoncELT/FozjkHjsWddsIh/hltDHRARAH789P+9bzrjMcf6+/Cw7Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SJ8AwN9p; arc=fail smtp.client-ip=40.107.100.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgaeaDmWG8lUJG00YaC/Mj+sS+OpqQ9vLPn/0t/sn7CBoBm1m8fe8/oLEDWs23QbY/VmBtE0N5Hmf0LPG7ZIdGeSk6KtD9yVi0rCC15UirbwN+WZiFWMhJk2bx6WotAF9ZDDPXh1Ym/3ZUqvv6GQnTQn6m8tfIrDzyEp5W/XlPvftXCCBcZojEN7SGWMbZ2tFUSdqZtmSIrDqSZlphWhRqgqkd06EidySzRkaKIE4Gj26i3GGt0boPooPpRheByEs8f4JzMTD98Jc5nEo+GKocLopAqP5pWxxJex5bzhUZ8j52ZE/RkDEcwNk8Mp+e+L2DeWWRnLlST+uyEVsFDTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLpFD9bkC53gUstIZB4vmxxtpBiAseSZfCEsdapox+s=;
 b=RLN12zxbtxPCjapOkcFUwcJxiyAlMrPINVhBCK/UIykLctZ8O7QjPBZEsMg5CUmmxJoxXYmwKEti6EVrGvyfmZ2FC+SuK5wnn0p4UwGK+UTYXXNpMGHTV94810JLuhb5NpW7yO0lzOwzat8te0yy0nVztwzkNjXq8zl8L6TnSNXRTdv+7eP0bAmzx6zPyHrgtX84b2c0pOEIfxmIXYU9eSuU7ZwcAscnQd/VP7hxXpdmm1nF1pPQiSJPY2+e7H0mW511Wm6wbFTNiD9675G+zcEAVqExgSJBnjGH9ej87Y0q7253QYTf2A873AESK5Q1JyugeS6BXWdsxwF9QXLR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLpFD9bkC53gUstIZB4vmxxtpBiAseSZfCEsdapox+s=;
 b=SJ8AwN9pvF7b9HkKx2YS0fl8DUfcoiR1l6HYsMNfJCNujgpdT9uB+O0hGlQrj0Xns0XHn3xQ3gnrANIUBqONC9vd3+J33eZo+M5N+9vbak/s5Dax1f0hMCbbgDtddKxASBgtO85dXxlNvW6NFGPXRdnAN0FwwSC2l0/6OHuK8jIPq19GK/2JIMzvPfErwEPxXcL0GTRmKqfd38//YLV8EiSuL6ttYEzpl+gFVVCL8pqduVwpK5m+C5EKGu9bFuR3zf+bP0gGk6yQTGUp2bDZYcEczQRMHhTmW/BBRaa9dgUU+c9djHg8/m1/B/LPYBtXLz9laoSoVqLhFMEld7WOLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB6886.namprd12.prod.outlook.com (2603:10b6:806:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 16:12:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 16:12:27 +0000
Date: Mon, 7 Apr 2025 13:12:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
Message-ID: <20250407161225.GF1557073@nvidia.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0363.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB6886:EE_
X-MS-Office365-Filtering-Correlation-Id: b61cc7a0-ba5f-48b3-d468-08dd75eefd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AZYDzJ2tRL962KarXZXaEKWd0Y4Mdtwv25QjMyph1Ne5EbdpON6VQQenDgT0?=
 =?us-ascii?Q?5Xqb51lo1EpFhvJ7uiKo0nZJubVwOSQtvPFW9OrwhVbYFpKNl8fRRM6obbJa?=
 =?us-ascii?Q?mi8DwYG86eEGZYCc6EQqNprf34RTGKp6+MG/30JyNPV4ipg5GzgrVq8Aifpp?=
 =?us-ascii?Q?EI/zIv5dYm3GgDKdp1l6uzP18IlwtALfiXC+ttwf6NNrOZdslui+F5BvPNab?=
 =?us-ascii?Q?KRq/GtmCN+tsmDcxJV7XZm5+v1I7fvbqHAzL5U8iGHbQLknj2C51T2GkuMBX?=
 =?us-ascii?Q?wGqhcuoMXRWijaoxmD58d2HEI0CjjzgWvFTwCSzkSQJSORqvJYWsEQPp9UXy?=
 =?us-ascii?Q?CZdcDV/9Co13FGGxsyg/6KQ7OLPCARfUqrRQMJY25Yw4pBf1fR/t+lzUSbKa?=
 =?us-ascii?Q?HqbVA3sbEJuur5/plgVPF5XsJD3+1EBl4fp93Nu0XRGnf6J9j1EmZ2vEwVOV?=
 =?us-ascii?Q?gX1rUMtJJQb43HgDnn7Pql4Qyxnys4kK3jeHX+CSfw+7EfWjLm6Kf3nImt5i?=
 =?us-ascii?Q?s9vxnBI6UNJAcQ4X4wSjUjmN7tgn7ovKVCQXgjDNOYLNVVL1Mj8honsr7a0C?=
 =?us-ascii?Q?mv3e0s1dGKqcGD1aLzVIYU0itFKtkzFSqaYtsBcA99h2xKBQ0HKHWJqX1L5h?=
 =?us-ascii?Q?IIcmQJ2sOvx7Vlh/Pxs5rCcduqD5kb/7Tcwy5a1FmFepmtUITv7wb827yhwq?=
 =?us-ascii?Q?2nIK5e2HtazYLNi8U1fN62KHua0obRdBHmH9Jj9WPgxsF/4DPLPOLuklc5Jx?=
 =?us-ascii?Q?PzbW63RgCJIHHtrlsNxqXl8Y2qVa6CXcF1HdKN3tg6hm6HxtHSFI4eNp82Gx?=
 =?us-ascii?Q?ElGIHDOZ8qPDzdrLDiiUSFQQ0emUVZOVyCDNiztg4tIL0mB22pnKNAMNjUPK?=
 =?us-ascii?Q?bYbmCiT2LHYDlXrTOI6X6vyivyUWUWCI+YeJHCUZMG62Tesd36BxOwD+1hax?=
 =?us-ascii?Q?76IDpa0SV6g+BngdmsiDNU46LUmrUprA45ga4Ue4phmh6Zs6rWgRu1incjSl?=
 =?us-ascii?Q?IwWRIkY485/FL2A4I7wFZdzLjAAKsO5T2aRTEsy8MT36U1cGR+xDvZSG4zCC?=
 =?us-ascii?Q?59pegesDtjgpB5tFVNSnJu6nWkrcmJgfMj7fQx/noWlHQn6UYO02RrMRqiWa?=
 =?us-ascii?Q?UHj46xbBeipIntqUSQSilOMFw5e+zqctm0rFQ6otmFAlBQX89K9lbXrhG479?=
 =?us-ascii?Q?ivRHezIENQuslOS7k2lPZDn/cQyjP31Ohate3JaO0yBwiVlAy8yIv4BRhgNi?=
 =?us-ascii?Q?M8q6y9TnjRAfx61XtTCDhj6jfNKKO22sMZMF5BJhiiCC90hRmHfaUrVqLn7X?=
 =?us-ascii?Q?etkuX5zv5Oj3kCw7qTi7AToHxnnYgMJuhIneN9SJL9ImDUIdhG12O5YdAjsL?=
 =?us-ascii?Q?gccn/igc5O+6r69dv0rNCh70vaAr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Euwqg2NlreddKE/WG8ttjkiaVSFPixiLDjXJuEOT8UQatrof3a8SyaoehaKR?=
 =?us-ascii?Q?3r6wfEkPLbLmIM1P8j0TPhR1f3845czF0PkT9C/Yg96wkcs//1tDcqm8WQkp?=
 =?us-ascii?Q?kjcR8x8dPfc1/Ek2pFTCvV3qBC3+M430F0XDjY3tc328/cAJktJWMHLMz7s9?=
 =?us-ascii?Q?MV3BRMtnzkmRDy2LlNH588cuKpg+5dt1/+6U0vpx4q0iLQ878DhdbEbcBuwq?=
 =?us-ascii?Q?yUkX+1sYOHCqgHEwMxUXdqRaHLOGcozwGXZIGobkBslsAhqf8yWsT0lCEnGW?=
 =?us-ascii?Q?3+nhQCselb3DNlw4vpu3y4mWmIjJ0tEH9HopYgRpB/0mwBfpNH0WXTpuG4Qg?=
 =?us-ascii?Q?xtfXhaPLA84AaNipw5VNZa6sCS1j8pXJDRB5a10cFt3D55JxpvN8UidWn+MH?=
 =?us-ascii?Q?kxGFqP3KHA9klc+Wm+ZXWwtdGG2Ay/pH0Xz76FCcgAgNnzgmtoMaLSNUJIQl?=
 =?us-ascii?Q?t0blgKNXgZPEn7RUVEG54t6pYujR3PYAAe0P2IViZnncg4X0N5j7hJd7hQnQ?=
 =?us-ascii?Q?+31jebsJoaHCPAa+j8miMNbWU5ey7lvFPkrZpHexPV3bgqREn7FlnOoyi7zs?=
 =?us-ascii?Q?AEpaJxPaGJgi+sde1k6z7Up7CTgtDyoXCa7fhiIE2s0AoQAPadJrndayETIU?=
 =?us-ascii?Q?//mDy8dlsaGLvcsOgjqOrITqNA77EOxstXZEIb8uxFPFa+1opkUfRs5SOarv?=
 =?us-ascii?Q?pm6zbTBscCKUlJ61I3KHD4ifvdTK4aqQTRG6CP+g/HSQ6bLf4kCOD+WAokiH?=
 =?us-ascii?Q?Q0W6ZfLBuEnDOcvkDg9ZkWF1zrU9qMPh2NS6yhUZ+UQeDPK1GOElmgdMhpCx?=
 =?us-ascii?Q?1QPB2MPpgpoJkyNP0DQFXgoNka3NXaEnSWvQ4VFg97zg2nFeac9uU84/5CJu?=
 =?us-ascii?Q?ERQR49OIeAD46w7UZRmkAWXu9BqmmGYI/+giXRxAUw4HLhLq+GBMApM1EPrB?=
 =?us-ascii?Q?srpd1PVQ042nXeYfoiXa6luoNbP+mD0fb+PHd7RBp7QLj6o307+Cu8l/eGXl?=
 =?us-ascii?Q?IWdvwxVfdrjmJ3nkI/HZqzwwnWArWb0MqgJgmgtBDiI8Rks1FR8m/r90raPI?=
 =?us-ascii?Q?Asbk3v8cPkXOT+4h0BOAeUPZrju8uZEi0gUo3rjx3cA02pcJhs7iJXZOORFw?=
 =?us-ascii?Q?Qq5v0m8pEkQZn688wSRMhljGNnMmkEscxRnq2nwYSCTJZjXirRn7VYeTb7tU?=
 =?us-ascii?Q?Wl9AJDgHj8diLTXhVJsCLCeuPbCR0T10H2zncygZgC8qzkaNi0CaVW2nvgxR?=
 =?us-ascii?Q?UlMPFQ0h3QL+890UyB6vYXMvmYg2hy+KPU+XZdg8h0VPnGypbKtOuGwTU7Hs?=
 =?us-ascii?Q?ea4RYGipDfHVM037tHhGlAe6mTWi0Mef/E1/WIYCMeP+SGw3zRv548PefBmV?=
 =?us-ascii?Q?o3WjmaiNApU8+XxryWofoIJ4RmQCEN4ycpNSgaFt1O+KcEGZBV8YtDQPzNQ5?=
 =?us-ascii?Q?XDAFENSfVT3I3ekiwwL9Dc9fHIGJPWxi++1VwYpqc9UJKhZsmWa38QkdGFzl?=
 =?us-ascii?Q?2RkGrjfNcSdLzHWun3psTM8RuelgwITfg56gDbXtEZn79OXIJHYJzPzNmk/e?=
 =?us-ascii?Q?7lX1LJ4t475E7dYKSmaxh4vszBOm6tkgCsr+fVnr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61cc7a0-ba5f-48b3-d468-08dd75eefd5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 16:12:27.1768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bu7TjYGs1TCr7ffo7+Au+VWARHZhYcbnUyqKfhBCGraOkwwZarCRNqF4Bso5MdKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6886

On Mon, Apr 07, 2025 at 11:16:35AM +0000, Parav Pandit wrote:
> > > This all makes my head hurt. The right user namespace is the one that
> > > is currently active for the invoking process, I couldn't understand
> > > why we have net namespaces refer to user namespaces :\
> > 
> > A user at any time can create a new user namespace, without creating a new
> > network namespace, and have privilege in that user namespace, over
> > resources owned by the user namespace.
>  
> > So if a user can create a new user namespace, then say "hey I have
> > CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
> > resources belonging to my current_net_ns", that's a problem.

But why is that possible? If the current user name space does not have
CAP_NET_ADMIN then why can it create a new user name space that does?

And if userspace does have CAP_NET_ADMIN what is the issue with
creating more user namespaces that also have it?

> > So that's why the check should be ns_capable(device->net->user-ns,
> > CAP_NET_ADMIN) and not ns_capable(current_user_ns, CAP_NET_ADMIN).
> >
> Given the check is of the process (and hence user and net ns) and not of the rdma device itself,
> Shouldn't we just check,
> 
> ns_capable(current->nsproxy->user_ns, ...)
> 
> This ensures current network namespace's owning user ns is consulted.

It sounds like the design does not store the capabilities inside the
current user_ns, but it logically stores them in other NSs. Ie all the
net related capabilities are in the netns.

Presumably then we have a mapping of every capability to the proper
namespace to store it?

If the container has a user namespace and the net ns uses the same
user namespace then you get the appearance of user namespace
controlled capabilities...

Jason

