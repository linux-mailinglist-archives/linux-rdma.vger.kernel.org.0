Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA283582DD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhDHMHL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:07:11 -0400
Received: from mail-mw2nam10on2128.outbound.protection.outlook.com ([40.107.94.128]:42721
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229837AbhDHMHK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmXSseemnjwyRtP1h9KUCr+GjLSMzNqzken9lMyxZQ/AQrnj6OORiT+aD+J09b5ZA53+GrG/ykEnOnKcpljoZM7NhWqCX/tHO+D4nfnCIGuVQlYoCdpy/ZrJEekMiugPrtOapzK6z5KjEfujaDBlTInp+2CSfFylKYSyjKlXd8TOodzY1QAJpebRaUm7F6dYqQwv9Wri3kFDFl4vJKl9YkueSWjpM778TuTBorxI77e+GILIV69YtoyJasx4Oq7lFCHTLDPwJiyGVbl1/ANGqHI6UvUvS+VFzgUJryIWrTUQWdHORXlW4M00/wWVRXJDdv+JznbTO8aotjbT0DPDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZR5lw5M8PRHlYIn64LfYDuknYlBmJ8b3ByNdt1OE/4=;
 b=ZXOTo0rjBXwYQDd8gCQWOKrpJcOZOtisfFN7eAPiu/qpFr9HPNsrgQnteeS5W/N3860EkXjwNYQ5I1ZXLSVp/j88SMT+vFEO7NjI4gdWo7VCtLM2viZH0kUQ/mWwRCUgYV+4BfrtVK6YO8sqq0kAPMLtYHWRTlOX4MUZkJJVA0oH07cesxU9O/KEdEg64n6rg1X2gMmsL0GyIkDFR6VuFL1eWsZdSe+5ihvUe78moQP6cCt36OLl2/YbrfTmeChwOfSDOAS6VrfoqQav7yMInxlr662FuqZmJe57ntSt/SMlkNy5x+oe7qPVesZcsQ6b6nYRBISQAZULihe1S83KBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZR5lw5M8PRHlYIn64LfYDuknYlBmJ8b3ByNdt1OE/4=;
 b=XrOvLJGbxRv3UGvQv9DkzpAf7E7d+1sdsaYXremhJHMcOkp4Dg1L+NdirCBk7sCWsBeJlfXuZigwnrHFQefln5h2DhgYoNfFKaJOWmrnnCF6gqF5+adTgTF+O6apRqkIxLSQ/EVN8zbL/1woVSFVFwCYGj5gipmYzHH9/SpxjXfoPoAaAGrwilQ/x+XjVb3yW+SPtK7aumUzn7b7zgP9gJPpAZtIxzbgfWWQ/kydp+6THM6p6ou0yG4/iyWMjwsaVfdWyumAk1XZ6z15UcPx4TTG7jM7MMRRu+x0FwuNLSH/sgM4UNOp5uhPH6poElyAhiz9/HAnwc+iqif6EI6tDA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6716.prod.exchangelabs.com (2603:10b6:510:a0::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 8 Apr 2021 12:06:56 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:06:56 +0000
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
To:     Leon Romanovsky <leon@kernel.org>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
Date:   Thu, 8 Apr 2021 08:06:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <YGWHga9RMan2uioD@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: BL0PR1501CA0033.namprd15.prod.outlook.com
 (2603:10b6:207:17::46) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by BL0PR1501CA0033.namprd15.prod.outlook.com (2603:10b6:207:17::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 12:06:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e6509be-6c71-419c-c032-08d8fa86cdbc
X-MS-TrafficTypeDiagnostic: PH0PR01MB6716:
X-Microsoft-Antispam-PRVS: <PH0PR01MB6716E94E3CC42B1462F2A1AFF4749@PH0PR01MB6716.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4T23YC9u4AgmazpA5kVEYgZWTj3nl8Xjxyp8UkVOBDnxfl5bN6TSQ62l5Cc1thpUg1Xqp6Q2xV3U9sXBwQTG6heoDs6ih64C0ZkhtR5c6Yag87RGXOvnG07UdpagcdTKsYJ4uhhgAGTYeIlRGSrI5qwS4E+eMG+rLwYJWn4a7+YpLcIF/jvqZ2LRP1MqCYLg3Ici9gKdfwzRH/bw07s3fzRJ+lsrEU7P89GjySQCq5/468kGKdtH7D/DLguSRNwFQOUHXavkwZ/yNR1X/119L/kKovxizPyasbc+3z6ydLWloLYOBe4tH8fmkbXpv4Ip9CRtrZJm2ZYg+SCIJaWzDy+sxo5JdXDwb9xIMgqhtMTEOi0Mivz1kI30FNKqCuo1AGAWi182vUWn5lEWS0/HO4TMOazAYtmcpxXU3Ytv3W5w2pJJTnouDtNuY/984lKCAOghwsl231U65mRD6OeDJ1sdk0d+vkrXa/kMsXTrbQdPeySvoyFIfdbjL+ZvcBk8Sy6/hN/+0OAfkruqNCtpvoYOC6TWUgeJBiqKrSoEymbVJsO3GAlNA+sPUhnwrPOYBABMNki45mrJ9bLHpBIwcjS/IRSMeApx0PDQ/uV2y81RrtQwj+hpsEE6jSKX1oGDg2WMmEAh6GoebwlHp+AiWMwiRwz0jmLjBfsGiq3JkWbzcakrOzDl6CISHlOnGVh3G93oQvkXjSJJkNwZQeJoSoUm/KaKeDi2zjIov5d/Qp14X6VoPvqF1eRLjTSo81X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39840400004)(346002)(38350700001)(2616005)(16576012)(16526019)(186003)(66476007)(66556008)(26005)(44832011)(4326008)(478600001)(83380400001)(5660300002)(66946007)(956004)(316002)(38100700001)(86362001)(6916009)(31686004)(8676002)(6666004)(2906002)(8936002)(53546011)(52116002)(6486002)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Skc3YkEvN3pWdm0xRnk3VWFXT2g4a05BcXR5UU9sdDF2TU1ESlJJbWlPOXBX?=
 =?utf-8?B?a1dxTnY4T2hYQ3VobDg3R3R1TFFLSEZRODhEWGg3U0lDby9WSWI3Z0pKUjJj?=
 =?utf-8?B?QmJqcGZjQXhyeENmLzF4cEVFdXBmdGZINWNhYUE5b2ZMR1ZQMkhmL3dRRXlM?=
 =?utf-8?B?a0ZzQUkrN2J1a1A0a3dFU2NUU3RBNWlwWVpMM0tIdGpSaEZtUXJiOVlYS09n?=
 =?utf-8?B?UWNGUWRIOXlLMHovRS9UQ3p0TWJva3J2Z0lPZVUxeEVvSWl5VFY4UjRaMEtr?=
 =?utf-8?B?UmZJeHNPWjlxSCsrU0VMZXpRQ1pQdkxibmxyeWxGalBuTWFRcHVtbmFVY2tk?=
 =?utf-8?B?WGc0U1dROVc1a01UTXFmZDdlMzBObEZXWGFWNGZxVkt3RG1OSzJYTjVtV3dt?=
 =?utf-8?B?RHJ1dkwzb2tqbU5UVnlBUHl4QURqb3R2aWxQN0pKbDVKUEMrRnU3RGJnblk5?=
 =?utf-8?B?cHU5bkFwUExHb2RTdGtuYmJqQnZicTFXS2JVRkVqKzlPQUlrNno1VUxLWDQv?=
 =?utf-8?B?ZUVVZGFvNnpLZGtxbmNmd3o3bEdWeHFHbVF3Ty9vbWdOVlJ6Y0VRQVZwT3lj?=
 =?utf-8?B?d1lPVlVsV1NGYlZYS09hUldURGtuakszR1A0djQ3alNkeXlJakF2S050anVJ?=
 =?utf-8?B?VzloQ0JkYmRBVkVqL2tOTmJISW1WQ1ZRV0YxcDlxUWdVZ1IrSTEwRWFrbEk1?=
 =?utf-8?B?MWpxSGJMZXNOb1lLM3ZndWp6UnJDT1VwRnREZVVWYUdybmdqeDgxTGY4L0VT?=
 =?utf-8?B?Vk9tNERMbFNuYThhQzZBUGxsYXUxVjZkRlpxUVNTcGRhWjRlMEY1MFRIVlJh?=
 =?utf-8?B?MG4yYzhUajRFSFlTeW56TEs2c3FWRHl4YmJ5ZzRMNnhiazJndVZqUlJoVDlm?=
 =?utf-8?B?RXNuc1dBZEk3NjlkdjUwR2lyWVJtNWlWcElHMlFCdHZJbTkzNWxPM1F2UzhT?=
 =?utf-8?B?UGxqa1BrbFRLK3BuWWRFaWRnbmJlQnorQXlyK2txWFNQY0wrRTFkY0JRcHhm?=
 =?utf-8?B?TTRuZG9pN21BQ3NoeE5NRkpjS2ozbmtvdHh4TFdiWXdvS25wZHZDclpHTnMw?=
 =?utf-8?B?Ni9zL1poaXJyQmFRMVBpMVdnSHlEOCs5VTBKaHVEaldLL0xLUmN4aXFHaHpM?=
 =?utf-8?B?aDRUdDBpdzhtRGQrMnV3anp5b1BFcFQ2cTExU2xSN2poZGR4UDU2SjVBTTBL?=
 =?utf-8?B?UnhiUGxUa1FhcUMyUnBNanZVN3c1SnRGeUZOWmJVMXpjMWwvWC9XVzcwcy80?=
 =?utf-8?B?V0dTV3VyNGdVTWZTaEY4S1NjMitJM2UvODhPZkxkMG5GVkZzRWVYWDJWdFFz?=
 =?utf-8?B?VWwvQStXWGlxM2p0M1dvWEtTSGtIOGhEL29ORFJkaWYwMW1ybEVMMnVkQlYw?=
 =?utf-8?B?SDgvVWUzTEN3MkNYM1djSnVDQWVkS3hMMHlFb0RGSjFqbzVFeGRuTTQwNjRQ?=
 =?utf-8?B?cXZ0VFpkbnNiWXV1SHJKTzZ4NnArUUlGcVNBVXNQNkRZMDA4RFhBZWh2Z0Ja?=
 =?utf-8?B?RFpRUWxPWkY5ekJwNldJQVZzTjBsdGhhZlVTMWRJZm1uYm83WXZVRlNKTkkx?=
 =?utf-8?B?Z1pKRXlvME5aWTZ4Q2tRd2w0VjV4bmpjZ3EyZFJGcWdXS1J5RW5EbXFocXZY?=
 =?utf-8?B?MU5OT2JKblF2dCtvTVpwQytCamNlOXBoVU5PUFFXcVRISGFGanBZb3VMUGZT?=
 =?utf-8?B?b0pHR3B5RlpkN0lKc1Fxa01TdkJLbDlHaFJ4SjhGOWtYNmJSWXllZjhSWWt1?=
 =?utf-8?Q?I0Pu6AcFYgTp+NE9CQgnIZTAc4vyrqT8lwSFhXt?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6509be-6c71-419c-c032-08d8fa86cdbc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:06:55.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCtEgnfrRFrohNTNCXGWlbpYqe3zSHm4H9IhFz9CK2675kULUKC8CoQYafELbJ+fR7kVvILFuI/V4TdM6YnbeFWU9htH9FDoktuPON27U1v9Xwls93CAMKRiq7r/8wyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6716
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
> On Mon, Mar 29, 2021 at 09:54:12AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
>> From: Kaike Wan <kaike.wan@intel.com>
>>
>> This is a follow on patch to add a phys_mtu field to the
>> ib_port_attr structure to indicate the maximum physical MTU
>> the underlying device supports.
>>
>> Extends the following:
>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
>>
>> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> ---
>>   drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
>>   drivers/infiniband/hw/cxgb4/provider.c          |  1 +
>>   drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
>>   drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
>>   drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
>>   drivers/infiniband/hw/mlx4/main.c               |  1 +
>>   drivers/infiniband/hw/mlx5/mad.c                |  1 +
>>   drivers/infiniband/hw/mlx5/main.c               |  2 ++
>>   drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
>>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
>>   drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
>>   drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
>>   drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
>>   drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
>>   drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
>>   include/rdma/ib_verbs.h                         | 17 -----------------
>>   16 files changed, 16 insertions(+), 18 deletions(-)
> 
> But why? What will it give us that almost all drivers have same
> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
> 

Almost is not all. Alternative idea to convey this? Seemed like a 
sensible thing to at least have support for but open to other approaches.

-Denny
