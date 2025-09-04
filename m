Return-Path: <linux-rdma+bounces-13098-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C0B44828
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 23:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E41A40314
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 21:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C01129A326;
	Thu,  4 Sep 2025 21:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZaELmJzZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC5287256
	for <linux-rdma@vger.kernel.org>; Thu,  4 Sep 2025 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020300; cv=fail; b=pvm+A5xTfGGwSAdnQLDgdHEQzapa/iuW8kROQyJFbr4fppWDscaE5K8vaMWpqcqDXVD6VahQNdmBccUyfhFntoKmJGnudOUQEQPmpOFCnLodb2xVwTFKWjugKuIv+5VmPVx8zbR7fvGPyfKxOSYCUHpBidLDtXa2X0E4ofc92fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020300; c=relaxed/simple;
	bh=cWyqhekACcbP+AnmqcpDSzCh4RqdwD9bDdBvIn1P9og=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I+1elpr3DCwyziYSO46EENEn2F1tTeEPNOCcJFS9oJDiWgOAifWJgtv1f0MK+Ytq43tU+stZI+K9S7g5tWo6A9XoXG2gF8mjGUOGc4yn+dt7SOKy21mELxCBIhn52jouYIwXpVFsj2ONqyR7827lwX4a34H9ihthcNHEsZN/aHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZaELmJzZ; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqtfjzRawy5nMGUALvIjDLIPAVj3q1VohrFQSpVIju9VBui1T+LvLawcZTjb9EC0KZ6nMbkUi51jo1myTf0aRKM2MirUVPGnYKdUNR/jvZiIySnPo/bSrBWG2TkEcKWrgtmAGjhKCs8IunuoQ4VhO15DZzERk7SdqsZgLXzuWRjpYV275PJJ9kQPy17kqfI3vnffCZtBf+R3tHnR8R5DHuYsgPXjMDwollV+HgRA+HMG6MxHY3rvbZEIb+/0gczaShTwHlKdNphcSHS9SYcfDL466W15nnRRPLLYMv/5I7gGEvP3dIcDJBwj/0yz6LdiknxY5FaPilJdVEW/NhZndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgQ7ExkwtokPfXkOuWNqKjdo2mlT0vYnITP5KRK5BSc=;
 b=AhMkecvWBEShroBTrSW1BE6hwySuX2Y2EMJ8u5EdpQaQJMdtzxlShoFNPC+2GZxsIZ4ttIbLbLfFkn4x9RonCjuRgswRHBhZe5Jv6sSazPyMFvG9TVCPjMfes0EuuXuSI0B+70FAXynTVxk2StOkOxnWsUkItU/T6tKFIVkk8gHLsw8Oy3BYELsxHquRQxcW62VOPHBh9FJ7uA+EdFOmgvBq9um0Zcvhi+JgtHjGjMY+mqG5eRhPPb89YKGmQI+oUZEDL6oCnbKexlmCFkKI2oLTdNgE2E85XWn3FQj5Rewn/6IZVi+rk9tU7J9n0I8NP4Lec9v4KWI1O4hvjs6nlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgQ7ExkwtokPfXkOuWNqKjdo2mlT0vYnITP5KRK5BSc=;
 b=ZaELmJzZroifVp1kwDCfrOpxhpWEGrSa8vBBn9ev+BG1wovZgq+mJRH3fSdmCZmlr70r7VRGv2aN1/zOge52yvBuHXTwYD4H4TqmdqpMYXv8sbmR4cZC6/39RSySn+ky/ThU3fXmIV0XSg+Wc+f5SMCUxHM5hZTrN+SFEr7Z5i7jmnshtwmDzpoLg1coxWVMduEi8YuGEnzIyLcTSVFcH+N/3i+BjF+m2LerpciDQ+D0UV66B91HfAgN21sHo3NzQGqEG8p+3awcsm7lmDd1AFnQws/sLcVwOPvVCrawphvVf/z7pJCtGd+t4U5RTenuQWyfPBxWt1dbG6maxnu0Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 21:11:35 +0000
