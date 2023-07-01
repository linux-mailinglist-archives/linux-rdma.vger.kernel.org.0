Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C89744A89
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Jul 2023 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGAQYU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Jul 2023 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjGAQYT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Jul 2023 12:24:19 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6137A135
        for <linux-rdma@vger.kernel.org>; Sat,  1 Jul 2023 09:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZY3+dSsbuc2MNERyROABsgoPhXER/3HLtsm0IJtyUr7wucgVEfPA9XS05BAlvLIHNPsIzC4hRqaM3dSDHBWbsGKkzP2DqwQPDoimC4cZEvvxIYdlQXrc2jzSyLXgG7b2kPVjmZyPoGyKxHY6dRUl2c7i/ylas1swWm2GBsQ/i1HKtpYGWM2zaHTwoVJQjtOurUhcEN+TSc4pfItcXgEaTxYVQeKQddMvcJ+L+YAmhXVVr8wWECICv3phumOncOizKC7OoAxexQmJbF6PESCPoahMB02IQLOjsXoFcSb6tI1dVxKZUm12FcuQ2kUIdoP36h9bHaphhVwV6amNdkvHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN8ZluH6YR3bPhBr99OBRZV4aCL2JZJWl5XDyL3P9hE=;
 b=aPWZfls737ABrE4x706yzunStZL8cby+8SotQcJfD7MU/4sdHo3uvQqt5K+Q+MmrnqN6WHlJcbCwDE1LwxDWOkPUzwa+3b+ySnLPOKR3oJPYepwSd/ubXN7H8PBCNJy+rE4wmMn2M8cdzFbIVBwCcOpKtpMMZF0pcVaWqJAH9TC6GD7LLUTQge2xvAC7NGfZBcUCZF5Na5z0CZqLqDePh5LcJKsUvkvtYxqCY4hQmjD7st43WDBpSlZQu12ntnunQPHGcnrwe51UmQP7IcA4Nw6Q+UDluCVFjc/XhFBigJjCD5Ccwu5XcvBv0Jyug8y4HA95dj4/taTDVj3xSLzqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BYAPR01MB4438.prod.exchangelabs.com (2603:10b6:a03:98::12) by
 LV2PR01MB7598.prod.exchangelabs.com (2603:10b6:408:17d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Sat, 1 Jul 2023 16:24:14 +0000
Received: from BYAPR01MB4438.prod.exchangelabs.com
 ([fe80::4bda:af27:33d2:a9ca]) by BYAPR01MB4438.prod.exchangelabs.com
 ([fe80::4bda:af27:33d2:a9ca%2]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 16:24:13 +0000
Message-ID: <1132df9f-63a1-f309-8123-b9302e5cdc3c@talpey.com>
Date:   Sat, 1 Jul 2023 12:24:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/4] RDMA/cma: Avoid GID lookups on iWARP devices
To:     Chuck Lever <cel@kernel.org>, jgg@nvidia.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, BMT@zurich.ibm.com,
        linux-rdma@vger.kernel.org, yanjun.zhu@linux.dev
References: <168805171754.164730.1318944278265675377.stgit@manet.1015granger.net>
 <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <168805181129.164730.67097436102991889.stgit@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To BYAPR01MB4438.prod.exchangelabs.com
 (2603:10b6:a03:98::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB4438:EE_|LV2PR01MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: d50a1f33-3d6f-4da0-3167-08db7a4f9ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AuRWad5UfXCRkHAye0hSllJGu38QoR0ePS4qDu2V7QWQh5BXutOrGnJzYL4pwuThwgE26ieVj1vXCz0UysNA2eZMepPJldJZ1swmYzqHQiu/Wnb0cP6EFsLza4mKDNa9vdjzqf4GFiOr9mZYWYjy2DZOH/5o+Asj0LbpYjVHnc7eicUMaD5s9Pdt2PA3Gn28bEV51EFa1jnnZy9wAiviIVPvvSFORFPRVqaGrESXSTLfICSTc9H4Vf7c0hY0N9IQ8WKTaBy+wS9US8gsFx0zpJXirs8xPc4YfMzd4WHV+t1HGPadJtQy0ya9xblk6K09r3qkvV0TK1LZdU3Pu4o1aZbK29SwBsaaHXHt7gU8Ive+lE/4bHa1i+c5/5Jbdc9wK34WJ2CM3Lra6L643sx1lZnMWiRL6hQ4KHuiS4OvkM/YGR3Fx9gmRGxywMC6ByooRBAr70Utz8xOmsfhtju2qwNPu4GI0EaSQMx/uUWZWfQovuse+h909f1icFh8NoKaXmGkl/Xs+7rzsonWD3w+IqNMBQA/wOZqiwWZcUFsQitMdp2mxgGDxSV5UxLRsvzpF2UHB7WIduVdqA8+1l0rqKLLuTa4ouYaZrrHNQ4vKSJDC11kqFfoy8KrkMuJCtzoPquH2bTyAuf4SXhgmpOpyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4438.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39830400003)(346002)(136003)(376002)(366004)(451199021)(31686004)(6666004)(4326008)(316002)(66946007)(478600001)(66476007)(66556008)(36756003)(31696002)(86362001)(186003)(26005)(83380400001)(53546011)(6512007)(2616005)(8936002)(2906002)(8676002)(5660300002)(41300700001)(6486002)(52116002)(38100700002)(38350700002)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEFabThmVFRXbXA3Mk1pZmlBWXYyRGtwc1Z3L2lMRHNyanZENWhWQnhmL2JC?=
 =?utf-8?B?Tkg5bmpUT3BZekRkT2h2YmpGZUxNOWJuT2YzRk1vaFRHZVUzbjR0NnNOSEk4?=
 =?utf-8?B?cnJSVHFWaWV2OGNPTzdBWTRKRTM2ekRCaVVFbk0wdW96UVRMQk4xWnBpZ2g3?=
 =?utf-8?B?Zm55TEd2N09yR3dVcUljODZwUmE4ajd0b2RUZ0l0ZHVVcDNHSVB5OWNCZjhq?=
 =?utf-8?B?NnpFVCtxRGo5NGFVeWZ5cTArVm0vbW9OWktlZVhMV0pXQzRaVm9KVHZxUXZG?=
 =?utf-8?B?V1JaWHpPWTgxWDJxWmRlQUlneWNqMzB1RFZvdzk3c1dwNHFMSEFrTlNmNGRI?=
 =?utf-8?B?WmQzUkErVENSWVo0TCtFZVk3Y09oVnRYTXRxRVJnRHF6NFRxM2RJSjFZZ0h0?=
 =?utf-8?B?MUxBY0tTampnUHdMK1dRb3VZL05adFZGTzAxckdmUkZOUXRiNWp4OUtaWXIy?=
 =?utf-8?B?N0xtUUtQY055b1RPaUpDVGQrT0RGU0daZ0xEQzQxN0JPV3psdU9OZmliam9U?=
 =?utf-8?B?L25Vc2hRTmplNkNzUEJBUzN6aW1lQldJd3B2eVZLZ0NuTDk4clVhYk9vZ1Fu?=
 =?utf-8?B?NEFndmJMdytFVkZRTENNSUlVR2hSZTU4SzhWYkd5SzQwMTBtUmpGTDkwOGMy?=
 =?utf-8?B?ZmQwRE9STDJSR1FIbC9XRmhzdUVBcFd3RWhuakFKSEgwa1AzUUhSTkxIZjJ3?=
 =?utf-8?B?dFhUTC9QcnVkMUYyUHo2OVkvd0g3OUtMeFllSDJ5U2lFamRKbTdEWXF6UW14?=
 =?utf-8?B?WmZIUitUNXRSUUpIdE04NnljR0dWY3FiRzB2TXJyYWdaR0p1UThvUGpLOWlj?=
 =?utf-8?B?OFhyMS9XZGZ6TTZld3gzZkdkcFEwMXdCVDJzYUllM1FTNTM2QThPejVGd3pU?=
 =?utf-8?B?WmxwdkRZd3k3NE1YZnNKY3NlMTN6Z2I5bE9tcVJ0KzNvTGhRRDJUMUZadWN3?=
 =?utf-8?B?WFZvNmVJT3hyUXM4emRhckc2U0QrOHFWUFFhSEdPRTBQY2lxaVNKRm9lZ1pH?=
 =?utf-8?B?Z2dXV0FGNUhrSXQzRUsxaGg3VFM5a1NkMCtLRHdvLyt5azVFVDJZdmVPdlRK?=
 =?utf-8?B?VXFNdHA5Nmo2UGxQcnB0b3prSklITzdOSjdTZ3dLVFRIb1JwZ2J2dUxMMWI1?=
 =?utf-8?B?Y3ZkcGtpclY1bDg5LzY1Y0NZYllIRHd1Y3dWWjNhV21KM242SVMrRnhRNERm?=
 =?utf-8?B?dERyNnZvNVJSRWx5WWZZSUlLbDdHa0UwZEp5WFRTWXEvR05uUGtuUzBuZmQ4?=
 =?utf-8?B?OHlXMmwvakNsSVczM2Z2UFhOQUN4MVdsa1dyaTVXeDJYZW12OUJCdTcrWDFL?=
 =?utf-8?B?UEdYRzVKVG42QjRONnNwWkdQcS9aYVJUWWpseFZsaXZaOXZlK1I0NUxxcDJw?=
 =?utf-8?B?OWxSUUJHbTNMTjRDMkkyYTlZR2ZqWkhUbi83U2JTc1ZvOUtFVGFvTUgwZThK?=
 =?utf-8?B?NUdPc1BSSWE3K3VZVzJGcXA3Umw3WWJiUjhoeEVzZ2lmVnFya1NjOWRoaTZN?=
 =?utf-8?B?YmE5dVNLT1RDRG1TRU5XTVdiUElXSWI5Nk96MTFYZHk0T1BmN253V1dkTmpy?=
 =?utf-8?B?cTVjb25rdTZTYkFFVlA0SDE0cjdOa2NWOTVWRFNEL2UyMWdPYjJubVQwbzBx?=
 =?utf-8?B?MUx2elVzY1plQWpudG1UcSt0VjlwUkgxeDN6UlF1SW1abzhJQmMrV3Z3aklQ?=
 =?utf-8?B?Z2JSeFdlbDF0R3FNUzRQSjc5L0wrdVVnUzZyamNCazBlMTBxNjNPa0ZLUVdo?=
 =?utf-8?B?Qkk2V2NVdXhJNjBxTklqbUVCVHF3TDdvV0MwRjhWMmhRMVJqNU42RUJrZUVr?=
 =?utf-8?B?cGtNRlE0c0paRlhnMkRWeGd2aTdjYVEyTEJXM3R1RU8yZTNFcVBLOHhHbjB3?=
 =?utf-8?B?UnlHV3RGdU54NU54bXlPQklzdk83QzJMV01uNzF4YTN3M2RFa0tXMFd2Undw?=
 =?utf-8?B?amcrdU16bGxCYXFWVmErRkszTStXVk5aUlkwOCtCY0tjZmtaSDNFZ2MzSi85?=
 =?utf-8?B?SCs1SnBYMzZHMGJLNEx3dlV6UW4rc3FvbEtrblJDUWNndmdoVTZCeWNkT25X?=
 =?utf-8?B?SGZabFFTeDE2QkkzTU5OcFczYWdZeUtSc0JjNkZJbHBNSHg2OE00c3lIQ0R0?=
 =?utf-8?Q?FOXav6E6mLcuucGSpfGc5jZbq?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50a1f33-3d6f-4da0-3167-08db7a4f9ac5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4438.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 16:24:12.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+ODc/xrq4PM6J6wW89NjddqdGuzoUcnTn6ATKlohfF1FXoS8UrMp00aVX0oOvct
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7598
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/29/2023 11:16 AM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> We would like to enable the use of siw on top of a VPN that is
> constructed and managed via a tun device. That hasn't worked up
> until now because ARPHRD_NONE devices (such as tun devices) have
> no GID for the RDMA/core to look up.
> 
> But it turns out that the egress device has already been picked for
> us -- no GID is necessary. addr_handler() just has to do the right
> thing with it.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/infiniband/core/cma.c |   15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 889b3e4ea980..07bb5ac4019d 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -700,6 +700,21 @@ cma_validate_port(struct ib_device *device, u32 port,
>   	if ((dev_type != ARPHRD_INFINIBAND) && rdma_protocol_ib(device, port))
>   		goto out;
>   
> +	/* Linux iWARP devices have but one port */

I don't believe this comment is correct, or necessary. In-tree drivers
exist for several multi-port iWARP devices, and the port bnumber passed
to rdma_protocol_iwarp() and rdma_get_gid_attr() will follow, no?

The code looks correct otherwise...

Tom.

> +	if (rdma_protocol_iwarp(device, port)) {
> +		sgid_attr = rdma_get_gid_attr(device, port, 0);
> +		if (IS_ERR(sgid_attr))
> +			goto out;
> +
> +		rcu_read_lock();
> +		ndev = rcu_dereference(sgid_attr->ndev);
> +		if (!net_eq(dev_net(ndev), dev_addr->net) ||
> +		    ndev->ifindex != bound_if_index)
> +			sgid_attr = ERR_PTR(-ENODEV);
> +		rcu_read_unlock();
> +		goto out;
> +	}
> +
>   	if (dev_type == ARPHRD_ETHER && rdma_protocol_roce(device, port)) {
>   		ndev = dev_get_by_index(dev_addr->net, bound_if_index);
>   		if (!ndev)
> 
> 
> 
