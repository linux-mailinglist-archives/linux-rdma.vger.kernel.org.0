Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D85E7D8F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIWOvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIWOu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 10:50:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7110CA7E
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 07:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Q+HvHDS6dbYfycON2s60D3fpD00be/0XH3WnYQJp/skU3SHMuPWmtcUJxZgs7U97V+XQK39uK5Hsar+Y6K3UI/sO+siON57lVhRhoW6qnoz2ep9Kf/xKpVJjcXhVSqsDY/v1ANmeH3h63JAKI1YGuKSxmO6Roc1AWJ/I2Z/GLQdZ7ZV1/KQwjQsmooO2FM2LOWJk7eP+rezUD9DiaSaRbPuvLrbVZwq/V64znNqTUMd8FcRzE9cDW7+2kbhnUsHd4McwWpWzDpnYgS0Dp/Yc3Y8G9XAAoUI0pATBZY5nLOaTa5hDDyEMmtP19ky/l9vf19vF+huMEzTQSTeK2uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyehmozawudUDjf1Lhdf3T39G8+T69BsK9LvqAE/YSA=;
 b=MQHtFGc301naQlxpDCHDJ+p+ap0hskLS3ZChCBU/PxNSWUDlSfyiFU29xLL/f3kDl5mKHsOKQBLAri7s4EWsZ8LK8PrxD7KNUaEas2epkaqcqGo7or5aF8i/U6Gh2FGAJsi3XPg2cOXIwRPC/DXkepHvTbHzd/gIptY8UBChttkeL/do9kOJcmlbgiUUICNW9YucVF+snhz0D4v5JzJQBJWMCpus5cwvwcF4Ewgf1ZY3Xa38LvmN382YjrfOAian0q3eo5UoRimIRgpDyoAGcAI2zIV1T5uKWXpxKe9kUwrKkyI+m2tk3jOP7ROTVd6IpP8yPIfPcYHJXzDe0M+RKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyehmozawudUDjf1Lhdf3T39G8+T69BsK9LvqAE/YSA=;
 b=aR1PAXLTDR0bI30A/4ZNylBSH/FJI1xeIuGZu27F/u9pZXztnmix0vp6FGOYLrfkPRiuKfn3CIIhWo6niWpDynEq8gRttaUmh/FjrjbFbeU293k6ckamElf+r1t8dkvZNW0g7JHtP0u0vYVwelZpfqlTX12tpg76/pRlyA1m1h6GuKFOK/MujSZlMZPjLZbHRYPKaLOR4eEGeOYoOUcNhavwBw9AflX3DqkeAqmJPKZLq3AQRYawOVyHE1mj+HUfljU2forbjGITI40IFQ9hftXIxN4L4J4J9h9/3ax55a+bi+E8JoqcBMl/Ka2+WpDN1fx1J3ocacMFVq9GqZ2DNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 14:50:54 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::1c13:dfca:d0c5:4d5c]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::1c13:dfca:d0c5:4d5c%10]) with mapi id 15.20.5654.018; Fri, 23 Sep
 2022 14:50:54 +0000
Message-ID: <899c9cac-901e-bc2c-daf3-e86e26300795@nvidia.com>
Date:   Fri, 23 Sep 2022 22:50:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support
 with netlink channel
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
 <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
 <Yyxp9E9pJtUids2o@nvidia.com>
 <969cf0aa-a066-5142-d917-f07130974764@nvidia.com>
 <Yy2w+kxp7ebtsdFE@nvidia.com>
 <daa5f761-9672-8598-1533-39eca4efa972@nvidia.com>
