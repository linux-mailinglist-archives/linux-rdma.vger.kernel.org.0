Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16452D287
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 14:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiESMcL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiESMcK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 08:32:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198C742A22
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 05:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRSmExBh1ZtW6tnnDWW0mByTm9hEFH5uKvRBpsaU7wBq0hpf13ilX/ePYS9ecmsZws+iHHYcUThejSakD55CirYYWD27irQrbDjmzNRl15zJwFDX/JnjsPz6/Bw2NXH+KD2+KPpRsijpk86jNrWEmUGVPSwMzlum0/8pHsM/H1ECJQmTniiqDJFe/WchF3LrpeF7t4B5zlsnemLZcxhbNUK8USwg4W6MeR34v3FvDLInpgDmKZfOybCQN2jQ/6v3pTqrFXMA7KI9sqRNfEgU+ZlJzlj/mzjZeRNyDKS3VapT4sryQ1rdkWKQSe8kCfg8sMPAIbursZZpOt8rZpQqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szAMVry0IBDPk/dAZ/i7k+b7CCda34uU5wRtrzKa/J8=;
 b=YuONtZ5mHHttU+v6BjTq0NsOAXgyewOQGlSwkxsrU1NgKE/NRojLxKgWivtbpkHLoqIw56bAU26VLdgSCmkaUbS6LUiqi4y2gpPbka6QwaEjwW6AMgY3nkNd1+bIUYinQfrYZ+DjDyflGVRH/xAATclKQXhpPHhjfZXFnbvUOsE2XfJ94uy3THJBwRBVcJ9izXUhOfsgzSHP9hk/TxPLo3zmrCshEfpdHW9Vo753dkeEmcRfyR+zLTuVeTy+FS80JmDGK+5pdkZS977ldtJtSbvxUDrebKoDAnkYOjQrNnLN2ZeODg7Ar2XM1zNmHtHuG7lRxoe9lLj5fxYvDclsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szAMVry0IBDPk/dAZ/i7k+b7CCda34uU5wRtrzKa/J8=;
 b=HTpY+waLSL53o2NhjGhiz6JYURjMrMdvea6Hq+3319/YjkziktZtX+h6jbsFMpfq/O7NwhF4XSxFb9ouXzq7h0VJ6qHh935G/edQq6gW1x2aTDLAYjGavNIoQNRAsDxKX2uld3bR3g1yIrEgBK770GECOzl88VtkRZ4F0arfxX0t0U5T69eJF4oyvSuKef5hY21IvOv0NlpIY7wiCQAIdgl8nkgmbqYxbiKZ6OPQ0XbhvyWHvoLOlml/C8HmgPnwzrgB+DPEnlCqageGdn8WG1ueUnKfaDYdATpxdFbdOOXVQS07SWHmVJlqhTLjCetoVlDflUfe5mgTKSyfbrT3aQ==
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by BY5PR12MB4804.namprd12.prod.outlook.com (2603:10b6:a03:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 12:32:06 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::19) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Thu, 19 May 2022 12:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Thu, 19 May 2022 12:32:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 19 May
 2022 12:32:05 +0000
Received: from [172.27.14.81] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 19 May
 2022 05:32:03 -0700
Message-ID: <a5330cad-fe0c-16c8-9d3a-00b662354015@nvidia.com>
Date:   Thu, 19 May 2022 15:32:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH for-next] RDMA/core: Fix wrong rkey in
 test_qp_ex_rc_bind_mw
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "RDMA mailing list" <linux-rdma@vger.kernel.org>
References: <20220518152310.20866-1-rpearsonhpe@gmail.com>
 <CAD=hENdeUN4D7LTyk2JaXNRKS-o-rR1yCqPXZjC4TdTEMLVJBw@mail.gmail.com>
