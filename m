Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46F443A277
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhJYTtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 15:49:22 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:15001
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236259AbhJYToY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 15:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOHl4fhxzEHteGhz3S26nxsfLvuywRq2ss8awjsv/y30w0FC5i2/qbghIh0C6GE7suPHiN9gDgn6ey9uMdxpCvDTMHKNdVYh/J82v37VhLrYteVhsZSdw+bjCs6N8WFl2N/1hGv/R09TpYytXhhF/irlTe8XsaAjmm4t9RE6yHS6OVyUd8jjzDLsmpc5Jg4m7EX5Oa9eHDMZchjrl4EDV8SuL3/baFaggTzECGyfo5GHdRXvPs1vcIPZyDPTKpkRtECiDjmjfSCA3fTY6DZ9RlN8y00hsUc/ucwQwA+/kLnhx5RWkOGdxKiscKRqpOKW+CJBJ4918CKdHpmA4qi09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLtg0FjADaT5DlsUpcfsaJhAfbtct6anQhmdKxaxagg=;
 b=DeutoSdF6v1mKziiSjvQ0br8EdVY5DG2GpX+xYLaysEDR1WKXIsSTe4o0tuAVdW+lDdW2/483cWgq9y0RYjamll+GqhOO39CGXkdgqK63GlB6I6IVnyw98pdTq/tbVNKGOeokO8xwgs6FIZzw5TWq+Zuxb3zX7LOppBXzAU2XxcK4alIdJS+gUV1apK3GE3J2biAMOijM6lOxYFNvXhnrGgBrqlm4hwwwrgqUPx9P5Mp0RANmowg1WtNT+lnqgH70SK3UjymxkgQbSltLAB9mFxmT13BEt61FjmblXlnt+dnhMma5UANsFJxab4rS9IkvWm2e/NL+63gPQQH+cj4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLtg0FjADaT5DlsUpcfsaJhAfbtct6anQhmdKxaxagg=;
 b=e3P5akuoP7cZqqkaaczcPMgxN2Xb+mhJBYBs3FF+ZotKAKNcURiDYvgPUoC8T2wBMENCNWvjlsRryARTSWWYmI1hAfoP51oqudXA17++E1eVRNlzK/DANgWWbPaSkValHq8GNk4fR23uH6KNoCxPfT+Ajo9yCF+vxbkqSHgPwHRsmXSBgfD5CBGHLFcDnI6IwKzxFtXPTxmtetRIu2qLmdz//Kh4Z4Gbd1uc8Yt5+uN/smNI21yg4mhggDozdB6muEvtOgQRGrv4xrCAsR/pOsXddoJXc8tnscEaq8YzB+Em3iyLNfAQx7LYzO7/zxgfBscEtORlFlmW7yCwOYOwHQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 19:41:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 19:41:59 +0000
Date:   Mon, 25 Oct 2021 16:41:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robert Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v3 01/10] RDMA/rxe: Make rxe_alloc() take pool
 lock
