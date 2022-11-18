Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE663082F
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Nov 2022 01:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbiKSA7q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Nov 2022 19:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiKSA7b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Nov 2022 19:59:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94041448FB;
        Fri, 18 Nov 2022 15:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyKlui4rNF5bQYhuPxcEb7990K1BaYREp8xPIsjwV4kXNr6epFNwVdk3B2DBIJBCgnzzL25jvHAosH4b38e9lA+gpOjOijO55akgW/Dskjk0fUft9Me/63FAo+VacwH181pN1ecAZiW8jgLb8w0vfm82uvyGEL1GVRTirMlESTrxO+6y4x5fb/TItQcPIa05Mq/6h6F262JVRcyRnIIO7O/1FpDXLaWSyFwiT8xo7NEH+DHvQqEQ48UaZO7PUloX0Ri7cswAff/EcS1HaN3ox/KjAbmytStsIpULN5mC6C0bpHbMNAnol25qSTXiZrKaZcY5Pmf5jiweIeKq9K59KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzQxSgA8McxiVp8DCiWt2C2IzivMVRi+yaaZ8kImHb4=;
 b=USi0SiwhvJVrpDHtqSbwvnjqUdzTmxzxB4ZqtSbMCSb76nYDiWhgG385WLAIjgjGFtQfb1Dt3VqbqUsufZk1HK7oM3m3nq4tbActpQa/6plyp4suDbS2yFQCrtrA1XLz22fIxjMQkKDzoPV4az8hSP6lr+dgUAUPQw4i+fSdNfwrBMRxVFRorvV8IA8vxTnDaV4P/AUPQXMC+yk6ODrq13X8U3CUVa+b3hipLFcaS+pW5yXmKxJHhh6EEHbrZ4+s659+kApMTBqiwyqkXgTWVNW45gl6+hVWYVUhbU/L0MDeDq3RsYk0mukz1GkEVo1IcDmNIAAisZ7oynWMQryVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzQxSgA8McxiVp8DCiWt2C2IzivMVRi+yaaZ8kImHb4=;
 b=Oo+COnIohDbJOsyCWwPdpFx2EOQDic/FRaEw34mGVHgvO0twAZhFR3UM6Kc+0FfQLbeqeIWx74Imf32Rw1wdcvGuNdaKWc8N/Yrjv1Pb4WDb9tAzmQqJWT1sf0wuBjwIa0lDBnwWQxVItvYQcJhXh/DtpxCY7+4o1rRjDIOfSoD+oXePTfyMckPFDB5ZpU6Q+1vt6G/dlWvEyJGr/pOFTfgI2IcjAX3RJa89DjB9lSPIrFOXINJelvFhjZB0X7v5gJTIC0I66F/Tm8cT76yzip5EWZkgdtgXHiokOFxPLNAkdDz+oStqPr5W4jZSQr5c1N+4kiNE4ZYlouMe/WEwHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 23:56:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 23:56:52 +0000
