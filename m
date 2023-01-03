Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4265BD58
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 10:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjACJoB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 04:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjACJoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 04:44:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B5E0D9
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 01:43:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxgdDjQ0N4n7Dl6jnO8t2bgdN7V6xrtO7JF+c8OQjQnw35XhWWutvuiP9QT9MkXjMxM5IfkTc34kOh2M6Bh/To1UCi4Eod3BtZmz/ifEi5vvm81Lm4CflOOeBBLDmjHVfk+bEicEUxthyPhlvRDBVI2QfpaaUi94g4eQ1uLXcf/I/1LZyRCe+e+2c1NpNbfWvCuq6uMu48Xjr8hD5STCcXTi7RiZEzKLGblT7SCP7CJaIxsXgxfxJc/KnjjtncEMKq8L2vsn1N/yjuEXaG77A4LpTRC8FudhwpgSNKtx9y+9wHd/XFPZOJdJVPNm3383i6o15XvILFINEKOvP1OXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5Jymn/pxcLMnBNAzG2v0b9QBAYD0xND1oSQYGFGZsE=;
 b=BrbWKlwFu1Ktgvp1fpuYWHewmlcMrSX/ydmjRwrzVtpq0Yg7AbS9SAtnrNA4xO+1kyZbU+e0BWvICCdatxCTlVxoi0gmm1W1FwV7CZntgm1fDytGAq2WlzdQgnWULYZWrqei2zpD/AMRbcYGNXgWw1shXhVLtwHZmH8PSClmKdwpR16potXeqAY3W6umE2cizQgC9GeKPZ4ttzzy6bofW9k+NZrs6n5cUvSs/Sl7ix2ZLSfVq9pwHNR0t00bk9PnpnEmlR93nlXa+75pqG7xWOQX6M9Xd5aiN5dIx+Huyn0tpqVpsl4cYDc2hZKasJ0PyLB2JOYa65UV8luXZ6CBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5Jymn/pxcLMnBNAzG2v0b9QBAYD0xND1oSQYGFGZsE=;
 b=hI2cMxn8wtteN79edrIzsy0MPSvU3xybDv0H7svB3dyi0ygnBe21j1bJki5BBxedlRtxjJaNiUsnuhwFhuAtKgKGrZwn9MaXbHHysGMQdB6OhMjJl3maLSCc5qkCIUBDsfeFO8oVquhRMdQbIkOz91NRz24RwohA8e5cj/vBvZr0XCMdTfY2Gdw0kwrjy+fFFXCXDocfmAROo32pvsTAe7hCX5UZqg7A3yOK6lzboT8WozV56ZroMEZie/iPHEG5Ihq4v4eo/IJzAvnIyKcgHXAZsqL1PGKtqfGuGokG5D+QPBFmAkQC9cmQ8O1Xc9wwtZ48LBHIX4QxAzgFxYivig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Tue, 3 Jan 2023 09:43:55 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::d01c:4567:fb90:72b9]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::d01c:4567:fb90:72b9%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:43:54 +0000
