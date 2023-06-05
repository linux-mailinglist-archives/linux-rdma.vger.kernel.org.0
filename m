Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923F722C77
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jun 2023 18:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjFEQ2K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jun 2023 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjFEQ2I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jun 2023 12:28:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2115.outbound.protection.outlook.com [40.107.92.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43154D2;
        Mon,  5 Jun 2023 09:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQlyb2JDaVhWKayilJBUjxcGQNNCLhDHuPZcf4+aLM2avhjdLA1urPz4ym/FUAfg7fZuy7kXgGw+2Pv8W/w6fvpr1FQwxTXPOE4rL7iLvSuObNW54sPc3leExZu1/LK5/USUbkIyjwW0DGH89nLlfSo8pae61wooLWiYkzNeQwH+G2lelbHbNUo5nsXoY7jojPGc8oU2WNjajYyYRzb60iOaaDGu3m+4hV8RDFERnOk9ZeHheEK7g3EPouQv2RfNGP+b36Gp68dmzg8GLkay9Nx3LrP/UvvIXqiqNCFiNL0zmS/gZjHDfByHwdsEbn5jp+hf9Nosmkjyi9818OL2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAdXemAsPTUhSMfk45/ukkcYT945JnCsHzpUF0ie1U4=;
 b=mTNeUw55jTD8sqrKMWbq1ZEifTZwvrlmPSQpzSnqEbqRfZKyniSC7uab8kzEtSBh3GpReGcwq6oHdt0lxzACz+C4QwER4ec9rlInf70B3SRzO9VEDPhN3I0Dep0TS2z1BYJEb1GtIChP5rsAhIneg//aOmMubycSQ5liezK9cVP97cKYmmeWJG433wZRGMHYJ6z5IJvdxLPyrqeQT7q1CUQohFkfFtpRr4JI5ECyJzbQ43OeeWnm7fpMAnByc5rJNRHlYHix8a9pwtpFlHatBzav83IAX2naG655oe5jlLeVmmDuCiHqGoua1DLg7S7TFwRpEE5OmABJw1lXRlaNuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAdXemAsPTUhSMfk45/ukkcYT945JnCsHzpUF0ie1U4=;
 b=DUoEc97XHZaCNPIHEKjbl7sbOpTLEhi6Yzg71SXDKO1VSb/ET9EEfZMtytv5rAPwyrdpsUSfEuULiYNSmiCzwX7l4uVX8mmoaGTl44Ilzg4CFweid4IDYGvP1LmK+43uY0PRfr3seq+yBMTGKgJJhvGyldeW7Xdbl7Ch2g6hVc6hZ1MvPn1mOLzDJs5Ro/I4A20fI6SnsWysOkPkxO/ymDSfQzoC7D/KKHKSBQ9WtZ7KkvFvRoo4HUVr+VeWpbO/AY5djCr00L2D/Z2YlhgMrCJyh8UaELVse1+yEbLO4HLbSdp5Mc5jfxxy/TaC/SEuFvUUI+DChhu6UCDvQgyAZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 LV3PR01MB8557.prod.exchangelabs.com (2603:10b6:408:19c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Mon, 5 Jun 2023 16:28:03 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::fab7:4581:2a24:8fc8]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::fab7:4581:2a24:8fc8%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 16:28:02 +0000
Message-ID: <ae831b51-0db2-7d10-3050-b9981db32448@cornelisnetworks.com>
Date:   Mon, 5 Jun 2023 11:27:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH v1 12/13] IB/hfi1: Use pci_disable/enable_link_state()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
 <20230602114751.19671-13-ilpo.jarvinen@linux.intel.com>
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20230602114751.19671-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:610:e4::15) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|LV3PR01MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a0fddd-deb0-400a-4c69-08db65e1d549
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZfJOpztCwKNZiOEio/57/8noulwDuZfmx0jCfFScPuCEW4DhFC2rWRdlDvftTXNkODlMPenwwqRteNZab+lJzRkEWHz4Vf6Iff1+6/4hC7iuNd/NNVWLBFSPfqyQxadHKXgrpfr7kDtf7Gzp1ZkxV8Ah9mNxi/gDBBQZBIqopIhN6+A3jfmOuP1zNFiBZncg/lEGQQP4Sg1poCkh7kuoLY1jZu3/qpsj1rIfS6dYm7mR6hIC/ZCkkqeKsbXrTRf9u+hjvWc8KrKk7K96U5zQA6qWdgxdvPgz1J/uBpSYVnhjAY/szrpu53RGHl7IqAyueBLHma3/bRBDvJrbGjaBufKjd5HIMsDHZ/uOc9s3vbshJJQAZ9TJ+cjucpBZwLejhu4yX7gOy0h+B7RIau8T82EQwuaxRilluRbpOIgbpCh1V04oNRwRk1QOL/O/GkaeKaNVFb5GQtoU6aLAmd16B+NlVg3o4E1lRgbyIuOKwo/Y/lylLzwmO16jpLP6IuE0MchcmYiHrNeGQnb3HL8r8lOWZgnJM9/yv6YsEQj2lB9F3o3g03Af2MuLvtvVZsnBvzgyVACeuslBL4RoIkm5vZ4GSMCMH9HJD+i0GfbLJ/IuKfnApotXx19RR7odLfeI8rhUmpMqYtSwZPteF2S6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39840400004)(136003)(396003)(451199021)(110136005)(478600001)(8676002)(5660300002)(44832011)(8936002)(7416002)(36756003)(2906002)(86362001)(31696002)(66556008)(66476007)(66946007)(316002)(921005)(38100700002)(41300700001)(2616005)(26005)(66574015)(186003)(53546011)(6486002)(31686004)(6666004)(6506007)(83380400001)(6512007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpxM2ZDTnl2VkltZGU1QkVWVUhPT1QxWnVCU2hpSXRrdWtPWkRtZjFHRGlV?=
 =?utf-8?B?a25kK3FlOS9iNFVLVG1FM21iV0cxU0VaajJhNU1iWVNQbVBBUVhObFRVMGJy?=
 =?utf-8?B?ZnJ4NUpmMkwyNUtJbkVnN1BuZEdSRkJIdHRYY3dFMEV2RkloUnlZRWpHLzBt?=
 =?utf-8?B?eXpxc244cnBGbEFtakg4QXl5ZTJ3UnluT0QvZS9ZRkZ2d1BQZndpTkV2ZWJz?=
 =?utf-8?B?U25Ld1JPOHFxdVBIdVNDR1NsUmdYQU5qaGFqdm96N2ZNZjhBYkxlU3VjRTNp?=
 =?utf-8?B?eUxHMCtqU1pFTDNWMDFZM1g0akwzWEFoOXhjUENhbGlNVjZSeHF6MklWdFdo?=
 =?utf-8?B?VG1mTHF4ZUpmdTlhUmtCU2hvRWpYMmVOTXNSN3pzZXNrVzVzaGMvb3dESUov?=
 =?utf-8?B?aDM5dFdrKzQ0TXcxUXZSNWtIdTJjemI0a0VCTDRtYUxNb0tlN1I4bUY3dysy?=
 =?utf-8?B?Y0NBUVp6eWYzU0NiMDExOVhvVmlRUVdXbVJGSFFidHFQTFRSMWM3Zmcyc3Bp?=
 =?utf-8?B?bmdsRlhodTM1TzBjUlc1Rm9Xd2lOYVFRdnp2b2NxbWhIZHlVbjE4OHBveTVy?=
 =?utf-8?B?UUpyTi80di9yUStmNXg2dWVmQjkxSGI5RVI2bkU4TXQvSFlKcWNNOHQ1ais4?=
 =?utf-8?B?OTIxM1JuekJGeWZaNzVYTFVtcE1KbCtoUHJUb1p5UGdwVU9uaXdabFhQZU56?=
 =?utf-8?B?Q1FLUVQyTTNjekw5U2dsRVdwTWhObXFQN1hVU2UvdVZnc09UNTIzU0hwb2JK?=
 =?utf-8?B?N1hhcVhSOVFLTjI4cFJhL1FWaCtCNVJ6aVNwWTJuYjZyTnl5cXE4MHBDNEty?=
 =?utf-8?B?Y3VkUW96RUFaZVpUeFEyWHI3Y2toUXZHTm52M29Kc3liMGZ5ZjRHMUlHSnJB?=
 =?utf-8?B?eEtmamtpRjFUNno2T1REaXZUN3Z4eVN1UlNWT0szTGxyQ0tLT0NFSEhnMUFj?=
 =?utf-8?B?cjJvOFpnNUlpSWdwUGZDdXdYNE42aUpqalljOU9mbStXTFllbDcxc1BPVDVQ?=
 =?utf-8?B?UklNdTg0Njk3SUNVSEQ5Zit6Tlljam1QejM0Q25kQjdRa214YndJQmo4UE1G?=
 =?utf-8?B?S2NqdGNwS0dMSmtGNnVwenAyM3AxNXF4SWNPa0lRZysvbzRrTEJOLzYxK2xZ?=
 =?utf-8?B?NnllNkhhczdJRmhZSTNZOEo5Rkc5SGdoQjJ0djRiTGdLRXNGbndxT3dkYS8w?=
 =?utf-8?B?NW9LM1BCZDJHNmtwUk9GN09sb29hOU9mY3M2UEtqejFQT1FEWmVBcDRYclp3?=
 =?utf-8?B?QWNGNDN6WG5kK01DQ3Y5M1h0bmFJc3E3MnhoTlk5VisyUjJ5ckJ3MGxadHZw?=
 =?utf-8?B?T1JqcndwMWFUT21NRkdqeG0zM0FhalpCdWVic09YVXBQS0hIQjRuV0cyelBD?=
 =?utf-8?B?Uk9OaFRLNmJCeG10KzBaS25XNW45S1lBMi9kMC9SZUFPS3U2UVk3ZUhyRUR3?=
 =?utf-8?B?dzFqMFlmOWhrRnVGNjdUYUFJa2hFUmMxUWh6STRtT2RtbzRVZlpaeXlyaHpk?=
 =?utf-8?B?YVBmeUxsMlV4eWphTXNDSUpRZnNTWnorVU5qS25CUFpKM1Z6ZmxzT0hKUmJY?=
 =?utf-8?B?ekxtRENOYWNpSS9KWmFEY2RnMW9WWlRBVnJ1UkVxbjJyaXcrSjY1UFoyWjRo?=
 =?utf-8?B?a3IwSFZNdVVrZk1ENUk4aHVSL1AwbDdkZ0h0dVNEd28wZ29sRDlrV2k1eVp0?=
 =?utf-8?B?QWczODJXVVo2L0ozTlZidCtKS09IcGRNZU95QjRFZzE5Vkg0SXFBalcyUVZv?=
 =?utf-8?B?elJ6Y3hWWUNsNlRWVkg1cG14ZzNwR3E4ZnFoS1FCZlVkQy8xcTUyLyt4WXFj?=
 =?utf-8?B?K01qRmFId3hKMld1N2dKSEozQ1VjUVk2QmVaR0xJSSsvMEl2NnJBd2Zyc3N5?=
 =?utf-8?B?Vy82L2lPcUlzTVcweHFLd0Iyb3NROW1TTmo4bUk4ZFNkeFFvWkZTd2ZPeGJ4?=
 =?utf-8?B?QXRmd2FyR01mazlwK01EOE9GYzAxZGVWY1VvRFI4WjhRclQ1ZVNqdGxZd1Ns?=
 =?utf-8?B?VE5FZ3drZWlIUks3enUvbWVqazQzVzE0VlZPdGFsOW4yRmEyY05vNGxBM3VG?=
 =?utf-8?B?QjM0WjNnYjZtcGNyVitkU2NIZjFVNnc4aEhwRWxKSVBJa3ZOVFFpSXRDazYv?=
 =?utf-8?B?ZERTamRxalNVSXVhNkJTaFQvY3hrNUZkbzJFVE5idDR3bjdBam9WTjJSVnZY?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a0fddd-deb0-400a-4c69-08db65e1d549
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 16:28:02.6068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdhT015uIfg3jTGip0bZnB3sWJBVlM7o0VU2ab/y64WBMGL5nqi3HUxBm2gGoJF1YR0jgZ49DO91UnuZAdf5L6/oZNDqObmEb5cWMxN/0nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8557
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/2/2023 6:47 AM, Ilpo J=C3=A4rvinen wrote:
> IB/hfi1 driver adjusts ASPM state itself which leaves ASPM service
> driver in PCI core unaware of the link state changes the driver
> implemented.
>
> Call pci_disable_link_state() and pci_enable_link_state() instead of
> adjusting ASPMC field in LNKCTL directly in the driver and let PCI core
> handle the ASPM state management. Remove the functions that handled the
> ASPM changes that are now unnecessary.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/aspm.c | 38 +++----------------------------
>  drivers/infiniband/hw/hfi1/pcie.c |  2 +-
>  2 files changed, 4 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/aspm.c b/drivers/infiniband/hw/hf=
i1/aspm.c
> index a3c53be4072c..8e3fc1d4c9c6 100644
> --- a/drivers/infiniband/hw/hfi1/aspm.c
> +++ b/drivers/infiniband/hw/hfi1/aspm.c
> @@ -54,45 +54,13 @@ static void aspm_hw_set_l1_ent_latency(struct hfi1_de=
vdata *dd)
>       pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, reg32);
>  }
>
> -static void aspm_hw_enable_l1(struct hfi1_devdata *dd)
> -{
> -     struct pci_dev *parent =3D dd->pcidev->bus->self;
> -
> -     /*
> -      * If the driver does not have access to the upstream component,
> -      * it cannot support ASPM L1 at all.
> -      */
> -     if (!parent)
> -             return;
> -
> -     /* Enable ASPM L1 first in upstream component and then downstream *=
/
> -     pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> -                                        PCI_EXP_LNKCTL_ASPMC,
> -                                        PCI_EXP_LNKCTL_ASPM_L1);
> -     pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
> -                                        PCI_EXP_LNKCTL_ASPMC,
> -                                        PCI_EXP_LNKCTL_ASPM_L1);
> -}
> -
> -void aspm_hw_disable_l1(struct hfi1_devdata *dd)
> -{
> -     struct pci_dev *parent =3D dd->pcidev->bus->self;
> -
> -     /* Disable ASPM L1 first in downstream component and then upstream =
*/
> -     pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
> -                                        PCI_EXP_LNKCTL_ASPMC, 0x0);
> -     if (parent)
> -             pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> -                                                PCI_EXP_LNKCTL_ASPMC, 0x=
0);
> -}
> -
>  static  void aspm_enable(struct hfi1_devdata *dd)
>  {
>       if (dd->aspm_enabled || aspm_mode =3D=3D ASPM_MODE_DISABLED ||
>           !dd->aspm_supported)
>               return;
>
> -     aspm_hw_enable_l1(dd);
> +     pci_enable_link_state(dd->pcidev, PCI_EXP_LNKCTL_ASPM_L1);
>       dd->aspm_enabled =3D true;
>  }
>
> @@ -101,7 +69,7 @@ static  void aspm_disable(struct hfi1_devdata *dd)
>       if (!dd->aspm_enabled || aspm_mode =3D=3D ASPM_MODE_ENABLED)
>               return;
>
> -     aspm_hw_disable_l1(dd);
> +     pci_disable_link_state(dd->pcidev, PCIE_LINK_STATE_L0S | PCIE_LINK_=
STATE_L1);
>       dd->aspm_enabled =3D false;
>  }
>
> @@ -254,7 +222,7 @@ void aspm_init(struct hfi1_devdata *dd)
>       /* Start with ASPM disabled */
>       aspm_hw_set_l1_ent_latency(dd);
>       dd->aspm_enabled =3D false;
> -     aspm_hw_disable_l1(dd);
> +     pci_disable_link_state(dd->pcidev, PCIE_LINK_STATE_L0S | PCIE_LINK_=
STATE_L1);
>
>       /* Now turn on ASPM if configured */
>       aspm_enable_all(dd);
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hf=
i1/pcie.c
> index 08732e1ac966..767f6cb770b6 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -1182,7 +1182,7 @@ int do_pcie_gen3_transition(struct hfi1_devdata *dd=
)
>        * will be enabled if required later
>        */
>       dd_dev_info(dd, "%s: clearing ASPM\n", __func__);
> -     aspm_hw_disable_l1(dd);
> +     pci_disable_link_state(dd->pcidev, PCIE_LINK_STATE_L0S | PCIE_LINK_=
STATE_L1);
>
>       /*
>        * step 5f: clear DirectSpeedChange

Looks good.

Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>

-Dean
External recipient