From:   Edward Srouji <edwards@nvidia.com>
In-Reply-To: <CAD=hENdeUN4D7LTyk2JaXNRKS-o-rR1yCqPXZjC4TdTEMLVJBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e390e76-bd4e-4b45-3bb0-08da399395c7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4804:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4804D91FF201105F607DFD5BDAD09@BY5PR12MB4804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeDW5v3DC5IbKJGbk2vR+YbEcMNuWhnaqjFPyzWJpkIZJkY/1y4FhN5bSfsZyVoOtlXtNEbOqRSdzF+XAXNhmDNJDiTXSXsK8C80PgGHEV800T7HyhAaCjALuMbMze6gMYO0VbEbnfds8ezFupALsbFcS/A0TUaOIVG23IZj/Qg2MWVL66jpR6FKQPmN4//RPSogUv+ugJnKXYin5PpUPYIlS7xYWDh/RiRAQfXw8o+yO0Cw5vKLB5j4pwHX8h6wk08xcgJjj6OeFuEc7U668DG599EnGssg566qB4bnW7YAT5oQGxrA5KBvitsHfRTfUV/DAnzkAZpYRpaygfqLcpYLMrFDLK0xzTpGCpRabGNXeIat39+RaCXFUiaWdZ3I9dkbOpCTJfTANZkJSPQjDxOXmeao1bqRSzIGjovB9hL6lTO6xYARh/iw20HZUJRTy+vIt6r9dIhVsP/9Df+nd3w2vTcvnC+msRu/WXDXPFHEWjXv8HM9kZLOyK1dH92XrurXJPFXpuAXLOaDtsRD0U4wGO8Ej3EdqLZnCPmgamTxFKRDeDrkA4zGeUgozp7aGaiVry/+WnEkfUym6BrKrfkF3JmdXnbx+BRTOiv8aD7jzWZLxuEliFlYEBcDZALUh3LZHOjT47V8sbj82aB/XBgpsjtFHrGPrOIVy4fBm+kR1hqtKBDudzPdcBikawcUCEdIDC3N9zaXC9Jh00ebU6MYpb+ah3lhgE0BkTWKuOtZNOYUizIRAZz5zvA8bxq7
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(8936002)(70206006)(70586007)(4326008)(16576012)(81166007)(40460700003)(110136005)(356005)(36860700001)(316002)(82310400005)(54906003)(5660300002)(336012)(426003)(83380400001)(8676002)(508600001)(47076005)(186003)(86362001)(31696002)(26005)(53546011)(2906002)(16526019)(31686004)(2616005)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 12:32:06.0465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e390e76-bd4e-4b45-3bb0-08da399395c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4804
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks Bob for the fix.

Could you please add a "Fixes" line?

On 5/19/2022 6:38 AM, Zhu Yanjun wrote:
>
> On Wed, May 18, 2022 at 11:23 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> The current test_qp_ex_rc_bind_mw in tests/test_qpex.py uses an incorrect
>> value for the new_rkey based on the old mr.rkey. This patch fixes that
>> behavior by basing the new rkey on the old mw.rkey instead.
>>
>> Before this patch the test will fail for the rxe driver about 1 in 256
>> tries since randomly that is the freguency of new_rkeys which have the
>> same 8 bit key portion as the current mw which is not allowed. With
>> this patch those errors do not occur.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> This is for rdma-core? It had better add "for rdma core" in the subject line.
>
> Zhu Yanjun
>
>> ---
>>   tests/test_qpex.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/test_qpex.py b/tests/test_qpex.py
>> index 8f3f338e..a4c99910 100644
>> --- a/tests/test_qpex.py
>> +++ b/tests/test_qpex.py
>> @@ -300,7 +300,7 @@ class QpExTestCase(RDMATestCase):
>>               if ex.error_code == errno.EOPNOTSUPP:
>>                   raise unittest.SkipTest('Memory Window allocation is not supported')
>>               raise ex
>> -        new_key = inc_rkey(server.mr.rkey)
>> +        new_key = inc_rkey(mw.rkey)
>>           server.qp.wr_bind_mw(mw, new_key, bind_info)
>>           server.qp.wr_complete()
>>           u.poll_cq(server.cq)
>> --
>> 2.34.1
>>
