Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D07BF9D7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Oct 2023 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjJJLfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Oct 2023 07:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLfr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Oct 2023 07:35:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A735894
        for <linux-rdma@vger.kernel.org>; Tue, 10 Oct 2023 04:35:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMF0AGWcHIxPzw9bL9BseqGxa1a1GL7VswsGBxEGWrJX0zOWPIDRHm4VBK5gBp/4zi4MdPMmHB8Q+yPMPP9lyREferLQPl3vT8Rb55Vidqpm/sVomcBTYutrXurGB1vqKpqL0C7eTkD7qcO71LfQidsrcmy8YO52/J89zFK92XK+5eEj1buqvo1dr9XgRnrumskmqVwBEYFa15LxYgYVxGxXjOMPJVT5IHaMKWefe1Q+npt/36BvE8dcMK5Y9liiXYmUlCH7gRjvqO5BwVuCKAbgk6xc+ekGOb82CjN18/V5Kl3ZBClXBGAI6+nAEySJx6fCkIb9MH2wbS1FxLYsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvbyzEsejggO+3EnWyuFnOj1GyGrOj/8IHxoobTNwUo=;
 b=I8Ojbh4LTbMcAiOwIZTrBp1faQTPZi2p5KPjwGs8k/d52MlOWkglHe4M/5Papyku8cBlADk929DwOlT8XxBbqlTKEGnOrSvqbC1o3HLYuXuq69k99M1tdC2oBnSCVH5++nTSCbDMTUzfd60YMBBbvozfOu317IXlPl78CZ9mpEzNcjpc7yBbXZZyhONDI6QxfxYDWx1x7VFBInaNnEdsN2d0hI8iLlhgeeUik/qpWZMaHFqoY/taWohq61jvc2IDXNS3GJLT17nGH8XJsaEvrQ6AcTnFno2+e05JdSudAFtvy8RaiFcRwgetdexl6sBqxtUiIRtIrragV0b380fqwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvbyzEsejggO+3EnWyuFnOj1GyGrOj/8IHxoobTNwUo=;
 b=dSzP2oOZ8u8AwcojGrzq7uxlAwbdTyUcCyc06NQqczt6Ls2Rvpy3SQpLRjPYKjuZ5bqOODxdRSOAV7t2PPXZVrkeTmVII6OSalTAiYterwD1NTTtGnCDST5PjYgg7lm9WGy8plgsePToPLa2aZJCZh6tJ3h6nRgTCjHGCieS91UgMyBLh/f0sNzKhZpaXX0n6JlRtOwAetiuCf+nJLkAfost+VUgkwz3rZ7ln7a6Y+r74UXaLFd01Hr9imZ5UEug/2b6Ig1n1GyGQeT2/V0HnSAZQQ3ptjX1uWoL2ix8PlBFQVOezfUh3FWYufkyKmILQc/vQEVCcwLAZ1ujhUuajA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 11:35:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:35:43 +0000
Date:   Tue, 10 Oct 2023 08:35:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@linux.dev>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Robert Pearson <rpearsonhpe@gmail.com>
Subject: Re: [bug report][bisected] rdma_rxe: blktests srp lead kernel panic
 with 64k page size
Message-ID: <20231010113542.GH3952@nvidia.com>
References: <CAHj4cs8hVFz=3OkVBrfZ3PCHU3fWN=+GpH40PvAs49CZ3-pJvg@mail.gmail.com>
 <54acca3e-ef7b-40be-867f-061544197557@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54acca3e-ef7b-40be-867f-061544197557@linux.dev>