Date:   Fri, 18 Nov 2022 19:56:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>, cgel.zte@gmail.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] IB/hfi1: Replace 1-element array with singleton
Message-ID: <Y3gbwroyCqH2nSlz@nvidia.com>
References: <20221118215847.never.416-kees@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118215847.never.416-kees@kernel.org>
X-ClientProxiedBy: MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2607eda8-4f90-4d9c-7793-08dac9c08fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSp2dpw+RHF6N8j47LsE/l8fBa89jam+e46zDbF9xR9H5c129C/8GYdbNuFKKzHHlb8NW/jfteugUhcY+KP29M/x8Uk72VJRDq+X7qt/Bi6IYv7HPhaOycqGL5+VB7WcBGFgCkP2sj2cmf0XtV8nl88YyIuhesbPJ8Wzv6Ujb/lkO2u46fOonhHKKU+1OcFCcNN9Z6Hq0AyqHTc1jADMY015XPZAhnpgUbtZrZhHTInleK6RAw3h4yjco2z+3b3ZcDvEA+Yepilg5LCYP2mQq3aLVEJ+egDkSMCYmmcIElRLGF7IokwzH+t8UIjOIV1642463RjplTi7G69DD2A0SfS699rnE6MdpISt1nGxC5xzJh7SGhfLfrktutXoMZ+BB6ZeCSpMPMsOi7eFMoULXrULk3e50PHrzUqDiNyyUP7vmjj63xRp0xp/tpwhDtL4KgHKpk8+aODa7+8zk2Fxhyuv47JEkRptUWQoTR68IYLuLEarLaJoBoHrI0NzZE7jP93/LSXeVx63dIf51OXIbzZEmcP7ekUXsS1ekGNJpexBHScNmyNx7oqEiO+QQQ10KBO3nQkOSLzJIwJeXrpGaRrcfKH6g7MZas+MImI/6lyua58ero6p82YbXw6gIK5S9woLXOYtam+DHOlnmWLZxhwbq5/sWKeDdiB+t8h55feboDU/wclUpQx4dC1xKCLg43+5ve92NBmedpVlEDim/01OHVp9iUIOEmZfB+QYxHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199015)(966005)(2616005)(6506007)(186003)(6486002)(478600001)(8676002)(66556008)(36756003)(83380400001)(66946007)(66476007)(5660300002)(86362001)(38100700002)(6916009)(316002)(41300700001)(4326008)(54906003)(8936002)(2906002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0JT2zN0ZIMTG2/bZ99nf9U0T+TU0Y9ryxesV4d3JGW1I34HxdXdYbOvC0e/i?=
 =?us-ascii?Q?RKQ5DNxs1v0L3NR2QvLYjPTnHKQlF5oJaHNX3eNqYBNS59WRRiHGtGgBTW14?=
 =?us-ascii?Q?wuL/Db492MiLh4bEZkSbpqd8NwDeD5tTxyK9KRQKehUKqsluQCVY9vHbhfl6?=
 =?us-ascii?Q?aBrxNy1nDFFHHrOE1H/hcXcfml+n0/R2UjTEuGvXMzN5hXUQtsAB2/Un4Xx1?=
 =?us-ascii?Q?d0VxhwID9zEwYypryID/7Fqin/wDxGj9UkzwleqkBpoYszez6nCekyvHFMdV?=
 =?us-ascii?Q?O89H5FpnqrLvanwViWY7rASpxJgKzCklopV+ZaUrqceZfr9z8bZn1WESuOt4?=
 =?us-ascii?Q?EF6oYFv3/MatkzuS9vq5imtbq6Lt9zWtDXXi7DHV77hBm16oqoiNRL7/PWV1?=
 =?us-ascii?Q?uQlu1HdgaCF8b/Esd+sy76yJMbKHHCpU7EjekHr0r+ACdBNYsHeEo61zbPbk?=
 =?us-ascii?Q?HlhN/+c80kLxiQ7P/s4k6WYdFJsO6onnIa4RJPrMtm2VRcbbqujn051OaXXF?=
 =?us-ascii?Q?dpNRQ/ikmW8FsYlBB8M1n2Yt0+n1vwDOA8rVQnJC4pVvHH1MYLfueY/8AQ/u?=
 =?us-ascii?Q?OOWhFqBQEwsc/qc2HWW7l9Xhc/MFI7FofC2t8N/43cz3IaslDKMOLMW+aqnX?=
 =?us-ascii?Q?L/6yJ8sNKOq2UulTeV6GoPEAu7WE+ObMJEV0Fhfxzac+v7ZLmdTjGeDQAp7B?=
 =?us-ascii?Q?SpAoOb5it8q9ez34Ck4GOHP1CBlMQlSEAevpuBe9CV/rMvOV7SfW3U45J1CN?=
 =?us-ascii?Q?rPbL7PQr6KE2MiqjJbR9mS1TRin5c32u3zOBzQxsAnVH/tc9tjSM7hfgW7IE?=
 =?us-ascii?Q?n1j+8d54TTnQ20vp6sDrhGfZs3VdPzxWVuSn6yTa/nuu5+InhV2SliNVO1pW?=
 =?us-ascii?Q?QGm7chsrAwkoFE9h279HpKVNIYEETdlSRgBtP6A+MzZHMVvK2GZSuvdnE4X2?=
 =?us-ascii?Q?ws0hFPmBmjiiNISnPl/jqLT0CjhQdNMp+V2przLw93AvMHUeJ27QLdX0GCcn?=
 =?us-ascii?Q?qG2ezn0Pc0p0ayU0YkPkTwIn6WWJ6/ElQzuo2zk29g0EsRXh/D4oU71vXxRO?=
 =?us-ascii?Q?LuQrXKA/zVj8uP4psbwASTTECEGylN3dXKe70IiBxRxozUYqbwGmInckf1tP?=
 =?us-ascii?Q?VJFwJSqrai3vmSPa/NJeLt+z/aWOmqHYFyDe0JL8zIYtaAlsklmcvDMWfsr6?=
 =?us-ascii?Q?Mp3GgAh7aYY9Iet/dw104vLKED+8BbihXZw8oDbi/+sI7nuYAa0ch5ppMO6N?=
 =?us-ascii?Q?6rVrK9m5abBcjoMh49fOu4tNaJPIxsZ4ftZTPP2bjIgsSBr9XWKimiKycf73?=
 =?us-ascii?Q?ppWHjtU/BgOVQK5amlNs75+176OmznMcAVOceRlgLanjIhr3sQ2pkNWW3P2A?=
 =?us-ascii?Q?hu23Xac+k/iIvDYd4BDp3fENPrQKt5gScwQlAHkmbWW1dOm6eE0jqWo5fv6d?=
 =?us-ascii?Q?/suEMnJ1Xy+f+2Lb3F102hly0l8ttHuYkSmNCIFGbBWYvc4FK4HYCmXvHYPg?=
 =?us-ascii?Q?NhBHrAZFwqSeQUaVdFcBcq1fPAe/IazDuGMNxRnw36MZxBumjzvX2Yct0Xul?=
 =?us-ascii?Q?0OP8GIGuSkeTGMZrrTY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2607eda8-4f90-4d9c-7793-08dac9c08fbc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 23:56:52.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVL+UFiejQ9+V5EWI3EnvW3S4hwia15Y9qi9wWJ72lwwj+m9oXkD257igklG8wdn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 18, 2022 at 01:58:51PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace zero-length array with flexible-array member "lvs" in struct
> opa_port_data_counters_msg and struct opa_port_error_counters64_msg.
> 
> Additionally, the "port" member of several structs is defined as a
> single-element, but is only ever accessed at index 0. Replace it with a
> singleton so that flexible array usage is sane.
> 
> This results in no differences in binary output.
> 
> [1] https://github.com/KSPP/linux/issues/78
> 
> Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: cgel.zte@gmail.com
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/infiniband/hw/hfi1/mad.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
