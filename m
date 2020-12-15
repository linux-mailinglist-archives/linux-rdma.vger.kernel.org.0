Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42682DB5EA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 22:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgLOV0X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 16:26:23 -0500
Received: from mail-co1nam11on2109.outbound.protection.outlook.com ([40.107.220.109]:49450
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729976AbgLOV0N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 16:26:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldMQv6JWUdYpm1/SUuEybfIk5Z0r79wZon7yxaxGlz6FUq2v7PTvAbPitJJ7qvhBt6hvwaBwzeTvTJYKPUrQf/s2rw4QblJoj7Nvwpt0SZkSIU7hi32bmZ1+EHHJWBiRxFvcp6wHYFy18cneg7ITpUFgjagLxeSH3bFaSTnCjg+FdpfPAqW4251+7cGVHlVWIEXwi3EttcOsCRYUDtMswgzQDdo+t/l5XmHjWW+C0Y/6ua28TJ/VjuHQ1dL9AwiPsFOtvhBp0EhIpdYRN2cr72bEqDz64EFc/mhTc99ewItFYN5FJwDa0w/S0VQpOysiOqbGfw6pJb6Hvj6WjSmHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPA5KmKHPo9eFJfXVYfHfCFkUSMKFlX3/slyXxp5RlA=;
 b=OTNsgdA4di8Txa0h730dclQMvi6BGEbYbtiNoiFhR/BqUgvU4C8hPesUyNaUPHuTfEzwtNgsyduGZKC7H1azeHvSunWeFIzO8DxIrjP0McK35MptB1QIVB33oDUw9YSVFYSBbmeCR04tTv2uLgHIMRn560w7fOT/csVFeINYRSDbll0N6XrgCHf0uwyyEBznKhF8VtViHPgPPYNxNoaQxBB6GE3vil7tf8S0cgWN8JTl0B4MmR2Fhr1p2zjhaepiwE1TCo4N1qAbE4GhI4k/7OVQ/ELq1RgCgwqLe18IgL9Adh0++5oXWGcaK0OeKhLTOjqEcwvH2PR7SOmR2cgmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CornelisNetworks.onmicrosoft.com;
 s=selector1-CornelisNetworks-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPA5KmKHPo9eFJfXVYfHfCFkUSMKFlX3/slyXxp5RlA=;
 b=d+zi7aa/zcoBgdE88CfAqi9jP2/DfBpoDyr4EX7xi9r3L3J82gCC1NyeEz9FQ4NOzqPwmJVTqK6L8wq242vs4VsdMasSssy6SmegHyXnoNISUQTbziLHNhWeTWTGlQe/mjwZrASZSmVwWupHSv38+72yGvDVpoFl56QNjs+ixy2SRr8XwrF7e0lMHHjqan1e1xvaxl/5sLQJ8uN9Y0PsdaR1+BdXz/l6x5w0ScgvkPD7ggOig5IUQfpGNt9d0m47N5ekEtDR/2VFQ1hCFHYQUyK5lj3b3COjAiPolCpSmWWiki9P6+A1KsnuElNWorw3MeuOFPx0UGtqcYSblDn3nw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from DM6PR01MB3817.prod.exchangelabs.com (2603:10b6:5:92::17) by
 DM6PR01MB4025.prod.exchangelabs.com (2603:10b6:5:2b::11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.13; Tue, 15 Dec 2020 21:25:20 +0000
Received: from DM6PR01MB3817.prod.exchangelabs.com
 ([fe80::80d3:12c5:1173:8cf8]) by DM6PR01MB3817.prod.exchangelabs.com
 ([fe80::80d3:12c5:1173:8cf8%3]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 21:25:19 +0000
Subject: Re: [PATCH] IB/hfi1: remove h from printk format specifier
To:     trix@redhat.com, dennis.dalessandro@cornelisnetworks.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201215183509.2072517-1-trix@redhat.com>
From:   Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Message-ID: <1df6bc53-58ae-b91a-fbd2-57d52483c24a@cornelisnetworks.com>
Date:   Tue, 15 Dec 2020 16:25:14 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201215183509.2072517-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [70.15.25.19]
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To DM6PR01MB3817.prod.exchangelabs.com
 (2603:10b6:5:92::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.103] (70.15.25.19) by BYAPR08CA0022.namprd08.prod.outlook.com (2603:10b6:a03:100::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 21:25:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e5764e0-9460-4cc4-d9d7-08d8a13fecbe
X-MS-TrafficTypeDiagnostic: DM6PR01MB4025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR01MB402532EAA7CD082492767DC0F2C60@DM6PR01MB4025.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5h1Qd2mPo06l0yBqiuy8meW1HSZs1Za10XATSZZC09nmid0rYiGKuN02xdBG/67F/lpsm2APHr/RMTD0A3hsYy+5I4JvULptDkY9nXhe2INJQui9msZtxpcaCnHwzFUHaVYP4iSpT9c1wYhYu4QuPgTgMrMXLyqNarjzTwtySyNB8lrsGMSHI/ULPzeujKYJL3EaDCvmbAgDfkr5zfR2Ts/nbeaRoFmaTptO1FPtirhjO2MhScbogthasnKfNPYBPXMdS804qu9Sz2oU8IMwQ2ynoHPjgTsMcj3CjEeU/5EZZHrx/NrC817k5zoppfFMiPtwGRwYx2zTnvLJ577yiEcfH5/xx/CPdnwbp8aLsHqxigJB2eGDM5gGVbGz6iZqRXNrz9wUNoizoDUECJrlVNu2CZS9tWkjW6DbILa7M8m9Wr3EhpM3GRiSk0Nt8Du
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB3817.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(2616005)(34490700003)(66476007)(36756003)(26005)(5660300002)(8936002)(31696002)(186003)(16576012)(8676002)(2906002)(86362001)(4744005)(6666004)(4326008)(44832011)(6486002)(52116002)(83380400001)(53546011)(16526019)(66946007)(508600001)(66556008)(31686004)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NjBBbGlMUmFqRGJISWxmWXZZNlVsSUE4TE5aQlVMbkdrUlNiL1FubzcraTBm?=
 =?utf-8?B?N3ZQTlRXQWdDNGt4SHQ1dXdyOG11VDB4b0owdHZtRU9Xbmg4eXRDZ0ltRUll?=
 =?utf-8?B?WHRWL0tMelE4YlFOeWRtS0pTZnVMSWVOQmttVEFuRTd4aXZKUFlYVEN3WjQ4?=
 =?utf-8?B?a3ZmQ00ybUI5SDdBKzZwSjZvOFR4N08wQUpXYWJnZ0JaVlRHZitucDE2dVUz?=
 =?utf-8?B?cldOYnpuYnRHM2grb0djY0E1a1BiZ3VhWTQ2SHYvQWJ0Z2QreGNtRDVKMWZr?=
 =?utf-8?B?Z2RESVFJd2Via3pLTlRseXk5bWkybGdQRnlGeXZBdkZHN2x2M3NSN0dEN0d4?=
 =?utf-8?B?ZHM3dXBUaFVYenRWNlZuWGtRNlFrQVM4ZkdsS0xNdW5FVFBMMzlsem1BZ0Fv?=
 =?utf-8?B?NTd5bzh1S3ZYVktGT0toUGxJQWc3aDluZi96a2U2WXhnTGcvbmgxR3hRbmJV?=
 =?utf-8?B?elozL1BTaE1OTDhhdlQ4R3l6bW15Vk5XWG5wdWY0Mmg2bk9jRWhrQys2Z01s?=
 =?utf-8?B?cThJM2ZuUDNqcmpKcUNzK3ZNbzBGUkprL3hSNUJmaUh0ejAzR0QvMkhqOXFl?=
 =?utf-8?B?SmEzL0kyYmlMWUsrK2p3ZjVoRHNwRDRQUE5KQXhIcm5ETEg4UFB6UXZuYVU5?=
 =?utf-8?B?aDRGV3k5R0JoNjhLakY5ZDZkaExzeXRUYld1UGlmaWRFcENsV1ZabjdEYnNo?=
 =?utf-8?B?LzFBVjhsRzJWNG5uSXh1TmZ3WXYybkZkVlplRmpkZlVqajlydzk2VFcwL1hJ?=
 =?utf-8?B?N2czZzZka2NxbkxBdE9vNVpFM0ZzbUx0MytMRzRNZ3RhVnpxaHByYUFHNS9j?=
 =?utf-8?B?bDF3VDVuckZuamxsdHBiQjEvZjZlME1Id3FuUUVnMnBmUTdvMVJhak51Vzht?=
 =?utf-8?B?T2dmWExabWJ6L3BySStkMmZvOVRTVStuV1d0V3dxOGdMY3RyM2YzUTh1OERo?=
 =?utf-8?B?Z24xVjNOWURWWnIra09saEtLWG9MRFlJT3Ezb0wreGxEclljeUVlZkU3STYy?=
 =?utf-8?B?b0hFb2IyVW5sYXZpVlY3cmZRbC9mMExoRy9DN1hPV2NDU0ZLazRweXh6UXhI?=
 =?utf-8?B?WFQ3TkpMWDlkdFRIem9OanRUcUZVSEJrQllJeDMxenRYa3p0MGVxNU5FWE45?=
 =?utf-8?B?K1ZvSytUVm5BUXdsT1kweTdNRVpPVUhxTFFPTVA5a2d6VWR0YlMxSndtU2JX?=
 =?utf-8?B?SUNmTGlhVENydFJJcE5zcmZzajBaaFVGcHdOTlh5OXYzTmR5dzgxeTBoMk1R?=
 =?utf-8?B?ZHFjUGRrdXJvdTdMVDZXQ0JJNmV4QTRzTVpIWHVMKzByQkJqakRQQ2I1S3di?=
 =?utf-8?Q?007PAesfnLmMs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB3817.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 21:25:19.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5764e0-9460-4cc4-d9d7-08d8a13fecbe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+UwjzlssgKM2ZLA2G3Ir4tGPEdU9Ub0ZyjkQrMdu9FMi1PYQXV/FW6SfhkEGraNJYLJLVPH4GJSAn4XhE1hKo8KyW5Aoxlo+SoXdQ1Ulw9vPDO8CljIA0NXfBbl1rxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4025
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 12/15/2020 1:35 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
>
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/infiniband/hw/hfi1/sdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
Looks ok!

Mike

Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

