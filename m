Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83B5EC5A1
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiI0OMh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiI0OMg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 10:12:36 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCA1B3481
        for <linux-rdma@vger.kernel.org>; Tue, 27 Sep 2022 07:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCZl3MWlTOZNuKjl9JGxzgJ0vBJffSgg0GQH3C4urZ9czrqctQ+I5zbyAbAp2Y2ubt56J68cO++T41BIvpgmcCaZgegipEdwWkWSv3kYC7NlMmFDQdZLvWujzZW1xA48KbJhyfwg/ByD6F2W6Jv/JR4QrVMo54ETFTU3ptt8trJbsQoU5jZEwCV4iDAVfqXZl5+JgKxzV1bf4UOo6O7zxVcm3Qs0rDgBMpBH+EhLKZf0FIw0GaTrgwN5V5THtCxBGCe+0Msvzrt1SPJZTdTzu98/uB3hu8R1vto/am8/+U30BCd23hFtXKtnbhswLmtwWTtCqp2/nc6MNeQ2HgcAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7B2sejdbiok5a+9GzhrJOQJ8SMgw0wrbKjVNbxLe7o=;
 b=PY64DbVpugNzzwPocPFu+Te6Bft2nv6tUa0II12TXtb2tkVMe1IpzM64PiWT3eVyp1CXavfaWUwmFH2TFVBNessOnEc8nLR6khCNI5x7hks41RMpeU+p7oEOWelydg0mtrzcn7F/6r+eHzSkypN2pUnQu6USWEO+a+p5twRRtikArOWUYJ3yMF+KYeQZL4+AiLaHi2RMhQr60qlioJTh3A81WeSlB5Bw+AB9M3Gx6tncmejYKmgl/rXGnsx94u8smaZctcstl3Xs/8rmAYLLlkpxPalZybszC/Sqt4KD9PVaG4Q4k9RVCaTqvB00IS4gQFp9mjSrLZn5tMsete79dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7B2sejdbiok5a+9GzhrJOQJ8SMgw0wrbKjVNbxLe7o=;
 b=uQnxeLeJvQStXuXXul+CagPwUv3LV64ZkQ49DRwzZOKhxGW+hcJak5SukssE86cfi/SL7jbZ22F8h0lqBQ9EVnfpb4C0qELTGKSM58iZkYl7HYQOWRrUcpobD+vA0V1/gwDu5Uvwdnyq3W+0ZriqzdOUODNMvi1yK6u+qiTK4+30Ib1OX0+XuT9JLj0wTCMswD5SAavVFGblX2WYwj0L6Sh4XKCbEZzELkXA/C95PWoLnUfq3DbqczVQnHISRvJrUJ9lx/LmYJ04XpfEytqBSlGaYCWPWvtnF0NoQCs4IPl5L9iiR8Vtr5K6+TBqCSRu7MA4yO03ATm1DoLOsoN00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 14:12:28 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.026; Tue, 27 Sep 2022
 14:12:27 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shang XiaoJing <shangxiaojing@huawei.com>, leon@kernel.org,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        dennis.dalessandro@cornelisnetworks.com
