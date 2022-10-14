Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE565FE60D
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Oct 2022 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJNAFh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 20:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJNAFg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 20:05:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB62BAE200
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 17:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyGLwwaKUd7DxwovLuRWOrEt/YErRRY9ygCdDvBVZWMpSIxi8gNx9sep82691CkP1H5YYQSVPSUtUp0IwG7L2IbLMVHwkDRUVCGZCT++mGlx3qbm3EphDuH3xJtSxdXFKu6S1n8ppTbPpcnTXEozaQ5xNmKwPst6o8xy/9YHzuiR1UpkLpIV07hK8dKOmdyPZGyJFsmuO7DPnedm5KSkIhJ1ObKo4xti4voIa5McvkRnAjtb6BbhAfctPHnZonJqdl00vy7La+yyFORkIQzuqkmpkm5KD5iLEnTqJTQZjBD8pXT+1npZy4oWYVfcsi8ergDWa4sx1EJIla+n5zDj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8O4rWRZG12T54PDc2skUMzO8x/daJoNb/UI4cNnTkA=;
 b=kH0hUUvkTFzetFVfFRxN3zxr6vWUVsBxaUnZUqa5bYmZcqrWILnxJo2W2vcY+T92hVO7vOruZlFHixZxAJAGo0pJp8UcpRxQY0eSRkrHzYQglhuRIzP0Wx5KbBszTOy6puEegvRkXcbwHNtGaoMEvcw5VT5rmQVBqXGVuFtmENkfC9VGei8gy9px+UtaFw4QWeGPbr38GpkZK8dkhdpfvWc2HCwraEHHMSyeRq14Y0dKyly3mLHFmaSaKUW7WqCTnZ/n8PLOUZNTYYMjXACr+wX9xIas8Yy7p8zfp64O5kt5yX95nZg/iezfjIVhMhLYDVYrGVhTNGg9asdEP5hOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8O4rWRZG12T54PDc2skUMzO8x/daJoNb/UI4cNnTkA=;
 b=aIB1n7b27bliE+cdju//5jkD8eBJLsnmYevM/wtUcHCIVPT64/bb9ow/0+7Bx9GmufewL2+MXE7RWpwl3WJRRsTmqTRaBx0Ho+WmDgBaFUktFNlfsiFBDCpW9AvLPtPJZLuRPE6OTp6ffOGcQXFh26uBuxZM4v4LW9yP6RAA9eGG2hLf/rhwtAF2v9Upkk1sYO/Jgvjeovu8/SEU4Uj4G9TCZaEk/FlCdL86pMT1Xp1GwMMjMHFi6uYUbyZIvoerI41Dn24FoHpR3Fwvsk4a/4sAdF1CRFziBWFchHnUIOH/DhDrT832AUfweXsKmKyS15SzaR4oZKCY21AZ+qetGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB6789.namprd12.prod.outlook.com (2603:10b6:806:26b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 00:05:33 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%5]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 00:05:33 +0000
