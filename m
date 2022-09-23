Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515B5E7CE1
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Sep 2022 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIWOYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Sep 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiIWOYu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Sep 2022 10:24:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826891EEC9
        for <linux-rdma@vger.kernel.org>; Fri, 23 Sep 2022 07:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAihKnzTAMjvIZH7LlNbtGMbIq9/jSmhZuc3QQG+3kmYWeJL4m4ijJmq7Bq8RIRexjf2dbWlUWo7NEUoFav+RQ4v8OPqAO1XrYFSOHlnbK/XiaVsTrB21Kigi6bklvW7HHULxzVo7JaXB6FLcFzjLgCou+T8GqsNtzYXLOk42TF/IEo1CuzoEtXII6I8PiFReEyzzTJ0Ro/bIkjn3LSVMIXBkvZga64WK9u/A4SeCeenam41QWTrpmY2JMDC/nMyQ6fVDHt/unZK5PQohWP6sEnCI+jcB3PPFIYnSvoh+DiNoPVxHDXQZiF7vNaVohAaMzaXY/Dasm0//NMFlzS9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhsNkB+wv58+xR6cH+wFzNUGkuoo3mOopqC6MKRpUSQ=;
 b=KwLFs/3lUhSI1BbuusX6HnhlZeJAzvQemYiqptbibRlcF4Rq7eA7XDFYsQCzRhJlPag6OybM1sC16x5xEOWncVTxu9giUCKvSknp2cZS9vHn9WhloeF9MLDeBu4dqsyOEMREWULNd824wf71OQzMFIu1mdBBWg13C5gnO183N1pFQUx2WNm1YnkrK33pLhNkHb70SSEln/+q/uj6C/x/OnARxaYdSznHYzF8E4Frdr2P6sHR6grwxmxG7J4gluvDtvv5sf4VQCPpMFqn67bnlMTo6kmzpL6Dba8L8EPpwcQxkehzU4sKT4VSL3gyh6zI7IU7Ao1QoE/vAHleneNdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhsNkB+wv58+xR6cH+wFzNUGkuoo3mOopqC6MKRpUSQ=;
 b=SRfOs7o9o/6ww8eLj31iA87TDTynEZbVmo7GZUyiVfcVgfqihCJHYtM6Bkvx+k8yRORAhN8AuBokHYDxhK6SMS9PL6Mczsd0prgT+SnI03zSw+8X8y7IVRtsZXdCftl/GH549U924Uo6axLH/smX1sco9dM5iMj7HeWxEVOjb+FjRuDEoUWN8hMXyLnpTLpUapUNfy8edvemx/54EwrOcS8DxLCF/ESnqngTs6+BUdHqFFlvdaAyYWrp8h4y1Mqamfv1rWuKek1KP+BjfGFGsh9/h3rISsNCCdUgTu80/yA94iLuCOcuwbW96ejEiVeovOpkxc3nbrZsoSXOcjCX3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 14:24:45 +0000
Received: from CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::1c13:dfca:d0c5:4d5c]) by CY4PR12MB1366.namprd12.prod.outlook.com
 ([fe80::1c13:dfca:d0c5:4d5c%10]) with mapi id 15.20.5654.018; Fri, 23 Sep
 2022 14:24:45 +0000
Message-ID: <daa5f761-9672-8598-1533-39eca4efa972@nvidia.com>
Date:   Fri, 23 Sep 2022 22:24:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rdma-next 2/4] RDMA/cma: Multiple path records support
 with netlink channel
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
References: <cover.1662631201.git.leonro@nvidia.com>
 <2fa2b6c93c4c16c8915bac3cfc4f27be1d60519d.1662631201.git.leonro@nvidia.com>
 <Yyxp9E9pJtUids2o@nvidia.com>
 <969cf0aa-a066-5142-d917-f07130974764@nvidia.com>
 <Yy2w+kxp7ebtsdFE@nvidia.com>
