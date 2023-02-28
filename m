Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B246A5C17
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Feb 2023 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjB1Phc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjB1Pha (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 10:37:30 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2111.outbound.protection.outlook.com [40.107.93.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520F30B37;
        Tue, 28 Feb 2023 07:37:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX2s38qQ3uOuoM0lXvg9jXOjkvY4HIWvUeXLsLY/DLl6O9drevwTws9ObBe6tXuankqRccEUbJJTG+5bl9AcdIp7eb0GAGBUOqDm6vXPeDSUiiOLuSnOKAV4XVcchB1Seo5CweryXZvFp1o+d4580DnNHdi1t3SENRAXQKovUq7qa1ukxtX8IULfDcyZynKl5n6c0rqNqTKG7oiuEog4gInE8D1TCvExeemyXHe/33kEUNTpxJfyHV9sI0AihEs8tqf7WATWzAwNvRlBPpClNzvBrwmnB+spkUk0Mqxhtgysvg5lphr7MjhQJvf9eOymkp92TqoHnBQai6b0mz5STQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oATAFSZ1NDAEiB5OvJcqbp/Jtzr3zGU4eKvkwrsp4YQ=;
 b=PfC8okNy7F1apWSotqiS47Y/pXWE9pMSG4UEc4nPHVlxR2qq6gSXWzH5M9b+1Xrl9IdJyEbR0v0WjzoztcnesQACF4ypjWhBJjPKoTVC4nSyPFhsuYTcjxWHSOu+u5eINREORNGB5KO4JKtr2zG4+IGYEHCHiBwHRtLPa4z6a9pJDPCtZ3bMCykvY4nJhurYHYhRB+iahSl0KzO0gHrq+PjpPKAXdNUx4hZp9AHIdm/IFnvSoA8e9LM+hsegnY0uPznuAyge2ANFkei2k/ivMUrb/Lc3ZLiKz5t/sRnXzobNb+MDgj9v+x2fIJisC85+1jlehxhfxDy8ER9BBeTSKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oATAFSZ1NDAEiB5OvJcqbp/Jtzr3zGU4eKvkwrsp4YQ=;
 b=VC2ATWk0l5dybidaPg4TRRVVXr0P65PbD3KIXU4hL0VOk5g+cu6X/LiOLFhBVO0/HAUEDmq/yCNRrmu9gH1iojbIFaVr8aO1DZWdVOin1CFgJ+2lXmq2XCRNuvWdNOtsG6fzrJZkHXlPuDnyTFmlnUS7L3dgJM/01G1ahWl1XSIv3SQKoynaD/sw/fvinaCCeaBQYQeTmnn5pY8tZ3q1Q0j/gRRaM9zf/Pa93ZEsYca9ItVAayWX4gcoYssnj0B+qIKW9cGV2q7oT6xdM09xp1CP4jNsvT7qNcRSrUJ+ncwMJ2cTdQzSB+lFAcmw9/ffIrzPA2aQ9NjFRGnmayZrXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BN6PR01MB2610.prod.exchangelabs.com (2603:10b6:404:d0::7) by
 BY3PR01MB6756.prod.exchangelabs.com (2603:10b6:a03:364::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.26; Tue, 28 Feb 2023 15:37:21 +0000
Received: from BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8]) by BN6PR01MB2610.prod.exchangelabs.com
 ([fe80::5844:6112:4eb1:a8f8%9]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 15:37:20 +0000
Message-ID: <81922cc5-4de3-bcd6-b0c3-8f9e61a1e7c5@cornelisnetworks.com>
Date:   Tue, 28 Feb 2023 10:37:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] IB/rdmavt: Fix target union member for rvt_post_one_wr()
Content-Language: en-US
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Zhang Yi <yizhan@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230218185701.never.779-kees@kernel.org>
 <6d2fe281-891c-8909-5330-f05d4407431a@cornelisnetworks.com>
In-Reply-To: <6d2fe281-891c-8909-5330-f05d4407431a@cornelisnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0025.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::38) To BN6PR01MB2610.prod.exchangelabs.com
 (2603:10b6:404:d0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR01MB2610:EE_|BY3PR01MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 1060d8e9-77d8-43a5-8bb1-08db19a1adde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DDhC/5LDJFfkJ9nIpWTPJtWRXOJ8tKe+0zXwmORayOgqMwyhDhXhNe4PZgI3jj0umxh87OOX8ILHlXbx71Fc9BNauxxpM/emvyt5qHk8K7payUanqhIHRreGhrf9/pTuymjhsZH6A1NnuNxoPlH6jVQgE0XoMYMCs6BNugtjTSnaSnrSWUh36C3OHAJtIFjRDEu1vuFJzxivbwVHITaBtebkea6FzH1rhORX2nYR5v3bDeRSzPMGw3EQNfjw7vdFQtf+C8H3IA5FsHyYaQC5VR/m7ZW8TdROnEufpfXAtjnWaRCbzZr7fQn2AF6JF0LePEUCAGyVETeHQL8UL654IdzOAxI2s2JpLFlXCTBcqwYJhehA31WWIReKP7QQpycfxyMas/+EwDFvhGDxa5kRWlic+Lx7mYxkK0YUh3iKP3fTbKWM83vVBPGAgB8/edJPnKq4Bz5kGwJcbtiyOP7uldK17k1VxKMGMVmejalJAMzjoJbxSMRsRr/RJAix0yxmkoaV5MjUbb72o36a040d99JeIBlX2IqKj42dx1/xPDebS5zcX6/iMKiB89ro0FZW00MgFkeyS6W6mnT9B5AWbyN6T5MX8bquV4lliOXfvFAQLPc0EMzWiJiVkyZmREJmRnDCxrTmMjj3YWCJYezy5DM4Pxr7VaX5HGKcJydEYTAXtxqFKI1fEwRTSn4Y3eBT4njmx9RqwWBAAzdN6T/Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2610.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(451199018)(186003)(5660300002)(38100700002)(2906002)(83380400001)(38350700002)(8936002)(66476007)(66946007)(4326008)(6506007)(66556008)(6916009)(44832011)(8676002)(41300700001)(26005)(478600001)(52116002)(6512007)(2616005)(6666004)(53546011)(966005)(316002)(31696002)(86362001)(54906003)(36756003)(31686004)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVEbmM4K050ZkJ0YXVkdmJ4VXJVU1JldkE2dVQ1TklaR1c4aFB5VWtFZGE1?=
 =?utf-8?B?c3RaU01pYmxKT3JGSkVyUzFoRG04bTJJU3JTQjM1bDJJQnpiYmlxQXdCOVpN?=
 =?utf-8?B?cTZSUGl0UXJtNWtxSEpiMkdLaWoxTmsreU03Z250ZnhLUDY2Mjl1ZjE4UE5y?=
 =?utf-8?B?aW5rMDRJZElnM3VTRTRRRXNSbmlxeEtxSG9zSTNtTTl4eFhMbDB0SEFvTDNW?=
 =?utf-8?B?RWMwSEVaWUFDQzIvb0syLzY1Q2VzNDBNTGczLzRwWk1OdkJJRmJib0YzWUZ1?=
 =?utf-8?B?cC9MUUR5M1Q4cmNWYTVzTWFxVktzRnZ0RDNMZE45UlR3QkNhdWJXMTBkVXUv?=
 =?utf-8?B?ekEvMVExVkJWZnVOanlMNjZtM1dmU3dmMmFCR2hQUHJVazRiRE90R1Noc3ZG?=
 =?utf-8?B?ZDBDZWh1SExyWVZyMEgxWTkxaUpjbDZrQVB1NklVR083MndTUUNaRFRrY3pZ?=
 =?utf-8?B?TVN3TFo0eCtTTnU3WDRYUnZDQml6TnlCTlJ2OVdBK2FEaExRelJOL0ZHekQx?=
 =?utf-8?B?RWhKNTdxWlZneC9NTk5QaWFON1BRWENoQ3pKTXBuS1Y5M0xudEUzbGgrczFD?=
 =?utf-8?B?Zi9oWlhMQ0VhTjFOZlZleDdUSjZWM2RWcm41djk3UEpTZk85VHBkQmlaT0hz?=
 =?utf-8?B?N0loaW9Gb1NSV1dhSTRLMFRMWGd2UmppQVBmN0kzaW5FdnJvNVpXajVpTEpR?=
 =?utf-8?B?WG1WNXVGUHgxK2RXbWRDMUNQSlVrakJpc0dVeDhVYVhMMHk5ZFFnditvM0VD?=
 =?utf-8?B?OEFRaHdJNnEzM2JHMjFwdFMyMjE4b1ZCOUN2TEd0SXpKS0tYU0xVTnZQNk1M?=
 =?utf-8?B?d2d3aUFnMkxoc2tjUU05UGVNY0o4anM0MmovSk1LVEJESERFRktIOXg5a29x?=
 =?utf-8?B?U3NZbUpkU1lXa3kxTG1obGNFcnBmWURYdXl0U0wyRXZiTko2NVh3NThtaGlI?=
 =?utf-8?B?Q2F0cXJqdnVnSGpPaHpzUmwreTYxZXpCa2lWSzVTU3pRT1V5WVAwTXpBeHgr?=
 =?utf-8?B?dmdFZ2NMazhZOTBaK1hUTW8yd1pnY1V4bG9odmtIaTZvUFc0bzVBOXJCMzQ0?=
 =?utf-8?B?ZksyUzF6M0JzUDJETUVqaUpxdmFZYktXSkhKNnYrNEZwbUVzcWtNaHowK1ZV?=
 =?utf-8?B?RW5rMHF3YUlCQ2pWWHBhZXhWWjAwVDUrK2ZYYVZ2VkI2cWliNmRxQUZ0ZUJv?=
 =?utf-8?B?d29DbTNGQUN6eDErMXhWbDBHeHNwMmZXckZsNGVFM0xueS9BVU5YOWluaUFR?=
 =?utf-8?B?cldIdVg1eGNaZllFNTdyZWVDMkdySGJQclhxN3JPaXFHQXRvdndWS0dSYlYz?=
 =?utf-8?B?cDQ2WGJKQXhxdTBDSWlkQlZlOG0wai9EWURKOGRzWTFKRWFudFhjcnYxRFJC?=
 =?utf-8?B?SUI4SlJ4STRUbTdMUGNoTmFpL2N3RFNXYXRCMnlLNUtRbm9QOTI0ZU1jSUVk?=
 =?utf-8?B?Q0xKRWFGU2ZBbnQ5NUlLUzZwWlpJKy9UKzhmZkQwQmFBN1pTTmdSTkZoVGpk?=
 =?utf-8?B?cW9ybDQvQVYxR05MY29zZXFVNk10QmtRUzA2QXhMMDhGc2ZGcmpET2lDWEZi?=
 =?utf-8?B?ZjlsUlRXUm1yUDE1c2RzZEIrNHRSd0xwWUsvNE1ZblBQKzh3RjhsZEhVd1kx?=
 =?utf-8?B?NEJvT1dFQllvWDNUZ29BakZra3lDQ1V0bTlLTVRCVUxNVlZUR0NQcS9BNlZL?=
 =?utf-8?B?dndSVVUwVWFISzhmb0NPQ1B1RGJVcEt1a0duRHZZSU9MMGk1UjdxU28rb2Jk?=
 =?utf-8?B?eFo1ZjZ5RjF3RXVRZ0o5SzN5UWJoc3U2SHlxa1Z2bjNvTDhpaTJieG9WWU5Q?=
 =?utf-8?B?MkhCdHJUdXNLVUVpdEVmZmw5UkJXall5U29QSjBCRnhZclNETklGZVh3UHV1?=
 =?utf-8?B?eW8vRHZpV2FMT2dvR01LaXFqcG43L0JTMnBpYjdEbng5a3pOQ1EvSlF0bmFM?=
 =?utf-8?B?YWNmbGUxQ0JvaXJZeW95cUVOeHNwRWkyZnlXVEFwSTNTMXdiaG1TWEZla2w1?=
 =?utf-8?B?Qmc4MzRDcDdKRHpGZVVjSjNwMnNsUXMxVVgveVJaTjUvZU5jYThsKy9odytN?=
 =?utf-8?B?UXRqbGN5TGo3MzRJanYxdzh4SGY5TVl6d3grYjNDaUU5SmQxa1RRMWtIcUxZ?=
 =?utf-8?B?YklucUNBajZOWi9ma3dUQmJ5ay9LRFFtalhTMFVobEtwdGo3cG92QXVocWc5?=
 =?utf-8?Q?CDo56jdzrNEPJaH9Zm4H/d4=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1060d8e9-77d8-43a5-8bb1-08db19a1adde
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2610.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 15:37:20.1935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/+/UIHKyANlv9a5EmhVAajrvMOV67UBOI79hNX+BcD5O09PQjXEbB8VFDU7eqO8GewiGQE3l7pWylfz67XftQ6KFv5QQ0jgkI2lYXWQN772SIzCGdaGDFegRgi4qMl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6756
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/21/23 8:00 AM, Dennis Dalessandro wrote:
> On 2/18/23 1:57 PM, Kees Cook wrote:
>> The "cplen" result used by the memcpy() into struct rvt_swqe "wqe" may
>> be sized to 80 for struct rvt_ud_wr (which is member "ud_wr", not "wr"
>> which is only 40 bytes in size). Change the destination union member so
>> the compiler can use the correct bounds check.
>>
>> struct rvt_swqe {
>>         union {
>>                 struct ib_send_wr wr;   /* don't use wr.sg_list */
>>                 struct rvt_ud_wr ud_wr;
>> 		...
>> 	};
>> 	...
>> };
>>
>> Silences false positive memcpy() run-time warning:
>>
>>   memcpy: detected field-spanning write (size 80) of single field "&wqe->wr" at drivers/infiniband/sw/rdmavt/qp.c:2043 (size 40)
>>
>> Reported-by: Zhang Yi <yizhan@redhat.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216561
>> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Leon Romanovsky <leon@kernel.org>
>> Cc: linux-rdma@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  drivers/infiniband/sw/rdmavt/qp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
>> index 3acab569fbb9..3f707e1fa517 100644
>> --- a/drivers/infiniband/sw/rdmavt/qp.c
>> +++ b/drivers/infiniband/sw/rdmavt/qp.c
>> @@ -2040,7 +2040,7 @@ static int rvt_post_one_wr(struct rvt_qp *qp,
>>  	wqe = rvt_get_swqe_ptr(qp, qp->s_head);
>>  
>>  	/* cplen has length from above */
>> -	memcpy(&wqe->wr, wr, cplen);
>> +	memcpy(&wqe->ud_wr, wr, cplen);
>>  
>>  	wqe->length = 0;
>>  	j = 0;
> 
> Thanks for the patch. We've been debating this issue internally since last week.
> The problem I have is this makes it look like everything is a "UD" req when it
> could be a different QP type. Maybe we just need a comment explaining.

For what it's worth I did test this patch. If you could add the comment that'd
be great. If not I can touch it up later.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
