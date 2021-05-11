Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C114F37A69E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhEKM17 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:27:59 -0400
Received: from mail-dm3nam07on2126.outbound.protection.outlook.com ([40.107.95.126]:60577
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231355AbhEKM14 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A83x/DcsQT9/0Vz8VHlaWOV4ZM8UQjYHT7HafKGACtcerNwCYSGxF7XukcdQ7gbgCI9Go+TxLtPdeYTFLKoKAU3n6O6GhkAHEA1vLy0TcEZKVI3wie0Y6aCupztskaDTfUOXWUVvdSCG0fZm3rjWl/WbpHigrxA8CyZmWDEPRSzv8NPAWLulcf9QN6xLe1PQ0c2zxppqklvHRar0pBbMTbWJdUTMFbsqHKCHMeKfdLlhZr6yC4wZvPq0q5zW+MeUdM/B5cLV/4/nTqmJ+TGn5nhvVP5R+2UHD1xvthYjDKp91AgoIBhoc3k6CnD9V8Vqw16Kvjzbfkf3BXGvXNZ6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POQIsLxKgo4pEOr/4p5ntDEf/JURPGX8i9ilA/jCpvY=;
 b=W9DWxPNUS+7wzerei814vvte2o39xl2zehU2a1UeuSgkSs1LcatpY2QBlK4VfsVhMTOXwzJpyIuV/zjeJgKtGRe8O7Do/0mqRjxnXv9MWdC8zp5356oDuc8eUucI/I4n2yipMcWqKgOZTCjLJ9dJ4Y6hHrmLQDf779Wpc4xwcCJ9a0/2+oHc+nMQOzbaFO+u1/Rxr25jv9bGKwHieTpDWif+BK1IGRylBureAvTxKkDut4UJk1Zb3TUwBwjG/osWPs7Ls/uA5ma/VxlNaqyAbYw19lVfs2oWHUD4G09BJlS2GLpnUi7RBhhRHoU0Kcl+UetxxDn59jhzDuaZunkOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POQIsLxKgo4pEOr/4p5ntDEf/JURPGX8i9ilA/jCpvY=;
 b=U4fQbBCiVgZfj0KqhSMVK0sXqPiHWOZ1qblej3fj3LNM0kzQQ9OVqq1uYWwCmxB5QlbOHKtV42AN1Bagct9b4DaqZYHz6kiIyzTid9DNMQYrqxn5wHp+csIicUUfXD6+xw1C0xmYYy2AIgKvFIMnF6LrzJ/Kx9gSTjpo2LcpMBWXDXEhB5EBOsfsG+RCvHzXK25adD4a3O80g/A85gZOrGRawmcEwyIUV5fDW31P1/VFWSbJkYL9MutUC+LVfbvfFgC5miKq2f9cYENHU469sgeqQ9cQHAPu6wlJZyINaJ4FmC8lZt+C1a4xtu6kRqJAZ34BmJpU1B12hVwkRJi+Cw==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6553.prod.exchangelabs.com (2603:10b6:510:7a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Tue, 11 May 2021 12:26:47 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::b43d:7749:62fa:2488%7]) with mapi id 15.20.4129.025; Tue, 11 May 2021
 12:26:47 +0000
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <f72bb31b-ea93-f3c9-607f-a696eac27344@cornelisnetworks.com>
Date:   Tue, 11 May 2021 08:26:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32)
 To PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Denniss-MacBook-Pro.local (24.154.216.5) by MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 12:26:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ca6964f-1196-49eb-559e-08d914780b50
