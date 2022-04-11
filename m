Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A384FBF04
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Apr 2022 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347256AbiDKO1I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Apr 2022 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347249AbiDKO1C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Apr 2022 10:27:02 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2090.outbound.protection.outlook.com [40.107.243.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFC137A34;
        Mon, 11 Apr 2022 07:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEUyZgifXytqpPr8BjyX9B+1BGQmEMRpuehaqung61LptUJjza2twowEBYhuPyJQazy7MO3gP7ROFSUCQo2M012dHwJJUNLlJ6AQOW9mvL+sUH+Tl92/XOlK3o4NyBWlg9KLuSXuoyRfgrhuDchzJH3eRh3f152O3eE/ZEL2MocnbL0cdJbjFqJArrTaFJXT0WPWUG8xWWrJRxQnlorHJyNv1VI4WSLqbwmX3BRW4W9eJ3oziCCWwd6V4+qFEoKfPlJH7tY7qJSVuGITOZsjjg19UivmuxTDV4KGxFLN94O4FYBKzVU4kEluDlnFxrsh+WTy9Z9eKynjDPY7QeTVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGY/OgviN541B9JiqXcu8SEHu3xDesauNT2z+H1CwCw=;
 b=AoK3iK78b6rvyB47N0STT8XlkrYL/42zrRvgIEce3Q3EVZDB1uHKTgOTmO1PmR/JjJesrZk/Re+YU8A9U7X78x/dQJDGOwyQdQIK4F2sNd27RPeTfWMB7Ehi/PSD8Mo2Zqc4e+KstEt7bVN5goEgrCKcs+pL7lEaebyP6sWzQAVeIplSUDldv6Lg2r7l/86BGc0JMHmTDgePaTAhpZyWA1ZC+Izc1RGPxeV8EMA7rm8RnY7BqdR6N0unmT+9mmKvELuGy3E8ppMc0n0K3Fn5F2gH8xoLje16ttsAy7vL3FSFpWG0BplktMKJf9kqVnZO895Fro6gNJQdGBZiijISRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGY/OgviN541B9JiqXcu8SEHu3xDesauNT2z+H1CwCw=;
 b=ObP1cnyL1Utg354GuD7Ylt2sKDZY8oW5gRVNCEBnkcKwHKg2+JuCmc628FZPCXVIEjW9LnrLwNw+witt4AFocQ5azl/1CDeMvid6FyUq6eM3+Y1sxMZ9/q0BoL6WUX6a/Wqb4BLZ5Lf++OXZwPP5Ji5N3rpWOqbzsGjmioK+Vl3asT6xBLwOOd41Gjm4Uh47PulVnkfQce2eaOD6lujkuej2iTg1ECnM1I1jHdKOiTlZS3Tcs98qv4IaAzQmbm/mCU0g+5meBMNg8V/6pLqXgMAR/0pxuFw/jDZ2sHO/xyYgdWJQu/WbYP1f+OYn2ipOYz0PpRO4SS5XbBpXag8xGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH0PR01MB6439.prod.exchangelabs.com (2603:10b6:510:d::22) by
 BYAPR01MB5288.prod.exchangelabs.com (2603:10b6:a03:91::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.27; Mon, 11 Apr 2022 14:24:44 +0000
Received: from PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875])
 by PH0PR01MB6439.prod.exchangelabs.com ([fe80::98bd:3eac:d0e:875%6]) with
 mapi id 15.20.5144.029; Mon, 11 Apr 2022 14:24:44 +0000
