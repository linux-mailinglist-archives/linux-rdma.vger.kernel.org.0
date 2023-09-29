Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28AB7B3307
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Sep 2023 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjI2NDQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Sep 2023 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjI2NDP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Sep 2023 09:03:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5F1C0;
        Fri, 29 Sep 2023 06:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYhqhp+4j6CgUqitFBZd3IdTQZOmikXskk5n2DqMOPiwUB2pm1fd1ggroShZNtcP13PRq//RM1+8Dgeon36bGZha7D026I/0gSWueOjgRLo9NMWanR0uWmS4fb5l3jHgY+cn2lkqNYLjc/qKuraHnHdKKhlGmAZsQItpymzp8o6O8szlFlu2egWL6tdcEcYQExunrzSN3+s2c9RHEztRoa/rsfZJTxmYwqmHwcAA8bezVT1q2RXj2jBmO+ezwuOM7k+gX+ZK+b4yjaDYB8Afqqxt6hWhqY7kus6u+j1rGuX76Yp72cMhDfni1PhpaXRr37UI2CysNFC15SI2VXderA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uVLJZuLt4gDfkyC7G/iwvFivmHrsOs+MT7wLesg13k=;
 b=N1C/fXl7XOXWC+wXofVtxUprvmnrrODoCsHZxUPvrBn9sNAgpX2/TrhjdhhPOeJvtJR7lQzzFYtWEkIJwWLnuEeGFJQ4UTku2MJQvuP89hR2ss6hIxL9zWjy+ZCvpyVEn7U09kHkbaMfezWvhz8XcfvIpOVPlx1B4rErCTTfJ+wF3/gt44GMHOLOj4CiR0RAHQ9Fr00AuBpDgO1EyOa9DX28mG1/yUus6BIAjHuYHrzH8Ew2m4dQSbCs4k0xdFVd5m3KfkvAvNRdV5WipZlfLadaxGFLH58/eZ98//+RWFoKgGu8dimkFHIAq6Uw99kMU47RdvUrW3mX0fwtRg8WFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uVLJZuLt4gDfkyC7G/iwvFivmHrsOs+MT7wLesg13k=;
 b=IytekyAREZ2DdkpCvh+Z6aKZnlSL7IvYcPAeDTW/vy01Yo4Z1Ajnf3AG/rud+2w+UZ8OtqYWImTmbP2lXBiWyaH7RK8WPWtWz0X0wMtsI8808XLtQvBNi2dMXcnEiPISYCKv/ca0dapjPw7FQ/IIL6aBwjSqPoVJPlbRxU4PAanjqj0lkmW25lnSvNB5aLsxVprx/a9OXlRafuGHKG17g0RBkyNBbagmltfpJWz/rUZdFCqPOTfndR/QcG5D+ANjNzwNvh95BQgiTB7wPmXaoHcgpZjUbh2rcHjF3+U9RYwSYQuObRqCCMVxycX9MA/2j0zZptOz8l44Mbt01Xb3rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 SA3PR01MB8476.prod.exchangelabs.com (2603:10b6:806:37f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.25; Fri, 29 Sep 2023 13:03:09 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::386c:b0e1:bf68:cf1%7]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 13:03:09 +0000
