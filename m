Return-Path: <linux-rdma+bounces-10725-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D172AC402C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99613A790A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE020127B;
	Mon, 26 May 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oRapW53+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3F4207F;
	Mon, 26 May 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748265584; cv=fail; b=EpFScKpmDNviYClpT1dRqZLAbBTydJOaVylX3+UEn88NJHL2RJ0Cz6VQK9VsGnHxcOYYGMibC2sMtMw0ZXHDGbVc0bxEL0WeyryKW1p105plzmmKtRfWvuWW8SEg1/9BlU+1STKYoJVUjbc9g+qKI1V2+t01240IWpCwQnELSOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748265584; c=relaxed/simple;
	bh=1sbVk5dRZ+qm9T6zBJwRfyLHvcX95MOP3IyCocaCNkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bbwX3YgybCg9YzWtuMfCrxTHUefhOzl2wNbcj78TXQKwh/kwxkfANP1jDNSlwL4Kiw6iV6fltIBB7yRVWbls+c7OgXoyKBAmSt0oHctmpdwF+IKv6TLlnHf3I4dVMy5/4tUWSHdJ0OPREq5mEBzxb0JcjNnmY/4Fa3G19bmFaPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oRapW53+; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCAVs+7OQTM986zFctNBcwRUBDkFjZEMOuOsqu3xgmRhalNbqKtoehtGFSl8DUh+Ck1agC/1yvnEvIOSphPqwyVSt+AM0ltbJGcH1GorQ33qdlDIlA0DpYWVl09YboXy/YbBCjiDTufbNsbM7Bbr96XAjukUD5H56GpiyARV665j9MO8AOMOT+hkbX3AVRuibXZ3E/oOLgwYXwPKiTmU7cxuLNYLIuL5txLTT7K0YLqByhamN9quEFYoQdKB5ebX35EmSct2NKoFEDuoGERaKuqRJHcxOVbcS49Y5uwxGzqkT74mnJSBZDoQ30oO7sR0fR+LaGtrhnfJwIYpiV0ELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mqiux3d1P5VrcbMhYEEgIH1vPlYpxw3GyoopyidxIY=;
 b=S5x0xwFd6lXhIn4JemJgHIwYZDlnQa+J54GIRvwG70lQaxYLmGhwE06CBOlSmwjZ+2Vo94+hQPkDfp8qdZ9PDD3yBFxz5N4ZGgxPF7BJXMYh55dN7s7zZRCeN+LxUrP/eGvzf9bzpia2ezwVWhbP1sSkYOIBNGfZNh+gzjbky5eHjpfF7ckf9pprLEDl4tNH6TXoNE7srAtrmyVnapQked1Zn5GHoLXFhnH6aV56X8k8bBY3HAO1+c6iAkfw5WOp4L2gAbtH2bqe3XifkfPoEEnF8Btir40ycVLZH9gRuyNlresBwQhiwIu1CtAQ6Qko6rMy21scZSZkIpu/X+A+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mqiux3d1P5VrcbMhYEEgIH1vPlYpxw3GyoopyidxIY=;
 b=oRapW53+DhBBy+hmjY0j4Xib2wHsIPEmZhWKLGM7c2BeRDc//SVKIKzxosHjLQnXd0qB/3AzJ5AjnNn9ZlhoPPWx8ugnCGdmRQOnUptwGqDjzyAxrcA3N/+PbePdFRBwE6/hsY55i0DHb7K1usbeva5MRC0Vov+vpUx2Bwy6Wu9rF7PVHE54aeu8Ki96kveRpOciGDALZapj7s5ZEhIM5Z4qEnVx7X82qPexWEMBdKPfgu+8QooyU9/ErtutT0I06YqWm2NmFBVYIxApSO2hefWKKjUgVnZT7nd1JHxZGsQJ16cYaZm4HbDYdcpyA3u1Izv5SQ5V6l+xnbyKlQ5YJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Mon, 26 May
 2025 13:19:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 13:19:39 +0000
Date: Mon, 26 May 2025 10:19:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, leon@kernel.org, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250526131938.GB9786@nvidia.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
 <aCuywoNni6M+i07r@nvidia.com>
 <6bc6fb63-2a31-808d-91f3-eb07a681e631@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bc6fb63-2a31-808d-91f3-eb07a681e631@amd.com>
