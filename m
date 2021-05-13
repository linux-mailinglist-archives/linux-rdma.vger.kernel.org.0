Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323EF37FDC6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 21:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhEMTFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 15:05:01 -0400
Received: from mail-mw2nam12on2102.outbound.protection.outlook.com ([40.107.244.102]:24737
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232073AbhEMTFA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 13 May 2021 15:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmcxj9kwvdmNJ/Ewi2WZNu5lP5NYDi317kYlFfNyVa1Fcy03N6ACbv0HNTVfNHzvV0mxFikBlPdxZ+2LQaItDGZhFtz5t3v2KdRX85q8qrDPHw5pzXKZ2Tln1qs3zpGHtc5HJsJJTRp/AyhpMeQqwAPQMEZoXIDCNrXb4dVeUY0NWX+WO+Cmg79v3kwR/QcvFsRL78/LdY4QkNe7fgnVDeNcPRDJdDf3o12FTFuDmdpxXCUgkbsbTH7joZtvXyyntj1FaBgVSvm/s5rSWOBzClYuuzp/U864nORUzOvfYFzqz5PL6MYiiYncjKuHE3oczFOIMej/paZ5jxQAhUDTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAbAI8PgR+DInJF0pJE+oIhN7+BgSuv1IZ1VP04gd4w=;
 b=OQ7kU7/rE73erQh4IDezRk5+oVnz1SQXl0ltu4RCcd1mkSLYN57MhRRWPHjWzOkj0yC9d61wc/Ms+eybxb/7POI/bVQUW2kFazPkl7i5WoHNI32OEdOFeNsNgH5cfiVBrXqlfNbTgYQHmQnnKrBS/nvOKgkEebEwDUgkYzxFE/8DMXiTLLq2JT3K24NRfgG7XaCuH54e2yjcRWFuMXWSy84BgbHS9a2RM3HjJT3URPm7HX7oUV2+l/nQUM23H7dsdtnCUcKIDny+0YadC1PmsKos19fZ0MWD5Sk/xQ/epkwT6tcp7wRe4L4rbHHrlti8b3gW+4S7MvFES6Ph780ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAbAI8PgR+DInJF0pJE+oIhN7+BgSuv1IZ1VP04gd4w=;
 b=NPgPoWS1kOwuj7hTXTL6bO1zX/IQ9KUEHAuiBlsYLAjRqc8fh0N3mwzD2X9A2aYgRWqQgQGgeFvWn1B2WgPvxFqtotmUC1Jh9Zx7TGNRHYTpLASYIxIHM33ZVXlHqKDUPJl0W/fsbfSTdJRpTZC5Vqa87cE9VlSU9OeFg9t19Vj2SQbiQeLEBV01uqEZs7lssvQecUdVks0g7w+m+lIdW1rKccLS2Hu3u/xZw47i6GTOZxPGhg74c56GHoqbJbM1CtwVZH0pzIPwSIyHyKN+9Nk6WWVg5CbpaIgBS3DZWem5bmXYe5ZeeMVtjqlwwYR+19Vrk1W7BwDhnjwpLko6OQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6407.prod.exchangelabs.com (2603:10b6:510:c::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 13 May 2021 19:03:47 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 19:03:47 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
 <YJp589JwbqGvljew@unreal>
 <BYAPR01MB3816C9521A96A8BA773CF613F2529@BYAPR01MB3816.prod.exchangelabs.com>
 <YJvPDbV0VpFShidZ@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
Date:   Thu, 13 May 2021 15:03:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <YJvPDbV0VpFShidZ@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:23a::20) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 13 May 2021 19:03:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e54ee7f6-b4ff-4ed7-a5ee-08d91641d5ca
X-MS-TrafficTypeDiagnostic: PH0PR01MB6407:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB6407A718A70E7403BB4DFE68F4519@PH0PR01MB6407.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq/ETuuySHrS69+/OEMr3EOuYDoDIdgU5S+JVIOANAeBKZfHuHOmh3P/idfjpCWvx2vw9foSobkyutWfuzsnL7PGbr1KUl2Ikoi9tbung+ERmqM6fj0kvk0qS7mFn1nZunwS/FkTkjma0Os4pBtBtG5Z9566WwdE4mRlnvlUdoembpJ8ziyRjBgMjl9ZWWshwWf5Jp04lFvX6efadrbocpZMrNE3TIzNeIDwPyDxsK0j4mipQj9WeE7kXiBws1y7Ats9pMHvpst+99RL+hvBX/vaIQAuArNwBcMM0GmUEA8Ubv8D6Z4WAN04Pr8LrS+vvEcC5lVUAIkzDoD4IhcBPcAJxOa4PLxfPIVm5RvD7ELVbmzvDYnMLKDSKfo564a7a1ZCBGeCEw38t8NzYKnjfFU/GTbhg8Noqm2tPRhQNRKb/79hl7EvG/rxmsBZNUrzP2PA/F/QwzQjAWCy3+6zlEyD9RcyTvXFyBGTwIftL0bfdfVbZcaRQ7ndnzAOLtEbNKjwQGUb9h/WaCk+ORutbiYOkQb4uoO87YjdSiD2F6W2OyyR/5Xfb1jFMj2TegIFMyrSC91vZMG8jvzB75a8VJIRJ85PtKEcwwlA6xDUqtdVmhECwzYYpzCFrQc3wPcmVSv8+53GOKmmohB1ANEGQtfNGYgAjI5cFvBAe+Y+iAdNvVw5NaBunIImb38rqMCEtn0Jog9l5KsBpziu+PtCW3gfM7R09TrMYpguUZeyU0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(39840400004)(346002)(396003)(316002)(38100700002)(6636002)(38350700002)(8936002)(6512007)(52116002)(66476007)(66556008)(54906003)(110136005)(2906002)(44832011)(478600001)(36756003)(2616005)(956004)(53546011)(86362001)(31686004)(8676002)(6486002)(4326008)(186003)(16526019)(6506007)(26005)(5660300002)(31696002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHgyQVVZRzRvandISmU5SENXbFdMYlJhUlNhVDJRbzRXV2V0aWNuQUYwcFli?=
 =?utf-8?B?TndtdUF5SWI5ZFlRYWZSdGRLVUFFeEhhNm5sa25JMWNUYnRiNU9FYjBxOGZ2?=
 =?utf-8?B?OU4rbHk3S2pKVkorMjBVZzZnb0tvOEtad2dJWVdYMVlCcEpNWitLS01DYzN5?=
 =?utf-8?B?UFJud05Pay9CNTZ6ZU50U0p1Q1RGU3BkNlFOaVArNGZ5Rys2VFBUdWN5aHpE?=
 =?utf-8?B?emcrbFk1VGIrSVIveTZLdENWRkdvblc5MUhQNW5JYmRJa2NlSDJHa1J6eURv?=
 =?utf-8?B?ZE9OMnZFZVIwdzlMalZhbVV3OGVMQmJCNzlraGFTOWNkQWFtaDcrTEsydjNp?=
 =?utf-8?B?R3ozcVVnME51Q2s3MkRLRFk3QTZQNm9RMzB5UnJWNEkydDEwckZpZkUvVUpv?=
 =?utf-8?B?UFd4VC9DNXJXdkNpajVsRzBJY1pvQ1dMcWtDNkw1MGxUNWdZeThpV2RxVU5h?=
 =?utf-8?B?Yk5qaFo2SjNZSlVIbjI3QVVmYlJUakhIemkrVHR6VWxBdUsyd3VvdDJqeEdX?=
 =?utf-8?B?YXBzOGxIOUZBQ0RBMnlXcFR1VUNUL0xpRjVOVm93UVVIdjR6YjZ1dWlHQXpY?=
 =?utf-8?B?a1lmbjdVQXRsSU4wTkR0SGRvSVQ4ajlzNG9DUVBsZXVadUw4aG9iU3VHdG1l?=
 =?utf-8?B?MHYvazVBZTBhOCtsNE9mbk56TWk1TUdBZHR5VnBEc25rKzRFbDN5RlZJelhT?=
 =?utf-8?B?WXNZUUtpU2w1SDhDNTQzVnVCS3AxYXY5aXprbGVNdzRMMDh4Ny9yRzl0K1JU?=
 =?utf-8?B?ZjZHZjY0WEo4YVluQUVRWWdZemlLZVNXRmc4TXhKSHdjNFNJNHFQcDdNRkIw?=
 =?utf-8?B?SGZEZlF6SWZNekxwL1B5TlIwSWNIclgvWkYzS3kwWnk5cU82UlZxdHNsbDlC?=
 =?utf-8?B?Ky9xWGxSQWFKSHN4YzZrbm1ObWs2Nk5TamN0OWZwaHg4YmlPd3A4Z0U0RnRJ?=
 =?utf-8?B?ODlHaHdUNUtRMTRDYU1pa3cxOXBPS2w5V0FwSWpVUkFLVzgrNlEvdW5sZFFH?=
 =?utf-8?B?dWdMSUhkU3ZvOUdKU1hOWFg0MVFKbytaR3ZpZll2MlRHUm1uNHhVemtWTE5L?=
 =?utf-8?B?TjhMMFpHV0xoUnozRDlpM2tMeFA1K2VwbENNS0lHd25saS9DSkhoK0VHQ1lY?=
 =?utf-8?B?V05ud0NtLzFUQ3JLamFJcFVsTSsrUG1CZHNGYXFwWUpMa3IyK1EwaTA0S1Ro?=
 =?utf-8?B?S2pKdVE0N1ZzS3JGWFZKYnZsN0tRSHNZeXBWRUJMSkZEeVp6VEp1Q3ZWRGk1?=
 =?utf-8?B?OUtXNGM4RCsweWZZMWdaWGl3MjF3QTQzc2cweHc4UElDQ2FTMTRtcjEyWkdv?=
 =?utf-8?B?c2JpVUVlWis1ZytsZEFwMWJRcXZoTWxtVk40bnBRNnlrbWRPMExXMjM2dk9U?=
 =?utf-8?B?SHViR05vZ3FJZU15UkxoTHN6K245MzhqZnI4VjNRSU1SR3pOZDd4bFZydkls?=
 =?utf-8?B?MmtEVkNFcFlrU05mcDdZYm1CU0RwcllQdTduWjhQRGFheXBTK1VONGVvTHdJ?=
 =?utf-8?B?VEc2cUtTSktwVTBDUkM0OC9tZ2JrMnZQbEJmVXZUVWpOSXVRSno0ZE9jdkcz?=
 =?utf-8?B?YUxSeVgwYmVGWEhkV3ZiaHVmWEpjWjlVdFhwOERYMGU2QWJnNXpXc1RpTnht?=
 =?utf-8?B?bHhiRHJmelNBeE9mOGk5QzRNRFdheS8xRmpwcHV2WkhrOUxta0ptWE9BRjV4?=
 =?utf-8?B?cDljbVI1VENCNHV2OFd0YURDazVzeVVrNnRmM2tMVFpxblZQSm9sQU5zSVZu?=
 =?utf-8?Q?tH/tJ5tHPFWJ6xYXR/xvWCDApmq/FNwYKi8sf7h?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54ee7f6-b4ff-4ed7-a5ee-08d91641d5ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 19:03:46.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5NX3c/GDnFuzrGeGoElQoMvnegN020wYNuUKfJir8WJl4Z3kr9tUIhkI2GijpOkVZ+pq1Djebc7UuO6DKTYwj8kQnrsgw8AwdB2iaFTU4oZ8qoxc+AcOl5bwXG9qRCP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6407
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/12/21 8:50 AM, Leon Romanovsky wrote:
> On Wed, May 12, 2021 at 12:25:15PM +0000, Marciniszyn, Mike wrote:
>>>> Thanks Leon, we'll get this put through our testing.
>>>
>>> Thanks a lot.
>>>
>>>>
>>
>> The patch as is passed all our functional testing.
> 
> Thanks Mike,
> 
> Can I ask you to perform a performance comparison between this patch and
> the following?

We have years of performance data with the code the way it is. Please 
maintain the original functionality of the code when moving things into 
the core unless there is a compelling reason to change. That is not the 
case here.

> 
> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> index 4522071fc220..d0e0f7cbe17a 100644
> --- a/drivers/infiniband/sw/rdmavt/qp.c
> +++ b/drivers/infiniband/sw/rdmavt/qp.c
> @@ -1134,7 +1134,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
>                  } else if (init_attr->cap.max_recv_sge > 1)
>                          sg_list_sz = sizeof(*qp->r_sg_list) *
>                                  (init_attr->cap.max_recv_sge - 1);
> -               qp = kzalloc(sizeof(*qp), GFP_KERNEL);
> +               qp = kzalloc_node(sizeof(*qp), GFP_KERNEL, rdi->dparms.node);
>                  if (!qp)
>                          goto bail_swq;
>                  qp->r_sg_list =
> 
> 

-Denny
