Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB82971F2B1
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 21:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjFATLw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 15:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFATLv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 15:11:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2137.outbound.protection.outlook.com [40.107.102.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20589184
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 12:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlPl/dTyF0tOunAzLMIjmp1/tLhKuP0f/7pLzxD9K6gO9L5ZzVwb1lL5JMLp2btvH5CEli4Az/uGdHW89Ms7sD4NmJ69RfJeetewu5wTnpNO4llunimZnA555RZfsrggDYl4AlMCc+NyP2F40II8ob/8vGpl4VeB87uGgqld2jshCtrr+zFBiCLPVcfRQc+sUI6qF4tPUOe1cdlgi8sxw8jD6C3hpDLtYgHg6sGMn4g3p3DQV2O8Gcgj1/fJIl8ymGJQqywB2W5mAJwkfXR/u+REwx8zGrwYbpv6RBJE3565AhXbpYS5lg/z49ukY4+MTGqeDG8YoWezZqXGx7xSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifhSnbUa/vuRrnVoeOEPG0DL2rkGMkdvlmn8wpLm/1M=;
 b=i6rIeEEBwP3tBGWD6RaX/afkVkE9Ng5hF5bkCuQPhXJybTL91F7RYgOuPN3C+D/gad7CosDBbxe1v99BpFPXaiS55xp/N0qZ3FnHVDZ6oIpHs5burvRDO8cLnvmp3iwlsrh1vyMXcWOAm91VpSol9ifCbqW5p4Uppy4fO1jdJvFYkle1IRwPXSsCWY0OcfFbFkLB5BdRMmLnNN3pUw7l7jgzeII2MYTXgRHz8CVstkzY4IOVkoIHpqsdlnyO9B8bJ7xxQBNb5TsaizaSyl2KHtHuQD+Fh06o76S1cNa7U/whC5mCRstApBs/qcRl+22pyTs1anYX+Mw0rMVfoOXV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifhSnbUa/vuRrnVoeOEPG0DL2rkGMkdvlmn8wpLm/1M=;
 b=B2AYkuyLjHRXktzB65SdD6OoyPrxQxGBoLA9uCnTaEgPxF3sUgzAPvzWySEKrqkRkOefJgRYgei73Drf90nyY4zm0e0/Q3wal/UPIWvOl74tKh1HTkM9gebG2dBB48pHpebcJid3ytE+sAYVRwqOORKOJZYOdB9FsIkRSAYgM1PinioKG98LQ6Sq4SQx0BBTbEBk1ClXstKigqs37jiOD/uFMoUH1dJKidchAtDzoHaTP6TSlu0Sfa+07/DlnBgklfV7hppEVe4ulVNDPDW2pFf6ESAQzMcYIIhimcviDIAEsercE7PFd+Xy9Biuug2ewIoPMA5F5n/7Zzjn1JMyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM6PR01MB4107.prod.exchangelabs.com (2603:10b6:5:22::24) by
 PH0PR01MB6602.prod.exchangelabs.com (2603:10b6:510:a0::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24; Thu, 1 Jun 2023 19:11:47 +0000
Received: from DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::f33a:edf4:c24:d88e]) by DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::f33a:edf4:c24:d88e%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 19:11:47 +0000
Message-ID: <5f17fa1c-57ec-2d0a-a14f-507c656d5828@cornelisnetworks.com>
Date:   Thu, 1 Jun 2023 15:11:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning
 from memory type
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
 <ZHjZQOYgNW9tllNx@nvidia.com>
 <034e5eff-ff84-f91c-dbb0-decc04b4c340@cornelisnetworks.com>
 <ZHjqacc3eKiJ0Kt0@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZHjqacc3eKiJ0Kt0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To DM6PR01MB4107.prod.exchangelabs.com
 (2603:10b6:5:22::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4107:EE_|PH0PR01MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: e3de2009-cb47-4e75-a156-08db62d40b7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tC/MMw3eAUQDKp5W2HiflVrfi80VsrqEHgsxSJGni8Km1jjmg972St6QnwxAxVYkDIf7gaX6RQr2O+e5btJYKk7mwBh+dMrISZ3dKLZahI5W8oVGlwf54C5P8ZmWFK2pL8OG/ff9NABBsSQLZMWa2j4VFKqFrMg37jwmnfwtWXolzImj7l18M/1quTGoYNCHDMB9XAPoEAPEOT2mA+mxhvQsRdSRHGUKyHXQJGkKkXSsiDxwWIECahoiUGnFGj5Krfooh+pQ2CcXqzsKb1uTPnYSVXUPptL3Jcd9K0YYXvD2N5vQpeTDwrnAKbpEvBp6a2p1dzjEPqxULRMiZtNvWHZgTM2LYXKLXdThYUhXbTaTGTQuLQA4zfbPNnOHXGZ2dmhOCtGHa6/kNbLq1M8t5KgBoOt0mu8KgUJk8p5TEu6vlElza1Z1jlA8Bx0VFCnKH8pzsfZ0W8/EhhnimrAFt0FgJXaYQr2lAqu4wj0ptZacXCcomaOLN12dRiq9LGk16C0BRvOm3Cs5n/62FthiomcmBB0C2NgjQYz6C7KgOQXn1LFM9K80zKxzoQPrETUQRqE6c7GXnc92P9mkFyTubr7C90tcLfxhwfVcYASrjGoFR6QtIOq1HN1gIZvIY60JgO3zNBKbuwQflhfymaJUig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4107.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(346002)(396003)(136003)(451199021)(38350700002)(38100700002)(31686004)(86362001)(478600001)(66476007)(66556008)(6916009)(66946007)(36756003)(31696002)(6486002)(52116002)(6666004)(4326008)(53546011)(186003)(26005)(6506007)(6512007)(2906002)(316002)(5660300002)(8676002)(44832011)(8936002)(2616005)(41300700001)(83380400001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnNkVy9QQ2E1NTdQdU9VMlJWTk51L1VzLzlyR2pyejNYSWhPTVcxVGtaVlM5?=
 =?utf-8?B?MXJod2cvTnBnQU55eGVaM1dUVWswVE1LQkVtSjEwUVVjUG15eGJDVzR6aEJx?=
 =?utf-8?B?bGl2eXBFMEtTMTY0WlA2WDBpM3VWYkE5Lzg0cWNXNC9kK1ArZEQ5ODZvR3Jh?=
 =?utf-8?B?OVUvbFVVZ2FMQmlQbXJudEc5dlVPMjg2OVBFN05CMHhMa1ZJUU9wWTEvYTF1?=
 =?utf-8?B?b3I0aEhuUUdKZzNZQXZDRk1zd0hkWFpscHFMWEFwZEg5MHlWMmpkRnVWVzlG?=
 =?utf-8?B?OXp2MG10N3RwcjJjb2ozNlFldlNRTjQzSHRKMSsrMUl3R0JCTDUyLzIrcjJv?=
 =?utf-8?B?TzFlcm1LU0IwOVA4YjRlZnE1d0I0T0loRHdEcXpUZURITC93YzhzV0M3VWJm?=
 =?utf-8?B?emFuSDhIWmZLVlkzNmp1Q3lVRUFMM3VHdHBDNXVEa1Z0eEJBL3c4Z2tSSTJL?=
 =?utf-8?B?ZGViK0UyT2xacnhVOWJtbWNEbjdDSWlhWUhNUWNuZVl6WnZwcmlFWmRORE5x?=
 =?utf-8?B?dFVzZjJKUU1PT04yeXFhK0pRaVlsMjdKU0hwdUFMOGRmbG4zZGpXOS9KNk5I?=
 =?utf-8?B?dlhlQ1NQU3RmUEkva0F2TXovQkdyRDVHT3I4d1FJbnZlSDlHMGRVemFkancy?=
 =?utf-8?B?ZW9MejEyT3YxV2k4TVZJZDB0WjNwNmZ5M0R1OTRwa3EyaUNGVHNpeVp6UzJj?=
 =?utf-8?B?cldobEZ1d0E4bThaMVZ0Mk1YRDc2MHFMdEJyUmpNV0V5MkhrbUVvV3Z2QWRQ?=
 =?utf-8?B?MGd6ZGkrdHJnaE5qNlNQZHpOaTlyZUErSWJSVkdmTEhnT2xyZVZqZVgxa0dX?=
 =?utf-8?B?R1Y3cTg4UzkvUWRGcjR0cWtvay9NeFhQZ05OL29naCs0Ny90ZlJiaHMzeGpH?=
 =?utf-8?B?Y1FMWUIydTNnVkhiRlhwa2YxcGJPYmY4cGZYMEw4RVpBb2xiMHRLUzdsUEpr?=
 =?utf-8?B?MjFKa3dDRmtvQldmTlNjQjZNVUtLYkdKaVZuY293Qko1QytxcHViTVVXaTJj?=
 =?utf-8?B?dVllcGF4OWV2dCsxNmNjdUp0YXV4eEV5NEVYZWRpWmpQd0J2djZOeTY0Uk9J?=
 =?utf-8?B?OGRFYzJ2SmErSGJRaHV1Mnl0TW5JK2lsbGlvdFhVTGpSVUZaQzJwV1dIT05h?=
 =?utf-8?B?Ti9Ldk5tWUp3Q1FmUHdQSWtOZlQ3RytURTdIcENnNWFuK2FhR3krQnNlS21Q?=
 =?utf-8?B?MEFGTjVJZGVKaFlNbENuMkY4K2lsZ1V0LzE4QldlWUY4MFU4UjZSdStpbUhw?=
 =?utf-8?B?aE8zN283SHNVVEdsMDNscVB1L3NKdTA3UG8zcmJsSHJWTXgrOU5sNk45eEFj?=
 =?utf-8?B?TXdkTSt6REdmWTJnNGcvYklFVVltMGsxVkI0WXhxTmhkWit6MlZmdXYzdmVP?=
 =?utf-8?B?MVY1d2VCMlVlRXlrRjc1OG9lREZxdXE0Smp2M0tqZm41Y0F2bHNwTWl0SzBR?=
 =?utf-8?B?cllPcytndXh3ZytVZnVwbzNMMkg3RzF5YlBaTVlQTnFWQmJrNUc1SnVJUUZa?=
 =?utf-8?B?R1h5RStxb0RHd2JYRlJmWUY3Ni9zM2dEK3ByeFpmQXE0RURSV0NJbjdLaDRG?=
 =?utf-8?B?M2lPVm0xNFNYbVp0NlM4Q3I1cTh3S0tPMDNOcnpmbGQwV2M4QkFHcTdDZjFz?=
 =?utf-8?B?TXpSWFJrQ05mWCt0K2dhUzVmckE5N0F0bHNYQzFiOGJRakZmWWVqNU1iaTFX?=
 =?utf-8?B?azN5TExLTlQwSXhTYytsaUdwcDU0RExoWWhHeXhxUzlGQjFxOWxRKyt5M1lm?=
 =?utf-8?B?SXl4cU5BeEdRRXZwZEx0SVVMRWFTZlp6ZVFwa3RYTlJYUDBzYmhJaVhWU1Zw?=
 =?utf-8?B?dWdUT1lVZkp1WU9sWGZaVkxyUmVyWFZKelFCbGM2QWpPNzE5YWdockF0T2Fw?=
 =?utf-8?B?d0pkbkxzdGY5U2d1eHZoRnJoUGV1WU5NUWx5VE8wdU9HTXJkdGxuektvaVA2?=
 =?utf-8?B?Tk5lSDREUHM5WHl0NTA2dWk1cDVvaGpTL2ozQ3pSU1BpU2lvbDIwcHU1N3BS?=
 =?utf-8?B?dVBiaCtGdkRkdnczaEo3MlkrMTFHYnV1SzN5NVZ3RU5JckZSTHdqUVJFZWF0?=
 =?utf-8?B?TW0xV2VxU09DMGRnWVFZM0c2b1cxZ2JhTG15RzVsUUEzV1ZCYW91QzdPajRu?=
 =?utf-8?B?eE45L1R1OG1rcURtMzRpZGdsbGdQTTRidThXVHhjcWRrbUNPZHRYa05BbnhT?=
 =?utf-8?Q?8/VC5+U1UqbkqFgxT3fWQEE=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3de2009-cb47-4e75-a156-08db62d40b7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4107.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 19:11:47.0019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4tHexF1iuyZfn73DJutTr/Lwc4kn6q7fQ9u2cl6lusPQuzBPIeBd0+wyGSGXESvJzOKF9EEbOQFnM6wpfsx3mQEx+B5Bv2xiC2J/yVfFbnBdDACfZERE0CcNMqkSWp+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6602
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/23 2:58 PM, Jason Gunthorpe wrote:
> On Thu, Jun 01, 2023 at 02:15:59PM -0400, Dennis Dalessandro wrote:
>> On 6/1/23 1:45 PM, Jason Gunthorpe wrote:
>>> On Fri, May 19, 2023 at 12:54:30PM -0400, Dennis Dalessandro wrote:
>>>> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
>>>>
>>>> In order to handle user SDMA requests where the packet payload is to be
>>>> constructed from memory other than system memory, do user SDMA
>>>> page-pinning through the page-pinning interface. The page-pinning
>>>> interface lets the user SDMA code operate on user_sdma_iovec objects
>>>> without caring which type of memory that iovec's iov.iov_base points to.
>>>
>>> What is "other than system memory" memory??
>>
>> For instance dmabuff, or something new in the future. This is pre-req work to
>> make it more abstract and general purpose and design it in a way it probably
>> should have been in the first place.
> 
> But why is there uapi components to this?

We added a new sdma req opcode and associated meminfo structure for the sdma
request.

> And HFI doesn't support DMABUF?

It will through the psm2/libfabric interface soon.

-Denny