X-ClientProxiedBy: BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: d481d239-6221-4e37-f169-08dbc98509e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjLTBRUHp1BOmWBF2wGzuM/dZPIrK/ZrqWBfyq3jRvATYWSWexySg8N2/7CccupBvsbejf804uEijZRWy2sNESQ7yfg7aKGp+bRdKz+xZbiZ5HzsJ0VplnoFL1NkQJKM7SQiGGyatDdix4qNkoCWAvgEIslk7nrCGx5eCGUfmOti2zzowlV7tyVXngWK8n0dcAXzkF5261+8ydS1xZrMFf4lYrJSujCds9jHbSt0ilFjKHy2x3IrPAx5k5ms7FPPvW2pD907uuGLCLZrDambrvPoLr+MrW3nUHsTEWXFouNwgAPUziZxQgjOui1Zbz9pyZHNC7I5L8CTWlulMmOdQsnLfCAfN/0W4xFRjECZ/FoakqdK6O8KbOE7ielOBorAXbEjhodmaKMabcLnMQAcdJa5I1I31eXiN6L2dUBLuyAvTOJijXITZwxRAb0dqqFGaEbZ1tJfLo1HrI0KtP1n9W165Vdccg/CnkLULVnU5H9ku2iy3/rbjcqz8Gm9enqzF60Lx8wBzR1aGmMmZyuIWBAw5SWmlrNuMH4d8+6VqRxlzD8IFlZE0Hgv1dK2uXiVl+ObIBx1brT8t6s9N6RSrFv6xVwb5LJX+MEM2/r2Uwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(26005)(1076003)(38100700002)(86362001)(33656002)(36756003)(8936002)(478600001)(4326008)(6506007)(2906002)(5660300002)(8676002)(966005)(6486002)(6916009)(41300700001)(66556008)(54906003)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmxIdFl4Vi9kTE5rK3pLY3JVb2hrVnFnYnNCTTVaa0l6aDltQzJkVVFCYTRj?=
 =?utf-8?B?QWJQUlk2c1FwUlZCUjBOVWh4bGZHZ3ZoZ2RjZkd1bEhjdTN0MUVLb2RaUTZO?=
 =?utf-8?B?WVR6WXdOM2grZnFyNW1pRmxZeFN2MTlJdVRXSC82eGRvR0hJOTR4R0MzTUU0?=
 =?utf-8?B?M1R6Z3U4UDFVbWVWbmZrYVhHcEtHOUI2UGt2UFIzK1lCK3R1b0U4NHF3QmRC?=
 =?utf-8?B?bEhoZ1FBMlRBVXc4RERaRVpqOG5WN1RubkRnSnV5R1d0T3c3RnNVRWM5bGFO?=
 =?utf-8?B?UVJtRTlYWDI2c1FHQ2xWZkRVd2hYNGh5aGI1YkFUMk1vTGRIZTRCK0ErV3Rq?=
 =?utf-8?B?a2RjMm5xT0lmem5NMnBjSkF3N09TSDJSY1htYWVUQ0hGS3VhbEg0eFQyNDFG?=
 =?utf-8?B?L0Y3cFdzYi82NWRyL0c4VXkwYUYwaGowYXFCdU8xcjIxaVpHSTI2WmYzTVRw?=
 =?utf-8?B?MDFJZHE0cXJpMU1Vb3pwSm1KeEVsaHhIVzRMZ3YrNFo5MmJ2MUJaUnJuMUVP?=
 =?utf-8?B?SXBmSHBxUFVsN0dZUFpzUnhhWFJwbyt6d1l3aTR1Tk5ZNThZeTNqOElZczZx?=
 =?utf-8?B?WGRCQWhEbEhUNGZFOFZtTHEva3pVQW9iajlGUytkcE5KYzROODdQVkhGRHla?=
 =?utf-8?B?V0VncU9aOHFlaXBLekk1QXZnNndMNEc2eVA2RmJZTXo5UE8wV29zb1NPSDZJ?=
 =?utf-8?B?ZEN5bTY2RFZFVTBpSXZvZ3FJSXNKMEhHNGpLRWhLN1NoQk9sM2U5d3pqQXpD?=
 =?utf-8?B?SS9KZzV0WTlJSDM5dmlVMHlRWE9SZFplRkc3UDJjaVEwVkV6eGRqYWxMUjVT?=
 =?utf-8?B?ZHg3V25wK2x2UXVLcC9RSEMwWkVackJDdFJ1ek8xWUtWNjJWUWhKZlo1R3lL?=
 =?utf-8?B?bll1U2M2cCtacUpjTGYxTmNoMVpJNkJTdmtiT2pXTzkyaEN3MUhJLzdjNEJv?=
 =?utf-8?B?bDF0ZkttanFCK1BWaTJmZHFyL040NkQ3SjlXUW5TSWZKZ2RWUExiRTl2N1lT?=
 =?utf-8?B?djRVa2FVcWYvNkxoK2wxZURYTzZ6U0d2OFZ0V2hmQWg1WnEvNTBRSjBkWWRG?=
 =?utf-8?B?T09XYkhWRUVuZnpGSG1aUjEzVyswYVRXV3NhZ2s5djB1MEt3L3RpaHBLWTFV?=
 =?utf-8?B?c0dYT1FVaWR4YjM1SlJ2UmJHRVpYdlVyZGFpeG42cmdMSHFYcFhkMnJ5d0Jl?=
 =?utf-8?B?emh1dnlDbTROcCs4U1NDbGRscDd2MEw2NHVrT3B0U0FMeDhHaCsrekRGeUVh?=
 =?utf-8?B?bmsxaEphMU0xb3lOVVJUekFLb3Jham8wUEo3eGlaNVBQY0NjMlFxbkEvKzF6?=
 =?utf-8?B?Wmc4MlZBcTBObUJLb2dEakt4TTNiUnNqdjd5eEhUWHorY2dqK2M3Zm0rcWFt?=
 =?utf-8?B?ajF2bmcwOEE4V1NuZC83NDhYb0JVZThJYnFsdkJZMnlqMnpUOWxuUlh6SExy?=
 =?utf-8?B?c3F2SHhqQzB5VWtkVFczU0psbG1NdzVwVjV0anhnWlk5Q0dieHgrcjM5Ulo4?=
 =?utf-8?B?bjNyRmlFWktxekNISXJiS2JFbTV4ams2TUV4bjFBVDkxbDBBb25PTGl4d0E1?=
 =?utf-8?B?cUpYLzNmSDFPbHk5bkEyZVp3TnpYdnp6clBFekFKYWFLUWVEVFBLWVg0YlpD?=
 =?utf-8?B?UldRcGQwWk1WdHFoZkRMVXhONFpNOVdyNERKZjRuOHdoQlBRMWNscGxKUXQw?=
 =?utf-8?B?cTFrWHc5MFBDU1o5Rnp5SUVMRkxNdVArNTg1bHFUZEEvSkpTMlRNcEovTWVJ?=
 =?utf-8?B?eVBVMk9ydmU2K25ZOWhhRjcwSHJGMEFlVTNzUktEUXNFT3dmdWR0d0p4dU9P?=
 =?utf-8?B?R2RxRC90STU1dy9zRnRqeXVpWGhES2RxMTJZaGlVZlBPUldTenVvUkZvRXJ6?=
 =?utf-8?B?RUhQVSsxM1V1enhIUlBhR1kwU0I0ZFJhbGZsZ1JHT3Y2aEVYWCtXVWsxM3I2?=
 =?utf-8?B?YWduRURkVVJuY2ZWd2R4MjZZTHNXM3F5dW5qUkJIUzRGa0t5QjZSbEQ1KzRM?=
 =?utf-8?B?MXZ2ZFpMdVJXTDFzM2RQTGUrdHlpbHdWNVF5bTJCZUVHVXZ2aXNVazNaN0oz?=
 =?utf-8?B?NmRTazVWYWlZN3UyMkJMaFdWM216bEN3eEhzQ3RJM2RVMlYyTEVLSWw4SDhI?=
 =?utf-8?Q?QYXg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d481d239-6221-4e37-f169-08dbc98509e2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:35:43.7918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju8cukEJcUZiX5D3cA1sARlAoPDpQDmu2Lzv6Kn3sxlKhHPSP9seMaCJ2a5/qnXE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 10, 2023 at 06:41:17PM +0800, Zhu Yanjun wrote:
