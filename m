Return-Path: <linux-rdma+bounces-5847-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3209C11E6
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 23:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307781C22990
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 22:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB8217447;
	Thu,  7 Nov 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcBnaTCF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E3B192B73;
	Thu,  7 Nov 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731019071; cv=fail; b=jtgzRy0rd20N1EilEmauUwNqISr3MBtVvLyepE+pPpFFS/Cth24ooOAyImIRdOlnu25tJNwuSwFO9KWRlYP3dS4iIUbQiyR5G7+qi2lDRG7uiVagY+DTebglqPjxNuEBcRg8XeexwlNZEI7Ku/aes2gtjCW8gX7MnJRpy4e1DPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731019071; c=relaxed/simple;
	bh=sczBZG0YjIcOhJKR0ZtH/LAtyIABc1ZJdmr8aQKVoY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AZLF3x2gx0BI/c8QOy+GgeTaTDxR+ew+JvSjOipcRFmN0Wbf6lJsbgOU6KuvcQIDFDG2WEpKc22POa0lnEm2TSi0Q2pcear6LykFw6yG70zJqFnQDdsUrFpz+xgRfqGNvgNC6rmpehSsjWUWIOP3QH3uRbWbT++s1NO88ldXnu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcBnaTCF; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnihVEbep9p1cZAyTjCXnZJp6Appq48eOSMSqo14YWlogVmfK1g6xRCq2gM6ZNIbxh12koOp/4Cy0An4r4eSSfM3plxLao+Pz9+Y1p+LYMgy63JKB5DkfxtvvHcWTf9LjFWGfydUKTFsvufuBhXrDn4gn/sbYhd18OJrESskJCE/IO7YBlqmYka0D2Lt2zplydLPqPdSXuxfmOO14EwlfNilqyGDaidklo3kSoHBzlk18VYo2tHPUSL3tbqWFnH4OXvmqsZxJS7PvlGCSAB9L6H7vqLrX+v91oaiGhmkqkxNWIP3mUMU7gbUCjOr/963ibb2kkwnFMCgBzwTqztbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sczBZG0YjIcOhJKR0ZtH/LAtyIABc1ZJdmr8aQKVoY4=;
 b=ILgu7lu9gXtaOo3FLeqwV9GvEfK0rsufFtrZ3miIChAYpQTaS8rOU0k7nbgQyM9RkZNCEUzwSPVErYod+4/IctRtdciKcCrp3sCIwt7JaabS2EHZ46FSCLGPAh8AWd+ekmMMh2I6tOLvzFXqfjhyD4TL8iwzERgjr1fKDm4JgRgNp2GkmCzRzieNI2YVD5Khwl4vC60NKTZWhizktqq4IF+o8MOblyAdVO0uYIwiLC4KArh5GG+DyM9FATXRVw4rxOYj0s6Eht85HrAPq/IkWcF0Ul1b5SKX78ee7ZDkYA56qY3JzHTajzljgO5qKLX8XKa357rq+PVwzs23HX45Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sczBZG0YjIcOhJKR0ZtH/LAtyIABc1ZJdmr8aQKVoY4=;
 b=PcBnaTCFNJKf9NCUj6VhKuhz3nV+Z7EhImmClZYAi+FdNmodeGxd7bK3beiA6/CvffK7/mK4xoNIPTzywkQygLT0rS7CY+2Si2t6jSlEFzfaHvyYGHv2GE5y+CRkr15N5GMPzaP73aiKNsZj33yyjhP5NpJp7PNdiDP60muk4ddpK+QtpGc3yP0+wh369kZ8cZe0z3NaMic1AqAlbntGPvsS6Wi6qLZ94J9noX+7sWCZzEZJAVnQNFN9D3XhI1PistTwVm4DSkyyBqtEaZAGQsx52SgLvlt1vOTwJp53A5J1cdjWdynIp6cQDFbGeU4j7mqHQMv4JMIJm4k6QaOhuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 22:37:44 +0000
