Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00036861
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 01:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEXzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 19:55:04 -0400
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:56038
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfFEXzE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 19:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jsp/4oE6QMZp1naGGCF4d2SWYPq0oTLiaHs+xrEC+k0=;
 b=XzjuyVuzOgk/32YkMI+SkpIWXxvF7zvZ73D82YCzkVvuYiOb4ZAUPNGiQvQpr7x/w9JNbBaldqHBI/5zYUsMTnyBnK4Ab1KpeqZSqZJeg2hM3dwd9ly7MhC3vXndLBrzdiqrMe1both8t/uehJrtywIf6rP7KTw1d522vrsc9KY=
Received: from AM0PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:208:55::30)
 by VI1PR0502MB3023.eurprd05.prod.outlook.com (2603:10a6:800:b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Wed, 5 Jun
 2019 23:54:57 +0000
Received: from VE1EUR03FT031.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by AM0PR05CA0017.outlook.office365.com
 (2603:10a6:208:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.14 via Frontend
 Transport; Wed, 5 Jun 2019 23:54:57 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT031.mail.protection.outlook.com (10.152.18.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 23:54:56 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 02:54:56
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 02:54:56 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 02:54:10
 +0300
Subject: Re: [PATCH 19/20] RDMA/mlx5: Use PA mapping for PI handover
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-20-git-send-email-maxg@mellanox.com>
 <ad2fde22-0701-e244-aad7-0b51ec3f2cf8@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <01bbcf0c-9fba-9256-939b-addd26f715d8@mellanox.com>
Date:   Thu, 6 Jun 2019 02:54:09 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ad2fde22-0701-e244-aad7-0b51ec3f2cf8@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(376002)(39860400002)(2980300002)(199004)(189003)(336012)(4326008)(107886003)(5660300002)(36756003)(8936002)(19627235002)(486006)(356004)(77096007)(2616005)(446003)(2201001)(7736002)(86362001)(6246003)(14444005)(50466002)(6116002)(64126003)(3846002)(8676002)(81156014)(54906003)(305945005)(31696002)(58126008)(110136005)(23676004)(31686004)(70586007)(76176011)(53546011)(106002)(11346002)(126002)(229853002)(65806001)(47776003)(65956001)(476003)(70206006)(26005)(316002)(478600001)(67846002)(186003)(2906002)(16526019)(2870700001)(81166006)(65826007)(2486003)(16576012)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3023;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73af8051-9400-4b9a-84da-08d6ea1136a2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3023;
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3023:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB30238BAF7ABEF4BA84B4C70DB6160@VI1PR0502MB3023.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GW48rqBgQI6XM5M8nqlpM8EpV3oUn66i8WnL4a0mVH0BWd9Ayn6StChYrBEr5ECm4vfY0iXxswFextgXUOwO9HDOWGh77lDx2+4MW3YDM+JD/SLa+VI9ARsNHsIAVLKlCrK3YepkjpEWlIfZKWIGPNvFVHvBU1C/d6u3gMwG3RokKoNRtCxdohIf2MjmqZzRm8JwkhnyrMxcrw6qMn8SI29bQBe8GRA6VfcyJNgMH4s/SjB7TH8Ng+uQVAb91EEBo/BdDR9JDbGwfAn3dUqWFK34lIzEOzxJjzK0qAvVg38ESzgsYENzEzjF84eei4wdHvpjG6uv++6AmRMmzZVRhGHbZXANX71alC2wd7a1RktA8Vr4Ccfl4durLo8YM2FUtAsixzWUUrHgG5FTFxURkhDwpCuiJ0kzm1XxEW9ru88=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 23:54:56.8504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73af8051-9400-4b9a-84da-08d6ea1136a2
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3023
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/6/2019 1:59 AM, Sagi Grimberg wrote:
>
>
> On 5/30/19 6:25 AM, Max Gurtovoy wrote:
>> If possibe, avoid doing a UMR operation to register data and protection
>> buffers (via MTT/KLM mkeys). Instead, use the local DMA key and map the
>> SG lists using PA access. This is safe, since the internal key for data
>> and protection never exposed to the remote server (only signature key
>> might be exposed). If PA mappings are not possible, perform mapping
>> using MTT/KLM descriptors.
>>
>> The setup of the tested benchmark (using iSER ULP):
>>   - 2 servers with 24 cores (1 initiator and 1 target)
>>   - ConnectX-4/ConnectX-5 adapters
>>   - 24 target sessions with 1 LUN each
>>   - ramdisk backstore
>>   - PI active
>>
>> Performance results running fio (24 jobs, 128 iodepth) using
>> write_generate=1 and read_verify=1 (w/w.o patch):
>>
>> bs      IOPS(read)        IOPS(write)
>> ----    ----------        ----------
>> 512   1266.4K/1262.4K    1720.1K/1732.1K
>> 4k    793139/570902      1129.6K/773982
>> 32k   72660/72086        97229/96164
>>
>> Using write_generate=0 and read_verify=0 (w/w.o patch):
>> bs      IOPS(read)        IOPS(write)
>> ----    ----------        ----------
>> 512   1590.2K/1600.1K    1828.2K/1830.3K
>> 4k    1078.1K/937272     1142.1K/815304
>> 32k   77012/77369        98125/97435
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>>   drivers/infiniband/hw/mlx5/mr.c      | 63 ++++++++++++++++++++++++++--
>>   drivers/infiniband/hw/mlx5/qp.c      | 80 
>> ++++++++++++++++++++++++------------
>>   3 files changed, 114 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h 
>> b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> index 6039a1fc80a1..97c8534c5802 100644
>> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
>> @@ -609,6 +609,7 @@ struct mlx5_ib_mr {
>>       struct mlx5_ib_mr      *pi_mr;
>>       struct mlx5_ib_mr      *klm_mr;
>>       struct mlx5_ib_mr      *mtt_mr;
>> +    u64            data_iova;
>>       u64            pi_iova;
>>         atomic_t        num_leaf_free;
>> diff --git a/drivers/infiniband/hw/mlx5/mr.c 
>> b/drivers/infiniband/hw/mlx5/mr.c
>> index 74cec8af158a..9025b477d065 100644
>> --- a/drivers/infiniband/hw/mlx5/mr.c
>> +++ b/drivers/infiniband/hw/mlx5/mr.c
>> @@ -2001,6 +2001,40 @@ int mlx5_ib_check_mr_status(struct ib_mr 
>> *ibmr, u32 check_mask,
>>       return ret;
>>   }
>>   +static int
>> +mlx5_ib_map_pa_mr_sg_pi(struct ib_mr *ibmr, struct scatterlist 
>> *data_sg,
>> +            int data_sg_nents, unsigned int *data_sg_offset,
>> +            struct scatterlist *meta_sg, int meta_sg_nents,
>> +            unsigned int *meta_sg_offset)
>> +{
>> +    struct mlx5_ib_mr *mr = to_mmr(ibmr);
>> +    unsigned int sg_offset = 0;
>> +    int n = 0;
>> +
>> +    mr->meta_length = 0;
>> +    if (data_sg_nents == 1) {
>> +        n++;
>> +        mr->ndescs = 1;
>> +        if (data_sg_offset)
>> +            sg_offset = *data_sg_offset;
>> +        mr->data_length = sg_dma_len(data_sg) - sg_offset;
>> +        mr->data_iova = sg_dma_address(data_sg) + sg_offset;
>> +        if (meta_sg_nents == 1) {
>> +            n++;
>> +            mr->meta_ndescs = 1;
>> +            if (meta_sg_offset)
>> +                sg_offset = *meta_sg_offset;
>> +            else
>> +                sg_offset = 0;
>> +            mr->meta_length = sg_dma_len(meta_sg) - sg_offset;
>> +            mr->pi_iova = sg_dma_address(meta_sg) + sg_offset;
>> +        }
>> +        ibmr->length = mr->data_length + mr->meta_length;
>
> If I'm reading this correctly, this is assuming that if data_sg_nents is
> 1 then meta_sg_nents is either 1 or 0.
>
> Is that really always the case?
No. I've the a counter for returning the num of mapped elements.
>
> What if my I/O was merged and my data pages happen to coalesce (because
> they are contiguous) but my meta buffers did not?

fallback to mtt.

We use PA mapping iff data_nents == 1 and meta_nents == 1/0