Received: from BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe]) by BL1PR12MB5205.namprd12.prod.outlook.com
 ([fe80::604c:d57f:52e0:73fe%4]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 21:11:35 +0000
Message-ID: <223b8a75-5a82-4aed-8cd8-6cf9e9a3c1e5@nvidia.com>
Date: Thu, 4 Sep 2025 14:11:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: cmtime changes
From: Vlad Dumitrescu <vdumitrescu@nvidia.com>
To: Sean Hefty <shefty@nvidia.com>, Mark Haywood <mark.haywood@oracle.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1e5a6494-91fd-40a3-abaf-a614bc3f0e2a@oracle.com>
 <CH8PR12MB9741FA55780650C84CD3F807BD3BA@CH8PR12MB9741.namprd12.prod.outlook.com>
 <fffc36f9-8463-4397-86b7-fedc54ffcb70@nvidia.com>
Content-Language: en-US
In-Reply-To: <fffc36f9-8463-4397-86b7-fedc54ffcb70@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:a03:80::33) To BL1PR12MB5205.namprd12.prod.outlook.com
 (2603:10b6:208:308::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 53135cbe-000b-4c90-74f3-08ddebf7a174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZORnVEdmVNUi9jQm5sVXZwemF2Ty9LUzVSTUtCTHhnMUxFcURLWXFua3Vw?=
 =?utf-8?B?azJwdDc4K3B0dXI3Q0QrSDNka2xoZTRFYzJFc3NzODdESkxiT2cwaHlxOE83?=
 =?utf-8?B?czkwRCtLbmpKZ3pGVHhmdW5rcVRscGNtaXdwRkhzM1M3Qi84REhqQ2NBWTFS?=
 =?utf-8?B?Q3c2SEd0RDUzL051RTB4UmtwNFFaVytBU1B4U0x4UjRxTExQUmQ1dzc4Q2Uy?=
 =?utf-8?B?a0RaM1piVVd0RU50cFhacmJlNlhQaHVXMktaYUY3MEJGYUZwZnE1WUpFNlI4?=
 =?utf-8?B?VWl3cThYMm5yT1lnRGg3bHREVm5UMXVxdmZGMnVOdldmSDg5TVZpNE5SdkRx?=
 =?utf-8?B?VTFtc00zbWRFZjJBT2EySWZhbUIzTnpncXJOT1IxSGg4WUo3R0c4cXZQL0ll?=
 =?utf-8?B?N09WYmd3SXZ5UmxFS1NzMysycE8vbnZQNEluMXNxemxWNGtMZTNHU0FoWlZN?=
 =?utf-8?B?eTFRZ2ZVS0ZmaDV3cDhhdkQ3azRvdzNBb0pTU1ptMWQ1THEyeDJtbFpZNDVz?=
 =?utf-8?B?bTRSWHk0d3UyT1R0ZnJ2NTJha2cvTStjbzlrYWw4U0lVMHVNNHYzY1Y1TTl4?=
 =?utf-8?B?V05JRVd2TFIyVzBnb1d1TStGM1pwRDJ4S3UwMHdhbU1Mc2FGWEUzMkVnSnJH?=
 =?utf-8?B?U3NpYmNYVzNCdnJjQ1BtRjJuc3J4VGFuUE5YWnBFWGh1b29kK2xMWk9vOGpz?=
 =?utf-8?B?ODltUjFkdlZMNGlxQktyYzJycmphd1VXS1hwL0V1dUN0aFhkSm82dEdnNnUy?=
 =?utf-8?B?bGx3M0wxR2JCdithc2xlcWpkUHRadmpXdnViNU5yQTZtQ09DTlkwTWF2bWdP?=
 =?utf-8?B?RmhYbnR6dkI1MDdlQW5Nd0xMQ0tMOFFGTXpSUXluV3VWeWd0ZW1wSjRISkFm?=
 =?utf-8?B?c3R3VTl3RlFMQkk4QkJwMGNnSWVDUGZRN2dUS1R1MGIzckcvNC91KzlGQlJh?=
 =?utf-8?B?UzVUdENpa2swL2ZkTUsrZVVMMkpCcnI0RGRpWUZWdFZBV1BmSmxPZlZPeCtH?=
 =?utf-8?B?VzJDdlI5WnBmN3RHRCt0Y3hvM1oyZ2p6aFB3L0tLZm9MK1JnMlBibW9wU2FV?=
 =?utf-8?B?QWJ0OVpZM2tUMldUajN1N0lnanFLRy9DRHk1ejZibUk4aUlaeGZOQ0NWMTUz?=
 =?utf-8?B?SkJ2WWUrbVNlc1BtYWlXVTYrQVAzcWpIWTZQcTdlNWZsQXp5SzNZNG1zVTg3?=
 =?utf-8?B?aW5WaURheWNKWWVyYmhKaEVKY1RpN1ZzZGh4MlFMVm5mMFNuUTFleVdCSGVz?=
 =?utf-8?B?VlY4YVYyVjlVczdSMis3Nzd6cWcxWVJUZUg1ZzFzNFErM1Fub1BxeWFhOG5P?=
 =?utf-8?B?WWgxNFlHVHBMWWwrdFlqd3hiNzQ2MXhxd2poemY0Smp4UjUzN2tYN0pBbWlt?=
 =?utf-8?B?SG9POWptekM1UXRMNk1DVGl1Rysvby9zQitZOG5SU2htZzYyVG9ydCtlUENH?=
 =?utf-8?B?VkZGQ01JVlk0RzU0clN6ZkFCMUdPY2svalVRMUNabFQxVzBiZHZ2T2tydkpp?=
 =?utf-8?B?NjI1SGNLZFdkOW5jNzNneDZPdnF1c0FnbXF4SDBYc3ArVFF4bldIMmVCRVQ2?=
 =?utf-8?B?SmhIOVczcTdsQ0JobFpQVDJyTytlcm56SjV6ZW1XZlZqcnU4aG1LTW9wUUJI?=
 =?utf-8?B?dGdES2JrakR3dUJYbTN1Z1M1U0U4eW5hbjNBcGN4Z0hzYnNMQTg3MlAraWxp?=
 =?utf-8?B?ZnpaUW1ROVZ2WU1LL1pPV01iYTZmcEhJZzlFa2lSR1gwUTlpL2RobHU1UGlh?=
 =?utf-8?B?L2UwdVlnc0tjTnZXNlVxTU1lTDljRkVoZzFUMCtHajltaXZiSmRkSjlqOFlv?=
 =?utf-8?B?ckhuY2Z5aEpVYXQvT1J6MEtQZWpFSlVrdFR5b2tpL1c0NjQzazlENzN1Mnk1?=
 =?utf-8?B?aEpDSGNCdEcxR096WVJxa2gyaHA0dVhRQmxZMFlBMVJRcHJReFI2ZmVxcmNr?=
 =?utf-8?Q?VbId7KVuoCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjhYWUNvRE9tUDdGem05K2UvbjNjQ1VyOGZSRXFwTHdYUjkrYXpFTjFUeTVK?=
 =?utf-8?B?bHBwSXlXMkg1NkQ2R0JkcnFuamRPQnpsa3BSV2hFUFVFVVpPTGNVdzV0aFF5?=
 =?utf-8?B?ZHVvcXNObHprOUZsNjVKa0hUVTM2SGxBeTRqNEtBYjN3UGVUV01FUU1qTTkr?=
 =?utf-8?B?dm52NzJwVVYzUFJYTnk3bFpJa08vMmJmYVBXM3JQb1AvblZoT2Z5K1QxTW5Y?=
 =?utf-8?B?c3I1SklSNEpPa0s5RmpXZzlsQ1NHSTJnTTltRXJoMVY1aVlnWU1kbzNVYy9V?=
 =?utf-8?B?ZER0VnZIeG1vb3lCaHZLWEFqdnB3aElaVjBNWFRLL2dlYUlWQi9JTXpFblFs?=
 =?utf-8?B?VE5DUDhma0Vob0htV0NDNVpXR0tHdmVIdG9QK0dsQW9nZ3l1N0hPc2tLa2tH?=
 =?utf-8?B?blh3N1krVG0vNjdPYjdXZktEUXFGdzJBa1BKYnNMSVBhWVQvRE5SSmxNMlhP?=
 =?utf-8?B?RG8rL2E5OUphRUxuMERsVER2MCtleVNOcTZiMGVDbzdGcHB0MGFtSXFxaGRF?=
 =?utf-8?B?QnROdFYvWEg5aFdNYUlVTW5KRElNSDJZVHo4ajd6ZmNUZXhuYmcvUEUzb2Fm?=
 =?utf-8?B?NTJYSStKTVpJUHZ5Nis0N3V1OHpJelMvSFB0aGF5Y3FyODBWZGVIZDBnTzlH?=
 =?utf-8?B?OWdUL0twMEJ5Sko2eTlabHZOQXp6ZUtzdG42Q0ZCQ2dNYS9MWHBUbitpb1VU?=
 =?utf-8?B?SnlrWHNxNUJ2cCtVZTdpcys0dlBMVzdaa243bG9QZlJWNXUvaUZZS3VBVGUz?=
 =?utf-8?B?cGMvSlRFaEUwakh4ZEc4RGZaOHczcEsvbUkyM3Q2YWdxOUFMdW5uakI4Vjcv?=
 =?utf-8?B?WC9jelQzZVRNSnNKanpaY3hVUU51M3NvSCtYN0lNWDVnZTdGdFkzd3BObk81?=
 =?utf-8?B?aFdnQm9Xblg5Q29xK1hTOWliSm1OWk5HNlVlOTVKUjZVc0J0OUc3cGRnRlhL?=
 =?utf-8?B?Rk9oNjRVWTNMeWx3M0NPUFRVUjhBa1NJQ3ZEUExoQjF0aHN3NEpYNjFPWVJZ?=
 =?utf-8?B?R2cwR2tOL1V5RHR3dmZ4dHFkOERTNk81anc4WTRUUUYxYUYrUHJFeldjVUVl?=
 =?utf-8?B?d2dmZ3JKUDdIcFVJKzM2eE1reGFvYWhOeE5jYjllTVVsVlZsMlRxdTBySmwx?=
 =?utf-8?B?RlVFcWpuL0lUcjRZeGhYdUxFN0FUamZwYlpjUlU4SmpZTnpBK1JUUnprcUJh?=
 =?utf-8?B?M2RXZnU4a2VIYUc2cDFJRjlRMHBlTDRsZUlHTzdralMvY0RGR3EyeHIyUXFF?=
 =?utf-8?B?NnB6YzIzajB6bDJZQWZ0OUliekYrbHVXNjQrWU1lV1hHaEg5Q0x0dTRGY2dX?=
 =?utf-8?B?TTlCZXdmM3g4ZWpjMkFLUTNuL0hFeXdPZndPOVk5dU9PNUp6b2t3ZmQ5MDIr?=
 =?utf-8?B?by9tcGlhU2JsTmJFSlVjZEhBdkRqV2hLZzBFRE5udU9ZWjFqeEZtNzhIaHNa?=
 =?utf-8?B?bmtUMUZpY3pjVW11WjRjcVJJZXlBL1dmc1hoNzE1NnhKZTFraityT29nUERv?=
 =?utf-8?B?ZzFaa0hmVFV4SmlIZmZla3RjZmxhQ0hFaU5PdElmclVjbGd1OVFDYU9GZmlV?=
 =?utf-8?B?SGZsMEphaERQQWdRN1ROSm5YejlWQ0dJVDdBSkVMYUZZcWdYM21VeUhPWUpv?=
 =?utf-8?B?bG1xTUY5c3lmL0xBSDRSL0cwMkZ6eHJocUdvbEtxSTF0WkxaNXV6dHhndXFo?=
 =?utf-8?B?NWdhT0hsZWM4ekZTWEl4SDNxY3EzQXVQRlA1MTJYNEZsRmpLQWtacGgxUTlL?=
 =?utf-8?B?UFVoVmlnT2VZWGhDdDFZUlFDWTE4VkdHbmtya1JBaVpCcGxuWjBYWTFOZEpm?=
 =?utf-8?B?Q0ZGT0dQdlRscE8zclFjcFpSSzRzM1k1T05VMTdydW1Zd1BGUnREeS95c09w?=
 =?utf-8?B?M3h5OXRwQnlvWEJWL2RmVHF3eWJCa0w2YzNqK2FOSEtMTCtoUkFQdkNNYkFC?=
 =?utf-8?B?SUo2ell0VndSV0k2TTlGSUtlMzl3TjdkeVVzbkJrbjA4akdKbit5b1ZENldO?=
 =?utf-8?B?OGFmSlVDdkd2T05qM1FUOWVmdVQ4T3VEazRvVThFM0dsd2R1ek1sZWtramxa?=
 =?utf-8?B?cVloY2lBRnFFaDhjbHBSRnNWWVptbDFpQ0NRNHl4ZG1MbksvNmtXcUd5alhh?=
 =?utf-8?B?YWR4dld5N1ovZThqSVpVOUtzK2c4QWtaS3NtN0J1R1FYdTJldnBZWHB6SDk3?=
 =?utf-8?B?T0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53135cbe-000b-4c90-74f3-08ddebf7a174
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 21:11:35.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XuUGiSqv6bb/HRgT4oUcgTMXuge8ErMuzGErffElsFWReqHKgmTS/GudI+QufL3RzC9uPn4lrxZ7RQ1nXrruQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466

On 8/28/25 09:10, Vlad Dumitrescu wrote:
> On 8/28/25 08:35, Sean Hefty wrote:
>>> Three patches to librdmacm/examples/cmtime.c last month significantly
>>> changed cmtime usage:
>>>
>>> 93bf54a43de2 librdmacm/cmtime: Bind to named interface
>>> 67879d9f22b7 librdmacm/cmtime: Support mesh based connection testing
>>> 0892dd7700f4 librdmacm/cmtime: Accept connections from multiple clients
>>>
>>> I didn't see may update(s) to librdmacm/man/cmtime.1. Was this an oversight
>>> or is an update coming?
>>
>> It's either an oversight or the changes were unintentionally excluded from the PR.  Adding Vlad to see if he has changes.  If not, we'll update.
>>
>> - Sean
> 
> I'm afraid is was an oversight. We'll have to update.

PR is up for review at:

  https://github.com/linux-rdma/rdma-core/pull/1642

Vlad

