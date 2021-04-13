Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0046A35E795
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 22:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhDMU0S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 16:26:18 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:56081
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348195AbhDMU0R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 16:26:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiujGI8AWbsp5IG5EENmgi161zB4uZuK47eljfCdD/y47By71dqj2AhGM4rbzyKnwgtOwtcrBnOJ8wjnEZ7LvrFkOv+Och4GOF2lHYEc3jmTFW1dQ0TYqVmdI8Esw4K/g4LhgTpAa+Md0DltkjH10wfSDGnIZcp7XjmQTAfiI+sQJUWsTY2jfNC0HOKtR9foqMXQ2MVmQAtS0JgtMoYJmO6rgLa7b7WF0qSPF44CkDqPpW0++kSXTGGAGsnL4zi7p8bmPaURfpZbPatHfrCUvRmOIGRThETvqRVKMCHeMmFx1exUbyseCCvSIH2kjXen7VtNNH1YcmgUqA8UkYESKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38+XC/VI7CJBI8clOYwBrH8ygCHKShA7M6MhYLsyfNo=;
 b=D1cunxKArvjl5QuUNhsKSqSMYsgFB4na2tkbvGFcO8z29K858V3iOoj3J1G7qOP48Bpy6NN44Yvd57GBci/SJHjgCNl9tqrKXCriALW2wzrK+Dvn2hNMIwDvEQ6fpzJGcVlNVh+8sxBa5cHuQn9HczMXyAjK1GUyVBl6BCZiVVaorz4IuriKgXmtF+yP73CP2jbRwPeI3GVksLGUHRJKdmsnr9IzBsubaD3f/jS3b1Rqq+pU3q/gR2bI/wUv+zgCLinfALuY6TCBmEfnEjhAB6ZdYo6A2dA3tNPG9Qt6VUjHshRmHkP+YqPS9zEn+I/DzimVNMpU4vOWMRaE7CV3wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38+XC/VI7CJBI8clOYwBrH8ygCHKShA7M6MhYLsyfNo=;
 b=snIWoYLteU+6Ctua1yJ8a8gPwwpkBMWFDAc8UwgN6/nwCEikvb59Dq7C8wVRvoVlW7LGABrPUodWWjvxVMxjxHI+AGBnLcT0nWtIcG4+2CAX+FccKpiz307q1/Uvv/I4CGcPER4WW6P0Rdmg78rfRnAo3J/J0BXqhLv+NY5YzhztxH1HjpmiWUr5qlNPVVx7zq9svscxaN5BEvC5PMwV8oEPd9qwKbZLp5CZcAVJCgJ3NlxtypHjPdbq567moiQ6QDWCSEP11TNwtx77lWU8R2gtS+ZXFs93w9RWru+iii2wAlvhXsvOdY4P8u0B5Flzyt9wQNX02Hwj4ahDO4woRg==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 by MWHPR1201MB0080.namprd12.prod.outlook.com (2603:10b6:301:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 20:25:55 +0000
Received: from MW3PR12MB4473.namprd12.prod.outlook.com
 ([fe80::9862:a230:a0e4:b9ea]) by MW3PR12MB4473.namprd12.prod.outlook.com
 ([fe80::9862:a230:a0e4:b9ea%6]) with mapi id 15.20.3977.033; Tue, 13 Apr 2021
 20:25:55 +0000
Subject: Re: [PATCH rdma-next v2] RDMA/mlx5: Expose private query port
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-api@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
References: <20210401085004.577338-1-leon@kernel.org>
 <20210413200309.GA1350353@nvidia.com>
From:   Mark Bloch <mbloch@nvidia.com>
Message-ID: <ba250d13-337b-04e0-110f-bdeca76e6fd4@nvidia.com>
Date:   Tue, 13 Apr 2021 23:25:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210413200309.GA1350353@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.110.77.193]
X-ClientProxiedBy: LO2P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::10) To MW3PR12MB4473.namprd12.prod.outlook.com
 (2603:10b6:303:56::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.26.74.9] (195.110.77.193) by LO2P123CA0077.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:138::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 20:25:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01bf6f8e-3f58-475a-5f9f-08d8feba56f1
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00800922DC3FEC9BAA098454AF4F9@MWHPR1201MB0080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7tyIb58momRfEA0/l0oTKPjYd2jZ+DZHMQXGf3gJvg9PKWG2y88qryQmdazMY80sDCdInatzTo/haI8D50fpBbdaOPpruvNspqjb4SijLGdum8Ki/pvTi2kQF4p+XVVn3h5RhLqi76mkJeuj+j7A0FOTkt61bPhJ/XZwtHfp/ljjEzNVH+JHug7yYJsHry5kVocuiKHUfdkRjWa6FHmbMYaGoM05teoTZUjQQyuUCyoWkYbu4d20ocKwBqCE/KDEZgsuPVlWKPcz4AA9w4uknnFoox1h+z/Hd8odlaKSowzdpg3TB4GtkPQmZ0UoWzEqHvLZDb0I8eQ8gystAEvXreXrW13V6NrWkZzuL271ioLSyxAUO0v8rbrnqXrldLvFK2islJO4SQe/j0F08lZNGvJGGliYAzYFYwuC2DCzSgTemRhxESivy9XMT0a32+FEPuC9t8LiP1lxG/9QxSJaGir4fbNcLRYM+lGY2aHY6uCxLb3UyzSHyajR+erNgTF7++xKNJhsmyNz1UDjKMM1KBUuuCQcTjqvdg3YokhUO2bZQewvvQs+BlLFQ5nVvrFtrJNkMPRyoC5RcVVBe3fV80OLUCmSDx8Yx7WlRvFq3bZ3Mhw1TpxjPkSpc+EiU26d+neYc21fhrqCjLXQmWWo4NdoUrxG0KR6zYxEry1mz6sOMr4gD5un8FGligMFb0X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(6486002)(5660300002)(2616005)(8936002)(31686004)(86362001)(26005)(6666004)(186003)(54906003)(66946007)(8676002)(55236004)(53546011)(478600001)(110136005)(2906002)(38100700002)(66476007)(66556008)(16576012)(956004)(16526019)(36756003)(107886003)(316002)(4326008)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmEyWHJHMCtYNDR3TDhIbmh2V2hWSmRCWUhBbTRyUExxaU91UEg0ZkFrKzRD?=
 =?utf-8?B?TXc3SVBJdnZPb0taYUV0M2JaQzlzR05XNENiTUVRT1cweklUbTkyc1RmaUNO?=
 =?utf-8?B?a1pZdTdBcU5TaHRpSW9PSVBhMXVrZHZmZUNrZEVjVktTcXJLQlpzNWxSRmlr?=
 =?utf-8?B?VGJtdk0vblpSYXIrcVVVVE9tbktpcVlTYWdDdDV5RzlwR2orNzBxSnRQT0lH?=
 =?utf-8?B?MzlVVDdNYnYvZXJ5bGJGRWJhQ3BoSWVkam83T09oSW41bTRBNFc4M21oSk9O?=
 =?utf-8?B?OXNoWVo4NmRaOHJyZ2EyQmtSVFFBWDRwaHRWQWZkZEp5SVFhNXdjblhETFZY?=
 =?utf-8?B?ZkxpTTBtVkJha1kvWmwvUnA3NWxQazF6eDdtemdNRjk3Y1p2NTI5VXRtZEZH?=
 =?utf-8?B?dU5YbndOZ2x1SjZ3eDVMeXZsamZmdTZRRi9RS3ErNjZmWDdSdGpQRkZlUEFu?=
 =?utf-8?B?cHhmMzRldWwrZW8xOGFiMzhjV0x1dEVkSUY3eUxRUURPME5IeWEzNE5MZWph?=
 =?utf-8?B?UVBTUXhiMUdzb1VabHVXTGJXRWJSanl5R044T241QlpwaWtBWVlzRlVBeE5F?=
 =?utf-8?B?b0RueDJ4Mzlsb3RadnBUZmg1Z1BUYm1LZ1Q2dVYxYWc4ak45ckQySVZUUVZO?=
 =?utf-8?B?b3VWM1k0R2xWN04wN2FFQlhDbHpabUF5WW8wRmw1WFNoZUF4SjZvYnFVclFE?=
 =?utf-8?B?ODZlUVg4UGRHd2R4YkVhNmpMNWV0aE4vUTZyZzFOZURQSy9KMnBtMjJFR3Z5?=
 =?utf-8?B?LytTaHRxNVptM3JkL3lCc0tVbkFWME45dUlaOTlKTHh5SlJvZitUWkpudjhp?=
 =?utf-8?B?T1hwR0xaVXErZDlHdDBaRUltOGdRV1dIQWJXNURxTm5MQ2VQRitQb1hKclNT?=
 =?utf-8?B?Qy9YdzE0UGRGOUJYdjF5SUJUYTBkMGo3U3NVNHR6U1hYc3hPLzl2K2U0ZitJ?=
 =?utf-8?B?R1Q5QzRnVENkQXp6NEVsK3F5cTRKN1JWQ2hZZXVSWE1MZzVibTNFZzBMVnpl?=
 =?utf-8?B?bFNBOGVETlNyMy9oaDZmSVl1MzJ1VkdoVXYzR0dCYXcxaldsRHljd3ZkNnpX?=
 =?utf-8?B?b0QwL3hybEhNTEtxN01yblBhVkk5dmFKaUo1a0VINWJlZjAzQ21qY1dabUFl?=
 =?utf-8?B?cDFreUR2dm1FNEtUSFlZTk1ueUxMcjA5NC9vUEpaNGlBalZLNFRqUHNDZjhU?=
 =?utf-8?B?U3NGcldObEJHeEEvQ09CVm1Oem9IR002NDQ2VVI1bmF1aU1ON2FBR2xJblJD?=
 =?utf-8?B?WHZPcCtzTmhyaVpBbDVYUVVhWlA4NVpLVlovMW96eFVsYVRuVC9zNlc3RnJq?=
 =?utf-8?B?emtJWEVDRnBjaGJwdEhOU2tFVHNLbGlCS29VeGh3aFEwOHZrbkViMStUdXBZ?=
 =?utf-8?B?UndEUFhXeW13TFpnRkNuS0dJWFk3S3p6aTlwOG5veXpxVy9idUwwZVpCRDIy?=
 =?utf-8?B?eEh1S3JiUzFnYUM3dU1uaHB4Yy9kcDBPeGF6UlJONGF3WTdmTDV6WFNrb0lD?=
 =?utf-8?B?TGxzSlNGOWhHNjBWUWh6a2lSRy8vRWgxTWlseWlwQ1lFM0F0OWhWTTVzODF6?=
 =?utf-8?B?MHh1UzRBRGRlYUZFNXQ5RTV2M2s4Z1Q5cndLa1BYYWNEU1I1TGhOZUpycHAv?=
 =?utf-8?B?MzRiY0Q1MzYwWDlOVHFtRnhSV0pabGdXRzBPYnBqRW9LQ1pBZDB2RExzWjhH?=
 =?utf-8?B?L093QWFXYU5ubHFPZ3dGcDMxbkVsSUhKcDBGbVh5Tk9sLzlvYVRoQVR2YUhL?=
 =?utf-8?Q?6E7yPf/dqtCnlUPWwd3VIaaGWJn4OxYlzzqRXrP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bf6f8e-3f58-475a-5f9f-08d8feba56f1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:25:55.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqZmcQ5lI1oWZOKgBseackZUriRIlQhlpGexxyaL9m5n+ttyGGlcWFicnUZYoriDymSD0Y3nQ0IWQ7oj8buVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/13/2021 23:03, Jason Gunthorpe wrote:
