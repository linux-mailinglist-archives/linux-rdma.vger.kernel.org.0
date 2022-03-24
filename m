Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86244E5FC1
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Mar 2022 08:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiCXHzq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Mar 2022 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCXHzq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Mar 2022 03:55:46 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAD98FE56;
        Thu, 24 Mar 2022 00:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYYW5QiDbxwSjxgaxNT+7+42cqZpK/sHLlTc8nCHpMjHEGA8RfAfJrGOWvOU7d1gY7S1/eKCd7ey252S3x1TTlyA6unXaFY7fBfDFQKw8EMWTojb6y6zqHnaqGbUsW8d5IpkoRth9blVsbPO7aXKl0W95v1Cdjs0OMYULETmlIrT/11EnjsvIAPkVZv8WCvIwcZynoBfXeVCvgK46bno4Su4a1FAtghpK51+vZmVCNVgrAoexkFVqHVe3sK4GRQLXVEvsfVl44uEHFcWyeUH/6ToEdMnDnuvpZLwUjzF9s7rU1sQ+BsggRvASB5xEdwQOHA2XgacG+64lhXZIj9F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDOhrUEiBQT3Dg0K5srNXlJon5j9+WCoF6Y+kC9id+E=;
 b=X9EL+9t34LJJGqscZnniGISCq3etOmoavYQhtkEiHHUXgwyUjupfFb6MH2mu/eFhHbn0X/XwbhdoXZmyFoGC6ZJTM9xUoPf9oOJ8MKtk0dBg9gTQRd+GGQh6vCNZGh7YQE8IcZGghroXX68yCLzFExuWfkS+1fG5D3B3qoVPH0txlzDwFw6mZzs23u2V3R7PDDZ9eMvcb6bFNsTNCbepP6oi7kIVW8qRW+rghsaek1x0vgTZolYftJ8Ai6yqeHGK6zpMvTjiMQo6F7ueT6qjFZyt7M+6u/S12iIzDfZBNGjO2zc771uZ/HlYqH5R5vn+PItQxxFpDwvFLkHxRkAt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDOhrUEiBQT3Dg0K5srNXlJon5j9+WCoF6Y+kC9id+E=;
 b=ctBUumrZvr1/LhCv9LH508PzdI9nFSkcPUnQurSkSjBbsDaeuf51VMxCs/+9/7oUMiGxwQYfWKtvNpGZdU3YEQkIKl2ALnRPQCnSt5G5YEUG7nXn9s1hAgyEs/OwcmEJERGgbEE9I7qDHYRyAJRF2MTw6cZwUomIoye5U4SUUoIxrokiFQ6HubCRMOJP7QbonZ8hCSPvoSkUvHJobLTFEWndxYD9JiT+Q3X2tphTZJdp0ucdWwwbp5IwsrJOgqwmCkiWSz4l8RDW6qMxE3EtiM2Daz6VLhly6D6u2xFfkm4saigq5fE/8pLy3iQztT2n7MN0eWJ6rTdSvh5qacWzBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 07:54:12 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::7044:8280:56e3:46da]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::7044:8280:56e3:46da%4]) with mapi id 15.20.5081.022; Thu, 24 Mar 2022
 07:54:12 +0000
