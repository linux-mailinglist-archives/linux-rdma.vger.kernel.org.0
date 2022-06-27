Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5655DE36
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jun 2022 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiF0M5X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jun 2022 08:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiF0M5N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jun 2022 08:57:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3543BC97
        for <linux-rdma@vger.kernel.org>; Mon, 27 Jun 2022 05:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeHRiIzM055OVBinhtDgiAFypTQ4ytPe8UaQ6eCs/ol7aXEAfF1qjynvqPyhTTyCPpvEP4TkFH1MFSXnfnXxWg1uehbpgVU4A/8dLbJmnB73APO39pGzsspM4xEOolvBop6CIR5NU+IGaadYw0zY+D9vUwhmC4YvvZEg+9iSTRMcT22dvfxgByR388kF3SLht6KLpXxcnkW5LNhl7cfv68Lrq+3DM1TpYCZ+txtBSPwVgPZZwQkp3H5zY67y0kDrd0KgO8NuV7N0kJdW8ZI9Z3sCjxZDY+gVbla5oGnWPs5c6CbUYausU1QPAB0X30WBy7rZ8HsFC0vy8r2Kty0G5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2+rGxcAyPpjJ0Ue5uISBE6E/wyc/7VEapqs4LQ4W6w=;
 b=CG1CXVo+4dcpGMCecPEdApduvXwMWAUrReV2zWDUVfwm+JzOp/N/+XvDy4c3mbZftfFLVfMtiRYWeaLHsebfoWHN/Yfs83PjAFyzJQKVGpRO2Nlm6m/NaN8Qq/i7CBE65U3LhuDHsorb5JG++q/kBdE/JaOq1hte8Jg9kDV+3ztpJIiVlrX1fTcrz04Fp8Bsq8rdTy1e7Z0ah0X5acogju4yLraT3crYEZprqiTpP49OIco61lCnbS+Go9dTyLF0XkHzc++cBrM2+ECrwIVVGb3xqDM2Ew/hlI3syR4KX+h/O3Hbb8e7QB2C9WpPiTPVY3Q3orCNkSyycCIDZzwBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2+rGxcAyPpjJ0Ue5uISBE6E/wyc/7VEapqs4LQ4W6w=;
 b=JA1fDPT+0vEneUE/2Joms3C2E2DP1T25SK/OwvALjW5Lezrkyia3913vvDgo01CkR66DS59kWryeRhYeRcr6AADKoTiZ55RbXL1Y39vd8B/rq2/wxyeGNe6PBXd34zyztCO15LJw7pdnrPfopIxYFALDy20uWvufyEvK2cWiDgOCI+1e3ri1nAp5gOIJZ7Ci96Ix77wB66FdbRu0/iN3zSti3hO2sCLncShQvRotEUiTo9ckqp11fciRKbja1GPCbdM4KT2U49yK3CsRV+xaKIiIXoCZ8nFO+52ymRf1Q23SOVpUnPVona5RlCqaY/j9S+DmS8oKnHoEaKZydr4A8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BY5PR12MB3908.namprd12.prod.outlook.com (2603:10b6:a03:1ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 12:57:09 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cb:bf2d:4598:bdfa]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cb:bf2d:4598:bdfa%8]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:57:09 +0000
Message-ID: <b7dafa48-b5b3-9f70-0829-82e5bacedf59@nvidia.com>
Date:   Mon, 27 Jun 2022 15:57:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] linux/dim: Fix divide 0 in RDMA DIM.
Content-Language: en-US
To:     Leon Romanovsky <leonro@nvidia.com>, Tao Liu <thomas.liu@ucloud.cn>
Cc:     linux-rdma@vger.kernel.org, saeedm@nvidia.com, talgi@nvidia.com,
        jgg@nvidia.com, yaminf@nvidia.com
