Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7827AED5E
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjIZM4v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjIZM4u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 08:56:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2103.outbound.protection.outlook.com [40.107.212.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF0C9;
        Tue, 26 Sep 2023 05:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCHU6KqNX4BJh5l/qilb++bfIBnviQCWcZS3mCeu6ozKz3R09LetZQc9SX1xADtrmSv08CU9txPkbqwE4JL3I7HC5ycYqi0WY2Q//f9L8s6yzfY/BpgMRR4zZxUKIzCbvBEx6MEqzqICz0g5USsNcb7nm/53pqMNBC0dCLtmJb0UWBA/7bD+o1pt2jvcrqyW0KyHAxhekcyWxJuh9fT7NkXv2P2HejpcxKi/qLf0cydJNm0tAfwzYftvPxnGq9VvzysHVXmyaV9Uo9RfbnBQp7Q+V1smZ7iPDXAmRL2QBpF3iQWl1DOONi5I7XiKZLEjAcaq3mXr1PgaRIq3AGINCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3xw6wzoRlOziEez3ffIYsLhsdV822cMc0eEXBL5U9s=;
 b=MdtSocDqJg+xGdfE/O4220eKVcnz9wu0uw23sHf/eeRW5s5cjeR53i/rubezETh2rpHUh1viqXO6+1cxVeIbYHgzQSebrehPgfgqjMYxlJeD5dUnh4yU7PaN1MEtpN8Vjh10RFhL3kyu4pq1QNLSACtievCv0+hXiQd9ldYPPjZv/AxTseDh4HolH+BEKDpU3TzFeUv/0Bk5Vv3Xc4GaD3X6dFn2ylfA809lcAAYsf9ecagfLIZWO3u3LHx7GR55NjZKjc5QPOlzpIspF9lyu0eg9gVqtKBi1E8LZQJU/jrHlqueyTu1CdCGlR6Rst90f24phuXLRa4kKc/hwtkvHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3xw6wzoRlOziEez3ffIYsLhsdV822cMc0eEXBL5U9s=;
 b=dXZhjQrM2wSqHaRnS4bAFSBMStcmDdlreWaYEC2ou1eDLnGxtN6CjYPsEvQpB5b7JTplpYCsXag6Vhp2e0TyG0PQhNQMKusWyozFfa9Egui/AhMol8wVXFKIFbEMmBOp+wWprP3KzA6VjGeLTfweyWncPAlFlTAgwW50O0Y3T12idWfpTn2MIGJnCd7qv3VdTjpfcHOw+SwBgL9JUU4ZlPqY8BMW3bdMD9naR8K8kS/0TzE95ckPGKywQzZ40Eb5l/zUofcYUNtnLoXaCN3C8Qgu8+El18yVVPWbZyf6yFo8TftAJxMjzB3e3XO+eDjuMwmoKlw8cKL18wwmJqo6Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 BY3PR01MB6786.prod.exchangelabs.com (2603:10b6:a03:354::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Tue, 26 Sep 2023 12:56:38 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 12:56:37 +0000
Message-ID: <a3b6e914-7469-42d7-81c8-9775715b263e@cornelisnetworks.com>
Date:   Tue, 26 Sep 2023 07:56:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/hfi1: replace deprecated strncpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Justin Stitt <justinstitt@google.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-v1-1-37afcf4964d9@google.com>
 <169537858725.3339131.15264681410291677148.b4-ty@kernel.org>
 <2f4bd46c-664e-4253-8d57-16bd46dd3be8@cornelisnetworks.com>
 <202309232019.BE78A9C0@keescook>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <202309232019.BE78A9C0@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:610:b3::24) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|BY3PR01MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e5ac2f-d90a-47af-565c-08dbbe90054b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VSNv9T7s/h1oMUWKVm4zwga6x4Hm3PEfp4uzNqP3J6yQz2THRji6U0vMCtK3EkhsEAP/lNaXYnKTdrJjKjJkHjQzLwL3x6AkVGSw0BDOlHE0SqG+efql6LkCH2kkahD6isYqaCzOURBO+t5zyZaIbOkir/wKIxJRZ0KvW66FWV5vzZeFgp5jKiLISNVZr+8gS0vzu1bHy0sFQ3uSQRC7vc7Lj/pvfMbMYcGTNt3yjC92zXWxaFST8GoSTY4rNqiigVGmbUCEttRCxqsvwWM/Y7f549PihSazWI31c0EERz6dp2skfK5hdfqqoziaZwpExsqo0e/n++gLaoQkUgn1VRpG+aCWh8noEhMN+UM7strmkYfWRgTWO38zaEDMU0LBTp8eIuQHakAsPzH4EvCjsrMq6ovoX6Mb2xD04u2vMVO+tD2JlrIn8xHS2uL3PUBsJAPKwlCqsVem/EqDbKN9o0zyZ/RO9RKhgD2lFH/ssvBrXCYrJxjxXDWVDWL4cS++1rHfBLkhuqXSbTk+rrM7vXfr2an/W67b5c5ixV8Z2I1XbSsMWlyDCi1tKzqKoCyRuJw4vXvtVzr77v0Je2USC7g34BWL42O6Z21aFAbZCnJZVoMJsZVlbguMjsfmoLa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(346002)(366004)(376002)(396003)(1800799009)(186009)(451199024)(6512007)(6486002)(53546011)(6666004)(6506007)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(44832011)(2906002)(31686004)(8936002)(8676002)(4326008)(316002)(41300700001)(54906003)(66556008)(66946007)(6916009)(66476007)(5660300002)(45080400002)(966005)(478600001)(156123004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVowSk5LeE9aTlBDU1VwVVhFaXVOZjdiUEpIRWY2VDVoYkNBcnVtNk9IMUw4?=
 =?utf-8?B?Q0xjNEVBeXBiQUJvUVdVdkp1cG9KTU5HM0RQVmk0NUlFOTg3ZVRvUHRXcXVV?=
 =?utf-8?B?c20yYitybkZQcUhCZ2xlNXBrQmhMeDdJT1RFemZsNXRvWS9kQ0tJZS9mREc5?=
 =?utf-8?B?SHc4Yk81czF3V2ZaZ3YwVGkwYm95TnRFOVNWakZPWFZERCtQVUlTa25NMjl1?=
 =?utf-8?B?M3NYS2FmckJtWXJvSVZFY1Bibndqd1JJV3F6bUVyMC8zY3hFMjZZZUJablhJ?=
 =?utf-8?B?RjNqTGthK3dSd2RFRnFVVmt1dUNZR1lybkpBRjAzTHJ3enlKVjlnMVh3UTJy?=
 =?utf-8?B?NEFYeExjU3hXeFlaRm9ObVBjMk0ramFvZmxHelFCaUhZb0JNZXFJMURVTkx2?=
 =?utf-8?B?TFFBd0RqcmtobW1MMG03R0hoVkM4UWN1anNPb21CYlJNN3BkU3ovaUFBV3RF?=
 =?utf-8?B?cUpBR25HSGI2S2NMYzR4NVNTNllQVzIzcndtejNUTzNzWnpyN1ZQUVc3ZDJZ?=
 =?utf-8?B?Tkl2MjRTK1BVczJBUlplaDJDblVPM0VmdmlFTWRJMDk4TEU0L0RMcUNXVWV4?=
 =?utf-8?B?dnI4T2ZKZGI2WERXeFY1ZDlpTVY2YUFSV3lYd1MzSnViYUVzWmhiSGF2VFVE?=
 =?utf-8?B?R3k4WS8yYk5vU0lNTURDY2ZDblRzcUI4TEhiYVhWa0x4dldqWUxjSEIxSUdh?=
 =?utf-8?B?elVwN2hCckExVXJ5WHNPblhLSnpPZ2o0NTJCODBYeXUwQnRVblRxQWZYSXUv?=
 =?utf-8?B?ZmZCWUNzaUhGSldMZkdQbkE0d2ovOEpxWWFlRFdGTUpPbURiOWU1SHR2YkxX?=
 =?utf-8?B?WFdQNEpHWEhrRWcxb25FeGhoMk10SS9PQ0FkOGJTUHFmMUthN0gwSWxHbEU1?=
 =?utf-8?B?dXBaaFIrdllNemxMTGt4clFDY2hPcE5SOXJvOWxYVG1ESm56dG1yM1czeVp6?=
 =?utf-8?B?RkkyR2xwenNnb0RjcFZGT0dseGVJdHlBNUJ3b2xjNkxGRlpWaWEzd3RzWW9F?=
 =?utf-8?B?Z3o3MmFsS3g0cUoyd1l1OGpZaUZCUVZtN3RIVXVWRVhLajd0UVl5TEhFQjdM?=
 =?utf-8?B?V1FHc2Z0NEc1V2RBZkUxdFoyUWYrdUZHUjZ6cjRnY1Jpb0VnbS9SaW43SzNC?=
 =?utf-8?B?UytmdDJ1b3hUMjNBTUhGMDNBVGx4bWRlQTZtQmJJbFY4N2kzaVpQYndRWm53?=
 =?utf-8?B?VlIwYVgyMjVRazhIVkZvSjRPbU1UWGdNbGpwSkVMQ29jODRTVlM2a1RJV0xr?=
 =?utf-8?B?dmRtM0Z6U1ZhZU9ERWN5K3B0T2QyeWVTcERFak41a1RPRE1FOU5Gbm9tSTMz?=
 =?utf-8?B?emFheVdZekZXRWNvakU2VkIyNS9iNE82OFRPeFpuVlBZdm54YWE4QWhzeDlz?=
 =?utf-8?B?TmU5T0VpNGVIekk5Wm5PRnFGUGQwVE5Ka2k0dURlMDZLNHBtdHVRN0w5NkVp?=
 =?utf-8?B?WXBlMXRwb2pDNnh5NGFtbkh0N1gxR1NtM0JJZlBFR215SDJPNHZLR0NQRGR0?=
 =?utf-8?B?NHhLUnNESjhNVkxlMDVPZjlPM0hmWXZzdHY4VDdISTh2VkRMTXNyS2ZKZzds?=
 =?utf-8?B?bWdsN0c2VGZUYk1rc2luTW42OExRc253dCs1dnFZUUZHNEs4azRMeFFPY2d4?=
 =?utf-8?B?bmFINFQ0TTNTRFg3U1ZNVXkwUVhDbUhBdjNrVVhITko2cTB5NzlKc1dQWGE0?=
 =?utf-8?B?cGhPdlVtUjFhcndzckV5akZPY1didE15a3hZREJ5d2p0T2tFS1BQWGN2QzVM?=
 =?utf-8?B?VnJEeGVPUjlkZGttcmMwZm9oQmFRUHYxQlRScmJKVGZtS1ZvaWVhMUJjQXFY?=
 =?utf-8?B?R2xvcTJZNTQxTVRrOWNvcHIxcjZ6aVcwZ3VRZ0hZbjNFRWIwZTVMMzQ1Ly9y?=
 =?utf-8?B?Z1VqWGsrTmU1eHpkR2hYSFNkS0tWZlFlbVpxRmVBNk5IUVFST2greU1tSXNk?=
 =?utf-8?B?L2FlUEtBQldJaldnMEJaanh6bXVCRGZIN2ZiRGswNUJuN2lqSHoxNjVIVmpa?=
 =?utf-8?B?S0lxUDJuQmhRc0padHpDTkVpVFU2K2xBT1JEZUhXMXpVd2NCYlJycVdKUDBz?=
 =?utf-8?B?aXNTSFdwNGZ4dkpNQVllcnNCYnBEemxRbFpVd2lxRWJuR29IWWYzVFl3bzMx?=
 =?utf-8?B?Y25sNnVwanI4MktEemR0N1V1ZmhSNCtGaDBUTEloQU4zWkRZbkREL1ZvNGVt?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e5ac2f-d90a-47af-565c-08dbbe90054b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 12:56:37.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlzU6PNAI0/6Dcm20D5Zi9eEZQbf5HMMS6A91RMqZsVTvlCAW6m7wiAJIBieCQMy+ytsGU/HAppdnIG5Q91f8Ed9K47ijfNEN6bo8K+hW48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6786
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/23/2023 10:20 PM, Kees Cook wrote:
> On Fri, Sep 22, 2023 at 09:25:39AM -0500, Dean Luick wrote:
>> On 9/22/2023 5:29 AM, Leon Romanovsky wrote:
>>>
>>> On Thu, 21 Sep 2023 07:17:47 +0000, Justin Stitt wrote:
>>>> `strncpy` is deprecated for use on NUL-terminated destination strings
>>>> [1] and as such we should prefer more robust and less ambiguous string
>>>> interfaces.
>>>>
>>>> We see that `buf` is expected to be NUL-terminated based on it's use
>>>> within a trace event wherein `is_misc_err_name` and `is_various_name`
>>>> map to `is_name` through `is_table`:
>>>> | TRACE_EVENT(hfi1_interrupt,
>>>> |        TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_e=
ntry,
>>>> |                 int src),
>>>> |        TP_ARGS(dd, is_entry, src),
>>>> |        TP_STRUCT__entry(DD_DEV_ENTRY(dd)
>>>> |                         __array(char, buf, 64)
>>>> |                         __field(int, src)
>>>> |                         ),
>>>> |        TP_fast_assign(DD_DEV_ASSIGN(dd);
>>>> |                       is_entry->is_name(__entry->buf, 64,
>>>> |                                         src - is_entry->start);
>>>> |                       __entry->src =3D src;
>>>> |                       ),
>>>> |        TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->bu=
f,
>>>> |                  __entry->src)
>>>> | );
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>
>> It is unfortunate that this and the qib patch was accepted so quickly.  =
The replacement is functionally correct.  However, I was going to suggest u=
sing strscpy() since the return value is never looked at and all use cases =
only require a NUL-terminated string.  Padding is not needed.
>
> Is the trace buffer already guaranteed to be zeroed? Since this is
> defined as a fixed-size string in the buffer, it made sense to me to be
> sure that the unused bytes were 0 before copying them to userspace.

I was not aware that binary trace records were exposed to user space.  If s=
o, and the event records are not zeroed (either the buffer as a whole, or i=
ndividual records), then strscpy_pad() is the correct solution.  My quick r=
eview of the tracing system suggests that nothing is zeroed and the record =
is embedded in a larger structure.  However, this begs the question for all=
 users of tracing: Aren't alignment holes in the fast assign record a leak?

-Dean

>
> -Kees
>
>>
>>>
>>> [1/1] IB/hfi1: replace deprecated strncpy
>>>       https://git.kernel.org/rdma/rdma/c/c2d0c5b28a77d5
>>>
>>> Best regards,
>>
>> External recipient
>

External recipient
