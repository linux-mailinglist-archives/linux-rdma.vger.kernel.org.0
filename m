Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF6D66E146
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 15:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAQOtw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 09:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjAQOtr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 09:49:47 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C2F3EFFD
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 06:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE5T0+J0ftDsdGHbtvnSqE/HamhI4sDhf0DiuHnpnFSS/xeKVBgxIAvDwpmfSUhC2549LaFqXDH2CLYbIVfV8qjfUSKS0CAtCqrI1WHEv7SVErPC6D0orRc/DtEXydN+Slk6kWhUtcNXNPGqz5snhIB2YhIML6hs12i45Js37y9pCTaxOtDGBXZaSlFpWUXWnfXPPNf3wrh2IeNmf+VjIL+WY5PHnpR/zGDZAiYTjj74Dvxv2NkM9ViX0FWr9v/S/x8WeVPBkpybWy1yKJ46pfK5yIpcDOAOLQ5zcXk3reA6SwwcPygXljQjb9mJtfrbE1YR94Pkq0OWOJ4mfe2HYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ+YFIIpjCQW9hq8Idnlm/ePK/7HA5GW6gIxjuuUQP8=;
 b=PAcCzYtIthIx8otG1Qijo0m2W30sshcQCoYCuzVDuzMJvd4tGiB9YPxNhwIE/vS5edbOsAe0Wz6kNdqJ3QSx6PY2f9GUeS+aOveb6iZ9jxtioUpCVl9SqPNZT1BDUafZ+zZrHd4JxBrxYihYjMEof4/cko5Cht3FSgw11pSYJltXW296RIEp4EMHcU79XLO+4i6gpD0Yu1dv2tcmLGf/3LC/DITX7jKdq8ojI8xCnb5kycDbKHMSbtLY/h4GaAVfpK+38h2eoRw37dNVC2xmPa10a02pDGPoz761eGCWyvJ1ceqSzQ52EUd3uBHOIrFA3gQcPAi8Rf/F6rrxpPowew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ+YFIIpjCQW9hq8Idnlm/ePK/7HA5GW6gIxjuuUQP8=;
 b=VSYQyPeCwclYY5Oc/3ONQfXHSrWUpnJiJwIsbtktcjaXeZedgBnGLHnvEVpiygXrSbU+IqcTSjAG1TFvOD1Fvcxy+JzMET3mgEYZkeWEiI770om6+aUr+ranrg8OuJaDaJCasjgTNvHzuUHC8obT0Ya4XVMBeIt0GPTZ6f8SzD5JvXmUOZTsFT0Ga6zqISaDx/ylaJEOkr+1yNoO8S8auWf91C6taiJDLyVY/yzJnTbVkUBzV/x6GlEjmAflkL+6gIDGyN4gjFniWZDxhcsWj6Pbax8LyN6XDCoMqVygZuCgDCFzrIrND5rdllp3YbC6NBAvTWzTcx3gHs41lxPLGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 14:49:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 14:49:45 +0000