References: <20220627113036.1324-1-thomas.liu@ucloud.cn>
 <Yrmn2x0Q8gon6msb@unreal>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <Yrmn2x0Q8gon6msb@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0451.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d95e792-10f1-483a-cd6c-08da583c8bf0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3908:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6ERK4BGWxVPvIxsb9XcBWpFsp1yv/Y9lQtN17wOecTQp0o3gsL2WcIVJJXVmoLmxvbQgBpjWxGPjyE0i9Gdrbo8uN5xrWXd7T8zZrGTqUSFf3b0+pWSnPOxOzmvRPCy3F0lKbxmwQ2bglHP+CgBkdUnDBJt8QNFbxKaiC9Lmzxt4mVsjnbBIGP8Fp51GLoEZGrB/xbwiHKucZxoMPKUdikMrig3y1YC4nEqMNIrT2KF2h9IMLXHj3QBIy29VCuegfKS4brfv5FXS+A1bo4nIuy0p5wFPqVwqQP1SFHJf3vkJo8luJsDdQgwvNS48H1sv46XL54Dj+jpbvG5C64n2xwE1u0QfcquoqjOANvMmM4jBALlUPbodA4/aIMr4yLzNRLwthKmf6cyHNSp/r5U+iMrfwKKqbpPjeERUmHT7aH2BJU2FMlE9rAsMopBjg263ugDGPvPekAxYwoXv68DtpTBjiUaZGsw1bbGpefJsDR6ZyuVa949RoQhMwFJxBgab9iA8z5PPL+ONDeDl0UXoW8qG1KdZwytCXnRIvSIwGdNOR6fP6KTmkwZnCS0p5ybH+N6RxV28Cx1y8y/b67hsCdGBCNguz1oGw7g5lNFQIAiQL4rVtowoRpiabqWDgwN2bXwYj21UTn3CuopZFNXXsOUrYZJkkTCPY4dBoHXVKpTWrr6dm597aBkFbJyINVftNnRd6yF0hfTMdoHtgy7RzitZhZOoulf4Fz1GYjaYyJF/QdSHGd2LTvIrTaFrcDcCi/BZTYYKgZwfi/LhlLnglkZnEGjrCRU+P5GfYHhApJIVT6mhGIM6y+RYgHondJeL+bNA1iVayCY6eL34Y9ZeH+7OgbB1aKsHYrk+WKU2vBFw+pIutdttKSUyycvn7F1vKdXOfHouDUdjfKejM+Jm0SAnrMIdX05da1rkXyEa4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(2906002)(966005)(478600001)(110136005)(6486002)(6512007)(66946007)(316002)(31696002)(4326008)(53546011)(8676002)(36756003)(26005)(86362001)(41300700001)(2616005)(66476007)(66556008)(38100700002)(5660300002)(8936002)(6666004)(186003)(6506007)(31686004)(83380400001)(107886003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzdLOENNV3E5Q0JmVDl0ZlNJU1ZYQkJ1SjIwUmtqUlU4NmxzSVZ0ZnNhQlFi?=
 =?utf-8?B?NXFwa3RCRjRWVXpCcGpJbS9YNk5yMXA5UXdobFlUbkxyeGVxcENuT1B3RkJK?=
 =?utf-8?B?aDFEY1RuTDVBTFN3NXZEYXU4TEZ2ZEYyVDNKSmR5N3dVVmd3YnkyY1RESnBM?=
 =?utf-8?B?dXJOaUI1alJzZ2RSOEMzYU9CU09UNHdZSDVFTXY4WGhKZjlBbklweG9xekJz?=
 =?utf-8?B?RUk3TEFHbmtIbk1YeGhFU2toY011VGF0aHpZZEFwSG5HZmtZYjQ5ZExvam5M?=
 =?utf-8?B?TnZZaXhsZUJhU2t0ZThoakRNNHRXUElJRUZOOTZJazE3ZCsxcVBWM1Bucnhr?=
 =?utf-8?B?RGpNNjdNNnJ5S2dPQUQrcUg0SUZzUUN0YVZ4UlFKUUdXVXJOMndiQ0dZWHV1?=
 =?utf-8?B?K0lrVE1jeDgxTitSa1FxUGZmeGN2NGIzS0YyQVlWeFk5NjlGQ3BrL1pqRnNq?=
 =?utf-8?B?ZHlOS21qaDEyb0JabG52UUZxSWhobG1zMEswUjN1cGt1YzFicW9qZkhVUHhK?=
 =?utf-8?B?NlROeW93QWtOU0ZQWTd4VTU4T0hFUGNHblBIaStSbXdPQmk4NXpwNmRDK0tp?=
 =?utf-8?B?TmRrV0diTDJ6aldPVUw5Y0FHQTBxOGpJVjQ2RlJaV0lEUEZPaVg2bklTQmZY?=
 =?utf-8?B?UlJoSG04YWxNbnB4c2VOcGorUFNYSk1IUUpRbnRveUxQbGxWUVBVc0lXM0hW?=
 =?utf-8?B?NmhJUDZENjR2cUVjTHhvWEU2MEFZT25ZdFFqdVFYMlJkTkJVQ3o1Snk2bkIz?=
 =?utf-8?B?TmYvLzQvUlpybTI4cUZnaGxrQUpBL0JDa1JyS21MaEdRWGhDS0V3NzBBVUt5?=
 =?utf-8?B?TXgxR3FyMm9JcElOWlpZY0hFME5DYVlEWTdwczdNQm12dGlSdmdUZHoyU1Ba?=
 =?utf-8?B?Mi9Nc202UCswdS93NUNMK01xdXFrR1BTb3B2WTFVYXg2UXpNcXY3bEJQY25O?=
 =?utf-8?B?WFJaQjk0dFdnTmZrY28xb0xBZmZxSnp2Z05pMDVpTEdkL21ERXViMkFZeVBx?=
 =?utf-8?B?eFpVTUJMaDRyaHZyVktKajQrT0o3ekh4NGFPdjUvcFYwZmVuano3OWZyVFZy?=
 =?utf-8?B?THhUTlNvVUdqV3YwK09JZFY2M0JHOWpNTVNyQkQzdTY3Y2o2bER2dys2Tnlv?=
 =?utf-8?B?SUVLUkhoOWM5YVBTT2wzdFVUdTZGYkRlK1VlelZJeThrZno2Q25EUzVDMHNB?=
 =?utf-8?B?Uyt3ZW5ZV0hScXRUZ1ZxUkZrSzdHUEdmNE5MUEljS3IybUpVZUROVzJacDZw?=
 =?utf-8?B?Z2t0MlhuQndUYlpGeHIzUVcyQ1pObWVFZFFZMWVTamFmcmFPc21OL3RpTTRZ?=
 =?utf-8?B?N3hXYjdWM0dOeDF6S1ZTOGZtMHcrTUJEUTdCeFVRMFNNcUphTUorR29OZE9w?=
 =?utf-8?B?dkJmQmdRaFRrNFpEbHVnZzNwNFJOY0pDR1dmcGRlMit6bm50YWE3UkNGQlZL?=
 =?utf-8?B?OTd1aitHOXhrOFlIYTh6S05zR09adFcvcjJxQmMreXMyY0s2VGsySG9GenRB?=
 =?utf-8?B?dEJCYkV1TnZrQTFqcWFxdllHVXBocWMxUC90dlVoWENSY1FscjhXVkluSUxL?=
 =?utf-8?B?eG4xTUw3QnZoM3htMXE3OXJtcU80T28vVGQ4UWdpekVQdlpQZlJwTHJYc3VR?=
 =?utf-8?B?Y0F1UEJuVnlzVW51dFBTTFF1aHhKMit5T3dBcWxFVVFvQkpZT3U5ZDZxZExG?=
 =?utf-8?B?ZE9lTitDelhXeUlxYWlQeDNWR0xYZkdNZkJVQ2JpR0tsNW5obDJHY1dvQStW?=
 =?utf-8?B?aHNkd1k2SWFUT3J4QUNCbU5xQ0Q1QmVqZkxVSDRhK1lpTGZTTW5jdldzWTB1?=
 =?utf-8?B?d2NIM21jYkV5V1VVOVlDVWVsdmZyZU1aWitINzZWTWhRZThZVmRaZjhkTWNu?=
 =?utf-8?B?QnJtclVja1A3aW5oUUMvcU9Ld3Q2QzVwR2o5ZkxHSmtReG5DWEd6aHpFN0Ji?=
 =?utf-8?B?WWk0TmpYR0xHQzFoMmE3TDRWMkV6dVEzeXlkMXlBZXJxMjB4dXV6Z0VFU21N?=
 =?utf-8?B?Z1I3RlRLbEUyZVFUb21QUjFjQSt6OWZrS1NPdGRBdlpvV0xzanhiL1pMWnVa?=
 =?utf-8?B?cUQ0bGRPVHFIVHJGKzZ2aWdHcGNUOG81bU1Qeko4cDBYdm56RVRnc3RuU2lE?=
 =?utf-8?Q?XUhCS42/U1XaxqH4sxBquY/G4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d95e792-10f1-483a-cd6c-08da583c8bf0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 12:57:09.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xrmyiTgILM16xvR2/gAGiWoDy6UmKrFsUrpHpZ04tmjRLCXBoptzj/MSyhbkOnOutIIiX4timIUrJacoyLBWIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3908
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/27/2022 3:51 PM, Leon Romanovsky wrote:
> On Mon, Jun 27, 2022 at 07:30:36PM +0800, Tao Liu wrote:
>> We hit a divide 0 error in ofed 5.1.2.3.7.1. It is caused in
>> rdma_dim_stats_compare() when prev->cpe_ratio == 0.
>>
>> dim.c and rdma_dim.c in ofed share same code with upstream.
>> We check the 0 case in IS_SIGNIFICANT_DIFF(), and do not change
>> decision order.
>>
>> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
>> ---
>>   include/linux/dim.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> I liked the commit message from v1 more.

I think you need to do a combination of the commit msg (remove the ofed 
notion):

"fix a divide 0 error in rdma_dim_stats_compare() when prev->cpe_ratio == 0.

CallTrace:

....

Fixes(...)"


Otherwise,

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


> It had proper kernel panic dump together with Fixes line.
> https://lore.kernel.org/all/20220623085858.42945-1-thomas.liu@ucloud.cn
>
> The change itself is ok.
>
> Thanks,
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