Received: from SA1PR12MB8858.namprd12.prod.outlook.com
 ([fe80::3a95:d815:e0c0:f62f]) by SA1PR12MB8858.namprd12.prod.outlook.com
 ([fe80::3a95:d815:e0c0:f62f%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 22:37:44 +0000
Message-ID: <961edd82-23a4-41ee-a329-b7879ea1db54@nvidia.com>
Date: Fri, 8 Nov 2024 00:37:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 0/5] Add RDMA monitor support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dsahern@gmail.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, jgg@nvidia.com
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
 <20241107082424.5fa1fa68@hermes.local>
Content-Language: en-US
From: Chiara Meiohas <cmeiohas@nvidia.com>
In-Reply-To: <20241107082424.5fa1fa68@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::11) To SA1PR12MB8858.namprd12.prod.outlook.com
 (2603:10b6:806:385::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8858:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 43eca2c0-cb48-4da4-454d-08dcff7ccbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STZKbjFlVi8xdk5WazNxVHoyQXBvVkkyc3lWanhwSE0vUWpnQmNRWGROTWwz?=
 =?utf-8?B?bVRVT0NZSFQwTEsvdWhtemNBT2VybWpiNnh6aEdqSUwzM0VhT1Z6d05uc1ZW?=
 =?utf-8?B?YmNZcG5naFJaWCtwQnRxRUZpWjNzc1BNMXBKY0dlNTgyZzdKTm9zc09vNzRQ?=
 =?utf-8?B?TzRSRVg1dHZTSVJrNVJNbXl2b2wvL1FqSm4vWnhwQmt2NGhHbkltZS8wa2da?=
 =?utf-8?B?MGFvSUxIbTVQRm5OM3ZGM2k5MUdGc0FQS0FVOUhuYzVSMlhIV08yZnU4QWlh?=
 =?utf-8?B?ZjBVMVNMaUMrN0dqaVNUblJIenY4Y0dYMGdoeEM5Yk9ldWNtYjFna1p1OXNp?=
 =?utf-8?B?VTFVaVZmaEhOeEtRRmZtYU9TdmlkbHAvMG0xZzhzRFBKdDdYNzlLam1EZlJF?=
 =?utf-8?B?bUhsMzg1QVRRMitTMk9lc1BMQ0FuY1RTb1ptZXFsZ0ZRZTJFeE5qK1lKbUcx?=
 =?utf-8?B?RFZNcFA5ZzhUVGdtT2IzMDhTa3c0ZGZoMUlQVFc5Mzc5MmtUMm9tcm90d05V?=
 =?utf-8?B?NXlOUTR3cTFrTW5MMGh0QSt6NWUyNjFzZHNUZURHOXlpdHlUNkUzUlNUT08w?=
 =?utf-8?B?clRDcjJrMDB6ekk0SkFicWNITlNzUmt4SHRGUlpkQmMxdHlkT0NxNGFNTGkr?=
 =?utf-8?B?ejZaQ3I5U01jeEJiR0MzcVB3TUsvcnV6anlHMWlGZ1BEQVlGZEhWUldiWVJK?=
 =?utf-8?B?SEQ5a2lyN1BqemlQVVJwUGhEUXVhSnA2SStuTjA3Q1hqVTVORkpGbkpDSUpi?=
 =?utf-8?B?NHRjb2Vwa0Q0ZXUyZmFuNU1NSFZaRmM0RCsvSHFYVjE2MmxZdTdhUFRwOWRl?=
 =?utf-8?B?TFV6N1dJdGwyK1hsZEhqajg4b3l6OTZrNU5xcUJ3Mm5tOFhTZ1hjRDJXYjE1?=
 =?utf-8?B?eVk5cmpwY00rYW1iY3FidjRuMUEyUVR4THpXTldkSjkrSGViWnlqcjZDc2p5?=
 =?utf-8?B?bWNIT3Bwc2ZSUlZsSHhKNnR3OWFuZTdHWG5HQW52ekV0NkxDSDFaSHVUcmFO?=
 =?utf-8?B?UWJBOTJRL3FHaVkwOWVHS04yM0tjRFZheUVOOTVneFkyZzVxRFNpOWc5MnNK?=
 =?utf-8?B?RHBibHBiNnV3VUFpQVFwYW1oZU5HSmlXOWZEdSt3T2c5TnBEeldXblJLNWxC?=
 =?utf-8?B?WjZKSklhY2h3eUFzbVBSbFdOQmF5TCtrWmYyU1RjTzRxcDFoSjNwUy9GWU8v?=
 =?utf-8?B?aFlLZFlCb2pPMzByc0V0aUFqcEE2SkJvczFxN1lXRk1KVXN5bHBDRzN5NCtG?=
 =?utf-8?B?dzRYQjk2eGxvT0x5ZFJ1L3VnWUVIVU1jc0NKSlRzMENhT0d4eXc2RHUvZ1hK?=
 =?utf-8?B?TnFTcFFGdXA2Y2RlZC91eFpKRngzdWkwNjF4S3NoSFJkVEJucHh0aFpDVjgr?=
 =?utf-8?B?b1h5bVN2TVV3Zy9pc1g0Mnhrb1dwazArV0swcitpWFNzRVI4U1FFOFZ4czFw?=
 =?utf-8?B?d3VyQWxRaVN0OUpFUXNZUXlNOXhyUmNDNTFmWXJNWGJWTmVNbFZSQWZYd05Q?=
 =?utf-8?B?V0YwMVJSMzVQa29xQ2NSbEhiZVRKUnlHbVV4ZUxQMUhPNjNlbjEvaitXbk5T?=
 =?utf-8?B?VTRPQWpxWno2V3FkTnMxbksveXIveXd4VzU2eEl3SWpWR0taTzJNbzc2Vlp4?=
 =?utf-8?B?Z3h6QWlQb3RRWnBpN2FMWWRZWnlXMTNia2loM0NFWTZaenhzNFRrRTJIYUpa?=
 =?utf-8?B?azJ3Q3gvZyt3WlBwVHpoRVlNS1JEdUZ0OCt2SkIzS0NhNjhMWU5lWjl5T2dN?=
 =?utf-8?Q?9GPV3w7JcZGzD1bFr4iPH+T8/JDX2A9L5UMqqgo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklZRDR2alZCUytNL2haMlNKb0tJZ2pOUXpyU0JtcHdQVU1ia3gyS04wUWNJ?=
 =?utf-8?B?SzRtTGY1TEw1cGJob21pOVNhelFiNUp3SllTeWg1Qzl5WlhVODZnRngwb0JL?=
 =?utf-8?B?N25ZdFFxMXcyaGtTcVpNUGcvRTFBQlVLSDhlOUlxMHp2MzZHZkRETjVPMUFG?=
 =?utf-8?B?RENwVFFEMjY2L0xnUW05aTdQdVVTc2JzNkYxd0liUlZ3TXE2WnFMRjN2MUdB?=
 =?utf-8?B?a2VRejM5SUdVTGoyWEZucVZ3VTV0U2g0eG9CK1cyQ01yVnU3ME9IM0dsTWJo?=
 =?utf-8?B?SmFKSU9yUmtSSkxvWW9qVWg3RTc4U3p2dGZFdTUxdW9TbWljcUJUWTVWL1pq?=
 =?utf-8?B?R1A4RzFXbWh4Q0FlOGZIOVlET2FjZ0ZZV1hHeUpBemN0R0lQRHIyaWkvbFF2?=
 =?utf-8?B?dGYzb2JWZUNWTHJjSXhKZDBpcDBsc0pPa3pHU21kL3VkaEdCdmRXb0gzejcx?=
 =?utf-8?B?YXU0czFnZEZVNlUybU1QcEJ0NXZDczZyMWFXa0k5RWN2SGNoc3MzaC9oY1V3?=
 =?utf-8?B?a3lnalBMRVZaK2tRRXd1NDE5cFIxWjBEalZUdmhVZTV3MDEzdFZoVWJFd1Nq?=
 =?utf-8?B?dm05anRHTXFRcmg4ZmtSRzErOHp3OWhmelV1RVd5UjNTMzZrdlAzY3BQZkhX?=
 =?utf-8?B?aW5WRTdhMmZKNXY2bjFudlVVZXV6aVlEYmpxTWM2QkZkWHZBTW5hQjdTeEdH?=
 =?utf-8?B?QVBqLzJnZnBPQjJTZFFORDBoRHJUZmRxK1ZONjc5MFVuL3hCSUZaQVhQYUpW?=
 =?utf-8?B?OUdxR3ZOYXc5aUZhMGtMcFNybXVTSHRleUY4d0M1Wlc4cFlhUU5DYVNncGQ4?=
 =?utf-8?B?S3h6ZERsMWRxZVp4Qk5SMWk0NnArUUllV05SOHUyTzBFaXZNSTNPcDIzRjMx?=
 =?utf-8?B?eGJONEN5dDlacHcxU0hJUGRIMnY3YjgzaW5TUy81MjVEY0tYaGFOWm5TSnBQ?=
 =?utf-8?B?aDFjajAvYm1QOWNFRkFLT1RiaGRQWkd1NG1kVWg0RUhJOUVEdzRFQURkbzdM?=
 =?utf-8?B?ckNTRHNaWWZkZXRzZ3dVL1NYSTF1c0tsdmVEUk5tclhtMG5WWUJTWGoxV2VL?=
 =?utf-8?B?U1Ivc0h3RTcvZitlMDdxNksxNE1zc3doWXhGV1E0Qjd6QzViK0tuTEpKU294?=
 =?utf-8?B?Z2FqbGc4R0NlZFJ0WTZsUDhrTGtjdWxQRlBIUStNUlZBN0V5TGRFMnViNTFq?=
 =?utf-8?B?cHY4MkNjeCtwZXJNY1Bud0NIOXVoUlF5WEdROVN0QTVKalRXZ0Z4blNXakNa?=
 =?utf-8?B?OEorOVlMenhMdmMvNXJnSGkwV1c0enJCbEwzNUhKY3hjWWxuWVdTaGdVeDFU?=
 =?utf-8?B?YXpCT0NiME93WE80RnpQT0hQWjFWbmpUSWpYTkIraTZMQVc5VXJ5Y2R1TTE5?=
 =?utf-8?B?ZmxJRnkwSXRWT1A4R3dnZWFNMjVwckpDRGpZVmtoSEVrZ3VjZlJQZEVuZ21x?=
 =?utf-8?B?VDdnSHNOU1JtRzVzVHZHanY2cXBMZVRWWnZhRjd6ei9qS2N6YjE4WEF5TW9P?=
 =?utf-8?B?Qkt4dk1qc2lrK3JnTlBBcXBWNFM5QjlUUUowNy84d29naXhtZXlIRW4xWHVI?=
 =?utf-8?B?RjhTalcrWFhDRUVyVTBSMnV1VnhYMmo4UlFyUVNxM01nSStmREtMbHRGT2Mr?=
 =?utf-8?B?c2hrNzFNWjFUZ0kyeVhkd1N2dWdmN3VYZlUxYWhlQU9ydGtlQTlBV0dYS285?=
 =?utf-8?B?OEtweElYRTdWRkQ1OHdNQlZCZmpoMWxodHBtZjFrUXZFcGU4SmFIQVAyYmNx?=
 =?utf-8?B?Zmc5RFRvK1N5VTJGZkFmYk84V1JzQktBRkE4Y3VsOWxxajlyellGRGYxSFNx?=
 =?utf-8?B?ZkhCMmtBbkthU1ExTU9TZzZBdHVBZmFWUUVDcGt2VFNrUGRPb3RZaitFb2RF?=
 =?utf-8?B?bVBFUDZNbEJDem4wK0U4ZE1IU0pWSXZVR1NDalQxOGR0Z0R3RldqbWdDL0Mr?=
 =?utf-8?B?RDdPaXRNU2VzNUw3SzZjeC9rWGNLOWt4ajFoYVNWRFNpZERsK3pqV3cyL0hi?=
 =?utf-8?B?MHdMRXJ0Zk0wdnpIcDlhOGlIS1pCOFpyNlQvVytsa0VpMVY3ODlpaHRrQTNV?=
 =?utf-8?B?dGh6YWhGRDlqWUhnRUxwMmc3amovOStZbVJRbDRRZVZOT2cxSEk4QU85MWZW?=
 =?utf-8?Q?+aFBpybPnIV6M7xNPNaxwI415?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43eca2c0-cb48-4da4-454d-08dcff7ccbd2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:37:44.2928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vbe/hZH1K9MscejQel6NAY37cpENmsGqxUj+2Zh89NJjENm5BPkZE+WoyKVWG2GVluB92rEePKXH03FF3Ss8LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782

On 07/11/2024 18:24, Stephen Hemminger wrote:
> On Thu, 7 Nov 2024 10:02:43 +0200
> Chiara Meiohas <cmeioahs@nvidia.com> wrote:
>
>> From: Chiara Meiohas <cmeiohas@nvidia.com>
>>
>> This series adds support to a new command to monitor IB events
>> and expands the rdma-sys command to indicate whether this new
>> functionality is supported.
>> We've also included a fix for a typo in rdma-link man page.
>>
>> Command usage and examples are in the commits and man pages.
>>
>> These patches are complimentary to the kernel patches:
>> https://lore.kernel.org/linux-rdma/20240821051017.7730-1-michaelgur@nvidia.com/
>> https://lore.kernel.org/linux-rdma/093c978ef2766fd3ab4ff8798eeb68f2f11582f6.1730367038.git.leon@kernel.org/
> What happens if you run new iproute2 with these commands
> on an older kernel? What error is reported?
If we run "rdma monitor" on a kernel which doesn't support it:
it requires sudo privileges to run the command without failure,
then it will hang waiting to receive events.
The "rdma sys show" command will show "monitor off" as described
in the commit message.


Best regards,
Chiara

