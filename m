Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323E4396D7
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhJYM5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 08:57:50 -0400
Received: from mail-sn1anam02on2064.outbound.protection.outlook.com ([40.107.96.64]:62393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233315AbhJYM5s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 08:57:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZN/GMKI5qoSxsz5mVuCK0lTH2ICF9xdYuqOiv71llW6zwp7kMG85PtA9Qc54XydYaNze7qv9IoAFOqjxzIQi4VvxOco8tykeTyqOzUs6EK1Un/INN/5Mr1NkLu30Mi1Os2ei+4MDBgELkzvXyLEnxVRJ94zpaDjlJcNA63qVpiDE5BaRMCgmiBnwdEg9N/QvMyjByUJUL6d8e7gbLDbTnp6tbfU+SsOiUhPjUa8AiYGjHYwGWvenIzNfg0YmpxpzdTyjXP8WIHn5QVGpKTSSMgy/LzXT2si62hFdUHB5A15f58Uvwk9oJt8tOTiMNwggp+nPHZUhAHAbvAeecrCSdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmz1nLO7PwoUJaq1dw+ntoyogVhh0YKX/pfKKqXfRMg=;
 b=eB/pL8eGCwz4HXNXNlhdmewSNcxjG1QOVdMwEDiAI3P8jjWU2/tivdkXQIfWdUq8u3/ZqRog5UhkXBNBw9i4LRL4Vjfg9LOGMkSrUrVE/geaZKG8BhjDMv4ENy+3Dg1os1B66l/5SfreRhVEBOQBw/l7Wigay0zeZT1KvtJYkM50MJkIg72s8PlNBhn3hsBxeYYibghah7Z2ZjZor3eM3DKB1XTSWNayAe7Ffm3j2hUlVVY10Yy13jTCz9cfJuRTxEyY+cQfapV1Yha6GeT5DOOiZ4vtqC/gv1D9Pd8rmicIfvcfii0qdYP5ERK+jMKbdR6RvgteYSObYMIvWXF3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmz1nLO7PwoUJaq1dw+ntoyogVhh0YKX/pfKKqXfRMg=;
 b=Usp1vwutKr8elLi5txdAYy2q+M1fOkHrWfx/bIhEXZeKCsE3WUd8iU14t46Lmnp8jdKmbuLggl/z5IWtmcCpR0mGX7+soHY14DoUjNr6+aoV8QMV3YULHjU4VrJY1L28aFw2vNzkzuaxfcmHOVzN+nNAri4j1pMdLRkdFdnoc2LupXBDcPfXadOo0KA+vrNdJfdl0STubseUcNSItPV0px8oU3fXIFzY10lRCngfF+5uHGVWnr0SBKw56fCvzM6KQqir3gPiENwBkT1d00aWAa8zWFoBzK27yF5egiJ2N1xyeU0E8MVxv/8OqQqseAgrmb0gf+hl4njT6Fxxoguqhg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 12:55:25 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 12:55:25 +0000
Date:   Mon, 25 Oct 2021 09:55:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add a new mmap implementation
Message-ID: <20211025125523.GU2744544@nvidia.com>
References: <20211012124155.12329-1-liangwenpeng@huawei.com>
 <20211020231500.GA27862@nvidia.com>
 <7397cd8d-c976-fd81-8bb5-ae6c679a9e03@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7397cd8d-c976-fd81-8bb5-ae6c679a9e03@huawei.com>
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Mon, 25 Oct 2021 12:55:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mezVb-001SAv-KT; Mon, 25 Oct 2021 09:55:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff24028c-1a7d-4dbb-986b-08d997b6b672
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:
X-Microsoft-Antispam-PRVS: <BL1PR12MB520547564A7658B90C954800C2839@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3db425p1p7W85EVKAT6aFNdhgy0w6cVSqFIO/kVs6fGQS9NkDZ+g6KgB7/r/rLfF2Oy3PSETGN4vMdwSWThveJGskmJoEsx2gJgfM9O4CqP2mhse4QUuWuwj7fr1zxOSDfKQII/ZRk9lUYmyMW4PDPBcweMtd08OGsHlvjsgBnd51FYpDYoK2WgwrrfQb0iBgeRcspAvgQcniW58LgOlmiaGib+sd4c9iHh6rhWCEJBaV+6RmD3s0vaWuJu/yYkbtQXzWKaPrkxLBwPttkh9jMd9D5cjeHX6+TV9GvimPgbqQiCgttCQzSrqkxosk0FxlteiJxMb/CultunUAz6AL5s8nlj62YEX8rvrOGBd7AvXGWfPZlZnTN1Z61Y55Tfv6aDplfwsWttZfRbp7PrmTQWC+i1lCbDfAX58oByoSYVs181IMJgXvQH1Om1NbKCcW8yf44+x7hOt0tUYoydeolLiwR7kNJiVmm7UcVACF28d0C13YzCT/PH/OUOLgqETIUK9Jgll6N9AfNADPfY2iVioUW+CTphFxRrxX2qDLm74lhpfHI8cV0KnMTKz6mJPEEL9CJVUGei9y7zW7kHZPfTscLM9egDKr8+lZQCDQw/anesIUY3VGQwCBQG3e9J4k69fIk3Sq1Z32WzVq8BiH51pmfhS8rpzf5YJJXTdk5VulT+9wzNrIhmkWg2BrqNz+0E7Ir56N8vYUvSKA2foxParaWwBsSELsMXnkPtxecM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(8936002)(4326008)(186003)(2906002)(66476007)(966005)(86362001)(38100700002)(1076003)(9786002)(26005)(45080400002)(8676002)(426003)(66946007)(36756003)(33656002)(5660300002)(2616005)(66556008)(9746002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2w2TEorM0N5Uk02ZENNYnJEdEVmcHlGTWZDeW9zTDF6ZzRTazFJNUlkTXB3?=
 =?utf-8?B?TEkrYjEvKy9oSUw5ZWVqZWJNOHF6eGU5TEFzYXJEZHVGZEFhZ2pSRWhWbTZL?=
 =?utf-8?B?QVo3c21EbWJKR1UzUmplZG9zTXpONHZvVEVaVGtGMHFldmwxcE14U1ZuNDJ5?=
 =?utf-8?B?UkJSSWhBTGgxelI1azhmWjZkOE1SN1k2MWJjVnY1SGlCa05HUzNTcUNvN2NB?=
 =?utf-8?B?TzZ3bmFEaVl3RGVOSlozck1malJMTC85RWJKYjZKbFgrUVJJME55Rkhva1cr?=
 =?utf-8?B?NUs1cEMxeWVzRmlwZENNdEZxZE0yVlgrSWIvRVA0Uy9ncXFpTFVEcTJZbjhs?=
 =?utf-8?B?ajhXelNETllEZFIyai82cjk1ak0rbmZia1VjWHpHUGpGckgwT281RnRuanky?=
 =?utf-8?B?OEdDQWFBVTU3cHhMYkdIcllURmhuOVQwZkRQcDA3c05lblYxL252dXRtdU96?=
 =?utf-8?B?d0NXdWpycFh2UWlFc0hDQnBEVlY0cTluY2t6N2h2L0FNT3c0b2Q2UkFVZU1L?=
 =?utf-8?B?MCtITGNHT2xjRzdhU0Q5c1BjRWZVdUZmWkdzdmNNMXJGcGg5YmFiMUgxcmtE?=
 =?utf-8?B?aGkrc1VGYis0Z0EzK0tiOE9WZmtrOVNFdmNlWDN3bkZsUEt0cmVJWlJUUHBO?=
 =?utf-8?B?TzROdE9kbEF5YzR6QXdDcjdwNGtPSWRoSDQwa2Q2dmF3dW42ZkRDZlM1eHFH?=
 =?utf-8?B?bVQzTk9tcExhaVEzK2ZLdHIzcEc3K2dWYXFzdEgwUHVmYkhid0ExYWRLa2xm?=
 =?utf-8?B?a211S0NXbXpQTFArNUNVblVTemloeENKbENKMytxYW50dXNpRzVSekVxcTBP?=
 =?utf-8?B?V2xMQlMzeU9nQlRaTWJhQzN4ay9WUWlNWjJaWkZHZkx2V01RU0trb1Y5M3Zz?=
 =?utf-8?B?UnlqYmhTb3hUMk5oblppbHVjczFabmhGUnQwRWR4cjFSOXErZHl1Y1dNdXlj?=
 =?utf-8?B?bjBXM1YvbGQ3SFJQa3dsLy9IaXVGNmE4VHNPdStwMm1NY3NXOUdzdy9GUENI?=
 =?utf-8?B?OHRRS3pDWGlBdlA1MFZJQVNBK1d3Zk4vQVVlbzJWRXRFUFkxSXUwQWwvTHQ4?=
 =?utf-8?B?cVlsTWRad3h3TFhMVXVvTThzaVQzUmNMeFdGdXNKa2JjVkhidGFZdTUzVEMv?=
 =?utf-8?B?T3FuL1lRSU1UMjl6azRNVTVFWW9OeHpkdGM3K0JmaERybjJpSWw1cVorSm9U?=
 =?utf-8?B?M0UvVkc0WTNieTZkYk01U0tuVkdrblFIMFYrVjZOYlo5dDl0U3VMbi9MZytw?=
 =?utf-8?B?RTQ5K3ljVjMrYUpwUmFDR3BnTmltbG1sUVRTZEN3WXJWYnFQQlNmOXdMMDly?=
 =?utf-8?B?eURUcjVlTnM4YlY2SFJmWnJzbzVNNEVZVXZ0ZkpxcDlaOEJCdXR4bE4zMmFC?=
 =?utf-8?B?SjVTVFJzb0RMM2cxZWRkaUpNdHlvbEdzOW9MNldScHdwNlFIN1RJTEhWVU5j?=
 =?utf-8?B?RGswNmsyM1o5aVlBam41UUx4UTZ0S21malg4Y3NYRVMxckhNSVo0RG5lZTUz?=
 =?utf-8?B?MjRWYkU3L25CSTlCbGYxNXR1ZjZCSVBYT0Nnd2pHS0IxSlloZ2N5THpQTWpV?=
 =?utf-8?B?WTdNd3RZZVl6dFJRZUpGQjl1bEVlRk5TMDRYb3RqT3F0dHhMS0V4SGtZdGhw?=
 =?utf-8?B?ZHZyYlJaczJIZ0lWei92K2tLUFNqVGlEd1VtL2hQZXJmSDhLaHdUNE1TKzlt?=
 =?utf-8?B?dk41VDBvaHlnNkVZUkw1dC9Ybk0rL0NySEtZR3FWaTBwVU1FTklpYlQ2bmcz?=
 =?utf-8?B?TDFGZEFwSFRZVXllMnJOb2ZFd2Z4elE2Z2d1MW5IaFo0ODlzQlFVYWNQUlRO?=
 =?utf-8?B?S0dIN0hLUkRoN3RLZVY0Z09hYkErcExjRHFzcStLN1JNMkpjSkZEc3h2Vm9t?=
 =?utf-8?B?Rm9KenI5L0FkcHNtcWJtTm83allrOU9QMSt3MW8xR3lSRDhxZXFncFRCSkJ4?=
 =?utf-8?B?TDlRall5S3Uza0tUdTZlNXhnc250d1BSTUlYZzFJalpieFk4aGQ3SUR4ZzVv?=
 =?utf-8?B?emNEek1YUFdCR3QrcVFJeG1ralVNUkFRWE93d1BtQW5OTjNOWWxZQnJkZzRC?=
 =?utf-8?B?d1JKZ3JEc2hEVlRyQUpOVVdxUFVXQ0ZmSTErSFp5RnBLQVVjbWRwS1ptSDIy?=
 =?utf-8?Q?XtFc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff24028c-1a7d-4dbb-986b-08d997b6b672
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 12:55:25.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAxfIQ7lejnTkOscC9+aLKqxKqO+jItyYj4AeMu7cchqpBUpxUkNLXRk80itAIFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 22, 2021 at 05:46:19PM +0800, Wenpeng Liang wrote:
> > Just write
> > 
> >  if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
> >     prot = pgprot_noncached(prot);
> >  ret = rdma_user_mmap_io(uctx, vma, pfn,
> > 			rdma_entry->npages * PAGE_SIZE,
> > 			pgprot_noncached(prot), rdma_entry);
> > 
> > No need for the big case statement
> > 
> 
> In the future, we will have multiple new features that will add
> new branches to this switch. We hope to reduce the coupling
> between subsequent patches, so we hope to keep this switch.

Why? The only choice that should be made at mmap time is if this is
noncached or not - the address and everything else should be setup
during the creation of the entry.

> >>  struct hns_roce_ib_alloc_ucontext_resp {
> >>  	__u32	qp_tab_size;
> >>  	__u32	cqe_size;
> >>  	__u32	srq_tab_size;
> >> -	__u32	reserved;
> >> +	__u8    config;
> >> +	__u8    rsv[3];
> >> +	__aligned_u64 db_mmap_key;
> > 
> > I'm confused, this doesn't change the uAPI, so why add this stuff?
> > This should go in a later patch?
> > 
> 
> The related userspace has also been modified, the link is:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-rdma%2Fmsg106056.html&amp;data=04%7C01%7Cjgg%40nvidia.com%7Cffac1b9f0afb458a4da308d99540ce99%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637704927843133708%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BAszHlXQWWh%2F8hrb%2F8qEStm3VBrhvbMshfPN3pc6wKI%3D&amp;reserved=0
> 
> I don’t know if I understood your question correctly. These fields
> are used for compatibility, so they are necessary. The user space
> and kernel space of different versions are handshake through 'config'.

That is for later patches, this patch doesn't seem to change the uAPI
at all. The compat mmaps remain at the same offsets they were always
at, there is nothing to negotiate at this point.

Move it to a later series?

Jason
