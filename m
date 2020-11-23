Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D02C1685
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Nov 2020 21:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgKWU2R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 15:28:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19643 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgKWU2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 15:28:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc1b610000>; Mon, 23 Nov 2020 12:28:17 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 20:28:12 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 20:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Ou/e1cfKzAw+/IPrjsEUQpROTOHiAfGszpdJyKlg+7/01d0bremeMHCxSkRDEzefc6NmvniaEVV0RWRqDIZhaiv9mqR7j4jQwNNAgLEMfXYg2oCe2rtQDcHpkzFoFdhrssYEh1MW43UBYmXaUVBETt8Xqp6ifwJU5BIfXUDn55xx8J9hLOwIDbEzvfjxwoziuumZexvPH89OCNu+gJurh28V2Q+DjuvklpsdwUGIpttwy+hEUOJHjpwhKZiHxSExQoh/kvILGIUyRIT5WGGrMw4Q0JqeTZ9m5dFmqpbKil85KCrmyOlo4CXRlF9HgIrqJ9CUVbin+Qhj082Qf97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elhQpFiifVCgFHAn1Y4jSHRtCGg+U9acwf65hWQl2+8=;
 b=CuLpapQBLL8OXrAAUkeCNVte6hH/Qcywc5i5HeDpdtK2VWnITkQgRBHSoYdln2BfYji1qpsUHUBR1I/jcdvs67DJDQlqS3RnDVm+TMnMeGDtlX3fUq1qnU8RQF5d1OwseAeV+RrGp+JNtZOXtcMpfkds2DqQ5zhCWB3AJ0N+q03L/0+3FIFmUhdOoMMZ3hezBjemNSNiWHxC81tW56PEmnCsd5C99okNfZKMXLTyHGGZmupx+TBtqLE6NqNJO2ONPo7QkzD1UBY+LTNE51hJ+XnF012noX0Y0O7ehNp/F0+VEivm1AJtS3Is709Cg9mKqHlP/tIJwfuC80CPUEIcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 23 Nov
 2020 20:28:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 20:28:11 +0000
Date:   Mon, 23 Nov 2020 16:28:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] IB/mthca: fix return value of error branch in
 mthca_init_cq()
Message-ID: <20201123202809.GA44105@nvidia.com>
References: <1605837422-42724-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1605837422-42724-1-git-send-email-wangxiongfeng2@huawei.com>
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13 via Frontend Transport; Mon, 23 Nov 2020 20:28:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khIRV-000LBh-E9; Mon, 23 Nov 2020 16:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606163297; bh=elhQpFiifVCgFHAn1Y4jSHRtCGg+U9acwf65hWQl2+8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=pi6DipeJj3ufLbEcshHCeEpKd0fjRp8rSGSbqw9EwIDH1dt9bintYRqVcSWFN0cqc
         rf8SsqbgWWpEWohEci9g265WqCfzaRZLUjFiRkrfBBllubnty0RY14KejemU0DRqN+
         M0+IvkA073KoI3XnJZFuxWCpqERPvHEPk6rTj9rnZwF+XkLaKneXtN+TSk6q5nrLFg
         pQjkGvjTx/zqaGWKfI9gPhBTagTPFhM9TMCy66IPYsaktPx4Jpw4hIkf+HMnlxpDm+
         A9X3Jw73vZYE74V4TN+snmUGHv5g3pyzJWxXTyc4BsfvFw3lgWX9cnyFjgLfcZjlV3
         2fNIruNG6X+MA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 20, 2020 at 09:57:02AM +0800, Xiongfeng Wang wrote:
> We return 'err' in the error branch, but this variable may be set as
> zero by the above code. Fix it by setting 'err'  as a negative value
> before we goto the error label.
> 
> Fixes: 74c2174e7be5 ("IB uverbs: add mthca user CQ support")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/infiniband/hw/mthca/mthca_cq.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
