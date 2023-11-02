Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B767DFBBB
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 21:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKBUyh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUyg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 16:54:36 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2133.outbound.protection.outlook.com [40.107.212.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27734185
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 13:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSEHvJQPLfVVdeETUDy+qOLnIgk3EnhliLsOEVzPlAu6P4CnBo2MX+QtlqovvtTomb2Y2DuGPYsTNe0hI2xP0PGu8rNv9Hv7lJbI2+RMRtoi/dLlyQdQ7gNfqkYlDoOnF3sVfAT6O1h6nbitwJ7NcS2bJw9lai7pER1jTe7brzFAsrZ+hHgzqEOUQ8hrtuMX4+MjAz0cDe6vhkIMserq7KCi6cbgecxYSNKgf6629Vam/ZASsc/vP0SRtfkjA7pDv6Fz8d5Jtuz1OdXvCj0w9DnSor7d7lG40pofNdCsxcZif+Q4KIbHY1pjx+Y2P6IYkgh7duwm3iZMu3fqJkCrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aAsoYFHL20LmZedQo0GVXqu5MOjwTSAQla4eJKHX6o=;
 b=VNquvSRMd+cFdG4fPXT42ukihfbdmPQ6iaCTUCrMMkU7kolggoAtc5XmJS6qSz/e+Pnf5YMtkWTY8sVkyzEQfpWyNwCx7WciAtvI4nVWG9t59HbR7Eksw8NaFO7RMRDWbUoE2IZdEf3HrMQ6LjvGw9J1M3CCl2Kupmva/RqRka57N78t8M/ypfOwXR6rKbzRGlvjbgtM15ILoleTBAYZUNYFxh+bveASa94t1iW/dmOqrUPDrw1Ty63dvEJp+NJyXNVPHTrMbRGjya233e264lyYQnDTHL7uc75/3WibNU7AA9glrvHYnAFrSkd+DiL0q/H4Kb5DkrEIx8yV4pR9Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aAsoYFHL20LmZedQo0GVXqu5MOjwTSAQla4eJKHX6o=;
 b=fiyqWYGg+D98t5T2+120T5870mRG5jB6UxZGx9SYjNuissNlKqXxWaqdffqb9I+YMDe/6wOS/jbyjwaYTj0oq3Lg2pNqNK5GpGK3JCTL8b65Dqv3zuHMTRxuDcz/8w4M2Q32wgZlcV/8PUJEShILaKlkqoA12w/cXggIEVldCUm5as+9CTqEfbMzzBWbh9tCpK8YJ4RqpAgDlWwlBO1/Vt+s0RUzmbDtKKRA7MLpVqllIna3JPGVudu3PtpFcK+VgWC4KG23USkla74Babvpocs4T0LT2h65rs3Qmoi163b8QiRgq6lDh46eB1E8sNKd4KbEOgliyRJ0ggdaM2V+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4099.prod.exchangelabs.com (2603:10b6:208:42::12) by
 PH0PR01MB6556.prod.exchangelabs.com (2603:10b6:510:78::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Thu, 2 Nov 2023 20:54:25 +0000
Received: from BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::e136:9901:2a4e:2eb7]) by BL0PR01MB4099.prod.exchangelabs.com
 ([fe80::e136:9901:2a4e:2eb7%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 20:54:25 +0000
Message-ID: <daf453fa-c834-9cf1-0ddc-04abdfa37abb@cornelisnetworks.com>
Date:   Thu, 2 Nov 2023 16:54:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] IB: rework memlock limit handling code
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>,
        Maxim Samoylov <max7255@meta.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
 <20231023055229.GB10551@unreal>
 <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
 <20231102123216.GF5885@unreal>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20231102123216.GF5885@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0370.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::15) To BL0PR01MB4099.prod.exchangelabs.com
 (2603:10b6:208:42::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4099:EE_|PH0PR01MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc21b7d-a149-454b-c546-08dbdbe5e56e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRIS+f+RrB/K4cUxFzD3MAR0ScnppDxU0FuPBJrmn/23dFLY/IBI7Nj+8/9x5Uj1exWWQXLMvhmsTltEfcOa3gAckNDul0KMaRvdbt0BWTVVv1e36OK4G0JUsAw94hX9V/wvyEdrJMiXlr7+1dzMGnKk417BJ1HexL5UKAiJtLNnTr6MjBoGfyRVLiwmzQ0kKzuv9fVKuRAfIqMX4/GOa9hVP77L44JBE5AiuZN1DyWBhIqQAKLIdSWbWxeRxqG4YeUVrvIFWG/pSVyJYLYl0inVp36Pt8XC+PknkEZoc3IKB0agZlRnp8eaggxD4nY3arwBJeZe8cHWOHhVMR/gEWwtLtQQ2OYEw1fiSt8jqv+uUHkUJIjEMU/59/EmGK/CLdi52K6jaKC0Ke5CtQozZqFgb2zdDsjv7osXx3jJRS2pqCoKHg0WqJOxC5lm79J2OfAW86gf2Jib80rrpt3kGv1ADC8XvJFmoO8Qzj9e//12y6HAsiZlnMG0tETmLsa+R/brDucCE7nN1/fFEFBsoOd67JS/zSj2EWVNsXMbNjhwZqyn7jkYoEmU3UdnZKjSt00VlBaJdlfoGybyPmIQolMWNHmh0JRL7Et04Bn62Htz5wQdBhtWzdQViK9ddSMKGjbwqyTeHuWOAt1lNMBPAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4099.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39840400004)(451199024)(1800799009)(64100799003)(186009)(38100700002)(38350700005)(36756003)(86362001)(31696002)(4744005)(2906002)(6486002)(6506007)(6666004)(478600001)(41300700001)(110136005)(5660300002)(26005)(2616005)(6512007)(53546011)(52116002)(8936002)(8676002)(4326008)(54906003)(66476007)(316002)(66556008)(66946007)(44832011)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxTQlV1M3F3KzJwZm5YeVFvdS9JbFBhT3pCN0ltNEkzdCtEUHEybUg4UDFz?=
 =?utf-8?B?enZCZzZRT3kxOWJrNWhxbXFIbkw1VXJOaTg5V2tlMU5pZDJkbG1IRGtTckhk?=
 =?utf-8?B?bE5idzhBckVIbVdHZWJ1NHFQU1JZeFRvSzZnZWJpRnNaZW9EK2xrRzQvd2hI?=
 =?utf-8?B?MEM2bjBINW9xKzlTZkQvdXNqRnAwV0dnOTArYWM5ME1DWi83Wml2SWkwZG4z?=
 =?utf-8?B?U2EzcWw4WlhzS3YxVElGUHZBNHI4dm1ESDBVOFM0N0NBOFU1R1BNMlJZWW9y?=
 =?utf-8?B?Yk1GTGMyQ3B3L282dEMwN1BlRll2N1JvVmpHRUM5aVpzdTNPN0k1azNVeUNk?=
 =?utf-8?B?TVIrWHkzNXVveU5TRVZDNC9ZSHFqL3BaOWRtS0VJYjZUTUg1Vk9mVE1Ubk45?=
 =?utf-8?B?WDdicVJyNjF6Rlh1VkgwM1B5cmNEd0NGSEw5RUhjaWdPS2x5aDJFWGYxTVJE?=
 =?utf-8?B?bmFXZWlSS3lzTlg4dXZJcnlNc3NzUGdFZlEvZUtmUy9IMVlWNFhzRlNWQVpx?=
 =?utf-8?B?OTQ3aTF0YzVJRmhDU3ZBdC9QT0YwVmVHcndQWVZFM01HVFc5ZlhHM2p1N1Bt?=
 =?utf-8?B?SHlwRVl5VHRKUGZqV1dDcGk4S3hjMWljZzdzdjFkREFtc2YwQjBLdDM0eTNk?=
 =?utf-8?B?YW90cmNWRUxxcDFSVlpRQ00xaTU3TjVJZkJPY2JSZUJFd0liS0xvWXVnNUxX?=
 =?utf-8?B?dTRLOU41Zm9wazRXMTM4RDZ3WVBJMHNESGpXTDIwZThaa055ZndRNVcvamZk?=
 =?utf-8?B?WFU3SGpQektoTzJuTyt2bGI1WHd3ZlhGblVkbjg0eExxZXJFRVJiaTBXem4x?=
 =?utf-8?B?ZDdKT0pzcm1VTXhKNWRNNHJxYmZxT0Z6dGFaM0NXVXFVems4WGo5VTFIUHBS?=
 =?utf-8?B?Z3BnaDNMRnhwRTFqakxFeUgvTkJkdGtCSXo5djNRYnU5OGZNRG9FdGZxM3Fs?=
 =?utf-8?B?TGFsK3RIQWFlQ2RrT0xqVDRZZ2NNVExua0c3dDg3U3N5ejM1a2s4Tjh1ODdQ?=
 =?utf-8?B?bzN5cGJWblhaVDdOVEpzMS9IMHZmZjZmejRFNUwwRCtkTEgxd290ejhLdFZK?=
 =?utf-8?B?TytTb3Y5dWJXNm8yckc1aS9sYTBLY2FUbXNwVG1hV0tOamJaYW1RVXF2MUpE?=
 =?utf-8?B?ODJHeVM1NlpOWGRNV2g4VThrOHd6cmdXd1F6LzNienEyNlNqYXpIMFZlM3Fk?=
 =?utf-8?B?dm12ZFFDSnp1ZTVIdzZZKzhSa1pabDFSVEVNaVpIYnh5TnJnQU5scEh4MjJo?=
 =?utf-8?B?OG83YzN1N1AyV01GM3FNaXlKalJDQWcyVmhMNFlHVUY5YWp4RkZsZzdweFBD?=
 =?utf-8?B?UEJpem9JS3lNMms1SHN1OXFZWmR4Z2txRXpSSFJIUm1IMm1sU25WdVdGcEJ2?=
 =?utf-8?B?MHVBNGNJcnJwMEZPaGNwazB5RHN4WUt4VVUvcUZtaGIya0M3bjlyR01uK29h?=
 =?utf-8?B?Rk5NVTdKMjlKOVAySVlpY0grbm1IUVpvVk80MllHSTAyQWpVTXlQUkh5cGF3?=
 =?utf-8?B?ODZ0M0Vjc1R0L2hualc4b011ay9yNGxOSHFpdlAzSVEycTBWWStQcnZlSFRE?=
 =?utf-8?B?S1VNcWRaVnZidHRyUVN2R29KZlE3OGdyaWI4YkcvSk4wU1hnTFh2T3RjL2xX?=
 =?utf-8?B?S3FORk9sMjF2WjBmTFM5Sjk4TjVGM28wNkVWcTlhUmNRaDIrcnd2c0pWTVZO?=
 =?utf-8?B?VkU1K2t0UklQWVNOQU5rZjBGK29peW5XcEE5ZWg0d1gwN2VmVEdKTi9LaVZX?=
 =?utf-8?B?cjBDTHdWUEUwblFpODFjZ2lCUzU3SDlEOW03TFR0L3U1c2xpcklwWEQ2L3Vn?=
 =?utf-8?B?dEFrbzk3ZUxjL3pDbGtRenhubU91ek51MGo5Ti9mU2JLM25laVlFVHhTdmpE?=
 =?utf-8?B?U1kxeUpkbE9HNHcwSGs5clBwMG1DNzJKME9ieXcyQW5EN2R1V285ZmJKUEZ6?=
 =?utf-8?B?d2dIVFVpTW11ZkZ5TnBDRlA4MzBONWJrNXdWZFRhWUJOc3RxTUFJSWlaRVpq?=
 =?utf-8?B?aktQejJleUk4QU4vOTd1Q3NEWlpQVUYvQWVyU2pOSENUbENLVXc2NlVPY2ds?=
 =?utf-8?B?NmpTSEdJaTJWK3JGcDdCOWJ4NGs3c2w2SWl1WUNtWmo4cWVaVWZleWpBR0VV?=
 =?utf-8?B?VHFLZ0ZqZHY4UFlXVWh2SUc2MW9aRHFvb3A1RDBxd3NZbG1NTkNoSGNpbUQz?=
 =?utf-8?Q?QU2aXKnSjvE6uTpNN9vKYa0=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc21b7d-a149-454b-c546-08dbdbe5e56e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4099.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 20:54:24.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW4t/WxPslA0QxA0/JWOVTo42C1sfehDwwrsSOg8bO9auSlISJHH5jGGIK7RrquSHTFc7sZ3402BC7sdfvq/wKWXXy/6Lumce9bjyPxyqClsg2YD0YVnpjye+rMFyN0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6556
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/2/23 8:32 AM, Leon Romanovsky wrote:
>>
>> So, as for 31.10.2023 I still see siw_umem_get() call used in
>> linux-rdma repo in "for-next" branch.
> 
> I hoped to hear some feedback from Bernard and Dennis.
> 

Sorry about that. I thought I did respond about qib.

Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