In-Reply-To: <daa5f761-9672-8598-1533-39eca4efa972@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdda274-1949-4dda-9cbb-08da9d73042b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNSKB3rTLUvZ5ESQUmsdly0QDubqbGJ94merbdN8+jIFIsoMV41rCRxRk8xnXnioeFtIGvN2fyd7GJ5b+wMI/Ul7p9wH9DR2ARaK9wEYLteb10NisHMp3uYh8E8aWWEA1IUk+fqORcOPHBiJNKKybTifmRXQCoVtZrU8lIj7/+z49XiNjEkJlXMWjmGnUQhVI1DLUReyVF3zx1hxZttbGoUUjha63ERXoRMd6RYgzLJjM8vLpj1qNkfI3TKRBv9S2TrB7DQiKs/kRguvswE9w7IefqiJIRbiHfmnRN8+7hxRSfjAZWTONCp1ZxtU9z0sCoVA4DYP8emAS613MwrpDc8Mdo56vOhwy8sEJK+mrk2HeXsbnm9JH+ZIMlMVH4XJtGObtxvzyj33UpkcA689IyLPSZKcZrnMxpGSCWJJUWZZLRo1/XetT39GFVr7tPg1UBxMIzQHkF+YO7ZVz3hIIfnm5fUoODi5IF/xWbZowebNrsIkHts9BnzEKW6LuJBIbiqDO1CWFLRvauKr9uLYfA+8D/6UfECI0jxuZvE62cP5FuyU00arZfaGFW/g0ejYMtzaTvMj9x4kUeAUk9bJs3b96QoAJyHUATye4lU8YUIxklYojWiutBPLegHT7UeWUsCaQK/UhcavoYStgUJ8CJAYy3xqf1KD1+iaDPboxeAJXd7Gszb+0+cX0XJaFirSWDTlEEE2HpDdyai/CSGPGcqiZ0QhdrqgRE+7Pqg4Plejim5c2U4TBVgtGvLPGKGT1wWsci68Rdp9O3noSqdpWPsUsEHfs/Dco6mxkT5hv7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(6636002)(8936002)(6862004)(4326008)(5660300002)(66476007)(66556008)(38100700002)(66946007)(36756003)(86362001)(31696002)(2906002)(6666004)(53546011)(41300700001)(186003)(6512007)(83380400001)(26005)(107886003)(6486002)(2616005)(478600001)(8676002)(6506007)(37006003)(54906003)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGI5YzVHRFB0OTVpRHhubnV0T0kvUTFyYm83UWdkWTAyam5QT0YrY2IwY2tk?=
 =?utf-8?B?ejhscHJaTEZyNFVHY3l6Nm5uOXNQUmNqYjMwVGVBWHNyb0lORFQxWnZUanp6?=
 =?utf-8?B?NjMwNFNrTmZWTm93Zy8waFU3K0x1dndpMzA5Y3BGcWJaVXlCdTY5alZjSTd0?=
 =?utf-8?B?K2NiMm1pdDV3WldmczZ1bXd1aStJdldwYkt6UXJib1FvZytRMjNSMGZrWmFH?=
 =?utf-8?B?RVZNUGxOcVREVk43Tnp5TktaUkJ4NUNxVUNlWGpqMFpXWDhXellMTCtNTWZU?=
 =?utf-8?B?ZlQ4dDNLb20zMm94UGwxMS93V0g0ZnRldzlaaTZ5Y2VtY3RWSFF2N2JGQktF?=
 =?utf-8?B?Qms3SjZ1ZDFhYlYrRUx3UDNUbkdUOG9BWlRiSW1RTzM5d0VsNXE5SUI2QXk5?=
 =?utf-8?B?Y1dJY3NiT2tEbnN6bVgwSTEyQ2ZTODQxaHQ2MFNaOXhiVGpMSHM5ZHZIdXdE?=
 =?utf-8?B?ckQ3cWhpQVZuUG9hMENMenQ1ZDk4Ylhwd2IzSTJJUmpEWjVhTDJMTFZwaEli?=
 =?utf-8?B?cWdnSDRGcENOWmFESk9wb2JqbWdWMlZjRGVZK0x3dWUzOVZnVGpZNys2U0tt?=
 =?utf-8?B?OUlyTkFRdmpNQ1l6WXZ1SjYzc0QrYWR2cWs1TGQvL3htbFFzL0FvUDVEQktH?=
 =?utf-8?B?U1MvNkVCVC8xaVVVWlZsTTBlSHJJcGZSWlkwRWNtUjF5S0o3RncwWXJISldV?=
 =?utf-8?B?bnU4SlV5dWt0aXY1anJVS1dFczhCWVErb25SZ2V0bWdOeEZZSlR5WWt6THZ1?=
 =?utf-8?B?b2g0RmpDcXk0MHlJMEFkc0NYMHNueS92TWJqL1piK0prVzdUS052UnFzSmFE?=
 =?utf-8?B?bkYxMUNsdDJQbTBKWHdpL3NzNW1vaE9XQmZMMnRGSnMyZXI2b3pwZWp5eVA2?=
 =?utf-8?B?WWZhY0pBa2JxNk5PNUlGZlFUdjJzZXJSRW5PQWNWVDlLWUlQd1NmSFpkZGxO?=
 =?utf-8?B?aU50NXQrZHNrL08yQmc2VGNocWY3VnNGK1BDZ1AwK2pCa2dwcUNydDc5djJs?=
 =?utf-8?B?eVFZcGxtT0dmZWR3UDZieTRGQVkwekV5S0c5Qng5OGZ6TGR0eCtqOHNod1pl?=
 =?utf-8?B?Q0dTZ2VOZUZZaDA3TmR0L1hzOEoyS3hudkg0aXlBNWdhZHhnSGRpUE54ZVp2?=
 =?utf-8?B?dXVrNUhxc2VPZ0FUZXJYQ1poTHppWFppV01LbzhXY0p4YURPM1JzcDRIWUxm?=
 =?utf-8?B?eVBxUTN5cFBRNXFDZHk5YXo1aDlTd1h3ODYyazJjVjBFN3RTK2pZYUp6OU9v?=
 =?utf-8?B?NjFHK0RRRVlZU0FFeGc5eFJlRzh6bzBIN3JvckZjdktta2dwMklPWGlOdktr?=
 =?utf-8?B?SEFSc1YrMno5eEx5eE9EOGFudWo1TmtaTkdVL2gxOWFteERkTDA4TmRtNXN6?=
 =?utf-8?B?OUlhS09Qbk4xZ2JZNHl2TzVLTnV1aExNWk8wNWlncThkUnR0c2NBdVhUTnNN?=
 =?utf-8?B?dHpIREo4emNRcmVsMFhocUQwQ3MvbmRNd3I0YkU4ZnNudTkwVnRmMmNKam1Z?=
 =?utf-8?B?M2hYbXVybWtReStjOVpGV3RnNU1YTVVzWHR0bkdxaWQ4eHhrTzRXNURvb1BJ?=
 =?utf-8?B?R3NFVjRaaGtFVTRpQVJhdlh5N3d3OFhodXJTbm13cFp6U0cwdjNoZTYxendI?=
 =?utf-8?B?blFqQXUwbkMvMHNuMVVXbDhDK0hmazYrbnNkVHhlc2tmWmk5dGMvK29CY3pj?=
 =?utf-8?B?aHU2dm4yWkZjTWFlQ3FmRW5udEVXMXlvWXNCWFRNVENPT2M3enhCckNpZlAr?=
 =?utf-8?B?S0ZPZnR3VHFTbnNZTmFlcGorVUtvbGRIZ1ZWSlRmMGZXdHZ0ck5icHYzcUFE?=
 =?utf-8?B?UUtidmFuYUEvcWtpajljSWZ3Ukl1RWRPZ1V2M0NqYXVOQTZHNythVGxiNjZS?=
 =?utf-8?B?ZE94ZlduN09oWTNPRnpVMHFxR1EyL0hCYlM4S0EzYTl3dnFzWjd4ZG1KckNj?=
 =?utf-8?B?VGFCL0p2Y2hnVUVxM2d4MERVRk1Nelh6TGw5SlQwMVJSVDhUZXdrbTdzaVhD?=
 =?utf-8?B?ZTdidmxCTTljUlJmTGY0czhBbURqbVQvS3hrS1BLSDBHYWZqZ2NkeDVFVG1V?=
 =?utf-8?B?RUdZVGt3RjNaNEpETVRrdjJmUXRSeGVVSFVnc1FFZ2tsWkoyZkVrL2tCOE4v?=
 =?utf-8?Q?cT/1Iw/QDbTFX+69PrXgEay3/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdda274-1949-4dda-9cbb-08da9d73042b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:50:54.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HHx+AyOxFSB3+o59pnO/NCvVoW0doM9iuMQgrIXyI283T9Y+eEP/Xla8UaZ/WWnGkNrvfPfaiaCfXEJ/uaA8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/23/2022 10:24 PM, Mark Zhang wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 9/23/2022 9:13 PM, Jason Gunthorpe wrote:
