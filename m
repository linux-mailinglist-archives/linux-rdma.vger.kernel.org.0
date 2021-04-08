Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EBB358323
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhDHMTp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:19:45 -0400
Received: from mail-bn8nam12on2116.outbound.protection.outlook.com ([40.107.237.116]:8449
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231409AbhDHMTo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:19:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuQI+qnUA+ywKxP5G69r67vMgBG+IexNfWsClTEC2T91Ravq4yQa7ddvbapkR32b6FpMb4EWCTJvP8eC2vTOhv7rjWZSMtbryAXP8+WTGQjFj1okd75ty1wwg3o+5p+iCE0IfcL6u0pMalLMj3vsUisaAraiNeAIdKZPvZPLzXBcQ6E4bnV+QTQAd55CdgEaSunxcCdHITgJSQcBQdOf3Dl0Q40B2kNp9LdW2Ljn9xlH+ehc0Lfi3Udup398lrOzflDctnE78CYXtIgJI8jNKMTVMokmRJdYDEEDfvsDdPM4VurIJfaKVT/yzRYw20WffvonOI6nguOQ+bXNHrbw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLUXxNI01XU0RyKN32LCXXHxFw/TMKZYENV+2mRArs8=;
 b=AFlB3xSmDIEGbkMmWFCEk6sBMBkgcl8flJELSv63u1+GuZkeN19ukvsKekhlbqBzhvj1ZaXdBJa3IUpWv3Weiym6+7eJ7nkSoj41Qh/TM4pTvaQeJlT6em3o8A+BbTkpEt4ZEff/j4fn4uPJMIlnsbv9FgpgT5LsY7goi/sW3l8NFr3X4nJbNCRBPFaalFkc31MvsWdG8VFU9pfLkFpDEpNKQrlNKIHtDoRaiKSbNZIbg8+DbCTEIdzt8GLHm+A0QRZb0y+Y5hW7sAbtYyTdhKv9HZaxpSvBwNo6sjToq51+38r6Hez1YgW5px6YB2JSiIJ1mBts6DhlRpRVsQCtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLUXxNI01XU0RyKN32LCXXHxFw/TMKZYENV+2mRArs8=;
 b=Zfu1UufuqOj3+xFd1hn4L1ROvFdasFTxOVcxN2+I52hC1vjomkFhENzmgSG5dwl12SajTrbwYiiP9QXzPPU6vJ6RNxhzYlPLf5iElYFeZeKQkVquQKPMONEtIIj/ACxq+r2vmmPq0OTBKPuYtAaLHqTXHgKEjFOVvz6eAvgV1P+PIM41fLR0i/fquP03VSv2MJGngqjFVXyBupVOjKQkP9OCJ/FMN95up9NV9otazRPJNnYj9ROGL9R+5XNBkLlGiUpzZhVGPC8284d3XdPbBYH4OxVwIBEvpcECdZLJI+bjxTL8SqcE/923a+Cz4B+TH6JraQT34hZNe8c7E5MyqA==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 PH0PR01MB6376.prod.exchangelabs.com (2603:10b6:510:19::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 8 Apr 2021 12:19:31 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::75a5:79c6:dd14:3860%5]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 12:19:31 +0000
Subject: Re: [PATCH for-next 00/10] Fixes for 5.13
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <20210407232157.GA578406@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Message-ID: <30099b55-7cea-dbdc-d3c3-31c236678492@cornelisnetworks.com>
Date:   Thu, 8 Apr 2021 08:19:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <20210407232157.GA578406@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [24.154.216.5]
X-ClientProxiedBy: MN2PR15CA0046.namprd15.prod.outlook.com
 (2603:10b6:208:237::15) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.159] (24.154.216.5) by MN2PR15CA0046.namprd15.prod.outlook.com (2603:10b6:208:237::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 12:19:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9770f588-7280-4807-3e85-08d8fa888fd8
X-MS-TrafficTypeDiagnostic: PH0PR01MB6376:
X-Microsoft-Antispam-PRVS: <PH0PR01MB637620B2A5F0ED2664F49C25F4749@PH0PR01MB6376.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FnP0H1HEoFhgCwX+Eum7ZHaib8q2sp7yrAyLdeIyYLMdD6dTXC3Nc2MI7PGwPSaQtuSO9tftMm5/smdH6FEs84fXEIgLzIb3BII3/sElXnwbHabl+Dc5j8hlYWLfkXYc1N6COrEYVQ6aGSGV2KxHDurORcu2iSKlC9a7xIuzoNzgQPOyMMSLreMHgfJ1bC7SiFNn3K+Pg9P6Fx8rJC7/rPmL4+6MJvr51Wb078jslJSdGQr4pgSrNNABvKjb91u0EQmzU8gallj+D48JCFHQ7CAeGbqHSmKaMYfBXOqTdz1EaAQNscZeOgEQHUEs/INxv91lK6qJ0jr6VZGTTstWu9pgKv2EwigD78o5TSydp80m4Skq06E+/mLgL6al4JcC+0a3yZVYT2mGL8BRYj9Kz870fDZW7q0C4JgN0dA20RM/JlZql803YqkbXD8vnoAve0dJHtAdQSv9Q1CPfEGNaJTbHdyBP6dH9sPWbCwAujQWoQK1wgb5qG3ZT3WJJb1yyvINELPLEkbTRAepKgy7+V0CoZrYu+coRMumq/eeSPXfRUTLBk+sYvtnJiY2y2x0R6R84mXUTm3QG1KMGBhEmdSZ5e8EUpQlsoMkRFWcBYCyFStexWX9NWgMVFz27p7EcZ87g6f6/3ciYtPfXhPrIhI29cES6Z7bigvjCereVbBB0tw7Sa93mbVRpi8kCGSd9MtVEmG82lHmnhjonFjaxKYh4soITkv0lORPPYAPoHeu/580EQOsdBCv6yjd5kqI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39840400004)(31686004)(26005)(5660300002)(52116002)(86362001)(8676002)(44832011)(53546011)(38100700001)(4326008)(6486002)(8936002)(186003)(36756003)(16526019)(66476007)(66556008)(66946007)(31696002)(2616005)(6916009)(16576012)(6666004)(956004)(2906002)(478600001)(316002)(38350700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MDNnb3RRTzBIU1FQNStDL0VVZ2RsKytPWm9RL2Era2Fhc056SGNMR3dlWXpJ?=
 =?utf-8?B?WE5mTHRLVXRNU1lURWpyblFwWkRZVUFIR2NoL0JqWmJwTUhBVjdlejBxQjVn?=
 =?utf-8?B?RnNmN2ovUElrZGVmMFhTMU45bmMvb1JxYnVKYmhzSG10RS9OcG50UnVLOC9H?=
 =?utf-8?B?UXhwR1FlTEpDbXRKemppc1ZmWmlLYUppS010dzFlTVdjd3pvbEpUKzNXeUwx?=
 =?utf-8?B?VVN1Yy9xOTNQLzc0dCsxajluZXZqZmZsSk9JVDBoc0lNNzROenVDZ2FrYVc5?=
 =?utf-8?B?bE1XdWxJVHVrTEp6cnlSaFVGaUVTS2YrNUczYjZpS1lOS21OVGtXdjhrOHdz?=
 =?utf-8?B?K1oxeWhZV2tKQUpFM0pIMlhROXo5Y1UxdXdzOWh4UExWOG5BTzlmMTdPNGFo?=
 =?utf-8?B?NG1oV0gzUi9mUDcyeXBOSXVjL0lETys3ZWtkSVI3d3JsZ1AvajN0YjVValJz?=
 =?utf-8?B?eGRSRU1aalNUV2VDMGc1RjQwbWR4RS9FUVU3WjBHcmg0bDV5NWJtWWdiaW53?=
 =?utf-8?B?ZTh4UFVqQXUydUVIYUdDUUpMTWd3Z2d4TjR6VFNlN1BpYlRaNDFNK0RoM1o3?=
 =?utf-8?B?eEdVL2RjcCtVS3ZjLzY4VzZNb3V5OFN4M1FqUWdzZlA4aWlPSFZXK3NaRzlv?=
 =?utf-8?B?dXp4OEtQbW5LQmx1Z2NEUytsSy9RbnIyNDh4VmorUkJza010VjYwemErd0JY?=
 =?utf-8?B?KzQvSUJLRjZHdXZmL2ZaZVdBTGs1UVYzUFp1Z1h5UlhEbmNuclZobWVmeVBZ?=
 =?utf-8?B?VjltWWpQR2FPdG9scytyNllnNVBIRm0wM0NxYkl3QUpkeWZmQnBlYk0yRW9G?=
 =?utf-8?B?ZFN6THFuZ0FDKzRBMHdkd29TcDVyUGRqVFJBVmc4Nmx5S3lJZTdKY0ZrYkdp?=
 =?utf-8?B?UTAyTSszTk1FSERxWmxiQVZ1L3p6aHFWQTVGcndoTG8rbDk3UjRCVm1xV0lp?=
 =?utf-8?B?eWZYNFNvZzcwQlJqV01LZUFXQ2grWTVMN2JNaXd1d3J5Y3dQcytXNzRYTWtx?=
 =?utf-8?B?TUxHbDZpZjBXSStEMnJ0dWUwWWs4emFEcFJFUFFxelJ3VEhMSkVkSU1kZTZG?=
 =?utf-8?B?eVJsKzlRamo5RlNjandrQWNETWlGZ2ZEYTN5Zmhkd1l6cnZZVUh1djBnc0Vl?=
 =?utf-8?B?aDljQnA1Qm16ck5LOXdnd05ON0h5azhRUzBtdnZzT1AzWXFUQ1dGcGFwUWNK?=
 =?utf-8?B?Yjk5UUlHaFIvNjFvaHRUUkxvS29rOStZQ3dBcTRxOHE0VzAxQ3lsaVQ3WURO?=
 =?utf-8?B?Z3J3eVhRQTM4a1g2WGIwSGs1amw1UGlXVERoRktzYlhWVHlWM1dBampZSTVq?=
 =?utf-8?B?dDNuMXM1ZzJHYkxnQjFSOVF1S1puTUtsQXNxMzR1VXBRQS8yQmJ4MEtOMjNH?=
 =?utf-8?B?bjZua01mT3hzZC9rdkpveEtxMVFBOEp1a2ZoN1NMNzVHYUthSjFLaTNSWGVR?=
 =?utf-8?B?K2t4NEJEdElZQ0lPRG9SWUVlWjk3YU84eEM5RVd3WXVQVmhVQ1JDeExsaXp1?=
 =?utf-8?B?cjdsY05NSllreUNyaFlHSFRNdGNTb2tURW9xTVVQSUNFZzY2eDFsLzAwWHh2?=
 =?utf-8?B?T1NWM2ZKVmU4dlZKZ09ER3hLQVVUWS9jNEsxNDFUbFIycm9Rd0MyZlhaSUls?=
 =?utf-8?B?enI1akdPYWFhNlpvdmowWGdHNlRyclV1Z1l5RjFWblBvS0NsTisvd0N1NnFW?=
 =?utf-8?B?QzZFaFBrMVVOVTVlTXJEdU44Z3lmbFNTck1BZGF1ei81Z25XTnJHYjVqMXFC?=
 =?utf-8?Q?g+cFOvploaFxopABjJp+anaqmicr68Z9DPRE282?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9770f588-7280-4807-3e85-08d8fa888fd8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 12:19:31.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YO2L3zWR0FJ5ycWK2gH2XvhPe8F2NgMmK06oTCKqFtfPHsBDfTg+P9Ws3WBguH+yEcj7ttDuifdJPL4jqKKG0djR4YfprPOmUTF9fCzhF4LTHU/5fsqa4WQdvzZa4lE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6376
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/7/2021 7:21 PM, Jason Gunthorpe wrote:
> On Mon, Mar 29, 2021 at 09:54:06AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
>> From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>>
>> Here are some fixes, clean-up and debugging type patches for-next. There are
>> some changs to the way AIP/VNIC netdevs are used and a timeout handler is added
>> for rdma_netdev.
>>
>> The MTU patch from Kaike will to add a physical MTU to query_port is also of
>> particualr note.
>>
>> Kaike Wan (2):
>>    rdma: Set physical MTU for query_port function
> 
> I left this one for now
> 
>>    IB/hfi1: Rework AIP and VNIC dummy netdev usage
> 
> And this one didn't apply, it is on top of the -rc xa_destroy patches
> that I'm still waiting to know if they are real bugs or not

Fair enough. We will certainly rework if we drop those other two.

>>    IB/hfi1: Remove unused function
>>
>> Mike Marciniszyn (8):
>>    IB/hfi1: Add AIP tx traces
>>    IB/{ipoib,hfi1}: Add a timeout handler for rdma_netdev
>>    IB/hfi1: Correct oversized ring allocation
>>    IB/hfi1: Use napi_schedule_irqoff() for tx napi
>>    IB/hfi1: Remove indirect call to hfi1_ipoib_send_dma()
>>    IB/hfi1: Add additional usdma traces
>>    IB/hfi1: Use kzalloc() for mmu_rb_handler allocation
> 
> Applied these to for-rc, thanks

for-next?

-Denny
