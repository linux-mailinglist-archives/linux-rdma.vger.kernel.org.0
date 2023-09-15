Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5B7A2039
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjIONvZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Sep 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjIONvS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Sep 2023 09:51:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113831FFA;
        Fri, 15 Sep 2023 06:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkknUdHbjUqCBF0cnT1SSkYDVgODRqUx+MCiTDmJjVtD3Rq/ewbTcVFSfnecMBm62pKLaMYX9ZkQuIYe8XqknvUF5vlcSAxc29h4Hj2IKsJTUYxi9jtHI+sMPS04qzmsZyuV6mQmLutjvTnPqUrB8XItDgownDzmRqYoxKxwHGud1onAOYcgT322OevYfilKdJUwHZ2WHMgU3Rn3Xlg61GJa+IVPsg59+oAElYVrLLtCaVlz+3xfr+UAvkZBK9dE/7tufC3CjKyM55L37pGYvCJ23EVKGgYxkdcQ6TvEmhJ5kVFa62Jbtkm3XHXm+j4BO7kuqjRNpH5gyIuIaozR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4Bw8QzPjcIShNhKgY2tOiAXSALOXOrDM5bIR73UmMA=;
 b=fsTilP4CrIU+lSU/SUkJ/88cAip/9InwmQAPwauktpvooOk/RNV0bVdXpvnmdMTCwanLtAejMiTOSOvt2hd9ifiuMNKllVov/SIOohB4HbPGonYwVm0JlS00v/v+gtSava5FNLwtgD9nFDMGEwcvE4JKVwJ1iWgOtZrIyeHC/OCsawKTXftU7yJNhCacEAmSptnXejDWudj5TbIYKeZjVpCqwSAfoKqE5Iw8Kbg9kSogBtbUx7jrZx8mU/BJ371ajlEt/0eczbhQ/jcfxafu+ky65vpxQxbkU9/fr6l4ioPeXpUvAXGKQK94II7SbWDoHqAd60g6BK6ou/MaPpq+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4Bw8QzPjcIShNhKgY2tOiAXSALOXOrDM5bIR73UmMA=;
 b=aZqWRnqme1GXv/HJdSbtFioGzNxYl1srL+rUhw/Y/wHo+H19LJLyv5coWWV+i5E1D3wcsN+ZEgTvMjtBeJ0Z4z+IKSrjCjBedB5IgOHEgyDI5D74OVZD8vjhA9lvoyCbY3nyHkWImCNFgYQrjQ4yrh7nbrlPgeV8yNP917xYWY+1o0Z0fx+Xdlc2OE2pkXWQsyMtr/UM8Gj6nYvpm0LrvI3JaX8Gmc/1pa2YHqhwDAiY2xNaKar5J2jDV72eTMovuqTwHPwdcszqOSnFUyQQWXcs1ml7dt4TzzaOnhiLQJSCu1o1cAlS7rN4ldQPTDaiZX3oxSin0ipDdcYzKmW+xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BL0PR01MB4131.prod.exchangelabs.com (2603:10b6:208:42::20) by
 SJ0PR01MB7479.prod.exchangelabs.com (2603:10b6:a03:3e1::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Fri, 15 Sep 2023 13:51:06 +0000
Received: from BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::57bb:9292:4cd6:5e18]) by BL0PR01MB4131.prod.exchangelabs.com
 ([fe80::57bb:9292:4cd6:5e18%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 13:51:05 +0000
Message-ID: <c0e07dbf-e19e-43b7-9c95-8025a12323b8@cornelisnetworks.com>
Date:   Fri, 15 Sep 2023 08:51:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] drm/IB/hfi1: Use RMW accessors for changing
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
References: <20230915120142.32987-1-ilpo.jarvinen@linux.intel.com>
 <20230915120142.32987-5-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From:   Dean Luick <dean.luick@cornelisnetworks.com>
In-Reply-To: <20230915120142.32987-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::21) To BL0PR01MB4131.prod.exchangelabs.com
 (2603:10b6:208:42::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4131:EE_|SJ0PR01MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb9da8d-81de-4de8-2294-08dbb5f2ce6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WV8q+g+X5y+1BaaxnYHkYPM6VJ1kfVvmx5ZFl7Cn4eGVdt3U9j950fKm3MUi0Q11iNYiTgHfO3+aeuW7m6dnw4wpo3zXBnSTJvqtgg8L9INBAMKo+WCv9l+IYFmg2KSilUgA7miNUIq0jJTqYcE6Y+33/hOfxuja6dYXURFT/b2dpmx2HkTEKd/JHxIK09/UOibuWUssDplPS9m0ClzBWKyvP+zXPWmzPSl84OZ3HOs9LI5rQirXT1hku7zoewQP0hibpZo6fKMY6mJlVVkPL98espZF68HH9+CPB2b9qoVQ2V1LnwiESLXFKWyTSVHR+hTJsvXJDWe/cZsWqmLuUJFjImQZt1iKdFQ6WYPpwQy276aesrMcUNuQ5lFjqXCUNmf9zpXY4Lh42lgNLE8QBceBeSgAyO+eopQ4oKBmOuP1YUH2oXb2pDONVgp/X71xmcn7hodf91+P2coU9dWtbQSsw7UJVpNbMbZ9CMknKqjEjHX08y0B9BJkCG/PS/u9D0WwWzemvXhH6NxSYhuYCHxNjbDWdDN/pTafFnr+fm9+gFhH+FWoyGOM9Ej16nfa+Q1ZXA3+jsdD1LY+2sxkXl01cHtvZRuvvAmoZ6Z3VpCoPRWf3mbXpE4DtFL8MbeZRAKBGObSii16Lz3b98kFFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39840400004)(366004)(1800799009)(186009)(451199024)(2906002)(83380400001)(7416002)(921005)(53546011)(6486002)(5660300002)(66946007)(54906003)(316002)(110136005)(66476007)(6666004)(478600001)(6506007)(26005)(41300700001)(44832011)(8676002)(8936002)(4326008)(2616005)(6512007)(66556008)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRVQnVNcUpNRGhuVGRhRnptbTFiaEhIVTZING1LZzhrMDIyRzNiR2tnRVkw?=
 =?utf-8?B?TEgwbmI2K3R1dkgrTkRzZUptRDZKa3VOanVkR0VkV0ZYdS9VWUJyQlM0TWpI?=
 =?utf-8?B?UXMwbU1hdU5ycFdaS2dpNXVXVGM1OFBmWTAzL3dHclEvOTZPNGZyRDBWWkR5?=
 =?utf-8?B?UW1SV3NrUkJySmdkNnNKWDJpb01hbjJwcTRnMjRqdWNIUFZOYmFtL1p1a3JG?=
 =?utf-8?B?R1ExWjJ3dnFvN1Q1eUt2cDZwenRHRkRWb0xlRHlTMzNscmFqenRpb0drQVBt?=
 =?utf-8?B?KzZuODVDT1BGbmpqNVRmV09UaU45ZVJMQTh2eUU5cDltSDNaUlpGaWdJTDZj?=
 =?utf-8?B?S0xiYnZqVmJhQmRjbGk0T2tNdEVVd3QvajdmZDcydUR4Y0UrSVhLQUVBVGRE?=
 =?utf-8?B?NVZqSGlhZGgvcmFZblI2ZG1xMUNkYzRiRWZuZkZHNld3UjNKUHB1dXdIenQ0?=
 =?utf-8?B?TnJIbnVhMlJNbC9LbXphYzF5RjRiVjdhZTJSMjEzSXhrVGU1a05Wa3ZSZk5L?=
 =?utf-8?B?aWpnZkk0cWJVeTI2MHUzK25FcHhIR0V1QzRFeFpaK2xqN2M2MG04SnZIVVBK?=
 =?utf-8?B?YXhYajA5eStKTUc4MW1pK0RBQzBOMWsyYm9oYktBSTMzejVIUy9ZRTJyUDMw?=
 =?utf-8?B?anJNa0sxWHhOekFtRUJoQXI4SmI3NDBvN09Sd2N3MXEzb0FYUlNYTmNrbnF4?=
 =?utf-8?B?ZURhMlBqejltbDI4TURPOTdhSFk3TGhwM0tEVFlIMGtjMmd5YVM5b0c1cnBU?=
 =?utf-8?B?UTB0bmxpTjgvbGxEdzY0K3lXTVVyQksxdlNKUlZMNHRYdnFrNENUQkl6MWV0?=
 =?utf-8?B?MnE0VXNtemswd2JUUkYxS1kvL0tzS0pzTnRrNWRxNExWclFKZE5VVG50NThR?=
 =?utf-8?B?MnJuTzZ1R1BnNVdsd0tDaS9CUFIwNmFyc1dJaHpicHprbUY2eFdhQUFrQzdJ?=
 =?utf-8?B?T2Fhc1FtWDFKMGlCbzh1cG1HQWMyaDgwSkdINXNCLzRTdHIxSDllS1MrdDZq?=
 =?utf-8?B?V3l6MTV5bDRYdnBuSnlLWDFsNmpQMlV5OWV6WE11V0JCalRacU4vbmVUSHRY?=
 =?utf-8?B?b0dlOGNHbFRUL1dWZU5TWTljSU5ibTY0VEJiMnQ2WVFyUGhPcFFEclArcXNM?=
 =?utf-8?B?TVVLWWxnNlFVNCtTK09TMjFTU3BwcmJmK05tbmZOeFVOS0EzY0NxY1VJTmo0?=
 =?utf-8?B?UjhsRHZrRG92Z1krU0VOVUd5RDU2R3RleE9sRGkraWVyWWZGYVlUaE96N01p?=
 =?utf-8?B?MEVFaXgyYVAvS0lHVktMK3E4YmtGbWVCdDExM1FBVCt3R1pwTXJFa2NmY3hV?=
 =?utf-8?B?Y2tRMzgxM2lKL3ZJRVU0MHlFZFBqTXpCMGI0NHpWeVFaZmpRVW5qQnVndWVG?=
 =?utf-8?B?VEh1R3hPSGlTYUxoeVFuUk90ZldIdVJ2dmdzRWYwYjU0U0NtTytqWEpYWEhS?=
 =?utf-8?B?SnJ6TXN1cGxVN0ljWGljMCtpZGxQVll1QVlBVW1sRE9WSGNwUHZqQU5Kcjlk?=
 =?utf-8?B?MXVUM1IwQUNqa0M0M0FxNlNwRk04WWFOcnBBV1diUlFZcHlIVDF4SDFtemI1?=
 =?utf-8?B?aFl3bHFFZlh6cUxUajlGYVV0aXB3NnRIOE53cTFEbHNrak9uVHE4YyszZDEz?=
 =?utf-8?B?YmN6YnRESEVJMk9MZUN4d2FNdE1lRE8rWVRESXlaeDhBZ0FNUmg4VjFRdDdT?=
 =?utf-8?B?Z0FjWk9FV3IyMFNjUkhHVytlY0x0N0FpU2ozRGg2RjNMWFVaYXpFSzVwSlpm?=
 =?utf-8?B?T0hsQkE5amlBeWppMks1NW9PSUs2K0E5L2JWNzdnVEVzdVFRTVNBOW5VdW1L?=
 =?utf-8?B?ZUFuQ2xKcFhrSDJYNGoxbS9QMFUxbUlJNjlMOEI3YXc1SE9LTXMyTytCZTY0?=
 =?utf-8?B?UnFsRExzblN5OXhTRks2NHg1UTUrSnRHVFladllBc0U2eTVIeVZZR2N5eFJC?=
 =?utf-8?B?YklQTkdWdmw0QXZTMFMwYjJ2MU9MWVhDdjc3N3duZlpnQ3ZSdEZLRUJDK24v?=
 =?utf-8?B?NzZzcXMxWG9ZTFRLSy9Nek1aYUExbEVxVTZmNWhMRUFPWmlZMG5sWDV5emRJ?=
 =?utf-8?B?Q3d5d2VUQjJLSGZ0d1VsOGFYOEpuYTBGZ1JWS2g2dUZvc0NkV3dxYnd0TFZp?=
 =?utf-8?B?UnRVeS9sZnArcUN2bUxOTjM5Smt6eWRKMmlYQ2V2NFFEWUxTbThldGl3elRt?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb9da8d-81de-4de8-2294-08dbb5f2ce6f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:51:05.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MkS+czzN0LgqM4A+peT3QNcD5PhTeqqu1+Afq/2qBqtAY86ZH0zgEHzaWCTGK5rixqRrQyHLSpp0znOdWfHD5ddX3I4v1sP/in2eAyaeLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7479
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/15/2023 7:01 AM, Ilpo J=C3=A4rvinen wrote:
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

I believe the subject should begin with "RDMA/hfi1:", the current expectati=
on for all devices in drivers/infiniband.

> ---
>  drivers/infiniband/hw/hfi1/pcie.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hf=
i1/pcie.c
> index 08732e1ac966..60a177f52eb5 100644
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
> +                     dd_dev_err(dd, "Unable to change PCI target speed\n=
");

To differentiate from the dev_err below, add "parent", i.e. "Unable to chan=
ge parent PCI target speed".


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
> +             dd_dev_err(dd, "Unable to change PCI target speed\n");

To differentiate from the dev_err above, add "device", i.e. "Unable to chan=
ge device PCI target speed".



>               return_error =3D 1;
>               goto done;
>       }

External recipient
