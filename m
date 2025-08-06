Return-Path: <linux-rdma+bounces-12594-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F660B1C19E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 09:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C6622A0B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 07:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6921ABB9;
	Wed,  6 Aug 2025 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5VcmbqqQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F8C212B2B;
	Wed,  6 Aug 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466863; cv=fail; b=K+7E4ALD5MkOKdpiUHBLnCTahlkFMcerHEWcHPolpgwkw4ftvVrliWhWTln1VPqBcCn3PexUmFoDFU6DOmqOmwG0WnbfdQCMUZdShpuNFArEHrAUnVJtW0rX/S+OTljOZSwTbqKcbL9sBLV7fELGHCXKvoqwWBWMYvKrWY4eb0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466863; c=relaxed/simple;
	bh=Xd/GHVJAksXRMAoOqd+VhSYUuZ47o+ajWVCgw/nMU0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lI2UEDhJR6RTuOWsRxkt39zMERKDSdqGbT9t7kSleJbSm46pPb8c22xPTIMjfigOprvVu2X7pZopkKJXhBaHlGTql777lGV7D8WHsxIwDFmrcRRlXpvuvK0ixQ0nGFwvn6djpA7trAyaz+jOK0UqZjeFTxWJDiEH8cuuO55FioY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5VcmbqqQ; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCB9Y0cLu01U544eccq0FRccdYxgZ67Ch9p7S1QksY/YGev80X6cbp6xTl2g28ApjuxLW6wapfcUloG3uDuKWLaEaOQD0ROgyZEA3+Ugf1LlMTL/Vir9WTVAH8VlOZ7nUV+cgCDx7GzWUD1sTpXEj1sFZSF+xwQBW0df3luwyO9nGvX2mfhfxRLj+HvUq0ph/NqXBzDOas0058pjEym9Xctc21dSHnNVcUJJBUkfLmwwVD328nkOSeIvNQn2X8ydetGGdxstWXgPH0Nr7POy0JlMXguoIPI3eCkzITprrqJHLXiPPCZ3HXIDW+Zj/3OlMRuD5aLWJ/j2dJIxpohkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf0BrYw/PCdv47U6/0IUWbt8fVjbgLnj8rTiCupFvgg=;
 b=Hs2poo0DUX0+VIHep8jpaxX17753ijhgDxBKlC9TsHu85FaIOsnJB4WRZ5mHyG/ZeoboO1hD3KxTjKhTI1xEpoAxo/xv8QZrboEd7TSfGCLPpQ+f2hVnVuJtAnwjheB8H8zNig+Kkn6xkX+ZbFXKB3C2TTAxmGNFZtcurK4yK6o9r5EQCeD5RKixn3spaPuec4nsNEawyluIOmYkAIjBCAW1O264pBh1NLCBlia4Sc3+CmSyDFgUabXkosf9gFb6/qFO3Gxq6T1CYfrtdy5LGygutcIaneDN7oIzrU1X56H9ssduXJ9YJpWmuBGSW4bditFFjB7/MZTVIMbp48gwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf0BrYw/PCdv47U6/0IUWbt8fVjbgLnj8rTiCupFvgg=;
 b=5VcmbqqQvt4RPRH236VOOs3oW1Luh6q01oDc84GAAKUt0+ngT3pbNsqeI4Dhera+r5Wrlg+4o6hkdPbQqt+Q61GaA+T/rCS2zN2GU3m4MQz9FIPY20HWiyfgThi/j7SZwPZ8cxF09gxzQAOp0RIx0UM1iElXz1VmF3c/yYxi+R4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 07:54:15 +0000