Message-ID: <1bd4d4f6-fe33-7fe5-f662-cdef61acf800@nvidia.com>
Date:   Fri, 14 Oct 2022 03:05:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
 <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
 <f7254cc2-88e0-e91f-e4f1-788c5889fcf1@huawei.com>
 <fbee7c67-fd7b-12c8-5685-066b1974aadb@grimberg.me>
 <550d4612-0041-3d84-b1cb-786d0c8e0d11@huawei.com>
 <3030fbb2-5c63-54ea-5be3-b88cf63c6b75@grimberg.me>
 <c86a6cea-09b5-c04c-aa7b-adc6a457acf6@huawei.com>
 <328a807f-bfaf-b279-69c5-09be179891ac@huawei.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <328a807f-bfaf-b279-69c5-09be179891ac@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 5854f90f-b1dd-4372-c9e6-08daad77d00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBmjjuLBArG1/2QEjq8CCdgS3V7fpR0mHQWwddmiknOltueujZtI/C5kN5nTS+M9iwZPANY2op9RCiMbwyMuuT1Fr4VZND76vC8ZbOkhtLfpB2ogfi89HanrqRH1EwA8UFB9rXXnQPB9Gao1s5bVlfFGKIiAwE/5dUPb4AMtzFXYG/Ns7U0Y8AMvvDH4YI/8nd/g3gxiw80QWLvHnVe77AjxXF0LLFrg1bY2TrGHeAPTs1hrCpogFwGYdjPujAku+JEIcTDlWZfF5Eg98EDD8bLi75d93YgNYxtYWJudGDr4YyU5xPZgfXxsVn+tYK26ASCkzumgRxKspwiJlwFTfSghY1u1V/0hgmxP3jzLfpqWy8C7XO8Gg1m1pIGQe6yDMhnX5yae8fsd/cM8uh93qGrxdoAyg2u0fHclAeMsmXb6COJYWv0M6AAiVuYKVonBH76FXgHtbbFuyHOo0P76wwilYNaOl4+vQpRTjgxcCAbrIsecjsRfJpLu859CLfbuDd/amwxOv1E+WoB8KKGDh5sVQ68Hab8NQmb3mkbjGjYyDL5JkJrusVAZZDsF+PsCqtTwqS/oTKweIpQzaDBBVO8kcKLN7kNMyuJHpdht60x4upXhV7RspaaMkqSn05X3pFJfTwEl+xDqjqlA7UrAyeZHUdlA81blFWDUs+8DxvNtPUbTpAgZdFAuv6GD8h27e6C8NqrMVfL/H0/b7L4vW2tLbw5dVxGgA9gn9j2lnWDDW27ZzRY/Bb00TECgCTb1k9sLjyPokVkb34QS10MUV337JG6p2b2vb1Vg5gI//mk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199015)(31686004)(6486002)(478600001)(83380400001)(110136005)(8676002)(66556008)(316002)(4326008)(66476007)(86362001)(66946007)(6666004)(41300700001)(53546011)(31696002)(6506007)(26005)(6512007)(8936002)(5660300002)(36756003)(38100700002)(186003)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZTUEVRZUtwRHBBcThPd1Y2bU1nMy9EemdINktoV2tCNDQzSEg1cG1DdExE?=
 =?utf-8?B?SlMrTmFsR3RWTytLUjFVV1J1MmNoTmhvWVVZVlRSdmpyNlRVMTFXWFVRRHdQ?=
 =?utf-8?B?eTQ2cVNxQiticVZ5UGphdGxuUVIvMFFOSWxKKytRSzRSd3BHdWlYNXZZdDJL?=
 =?utf-8?B?cnpNTXBjS2RUaVY2MkJNeFQvRW9OWkwzV2RLODYzN0xyV1NtcWJUcFEvbjNV?=
 =?utf-8?B?dElsRndBSXdBMk5YbEczNzFmQnU2MzA3RGNqTmFTY1o5am9vZExENnYrQTBk?=
 =?utf-8?B?T1Uwand0KzhFRUhGUHBZcHNHbHpNVzZvLzBlNTg0RmJIS3RsK1V5aXEvQmpR?=
 =?utf-8?B?L25DSC9PUHJENDZ1eDIxZHBIVDk3VTJFSjNjSzhQckFoRXlaU1ZLazQ5LzY0?=
 =?utf-8?B?S3NEVm1JSG5uYXJXZ3lOdW11ODRaSWZxVmpRU1JjYU9zWnJmR0ZJbjlndjBu?=
 =?utf-8?B?NWRFREJWK3ZtTCtsT3NiblF2enU2b1pFa2FydzljMWx4TW14UG9wNDEwRmJP?=
 =?utf-8?B?RlJrM25CcFFJK2VkS0lUdmQ0NUV1MXNZYjBlQTcwWmM3U1E1STZ4N09tV1Jm?=
 =?utf-8?B?cVpXMzFKdHdTNW1velRyRmdpbDQyTDdtZ2dvam4yWGRHdXh0cWdHK3pYNGdD?=
 =?utf-8?B?UW1Sem5IRDFCNjF4VkZkbGovSjBOQ0F0eFZaR3BWMXpSaU5naTlvN29QRzlC?=
 =?utf-8?B?MHRsMjU1Q3pQVmtMQTUvNzZlbG1DejdsN0FvN1ZrdWwyRU4vWjR5TXpvUE0w?=
 =?utf-8?B?WndXNHVhUWV3cVRHQ0ZSVDJvNHpHNUpBdm5ZWFZHbFBYVXlrTjQ5Q3l2YitZ?=
 =?utf-8?B?NFIrY3V5TnNYRFRleGlyNDVjSW1WMVBqMFluOUZJYmM3THRKOUtDYlk2TWps?=
 =?utf-8?B?MlhXZ3JtR2xCQUVyVSsxL0RmUW9HSEhjLzlTMzdLWVlKMEpyNEtMRHJEWXlJ?=
 =?utf-8?B?WjJvWmNvdFJZNUtBWi8rM291YlVIbGYvTmhLd290TFBNWFF3UW5EOFhaQTdq?=
 =?utf-8?B?YTc3SkF6bGtaWHl3V3phb0pMNjBHSEpFRlJmSGk2NTFXVHk2YjMzS1ZiU3lF?=
 =?utf-8?B?emRzRDMxQ2xaUVIvRTFGN3NUclVUa3RRSlNWVEFUOEI4MEhSWEM5UFFZeVRr?=
 =?utf-8?B?NTV3bm5pR1ZlVFZNMDhZY1h6WE1aMVY2aUd5YVBCRHYwSmlPbTNoMmlkMyth?=
 =?utf-8?B?bEtMYTFvNW90MmFWUmpOdE5LU0tGODBhbVNOVHJlampEaFpHSnhwdERsWGUr?=
 =?utf-8?B?ajVxNnc1bW9VVnk5OXdTTFhmblZOMk1hbG5GTU10c1g4MjlrTWplRGIvSU9W?=
 =?utf-8?B?ZkxZWDU5ZU5QSmxXZW9LKzBkM3JPUDdyVmNTYzQ3S0ViNmFaN0pmRmIvcERF?=
 =?utf-8?B?LzRiUFlHbjkyZXRubWIranp2T0FjcnpvZFpaemxnSEdHdXdmSXNEbDFFZDdK?=
 =?utf-8?B?Rkt3WXYwUGxiNmJSdXBaaWNQbU1na0V2WmsyQi9mdTNPRWtvdVhML0NyL3JG?=
 =?utf-8?B?NUQ5WWFERmQxVVdpalBTODlSUzlvaDZzZmJSa1FCQ08vQXh6bFQ0dTdtTjlv?=
 =?utf-8?B?VCt1KzF0L2xzVGlPa0tvM05kNHdHRXZWTm5HMXZnUjNiSWlOWHI5cnc5dXVU?=
 =?utf-8?B?UmNVYkN2UVVJc0c4MHNrS1B6VUdUTEV1TmRSVUV3bVNFS1VtOHhLd21rSmhx?=
 =?utf-8?B?YjhSUm1pQzBtVklNT3NpbWFJbEkxdlY4OGRzWTlKSG5xSFZkL3NOOTNHVWVF?=
 =?utf-8?B?N2taMTlwR2EwOEU1OVZiWDY0ZmxtSmcrdkh2RmJtMUI5Q05sWUs1YWlVeEVm?=
 =?utf-8?B?aFJIZE8yTXlnTW5BeXdhRDdMSGVaOTNyamh0WklBTGVSdUhDMGx1VGhNUjNy?=
 =?utf-8?B?UE01b2c5ajA0b0oyU3hvK0JvUDYwNithc1N0S0oyUStQdmdEZkN5ZDZtWlcx?=
 =?utf-8?B?YkpNSGE2RVprKzdWOFpNTC9RU2ZRTnA1ZDZtRVk5TDZGcVpSdmFEckl4ZDZ1?=
 =?utf-8?B?aFY0ck1IekZMM0hSSWdFVm1tVzE4QkFiTThabjdYS01GVlJmTHZlOVVhclZ6?=
 =?utf-8?B?NmtSdzZRUVRvOEwzLzdMSUlRMm1zb0NXNk83emhLaFcwcVdhSnRnZW1jWmdo?=
 =?utf-8?B?djlwbEZnaTUzcWU4by9FcmVLR3Z0Z3hTeFh4U3JDL3NMUmtoTVJLcXVWMHVB?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5854f90f-b1dd-4372-c9e6-08daad77d00b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 00:05:33.1524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LX2+p7ai49kYwBqaiLo/Mt1p4A/UDYdiNdpP+D0Mnlhnf3+aLNPHeCPoZQQm6sgvjpXrYQacztwbAmayOp3ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6789
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry for late response, we have holiday's in my country.

