Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1486FF5B6
	for <lists+linux-rdma@lfdr.de>; Thu, 11 May 2023 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238460AbjEKPTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 May 2023 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238591AbjEKPTu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 May 2023 11:19:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C762125;
        Thu, 11 May 2023 08:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJewclR6v0QNkHYATcxKCLeuxuoJnQcoBfRIdtrREax0mGbOLN77Ijd8L/yg8E/3jydWQ9VMXgkAcfhhA1RXvEeckEZYJ7yRjS9hEEqTUP7sL/uv2e57+nq8u+s3sgei4DCOD8tFDCqFXYdc8uNjOmO9NvPKGy88GJ4btfNZvtMptmf8M0U6IDU/wrXMvkVA3A0EW5tA0Otg3aUqumv7A1L0JNk2wwonjl3GlsOE6QfF5qWaKaTyEEhl791OE7ILDYF4+yiQ3TdyzCc9XpCrbWV13/rNejo5jme2rp70ImPchdnd2+BalJKUHO2HbU11cfnDjBFanBiMMEztRjzB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hz+qFqU61AbwPuOg5clTU+pwOi1BY4MjmcHbsPWekw=;
 b=CmltCsgC3SGZDa0gi1tj3fvvDlmTlgTUeiXLvoTCJ4eIZzkfqsQoa/GGi2ZtbXnGqjPDZgyPMoUXzqMV6DBMbkIx8QACzVQqUEUeK5fLqjsOqFS69mOuj6Fik1TD6PCtxfBbZVhcL5V2+Yjc9WuqfzymZtg/rPGsniInpK8xGllH+P5yW0ZVj/UJoQ4XDvMND3EsVXOlDdCPnbTNDU6X72y3tWLqAs/GxslX3T2HYxgtC+lCEzE45G2/OZgVP2Lp9P3cvJA73tOLXTqMgmoil+OKaZV3i9Lz7uUwJZ0Hs3GO3guw3w5X6Ta00XwBPKl5+jGfIuy2w2dQmYErVBLiAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hz+qFqU61AbwPuOg5clTU+pwOi1BY4MjmcHbsPWekw=;
 b=E3s/6mk/CZ+L8vTj2DdDqIg7KUOAoua14jtKsbB6MrBZNS3gTTTkoWFT2XVofhV6bQ8m4uZ08BEetrkU1siDPj8Tqjt5gJj0ixE54X3cN0hs8KE2/DHVF8FnP/8bLPTEWDBQNeLxjdBW0E+rhkPbql75sdBf5QgchQfB7+neZem4P1VWPGF7kyYZh79ZIGwYmzdxoooiGOcn+R41QHErAPGav6olgLsMcxjARTuhvQUw53bEhcccYALJ55JwDVSTRm/EsFbZfI+nHvd79y5P/HuSZW1ls3GRArLJfzoPDRkUrpstIZ93GZV/xr8wNC0+OEdkMcsQo+xEOG/zRrL6cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 MWHPR01MB2462.prod.exchangelabs.com (2603:10b6:300:3f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22; Thu, 11 May 2023 15:19:38 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::fab7:4581:2a24:8fc8]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::fab7:4581:2a24:8fc8%7]) with mapi id 15.20.6387.018; Thu, 11 May 2023
 15:19:37 +0000
