Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD1A3A0EE0
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhFIIrp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 04:47:45 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:49965
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231917AbhFIIrp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 04:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyFqiYmz0rvJNIGZLpRM0bHEVV2QUBuoFzZGHxpQJuKB80EsjP5hyNzdgOQC9e8CIZvp5Jbqvn9RWkeGnMts9oaw3d6hoJ6YVvrfKufy0zGQCXSkNo6iLi7vKeXw0pqKM9HgRYL23NFH/GQIaHGBzOjNn0OmvKvFtsXhII5vUmba7rRbtn6f9il69JY3wVebAaYBFqm/7UFLY6HzUOhCoIXeg0Qood3AJ1SiVFROfm5Gf/MQF3CgVTcGIUiNCS8okkysuCuXEk4JpY/jvKqwbWWTTZCOUjhPc+CcQgPb+etbkkjPLS+wGgVNRE9GCoMW9XtX55tFmamLXQbGVlC2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzT8uLff6KCKF5oDikn4Kb11OVZqgU2Vrjz6sqzzWV4=;
 b=YZ8gw5DRDAe0k3q0XddF3B8xJPebBv2fJburcQ17H8g6HJGIXFVAY1CFORt7u8zd6ekf9jJzqFCFCT4jhr/Ox5qEZYCBCsCIQpQGq0rccVAk3nXRGh707bx/yj0wRdvpWEBIOFbliqXWLpea+i9Qe4jlUl1MKNCuu8YIkIhUITS6kRdyynFEK5FkxRYEn6zwnvy1LBct3WcBRdqOlo5tuzzdF8PjN1upSSSs4opfcajim4T/z1YclDiltGnu03hTe//qeVxvwdckAIJGg4/PTdYrhi3l+p8UAvszou3C0fgkd0m4qzQQKzlVzZUnfuLiazcfkUgv8KUckmYXQXyCIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzT8uLff6KCKF5oDikn4Kb11OVZqgU2Vrjz6sqzzWV4=;
 b=Apmd5sCuatEnI6UulKZzXhjsoyTy0+kyMWqn28yxeshf5pC8MjCuptZKWlNY4YjG3j36iBrO47+12x9sVCtUQaH9hEiTe9xclrTKx+rG6pENNUPGKbe1baqT47kAxYJj3UUsJzSnx2jPqAYuYQ4VoJhw+8mshHn6HXIVXChjDgjoRyrl+XLpbv6XsjM6sqArA18e5KGg8euEmk31t6NTGKC+sIcbPsyc30+8eqJB4rqdH8gvCAYK7JkE8A1eJRIZILQK1+MY7dCbedcbG/wLrifi8evwBI+NMO5KHmoIo6FTRODtJA/sZN/zSf3DTNyHDM7vWqbI5pA3EYAFZIs5dg==
