Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF4C4DB58E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiCPQDz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Mar 2022 12:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiCPQDy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Mar 2022 12:03:54 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701D3DDFD
        for <linux-rdma@vger.kernel.org>; Wed, 16 Mar 2022 09:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlZqrCS4w0MMySKlbzrqL1pEurBE6+evIoxLaVh9RSrPBjd+kYIitdPT2XRiKzsecgkOFrxyP4a1qzqdSG0eFbR2kUNOFWhEleEAqZyJ5/0hFkBzXZo/wZqggpb0jL18phX0uny1phbH4Un4rdPjmYBfdAjjpfpNPSY0/TDWzRnzfNqz6d/SXjAyunEquWGdULRqcI5C/M0m7s8ZzVIcToVnmKqUbpQfDE3PhV07hHC1j11mz5/JBeNJE40GT5/EBYwvfpRN0ukSoVEVLWj3lKlyMK91u+eBA8mx9Kq5mESL8U0lSf7800aP0taR5Gf3Lqtu+3fxyifmXs/k/j5JCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiJq4I2iUpNJsdUZKS3NkhJMocFedO2unAGmaC75pOE=;
 b=bX6SN6MBdr6wjp5nXvffRX/VyFjtS6tDC14uSaMaYXX6Lf1A9/i09WYKRBzYdsZ3QIgKEsW0sCDZNwS9HHPrznupo+ywnyMOB6E/KZUJGkTxBylycv7sLPLPuuwkUlgWUb2rLNrtaJ0D8TXW8IVqoY27X9eklgUTVS0EcFaScoMSwQlDjrBSV8M5a+AKcmjTHnkoip5ntRbVp8eO5bi3e6ykCno7BzUBRQ2Yctw+3qjBBt+8ArTsL5t29BlxCoNdUE9/WN5yB03wZNmezHUQuxEs8N9WNzPR84h7Tl4oSWJPOzfUBE9Ei6dDx3Ua/9TbWdQTgYkcVnLm1UMENjz5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiJq4I2iUpNJsdUZKS3NkhJMocFedO2unAGmaC75pOE=;
 b=H9zy7ivcE9Q5m9bbMV3+HFWiEj266IpXQRQvYQW7ZsP5vNhVmWEowZLePRCywotQC9Z0WA0Gpi+BtLkzvyUCW/M+hIfvHgSRNfflGFdxXybwHmO8rEx/l3xALYzadrx4wqNEw1R3FY//ZsrXxRRKy6Vu2J8cFPlVSqIStbF5iAF0i/a4y9b2uJq7oo9MvBfmEbl9WxawvF2XmthTBhLuUb3Nw2Kil0wyRRDJSU891NlSg5yAZg0VZInQcpZdPPD8oMWy1IJ1DP16pdTAta7bzWqcZ4tkMqDcyaHhwXMhOfteZSFPVJaPjjdpFBJuM+CZTQgOzAyKKTriXJLBa+ZvpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 16:02:37 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%7]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 16:02:37 +0000
Message-ID: <61e7094d-e645-f6d4-d267-3f0b86404879@nvidia.com>
Date:   Wed, 16 Mar 2022 18:02:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 4/4] IB/iser: fix error flow in case of registration
 failure
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Cc:     oren@nvidia.com, sergeygo@nvidia.com, israelr@nvidia.com,
        leonro@nvidia.com
References: <20220308145546.8372-1-mgurtovoy@nvidia.com>
 <20220308145546.8372-5-mgurtovoy@nvidia.com>
 <f3e1200b-1375-0a5e-7b56-3c1565576cf5@grimberg.me>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <f3e1200b-1375-0a5e-7b56-3c1565576cf5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::48) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b48ca9a5-730b-41a7-ee26-08da07666418
