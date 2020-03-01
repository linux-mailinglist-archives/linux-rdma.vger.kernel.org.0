Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE93E174D99
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Mar 2020 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgCAOGA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Mar 2020 09:06:00 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:8458
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgCAOGA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 1 Mar 2020 09:06:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obPOdVDdIEwsxK8ptaHWgkfbtMmJ4BW7L6tj/S56I18XlZT9FxBDSesS8YoQwJyQ7wHKUh9fhwKiqgt0aSAWOa4HI7zebClEH5CH65L9EmV0NR38MQZH8tSOtsXe7RfXO/+TlFirJSX9evYN9XVU1D1ya2P/PIOoRkIvJcUTnBDFtXCK0pyi8eDDxKTA2ypCBMGxHQaiaJzRnGSVJCmqzFFECVG5P0Z4uIgjFIYgi+DD/fdcc3x+WWbIvrTfDHoUbq/O0v6C9TbQzXFYXsNMa+weblhZI37DAVNf3QXUNhTOx4h92c65jHZyW59dSf/Y4tFDMW3QyEr4PKI+BYcnCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNUAmFq9qBmZdZDFxv5UJnnZW21vJfcl79Jz41Yu28w=;
 b=lkSWVa/jRKcDAYIBuXOWNkXYhCBHpHBo5S/z4+3UWswFifMDOrUcpU8zK+2OIBJ2P0q0ZhUpwhslddn+v0kJBEVbc3Vvi/5XrrHcyzGqVePnZ0BCNfzTCQB95o7ZikA3RtVcvPR/2mjSw6+9KQwFDhl+pIkxpYiGFLHQO9boC2ZeynOQ2xPxq7BvJRKlpMT6wllLhlLasncWwI5YjJ5cVynXaXtOCDbFXJWFa0CfgW6hE2nXHMKUh5byRFkPwbhLvSuuWv5RRwF56w+qAgLCWtmb5VR/7JwhujP5Tag0f8Z9qXf/597WOLwDGmUzwTElbcT8Gj32y3/ZBAMYymtiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNUAmFq9qBmZdZDFxv5UJnnZW21vJfcl79Jz41Yu28w=;
 b=Eq4s0l1iv/rg2eohyg2wI28IaYw7tXSVzSpeAvYluq00yp9HaGj1ZhCeGzgcP3Py+3DFiXZfL1E7rVHBf6KQQXCs0BecTGp39wJeMEd5EWallkzfzybXYnDR7bXcoSclnHNJotpyLWHLvbkzZOc4pI1L/5Wzb7QWJTYiwxoB2mA=
Received: from AM6PR0502CA0052.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::29) by HE1PR0501MB2491.eurprd05.prod.outlook.com
 (2603:10a6:3:6e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Sun, 1 Mar
 2020 14:05:56 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::205) by AM6PR0502CA0052.outlook.office365.com
 (2603:10a6:20b:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Sun, 1 Mar 2020 14:05:56 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2772.15 via Frontend Transport; Sun, 1 Mar 2020 14:05:55 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 1 Mar 2020 16:05:54
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 1 Mar 2020 16:05:54 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 1 Mar 2020 16:05:53
 +0200
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To:     Sagi Grimberg <sagi@grimberg.me>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>, <jgg@ziepe.ca>
CC:     <linux-nvme@lists.infradead.org>, <hch@lst.de>,
        <linux-rdma@vger.kernel.org>, <nirranjan@chelsio.com>,
        <bharat@chelsio.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
 <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
Date:   Sun, 1 Mar 2020 16:05:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(199004)(189003)(70206006)(186003)(70586007)(16526019)(2906002)(2616005)(336012)(31696002)(36756003)(53546011)(31686004)(316002)(81166006)(8936002)(4326008)(356004)(86362001)(478600001)(36906005)(81156014)(5660300002)(26005)(16576012)(54906003)(8676002)(110136005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2491;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5b155bf-9f67-4e09-e591-08d7bde9a927
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2491:
X-Microsoft-Antispam-PRVS: <HE1PR0501MB2491185A7FFA416B08B3371CB6E60@HE1PR0501MB2491.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0329B15C8A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVsQO6KLXlEWdWOE+rGitbelI69lNwtKPRk8Y+VNA8EAHvNn/l3ktFkw/hP72fPrVE6R1e48XU9ezFkMBxdaXdMwFuJSHWGb5tueTO6UXQ5oIK2qfoHZrLpA0QaOqsvTlrLfG77Gtgq4RyBW4JwQEMLOyB+quR67bKGMXp+tVrE4b7zu/GDZSFzYlO1KK646k6pkYXTpLW2d+EPN0Rf9lPYcDLx99PETdJwxrLcgsnr6TR6ClY7V/QuV4DyQ8UwwCqL5V7Le3n4kX11t43ZWFX4ErZuwSb/a1UYURg2nMbt16kJq8+lxfUopMMsHEZhLDan7tLCJ2cJkwa8dv8T8QS9XlRxSyjUfh9r+RbkaFkzoy5Cz501DQ/7URAhmMriuRYuQ/zl9ue/tHAAf7KFc/2yB5id6GFJuE5LA2YkvDG+Hfnje1Gdb5BfTMoGngrnvC7RZmj6ySO976hyrCRtl5chlxZppLxExac6NjbW6mYGitmvL9KN89oNWPcnu1PVv
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2020 14:05:55.7526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b155bf-9f67-4e09-e591-08d7bde9a927
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2491
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2/28/2020 1:14 AM, Sagi Grimberg wrote:
>
>>> The patch doesn't say if this is an actual bug you are seeing or
>>> theoretical.
>>
>> I've noticed this issue while running the below fio command:
>> fio --rw=randwrite --name=random --norandommap --ioengine=libaio
>> --size=16m --group_reporting --exitall --fsync_on_close=1 --invalidate=1
>> --direct=1 --filename=/dev/nvme2n1 --iodepth=32 --numjobs=16
>> --unit_base=1 --bs=4m --kb_base=1000
>>
>> Note: here NVMe Host is on SIW & Target is on iw_cxgb4 and the
>> max_pages_per_mr supported by SIW and iw_cxgb4 are 255 and 128
>> respectively.
>
> This needs to be documented in the change log.
>
>>>> The proposed patch enables host to advertise the max_fr_pages(via
>>>> nvme_rdma_cm_req) such that target can allocate that many number of
>>>> RW ctxs(if host's max_fr_pages is higher than target's).
>>>
>>> As mentioned by Jason, this s a non-compatible change, if you want to
>>> introduce this you need to go through the standard and update the
>>> cm private_data layout (would mean that the fmt needs to increment as
>>> well to be backward compatible).
>>
>> Sure, will initiate a discussion at NVMe TWG about CM private_data 
>> format.
>> Will update the response soon.
>>>
>>>
>>> As a stop-gap, nvmet needs to limit the controller mdts to how much
>>> it can allocate based on the HCA capabilities
>>> (max_fast_reg_page_list_len).
>
> Sounds good, please look at capping mdts in the mean time.

guys, see my patches from adding MD support.

I'm setting mdts per ctrl there.

we can merge it meantime for this issue.


