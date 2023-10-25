Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59857D6178
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 08:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJYGLB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 02:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGK7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 02:10:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB1CC;
        Tue, 24 Oct 2023 23:10:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTiatlFmYaq2mVhpn2a9BRqtO3fSxjdntOg1sIpRQyhYRqJft3fqWyGjcCL5OIRCmDnM8iJY4ZBDvdZcBnkuheKeY8weIm7jaOL0YANDJze9jCYedxi6O8bbYv92er2VSQmoB/LfI0vpsxMdGMcs6omjSsXDMwYNnb4gkwvsxd0J39JnhfOAe0sYQvsdKtMrW84gVoIRYwLl90K6PZ2b+XNm24N70bwjPWLDaz10xMIYW1lGLq/gaw2fpiF+YMh04iP5kDdC6rE6+OBbi4xgweF0LNGegnkfCmEb9vG/a8TEhltmt9Av5YjPxRe4ufkSpdTmfcDCr7EqfWkdv00MQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIHIXh1HRIlumPbke3rw0zVsL1/RCF4lNWNQGn79COc=;
 b=afOjLiETwIL0VVzMWytD5xLkl/6TCqsL4kO/T8QDmax+rJvlRKhTo8M734JKCGZv0kcPFXsDwn5Sn7ESV0Jd7tNdsHTsQ0r9nw7w0guyo6pnuSALCmng/1ABCDLRoRLgG7tU5dEAPVnTte5RFBcMejc6MTSBrP1UNZfndRJdzXS+gPy1A70KGKvRZUeeDXxusDOaeUV/ow/b4PA6gTOBTO4R6AU6qHDgAcXtzCk6hW/ogI4kTy4EmLgWaGCf5knMdPKe/RZ3fo4DixN2mevWokkjaCP+7HhcFNKx9km6KV/EDdrB0HtJixWd5E5xU9YBUEskQFKrfcmozGORPQXVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIHIXh1HRIlumPbke3rw0zVsL1/RCF4lNWNQGn79COc=;
 b=anUVAkze7gP26ggzjF6QgZWRtRUeRhySkonHxkoQqXpOljXUk46D5n+4hoKHBd8i1+p9xJZfxJSpT1YxEwiNc4WVAKxymuwP1oomgS7WOGCHXS41hi05XtAf7QLPxiBiVR3Pq7OzjOrXlNpO7hRCS3YVZj2yXfdr0JDm4XwMnA2YwHn5aA0ZLTw4RbmRhzMdVU2ibGc+sCMUCfYvK72Rt7hjuiEiBAwZapnqB2qtyD67GSHnGM/FCIQdSyeTUT/6/23ZaL6KKcSCc+y1BYU4pCy+zqNNhnPYg8s7LBkuZcgucdfVbV1I2SkdYCaln6jp66zZZJwH5dFM1v27tcCGeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 06:10:55 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::1f1d:ef30:13b2:ca9d]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::1f1d:ef30:13b2:ca9d%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 06:10:55 +0000
Message-ID: <d9b4a501-1827-1c5d-0e14-3957edf7b538@nvidia.com>
Date:   Wed, 25 Oct 2023 09:10:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 iproute2-next 3/3] rdma: Adjust man page for rdma
 system set privileged_qkey command
