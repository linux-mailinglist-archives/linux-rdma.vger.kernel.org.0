Return-Path: <linux-rdma+bounces-9096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5DA782D7
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 21:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2873E7A4EA2
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C7520C003;
	Tue,  1 Apr 2025 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FWbN9GL/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99EE1E2312;
	Tue,  1 Apr 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743536366; cv=fail; b=ii+mOALk/+mMrNaogYwOXc/t96ORHoEGpRoHqd1qjmQtkZ/+Rw2Hn0vNIyZtbiuarwlJtiXofuWFox4+YzCP0KCT+UAE45581o2NILqxnerVYg3HmmORr1Bo/AfTTpFPeW634L2bXvfHf96GbNtZudtVdxxBtTtv20g9ZmMJyR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743536366; c=relaxed/simple;
	bh=dDvRTfLqeAFQg4fLi6W+MV2wzhPZsGBenupkk+IK6mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rh8P8//hTZr+4t76rKlOVrPVFjm802t3nI4hCZf+07DSDJjzmDy1pe5MBqYn4Rk/GEUjvXQUCA2TTSZPkp0eTfj3FvP3pk2B1FUSqhjEh5MRkKUMg0yfH3VxRYETo2Oq/HX/S0LMdois++qzgvov5kim+Gmlq5F3DC8wyraVmJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FWbN9GL/; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3dA62giu3yfdXLyu/EQrn45Ha+s3sVsy7QuVjEun6l1zo7A3vB/SpIMGGMUdeBRKxHMgSlJQ6+6So08k7SuLeA5Wjpb4bDttjX22WgPLwfAEXLiYQ6jFwk3V0sP482OT+h+H/U2b35v9+9BgoKsGMwUPbdBUObUL7xYHKYxJzBVfr/qfwMLYoSCp/4Wg3XdqvaSRJGE7S2oWwp/O82p0GOwaAf3yZeJrhAHgWfEV6t3yw8pGZoXeQ0Eee2ya+h5Ndzpdt7i5XD6MV4z7LYa7yJkFUwvxZvgnMH9Ljkb1+3EH3uxzOcNjKDEWNkWezwhvmchE2YbWSnAjqNvMP4gFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb7HAxpyNLYLW3mnKobuWty9EvvUwriZFH4aUSF6nFs=;
 b=L8zqcWuisPWBLqUmj7MLjPvti0MBIj1FNYdITArgs//d2Qn/RNtysK43bOD9IiAY4jHbxqJyhMkntaQfqGSw24jDKigpKJtZpEXyzWurYd81nXMFo0E+sbXJj+0ZWvQCLIFzO5SjWAXE9PqVJ/zWMZVMZAANE2d6CBORNVTPlVm7jFw9edLcDVz/SwfW3nBb876z1OkPf5LgCUnEs16MlWfavF7rByjYKk5+iqUIiiOx0/KAI/lSfWcIN3YX7/+dl79xUp5kTJB5r1acj2x72ikp/BSlJzjNl3wNH9ZU4I3Er3+s0QCO0TuTpsg1lzb4ww0NDUVsg2huY04n566rqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb7HAxpyNLYLW3mnKobuWty9EvvUwriZFH4aUSF6nFs=;
 b=FWbN9GL/HTfymOFjpCh+nT4Eh005i6+CkWyf/bqMo3JrGH5t0gUpZV3MWKB+VZ08Nm+YKWWlkY7wGdejpcyIPZY86HnzrpXmwikujO8uLQ/9W48+oqUL5w0sji05XqU7y4gM22QmUB7WPpIXSPImNWkYnkIux+hj/D8s2QfRmU1l0UB5ukk/BbGKGLcadTnHfR0H+l70KAYvE51PCU41fdB0G6Rx1HlXfOwf04/nQXZq9m1xm/reQFbU7IoXcC2ZEh9kNeTqkMRM3ezki2YtiQ02gTl5wjrhKoUD0GM5+yoowZZaONHZHLvkrueLtUnwtlMvOuvFgTrkaKBQvpnfhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 19:39:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 19:39:22 +0000