Message-ID: <20211025194156.GC2744544@nvidia.com>
References: <20211022191824.18307-1-rpearsonhpe@gmail.com>
 <20211022191824.18307-2-rpearsonhpe@gmail.com>
 <20211025175540.GA433125@nvidia.com>
 <CAFc_bgYLp9dF+60w4pe9Pph2N20N+bx_ChsVsMPy+ynkWC3bxw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFc_bgYLp9dF+60w4pe9Pph2N20N+bx_ChsVsMPy+ynkWC3bxw@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0085.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR13CA0085.namprd13.prod.outlook.com (2603:10b6:a03:2c4::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend Transport; Mon, 25 Oct 2021 19:41:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf5r2-001rTN-1u; Mon, 25 Oct 2021 16:41:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be291d2a-5ad4-4126-2b16-08d997ef8277
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255C7B39E44C95C10F92C1BC2839@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVYSUxRSattrXFR+OTuA8zulgM8kyGVVOAipgKRr7nGiFu1LuRGdqPwsrIzDSsDw+sryEvQpKZTXo6kf3ujwqdCuay2SCRTMEtVsZi0X56VpokHJWENnTit59wwb+h2jDYkp9H/txAQ5hFoIAABmO+nL39S7GwRxliLHkHlUTLMoXrdj3p09Z9HYewzi+q25Wm+9IrhX7agwY5U0vo+z1WmZZhd+b+YxzS5yEB3LuSet4lVujtqQTfSbIX1jMxYJLQlcBVIMrCUGrRsbk8vQ1vEdHSz9k2OidYbyaTqyC1RC9PqtNAxFLwu9ZD400iMkt29IdBfOxTBg/1uLw+yZG7ucAPTPFPIN/bgOrWCPLG7NEd/Hl6wD3CFkzyZf+yozvMNDo+Yz+ZB35tckqPhRoH24fGArdRyR2h1GjGeiQkQyCcHsy7gwZQe4K+Hi9O0v+XSir/RJY5lvs/2OKpGgAek0cafTOrA5CYgdp3l+BLjC7iSsOoedGyH2qZ5WcspFKM0OAXoSSbLnl4SLWFDw+MzEYOxurvtpfF5y78eKIT6TlqcJlJfStllTuooDJS+Z584tsn4z4m7DerHrqCHHTZPqVF2OH97zN9/Wz+cuJaR0Ib+1m7kuQMZQ/gfeirL4DI8pwH4HjdkpLbE46kr1bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(316002)(83380400001)(38100700002)(86362001)(4744005)(8936002)(9746002)(5660300002)(36756003)(9786002)(508600001)(2616005)(426003)(26005)(54906003)(1076003)(4326008)(66476007)(2906002)(66946007)(186003)(66556008)(6916009)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwuNZRHi1DxutTLdiMTt6i1FRh2dKv+KoFnvy0J2zzK4c6B1zsXVTyBMzkIE?=
 =?us-ascii?Q?u/1b2vAch3CRZXilmMhY7ANl44gtMnaBRUfgVCCTju0n23QwmXLL9V2U15u5?=
 =?us-ascii?Q?tHJY7Et37YEZh4cklf58W9+jCZdF2gJPt3xumhrI8TsIZWYggmsnWz0zNNpI?=
 =?us-ascii?Q?4Y3YJNOLBGNGdLKw5PISpRKbOBiKvZg9wxpyhnnzaSVplKMRpU4bFbMLFOk8?=
 =?us-ascii?Q?TqUTPw8gDPMResNj6oxIJGNA98eB01gVRx73DVja3/SS+AOnyXA8VfEjCTLT?=
 =?us-ascii?Q?Ho5NfRsl1HLdb11wj6fOEkxG0cnbi2Ewx3SYUieOMyrZvVRkfoHcv52vdRq+?=
 =?us-ascii?Q?fVfa0dob3HHE2ze0aw8w/bGI0mrrdGu2Hltg/fgKIjtYVPC6+3MBF6z+1C8z?=
 =?us-ascii?Q?dkkk/miqoeW3bFQpZrN2u4dntwBx6yT7j43X+1UCQFVzR5wJn1EnboEgBWrB?=
 =?us-ascii?Q?6mvaLbcXz0yvYjqLuIFtsL+LUob1C3XoNtkjBwzcyeiKgHbDQ+hR2fdxXk7z?=
 =?us-ascii?Q?cuuQav7hPEBdKylQcPihu1FZZqBbI+MecNEo2xfioTfbkG7TTs0eLtqjmg1U?=
 =?us-ascii?Q?s3yDlKkZh1FcdSI0OLyddmixWpoCQw0O6jwHCSWyeZHzLt2vwUq82kZpTpg3?=
 =?us-ascii?Q?oFXc8mIkl7ko01q95NUyvR4vK1MStwerd5y0BAVwMZBceJUUoRxgGeQIJCMJ?=
 =?us-ascii?Q?dXJfXdwtwQYBqhDZcPBeTFbPRQt3SWoVZ+LulTk58wUxGEQh3zMrHt3/Fppf?=
 =?us-ascii?Q?PY0Nrr0tzWreiXZxQ9A+8A3CaqSxV2HW9Wf5994FBo5HV6Hl0Zt65d0FHDU2?=
 =?us-ascii?Q?yqDxxUtBrcJ0+hSIBgfz1hsGjCyiYT5qWPnupAABAgYhk89EWn8G3Cy7WJ2T?=
 =?us-ascii?Q?oPi3TJFAE9Hg1+wxDDsJV/myRZhQ5eiRywujd/BOiPw1vN36DV2wGt7vwpoZ?=
 =?us-ascii?Q?m4pGzQ1LHSeARIiAqEl8yzoydN2eX77IshP5DWmMk4UQzeiE5YE2DlBfxk99?=
 =?us-ascii?Q?cGOsGSeVy8ZcSAMLrZoZLnkw0jGWn+eZbzwyA1MMRZDOCRqV+tL2g0YQMfUR?=
 =?us-ascii?Q?uAMREmNOPRTpuTS+C7/j3G35gHhHlYokjBrR5K61GWY8mGTOWViyOrUjTkxj?=
 =?us-ascii?Q?ekz+8g6TrmS0I+1ylYkKpQf7VR/nDKLom42zd2erlo7dRS57wfdUc7xolWiZ?=
 =?us-ascii?Q?soXgDdZ+YN+sl0dHlS1P88AKawKG+RZvVxBiD+vgo2SIZwd6eU9t4fwpE9IW?=
 =?us-ascii?Q?1wn3aOUJlKhqAhb0pZTcldyh0NCg/oFQHCzgJRz5E15oLxPwUF+dSD3233B/?=
 =?us-ascii?Q?RiLp+kGax8PAmES4N03X151D6X7SB8yN58MHngSOl4g8pj4lijm654SGsuL7?=
 =?us-ascii?Q?m6RJkbrIcg2ctOOLfvg1DcAf+SqA/Vh4BS3ZT+putUh037bkRtHE+vAHjbbo?=
 =?us-ascii?Q?G9/BdxWL9MOQJnWi4DTrxwbwGRDsi9E2sMdVxmKYvPnAhT+bTVGHlr2ZTNLS?=
 =?us-ascii?Q?vkFyg+uNo0SeGbb7np2eLhj4DXuIECJHuej94LJQ1ieRzxsfJhUGNCMWV5Ny?=
 =?us-ascii?Q?r4k/LPo8fciUBMg4mtM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be291d2a-5ad4-4126-2b16-08d997ef8277
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 19:41:59.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxlb+NcJfPGvKIEsMuHtjOL1h9Wzk5Tfr/3PS85Ueph+Vwdtwnr7zyjvs7hD+gVl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 02:09:36PM -0500, Robert Pearson wrote:
> Here (not related to the mcast issue) I am guilty of hiding my plans.
> A little later I was going to move creating the metadata (RB tree and
> index table) into the lock and then later after converting to xarrays
> replace the lock with the xa_lock which you have to have anyway
> because it's part of xa_alloc().
> As you point out it is the index/key tree change that is visible to
> everyone. The races here are in trying to get the index or change the
> RB tree. Perhaps I should merge this change with the later one where I
> get rid of add/drop_index(). Or, rearrange things and convert to
> xarrays and then worry about races.

Right, it should be later

Jason