X-ClientProxiedBy: MN0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:208:52f::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3933e0-0d0a-46a1-c44f-08dd9c57f7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm9LTnJ4L0FidUJNY2FVVWdDRnpoS2VCd29XYzRkdXpZU0lNbjZsSmppUGp3?=
 =?utf-8?B?bURaK0orUjJ2OWhYZWpscTBaWDNaakJkSnBWWE96UDJWOVp0OUNIckdkZ2Y1?=
 =?utf-8?B?M0tnRnFSRDVmZkZGempVUXVzbDR4RnJ4ckxxZWc1TjVvMllPd1JTbW9SNlNh?=
 =?utf-8?B?V1lyZklEVzExa1pKVzFPbDE1VFllZDh4bnRqQytaMUNhVmRibkVpaUI1WGMw?=
 =?utf-8?B?V0V0WUE5RXhvS1R5NnZLSFR5ZnNWM2Z0OEQwWGRqUzllb0VKSXd6WVlrcmxx?=
 =?utf-8?B?dG40MFk3b1hLY0tzOGdJZHM2dU1IaG9EWEdaMFh4SXUvWGVzWVdrUU5CL0xW?=
 =?utf-8?B?TFR4WVhVYTlxdkZIZzJiOE1xMXZlZUtVNEJ4N0dZUU9rMWxhNzQ1MGlBaDN6?=
 =?utf-8?B?UFJKMm04K2w3eER6V0NSUDBrYjJ1TGU1amhSbndDOHk1Y3ppdUNWdEJwd0tU?=
 =?utf-8?B?eVlSbG11cE14TDkvb2dzS3hiTXMwUVVnVC9UUTFDVVFOelBld0hyY29zcFJX?=
 =?utf-8?B?NGF6QzNVMGVERWxtd2lxeUNiU0pnakpXNVZTM096eThTaTBMNjMwbGRjVlUw?=
 =?utf-8?B?RHk2UXB0bmMvMlZUSHAzNFQvOWllQUdOTzQvcnhOdmErT3NINHlzSGpCNWdq?=
 =?utf-8?B?Y0NzbGtNR2t0ZmtVM1o2UFBvK2ozY1pUT0FHcVFOVk1xeHc1VmtTY2pSWVRO?=
 =?utf-8?B?a0N4SGVRU3pGTkVPaHNPOFQ2YU9tYTA1OXk1Zk5YTjhDbTBrM0xaWVVCdmto?=
 =?utf-8?B?VklhLzVwY0JUaXJzdGpsejVBaEVCYSsvYllTYStydjB6bWpCa3BZNlVoOFEr?=
 =?utf-8?B?UjVJTld0aUdzU1UxSExhejR0WGVqUHFxRXhCZ0U3YkZtaEM0U0Z4bk9jdlAr?=
 =?utf-8?B?MzZQSW8rUTF0R3k1WGEvU0lDRndoWjFkS2hodG1sL3B0ZlB4Qk1WNzBQMGJr?=
 =?utf-8?B?N0t5UE1aZ3RVakUyT0VYVDQ4R3dMN1JuczNxWnJjYXc1TGQ3TWNoS1p3WFRj?=
 =?utf-8?B?eFVlLzBWaUFHV3hFeDIzTXV1a3JlaEhqQnZHdW4zQ3B0aVNZK3ZlVlZ1TGFk?=
 =?utf-8?B?OVhMWC9NVmM0NmJ0YnZjRkJwSkhSNnViR0ROTy9QbEQ2SW9Db2JxTklTSG8y?=
 =?utf-8?B?VXBnN3FFZ04veE1EZmUxZDRWdHBma09XMTA1TDRPL2JVNDljYzhtRnZCSjMv?=
 =?utf-8?B?a0lyMm9ITTdibnFzTnNQVkEwSkNJbkYyUHVoRUpic01QOXM4ZnR2TVZZTGdJ?=
 =?utf-8?B?eVk3ZHVDM2psclRRZDF2SmI2ejBrMXk5L0xMbmVCNTN4STVIVXlpV0FvUm91?=
 =?utf-8?B?cVZ1TUNuWW1STlhLMUIrNFlZTXQ5Z01WZmoyWWNSK2lKTVB6MkJ4bWk1aG1T?=
 =?utf-8?B?N3NrbjBxR0FibGxpdHJrUjBLaTJSVlBuOTZ3WUZCY0hZNWYrN1cvVkxKdFFC?=
 =?utf-8?B?UGRVNE1BaW1BeWdkeHljOTN3WHo3aGxPR1hvVWEwdkZZa3ROQ1l5UFd5cUhK?=
 =?utf-8?B?aG13ZHpWRmkwTmZnS1h2YzBDaUJLY2dPL3p0NU9rd2RNVHg1NzVHL3FzZCtO?=
 =?utf-8?B?ZVVwYUVUdmpYU3RJOVNQVGI2dlBlbGJWVjl3WUd4UjVrN0pTRG05S2o0VjJw?=
 =?utf-8?B?eHZOajZIU1NkUGdUT25GWXdlYm44Smc5VUlMaWZ1TXNpby81VE9BOVRIc3dC?=
 =?utf-8?B?Nm11Zi9xY2hrNFpHdkN6V3BjS3pVTStnb1pNaThTZmR3T0VpSEVHZ2FRQ04w?=
 =?utf-8?B?cHhpRkZsYVFiV1NzenNVd0FoK291MkNWMXBUblZ0cS9NeDRqNTR2cDlmSVN3?=
 =?utf-8?B?L2QrS0Q1TXg2UkdaTkh4ek5GNTV3RzBYRFhwdjlCUGpmWW9sT2h4QS9lakVo?=
 =?utf-8?B?dCtXUFRQYTF0cE50bjJQYVFVdXQvdDJoRWNBOUtVbXBxNURLVGpNY3I5Qncr?=
 =?utf-8?Q?6XkH/2cJUDY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5ZQlN0Z0puenVqV0pzamhiUTY4OEwzeEpQVkxRUG1mY3RHb2QwNkpvRWJ1?=
 =?utf-8?B?QVl3MU5sNkZPYnA5cUVUVDBNTzdiQXhnM0JwRGp4c20yU05wTmNyYWVFS2hn?=
 =?utf-8?B?akFGNnh2c1F3WUJFNG9yMnBScjBES0F4UGZSY1IvcUhoMmFHRGsxL3pua0ha?=
 =?utf-8?B?Y0h5NzZ6bHlUMUxuR0ZuMzJSTXdXdHBsT3hSOEdSWWR2S3E3dy9RSTROdGNL?=
 =?utf-8?B?aUpPd2x5eUdMcTlLYVErQVB6YTZSc1o1am01NVptdVBOQjM1TVNUUmZWNW03?=
 =?utf-8?B?NHhRdmdaK29WWTNPMFpmeUZwRWpQK3EwRkY0T1hGUm5CTit1M0l5em9nNjhS?=
 =?utf-8?B?T3duTi9xdGt6WkRFMmVBdGs4c2FYM0Z0dmo2Qy9XTHJJWWJ0aGJJWURMT3p3?=
 =?utf-8?B?Z0hQczNQNGNQQWRwalR5ekxwY1N5NEF3bnB5OUJrSHBZRUtseXdjOXRqY2Y4?=
 =?utf-8?B?MnFYUjdRTVNBQ0FJYXNHRlZ2TG9mNllqc2MzRFoxcnFlV1N4Y1Q4NkEyVWlQ?=
 =?utf-8?B?ZEM1MzJqZnBpUGkydUZ4SXF3MDNTaU5kTDErU0wzQ2doZUdLbXJJMmMzT1NU?=
 =?utf-8?B?QThGN2duWHlwTEFWNC85YzdiYjlyYVVoN2pZdHdFQWIzM3UybGFOTzhySFl4?=
 =?utf-8?B?VklvR2w5VDhtTjcyL3gvSzU1OTk3NE1DNnh0bVd3N01YS1dXR05UY29IREIr?=
 =?utf-8?B?ZHlUZGc0R0Q3Q0ptdjJjY0krNUc5ZmgwcTluM2FSVkViVjRGbUJEN0ZKNGdi?=
 =?utf-8?B?ZEhIdU5JUkdtdGpCbUY2d2E2TnY1ZlNraVlILzd4Um1KMktDYkFsSGo1R1Bq?=
 =?utf-8?B?bGdBcmU2TEhkRGJPaEhhZTZ0NTRDVnAzQXlXU2orNEc5dGY2NDdaQmpONUVX?=
 =?utf-8?B?bXMvMDhnb0o0aFZHSGkweWFTS0ttTHBRY2YxQVc0dlBpU1p5RkJwME13bTBx?=
 =?utf-8?B?Zm5kR09JWHpIbjRaOVBWandUZWhWYStGdjdPMkJvanMzbVVwUXJBd1VVTzJL?=
 =?utf-8?B?bkVPeWYydUR4NFQwbUxqd2x0UFNZTG5uenNJK09Ud1BjRFB3dHZLZFg4QlI3?=
 =?utf-8?B?K3ZkeG1WZTdaTDNHR095U2RKejgxR1dNaGIvMlVlU214VnZ0K1FNZUllbndv?=
 =?utf-8?B?OTd4OUlWeFhzQmlUQjFnNlRQcW1EbmNqWHVUb1d3ZWFLUEJSWXhBSHNpTndy?=
 =?utf-8?B?K0Q0eFVzQkxFVmw0Y1FIZmI5NGdSVDV5cS9Sc2pYVmNvQUkwcGU0aW1uTU5H?=
 =?utf-8?B?YVZ0T3ZMZWJlakY3aS9uRkVQTmZlaHdIVHpRNHhTNEZ6ZlAzRmRjbHR3MjA2?=
 =?utf-8?B?cmluS21YVlRPNlV6WDBITzVnMndRcFZJT2IvemlrTnVnWnE1SUYra0xMUnlj?=
 =?utf-8?B?SnhUdVVIYmdJc001NVhLZ25JeENOVzNVUDZrQVhXOFBaMTRMeGgwZ2s0Z1RW?=
 =?utf-8?B?bSs1WGViL0wwbFZLckdocmhzQXVMT3JyS0dtNFlNQkF3N1JHcFgrOGNqVHRi?=
 =?utf-8?B?MUp3eURsYzNRUmNMeEM1S1JHV0xIS09lUVphZWJaRzErR1gyWHpjZTNPdEVY?=
 =?utf-8?B?bmhQVzgyeFo4aWlpV01pL2l3eHRpYjkzeThoUmxSd2V4ZWJYalUzbDJONDNQ?=
 =?utf-8?B?VDQ1QmNJSFJydmk3YXRQd1h0bGNqaGZSZ2VnWXpTd2FFZ0hrbktRdlZPUHQz?=
 =?utf-8?B?TXp1Q21JNjVWeDhYZmNtV1p3WGpsNGkvRkMrMmZSK2cvaUM2UDdCUjFveTdx?=
 =?utf-8?B?TFV2MUZDcU1tZ09NU1U3L25hMzJMcXpUY3lRcDhjMzFsWVp5RXp0MlRkVEps?=
 =?utf-8?B?N1IxYnVmVHl5anJGVmduUmlPYXNlQXpFd3dPSmlLeGRTd2EvNVU5Vng4b2Vh?=
 =?utf-8?B?YlplR2grYUNnRzM4OEQ4NHVIRHJLYkd6MWRNOE0vN2dkcXFLdEJBL2hHQlpM?=
 =?utf-8?B?MkRHV1JQT0V3ZkNNaE1KOHFNY24wcmVncUtVd0FubTNIUitKdWNjQUxaMUY0?=
 =?utf-8?B?RStnNTdKRVNzVmgwVVdRYThucHB2MU82WitYWG1ZdGp0U0VjaWwyYkJzYTVT?=
 =?utf-8?B?cytxMkFWSGd4SWRuS3V3cE1GVWJjQlB0MHlUUzF2KzdnZkEyV2pyUTJpV2VC?=
 =?utf-8?Q?h71E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3933e0-0d0a-46a1-c44f-08dd9c57f7e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 13:19:39.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4hiXfVWJni45xZlfA6EXo2LicON+Er9TCp4TvnEh5HwWiwdjnqYABf4PlTICHLF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

