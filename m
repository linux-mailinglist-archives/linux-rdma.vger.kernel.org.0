Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7571F189
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jun 2023 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjFASQj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 14:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFASQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 14:16:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D5E52
        for <linux-rdma@vger.kernel.org>; Thu,  1 Jun 2023 11:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePbGHLLWS0bPpL0Up9paig4oXfZOKYNYy2H4RGKUDGNPSSF/WmsAcKibkGv0PC3zEyk9drlIuDc6im0ubuBO34JJjNC7Qv0ZUcKig/hXKaTZE9LsXBhXJGuQz17T+sW2LsUlBG7WqCYRoH44kUAcbtZliNk/iqnSgjfKuLvSbEyD50WNWtM4qBBO/nCEbK3uSbzOPFWfr40+6PyA8RTjwAauHSD+FZDD5uHWykrq5KHgqbkNwYfng5htn/TufdKXqnyST5QAuVaPbZmCjdrLdZtPKMJ6Irbm6wXL+Fk8fQWoLTdp8x+V7tR0ponc1Pl/RJyg9AndhcUGrJ1oFtC5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBSuaql9E61Kcu+i6JsaXpNrEMsphuIytWlt4XSnrwU=;
 b=Wds2rbr8MKqZfJIb8byYugwu3f++E31ArMNSJQhL9yPZOql/FV19O3b9+oFk9KhX4jF9TYxC/rgaQXDRTeVDlKUHRZ1RgnvJCD+D7GwBes21ryTnltz0d9NEgobLRc0VnuOzHNmqwnSgcNnC18g1SLqVzKWvuretKcLzgWD/MhN8v5hTNlm2noXN3kTxZHWxSpsfuTppPUyZ66TZBcBxSMg2BRl8QLty10FKkgB6KhvgKfkhrOjPUbUXwMbWl6e8FKjkg7gLJAOOara+lemcvxybT2xD4BPBQvqSOFtnXFEWcIhlBP+RBNiqfQ1cRvdF3NBJ9AEPwJGc4jqVrvrqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBSuaql9E61Kcu+i6JsaXpNrEMsphuIytWlt4XSnrwU=;
 b=C8JCEfJCV6pQ9MhVIvkXdp3WkgBamMbIHhuqFnIgRrl7fZ4jdto0dWb0ic9PfOt7PRToQLk5g2XxYz0Gef25zMObnfdAeTiHykePYqG3rIAXp8SlZaAXLsS2DheMWYG3aH+VPY5azRvnamKUbQDdTWyOdQ2fkE37660XXvSDdMn3Wvsq99D8irWoUIP/R6Hd7xsJbhOoaeANqJc3euro2tm99+iozzc7BWnuIKF2eYlzwA/ISHXm0rTdVQZpnCuna+5rVzt5d0R6zikKV9amO96w6Q5BkUnsCriWZZaS3LZdgwWRtQiX4XkPJkGkMU0dgyvD/DjvP0dHCfzD9o0rWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from DM6PR01MB4107.prod.exchangelabs.com (2603:10b6:5:22::24) by
 PH0PR01MB6341.prod.exchangelabs.com (2603:10b6:510:d::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Thu, 1 Jun 2023 18:16:03 +0000
Received: from DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::f33a:edf4:c24:d88e]) by DM6PR01MB4107.prod.exchangelabs.com
 ([fe80::f33a:edf4:c24:d88e%3]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 18:16:02 +0000
Message-ID: <034e5eff-ff84-f91c-dbb0-decc04b4c340@cornelisnetworks.com>
Date:   Thu, 1 Jun 2023 14:15:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH for-next 3/3] IB/hfi1: Separate user SDMA page-pinning
 from memory type
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <168451527025.3702129.12415971836404455256.stgit@awfm-02.cornelisnetworks.com>
 <ZHjZQOYgNW9tllNx@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZHjZQOYgNW9tllNx@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:207:3d::18) To DM6PR01MB4107.prod.exchangelabs.com
 (2603:10b6:5:22::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB4107:EE_|PH0PR01MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 557de7ca-7cfc-4ddb-e333-08db62cc4230
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jTNVECCP92ootjlox4RcM9nmxi0gzxepW6YvB8aCyLz9FCel5HtvsD7WkfGnmSG9ZmJFh/OVhPc4xbyt8D9oiuLIGN/ObWKdHh7Y758jgk2dEl4rjazqqqN9M9PBj9Labgl7j0vFJV3YcNe/jrxoXTxYfZxaPl66wNcToKKsjWuGhyQySC9qgLExb5Ju0rOmgcGvPVvewayB0MwXHtJvZbkDQblYVm7STGg8c/TsCARUEK0nH9RV6zubOHeJk36Et0nTITVLM31R3FEIkR1+uzo7MCmDFcxPIRGBnweaoGLWElvjJXEOOb5MjPNLDh42zrnw3MH3rLyD6kWL6OhlbdZofN7BWdz/UUEI9Wb49r2rvtkySd9pg3q/Nz/x2Vx66ye8OKsTsEaTgMtf83i5ursTWRjM0/31w3DJ+MNM7+vG2ZpLvT/b/GWAwoAJw75B0jikZI1lVyfDfh4+AUCrTqca+1S/irEPz72g1MRzcmt8ZbyTTk7I8osHrkcGU4t3/SScjEZ3o1+nRlCcSdILDHRf/2bYEYIH77WWl5sbOJYWR03FIelgWuLYX9cUzkEnhVM0slR4WKI7QaiJg5qdpmAAP295FxUG6KbgbPkOV81QnccyCsap3aHfvETfUcUiQ2WbT21u6QyxCDiDDmSjJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB4107.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39840400004)(376002)(136003)(396003)(366004)(451199021)(54906003)(478600001)(8676002)(8936002)(44832011)(5660300002)(36756003)(86362001)(4744005)(2906002)(31696002)(6916009)(4326008)(66946007)(66476007)(316002)(66556008)(38350700002)(38100700002)(41300700001)(31686004)(83380400001)(53546011)(6512007)(26005)(6506007)(186003)(2616005)(6486002)(52116002)(6666004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0l4NUw3N0VhQnlpeGNvZjhzSm00VmVRNEltYjJscVJ0WjB4SWdWWTk0RFVZ?=
 =?utf-8?B?NGlyUzA4eExZVVpYNlVwUHljRkpYU1RwdWwyajBDcUlRWllJWnozUmdBeVUx?=
 =?utf-8?B?TG9uanMwcEVSanFlakNYOGdJY0xhcmpOU2d1cnpxOUthRS9nY0lTaUkrTHNU?=
 =?utf-8?B?QndvT3lEeGhueHpraG5GcjdHUDYwZTllclRIRWQyL1R1MDI0R3JiZklMN2dN?=
 =?utf-8?B?YWRZZXJWZEh1ZkVGWFU0M2RXQVhjYlpuOGJRd0VReHRIRVRUVmF6TTR3MHNU?=
 =?utf-8?B?WTJSOWZ6WjR2QVBWeUQxUmMxUWJ5R3hJVE5yMnArRVRQUjJ5U1JTTVZsdk4y?=
 =?utf-8?B?ZjhhaTlLcTdQZXFjZGlVSW5DdlJpME5ZaDIvazJyUjNNWWlNN2dXOE1OUFRI?=
 =?utf-8?B?VmdoQTc5dEpvVVZ6S2pLSEJkd09sVDFBeXVHSG9XVjRocnVCYXNXRFlEbC9J?=
 =?utf-8?B?UW15YXBPeDdpdnRKRU5IbjBBdVVFTUpJcXpiRVlqSy95NkRHV3A1Z2ZTTEJL?=
 =?utf-8?B?MURhYUJINjkzNTNCRXdNc1hXRzBJcmxseGNJK1gxbjVyWCtaOHVQdkIvdTZZ?=
 =?utf-8?B?ME5Bdm9MbVN0Z2F0OHl4dkw3d1VMSkF1YkY1dkZxeXhpSVYzR0RDV0wwTVFZ?=
 =?utf-8?B?S1FKL3ZiT252QUlZemEwV3JiMlhMMHNpUnpiOWVJbXQ0SzFUZHArV0tSYW4x?=
 =?utf-8?B?M252a1pjdzM5RHhJUVduK0ZoMG5zMXFuUjVWSStNa0piUHJKQ3RjYVpWMmNW?=
 =?utf-8?B?K1RNMXpTUmpkUEtkUk5zQjVNclZsbDVCdTBJTjJiRktzRFVlMVdxdEJuZ2xS?=
 =?utf-8?B?ZDl3L0U0bG90dDY0VWh3VmJsS1ViakJDRmNoZkJvdlo3ZkI2d2ZNZ0dOSXRM?=
 =?utf-8?B?Y2xveU43d0lMRTBTeHVNajRZZXhnbEU0ZkYwNHVYQUplaXM4YVNJMUdiQjZq?=
 =?utf-8?B?VUFRWitFN2FDVzgzbk4wR3BqeWtkWkl5YnA1ZjZEMjg5T3RlV0JzOWlWQ2NL?=
 =?utf-8?B?OFRNY1oxSGcvZGZlWXRzQi9MdzJjaWtTNnVYZGxOTW5zdXYvbVdJY3duYUk3?=
 =?utf-8?B?M0lrUkozZkhqNFhrMDhFaVZiMldqbW1iWWhHeG5ZRTVUUmpwV29jb2VrQnZt?=
 =?utf-8?B?VzRSeEJkU09JY3FxNk5KRUp3UjZkQWQ3VTJLc3M3ZHorQWdpOVIwSXFUcXl4?=
 =?utf-8?B?NnYwMGl4Mnhyc2tQZVFpZzBlNXlDVE8xU1psT1czSlFPaDB0c0ZpVlg0VnlZ?=
 =?utf-8?B?bkVSajZ3OTVJYmc3TlpVWklaY2h3Z0R0Vy9hdlN3THhFeGZaWW1YUC9BRy9C?=
 =?utf-8?B?S3pXVGlUM3AxeE1TeTVTVit2amFtZURjTldHK3B4YkZGdDJFeFA5N2NuN3ky?=
 =?utf-8?B?R2VrTE9vR3hpbTFSMkRHZUZ0L2hPTzBVOUFOT09zQjk5aUtSWCtPUmNaSXF5?=
 =?utf-8?B?eXhNUVU1SGVoa1VCR0hpVS9KSHp3eFV1SEJHSk9TZ1JpcTF4dlF5djEyOGxp?=
 =?utf-8?B?NUowN1VpQnhaZkdnZGdveTBORTlLQ21HaU44OFZybTBYUTM4WHpGMi9XTTNl?=
 =?utf-8?B?c3QxTVpnZGZsaEZ2UlF4NTJqU3FOMjRBQVZhTmhCODJBZ3Rua05IZWliZ1Bi?=
 =?utf-8?B?d0gvaCtsNGxNdkVRUVVQMWg0RklwSFFhNXBRbjgzaDY4cFRtVm1NUDBYUzIr?=
 =?utf-8?B?amYrSHZhd2ExWENqc0g5dDFTcFN0Mjg5NXZDeWRWMitJWEFqUmZlWXpHRm4x?=
 =?utf-8?B?UEFWVjlsVVUyWWllUVM0dlVXdGxPTDJZN01sREdFci9mTFJWUGdvYjI4Nmtu?=
 =?utf-8?B?OVVJMEpnUzdQMlR5NUdCdytzS0k5Z2N3UXFRZUwyc1pVaUYwN25mVjdlclQ3?=
 =?utf-8?B?OUJMbjFJbFpQK25UMUVyRkN1YmlFellrN3BKVFJ3RXJLK1VTYS9UOXE5Skw2?=
 =?utf-8?B?RzNuWnBYUEZ1OGJ4V3Zvd3B1VHhoMnNYbitIcm02OXp4TGIveHhUVzlhTm1V?=
 =?utf-8?B?M0VHUEIvblFQMnViNGNudm5YNFd3WU1iVndaUTdyY1dUNFJla2xlblo0RHpP?=
 =?utf-8?B?WWNuUDhRcFNHNHBoSHg1UGtLQjZlSmorZU1sZlB3N3ROREcrUlN3Z3IwQUtw?=
 =?utf-8?B?VkVVQ1NSNENZVmJOc1dnMEg1UEZUOEhmMm12ckFjL2laQ1NWRzAvR1ExYjVz?=
 =?utf-8?Q?opXiqYNiGt5bI3TmwsyKrQs=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557de7ca-7cfc-4ddb-e333-08db62cc4230
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB4107.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 18:16:02.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4uBHy5XzxA5wGot3t5GYlceC1bBcn8P7o/v/g8DG2P2pFTSp0WiMO8TPAF2XIvFNa3iDPgPRkya0qxfBUfAbi3AyXnwqWoWuzUW50ycB8Q93Vw2MxCLi4Yn26kAITzq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6341
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/1/23 1:45 PM, Jason Gunthorpe wrote:
> On Fri, May 19, 2023 at 12:54:30PM -0400, Dennis Dalessandro wrote:
>> From: Patrick Kelsey <pat.kelsey@cornelisnetworks.com>
>>
>> In order to handle user SDMA requests where the packet payload is to be
>> constructed from memory other than system memory, do user SDMA
>> page-pinning through the page-pinning interface. The page-pinning
>> interface lets the user SDMA code operate on user_sdma_iovec objects
>> without caring which type of memory that iovec's iov.iov_base points to.
> 
> What is "other than system memory" memory??

For instance dmabuff, or something new in the future. This is pre-req work to
make it more abstract and general purpose and design it in a way it probably
should have been in the first place.

-Denny
