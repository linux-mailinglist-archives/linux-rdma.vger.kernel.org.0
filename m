Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99631E211A
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgEZLnJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 07:43:09 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:27470
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731906AbgEZLnJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 07:43:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mS0ohyD86F1e6N8i9xGcWQWT9JGOi8cPqND35hTkpFDYprPzrDttFA/guQO4JjkUT2Vjahvn/yaufzWBRzQzEBTO+8Gzqv7BqcVjgX6+vQr5foC+1KhD39lJzPiIEzK0pJsdEtyGmcFI14r6zWsXOPb0wKx5i9GQ4Kkmu5hti44ZK95+RPl6es/HDmNiHGMUMzKk108Z+9N6tso4LCuxc5xnk0fXfMYX9/Kny20w945CyuXDdl04v94T8NgiXmvRse7XXlaY3zFqMjuBfM9iWT1qtarVJv47DlF7N4WtcsxUHtjBT+ZcnQefmf8w9awEDpMoXBiPm4IvgZExeat2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz+wbojxgsZO0UcagK9dtUQ8+JYdu0FEHsnL67rMGmw=;
 b=erRUCRh3zXHnuhii+mwZkZwkY7x9P4vF48JAtDf/+fM/LZ2jGoFL3VlQ99LQnfTKfDMY4L8TdvA4SwwSbJT4HI12qgbHhCvABqrWZSb55siNNNvna6K6V9DiCLUNwG2xLZIfWYw5BEycJxFl/TdjyJ5O7JNCr4Cfrw1MX+eyxYHnuOVYH/TSiU2xHdHVY5e7QV2IgCa6e6+6zdVPGRtk7Keyzq1jk97PU+gR4pF8xg8xcqxHD91hXAwdDzmxY7o9pL0BSARNrupO8a+YJlNh4WX4v4NDDI4256AdJkZ6/td1Z6MvFuJnDXh9nGOCXGfh3jXqASQ6mHgsmZKX+S+ZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz+wbojxgsZO0UcagK9dtUQ8+JYdu0FEHsnL67rMGmw=;
 b=aNHa2HeTDg1A5+yDXr1BAeE8ZgOkhze4Rd7c9kdfayh+zrbWB2HSW0VuHH8E/YmDIH6Zc8XWBN0dXsPWPuKxwK9Wea38AWjX2OprwwNKdWKDDlnVrrj3x9CcSnlglXcCCHOgDCmaUM7xACMHgyU5SReYh1vX0Nl2hcELjwuj64I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB4076.eurprd05.prod.outlook.com (2603:10a6:8:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 11:43:05 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 11:43:05 +0000
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <dcbddbce-2f30-06a4-383a-c4f41b39f2de@acm.org>
 <20200525164519.GG24561@mellanox.com>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <124ef522-533f-161e-0c71-f06507ee8ac6@mellanox.com>
Date:   Tue, 26 May 2020 14:43:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200525164519.GG24561@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 26 May 2020 11:43:04 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7b44f275-72b6-4fb8-d563-08d80169f433
X-MS-TrafficTypeDiagnostic: DB3PR0502MB4076:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB40762F016A5B8A0FC645A4CFB1B00@DB3PR0502MB4076.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ztt/2AWXIVBlJE8sOmoFPHC1UG359fLnplR3Rnzw9b//dJreUG3IgKv4akjqBUslPivTy8BWuGBxtwYTzgmpcihwj/8+ntDlvm6gb44j6vMP2lcw8702Z4ZqiJYh5Yfa7+mA/yP43S7xN5kv67ukZG155B5rkTDrj9FLz4LDLBupd52TXZ8XgV4CVsHRBuoCPPI8mV5mfV1+fCwilLWgq37aUi91rkIx3QmbNbGCC9ibactc9erBs29PEjw/hhO5dRW2TDL4t+xvzxKXB2Cb+OiI2x0HGdzpwraVB+T4f9UwBcY7ZJiMzyvPT7CLSaLt1nz0LtzSCoN9BZJxmfR+Ys5j6vFsUvLWInLD+OW1KuP1/SU/qKKKaUdYKzhqXVLN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(316002)(6486002)(86362001)(110136005)(5660300002)(54906003)(8676002)(8936002)(6666004)(4326008)(36756003)(53546011)(26005)(31696002)(2906002)(16526019)(186003)(66946007)(478600001)(16576012)(31686004)(2616005)(52116002)(66476007)(956004)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q4tUJ8wYjzIq7NAVsrx7q8gDe/YFOSI+n212iMiIqMw4iKKWNsrvHDj2FMw1AvlJKxc9/ksbgAMbxr0hYFGyFuezFhm7legSfNLzCK0MaXBKVbFSQklPgEcr7kw2yfZc0vLqBgkZgXEjZbJoYHOyfLMpBYmWMnUUQDeL+0cZKyBGerXjo5wUcGOaNtHc7eEI2S7eoR/ZMYEQR8HoomN9luPEzE8PV0dKpFOgS2NapRmmUE05Oe7RZUPTD3LeHEjFQXNe6umDvk7qOD3OxyLtcS1HgNuyJavWgdcvsRwfnZvRfcVEZJlrRqTWWt/ZF6mK7SjpYDNluLKwGYeCiRBfXSS3xwX3UYDuPGs2vQIZ2wA0pGr08nTYIHa41GNm/yd8EITz/MiPLZW5LAuVMyEdpG0qfT97pQ2bDhx7yHn1RhcEgQyZw02ho8+w9F7si28XVR9sO9098nTb/PPhIG1GqrncWk4xs1LzfwSByynIl5Q=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b44f275-72b6-4fb8-d563-08d80169f433
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 11:43:05.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfdTngVpv9EfpLp4rYTu+7EEcJHlDmp1ox33L2+vmTZDayAQG1RX0pybu2yTUxUrAifPolBeKsN8Uw/Iv/Gxkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB4076
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/25/2020 7:45 PM, Jason Gunthorpe wrote:
> On Mon, May 25, 2020 at 08:14:23AM -0700, Bart Van Assche wrote:
>> On 2020-05-19 05:43, Yamin Friedman wrote:
>>> +	/*
>>> +	 * Allocated at least as many CQEs as requested, and otherwise
>>             ^^^^^^^^^
>>             allocate?
>>
>>> +	spin_lock_irqsave(&dev->cq_pools_lock, flags);
>>> +	list_splice(&tmp_list, &dev->cq_pools[poll_ctx - 1]);
>>> +	spin_unlock_irqrestore(&dev->cq_pools_lock, flags);
>> Please add a WARN_ONCE() or WARN_ON_ONCE() statement that checks that
>> poll_ctx >= 1.
>>
>>> +struct ib_cq *ib_cq_pool_get(struct ib_device *dev, unsigned int nr_cqe,
>>> +			     int comp_vector_hint,
>>> +			     enum ib_poll_context poll_ctx)
>>> +{
>>> +	static unsigned int default_comp_vector;
>>> +	int vector, ret, num_comp_vectors;
>>> +	struct ib_cq *cq, *found = NULL;
>>> +	unsigned long flags;
>>> +
>>> +	if (poll_ctx > ARRAY_SIZE(dev->cq_pools) || poll_ctx == IB_POLL_DIRECT)
>>> +		return ERR_PTR(-EINVAL);
>> How about changing this into the following?
>>
>> 	if ((unsigned)(poll_ctx - 1) >= ARRAY_SIZE(dev->cq_pools))
>> 		return ...;
>>
>> I think that change will make this code easier to verify.
> Yuk also.. It would be alot better to re-order IB_POLL_DIRECT to the
> end of the enum and use a IB_POLL_LAST_POOL_TYPE to exclude it
> directly.
>
> Jason

You are right, this shouldn't have made it this far without refactoring. 
I will move POLL_DIRECT to the end and clean up all of these references.

Thanks

