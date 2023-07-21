Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89175D17E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGUSqo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUSqm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 14:46:42 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACCB19AD;
        Fri, 21 Jul 2023 11:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZUckInf85/TasFil2nxD3wIOFhSIqfuAVCwcb2ZCIsKUhXn8gtlx4+tXNRSYOljs9Md2iYc9BWN6QmzNeQxLGXP0BIu8UXLHfQ9uwnoNmANwH2KO0YEC6p71mHnqR96fEfh3jHtvwKmthVJBGijgCYCcMXDZ8+sPYkKAwdfz/FFe9PbXyWvHRh8ENaPfEgetyiy1iI2aFe5z/75HWvvw21+mw9BRyf6KaTjLKcsUOLH5S5upV0qNCt2Epzni3u4AdY4Uw8n/Ms8RoQlEAB9pD1GtFVeNPSvhU+hcgXyF78AuqWO+eimnK7OuRpNsRk5Fu7zQeznxMbR1ScxmQq0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIYcMjMB89RrpnGUWuO9Bth+BVt5VDFDPmN0FhnTf6U=;
 b=jlgXBS9gwfxo+ZPrGHKMTaHSgYEz7XEBLabk9xhqx8SwLWuQK9/dAX8IuIIo7Sfi4JK3HrXbs+UDc5wkcKNBvp7KhM7mGaGgx1Ge87/hAKB9lbxzRlg/bKVruNr9V9lq1xRWK43JphynvHpqpxi5MUQkFetYCrkIMUpTNBBMKIoECLLGkUx+ZaTLPgi3PMajnMvimpE0HxywQbKXeva1S1mIbox/ohElFIZELL9BxLzHXMfsKVjxX7lGFr7vrnS1v8ILVpfGAcl9AxFPi7d3uUeTg0wBN2241t1Ypr65TnJfb08nuZ9T7ADG9s+4qt37orWUBIRgJwP8SNzxuEWhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIYcMjMB89RrpnGUWuO9Bth+BVt5VDFDPmN0FhnTf6U=;
 b=HfC0+oZw956QcssOksnyM4iV7TA0KQwShlHjL/brmX5ut5wqD9e/G511mEIgMxJftpYnsZ913RtBpx/lZHSR2FWUWt0qM2+xHdtV9Rl6rMJVv85g+DGlGX4Bgkj5yAgbL/EK9yho0WT9pTLKdgYyxtRHGyc6Kp+FuA9AvkgqABw5Xw+X73cSitaIZgzBUuCdaZh5RBaHg4pJRexmIpVKy7UzPdPFI3uLeJamrkZrveGqeskJ+aoWW8g86S6O9CZM8v1U/uViL/u6Jo0rVDsim9cfVtrukzpVGdKsurjv8o3uZXpOV6eiFDT8jkb5Kd55OajT2+di2V21qEmOLC5BLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Fri, 21 Jul
 2023 18:46:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.025; Fri, 21 Jul 2023
 18:46:39 +0000
