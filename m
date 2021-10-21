Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774E24360B9
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhJULvI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 07:51:08 -0400
Received: from mail-sn1anam02on2138.outbound.protection.outlook.com ([40.107.96.138]:39391
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230342AbhJULvB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 07:51:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVlr8Ok0bsZiHahcTxBcO/BDJnCu4AiOYhqKOF8FlPTpsvfGFx+UZ8VfBbVOqxoB4cTik2GHYJM99JuD12D/ZXRpjOkUSsOP7HtZQ+fLBFaAjNPjGmhbRnYH/aT/HgYgYd0iV0edVTx7+Bxk9Bx1nmWcFWK4Fpb2C1hnw8UJmZ27t0+luQNonDclAE/NGg+HXdNg4iCnNBlqUonvlDmaqoLBz7blfpdgQ2NsImAMy5PrWdRQbLZ6cZAJqW7XE7OR1nZ6XqrKkSTJHvbLQJYUGaIlFTH5/kazKXe1sT/uNSPpXVV1ZgwE/nSRRfLPBYgFbvgR/+C20Gb9qOxZpUhyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOkJ/JDGg2IqfSrU/HPq/Mvr3izSMtQ2roGMJQN9Cmc=;
 b=aaackNAmUpbgpSBUIm0EmDwvRSR4R69a5OQKcD9YhGf57MM4Gla86VSqjaG8QZ8een5+s7c7LRYg/O+0Z20wbQYrnEMhrAaP1z/kn915+7bvmqybSotNDdntL33GF3UljgBeXnJ+4UU4bcupzJJHUR+birSkmtzM35BshPP6wuRVLr6Ovnf+bZv+9A6lOgg3scWUaqp3hKLrz73F7OH2SKwqBqHi4ZMkp+UHxN9PNCF5l95ChHsXSxxZhMb+fk+128N+jffjQe+gx2RTx/8lYZY5q6G8t864EYa4CRgEut/4ha1g4VkT1KqW3WqbJsbquH0Xqx8bvQDgvfUYlKKrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOkJ/JDGg2IqfSrU/HPq/Mvr3izSMtQ2roGMJQN9Cmc=;
 b=NCVTIgsetf9mQOmTX8k+pht2q4m2Yj7wv6WOH3r6owdM9GGOsv/+7I3cZATYlnQrgytFPuXBUvb0tOWfzWEWET+GaujzpL8TUm0u+ffNOAmtiVEOqMvX7Qnryn0JGsGBAjENPx5ASyosDrzB7TvCeqSbiNMgYZI6yOSbQASCQQOc8IO/T9uWPN6Y9J14V1YsgSXQ71Z8c8vCGPULXZoYIkniQ1xPqwV5mhWFjzSv57Bc+Aeq/v4iGPxgoTeA2CjYse6FbOfXfaF/hCrcjPNhOAuA8yphhFcwME+Rq7uPEzu+eshAltbJYeaKO1CgsQCyWvYpxvUV6n9sjKYObFvqIQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6245.prod.exchangelabs.com (2603:10b6:510:19::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16; Thu, 21 Oct 2021 11:48:42 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::88df:62ca:347:917f%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 11:48:42 +0000
Message-ID: <9e112f59-e980-a892-343d-9e21924b6f93@cornelisnetworks.com>
Date:   Thu, 21 Oct 2021 07:48:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH rdma-next 3/3] RDMA: constify netdev->dev_addr accesses
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, dledford@redhat.com,
        jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, mike.marciniszyn@cornelisnetworks.com,
        jgg@ziepe.ca, liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com, benve@cisco.com,
        neescoba@cisco.com
References: <20211019182604.1441387-1-kuba@kernel.org>
 <20211019182604.1441387-4-kuba@kernel.org>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20211019182604.1441387-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
Received: from [192.168.40.173] (24.154.216.5) by MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 21 Oct 2021 11:48:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c87d2f8f-ce26-4cf6-145a-08d99488bab1
X-MS-TrafficTypeDiagnostic: PH0PR01MB6245:
X-Microsoft-Antispam-PRVS: <PH0PR01MB62451B422A97BDBEFED03D67F4BF9@PH0PR01MB6245.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGhc8Mjy6L4bx6wq1rO7gJAD8R4yrex/vPOmlvRfmNXTVRjcuYUuA/p9elB3pNBHaXTl0ewWeVNbXkiNRqrirFvDs1JhWhBXIrq/veZYApBm8VS2PNjRSMp1FJAP4ADA8P1KP67rbSq79AnRx8a+vxYAvKtxKcjO0bt9pk4hq+JobucdCi+9yexuJqAETuPQ+77CZoyCIk1sOGVDcXg5gGI8xozat+jkIMDzC+lrhD04eStuQ62LX3TTAnpffjidrBlltXr1eiGU4Ih+fx5LE2ZM/4AJ8NnNMgl+jaPMjkLbCCJOLVkurYzVvOrHbpPBv8DZJV2uPpP8niXbfuWCraSYw/OWigCi5wIE7K+R9jfCv7Q4pMoY8ovkiCFbAm5WaWibjdlVC/gyRFvGDZSz8WggUnC5hEp5pFi0ZegWQrvfpSZszkXu26aRDnGKbkQAdC2KZyVmPDyDg4yVTFzQORixGMoFJmPmipkglc+8uCjqpgIZPGzIYNRfFZ2nkm6xmeMznLMxysrcL2j6X1y5oqcWzIIML9ZiIxUoYK2nev/Z5hmjVem5kMT2ykaEa9CrLMeeG3C1cOdssKZCtfluUFI2jmIWWWGfVJUypZbMs/QXlxxe7Zvqfu80eTbHSeBKZKnr96EmhCAyro1s+1J//OhU3hXHIgbomIk0vAxmBj4jA2yu2puH+15TTJ48UhgGzO9xBBnOGaQw49ufptrvSB+ZTaRV8Ix5n/BkeU6E6bEpD6XO4Tkt7M+s21WXMNGT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(5660300002)(66946007)(53546011)(31686004)(316002)(6486002)(83380400001)(7416002)(956004)(16576012)(186003)(26005)(8676002)(4326008)(86362001)(36756003)(38100700002)(2906002)(31696002)(66476007)(8936002)(52116002)(38350700002)(508600001)(66556008)(44832011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MldPR2dkVXRQbngxNGVjSUNwREFHZ2RFUERzc3d4VkRMd2Jxa1lveU1aM1VY?=
 =?utf-8?B?dXJlV3YvN1BBbkx5cVZUL1JCWm1VZGxUcitxaWIyUmdQWjNVSmdBbmdaS0NQ?=
 =?utf-8?B?OXNRS3JPS2VFYlhmTUUzQktaQ1NSc3RianJadFBVZzAwS0VJWm01VDR3ZFJS?=
 =?utf-8?B?ejRsc2p2eThUUzZhYU1xUHd1YkxJSXZWNVU4QWh4d3lITE5QSE5FeDNBelFB?=
 =?utf-8?B?NW0rV1lSd0pNNmxWc1BTd0Q3VXpQVWxMZkhpYmdjY1FyZDZQQzFtajdhaGpI?=
 =?utf-8?B?bmsrdXUxWXR1bmlZbWZTblpiU1BzMndqOGlQZFBWK1dnWWF3TE9mdjQyOHMz?=
 =?utf-8?B?dGtCRWU4T1R6QlRTRzQxOVJwRDYvbWMzTVF1WFV5c2g4RVh0QzR1S0V0akk0?=
 =?utf-8?B?SFNvUW1yakR4ck1zY29UdXhWVGtoNVVNOTNFa0ovdVlXOUJZY1UwSnJ5dFQ2?=
 =?utf-8?B?ODZ2cjY5dFhoWk56c2F3enNkaEJlSCt5TjNaRElMU3dxYlVwNVppRzc1b05D?=
 =?utf-8?B?NVVHalVvU3MwNSsreDBDSkkyczZqZVZGU3VJOEJBZm1CR01iNzZiTzlod0pG?=
 =?utf-8?B?cHlrQ1JJRmZta3VwdnpRbWpJQ2JZVkJrV0VYa3hEbU5xOWU1S05FZE44SHFU?=
 =?utf-8?B?cHRLaHZCVlM2SGxlaVZGZFJtZXdBbE00STlndkl2R3dDaU0yeGVFRWErYlJh?=
 =?utf-8?B?V3VZcVphd1cyN21vclU1TGtZbU1UeG1VN2x2Ri95RXhycVk1RUd6RkFONWpx?=
 =?utf-8?B?ZENFN2ZXc1VXUGI5OVY3NFpxNzhwRnVnVHcxWExXYnpyR3IrOGg0RmRMZFRO?=
 =?utf-8?B?NG45a01FaGNjV3QvaWE2cUxFcE5qT1pMY2w0RzVTdVBGRkNpTEhOTEVzUWlt?=
 =?utf-8?B?M0tBVWdCcndVd3BkNGRqSmIyendyUlBONkpSZzdtMC85YTlQQ0ZTNFNYVWtZ?=
 =?utf-8?B?ZmJ3ayt3SHJJSmdSU293M0VMQmtNU3JyNW1GTTdYakJxcThLRktTYkEzWmhW?=
 =?utf-8?B?YnA1bFBZNUZlR0ZmMzJNL29XRE1aRjUxOGc0dyt4RWhUNkZiQ3hzZUQxRmJm?=
 =?utf-8?B?OXZNbEZMQXlWdmdaS0RjcmxMQWFPaWZualAxWnB5YlVhaE5OaDVyYW1ROG14?=
 =?utf-8?B?NnAzUkNKWEtwWkVPOVVXNUovMWhpZ2pIU2xwWERTd21GQjl0S3dQU3dpNFNl?=
 =?utf-8?B?S2xnLzJBSXJnRU0wSHNDMWtYbWJyZy9xRy8yR0NJeG9hZ3FIM2U2dEF4OTdh?=
 =?utf-8?B?NkpWM3ByWkJpdVQ5Tml6eTBOcUVyL01rSzZCNmRSNXQzUjVUdGVpYlAwTXYv?=
 =?utf-8?B?dEU4NFpSY0hWN09uKzBTVTJqVkszK3lTTm5PQ2xUYTluaFBNV003SWg2WEhQ?=
 =?utf-8?B?Wmd4RTAzTldvMDRKdjNtckp4b0lzaWpLS3pGajdZSjJRdG94R3JzblFSaFBv?=
 =?utf-8?B?WVRaKzFMVUVLOG5xanJkSE4vSDhBdkxFUWNTOWtkRUZPb0VuTHVid0NTSGtE?=
 =?utf-8?B?djc3Mk1MMCtpMllhTkRnWEtHaUNqSmt5RlZYK0k2OEJ2YjdBREVKd21yakhC?=
 =?utf-8?B?M0ExRlkyczJsTStqKzQzV1lUazl1eWpLeHFJWExrRUZiWEdJTW1LSzJTUllH?=
 =?utf-8?B?Q3FXOStxeHNxMkVjZzVMdWJkaWpNd00yWlRobjBqRXI2aFhrRlgwbCtkV3ZV?=
 =?utf-8?B?VDA4TFY3K0ZSY2Zvd3dldDVqcEszU09weHFZWnJIU2M2VFMwODNlcXp1OXZ0?=
 =?utf-8?B?VTQ3dExUZUxEUTU0ZFc0SVM2UW9YRmVFMGhpMHg1bStIMDFwZ2xLZkcvOXRr?=
 =?utf-8?B?SU1YWEt2TDdlekNVZHJzKy84aDMrVGNmbk5KejFNMkgvMXdQL0lpUStWb2RO?=
 =?utf-8?B?OG9hTXZaZHBLa0RHQm1yL01zN3I2VVIyOFBqTXk5Nmh4dWhuWHBORzQrNEww?=
 =?utf-8?B?cVRzazdEdXd2L3NQWm05eGFUdW4yR2ZQMG9zWFhPK0czTkZsNllDYmlJeHM3?=
 =?utf-8?B?MXM4dlJKYzNnPT0=?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87d2f8f-ce26-4cf6-145a-08d99488bab1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 11:48:42.0556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddalessandro@cornelisnetworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6245
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/19/21 2:26 PM, Jakub Kicinski wrote:
> netdev->dev_addr will become const soon, make sure
> drivers propagate the qualifier.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mike.marciniszyn@cornelisnetworks.com
> CC: dennis.dalessandro@cornelisnetworks.com
> CC: dledford@redhat.com
> CC: jgg@ziepe.ca
> CC: liangwenpeng@huawei.com
> CC: liweihang@huawei.com
> CC: mustafa.ismail@intel.com
> CC: shiraz.saleem@intel.com
> CC: benve@cisco.com
> CC: neescoba@cisco.com
> CC: linux-rdma@vger.kernel.org
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_res.c   |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h   |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c    |  6 +++---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h    |  5 +++--
>  drivers/infiniband/hw/hfi1/ipoib_main.c     |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  3 ++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 10 +++++-----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  6 +++---
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  3 ++-
>  drivers/infiniband/hw/irdma/cm.h            |  4 ++--
>  drivers/infiniband/hw/irdma/hw.c            |  7 ++++---
>  drivers/infiniband/hw/irdma/main.h          |  5 +++--
>  drivers/infiniband/hw/irdma/trace_cm.h      |  8 +++++---
>  drivers/infiniband/hw/irdma/utils.c         |  4 ++--
>  drivers/infiniband/hw/irdma/verbs.c         |  2 +-
>  drivers/infiniband/hw/usnic/usnic_fwd.c     |  2 +-
>  drivers/infiniband/hw/usnic/usnic_fwd.h     |  2 +-
>  17 files changed, 40 insertions(+), 33 deletions(-)

For hfi1:

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
