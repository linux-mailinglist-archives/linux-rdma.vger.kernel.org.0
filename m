Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D02A72CD7C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jun 2023 20:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjFLSHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jun 2023 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjFLSHI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Jun 2023 14:07:08 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DFE64
        for <linux-rdma@vger.kernel.org>; Mon, 12 Jun 2023 11:07:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOCmeKm6haL3TXKfnCEYdVcUnvvPct5Q3pnbOzrdZ0lJR88lYFEDiiaB0+DgRrbEgwvKpifQahVfZtatib7VwfA4iKevtgHqey/8bUbgVgAxX0ZPw4gX28ePLNsIwFxjo2R+SrRuGCKh1uv2I9+ngVy2bb2o5bXoHTlxm2rp9I/ZhkOczd2Q5BWREnW7MvX242DqeUCJqUFTEJnX74maEqx18Wu7YLoBBWJ3Sq+O6fuyg7YkIxQYfk7A/gxRDZFzWVr9JUQNWB6Zla/JaWb7JPlDonFgIro40ZfM8IVGfrZbVQ/lQzKLIltGqllG0TeLljABQScfmWt4L6JJBWQJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1Xcm519rxhRRNdj2fQIHj99/53243wQlPnRLaE+PYw=;
 b=KedGJY4fZll98ImoDuTa98933A9m9oQGWH1HkJ0u2yfQHmQLoz9kCP/KHdV8W/uAUdmsbDkyqduau55nlJ6rUTslXqtuRAyBghbqg1KPO6fSQQKlnZQqPLCvo0IADhk8gV8wK19LzKVpxgJsrZjlsSMW0OecI3YM9DCgDOAOqPyBS19IM22Y/1LVIISlhGDyJlJmiEXAcuXEaDZKxNQf8vLTY1yQKPsidXP/SUGLG5AEgJDUITn+gvtI3r2AHLEMLF5RUHPkA07UvB1I6x5pa8NR+YDLhykaNBNhpVSiN9DF5ZbGkwUg9JVqJGTGUVQSVqAfHVqdqNux/oKyivTmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1Xcm519rxhRRNdj2fQIHj99/53243wQlPnRLaE+PYw=;
 b=eggCVmNz/9JYBDuw/mvXOaW0HXNthrel7+crtxRcEJm0GxLxJznPM7pDqr6yiFj6RHYVQGdFP3fxzLcDNSoa+T7sPY4D5LCwmdtWvGIvE7OBET3KHpvOtvCyB0U5JbO/Am6FcoGhtXheACqWGhDgtUO3/15Y7MObzyaZ+Z02t9vnJfz7rl1EEFtuduUUfiYOidQnbClq8zvx27CE6fyQms41u86Mq/6anpnFFjmhvFL03cP+LV24PzThdrHAlUoUqxh7sTzkR5SSp1d8x7Uyo8bf9SHr3nAy4By2hDMQKk1QmPe+mZRjmnpE181K6J6uPtjyE7ruxL1NUq67HoD6Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 18:07:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 18:07:04 +0000
Date:   Mon, 12 Jun 2023 15:07:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v5 for-next 1/7] RDMA/bnxt_re: Use the common mmap helper
 functions