On Thu, May 22, 2025 at 04:58:19PM +0530, Abhijit Gangurde wrote:
> > @@ -1231,6 +1257,7 @@ void ionic_destroy_rdma_admin(struct ionic_ibdev *dev)
> >   	}
> >   	if (dev->eq_vec) {
> > +		// Locking? Add a lockdep assertion if caller is holding the lock
> >   		while (dev->lif_cfg.eq_count > 0) {
> >   			eq = dev->eq_vec[--dev->lif_cfg.eq_count];
> >   			ionic_destroy_eq(eq);
> I don't think there is a need for the lock here because the device is
> unregistered and the queues are all stopped.

Add a comment then

> > @@ -887,6 +893,8 @@ static struct ib_mr *ionic_get_dma_mr(struct ib_pd *ibpd, int access)
> >   	if (!mr)
> >   		return ERR_PTR(-ENOMEM);
> > +	// This seems strange, shouldn't this do something? If you don't support an all address MR then don't define this op.
> > +
> >   	return &mr->ibmr;
> >   }
> From hardware lkey zero is reserved as a local dma lkey for all address MR. 
> I would make it more explicit as mr.ibmr.lkey = IONIC_DMA_LKEY (same for
> RKEY) with that defined to be zero.

Yeah, that's a lot clearer

> > @@ -1454,11 +1466,15 @@ static int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
> >   static bool pd_local_privileged(struct ib_pd *pd)
> >   {
> > +	/* That isn't how it works, only the lkey get_dma_mr() returns is
> > +	special and must be used on any WRs that require it. WRs refering to any
> > +	other lkeys must behave normally. */
> >   	return !pd->uobject;
> >   }
> >   static bool pd_remote_privileged(struct ib_pd *pd)
> >   {
> > +	/* Same comment, except about rkeys now. */
> >   	return pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
> >   }
> This is how we allow the qp to use the dma lkey.  If the qp is a kernel
> space qp (its pd has no uobject) then we allow use of the dma lkey by that
> qp.  We do not allow use of dma lkey by user qps.  If the pd flags has the
> unsafe rkey flag, then we also allow the qp use it for remote access.

OK, so this is just about permissions because you don't attach the 0
l/rkey to a PD? Add a comment in the ionic_get_dma_mr() that the QP
needs special flags to be allowed to use the 0 l/rkey.

Jason

