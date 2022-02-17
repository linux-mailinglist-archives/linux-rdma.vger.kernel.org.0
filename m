Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B894BA163
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Feb 2022 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiBQNhf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 08:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241007AbiBQNhc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 08:37:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB40015E6EB
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 05:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZlfx9lWt9qcu6eF7KhhTAlgQRD2kcitvq6DuN7z9gvNJE/53l7G5IwGKLUr9fYMgtE164lQY32uSi2dca+FwmdhRWOlDYDZp3o4PmGIUDvlbv18n+pN3BP6MvHcWwF7C/hdyo8JuzjQmwJtYAhrXb4B5H5l2axDCpYmMYMHXwKLOFuu8C1JD+2Ks6lSJtS9rTNIQN7giVsK2LnHEYYgPeVVgt9sTbP4fgeljRXQyA8gcwYhfbtVg72o9FA5qgwhvQu/nDMHnQBaL9WHK7PVwltHj1YbEWFT//Sy1+DoKTjuS27FqyOBNjB4QHc4WbUhkRXos3XBI4sac+DHUb+mQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMPMooywa/KN6YSfqJ9a/+HgPaSUubB/lpChrQ9OG2o=;
 b=ZQZtWJ4ZOMokAZpffeyZhc+oTViSJdpCFKZBDTyErYWtUylhEcpTxkQP4jSOf1pAUYoWQ1RV5UbX1OJmUy05wPQOC2YA6FJbytOS1Ji81RbFHyytZMDje1W1Qa1rfalXLeICv7q9nqY/kHxvk5IvZbMGl+na91LcJa9GeuDY5/m6UDa3BhSYhznuHZx+9t9PVwVM8z9g7NH5e9O+GzKNqKE4kk6OFLJND0v0UScUFFv+yTEyZ4wtzGxdQCNRS016y3UWn82+FoTmGns5UWDYOL1FpwOU1wyoTQkdlr58ohCXo3NNeuvKGT07yzwNC9wiwmHuBi2A7/bn+JEJTKUSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMPMooywa/KN6YSfqJ9a/+HgPaSUubB/lpChrQ9OG2o=;
 b=e4rY4GQMm8XjPXF+tSCiyANSblcDikJRply/DqCbFtCzSlHvvIXUbhy2AuHUMioPpFTbQn1OT/j3JQqbWdEBQy+xW16oOXY/nxS9/YxmnTznAjCQRiCFqIpMaA8024YSoQGmapeOV4THVvxR1EqyAVy4OwiVaJ25JvHqrm9Zj5mu8xH4c4ukr4Gk5bdEFAttGjLWtWBEuCojF9S2QNjF+E/fz/LQuPdW31CPbx243HQ8pbLjC3iB/nUJJ4A1lFVaWtKl/MURxcV1xrWvGeDegNJNtVZZxRpKFT6tZoWR8bzLj38oBFcUwZfUPJUD8e/tV1+NoK+ifxBQyfg/WMJBOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BN7PR01MB3923.prod.exchangelabs.com (2603:10b6:406:86::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Thu, 17 Feb 2022 13:37:13 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::14ea:6d28:36e3:d12a]) by PH0PR01MB6439.prod.exchangelabs.com
 ([fe80::14ea:6d28:36e3:d12a%8]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 13:37:13 +0000
Message-ID: <b6c38f40-cbed-9ba7-7184-801ee7c5ab3a@cornelisnetworks.com>
Date:   Thu, 17 Feb 2022 08:37:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: sysfs: cannot create duplicate filename
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Peiremans <rpeiremans@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc:     linux-rdma@vger.kernel.org
References: <20220214180833.GA525064@ziepe.ca>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20220214180833.GA525064@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:208:32d::33) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05b11e7c-fd49-46b7-0364-08d9f21a9a93
X-MS-TrafficTypeDiagnostic: BN7PR01MB3923:EE_
X-Microsoft-Antispam-PRVS: <BN7PR01MB3923FEEC8FF85C2ED6B25A4DF4369@BN7PR01MB3923.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iS2T2PsR5tTGFIlXqh9CymJH4KR7oNzYwY/9RdrKPRmONbaf66/uDglg/DOlVgHY/5kMgSAL3qS68C1rxXD7o6P1Dhq1SwecUGQUO3POeuP3XGxA147N6YOA+XogM0rtcrZRKnXdp4WDj2Bligipo73u4W7phb1tXjoVy3i1892b3N3cd0KuSskurRLp0lTUgID+TxhMmun5f7S0Ycxr65HWWJd0FSupjiNAVZNWkzh0GNZBMuQzWoXdMuQKMRLqI+ZhEURh1d1DSO8LcqGBix2hwfnb4yFS3zzoRtWV7H1liT8fVLWn3TSODf51rTuqO897rJnJPjYLOB4nlj1EqbFl+YS7WFn1EBFk+bcuPtUdDdIDEvQmXlD0cOOAIzBYzIZgqzeDF9zsHaa1K3MrlF3RS8gvkRDHf2lIilrwpAALXobLL87uzCiZPuE1j4Quj2yB3oPsdfidMdJEpp+I6XPQfCbi1x2xIrO7VyXfqDM86kUvcEVPuZd1orxMQn23eg6CvVo6avKacD6ceZhQ9r7uqTjpq9U8HUfRs5ueETvg9zy4SyndVRGeNX4Zqk/tofnHgSw/v359DF5bNh2u0TKVP9cn1BLFyebj9jFNYoVWdHpOIVWRZX7vJV4RY4B+eKBNvgkaR053+EXPXUqrc4KbpPrUwZiQp395MzYmFSxpLuCj7TsfW8ACPDdJeEf8B7baZf72AHsnA1pJ5XjxFnpxYbpdSMAZRydjGd+D6+Aerep7dshB9YlMFpJITGyU/PrQ+oTPL/PtUOkqhXZo1PsVq11Q6hSImvwv/BDCV/htRYFz+gyftQ3NbG/GXNZ6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(39840400004)(136003)(376002)(396003)(346002)(5660300002)(8936002)(66476007)(4744005)(38350700002)(2616005)(38100700002)(31696002)(86362001)(44832011)(31686004)(36756003)(2906002)(6512007)(6506007)(26005)(186003)(508600001)(52116002)(53546011)(6486002)(6666004)(66946007)(83380400001)(4326008)(66556008)(8676002)(110136005)(316002)(6636002)(16799955002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnFvODVESDlyVjM0Uk0vbEdRNXN4SkNMcnFlL011N2I3Y1lPNlhRd0JhQlp3?=
 =?utf-8?B?dmhFbWwwZ045OEVEdkRCSCs0SHNvNlhRcmI2azMwRVdJZmY0TjdlSGhpTWR4?=
 =?utf-8?B?aHk5dUk2N1ozQU5uQmIvQ0ZrckRYOWlCZEk2TDBxKy9WZ0Q4UnkxYTl1b2dH?=
 =?utf-8?B?S2F5RVRSWjV5eEZwOC9aWS9mRkJZT0tGdDRNSkx6MXQydExoSHJNUzYvRkNt?=
 =?utf-8?B?WFRUTXpMVUNNeUY2ZjYvdEdoNmZ2UldsbXUxWmRQY2J6cGsrZ0pNTDdVY2dQ?=
 =?utf-8?B?Zm0xS3hPOVhLSzRFMHkxZ0hldEsveUx0MUluRVo3Ry9zOGxHTElPbGs4bTRN?=
 =?utf-8?B?REUwT2E3bWZGb2VkWjByektkbHVXSkN1am1qY3pwM3F4SGdMaXY5U0NEckVv?=
 =?utf-8?B?S3BJbklacEZJNFpObnB5WTFWWmpTeUZ1b0k2L1R4N1RuWms2Ukl3dCtRZWlo?=
 =?utf-8?B?VnA5dWJodlhJME82dFNnbC9ucVUzTW9RZFFaaU9iT1pZaVVLVHRMZmh5YkRG?=
 =?utf-8?B?UVFqT3hsVlh3TnpxRDJncG43TEE0OUt1bllySmc4WXJsYm5pbTVSZFZrb0Fl?=
 =?utf-8?B?aUg4aDA4dXlPZEJvbEw5dkEwM3RHekx4YkV2aGZVVG8rV1dRamJsRk1IcW5Y?=
 =?utf-8?B?TlAxODI1M2pwWndRN1kzUkcrMDZFbDZkMUlrWThCNFd4cDFUYUJObHZQQ3ow?=
 =?utf-8?B?cWd5RnVTMFR3aVA0d2NhZ253Z0s0T1lGdGxGVVBxUXk2MDJySjFTNUZqeStO?=
 =?utf-8?B?dHlUMGtrSlg4bEdGdjdiVE13YzhLVXlWUFhGc1cvYUYxT3ppbXZkclM0UFFz?=
 =?utf-8?B?aTgrVUtJV0lvdDhsTkFSTVMvTUhQWGd6bkpEMTFOMW1FTVlOYkNTTDNuNGpW?=
 =?utf-8?B?YTVwWkxmMU85ZzMzZ01EelM2N2RzMkhTdFNGYnFMV1ptbFJGY3NNd1VFc09Y?=
 =?utf-8?B?WTY3cXAyT1RodW1jY3hoVW5JQmVUU2poWkFlcFlab3Z5UGtZUGFrdnkwMkRk?=
 =?utf-8?B?U0ZXa1VjVzZsYU9qS3pneXl5Nk5PVU04S1lVWG56d0o5MENXbUhMQ3I0MDdi?=
 =?utf-8?B?TUIvOXVtcUQ5d1JXb2ltV3F1YUdLSzJoYUl3d3hxYVdwQzFtdGNwKyt6OXdP?=
 =?utf-8?B?TVlaTmdOU24yRTh6eU5GOWh5cG5DTEswTDBSaDd0WFRpSDhhbm1MQ3ZIZTYz?=
 =?utf-8?B?bmRoeTZXaHEyL0I1MWplb3hiYzl1bytRRlNiN3hLUnVtY0hOcHpxV0p2dERR?=
 =?utf-8?B?MnUvcytiOUpDZEJwcEdyMkpNK29BS0dVK2xYK0Rkdy9yeXB4dW5neWRyaE8v?=
 =?utf-8?B?WHo5UlNGRnVIQnc1ZVlGaDk3Y3E4ZkdDVk4xcnFqQ010dytVd0J4dG1tL3o5?=
 =?utf-8?B?dmZlQ0hVQ2g3eWFyalk0a2ovRjE3ZDUxMUU3Y3drUjhzeDdvcC9RdVVTQ1FB?=
 =?utf-8?B?WXhYdEQ3bkZQeW9hSzBwbGpxeENackdDb2E2Qzl0Vnl4cW9MdG1YdXJ3ZjE0?=
 =?utf-8?B?dmZvLzJHVUtHdkh3djRpRVNMSExFNlhySnZiOGZIbktWeHRzM1Z6TmMwdGIr?=
 =?utf-8?B?bitnbEZpSU43cGFVTGwwNTVFNXZ4bzBkVlpoMjVpaWxONnJTYXFsc2FybElR?=
 =?utf-8?B?Z2ZleW9jRUpOdjU1MWFBME10Vm1sMG1iTC8rUlNXcGdHUlRaVFhyOTd6UFgz?=
 =?utf-8?B?MlV5TVdYSkM3OElNMWNiRi9IREI1b2RvSWtWL0JqVGdnVVUzTVNsbUFDek54?=
 =?utf-8?B?RktsWWxSaWhCekQ3c1JNeWlHZWVBdW1tNHpvYUVuWjFOZlZUQUdJa2dNUS91?=
 =?utf-8?B?c1NiUzJodTgwYy80V0dzM1ZsWXJjbmY5ckZ2bW1pcVg1TGRqVnRvQWZPSk15?=
 =?utf-8?B?d3l0RWo1KzNZcTFKTHBmbkU3aHk5L29vZ3psZVRTNGc0bG5VajJibndBZ1ND?=
 =?utf-8?B?V214ZkJpa05tLzZRb0pId3ZrK3p0dGxBRCswdVpuQnYxeXh0N3VjUXRsVTBH?=
 =?utf-8?B?bEhZRHpCejRnUWF4YkgxTGJKcTA3cnpiejRJeVFmd1VjdFE4ejhFYW1QRjhC?=
 =?utf-8?B?b1M5V1lJTVp4eDYwUGsrdk1NSlhORlZXRjJLMUlwZ3lwSHFMeWx0U0pibFRj?=
 =?utf-8?B?MndTWFhkeitQVm5BQ2s0VTVGUWVJWmN6bnF1dEQzYkRhK2dzM0sydDZaMXlK?=
 =?utf-8?B?MGMvaDNPWGJjVTV2cFA5dXNVVjJERG16YmVJNFF0RGxQWXN1QjVUT2JhOVFJ?=
 =?utf-8?B?aHZlZnJPakdCMWhtMzRabXE2KzJPeDB1TjVXU25qdkcxV0Uwc3VsZWR2TGo4?=
 =?utf-8?B?ODZTRW1MNjdsTDFlS0hISFJJSUNXQ1o1Zkl1elFVOWhaSVFnNG5GUT09?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b11e7c-fd49-46b7-0364-08d9f21a9a93
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:37:12.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCyXx90x4xKF3VcuG+zRSUjIkqTaRva+6JRqFlDhr3CAfYPYM17tiuBuybZgZyayZNJ8lQyofV+K/L3WwQRKC81dL6Mxp6Vy37RORp+bQ+u6SxMq15OChX5i/EG4OEQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/14/22 1:08 PM, Jason Gunthorpe wrote:
> On Sun, Feb 13, 2022 at 10:21:49AM +0100, Robin Peiremans wrote:
>> Hi
>>
>> I ran into this error when upgrading to kernel 5.14 (it works
>> pre-5.14). The driver gets loaded (verified via lsmod), but the ib
>> utils don't show any ports.
>>
>> There's a bugreport on elrepo
>> (https://elrepo.org/bugs/view.php?id=1176) that looks pretty much
>> identical, but it looks stalled.
>> I've bisected the kernel and commit
>> 4a7aaf88c89f12f8048137e274ce0d40fe1056b2 seems to be the culprit.
>> Since I'm absolutely no dev, I'm hoping someone here can figure out
>> what exactly is going wrong. Latest mainline kernel still has the same
>> behavior.
> 
> Don't know, Mike tested this patch on qib, maybe he knows

A patch to fix the issue should be posted soon.

-Denny