Message-ID: <b2202998-b67b-ee45-b6de-1da5d30cefd0@cornelisnetworks.com>
Date:   Thu, 11 May 2023 10:19:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/17] IB/hfi1: Use pcie_lnkctl{,2}_clear_and_set() for
 changing LNKCTL{,2}
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511131441.45704-1-ilpo.jarvinen@linux.intel.com>
 <20230511131441.45704-7-ilpo.jarvinen@linux.intel.com>
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20230511131441.45704-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:610:4c::39) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|MWHPR01MB2462:EE_
X-MS-Office365-Filtering-Correlation-Id: eebd88aa-c123-40d7-e485-08db52332253
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMnwt6vuZAimINXb4YRQEL42/hFW6+1rMcPZ3Mf3egHzyIOpE74JD6Qe07UvdYPzBUsLBa/3IGC/Ubj9RssqziF2/pXnnobEpJ32AolCPnfGI80eCIUyXlOEa0zMtV+TLgeeT5p7F8yVtdXBnRF0dAe5Itf/g0y6nQSaMZkKoZI6i2TsIkggLXbYPUyWHgeUm95b4lQtiK+h7Ma1wmSiSNrFIsYZAHRSazqPanrCJe2uw1DuD0eLI/f0NSW7X77HFKQefbLXpFtx6Un/tyGNW75yy6LNooP6s/eX0Yh3ORAU7pM4WGPhb7XHVSiEe26E3MugW0mBtOj4ClzYmFLN/w43gY2DGyznXcNnQikkGzK2bBY4Sc+5jp8MVxgS1oUQRCRNyz2JYVnHj8XOyvByM3HbF8OUfR5A3ObSmxMvh2+L15/UP2l/pHW1MgGfAySD3EuV2mV1n0T+Yl2He7NNCI10jMmNC+VXM9GuyAS67IrcvBgH+NT7G86JrOO6mHNWZGhMZDyzKwov8X+FKaoDuKn9eVzA5RpIyHlyhebqnWWNAKhBBZL0MIXiWcIMws5vc8cuQoSZ9NhW/2GRjMwKgdu9BYPLPdNKlsykY7pJ+vAUEKZDIvaw2SrQNy02S+dor5CiX6oqbmoGpJC30TAfHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39840400004)(136003)(346002)(366004)(376002)(451199021)(5660300002)(44832011)(7416002)(8936002)(8676002)(83380400001)(2616005)(2906002)(36756003)(186003)(921005)(38100700002)(86362001)(31696002)(26005)(6506007)(6512007)(6666004)(41300700001)(31686004)(66946007)(66556008)(66476007)(478600001)(316002)(53546011)(6486002)(110136005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjdZZXhtdlJlb3lGeENhNXFGaHF5R0lxTHVSbzNVVnFBU3EvdEREOGJjN0w1?=
 =?utf-8?B?RkVJb1ozWEgxalV4ZyttckVrWVF4dnR6V2ZhTTY2ZFNnenZMWE0xMlgwZXZT?=
 =?utf-8?B?Z0hmeFRkeGNkamZLbVZXOEkwcWdONDRPelhaVTNtK0h6a296dkJjbXo1dnFz?=
 =?utf-8?B?WG44QkpVejhpWmFtRlZadkJhTmlvMzMydFczM1ZVYmdlTEdLdXJ0NFlDdlVL?=
 =?utf-8?B?aURBNWp1bFRGcHBTYmhyZzFJMmJCK0VWak1CQ1pieFM0TWRVYzZSMHpzUzA3?=
 =?utf-8?B?cEowYXFGMVVxRG1EZ3hTcHdEWmxuYnhQS3ZxM0hWYTkrWDV4ZndXVXBiL3du?=
 =?utf-8?B?a2RNQ2xXcUI1RUFQM1pJam5LWHpRd2hOWjlYUWltMFc1QjhoTE1LMklZbGNZ?=
 =?utf-8?B?bTZWbi9rZHBPYktwMmhGazMzRzBQQm9tTnF5MUM0QkpLaWVKOGp0cm5nb2x1?=
 =?utf-8?B?RXJ5UlRwd2N6NkMyRXlDSGUxL3pVT1RvRjRpa3piVXRZZlhtdEY5WkhYMHBt?=
 =?utf-8?B?NTFaYTlOYnplQnNrQ3RxeEo4T25ncHVLUHlYaU8zd0IyTmNqTWh5dXg3Sm83?=
 =?utf-8?B?Ris0RWVtdzBJRlphNFdwWXJvTjRXNkxUOHhTTFVXZlBVUWU5ZWdVbGtRY0lJ?=
 =?utf-8?B?T1ZFYVo1NStPRXFudW00bE5kMFZFdWhOSHZSdkNNQXJqb0hyZFVLUDNKdlNV?=
 =?utf-8?B?R1owMFJ2OGY0UU50WUZxUTBwWi9XNlVVVTVySWtlTGM1K0kxZFFTVVpaVk50?=
 =?utf-8?B?SENPNU50VHI2NDVQL3lDd1haWUZuRVljeWhGRU9GWExxelhWa0dBNWVCcUVZ?=
 =?utf-8?B?TEtweUlvdnF0U1MyMmYycm80RXZCWUtPQy9VQ1lVck1tYTRwYlVHdW1qZmQ2?=
 =?utf-8?B?RVRaZ1dZNDFZemZCYTZBU1crZmVDVXZLRjFXVTI3UmxYWXZXV1RHa3FLQkh2?=
 =?utf-8?B?a1lScGxBSmhQaXhsUFdOLzVZZ0N4bkNLWW81cWVvQkdPTi9oaWZqeGJzMHl2?=
 =?utf-8?B?N2NubnZqZmQwdWthT3p4VDRCQ0p5ZlhmVjdaQzlCMG1SYkowR2ozaFQ3dTJN?=
 =?utf-8?B?WVFQSFV2bHhWdmhBUllnVG5LVDJhMFhOU0xVOXAyNU5ZdjRSd1ZnRlN5U0Zh?=
 =?utf-8?B?SzB5K0JGL3BwWm84clpkQU1sQUJ5dGFZU1BKU01PZnVRS0F0SnVvVkwrVnhv?=
 =?utf-8?B?dDJFQXBUalVocXFTUVdYeThmandoY2MzTDhyR1NYT3E4RW1kVXBkSXQ3RDFv?=
 =?utf-8?B?VWVmZVVOVGJRQnhNN1dDY05keGNvTlptbzViQ2tCZ3RKSVpVL1BNb1lPNytm?=
 =?utf-8?B?ZlZoTVRxZEYzMGdnQnVmRUt1WlZhQUNlTmRyU2pXK29ld21CYzkvUmsvby9z?=
 =?utf-8?B?cnBUa1VtV0ZFZm9TdTJvZCtWVGFqSlBzdWhKQ29sZGtqUDJpZGZQQjN3by9W?=
 =?utf-8?B?NE85M3NwNlJIYmkyVDlKMk9IeThHdStJekJQQ2pkRnFhRVU5SlBaR0kyZTMy?=
 =?utf-8?B?RUNSMk5Sa2ljeEdEMUtzLy9JYTBGZHBnbUxPU1FCTWdPcy9KMnArRnRnMkFL?=
 =?utf-8?B?Z2JUV3RPVTNJNGJrYWpHcnJWWW13YWl4TXcvSFhMd0Jab3I2RGdUaGJTWG9S?=
 =?utf-8?B?dTlKeEV0TUtrSWpHeEZLSnJJNHNwdzR1b08ycG84amUraUY4MEFzYVlMY25W?=
 =?utf-8?B?am1Xc09HOWpla2lDWmd6UDVBM1NSWHB0aGNQOXhBUlliMVUrL1FZdzdwT05r?=
 =?utf-8?B?STBBS3kwTHBiMTZpSjBLOFRmM2FWM2Q1VUFidXdJNjZSOU42L2xmam1XclY3?=
 =?utf-8?B?VE9xR3RmUDZMTElISWYxanR5QW51c1hMNGFGelM1TlJmSjNIc1NoRjIrODEz?=
 =?utf-8?B?enNlVUZIa2FaQjZtRVVnL2lvcmxidVVpdHM2QTh1b0c4WDV6UExBMnhSb1ZC?=
 =?utf-8?B?MGZ5NmErTG10ZktncmF2V2ZNcXZveDRkOTRRYVliRUlNMTlFVnRkeTlvREhq?=
 =?utf-8?B?eTgrYVFOMW9PR01KTHNJNks5ZWU1U1d2T2pxRmZnTXdrUi93Nm8yOHp4WWFq?=
 =?utf-8?B?QmdRZUNzOGJCbUt0eERvQ01KZm5XQnN2MWxXdit1TFlPMkZCb2xud0JUcnMr?=
 =?utf-8?B?YnEzeHRTRUZ1YjQ3WkEyOEtxazRnNENybURtTHVuZ1dWS05ONy9mVDA3Z1lF?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eebd88aa-c123-40d7-e485-08db52332253
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 15:19:37.7768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwdM3hOEBUTWe+z0MwX8xBw4CR0DrPaK83aYbtlNIHzSeiISVb7jiy9IFUMrUg9iIh11wp9qYrsD/tyN0F4GkwK91sncQ5OK7DFhT/KWV+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2462
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/11/2023 8:14 AM, Ilpo J=C3=A4rvinen wrote:
> Don't assume that only the driver would be accessing LNKCTL/LNKCTL2.
> ASPM policy changes can trigger write to LNKCTL outside of driver's
> control. And in the case of upstream (parent), the driver does not even
> own the device it's changing the registers for.
>
> Use pcie_lnkctl_clear_and_set() and pcie_lnkctl2_clear_and_set() which
> do proper locking to avoid losing concurrent updates to the register
> value.
>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/aspm.c | 16 ++++++----------
>  drivers/infiniband/hw/hfi1/pcie.c | 28 ++++++----------------------
>  2 files changed, 12 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hf=
i1/aspm.c
> index a3c53be4072c..d3f3b7e9b833 100644
> --- a/drivers/infiniband/hw/hfi1/aspm.c
> +++ b/drivers/infiniband/hw/hfi1/aspm.c
> @@ -66,12 +66,10 @@ static void aspm_hw_enable_l1(struct hfi1_devdata *dd=
)
>               return;
>
>       /* Enable ASPM L1 first in upstream component and then downstream *=
/
> -     pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> -                                        PCI_EXP_LNKCTL_ASPMC,
> -                                        PCI_EXP_LNKCTL_ASPM_L1);
> -     pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
> -                                        PCI_EXP_LNKCTL_ASPMC,
> -                                        PCI_EXP_LNKCTL_ASPM_L1);
> +     pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_ASPMC,
> +                               PCI_EXP_LNKCTL_ASPM_L1);
> +     pcie_lnkctl_clear_and_set(dd->pcidev, PCI_EXP_LNKCTL_ASPMC,
> +                               PCI_EXP_LNKCTL_ASPM_L1);
>  }
>
>  void aspm_hw_disable_l1(struct hfi1_devdata *dd)
> @@ -79,11 +77,9 @@ void aspm_hw_disable_l1(struct hfi1_devdata *dd)
>       struct pci_dev *parent =3D dd->pcidev->bus->self;
>
>       /* Disable ASPM L1 first in downstream component and then upstream =
*/
> -     pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
> -                                        PCI_EXP_LNKCTL_ASPMC, 0x0);
> +     pcie_lnkctl_clear_and_set(dd->pcidev, PCI_EXP_LNKCTL_ASPMC, 0);
>       if (parent)
> -             pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> -                                                PCI_EXP_LNKCTL_ASPMC, 0x=
0);
> +             pcie_lnkctl_clear_and_set(parent, PCI_EXP_LNKCTL_ASPMC, 0);
>  }
>
>  static  void aspm_enable(struct hfi1_devdata *dd)
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hf=
i1/pcie.c
> index 08732e1ac966..fe7324d38d64 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -1212,14 +1212,10 @@ int do_pcie_gen3_transition(struct hfi1_devdata *=
dd)
>                   (u32)lnkctl2);
>       /* only write to parent if target is not as high as ours */
>       if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
> -             lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> -             lnkctl2 |=3D target_vector;
> -             dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__=
,
> -                         (u32)lnkctl2);
> -             ret =3D pcie_capability_write_word(parent,
> -                                              PCI_EXP_LNKCTL2, lnkctl2);
> +             pcie_lnkctl2_clear_and_set(parent, PCI_EXP_LNKCTL2_TLS,
> +                                        target_vector);

You are missing an assignment to "ret" above.

-Dean
External recipient
