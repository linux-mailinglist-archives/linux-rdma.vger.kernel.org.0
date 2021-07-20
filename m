Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDD3CFD49
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbhGTOhQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 10:37:16 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:46400
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239014AbhGTORg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVwgFN6B/QnftR2hBM+E4QZS31X1k5om6chC7DH4eXfvlH9/VsVIqx8/yEGhhvUZhH3rpp/tYMYUbUXBtMLbjafXEbXL91RT1PAB582QelJPOVBkdAc2gFk+pgxqVXr1UtCPLVq8D5sliE6F50J7LS/APJY3fm/sv6U+F2qoC2mxZfMlZjsykvF5eIvemE6BI+jEDxl8BGT10QWMwn86D1gcreurWMjsZ5fPK20X/vMtvR6eErFVdwii4gUTeHEJcH7OXF+7eKim8i5IZdQsdHHxhv48xMQw+KAyHMk1BjLiLXLfb5eT/qWTxei1E8d4bKz/kApmey/8i7dJw3ueeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cfjultOK9LzTEwnxBvkpQKKTEMPHO7RQRZGNPW6G0g=;
 b=DZcDqhK0yQx8jjXrnM7bb/ZZeWBaz8cK3ciam8aoakm+RGIwUDc6zPQFQJQajLjlmi1bPGndjPj9O2jAbxZANKKwC7HXTJpcFEYF1Jp4FKTpsriIr18FlPKfjW07qKuPjvBe5t6s3mwQY6t3z+i/Iaz1CHxWlOpAgxqljPghZn+aPfybiZojHGedPjCrCajDJlSXo6ZOevz2AKsb4xEN4Oot0iSaNDVgc4i3gvhv7DYyfkqxLq4mp1W8uWVFYH1Twv9TNEC08NAmDa1CGSBGLZDqgGZxeL7yMQW9tu2DpitnikrGF/ZVqPfhmVVZR5eBXcdYK7LToCg3xDTJ1gsfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cfjultOK9LzTEwnxBvkpQKKTEMPHO7RQRZGNPW6G0g=;
 b=eV4G8kLCh60b2YQUhTgklxOWX5ajarESG76+SEPfFtfpo7Hj57OvVJV48eWcGVNEF4m0PLkhzvTb8kAoG8krOQeCx4VnrYgLjXxD/wxaQ+RFpdEe5qJHMpTYKV/a9fPL9pL5haPyBJw03qnEOs184n9++Od/nrAs7AJYekCprLLJmg1c97FKpkHEMp1B0zPI7iBWecVbvu1ZvqIewJqY7ZYxRxv3Db/vWOBWcqW7G7RX3kuXBiX1yAm9hBiSt5rMZeiN22o3MMh9613rZh9TvzvQQqD0YJHgfHqACG4qNH28y8Ix1BCnTI/Tmb7+xbLDOlXqp/g9NWEci9HQa/JRwA==
