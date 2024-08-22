Return-Path: <linux-rdma+bounces-4489-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D7595B520
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 14:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E261F22C4E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 12:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFC31C943E;
	Thu, 22 Aug 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NqUz4sxc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A920C1C945E;
	Thu, 22 Aug 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330215; cv=fail; b=M3iTu1y7IOmZWV25Qt3xAjcyQt5OdcAr3k+urmmU3i2oBwtr0j20kUnXanVMv42uBIVKwzjLamMZTVn5KhzEF3MwZYfhYaK6RBbAceXUogX3MoNGneZ3iHXHoy+WqPCuNVs5/thyza61Uv82F3Pl2ZBPjJFv5Gb6ACH4aqTweg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330215; c=relaxed/simple;
	bh=jEZrHcqexNbhIcvxAo6+B6wWjaKQ0uYqXuSgGaN58oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tCO38A+j9WFPX2jOsHX5Andj9rwjYfc2kyWu7pIMohFEebJHWcZCH8R8VbPJOQbPUwNLUUkp070Lp2SjONgEB0JDv4jj3Coc7I/KXI/ZdwG/qJUux+xqwq3KNrlMqI1uEvlLXoLVuzIbpqEXvB6fXBjb5Wmw7+e+5Khcsz7Nf8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NqUz4sxc; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1lXwS1hvZjwL1vMgVEZBsedehzKB3O1BuZKnezgZdPGgYeOIeMc8dHmews9JKqQAniaJUpoGe/fExgFqlHxoVMt6Qcnd7JNm4mSlpLUel4Ge5TCzkn/dUBWQFFLo0B+Z7EKur8/8VScP6QCdRjb4zT4pGggIOo0UiOpxnjmL0fd8gZf+y3aRSf4fMlUeNrxx1y5/daZR6NJ4TkxtaCUBX+LaEbs0St4TgiWz1sneLlabyObJmh9KRXtO7qfygZ90vD13L79Va/2mjp+Jvub1aAb1+X6ePndytffK1aaqNrfKs1Fa7rDV+EdZav8kJ+8sELRnNtKUOmoyIF1dTubkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xKaS6eX98itlSay5mf3ueIXMI++AT3sNy0U3lg/2oo=;
 b=fcngUYoycYkLCT9TgujBMTv0/aBuxI5v3N10VGDG38V3yoZ45T/T9MVxGre01FsUouMU/urN0oj6AW1tQvth3VC8ym0AjIFdfRc7/RqcaunNQERnTExN7AfnRsJ8VOtEQA4jWVSEl5poxCQ9t3K2LTvHsfaC1r2QvOtHvHOOcNMtNMvB3nfcrAEhczlTJC7cFepZZFrflKfHBpj0DSxo43vKXJQAZAXPfHI78fPna4pCoM51dyCvcqUCnV6UBdRtVT/lVX/Fl7AcALWu/UUnhSo+KUbYgbXNVCWSL2tXBJ3yRCGxsvw3SMDYyx4X+FmtdKdu/AvDrrP87RnrW4LAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xKaS6eX98itlSay5mf3ueIXMI++AT3sNy0U3lg/2oo=;
 b=NqUz4sxc8rwpbPK8UH1HWvCZhqv7BW21Oi3OjIOZThFbf3lxof93WoS/rAosX65PNjIZ+wRVXUtj7lQvIgpIKXI+nMOLy2In157mHhXKN87ytXIeyUkqSuF1z9TcrtsN2dUKnDQ45VLg3kmlsn7TpQk8SNIC7RVWKkvgt1usUNw/7LamLi6EEvG7NIxUlX9ybYShW2lKEEcXT9sg+7vgkza6sUqnNGRqe2VhSUDK68aRWx3+zgJr93ZkZzPlQBQgfbyOPdCHgr9np/NXKugKUw30i8U03wQK5h8+1UF2SB8vMVfo+dSzU5OZPjoWmKWakpKRyRGmwyMcVcVI4EIx9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SJ0PR12MB6709.namprd12.prod.outlook.com (2603:10b6:a03:44a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26; Thu, 22 Aug
 2024 12:36:50 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 12:36:50 +0000
Date: Thu, 22 Aug 2024 09:36:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zhenwei pi <pizhenwei@bytedance.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com,
	leonro@nvidia.com
Subject: Re: [PATCH 1/3] RDMA/rxe: Use sizeof instead of hard code number
Message-ID: <20240822123649.GP3773488@nvidia.com>
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
 <20240822065223.1117056-2-pizhenwei@bytedance.com>
 <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d933e865-2b6b-41c1-a0f2-46f8fef3cc17@linux.dev>
X-ClientProxiedBy: BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::18) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SJ0PR12MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 675f9e53-5990-4112-d92b-08dcc2a7180e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blMwLzhKWGJza2RwL1RGVG9hM3dtengvc0hZYlJNTG5TY0N2ZWtwdFZuRTRj?=
 =?utf-8?B?WUJkclFMMFpnaFJIVlRFRm9BVFJTblRZTnlkRlhQMGxIRC9sSzdLa2cvTTR2?=
 =?utf-8?B?cnQ2bUkyWEE1SmlibTRIbkt5UWFGWWtDWE5LYktRZjlkdWlyaEVYY05KRloy?=
 =?utf-8?B?Q2VIWW9HT3VNY3EyL0FnMGprWWhYNXBiTC81amdMSUdMNFMxblNGdm5RZkRi?=
 =?utf-8?B?RlVNc0M2SHZMNnNnbjNHMFhKdG9EVVJjL09HdGRzaGd4T2lTckw0MXVYUENy?=
 =?utf-8?B?ZDUxSnY5OUJDNmM5bGNJaW9OZExMNUhONjdZeHp6ZE9iWHVnL1dISzVLbTY3?=
 =?utf-8?B?U0NhYUViNHlHcXJZNGp3WnlBeTV1K29iNlRoRDhPS2FVOHpYUFlvR2g1N2xu?=
 =?utf-8?B?R2hTb0RjVGRuaFd4UzdxTE8wUjMvcGJQTEU0QUJtd2hoamZkMEU4ZDVsSk9j?=
 =?utf-8?B?bWs5NmlyNll3aSt5Z1JTTlppbFhoM3pFRVJTMWQ5T2ptQkFhdG5YRjhkUjVD?=
 =?utf-8?B?V2xuL3ZEaXFrN2xPUXkyblJBUVFkUG03QUxFWjRjaWJtdUl2MmI3OVdIK1VC?=
 =?utf-8?B?OE5ublZ5V1EyVTlPVmxRZnpEditnWHprQm1hN0plZmlwTTNWNHlvTG5wZlBp?=
 =?utf-8?B?MWFvREJFajNvWnY1bzVBck9nRGgrODlEY1QwL1ZCd1o0RldEc1BBZ2FEVThl?=
 =?utf-8?B?a3Rlbi9Zam1SRUdmNTM5dkljcm5IM2dxbWliSnJRWVFWMGQxanFzaHBIeWY5?=
 =?utf-8?B?cldGT0FJaGhRUDlxMVFmU1BjZVVhNVk4Z0JHZDQwVkhHSU9xS3hSZmpJNU1Y?=
 =?utf-8?B?VXRqMG4yNStKV2gwNkdNWExEVU1UaXl3eGxyQVN6OUI2dlRhYXlDTlhnTGV2?=
 =?utf-8?B?anBZaWZBSFA1SEFEbm80clUyWE9zMWprblhGalJ5b2lySW9VMDBzbUlHMGoy?=
 =?utf-8?B?OVFqbmVjNVh0QnhXSkJpMmhMMDNxaktoeHBBSTdzS2NmNmUrVnJEMXVkNnkz?=
 =?utf-8?B?MCtPUjd1NGErVWs2Ylp3SGZaMHpVcnpNU24vMlBEbFZ4dWpFNnpaV0o0Vyta?=
 =?utf-8?B?SHVBeXBiVUpHMUsyc1BVT3lpV0F4Wm5CZEU5UFhzYWhQMEhHMTJBaXpUVEp2?=
 =?utf-8?B?OW4vemdCNkdvTXhoVHIwM0VlbC9wUXlsWk9jM003Z3diaVZqeWRiMUVWa1BZ?=
 =?utf-8?B?VW5FSTlRVE5GREUzUTYzS05ucXREcjExOE5yaEhwNldiOUo3Vlo0YXVxOERy?=
 =?utf-8?B?cHFFWm1OMExzQlVXT1psa2o2WlIvRnU3RDRUQmpmRFVLdWxxTiswZ3EvQlB5?=
 =?utf-8?B?Q1lPTUc1blBtLzlHeHI1RDNhQTUxV0pNbGd3NlRVOHpXSEdlT0RKR1NLSkFY?=
 =?utf-8?B?U1R1MGs4dGZoTkRwdU9vUEt4WU9kVTRnYjgwREE0SXlEUTVJOSt0OGhyeExk?=
 =?utf-8?B?MUJNcG83cy8rekJuVWErcjY0VnlCUDV2eGI0cDlFNmgxcEJGZEU4TjlyRmls?=
 =?utf-8?B?cE1EWmdlRzF1VnBUc0xPZC94NFpwWU10TWdxQmFrZEZWam9nUmtVaE83UExk?=
 =?utf-8?B?a1A3V3VVZFlJR291cTZWb2FsRW1ZWXhsQ1J2UFdnQWFGQ3p4bmJVcTZkd2dV?=
 =?utf-8?B?N1J6WEZoQ0xYRVlueWswQ1ZFc01WWDU3MFVkYURTeGo1S0ZlVVREV1lTUUc3?=
 =?utf-8?B?UU9vYWJqNHZPZFdNcTllS3dYcnVHT1g1SWNFc214VTVJek1OendtM1ZiM1ly?=
 =?utf-8?B?eEhnT0htbDFYa1dGekw0cHFZWU5KbU5uMkJ5M0pPVjc4Sk9kNE5VWHd2NnBD?=
 =?utf-8?B?U2M1TkxCM0Q4dTFrby9nQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVA3SkFqdHBOeHRTRHBJaFZmUGsvVzZ6MDVnNFN0OTBlVzRjSCtGZWpPM01i?=
 =?utf-8?B?eng2UGhkL21MM2E1Ti9OcHFRUEdZSk4xWENyZjdEaG9wM0d1SjRaSXR5aFF0?=
 =?utf-8?B?eWhvcXREZCtTamdSSzI1N1RFNGYvcFk3MjVRRTN0cjlqZkNHS2pWRFJHL01i?=
 =?utf-8?B?TCtCSEEvY2F6cVJxdUFNdEdGRmhhWkFaMnlySzZ5eUxPelBuZU5CVmdaMHRE?=
 =?utf-8?B?R2RkZjNITXkvUUpTN0xSeU5GTWJxOEhxVlJ4QXE3RnM0SlQvRGltYS8yZDhm?=
 =?utf-8?B?eU4yT0xBcjh0Z0ZuMnlLV3p2d3ZQS1pIMFZIK3JLSnBsT1M2NU16ZXJ2Q21S?=
 =?utf-8?B?OFVUNUFwYVFvandab0I4VFFUaktJRllXYXNMZmQvWktET3RpTE9jZjlwRlMv?=
 =?utf-8?B?VDdxMnFCNzRPTEhTVFZKRDcva0RPK2tURUFZeEV6bXRiVFFmNUl5THZxaDNX?=
 =?utf-8?B?WS80bDdRaHkvZ3NBRHpLNmhRUWlLckFsRk1NWHdLaXlmSEtuTzJ0bVBWZG9N?=
 =?utf-8?B?N2NoL0wwdWdoajdBb1lESzIrNVhKWkJ3dGZjbDVuNzFwVE9uR3NZc1dIZ1Y2?=
 =?utf-8?B?K1o5YzQyNjA5ZkFVNTVDZWVqcllZTVp1UFAraVAvSmpDTkdHZlE3KzhGTGx3?=
 =?utf-8?B?cEQ3aXhsQVRGVTM2aUdEcmZCYXB0R3dhNGRpVVRzdGlzOWJWUmlwMnQ4ZTVw?=
 =?utf-8?B?Z2cza2NlZnpIcHZIL2cvcUlSTXV4TzdVMGJ5NTk1RGtiWWh5ZkNuZktBNi8v?=
 =?utf-8?B?QWJFaVhaUklVRVcvTUlUUGY3empnZzRpME5jWk4wc1N6S2w4OXB1UjIrejRD?=
 =?utf-8?B?RTA0WTBZOWtUN0lNMFBDVEpGb3FweFBHeVJERnczY1VtQU9OcDk3OVMvNy8v?=
 =?utf-8?B?TGJVelFOaW9Fai9meGt4MjdaR0w2T3JqTjR2VEpXa3VtM0ZQQVJzdGhKR3RM?=
 =?utf-8?B?WXJ6dmo3RG1JckpTallBMDR3MW1XajMzMFhRSzJrNVV4c3F0K2JDekNvQmVo?=
 =?utf-8?B?ejFmaXh6WVo3WFNHS29TbWV0ZU8wbUUrTCs1bDFhRDhrTXAybDFYaXlOZFJl?=
 =?utf-8?B?WGJQNnJ3NGp0SS9zSHpvcElRWVFzTk9rcVZQM04zWEFjeGk2K1BGb3djUUlH?=
 =?utf-8?B?bnNCMXJWQWRPM092Y3dQNUg5ZkMyOW15NGpMeGJ4dVp4ZlVjWFU3N2E5ODR6?=
 =?utf-8?B?cHZOZCtVN1NoTTd5NkV4MTR0SlQyaGxMbTRQZFcybFNnT3hiVEZsMTJTMGNp?=
 =?utf-8?B?emZuRHNKVGxPNmJvOWdDSVZQTG1QdlRVbXpMSW1TOFNkcnJiaE1HS0U4djJH?=
 =?utf-8?B?eGN2VlgwQ3NEaWg1bkVYdjZHa3NJRmlxNnMyRVBMemRvRC9JdnJpSUtxRXpv?=
 =?utf-8?B?NldtRVZqQ1BnSFUraTAxVE1zeDVmYXJKYnQ5NE9IOFE0aGlhUU1qYkhSOEhF?=
 =?utf-8?B?NFJiTXVoK0I1THZJaTVhV0Y4RHRidjZZaU1NOHJmV0Q4NFFuTUpvUWpON3dq?=
 =?utf-8?B?K00xa0l0V05iQkVsVG4xbFpjVmVkNlNCVnkyMWNIRnIxMExDNEJaTEZpMmZv?=
 =?utf-8?B?L0tJSlNSclRSMFM5QUVLZlAwSkFUWjNsV2pJZTI2WFdHYk55WVhsYkE4N3FH?=
 =?utf-8?B?T3RBdlpzbXM4SHhoeGp2T3k1NW5Lb2lkellyOUxlK3JDQVFwaW5zM01WVy9y?=
 =?utf-8?B?ekM2OW0yOUVuL0xKdTRyY0tDeGdNUjRsdDNvUXk5VVlRNjArNDRJREJMdm9o?=
 =?utf-8?B?Mmx6ZTdXMWJYbW9ld3pIQ01TYjE2WkRqUUNuVUZvSWpwNDVZZXpYVXBGYzdR?=
 =?utf-8?B?elp5bXR5amVxTmVWZlZBS2xkRWIwSW44SGg0by80UEJJMW9BZllLTVd2d3Vt?=
 =?utf-8?B?Zkw0UFdIbkdMeEkzamNoMmlZQ1F3ZUFPa2twYXY2ZW1CMVY4djFCSGRWQkQr?=
 =?utf-8?B?NzJZL0ozbERreDFEMkpxUnVsK0ovMmYzR3IwNEhoR3FVWXpKZ3drOGx4VDRQ?=
 =?utf-8?B?VnU3bWhmK0x4azVtVVM5V01FZ1IrRWdWSEFVS3hLa0JOVEdzYnpCRVA4YXdu?=
 =?utf-8?B?ZzAvYXlPdm9BWFl4Y0MrbC9DZ1FZY3ZVQy9QNG1DcnlYTG9wWHl6dTlVYW1o?=
 =?utf-8?Q?e+txSeolvS0iVu5BFBvlOBNMU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675f9e53-5990-4112-d92b-08dcc2a7180e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 12:36:50.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IS//gPkEZLUe3Kmiqsg85mOgQ8Wjky3Zk5uZhdvjJ0BGjrDaCEooxytzJFWFOJEV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6709