> On Thu, Apr 01, 2021 at 11:50:04AM +0300, Leon Romanovsky wrote:
> 
>> +static int UVERBS_HANDLER(MLX5_IB_METHOD_QUERY_PORT)(
>> +	struct uverbs_attr_bundle *attrs)
>> +{
>> +	struct mlx5_ib_uapi_query_port *info;
>> +	struct mlx5_ib_ucontext *c;
>> +	struct mlx5_ib_dev *dev;
>> +	u32 port_num;
>> +	int ret;
>> +
>> +	if (uverbs_copy_from(&port_num, attrs,
>> +			     MLX5_IB_ATTR_QUERY_PORT_PORT_NUM))
>> +		return -EFAULT;
>> +
>> +	c = to_mucontext(ib_uverbs_get_ucontext(attrs));
>> +	if (IS_ERR(c))
>> +		return PTR_ERR(c);
>> +	dev = to_mdev(c->ibucontext.device);
>> +
>> +	if (!rdma_is_port_valid(&dev->ib_dev, port_num))
>> +		return -EINVAL;
>> +
>> +	info = uverbs_zalloc(attrs, sizeof(*info));
>> +	if (IS_ERR(info))
>> +		return PTR_ERR(info);
> 
> This allocation is not needed, info is small enough to be on the stack
> 
>> +
>> +	if (mlx5_eswitch_mode(dev->mdev) == MLX5_ESWITCH_OFFLOADS) {
>> +		ret = fill_switchdev_info(dev, port_num, info);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return uverbs_copy_to(attrs, MLX5_IB_ATTR_QUERY_PORT, info,
>> +			      sizeof(*info));
> 
> This should be 
> 
> uverbs_copy_to_struct_or_zero()

Will address both comments in the v3. thanks.

Mark
> 
> Jason
> 
