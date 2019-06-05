Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C66813671F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 23:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEV7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 17:59:21 -0400
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:8859
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFEV7V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jun 2019 17:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ/v1jYTyDU7HG8v5GXd4VRwRoQ2KoqD75eTyIqxupI=;
 b=F5gYSJM9ZFA0YylGlp/gq2DwKLd7TyQ002+I3iB5a6qtepACGImI8mAuckqB9UbaVXixOmv0RBH8JB8AZoImce0Bl7qifj/Q8VcLpx8OaiD1bH8KqMfCVdFltv/t/SQnFlaxk4n2Zv2U6vxX5Bhzg60/f8fweWUZwcsldUW/+zw=
Received: from VI1PR0501CA0003.eurprd05.prod.outlook.com
 (2603:10a6:800:92::13) by VI1PR0502MB4064.eurprd05.prod.outlook.com
 (2603:10a6:803:25::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.22; Wed, 5 Jun
 2019 21:59:14 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR0501CA0003.outlook.office365.com
 (2603:10a6:800:92::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1943.18 via Frontend
 Transport; Wed, 5 Jun 2019 21:59:14 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1965.12 via Frontend Transport; Wed, 5 Jun 2019 21:59:13 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 6 Jun 2019 00:59:12
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 6 Jun 2019 00:59:12 +0300
Received: from [172.16.0.12] (172.16.0.12) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Thu, 6 Jun 2019 00:58:35
 +0300
Subject: Re: [PATCH 10/20] RDMA/mlx5: Introduce and implement new
 IB_WR_REG_MR_INTEGRITY work request
To:     Sagi Grimberg <sagi@grimberg.me>, <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <jgg@mellanox.com>,
        <dledford@redhat.com>, <hch@lst.de>, <bvanassche@acm.org>
CC:     <israelr@mellanox.com>, <idanb@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <shlomin@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-11-git-send-email-maxg@mellanox.com>
 <e058cb80-7000-781d-8455-581ee5dee1b5@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <d4d4338e-f655-930b-b201-cd5f80c47bc2@mellanox.com>
Date:   Thu, 6 Jun 2019 00:58:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e058cb80-7000-781d-8455-581ee5dee1b5@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.12]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39850400004)(2980300002)(199004)(189003)(8936002)(81166006)(53546011)(14444005)(106002)(4326008)(76176011)(316002)(305945005)(107886003)(23676004)(58126008)(77096007)(16526019)(6246003)(7736002)(70586007)(65806001)(54906003)(110136005)(67846002)(70206006)(65956001)(47776003)(356004)(36756003)(5660300002)(31696002)(476003)(31686004)(2870700001)(16576012)(2906002)(186003)(2486003)(64126003)(65826007)(446003)(3846002)(6116002)(2201001)(86362001)(478600001)(81156014)(2616005)(486006)(50466002)(8676002)(229853002)(336012)(126002)(11346002)(26005)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB4064;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a975ee1-049f-491b-c7cb-08d6ea010c2e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709080)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB4064;
X-MS-TrafficTypeDiagnostic: VI1PR0502MB4064:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB40641F2FCD94DECA59C3CA75B6160@VI1PR0502MB4064.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 00594E8DBA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qDTSHNQ4BfaEWkwcLNgQu2HpvD+nsdK2j3j4YUhVzuO8hLcV3iBF/fowHSjqXBNcft6QrxMb9fyGovX+07QGQ2vltryOv8jwAS5JsnU7ZOlifBSQJzL00pys2Qz4gOXFwf9cm53Ynrj5mTGKZngLzz1GEeodlUBF4bs5oMapSQj8cpDrJEfnipn8DqYYSYJnIRLdkhGIBQjc1JsSFlTKj6FYFufBRvYQ3pPrw5f5lylOPG3Urg+wyBkZVLdzAHwq21QAZ92atC7M2mN3g9MShL6pH9AGl/12RhGAJoZS7MY/rWH3pnyFIPqmI4RqOn4VaHb2yjbqqcu8nblR1phYEHFD2dAcl27rGLTZSz3BkmEgtWOoFUKif+9v5cvyi9WtsHWA7wwFIj4sl8mmMJL4De70ezYAPZbx7kpc3nigGZ0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2019 21:59:13.6360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a975ee1-049f-491b-c7cb-08d6ea010c2e
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4064
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/5/2019 10:31 PM, Sagi Grimberg wrote:
>
>
> On 5/30/19 6:25 AM, Max Gurtovoy wrote:
>> This new WR will be used to perform PI (protection information) handover
>> using the new API. Using the new API, the user will post a single WR 
>> that
>> will internally perform all the needed actions to complete PI operation.
>> This new WR will use a memory region that was allocated as
>> IB_MR_TYPE_INTEGRITY and was mapped using ib_map_mr_sg_pi to perform the
>> registration. In the old API, in order to perform a signature handover
>> operation, each ULP should perform the following:
>> 1. Map and register the data buffers.
>> 2. Map and register the protection buffers.
>> 3. Post a special reg WR to configure the signature handover operation
>>     layout.
>> 4. Invalidate the signature memory key.
>> 5. Invalidate protection buffers memory key.
>> 6. Invalidate data buffers memory key.
>>
>> In the new API, the mapping of both data and protection buffers is
>> performed using a single call to ib_map_mr_sg_pi function. Also the
>> registration of the buffers and the configuration of the signature
>> operation layout is done by a single new work request called
>> IB_WR_REG_MR_INTEGRITY.
>> This patch implements this operation for mlx5 devices that are 
>> capable to
>> offload data integrity generation/validation while performing the actual
>> buffer transfer.
>> This patch will not remove the old signature API that is used by the 
>> iSER
>> initiator and target drivers. This will be done in the future.
>>
>> In the internal implementation, for each IB_WR_REG_MR_INTEGRITY work
>> request, we are using a single UMR operation to register both data and
>> protection buffers using KLM's.
>> Afterwards, another UMR operation will describe the strided block 
>> format.
>> These will be followed by 2 SET_PSV operations to set the memory/wire
>> domains initial signature parameters passed by the user.
>> In the end of the whole transaction, only the signature memory key
>> (the one that exposed for the RDMA operation) will be invalidated.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/infiniband/hw/mlx5/qp.c | 218 
>> ++++++++++++++++++++++++++++++++++++----
>>   include/linux/mlx5/qp.h         |   3 +-
>>   include/rdma/ib_verbs.h         |   1 +
>>   3 files changed, 201 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/qp.c 
>> b/drivers/infiniband/hw/mlx5/qp.c
>> index 65d82e40871c..7c9fd335d43d 100644
>> --- a/drivers/infiniband/hw/mlx5/qp.c
>> +++ b/drivers/infiniband/hw/mlx5/qp.c
>> @@ -4172,7 +4172,7 @@ static __be64 sig_mkey_mask(void)
>>   static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
>>                   struct mlx5_ib_mr *mr, u8 flags)
>>   {
>> -    int size = mr->ndescs * mr->desc_size;
>> +    int size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;
>>         memset(umr, 0, sizeof(*umr));
>>   @@ -4303,7 +4303,7 @@ static void set_reg_mkey_seg(struct 
>> mlx5_mkey_seg *seg,
>>                    struct mlx5_ib_mr *mr,
>>                    u32 key, int access)
>>   {
>> -    int ndescs = ALIGN(mr->ndescs, 8) >> 1;
>> +    int ndescs = ALIGN(mr->ndescs + mr->meta_ndescs, 8) >> 1;
>>         memset(seg, 0, sizeof(*seg));
>>   @@ -4354,7 +4354,7 @@ static void set_reg_data_seg(struct 
>> mlx5_wqe_data_seg *dseg,
>>                    struct mlx5_ib_mr *mr,
>>                    struct mlx5_ib_pd *pd)
>>   {
>> -    int bcount = mr->desc_size * mr->ndescs;
>> +    int bcount = mr->desc_size * (mr->ndescs + mr->meta_ndescs);
>>         dseg->addr = cpu_to_be64(mr->desc_map);
>>       dseg->byte_count = cpu_to_be32(ALIGN(bcount, 64));
>> @@ -4547,23 +4547,52 @@ static int mlx5_set_bsf(struct ib_mr *sig_mr,
>>       return 0;
>>   }
>>   -static int set_sig_data_segment(const struct ib_sig_handover_wr *wr,
>> -                struct mlx5_ib_qp *qp, void **seg,
>> -                int *size, void **cur_edge)
>> +static int set_sig_data_segment(const struct ib_send_wr *send_wr,
>> +                struct ib_mr *sig_mr,
>> +                struct ib_sig_attrs *sig_attrs,
>> +                struct mlx5_ib_qp *qp, void **seg, int *size,
>> +                void **cur_edge)
>>   {
>> -    struct ib_sig_attrs *sig_attrs = wr->sig_attrs;
>> -    struct ib_mr *sig_mr = wr->sig_mr;
>>       struct mlx5_bsf *bsf;
>> -    u32 data_len = wr->wr.sg_list->length;
>> -    u32 data_key = wr->wr.sg_list->lkey;
>> -    u64 data_va = wr->wr.sg_list->addr;
>> +    u32 data_len;
>> +    u32 data_key;
>> +    u64 data_va;
>> +    u32 prot_len = 0;
>> +    u32 prot_key = 0;
>> +    u64 prot_va = 0;
>> +    bool prot = false;
>>       int ret;
>>       int wqe_size;
>>   -    if (!wr->prot ||
>> -        (data_key == wr->prot->lkey &&
>> -         data_va == wr->prot->addr &&
>> -         data_len == wr->prot->length)) {
>> +    if (send_wr->opcode == IB_WR_REG_SIG_MR) {
>> +        const struct ib_sig_handover_wr *wr = sig_handover_wr(send_wr);
>> +
>> +        data_len = wr->wr.sg_list->length;
>> +        data_key = wr->wr.sg_list->lkey;
>> +        data_va = wr->wr.sg_list->addr;
>> +        if (wr->prot) {
>> +            prot_len = wr->prot->length;
>> +            prot_key = wr->prot->lkey;
>> +            prot_va = wr->prot->addr;
>> +            prot = true;
>> +        }
>> +    } else {
>> +        struct mlx5_ib_mr *mr = to_mmr(sig_mr);
>> +        struct mlx5_ib_mr *pi_mr = mr->pi_mr;
>> +
>> +        data_len = pi_mr->data_length;
>> +        data_key = pi_mr->ibmr.lkey;
>> +        data_va = pi_mr->ibmr.iova;
>> +        if (pi_mr->meta_ndescs) {
>> +            prot_len = pi_mr->meta_length;
>> +            prot_key = pi_mr->ibmr.lkey;
>> +            prot_va = pi_mr->ibmr.iova + data_len;
>> +            prot = true;
>> +        }
>> +    }
>> +
>> +    if (!prot || (data_key == prot_key && data_va == prot_va &&
>> +              data_len == prot_len)) {
>
> Worth explaining in a comment that this is either insert/strip or
> interleaved case..

there is an explanation that you wrote (I think it's good enough):

              /**
                  * Source domain doesn't contain signature information
                  * or data and protection are interleaved in memory.
                  * So need construct:
                  *                  ------------------
                  *                 |     data_klm     |
                  *                  ------------------
                  *                 |       BSF        |
                  *                  ------------------
                  **/



>
> Other than that,
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> (again)
