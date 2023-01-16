Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F566D348
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjAPXpM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjAPXpL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:45:11 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB15A5EA
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:45:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyLv7ks3vYdVtXaTsUhFHy8cYGiHr9S0N5bvLgslOcbrOzPE7mP6sSdfZ73PpyLxwjE4jOzO5zZe4SxexS3nllFLN40SKrJwstDznuivf8WhKbU9PWdjkYJMVB3BLHpx+QZZOtdvMIsjPf3FEVQi9TzH/M5OacEc2KcYEB8PToAI9NO4AmHoPzY5mGzuhKwjN4gPmh0axx+8EC+lR17jc2pigfmFbXXM06/PojSVKJW/ZjGlcF5rVXEWft7U0crfMmvfGuhJ8DkL1ZCYaEtPAWR3x2Dwwp6SRC7VEE3hO6dRzvSK/CGm97oAXiGTvOEoqWaI9jt5RjCPm65U2V1XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hKpruwuUw/NPx+VDoTPdbks/XiPveqF9BSzb8fRUeg=;
 b=O1xolv2Z044dtEy9sHAqjWhz87eaDE8ZKiQJ+CGgJ87RPQmFG82IiSJDS62fw/FxXMqceebocGLy+BKbrokEPJOgbsWA5ZhPI5kDaDKOmXLqGaGuC37X9wtt9rV2tPocTNuRI0D8Tc+tl+jQQbGJUBdhEIX9/gapLPxHiQcDoXkE0E0/6BqyNBEcQM8J3y3ZF7lvFK+7j3whyyIUcaVg50vf0jbrPFwdNVCpDnbH96IycDH0v8joSZs1NUBNjgqgSf6HLInmWSyqAmmtVSkEppQeokq+lD7tkQb+Ju22bQoIIsncWrQomVDKMkI0jZqk6/5PSqOPH+V1zOpzDvXzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hKpruwuUw/NPx+VDoTPdbks/XiPveqF9BSzb8fRUeg=;
 b=OeaWbpFUjX1OdXr3/RHFJkBgKD4MB0yyeMqnvQxFuj0KbgD56sIKqsdVU69L5Zi3Z6ne5JTsQZyQWJyxKs8vzLVr47IpGr/1TV4R5NKw0OEb47jr/rhZg66aqNUDL6VCGAmPfVstzfgwkhfn0TJybvW9W19EOGHh5Ds0NQqHBP50MWrFxVylO1CIs5NN4y5TrbILl2VVZODqVj/5xbBMI9rbvHGUFs2huUnHlX9D5n9mj9UuSKHTeA4YoWgbwmPcdYcX8ZBqnKTmUtbNEhz6ljyMlQd/AD9Q6ntkB255PM0QnIEj5hhorqtFH0l4JOP0L2lXC2c0AtmM/y6sekuAEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Mon, 16 Jan
 2023 23:45:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 23:45:08 +0000
Date:   Mon, 16 Jan 2023 19:45:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Guralnik <michaelgur@nvidia.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org, maorg@nvidia.com,
        aharonl@nvidia.com