Date: Tue, 1 Apr 2025 16:39:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	Roland Dreier <roland@enfabrica.net>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>,
	"alex.badea@keysight.com" <alex.badea@keysight.com>,
	"eric.davis@broadcom.com" <eric.davis@broadcom.com>,
	"rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"winston.liu@keysight.com" <winston.liu@keysight.com>,
	"dan.mihailescu@keysight.com" <dan.mihailescu@keysight.com>,
	Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>,
	Dave Miller <davem@redhat.com>,
	"ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com" <andrew.tauferner@cornelisnetworks.com>,
	"welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <20250401193920.GD325917@nvidia.com>
References: <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR16CA0063.namprd16.prod.outlook.com
 (2603:10b6:208:234::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6450813f-9497-4c99-3582-08dd7154e6a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tf0Z7SFj0I8YvHZ/XPh2Ajx1pQumyOyKz6AtoWFI9S588PhRRpOwcZNtsksT?=
 =?us-ascii?Q?Ll5ByP7AXL/v++7Ihi10UTqQJQrL8D4S16Wbzbc/g1qBLPbsVRIUnRIkhZmt?=
 =?us-ascii?Q?61l7UUa9OgdODyMKnkMp0Rq0rOeXZsJvUTVBkA8u8/+7w/riQXYxxmUSTMcF?=
 =?us-ascii?Q?vfxOrX/gzcUZm/qECXvpqV5EAOKDpaqzek3Q+rUAiheb7OpATLsgiIBFMEAY?=
 =?us-ascii?Q?0yFx3UbCZFKqeRW8ctx1wNxVJYACL/pUlhTcQTYx1NL56SKxYQmmfDE2RnmE?=
 =?us-ascii?Q?kkkJJFwvrbopBHrxpHi42NcYEOOjNezBEAYJPSo5kczB+qhSa6ebzja/VBvo?=
 =?us-ascii?Q?6MuVpMRtKTtMP07BNrwPIUBSZ8p/95yMUOy4mWCxEqyr9lr77WMmmFlbfdmn?=
 =?us-ascii?Q?sgBW+sb9lJafXk03P07W0CpmKUqAZ7atpSMO2bQgwTgq9XT6R7BAtmAPkPoE?=
 =?us-ascii?Q?F8cu/KpOtwnMpKYCHHekjBqZ2P1hCWU+It645GC8O1kZ3W9J7Mv4rLWyLf0D?=
 =?us-ascii?Q?nAL0/dSoUR6PgwhfESu5yRpi41+KRNSGc7eThaobhY+17aylpV9Cg73VvLmh?=
 =?us-ascii?Q?H/GUrj2MjaQmcWzID7epyw/ZlQr+s6mBKWmq9HXYy55lL7ICVNa5aQQ+1kjc?=
 =?us-ascii?Q?Iw1Dyhj1J5SICY9I7tjf6Y1esjJmQMiZxBco7esy19vGSN37BjcZNT32xZtF?=
 =?us-ascii?Q?nhXxL783NlXkldjrIXASDGM10BfauVOUWm7Fzpwrnl+5QDWiby86VDQu946Y?=
 =?us-ascii?Q?FQ8XbCMVQ1Zm4NxVYOpqoNjqIvlLWDsVrs5rNwX/TnXs7ZMhl6KUtBfiWp4j?=
 =?us-ascii?Q?WA1xZmkR8yYBwQ0q2sd1pa5lreB4XMQxje1z4wInbpdKsJX4DSuK1HW9TjES?=
 =?us-ascii?Q?ec9atShq0ofJ6ZunYIcMHLh8BsuWb24s2DeL9LikyKbKN74NJ6SS39BRVOjV?=
 =?us-ascii?Q?tLbk2VP4vO88FuU8qv86XNOvVd0FzA8fAT8aeRrbpiyn1DdQtydgwIrWJnaw?=
 =?us-ascii?Q?VtWc4GTaM8F7OXQtIaBtIiz1hdY0+xeGhr3ozFkRRLZWn+YPyghT8d8GEvk2?=
 =?us-ascii?Q?28489Sw1lniNYPO5//UEOvxO5yPOpxKz4xgmO3dpEIQO+DlfG//HsVapxMKn?=
 =?us-ascii?Q?SLu+wYkPp+dY5fuLHmnNoB/kFTqnsIIrwyiWUahBrR/cvkLmVGuh7PmgYFLf?=
 =?us-ascii?Q?AUNdMevdgAHyW7LqHP1FiC/DgpKfu4CtrgD+HgtXdvseuI9rdhaNVfPTuGlc?=
 =?us-ascii?Q?7Bcbw7Mcyakp4bFQ0Crt0E5Eb2NCswulQqVRziWKo2QINTMVfbpuYENjZVgd?=
 =?us-ascii?Q?wQyuMeC2rt8ByCu/v006dvka3/1yOP8YPgey0/qA9mbs1ojGKN7fQjOaS0+t?=
 =?us-ascii?Q?dbri7K+xNJN8vxEWhURuWC8AXoyo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NsCk2BbY4tt+FR5yVVCpMoiNU2pkflQAwPE59V74sm8hBH2LbrZ7/3eFLusb?=
 =?us-ascii?Q?zOtnjiMQU56O6ELrQCvONC/Vyoqb1w9GNERrgVIoK2KepREWGBSuqeF3Zz3/?=
 =?us-ascii?Q?afBNEVfZWytAR2QbF9lhAZsAUEFLdTvLZJjYzZbZldnCiBRFYb+AE1IjfuKv?=
 =?us-ascii?Q?pBMRb3IL1I5ioLCyTQ39xgnSwte88wqD8Pk7VDgl/SzW0OvyaubyHS7tsv4S?=
 =?us-ascii?Q?bpzs3oddHMXeu67X2qSsqfOFVNeCM1AlvS1ARv4DGbbD9rvsHb33aRK6egf1?=
 =?us-ascii?Q?3+j66XR9S7tXE0HZJadQCRWiNHuKAq8X0mft1CpHstODTvVDUoziPHUmEqBi?=
 =?us-ascii?Q?n89tD5/1IfWobAtR8gryYQpOd06T8SbZH331oHD7ykbs7iKH9Sbh9cxowqwa?=
 =?us-ascii?Q?G6zV5mlMVCGcH5QOuXY+u6gMsFT9aexM08EjzIcR6ca8OB7xaF0NLgmnAgIR?=
 =?us-ascii?Q?n1A1atQNlXWQGin4axOSkqz9Sj8f893Ibk2CSULTYStdTgr/WQEYveW6t6i5?=
 =?us-ascii?Q?na8rQHx1k1ZWqiBmxxJZTqVQMyEWfPobkLnqmdWpTVgGH6pyePRCWPHw1Iw6?=
 =?us-ascii?Q?lU+PRifxeOmpzExhiWZVc0on4vvLSLJqdhkYPYJfdSdpctBYYpaF6UhF1dE7?=
 =?us-ascii?Q?qLZnz1oTeuw5JspjT6bVST/80yDrGVHfFY6SvLZcLPveN1ntx2Szc9e2I45X?=
 =?us-ascii?Q?kx2E3omwJ5jYTeLUZe8zbAMfcYu8cPL7PhXur5EcDfXFipDlKI63Dxdt/FAE?=
 =?us-ascii?Q?RyPYsnO5wL5cwO51E4/CT0StulF0cKxuraQax82PBayklif69Ju+DrMT3+4k?=
 =?us-ascii?Q?PxOL0o7YECyiBIwkxX5+wxD4jmTbByRF02H+8WftJMapVz3GgF8T2ldPohyB?=
 =?us-ascii?Q?8VJ7JVzGb5st2RdmjiHr/fc90oAfXlaRrPquBt2BR2met26Y+CISroojSLd6?=
 =?us-ascii?Q?tx7ibfqk3zX30U+RTHXlVi9LTa6MjihUMTXezpZaj3fl+wRdfhttAwc8Gr2e?=
 =?us-ascii?Q?rjdyyJdp2ZDey5yu2sd62IxUMKYAmPYokTZgLPbFqtJa4YTb699yrg6A8Mg/?=
 =?us-ascii?Q?xyj149Lv14ygdP/kWIj2QwoZNew2aS7+m+2Z4vuzekUt1buEhf8O4joygz3M?=
 =?us-ascii?Q?129scsT6zQfdLZGOAPjsMLCYeCgWUnvGiRaOJlksx+aXjOTEsDWKU1C9ZC2F?=
 =?us-ascii?Q?YHiAMrAt0OuK8mlknq1LL5RXtZ13gq5ub7opzRKChy8LbXGplUgTLeKLKp4z?=
 =?us-ascii?Q?vdt8Nmfwn+x6Nxejx5MVr1iw+63NQR1AYjn0oTfWwijZrxcFT8OkDKrzkO6J?=
 =?us-ascii?Q?m3wqWplGNo1umxFVyoacNdbN0TguNjhETTUdeCWylDty4rssZs6OGVtOZ56o?=
 =?us-ascii?Q?feoaQj6CEpDQz+yekZI6l9X0AVv4wOU67ewbP9RzXB6FKL9CVFGyGs/oLMfF?=
 =?us-ascii?Q?eLQmi59R2L730DzFGlDIli0uQ3vY+O2QKOAngHbt9Od2CxXpfFmoxSPWpcnG?=
 =?us-ascii?Q?ABLazpAXAYR0CTra0viQdFufUm8yzT1qFEWkc5KdsXuudM64If6PxcuvPMmz?=
 =?us-ascii?Q?qZSZIhlK/dsZi2l0Gp6JDZVM2aNAG2w9p+VphiC1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6450813f-9497-4c99-3582-08dd7154e6a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 19:39:21.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYHQ4lRIt9Hz4CPqvXFhCYjVqFG6TKj3IImsJlU+G40yig9HgUBNWXJTcBe6S8kC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

On Tue, Apr 01, 2025 at 04:57:52PM +0000, Sean Hefty wrote:
> > > Specifically, I want to *allow* separating the different functions
> > > that a single PD provides into separate PDs.  The functions being page
> > > mapping (registration), local (lkey) access, and remote (rkey) access.
> > 
> > That seems like quite a stretch for the PD.. Especially from a verbs perspective
> > we do expect single PD and that is the entire security context.
> 
> From the viewpoint of a transport, the target QPN and incoming rkey
> must align on some backing security object (let's call that the PD).
> As a model, I view this as there needs to exist some {QPN, rkey, PD
> ID} tuple with appropriate memory access permissions.

Yes, but I'd say the IBTA modeling has the network headers select a PD
and then the PD limits what objects that packet can reach.

I still think that is a good starting point, and if there is more fine
grained limitations then I'd say each object has an additional ACL
list about what subset of the network headers (already within the PD)
that it can accept.

> The change here is to expand that tuple to include a job id: {QPN, rkey, job ID, PD ID}.

IB does QPN -> PD, if you do Job -> PD I think that would make
sense. If the QP is providing additional restriction that would be a
job for ACLs..

> I don't know that I can talk about the UEC spec, 

Right, it is too early to talk about UEC and Linux until people can
freely talk about what it actually needs.

> I can envision a job manager creating, sharing, and possibly
> controlling the PD-related resources.

Really? Beyond Job, what would make sense? Addressing Handles?

I wondering if addressing handles are really part of the job..

Jason

