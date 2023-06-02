Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB76720839
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjFBRPz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjFBRPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 13:15:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2102.outbound.protection.outlook.com [40.107.92.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A405B1A7
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 10:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSZJzvU3QX085urCYB5hVJvg483bEfQllY+zjqQz9swkKN2FlJiT+8RcH3fZ7LSf/jVok4/lTHHRGhUyKj2LCzVbfT87n5AVsPlCYud0OIsmsIcEifZP7JS0c5+sVNGVq61nkzOVpelTSL0Q1o69yJEkh6yv0zsKsSINeUysYsFseR1uO9lyA5aPFrHfNMs3QbX03+CrXvlekYoKMQgd8WHpbBWQek/mi+YR/XgCuJRDPOHQKkhPZF7sJ//3brxy71FB1IRuHfHkbD+K/tVWiEXGFxtmonv5OKMKNSJMzXbF55RhkTPSWJLItUNUVrD1fZicvn5RjoctmtpWRGj3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3E19IgpXm3D2RJ02gqx1KkSb11xFxqPSaryFGbEd0k=;
 b=IbTMmd0uz6R1EHocPIt+mT9u3vv7/VT06d8eE7QHZ+aIcd/0uriJiWoZ9rju49t28NhGR17u04S6kb318TxP4Ez4heDt9WQWAnay586G5Mt0IUHvCG77p6tJSXFG6/pk+cnm7Z81wtSqva3s+vJbvbPwvAuaKjbndElhkfbZOE+llbkMg/VFavcH8xiuBkPCIQgdXYd2SzwBq+TkJlJisoi0L64IX1hxSlM+Kmy72I0nKQKmybDF7NCP8XWdhT7ppHmCt9fUlk7JdV6jKaPWdYYVezQ+/HcOCKSPFJxGkACYX6w5quiupVyBleVK5mVdgqDIMBaqI/B7PWzsSmQaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3E19IgpXm3D2RJ02gqx1KkSb11xFxqPSaryFGbEd0k=;
 b=T5YBkMdFIibjzkyl5r0LLY5uLbFyYRHoSkyyT6niDQQpck5pXykOKx0yuCjr/IZWMYcf7eCR9IzhA/Wnaxc3/PkEHND99snB/M1GtpwainjuDl7kTZhx+5zXhn2Crm+op7zUZR9LbCcEx18w4nJbP5WEdeTnQSWjEECrucqC0gHosDgMhikDFEN29mG7k66SrtXe6PBtl0v0BSxmppZ+kLptL3mOjzx5Msqu4TJNfX6aV12FBFNJWyigXoGJ+zgx3f3XpnmmtjSMo7k+Fww7bB84GJHzottYqpg5YBCyCee+KNxBgHYBE+QMgSOGLcWuZuaZGCas6ZyT+a5oXq/2TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 LV2PR01MB7623.prod.exchangelabs.com (2603:10b6:408:179::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Fri, 2 Jun 2023 17:15:49 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::938b:a632:32e8:95cb%5]) with mapi id 15.20.6433.025; Fri, 2 Jun 2023
 17:15:49 +0000