> 在 2023/10/9 12:35, Yi Zhang 写道:
> > Hello
> > 
> > blktests srp lead kernel panic[2] on aarch64 when the kernel enabled
> > CONFIG_ARM64_64K_PAGES, bisect shows it was introduced from commit[1],
> > pls help check it and let me know if you need any info/testing for it, thanks.
> > 
> > [1]
> > commit 325a7eb85199ec9c5b5a7af812f43ea16b735569
> > Author: Bob Pearson <rpearsonhpe@gmail.com>
> > Date:   Thu Jan 19 17:59:36 2023 -0600
> > 
> >      RDMA/rxe: Cleanup page variables in rxe_mr.c
> > 
> >      Cleanup usage of mr->page_shift and mr->page_mask and introduce
> >      an extractor for mr->ibmr.page_size. Normal usage in the kernel
> >      has page_mask masking out offset in page rather than masking out
> >      the page number. The rxe driver had reversed that which was confusing.
> >      Implicitly there can be a per mr page_size which was not uniformly
> >      supported.
> > 
> >      Link: https://lore.kernel.org/r/20230119235936.19728-6-rpearsonhpe@gmail.com
> >      Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> >      Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> 
> Hi, Yi
> 
> I delved into the commit. And the commit can not be reverted cleanly. So I
> made the following diff to try to revert this commit. After this commit is
> applied, rping can work well.

We can't keep reverting things for what are probably small bugs. Fix
the issues please!

Jason