Message-ID: <dcac5131-f46f-5e92-efe5-3862da9a2678@cornelisnetworks.com>
Date:   Mon, 11 Apr 2022 10:24:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [BUG] IB/hfi1: Warning when the driver fails to probe
Content-Language: en-US
To:     Zheyu Ma <zheyuma97@gmail.com>, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMhUBjnc1rCoE5G8MPHO-nzMdQs=O3=YLH1QnuF7mbKbds2QMQ@mail.gmail.com>
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <CAMhUBjnc1rCoE5G8MPHO-nzMdQs=O3=YLH1QnuF7mbKbds2QMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0043.prod.exchangelabs.com
 (2603:10b6:208:25::20) To PH0PR01MB6439.prod.exchangelabs.com
 (2603:10b6:510:d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873ffb81-69c5-4029-53db-08da1bc705fe
X-MS-TrafficTypeDiagnostic: BYAPR01MB5288:EE_
X-Microsoft-Antispam-PRVS: <BYAPR01MB528846088948EC04AE5B8BC7F4EA9@BYAPR01MB5288.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vchpg5JqxGffSZ6NIbazA8MjetSC0MGHXjwYKb43v4ENPWAhznc/8iKOW7S1pgC7MqlNSdP5jxS3eIRpu2mstuTBcZlfHfsaXUQtlGDPTj1nwvi5dIcRpZlZ3UBOG62creAe6IVHkQyHmakGaujQ8PZt4ALSwUY8nBWXQIx3G6v2zN1vU3rNfjQKGpvTYNt1JX462599PS5jecc1F7Prdb+ri2WT/l/+DW/F/3hk3cwXFSJ/EU/42BLgul+DxCjdnfP4bxSdtdT0yx9Am/IpdJ/u4VM7SzV2JZ1GkWCPDiQen8Pqd0fpazfzZPpLJ8YJ9r9tXek0MRI/NgAnbv5jQrnLEOo0xvBGoZ1L1/KnFFkoZGvPy1KrXgOxfjE66Lq5lYq8qcFUUJWGe9rpGRnJ3tx8BKm0ILFhKaYPoCO1LcwRbKOYLN45g1Ie2+5iGqDGKjpvPrUeMEo0DN1bb6ZQhLgXJvfMfGteg1oxaop8pNxnyUnyKUAk/cYGGAiBJ4cUWfZymVIG8XlOLt3sgeTIRk7RUga1bHd9A9KKdNuXjMMpazRA0lz6ybJrSkrHlb/I3RYhRbWBY7me8h2B9YoFBmrrj87gnLLPFfDiDIk5btArJLIOt//hHfXA2UFAysIKIIrVDGlHovrWhOygKcYpfTUg+rnIlLcnJL9+MYdKcoXTF6h1ODacPNjl+MhrEHv9rQwzaml8uncTuq7b84JJnjPVNOAEUIUpJIyWlHGxhYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6439.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39830400003)(376002)(396003)(366004)(136003)(346002)(31696002)(38350700002)(8676002)(66946007)(38100700002)(31686004)(4326008)(6486002)(508600001)(8936002)(5660300002)(36756003)(66476007)(2616005)(86362001)(66556008)(186003)(26005)(6666004)(44832011)(316002)(6512007)(52116002)(83380400001)(53546011)(6506007)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNud1JDRGI4aWkvZk10MVhpMkltejlzMGNzU29rWUFnNkV0UVZXWFIrZnJv?=
 =?utf-8?B?YlJSUkdDMllRT0RUUUZ6NHZ0T1VaY0ZzN2R3aHRzVGVtV0w1Q0xtL0RDZW5R?=
 =?utf-8?B?WlkvTHg3YWtKdUdsK1NiYVhIeldrOE1iYzZPWlJsQmVQSlRuZTR4RlRVcHVP?=
 =?utf-8?B?OXFMWEQvZldDVTFjNm5BcXV2N2gwUjkvbXZBYndmN1hWNHFvY0VHWGNEbGNL?=
 =?utf-8?B?bnUvUWY5aDNvbFBxTWJ2UE1rM251ZGVLM0FzcnBVNHNSQzlqMm9aTTZVRk9E?=
 =?utf-8?B?NDg4dHdFdURoSS9YZ2wxdTZLUXMxcE1vZTNEU1R0dGhtUFh4UUI2WTdGQzZz?=
 =?utf-8?B?N1h6M0Y1MVN6SzVzbGZwZ2gzeWZZTHdpK0dFZzVrd3JFWTZ4RHFZOW02bDRs?=
 =?utf-8?B?UGdKNVZZWVZucXpnS0l0eFlJVkZvNURnSXpxei9wWENMcnA0Qlk1MFJPNld3?=
 =?utf-8?B?Tm82dUNlOHAvcHk0YVBxMExLZlUwUjNYMVdMc2ZaRHVjZkswM09jOWRld0ow?=
 =?utf-8?B?aHJKeXE2aENORE0wQzZ2b2xWN2k3R3VyNVZSNWt3N1p0andLYVlaR08xa2Iv?=
 =?utf-8?B?MnhjZ2VVcEpuMFo1ZEYxeUtqcnoreWorbjFCeWlzc29WK1VFY2ZzNENiNXFk?=
 =?utf-8?B?bXpFampDOUVFV0M4cXhWTGk5VkJsMkJnbktWY01MRm5Ba01hb1pJYjFEUjdU?=
 =?utf-8?B?bCtoWm02WGZiTk1XeURTK0tYUEtCQzgrTHgzVHhiVll0djhQdU9OMVJpRmth?=
 =?utf-8?B?aGxxaTBVRGhIK2hWVVc2ZTlSVnE3TUxUT3Fqa3RiMGdlNlRqVzZjVTY3Z0dT?=
 =?utf-8?B?cHllb2FMZk12Y0o0WEh1Zkh0R0l2MkJHWDRyZ0k5RXE1NHlDbktFQUxJN1ZW?=
 =?utf-8?B?ZE1KYkJuNitOM2ZDZDhYbDNOZ1JJR21zR2JZNDh1VHFBMzNOZTdZazBSOWVa?=
 =?utf-8?B?UVZKa1RHQi9rK25Wc3luVy9NRUVNM0QwVklZYWVGbFpCWkgrSG4xRk9kL3or?=
 =?utf-8?B?eWxxa3g1b0MvT0FxcmtxM2N5emZsQzRIS21XS25SMDUvR1dlK3JDY2kvUGpu?=
 =?utf-8?B?eTdYNitBR0drQmZyTC9YL0VYNXI0c0lGSko2WnR3NVF1Y0s2SUJVU0R1ZXVH?=
 =?utf-8?B?VnlCSkI1bWpwa3owSTZydjQxZm4vaCs1UWxJcDRwdENEY3gxcFlVTmpacEJQ?=
 =?utf-8?B?UkM2MkVRQ2RtRkZEejZXMlhYN3VnVzI1cndmTkIxL0o5VFY1NXlyRWZ2WFg1?=
 =?utf-8?B?dm4wUVFUa0M1MUVhSExoczREM09QOFB0cVAxdFNnZldweEpNU25PT08vTU9H?=
 =?utf-8?B?WXVPdlJ6R0wvVmRwcjdKY2Frb2ZkT3hOVkpYcW9pZ1o2WURFOXRhSURmMSsv?=
 =?utf-8?B?MzB3UlpqTHZoRytLY0NvVllvNTBzaFh4ayszNUxoNDdUbDVaR3ZkSHB6cDA2?=
 =?utf-8?B?d1A3M294dDBGRTQ5ZFdHeTdCM0xLQ2IxRWpJME5ZTGZTcGJkb1VYaGJQYjFu?=
 =?utf-8?B?WVhyNUdjS01LcGdPcXh0UFFJczlzeXVtMXF4SGtxZ3kxWXZwdVIvdjVaM1h0?=
 =?utf-8?B?aVZIdHNsdnF6R3c2a0NTYmcyZkFFRVFpNytycjB2bnEzbGI2RmwxSjkzU3BO?=
 =?utf-8?B?LzZ2UHVvRjVLcUFtN2V0TzIxMjF3dkp4TUVuZit1amJDSkdBMUxqSFc3M2JU?=
 =?utf-8?B?eStvVXRneHkvMnhGNkJZSjRCUVhwUDFPVFRWYS9ZNU1tZURqdnRoYVpscThV?=
 =?utf-8?B?V04zUzZXU0NlUVhKeDZiTmhTY3lrRFowaGV3OWFGL1ZSanh2ZWJ4M0lKVkVE?=
 =?utf-8?B?QzJ4Skt1WlJMSVQzcGN4K2thUHI1MllOcXJUa1UydTZHWTU3M0VqUmpOQ0RH?=
 =?utf-8?B?anF2Tm1ZNytVOHhNckRSU3BKaFh4T2tNUmdDbFU3QkdtbXBlMnc2TmJ4dDQx?=
 =?utf-8?B?LzR6a0xmNzFwcmRnZHRJKzRoTWZuejQzdmQ4OVdhTitOc0xDbkNvWDU1eFNk?=
 =?utf-8?B?cGE4dXhzdnlGeENHbzU0WXNXeUwxYmJocjZneGtEUHloQTlkMjdka1F5Wmwz?=
 =?utf-8?B?amR1WmNyYUxKaDZyLzE3MnRGL0ExbmR1d0E3eXB0MUZlSVZUYXhKUGM0a1lm?=
 =?utf-8?B?RkFHWWxvejVmN1hCY1JqMnIyQ1hFblgrV0RLeVV0NXVNM01rZjYvZVR3ZWc2?=
 =?utf-8?B?SHp1KzhyRVNBQW9KcW9NVE96dXJxeEJPN3MweHN3MUk4ajVZV2h6UVNhNDJZ?=
 =?utf-8?B?MVlxcUFwY2RtSTRXN0FqelVjbWZZVy9nQkdUZGV4cnFYVDJ0Umx5MEpLL3Rr?=
 =?utf-8?B?b3pwYWpsaUpCcDFFdGxZU0RuWlphZFk3MlBmdmVtaHBpNW8rcXdzSE53UStJ?=
 =?utf-8?Q?xUinhda+ST5FAdAjw5ZX+oDhnIxCrQ4m5Wndb?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ffb81-69c5-4029-53db-08da1bc705fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6439.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 14:24:44.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUerBNfhvxZ4tm4GuXbmFI0HxL75uvJlKe31ik3hj1BKC8ACoOR3+O7I6j+QZhboXZN+3ExqRlTl1Ozbwagzc9mHpW89bElaIdFpeWZRs4nv+3MOjYZHM6kRufaT7AvU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5288
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/10/22 3:08 AM, Zheyu Ma wrote:
> Hello,
> 
> I found a bug at the init_one() function in the hfi driver.
> When the function xa_alloc_irq() fails, the driver executes the error
> handling function sdma_clean(), and this function uses the lock '
> dd->sde_map_lock'. But this lock is initialized after executing the
> function xa_alloc_irq(), which causes the following warning:
> 
> [   23.257762] hfi1 0000:00:05.0: Could not allocate unit ID: error 1
> [   23.269915] INFO: trying to register non-static key.
> [   23.270318] The code is fine but needs lockdep annotation, or maybe
> [   23.270808] you didn't initialize this object before use?
> [   23.271229] turning off the locking correctness validator.
> [   23.273198] Call Trace:
> [   23.274185]  register_lock_class+0x11b/0x880
> [   23.274525]  __lock_acquire+0xf3/0x7930
> [   23.275769]  lock_acquire+0xff/0x2d0
> [   23.276053]  ? sdma_clean+0x42a/0x660 [hfi1]
> [   23.276485]  ? lock_release+0x472/0x710
> [   23.276789]  _raw_spin_lock_irq+0x46/0x60
> [   23.277105]  ? sdma_clean+0x42a/0x660 [hfi1]
> [   23.277530]  sdma_clean+0x42a/0x660 [hfi1]
> [   23.277945]  ? trace_kfree+0x28/0xc0
> [   23.278232]  hfi1_free_devdata+0x3a7/0x420 [hfi1]
> [   23.278688]  init_one+0x867/0x11a0 [hfi1]
> [   23.279090]  ? _raw_spin_unlock_irqrestore+0x3d/0x60
> [   23.279482]  ? rcu_lock_release+0x20/0x20 [hfi1]
> [   23.279930]  pci_device_probe+0x40e/0x8d0

Thanks for the report. Will fix.

-Denny
