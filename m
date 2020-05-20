Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF851DB299
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETMCG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 08:02:06 -0400
Received: from mail-eopbgr20063.outbound.protection.outlook.com ([40.107.2.63]:6305
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726548AbgETMCF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 08:02:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp6KhmZBjJRZ1G617q10WtrohSeelPBioRii+PmlmA+JM4vvEjCN0pfNT3npdXEAlwoCpw51+aEm0j3Cg6RUBKlQFuGOuNktDIxfV5Bvjyp5JjhjlleDqcKUMqoTSlI5QCpUE4lBm4c0KIabHf2Fq8cerlIFMZvVSGIcevbwnrwjDG14+9MU1kEqhInaXyuun4/nDDMtqYuYNRwA25hd0DkZFgQxisLaVGCHUNzn3UJ4xzyWNsmTn7WSTsjbV+WnolWA5+scQNfM9d41h3HhtUQI+rvZRO8dV+a5tX1EOrAHKxAAJCpiOuLM3MN5D3X09dfcSMk+KhU/X0AI0nITcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikIxVh2/a2nZ71IgCx5xCzyjCGmZYJBcSibCX/4mNmY=;
 b=CsxiJ7wWoNxh6et5zgXcj6NrxIlWaLFmabB/dDWGSGBG4w2DfMirXaxYrKaApbAb2JgDoHxKOYeIwtTtfORo8pi1Z+qopVbNtahiM+Y7dJURv+yo869vynIComN7Pxl8ENpo3AtQrh6QRqdPSLFOqYLNOhiSAkMa60i9U2XQzUsWEkGwdr4rFwoAB000JnlG7oMlReOerjxf7F/fuCKsE/VOibjDI9XCSt375VVTuooybuQp6hrclV/BciLKWs/QJKQbE11Ha/w66C5tcOOM0GCiNEBgiRqLaUnnI7Wp4W/WOM2rwzJj2KOGfakalhyXtGmH7XMwN9WDg55WV0Kyhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikIxVh2/a2nZ71IgCx5xCzyjCGmZYJBcSibCX/4mNmY=;
 b=f7rXv4ho6Y85ZtA0CL2uKrnBIzlIfXs09e/YY7cAdYCM0O0/HXJI66HbK0meohQQ4Bm3PElgDKUTq8oN4VwJQ+o7PmHCwpNKe2u/AoZHY4YaezyGGMUAQYUfiRZXKym+WZMMhr7kLwZ/7KuS7b8IITdgqZ+LNpq2ICSUsJZNIFM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3945.eurprd05.prod.outlook.com (2603:10a6:8:3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 12:02:00 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:02:00 +0000
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <CANjDDBgPQBOuBNQE=3PqsAtNgSzVbnDDt6wYNrS8iC-gAYzHJQ@mail.gmail.com>
 <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com>
 <CANjDDBhenmz=k21BBhK91LwQ9OjgrdPUZx-Vvu2PvUpj0YvNAw@mail.gmail.com>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <98c26ee4-742c-a6fc-bb1c-5134c3361dfd@mellanox.com>
Date:   Wed, 20 May 2020 15:01:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <CANjDDBhenmz=k21BBhK91LwQ9OjgrdPUZx-Vvu2PvUpj0YvNAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:207:5::14) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM3PR03CA0056.eurprd03.prod.outlook.com (2603:10a6:207:5::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 12:01:58 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c005bf92-2225-4d9b-ce89-08d7fcb59a11
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3945:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB39457F5C04ABD51A60E1D803B1B60@DB3PR0502MB3945.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRkw18Bd8WGKe419tZzgEAxa1RoqzrTu4IS4IypAQ+RKwrEf5NFM81cny6wDYimdtGyvGHpD06nY5NBZnRwAX3yDZEhBL5esq4Ztaab1vYPehZfoXS/gkQWhKrOugIbs8SJdEVMHuc4FvdlsNFRKL0XQZItM2bYp899PadoBY2vi0o3Q/uOTvAulbrqco3j5W9GeZv+24aKMk4eC1hOsNUNu32UTPSNhEuMSvRMRTzljo1fNg88r9N9XdbuujVcwi6OFbrL2jc8DOBHwqjKT/8BVeEhnqUWh8xzRIrSZxCnci1H7KzNo4LakqeYIqFkMY6IUjH8BXm5gTE/Kg+7e3id+v0VG5Cav2PWL+DHL/UJvQhmDs5EXiGWs/GpqsdPc2rIRxlbSGv8TQ3KTaw8PjRDej1obqulQQPCFYHEZMpNXSkPixKxt5vpiB+xrjpPOnTRrOjxCHAK89ZzYJS8sfokq749HLaUhjfZlbNUHRISyJhSEkm89NPsEsbxf/epG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(478600001)(31696002)(6916009)(956004)(86362001)(4326008)(186003)(16576012)(16526019)(8936002)(2616005)(54906003)(36756003)(6486002)(53546011)(316002)(5660300002)(52116002)(66556008)(26005)(31686004)(2906002)(66476007)(66946007)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b3v4HBYxUJdFvyVYlUmt3PP0YzT70VDBTGHKMdbLAUxHNqNMOvqy2IPb/+89/87g1TWA6mgN3LpzQjKmbumNZwxLg7JENYQ58msjNNlxlI+pOZrcwmj5G+CdSURLdxwS3Ya6Vy2MCuJ8VKxNOOVzCZN+iaqFiSqsloWOT6LkepwL5Xfg3zs6cvhgfAgYncpkiTcU6n2X+IbLGwksnqfLPrV2oZHXBKuj8x1kG2G+Nb63s3j6k++yyYKeMPYd4sokLa7xj9SdCVmdUDj70agOUOLAvjJy3H3TZ/CYuNJyAIQcQV01P6s5fga62xn9PlUhTigxR+KBma9odzBl6VJV7wUd2Fq8/qzjF+L9gs7izI4ZwdSDCX1Pj78dZMqHs9BtATnmbK8bTUwuZP3nD732Ycz0USpwtQGOp4z2aQHoZsxmmrpEnWwCBcBCIF6Cnm7MKxy7HINQ17tiLFxSzujtv3y3bOCv4EWvfkzsCCzEEa4=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c005bf92-2225-4d9b-ce89-08d7fcb59a11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:02:00.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1qsJNW3ENkDlkT0nSc664yQRTseAgVya2deNMbkz3p7MYoQ5FXV8ugpKhqSDkRLelEoOfBFJeTbe9pmyzNBjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3945
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/20/2020 1:50 PM, Devesh Sharma wrote:
> On Wed, May 20, 2020 at 2:53 PM Yamin Friedman <yaminf@mellanox.com> wrote:
>>
>> On 5/20/2020 9:19 AM, Devesh Sharma wrote:
>>>> +
>>>> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
>>>> +                       enum ib_poll_context poll_ctx)
>>>> +{
>>>> +       LIST_HEAD(tmp_list);
>>>> +       struct ib_cq *cq;
>>>> +       unsigned long flags;
>>>> +       int nr_cqs, ret, i;
>>>> +
>>>> +       /*
>>>> +        * Allocated at least as many CQEs as requested, and otherwise
>>>> +        * a reasonable batch size so that we can share CQs between
>>>> +        * multiple users instead of allocating a larger number of CQs.
>>>> +        */
>>>> +       nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
>>>> +       nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
>>> No WARN() or return with failure as pointed by Leon and me. Has
>>> anything else changes elsewhere?
>> Hey Devesh,
>>
>> I am not sure what you are referring to, could you please clarify?
>>
> I thought on V2 Leon gave a comment "how this will work if
> dev->num_comp_vectors" is 0.
> there I had suggested to fail the pool creation and issue a
> WARN_ONCE() or something.

I understood his comment to be regarding if the comp_vector itself is 0. 
There should not be any issue with that case.

As far as I am aware there must be a non-zero amount of comp_vectors for 
the ib_dev otherwise we will not be able to get any indication for cqes. 
I don't see any reason to add a special check here.

Thanks

>>>> +       for (i = 0; i < nr_cqs; i++) {
>>>> +               cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>>>> +               if (IS_ERR(cq)) {
>>>> +                       ret = PTR_ERR(cq);
>>>> +                       goto out_free_cqs;
>>>> +               }
>>>> +               cq->shared = true;
>>>> +               list_add_tail(&cq->pool_entry, &tmp_list);
>>>> +       }
>>>> +
>>>> +       spin_lock_irqsave(&dev->cq_pools_lock, flags);
>>>> +       list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
>>>> +       spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>>>> +
>>>> +       return 0;
>>>> +
>>>> +out_free_cqs:
>>>> +       list_for_each_entry(cq, &tmp_list, pool_entry) {
>>>> +               cq->shared = false;
>>>> +               ib_free_cq(cq);
>>>> +       }
>>>> +       return ret;
>>>> +}
>>>> +
>>>>
