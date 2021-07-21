Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C453D0A2D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 10:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhGUHTA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 03:19:00 -0400
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:32357
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234363AbhGUHSN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 03:18:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfFKDksHB8anqCpnZ7N6+xhD00GrQYWGF1CCeNP06fiP70Ne0/05tKIkjN+oC1Nq9m63Kx3WUqIzeTH9HP8grg6xDvVutm4FR+UO1jBvk8Ohy9l8wXZ3+/55bCQyzTn5e0ZfA+0ptqzxH4p+FzngHYRVoOgSxAf/+iuv6wjXtFs3XeOBPxDQDbZzXj7dpUSI6byPSewK6F2F9mT1gRMNCEF/O+3pUUfUuqmJdcEwTdkihlcctn/7Kx9mzClnzURcv5koajkpkBmHSH75Lr3/DeCx8qDifANPrmizrAHKgHG2DHgpRoYVmg/ETEPqFXuG+X4+lrbMb8ujcXJm85V7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpCjPAysYu5Wid5/0QVuojzftAoO9yaoIfqAqGTYOL0=;
 b=fRr7DSMSZX8C5Rz8HOXQ5y8phbiV02H9/8nx6cq8yNcD1HneqiSap66ERJZf3EeHesmDhOjGnsh6SdFdwXev77L8aLj+zbCxzKD7PisERvlQo4Tl5rzTG48QvdvkQPdcTAsx0aRJdQ1k2BMRRgXWCLBRQ7enATSDJV84NX9eLpJnC+nrbiJaeq1OY5R+0MPeS4iiuQ28Gre1o1Q4ia/lEsrwJAy/4wcqaIPGsl1RPJqRrBfEe4TFX6Sumy1CPB0PjfNbKvVVg4i6mZzfbf7D/dgI4GUuP3PmCZmwA1uoV04o2EtY6o4tQihEsV+hBD8oIXJJRvntYSP8ss5Bbpii0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpCjPAysYu5Wid5/0QVuojzftAoO9yaoIfqAqGTYOL0=;
 b=eV2g9Pt3hTUfB19DmgKw4YUcCxZ3pUqiIuuIPtRV0HhF3UillJnYNYzEMN+VAJwpcqnPx4eL3HsASMthuYFzgKAvWV8nRiLUBrhmpj8xypyPS5sf5H+qwZ06QPIQ14aCmgA4yUvvYvas1ra9Dq123H2RCX2qTXz6kq4NVbYkM0ko4EipRjf0MAHzX25lUjhMEVQRbUPR6mR+ecXP9/wcMVjQ/b6YA8Q/0ZeqiZ5+nHZwiMRGTwsgeqsQBAwyb7hFhu8TyNjle0AhkqqTcliob9vgt7LpYDgJ78pkYpw6zpdXAxwlCJtXBkNRY5ugaWXRc7IkFmb7tRzbnCFpjld3AQ==