Message-ID: <6b469bea-2b6a-6506-aaad-581bfee42670@nvidia.com>
Date:   Tue, 3 Jan 2023 11:43:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-rc] RDMA: Fix ib block iterator counter overflow
To:     Yonatan Nachum <ynachum@amazon.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     mrgolin@amazon.com
References: <20230102160317.89851-1-ynachum@amazon.com>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230102160317.89851-1-ynachum@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0019.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::11) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|PH0PR12MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ef4fcc-ae88-475e-2437-08daed6f0759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2kjjqzH2a6JJ8mA1RC8Zlc59/e8rZn2R/i3FMEGZwcjZyUh+Lhv/jcnOLClFaVpP49FHwIMPBFmOGWQI25lK9eb67MSx3ndhgPurrclbOmQQ5lvbWCJLAyuRHB2VApZXyZdR8LRJKGwYTd9dox+lv8viOX3QkcBYyoJ62dK7uKpteP3zd1CE9KnztO5BLoVIdmEkS8kP/goJDKqjv7hLP9kjSyQU1gc6dhXKjCwtUri17Cw4clyv1a5Y7rxeTHgR0WUmglo6Yesx/OmMMJunBPzJJVe0Kwu0MkDKTiZBMREU8BGZO+4DkoGERcekZajkuq2bBsBAKQ8VARMl1edR7M7WxryMxaJkylg95tAJZ/PMs0nvT2l3dHSxeM9qN3QQAyx7CtaQY1uq8KOMKvPsr0vlsbkRXAMz9jis3d6IHeJiCoK0uzgul3znPCgbfQEWiYCjiCMZxwtvYw8vcNfo0vyut5lvjvaikt8U73Rx9eRuHvjJ+ZlOej5D95iBGFDErdOcXgkOAxrCDFI9adYjs7GP61XOpR0aTh+A1VC4yucWOVI3VNNqHxJkwefB4jAhJwmB52DPqSkfyxwoyjU+q/i4I8Q6ErTMx8groIYnjmRGE41aXS29us0DnC7+eru8aR2imImA8J+JwMR9AhSkGcZJaLD1IptXZQXNy5YScwdRIIc7o3UwbND8HZH/AdfCwOQCKm3ucmApVy+11iknq8ncoDucoj/cT56Co0CY3H37mVBFP8rEYZMhy9aqvh5Gyo41oH/WnttoG3noDM37t3KgxySnodqmXfOUlGP+JeOQz8Bp02TlVq97+18J89zEkI59p0GNexK7JQjtZZtAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199015)(83380400001)(31696002)(86362001)(38100700002)(5660300002)(8936002)(41300700001)(2906002)(478600001)(6666004)(6506007)(26005)(2616005)(53546011)(186003)(316002)(4326008)(6512007)(8676002)(66476007)(66556008)(6486002)(966005)(66946007)(31686004)(36756003)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnMxMmVZQUJyK1F2VjhCa3J3ZEY0aWF5WkxUdk1PSDNRNFJnWFduR1FUam5C?=
 =?utf-8?B?aE9pVEwzZHMxME9VZ3BtNXg0dGNhL2N1bEMzUjVMYndvMzBSSXowYk9tVGJ1?=
 =?utf-8?B?OGlLSmhtTzdvdnRWd2pxRmRadVU5eTV3K1ZrN2JKQWxkNXpXRVBoUkkwMEpE?=
 =?utf-8?B?SGhDRHVsK29BMkdiZGphZnpoWG5meTJTWVhta2FaU3lQNi9zNWdZaXd4dGNE?=
 =?utf-8?B?OWlLQVV6M0lNdmhrMWZ5RE9WSVJTVXJTUEJ0aWVhMnJQaDVUZ3RkbUpQYWJo?=
 =?utf-8?B?RE1IcktXL2hZanR6RXB0Ym8xZG5EdTNkTEYxK25PZCtWb0JjdmxiL1hzN1Zr?=
 =?utf-8?B?UTYvc2dVOGgzZVB5OTdhMk1HZ1dBeFU1V3JnaG40dFdDNHo3UmRGeHVlWnBT?=
 =?utf-8?B?a2MwUURuVUowYUh4M1R1eEZTcmpQcy9kZTNkTnNVMk5UTThvOWVYS0xQS2hL?=
 =?utf-8?B?MXBmbkRXaS9OS0Q3Ymd5OWQxTTlHY2hSS3NzbkQwVkRhZE9LQll1QnVqY2Nm?=
 =?utf-8?B?enBaakYyUnJ6L3NLczBYK3B5WTUxN0wzZy9sZGNPZGdPckQ3Q0djeFNEazZE?=
 =?utf-8?B?SnEwN3JEWFhvbWFBQWtJcldNcXNFTGJ5QjdxZ1pXNzNiMldWU09meXFqY3g3?=
 =?utf-8?B?MkNKOFZRWTAwRVdBUldLK1hBTlBUT1c3SU8zVzZqRmtHb1lpOHRQL1BwVGJD?=
 =?utf-8?B?eTZrWWpKSWFNaEZvK2VCNXE0S1Y4SDJ1ZHprSHFYM1hFUDNlZzI5cTc0OHU2?=
 =?utf-8?B?NXd6NUFzTXZyZkplSysvSmNncEtubVdKWE1QWVJQMGJaMXlPWkpSSEcwZFFq?=
 =?utf-8?B?TUlrN2laQVhSN2psbVc2OHY1WnpuYThoOC9wQVpuV1Zjd2JYVjVMTnJFdXMz?=
 =?utf-8?B?a1IyaUFQMllUcFFOWW4wWmdYK29TRVQ1c3lWYVhGa2dIcm9lOUU5SFV4b0s0?=
 =?utf-8?B?VDNuMzBDdHdXUXlEaXdZTml0YS9TVU1TeUZLTE1HZXNtMksrY1grdVYwZDNu?=
 =?utf-8?B?d25FVGxGVWo5Z0JPOGhTOFBadXlFMm11VG5NL2lCdmlpNTM5dEgvU3ZUNHM3?=
 =?utf-8?B?M3EzWFRVMHViYTdoSzc4NnRoRzh4T2ZBVkk0VEdlWHJ5c1VDR3FQQWxIUXRa?=
 =?utf-8?B?T0NndTlYM3Z5eHNyOXRmdWRTb3ZtRVMrblJHN2RMWnNJU25YczVXU2RqczhY?=
 =?utf-8?B?VWFZdEpPUzIrQWx5STQrR05lY3dYUVVsYU5JQkZ3N1ZhSWt3Z2F5ZWpFTExq?=
 =?utf-8?B?bHc0R1JGcnUrdHFxK2p3WnpNcXlTNVJudi8wSFpPNzVzQlV1VUtmdUI3eTVt?=
 =?utf-8?B?YXpqMDRzaFRDaHlnSmtRd2Jua1MwSEVyMTYwc3FDeTZoa0JwY3N3Njg4N3Nm?=
 =?utf-8?B?SXZIR1N2clhuMjFDU3crSmFyR0pwN3R1Uk1TUGtYOGNSVXUzU2t0eUpFQWZ3?=
 =?utf-8?B?QnZMT3VJTklqV3RWZGdBdzdxOUxOR2xXOTg4SzZVQXlhQ0hpU2tsK2loa0Jt?=
 =?utf-8?B?SFltd2g0dHpOYXgzcmNEcGx4cy9tR0U1YlNxdmp6WEFUWDBiYmVwaHRQSXFX?=
 =?utf-8?B?WHVZelF3WXVuQytoUXZxbnJQVFd5bng5dVZad1lKV3lzZjhOVHBTN3V0RjNE?=
 =?utf-8?B?VC9kaFVSZHhxRnVtMURsRFJNWWZYZUhpdzRzSEprMEd4eVNCN2lvMkVwa2Fs?=
 =?utf-8?B?R2RrZFRDM2MvZmpRVmxmazFZcU82QjFzdGRTZ2xrY1RhQU5OUjJWSHlLRWdl?=
 =?utf-8?B?cW9KZFJQNU9oSTVEQitCaUNJVXVZazZTc3kxY2lNQ1RvWG53RVA4WHYyZnRi?=
 =?utf-8?B?aWNMdkFhWFhpcDQybUhzd010RmhFSklLSHFielBrZDlTMEFvVGJiNTk5QkQv?=
 =?utf-8?B?MnZYOXFOZEVlQ2Q0ZWdKcWZTSUlGL2xVK1NES21PcHhiVzEvWng0VlIzVjgz?=
 =?utf-8?B?bXgyc1FHbmdIRHo3ZDI0dTRZRnFPS2FLanZZdy9NajgxTTJueWEyRFFxck5q?=
 =?utf-8?B?dFlDNUJzcFF3TjNNUjN3K3JWMWRLeUJNNzdHTFRqMmtGUHZDY2ZBOXlVVXQ3?=
 =?utf-8?B?U29DODM1dFdYajFLUlRTZnNtN1hyRjVrUXoxQzZPVUJXNVZtUGpTMitQMHVQ?=
 =?utf-8?Q?MSyFjk2Ul7nOsMKJKE3EQ4GgN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ef4fcc-ae88-475e-2437-08daed6f0759
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:43:54.8968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y0DDTYVCEYAohJxJvmv5V8joea5B4C5Va+i7UXFX1MRqrJexfY+GRB4iuP8UO3LU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 02/01/2023 18:03, Yonatan Nachum wrote:
> When registering a new DMA MR after selecting the best aligned page size
> for it, we iterate over the given sglist to split each entry to smaller,
> aligned to the selected page size, DMA blocks.
> 
> In given circumstances where the sg entry and page size fit certain sizes
> and the sg entry is not aligned to the selected page size, the total size
> of the aligned pages we need to cover the sg entry is >= 4GB. Under this
> circumstances, while iterating page aligned blocks, the counter responsible
> for counting how much we advanced from the start of the sg entry is
> overflowed because its type is u32 and we pass 4GB in size.  This can
> lead to an infinite loop inside the iterator function because in some
> cases the overflow prevents the counter to be larger than the size of
> the sg entry.
> 
> Fix the presented problem with changing the counter type to u64.
> 
> Backtrace:
> [  192.374329] efa_reg_user_mr_dmabuf
> [  192.376783] efa_register_mr
> [  192.382579] pgsz_bitmap 0xfffff000 rounddown 0x80000000
> [  192.386423] pg_sz [0x80000000] umem_length[0xc0000000]
> [  192.392657] start 0x0 length 0xc0000000 params.page_shift 31 params.page_num 3
> [  192.399559] hp_cnt[3], pages_in_hp[524288]
> [  192.403690] umem->sgt_append.sgt.nents[1]
> [  192.407905] number entries: [1], pg_bit: [31]
> [  192.411397] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.415601] biter->__sg_advance [665837568] sg_dma_len[3221225472]
> [  192.419823] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.423976] biter->__sg_advance [2813321216] sg_dma_len[3221225472]
> [  192.428243] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.432397] biter->__sg_advance [665837568] sg_dma_len[3221225472]
> 
> Fixes: a808273a495c

Missing the patch subject line, please see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Also, there shouldn't be a blank line here.

> 
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
