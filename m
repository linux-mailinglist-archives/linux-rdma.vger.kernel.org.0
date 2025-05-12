Return-Path: <linux-rdma+bounces-10287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CF3AB2F24
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 07:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADF01899BAD
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F73D76;
	Mon, 12 May 2025 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iwiA/gaK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586BE2500C5;
	Mon, 12 May 2025 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747028974; cv=fail; b=JVeCqMa9rAA4AcncRGdZXeklah95JSxs11r4eKn3RToShFL2QCU0Y5GqVLUtFHE6SmDWsBc+ZzTnhuMpGGeh6mKiiXclnIfLYb/XKVmYPlBoPEmHelskZOROyfp4A76YqelxVoQjO0yFbL55I2VMUmGa+as2wKYRF1nrBjgUNFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747028974; c=relaxed/simple;
	bh=+26H06AA6D8PgGx8HBODxQRHdfbqcuQ/TWjcLM2ziVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J5e/repFD+G+o9sMe9WNz+w6hvqucLTNwUSS6vaD6ERpZtDYYH7Lylnys84a146YMgmqI163viGn/x0t6caPcAoGk7TN8Hvc5CO9hPVP3Z4Mqa1eUEmgoeZ6sdUWXotf9L/w7iJTOroVuHSNHM/2v2AFWFEGvfSqkp2QI/49WWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iwiA/gaK; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2zyN8nRj2lQ1m3YrMhNam2AN0bSlQ5jX1+3xohCYZJ9I5OCnqyjmfHkh6zswM7iDaS+mIBp7SRS7yYeVvdFxuy964sJcZ2o4XyqOZ6MTuNJp9mo6SOx4X0L+AqEyKA+1wVFNPeckXvhBlxEb6dcP4ywWAXq1wNeUCeVkW0+QBZ2Zfp3X9+S9bZ9P4HLI3Zlo0Xw/3eHraTu/ThV7zAOv4uPtDi4gKF/yRT1j7oXCDW+S8aLThnxjNjD3ZEFP6jLSgRBFmXoFS0B8p4VxXlDVxce9HOfiAXhkNc21uQs00foxZlcI8Eq5ehLxbYFHEM1zUn2k8jCSH1k5tKBr3cXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iehc+rn7WLMirwYlz7DOIgV4qlW5OrMgZtcmqcxyUSk=;
 b=Ehaw8WgO/TlP1CCcyNKRqU74AMqpmhw8ZYuIvlrIHE62vR1bjNR9MI7VR8Ogsemjk8at/BD4fC8TCvqQojYqNOsn4mLeJHM9JcK5+jBjdls191fn0VaGjUn7humZU/oKh1ZQD2hUGSwlJGJy0YxwhOEEnaE9n5BJ7oxwn3tYXG4QtYfVZstMIqFC8sj1mB4V2xipJtVYZISv+w6l12/MRj6nQgaJWdOQ9V/oqwA4bltVI6x+suVF1clgJu5MWRqfSjyFZVEkivecbAxOimrd+SDiwpEh5Lx09UV4Xnl7eiD2pXqQsYd6cWpgHVx0soKc/2CBcOkY8ynuXLq1F7RBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iehc+rn7WLMirwYlz7DOIgV4qlW5OrMgZtcmqcxyUSk=;
 b=iwiA/gaKgsL1nO7HWe91bgb1R6IN6vbIwaSUh/1bL1tdphoPHtwBLZ1Etf62gZs2bitNcffY8SB9lE7P2kbUo5PhoIN0xknROnSlOzIXt7+0mM4ERp8Ek+RRhgLXlIgCC8EFxdRfll3Dro2yeBwQInWdYneR+bosocNIDL3GGQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 05:49:29 +0000
