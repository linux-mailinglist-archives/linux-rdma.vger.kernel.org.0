Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAB468839B
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 17:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjBBQCT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 11:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjBBQCE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 11:02:04 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::71f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A68F5CFC8
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 08:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k47hLlHe3qDGr96X8f/rlcpTsIZywq/PXDKijZ0dzF71iVBVpf7eHk3Fe6UINYMfMYGI+Vr6nj/b54chgvpacPkpO+pO6esiUhu+iB3Ebd+1+a2fDkk9xzipULuCqQ32vSM+5thYp9Gtjv45TXYj7z29+rmigtfaU6dBD0envdaqcRHtCcVKFiGKSrWoF/MbPluiqkkrvG5YX1lMgFBFleVn0YzfSWcepxO+VTwTOvGDNyDVEOHBUtBvzcPbJvGsYl0iaQg59rxBjLxVUFmA8w5KyQsnvS8Wl2Pldh7UJodJSajrna96CuQJjUOYjA9YZSVKYU3FIIQxZOreuxulkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRXZjH+wbAFpsojDSQEC9i1eFwCndZMBI2GwfcvzDNY=;
 b=WcnAn/ukiW+885L4VbZh5vbmVY9kUbelt07QtCU6MYh3BRn6fwZB1L8ldb6DE7RVxphRk5KrezO9X8QaEv8c8NJfpGubs1CaZAKIF0UZZKLuI4te9jsV49gFM207WzGJuL27UzflgrLmOeFktrM+2uWZ6wf8pe8musFWRhBTlKYzf8bzC5/JJg4zlWcI3p/Ec8lGxQCRNiipns2ZNHj7DL/WCzxpG96LjcylkJZzksIytuuJjcuO6pre4QwSd7AdufrmO9Rw+Qz7XSOkeEepJqQCb8+8YllZxxOkRHVnjSmheU6UcGUGfLGzTc1SBxFLRF8e2MQtPNeymAVFP7dlrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRXZjH+wbAFpsojDSQEC9i1eFwCndZMBI2GwfcvzDNY=;
 b=iEpfJIyAeFmM3CyToXOL3SceOYxs5p4rtjk3cC8mBrvMNghcuOcTE/e2xk0N8LPo5M1nP0ghHC/vpIamqoyBcOx6ryjytquL+gyOqjqAv1hWS6RcoKH+R1wz33emVFSuvvNwziaFreedE7rV54Gph9fqh1Lz8vfZuXCG0Y2q3heT814qV9nZzIKwqSF0Svh+FqSkRsIUavy/FJHzL/GcreMCJD0YslDUriWjFLnvwVN0oX8OQ+SOws01O/I4uP/pQ1CgmJLtM90RFZ/5RH8CShszrX5zzk31ianDOxY4AZpDOufDRHBKSt0gc/MvRDiMwA8OaAWQKvLAQ5BevdP/wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 MW4PR01MB6337.prod.exchangelabs.com (2603:10b6:303:74::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.28; Thu, 2 Feb 2023 15:56:23 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6064.028; Thu, 2 Feb 2023
 15:56:22 +0000
Message-ID: <ef27f46c-3298-6847-3978-5e09136a9cf9@cornelisnetworks.com>
Date:   Thu, 2 Feb 2023 10:56:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal> <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
 <Y8z+ZH69DRxw+b6c@unreal>
 <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
 <6e74d22f-a583-0cf5-fe06-ac641f976f0e@cornelisnetworks.com>
 <Y9ksq0qce6iopG83@nvidia.com>
 <cc1c9687-9537-b514-29e0-4fc764d93b09@cornelisnetworks.com>
 <Y9olcZ7PWIzc6BqS@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <Y9olcZ7PWIzc6BqS@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|MW4PR01MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 79713fff-3843-47fc-bad7-08db0536083a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcAb88PBVlBwYDn1UHCLZtqfDmgh84LFrRlXxgo15fCX696F5RBUUa9YcHZbMSZQHuz+B/HXzP6sXCkAemV2OOLXi1lbJ73YzpYMRy/Khc4Oo77cBvAxbwBo06Cc88wF3Af4mF2nJ57g/2cGs/4EX2zGgnq3s+h6asO2ntohdg5JVpEoxn6wXcQmvGMdL7pDK1ugGMk5bYBZWCCPHRm2KqFmtEFqD2mcbu22+LPIZ9qXIuqVYziYosVqCMi1HDtqFzdyRy0BK+9tMBhwdiWdhWI0yJ9pMxU5A4nVsZX95Prpd9XfkLxrtx6m7yGG97iAPMJ7YDKKr/earGMvLt0b+BSOQRJ45sLxDvd7P0N6jThNmxVvLgTwveDuGvX7CtYCnl1n5gZtCPvlwWC1DP4+uevPqgq5sFUm6oacDNZUYHxxLy3eFwTUIgnzXZ7a8t7pSoxASilelhrbSqKCILgPWL8wJPnJJ9uzyZT8WxtPkT5ipvqB96vNIk1NZuRxOPxJT/Pi5TNo1gfh2Pj3xT3U+hrXuYXyUZtUtmrXt6wgRrDg1oVaLOuFw6XqvX5kFZgZWMFbkcmVMVqKd0uRI8vjfwtFWZss8seQZ+djoLwMtJElcG4TPM17fi/VBpsjaicg+c7doUiQTbePnNlikGyYt8Lne8lWm3sniKYErtMzJgBYLz1zIlP5iEBM2YNhmKWD+2gT5foAUSEuRG1Xm0yNncc1Zdu4r6eUZyc9B849by/57GnTxKaP5b/AjOBAYIXsPyQraAp8ej1QogThKzw9pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39840400004)(346002)(376002)(396003)(366004)(451199018)(66556008)(66476007)(6916009)(66946007)(4326008)(83380400001)(31686004)(41300700001)(38100700002)(2616005)(38350700002)(8676002)(8936002)(186003)(44832011)(6506007)(36756003)(316002)(52116002)(4744005)(53546011)(26005)(6512007)(5660300002)(478600001)(2906002)(54906003)(6486002)(31696002)(86362001)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFBlSGdWOExHM0t2TGFRekJuUC9YRjc5dmtHcE1DTldOSnNSUCtMNTUvZGc4?=
 =?utf-8?B?OFFESVRFcTJzOXRtT2dpaUorTlZhTzB1UFdYbnFReVBoUnRVdjhBWnBITkxn?=
 =?utf-8?B?NzhYbWZieDhMSCtJN1QvTlZ6L3djSWdkQWl5QjRrT1RaWVNTVGZuMWtlb0R3?=
 =?utf-8?B?cElUMk94RXhHMUhKODExVmZuN0EzWitVdGtDbGdyRVp4M0tVUExiQndScVJN?=
 =?utf-8?B?UW1OUTE4eGoybjIvZG5SZ1VpSzZrNmRpSmtVdDRCSUUxeXY5VkpVTzk1QXB3?=
 =?utf-8?B?V3ZmaStCTzQrRWxVVjRDamo5SVBNcDh3dWJsaXdmelZqeFNscnRyQlJmcndR?=
 =?utf-8?B?T0VEaGQxQ0xURzFxSmZVUHdlTkVCNnJidkIwVnk2bllWa2JSZjJQdXJ0ZTQ3?=
 =?utf-8?B?cVYvc0pKWEFxT1A0N1VTQjBwcmo3SW5JaWZwUVFQSUE1MVpFSXFRRzNuYno1?=
 =?utf-8?B?anNBOVpxUHlMQmdldFk0cFV6UlJsL0dRa1h6U1VydjdEdWpnK1V6QkdkVXJK?=
 =?utf-8?B?WVFCZWRrSzBqOVNZMlJvUnBZVWpDNWFyYk1Bekp0R2RBN3ZjRURGTGJuQ3gx?=
 =?utf-8?B?OTVHZzd5QmtrcWg0MTc5YjIxbU1MSXZhaXFaQWcvVTc1UWxFYmNVTEl1NGlQ?=
 =?utf-8?B?aGRZZFFTeTUra004aVY5SU51eFBLTXdZemJaeHN1Zzc1bGV2R2VLNVFCZUxj?=
 =?utf-8?B?eUtaTXVUTjkzVmp0R1pFN2NaVlQzZXRBNTRhYUlnSytiaU1sbkdjU2NncVdi?=
 =?utf-8?B?UzFGSjBkcFI1Z3dDYy9mbVNqbStNdUNURFUyS2kweXgwMzNyRFZtYUFzRjJR?=
 =?utf-8?B?Wkl4YVVuWkRwUmtFTHMwTThlZHJvQlVuT29ub1ZVaTdmc1ROc3hMb2RJZEp1?=
 =?utf-8?B?Q3B5RjQ4dnkzZmNqVVlGdElWTWpZS0NldDVmWnh6aDZnZldhZmpaKzZDSFA1?=
 =?utf-8?B?U2ZPSEZrU2JNMFpORndNY1huYUJ2ejRmRm1nWVI1RXliUHpZTXRuZlZmWFRz?=
 =?utf-8?B?L3JORXJZQm5aUTdJRGExdU53TUZSRC8vcGZHeEt4R0lEMmtGVFlBQmZodUd3?=
 =?utf-8?B?RGI5eWlSdmRMS1UwQ1ZMRk9iMGFEMk0rK080SmduY3MzY01zK1hlQld0cHN5?=
 =?utf-8?B?V1lvKythTStzMGszT3NJcmZ5Nzc1bXVHQUxnckJoVUowWnpWR2dFUU5MQVIz?=
 =?utf-8?B?SXlXbmMyZmJjN29Vb09vKy9SeklsWldTZmZ5L2J5Yy9UZGZFUmhDMWNGTzBp?=
 =?utf-8?B?bmZqMVJDaEpIcForQTVlUVl1N3REU2s0MFdMcXcvU29hR0JtTVpTTDNqNkxa?=
 =?utf-8?B?OG5INFhmS1NiZklTRWhJVUxEdVhjL2toVXdJUytGdGsyK2IvQk5iZzl5OFJ3?=
 =?utf-8?B?WHdwdjdvQzlpYUhBc00reFM3UTcvdXUxWUkwTnZKY09rcDk0UERvOHBFVTJt?=
 =?utf-8?B?ZVRDamNVRkJOU1pKQm5NUG1GcThINjI5K0hFV1BQZ1BqMTY5L1h2QVRTd2R1?=
 =?utf-8?B?eVZtTmQ4cHgwcjJLbU1UenRjeVFSKzgvZ3dhYUkwZDJkWFlyc3g3YzVTRjZw?=
 =?utf-8?B?d3VTeEtsdEFERkdVako1TzFOQUpJOWxtaXZRNGNSdGNrY2luaTQ4K1Y3MVZY?=
 =?utf-8?B?RXdXaXJPd3NYSHVGcFU5NGdpc2NzWG1VVEF0dzE5Z3hXVXR3Y2F1R0o5eU1t?=
 =?utf-8?B?ckdjU09WTEVXZk4ySW1vU3JzV3R2Q0RNc0V6eGVzQjk4Qnh2enBhbFY4QVhI?=
 =?utf-8?B?bE85QUIwalc5U1BsbGtZTk1UeFNyUjdseWNRYzlta1lYMDNYdTA3LzhvUFla?=
 =?utf-8?B?N1UxTUVkaTdqUktweHNONXp1QWJiOEZKOXNhZWtVZ3d4Z3JlbnVQSks1ZzF4?=
 =?utf-8?B?dFdmeFYzY2pzSWR4UmZDVTNhK3N3TmgxOFhHR1lubUNWN045b0lBaXJIeXFr?=
 =?utf-8?B?dExwdEI0OTY3dXRhS0N0NmVlOS9QdHZTOWF0dWw0aVhFTVRxaWM5bXpnZnQx?=
 =?utf-8?B?ZEVESHRaSGducmdObitRUUVsa2ZZVzdFdGFsaVFsZHV3bE1GWjRtT3pzZkRv?=
 =?utf-8?B?MWp1bmVnM2xRdjREMlhvMGVsbDJsazQ5QVIyQm1sS0htQlZRenlmdVJlWFpR?=
 =?utf-8?B?cGtyL3VmOGk0UEN0bkFVZ2c1OStieDNhSENwWThDUVZwemhScTJoUkdhTFRk?=
 =?utf-8?Q?QwsWg2odcS4Swo+fT4jzaiM=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79713fff-3843-47fc-bad7-08db0536083a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:56:22.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH0eQFH5HAiZAZneArBZHuPQg9u0JQiTypCmu35g/m5172o4Kkga56gCE/v6132G/xXV5l0Rp2VgCQSgQQdouUts8Vtb8lt1YKeOm4nRVh4XJjjYCZMDd5XS24gi3mJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6337
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/1/23 3:40 AM, Leon Romanovsky wrote:
> On Tue, Jan 31, 2023 at 11:57:22AM -0500, Dennis Dalessandro wrote:
>> On 1/31/23 9:58 AM, Jason Gunthorpe wrote:
>>> On Mon, Jan 30, 2023 at 04:57:56PM -0500, Dennis Dalessandro wrote:
>>>
>>>> I didn't see this make it out yet. Can this still make it in for -rc? Based on
>>>> Jason's reply [1] sounds like it will just work itself out in for-next.
>>>>
>>>> [1] https://lore.kernel.org/linux-rdma/Y8rSiD5s+ZFV666t@nvidia.com/
>>>
>>> Well, it looks OK to me, you should do a test merge yourself and
>>> confirm nothing got mangled
>>
>> I tested this last week by cherry picking:
>>
>> a479433a6b7a ("IB/hfi1: Assign npages earlier")
>>
>> onto for-rc, then merged for-rc into for-next. Looks ok. No conflicts.
> 
> Jason took this patch to his wip/jgg-for-rc branch.

Ok cool. Jason if you want a fixes lines to tack onto the commit message...

Fixes:  b3deec25847b ("IB/hfi1: Remove user expected buffer invalidate race")

-Denny