I still can't understand how this patch fixes your problem if you use 
ConnectX-5 since we use adaptive re-transmission by default and it's 
faster than 256msec to re-transmit.

Did you disable it ?

I'll try to re-spin it internally again.

On 10/10/2022 12:12 PM, Chao Leng wrote:
> Hi, Max
>     Can you give some comment? Thank you.
>
> On 2022/8/29 21:15, Chao Leng wrote:
>>
>>
>> On 2022/8/29 17:06, Sagi Grimberg wrote:
>>>
>>>>>>> If so, which devices did you use ?
>>>>>> The host HBA is Mellanox Technologies MT27800 Family [ConnectX-5];
>>>>>> The switch and storage are huawei equipments.
>>>>>> In principle, switches and storage devices from other vendors
>>>>>> have the same problem.
>>>>>> If you think it is necessary, we can test the other vendor switchs
>>>>>> and linux target.
>>>>>
>>>>> Why is the 2s default chosen, what is the downside for a 250ms 
>>>>> seconds ack timeout? and why is nvme-rdma different than all other 
>>>>> kernel rdma
>>>> The downside is redundant retransmit if the packets delay more than
>>>> 250ms in the networks and finally reaches the receiver.
>>>> Only in extreme scenarios, the packet delay may exceed 250 ms.
>>>
>>> Sounds like the default needs to be changed if it only addresses the
>>> extreme scenarios...
>>>
>>>>> consumers that it needs to set this explicitly?
>>>> The real-time transaction services are sensitive to the delay.
>>>> nvme-rdma will be used in real-time transactions.
>>>> The real-time transaction services do not allow that the packets
>>>> delay more than 250ms in the networks.
>>>> So we need to set the ack timeout to 262ms.
>>>
>>> While I don't disagree with the change itself, I do disagree why this
>>> needs to be driven by nvme-rdma locally. If all kernel rdma consumers
>>> need this (and if not, I'd like to understand why), this needs to be 
>>> set in the rdma core.Changing the default set in the rdma core is 
>>> another option.
>> But it will affect all application based on RDMA.
>> Max, what do you think? Thank you.
>>> .
>>
>> .
