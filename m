Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30533B7FC3
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jun 2021 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhF3JQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Jun 2021 05:16:44 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:39232
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233541AbhF3JQn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Jun 2021 05:16:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsyMNCw61VWtRnkLM4a8Ihye5waqO+TxitxY0HFNf8FFPeANgS9qr3xr4HH7+BrqEKBINIhl5MjQ0TVK46npHFl9ptr79XnPNMQaKFDNhzPCUxScUZ69goPlImT/VjFVzO8YK2oPF2XU7FQEadC+JIe7yRE0ykPcec3dyD4M+HF8Dai3oefzQOEj6Or9JB7IbpAJDYTRB4BaIpwv5Tqgp44O9IhKwlLusA8ZiEWES3wsDL6VMCj0J0E+AYGcjjOKw1t8bmr2wUTCYbdugBYK+B4beouVfRzS0uN5iudGvcMb4mPMO06VGoP+TTUXbbVg6oQ3ZkvJEiuPCEigqzW3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+NpiHDY4oLaEyvd7pBTtRhjKa6Nuv+a0GE4I317l74=;
 b=GKOM91bBJwPFwG8uFFkNq2T4kv7RZHlc46xOYxn4wuqQF88PqqRFEud7KbGKn73JbsDu/cljNfdsnAzSDHo9T8xfkJOkWoXQvejIfUPz36WV3vuj8wzZ9Ad8NkBXx4ZP9QISzQ1kGK7gV1lSAa8W4/IWx2V/axFoaCIiZi0A+NxbEYeaVnCPTDL9zR8LAo7b0dqsmknKi3na5Nv9kVfYeMSLRaKDAJNrWkhmQ7qcJi8f0XKJTVfa8/bygqTX8r5uj9QdiewPIKhaXkbW2f/8p+JrmZcFfwVY0iGtZoFrHrKP1nwB5DpYt0thYQ/co8hC7mvzzYWXA+/md2Kx1+0XMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+NpiHDY4oLaEyvd7pBTtRhjKa6Nuv+a0GE4I317l74=;
 b=qdgolryVL4V8fb8qRCsfSW7LZhoaq7c8fe6lvzqOuxtEmjA1jsyZyPRFgk2OkKr9bJkKEIzJaA372KdGwQwvIKRJqQ5DyG7amhyq4DKyzzZQwwFxvw/uXHDx5SIndphCTzXmqV4grhjtmZ1OYUkyg96aJVaotkLENCdRxejP2td03uvP7whkNVu28Rt89LHIHirNag21DVOG92LHvpjYsZTX6cCLImeVr4EDGK4ZvqYglVJ5HGwfb3kZTtHTmQ9zZCOaMgDQuLjiOFfmLmhWrmMi94+UmEW743D/txvgUdf3rXLa6zjD5PnPsNg8hxojk5eQ7Rv0cPz7/c+3pKOpLg==
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by MWHPR1201MB2526.namprd12.prod.outlook.com (2603:10b6:300:ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 09:14:13 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::78) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Wed, 30 Jun 2021 09:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 30 Jun 2021 09:14:13 +0000
Received: from [172.27.12.24] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Jun
 2021 09:14:08 +0000
Subject: Re: [PATCH rdma-next v1 1/2] lib/scatterlist: Fix wrong update of
 orig_nents
To:     Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        "Mike Marciniszyn" <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1624955710.git.leonro@nvidia.com>
 <dadb01a81e7498f6415233cf19cfc2a0d9b312f2.1624955710.git.leonro@nvidia.com>
 <YNwIL4OguRO/CH6K@infradead.org> <YNwPX7BxPl22En9U@unreal>
 <YNwQLV87aBdclTYe@infradead.org> <YNwW83ZpXZSSPDfM@unreal>
 <YNwaVTT0qmQdxaZz@infradead.org>
From:   Maor Gottlieb <maorg@nvidia.com>
Message-ID: <2134e949-0569-c495-cb0b-f0324c5920df@nvidia.com>
Date:   Wed, 30 Jun 2021 12:14:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNwaVTT0qmQdxaZz@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df31ab85-3b3e-40cd-053f-08d93ba76d9b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2526:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB252681339312BB721A85415BDE019@MWHPR1201MB2526.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLxpsltPJ4l+2akYdRl3l6ix/xhDSTv/tE0+Y6Ko3HWPhhdOBEqb467YUrQvA/wEEj8W8KJZd2hwvk9u1yXUsfxyW1aLqoZ20XlZUfSBgxOVq+9MywQddJzydBxx4bfjPqQ7JEvJ/RZj1F3K8RgryBs+pqmOZRIQD9nddzOtFEDVYditgfJrCpDwuc9Ff73oTeDj7FjMk0nLyqVhvk3R8Gimttjgoo32hm0xediXIJE9erFZgguHWkepo9HKsp6nYhjaryu6VODSyQ7wTTim0uO6XEOaR8wPIJEd5A5rjUvT4/LwAL2/PQxAl148geYgKVBZi1F2MIwYCjhjA4AKadf+CBJN9QOi310oICnkMdmWhNTos2XqCTn6iKU6uIqZzg9d8+G3ZBujl3k5h/TZDm1yrS0Q7kLpF3rgsNWBjGO4qeA5ud2rNOqJIhI8sD4WdLEe9WG82YlW3qhykN2MEIoozgfKyLijX4RpvL6PYjh9/VoIR2eILqmSFGBUPwB7TdPzMjtRp+/c14ldmjI3u223v93Xpv971Mc3z7vYYnqT8d0QY++rDXjv9GqouyT+7NLtsRyBT7DxnpgoC+1IhQ/erYfl5vhSgIKsIt1uNS/nK0yao9q9lKKHVm+74kqOCiQbdiTn7ySkMo4jBUpH/IkI34EMbngpR7i7gETqXogq6Yn7zImdKhZMHThkkTT1qtltTitg/vEemebHr73YNYkCu65AJFyWvrZdRyFurDU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(426003)(36860700001)(53546011)(86362001)(36756003)(31686004)(82740400003)(7636003)(6666004)(70586007)(2906002)(5660300002)(4326008)(336012)(478600001)(26005)(186003)(16526019)(70206006)(47076005)(54906003)(110136005)(8936002)(356005)(2616005)(16576012)(31696002)(82310400003)(316002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:14:13.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df31ab85-3b3e-40cd-053f-08d93ba76d9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2526
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/30/2021 10:16 AM, Christoph Hellwig wrote:
> On Wed, Jun 30, 2021 at 10:02:11AM +0300, Leon Romanovsky wrote:
>> Another possible solution is to change __sg_alloc_table()/__sg_alloc_table_from_pages
>> to return total_nents and expect from the users to store it internally and pass
>> it later to the __sg_free_table().
>>
>> Something like that.
> Yes, that sounds pretty reasonable.

OK. So we have two options

1. Add another argument (output) to __sg_alloc_table_from_pages and 
__sg_free_table.
     The thing is that __sg_free_table gets free_fn as argument while 
__sg_alloc_table_from_pages doesn't get alloc function. Users will pass 
NULL as free_fn and scatterlist internally will use sg_kfree.

2. Have dedicated functions to the appending allocations - 
sg_alloc_table_from_pages_append and sg_free_table_append. With this 
approach users that use __sg_alloc_table_from_pages not for appending 
allocation don't need to maintain the new argument.

Christoph, what do you prefer? do you see a better option?