X-MS-TrafficTypeDiagnostic: BL0PR12MB2401:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2401D23E086B82B216FE6B24DE119@BL0PR12MB2401.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C40q654ANiafU3Ip9+JMOQIsvGZRZ+65nZyuFBw/P6Z+YcvAkRI4hJ4OQ3LpKLnEYjbFVLp12F0HM1ZxkxarkcfvhXChjkfhvz4RiZ/LPaNZ0Buo79s4DSOgNKSxKL5vWVmZwC3u58D/wa2jO7TpWm3IQ4JCcKvZfBWWCw3dv2hGdsmm2HJ/RntlAPz8vpFZavujGL2u9c0XGJxN7nGcERexyrOyA7S+Uxq97bqqbM8L5Eafijbj6XwQAChKrMX2Am6nCD5tm5GqXi4C0dJKjBZXNiI7B/Xtud9swJ1lddFTHio1w67CKYSYFdJ3IuH/RtdAKmZ1uWSPUO+6vM9gilJHWGfR2UwE5vyZIRHfTm9PxOaWRNdWVFPzZcyWc+kETc9qd4tWEGLHN+idtSLMY+EmpUZzaplhwdP5wbD1UJJUlDIyYufvhyRyJhZck2QCEDPNfSgXDswemRzG2qxU/5gxBuR27812zRPEOESrKb5/duQr2H707NHzvvtAVc+26xskx0++MQN20AMUs3iZyP/rjUktNZHev7CUVgPNcTbG6U8+tEALMUaLCVHtMu1enP/vmSUFmAabiUC0oRIfLF/RApA2KPU9JxVndE73N1Zxm+NVAkelYzzInUhj144hVhR9nhes6szNYaBacELadBDtdzEfYD6hn0FWkGqWMG7EMHvfotKGTRRpD2gdiAsqn/tGIx65sfAxvpaA42SO1KbCwbBlWpP5nJKtmF/kuLtV63TP+pN+PFJjRW0jMEJj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6506007)(53546011)(31696002)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(6636002)(38100700002)(6512007)(316002)(186003)(26005)(2906002)(4744005)(6486002)(508600001)(2616005)(8936002)(31686004)(36756003)(5660300002)(6666004)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThNalRnS2taQVYrb2U4ZEo4WFFZRzdUeHpJdEVsdEU2K2wyUkFpQ25YU25l?=
 =?utf-8?B?N0JlRFpWLzNNdlRsNTZ4R3lVcWJ2eXRObU9pYVc4TzZzU2ViKzN3ZC9GUXkr?=
 =?utf-8?B?WlFsUDhQWWtWUCtGblUzMHBLQkh2QzhOclMwOUtFTG9TWHBsU0N6V0dMTC9M?=
 =?utf-8?B?S3NtMlY0UE5YK1hJY3hFVlErUERGcU1jVDk4OGdqQmdIUkx6WjVNY3ZINkZp?=
 =?utf-8?B?SlhKQjA2Y0NsTm13V0twVjc1RWc4UUhXUU9DY0VPbFR2dkg0ZmtacjRZOEZZ?=
 =?utf-8?B?SGpmYnhEZ3NWMmI4TXJyalZHcjQwZGN2VzgxVklYTlpXUmI1VC9xdlJFLzVj?=
 =?utf-8?B?SDhjenAxRk12L1Rma0lMaDF4bUdKak1WTmVuaFRTL3I0OFd4akFoOFh3SVNN?=
 =?utf-8?B?ajlHUXdwSU03V2tQVSs2SVdJUjNJb1FvaGMyWXkrL2NZTzB4SXpBeVBYT1lp?=
 =?utf-8?B?T0MwS2c2ZWpvamd1ZkhUZlM0ME9paUV0c3BYRThzNURTeUtGZ2toR1VWQS96?=
 =?utf-8?B?c3hQTURONURQWmIyVGdRU1ZSMmhKYUE1dCsydmtRNVlQc0tvM29odXdEYk5W?=
 =?utf-8?B?ODRrWmMxM2Z5bnI2R0t4V2o1d3BNQWhqNlRWL0t2a1VidU9tc3I5ajJsSFZu?=
 =?utf-8?B?L3o0RnBvQmRQcmlIcllVdzlOeExxUkZ0a1ZFZHlUcmFNekZaRVlLVDdkc2VD?=
 =?utf-8?B?QzJtRWtVY2JjalFXaXRBdWFyYUo5Zm5BY2l4UmpEaG5EZys3S3RnVENVWnNI?=
 =?utf-8?B?WUN5cEtwVE5CUWZPQVNPKzJzQ0wxanFaNWNielZybGhFY2lVaWNQbm1hYUU5?=
 =?utf-8?B?WnVMakd3Qi85WGMvQ3FNdWcwYjdwRHJzTnRKUFdzbVpmWTUvZERKMVVmMWpF?=
 =?utf-8?B?UkxYT21XMDZ1QU5JMEUwNVZuVzZUNWk1elYxRGI5SXJ5RlM0QjdIMXZwckJ1?=
 =?utf-8?B?SFBaeHd1d0tSNWd1cDRwZTl4Ly9ER0dDMGM4bEphWWdGdCtya0V5STQ4TkVv?=
 =?utf-8?B?VFBBYnNaNzZQZ3NMMXVYUXJwaEU3eEdndHBjUVBRdjRFdmJIU21hTE5GaTg1?=
 =?utf-8?B?aWs3cG82UE45Z01EOXpac1prNmtiTkZOUjQ2NE9XdC8yOWNvYVhTSjk3RTEx?=
 =?utf-8?B?MS9ScTVjWkttSEY5bUYzY21JSE5OUWJFdzRzNFhjR01NeisyemxqemVHQVVm?=
 =?utf-8?B?OE8wV0V3K01jUDhnMzJtNGVCVDJyUFVpR1BNOW9Jc0p6MXFTQ2l1NDRxWDJW?=
 =?utf-8?B?KzNIOGVjalE1Qm9kd1dzSUdtc1l5Y1RYQ3VQQUhGMCtUTTV2TnlEWnFoRk5r?=
 =?utf-8?B?SERLbUR0eENEYlJiaExBYklBc3U5TFZRNkxGdnNSSUZGUTB2OFp2MVlKTW9t?=
 =?utf-8?B?RVZOYTdwOVh4VFd4MlNSNmNQMDBXSjJrb01yVDZjdFFOM0plWXlseTZ5Y0dD?=
 =?utf-8?B?VFF0U0tDc2U4MElnekl1M2k2S2QxMkcwNHhlc3pQZi83NCtFL2dWSEJXanhq?=
 =?utf-8?B?UHBLMExVaEpUY2VzTWpGREYxUEFzTUZPeXdMTExHdnpCM2Ird082RGhJRWNL?=
 =?utf-8?B?NlN4L25STFhnenh3QWF2dTBRWUxRRHJ4a0hKejkvSUd1MVdhVlFYQ1J1VnJD?=
 =?utf-8?B?Tk1oSUJ2alZ2SEpObDM2UEJiN05uK0hnWWthZGhqVFpSSms0YVJrMnB2VlBt?=
 =?utf-8?B?OXdpN0RBODJHbDBKSGVWT0ZGSlR6cWhnR1J4Zm4rRzdjWE4xUlhKMElOODhH?=
 =?utf-8?B?TE5iVlRLRTFUVEFuUk1vWiswSzdYSld6UEVsWUFKek0rTlRhbjlDRTQ4ZUdy?=
 =?utf-8?B?Ny9IY3BEamtQdlV3Kzc4a0cxN3I3Z3R0bDQ4WmxDTDhkMTg3Tk1DcjBSakF1?=
 =?utf-8?B?T3ZNM0xhTEF2NnlXeFVXVlVncVRNNEVveVYrYVJLcVNIOHQ5eVpaOTlSVnUv?=
 =?utf-8?B?UERTL2Q3Y3IyQ2ZtNkNoTDhpNlVWS1dLTFVHdVlZNFN0VVpBalczWitkNllV?=
 =?utf-8?B?V3BuRHVwWGR3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ca9a5-730b-41a7-ee26-08da07666418
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 16:02:37.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3yebHhi0ssCYSJm1f6WH0WzBwjftggVUJTXYpLkXziHdO+mdmLfN5I81tHBZErEPnlNsmUeoN6jws357BkNjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2401
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/16/2022 5:14 PM, Sagi Grimberg wrote:
>
>> During READ/WRITE preparation, in case of failure in memory registration
>> using iser_reg_mem_fastreg we must unmap previously mapped iser task.
>>
>> Reviewed-by: Sergey Gorenko <sergeygo@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> Looks good,
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
>
> Doesn't this need a fixes tag?

I'm not sure.

I see this issue from iSER in 2006 (commit e85b24b5e7de9 - IB/iser: iSER 
initiator iSCSI PDU and TX/RX).


