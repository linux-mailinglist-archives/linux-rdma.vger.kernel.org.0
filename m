Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2938678227
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjAWQuO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 11:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjAWQuJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 11:50:09 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2125.outbound.protection.outlook.com [40.107.243.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7CC2CFD3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 08:50:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVpHeynQEfHUqfn8kUuODCdpBvRqJPugMLa9Nkf+FzO2PC256ZP42qIc87wEglxYviAg16/JPrXmtL+vHMFMHGRJlQem5fmVB/85o61EzUMJ2HVc3ChrGiLCsxTcYyb3DpmldpZ9kqPsNrTYzrmtgoe1HhGcy0kM/D/ol+TMdEWfBwJu2tVtq2TXQvDU5XNPm9RBOBAXdR9nUPFz3pQlja2u10v8nloMo9UoYIuSoPo/VOKfph+PUYJWaFF4xOvJM2/oWA2DH0h493SBvob337B3HEE0zEVJSBOyPlL8xzaV/vXeG1S0HvlBLuhSvBBiO8Q180P+lUFINv52ZPjV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEP0RGzCV+3G3ZYrtlZP4JNnqE/HizKZjErs8VztRDs=;
 b=Axv4xNxLcbpzY09tIHy/RtLO5mqJEgM3pVymZwhQD3zgIYkW+dfVRebfZiLnoosjtZXpnDEVaP/AhTJ+rV2WtM08eCO70NCxZysxpoCT68LwnD4Lee47dInrdH4JZUofxXrUFkOQOpmImmu358VfJpSqDeSw3cSbOi7x6AP15nsbVEtReD/R+MBzKEacMTsmEkqJBADRfrllUWoVvFg8xHq5C9+xvXK27nAcfNpf+bOUH1F07ZgIe/QNCT7KR/SnglUW3KoYGE2hWXFr20CQ184JglMVyJSrQBCovLp8sXiBjj57ASSpS2Ku9CRNutgbsUose0mXug585Kb2mH7+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEP0RGzCV+3G3ZYrtlZP4JNnqE/HizKZjErs8VztRDs=;
 b=eLU1ih0fDpU4aR2F7AIyhFGN3mSFqbvc7i9BV8VHOVF9o+evgWkrLrZ72MiUSq8Fcj9m9EBT30PudED/OLw8iWn8L/VUbejPSOu4oXqQdv7XL3lD5KhjjOQ1GtGE2Ff23X+p7Tg97e976judR8+jkksLrPT3qUQb1Lo+MK7LLO90SnsSMHac1NUhQfM5jRzYVBiKY5LcezY/G2u7HQd2u3l9K5BcuY2RuVXAt+eMqRm9FWkrfq/ZozPxZSdCwpzMh6F20P/pRIEA/sR7tccdyHtk1rBkuNw3e4siPUgtQyfLDa4DdM1gp/vX6FORjd1jgwkdTKOubj4VGAU2NrAvYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 DM6PR01MB5625.prod.exchangelabs.com (2603:10b6:5:178::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Mon, 23 Jan 2023 16:50:03 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 16:50:02 +0000
Message-ID: <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
Date:   Mon, 23 Jan 2023 11:49:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <Y718/h2uSTYq5PTa@nvidia.com>
 <3cf880fa-3374-541f-1996-d30d635db594@cornelisnetworks.com>
 <bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com>
 <Y8Pnn8NokWNsKQO/@unreal>
 <472565cb-e99d-95a6-4d20-6a34f77c8cf1@cornelisnetworks.com>
 <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal> <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
 <Y8z+ZH69DRxw+b6c@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y8z+ZH69DRxw+b6c@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|DM6PR01MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: d432f415-7b64-4b41-8fd4-08dafd61df42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGVp0M7/34CmbLjNNEnoBN1ePd46FLxz4v9G5mrdJXfkwf3VbZSeMkoik3wKFUT25lMLYYLVFiroeDfvbJ4aTjiT8jugJg3WPzVQqtMLpZSzHACMWdl2u6ueGg1NYuOVJVhxnRHyuslL6D4SUkOChCAuuDOinbe35dM+6F9GQRQOTA2cXO9tpzVBaXheEC2xy39SxSwdW72ZyA4mujTQ8rk2RvWmLdXasv8dCJj5thx9wtxc+Wc28nXJmK59Hzo4RsD30HlYnqxArRLmwJXaKkHKKvK8RhzQO470ZT8T7vTbAydAhsh8PiA/nG3Y0ccvf/KRg9dmKmBWJz+cboXC2sA83j6hxNWenemfvhAgX6MX8cSQSn1ZzJcwkGIwUofgnCvk9upT3odty0EwKA/WLRvemkAmjDmlrhMqX42JXwxHdIuR4BiuvR0JuPRqgRR9INB+zRICELztRrD7Yz0W6+PR92TvIGZO5g6+8CNgLxjv3flpejNHdGVlhRrBH6VlJOpFHpn5w2/ZNJLdc2IYIBs/AN7FY5ynMqUfxjEsI3GiiKGu1+0E06APM4k3GjLNW0dIckyn5IhbMVL7Z1my0frphYTga+3KWI/wO3fMvDOoLgrxFGVl6LQyju/87U/yTtM0PWuXSy6k8QvcvVM2vgbPcwkUQxvTzaUTumxex+PNqadnE0cotL8D/BScs4EKvpnrgr/vaQBXWiH1ChO0/Wg85CXPjRpDac6H7BhfCG6H9kvww6SdjGud1z1FjJTIagnXKejCoIsBELcxtJlHf351c79yUnz/UCq/WaMM+xn1BKGYo3w6CPAPJwe+pTWB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(39830400003)(136003)(376002)(451199015)(66899015)(36756003)(38100700002)(2906002)(5660300002)(38350700002)(8936002)(4326008)(41300700001)(44832011)(31696002)(8676002)(52116002)(478600001)(6486002)(966005)(31686004)(86362001)(26005)(53546011)(6916009)(186003)(6506007)(6512007)(66556008)(66946007)(316002)(66476007)(54906003)(2616005)(6666004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9vTmxLTlNraExwdlhuVTBqbkVscWNWSFdmUFZKdGlHWXBWQ3hoT2MxeW1Y?=
 =?utf-8?B?NnJ0SThPWUQ3TmhpYTRaTi9DTGZlUnV3QUUzYkJtV3hEVDBwQ3RMMm5Hdmpt?=
 =?utf-8?B?em5UVnB5Mkpud0ZOUkpTT3dqT3FiRkRybVpWQjBiNzhqZFNwWElwK0VaWGhv?=
 =?utf-8?B?QUx3dzYwNVVFMzFDTEJhbkJRUW9uK1pnd3NnOTFGSGFTYTZ4OTErVlZSZjlG?=
 =?utf-8?B?YW1RNDlidG5nMXptUXQzcXBUcTBRcjRBVUFTU3krWSs5aCt0NFBoQW8yWkZM?=
 =?utf-8?B?WkJZbHpWNTJiZXQ0c2Zva3BVZlpKQ0haQ2pJNzlZTHMrM0FGTk91eDgySUsy?=
 =?utf-8?B?c25Ed0VyQkJ2cUszZldYV1JFWXMvaW4rU01OK3ZZUFNGR3pWT1o3YTVDQThs?=
 =?utf-8?B?TkJ4cUVjNlUyRnJ6SlZSVnZQeDZhQUhLUFpSMkdKM1VUWXcxSHBSd2haT1F1?=
 =?utf-8?B?dHpHK3N1dnNFaGRpWnZLSDh5SzZ3OWtjSTE0cXM1MFVScWI1ZmlrQjA2TmdD?=
 =?utf-8?B?S1NGeDJsVWFiZjh3Z0lGRmwxLzk1UGJkMUJNZlFKYWRCRXRtNmNodlJxeERM?=
 =?utf-8?B?b1J5Z0Y4Y0tpTkthK09tWjZVVk96NUNQdVhxQjN0K3FqZ3laN1JmdVdleDVN?=
 =?utf-8?B?SGJkaW03WkdEY3JDVVRDS3dSY3UyMmJTNmhMcEsxWHZrcHMrczdsczBlaHhy?=
 =?utf-8?B?Q21FbzBVNFBpMmNUeTZOSC8waG1ER0R0TFlrRzlSb3M5WnBXK3B6djc2T0JM?=
 =?utf-8?B?cEp0Sm5wU2JkTlZiRkhza3B0dDZIK3U0TGIxb0U2ZWRLbHY1ZVV0V24zTlFa?=
 =?utf-8?B?VVNkV2NZZkxVckYwOW9VaXdOYWFlV1N5WmtJRjRTakZ5QlVxem01R2VYc2tE?=
 =?utf-8?B?emhmUlZ3RkFONmZlanNZQnJtZEZhQ2RvdjJaczl1T3Z3YnpzL1pudEZDU1ll?=
 =?utf-8?B?R2p3eExOTjAvSlFJSVpaYjVlVlhCUWtybjdUS0tqbmZCZWxMVjQzTVljbk4r?=
 =?utf-8?B?YmpLZGdtbERuTlY4NEpaNFNPTkpzUUJRYTM1MStWUjdzeHpPbC9qcmwydmRX?=
 =?utf-8?B?TlAxRGt4OFlsN1JGRmtpUkJOZit2Y0N5cWRCNUZDdEJkL056MWx6Z1JwbkV3?=
 =?utf-8?B?eGszRjBiYTZXdWg1L2d6d2FLT3k3aWp6UHlzNGM2QnA5aXhMYzV1WElDbFpy?=
 =?utf-8?B?OXhsTGJnclB4UFBYUFZoR2J5cCsxeGhnYkh4RzB1RGpVV3hLU25CblFWUXUy?=
 =?utf-8?B?ZXYxUkdyMDZ0YTRScEZzOFAyeHNKNjN4WG9lYkl0VnY5OEVIcC9qa1d6WHVO?=
 =?utf-8?B?MVgxVG9TOUFMMkZVTXN1dVRjQ2JPZVdmR3NKNnJOSVpEK3dXdThpOVBJOFRW?=
 =?utf-8?B?cDJvYzdlTVltMWxuWjFWRHNUYXZLUkQrd3FXUEdvNk9NSi9VbldXQm9PZ1pW?=
 =?utf-8?B?SnJ0Q3BUVHd3UTNwTUhEY2YzV24zSldWWm5IWnVZRVJJSUg3Q2p2MWJ2YURr?=
 =?utf-8?B?Tjl3VGprbXVLanJGQ2JhY0R5RU1MbHBmUFpCeHFEY1IwWFFzS0o2dWN4cjk2?=
 =?utf-8?B?cTBkdG1lMEgvRDlqY1dtNDNHLzlRRXZ6dml5R1JwWjIxRHFOZ2tzSHUyT0Fl?=
 =?utf-8?B?ZlBPc1dVNHlxZ0VXRm82eW9KQlNaL2t2WGRTVnBKbmZ2a0ZqVzA3R1hUUVp4?=
 =?utf-8?B?amt6OGFRK3Q4T3pWcFhxK0IrSy9CZm1meU1iUVRIQkhJQXMwb3p0Rm9UZVM3?=
 =?utf-8?B?WlN2aVdKYzFrWlF0ZnVRbzVEMnBKaDZpb3FSLzFRbHB2UzE2bm9TWFAyUFVR?=
 =?utf-8?B?SU45YjRJbkFQUlIzektDR283dGtuN1dSM280dnBCc0VEMlVtdXQzdXZDR3J4?=
 =?utf-8?B?Zk5SSWIxMGRHOXNnNFFKTm5FQTFTMFVCTzVVUHdzV2RaZmgySVI1VUJUajRx?=
 =?utf-8?B?dXlHcVd0a3I1QzdQRDFjbGlXNk40aHphemJLeDEya0xvNmRHQ1VsM3NlMHor?=
 =?utf-8?B?cTVMQm1BdEhmRVZXNDBwRmhJc2hNZzF0cnJvQ1Z4NWsyMlFTaGpGamd4MnhW?=
 =?utf-8?B?U3lMeEd1K3FobzJFYnVqdlorREw3NC9rOUF5K2pqZjRvNUI0bGNsU1hYQ0JP?=
 =?utf-8?B?VVA1ekZKYmZwUXVJWVY3aE1qazhUV2JxaHhNTjljTzU4RVJ6V1dONkl6Vm8z?=
 =?utf-8?Q?OrEiuA5wSkiXqASMmtv0Qkc=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d432f415-7b64-4b41-8fd4-08dafd61df42
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 16:50:02.8338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGaalqcxv/6f7rWWhKpB+AvlJwvQSZiO2BBjCmlr9qT/aQqnf7CGsWOC+CDktgFycIPomV86ieZJImZRSFgwD60H0d0KeFDkCXqcn6sQ9Upi5O+YeQZ73wDEPXeb1YHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5625
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/22/23 4:14 AM, Leon Romanovsky wrote:
> On Fri, Jan 20, 2023 at 12:50:35PM -0500, Dennis Dalessandro wrote:
>> On 1/20/23 12:42 PM, Jason Gunthorpe wrote:
>>> On Fri, Jan 20, 2023 at 07:09:43PM +0200, Leon Romanovsky wrote:
>>>
>>>> Backmerge will cause to the situation where features are brought to -rc.
>>>> The cherry-pick will be:
>>>> 1. Revert [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] from -next
>>>> 2. Apply [PATCH for-next 2/7] IB/hfi1: Assign npages earlier] to -rc
>>>
>>> You don't need to revert, we just need to merge a RC release to -next
>>> and deal with the conflict, if any.
>>
>> Thanks this sounds like a good way to go.
> 
> You talked about broken -rc, but here wants to fix -next.
> https://lore.kernel.org/all/bce1ab36-66e4-465c-e051-94e397d108ba@cornelisnetworks.com/
> https://lore.kernel.org/all/Y8T5602bNhscGixb@unreal/


> >> As a side effect of this, can we pull patch 2/7 from this series into the RC?
> >
> > No, everything is in for-rc/for-next now.
>
> Without that patch there will be a regression in 6.2.

Sorry it's not clear. Want to move or include patch to keep -rc from being
broken. Your #2 above. I'm not concerned about #1 b/c it will fix itself in time
after merging with 6.2-rc.

-Denny

