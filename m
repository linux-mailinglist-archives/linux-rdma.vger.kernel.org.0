Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B31188E77
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgCQT73 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:59:29 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:44873
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgCQT73 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 15:59:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncQuhXS7S4c+02rOzL3DuCuOuPK4yjAdZL5Hk0idDQcCwbizSYBqafGSdDZDUbkdJZ0ADTka17F9aff+gtuU6hIn6FX54bs8unGek+7kpIXH0SxqXeCKX/kdtVonkaes+6rArJYlhMzwzHp93cLsWihMrrlEcuy71Uu6j+QVfcOCKgmqBAH6qzmCX3KKzpI3G7WaUD2bn93+yCk4OYn6UW1UeSiirvxupEslwCv5KQIijbkgIBt+vfJUt4OE4kgMDk3mVhSiYBDFJe/7RkzeLkTPC4v0zOazezvgnseOB4UNw9icACwWi84SmxqwWDECsOEIpCB0rBvZmym7QDmlYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q9QvrzIEpMi3LthlPKd5LLhStqnw9z/wrq+IgZIWRc=;
 b=TfH7+r2SXJVspKY5ADH2n/wksDl54YkXUXmiMJMhIpRTxMNcee68nyM1LmD6UE8c6bXsYDGh5Kdvs6p4iR/tRWgTxpQdMW/a/kamfWiWqcpl0XEOBUm/gWyw9FfFOdrqvZTypp8+X591BickovqHMZgten0P5gsOkH/VvneL2/BmMo4oD7FDp1xknKW3Jue1IkvsVct9Nj7dxt0q2UkhDsDP1ibElloTb7IFMCsEmlWkPQmhH1qWstyeANvTYEr/eXM41GXKizxhroVEnkzUJ+p0xc8LXNeMa7BoenbaZ14kh8eRUHF79f1ysafvgWJZPVuKdPcn17LZmxUG1pnA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q9QvrzIEpMi3LthlPKd5LLhStqnw9z/wrq+IgZIWRc=;
 b=oXGKeCl5FmumiN2dVeSskB7a+QKUnFxZpdzu+9AGXRmjwxHt9h3sp3SSQ2wW/FXk+73QEXsmRLS9r1WYTk1dUgiONhuZjTWjoHZTNzU36imKpKweh+dpS63PSiMjsZq4igYj2QwnoDy1UT59dSYqzrWJKAsujTlG1j8QY1Of7Bc=