>> On Fri, Sep 23, 2022 at 09:40:22AM +0800, Mark Zhang wrote:
>>> On 9/22/2022 9:58 PM, Jason Gunthorpe wrote:
>>>> On Thu, Sep 08, 2022 at 01:09:01PM +0300, Leon Romanovsky wrote:
>>>>
>>>>> +static void route_set_path_rec_inbound(struct cma_work *work,
>>>>> +                                 struct sa_path_rec *path_rec)
>>>>> +{
>>>>> +  struct rdma_route *route = &work->id->id.route;
>>>>> +
>>>>> +  if (!route->path_rec_inbound) {
>>>>> +          route->path_rec_inbound =
>>>>> +                  kzalloc(sizeof(*route->path_rec_inbound), 
>>>>> GFP_KERNEL);
>>>>> +          if (!route->path_rec_inbound)
>>>>> +                  return;
>>>>> +  }
>>>>> +
>>>>> +  *route->path_rec_inbound = *path_rec;
>>>>> +}
>>>>
>>>> We are just ignoring these memory allocation failures??
>>>>
>>> Inside "if" statement if kzalloc fails here then we don't set
>>> route->path_rec_inbound or outbound;
>>
>> But why don't we propogate a ENOMEM failure code?
> 
> Because inbound/outbound PRs are optional, so even they are provided
> they can still be ignored if cma is not able to set them (e.g. memory
> allocation failure in this case).
> 
>>>>> +static void ib_sa_pr_callback_multiple(struct ib_sa_path_query 
>>>>> *query,
>>>>> +                                 int status, int num_prs,
>>>>> +                                 struct ib_path_rec_data *rec_data)
>>>>> +{
>>>>> +  struct sa_path_rec *rec;
>>>>> +  int i;
>>>>> +
>>>>> +  rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
>>>>> +  if (!rec) {
>>>>> +          query->callback(-ENOMEM, NULL, 0, query->context);
>>>>> +          return;
>>>>> +  }
>>>>
>>>> This all seems really wild, why are we allocating memory so many times
>>>> on this path? Have ib_nl_process_good_resolve_rsp unpack the mad
>>>> instead of storing the raw format
>>>>
>>>> It would also be good to make resp_pr_data always valid so all these
>>>> special paths don't need to exist.
>>>
>>> The ib_sa_pr_callback_single() uses stack variable "rec" but
>>> ib_sa_pr_callback_multiple() uses malloc because there are multiple PRs.
>>>
>>> ib_sa_path_rec_callback is also used by ib_post_send_mad(), which always
>>> have single PR and saved in mad->data, so always set resp_pr_data in 
>>> netlink
>>> case is not enough.
>>
>> We should always be able to point resp_pr_data to some kind of
>> storage, even if it is stack storage.
> 
> The idea is:
> - Single PR: PR in mad->data; Used by both netlink and
>    ib_post_send_mad();
> - Multiple PRs: PRs in resp_pr_data, with "ib_path_rec_data" structure
>    format; Currently used by netlink only.
> So if we want to always use resp_pr_data then in single-PR case we need
> to copy mad->data to resp_pr_data in both netlink and
> ib_post_send_mad(), and turn it into "ib_path_rec_data" structure
> format. This adds complexity for single-PR, which should be most of
> situations?

Sorry what I mean is resp_pr_data is used by netlink while mad->data is 
used by post_send_mad(), so if we want to always use resp_pr_data then 
in post_send_mad() we need to do malloc, copy and transfer. Besides if 
malloc failures then we still need to use mad->data, unless we always 
use stack no matter how many PRs there are.

> Use malloc instead of stack for resp_pr_data and multiple-PR unpack is
> because sizeof(sa_path_rec)=72B, now we supports 3 and there might be
> more in future..
> 