Received: from IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3]) by IA1PR12MB9064.namprd12.prod.outlook.com
 ([fe80::1f25:d062:c8f3:ade3%6]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 05:49:29 +0000
Message-ID: <e66edf65-c2b8-9ebc-965a-b848991054cb@amd.com>
Date: Mon, 12 May 2025 11:19:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 01/14] net: ionic: Create an auxiliary device for rdma
 driver
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 jgg@ziepe.ca, leon@kernel.org, andrew+netdev@lunn.ch, allen.hubbe@amd.com,
 nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <20250508045957.2823318-2-abhijit.gangurde@amd.com>
 <20250509203021.GR3339421@horms.kernel.org>
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
In-Reply-To: <20250509203021.GR3339421@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To IA1PR12MB9064.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9064:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 6164efc9-9392-4d90-7654-08dd9118c29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVnWHV0SHozSUNVRTRwT1lqeVhmVWxnSmlIYTY4cHJXUVhzOVNSYW5qZzZN?=
 =?utf-8?B?OWowNkVSQzlLckVTdURZMVFEWXJpbTMwd1Z6SGE3UDdoQ3hwMi9ucUZRdHI3?=
 =?utf-8?B?dnc0OHJ3ZzBiVDhOclpiY1h1cWF3ME5BRmN3SUxLWkJJMmRMaGZCUXJzeU9F?=
 =?utf-8?B?c0VIaE00RmhrdGlGSUM0eFEvQzYxM1pDNDlZaGhVejhzUU56blRHd3dSSTUz?=
 =?utf-8?B?dDduck1KNjdhTnpSYk5jZFhCMUJINXErM0tBcW85ZVgvY0phTXhyL1BjSkpw?=
 =?utf-8?B?cTMxazhPUmJ0Nm9GcEFMSFFPbXRBZHEzWjRsNkY3enNoLzUrYUZKSjZLditz?=
 =?utf-8?B?ZzNhZm1FdDllRG5jQ3dFZ3UycVRjUWhVMURhM2Y1YXdlRHRmQTduOXNQUU1Q?=
 =?utf-8?B?WEl5d0RCdHBpVFBBWmorOGg3R3M5T0dnZFpHMmwyeEw3QzN1NWd4aUNoeGYw?=
 =?utf-8?B?Ung4NWZZV2wzLzBQajBRSzBXZkFScUxEd2gxeTJYRlhZQnM1U2ZnbVFPa3VW?=
 =?utf-8?B?bHhDNDhCN2duUXcvQS8yV01YcTlSMEVuc0RFejVJTkg5cDhLRlAzQ05HOExN?=
 =?utf-8?B?NURqR2xZRmNaMDdaTWpSbU0xL1BpaXl5Yk9EQlEyU0ZKajgybUdTOWVGRDBq?=
 =?utf-8?B?dlhZZjdFbklPc3Q3YzE0SmE5dnNhQVZlWnkxbUhRUkZzY1N6TzBhVHZ1OWFU?=
 =?utf-8?B?aUk0azkwVDFWa3RFK1ZyK0RibHg3SVpBdG9YWmVFSDkyN0hCdWxhUk1LbWpG?=
 =?utf-8?B?elF6TzBIMzN6MExLY0dRZlphOUV3NXFSQjBXLzJQdnBiOXpYaFAzWFN3SFFP?=
 =?utf-8?B?Y256ZUsxSkRycm00TExZdkphUUFmT0poaWJXa3JsMkhML2EyRDQ2SjJMNzVj?=
 =?utf-8?B?RUczbG9CYllnYkN1STZLbXZqVDFDWlRMSFhpRXYrdlpMTXkzUU5FLzZGQlUw?=
 =?utf-8?B?QWRpdHlSc3ptdEZMelNkMENENzRLVUhCTS9rQ1ZuN09wOXRyOVF2dkZLV25B?=
 =?utf-8?B?eklIbmROc0VZTEJvTTA4ZTBOTGFqT0lhRjhQVm16T2FLOVhCeThYekkwNGhz?=
 =?utf-8?B?M1ltN0VONG1EREpyZWNaVjIwSkRTL21uSDFsRGlYTWtQTjZJVWJGL2VaOE0w?=
 =?utf-8?B?MlY0VDd2Nm9NcnpIUmdVaVEzZUdnQ0xBUTY5MENvT1FJdjl6QmdyRzlIM2Za?=
 =?utf-8?B?K3E4SEx5TTNqdDhMRWE0Z0lFclZiOVgxcHdJUFdOYWN1dEorTDc1WE9WYjNj?=
 =?utf-8?B?UVhwaEZ1MUp5ZWtzRXd3SktZVndiNWVoT3FqRDQxOWdldVNRMTVLZEZnTFR4?=
 =?utf-8?B?R3Y0L2xzc0ExNm1TZzRGVnIzWXM0R1BCaXlEN2VhcVpFZ3ZJOWFrNS9EMEZU?=
 =?utf-8?B?aFArNVpvbFJOV0U3dlA0Um9idEVNTkw5MVlCODc1NGdCRVFreWx2UmFPYXhK?=
 =?utf-8?B?NFp6ZUpXNnpGOGVhUm16dFFPeEE5ZXB2QjZhb3F6VTJYZVdxelBvbVFYN3cz?=
 =?utf-8?B?WXBjMWkveklURXJzZ29sSGdZK3QvR2JOU0pjU3dUQ1hoWmtMRnhkNlEvSmFm?=
 =?utf-8?B?OUFQN0tScmErVG52SmNLdFhNVDhWU3RmaU1Dc0NCc0M2S3NNNy90QU9ydVRq?=
 =?utf-8?B?cXBBbGI0Zml5Tk5FdWdObXp0YzN3cG5sRlZuM3h3MkkrWkozSlpqNWloTk1j?=
 =?utf-8?B?cnhFbld4bEROcWdoUC8zV0drVWdsUFBKU2xQMTVzK3pDTGM4VlZyWmNRMUFy?=
 =?utf-8?B?ZXdwWXV4VHh6OTRoQ0luT0hacWd0ekR1OGZ1UTlDUnJ6Y3UzUWRPclU1QS9L?=
 =?utf-8?B?M1g1cTN6RFJCSkZEUHNaZHBLZ0pveVpaZmRZWmtoaGNNQmZaM1Z2K3FtZnN1?=
 =?utf-8?B?NkJhaGxvb0RrK2ZJR1ZFay9OTUw1OW1xY0FHcG1qRHI4NVBzOWRaUml0WTlL?=
 =?utf-8?Q?IoVHXRw0ZpI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWVEVEhISEUzVU8xdTFqTjNnVzhmWEtkN3lNY3VJVmoyQXcyV29jdU0vbjZM?=
 =?utf-8?B?NzROWFdHVCtjdWMvdXJXclA1N1MvUmE2NFpUYnZ5ZzROcTVqUk1qL0JxVlh3?=
 =?utf-8?B?S0JaczVieWsrKzVKVE81NUw2cE9Hck0wLytCRHhPSzhTWjRXT3ljZ25JQjJJ?=
 =?utf-8?B?amVMU3RHdmRWV3ljS1RTZnUvWHN1SFN1SzAwMHlEZC9KVlFhOHoxTkFVOFVm?=
 =?utf-8?B?NGR1c0xmNzhwbTUxY1k1MVY4bUErUmh6Z2JlbElwZXo5WTB0NVo4ZTErY1h1?=
 =?utf-8?B?cGVHSldjL3M1MnZ2eXpRTWk0ZkRzOGFRTWcreVlOVXNvbFZKYWdHY3dqUjNH?=
 =?utf-8?B?SjEyUHkyRDN0dFVkRGxkYzRQTnhMTnlSNmpyb1U5dW1vT1Vvb2Rsc0FtVkU2?=
 =?utf-8?B?ai9KSlpZVDZqV1k0WDZ2WHFBcGZuNW1jY2ZKRTk1ZG9obzdBY2NkN3BIU1Zn?=
 =?utf-8?B?MEQ2M29LczFpaXF3UHU4N1p0SFJ2VGp4c1p3cEZDY0VHOWN2Vmtxem1lUFpl?=
 =?utf-8?B?M3pueUVkV3VCZ0xwUlBmaHFzMUI4YyswcjlDczB1d0dEMm5yTnZpaUFZM3l3?=
 =?utf-8?B?TnZTZlByZlBnUU1Fc3h6dHJ4K0VkbWpBOVJXNFBNaERUY1FGVUh6VWhvTnZv?=
 =?utf-8?B?ZkpxU3EvRWFpcUlaQ3B6em9DZ2gzSzQxMEFOWUQxUitBQ3RteWJtUzd5QXF6?=
 =?utf-8?B?OENuMStvN25jTEZqUzRWZitDMkVnbTJZVkRQR1hpeXRIR1FTNDRoZTZJMy9C?=
 =?utf-8?B?OU9mKzV3WUhkd0VJeisyZ2YrMnZKYkRqQXQyK3lyYmFwYWtEUHZYc21FUVpQ?=
 =?utf-8?B?Wll5NDQwRDZjb3FOYWhFMGJ3RjZkT3hmNVlhN1J5RkJzMjBWVktjcGJhMEo5?=
 =?utf-8?B?dmh3c0dWVVdBRUhkcFpzRHhjcG5WVEpPRCtoQUFmMDgzeEtVQ2pCdjgrQldT?=
 =?utf-8?B?NDg2Z1NHWnVwZnFYdW92aElTU0ttNDhKUGhMTmNidDRGU2htTTRRU0Vsci9m?=
 =?utf-8?B?M1RCaUdNbVhTTXc4SnpiVnVlZEhDTzB2UnphR0xhWjRuLzJtZ0trR0dwbG9r?=
 =?utf-8?B?QkMyUVNjYlhqOFo4eThjS0wrNlRQUDRQdlpOSkJaeFI4REMyN0prZFRVYVpp?=
 =?utf-8?B?a2xCMkozdm9mL2hOei9mYmM3WFZ5c2hmK1oyUDRWQUpXRkh0TmhOVnA4TVdk?=
 =?utf-8?B?NHRLbGhRNTdIUXdQU0FDeHRWbFozYS9iYmRDWk8vTlRmWWIrWEFXN0wyUy9F?=
 =?utf-8?B?dkJPbk5BUWtkRGtwc2Q2aS8rTmFyVUpwYkNualhmclJTcDd6UnNHZTFxSzZl?=
 =?utf-8?B?N3pmNVJiUW9iTDFNQ0piOTVHdnN5dGcwU1ZBSUpEaGYzMGdhZHdOSHJiaTRu?=
 =?utf-8?B?Y1JoRzh5VWdqeVBjeXA5eDJTaTFyK3BlRUgvRHU5NUk2amVaYVdiL2VyMDNX?=
 =?utf-8?B?K2F0NGtsQk1YQ2V5anlEV0JPR0xyWVRLRm92dDA4WHpEMlNWRzM1NS9Ua25L?=
 =?utf-8?B?aHAwU1NpZXRzOGRQUWxNY0ZjSnF5a0h4Z2xRR1dhTzlpcXJrUmtpZ290eVJo?=
 =?utf-8?B?Q1Y5elRKL0dheGdNQ1diUnU5UU9UTWdUVXZZWCswQlNvNWNSaDE1aW5aVytO?=
 =?utf-8?B?ZjRyNDU0a2YrWWE3RU1RM3lKU0RDaUFzMkpVSGE0ditUbGoyU3lXYWhQUFlj?=
 =?utf-8?B?V0NYNFMwS0lHZ1JibFY3QTdlMmNDVDZSWElVdXQ2Q0RSTzhabGw3bm91Wmtw?=
 =?utf-8?B?QVA3emM5SEVVWGhVRkVjT1YxR2lpbExqaUphWHFjOXFYRnlkdUlRMnQyckdy?=
 =?utf-8?B?Z1VhRGJOZ0tsUnhDanJXVWpMUlNKWjlISEhGaTYyL01HN2dGdlBteHoxUmlZ?=
 =?utf-8?B?WXR0cS9STXRkbTY2b2ZnZGdaNFRMQ2F3eVRKS0lIOEZ3eUpHbWJWZU1NUHFL?=
 =?utf-8?B?ZkZpa3lLeS9uMVVqdFYxaGg1dXI2K1I3UzdqMnR0UENhWmlOZVpSbHZZZWw2?=
 =?utf-8?B?TmNPblJ0ZkdaT3ZNcGNkWkhnQ24xZm0raFBOTlhjZnovam95NVhEN0VSYTVx?=
 =?utf-8?B?ZFpJQ2owUWh2M1RkODMvT1F5bWZIQjBLdmFzVjBUalNOUWowTTR4dDBxZ2xC?=
 =?utf-8?Q?gPMP4a46JK3FVc4sKdhf4cVee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6164efc9-9392-4d90-7654-08dd9118c29f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9064.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 05:49:29.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrqm+jNx8/beyQg+xEscbO54LJIbNKSB+UZ4dQQ7fp+arROrjf/ml1FI/ZOnmjeevZmOVvPGynmtE2t5PtU/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715