X-MS-TrafficTypeDiagnostic: PH0PR01MB6553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR01MB655323CD4BA699F46F6D4C9FF4539@PH0PR01MB6553.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6P13CmBQ0zDeFm7VZDjUQ2n/UIWmmTmGstI7Ib6cD2F5Wjb6sQmUVZTRdEnLbL6Q83mALNio2zwJ48F51/r/6XXbCThPFK/q+d/56TXKfLOzTV0vXzZ626N5dbvWfwBn2O69IPWMAIyoTZAI1QQbRtvm2NvT2JRQ4Y978Bawja99wDODP9R4lrTP49Bzi1IBDqlI4wJCBRiFOULe9IzW79uw6fX2Yg+2AvvkURHBnXYnHNzKRCQMZN0vbnub1Qe2HdwLr6c985wVyL9Gw5+e3oJRDPb/stA7FK7cj1uQ5TIYLecdSCKk6cIuiyFoqDmGG7YREgVc2ny2NLMbM1yFRP+SgRWbtbCpklJ8RqVUxcXAI8Y3VoW2H9tlGmLEi+AY+yZ6YJwkVlx2J+1osBpgDgmJA4iLQEgox1W+l8VUE0m2uVPtBAwpbpxet7rs12uZdln8WLhyHFVG449RNer5RyfA79D7hA9ncQXjsQZ4eQqxeJYpT0p2tx3BL1kuj+reCajfVSpahWCc4IOjXWzN6m4rvARgNT1Jmd1iyas1DOTHiXj65mJ7V3g2OK0CjCzhRhZ08URWkA0qBl2k1eP57Z5sOGlsWED1LvqQeczoh1mpVFX8OLkVYZMlhBIMz5rFJRZe1kQlw7LbpaxmqY80MyaWM66ijSte9SAZVxoIoU9J4xtbW0DZudEsTm7264x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39830400003)(346002)(376002)(366004)(4744005)(5660300002)(44832011)(31686004)(52116002)(53546011)(4326008)(83380400001)(478600001)(36756003)(86362001)(38350700002)(38100700002)(6486002)(110136005)(54906003)(2616005)(956004)(66476007)(66946007)(66556008)(2906002)(31696002)(316002)(107886003)(8676002)(16526019)(186003)(8936002)(26005)(6506007)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWc4YkJuL1FtTnAzU28vSUEvcldadUlPY0VqblJGSFpZT3RKOVJvTXVqdDZE?=
 =?utf-8?B?TUl4RkIzd0dtWURnanE0MTllNUJlUVRvdmozU3BpMEx6UEFkendaT2NvQjFa?=
 =?utf-8?B?R0tVL3o2YUhsc09OK0UyM2MzN0VUUjcwSmFXdU5lOURtMFFpcFV2WVBxZUtx?=
 =?utf-8?B?WU1DUDdET0EzRDZ3YTM5enYyVlBtRXlYNmdSQlo3aVp2S0s5Z1pJYS9FUzMr?=
 =?utf-8?B?aWE4NDA4bmV1V0FydStJWlpwYlkwTW8rczRsMzAwQnQ3L1AwQWg5UFlKd3c5?=
 =?utf-8?B?N2NGNkdRUmw3QjlCSFFEZkVHVHpDcjhveC9jZWgvVXpwTk1oa2lRdk5zUzFN?=
 =?utf-8?B?MXpZN1BPeXRJREVKaGEwVzNVc1NYQitSRURiMTlrSTJ6QWdNc2RVNk9EQXJY?=
 =?utf-8?B?QnRJQkRIOFNXQUg1TnZiNE9jMUkxVWNVdndWSXlZbmFmbGJlWS9EK2pHZlVF?=
 =?utf-8?B?dzMwSjRoWWdrTm9vaDEvSXprRXN0QzdJU3JCSmR2Uk9kZEp6NU9ILyszaEtk?=
 =?utf-8?B?M1hJdlNMdlZ0NEw0T3ByOCs4U0VZZFJFQk12anFjZi9jQUVrdzVTTkVRelpN?=
 =?utf-8?B?VG5NZ2tMMlMxa0RMdlliMTBPRUxIVnFkM2JDTHRPMWVuSW0wT0VUaUFWS1Vt?=
 =?utf-8?B?cXVsdjNzaEUrRlA2WFpEcGVsVEFzbU8yNGdPbUlTYitucUhWZVp6VktNUmJG?=
 =?utf-8?B?dFBzNFdFL1gwYnpvd0NuNDVid2hGZEJFUEZjdXVxQW82YWlhOTUveVQ1T0NV?=
 =?utf-8?B?TG5oWUppaHhHSkRBWmJDWG56YlNOTkVxbFZsRG5peW1SdU10SlpKMnllVTh3?=
 =?utf-8?B?dE16ZTBvNDRjWlFLdkdEVnV0VW11ZUdaWjBUUkcxOHZQZGZiZEZ6K3dUdVRp?=
 =?utf-8?B?cnV0ZjBYRldkOUdDNlMxUldsYThTVFRQZmJ0RldhMEVsZFVYR3NTNDFraEN3?=
 =?utf-8?B?RTdreGVWK0g5RGx2TTRIQVA4QzZnSUNZRlpCUnJKZlhEb0pwcXptdTArWDYr?=
 =?utf-8?B?cUdBTGtadHdmVXQyNTBxKzAvdUZNNkpxK2doL0p1TmVPSHpaSHNhZjVkdVpY?=
 =?utf-8?B?MmVnQ0hUWG04RFVtbmJwRU1kaWZjbWl4elpKZzBCR2poMnU4dGFzVFd6ODBa?=
 =?utf-8?B?dGt6cnVObGhXQXB1T0t1RWhjT3FodDhmMWQxcDAxT1V3V1JNSDBBajNMZ0dy?=
 =?utf-8?B?bHhibG9STjBwdmw0bmdMVUVWWmJCcTAwS3ptRXJqLzRtZk1lbkdDMTlwUFpV?=
 =?utf-8?B?L21ZN2l0VDhzVjNHcGdNdGdVZjhNbFdaUzgvU0V1WklCZEJwVVhKc3Y5bm5L?=
 =?utf-8?B?YWhKSlB4Y1RXZE5DQmZYN3ZOSktkaFVlVCswR0lpaFBIeWIxNDczUEpXcFY0?=
 =?utf-8?B?cHlFTEY1ZUZzdDVyM3lEbHduUkM4Z1hBS1NsOE5WOHlyUG1xb3lYSjVIR0Uy?=
 =?utf-8?B?MmltSmJ1N0htSDhuUUFBWDY0eFVKV2gvbXFGKys3bE50WW4wS1J2NVQ0U082?=
 =?utf-8?B?UVAvWng4SVlsSWtEYnR2d0RsTTVkaWN0OEFqTzJwWnFlVkEvT1g4Y05WWEFJ?=
 =?utf-8?B?VHNjQlpMTFMvNE1vRmVndmlyTm5wbjA2WHdlT21UMmw5d1dKLzFONE9CQ3FK?=
 =?utf-8?B?K2crSGxoMG5IT1cvaVg0N2ZENko0aVU3UlRCS2w0a1FOMldXMlJKdXBEVkgv?=
 =?utf-8?B?cmw1blp2dzJmVGdMZXc4MENCZFczMmdkazIvckxrUmwxcWVLNFVWdkFqUVJI?=
 =?utf-8?Q?KCJxuQrRVQX87vBZDEBI4UVSvhmUnByuY6pJrrh?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca6964f-1196-49eb-559e-08d914780b50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 12:26:46.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPK/VYK3Mslrq0ghQ9iilk5OArj+geWoqnDGL0b5CbB9Cp81cOg0liqLL4wLZwtDV51xay9CNc/ccuteZuQ2kaZ5nyX0Qa1vd2UvzrOsMnJDsiQMT/jCJxObIIRSOcwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6553
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/11/21 6:36 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The rdmavt QP has fields that are both needed for the control and data
> path. Such mixed declaration caused to the very specific allocation flow
> with kzalloc_node and SGE list embedded into the struct rvt_qp.
> 
> This patch separates QP creation to two: regular memory allocation for
> the control path and specific code for the SGE list, while the access to
> the later is performed through derefenced pointer.
> 
> Such pointer and its context are expected to be in the cache, so
> performance difference is expected to be negligible, if any exists.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Hi,
> 
> This change is needed to convert QP to core allocation scheme. In that
> scheme QP is allocated outside of the driver and size of such allocation
> is constant and can be calculated at the compile time.

Thanks Leon, we'll get this put through our testing.

-Denny