Subject: Re: [PATCH v4 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache
 entry
Message-ID: <Y8Xhg5OY6sJDXfm6@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
 <20230115133454.29000-3-michaelgur@nvidia.com>
 <Y8WCetXDkjH3Au1W@nvidia.com>
 <5b3e0314-5e60-eb4b-9fcf-7a4e6061eeaf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b3e0314-5e60-eb4b-9fcf-7a4e6061eeaf@nvidia.com>
X-ClientProxiedBy: MN2PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:fc::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: ab277118-b410-4d5f-8029-08daf81bb35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+sN1PuvylkjWoqUhh9q6lIUW4mi986cep/ivEw/MBH9McsMJMd1lhaOevjVW+fi1CsQM85JPLpNd/ctZK6eUOSHTCuj8GpY+2436wyIXizHnZM7ZkI/reeb2DCnClUJb2pcXi7v7dtlOIyBrImr9ya2uVrwRsqYcrwmTp52abVpeczsmko624OsyesBjUEm4ghQWt+9LS1wMz9f5bNXDVtSWn2ZK1ha3WuvOE7SEsAyy6W0LPBqJLSvMJ4GPCEm0p0KUzNrlPoriud84XLsdwbTRypDP772kmjrh1x6j4PpJJ2tG7ffN3DYdSTQ/jakTlZSNTxHD7i8/YrRTrB+2m5arHWCwouXkGgajWdmn/2qR/D4pzZbBEQ3gFoa3cawvnYHr+F1zV5aD3d+ZhbGCUdWmzxKxSN0Rs7PO35a2FbiiSkJZdUrNakkbcEGu0c8Ak6HeGrzY8q1igCGtN0AH+1bE6aVwmy7fdgPi6kzP1MTrZ+tLtH3Hrz5WcWdblmOIjhrqdkyiUCa15xJXI9pjJ+SMqXENZH+gtffjiPtTm8qB6OJUBGJBMOyfi5L7RpMgo86IL5hlWM5fzoT2i9delSTHNJCkrBepvV/2lUmEW7r/npwBnx1W1JZG7zSEdHxc9c32938dAnBycWs0QN/yGvAOeoG8DPaQOMuHmCguDwqUxosnuFWyuSbzZQBrrtG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199015)(6636002)(316002)(37006003)(41300700001)(66476007)(66556008)(4326008)(36756003)(8676002)(66946007)(86362001)(83380400001)(38100700002)(478600001)(107886003)(6486002)(6512007)(6506007)(2616005)(53546011)(26005)(186003)(2906002)(66899015)(5660300002)(8936002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ixwk6Cx4xdup0lVvL8aLpLMDOju8Qj8dYLym6UWIP/wwZwBJV6/GiczIofzH?=
 =?us-ascii?Q?QNRyl5w8uL7Z+8nUqZ4rC6ra7EVvy0cotkhC92lZ1FtG4yqtskLahgeTii3u?=
 =?us-ascii?Q?gDsvlUbyqSKjrNquvjWSN0e4/pjDHPi71zdbanhb1d+NVoaRrIfjhD1K3sXx?=
 =?us-ascii?Q?Q96M3Q6f1tPWPsgLYpAS45EeNM1NBWNvuBTP+9hWX92clAn/IcH1rarUfIhW?=
 =?us-ascii?Q?meDpKZ4BzeoNOR6LLyqVldLzDwHrML0O6KWv0h6kh97FG/JL+uoeS+6TM7S6?=
 =?us-ascii?Q?/gBjGwyXJ3w2fx8V1iBS3PPyie/J1v1lhDsVFy4PQA0AZ8EyoniCikyYQTF/?=
 =?us-ascii?Q?C5S/p5abXQ8fmK8spYF7jp3uNl7xs+PF7UbKYgbf2jtLOq24OKPcrvn/ERpG?=
 =?us-ascii?Q?ZsvtqFHndS2huoO1bE7qTFZVYsoRQtS9uocVtvg5gB2ODw0H5CDBkyl7HgMl?=
 =?us-ascii?Q?+U2vSFfygLoH1pmlFcDqKyvinWX+EuHZYT8Hp2UyrZ3F9dO/ITQyNTLEm+Tz?=
 =?us-ascii?Q?zqM22RzKduGXFFwzfOQuHAPxel8hDuu4/2PVoJ08/XK/n1tE85J3yhfXqpJJ?=
 =?us-ascii?Q?tiwd5sIJIer83hNNRBquNveUGsAyHO5++0wFBBck8lhStFair2fEGVyHzOve?=
 =?us-ascii?Q?OlxD1XQ0bxQw6kVjt7hxQex93R0to+sBfEsKpzflezxRKV8aNhuxEFAwgy8n?=
 =?us-ascii?Q?pRiMI0Li7ibGFJOhw+l8gn5PHqMoPrDc+9rTkVAh7CWmjkhIAnWcDXLr6TXG?=
 =?us-ascii?Q?xf2I/nIRd1jm8UwFAM6rd0BAXSEfDyfh9wldBS4Rt1K5KeNyej9pcP/K9mXY?=
 =?us-ascii?Q?4lXqytvy7VNylWIDfaVH5vlKSITR/cxpKpmtBHaGDi7jdbBgRdM8dAhpkbsX?=
 =?us-ascii?Q?w1M7zwqjDyezUhLim/Omj7038VDChRFhr8DSNPIQGQlqIxrug0nG1dP++z7+?=
 =?us-ascii?Q?4iCwkxBU5fMfbJp0EMd+dAl9Z8/MQPzO+V398+ardcVbhSP2Q6Xb7YM1cYY8?=
 =?us-ascii?Q?80FS7NJGOOTtkP4qv8RDI3xInl6onYNGCwv9yaYVKEzl8PXG4Zvc8LDB0S0k?=
 =?us-ascii?Q?HHwTX7l17Q1jube5pNTzZSjmrtdWoL/8lXAxnZdsxdhBskU8JKDJz72OuGnY?=
 =?us-ascii?Q?qyRw0jqF31BqkEg/QRp2RRgK4vthD372PRjWXiT8ygyKWqs9xVDXq1BKtmUd?=
 =?us-ascii?Q?/fmQ/7xsrZWkvp5sUJM/46b1X+VE5hSaQBY8VJsoepb59FxkChrLP6zRixET?=
 =?us-ascii?Q?n0XsMwTfyorkIzu66BMLGJGgO1UzDF5wrGKAOPXqxKnrDktzxSEOCC8K3mIZ?=
 =?us-ascii?Q?smI4ZAPXmdfgF7ZWKtoyNPAtk6ko4uLGT1J1baza2BS8uNR7+z99pJlQ+tc5?=
 =?us-ascii?Q?/q0w1zMtNnAv2ry7PvNZGXYHGqdA1m4ASrH6eSt2xne24pF4R4qSlAkV0q1j?=
 =?us-ascii?Q?jeDgYFx22kcCKyX9V2lbN6ubcficbyWLz17Prd8YeEOb0GP+MY0K6B29u2Rr?=
 =?us-ascii?Q?6GtDHtoMCPxUqu0Jfpxq1rVas85u5kfwRY5r/MJFN3n/F4MR7ehooKK3/z5J?=
 =?us-ascii?Q?eHvicQAvED2gD2Z/bjCDGf8LlMHJwwndkgChcWYY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab277118-b410-4d5f-8029-08daf81bb35c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 23:45:08.4586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmPKaUqBBNAxHI8GRwbrblcggFWZ3u0cJD7KnEGNjJMUgXt36lYtudYPJwPx9GAp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 17, 2023 at 01:24:34AM +0200, Michael Guralnik wrote:
> 
> On 1/16/2023 6:59 PM, Jason Gunthorpe wrote:
> > On Sun, Jan 15, 2023 at 03:34:50PM +0200, Michael Guralnik wrote:
> > > From: Aharon Landau <aharonl@nvidia.com>
> > > 
> > > Explicit ODP mkey doesn't have unique properties. It shares the same
> > > properties as the order 18 cache entry. There is no need to devote a special
> > > entry for that.
> > IMR is "implicit mr" for implicit ODP, the commit message is wrong
> 
> Yes. I'll change to: "IMR MTT mkeys don't have unique properties..."
> 
> > > @@ -1591,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
> > >   {
> > >   	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
> > >   		return;
> > > -
> > > -	switch (ent->order - 2) {
> > > -	case MLX5_IMR_MTT_CACHE_ENTRY:
> > > -		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
> > > -		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
> > > -		ent->limit = 0;
> > > -		break;
> > > -
> > > -	case MLX5_IMR_KSM_CACHE_ENTRY:
> > > -		ent->ndescs = mlx5_imr_ksm_entries;
> > > -		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> > > -		ent->limit = 0;
> > > -		break;
> > > -	}
> > > +	ent->ndescs = mlx5_imr_ksm_entries;
> > > +	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
> > And you didn't answer my question, is this URMable?
> Yes, we can UMR between access modes.
> > Because I don't quite understand how this can work at this point, for
> > lower orders the access_mode is assumed to be MTT, a KLM cannot be put
> > in a low order entry at this point.
> 
> In our current code, the only non-MTT mkeys using the cache are the IMR KSM
> that this patch doesn't change.

It does change it, the isolation between the special IMR and the
normal MTT order is removed right here.

Now it is broken

> > Ideally you'd teach UMR to switch between MTT/KSM and then the cache
> > is fine, size the amount of space required based on the number of
> > bytes in the memory.

> Agreed, access_mode and ndescs can be dropped from the rb_key that this
> series introduces and instead we'll add the size of the descriptors as a
> cache entry property.
> Doing this will reduce number of entries in the RB tree but will add
> complexity to the dereg and rereg flows .

Not really, you just always set the access mode in the UMR like
everything else.

Jason