Date:   Tue, 17 Jan 2023 10:49:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        aharonl@nvidia.com
Subject: Re: [PATCH v4 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
Message-ID: <Y8a1iHmFzZL50lYD@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
 <20230115133454.29000-3-michaelgur@nvidia.com>
 <Y8WCetXDkjH3Au1W@nvidia.com>
 <5b3e0314-5e60-eb4b-9fcf-7a4e6061eeaf@nvidia.com>
 <Y8Xhg5OY6sJDXfm6@nvidia.com>
 <04b75e85-dcc4-b012-06e3-77a298a7d0e2@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b75e85-dcc4-b012-06e3-77a298a7d0e2@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c766a1-990f-4e13-1e90-08daf89a12ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJYTURFGatnnh0sR0/HRrUqhcMPaI+rkiBzF13DiK24JlACwJ40PnNQ8+Drqn9wll3AYaYN7sZ+xwVHSgqU8mT2uanKvaG/ezh27CODUA9sUmMqqPEvS2gQla4kIeA3xD6z/kKOHCuTI5SgM15s4g1BlDaz/JGmOdtnVpE4eoNhH4rPezyPTivQ4K8qk3kEk7WxclPOpdoguYX8yMc1wnhXz6dkUX+j0sx180I5wCzUTLz6jUHAbF7ksmXACMQH+Mx+aFUOIuXu9IcFj+9qAHo6SMrdBVIwn3XUqkHMWm4BJJABooCHGLaBQeWWrkg8MC24p4H0FugmIzO6Rik752SGXxdhov+kHhcrJyWZeBWkpaSEoa3d3rBXMDaK8Dqjk9msAjY9mO9BsEsbnjlOXRvVXmABJvavPjCxY+Fqyq1C5IllLl/AjNKROqDycaDtRqDxYy3nlQkoXXl/+NauOgbme03RpLlPEyriTTQO2SPolyVcJRTwMnchtF8WQOpKHoREpdEBD18wbz1Ru0FdCEZMlPH8MX+RmbOLCpWG40cMSGJUNs83D8JRfJGiaXqpxhXDaLtd4QwP7c9Q1kyWACwZDrXI5kqr1x8YQYf/dcWlUlVBSrH2QVGX28eqXfVoZFBtaT9JjBjeRl+wu/vhUNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199015)(38100700002)(86362001)(66946007)(6636002)(8676002)(107886003)(66476007)(41300700001)(66556008)(83380400001)(4326008)(5660300002)(2906002)(8936002)(478600001)(316002)(53546011)(6862004)(2616005)(37006003)(6512007)(6506007)(26005)(6486002)(186003)(66899015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kf3FS6ikJpUozIGbxBSFCRDEf/LcaBSp6TgcHLF5sg/+causESbFyG6oXrvl?=
 =?us-ascii?Q?Klo6mFGOkq+5f7lgrwfptT0teksNvQXIXIpxatoA+gRIP94+Kuf2UM5vOwYk?=
 =?us-ascii?Q?fdwfxolNJdHxyLHSLPS5WUviNnTmT2yDd9zZlv6bTV6aL2KqzVCV2pPrNXkX?=
 =?us-ascii?Q?pRlCX/PhDGvvuInHwjJK8/SbC6qcLxE1mVAgW9zlnDu22xgC7FoK/Y41vH4P?=
 =?us-ascii?Q?Dnrxrn+KiWFnRToOu28UK9J8kH7cYDschiWgyADxQJckwzuTdpU48cIH80Kd?=
 =?us-ascii?Q?+4Zs3biMKsOJ5zsMbeBQln4DA/kzXVGr8w3Acig2aLu+GPOWiFP4fNfaHaEP?=
 =?us-ascii?Q?n6aVm0ntRJzqhgw9ffEuhnF+WXu7ALUPH0fLYaD4X4PAEuhJEWGcE33Sgijm?=
 =?us-ascii?Q?XOZoJbNVbdNHxxylm3JEBPrW0LPd23nDXAl/HFF+dq15qcDsreMvLacKjX1T?=
 =?us-ascii?Q?Qf8CnAc48ENvdFHGAkxsBcLMkANyQ0Qr3a2NVnentXIdLZi7RXZRPl/liLiJ?=
 =?us-ascii?Q?m4Q3L3Zv1pcp6Al9PbSHrw8pRRWHWPui5avLHyGsZ0SJWrrGsMyi/Y6L/eni?=
 =?us-ascii?Q?cb2+AT5mEVmfn+aAsT1XWMDXht7WA6KqSKgiE6zZ0yomZbqHi54bbtszhoo3?=
 =?us-ascii?Q?Hm7XXHNgmVpFJ89ywNQ5LmaP3HH8doH6zohUEyNrjVvWxakfthOWfgPwPqea?=
 =?us-ascii?Q?aV/sHV6DKCh2snSxLtr3XeSCI4FHvYUFdzaYTLC7Y7vHnZ4looSPwHQSDQsV?=
 =?us-ascii?Q?mRM10vkmh/iFCl75+UBWtYh+xuY2Z6WFxA3I5TvBtAfpOjvf101LFwCuhSAR?=
 =?us-ascii?Q?BgCQlJi///L2sKCyIwFV29wTHKJKjWkOABbmAHPr3ZFpKCL05vAj1boRfR9w?=
 =?us-ascii?Q?AkIlKZCTxI3mc2JdnrK9I2pq7+xQPZYGXp+lKPYprkndXDGDQOtEy2W76cI+?=
 =?us-ascii?Q?qbOAZcXnr2S6VN/dcwkisAHV/quoLyfMBCj7kuW7PmEnStmyh+d6qyB6sigG?=
 =?us-ascii?Q?oihyoFgudLZO3FweIxh5kB70xXeo7KrtKGoBGthLB0FccaJN2WUxB2BWLRz/?=
 =?us-ascii?Q?fQJn7rFY6QG0H+G3A/uOiWUoQqwZpGsRxbAmoFFgz8CHRqfo5Q0FRGw5zR5N?=
 =?us-ascii?Q?g0jJer/or2DYNLNXq8pxOYXHfkLcZp0JWnE7SlTsFIbkk5aUsdCpe3YRb/0W?=
 =?us-ascii?Q?iPDkd4hts/WNDvmE8DFRceKmOfQQOTsTEnDyJtbKYDAHFYed6x1QSwdxi00D?=
 =?us-ascii?Q?Ty94ADtx1HUOX4rgnMgYgSUrMeOmkrrHagOisibMkw5oO/d141V6HrvanLxk?=
 =?us-ascii?Q?w4ESb1BdtHBarGnxU+APg1qxZmwNfoxA5gJ61iFAxALAReegbD2uGNlheXqg?=
 =?us-ascii?Q?ksjO8lq7ZPrEr9DnIrgUQEM0Xd6dz539y9sv0PmPI+34hFoO+MuJZC0MKRdR?=
 =?us-ascii?Q?bvgVTFh5pRYm4jTLfnT3tFbEPdPy2TrUpJmw3ye/1j/pkhUwmnKojjAN/7K8?=
 =?us-ascii?Q?MoVNoQXi6Yyn4eTtpKS9p/ohJA0TJP+aBqkkUbV7vQ8TEVicIuXwEx/qpz6/?=
 =?us-ascii?Q?GHhyGVO98d4UpiLikNF1C+O4S/O/b9DDZA7Z+SzE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c766a1-990f-4e13-1e90-08daf89a12ce
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 14:49:45.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1gaHKjOr2PNlBJUfES42yyopEmYY7sXm6FnUJvzEDMpVDxufyetHWaMDPDMfqSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 02:08:35AM +0200, Michael Guralnik wrote:
> 
> On 1/17/2023 1:45 AM, Jason Gunthorpe wrote:
> > On Tue, Jan 17, 2023 at 01:24:34AM +0200, Michael Guralnik wrote:
> > > On 1/16/2023 6:59 PM, Jason Gunthorpe wrote:
> > > > On Sun, Jan 15, 2023 at 03:34:50PM +0200, Michael Guralnik wrote:
> > > > > From: Aharon Landau <aharonl@nvidia.com>
> > > > > 
> > > > > Explicit ODP mkey doesn't have unique properties. It shares the same
> > > > > properties as the order 18 cache entry. There is no need to devote a special
> > > > > entry for that.
> > > > IMR is "implicit mr" for implicit ODP, the commit message is wrong
> > > Yes. I'll change to: "IMR MTT mkeys don't have unique properties..."
> > > 
> > > > > @@ -1591,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
> > > > >    {
> > > > >    	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
> > > > >    		return;
> > > > > -
> > > > > -	switch (ent->order - 2) {
> > > > > -	case MLX5_IMR_MTT_CACHE_ENTRY:
> > > > > -		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
> > > > > -		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
> > > > > -		ent->limit = 0;
> > > > > -		break;
> > > > > -
> > > > > -	case MLX5_IMR_KSM_CACHE_ENTRY:
> > > > > -		ent->ndescs = mlx5_imr_ksm_entries;
> > > > > -		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> > > > > -		ent->limit = 0;
> > > > > -		break;
> > > > > -	}
> > > > > +	ent->ndescs = mlx5_imr_ksm_entries;
> > > > > +	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> > > > And you didn't answer my question, is this URMable?
> > > Yes, we can UMR between access modes.
> > > > Because I don't quite understand how this can work at this point, for
> > > > lower orders the access_mode is assumed to be MTT, a KLM cannot be put
> > > > in a low order entry at this point.
> > > In our current code, the only non-MTT mkeys using the cache are the IMR KSM
> > > that this patch doesn't change.
> > It does change it, the isolation between the special IMR and the
> > normal MTT order is removed right here.
> > 
> > Now it is broken
> 
> How do IMR MTT mkeys sharing a cache entry with other MTT mkeys break
> anything?

Oh, I read it wrong, this is still keeping the high order
MLX5_IMR_KSM_CACHE_ENTRY

> > > > Ideally you'd teach UMR to switch between MTT/KSM and then the cache
> > > > is fine, size the amount of space required based on the number of
> > > > bytes in the memory.
> > > Agreed, access_mode and ndescs can be dropped from the rb_key that this
> > > series introduces and instead we'll add the size of the descriptors as a
> > > cache entry property.
> > > Doing this will reduce number of entries in the RB tree but will add
> > > complexity to the dereg and rereg flows .
> > Not really, you just always set the access mode in the UMR like
> > everything else.
> > 
> > Jason
> 
> ok, I'll give this a second look. if it's really only this, I can probably
> push this quickly.
> BTW, this will mean that IMR KSM mkeys will also share an entry with other
> MTT mkeys

That would be perfect, you should definately do it

But it seems there is not an issue here, so a followup is OK

Jason