Message-ID: <ZIdex3yPdSiX6qfA@nvidia.com>
References: <1686563342-15233-1-git-send-email-selvin.xavier@broadcom.com>
 <1686563342-15233-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686563342-15233-2-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR19CA0010.namprd19.prod.outlook.com
 (2603:10b6:208:178::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fe3e8c-d431-4cce-ee08-08db6b6fd406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgDhvUgC5/5EzVwkGABgXCUw7p9DhQ1NSvQDghrvuoxZx4CTPBQvjluYZpo/5mGplFLbOaS1Fmi+fjah70svvjdUmFqcgAsDOOQkj+Uj4Axtem4viiLNoQ9i+Z+1UTqWFD4ceeFBooWoDLo4z08ejV09uh+t63pAw2SPopDmKZPlJjJuiTLwgw4GbRbqpKd36X9fhVRWQSqFWj7VMzB38rDB3zbE6Pq6Nf8MUQSOM56R5pio4EOydGtfzR4sskOsAxD/bZ/9Ls4yUMxEBKIl8WWhf3GA164bvEq3DhwZteA9c4v3rTbN9jljZg6I2K8FIBNroX9ao33HY6WfEbwWJ4MuM6w7sq2Dkt5t2fXdZq+K/RfS8WZVauzEGQ/5WS/jBdgQ4QhhNp4TrQxgzhcw2y8pEb0JzBtWtt3nYZObwX82CpZHaW527u3aApZtjxLqGz5RGvtuTgjHmi+CfYAHLo2STr3GR4Oe6j5Rjd2hpb43em8IBtNZ6+Ix0fwXON4OpDt0PSXOYdpHOfgL421BD3CtWuXxPibb8G83VeO/FuoNIjeH9q1C9aNpCSCVR/9Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(316002)(6486002)(41300700001)(86362001)(186003)(6512007)(26005)(6506007)(2616005)(4744005)(2906002)(38100700002)(36756003)(5660300002)(8936002)(8676002)(4326008)(66556008)(66476007)(66946007)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CcP7xAcyvunmWeRrB5edhQpC+xxSdVsnXLG2d8N41e/JuZZQSUuDDCBT3t4W?=
 =?us-ascii?Q?eSfjIiwo4aQv4wPjT21jk39X+j3EODp872Qy0J7mkkaQJgcVoLUuLRZxshj1?=
 =?us-ascii?Q?RyRTHzqgyv7gDnjR5mV5SgOPLoYhjFgGd/ftvfJgBEjXf9ON3rmbsDwETHe3?=
 =?us-ascii?Q?6zaWkFLggjsRHqAeoqS/XfyKzV3sPiMpXI2l8bsw2J86EtVwCOOQoBPTcTZj?=
 =?us-ascii?Q?Y5gkvw6IYhPfiL8sgL2llPDmHevV39IW/USPOcTSjQKc06T6y7Of7vGtgOVO?=
 =?us-ascii?Q?vFo2METkAOE2CTxybY2RtiwdlOZ5pfgOAbzmIsMZd62pgDAf1ldgvDH+eZap?=
 =?us-ascii?Q?hLIAk/adZLEE8vaqQiTFOlqq9J/Biv3QZR1PeEbXrEOghRjGFs+ZM/EgA9ew?=
 =?us-ascii?Q?csDg/PfXFq3Ti2ZBDFHQJYf2k54mEzC4UVgObXQA+CqMyRDLKilFreKHDEeV?=
 =?us-ascii?Q?bfWUS2IfEdsOpTGmC8fVEljDugjrRYpsoWTnEuwG9Tx/Af9BrcoghxJ4tb+y?=
 =?us-ascii?Q?y7mpMrmKxMocKClvbYo+OxcbGIVrNCESkA1v7ZYkdzSWpgTq6SqC7AgzPWKS?=
 =?us-ascii?Q?ineorcc3wlF4JztBC/YRkmIzRL6TDp1Vv6V7MyKM89NR6+m5nT7q2pBSITIz?=
 =?us-ascii?Q?zAaMS6ClJVgbBsMh99/qXJ56nhL+LkNYFn4AGFP/8XITG/sA32nchoWnbAqx?=
 =?us-ascii?Q?PVzHbCf7824dVbTyaZbCAH8acyBxEuS49EY8pS1FZp0aQqn0lB7+j1hNRPtk?=
 =?us-ascii?Q?x4Ia0o+Tkc5GbjIVXCBb9S1xdX+jL6SQT1bfMzYyCQs0Ht4g9ct5PB71HHke?=
 =?us-ascii?Q?YJijsx5p3kEgU+M3hQsxFLTP9s5l4E5bCylD3L5glg2gJ/6fXJ9r9XZCXTCX?=
 =?us-ascii?Q?pK0MKyxhbmeaoOUC1HCxTKNmv+CpTOgUiSpc7x+oazm4gkSfGfZYi6t3Dpbf?=
 =?us-ascii?Q?qAo5kdEfVb2lfQkHzQfeuCOt09IB0A12HDMDD/ZghWofCV1xyinbkVZ5AyRy?=
 =?us-ascii?Q?0dsfXEKVymuoOPvluZIvTMqdhcmTThF/PycMxULrmZjfIYkyECyQt1VHHLkv?=
 =?us-ascii?Q?pGv1bVRGm5fRmzMPgwwkD3u5eWvOIK9gLkTEtwaa91XRBTM9lEzKaHte2Coe?=
 =?us-ascii?Q?5+Q671gMSqGUX7Y1TIyr8iNwz0qRV4yc4COSFW9IH0wuefYaIPdAI6VNTjS/?=
 =?us-ascii?Q?mqtv4CI+JLInhlpn7jZ3d/0592WAjuWgnsOOQu4cPSD4RzChS/hgFoRal9wt?=
 =?us-ascii?Q?0j7hzvm2ro6cue8++SEkNEMxhL7t5UkPl0eqlgSJXY0L8mrjjVwniV//55Ln?=
 =?us-ascii?Q?lof3yEO8jIe6qoYCwN2bJ2c8BlyyZ71rauAsWAay1e3u61I/QGSsbEjiMPyA?=
 =?us-ascii?Q?4ELIRKOJU35JAPUqHbzXF49bdhh9WuXf6jGh7RJQgF3twOAYBxz9STuQPVml?=
 =?us-ascii?Q?7FSUe7aBfSVAv8HpjIFRded7N+DOUz9ToD67pa7VtD6UAL6bYMMoG58QnLl9?=
 =?us-ascii?Q?GtIt+qdk2M/Z7W4BxnmghoBd6dpGNuNSpqqdNT53cMwPWfVpToL/PijWwTP+?=
 =?us-ascii?Q?Qzg202zePr43RDJ4oXlNzVDnyYRdBuIir9pQsiUm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fe3e8c-d431-4cce-ee08-08db6b6fd406
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 18:07:04.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VJEj4uuaIhYXnOCJfl7R1ysLq6SA8S1bbfHvGEOIBF/y2OBmowpFpMq300qk8AO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 12, 2023 at 02:48:56AM -0700, Selvin Xavier wrote:

> @@ -4002,6 +4044,13 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
>  	resp.comp_mask |= BNXT_RE_UCNTX_CMASK_HAVE_MODE;
>  	resp.mode = rdev->chip_ctx->modes.wqe_mode;
>  
> +	entry = bnxt_re_mmap_entry_insert(uctx, 0, BNXT_RE_MMAP_SH_PAGE, NULL);
> +	if (!entry) {
> +		rc = -ENOMEM;
> +		goto cfail;
> +	}
> +	uctx->shpage_mmap = &entry->rdma_entry;

How can this be called with a NULL offset return?

It seems like the offset is hardwired by userspace?

If so it should use of the insert exact offset APIs

Jason
