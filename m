Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82FC71F900
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 05:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjFBDli (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 23:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFBDle (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 23:41:34 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB0BA
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 20:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvXWuF1zGIwwd9DrnjEqc6PKdQaGU6OANm07Vd+H5mZxhSJmJNaClt2rA23q3chBTLS7gGXvGrqOiG/LbqNqM/3lGnEkGmGeVWEgPPKqvF9Yopfu5JWw0rHhLRijW6TO/1N536U6A2YNmrUkhCf3wrBIQv6uKAJEQvov8323omQMxgUhi9nWC3Mbvtlr9WS+Y9hl7fhZOjVCDc/8CfT/sTzr0a4rbaSkqQEkQA6AW9IoAmkqiMcVPNx0/pLmmUnQlvNjsql7BykgGEbaCN/RQs6S582b3v4hTSsc4ykY7lp9QeFID7jXpU2p4d7gLip6sPyqSBP5GWMqEXf/vjUGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2AdKBd3soP9rpMuLJkT5NPOjmjvQuF3asv0rPJwQdg=;
 b=SHMLoMdfek2fhls96hy6ILf/YdrD9vfUo2Cr74MLfawKYj15YPr3zpAvBxxrcNQn1rAZjx+h+cEpBhMHu94X7/tJ1fCbpC8Qxh6MTOME1vB7nzYfqzJW64dIdc+2fIEijThOCZWLdg5b+9El4Et9GOmcmGN7qhzZFZD/WvoYyjYflN3xFXQtgZQrlLbjvYtfDBsiy/NS8kbZi+ZWbYroJQ1rGzaeCsLg/Licvud4ezEiEOEBNDSSXjf9Sz978Hmy909Cr8RbVtbRUXkalTn3Y660uKqGJFVrCBuvjs2K8g2aaQKeByQofFhySuyT1rtZeF1w5WHBz29NAIysq1xy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2AdKBd3soP9rpMuLJkT5NPOjmjvQuF3asv0rPJwQdg=;
 b=RH13S5LH1fL3vNV5K18MjRnvrUocetoHFbypXH1U98rM5xfMPFCl4PoJGyzOao4RWE0RY295tft4cWKAa+gCckIe7TXkz8qgWeIbA1iPtmzuiScWTt3CgR7M8ZggOqOsRrhonboQScgXapMXIk62AeVOeCpC1YhLUQ1WMxOSg8ZriFtryjHhpqeP7qWHjRPjuz0kDlD1dnPipJPse8O2TrL74EsyLDpbH/4FKwSmK5DsRwVk4V9S1eqbONTEn3iPoFTzoVZ0ymMdw2J90ap6cuhY9173UapRAW5XLAr3kplgOgZlVOWwJVe1W0rHnRatNIcaw/QninQ/d4lH+vqOIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 SJ0PR01MB6480.prod.exchangelabs.com (2603:10b6:a03:295::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Fri, 2 Jun 2023 03:41:27 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb%5]) with mapi id 15.20.6433.025; Fri, 2 Jun 2023
 03:41:27 +0000
Message-ID: <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
Date:   Thu, 1 Jun 2023 23:41:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <ZHkhjTvi8vNAmmEC@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZHkhjTvi8vNAmmEC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0355.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::30) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|SJ0PR01MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d69df7-ca62-4406-2aae-08db631b3ea6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Pw0FSJKJvTccqxgzP+uR6nU8VfjABvwvK1uyyyZaiVv1TT9r43z7qzOthmz6vWSPbffggFczSOEljruXhrxTvSF3CsIGjpnyyvVpgVaTtMNy+F0G4Zv+yoE4qiiufc9YYSxfZt4AXZty8Jc6aWVWRAS91Wq/xg1/dc4fWXGQZOCJmCe0E3zBNE9OvRmd6QqD/0SzkuhFApD1ZkZ4R7+FKqIhM63QcNTbLl7NGlv4OL5XckHvogCVq2dyF/foSjJiPEacvsCAZmFh/kIFkomKJU/4fNkfStbCJmO9luT3fowZ8UOJA2xV4MvtbkdiEvWOJWoRQCOaMWKjjpEljpLuFBa8qFdime4hlBeEsz/HUFH2cVHv8Nn3ApJBP1726jIPjxXyUnVYPUzureJGIpdR83ViKsd0to8lblUi91i9YAq0mTk7Lsn49jbOh9KqFQjs6sXyzJOi8yTiEbaUtEo7v6rWJWwJHJ/G95T+PoKA1F8Gb6wi6yWYur35Xb9oUC18hDN2irUJ7DXZ55yGh2v93zAA4GJO2FLc2G50KoJcJeCXSWYH7daNE8KJX0v1r6V5kfJI8z3D1wQEynfvcn/WqtoOwKamY0Np+z7McZXQWMFKiGYGEDWVNF+q17O+ZQhpdA6qIjfJZk3cRhzJkDzeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39840400004)(346002)(366004)(451199021)(6512007)(6506007)(186003)(83380400001)(53546011)(2906002)(36756003)(2616005)(316002)(6916009)(6666004)(4326008)(66476007)(66946007)(66556008)(966005)(41300700001)(52116002)(6486002)(54906003)(38350700002)(31686004)(38100700002)(478600001)(44832011)(26005)(31696002)(8676002)(5660300002)(86362001)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEVWTC9PN2wwaGlzaElGT2NHUkRBUk1rYUNxTU9ZUFQ2akY4KzdFTW0ybWNo?=
 =?utf-8?B?MFNmUmlLVzRlY3Z5b09CbDFpc2xBaS91d0dpYmhlTEtzTHlKN2RMYVlaazdM?=
 =?utf-8?B?ZVdzeXFXS2c5V3NhdnBuOGF1U0dTYVV4OFNmWllrWE84ZUY4Qk51a0xEZE9Z?=
 =?utf-8?B?dldwc3RVRTNyYnhmT1puSW5yTkduTStyc09sdXZQejdTSWhKN2VJODhTZnJu?=
 =?utf-8?B?SE1JeWhOZ1ZQdmhab2JFR2daRHFhRTQ3TjVDM29qUERsRmsrNDNma3AwZjE2?=
 =?utf-8?B?QXlQOWFiRWNqa2dDTWtLSUQrOWRmMStNeWFsZFdPYUY2bFo0dmh6cmRFK1VL?=
 =?utf-8?B?TVlDRE81U3MzSm9RdlZlT3BQUUxzeExoRVFaY0lpZDM5OER1RFl0aXEvcUw3?=
 =?utf-8?B?OFJYaG5WRnZoTFBUMDVYY1BWanlUNUhEaTYweWE5TW9qUWF6eTBialdEdnhB?=
 =?utf-8?B?RkQ4eElZWDQvSkRkVW5mY3BycWQxdTI5TjN3TU01SDE4M3c4MnNmSHVmcU9s?=
 =?utf-8?B?Nk9JRzlhTy9jeFFZM3VXcm1wSE5XME13cGZCbnRRVUxLRVB5NEs3WGlMMVUw?=
 =?utf-8?B?OHU5RjNNUUNVRFZPalcybFdPYVBBTllJeGRSd0dKM1ZrSFF4WGlWcUZ2YVNL?=
 =?utf-8?B?NXlZdlp4OS8rTmtIcWRNSXMxUFR4TUs0WCtlLzlKUXA1MmJLbEtoelExb1pu?=
 =?utf-8?B?c0d2YVVWOFV1Rm5ZRjhLS3AyenpMV01PcGM2UTg3eUEweXhReWNJQm5TOS9J?=
 =?utf-8?B?Q01SR3JNUi82c05nL2tQbzV3TVhtdlVWbDFwclNVdDJjRW1LSWhsMGozYnhV?=
 =?utf-8?B?QUlZays0aXYzY0tlclBHWjJqVkw2OEx2N0c5RXB3WFRqMkg3c1o4ZmgrUHpO?=
 =?utf-8?B?ZEk0elAxc2RuZXRIQUFJMy9JTzNhY3M2WXEwNVAwSjAyUXl4Z2J4SG9TdVFu?=
 =?utf-8?B?NWpPM2hteE1TUWNMYzlSeUdMUDkzVkhOT0ZPY0thQkd0c21rTDNMQzdhS2Fm?=
 =?utf-8?B?bHBMaDlQQVYxUkdzNys5M216SHNNZFZkQ29aQnEvQUpYRWpucHptUEh5VWhP?=
 =?utf-8?B?UkxrbW5LVllwNnk2Z20wcHkxVzVPVzFFNWVtS2J2MXlZaXk0SWM2cHovL1lu?=
 =?utf-8?B?NnEwZ0c1ZlJKT2NwSmhkUVBiaXljUG1zSlIwY1l6L2FTMExOM2Zwcy9RRUg1?=
 =?utf-8?B?TkRXbDlKRlAxc0tGa3lCUTQyYWNHU2owZDRvOE52RmQydllHbVBZZ1VPOXhV?=
 =?utf-8?B?aUp0eWRGZkNXb2VRMGFOcmJXTWNZeFdpaUU3ckpmZ0pGMkJxbUpBKzNrbXlV?=
 =?utf-8?B?WWRaMU9EZnl1VXVJb2hSMnlwRTVLYjlvOEFwWjd0bHR0NUZZSkw2WElPd2sx?=
 =?utf-8?B?OFBwK2laZVpSTExHbUJpVGZZUTRFU3FwU1QwUkdraDRMc0NlSVZSY3pjTEFx?=
 =?utf-8?B?dHdCZ1BuT3ZrelA1M0QxNHNtcWhub1NqMmhaeHdrTGFkc1l2dWltSmRjNVhh?=
 =?utf-8?B?UWRpc2JuM3pXTDBSL0N5WmJkRkJPSEVySnljVTkya3VoT3Z3QjFQZnBKQ1Rh?=
 =?utf-8?B?Z1NUUnpjVXBSWThoSEs0a1F6aktTNHd0cXNhdzVBcitMR0F2SzN0OUhEZDhK?=
 =?utf-8?B?bzV1L0dJTmhLeElmZ0IzQnQ0aTV3dDBEQjAxUk9aSldPMFdPcngzQ2hBeXUz?=
 =?utf-8?B?NWFNazgzSkx6NHY0UjZWRXRLS1BkbTVnMkZka3VtQ01xSm5CY2NvRlJVT1lJ?=
 =?utf-8?B?aTRxNjhoc2pSTVZXU2dRQ2VLYzNpYmtyeUdiV1phVFhCTXRPOTVtc3B3Qm1i?=
 =?utf-8?B?eFhybW9GQXdrQzgrUVhwa3N1VVhVdkJ6RkRWZzMrNm03dDFKMURxd3VFbTRE?=
 =?utf-8?B?Q1R0WDM4QjlySVdOYS96cWVmUFRHb1FKeDF3aGFMVHIzU1VFWWZqWlFQQ01i?=
 =?utf-8?B?MlVNSVJDTXMwUTlIOEhONkhVaTdwYk04eXN3V0xvUk9TWVY1a21qdU9hQ0Vl?=
 =?utf-8?B?UzA5ZzhNK04rUWNGM1cyVnl4akQvYUs3MGVVay9raEpJYW11LzNvV0NUb3ly?=
 =?utf-8?B?SndaSGFhRnVndXAyYURuZ2NWNk9leGZRc0hKdkQyREFvVUs2WDVRN0tVV3lh?=
 =?utf-8?B?TkIxWUZaZTE1Ynpaa2VxUk1GaHprVmE1cGUvT3dnckwvSzY3Q25qWlBqRmox?=
 =?utf-8?Q?JM4UPBjN9ezA6RwuhgzuU4c=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d69df7-ca62-4406-2aae-08db631b3ea6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 03:41:27.1241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aylZWcn5eiGgDl/2OcbqGMw+EtJ/og5s5O2KqQ2fdMEnmqlSkt8arkMk6JtirIXq9kyaqYO1iB1azGUWQ+3Q73Ddb1QDvASf3DtHMvdYhnrCMxfkgmOQb1KVoDY9TDxN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6480
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/23 6:54 PM, Jason Gunthorpe wrote:
> On Fri, May 19, 2023 at 12:54:14PM -0400, Dennis Dalessandro wrote:
>> Here are 3 more patches related/spawned out of the work to scale back the
>> page pinning re-work. This series depends on [1] which was submitted for RC
>> recently.
>>
>> [1] https://patchwork.kernel.org/project/linux-rdma/patch/168451393605.3700681.13493776139032178861.stgit@awfm-02.cornelisnetworks.com/
>>
>> ---
>>
>> Brendan Cunningham (2):
>>       IB/hfi1: Add mmu_rb_node refcount to hfi1_mmu_rb_template tracepoints
>>       IB/hfi1: Remove unused struct mmu_rb_ops fields .insert, .invalidate
> 
> I took these two
> 
>> Patrick Kelsey (1):
>>       IB/hfi1: Separate user SDMA page-pinning from memory type
> 
> Don't know what to do with this one

I'm not seeing why it's a problem. It improves our existing page pinning by
making the code easier to follow. It makes the code easier to maintain as well
centralizing the pinning code.

> Maybe send a complete feature.

It is a complete feature. It's just a refactoring really of an existing feature.
It makes it more flexible to extend in the future and is the current interface
or psm2 and libfabric.

We are clearly not throwing some uapi changes over the fence that have no user
backing. We have existing use cases already.

Now all of this being said, this is starting to concern me. We plan to start
sending patches for supporting new HW soon. We were going to do this
incrementally. Is that going to be considered an incomplete feature? Should we
wait until it's all done and ship it all at once? I was envisioning doing things
the way we did for rdmavt, showing our work so to speak, making incremental
changes overtime as opposed to how we submitted the original hfi1 code in a
giant blob.

For instance, we are going to add a field to a data structure to hold parameters
that differ between multiple chips. The first patch was going to be adding that
infrastructure and moving WFR (the existing chip) values into it. In my opinion
that's basically the same thing we are doing here with the pinning interface.

This is all in effort to be open and involve the community as much as possible
along the way so we avoid a fiasco like we had years ago with hfi1's introduction.

-Denny