Date:   Fri, 21 Jul 2023 15:46:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>,
        "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH for-next v5 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Message-ID: <ZLrSjWDjQLUuREqY@nvidia.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <7d8595c23e954e0fdc19b14e95da13ceef2adafd.1684397037.git.matsuda-daisuke@fujitsu.com>
 <ZIdFXfDu4IMKE+BQ@nvidia.com>
 <OS7PR01MB11804670384E92E0CAC2E5E32E539A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS7PR01MB11804670384E92E0CAC2E5E32E539A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0227.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d38d078-3457-46c5-9a62-08db8a1ad199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WED5mJ7rTIucrpVIKEBioIAuDX2IULB+3zrnFfJ8dQZiQD4jZ29TV5ennDqVv29Lv2DMsrRojoVIxlEDghxk/6PBsMkAPQi5LEFIi8ONGVvMygyXntN11Ed9ZOxkBp38dbzvLSzcNVkv6iLXm7vn9SGK5HwQiknbIkOUroJMAvoPyihyOBBMyPyL4M9dnhLzPaDNvpvW9NoXG7mXeYmhExOv5nk/DgXR8fC5fcGWVYWUAohYm2b1sqkrjpFJ9tqhMokThS9/gX4TLUZkeYaoNziYADPTjKh6mO1T3TZqO5/A0dkt3DI+EpeQOKGFewHwKBCX3WgmOwxbUWtMGs7yrLSesjTPPbuvTjyP7aUW6ZFLtF11YkdF7DvHGdjT41cf5tm8SUbYJiK41JaRDGHyHVi00ZwrtZYdaraDl3phECw5HF7EwGdnPdVoEeWw4WKyvfgaJpfQEY5hffwREkdI3MUDvpd81dz5axzRTF3xZ3q8wbp/HLyoCd7YerdED3Ps7dbeDGFDqdAfJJbNDVRBjy99EIejoKThlBwq8oNuL/YDEgRIxAQkg8Jck5wwFhWD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(54906003)(66556008)(6486002)(478600001)(36756003)(6512007)(5660300002)(2616005)(186003)(6506007)(38100700002)(41300700001)(66476007)(66946007)(8676002)(4326008)(6916009)(316002)(26005)(8936002)(83380400001)(86362001)(53546011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2V15vbVxMnBM3Hx360gEYVxcA72bWxdA073sE6KT8Ti0ZJHBpODGH8ksF/QN?=
 =?us-ascii?Q?MCNLsM+q4OpTyjnVonC9Rch5dAUHpI2eKnTHJItby44dOfRKJ2yOa72n/D8e?=
 =?us-ascii?Q?VnkTMXZqkRWbS2JcNYk63JPPR5ZT+wuhsAK1Sx3EX+kwZ0KJe9A7GWqMYkwG?=
 =?us-ascii?Q?sSaJI5g8+UhLkGo342slvKyoQyTaTAxWHno0O7ZD41lSoSyvZ3/TcFrdq8AJ?=
 =?us-ascii?Q?RJfN3mWBlQkDzCuoPQipv22hVwZdI8z52x4jSK4/LG/CeDJJ+yuC19ernsIL?=
 =?us-ascii?Q?yv8dZSmlgzevnDyICut9Nr1XYcclrRjpDBwXMpOOMT32QfZRNVqWknyRWME5?=
 =?us-ascii?Q?2yue+TNP1IC/DeT7Wq4uOB8Q9r4HKv3wtli0BHs/79ymD2JY2v9/dx8lynRO?=
 =?us-ascii?Q?WKSkKAtAavp5hCH+dESvJcg7C5wjep1vs4I6RwZ1CuXyJCqMF5FVYaEfO1Uz?=
 =?us-ascii?Q?z5+QlGF6HpG6IEmqPs9iRVRo+n+gJqr22vJwivJRzqGYPCvt7GNmqQNdlX33?=
 =?us-ascii?Q?NEt47APjt936+Yi+KW14S2/xjJI8qeZ6Hoo761UVugQbrVjBsMVNRMamiCdL?=
 =?us-ascii?Q?yo9fLK8DZ7bbeoc7DagY3BV7aXSpJhSn0/j6yBkKrz5nCMbiSjMk35TfVSv+?=
 =?us-ascii?Q?8vyEtbki3kzIOPY2niLAu3MjTP09xw8d/eolHCzGGT8mdBhPfGblt19BrF+P?=
 =?us-ascii?Q?d79tAkRDAg/qLLPIq3ZHRUjJwIibgW6xtJrNlfsxxS1lxHS6MHOsJkZLD6IF?=
 =?us-ascii?Q?tbmr8btRCgks2HD2kSYQsQFbeLGrzq9qlLupRwAoJ1otrTQg7KSnifrD0cLw?=
 =?us-ascii?Q?phM0az1dtUBPGiZUCMATR3fULqxt+vHCgGOao5CzW6fyQ7j22ItibLQKJ71i?=
 =?us-ascii?Q?k2fNb5F1ZuK3J39dY2aLGNNDny9lx2d/FFXuPXQMxmQ14h8RViR+ykce7lJt?=
 =?us-ascii?Q?g+a2fB+W2kX1sFwtr2rOY6VX8HZr9Q8co1dG/fAu8YiQ0HzWMgAiJBqWqbEB?=
 =?us-ascii?Q?1LfSgWpcDShMeXpHgzMNqHUof12kowgGfs1f6NMYmE/yh7AMMUvPDi8cKOBI?=
 =?us-ascii?Q?EdMNsGhItrGzuKHYXe6zBgutYRU7wAA+1DrzLisboH+kGTjcEXBg6yYMdD1d?=
 =?us-ascii?Q?ho3Wq7PyMmt+rD/LsRSpJb/E90I7alpuGoBBTBoF2NBB2PfmntnpuLC3uef+?=
 =?us-ascii?Q?AVIFP2lSzokOaiD3IlVELICm5ghEmwkyzd0RBq5oWPR6Ms5n+EYjwjkwz+HV?=
 =?us-ascii?Q?B6P305s6tbVXea3JXADY6mbvMffBSSTeMXRYhuwK3UplipZH6nd60CEVDn2u?=
 =?us-ascii?Q?74rDgdMjiLTBYw9AEdETDaxgF15IfiGpKfl+SlA5Z0/71fTctlu6dVjQrNN6?=
 =?us-ascii?Q?NurG7bTmHH6lLQHYqQfJY05/AV1kNoogYrYCE7SoOiQ9Fzrd1fRZQ3Yqxl7p?=
 =?us-ascii?Q?CbjLZaUvc/gE3bTS1GXYmIo1i9i4Zfr6BTjI3ceTloK9piDrqwMCqqtjvV0O?=
 =?us-ascii?Q?72s1T0zaoIEjuds7sBOZWxHoYeEEdEip2a43iM4rvw8PpDxwoWXsl4eWZ6IJ?=
 =?us-ascii?Q?AE5NngziJPt+JMDYfhtCxHR1Hz3axa84YsLvAJmJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d38d078-3457-46c5-9a62-08db8a1ad199
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 18:46:39.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yIK1JRw6C/IYzWX6vm6eyHUWxviKauwYBk75Met7/81Y4aC6dWANwUfZ1GQgeST
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 19, 2023 at 06:00:50AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> On Tue, June 13, 2023 1:19 AM Jason Gunthorpe wrote:
> 
> Sorry for my long silence.
> I must spend most of my time for other works these days,
> but I am still willing to complete this and subsequent works.
> 
> > 
> > On Thu, May 18, 2023 at 05:21:50PM +0900, Daisuke Matsuda wrote:
> > 
> > > +static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
> > > +			      unsigned long end, unsigned long *pfn_list)
> > > +{
> > > +	unsigned long lower, upper, idx;
> > > +	struct page *page;
> > > +
> > > +	lower = rxe_mr_iova_to_index(mr, start);
> > > +	upper = rxe_mr_iova_to_index(mr, end);
> > > +
> > > +	/* make pages visible in xarray. no sleep while taking the lock */
> > > +	spin_lock(&mr->page_list.xa_lock);
> > > +	for (idx = lower; idx <= upper; idx++) {
> > > +		page = hmm_pfn_to_page(pfn_list[idx]);
> > > +		__xa_store(&mr->page_list, idx, page, GFP_ATOMIC);
> > 
> > All of these loops can be performance improved a lot by using xas
> > loops
> 
> Well, do you mean I should use 'xas_for_each()' here?
> That is the same 'for-loop' after all, so performance may not be improved.
> Additionally, the 'idx' value above must be counted separately in that case.

xa_store is O(n log(n)), xas_store()/xas_next() more like O(n) per
store operation.

Jason
