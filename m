Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240B283C3D
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Oct 2020 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgJEQRd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Oct 2020 12:17:33 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:8725 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgJEQRc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Oct 2020 12:17:32 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7b471a0000>; Tue, 06 Oct 2020 00:17:30 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 5 Oct
 2020 16:17:30 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 5 Oct 2020 16:17:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuqXIiQZeEDbg3Q+R3w436OMLGQ7wyitx1ma4xGLfbr/8TGMSEGLCCOplM5yvJiBR+E48VTg5T6fnxHpjnHT8QXd/9LNI2uJ230toM5KY/g8ie+X0dgQX1myGwEFULgUzbNpVCFDQEGhtfwHwEx+e1yyNuan/gCTp60IRcPWlDtnyrsMDhGZGY4m7yt6H+hEIdztsXIn9rOCMY97ax+K/Xei/3x1pasQUdCPbdXZqgZ2q4fYFNT7N1aCyQGLPyM+hNgn6k8DrLxRgRwspCHIhPeKAGPgj091apm9wuQyDw2fJb0BM0u24QgWKtdcXLRRML0ELoWUEK+ZETpOhPWCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxiwRh+a3AXg2EJ6eL+2nfJj/CtPOtizoz7HjnO5/sk=;
 b=VSZfSq6vBk2NZYOVloVlRIzRdcDnfqaMyj+338PeEgaH6fVWFCS1K5EYlWz45UfANpRzqEpF4U8MWXeAVqrGKR6+iGNXGznvkqeLDv6K16SXqjETG4cW0GYjx8ZR8dRUb8Ph4zzMZKV6MG5ci7c00e56347/uwQKv2eedHshG96061dciMI2ne6F9q2h+7lCZhazrRYqiZG7C7BE4AV2MawzxttrD2qX/l3UPSY73fAllRRGhrlpHvtIK6inioqhyAIIWRjAo0HV+yIRWRFJUXf31/GI6L3gTbY6Oc7ofR2pSYjWa0zVqQnXKZgl7GuI6lvBg17VDNBZeTBb04VNnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 16:17:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 16:17:27 +0000
Date:   Mon, 5 Oct 2020 13:17:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Potnuri Bharat Teja <bharat@chelsio.com>,
        <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 01/11] RDMA/cxgb4: Remove MW support
Message-ID: <20201005161726.GX816047@nvidia.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <1-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <20201005055652.GE9764@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201005055652.GE9764@unreal>
X-ClientProxiedBy: MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Mon, 5 Oct 2020 16:17:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPTB0-007h1q-Ao; Mon, 05 Oct 2020 13:17:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601914650; bh=RxiwRh+a3AXg2EJ6eL+2nfJj/CtPOtizoz7HjnO5/sk=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=TEjtspbIudj8KCsKYtSJi2onLHZ1E97gdvqo/et1hERYb95MTi+iu1aBHfq4SnYuq
         eQMjE9qQR2lrZ3nNSYzNMTahVDlgjF/mPzWI6BjYwgVQj2JAwuPfY9ms5YqOe4V71a
         bMUDOc4fySnXQ6Z31GlQUOdBDAybALzspmK032fv67UYgDiLF3aKBEZPaB+jxwdztH
         uu+mbrZST40Oc7H7EbT+mlRMGoBh5bIYfI2ABj3+GD0aHjSBsQL1FzswZAtZNN6SIh
         1RRtqRqAKQ3tSZ5FXfIhkpj1dLmIH0ZJDe0PWvpG9WeR+1WHrQZiA3wQWim2N0F820
         fcRjTYrFmzd3Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 05, 2020 at 08:56:52AM +0300, Leon Romanovsky wrote:

> > -	mhp->rhp = rhp;
> > -	mhp->attr.pdid = php->pdid;
> > -	mhp->attr.type = FW_RI_STAG_MW;
> 
> 75% of "enum fw_ri_stag_type" can be removed too.

I think that is the code-gen'd HW API for this driver, I don't mind
leaving it. It seems the HW supports MW, just nobody plumbed it
through to rdma-core

Jason