To:     Petr Machata <petrm@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, huangjunxian6@hisilicon.com,
        michaelgur@nvidia.com
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-4-phaddad@nvidia.com> <87zg0856io.fsf@nvidia.com>
Content-Language: en-US
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <87zg0856io.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::10) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e9bed5-d23f-4462-926a-08dbd52125ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGaxMq5rypctAEwDGExVv2C/gj/ymrgPbJcUQKNPLKv2qToIx5psAQ+p1MoqJKvqCQrxiSEkjTi224UnIMKIhNL0ESbGFrF0d2CzwenRc7/Sk4iIBkuxSf+D/TJBfsp7vnHL/zPGEPQ0LNiptSOXiOr42BAap8lvTA9vXGQ6bBM0wtjXHrfXKlSzE/e3maibl/sfvxahr7fQ5j07eYWQlFGiqO5RLhr4PP9g8VGDAYNWjsz0fkpkVCPseWM5saDXwPP+qLCB7vlgJ/9FeSsjfWxZZ0x6FDCj9ONaOr6Tfz2q6ZBeoLiMO8CUGaiF4MJzPNoKPxFAmO+ig9aNWVnpoiVgJX1+/Fd8Yol3JiLolykvpXmdAtxbTAX2eDs9A59S1e1n55pADkHl8Vgf354a/LDiOe+ZG5jLec8dDvnMlqMHxBbQRwdr44+HhWD04fjW3Wr9ECZJ5duSYXvATJZh72L3U54RS2I4/Vr9Y5eHje2pAyGd2Sbwbtl+DPlANgNRv+nuw3xBxOq2R1m5Oxa8ylWdXO4nmz5XNqmwv6zxrnDaBNAla3Sj26NZFAOGJdcfvwcaGyTm2Fa55SfqmhcYVqHiFkWivfV11Tf4D4V42/o89/pRTS70TavX9ULrakC8ISP9qmHYNceKkgsZqRoeLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(31686004)(38100700002)(2906002)(41300700001)(86362001)(31696002)(5660300002)(6862004)(4326008)(36756003)(8676002)(8936002)(2616005)(478600001)(6506007)(66556008)(107886003)(37006003)(66476007)(6666004)(316002)(53546011)(66946007)(6636002)(83380400001)(6486002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWVad3Qwa1pvWlliUWhyLzBpVGZYOFlWdGFrMDVsWnQwQkZLTUEwR05QMVU0?=
 =?utf-8?B?NkU0WU5Vc2U0YjBiSUtQbk1zWHRCV3IyOTE4d1VteXJZRzUxSWNvZGw3QlJm?=
 =?utf-8?B?cDN1T2s0NVNDV2hieUNLbW5ycGFPTmhlYjZpVW9KWm5yRkNONHZaMDg3Zjgv?=
 =?utf-8?B?aFQ1K29ZMzltTmJhNW0yWXlhRG5XM1FkZkdOT0NrRXNKSmJiNlVxclBEL1hL?=
 =?utf-8?B?ZWlwd2d2WTEzK01VYzJyVmhNc1V2R2JMQWp2RkVRMHBwK3F2YXRNWDhlMWNI?=
 =?utf-8?B?aVVxOHdiSkJRUkRpbVBUbm1EZCtvSXBwQ3I2MExWbDRlUEhsSUgxSmxRM1Bj?=
 =?utf-8?B?OE44RVpRRy9QeVpTdUZQbWJ6SGl5Tjg4WFQvaXZtMDJLZkF0ZjJiOS9sR0NL?=
 =?utf-8?B?WXV1eFgvYkNiaWJqeHpkN2J1SUxoREVMUGwvVWNGd1JieVpTK29hNG9hQUNG?=
 =?utf-8?B?ZWtYN0NaNUIzSW1zWGRTWWh1K1JjOGRtZGZhK0lLVU13S3BDMit0aWw3WWFa?=
 =?utf-8?B?bjBGbURjTjMvUDNZbzZLSlZSdUpoOHB3cU9uK2pwN21DWks4Vlhsb1grNWFu?=
 =?utf-8?B?RXRhZ0NDSjVLTGN3Z080VTFjaXRYdTlpaFZjQlZQRnArWGhvQ09ka2pHcDlW?=
 =?utf-8?B?Mnoxa3NPSmVvVkN4STlod28wMVVUNDhic3pmb2FxbG1RbXVkMmRkanNjY1pM?=
 =?utf-8?B?V05oY0VCMHc0T0t0bFJLeUVsY0RtOWF1UGZCc0hPSzhoeHR5OHViVVczTnJq?=
 =?utf-8?B?ZC90cjdYQ0ZhUGYvNkx5QWY0TUwvK0tiZUtLSzA0WC9nVGtCV2ZuME5tK1Vq?=
 =?utf-8?B?dlFGT2JjbjUrWEorVlNTbE1jTDBUazdsd0tPYUllbVkvYlhlYnY3WG5ZaFZL?=
 =?utf-8?B?d3czZEw4OEJKQ29LR0xnRnFOdGQrc1JNeGJYMnQyWitUZlkwVExneE93Z0xw?=
 =?utf-8?B?SCtJMjMrMUZqK2QvMDE4WmpaQnU2VnRLN2lzVGxDWFJrdE45ZmJRQjIySWtU?=
 =?utf-8?B?RG13VktBbjhzL0Vjc3NiNWtMS0x0eCt5MmgwMXFDME9kemlleTdHVnV1UGlE?=
 =?utf-8?B?WWZUbDBzdjdvUkhPS1d5TWpQU0tONVhpSWZOcUJDMlJUa3c5NFZkZ2tSZWNW?=
 =?utf-8?B?UlgxVXlYVFlaUXpPN0pMODhHRmpFRXdVa2xPRWdrQ0Z2aGcwN0RmQk9zZVV4?=
 =?utf-8?B?OTVnQVdPcFpxYU5KeGxib21nYUtpc0pmZFl1Z1o0Y1ljTmVCYWpjdVA4ZUNW?=
 =?utf-8?B?YW1CV3h1SjcrZ01ERXM4S2d4L29YS3h4VzM5Q1ZxeXllU3Y2Zk5EcWZuK05P?=
 =?utf-8?B?cVFYdDdLYmtlRk9GMi9FeHJRaDZoUXhjVDlzVTBTa1hoVG1qY2RUR285Y3RQ?=
 =?utf-8?B?cTZmUTZqMWZXMWtYQzAzY2lYMmwrL1c3VnoxdC9heGQ3cm44bE8wc3dzQ3dj?=
 =?utf-8?B?VFBwUi9EbjJYSWVHV2N4ckg3WnlsVk9uNW9DSDJjeFlRdmV5b1hWOFE1bGtl?=
 =?utf-8?B?bE5kRmlmcGFVVE9TdUdFS3FhOEF4em14Uks2aU9iTmlGbTR1ZjNRQVprUE9z?=
 =?utf-8?B?QkdRNXRrVDVuekpRa1JqV01hRE85NTN6OFVnaGpBR3B0WkJhV3NRRHlGeWlo?=
 =?utf-8?B?MjdQMHlCSXFtWXowaWw0QjhaTkp6TUR3djljeFk1OVRZZFJ1c1M4VFZGamND?=
 =?utf-8?B?dmxhWmE2QVJWR2pSTnM5Z1dKOFVJa01iUHdzbkpwM0s4NTlnUWNpWWFzUDl5?=
 =?utf-8?B?a1h3Nzd2N0pNQjMxc1BNZ2swZ0FFMS9ETVRPUklTUnJiZnFTcjBldzUwdUZX?=
 =?utf-8?B?SFlMWmhXamRTMTlOMDI3MDlRZGI2ekhwZ0QyRkhzaWZsRmpVWW01bjVPV2pv?=
 =?utf-8?B?OEZ3a3p2ZjUvU2I5TkkxamVXQWdLaVFUNzkxb2liOHczcytpb096RWlvcUNl?=
 =?utf-8?B?RGwvY3JrWlhkaVFWMExQUDc1Zy9ScjBIOW9jK3VJeVZWM2NGUEJ2bHgxN2dv?=
 =?utf-8?B?WVB6ZktJci9NQ2dtdlZtZHZXNW9Ka2RKRk9VU3VLZ2VJV3BMeEZWNE1CdWpI?=
 =?utf-8?B?QnZoc204aXZuUDVTZlZXQ1d3YkZJbzB0YU02RysrU1lHSjdkeFZLbXJpS1U3?=
 =?utf-8?Q?rh4iGzucM4f969BxlNWhmedUQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e9bed5-d23f-4462-926a-08dbd52125ce
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:10:55.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uhiKfQ7CdO2UBituD8QjAARwQWmawg8lbjbcsYHtpsPyUbPzdeItIu8BrtcBtNdYPuboN9Xk3ueLANPwcWGK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/24/2023 7:09 PM, Petr Machata wrote:
> Patrisious Haddad <phaddad@nvidia.com> writes:
>
>> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
>> Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
>> ---
>>   man/man8/rdma-system.8 | 32 +++++++++++++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/man/man8/rdma-system.8 b/man/man8/rdma-system.8
>> index ab1d89fd..a2914eb8 100644
>> --- a/man/man8/rdma-system.8
>> +++ b/man/man8/rdma-system.8
>> @@ -23,16 +23,16 @@ rdma-system \- RDMA subsystem configuration
>>   
>>   .ti -8
>>   .B rdma system set
>> -.BR netns
>> -.BR NEWMODE
>> +.BR netns/privileged_qkey
>> +.BR NEWMODE/NEWSTATE
> What is this netns/priveleged_qkey syntax? I thought they are
> independent options. If so, the way to express it is:
>
> 	rdma system set [netns NEWMODE] [privileged_qkey NEWSTATE]
>
> Also, your option is not actually privileged_qkey, but privileged-qkey.

I'll fix the typo in the argument name, but about them being independent 
while that is true I used or,

since they can't be configured using the same command whereas your 
proposed syntax gives the feeling that you can

configure both in the same rdma system set command.

>
>>   .ti -8
>>   .B rdma system help
>>   
>>   .SH "DESCRIPTION"
>> -.SS rdma system set - set RDMA subsystem network namespace mode
>> +.SS rdma system set - set RDMA subsystem network namespace mode or privileged qkey mode
>>   
>> -.SS rdma system show - display RDMA subsystem network namespace mode
>> +.SS rdma system show - display RDMA subsystem network namespace mode and privileged qkey state
> Maybe make it just something like "configure RDMA system settings" or
> whatever the umbrella term is? The next option will certainly have to do
> something, this doesn't scale.
>
> Plus the lines are waaay over 80, even over 90 that I think I've seen
> Stephen or David mention as OK for iproute2 code.

Will fix all line lengths, thanks for noting.

True about scaling, but isn't the idea behind man-page to be 
comprehensive and list all options explicitly ?

>
>>   .PP
>>   .I "NEWMODE"
>> @@ -49,12 +49,21 @@ network namespaces is not needed, shared mode can be used.
>>   
>>   It is preferred to not change the subsystem mode when there is active
>>   RDMA traffic running, even though it is supported.
>> +.PP
>> +.I "NEWSTATE"
>> +- specifies the new state of the privileged_qkey parameter. Either enabled or disabled.
>> +Whereas this decides whether a non-privileged user is allowed to specify a controlled
>> +QKEY or not, since such QKEYS are considered privileged.
>> +
>> +When this parameter is enabled, non-privileged users will be allowed to
>> +specify a controlled QKEY.
> This is missing syntax notes. One might think that to enable it they
> need to say "enable", but in fact it's "on", and "off" for disabled.
> There should be an "{on | off}" somewhere in there.
>
> Also, line length.
>
> Also, the paragraph is imho a bit long-winded. Maybe make it just this?
>
> 	determines whether a non-privileged user is allowed to specify a
>          controlled QKEY or not.
will rewrite.
>
>>   .SH "EXAMPLES"
>>   .PP
>>   rdma system show
>>   .RS 4
>> -Shows the state of RDMA subsystem network namespace mode on the system.
>> +Shows the state of RDMA subsystem network namespace mode on the system and
>> +the state of privileged qkey parameter.
>>   .RE
>>   .PP
>>   rdma system set netns exclusive
>> @@ -69,6 +78,19 @@ Sets the RDMA subsystem in network namespace shared mode. In this mode RDMA devi
>>   are shared among network namespaces.
>>   .RE
>>   .PP
>> +.PP
>> +rdma system set privileged_qkey enabled
>> +.RS 4
>> +Sets the privileged_qkey parameter to enabled. In this state non-privileged user
>> +is allowed to specify a controlled QKEY.
>> +.RE
>> +.PP
>> +rdma system set privileged_qkey disabled
>> +.RS 4
>> +Sets the privileged_qkey parameter to disabled. In this state non-privileged user
>> +is *not* allowed to specify a controlled QKEY.
>> +.RE
>> +.PP
> on | off, not enabled | disabled.
yeah I don't know how I missed that will fix in all instances of man-page.
>
>>   .SH SEE ALSO
>>   .BR rdma (8),