Content-Language: en-US
From:   Mark Zhang <markzhang@nvidia.com>
In-Reply-To: <Yy2w+kxp7ebtsdFE@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To CY4PR12MB1366.namprd12.prod.outlook.com (2603:10b6:903:40::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1366:EE_|IA1PR12MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e290cf8-cd89-4463-19f8-08da9d6f5c90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJBuTMTbx9qzcEN66mGrDA8tmwvz3tp7CXVFNIWNLurifJmVNMaPoKVFfF0x0FW72Qn0EmtPUXp6D6FqfkzsTABgzCwxzO5bVC/wfcdmyeyFnKTe9eDlk16kAytQt+4QtmJxyNuAJGb8t6ZDouJMwsY4NX/dY2GfOFHRb5HTMgXMYPLZHmJb6M1tWm50Cbs8NybthZ/wWhcvVEaRxxBiPPnh9C0QCecCysfHvItON5pA5aj3CjDFjO/yZxI9CdKURW92JXaxqNQi35NOHd2mEGrZE9Z3LkzIYIUQ3Pr6jDNaHb/Rwq8sx/CPp+YAjNFeCsxf29OxgJ924hYxXhlj15YI/dYQo7cBOn3Zash04DHEsJCWtlnln+XTLwky8hVNdu7UqqM1l3RmGsPDShBHkCIyp7PMrMoc+2tKvrU5EmMgY8AuCaUQJnvtFEh7JY05PNFpTY1+okPjQ9dNwq2Mf1l3aLkwKfMbtOYEiq0AKhTST8F+QgruttSWRA/6zemjtunBUJ4XQzHvqT/gDhgI6SQiP2za5XU+TmhnVvHYSmEUZ2A2YxZRnfmMBXy7kAs909fPsxnNOea85wYydEankNXKnPb7/rABfi9kxYvvuxjIBdfyABpLTMmb+LGrOUIWlZtXBlW/r7wT9mKKGij7VBMig7OCX1nqxXK30joA9HZv3UghbXKwson5R8/+iPwUZSUdHxnTu6Q79jd2xuNZNBxcZZpRuPT+rp2ssm9UWzSJO59SxWTuUeWTwx1S2CVk2EqHs2V8SD3/Hq4uF617Asr4rqc6sgB/lcxoJ2tdPNY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1366.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(83380400001)(4326008)(8676002)(66946007)(5660300002)(66556008)(66476007)(41300700001)(6636002)(316002)(2906002)(6862004)(53546011)(26005)(107886003)(6512007)(6666004)(8936002)(186003)(2616005)(6506007)(37006003)(54906003)(6486002)(478600001)(31686004)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFljSk0xNTB1aW42OVR3WnBQRzdaRVg5WTdRTFNrYlJNZWYyeDJiY2tHTmEx?=
 =?utf-8?B?VUtJTU1oVjNSRy9OWDJSaTFjZjdGVUErYUdaT1JHQStIOHpDa09MQU92U0pD?=
 =?utf-8?B?RnBVZGtUU08xSER1NmtlMUpJcCtIS29wNU5oYXRYL2wreU5YcUkyU3c4cUNL?=
 =?utf-8?B?YTNtTFpuWHpwRTh1MVNaMU53YXFRN3lNM2dFUDFVYTI3R3dBNlV0Y2kyek9K?=
 =?utf-8?B?cmZGLzE0Y295SG9GQXk2YjFCQU5DUkpsRXZEU2RWbnNES3hYT0NkMHZpQUVZ?=
 =?utf-8?B?UDVVZHR2ZmxJRE5SL3hua1NKVHpNWHJiOUVDTmVBOXUrVElNQkQvbko5dFRn?=
 =?utf-8?B?N3BvYUliV0JDSGlDZ1pzUE1Cc3JPRGphMndTTjFiZEdNaEJuU2prckVpTEVJ?=
 =?utf-8?B?RlNvTHJ1aWkraUNQRml0Z0ljWVFXdjBCTy8xY2FrQzFHUWM4Y05LbTN3UEF3?=
 =?utf-8?B?MjExQS8zd0lkMHVUdmRkSE8yREZMclZpV2s2d05tQS81aHpQd25oSkdjR1dE?=
 =?utf-8?B?aVBObUxlWXJONjZPYUdRNEN2cEljUW5uZWwrTUxJankwWjRHT1dQcmxNS2xM?=
 =?utf-8?B?ZXNuRGRUVW1ndW0vM3ZHR3EzbzZNek80THFLU2JFMDMzUncxc004dGlvU2ZF?=
 =?utf-8?B?TUhEUGlpbzd4Nys4eUluajgyR1gzOVdYUDEzbVFLNlVGMkhPWW1EY0Vta3hN?=
 =?utf-8?B?aU8zd0xvNWRyV0RwYlVVeStnWHV5OGhaNzN6bFNjcjkxUnZ1ZWNCNDBKNSto?=
 =?utf-8?B?andROVVVZW15eGdFSnNXbWVqYWRObUNVTU5LVDdVUk1kN3RqVU5ueWJUM3Fq?=
 =?utf-8?B?K05NeERGMEx6eTZaZFdsRk1wOXptSUdyeEZwMWZOc0xXOHRTcGRWZXBVWGpS?=
 =?utf-8?B?TGQycE51RStCZDRuYVM4Q0JuMUhkeFVjU1JLODF1MnpXWkhkemJxQVduWVlP?=
 =?utf-8?B?UWYycklaZHI2cFZJQlU1cDNKbTJUT2hnRWlJZzVwdktXQjBySWUreDFnUVkz?=
 =?utf-8?B?UWF5RG5BUE9aR1lJK0FXTlB6QjNXb1E3MHJqNmZIc0c1UnQvZk9mS1gyYUZT?=
 =?utf-8?B?bExWT0Q1cFpYc29YZzRUQXBQRUlkQlIrcHVMWHpjbmJ6SWhMVmV5NFpFUjFq?=
 =?utf-8?B?Y0FtWEZFRUxoazdQMUVjWlNhaElJZ2NsLzBKbmlNNkMrdHJXZGEzNHpMV3cy?=
 =?utf-8?B?dEV3ME1IRGFpc2M0WDJBNndKVmZiTVpjWFpnbEFxY3pUNEcxTnFhTGl6NlNP?=
 =?utf-8?B?aHArUmExQVNyN2kwZzZUb0VSR3hZNk5KQ3ROMXFmVC9TMjU5YndlWGNQbktF?=
 =?utf-8?B?V1A5eWh2Z1NYRGU2WkFnU2d3alg1SVhKMWJSK2RvQWE2N0d1SjlUY1pkREJS?=
 =?utf-8?B?UjlkeDNJZi8wTGJMY0cvdEg1QnFJT1d2NnpBYTNBcEdaZGpNdnpWNDh4N1Er?=
 =?utf-8?B?b1V4M0txZkdTcGgxWlg5eG55UjhlazRQU2NrU3IxczB0MTJtTVNneWQ3c1NL?=
 =?utf-8?B?Z0lvdjE1TFA2VE9TakNXRjRjdlYxN2x6T0w5UWpoWDJHblhPdnptVCtjWEhi?=
 =?utf-8?B?KzZ6UGJHRzdzOVY3SmtHd3RrSlllYnRTSFJDNWp6THR5VHFuM2hKbWpIYkNC?=
 =?utf-8?B?dXFsdGRvcFRURzdSRHZDWlJCVm1vbjl5SWRlUTFMand5V2dkVVVWSXQzaDha?=
 =?utf-8?B?bkl0Wmlad2xPNGpCN1RrdEtMaVM4NmdpbzV1Qk1CMDBLVlNhQWsyeGtBSC9E?=
 =?utf-8?B?R3lDNXdZWDFMWTc1QWZjRjg1cTRkQ0gwaTQwanpTSlpoQ1hZekRldlZBWHpy?=
 =?utf-8?B?bm8rMkdGYm1NMUlTQlJYN1BVcGV1bENLZ05Dbi8xM1d3Y3hzYTlOeDR1RzAv?=
 =?utf-8?B?SlBaV0dQK05SOGl2K1NNOTYrcXhwZWk4L0tNRTl5WEZmTnM0QzVSbEVlMFpN?=
 =?utf-8?B?N2ZXb0FycE5Scm9ZSlVPKzl4em1iSXdFSlRVNU1PT1NZWE5obzY2eVN6aFdr?=
 =?utf-8?B?MjBKWFNXb2owY2FpdnFPMFRoUnVSZXo1R0FkWDNTWDFQUWpWaDJZZW4yQTBV?=
 =?utf-8?B?UlJZS2psSzJFellFRm5hNGdLYW51NGVVanBjUEVJVGthazQzRFFaRmdwUWtj?=
 =?utf-8?Q?xypHZaErAXmt/m7oAtPFXu8RK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e290cf8-cd89-4463-19f8-08da9d6f5c90
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1366.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:24:44.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYI7PXOIOcDBMjsMtr/WVGDAvwTU8tEQzcz9wrrddN10+9uy3ZTCkL+E3qSCR2YbDdRi0tL2H+CV44zC7FixJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/23/2022 9:13 PM, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 09:40:22AM +0800, Mark Zhang wrote:
>> On 9/22/2022 9:58 PM, Jason Gunthorpe wrote:
>>> On Thu, Sep 08, 2022 at 01:09:01PM +0300, Leon Romanovsky wrote:
>>>
>>>> +static void route_set_path_rec_inbound(struct cma_work *work,
>>>> +				       struct sa_path_rec *path_rec)
>>>> +{
>>>> +	struct rdma_route *route = &work->id->id.route;
>>>> +
>>>> +	if (!route->path_rec_inbound) {
>>>> +		route->path_rec_inbound =
>>>> +			kzalloc(sizeof(*route->path_rec_inbound), GFP_KERNEL);
>>>> +		if (!route->path_rec_inbound)
>>>> +			return;
>>>> +	}
>>>> +
>>>> +	*route->path_rec_inbound = *path_rec;
>>>> +}
>>>
>>> We are just ignoring these memory allocation failures??
>>>
>> Inside "if" statement if kzalloc fails here then we don't set
>> route->path_rec_inbound or outbound;
> 
> But why don't we propogate a ENOMEM failure code?

Because inbound/outbound PRs are optional, so even they are provided 
they can still be ignored if cma is not able to set them (e.g. memory 
allocation failure in this case).

>>>> +static void ib_sa_pr_callback_multiple(struct ib_sa_path_query *query,
>>>> +				       int status, int num_prs,
>>>> +				       struct ib_path_rec_data *rec_data)
>>>> +{
>>>> +	struct sa_path_rec *rec;
>>>> +	int i;
>>>> +
>>>> +	rec = kvcalloc(num_prs, sizeof(*rec), GFP_KERNEL);
>>>> +	if (!rec) {
>>>> +		query->callback(-ENOMEM, NULL, 0, query->context);
>>>> +		return;
>>>> +	}
>>>
>>> This all seems really wild, why are we allocating memory so many times
>>> on this path? Have ib_nl_process_good_resolve_rsp unpack the mad
>>> instead of storing the raw format
>>>
>>> It would also be good to make resp_pr_data always valid so all these
>>> special paths don't need to exist.
>>
>> The ib_sa_pr_callback_single() uses stack variable "rec" but
>> ib_sa_pr_callback_multiple() uses malloc because there are multiple PRs.
>>
>> ib_sa_path_rec_callback is also used by ib_post_send_mad(), which always
>> have single PR and saved in mad->data, so always set resp_pr_data in netlink
>> case is not enough.
> 
> We should always be able to point resp_pr_data to some kind of
> storage, even if it is stack storage.

The idea is:
- Single PR: PR in mad->data; Used by both netlink and
   ib_post_send_mad();
- Multiple PRs: PRs in resp_pr_data, with "ib_path_rec_data" structure
   format; Currently used by netlink only.

So if we want to always use resp_pr_data then in single-PR case we need 
to copy mad->data to resp_pr_data in both netlink and 
ib_post_send_mad(), and turn it into "ib_path_rec_data" structure 
format. This adds complexity for single-PR, which should be most of 
situations?

Use malloc instead of stack for resp_pr_data and multiple-PR unpack is 
because sizeof(sa_path_rec)=72B, now we supports 3 and there might be 
more in future..

