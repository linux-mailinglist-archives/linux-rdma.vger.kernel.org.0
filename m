Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8F68BFDD
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 15:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBFOSF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 09:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBFOSE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 09:18:04 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3016EB3
        for <linux-rdma@vger.kernel.org>; Mon,  6 Feb 2023 06:18:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iu1ik7LjvrydFHiZ+LaFroX2aRIe3IV44Ydiqtmw2fAN/hYYxv8xCWcJ5ekh4dtpsE/GEtHLtFFysb7XCpqpKdUzOc4hgsUQRFAJiC2yb9EjPJZorjoPh9rw2YXg/CbMRjWpmm+VomtgIrMm5fPPQ2EN1prdSGELFZxbcp2jiZVjT6kizUlaCrEjQDomKGSe9dWmfUd8xl+Id5RVXOvK3OzdUUjezSsjZ+QUg8Ra5Xw1ASjYCDVvrVBNhQI7paqgXNy/kvtoCcwNF8jyq2SUzIBYRv1HStlJ/rnQRvpbpPQgJfVZkaJ2Ztx1RxVOMZM0c36ORn6C8EcW1jIsybh6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X+lcrw/rxw76ej0OOBH1WKRcK98IGvtQ1dSciRfrBo=;
 b=AikjYeBc9+kvmFgccunbGNlC489v0IUDUntIb6gMrHOhPDpqAbwR8Di/gg1XohEixfT3VoThtOAdotRdG4j8EDMYG5fNYG0FAa/zfBqw22LsQrkVGyEi3tQUBIEGAqK7zT5CfngO6I/qprbJdhSHLIFwiALyO6QqmY2SOu4EWB49nLd1LzswoXuCh3HG0M0so4AB8w8/U7OJIjhAd8wWIUe7vjob7sWJ8KuBwX29B6waM1vHy6ueJ4cquPaUKHvfZvWxet01GFx0pDlBmDMI7AqRif3R42T5flwpU/tadmNM1fFDUOx+Emwq4bkij1vKZKsgkC0PsbYJbyPefMwhqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X+lcrw/rxw76ej0OOBH1WKRcK98IGvtQ1dSciRfrBo=;
 b=HOFfJCv5BUcFBkXfHXeKxlV6VKJlMvN398cu5YIajMSPAnztPjWJoItjBhOZTZecm3GmkYhkbB7TRtOeg4J7NDXl5S3z52OfD/CFsR4oLFsdoFpr3HpT78qQExMUIxP9WpY1WPgcXjdapcroKt0XR5skS76CBGMOoAGybVgjFOzp/fmcTKOKE+PaFv7y+IfdJdqtFQ9dKIeYiArujsNtFuYwEvRumBCT9emRAdZqmFJNskeFzuDpPOY0QC9R1n1J9539TIQLlgMg0mtXymyP0QQ0QRnBYHnhyK/Q1JYSG1SI/gehVQG3v8MvnGjeNNHkgtaeq11tUefRZMszNi+IUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 BL1PR01MB7723.prod.exchangelabs.com (2603:10b6:208:397::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 14:17:59 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 14:17:59 +0000
Message-ID: <9367eec2-f4dc-ac18-6bd0-a184660d0fa4@cornelisnetworks.com>
Date:   Mon, 6 Feb 2023 09:17:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next v2 0/3] Rework system pinning
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <167467667721.3649436.2151007723733044404.stgit@awfm-02.cornelisnetworks.com>
 <Y+DemENJaLcGW9ki@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y+DemENJaLcGW9ki@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:fc::21) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|BL1PR01MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0676b89a-767a-4cf3-6c9f-08db084cf2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT4l3vIV+17xSTBeGGaxndHt1nSrG/S4Icl4k5wb0O6NOq5+/JbZoRugZy8USY0MtXveNc4knTQSnSIfi3dQ26pfZOwh2mcqPctZTueDkLcGe244V+w/7ntzGn10zCeVmYG2IyMP91Rmt4Ahh/yHE3IrdMe/RAwXlXjN7fgo+W+ZB/hUZE1GOWSg4EUheOaaW6cZIMJJRppszqkjhWS+bBY7Jj9upQzShl7//Y4vpdnPCQHBt0Oz4p5u8l4oPpLzb3c56KBoBEIjmkH/orh3Z0kZFcrhBFb1oJrkCcpYLjuBPJA3BeuZcGfuGx7c5wmA0q0T/FXPJ//8hrW5c3OCuXqsQ0d2EVq1L1zqKA0AnUEmRfWLroG1DcNoAPoSDAogUtgmIv8HEqZtEw1W2W3qHLea+qLnoDKSp96WDNgGoSyq0in3f1qTsqgsOxsqSlcfrDMr6kz9B/DMJvPWPt7bJWmZUJw4kVusBiNmgKAojnLhAuR4S4G5A51nPKNYUUwTeOlO52ivx+UNbwQMELa3W40KFCNiiBK+TatwLp7UjaxBqC/QzR4fZZK1B7ltvmdqvLyNzr8o2sZ7WC4i1FevaoU6mqM9aKCaKiI/HkdAEYQDXVfQGAA1VWOMwAxymJEyimky/xtCsouX2GFG8UacOoalqUsVMHq5SGT+ROh2rM3Mmj1Lvk4ZJ77b2MrhAZgXKtNw67tJk1UkgwwG2y+6AI8o34bcn7MtUXnmP2RuqpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39830400003)(346002)(451199018)(31686004)(5660300002)(41300700001)(8936002)(2906002)(8676002)(66476007)(66946007)(66556008)(83380400001)(31696002)(4326008)(6916009)(6506007)(6666004)(54906003)(36756003)(478600001)(186003)(44832011)(52116002)(6512007)(26005)(53546011)(6486002)(38100700002)(38350700002)(86362001)(2616005)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHB4S2FCMGpxeFh5MFB0M1UyV2hvazN5dGR0N2ZVUEkzK1IwZm55S0sxYm1v?=
 =?utf-8?B?K0p2SFdCdnUxQ0p4RnZvNG0ybnA0KzJqZk5OZWRDbWx0VnVSMC9oM2VYeGJU?=
 =?utf-8?B?NEwzNHhBVDg5K3RhLzM5NXRqcHA4V0xvQmNVOGNreTBXOGZITVJhTXdXQUsw?=
 =?utf-8?B?Y0RwVUd1QnJLdkY3TCs1MFo5aDErbnRodGQ5V0lOWDBOTGE1VG1YQWRHSGU1?=
 =?utf-8?B?Rkg5V1c0TnhGam96NWNBSHZNbllvVVlTQXZtVVlPMlhkRGZHcVZMUUJkdkZr?=
 =?utf-8?B?UG05cUtCem10WGhhMlFZOCtqME9Ta3BIY0FnZHJmMGV6cytEVXZjV3lZS2dy?=
 =?utf-8?B?TkltMlBIL0JnU25mVmZodERVSlB3K291UUJReURsMVV1dTFzaFBrczBIL0N3?=
 =?utf-8?B?d05YejNsTDdwVnBGQnBQeGpONjlMNWVmYkZtU3kyRDhMVFdjVWw1ZTl1OXVI?=
 =?utf-8?B?SkFpRUVGbnZIWk1RR0Z5a29Ec1ZTUW5TbVVJd1V4c0E1Qmk0MFdYZytHT292?=
 =?utf-8?B?Y3hjM2cvWFBMVFIrSWtTZjlEdjN1bnkxWE43Y1pnbkJ5Z1pwSzFndWZxNW5U?=
 =?utf-8?B?c2p5NUQrYm96Qzd2UzhUUGdUbUJwSmxZOXQ3eVp1SG9XWXk2UXZKbzJRRlA4?=
 =?utf-8?B?QTRhMDl0cEh5WWhkbFN3aXJQaVVZNnR0UTFOSFQxdHNDN3BtdFRleGdiL1gv?=
 =?utf-8?B?OGxmOTEzRGkxY0tDemVXMTd2MHd4ZlprL0IrZER0dkJ0TWZhZEYvSTQxaW5t?=
 =?utf-8?B?OFJjZTM4czdQWE5Vc0VlM2FSWGhiRjdRUkgxaDhxVVZUZHRQU2xESVhZYnhr?=
 =?utf-8?B?SjNXM21EK3VUb0Qrck1SbEdqTXdQNEhuNTV4dU5TQkN5Y0pLdUp0ZHZ0T2la?=
 =?utf-8?B?YlZya3Q4V01meUt2UEhZeTRMZGNIVTU3RWN2MFBtdUdZdlhIalZtOTFyNU1F?=
 =?utf-8?B?YUJ0R0wxTkVOS3NFcDVldWd4eWtMRXRFYjRTS2M4Z3BnK3RNT1prTUhmWi85?=
 =?utf-8?B?WWI3d21IcnZFbkdyQWx3NWlmTmFuZnNubzNDNWk1V3lKakFUbG1OWFNhUGVJ?=
 =?utf-8?B?Zld3L2FBdFM4eXdPb0V1N1N6UzRyZzgvSFJkZis5RzFzci9qS3haUUt3a2hn?=
 =?utf-8?B?Y3ZuV1RVVm9KbFc3OEVjV1NTU2VvVTllQ2Jucy9YM3dQdHd3dTUxTEU3eXQ1?=
 =?utf-8?B?VkpQNHl6VklBMDY3K2FOa1RXNXQ5cWFsaDR5TlErWlcyTm51ZVJ5KzlXTzdl?=
 =?utf-8?B?OXRhcUorWlVBZTVoQlR6YXRWbEovTnRzWGRIQUpJNnNPenJpZnZ2cVZwVUta?=
 =?utf-8?B?VU9SNXRkNm5aTWpmdlIxUllFdzRTQWtjaC9wVUNHY1FNR0MzSHlGWDBtRlZG?=
 =?utf-8?B?ZEEwR2NRdDBDWlhPYTV5WUovR2ZtTTl4UFBIbmpid04yZ055V2VaejkrTmdk?=
 =?utf-8?B?cE1xcm1RWkxmOFhNM0pmZ0h5VWROZFRrMUs1R3BVR2JWQ0lxaWRxczl4Y0lZ?=
 =?utf-8?B?VnFUSXl2aHVYZXphaUFPRk9vSWd3cklCeWxCV0J3ck4yWE5xN09rZTVnWnRm?=
 =?utf-8?B?RGZxSkxMWHV1U2ZvL2g3bmlJRFlSK0JEOERRbWhCY09uTnluMHI5L0VxQ0I1?=
 =?utf-8?B?SlRVTTRkVGZtM0s2Y3prQWh1aWY4MWtzS1pFeGorU2lkK2JZbExhV3FNVkFu?=
 =?utf-8?B?T2lKUVhPVGhyMUFYTkczZG92OFBuTTBLaXJlNlM2aE9Fc2kyYjI2M2tzcVRU?=
 =?utf-8?B?elMzY0JreXIyNDRyMmdsS0VpZER4dnQxUVN3Y1NkMW1hckRTRGJmeXNzTkZy?=
 =?utf-8?B?WXBNeEtqTjFuV0hYbU0yUXdRY0ZOdlRiNHVuTGZrbFdjRnA4WE4vZXozVXhK?=
 =?utf-8?B?NnhFRndBQURBMU5ZMlI5WVMyVFNrWGlwenk4VHNLeXRmQjl0ZGlxRjZTWnFp?=
 =?utf-8?B?RjllZzJ0SkJyTDVGTjg0emVnaDFKVEE0bmNDWkplak8xbC9VZ3BTMXJJY1dB?=
 =?utf-8?B?eXB0a2N0L2NzNEJHd3JNTFk0d0swa2t3dnBhdkNYeG55NHlmU3ZGY3doZDFH?=
 =?utf-8?B?MmZSb0hTVUJpbkx6UHg1MjJ2Z3F2R1praU5TbnBqUWRQSEwwZmpwMUJJYjFT?=
 =?utf-8?B?TkRpZVQ5dTFjT0lXbHg4L0kzRFRDNyszSkZxQzNkbHdaNjR4WW5GNlRheVVI?=
 =?utf-8?Q?1eimBzQRCr9aPxrEqqnhgxo=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0676b89a-767a-4cf3-6c9f-08db084cf2ff
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 14:17:59.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tTIgAAivz3OKwpkXu/XcE8hTXLLgpT1kKhmHteZTPQ+J36a5XWhzPRgJfiijTdHSDM69jlGok8jWsxtw8NUh4eMqzXMcVL0pcoqcXYIhIB1AHtTUIhewOjtEGrf0RMM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7723
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/6/23 6:03 AM, Leon Romanovsky wrote:
> On Wed, Jan 25, 2023 at 03:01:33PM -0500, Dennis Dalessandro wrote:
>> This series from Pat & Brendan reworks the system memory pinning in our driver
>> to better handle different types of memory buffers that are passed into. 
>>
>> Changes Since v1:
>> ----------------
>> Added missing commit messages to patches 1 and 2.
>>
>> ---
>>
>> Patrick Kelsey (3):
>>       IB/hfi1: Fix math bugs in hfi1_can_pin_pages()
>>       IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors
>>       IB/hfi1: Do all memory-pinning through hfi1's pinning interface
>>
> 
> <...>
> 
>>  include/uapi/rdma/hfi/hfi1_ioctl.h      |  18 +
>>  include/uapi/rdma/hfi/hfi1_user.h       |  31 +-
>>  include/uapi/rdma/rdma_user_ioctl.h     |   3 +
> 
> Where can we see user-space part of these changes?

These don't effect anything in rdma core if that's the concern.

Pat and Brendan added an IOCTL to get some additional stat information about the
pinned buffers to aid in testing and debugging. The thought was OPX, our
libfabric provider for OPA may want to take advantage of the stats here as well.

-Denny