Received: from DB6P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::15) by
 DBBPR05MB6522.eurprd05.prod.outlook.com (2603:10a6:10:c2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Tue, 17 Mar 2020 19:59:24 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::7b) by DB6P195CA0005.outlook.office365.com
 (2603:10a6:4:cb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend
 Transport; Tue, 17 Mar 2020 19:59:24 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 19:59:23 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 17:41:37
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 17:41:37 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Mar 2020 17:41:15
 +0200
Subject: Re: [PATCH 4/5] IB/core: cache the CQ completion vector
To:     Chuck Lever <chucklever@gmail.com>
CC:     <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <leonro@mellanox.com>, <jgg@mellanox.com>, <dledford@redhat.com>,
        <idanb@mellanox.com>, <shlomin@mellanox.com>,
        "Oren Duer" <oren@mellanox.com>, <vladimirk@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-5-maxg@mellanox.com>
 <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <078fd456-b1bc-a103-070b-d1a8ea6bff9c@mellanox.com>
Date:   Tue, 17 Mar 2020 17:41:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <448195E1-CE26-4658-8106-91BAFF115853@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(199004)(46966005)(53546011)(54906003)(356004)(86362001)(31696002)(5660300002)(16576012)(316002)(36756003)(107886003)(70206006)(478600001)(70586007)(4326008)(31686004)(8936002)(186003)(26005)(81156014)(81166006)(2906002)(16526019)(336012)(47076004)(2616005)(6916009)(8676002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6522;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baab8418-2da0-451f-0b99-08d7caadb0c2
X-MS-TrafficTypeDiagnostic: DBBPR05MB6522:
X-Microsoft-Antispam-PRVS: <DBBPR05MB6522493ADDB157F8A48273D0B6F60@DBBPR05MB6522.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWm2caGkWR29bKNbOoTW9xh+jeKCMll8sek8pgmhJ4KE4v20HA3a754b0aXUUGSeLYY+RpWOhiaypf6hbGilivL4+ONCD0Te4nuY+peVhndTC2EVM/6CPaOrMPYutAskkWJvDMBN33vIe6hwoH5QQfR1fRdr0CFKTAhKhlV3dz7JImuaXFhUg3RTS9HAHcL/ou3H+Thl450BcBx+C8uGfogbCCRn8k5VectSn1HpUNTz2VNNESHO0iEwV0SEqp2XOTRNsafiagYb6YgR7qBIm21H00FHmB8Dv+Lvgp8gs4Ex2ztnFI8IDRWrwFbvisSrdg0sZiu/3NP6yurX2Vz96AFdoLUfGsY2n+bmdG0uM6cSO8t4tSH3u4vitlLDrms1YYtPy/epnfwrVbpGq3G69vGkl2g3SQOO+v68pEIJLcnyMjeaBpFr0GxfYISmjfrlLM6yq3Vge9pq2nDlSXUcXSjKDUoghgTUku1yvQ96Lqr/17gZ0RXVCFBWhgVpKjLM59IEDvkqwfJtnuadjyN3u1IiWLrLf5guVQFkMpil8BQ=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:59:23.7932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baab8418-2da0-451f-0b99-08d7caadb0c2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6522
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/17/2020 5:19 PM, Chuck Lever wrote:
> Hi Max-
>
>> On Mar 17, 2020, at 9:40 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>
>> In some cases, e.g. when using ib_alloc_cq_any, one would like to know
>> the completion vector that eventually assigned to the CQ. Cache this
>> value during CQ creation.
> I'm confused by the mention of the ib_alloc_cq_any() API here.

Can't the user use ib_alloc_cq_any() and still want to know what is the 
final comp vector for his needs ?

>
> Is your design somehow dependent on the way the current ib_alloc_cq_any()
> selects comp_vectors? The contract for _any() is that it is an API for
> callers that simply do not care about what comp_vector is chosen. There's
> no guarantee that the _any() comp_vector allocator will continue to use
> round-robin in the future, for instance.

it's fine. I just want to make sure that I'll spread the SRQ's equally.

>
> If you want to guarantee that there is an SRQ for each comp_vector and a
> comp_vector for each SRQ, stick with a CQ allocation API that enables
> explicit selection of the comp_vector value, and cache that value in the
> caller, not in the core data structures.

I'm Ok with that as well. This is exactly what we do in the nvmf/rdma 
but I wanted to stick also with the SRP target approach.

Bart,

Any objection to remove the call for ib_alloc_cq_any() from ib_srpt and 
use ib_alloc_cq() ?


>
>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>> drivers/infiniband/core/cq.c | 1 +
>> include/rdma/ib_verbs.h      | 1 +
>> 2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
>> index 4f25b24..a7cbf52 100644
>> --- a/drivers/infiniband/core/cq.c
>> +++ b/drivers/infiniband/core/cq.c
>> @@ -217,6 +217,7 @@ struct ib_cq *__ib_alloc_cq_user(struct ib_device *dev, void *private,
>> 	cq->device = dev;
>> 	cq->cq_context = private;
>> 	cq->poll_ctx = poll_ctx;
>> +	cq->comp_vector = comp_vector;
>> 	atomic_set(&cq->usecnt, 0);
>>
>> 	cq->wc = kmalloc_array(IB_POLL_BATCH, sizeof(*cq->wc), GFP_KERNEL);
>> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
>> index fc8207d..0d61772 100644
>> --- a/include/rdma/ib_verbs.h
>> +++ b/include/rdma/ib_verbs.h
>> @@ -1558,6 +1558,7 @@ struct ib_cq {
>> 	struct ib_device       *device;
>> 	struct ib_ucq_object   *uobject;
>> 	ib_comp_handler   	comp_handler;
>> +	u32			comp_vector;
>> 	void                  (*event_handler)(struct ib_event *, void *);
>> 	void                   *cq_context;
>> 	int               	cqe;
>> -- 
>> 1.8.3.1
>>
> --
> Chuck Lever
> chucklever@gmail.com
>
>
>
