Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D015301DE
	for <lists+linux-rdma@lfdr.de>; Sun, 22 May 2022 10:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiEVIcf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 May 2022 04:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiEVIce (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 May 2022 04:32:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F43275D3;
        Sun, 22 May 2022 01:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a191kgjc6SjaUt+qkOUb1gasjt41vAGubx5+fHEoxbLtU3KvBrnmq/26K+C6kuHapM29ckyCuz4sFsD48mhmhdYP/silV0p9BjLUDUgSRsGfPhYfFYAWUgd8XdGCBKyeuQ5FUft0dL26Vq2mdVnYHMJrorxWLmmbaWYAhatxJd1iDxF2sEyUh2k/jlLJmMpUVUafOp6mOrb1+QfzwVfEDODJfTo7TZ0HpiMPvjOo0pLgNTqCsiyon3NsTZ7zNmBCjAn1ZCZSp8JkiBdBX3sd8CUlu8cBsxBD1iXPLgFZNK0ZcCnERR+WZIuuBp3mkx0kUG7UPerUC98t5Ty860JMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1P0PZy0LJzL+QUdcIvE2tNHmLQ99w5vY3KYzzBfbG8Y=;
 b=DXRHgyNvRbmmafW8QLJOFmpMpPu8sFw/ucQt6HxP8XNQ8/fVm0fdaDQvkjpYOhDDf6fwtyx3f/vA+cDgrEaP9s1BtKtUtgaLQmNPOooVnELbLv9L8TVwAG4ZQI4/AC0U+uoUHhGnlWFiwtGqNInJrsT+ZsUVgZqXp+ZdJdV5mQUhtMlJdCAcKSB5Hhbu6ZBehz7VWTULXW1rB1FhX7/QCKOGfxTZjLwB+vhTex0yM4eMyZmthuMzLuCWUOB0KO0Ql8EXVRKAFgVbpVPp92YzgP0gROrm/25NkWoUcuw+/0wf8d+fPTwte4ZIXoO+B5rvObrcpMtbc86LnPpCkLVi+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1P0PZy0LJzL+QUdcIvE2tNHmLQ99w5vY3KYzzBfbG8Y=;
 b=R4a8lbi9Ok0nBC2wvPMzA4jS7/EvCy2Mna2tA3/VaAMYEkhWiGI2TxDYn0Hco5YG72NHGFHuwZPs5ZXx0Rpbh1sdhd1WCFb83pB3ewEWyH2pC2+HX45iw1USisHdbSYKmX57SxVZHIYoNHrioBzXVxl75GPKXPZqzipcCeoyglsn0Ui0ulXmBkLggFjq8xW7X3iBmL+v8f90Y+RORqGGe5KUgqkB4nAh9ZzLtwsG15lRgEAgc8aRtbPXAddj1X54fOx7NTidfhfE60KZdfOXz/Ziar70hkqcI7mdHWdHQhDjmvP8ZEzJMveRDTrObWaUoEbBHxpbIrW3BIx1KNZI5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.21; Sun, 22 May
 2022 08:32:30 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::b3:bdef:2db6:d64e%8]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 08:32:30 +0000
