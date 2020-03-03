Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172B8178623
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 00:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCXLs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Mar 2020 18:11:48 -0500
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:36292
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbgCCXLr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Mar 2020 18:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR8DsD2soKcPJHWIpnYmQ15iWCVZtwr2Qv6eBE2+oNf7hJO/NQp6+0Ah5kjBnK7JY+AN2OanEe41tIafDZnIsCGThee1S4jRarhl2lyWrV0RTC9J4zuRVilCQ3ANes7/Ns5wWKc29HzT2q+YOwxlaL+b18EqlTqGliXlXp1MpmzOWCEHUlrTolWtwkP1Xeq12zV2Kxe/jCB57FSLePms1+28qM78UGpQ+gvNnQ7maROvsHazvQRahSLG0PssAIRjzbjBOl2cXZOQWPMS+yhULWS5ak9Dan9URec4gBogAP832IlRPNu2wwH56Yzyd5VD2jPHaQ5APb2r6imOgHImvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwPFvhWipusmiKmzIw+qeIjdg5ywJ+394BZ4ZJw4pGY=;
 b=eHfM0G0SvmfhDwfKduFTnqFFtGBK9FcDJO6AnKjo6FeFofk6JsRVvJlIS/9pZzZJKsRq02Zev+BDbMB216wNjRRh5av5UV4sjUUqtbgD0U/0K1sD+dpiBAW82LtDbcCsOl6JhtgARUZsxLdHkly5vCXUiJlUkUffcMpP6yrmtX8Z6FkQ8sumxYg50sqygRG6N0fkaOgi3XEYRWbiT+sOtQta2vljADqzSU5bBcMbqgxHyanm4eeN9kknuN8jQoaz4veZCQfOtLrb3BeGCYN8sJ2ynUCKaXxqSwaHvph7Zhr+EmGrhfMFv/50+vXElan/oDXkahMCyaNKK4Kx2xdBsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=chelsio.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwPFvhWipusmiKmzIw+qeIjdg5ywJ+394BZ4ZJw4pGY=;
 b=hU1fb7xWPhzJFepIkEB3BETGwJ9MYo6ZcFvd8G+ooh23nHxq5K8Abao0dggCWnmLock1eqc2fuk0PVoUtH35vICi7DXKNcCd7w8rI++w8AydGYYJT/AryGZlE/GEOFWbSOjdLbWzMKjd7XyNJbTgkyPAtGFrmeg7CXcmRgSABwY=
Received: from AM6PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:20b:2e::33)
 by DB7PR05MB4890.eurprd05.prod.outlook.com (2603:10a6:10:24::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 23:11:42 +0000
Received: from VE1EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::207) by AM6PR05CA0020.outlook.office365.com
 (2603:10a6:20b:2e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Tue, 3 Mar 2020 23:11:42 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT060.mail.protection.outlook.com (10.152.19.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:11:41 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Mar 2020 01:11:40
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Mar 2020 01:11:40 +0200
Received: from [172.27.0.12] (172.27.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Mar 2020 01:11:39
 +0200
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To:     Sagi Grimberg <sagi@grimberg.me>,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
CC:     <jgg@ziepe.ca>, <linux-nvme@lists.infradead.org>, <hch@lst.de>,
        <linux-rdma@vger.kernel.org>, <nirranjan@chelsio.com>,
        <bharat@chelsio.com>
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
 <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
 <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
 <20200302073240.GA14097@chelsio.com>
 <c8e3f76b-a255-ba03-dcb5-32d8042fc8a0@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ba0bb0df-ea36-2035-3364-647c3f5775be@mellanox.com>
Date:   Wed, 4 Mar 2020 01:11:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c8e3f76b-a255-ba03-dcb5-32d8042fc8a0@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(2906002)(6666004)(316002)(81166006)(8676002)(81156014)(31696002)(356004)(31686004)(53546011)(8936002)(16576012)(36756003)(110136005)(54906003)(5660300002)(4744005)(70586007)(186003)(86362001)(16526019)(26005)(478600001)(70206006)(4326008)(2616005)(336012)(36906005)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4890;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abc95d2-fd3e-4353-9e78-08d7bfc83c29
X-MS-TrafficTypeDiagnostic: DB7PR05MB4890:
X-Microsoft-Antispam-PRVS: <DB7PR05MB4890E258E95521AAB5EE6983B6E40@DB7PR05MB4890.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hqypvxTqA2FF2rMnfvdX+S2yXOrYTexct37L4bvHK0BMr0eU1Z1Lf7i7Q03GCQIf+1UVeMzIGqILiF3oxsw260RXihGRyy+/nsk/I1Z3kgaGOhuGD8mFj5n1CqPAbd48pqs07ddQgOn09jAW8EPUYmAq7e6KFrqoVCw4WJ/b9n7bt/FEJOh5bJqsAD379Yo2LUHRqVSRt107mCcVBgnObToukglZ5HT5t/VvjB88QT0z5gCqVxQQA3u4R/pw1NwxRx84P32xO09sGF7vgeiukek3mEMXQ+HKu+xFEmx5lBg0H4obp7TPOU6zIX/JxSlIHVzeVPwHAT4n/toKyQ/EOV1AYpRdNsHPK3OvFkECP5lG6u3HpWPB+0anAl9BiJ0e1rav1QT+XPjskmibssPfOrUtXnHlAclcnQGrespiHsNmMbkADvTPfSGegSaZLBPPSJ1O3bZVndESviv0Iqkw9dS4iSdwh8pK+xaP1SW6T6Vb9R0mSdbZQfP8MWfMozq
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:11:41.8127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abc95d2-fd3e-4353-9e78-08d7bfc83c29
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4890
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/2/2020 7:43 PM, Sagi Grimberg wrote:
>
>> Hi Sagi & Max Gurtovoy,
>>
>> Thanks for your pointers regarding mdts.
>>
>> Looks like fixing this issue through mdts is more natural than fixing
>> through RDMA private data.
>>
>> Issue is not occuring after appling the below patch(inspired by Max's
>> patch "nvmet-rdma: Implement set_mdts controller op").
>>
>> So any consensus about merging the fix upstream, to fix this specific
>> issue?
>
> I think we can do this asap.
>
> Max, please send a patch for this.


sure, I'll do that.

But since nvmet/rdma uses RW API that may use multiple MR's per IO 
request we need to implement the set_mdts differently.

We need to update the value of max_rdma_ctxs that set the MR pool size. 
We can limit the RDMA transport to support upto 1 or 2 MB and get the 
factor we need for setting the max_rdma_ctxs.

I'll send a fix soon.


>
> Thanks,