In-Reply-To: <20220927022919.16902-1-shangxiaojing@huawei.com>
References: <20220927022919.16902-1-shangxiaojing@huawei.com>
Subject: Re: [PATCH -next] IB/hfi1: Use skb_put_data() instead of skb_put/memcpy pair
Message-Id: <166428794598.151957.330860353611903487.b4-ty@nvidia.com>
Date:   Tue, 27 Sep 2022 11:12:25 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-ClientProxiedBy: MN2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:208:e8::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BN9PR12MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bff4160-5bee-4a1f-7e92-08daa0924ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgELxt6ON7381HgpHncoXQji0afzr7BJBt5oPQ5d4AroPOVWNhRLazJh4EFjD+8rWZ+Vq9AOW+CeE5bpWl83idXvCDmc/dvFyiL15lApj4m/Og06ww3WyW/I/OSpWjmd/3M5KfNzrdNtvPKHaRCS+GO4SAb06XjzW3n2E6nG437Q8QW2EjowHEiq5n/rBx/RxbKHpHGEhz0ryiZ5GaCXpDPJY56FXKmIrkUkUQ8sT00a1aklXeSRe/wTzh6YC80gwXwGzeij/gFoiHsWK0w7mWFW30S8MhkeCKgTMJGhnPPh3S6VPWt4cKaCkLkVslwkJGoC4vWkbEIPfViNfnlqZ61EqhAxRfjvYVj7BObWqK3emPQ3hPK5C4MN98G1jBJMEppVd8OrJI8Zw9VosrYVcB4EKamJuJemcYf2SDBnLH20nVspM1AvuEm+Sd8nWh4cIqWrZx5dZPJ1eepTNUMSVm1ezWAxVMB7NpRrcuVZEdbOYSYI9fYTmvdUmARlIMrRe8lEmRbtX8VsIhspCNxtMNlVKIoWtoNHDa2z5IvF4ixIhGVxu1VyeUz3oRIgBz86Jp5nVNDi2BdqXwkNk6vZEblGJ/lj2KsQdvQGJC3YB63VvfYyncEJkQaHHcszKC83RwQPcEF5PmV/GEl2RcOQawBMj5WcEete0yrnN2UeIhSOg8siDobIFKq1nZpnhzfuYC8J8aKGZDaVGNogi5MnnsATgKc62PY8lM1pNf+q/W476/2b3UkmcFIY/rjzA5P/Zne6jFeYrkFZ799SxoVeYj1FIBg1n7O50EWkDoU5vEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(478600001)(4744005)(26005)(41300700001)(2616005)(2906002)(5660300002)(6512007)(186003)(8936002)(86362001)(8676002)(38100700002)(316002)(103116003)(6486002)(66946007)(66476007)(66556008)(36756003)(6506007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEZoWnB6aVlJNlNvbDgzN295VFZmN0hOYStjcVEydE40Tysway9aY1ZkdkpD?=
 =?utf-8?B?cDJ0Y2diaGx2WU9zY2Z6cGtoU1loZ0MwU25XcTVXRTVYRytZZEtkTkpWajhx?=
 =?utf-8?B?Q09ISm1jRVR0YUpvY2FDL3AyZXBYd0xWanNzanl6KzFmUVhUYnhaLzRtMjNq?=
 =?utf-8?B?MWVNWlNlTUxBZmxEbCsrd0xHOWluRFU4UDFqVDFsOTVram15cmhvTkR0bzhZ?=
 =?utf-8?B?Y1M1L2pWeWw1RDEyK2hUMkZJR2ZqRFBycWFUSjJpU2RGTCsybUV0Y0FVMGFs?=
 =?utf-8?B?d0NDZnlITm9hMkM2aXBtQkp5WkNmNCsyYWowM05wa0trSXdEZW1aYldFM3ZX?=
 =?utf-8?B?c1c5NXNrWlU1cjBkamVVcHo0aFFsZi9KdGgyd3RKTVBxNk1rZHlUZ3l6YTB3?=
 =?utf-8?B?bytvNytpcGdJMmNQUkl3VG0vQklTQkE4K0FsRjgwd2JWL2FRbnVRZmNnR3NY?=
 =?utf-8?B?TFFkY2FybUoxM2xYU20rYjVscW51TEJGN1hQUlMrd1pwa0d6U01vdG9TbitQ?=
 =?utf-8?B?SUVGS0l0cFZHU1hLRFF2UTdSNWRHZVZXL1dZUDEyQldOaHpERUU4eDEweG5m?=
 =?utf-8?B?TlkzMFJLYmg0bWUzSGY0dUo2N3JaZHk2dmpNRnhBaW1hRFlDZXBzRkVZUjA1?=
 =?utf-8?B?ZDl5Nkt0TWtjcmdvc0dLdnV4Q2NSSjl4bW4vdGM0aWt1YmMyb0hsbCtpNFJl?=
 =?utf-8?B?SENIUWJ2VUwxUjVwU1A3ZEFDMDgyTWpvZzc3V05zWXpCaUJMRmlWckVoNjZ1?=
 =?utf-8?B?Q2l3eWFOVzc0Q3FPVUswcmRmUzI3YWo5bXFHK3J2aGxoOTQ4TlcrbjlBMG1V?=
 =?utf-8?B?R2tCbm1wbkRNUmhjWkY4ZWdsVzB4QkNCKy9PS2RCMnVmUTVSL3hFTEwwRDV2?=
 =?utf-8?B?dHdBNWhsS1RmR0d1SUI5SXZiS1c0ZzJlK09PbzlRUjJPL1NTTVB4TXJ6NkY1?=
 =?utf-8?B?WktielE0VSs0ZlZoL1VnakFCMnIvSXlENTZtUWIrelYyQW5iUGFMTzE1M3cv?=
 =?utf-8?B?MGcxV1MxVTNLRGk2SDMyd3BPRWdQb3I1MEVoZG1DK0wwTVhLSmRTVldwOWJ2?=
 =?utf-8?B?NEtmVVh4a1JnclMvMXBKQ3Z6YjB4NndMZ2N2ZWZuK0RTbHQvM3JZdy9GdUVO?=
 =?utf-8?B?bDVYWVJlWmozeUY5VERRYW1TRkhua2d6UU9PZjV2WUo4Vk03NkF1WTl1SFN0?=
 =?utf-8?B?RjZtcEd4RzE2NFExOHUweWlsai9aMld3cTdmcHVMR1kwNEtrZmk2MDg1a2Ew?=
 =?utf-8?B?SEpSUjE5Z1g0NjZBMSttTkdLdDIwR2JPTU5OZklmeVFCZ3RxQ2pwZk9QeU1V?=
 =?utf-8?B?Tm92RWo1d0xNYnY0MWpBYTBHSHpSak5FUm0rcUtBdEVWbGR6R1hmdkZCWURU?=
 =?utf-8?B?aWVJa3VkVVIxZWJ0SzlvQktsVXRObFFXdWYrQnJQZGY1alh4NFlBdWwzQWRD?=
 =?utf-8?B?cUh6dEJOb3N6czdCQ3dub083ZVZDQ0lHS293N2FIbFVHL2dLNkJJbzNyWFdr?=
 =?utf-8?B?NnlBVWszRThBaGVkZkpNSUYzK29rMmFvcU1scjRHNjdEMnE3TDJydnk0Wndx?=
 =?utf-8?B?cVJaT0FQekJOWEUrQW43NnErSnh6NG9yeUhwajFRcGNxZGxuMUpaWUdzUVRl?=
 =?utf-8?B?alNtc2l5dEpGYnhpQTVJbWhMRFJQT1pNSU9hU1prNGlJd1ZWKzEraDB4MWFZ?=
 =?utf-8?B?WW0yL2tRcDNqTnRkYzU1eTFNY2FMNm05SHM4Y3RpaEVaMjhFQnkwQXU5VTlv?=
 =?utf-8?B?ME5yZ2xZWnViaFN3elcwTEIvK2pnQ0RzRmJaMHRHak5NTy9sTXROZTByRnZR?=
 =?utf-8?B?Qm1NbXozeGpBdXFQcmh6T0pYa29vNVg3dU5LREhHS3ZIak5zYVV4VVdYdmhQ?=
 =?utf-8?B?NzgrNiszTTVMV3J3RnJKRGpzNDluTWJ6WXdYd0graklHSEdXcmg0ZllKb3M0?=
 =?utf-8?B?NlVVWmV2YWtvTmltZnBmNnQrdmpUMHNGaGZmeWNMbkZRNmJrSmlxaFdYZXVG?=
 =?utf-8?B?ZzVHNW1nTXlOdGNvcjRwanFvYkg1OWJqQS9scXc4YXpRSCtWZEZxNVNDZ3or?=
 =?utf-8?B?Ym1RRGk2TFN5YlNSMGx1U1REdmVFZUsySW5DNUU2YUhOT3FRYXVWV3BNRXB5?=
 =?utf-8?Q?pav4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bff4160-5bee-4a1f-7e92-08daa0924ecc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:12:27.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwfGAQrfdL1CEs5Sc5I2P+mTrgIeN70YJKItshq+3/kDWHqRCE/hRDJEcQo1DcOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 27 Sep 2022 10:29:19 +0800, Shang XiaoJing wrote:
> Use skb_put_data() instead of skb_put() and memcpy(), which is shorter
> and clear. Drop the tmp variable that is not needed any more.
> 
> 

Applied, thanks!

[1/1] IB/hfi1: Use skb_put_data() instead of skb_put/memcpy pair
      https://git.kernel.org/rdma/rdma/c/cbdae01d8b517b

Best regards,
-- 
Jason Gunthorpe <jgg@nvidia.com>
