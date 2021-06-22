Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833E43B0491
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFVMec (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 08:34:32 -0400
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com ([40.107.92.76]:47585
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231972AbhFVMeU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 08:34:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVdj3/0yGxMw11TeFhi/pZTTmBt6NBEQCB6nLfBz+vTLoZYGImItdfducADNO54afgxSRZt+wawfj33KxnFcNj4Sn+yQPTnhiH3zmHjhx+ctInMYiKJWFRhTlUlqwdbX4mOblIy2ilEu8gJ4bUl7RPH0TXJGoM4VYnI4I8Vdi1hSE8CRkYCQ15bE8RrIZ0MmVS5HKKZoa/8sqZhjMaNwOwaB0VIdAFGsdBhc6WbkKySdNBJXYjAbQ/dvaZrX6hagnHBrsdArg9uCu1CWIu3MF+Op3quoE2ahOAyMU6cOmXpkzbm8NE5VAFWo23k/K6uKE8H6FrDq4dKhYkalAtrgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjziJm3mv28htWY3QmpEejP8g0l2dQnhOVes2CxEWM4=;
 b=Mw+fjy2CCKrOiI5RuitvdA2GkWfHNoP04HCNDXl/U7srUm4mseM+XTAFOttiGA8vauwb6z20nlz4I/vmfc10ZPZ5DPwwocfiRKMjiyZg3TeS9MYXL25ROFCu+bVGM68rQVQXXfviMjgaCNnxWtsXRDH5w7uJoJRZ3XEPrGFbS3WhSapPBcEQA9IIHCPegO+3PyQTUq9SrOjEMNGXusvN8MgIwqdxS6RXmeT9CBCs8/ADTyArIp0xWucUVvWojVBKDxRaOuw05VueZzaaq5YFg/S82F+72x/E8q8XEPqvTP3CArHBGBV+AbjGBeDAOMiocu72kouUthYK+Ps4fpzf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjziJm3mv28htWY3QmpEejP8g0l2dQnhOVes2CxEWM4=;
 b=bCuMNi+tvG6rsOTLwv1/5jGBIc7e/OVeZueIRQ85uQdWBja0eNoc/z6B97tWzkp0OrusswKep498BVwJuFpRlTfA0P0A2B7NH6ccCrEwgoQaSXWu2w43uiNotuYObPyra8Ijug3DLuvbUzaEwgeLyjndgxPIf1/baCjjKNApdttWPrtb2nZNnUSpPtsMs23ondx99Fftc+qxE5Z4PuJs6zccVEDKT0KRTaf10MKTwcAePlEcvWbLR6ko2Cz+g4XBYa9/uVm+m833lFvxg6SsuFgv8Eg2wMr+pDp45e6M+qVxrY9MkbmbIwKW0v0cMBbx6ro8uTe6bg+eY3y8KD6Mjg==
Received: from MWHPR15CA0028.namprd15.prod.outlook.com (2603:10b6:300:ad::14)
 by MN2PR12MB2928.namprd12.prod.outlook.com (2603:10b6:208:105::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 12:32:03 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::53) by MWHPR15CA0028.outlook.office365.com
 (2603:10b6:300:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 22 Jun 2021 12:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 12:32:03 +0000
Received: from [10.222.163.31] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Jun
 2021 12:31:46 +0000
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
 <2237ccdf-e2b0-aab3-6e3f-297e5b7791a1@nvidia.com>
 <82ef613c-2697-261e-317e-b40d09cf0764@redhat.com>
 <90153fcc-8ed5-6ad5-0539-bcf97d8e0ce3@nvidia.com>
 <d6e2f70a-1885-9cc3-f82c-0c0abeca2c7d@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ba0b44fa-c93b-34fa-41c0-8bd492cda92e@nvidia.com>
Date:   Tue, 22 Jun 2021 15:31:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <d6e2f70a-1885-9cc3-f82c-0c0abeca2c7d@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23ec2311-86d8-4094-552d-08d93579bd81
X-MS-TrafficTypeDiagnostic: MN2PR12MB2928:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2928976A77E3795C2F7BCAC0DE099@MN2PR12MB2928.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7dbq0R0w+q0DIL+pmYZvxxZUrcWc9DOL6ORQsEECYpbVENU6UaJ3kqGL+Z/OqiZvO1e+HILSJ9pjqPYLl30Z3g+uAyjuNpYpAg1fiDRcHgAZchQGwSipAepYNeXRY0lCPnXPsaXeIen9aJpSru5YlMC1wOUXSut3itXhKmnHjlcKHCj6TWa6Qs1hUNVFKYyLwNOVRrBULQn+2FphlxKJwkSUHeW76MSHn7fcYrijLbWO6Wquen5LkHCW9MFKa0pfIdvNk9+i3CMuqzqbAvSkaEFChuUL3MM6yRt3yXW18fj2vtB+4eN9BdMAI1cU1BGdgzkouCN/iOHftG7RvkjvXLnELGWErAUGSXpPS6m7BSdnjrwaanE49ChEJ7Pmcp4wgyGJXjm4vce56sXb7xcIdzx0iHHXymGz6dozXUobvsfBQBao/a0Ew4ykV5TtcXWdnU0SDcb3BGP4/XAu3kh5d2lzLRcluVionQ/uvU3hm07MDt/wmrjqaebaYeOxanM9Oj6+HVb5NkqvEX+PqfIqc5g+g9fE/EQvTkycPoe1y1NGaTMFCsk6JK7dW2S9YTNC/SKgSV0HWM4AsDrR4Gbgf4jSt7IVcmigq81zjehHALjTPzzXlv+zCw+evmSyL4CQUvuz72RuL1oMJOAjNa6ArVhTlo8Mn8DhM3c1ZjF/p3u7RtQCZ5YULEL1DUkxo2s4M6DdYwBp3hqjUmfXiHddClXYuQkwjcnA/SPz6BIIVmE=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966006)(36840700001)(16576012)(47076005)(36906005)(316002)(82310400003)(54906003)(82740400003)(31696002)(2906002)(36860700001)(110136005)(26005)(53546011)(4326008)(8936002)(8676002)(5660300002)(70206006)(2616005)(426003)(31686004)(186003)(7636003)(16526019)(107886003)(36756003)(6666004)(478600001)(336012)(356005)(86362001)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 12:32:03.5271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ec2311-86d8-4094-552d-08d93579bd81
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2928
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/22/2021 11:56 AM, Sagi Grimberg wrote:
>
>>> Well, from the distro's point of view this code is not going to be 
>>> dead any time
>>> soon..., And the current user experience is very bad, Could you guys 
>>> please
>>> decide on a way to fix this issue?
>>
>> As mention above, I prefer the simple solution for this issue.
>>
>> I guess the most of iSER users are using pretty old HW so defaults 
>> should be accordingly.
>>
>> For NVMe/RDMA this is a different story and we can use higher defaults
>>
>> Adding fallbacks will complicate the code without a real 
>> justification for doing it.
>
> Usually when you end up changing the defaults multiple times it should
> be an indication that it should do something about it.
>
> But hey, if you are killing Connect-IB anyways, and you don't see any
> sort of regressions from this I don't really have a problem with it.

I don't know why you conclude it from the above.

I just want to change the defaults to what we had in the past. This will 
help OOB for old devices. We did the same for Chelsio.

And we see that RH team is also interested in it.



