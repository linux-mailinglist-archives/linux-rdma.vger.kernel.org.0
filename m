Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A60D3ADE28
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jun 2021 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhFTLbh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 20 Jun 2021 07:31:37 -0400
Received: from mail-co1nam11on2076.outbound.protection.outlook.com ([40.107.220.76]:29856
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhFTLbh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 20 Jun 2021 07:31:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlPBEcqA5OMislxKJqgQqXYTxa5Msmdh7x0IKK/L1wqRFzm6EzIbg2SEFWxs3xZvR72JWbSiMImQ9WT7DOXTQRr0/fw4AgXZCS3hdErbbpviYB8NskjHzIsMOrVFOCzjks9ylxu+R2gFp7HdGBLfSYFe+o1shaOvzRWpDUl+P+K9xy4UHoLmPy7ztUk+Ur0Uk14OY9FBdxa2oRBn+opwh7SZgYIZ7cEzIgpkQYjZhylZHZV8iLNZLM+xTFZcgLvl/ktqGFX8AtXAIN4v+kkbNzKFppJmb6H51kGE6yOUuv4ED8RgHvERsaDvqUOrqlKP17SR9uh1VVVc7mYVL1rpmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiGq9BtqlVlNuBFvXypExsPVy5LhdtQFC//uuKJ8MHo=;
 b=SG+3CIET1jQyaT0gKEc0yycKJuVpeSlo/nm+YgeqiXjeH276Pxo/4y9587664YjJF4iFQq/wiMsA8TimUV2gG28McdgR5+8jrSE0MUhFg4d9UWO5hojfT2XJ5fdfcTaE+1UK4jUMz9YqYy0CN8fGe07npd1hIkYcvyhWHQqfZYMxkwAOxC/iTYDvPzSdwZ+bxHsfrmg4lE5E6EENQvbjwoDAt27gJTPjMPIny0ryC++1VIslLXq1IUTg9flns6eMFmzzv2aAsvSJ9r90xdGHNMv58AS5WGdl3B3m3NzE1fUVbH7Nr5tEKr3VWQkfTFqiYCoK2opSLb5eFy8KFXBp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiGq9BtqlVlNuBFvXypExsPVy5LhdtQFC//uuKJ8MHo=;
 b=q6EI/B//3GZ/tdyj818lYWBqiRsB3iIMtTBxI531rF7nwt4mhpFXtHoCCmj0m4hp8SZaLd5MqsEhm8+lyj5Buyime6i3KYRHMxTuRk9lijc65FhFx3EYnuGAHmh13akl09eENMC6OEdPx16ly0Xyl40k1dWJ2Tn1Y7Jzhbv1G02dZyToInoNLR9KLLuEISGh60zQcjX/o3BFPLQF22EYXx9O2X0XC0Bk6EOgm2vOzPciOUmhxzn0/uMS32Px+Ugo0jSuHQh4jtHF1l0QN0va8L6knwEldDpvXI8e8NMiRKhA7Gfkd0arFhIHL9pZ2YUUPBTL41sR7+o8nFfTr0WyoA==
Received: from BN8PR16CA0030.namprd16.prod.outlook.com (2603:10b6:408:4c::43)
 by BL1PR12MB5285.namprd12.prod.outlook.com (2603:10b6:208:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Sun, 20 Jun
 2021 11:29:22 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::8b) by BN8PR16CA0030.outlook.office365.com
 (2603:10b6:408:4c::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Sun, 20 Jun 2021 11:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Sun, 20 Jun 2021 11:29:22 +0000
Received: from [172.27.13.145] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 20 Jun
 2021 11:29:19 +0000
Subject: Re: [PATCH 1/1] IB/isert: align target max I/O size to initiator size
To:     Kamal Heib <kheib@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
CC:     <israelr@nvidia.com>, <alaa@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>
References: <20210524085215.29005-1-mgurtovoy@nvidia.com>
 <46c4d30d-510d-b329-4793-8a354642632e@grimberg.me>
 <fdef3991-74e1-63f1-593e-ac2018286ae9@nvidia.com>
 <b62e5d29-025a-0827-ecad-a48812114220@redhat.com>
 <e6623d9e-0122-ea0c-e148-f739bd15b0bb@nvidia.com>
 <0e4f17d0-5237-e9ae-44a0-4891a53bb26a@grimberg.me>
 <2237ccdf-e2b0-aab3-6e3f-297e5b7791a1@nvidia.com>
 <82ef613c-2697-261e-317e-b40d09cf0764@redhat.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <90153fcc-8ed5-6ad5-0539-bcf97d8e0ce3@nvidia.com>
Date:   Sun, 20 Jun 2021 14:29:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <82ef613c-2697-261e-317e-b40d09cf0764@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e7a3a3f-2129-40c8-a4cd-08d933dea6eb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5285:
X-Microsoft-Antispam-PRVS: <BL1PR12MB528536D6CDBA25DD9D66182BDE0B9@BL1PR12MB5285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnibXQLGKDpJGMsv/cSLE/n/sQYHv+iZYFdkFNahCnXtfCYugES50GppwfY3P+nyO5PETGphg4AVVFPgciWevDlU3P3YRqF+hW2obsDS7tHAmXLLNB8E6fZgzddPePY0ac1oHf0jG1D4eq5wZ1zYryi+95Q9j1Gh8nuMGkcQe16vl1sRDJiiVJwA0GXUe7MurUALgAJTKk0bErDDjT/RP6ZD2eIqBxxPqeXVFAqjmLxw1v2QHF9L1TLfAwGoBw8QGuiZqG0z83nAWC3uCj7AKgPFzVhse0GRxPC0pbwLTylzdlvgcXkXzsDE25RiD+KDbFUEQlM1dqaWB/WKmvWD2vitbIG45sbHnhGrRpU9fT1noUVJ6IaoLzOTktlp2D80GwQMrnCXpElQqjUlU/BZcDYySPEp7QdCxxRBIxg9eo0U6wQy2Qrp7KqUuFYR6F5tKX2e7ziaqr3FMcOk2cxavMExJBzmR+ZfCOS+9o4oGBgWjHCCfbL83jPN3NgFusIQzZ5yPzLF5MbL5leZya9NKKA5D3c9s8/tthpU0sjqh/RWRSdlW8iy88fg02mF0es6kP2kDz1ANJ86V/GKPcwGLBRnZNzeOkFdvDllns+bKqlOCKUpxVuAvQ2jwc6gj576vhnPAzitDkxFhw+vUKGeQZyWT5oqV1Yyz/Cik2HUGosrH2T0iAYFXjy7FKRM66Hy
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966006)(36840700001)(47076005)(16526019)(16576012)(54906003)(186003)(83380400001)(356005)(6666004)(8936002)(70206006)(86362001)(5660300002)(82740400003)(36860700001)(7636003)(70586007)(107886003)(36756003)(478600001)(426003)(110136005)(31686004)(336012)(26005)(8676002)(82310400003)(316002)(2616005)(36906005)(53546011)(31696002)(2906002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 11:29:22.4004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7a3a3f-2129-40c8-a4cd-08d933dea6eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5285
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/20/2021 11:11 AM, Kamal Heib wrote:
>
> On 6/9/21 11:45 AM, Max Gurtovoy wrote:
>> On 6/9/2021 2:04 AM, Sagi Grimberg wrote:
>>>>> On 5/25/21 7:22 PM, Max Gurtovoy wrote:
>>>>>> On 5/25/2021 6:54 PM, Sagi Grimberg wrote:
>>>>>>>> Since the Linux iser initiator default max I/O size set to 512KB and
>>>>>>>> since there is no handshake procedure for this size in iser
>>>>>>>> protocol,
>>>>>>>> set the default max IO size of the target to 512KB as well.
>>>>>>>>
>>>>>>>> For changing the default values, there is a module parameter for
>>>>>>>> both
>>>>>>>> drivers.
>>>>>>> Is this solving a bug?
>>>>>> No. Only OOB for some old connect-IB devices.
>>>>>>
>>>>>> I think it's reasonable to align initiator and target defaults anyway.
>>>>>>
>>>>>>
>>>>> Actually, this patch is solving a bug when trying iser over
>>>>> Connect-IB, We see
>>>>> the following failure when trying to do discovery:
>>>> You can work around this using the ib_isert sg_tablesize module param
>>>> and set it to 128.
>>>>
>>>> So it's more OOB behavior than a bug.
>>>>
>>>> Anyway, This is good practice to be able to establish connections
>>>> also for old devices without WAs and we also aligning to the sg_table
>>>> size in the initiator side.
>>>>
>>>> Jason/Sagi,
>>>>
>>>> can you comment on this patch for 5.14 ?
>>> Actually, if this is the case, why not have a fallback when creating the
>>> QP? Seems more reasonable to have the exception for the old devices
>>> rather than having those mandate the common denominator no?
>> We first wanted to support 16MiB for isert but then we get a report from
>> Chelsio that it will dramatically reduce the total amount of connections
>> the can support.
>>
>> So we created a module param and reduced the default to 1MiB. Now we
>> have similar issue with Connect-IB so reducing it to 512KiB (same as the
>> default for Linux iser initiator) seems reasonable.
>>
>> Users that would like larger sg_table will use the module param.
>>
>> I would avoid doing fallbacks for that and maintain a code that might be
>> dead in a year or two.
>>
>>
> Well, from the distro's point of view this code is not going to be dead any time
> soon..., And the current user experience is very bad, Could you guys please
> decide on a way to fix this issue?

As mention above, I prefer the simple solution for this issue.

I guess the most of iSER users are using pretty old HW so defaults 
should be accordingly.

For NVMe/RDMA this is a different story and we can use higher defaults

Adding fallbacks will complicate the code without a real justification 
for doing it.

>
> Thanks,
> Kamal
>
