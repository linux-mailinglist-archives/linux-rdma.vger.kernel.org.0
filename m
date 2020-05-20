Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F821DAEA6
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgETJXJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 May 2020 05:23:09 -0400
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:6187
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgETJXI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 May 2020 05:23:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ538mYGUXcaCSUPygM6MUW7Y9aLjx/NVN1S1VeUW7Bhqu/M1auUy+HCgC2nphJvTOMhIr4XLa0aN5Ap3AajlkfBqwY9LJqPxftFH6a/F1qTzduTfuBf43nqyq4W9pUewraHkBiIg1mrD5UXBaE1dWO1I7XfdiWtH1+ZEorMavhlgtUqvUQsZCDJKN8ULCzuheukCoZao0G9VEZR3i4qrQfyYi/4Khf/aFuS/vRL4TeM36kZoZj2d0Lf2k1/GUxt9OE1J7PovvvHCLDFOuN8PHD8EHH5KvJQ9UnLCyX/86Zykw3CmFzc3pdjHC+Zuuo+eH07BHvOofdCn7zsDcSxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YB9MNSv84VHxIpVuUuEjLpJ+WikXBJQ44Fmtc/iiGU=;
 b=OnXlzg6g5KnwWI/cwRTLxLmnZIZa2NtWf4v6pdoX9T3brehhz1/Bb5Rx7DpWaIzuTwDesinHg1HyJ1iefHc0q8XiMGYXu4+GJiXnUocv3e/3j2FY8wC5qOO5sec10TXvwzo+ipc4ir8XNtjjQ1G9Bn9b6TNg7OUQqRtJkcibkx5P2tLxv03DMC6F5AIIpmP+8XUZ/jE1x83I3lGNp51nEce0pCX39FXI0i+KDZHEHqBCNFxvuHwj2vOhuvqBXXQ1wuvMPeR1csknrjpjxpR9ujhuvkPu+JWJQG1oKLUziAOg0ughnyxu5TxoUBKbP0TaOXxVSbkudm6WSz4bxBEFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YB9MNSv84VHxIpVuUuEjLpJ+WikXBJQ44Fmtc/iiGU=;
 b=h7TS9IbQE21ZsOSSR9K10HSRLx7kLuq3BBQZXVo8IStV/WR+PcJhHQmDNsfbyLhM6vXMLyTjUaCOv2/Fjoyv0/6OCg/DMph18hqel/qZAbCJ6WEsQM1zCAvRU3Ipy0u4gtURYaTIp58YnYhFOXxBUOuKzA6mcOb3OZyW6jcnpOE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3977.eurprd05.prod.outlook.com (2603:10a6:8:d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Wed, 20 May
 2020 09:23:05 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 09:23:05 +0000
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
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <1e4eeb19-17a2-d281-24f1-fd79d34c7df2@mellanox.com>
Date:   Wed, 20 May 2020 12:23:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <CANjDDBgPQBOuBNQE=3PqsAtNgSzVbnDDt6wYNrS8iC-gAYzHJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0126.eurprd05.prod.outlook.com
 (2603:10a6:207:2::28) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM3PR05CA0126.eurprd05.prod.outlook.com (2603:10a6:207:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Wed, 20 May 2020 09:23:04 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 501031d8-50f1-45e4-d115-08d7fc9f66f0
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB3977BCAFB6971E27F1109024B1B60@DB3PR0502MB3977.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRrXKtB/ZnYS9x5j7rF5+9fepKUnUUG4Od81EfFay/yKHV/LcgODPKRwqoW+pCk+5qB9VMvC/q+kbuYGU3gyls9LpPzRDbmnkXPEiKzWFAvGSzTUDr0oC5bo5iNOWGJwVC65JOTTemEbpxFP5rfoRnietdF7nDuTjC7qSijRvUF+MdJd9oDlHbBOENLzAoxc9FboT2MoHZxJ2fZdtuzZXoxr6SHL/Xa/yKUC6YkOEXfomVOOSVnrLUQIr6XDlOPICsk5eBzxFMoyKbEsjdNrsiWn0H3WEZLZIWzGn683WGEVgjxXrnPvmoJA379962CIWgaOGmLud2YVn8atyQUTbW8LZFlN0l8Nx4XcaTfBkAzJvpM5pPUSqe/IrIn0Z/+l1YQ/Rg7WRYj64l/c5lwZy7d7QdJiR/MXh/IAQHgZVOatFVCNn9wbRiJThbh1D092EcAd4q8NVSdeoMIGthcznbHDryRCk0gGLmZrG6Y57G1AXbgXubBdxON7mwzbnRPG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(8676002)(6486002)(6666004)(53546011)(5660300002)(2616005)(31696002)(86362001)(54906003)(6916009)(8936002)(31686004)(16526019)(4326008)(478600001)(2906002)(66476007)(66946007)(66556008)(16576012)(186003)(36756003)(316002)(26005)(52116002)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GCjgC+zIm0vlS1wadhZ7bHehQ18kQwp/s3z9RUjiNU/Nf3mfetLufivlPo5aEJKjrpFX8dojSMUZGGgQDaI8nIlHrvobf3HW2l8abTa0CB0h1FiOT3lrWpruA9KHD48NknOOIBGGDEt3T989oeL8JrVYeUR0zpLTjD2jh8S1ob9ZqKwbqgM9bYw3sX9FkXWMPcayd41xYbC/9AwpoNGqy8HpN8CEMDSnZK6RP1VLgSenb2QnR51srN2/G4eAkMtqdGcGkDMJFOJZVEcKt8WBY8P6KcCl/4wWOF5fvCWuHYARS2/L0rAemEQyZlHm36egId1+AxJPtTJ6ZjVLz8OUIl8Gb+jLkWkLU7yB4xdTnfiKpBOpHdMcLxutdkHG5fgZllOqwOhSdxnacgfowXv2orim5UOCs5vLTqLHJu2eFNS7QM5Inip4DBy0bJUS5uxk6sdWDA/xjMLbsF96AsxAGO85J5uzWqaCUn58k2DQpYk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501031d8-50f1-45e4-d115-08d7fc9f66f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 09:23:05.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87SRIzhmi0Et2NCfSCbCU28Tx9ShHZrsZL3CHQGPVO1O+FCaDdUkYLVc0LU70NhQX51j+aMtnD5sOhg/VOjyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3977
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/20/2020 9:19 AM, Devesh Sharma wrote:
>
>> +
>> +static int ib_alloc_cqs(struct ib_device *dev, int nr_cqes,
>> +                       enum ib_poll_context poll_ctx)
>> +{
>> +       LIST_HEAD(tmp_list);
>> +       struct ib_cq *cq;
>> +       unsigned long flags;
>> +       int nr_cqs, ret, i;
>> +
>> +       /*
>> +        * Allocated at least as many CQEs as requested, and otherwise
>> +        * a reasonable batch size so that we can share CQs between
>> +        * multiple users instead of allocating a larger number of CQs.
>> +        */
>> +       nr_cqes = min(dev->attrs.max_cqe, max(nr_cqes, IB_MAX_SHARED_CQ_SZ));
>> +       nr_cqs = min_t(int, dev->num_comp_vectors, num_online_cpus());
> No WARN() or return with failure as pointed by Leon and me. Has
> anything else changes elsewhere?

Hey Devesh,

I am not sure what you are referring to, could you please clarify?

>
>> +       for (i = 0; i < nr_cqs; i++) {
>> +               cq = ib_alloc_cq(dev, NULL, nr_cqes, i, poll_ctx);
>> +               if (IS_ERR(cq)) {
>> +                       ret = PTR_ERR(cq);
>> +                       goto out_free_cqs;
>> +               }
>> +               cq->shared = true;
>> +               list_add_tail(&cq->pool_entry, &tmp_list);
>> +       }
>> +
>> +       spin_lock_irqsave(&dev->cq_pools_lock, flags);
>> +       list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
>> +       spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> +
>> +       return 0;
>> +
>> +out_free_cqs:
>> +       list_for_each_entry(cq, &tmp_list, pool_entry) {
>> +               cq->shared = false;
>> +               ib_free_cq(cq);
>> +       }
>> +       return ret;
>> +}
>> +
>>