Received: from PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f]) by PH7PR12MB9066.namprd12.prod.outlook.com
 ([fe80::954d:ca3a:4eac:213f%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 07:54:14 +0000
Message-ID: <5d495e57-71f5-e465-cba0-d727c6b36167@amd.com>
Date: Wed, 6 Aug 2025 13:24:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 03/14] net: ionic: Export the APIs from net driver to
 support device commands
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Simon Horman <horms@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, corbet@lwn.net, leon@kernel.org,
 andrew+netdev@lunn.ch, allen.hubbe@amd.com, nikhil.agarwal@amd.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
 <20250723173149.2568776-4-abhijit.gangurde@amd.com>
 <20250725164106.GI1367887@horms.kernel.org> <20250801170014.GG26511@ziepe.ca>
 <20250801132128.69940aab@kernel.org>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250801132128.69940aab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::11) To PH7PR12MB9066.namprd12.prod.outlook.com
 (2603:10b6:510:1f6::5)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9066:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3389ee-951b-4b2e-9132-08ddd4be6fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkRjdThPSjZneEpacDA0UU1qSUhNeVNZOXFvcS83N2pqYm9ZSWFwQ21lblkv?=
 =?utf-8?B?L1lKNFFFMjlNa3FrcmJCdWVOOVprbTFZOUE4dkQwTkZyblJDeW9sK2VoaVVz?=
 =?utf-8?B?RTN6NVQvZFVBZFFpV2FQYzMvNHZDcnBOczRiQk5KV29BQ1NyaVBDZ0lmdXpN?=
 =?utf-8?B?ZEJTWDZFSEsvV1M1MHB4TFJ5SlFyTU5uMklXZTZucE1BS2hsdVpkdGVYZkI4?=
 =?utf-8?B?ekpsUjJWamxvbEhzUzNUcGNtZUoxMDVLSW5PQ2dJakUvRkNwbWVtNXpEdXBT?=
 =?utf-8?B?dERwOXVkRHdBOWlXUDNVR3JGUldnSGkvZmNmMFVCdlBGcm4yVUpvK0drU0VV?=
 =?utf-8?B?anBqckMwRndKbVFNNWFMajJKTzM1K1RBK2RKSFZ4VnNPYlJQV0VLTlIxNHZ2?=
 =?utf-8?B?NW5wT3hyNUdsUmpFVW9WV01YQlFyeDJBRDV5bnU1RGlLMU92N3hCdWZkUnhp?=
 =?utf-8?B?aktjMVVmazh3RGFsMjBSUUp2Njl4RzNKcXlCSkFTRllPQzZVd2VkZmtLZ0dW?=
 =?utf-8?B?RnFwNCtiNDhTYmU4Q293Y3VpaG9RRmhDYzNhdDFxM2RiOXBHdVpjV052Lytu?=
 =?utf-8?B?bGl3U1BERmdndmVjZ0NsaVlpR0djYnc4TE9wUnd6ZGxKZGJTUTdiclIxczAz?=
 =?utf-8?B?TXhMOHZHQVlPZC82U2htcEVTMmFLaXd3c04ra2hUTzVUVlFHTWdHcFpLVkQ0?=
 =?utf-8?B?VmZrNjhsaEJoRStCQW5jRCtWZEtoZzU2RnE5SjZoOUdJb2tZZ21tZzQyL2JJ?=
 =?utf-8?B?ZVlkRzN0dmdZTHNSUEQ0a0p5YUVyZU1rTmk5SjZoQ04vaXpyUERmM2xxdXJT?=
 =?utf-8?B?WVJtZDZrVWdmNmFsZmtHcUFnS2dwRi8rSGQ5K3MxS3dzRG53Uk1vdGtmWlpR?=
 =?utf-8?B?MmlSVGUxSHZha1JtdE1rOFl4U2ZmcldZS0Q2VzhBQjVzYzM5RDlra1Y5eHp5?=
 =?utf-8?B?Q29uS3NETmFBbEtBVStkRlFCYWtCMFE3Zk9mS3JPN1dtaCt6MEprU2s1Z2d4?=
 =?utf-8?B?Rkk3M1VKS1BMTUVBWUEwUXpHeWxKRkQ1aWdwVE9aT2VlckRqMWJDMkhqbTB0?=
 =?utf-8?B?N21YTGJNTGdNMHI5RWgyZW1yZmRaZG5Jb1hVKzB1dkdoRkQvOUhyM3R4Lytj?=
 =?utf-8?B?dnlmOGdvaENJeHNkN1paRDJHWjMvNkFuWTlMelJWblo3QmVoVlVDcUxISkpl?=
 =?utf-8?B?L1NUSC9mWXpGR0xsVS9CMEt0RWJQazJLaGRvY2MxZWlob1FhVWlvYk1PZldQ?=
 =?utf-8?B?cXBUdFBEYm93SzJzUEZacXBvTHNkdjZIQ2xEemNnMmtBWENwMGE5dnpxb2hM?=
 =?utf-8?B?SkhSMU90bGVLd2J2THVCSWthRkgvS1JMcElCTnRrTVJ5bmtUOVhJTFFBb2FT?=
 =?utf-8?B?bm9EbmxQZm9HSXRJaDdUVHhxT09GV1JOd2d1K01sWWI2eTExSHNBUThOWUlZ?=
 =?utf-8?B?dWI0cUlLYm50cURGa3JadktaWUlCMkYvSDNPMjhrOUJocUxVbGo1QnhHWVpv?=
 =?utf-8?B?WUdHOUFnaU55S2NrN0JHWklpeldGSTlJdE05WUdPcHpramVEZi9qTWtzU0l5?=
 =?utf-8?B?a2FWWnZyUHNIam16bzA1OWd5VWdLY0luaXVITzEvWXMvTlBmdlNoK05rMkdX?=
 =?utf-8?B?bFV5WTZQU3lLSDI0TEpMNmM0S2R1dTlZU3JJbjJ4R0szdnNURDExZUEySUgv?=
 =?utf-8?B?am14bnhzeEZzMGFIWjZSY0FNRlNMZnBwN3pCZVlFSk1zRFJoUm44YTRkL1Z2?=
 =?utf-8?B?blYwek10b0tMZnZPc2NKazZ4SmhiVjJrbTZHcHVYbGJPdUVKamd0Y3RZcVIw?=
 =?utf-8?B?eUZYSTlXZmczS01ORFlCQXRCSkg3UzFBWm5abW13amRqd0hhTEE5RDJHSGJq?=
 =?utf-8?B?ZHRhZTRZTTZlWHRxdDNXcDhLaklrNDZET1VaQWZZOFNPbG5keHl2TVdqdU9M?=
 =?utf-8?Q?HjMj7ZdOJZk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9066.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFQzN1hIblE4emZmUC9PdWhYUGVXZXBQeGZVYlJLUzdDUFE2Q0hJbTNqZnNM?=
 =?utf-8?B?TzFpYnhscWdheFlYM1c2c2ZySXVLWkNLVzZvUHN5Z0loS1ZEbEhTOVJGek9O?=
 =?utf-8?B?c3k2d2paZ3MrMSs0S2tqZ2NRVDF4SmxBNHlsNzNDVllMcmdVTWVkV3Y5L3dq?=
 =?utf-8?B?YnB0a3o3dlNUOHVJS21RcUJMYWRwS3BVUjhucVpqN2NQZ014MG0vVkdvSHZ4?=
 =?utf-8?B?RmNFVlUwNHB2YTVwS2F6WEtudGhkV2RrYVZWVS9oSVhFNkpIYnNrdW11TDRR?=
 =?utf-8?B?dys5akthSXN4VUd1RUIrbVk5cVhiMEE4ak5TMlhLTmtBMElnS05tN1FkTWFl?=
 =?utf-8?B?ZDNCU0YwbU5pREV6aTdiQW1PN1BBcDQvRkJMWGRaY2VjcHNGQWEyNUtUNkl5?=
 =?utf-8?B?Uzg4YnY3TGhrVEtreC9IL0d5ZjZQK1BZVnNaRWEwOUNRQ3FUa1loUXhNc3VO?=
 =?utf-8?B?dmxVZnJzRkduVnAvU2t0SEZCR2ZvZ01pczFXUkEwSHQzL1ZHVnUxSjJOMU9i?=
 =?utf-8?B?TUIreWdXbzJhbEZ2R2hUYmh2TmpIUHltMHQ0MDRXV2JEdzM1WnFGMUsvLy8z?=
 =?utf-8?B?QTA1R2Z0YkczWnYzRFRXbW5UamMvT2tLMW5oVm9qQzZ2NTVzUUZGRXdaQ25D?=
 =?utf-8?B?eHllN2plMHRmeHhZdWV3RzFoQStnZER3Z1ZsMnVQbklieXhDcFgwOTA1M3p4?=
 =?utf-8?B?R2lOMEhITXlFZWlQWjNQZU9VOFdqVS8wWFY0eHFqeGNRZU9UcVZSVmxmN0pC?=
 =?utf-8?B?U1RpSmFUSmcvNWE1ZS80eHZIbGQxbGdSTFd5T0E5aXh5eWZtWE9jRmlsaDVU?=
 =?utf-8?B?MFpEVWQvSVBoWEdoa2hicWtWajZ4ZVdlT2tNMVpDTnpNNWRVazA2YXU4U3Rn?=
 =?utf-8?B?VFZ6VDBLbUl2a3dpb2c2QThtRmtGUFpEbktkUkt5OE9DdWZrNzJSVy9udklG?=
 =?utf-8?B?eUR3TDcxQkZHMWxueFNJK1pkZG5jYkVQd3llNG9BYWhzOWZuZzhhVXhpTFo3?=
 =?utf-8?B?bXorNFJ6Y3JEVUZuc3hMRFJVQnlFSTRKTFZGWkl3a05VSUFQbXNYT0Q2dFZo?=
 =?utf-8?B?NFI3dnFZLzVxcW9XTGg5THBVb0RQVGhETUNsY1kwbmI4ZXQvazVpWFpMZGNm?=
 =?utf-8?B?Q3lNOFpZUXllNk4yNEhPOGlZV2Q3cnVZNC9mUXJxUmZCU0w2Y29JUi8zSFZS?=
 =?utf-8?B?NUxvbnB2c29HRUNuWm5DN21YcnN0VlFrUjFKamptKzM0c09TeFdINVdtaTNm?=
 =?utf-8?B?OFRkYXA2ZmNHR1BIYmpLakI1Y1hmVFJZYTd1ajJuOGtpMTY3UGdNVWxsbWZj?=
 =?utf-8?B?Sk5DdjFBT2ZMSFJYNUFWTnZUL1BGdUNGeGVHQjZ0L3N2QWdVdjhRYkdXT05X?=
 =?utf-8?B?T2R5d3FiWGFwNFhMRnk5OHFqbmlLYnk2WVY4UUI4b2p4UnYzNjFhMVZrT2ZC?=
 =?utf-8?B?T0xDQyt5MGFwbUxZU2NpZDVsTWxwK1Y4SWhaZnVrREtZcWdkTmpuVFgwdnZR?=
 =?utf-8?B?WXkvVVRzcHRHdmpRVFBjVXRzL0I4L2hJeVcwOFNZb2J5RFJMcTU2cTkxcGhL?=
 =?utf-8?B?NENyRU9sVG5zYXpjaGFGUDNidGJHVkNpN0xSMnBWenpvSEhDcDhzTHNkbDVY?=
 =?utf-8?B?NmRIUElFRlAwcVIyVHovaHJndDJsSUcwcm1KSXFUZi94RllKL0dMc2krOFFs?=
 =?utf-8?B?Z09FcmJuMnBlTGVHdWNsVitxRUVid1NOQ0V3RXRtQUZ1cDZDZGFkTWhlS3BT?=
 =?utf-8?B?NElGcHBydjd1YnMzYi8zUmpwZlJPTm90a1YxSC9pbysvQmVyZkpCNEc1ajR4?=
 =?utf-8?B?UHY5Y0hvOTNPRmxTR2QxY1EzUGw1ZjBmVVcyTWUzSXYxTWxpUmpBMmh3UUNG?=
 =?utf-8?B?Y3BZQ1Z1ay80b01tVEpsRG1lWU10QWJ5bmY0SWRYRzkzWG5VeXdidFN3NWl1?=
 =?utf-8?B?WUllNUtnY0Y3Q0xKZkNsTnMwUExjTC8vNnV5a0dMMkxta0xubEczSGFxNlRC?=
 =?utf-8?B?OXd3SGpyNS9FdGxiVnRhbTVFZGIyanlmZ3VNTUI1SUM5WVd5NEpSbmpESDhl?=
 =?utf-8?B?M09PdG11b0EwNWQwYmk2NGZ6Zyt2VzN3WFZteU5WWlhYeVVzZWd5TStzVWZR?=
 =?utf-8?Q?Y1jlxwOD9VC68bKrA0jvoIIc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3389ee-951b-4b2e-9132-08ddd4be6fe0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9066.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 07:54:14.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvYmYkYm9Pzt5AoP6VX15+aGdl1+q8nROx2AgpMBqQdUMwz/vje/VdEReWqxcnM6JzGBFh5wjMNoVJHlXJTUuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055


On 8/2/25 01:51, Jakub Kicinski wrote:
> On Fri, 1 Aug 2025 14:00:14 -0300 Jason Gunthorpe wrote:
>>> Perhaps I misunderstand things, or otherwise am on the wrong track here.
>>> But this seems to open the possibility of users of ionic_adminq_post_wait(),
>>> outside the Ethernet driver, executing a wide range or admin commands.
>>> It seems to me that it would be nice to narrow that surface.
>> The kernel is monolithic, it is not normal to spend performance
>> aggressively policing APIs.
>>
>> mlx5 and other drivers already have interfaces almost exactly like this.
> Which is not to say that it's a good idea.

Thank you for the feedback, and apologies for the delay. This discussion 
prompted a thorough internal review.
Although a precedent for similar interfaces exists in other RDMA 
drivers, the point is well-taken and we understand the concern about a 
wide API. To address this, two potential approaches are being considered,
1. The function can be documented as a privileged, clarifying that it 
performs no input sanitization and making the caller responsible for 
device access.
2. Alternatively, a new, narrower function could be introduced 
specifically for RDMA use that validates commands against an explicit 
allow list.

We are open to either approach and would appreciate a guidance on the 
preferred direction.

Abhijit



