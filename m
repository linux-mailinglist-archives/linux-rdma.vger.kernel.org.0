Return-Path: <linux-rdma+bounces-10851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F28AC6CAD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84B03BF1B6
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFEF28BAA3;
	Wed, 28 May 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBogPVoB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F4F35947;
	Wed, 28 May 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445146; cv=fail; b=bb96L90IPXRHfzppKezhmt5iJVvmOxNbH9sEBn3HvlPvp+/pdyRzDIoqmSYy+2Lm6oOAOKWGiZ/naBs2sIxdP9AledFjxWNZAwl4EJIpJO8vEzapHR/xo07eE2MZyrzJCBkPQ8+JH8X+Z8MWt2+9L6T/0ZSq12OhiLMqrVFgvAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445146; c=relaxed/simple;
	bh=sKg79tkY3enBCx8pKLJbYXSmONv4FNShBeWVw3Ny2YY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O3zXLNc6oWNaQUxS5ojDPVE7APNmRVtESmr3dAzQ4fSNJ455ytQQhp1Zp3tCQfoy7BwZu9jsPhR6I6c71PvXNRLxNRxxmLnLA6zO/FwOLGmeMRvg6BktmiqT2HBL4YL33aZDDSI3t47iwKSFoRNRKy9jnK0QyJX3we62g5GxbV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBogPVoB; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=At82N5ueRt2dfmytoj02Zy/RkMr1jQ1oWAPctEIWMqH0wa9tLAcnbnnrJPQNGvc7AflVpuwuw/pR4pk038a/hbzWToVIaTQeJocG72NJ5uzVp52kDkx/DdEGU5mLagQ4c1oJSgjp/hULcWEDwWl0fcPgwpCdi/N/X4x1yViBgjFEp4DvHRBDOkTkVTulpHVanPk+DcYOfFIqgTQd1giCjLJmIwQwJ63V6plH/yeXWSU5knrDsrJtrIps0VZ0h0r0hkp/1jnO+edHyblwaFxcJ+CANNc5j3bp/ukBWzbTisH5wzE4/FSmy66UkLtj26XNxxXISNPgTIMj0esoYxI4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pjJJxcYYhHlNyYaMoegLwjkdw9pqRTf/hgk7PNR3vw=;
 b=hzWEtDP512HOz6ckCxSALSgaxyAH4j1t4R1aMeX0Igb1/hxK3jppgsHKn+DsObvSBEAGxiMC7MgMOaL3qFXcaaeIxNAMUixV+jskqbjs0eTe337rC/47/Wc8KsdTcsYQVEZmA3cKNBfExwvFsLKFaKb3tS22+5ddZrXXph8HyYtW/E+N/5l9RbE8Uwg9LYYByOuVgh38Ae3JQJ5aVjB0pHsNA0nNw1KuWGuNMd348/eAfOA6qE3Regj0xiq8KgaMQOp4z1Q9i17xF7VX3HZIq92VX9X46TuBgK1hvTiuY6lmMDkZSaf4dadmDifR6z1f5q1s96YhCi1CwcNCjClV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pjJJxcYYhHlNyYaMoegLwjkdw9pqRTf/hgk7PNR3vw=;
 b=KBogPVoB6Nrmxq89QqyhGYqtXXGwCfspZ2MTOP6/3mT3PcEsNKrkJV0CQHX6LBfNfzaULMZH3XyltwD15JobRnw6w872LjNlhVfNaTSfLDIYmqwrslfXzhMJt8vnRtNkSCnaSnEXIXtdCBCr5+mNt1iFaicuvlGKLuCLGNW8Ikc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by CH3PR12MB9731.namprd12.prod.outlook.com (2603:10b6:610:253::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 15:12:23 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 15:12:23 +0000
Message-ID: <7bdca720-d39d-6104-c5db-fe3f375aea2f@amd.com>
Date: Wed, 28 May 2025 20:42:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 00/14] Introduce AMD Pensando RDMA driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <aCuywoNni6M+i07r@nvidia.com> <6bc6fb63-2a31-808d-91f3-eb07a681e631@amd.com>
 <20250526131938.GB9786@nvidia.com> <20250526154133.GF9786@nvidia.com>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250526154133.GF9786@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: eef7f9ea-6786-41e6-6e3a-08dd9dfa0bf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWNibnRHMUw4eENxS1dCM28vMU9VOFZ6ODk1amJkdm5YZFl3QzJpL1l0d1h2?=
 =?utf-8?B?MHpVVHlwSExtNVpHK3dRQUN6cFNjbWdYZEUzZDVEdmNyQ3NiZ1Jnbmk2ODVG?=
 =?utf-8?B?QVp5a1IvQVVxa3RHOHpxQnBsQ1JmbGo0Qm5sd2g2ekRMUlNLSmh6WGw2aHNN?=
 =?utf-8?B?KzExb0tqR3JlSWxDSWhCVytKYjdMclM4b2w4QXJpMWpkb3NseThoS2FYdm1j?=
 =?utf-8?B?QTZkNnVoZDVyVStzc1VWOWV6WUZwTkcxd0JPVFA3QkN6VVMzK2Zudy9xd1Vp?=
 =?utf-8?B?eEZaM1hqRTNYWFBSNFovTDJ3K0FVVnV2bjdsR2VnRk1QS1NTczFpclZnS2pM?=
 =?utf-8?B?SFJUSDQyaS9pNVVRWjBLdFlFcENGY0dxeXRtdlAwemtGUzBzTUhsL1BibzlQ?=
 =?utf-8?B?YWZJR1JYZ3VDRDNTdjRxZ2JQV2dnRm0vbWUwaDhNMCtWOVBzbUZIL3orZENn?=
 =?utf-8?B?cnlZaHBEQjAvK0tRUHpTQVFwZHIxaElrNk9GRHMxMytJUUJDYTNOcFdtUUZ2?=
 =?utf-8?B?MmRqWWhhcVBXOHROdlI5bnN3RW1seGV3d0s3RExzUHRuZTdpOWlNZXE0L0sv?=
 =?utf-8?B?ZzUvaVZiclZtb3oyTXd3NlRXQ1BzRzlLME05WVBDWmFldDE0ZDNKQVIyVFBL?=
 =?utf-8?B?enhtZE9IOGlJQnI5dXZ1YmlWT1JXZTZJbGRqWDRMWVIxVGNKUHBEYTFZTy9H?=
 =?utf-8?B?NjhISDJYRnNTNVhVelAweWxUV3Bmd2ZsMGk1MzRwR25qS2NBR243Tll1UFhi?=
 =?utf-8?B?SXVkNmpPdGhYRFFUUDhDT3JBWktGZG5GL2RUR2pzTjBaNU9CcGZ4MHk3ZlFC?=
 =?utf-8?B?eklmWUxEWk50OG1NMTM5SXNNUFd1b2RSYjVPT1pUWURKQ1lsWlB0cnpKUGpU?=
 =?utf-8?B?WlkrT0l5cm1XZVNGNFZnakNWcFlPWTdxVGZ2ZEFHZnpUWnNrT0o3MXVNZUx2?=
 =?utf-8?B?c3NvS0hBS280ME01ZzVsZHRRSnRINU1YZFRGK3JNMFFmVHFiWmZUTEJzZHN2?=
 =?utf-8?B?RnlHd2h5TTdZMWdkbFprV2NLVFl2Q214OUVXdjZCelJ3NXE1YTNrQ010Q1JS?=
 =?utf-8?B?TTZaRDZRQ0swRU5zRXViWlhkWVN5akQ0NFM1c3dzVDZLQllOU05yZFk0MUIw?=
 =?utf-8?B?eFFzMUt6M2pkU2I5MkFRUE1ITnAwajRnbzJRME4vUEpHQ1JWQUxwN1lHQXZw?=
 =?utf-8?B?Vzg2cFNMTHJjbFNGbXJJYnZ0NEx1amNYdU1aMmhtbnVnbEI5bHFhcCtWdTUw?=
 =?utf-8?B?TkF0SGhZeUtoMWJYUWdpUjd1T3RMekpwdmR2aXA3M2NXY2dZWG4reFNHSEhK?=
 =?utf-8?B?NnArUEQ4ZEdnNGFmdnowa2loSTZBek5ScXRodjFaaXBPK3gvZFlFVVk1aW41?=
 =?utf-8?B?SnhIQTZKZ3FoMlVJaWQ2Qms1d1owRytHaDcyQjZMMU9sUTRFSzZWbm5vRmlH?=
 =?utf-8?B?MHNIWktzRkd3V0dxc3Iwd0lMNGJMZFZEazlsTG5oTitzVVV6VGVlMXhNUGlO?=
 =?utf-8?B?T2QxVHVOamg1WUJkekIxcFd1U0pvWXBBdHc4enExbnVpZ2ZmUlZmS0Rvaks4?=
 =?utf-8?B?eXdCN0VQR2VLM0gyMXFkNDF0S1ZDZE9RanFxc0VuOVVvODcrcnprbWJaS0lH?=
 =?utf-8?B?ODJpV204bit5QStjMkJDdlU4UC94Qzh4eFZwOGxqNDBhN3BrV1Z6ZVhJSUFG?=
 =?utf-8?B?cFZFekRXRWlYbEtlTVE1c1Y2cnByalFNSGFNcWdQdzVuSUxUa0NUYXozOUJL?=
 =?utf-8?B?YUdXUk1STG45eGovbUIwNkJtVlIwOEgxaUFxR2luZmFhaUo4V2NncVdaSHla?=
 =?utf-8?B?ODN3SUlYSFlZVUpMSUZaYUFTQ2QweGozRWk2UkhzNGlseEEzOW80Wk5BU1Zz?=
 =?utf-8?B?cDBCY1JIL3dzT0pMWDdZcGpuUGNKdTFtZlp6RGsrd2ZFeGJ0LzhFTjA0YXdy?=
 =?utf-8?Q?WYwmaGLiBLM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NW8yL1RPZUFGalgxbWVKeHpMeUZaQWZCVUd1ZStyVlRqQ3JlQzIrWmx1Y29K?=
 =?utf-8?B?azdWTFBnbm1IQkV0aUdzOHZXdDFTRjl1UUxodnRqWEcwN3NIaVBhOG9WaW1v?=
 =?utf-8?B?RnRlWGFhRmEzY1p1TlJFOGJMTmpnL2t1aHRvSmNIYlpNN2k0N3pNMlJKdExy?=
 =?utf-8?B?cXBWK29YVDczcVduQWVDRGp3ZUdtZS93ZjVrTkRFV2RFbEFLTzl1STVSSzVK?=
 =?utf-8?B?d3YreWp1VHRLTGhGdGE4VGJraTBCNE93YzgyeHViRSszNWZuZzRIa3dKOWhX?=
 =?utf-8?B?ZU84b2kzb1UvenlhL0dvMFMzOWYyOWpvdDJsekFSWTZEeFN6a1M2QURSN01D?=
 =?utf-8?B?M2hvWnZEYVMvMDEvL1ZSVDBmSnJVS3h2TGlyM0NGSk02NlZPVkRGSUhVcDhJ?=
 =?utf-8?B?WVE4czM2TTFmUzl4cXJ2cHc5aDUvVVdObFpZMmZJaVRzdDJuM3d0SytEVGts?=
 =?utf-8?B?T1FpWkpWOE9BTVFHa2RuTUU0Y21MVEpheGFyZVZIZFdobDBSWEtnaTZHaTZF?=
 =?utf-8?B?aXVsN3RXakJSL1MrQ0dwbzUxdTZjemt5bUIvclMrS2V0WDVsWWMvYUVqMTVw?=
 =?utf-8?B?QjdOamM5U0dGODR1bVYrYlkyS1ZaNTNxbFN3YVNvTTFCcVJpZnRzRy9wMnRW?=
 =?utf-8?B?YzRWYkNHTzVyR3NxWExyNlVtNVJrZi9tanV2RnNMb0lQS3lnU1FwVFQ2MERG?=
 =?utf-8?B?cm44eWkyMENBRXlMSVY0ZVNraDlSMW1GUGU5OENjMDd2MllPRTFaQW5PVlk2?=
 =?utf-8?B?UWdSS2psOXVQT2ZtMjY3L3RoQzY5QTdTYXRoTHpyMnIyUi9UVnhsNUcyelhm?=
 =?utf-8?B?WFhicU4wdmd3UEEvd1piTG1WMVExRnBCalRvT0hvcGl5QjR5RThnakJvZlRP?=
 =?utf-8?B?Ti9kU0pCVlVTWFVuMXVWdU1vZkxHUFdJRDQzeTRGVzNYbVF1WEdmWHFQMSt2?=
 =?utf-8?B?TEM1bmg3UlVXb3FOQkRXL1pMZzRuODBUY1Z3SDdJaFg0cTNNMFcrNEhmdVVv?=
 =?utf-8?B?dHZKWWdoblNkMXIyTllFUmZkUEVCcXFXVEJyYVdDd0EwaktYd3FLUGtHQWZ4?=
 =?utf-8?B?YWhUQ2RkUEdURnc0bDl0MUJvemswcnZYRGZpOUluZDV1SWNna3ZLMUZUb0Jm?=
 =?utf-8?B?YUp6b25RcW1RTzkrSUZUdzAvd3hUd0hPUzFDOUlUS0RnODhNc0J1QjdhUTRj?=
 =?utf-8?B?WGlzd3VpNEUrUDJrbXUydWZTcGlSelZ2dTFXQklhUERhU3JDdllhSW1vc1Fs?=
 =?utf-8?B?TkFaM0JhaXNxRWRrVkNTWElqc3NSci84WEJ4SkVWTWRsTFZQeThzQ25hcXU5?=
 =?utf-8?B?VDRtajNEczNCdFh6VE5SU2NZOEVMZW9lTk9SeUxmVmphS0cySDZIZXE5Ryty?=
 =?utf-8?B?c0lHdmdiTG8wM1kwUTRXUXdyZnB1K0taRlg2TFN6Q2NaRUE5ak14eEYxOEJS?=
 =?utf-8?B?QzJmSTRwYjZBaDVuNWp6c2hPMlFKaVJidXF6MGRhcktHcUpOeXFNb29yMXc5?=
 =?utf-8?B?bmp3a0JJL3pMaTAvajFKUDBHOFhtTHJqWTFJT2ZVU3JOeWwyU01qbDRDczlH?=
 =?utf-8?B?NXpyeXJzQUdGcnpSbWhRSEx3QVJKelFiZ0JLRmRoeVYyTmx4elovYzJSenh5?=
 =?utf-8?B?akRYY3Z5ekNZbHFIODk1cWNvY1JuRkM2VEJvZU5MV1V3RVlVSU5NUE1jdTQv?=
 =?utf-8?B?M0FxZUxvbGU0RUFVZHFOYVlUNE04T2g2enJkUCtuN3Vjb3R6aGFsQndOYVFB?=
 =?utf-8?B?eERuRWlhVXRMRmMzcDJYd1F2M0JlWlZ2OWhnV1BpY0lzR0V5Y2RZYVZJMUV3?=
 =?utf-8?B?US9GRnRXSFozNTZXc251Tk01K2kvdFJZR0o5ZXdYMU9DMmZxTUNGaVk4Wm1t?=
 =?utf-8?B?VXczYmZISjRqL1lvT3VIMlN3ZUE5NGk4UjdUbEVscGhsT1NrZ3BKTnFnc0Jq?=
 =?utf-8?B?TWZWNzkwOVhiNVduUU9ncWNPb1ZHclJzYUhEVnpKSXdNV0ZJK2RNNjJma1E1?=
 =?utf-8?B?eGlrZ1FaOTFxSnViaWY5b3dDb1oyQnUxb1VmOXdlNEVjS08xYmVwZXJScG50?=
 =?utf-8?B?M1VvSkwxNDBvZHhCSEpMMUV6SitwVGRMRHJDaHJrclZnYW5aS0dDR2w5M2l1?=
 =?utf-8?Q?UVWarxMUT3T5oI7zuNCESK3Ze?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef7f9ea-6786-41e6-6e3a-08dd9dfa0bf4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:12:22.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvK3OTbDCv0ePjNr9lCUZFUEaEjeUKvKVQ0wxCZca0TyqH7dTU0pVcB7cLrRFivCBk4dNLDdyvxwzLJhi3sIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731


On 5/26/25 21:11, Jason Gunthorpe wrote:
> On Mon, May 26, 2025 at 10:19:38AM -0300, Jason Gunthorpe wrote:
>>>> @@ -1454,11 +1466,15 @@ static int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>>>>    static bool pd_local_privileged(struct ib_pd *pd)
>>>>    {
>>>> +	/* That isn't how it works, only the lkey get_dma_mr() returns is
>>>> +	special and must be used on any WRs that require it. WRs refering to any
>>>> +	other lkeys must behave normally. */
>>>>    	return !pd->uobject;
>>>>    }
> I was thinking about this some more, probably the call to get_dma_mr()
> should set a flag in the pd struct (you need a pds_pd struct) which
> indicates that the IONIC_DMA_LKEY is enabled on that PD. Then all
> QPs/etc created against the PD should allow using it.
>
> Checking a uobject here is just a little weird.
>
> Jason

Sure. Will use a flag inside pd to indicate use of local key.

Thanks,
Abhijit