Message-ID: <97b685a9-cd0b-023b-75f1-48c8df06a2ad@cornelisnetworks.com>
Date:   Fri, 2 Jun 2023 13:15:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH for-next 0/3] Updates for 6.5
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        Brendan Cunningham <bcunningham@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
References: <168451505181.3702129.3429054159823295146.stgit@awfm-02.cornelisnetworks.com>
 <ZHkhjTvi8vNAmmEC@nvidia.com>
 <d5f1df96-b06d-8708-8732-7c034f5bbd81@cornelisnetworks.com>
 <ZHnx2xu/AmkKFni4@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <ZHnx2xu/AmkKFni4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0085.namprd02.prod.outlook.com
 (2603:10b6:208:51::26) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|LV2PR01MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 046c6366-5966-4fdb-0d8d-08db638d02e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uB8ORuw6gkd4EgJna3VjnibDPAZ8bdGMqG0j5XMoeJQvMH5pc8KjAkMo/tt6xXMngWzPEZat8bNFVtTBmm5+5JEBoKq8VoO60hb78WYWWGhEWghHTtfeRmbkrDJyoSvZu9jt6YOvZSNk+M/dV3gcEXnqMZ/0EiaDs+AfXw7AL1F3ArMT9+/cmXAEHgiXNSi+um61fCay4qenN9UGueppliFLk4DRMBgop5DiTV4i8Y9nW5JZ3NTrJQFY6+di5QZSEDh5Q/YrhLlSsxUvVOG+GsHQycDmaVkNAHv3FkuHcbN8tRxY7KmEw7JBKxJCP8Y7T37e9nn0CT07tIhl4YTEaJWj2JeiHyk6m3IqRXzbTLnBoYekBcKn3SQOcbHKb2xn+R9kN+O3jp6TcHi/S7Rk/Oi4YUBGxRlLiInkmxdrzL61mkWz/Mmbpw3c2bIsi0lPtzgCWhmXURdV4updm3HfxZ043xubhzuFY6/npYUFk1yh3XENF1MnweZHbzkGrniXo7Zm3iplz1iEuOR+dHDKmIZOeHwpW5Bm36cKIyifv/XVymxro7A8TbQEo4W2gROnahGLzKTRKwkBde0N1SfcCc2US+P0bdjBNx5a1OVVgy0z6LQ+4txww4P6AHS3PuFF8QT41hpknGuJhiP3Hdm1Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(366004)(396003)(346002)(376002)(451199021)(6486002)(52116002)(478600001)(186003)(36756003)(53546011)(38350700002)(86362001)(38100700002)(6512007)(31696002)(2616005)(6506007)(26005)(41300700001)(316002)(4326008)(6916009)(31686004)(66476007)(66946007)(66556008)(44832011)(8676002)(5660300002)(2906002)(54906003)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVN3Q3JnQi9DTlVyeDRTRlArdExoMHdEdDBIdXVyekh3UWdHNllnQWNRYlVQ?=
 =?utf-8?B?ckYyRktrdnZ6b3RXWThWclVvTkFDUlllRDFhRUt5K0NnY1ZVb1FXOVdTQXpi?=
 =?utf-8?B?TzMxeU9keVl2L2ZndVFXTm9KNGdwYzVDbHpYMEdCZjRwQitaNUdSaXhkV3dB?=
 =?utf-8?B?QVVVd2hxb2tOeGdJMWExbS9qR0g4NGRLM1dCUk1EUjdnWWt4eTFNNWxZVmJU?=
 =?utf-8?B?N0N0QlYrK291aTFGT2g3bW5xdUVYd3MzdEd2MUlFMTVrTjl3MVEvWmt6MXNy?=
 =?utf-8?B?M3FHRTYyNjBXTnZlaTFNNXRpK1pld1ViZXpiY2JPR2k1Q2xxSVg1MzQxWEkv?=
 =?utf-8?B?QWtrejdvemt0eWpqMnMzV011M25wMFlqMFp2UEU1RzRGNjV5QmtISGNpdUhQ?=
 =?utf-8?B?bnJpanFZRFpNVUpham9PODBnQmZYUno3Z2pNTUlXSjdIcUN6WFJ4ZDRLdEFv?=
 =?utf-8?B?dllZWGpXdnJVSGJXc0daZVczZksyZ1J4SS9MN3ZPWVkvNlo1QzdLT2ttY0hy?=
 =?utf-8?B?bkVyZzQ3RWRZNDMxbHJFM09YY25EL055eEs2NVB4WFpyNjhRdmhCY0piMFFX?=
 =?utf-8?B?Kzd3N1IydFRjSGdnTmZTR0RvSnpMbHhHTXFHYXZVUEN3ZUlXTndjZ0dQaHYr?=
 =?utf-8?B?R2JvY0hXRk5NVDgxUXlha1ZmQU5xbjd6Y0NZRm8vc3FraHhJTkdocnR3VkJR?=
 =?utf-8?B?UmhTL2JOWlFWc3A3WGNVMUo3ZHBqVVUzVzFkcFBxUi9MbnlvNHpMTDgybWk0?=
 =?utf-8?B?S3dHWE5XSGN4NEtzVndSQzVBUU9EcjB3Z09IVmtPTUxMVDZRUlJTUnkvNnR0?=
 =?utf-8?B?ck9BOHBoUHU1M3kxZVNHaXBXWDdrMTNGOW4rUmtDTTc5QkNSbFZERVhkMjRI?=
 =?utf-8?B?SWJXUmwrWThhWjJZeTJITGE0MFVpanJudlY1ck1DVTlvbnFkQlFxZFV5S1hK?=
 =?utf-8?B?WkJPUlF4bkJTeFFlU255SVR0YmVUMU1rdnRscGJ3N2FKTk9QRlR6NTI4MGds?=
 =?utf-8?B?MnlCUVlrWVdiMjJ6ZzhkOURkRmV3UGxXajkreUJlYll2UjJkZXVRZjFLdzND?=
 =?utf-8?B?Zitlell5cjNodkphRURUTzBpS2ZCQ09ZL0tRZjVFS0crRC9aZ0VxaTFqQ1E4?=
 =?utf-8?B?aE0ybGhnS2VSUXdFaW5IaU1pbUhEVHlVZnZZT3hPYnFuQmJOUUNGcGJka2hw?=
 =?utf-8?B?VkE1OHhNVUV0a1JtU0l2YlE1ZjVDMmFnOWMzNy92d0tVTTdBeTlRVzcwVUhn?=
 =?utf-8?B?UDNpWVdBZlhVbE50NUZuUkp4QVZWYnd0eVpRTVZWV09lYUhvRDBmR09TRUFY?=
 =?utf-8?B?a0V1ckpHcmFMUXBQNEZBcDlibVhtK1R0aE1SalZ1ZjBHYTFkU21mV2U5eEZu?=
 =?utf-8?B?Z0J5dUxzVDlUbHgyUERiWGhOV3JIdTlrNzNkKzV3S3BkTndQSXJvMmtVNTVO?=
 =?utf-8?B?SnByUUhXZmdIZjFYUlFoRnh6aEtjRzZBV3phZkVpUzZVVDU1aEgzdE0xL1No?=
 =?utf-8?B?eTluRmNNdE1FVnNDaWZ5OXZBRlJYa0I4RjVySnM5S1J1Q0pSWTlaZlMrWHov?=
 =?utf-8?B?eFBwQ2k2SmFkZ290cCtzR1VycGFSbS9NWXRPcytYUGphYUNiOWVaaFl1eGxy?=
 =?utf-8?B?Wk5VVlFEZ3FLUjBjZXRpUFp1TjE3aUNPaU8vMS9pU1RyZ3JaTXp0TVJ0cXA2?=
 =?utf-8?B?ZUduZzZhZFBROGhlM3ZhQnN0SXRXWURPNUNmbW9VbzhvVkF6Qkprc0RiOVpj?=
 =?utf-8?B?ZjloeFlqeVJzc1FJems2NiswOEtpZlM2UWkwVWo5NFRVYWZUckd6SnhiaTNu?=
 =?utf-8?B?L2RQOER3dmlIakNjRStLcHpOZlJyL1kzUlJOV2ZYNDY3QmljbEErQTk4aXpi?=
 =?utf-8?B?T3dVdWhWbTlHcGRvaDU2clpmUWNudW1kRTN3dkxVbkE0TmhSQXNBclArQkRx?=
 =?utf-8?B?OXZwdjY4b2xKNlJHckw0ekJraVgyYndMMlQ5QUtubGszYnZQdHVkWWQ0UkN3?=
 =?utf-8?B?RDlyYU9jKy9kYU5zVjVwbng4QVhKN2hDdTFPOUtPQ2NybVdGRXNxTmNpcEZl?=
 =?utf-8?B?NkxoY2tsdm43bEtvcUw3bnp4OEJkWWhRM0R4TlpWbWpmTjR4dVhXd0dIQWVz?=
 =?utf-8?B?bVZHNnROcDJJb0dSdXhnc3lUZHBKd2U2eEc4WjR3ZktXWEgySTdlamRZOVhH?=
 =?utf-8?Q?crnE//iEEF9FTXNzQGAWw6A=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046c6366-5966-4fdb-0d8d-08db638d02e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:15:49.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzAygneXpUixdleVhi9WLtKIEsapKGEKjzJ9ZzySBVMsjkm2eV+IOa3qCLYw8ZcSFuFsXjN1Z7g5jO/VQROUazOyA+kHkNkPXl1AjynUb1TBdK+haQa5VNHKLIUheIT0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7623
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/2/23 9:42 AM, Jason Gunthorpe wrote:
> I think we said long ago that this was the last HW that can use the
> hfi1 cdev.

Yeah. I don't want to conflate the two things though. This patch is specifically
for the older HW.

> So you will have to think carefully about is needed. It is part of why
> I don't want to take uAPI changed for incomplete features. I'm
> wondering how you will fit dmabuf into hfi1 when I won't be happy if
> this is done by adding dmabuf support to the cdev.

I think at one point you said it was ok to have the fast datapath go through the
cdev. We want the core to own the configuration/etc. This is the fast datapath.

The high level idea in my mind is that we do basically what is done with our
control IOCTLs through the core, setting up contexts, etc. However, still create
a cdev for sending in the lists of pages to pin down since that is hot path. I
assume that cdev could be created by the core and owned rather than done by the
driver directly.

>> Is that going to be considered an incomplete feature? Should we
>> wait until it's all done and ship it all at once? I was envisioning doing things
>> the way we did for rdmavt, showing our work so to speak, making incremental
>> changes overtime as opposed to how we submitted the original hfi1 code in a
>> giant blob.
> 
> I think it depends, stay away from the uapi and things are easier

The new chip doesn't require any changes to uapi. We'll start sending patches
soon then.

-Denny