On Thu, Aug 22, 2024 at 07:59:32PM +0800, Zhu Yanjun wrote:
> 在 2024/8/22 14:52, zhenwei pi 写道:
> > Use 'sizeof(union rdma_network_hdr)' instead of hard code GRH length
> > for GSI and UD.
> > 
> > Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> > index 6596a85723c9..bf8f4bc8c5c8 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -351,7 +351,7 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
> >   		for (i = 0; i < qp->resp.wqe->dma.num_sge; i++)
> >   			recv_buffer_len += qp->resp.wqe->dma.sge[i].length;
> > -		if (payload + 40 > recv_buffer_len) {
> > +		if (payload + sizeof(union rdma_network_hdr) > recv_buffer_len) {
> 
> The definition of union rdma_network_hdr is as below
> 
>  797 union rdma_network_hdr {
>  798         struct ib_grh ibgrh;
>  799         struct {
>  800                 /* The IB spec states that if it's IPv4, the header
>  801                  * is located in the last 20 bytes of the header.
>  802                  */
>  803                 u8              reserved[20];
>  804                 struct iphdr    roce4grh;
>  805         };
>  806 };
> 
> The length is 40 byte.

This looks like the right struct to me if this is talking about the
special 40 byte blob that is placed in front of UD verbs completions.

Jason

