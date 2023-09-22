Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C77AB38E
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Sep 2023 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjIVOZz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Sep 2023 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjIVOZy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Sep 2023 10:25:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2097.outbound.protection.outlook.com [40.107.93.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41993C6;
        Fri, 22 Sep 2023 07:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9DUkVSkNDl5HKSVl6wM+MK9dpG2y4Wdr5Y2gmdo9YlcVIO65vxcS3qwucC9AySzPpp121MGaHtCxK2SjwC25u0gW14LGmW1yfJJexffJyyMXEYICf8ySFR9gHoTFJzdDVqK0p1zuypDeCOdIIRXR0fOA1xLER5gg4yd4YBhAUXtDcghW0TFKiCo+82Co4oqdzmmdSq0dmVJLgmHC4QEPmgr7lOD4lUInGewymVfR2hBzbUizLhKYfZBMYxusa+Aub67v8asdbos8NO7FWO8nY/6InXMJk8izlkYu1H1z6MDp+J1XEJtfFtG6kriuVrYBvbqWQKKSzuuKV9mmBuHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpX7eimeoLzk7Re1nJAR2pc3RCXMGHpbWAghz1PzXTs=;
 b=OGW4vDt3WeflAHelisu4L/sfvhW6LrQVbsw0SCM/fDRflpYv3uRmUE/pCupZubg/WSvqZWpWYnqi4TJQWpy4gSML3CZdKwTT/v8PKgbtcG78XLe2fZi9QhxYBow+ukvqcSk5cMba6Ll246u2QU72YMrj/RK0dUsukSvbdEBILzUrrlxfnjcrgc677lO2U7FYxizpoJ/2DLUQ9i17Ezo+lbj0p5/rmZf/c7oao7T9Ir8O1udE95ZHJ1CctSg///coPIiAnn9zoq+LIrla2WMclRiQl0w+OhGhSbhksbzU1WUJFzyxtSN7M6fuWfxIzuIA9X/eExgLrvo0/N+WiInNHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpX7eimeoLzk7Re1nJAR2pc3RCXMGHpbWAghz1PzXTs=;
 b=DSwnP8yVuvM1JH+A3TdIJDmj6tTX8UDE14IiqtWqg0U22xVqVuM+khqBWR4mfurq7QRi2oa/VSMK5sHCxn7RHM2si3JSj4ULpypEGsXIvPuUZ1S4mkqhSZW6ZufqpxGE1t0LVacwhzDPHjYqP30TdZQEb4i4P2J3tOzfMgYSYnmcgIWBAKcpM6j5eyl+ebYc01h6IOBgLTmWq6NJnRDLBiBiqna5D6SyGN7fRerN5C+9k18/pppzWicvtVtWMjffUCxLGss5EfZNTjS2W57VOoMfoF3PBBlVAaJh/e668zp+8MK0kaByzVshF3Agirv9N2u/7PhQmkImXBbaTrR0cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 BN0PR01MB6943.prod.exchangelabs.com (2603:10b6:408:16b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Fri, 22 Sep 2023 14:25:44 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 14:25:44 +0000
Message-ID: <2f4bd46c-664e-4253-8d57-16bd46dd3be8@cornelisnetworks.com>
Date:   Fri, 22 Sep 2023 09:25:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] IB/hfi1: replace deprecated strncpy
To:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Justin Stitt <justinstitt@google.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230921-strncpy-drivers-infiniband-hw-hfi1-chip-c-v1-1-37afcf4964d9@google.com>
 <169537858725.3339131.15264681410291677148.b4-ty@kernel.org>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <169537858725.3339131.15264681410291677148.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DS7PR05CA0083.namprd05.prod.outlook.com
 (2603:10b6:8:57::29) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|BN0PR01MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dc326f-0c99-4fb2-a4a4-08dbbb77ce0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /NV8lURWjbf9BUNDhXerdbm7VrytrRkIxYpFhjEo+LhqNevVdOfoeWFZOnSqoY9z6kYTL/s5BDP8YdCbe6BDgpDNBMO3bW3jkw/q5h9iSX0kVlL+A0iZm1HnosLoMKNLofVmwFknsuWA8p1pNhVBFzbYoGjZbkESbGOAoBZ2uU82+VB4zKsJ6tdxSAyLmIH1GC0UfY06XEIGhAqDrZQ6HxanlTM7R9pqZ26h1uGRJN/roqCj+eiFyBjMhldogntrCen1R1wHwmPadWqGYE3i5fEvfxSGNCbreEx0jRM2YcHJI486fQnLe18Ddw7leyDq09TYUgFw/ZkZv/Ir2St+A3dO4EobWQS0nz0BR/9bYGXHaG9gPb63D5/KC0wU94Xgaxgx8qme4MMoc2wSCKwLr9NmCNXoeVmrg+2v/teqKQyLmaMC8RkP3aja69aeLBMLRnKWfy4Fjxftl7ZNxkWqkHgNjleXTEdyxk3U+QH7ABy6oncPBIhz2thfyOPnCTgaq+k9zIGb7MdpeLE4yj0NQLIz6G67KxnmXGf8zdOGze6S4/r/x3LEloRWygE2WOL3/aILp8i0mK863l+AV9l+TO1t16V5tEW4zavHeOomFpogZWVZE/gquca55WSCP+ji
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(346002)(396003)(366004)(376002)(1800799009)(451199024)(186009)(4326008)(6512007)(6506007)(8936002)(316002)(53546011)(8676002)(31686004)(44832011)(966005)(110136005)(66556008)(66476007)(2906002)(66946007)(45080400002)(2616005)(6486002)(6666004)(478600001)(26005)(41300700001)(38100700002)(31696002)(86362001)(36756003)(5660300002)(156123004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFTc3NxREdKUFVEai9RNmV6aXFzSWF4VkNKU1BRYlEzcWdFTElyTVRwOG50?=
 =?utf-8?B?dW5kUDVZUlR5dFZMUHExVzh5eFRRZWk1QTJQK0lPRC9lNVZjZlE3MjRTdmVj?=
 =?utf-8?B?YzZEamVZOTIvVDBDa2JRYWtzSStKZlNmTlBpUWtBRkkrNHFqY1lpZmZUb3Ay?=
 =?utf-8?B?Nm5RMjVCRUI0WkxIMjNVRE4xc2liczJxWnZhbVJYdEJBd1p1Q2xjcGlETnVx?=
 =?utf-8?B?b2RzM3hvcm9zcHduYW1OaFBsZXNpVENFazNoN2FlRUVlU3FHRFNuMnpiNFlt?=
 =?utf-8?B?QWVhSXFjOHNSU2hyc09sS04yOStGTG11T01RS1BZdjkvaG0wSHJBQkRmdWV0?=
 =?utf-8?B?SFNsRi8xUG11TStuYUtzc3RFaE5oaHU4a2o2RWhXb0Noc2ZGbE1qME4vaWln?=
 =?utf-8?B?SHA2NmZjL2xadzZrOXZ5bHM0cjRTbUtMZHVnMmxBQ2F1Q1p4S2VSclFLWUZZ?=
 =?utf-8?B?RmE2M3R6bUFvcUxKRHNrRlFiYWhGcU5VSW1hTmRObDhuNmJyWUdYV1B0VU1x?=
 =?utf-8?B?aFd0Q3dmRzB4NlJRSGc3djErVXVTdkRmYURWUWhjbjZPTHNUcDYvR0V4OWVX?=
 =?utf-8?B?eWU4TkZEZ3Z4b1VvNjBadk9PcWFKYTU5NWZGWVJSbm45bm9yTUI2YWF6VlVL?=
 =?utf-8?B?Z2Z2aGo4NUNta1lvTlhDUStJMXZlTDZaM2NnVzFOUWJMZFpvWDNMK3VpamVB?=
 =?utf-8?B?REhoZkJOOGpRZFdPelFhSUNCaUJtY3lLZSt3SlYxK2hzVWM4Z1FwOFdSQkZI?=
 =?utf-8?B?QnJEWG5veXVRUFhnMW9CbWFHdUVyeFRtU2w2YnFEODVtZ1h3UXZTbzNydERm?=
 =?utf-8?B?NjR1TEVSRlJMamxOSWRidm91bWVsU1paTGtxTkRCKzMxd2JpZ1NPWThsemZh?=
 =?utf-8?B?M0lMT2J2cUJ4ZVU2OWVUSkZ0WGg2UEtBRHpla0Mwb2pxbG5rQW40UHN4dFFv?=
 =?utf-8?B?WjJZUk56dUI4VitjNlNqSXg5QVpoR0xyZGJoczVKci9keXl3VGVNMDh1VkZq?=
 =?utf-8?B?RHNyK2VmY2E3MWN5VmRoOEY3cHZsUWFQQ0pjNHJaTW9TbDZQRjFiZ3ZXdW92?=
 =?utf-8?B?RWZlcXlWcHNJd3paUkx5YmhuVWt3RjNSYlc2aHl5eE8yQUJNR0s1dFdNRnJx?=
 =?utf-8?B?UTRjeHdmbldCb2srRkRyV0VrMkpGMXJod3FqVW53WlZxNG1VNWlNQ0xUdGZU?=
 =?utf-8?B?d2ZpM0JNZEROcGQxWDkvOUFaSzMrMm9RQ3FyRzd5NmVMNVM0SGNOYm1DQ1ov?=
 =?utf-8?B?UFJNcmRxT2tTbjBuSVFiZHpUVjZwUkRlandhYzlWM28rRlNlcTNRcVptaUMw?=
 =?utf-8?B?N29RTkU1V2x2elAvWmZkdXlhM212RWJTRjNhcGFzbWJxcE45QTQ5bVViNlIx?=
 =?utf-8?B?U2NSMnBVSmFvSmR5Q2Yzd1BwRHhuVUtjMHpudWxHeGFjNHVIZStNVFFkWTky?=
 =?utf-8?B?ZTRXRW4vMlN1czcva29IemVHdlBmQlQ0ZmN3SjhIY2gySHBoTU1hcjBxZ0lB?=
 =?utf-8?B?MThVallncm1LOTVWU0R1b3NkdVR4SzJ2ay93VWpEdDZseHdOYWxuRWZwQUkx?=
 =?utf-8?B?MS9ucU5zM0Y4OWplUVJ2YzVyR29wVHV6UlNNSWpzTFZIb2x6SlpZVTN4UnZH?=
 =?utf-8?B?ZllPNmtCT04xYVNZdElNMVpDUDc4MGROV1UyRml3QVRXYStsNmlKdjJMb3V1?=
 =?utf-8?B?WER2YmpvMjA5VnFGMWJhMVpYdUJxNXBlS2xsZVNkTUhRVFZyV25icDJwUHFU?=
 =?utf-8?B?VklkQXozN0NaM3ZUTWZVdXo1cW5LYlY5bjF3LzhYa3RHaTlxMGgvZk9lQ2xo?=
 =?utf-8?B?b0M3NkdWeFl6RnkyblJWQ2ZoUkQycmxsTk9QeFd3ZXJJMlhuSktCZ09hd09R?=
 =?utf-8?B?WXFlbVBGZnBUVUlzUGIvbGl0bTlVdFNhRDA5NGVrRUQ5OU9IN0oveE40UFRR?=
 =?utf-8?B?VDBETlNZNDhNTHNFUFYxUlQrQk5VWGJxTkd1YWRWSk14VURGeHN0UHZSLy9N?=
 =?utf-8?B?MHN1cU9xSXpENURJaCtDQ2IvK01sYlJEK0VEU1NXbW80Rm1XRk5UN2lHYlUr?=
 =?utf-8?B?NFVzQXhmL2FHbkhqL0xvUkR2TlQ4dkxuVWorQ1JrSWFCUldJVitISTFWMVc3?=
 =?utf-8?B?aFIzNWp0NzdKNFlBaGY5Qm9haHVadkF4c1F2T3pJMDk3WmdDS004NmYrVGZM?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc326f-0c99-4fb2-a4a4-08dbbb77ce0e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:25:44.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KR9gIQHsX7DgiC1sT44U1FY6hGWVffIeN1BLOKCv/XyQeGpGgoqQ9/ubSNIpfSMl/D0/eiawuae5NFLQoZfQjnqRXc67glTcsCRVGVF/duU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6943
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/22/2023 5:29 AM, Leon Romanovsky wrote:
>
> On Thu, 21 Sep 2023 07:17:47 +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>>
>> We see that `buf` is expected to be NUL-terminated based on it's use
>> within a trace event wherein `is_misc_err_name` and `is_various_name`
>> map to `is_name` through `is_table`:
>> | TRACE_EVENT(hfi1_interrupt,
>> |        TP_PROTO(struct hfi1_devdata *dd, const struct is_table *is_ent=
ry,
>> |                 int src),
>> |        TP_ARGS(dd, is_entry, src),
>> |        TP_STRUCT__entry(DD_DEV_ENTRY(dd)
>> |                         __array(char, buf, 64)
>> |                         __field(int, src)
>> |                         ),
>> |        TP_fast_assign(DD_DEV_ASSIGN(dd);
>> |                       is_entry->is_name(__entry->buf, 64,
>> |                                         src - is_entry->start);
>> |                       __entry->src =3D src;
>> |                       ),
>> |        TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
>> |                  __entry->src)
>> | );
>>
>> [...]
>
> Applied, thanks!

It is unfortunate that this and the qib patch was accepted so quickly.  The=
 replacement is functionally correct.  However, I was going to suggest usin=
g strscpy() since the return value is never looked at and all use cases onl=
y require a NUL-terminated string.  Padding is not needed.

>
> [1/1] IB/hfi1: replace deprecated strncpy
>       https://git.kernel.org/rdma/rdma/c/c2d0c5b28a77d5
>
> Best regards,

External recipient