Received: from MWHPR07CA0002.namprd07.prod.outlook.com (2603:10b6:300:116::12)
 by DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 07:58:45 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::87) by MWHPR07CA0002.outlook.office365.com
 (2603:10b6:300:116::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Wed, 21 Jul 2021 07:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 07:58:44 +0000
Received: from [172.27.11.33] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Jul
 2021 07:58:41 +0000
Subject: Re: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
To:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>,
        "Leybovich, Yossi" <sleybo@amazon.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
 <20210720081647.1980-4-yishaih@nvidia.com> <YPaOlTDrV877Jgnt@unreal>
 <2054ad99-254f-4e46-d193-4b1183000d87@nvidia.com> <YPbBFAgEOjfLcYrI@unreal>
 <6d0d7c10-600d-03b7-194c-e7356d07c558@nvidia.com>
 <36390571-e7ab-377f-b2a7-26e2a70e4c94@amazon.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <36f3d02d-e70a-dc8e-0dbd-07fad437c2c4@nvidia.com>
Date:   Wed, 21 Jul 2021 10:58:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <36390571-e7ab-377f-b2a7-26e2a70e4c94@amazon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0648efd8-4f86-4c08-6776-08d94c1d5ce0
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-Microsoft-Antispam-PRVS: <DM5PR12MB46804FF1BD1189B3FD721165C3E39@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzPFAojhHBhQZ0XMySJCXKnEJaMn/evP1P/Ps8SVHLSfebxeUHg1xx5mZOSMKkPGV43Mqj8nCaKpZulj3q3m+gjS0oSgsCqPMS2Glr1pSCAItnVfKGHLy7l3WqrL/oGyArPoRccnkWgZ7HuFYLHiLBU+jLtwrKiJh8ARBDrNMQlSzaIY1bdDcXztisw+iUO49al2Izd7ldRfCP3w9wfkFOeYTcpNBkMbuhT4vh8MAjWmu1YlUSYKrmpXNM8N9rX7TYmY5j+ctDMvxezKhTBa1qNa7uIuo3nBoWaqiKnK01lHPVqFLhf+1MtJlYHCJKV6O66HkJrvQ+bsRNmW0V/+lc9qowzLUQSzaUgzsFWZhErUVPxTtUfkd9DxhQf+o9GdpEtto4Bgp8B47kiEAGZeLEE1KqUG6Ttben9eCfWYmWOlnGBvLTzzdT6vRAVyqU8Ua+hhxpBl61Q58RFaO8SsUxvSdvJ9DZVGP8HWbiBkrDRl06NMEXVq0qMVy8XcgFAhZREOp2M6RFxsUQbqG0+H6Q7Jxa+jbnoWab/lhXwpBp58kzfZsd6eYgEYwIPxcKPfTMnT8oowgGgaVqXYDPVkditrzCTMi/x6GPyOP3Wc7agrMqYvNSfne6xOVjeSwYHhkgaF9pI2vq3xUnBsUFGOn4oAnO/KD5UXHUTirNI6GIb2rywf6B38Rji67zMWEAbeGI87Ye9hlkgQKZ+WF7iFyZYNN0SoTaUUzGgmlxYGE2E+IFX6TST4K6irQJ20XbNY3w0vU9rV8E84x+3KPVtCiDMIx7iVWCrmpBddtUoT+z/Fc4rtbJwSfIHnDuDQzwQJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(8676002)(110136005)(82310400003)(2616005)(478600001)(356005)(186003)(336012)(82740400003)(83380400001)(2906002)(16526019)(54906003)(426003)(31696002)(8936002)(26005)(86362001)(4326008)(47076005)(5660300002)(31686004)(16576012)(7636003)(53546011)(70206006)(70586007)(316002)(36756003)(6666004)(36860700001)(36906005)(966005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 07:58:44.4509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0648efd8-4f86-4c08-6776-08d94c1d5ce0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/21/2021 10:05 AM, Gal Pressman wrote:
> On 20/07/2021 17:57, Yishai Hadas wrote:
>> On 7/20/2021 3:27 PM, Leon Romanovsky wrote:
>>> On Tue, Jul 20, 2021 at 12:27:46PM +0300, Yishai Hadas wrote:
>>>> On 7/20/2021 11:51 AM, Leon Romanovsky wrote:
>>>>> On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
>>>>>> From: Maor Gottlieb <maorg@nvidia.com>
>>>>>>
>>>>>> Usage will be in next patches.
>>>>>>
>>>>>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>>>>>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>>>>>> ---
>>>>>>     providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
>>>>>>     providers/mlx5/mlx5.h |  4 ++++
>>>>>>     2 files changed, 18 insertions(+), 14 deletions(-)
>>>>> Probably, this patch will be needed to be changed after
>>>>> "Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030
>>>>>
>>>>> Thanks
>>>> Well, not really, this patch just reorganizes things inside mlx5 for code
>>>> sharing.
>>> After Gal's PR, I expect to see all mlx5 file/debug logic gone except
>>> some minimal conversion logic to support old legacy variables.
>>>
>>> All that get_env_... code will go.
>>>
>>> Thanks
>>>
>> Looking on current VERBs logging PR, it doesn't give a clean path conversion
>> from mlx5.
>>
>> For example it missed a debug granularity per object (e.g. QP, CQ, etc.) , in
>> addition it doesn't define a driver specific options as we have today in mlx5
>> (e.g. MLX5_DBG_DR).
>>
>> I believe that this should be added before going forward with the logging PR to
>> enable a clean transition later on.
>>
>> The transition of mlx5 should preserve current API/semantics (ENV, etc.) and is
>> an orthogonal task.
> Yishai, if you have any more concerns please share them in the PR.. The
> discussion there is going on for a while and you've been quiet so I assumed
> you're fine with it.
>
> I disagree about needing to support everything that exists in mlx5 today, the
> purpose of the generic mechanism is to unify the environment variables, driver
> specific options do the opposite. IMO masking out a few prints isn't worth the
> divergence.


The options in mlx5 gives more granularity and supports vendor specific 
options, this may be needed down the road by other vendors as well.

If we come with a new API need to consider such options in the general case.

NP, I'll comment in the logging PR as well.

>
> If the mlx5 provider has backwards compatibility issues it doesn't necessarily
> have to use this API, but we can at least covert most existing providers and all
> future providers that wish to support such functionality in a unified way.


The point was that current suggestion doesn't allow a clean transition 
for mlx5, so we won't use it unless the API will give a matching 
alternative.

> BTW, why even insist on having backwards compatibility here? Do you actually
> have useful code that relies on debug environment variables?

Logging options (env, mask, etc.) are kind of API which need to be 
preserved, it's used in the field for debug purposes, no reason to loose 
granularity and trace.

Yishai