On 5/10/25 02:00, Simon Horman wrote:
> On Thu, May 08, 2025 at 10:29:44AM +0530, Abhijit Gangurde wrote:
>> To support RDMA capable ethernet device, create an auxiliary device in
>> the ionic Ethernet driver. The RDMA device is modeled as an auxiliary
>> device to the Ethernet device.
>>
>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ...
>
>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
>> new file mode 100644
>> index 000000000000..ba29c456de00
>> --- /dev/null
>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
>> @@ -0,0 +1,95 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
>> +
>> +#include <linux/kernel.h>
>> +#include "ionic.h"
>> +#include "ionic_lif.h"
>> +#include "ionic_aux.h"
>> +
>> +static DEFINE_IDA(aux_ida);
>> +
>> +static void ionic_auxbus_release(struct device *dev)
>> +{
>> +	struct ionic_aux_dev *ionic_adev;
>> +
>> +	ionic_adev = container_of(dev, struct ionic_aux_dev, adev.dev);
>> +	kfree(ionic_adev);
>> +}
>> +
>> +int ionic_auxbus_register(struct ionic_lif *lif)
>> +{
>> +	struct ionic_aux_dev *ionic_adev;
>> +	struct auxiliary_device *aux_dev;
>> +	int err, id;
>> +
>> +	if (!(lif->ionic->ident.lif.capabilities & IONIC_LIF_CAP_RDMA))
> Hi Abhijit,
>
> There is an endian mismatch here: .capabilities is a __le64,
> whereas IONIC_LIF_CAP_RDMA is host byte order.
>
> Flagged by Sparse
>
> ...

Thanks Simon. I will fix this in the next spin and make sure to
run sparse on it.

Abhijit.