Received: from DM5PR1401CA0011.namprd14.prod.outlook.com (2603:10b6:4:4a::21)
 by SN6PR12MB4685.namprd12.prod.outlook.com (2603:10b6:805:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.30; Tue, 20 Jul
 2021 14:57:53 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::6c) by DM5PR1401CA0011.outlook.office365.com
 (2603:10b6:4:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 14:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 14:57:53 +0000
Received: from [172.27.11.115] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 14:57:50 +0000
Subject: Re: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
 <20210720081647.1980-4-yishaih@nvidia.com> <YPaOlTDrV877Jgnt@unreal>
 <2054ad99-254f-4e46-d193-4b1183000d87@nvidia.com> <YPbBFAgEOjfLcYrI@unreal>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <6d0d7c10-600d-03b7-194c-e7356d07c558@nvidia.com>
Date:   Tue, 20 Jul 2021 17:57:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPbBFAgEOjfLcYrI@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2448d51-5dc5-4d1c-b7d7-08d94b8ec02c
X-MS-TrafficTypeDiagnostic: SN6PR12MB4685:
X-Microsoft-Antispam-PRVS: <SN6PR12MB46852FDC60F26C83866B96BDC3E29@SN6PR12MB4685.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+tm5EztoXWKDaH3PJ5/FYRyntlM8tZA9E4ZyhpXwzkpJsIKan6TMvnjHoVjXoo54It3oczupSO4yegVwU0W6JjbNmr0iWr9fy6WfepZPxcGhuq/oMJjUYGlZ+E+oo2N3eW7bCwZrNxmAcUSKav+7L6+o1InWIkV/D0mZpYn0Re0yJtAbP8y7Kqhg5YPOqLlqPf9YBK74WM5fVnFTgXJFED4dkOS3/ZdbgsByW+IBnQFbiKJz8kZLgn6yeBsJ500ATEXz59WPdOgk8lLf/t6sZ+5OKIIusXey2TZCX3AIxwnmhaF75n0xhV+RDxWQ6SAqUsu/oqtr7eX2xuRXc3F/BIsNtdpOE1pEkozwuCuksNUxFQtYlmCrQqh2LkDfxffzsUzgM3gS/XIbOC8vElxUonKeDqrIGuR4Hijm6zylL7af/wH7RWSq/ubBs7jMVBs7QIiUIbYtd4RzDW/idRb/lVtzkVVuSWo6Hr2KG4LB7MnwQb2EnxpYiOuRhOCLHsaO3cAMT3aUtOC1jbrvx/W5oZZvcKL5LRQAodVjUZoopg3b1yNKE6D9qgsXAeBnHSD2mEj0T5vTxvCHvayKO0k1eFpBU3WL7MxT/jzuUvaAyX94JKnUl7y4Y7R939gTVCUf6GxubHnRDamZd0xDmQXQczLeL4upVsHamPxRkb5vkerrf+HHpsuzL1O56XuXumtRWjCqbvTRpoNEHZDYs0sN07itXQsGSJ0Y06Oi7EA4zyYoOjXK60CJ0V4MsZydXQqagTzieqbqyrzmYg3bO09/cYjV1cd8hmHIXiT72z6g5cI2XMj6dbUMwaNzu8BZdwd
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(8936002)(83380400001)(70206006)(82740400003)(8676002)(107886003)(186003)(36860700001)(6666004)(7636003)(6916009)(16526019)(31686004)(2906002)(53546011)(26005)(356005)(5660300002)(316002)(4326008)(36906005)(426003)(966005)(336012)(478600001)(31696002)(2616005)(82310400003)(47076005)(54906003)(36756003)(16576012)(86362001)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 14:57:53.0081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2448d51-5dc5-4d1c-b7d7-08d94b8ec02c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4685
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/20/2021 3:27 PM, Leon Romanovsky wrote:
> On Tue, Jul 20, 2021 at 12:27:46PM +0300, Yishai Hadas wrote:
>> On 7/20/2021 11:51 AM, Leon Romanovsky wrote:
>>> On Tue, Jul 20, 2021 at 11:16:23AM +0300, Yishai Hadas wrote:
>>>> From: Maor Gottlieb <maorg@nvidia.com>
>>>>
>>>> Usage will be in next patches.
>>>>
>>>> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
>>>> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
>>>> ---
>>>>    providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
>>>>    providers/mlx5/mlx5.h |  4 ++++
>>>>    2 files changed, 18 insertions(+), 14 deletions(-)
>>> Probably, this patch will be needed to be changed after
>>> "Verbs logging API" PR https://github.com/linux-rdma/rdma-core/pull/1030
>>>
>>> Thanks
>> Well, not really, this patch just reorganizes things inside mlx5 for code
>> sharing.
> After Gal's PR, I expect to see all mlx5 file/debug logic gone except
> some minimal conversion logic to support old legacy variables.
>
> All that get_env_... code will go.
>
> Thanks
>
Looking on current VERBs logging PR, it doesn't give a clean path 
conversion from mlx5.

For example it missed a debug granularity per object (e.g. QP, CQ, etc.) 
, in addition it doesn't define a driver specific options as we have 
today in mlx5 (e.g. MLX5_DBG_DR).

I believe that this should be added before going forward with the 
logging PR to enable a clean transition later on.

The transition of mlx5 should preserve current API/semantics (ENV, etc.) 
and is an orthogonal task.

Yishai