Message-ID: <3cbd35dc-2e63-26c4-7258-012009a97dd9@nvidia.com>
Date:   Sun, 22 May 2022 11:32:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] IB/iser: fix typo in comment
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220521111145.81697-4-Julia.Lawall@inria.fr>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220521111145.81697-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae924142-6d9b-49be-efc4-08da3bcd9c19
X-MS-TrafficTypeDiagnostic: DM4PR12MB6231:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6231D227BB3B19C483FB9B44DED59@DM4PR12MB6231.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +aLq+PZRKPwLazemnDiCQJXhtwlIXoAeFcSk2pIBU+1ahSWdXNZygiqxkZU/4opnlKaISAaF5gXPwMUP0DiyGpt/wW0uUIZJqXcgtQ4HaNax0v2dcyQmj4C41bEtILTz24mwlBAfVm12dt1/b3fHehyjvoodp2QjIps1PWctINRpjYiTloqe9+rUexm4kMNh4UemCREsd9i5++2fnXIY1WHYtsT6Z1X/+uu4x1YxI4939HgT5oN0eeVmFxD1pYjwBmyjg5IhFfFdHpXjekvapSwKhO4U3QLkxiXFbBmd73LbUr0EI1DOYJ6Y+pIoCZpshzGyE9OgskgdFkylRFyhFO237ak6O0wxjeLqLnc7JDu4bogBAW8CWKJdqD/H3/FVLbtDnQ94aLLBqFASIXotBp2Ay6sdcV18iERyPHGOGEGnvPQIUsWwf2SE85x5EmxNBIB/RoA16o8H1cGKYAXyKpd78GbYB5yhp4cpbccMqUnfns4rLp+bJwsKk64/NL69cqxS8GPVECsei5OixVyECexYTyMrVNTmge/ztlG9Etil01OCzwJ9cyo9b/oOsJTbxT8nh8g6ABw/zgUwozQevvaSPworx5Kjs3km9zpATmO4IitnGnLM0bH1beLUlo9m86anSUy25kcJNnjkTyyQV9lZpy4k+RoshrPEDVjAkJC/dyY0WsLiDrnsyI487EYzqkUUnTDzWpN5M27dwJzRvig3y0DswQiLenfCM0qyP/XT0Fq/m84KuRV6PlKO5twZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(8936002)(186003)(66556008)(66476007)(66946007)(4326008)(8676002)(2616005)(508600001)(110136005)(83380400001)(53546011)(31696002)(316002)(6506007)(36756003)(31686004)(4744005)(6666004)(38100700002)(6486002)(26005)(5660300002)(86362001)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE53NVAvZm4xZGgwbXI2TUQxeVhvR1o4cmNpU1ZpQTJrdU5RUVFXZyt3azlY?=
 =?utf-8?B?L25CVG00dy8wR1AvVzhIT2hDZTNTTFVmY1ZpOE5KYTJwQy8rUnR4Q3pSYTdN?=
 =?utf-8?B?YkJtaE1wY0l4Z0ZHREUyZUUrQjVvU1h5U0RWK3ptUEhZMHhsRGNyaHRRbjlk?=
 =?utf-8?B?cUF2NFFxdFVVcXJBOXZxTEw5S3FIU2lNeVY0cVg2ZlhPeGpnaWZLUjgzaE9J?=
 =?utf-8?B?RW1ROUtTMlJnTGtiTFJ6TUpSSktpd3c1c0VuL29XM1NwV0hrMXpGNVlBU1NU?=
 =?utf-8?B?RDEyajJTSTlSdThEVDcxOHAyYVdFMldiVTdFYkNodWZic3lOSjJuVVVvcUZ3?=
 =?utf-8?B?K3hGWU0vNk1UY0pYYnhtWmZ2V0RPTndBeWJBRm5Ca3NsVmIvR3VvYmgyVnFV?=
 =?utf-8?B?eXBWMkRNbkJ3MUV0TG4xU2NBNElDaFk0R0xOOFp0OGRzSzFZQk10RXBpOUN3?=
 =?utf-8?B?Rlp0UjRUWW9CVWdub0R1L0JTeHFGTWh1c0NBdXlGd1VvbHRlbVI0QUxlemw3?=
 =?utf-8?B?VE9OZzJQYTdjTlNrL3Erb1o3dVM2OEM3ZFloTUxGNmRuYjdNRVBXdTNMNFB1?=
 =?utf-8?B?Q2Z3SzJlbzFYektSNktBdFd0QmpxelFMNnBUaU51eXVCeEx5VHZXcnQvYW5W?=
 =?utf-8?B?Z2FhOGhEYTM3ZjQ2NlJLYTJzS1N2Um9aNkFRbk9IcjJPOFd0RFMxUFFraE4r?=
 =?utf-8?B?YWRUTTV3UFl6a3pNYnZkc2xkQWo0K0dlNE5xVXYveUZiS29iR25JTWIyZ2Za?=
 =?utf-8?B?Wm1KUllieC9oSWRXODhIdGZEb3NJbWh3UFRGWWIzdzczYThzZ1NhRi9yeDMx?=
 =?utf-8?B?dUs0WC8yUGYvL2wzTmtlQVBnaGV1VEF1bFNCU1hnV2QvYzRPaGRLYUpkcmN4?=
 =?utf-8?B?MXpmaHp0TFAxc2Z3bllGekNXUXkwT0sxK1BFenNsUk5SZlkxazJseFN1TFVJ?=
 =?utf-8?B?ZFh3dTd1SW1HMmxNVzBzVnVZSi9ZekNLRFY1YW5zOVhyOU9MZFdNaWJVQWtv?=
 =?utf-8?B?MGNsbDI5ajdwbmVDNUc4TEYwVXdBdWh1TnV4NVdIZ1MyOWxVM2RicVlURzVT?=
 =?utf-8?B?SEE1TVJmN2FzRlNOd0tndXNQdVNyeUUraUFTVjQrUVNpZUJ2VFFYL0k4Vk5y?=
 =?utf-8?B?WTJFeVpieUVUdVErcmkxUEliQk4vdTNXYUEva1IyQ00vS1lVMmJmWE5xMHow?=
 =?utf-8?B?SXJhZ29VSm5uVTgyUDZ3M2FwRXA0RmVwUzBKbkgvcS8yaG9CRzViZXVnbUdP?=
 =?utf-8?B?ZUxOT3Y4NkxuSnpMYVRtV0F5bFVVd29hb2IvQjdHc1QxRUhRU05YbnkrVXY2?=
 =?utf-8?B?RzlqNEdaM29kdHkzMzMwQkVkNGVEdENiMjNTTWg0bHBYNDJYZHF1TnRYWTVs?=
 =?utf-8?B?dHRRaE15d0JTenY3VEFKbElZcG9TZ2wwVldpbTdVN09qb0QzNy8zeDJ2WXRr?=
 =?utf-8?B?UlJCYlVjeFh4QjgyYXp0a0xCSzB2OHdDSCtpemh2RWtjOXEyRUEwVW4wbXJq?=
 =?utf-8?B?ZklqcWxmNSsrR2duYU9BZFlzTGM1WE80a0ZWTnlESzVEbFpEcUM0dExUQ0pR?=
 =?utf-8?B?WHlvYmZESTVTcXAzN2ZOMHlZRjJqTjJ1YmczZnh5QU9RZHlUanVmUU1Kcm90?=
 =?utf-8?B?VVF4cGdMbFRheTlRVDcxZ1V3R3dkSDE3U09oYzJ5d2tPL3dZcmZsNDh4R0t1?=
 =?utf-8?B?dWI1T2Rhc01NZlAxME9BNWhpQUVIRFFGd05ZYVpDaWdtWC9YYmtyRUtVcEtU?=
 =?utf-8?B?UGxxa1lqejlqWW1hWDBCcEZGNEdWSGxRbUdKYkVzQms3RjNJeTlidFgvSUw0?=
 =?utf-8?B?QjdPc3Q4T09tenZjWDJzbEVkbFlJM3Z5eWlPTXNGNGVzUkZMVVhLVUZtRzVC?=
 =?utf-8?B?YnBWRjArdVdjbjUyT2x5NU11aUNuUjNGVGhnTVdaNVlFd3BUQndXTmhMQWZj?=
 =?utf-8?B?R1BoZXR3ZHFQckNwOU1DRWludWxhNlhQWmt4M3kzTjNDKzM4T0tvY1Zibmsw?=
 =?utf-8?B?VlliQnpNL0VPbC9pa0xkQzBldmJyc2srQjQ4SVhTZStMYUVDVUNFZWRiNHlF?=
 =?utf-8?B?UEtOSEpta1M5cnJTTVNueVNmN0NXN1pUMkNSVlN0bE5scE90dGJYSlpJb24v?=
 =?utf-8?B?MWdpc2lwYUxsVDBzOE5sOXd2QnVwSnJkLzlBazltL2FQUGZuZU55QytvcDZH?=
 =?utf-8?B?dHQ4T1ljR09ndk41SjI1Q0RMZWxubHY5YzlibjEvZ3Z1bkhCQktQNGcwVlZs?=
 =?utf-8?B?eGxZQ1NYUFpNbjQ1ZE1pWW15TXQzM1lhbzE0UjE4R2I5Mm94MDVCM3o3SHda?=
 =?utf-8?B?emVFVFM3enRQZjdQQ3V2R0dVdkRWN1JOcWt6V1Q5TjJ2TmpCaVF1Zlhsb2tr?=
 =?utf-8?Q?nd6end5LEHGaVvUo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae924142-6d9b-49be-efc4-08da3bcd9c19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 08:32:30.1824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvhXbWRmS24gnEEP5ki/AxTABn8ctdHla2OcHHz/wHKzsc31g+wdrkoCjbiCYwrUgYJlX/EOxn3iq8bI18kmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/21/2022 2:10 PM, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>   drivers/infiniband/ulp/iser/iscsi_iser.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
> index 7e4faf9c5e9e..dee8c97ff056 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -363,7 +363,7 @@ struct iser_fr_pool {
>    * @cq:                  Connection completion queue
>    * @cq_size:             The number of max outstanding completions
>    * @device:              reference to iser device
> - * @fr_pool:             connection fast registration poool
> + * @fr_pool:             connection fast registration pool
>    * @pi_support:          Indicate device T10-PI support
>    * @reg_cqe:             completion handler
>    */

Looks good,

Acked-by: Max Gurtovoy <mgurtovoy@nvidia.com>