Message-ID: <99fab1eb-1092-4b7d-8b60-b03374883302@cornelisnetworks.com>
Date:   Fri, 29 Sep 2023 08:03:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] RDMA/hfi1: Use RMW accessors for changing
 LNKCTL2
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-5-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20230929115723.7864-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DM6PR03CA0100.namprd03.prod.outlook.com
 (2603:10b6:5:333::33) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|SA3PR01MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: adcd1129-b068-446e-c475-08dbc0ec6d60
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgKt7NVIcWmxi1zWmNj93o7Hs8Cyh2h1z9PAS/YxYRf81Y4fv8j+pKcIsWmRswPFsauPd6V7NCimNylDydrTy9G+cnLp7BDITIdVgavsqSs6uo+o5hXedOL5szIqi43d1/IvQOG4XOkKNLg5RplhZTVIVaIUf1bwtetlf+uPVxu9DQQ6ps5Urrb2KFY0f42lOfMB0JMVjejO70Gjrewb2Ahu7N3a0dpI4o2HuwMLZQcMswClpyVHsUu+o9bkRzDQAglQYlX4Qkn3OP7JzdRWNmGnQ+W6IYOTJTuO092/a84RX+1zaglTu7gb0yDkZWv3lU6PwBGFo4I5MKVVlnxyFZtp2KystO82Z8lKxper3ESGxeJ6qp8GISvD3S+f4ruKhmKkSURzwmwD1k3jJ08b4N40bnqBn1l8AH3IEcXVbUqDs/gGwPEkxKSQygZAD6XX1ls+GCNFcxCvo9VSMsQDqWU0pTdw7Mf/ZtycogMJ4J4QBw/0T1V7p4OF+Oa9ovMC5lSrEr008k94JO00EAAVVjGcmJ9Spu53H0fOnFdxPHB0tJ91Dq2FbsVF7secMWMRMWd0u7TIKGgCTlHOfauLA8LzFN4kqKxsauTQnBFPQUHzr1XOvjgs7MAjv+8f2WABod4q51ckHg3Lg5DvBT/CUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39840400004)(366004)(1800799009)(186009)(451199024)(64100799003)(478600001)(44832011)(38100700002)(5660300002)(6486002)(6506007)(53546011)(6666004)(66946007)(41300700001)(54906003)(66476007)(66556008)(110136005)(316002)(4326008)(8676002)(8936002)(36756003)(86362001)(31696002)(83380400001)(2906002)(31686004)(26005)(6512007)(921005)(7416002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1E3WmVPZHBYMnpSNGQvZjJMRTBjSW9FdnBwYStBbi9Oa3dnbUttV1VZcUZ1?=
 =?utf-8?B?TDhRQktxakkxSzZWWitFMmlldW9EcUx1N0FoZHVnaWVKbHNTQkczcHdSZXZG?=
 =?utf-8?B?dE9keXJrQ0d1QnE1ZFdLREI3cWxLVDVtRVIrN05DTVVvWi9aZlphM1pOTmll?=
 =?utf-8?B?cVpKYURqYUVtMEtqelBYcy8vNExOblNhU2V2eDBvTmp5MU1Ja2VFbC84YzAr?=
 =?utf-8?B?TUZBSGw1RDVUS0xZQm5ZSXF3ZzBlbTMzYzVRLzRrWE1PYnRyWGJxNTBBRzh3?=
 =?utf-8?B?VGZBQ21wYmNaeEdGOTl1NE5sSHNMcGhSc0NYemxDNG1DVGYvcHRkc1R6VUFN?=
 =?utf-8?B?Ukxmelh2K2U1SWp1UktNTXllbnNJOEJodVFVSnZhc3AzeTVBMVFjcUpBNnNC?=
 =?utf-8?B?N25tV0JUZDhScVN0L1VtREJ6Wmx5S21LbnNMOVlPUk5za0RxOG8rWXZzaURX?=
 =?utf-8?B?d2NhMkFxSEZHSWh6UGR4cy9EN2JxdVBUMzRqMGViMXNFT25vbUR1NmVva2o4?=
 =?utf-8?B?OVByZnF4SWZrUkdBMjQ4MEFPZFNkRkNITi9uZGcwSHF5RFQxMU4ybXY5Nmdw?=
 =?utf-8?B?bHJick5oUldyTGtHbHliUEJzWHVKNFVNTmNmMmZyYnUycTJtbTdvRGllZUhY?=
 =?utf-8?B?SldPaHFLeGZtV0dzaTBxNURHWGx4R2lVb09JSjdZRXgwZW5QRGZjb1ljMlUy?=
 =?utf-8?B?amF0ajNMT2lKbVJXS2FtOEdaQ1VnNUo5REF4MWxwQVZrTDRoa3RvU05IOW01?=
 =?utf-8?B?dURSckNZaVdDcC9tMDZmMmkvTWtBNWw4MHBEemQxeElIM1JrNVE1bUxBVDlZ?=
 =?utf-8?B?Vzk2ZmQ4TzdCRVFkU1BYTkM3Uk9RSDh2dmlEWDA0RHBEMGpvbXk3bHpxWnov?=
 =?utf-8?B?ZStZMzk1bHdmRGpFUjA4cmJNNVFoOTd3NGRvdnEyZSs4d2pydUgyUHBjZVd5?=
 =?utf-8?B?MjZmRWZkUVo4QWhkeXVibm4xaVp6ZHBVQnYwcVNCZDcwRWtGR3o4UFVJK1Rr?=
 =?utf-8?B?eVQ2MzNvVTluNStXZmFKenVRWERMVy85YUY2ZW1BenFYbHRnMWtRc1p2YmxW?=
 =?utf-8?B?cll1UjAvVDBBd09lOUxPcHhNM1prdXh4Uk5FenJ6OE0waS9VWTJxTlVidU14?=
 =?utf-8?B?VkVMa2g1YTJqVkREbG9Bak4rUlM0TCsrSG1TOVBrUVdDWVJCNTJkY0RIdjdl?=
 =?utf-8?B?S1FjNzYwRmlIRzBBeVJoaEh3RDc5eEp2dVhjUlFqZ1FqNGp6U3pQU2FFYlBG?=
 =?utf-8?B?MkpYMkp2Z2ZmQVZwZ1FDUWsrc3psenF3alIvbVRxcGhZNkN6bzFIMlI0Z21M?=
 =?utf-8?B?RHA2dWw0YVNheVdzVm9jZ2Q5RURWbFpacDlLME1SbVVGV3lXZmliOWhad0h4?=
 =?utf-8?B?YWdCVnF5MlozTEU1OEdhc041TUNwY3BGNVRqTnFSZXpsejRwV1B5ZjZJeXZJ?=
 =?utf-8?B?bkh3L2dsWU1EalFlclhleU1qM0FjU1VyZHUxN1BwL0Z1MTNJU2cvNTVlSXV1?=
 =?utf-8?B?NnZUSnYwNDB0eEZCNEgray9VUnhsYU9jeDJJekJNYXhiVUpBbFlnZ25hLy9J?=
 =?utf-8?B?K0RDZlVxakhQRUpEZmVQdXZRRDRTOGdHYkZUV29FbUgzaGRUYk9WZDVaWHh5?=
 =?utf-8?B?RSswNTdpTWVBWGxKSElNN0xnM3B6ZkxVZlNLcDNvMC9DZ1NOZmhCamR6Vi9W?=
 =?utf-8?B?ZFlwRS8yZExNeDdkZGtkZUNVWVBQRXNtZDVLNjJSZDk5WGVRdTMxdGxwVUsv?=
 =?utf-8?B?V0Uzb1ZSMnlpY0NSdnlBYnFFbHhkTjhzRk1wY0kvbTY3M2pTRmJSWUZQWEt3?=
 =?utf-8?B?TlhBb1Nmb1dGK1BSaFRLNlh2QzIwMlVobDVuTGxXS2htRzFVNnBsRTA4TUxP?=
 =?utf-8?B?RjE4NklvekNoU2EvTlg2VDArU2ZOaE1hNGxyNFY3MUVrazVib29oYlVrUWgz?=
 =?utf-8?B?SmRxOGpXYk9vVjIraUlSV3RzQWdRNm9VbnF3SjUzQXloQ0NpR3Y1QjIrSEFs?=
 =?utf-8?B?ekRYZmlJL053Nk1KS3JuVWtEOXY4b1lUZ29zbWd5OEZoUnQydklZVTM4SXNW?=
 =?utf-8?B?WDUrSWtLNENEUi9jUlUySE5wTElNRlcvMzNDYmtuV1owZHArZEgwRVpyUGFJ?=
 =?utf-8?B?WXE5d1BaYUVSeDR2QmRRVlh6SHNwTkw3eEtHOHRzK29lcUhJL1lDblFTVWIz?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcd1129-b068-446e-c475-08dbc0ec6d60
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:03:08.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnjf3sbwG06nlqV6S9p+B0kFglCq3PNWwejdxoQzKfbC+eJ9YiXYPfTyDqEcg4rep3/UYHH8mZgAle7I6C3aOs/QZHOKo9wCYhm08ALKS54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8476
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/29/2023 6:57 AM, Ilpo J=C3=A4rvinen wrote:
> Don't assume that only the driver would be accessing LNKCTL2. In the
> case of upstream (parent), the driver does not even own the device it's
> changing the registers for.
>
> Use RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register value. This change is also useful as
> a cleanup.
>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hf=
i1/pcie.c
> index 08732e1ac966..4487a05bea04 100644
> --- a/drivers/infiniband/hw/hfi1/pcie.c
> +++ b/drivers/infiniband/hw/hfi1/pcie.c
> @@ -1212,14 +1212,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *=
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
> +             ret =3D pcie_capability_clear_and_set_word(parent, PCI_EXP_=
LNKCTL2,
> +                                                      PCI_EXP_LNKCTL2_TL=
S,
> +                                                      target_vector);
>               if (ret) {
> -                     dd_dev_err(dd, "Unable to write to PCI config\n");
> +                     dd_dev_err(dd, "Unable to change parent PCI target =
speed\n");
>                       return_error =3D 1;
>                       goto done;
>               }
> @@ -1228,22 +1225,11 @@ int do_pcie_gen3_transition(struct hfi1_devdata *=
dd)
>       }
>
>       dd_dev_info(dd, "%s: setting target link speed\n", __func__);
> -     ret =3D pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL2, &lnk=
ctl2);
> +     ret =3D pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKC=
TL2,
> +                                              PCI_EXP_LNKCTL2_TLS,
> +                                              target_vector);
>       if (ret) {
> -             dd_dev_err(dd, "Unable to read from PCI config\n");
> -             return_error =3D 1;
> -             goto done;
> -     }
> -
> -     dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
> -                 (u32)lnkctl2);
> -     lnkctl2 &=3D ~PCI_EXP_LNKCTL2_TLS;
> -     lnkctl2 |=3D target_vector;
> -     dd_dev_info(dd, "%s: ..new link control2: 0x%x\n", __func__,
> -                 (u32)lnkctl2);
> -     ret =3D pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL2, lnk=
ctl2);
> -     if (ret) {
> -             dd_dev_err(dd, "Unable to write to PCI config\n");
> +             dd_dev_err(dd, "Unable to change device PCI target speed\n"=
);
>               return_error =3D 1;
>               goto done;
>       }

Looks good.  Thank you for my suggested changes.

Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>

-Dean

External recipient