Message-ID: <a06fef85-7b5c-b2ef-7965-2387cbc8f724@nvidia.com>
Date:   Thu, 24 Mar 2022 15:53:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] IB/SA: replace usage of found with dedicated list
 iterator variable
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220324071124.59849-1-jakobkoschel@gmail.com>
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <20220324071124.59849-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To CY4PR12MB1366.namprd12.prod.outlook.com
 (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3edbd2d-a7e4-469c-2630-08da0d6b7c4d
X-MS-TrafficTypeDiagnostic: MN0PR12MB5932:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5932FB64CAC373A7D9BDAD2BC7199@MN0PR12MB5932.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYkusXMArpiLCJtu9GjQuTu04oViHqJA4pkvUri7va9UvferyW/l5F2TNdbY2yZKyWI7P+s/ycwW9FA4ZhpuiZDAVweTOppXKfI4j2mRPfMhIUO/3JZs7QRwYZgzO4gW4Glr/mNTgU0LuW8CIfhXeZ3gaFgwUMOQqEl8RNAPOofIKCjr9ASMWaMWpnQRFEavbRgWfwBJVje41CC4W0HxX+oC+E41C3Y/cF1i9lyi1dwLQ6BUlW2fezOi9b11NAWjhP78B2jmbKpfMnlYadj2dyTnNmI1F+3RLeoW+53IKjFSVGetEeH3qlhwO+aJx/TZorCo2HhsXrZ8unXK3Ue4cxfcT7v3BEmyLlcQq4bRl9fIYeQhrJ8upUEK8RKKoJwdPhHdwCEpidn0N3pwcCej3W8DFI7IljbyG0PwGHZQUxIy5AHVP3RzTXDNVPJ/uGZEaJy6CYPsAHnb4qn2/8N8KI72i1ZBa8+Ml/jlyzbmKAUltH8441nFge3RfN60jzNRZyE7GcD6RUZBQaGCwMRHTBaKyl1/SrINcjqLOQo4b1LrOLI+dRTkmDO8rCVApLTMbxLwFmh71bRB04okIVRSJb7/SU3e5lZcfQYEL14hCAly8ImeASykre1Q7RqJBvRm6KnkfGJ/vITkWUIdQ6awKFW1kuuP78K3vM43sVzkmh96WH2m4MyB5th902fs5UPvn0XyMKkG1Tz6slJTR0oLyR9ZSdQToMCDIJN/22KabMuHH5T8rAbjLjK40p8YKIgNypgRhm3Av0gYluRZfArjAMlAtPwqxhTK2J/t9vxIsxNqTL3LqUszkuF5juXHE2TCALmm9lQ6qgJF8VvWKT/joA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(7416002)(186003)(508600001)(36756003)(31686004)(8936002)(4326008)(5660300002)(38100700002)(8676002)(2906002)(66946007)(86362001)(66556008)(66476007)(316002)(54906003)(110136005)(6486002)(966005)(2616005)(83380400001)(6512007)(6666004)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNIU0lqZDhaS1g2K1IrWHRxRmhrWUIveVd4UnI3Vk0rNEJuTldJVWUrWFVy?=
 =?utf-8?B?TjUrSW9JY3Y0SE9kaFMwcjJ3cDBnSnpSWmppUWEraTZHbnF6bWZiZmJHMTlB?=
 =?utf-8?B?YnVKSnE2bFZrVzAxTFg5YUNPYWJPeWFGTkQ1S2tIYlhZQVlCenlJN1dyMFE3?=
 =?utf-8?B?aHJicXJCYmV1SWZsUVNXRFpyVkQxMWdEamExWmx3OUVKV3E2eTFOdW1HZlJO?=
 =?utf-8?B?UnJiTzlSRGhucmZYN2VjMHVzekZmYnRZcTRaSFBvQXJtTU1lbmtVZVI3eFBK?=
 =?utf-8?B?V2tWVVgvdFhXWEJERGk5cGthNUxmZUQ4RURyZ1UrRjUycmp0dTVEUXkzb0lm?=
 =?utf-8?B?S3dmaHl0L2JiSmJzcFFVWWoxSXkvSUF6bVVuRW9raGJmVk5YczR3R1FQWmRx?=
 =?utf-8?B?NFB5a3J1cmpXQ3RmcTVSUmNmbGVvREZmZHJqaUUva2VYWkdyNkNtVHh3bDk4?=
 =?utf-8?B?Qm4rNytnNEN4MEtwbTR1cGw3RVlrWmFmTmhpV1RpTStQbHo4UXdqTi9JOG42?=
 =?utf-8?B?TXZHWGNaSEwrSTlTaVhSTDhNUWNUc1RyN1IwU0NtVytvMzQwQzdXbkp1TnNW?=
 =?utf-8?B?YWhNeTErMmJxQTJsZFVWTHphbUVNaDUza045ZWVtZGo1cTZWbFZwS2RwL3JX?=
 =?utf-8?B?MThDUzZNVXZGSG1EbjV0YVBzcGUwNGdVSUhiaVNXbjJtVnpTajgwcnVkZ2lW?=
 =?utf-8?B?UWNpLzNCYXg4MkVZTmlybDNmRXBzT0lPbThpNldnV0d4VG5UV0VwRVpWS3U0?=
 =?utf-8?B?ZVhGNlI3YUpzd3NWZUE0SnFpanN3VGRaa0UyajNLRldYenRVNU1DRzdUcWR1?=
 =?utf-8?B?Q1dldDNGQjZ0U0IvS1Fya1NiRkNYNWhNSXJNN2g5L3V5UXhnaEErdjNPZ3lP?=
 =?utf-8?B?NUozVnJIc1AwcDRQVU1qSHE1VkV1NEg4TitZbjVDWjFlNUM1Y1MvOTF6Kytz?=
 =?utf-8?B?b3kyRTgvazBSZkZoNUxOYnNoWXhNYUcwOE1acERpa1pKNHl5azcyWXgxOWJP?=
 =?utf-8?B?OHhwOVo1MEZTNk92R3VxSThMdmZ6R09sdW1OaTVQVnY1QnB3WUdrNnhuOW5o?=
 =?utf-8?B?b1NYdHZYRFhXbWR1VXhETzdQZXl4K1Jta05lUnJVV0FHbU5SMWpMY2pSTWNG?=
 =?utf-8?B?SUQwSUorckJQZWRkMGhOWFVabG5sckFLM05LWU1lakZVWXZKSmo2Ky9hZ3hT?=
 =?utf-8?B?Uk5zVnNZb2U5eURBV1liVFBiR210ZVVVdFhJK0lXNklKMFRWbm9uNkxWaU9D?=
 =?utf-8?B?Rms4U3lxRlliL3N4UnFqZjU4LzBEVkRnYjA1K1hRQ0x2OFRqWWdpVkVvS0JF?=
 =?utf-8?B?YUJZR3RJcTJCS2U1OXAzQXlrM2ppVTdMN2lRbDI5b0VmQUxFb0E3THRIT1pV?=
 =?utf-8?B?ZG9kMGJySXFXbzg0R3J4clpkVUpWMStRSldmTmJkTTlpRFYrN1FRNTJBTDNm?=
 =?utf-8?B?YW13czlyQTFJYU1EalJrOW9MT2JUMzczbUhsWlMvMDA2enZLdVd5WUZNM3Jt?=
 =?utf-8?B?dEhhY2loaTY1dVZhdGZMRW1FUlBaOTJpTkpYN0xOcnc1eEVOMUVkRUlEOUhi?=
 =?utf-8?B?b0twZlUyVng5RjJhN296Vld1M3p4N2ljYW5HNUlicElNWkt0bUszVGNKeFc0?=
 =?utf-8?B?R1VvVjFaR29jVFdGK2ZwenpaSmF2RXFKa21teWd6Q2ZrdVpBNmZtL2Rwa3ZN?=
 =?utf-8?B?L25CcUNWT09RclBGSTFaLyt6ekN1ZnlGZ1JOdVVyd3o2dFpFYTBNdDdHL2RY?=
 =?utf-8?B?ZGhib0hXU1RYRC9BVkJFdGJxcjBnSzNtMEw2UVZyMUFZVnVENmlscUI1WXdR?=
 =?utf-8?B?RVJUR0REcXpnR0E0TVFqUVV3YXdoejE2TWprU1puZ0pMakZSekMwL0RCc1Ey?=
 =?utf-8?B?UUFETU8zZ1JVaGtPOHQweDhCZDVPYlliVmFucm12dTVhaXRmU3htemFNei8y?=
 =?utf-8?B?R083bERlNURRZDhHSGxPTTQveEtzdmFsTGRqZjVnQWJhVUVBQUJtSjkrV3Fr?=
 =?utf-8?B?VTRxaGhKcDl3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3edbd2d-a7e4-469c-2630-08da0d6b7c4d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 07:54:12.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6PSXlvzPDZaYky2ct6Rvn5uq4G9oJ4Y9rf3+aI4+XBmag5+omcmeDmPjvQJO0T1xAHQOAuFtJyP7tWg155vJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/24/2022 3:11 PM, Jakob Koschel wrote:
> External email: Use caution opening links or attachments
> 
> 
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>   drivers/infiniband/core/sa_query.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 74ecd7456a11..74cd84045e5b 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -1035,10 +1035,9 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>                                struct netlink_ext_ack *extack)
>   {
>          unsigned long flags;
> -       struct ib_sa_query *query;
> +       struct ib_sa_query *query = NULL, *iter;
>          struct ib_mad_send_buf *send_buf;
>          struct ib_mad_send_wc mad_send_wc;
> -       int found = 0;
>          int ret;
> 
>          if ((nlh->nlmsg_flags & NLM_F_REQUEST) ||
> @@ -1046,20 +1045,20 @@ int ib_nl_handle_resolve_resp(struct sk_buff *skb,
>                  return -EPERM;
> 
>          spin_lock_irqsave(&ib_nl_request_lock, flags);
> -       list_for_each_entry(query, &ib_nl_request_list, list) {
> +       list_for_each_entry(iter, &ib_nl_request_list, list) {
>                  /*
>                   * If the query is cancelled, let the timeout routine
>                   * take care of it.
>                   */
> -               if (nlh->nlmsg_seq == query->seq) {
> -                       found = !ib_sa_query_cancelled(query);
> -                       if (found)
> -                               list_del(&query->list);
> +               if (nlh->nlmsg_seq == iter->seq) {
> +                       if (!ib_sa_query_cancelled(iter))
> +                               list_del(&iter->list);
> +                       query = iter;
>                          break;

Should it be:

if (nlh->nlmsg_seq == iter->seq) {
	if (!ib_sa_query_cancelled(iter)) {
		list_del(&iter->list);
		query = iter;
	}
	break;

>                  }
>          }
> 
> -       if (!found) {
> +       if (!query) {
>                  spin_unlock_irqrestore(&ib_nl_request_lock, flags);
>                  goto resp_out;
>          }
> 
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --
> 2.25.1
> 

