Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF00414C43
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 16:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhIVOmy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 10:42:54 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:48224
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232720AbhIVOmx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 10:42:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTn3br6IcAJq/Wis0Wzrcp4IOo86XD1ASry2fdkTGibA1wl7bC8ZEJ2+sbJQ8PMiUQD60frAMkAfE684YiFsT5MyDqa0yfi/TJcG+35AKltqG8/9OjwrvNudAlMjiRsP67Jhi2KBArPP22nADZ/faec8u1cynt9kPZdoBn6YI5PKG0OkDgSZHagt7ZfD8iKvtvSF1cHSPXNy/aErJK6BHLtfXatjHv7wEjQPn+Enh/IopnFPY1wI9L3fcSiAt7Vpf0wLr7TtmJY3nVeeiEXbQ9A1Tkho7Ss2pl0qSoNmZxhOF5K6LBu7F5xcgJOne1ATe9iYL/AND9gDNzGerTZ8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WdlQ4gFw/xWgvu64ENhl4M5Cs6Wkb/QFCOvvITaI0Cs=;
 b=AwRCS1T0m0ENO/KRMg8OUn2uZ6fX4mPdeOGs1ha53gWMqEK05nXeeLINus+rsishDo3B8R7gSyx/tyvDnDwDME4OISbBJbbKBtMZOpCdXOHQwzquSp6pBgfO0AB+ta3yv3AQhTpYxfa2g8KqHGmY4+yl7mS92slUEDtJMiYdNYPJXHMIXk+Rs1NlW7XSEFqfi8LfolpBTOxkLDW6fQb7G7kl4YBV62+zU5vaS/B6SNU7zDIGDPLnpbq9YcSW1+DiBs7lWAqh07wZ4784BOKOp8Lq3MfUj0llzHSNpD1taN+Wm2XB6xRTgL5Byxfb758rmE3Yhi6C0KiSQgBvDPE2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdlQ4gFw/xWgvu64ENhl4M5Cs6Wkb/QFCOvvITaI0Cs=;
 b=DVnX+A0bSY2T0epzoCGNbEfnSAttpLMzwAyAOI+/SNhNy7AbbZYJwD4ze2r+FHPjd3CkFzYCPhVhmeZiwm0P2aQvtObDwEDggYbDBzdc5hjDjnN0aD+/TPXnzlvLWYeZU17EPRAc+f3lPzdv1ipJtigi2pCKjmWybTTAeOQVKes9I29wgNNsVvBcxm96Co9VnKRNMgbjA2IDn1013bSPMY8VBf3oMctO0+T5iAP4Jgc4hUesfurhHKlfAS/QqpQJ81W4fcRV/tdV7lLnEtEEXZqNra1h8X4UVpoxvkaDHsLUGXSvPbJA9wEcCmE0imyE9yqqnEFceScF9YvhEURHig==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 14:41:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 14:41:21 +0000
