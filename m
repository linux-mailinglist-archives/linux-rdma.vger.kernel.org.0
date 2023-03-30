Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8356D044D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Mar 2023 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjC3MG3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Mar 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjC3MG3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Mar 2023 08:06:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B164204
        for <linux-rdma@vger.kernel.org>; Thu, 30 Mar 2023 05:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRQmAQgs5D6W3NR77drfw58W7slNlaYWIweQwYrgBreBaZI3vQIhwyio6B2L68MrKxBDfmznpQ4lonGmSun4vTE/rc09WEQKrrLf9WzKiuDVgmLVwd+gAvomAeVXKUspgq0fgzPOsnkNWYTyVe/aOnwpUBx8d6EWI0eCT+Dol6R+vE58i/CE19Z1m7BEHALRnd963V/dA/iAKdoWCIza38FmpSTeMaq23+rAkFdLL/UOBROUt4i/eshSHLXaig/IKymTBJLXn9i823bLapOo19R05lbYQEpA9oVuLfpPkjhwI1cyl8L480AVFOqOvnjNv9nTXimZ+ju3UcFLnJiU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y27dv2oLegFYwjR42q6gQvyy5qSgJEL96fWZHAwARw4=;
 b=UAgxtGWxEjuOUBGBM3Y3pFtyin7rDrPMhNnD0LNLR46sGdGPGdpfuprlq2r1KG7H+BLiJCqkhO3lF1WjAPqpSaVx/TVRYZNPF6lvDftOtY9hhpGQJJBjlzh/4OEG8u5H8PqWIPucLmV8RwF+xTRPcR7uTpWUMSWFyog9WlTNXnPbmUqu1BrRRXbKXoELYLGrF01pXeom2YbnVgJZJHrx+VbpRw86oK/adDJ9/KYMOcxO//YEt8/gVIzV7k/rW1wCL72gvB15PDoUZbqq0yhpLw/HIa3SY6FUyolozD6y3lMZlRbw4ANlE90yHrytTA5YbEK4lyWpo5wH5Bipz3Wbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y27dv2oLegFYwjR42q6gQvyy5qSgJEL96fWZHAwARw4=;
 b=tpF6RpsGgiHdrdqPoZVUaBMO/yXQSIiHNcDHoZjejMyclHUmQyBXVY8kJSjJQg05ofTGB9IJ50vDJhJCo+JQGMRroS9uyQIBthfWibiE4xalhcPpxsf66QHGOUbKPaB7G0BILRH1i2FxM7+v+WePkrL0vv2hx0BOs8VAlKPstdqhdgKOi64lili6bv5XR4kZwlFLO3C9Zue/UkCBLZp0331+fBmhDzZq+NmtDxGf2YM8Pen1ZUwnrxjPb410zCke5mHfMhDDBrmnrX9mPTPMrPSqNsulMD8pPHo13EzwEP3FaZpDnWSoModObWhH+Czvb3coE5Q2p3qdK/bPLzvfpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20; Thu, 30 Mar 2023 12:06:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 12:06:25 +0000
Date:   Thu, 30 Mar 2023 09:06:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <BMT@zurich.ibm.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Pass a pointer to virt_to_page()
Message-ID: <ZCV7PwYwLVXGS202@nvidia.com>
References: <20230324103252.712107-1-linus.walleij@linaro.org>
 <ZB2s3GeaN/FBpR5K@nvidia.com>
 <CACRpkdYTynQS3XwW8j_vamb7wcRwu0Ji1ZZ-HDDs0wQQy4SRzA@mail.gmail.com>
 <ZCTGw3+9rYQAmlJS@nvidia.com>
 <66639a8e-e8b8-64b4-5b04-dec357db86a8@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66639a8e-e8b8-64b4-5b04-dec357db86a8@gmail.com>