Received: from DM6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:5:80::39) by
 DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.26; Wed, 9 Jun 2021 08:45:48 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::ca) by DM6PR08CA0026.outlook.office365.com
 (2603:10b6:5:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Wed, 9 Jun 2021 08:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 08:45:48 +0000
Received: from [172.27.14.222] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 08:45:44 +0000
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Sagi Grimberg <sagi@grimberg.me>, Kamal Heib <kheib@redhat.com>
CC:     <israelr@nvidia.com>, <alaa@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
 <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
 <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
 <0e4f17d0-5237-e9ae-44a0-4891a53bb26a@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <2237ccdf-e2b0-aab3-6e3f-297e5b7791a1@nvidia.com>
Date:   Wed, 9 Jun 2021 11:45:35 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0e4f17d0-5237-e9ae-44a0-4891a53bb26a@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3eadb75-ae8a-4570-7ce5-08d92b22fad2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1641:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1641DEDB3786D3523DEFFE1EDE369@DM5PR12MB1641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agxcxBL2i0RXJzmgkxNuy6cbS9NaYmvuBgtdE2eN0gY+ywWNq4as10kDdGctawC6SnuW16YDhi83+zFt6Ky/YrPTUnFGuhwcct0x1VMxjcpBQ0B9R96J2eCFRRXI5AuYNwOuweO1/w2kjAcd6bZXZtGFMTBAGMVotEq7a3cooigX5U9jDRCy+1fI1bYHb4G3Y50iepfPo25XnwVHoYb0Zwp3i9MuHvgiKr/Fuop71hmocYwXMWKxlp+is1LPHvAsGr6fw1gfehaZc2x0W7wiy4543PYGHBQRxiMdH/gkffVIMaXmp+a720vIxWVn7XzrDL5cxb54HZ8wdqC7tJh9mTEs4pjdDBWvB59kqM6NAJqC2+icFa4mPRpS1/skqGpV1spAUdNNHbsLFLT5pWrBoSuq4QHzQpZLRdNTTV9iovoOR0Mx8lxgt52bzgMTgkw/5wb05kGI3V7TirKIiAyovZNWWxuTQ6D+iXCMGHAhbAJFDDuqTXhDXQw6oCnHlFYWVHNO7YvN7fuwjO6v9uMUwLlwCZmnpMFZdavXySwu2Ffo/HCuf3JEHcTjiSx23LhsW2g2JyUxgzM4d9TVpWGsAqqSix0Zqz18rpdMbG3jfnIQ/1flWijI/q2siaPxBtT4tK58F9FB8A6ItUAo++wBIEs94fhCLnyv1combQ3YYRr1w9SYIB6WKayvoUKS/1/R
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(2616005)(8936002)(478600001)(16576012)(426003)(82310400003)(36756003)(31686004)(82740400003)(70206006)(16526019)(186003)(107886003)(54906003)(86362001)(4326008)(83380400001)(47076005)(5660300002)(53546011)(36906005)(2906002)(36860700001)(336012)(316002)(7636003)(31696002)(8676002)(26005)(356005)(6666004)(70586007)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 08:45:48.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3eadb75-ae8a-4570-7ce5-08d92b22fad2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/9/2021 2:04 AM, Sagi Grimberg wrote:
>
>>> On 5/25/21 7:22 PM, Max Gurtovoy wrote:
>>>> On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>>>>>> Since the Linux iser initiator default max I/O size set to 512KB and
>>>>>> since there is no handshake procedure for this size in iser 
>>>>>> protocol,
>>>>>> set the default max IO size of the target to 512KB as well.
>>>>>>
>>>>>> For changing the default values, there is a module parameter for 
>>>>>> both
>>>>>> drivers.
>>>>> Is this solving a bug?
>>>> No. Only OOB for some old connect-IB devices.
>>>>
>>>> I think it's reasonable to align initiator and target defaults anyway.
>>>>
>>>>
>>> Actually, this patch is solving a bug when trying iser over 
>>> Connect-IB, We see
>>> the following failure when trying to do discovery:
>>
>> You can work around this using the ib_isert sg_tablesize module param 
>> and set it to 128.
>>
>> So it's more OOB behavior than a bug.
>>
>> Anyway, This is good practice to be able to establish connections 
>> also for old devices without WAs and we also aligning to the sg_table 
>> size in the initiator side.
>>
>> Jason/Sagi,
>>
>> can you comment on this patch for 5.14 ?
>
> Actually, if this is the case, why not have a fallback when creating the
> QP? Seems more reasonable to have the exception for the old devices
> rather than having those mandate the common denominator no?

We first wanted to support 16MiB for isert but then we get a report from 
Chelsio that it will dramatically reduce the total amount of connections 
the can support.

So we created a module param and reduced the default to 1MiB. Now we 
have similar issue with Connect-IB so reducing it to 512KiB (same as the 
default for Linux iser initiator) seems reasonable.

Users that would like larger sg_table will use the module param.

I would avoid doing fallbacks for that and maintain a code that might be 
dead in a year or two.