Date:   Wed, 22 Sep 2021 11:41:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <20210922144119.GV327412@nvidia.com>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUri44sX8Lp3muc4@unreal>
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR04CA0035.namprd04.prod.outlook.com (2603:10b6:208:d4::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 14:41:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mT3R1-003yze-Uc; Wed, 22 Sep 2021 11:41:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5635ce35-922d-434d-9979-08d97dd70b40
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:
X-Microsoft-Antispam-PRVS: <BL1PR12MB536222C3789C7461B8B4B59BC2A29@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChQhRKh5+yQtOIPtVcGowpFSH2ca9ArVKSiCtIsZ0EqSsnaWLwWEN0i5AO+39YIPDczDwpCKCox0DpCcNrIj5g0igoMsz4VOTFWr3m4nzFFiq3qTg5sn5iD3LVjX4f+SPTmCW5g1t551Y+K4+vSOQKRCzli0gnnzWUO93DaI4s42XOdR+RJ1hPi5kXIlP/l1sK9LF1xIvTq5zZa3s5sjhcKPnpoZt0UQHRV1nPeQj0hRNrU+n9H9yI3j5+31BfWs9aFc8AQBqsIsuCXXuWxYxRSUUosFITGB4qNQe1He+KwRVEBA1pcyThIKvNUkXNVoBGEH4EsXLbYXa3kk5qynRvmicjVNaia5wflq92XBe0O8JOLgLrjBLbirM9JhG9OSz2zluOzTIssHlhqwbHgzO+88W4bznbVFkC069KZn33R+6Me4ye0O1dZ3VgxpMPWt3275gXAQkjj2BB/3I9jdn2kMGIjYPimYWi8B8jDWOW0skv7NzykpEJcRlLBH1/WmdsOxIcEyNY578F0uhVyVI0NdNO8pjezHFwG4H9MNB4Fko59uiM2JfFRBci2M9j9rw5HFnZPTIoIP6/VDAdhubQFeAu7McMkB7Fjkjq9vBcSo8AqZU9ISvj+Q80qSY0e2uzFlPFync/kaE1UmZI5y1+Cu9EJU/AiUUyZWcPFOfTZiaQWB3r1YW9AHGe85fOvW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(38100700002)(9746002)(9786002)(426003)(1076003)(86362001)(2906002)(83380400001)(8676002)(8936002)(316002)(6916009)(26005)(33656002)(4744005)(2616005)(4326008)(66476007)(508600001)(66556008)(5660300002)(66946007)(186003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ng5KsBtcG1nd1F/bedukAQEchyMRzGCh3AUkqgd+yt6fNvbAteZms3DnQJ5q?=
 =?us-ascii?Q?YOUayG6AZv3mfuzMYcseO1ibkvV3f/6cfi9Kws3qfvwdXsSpukJCZ75Nr6m2?=
 =?us-ascii?Q?YKbI5NLY8icK8x4unKhlkMUsqa3yfx+Ka6i46WRKDbgJP5046dCKoHUNz00R?=
 =?us-ascii?Q?9cg3UpsnrxPkolNF+eohOSxyCJ75viObQUeWcQCJbmObkgX3sdT7foBt/l1E?=
 =?us-ascii?Q?Y2dH2YvJcS9hQSOhZdxbn2wLgtiwmLzdY+ltBQRm+OXFmCDIlt35t7fc30wc?=
 =?us-ascii?Q?dOwzyiSO++YO+5y1dzk1stvFfkSCOiIIa8kJwL8KPK7J22ILydPWq0jpmeK9?=
 =?us-ascii?Q?rSjDXKQkp0Eju9EVgmJQ/kQPO41amyuDOtF3VnN9Bt+3tU9bao2c34EajGE1?=
 =?us-ascii?Q?UzyoxsRCdBwWmem0dyU0sBC2+GVabdvH61lG95AtKCF8zzc4f/7trsyae7Op?=
 =?us-ascii?Q?17mSd5xmEEp816W2E2mCRBCbNYYr/5igOJ3Hx/gj0Kf7rFUlvYSYuj6NS0Nu?=
 =?us-ascii?Q?CJoiKErxIlry6orkPTjBPpP+aWKWLGFvuw0sbNo8TPa5fWg76+OCaC4g7qqo?=
 =?us-ascii?Q?5469ZMt4ljE3dTv/Ljg0tf7M/sbFX3gpUOAZQOIY4CYaACVRm1h1ZObmqOWp?=
 =?us-ascii?Q?vp35Mk/tT8feps5wp0C4j9JNLWNNKSX8SqKzt7SGJXuRjg/mtIxR19TfS2O/?=
 =?us-ascii?Q?agiyCgrPWXsnGYQC3Vp9qPyTcj2sjsnSsDs3rAUCBLF+t7joy9lL9VpXbtlc?=
 =?us-ascii?Q?enwF9VIbm3PVwOVYBHZwiBA/TS2xrVKd/3Ba924Uu2BkS6IQQKdqSq0fGeb6?=
 =?us-ascii?Q?96AYkFKo+zvKu0tHs0/hH5IT4gkuvaqOCLz8NzEJVOkH5aLnV9aA/Ycni2h0?=
 =?us-ascii?Q?rjdLg5zj7Ml49CvjNzLkrbHtcOj0Ec0thuBM+eAT0LzZtyti0o2GH0QdLeUC?=
 =?us-ascii?Q?hgfKgzklJVtaBN6ThCyvWl3HbxyqHpOLjMzVWd989t1My2ndT/24Q+WxYLTe?=
 =?us-ascii?Q?zLxLnObQdeZY/nDxvI4uza+AmWWEOBk53PXWAnFmqv1Fn6/bWpTvy64XIDH1?=
 =?us-ascii?Q?MeazYQpMLJk1xPHVLzcHU1eoH2tNl9r/aFB3AjnuRglWgXY2hmCwwdqDVvRp?=
 =?us-ascii?Q?giIprg/pdQyFhfAFD6KSVmbJjEppQ1mXG0KWOXsMxDxvoV9pC+DFs6QhTcVj?=
 =?us-ascii?Q?1ZHqlErn7Cm0BNyqt1Rcfn7zb/cGeC04XLU/NOJ6Kv2jewtHOga+7tEkxHXa?=
 =?us-ascii?Q?JsOrHWRWptXZ+i8rXx578i/AwuxEfwx1jtt9YxpvZOSR/w+2YOKHDiHwyKzp?=
 =?us-ascii?Q?3mDy/awsiirrfekhsvan/0mE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5635ce35-922d-434d-9979-08d97dd70b40
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 14:41:21.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGLJKpvcziz2S8Wuu9FeMelolDMsGkkXu0+mD9tZjx5lPzcGyO3hehASk1DqS7Bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 22, 2021 at 11:01:39AM +0300, Leon Romanovsky wrote:

> > +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> > +			 * rdma_resolve_ip() is called, eg through the error
> > +			 * path in addr_handler. If this happens the existing
> > +			 * request must be canceled before issuing a new one.
> > +			 */
> > +			if (id_priv->used_resolve_ip)
> > +				rdma_addr_cancel(&id->route.addr.dev_addr);
> > +			else
> > +				id_priv->used_resolve_ip = 1;
> 
> Why don't you never clear this field?

The only case where it can be cleared is if we have called
rdma_addr_cancel(), and since this is the only place that does it and
immediately calls rdma_resolve_ip() again, there is no reason to ever
clear it.

Jason