X-ClientProxiedBy: BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9d0f94-19c0-498b-2ccd-08db31172f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGeAjEZnhv0lC+Mgzg0x92n4HUGomX2SeONYUjdoekjI7EFygqHGj9F/ua3zC1NWfH/MbZ7BZOsLa+kXLLnS+unNCAPh/eU+QogNaOZqvxAqVFMb1OeLJxAFlbY7+fLLNKPevuas03C7LUj84CimAdP3TVDi7YUVUVbdX0gbZ/HvLpuIUdUAlOGUa3DKbQX6N5tHyG+0XP+6fa7ga1ydDOhsr7EVeG1ppP3EiH7BXSdwGmqIiAspDB4ygegFWy7Tg9qAOi6NAQvVs0OhCnq1XaW1FmueLYWKnOb75UV4LisLRy6k0JfKvSEYfS3v61pPz6sRNzQKcra67lmdE1yuoiAgZHqlXaOeT+czVVA71vrSGi972J03cfD7WhUZrdzJ+j1IJWXVqUHKisZvJES/1TReghl1+29VsMINu3LES98O8a2wRX2FNcrQNBjlyGzwMVbzuugsJQA48XJjyLCQ1hdYBIDEXvz+2N90l0dVFIgracLrAmqRdVbgLya5NQTYO0o0VxnDKr1P44wb/bJDOTXyxPy68HXs/6dgZW3WqZO7s9qvu1q1aPB+p0yVnKDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(4326008)(41300700001)(6916009)(6486002)(54906003)(8676002)(2906002)(5660300002)(8936002)(66556008)(478600001)(53546011)(6512007)(26005)(6506007)(86362001)(38100700002)(186003)(36756003)(66476007)(316002)(2616005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehqWG3y0Lmc90nYzIVRz1d2VSPaIEussAtQI4r9aZTD5Ha89t33RmG7vh9zs?=
 =?us-ascii?Q?ZkaQ8kkEet3/L7a7PoFPWKC1tNB/PloOlP96hz93e1QcwyBR5eWh/WPT4Y1t?=
 =?us-ascii?Q?9Cxw1ieZeGvSsViU/jhfW7vuMPGay9hhX+qDN6z3RXiG7dUYyVMoaOR7b8Tj?=
 =?us-ascii?Q?6yfm487YYUM9JqtFBYMd3l+EEfr0WhoGzx2zKwmf3Yv4ihdtHP0i16l7i0oT?=
 =?us-ascii?Q?yIAyBZAdH8SOjUNihisH9U4qgJifeO21ToZwM8eif44pkF3eb2UaLcHr6KUT?=
 =?us-ascii?Q?8IEFOtV8IlUEu9syVN+cy+300r56YtGkD0QpOcACdFXhpSrSkv1EzG4B2uTf?=
 =?us-ascii?Q?kdued49YphiJqilO09sCmjpZ18CdTnLexWJOmyKgkUxa7i8l4kpW5YaoJYZu?=
 =?us-ascii?Q?jUzK2P6Uk7KD4f2Yfe/U3H1eSEHWVlrPq+k3W8G7EsNLofR5I5+Cs/Xd5rS8?=
 =?us-ascii?Q?bpPaByOo0FF+EHKM7Cv04vIfvs6/OICxIfK2EDp86uCUa9tJmzsIWcWJQwNy?=
 =?us-ascii?Q?+XQtt1qsKEvPSRC3scba6BUyfi1QdA5mZ2VfaOOGvpmUjAJRzZGe9hkYKolm?=
 =?us-ascii?Q?Rba4Aqs1OC4XxWOFebzW1iWDBJQyvcSXKfVwOukxRaPCSL59x4ruxD85VCt8?=
 =?us-ascii?Q?7asVVkmLtAgKh0WWrYsaT1X5wjKVGF3Zp59N/m0WRU0e9TRnQjRV5M0xGvqr?=
 =?us-ascii?Q?z00Sv6z4dxHq3/m2yAEHHGAlX5EggBmRlHdbTf1MtoDbLI6yf2AxqCRcwmG+?=
 =?us-ascii?Q?rg08snuDGU7aZ2UdYI82h2i9ALA9BOvbCE4JzpbnV3PWcogzfTaa1WBs9LsC?=
 =?us-ascii?Q?0xGmlGRqrfZz5aZoUKTRLo21eTugJ/Lewu5dWsq48Mchmf60sfx0U1NeCeya?=
 =?us-ascii?Q?BaqZUsmOUfGL3RR9Ea3e5vgd6tAIAcl7epVVEzFfFbk2uO4s7bQBuzcm34RK?=
 =?us-ascii?Q?O2BogcyJLrzWJm4QM98UEr9rkp/IMqB3C/RhgJUF16V/5NzWlel8pV59KKJI?=
 =?us-ascii?Q?EiuL4o+HENGiyst/7xnVEehYCh52bSn6wSJtrt3GFbQEK1o2ikzoalLx2wGp?=
 =?us-ascii?Q?XkdB90X7LkmL1vu57eFWJRUihosOahUc5wskB/k9ceiuEx82ND63jnxmWGlz?=
 =?us-ascii?Q?feMINROyHrq10FwV9xK+q1hkx/6K/XbHTfbUgCEMOlqlLqTy+8Lv6Y+rBPhb?=
 =?us-ascii?Q?gnAuLZesciezyFTFXQCFsiDSYlpZKlBjXzyvx2XcTVjcKL6kexGzxXBiFhUi?=
 =?us-ascii?Q?0KbImBvyVX0Q12JYujQRvHlaf++IwOBigeSXNx3SLQA2u23dhuTq9CP05zUK?=
 =?us-ascii?Q?MmYgx6tl2o/RHr8L9nX/JvkUHLJ5DZSXUGWX0HbhLj7k6DPgpQwJAKG072Iw?=
 =?us-ascii?Q?HHJ2YKjXjtQD3BE2aql3RZxxh3B4bsrtHkF6cxcbmdmk4orWCkuJrKQEhW4p?=
 =?us-ascii?Q?IURs4Zp4+AE4ptjjoBu/bMOmB6ZK1Z/IcbamAYdrClxZ3uG5FkS5srSm9j4P?=
 =?us-ascii?Q?h0E46RmBKEigRRTe6yWnCap2NXcgjWGHT97asm+NKU1TGt0NzVFHivR/y6Zr?=
 =?us-ascii?Q?117VlJpQXwEjXEP1BCcUiTaQ4pYnbHN/vp28NTe0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9d0f94-19c0-498b-2ccd-08db31172f42
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 12:06:25.1025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CulvRxkps4mlTb6C7yxLVIAizwmuRtGCHMiwbq0/8zccJTb9Ym41VdEOxtflJb1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 09:45:45PM -0500, Bob Pearson wrote:
> On 3/29/23 18:16, Jason Gunthorpe wrote:
> > On Wed, Mar 29, 2023 at 04:28:08PM +0200, Linus Walleij wrote:
> > 
> >> I'm a bit puzzled: could the above code (which exist in
> >> three instances in the driver) even work as it is? Or is it not used?
> >> Or is there some failover from DMA to something else that is constantly
> >> happening?
> > 
> > The physical address dma type IB_MR_TYPE_DMA is rarely used and maybe
> > nobody ever tested it, at least in a configuration where kva != pa
> > 
> > Then again, maybe I got it wrong and it is still a kva in this case
> > because it is still ultimately DMA mapped when using IB_MR_TYPE_DMA?
> > 
> > Bob?
> > 
> > Jason
> 
> In the amd64 environment I use to dev and test there is no difference AFAIK.
> I have to go on faith that other platforms work but have very little experience.

Honestly, I would be much happier if the virtual wrappers used
physical not kva :\ But that is too much to ask

So I suspsect I got it wrong and it is a kva still

Jason
