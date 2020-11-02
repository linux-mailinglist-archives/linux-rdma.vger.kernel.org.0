Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416A62A340A
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 20:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBT27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 14:28:59 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30638 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgKBT26 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 14:28:58 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa05df80000>; Tue, 03 Nov 2020 03:28:56 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 19:28:54 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 19:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfwBVLNllu4x3d4hlhRGIMdGe92OVOs6pBMQ1Xh7ZNfoq2Msp81gyuYobi/mZHt/cTXq+1natVAED9sRaJh2Q2s3WPM8PrAgHVngHROi/SjZPFxLtrNtyDPoeIRTQi/Gb092h/t3PlVk2eQH07bMABsN9jsWX+ApHOsHNkQxKXCdDnbOp8zv4DNCPeEXNfYvMDtm+giOx9LDT5/h6LTrDlFuM55XFc1lGsnL0SCVokNNgJrz6KqNm7Vujwrx/nd268CBEwOVidvo3MmiJgARNYCGbxk3nLnZsJLMyNXzUvv8OCrwMPKliE/6AlbWXl+eXQ2l11CW/mXCBVfpsaGFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouYMhT6V5V7kHGlOAaqp7Zoey++KUITRxsitMtVcUvQ=;
 b=OSBzYU5ZHrxcX9evZRc/0spsNE9h4EEqkL63/gMSFPmrtdq3WLbVe4mdDraN2lp8SjrK/Na6pjGBGoFRn/uc5A7i3objMdUq+m1jyGznbV/nauhlbNygPCV8ASxt1uiXZeV0nqxYqvu92vuqVOZLlqR8XVwFdkJ80Bk+rkTR/l0hB0qN2qak8J2czHGzJ46BTEsS5tv25xIeocgIdGXfGzNv5cpISWJXvgq7Uf09tg5JqO7Fns3jZcyQqNEzWx3+JfVeV0ZfEkC1FNnNgVgZvX1mBRBWMfa1rWVskC65FvEmSCrIeYCiRXDOGYkBzf3I0/lukwQBhEJFHlk9ZIkp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 19:28:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 19:28:51 +0000
Date:   Mon, 2 Nov 2020 15:28:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhang Qilong <zhangqilong3@huawei.com>
CC:     <bmt@zurich.ibm.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/siw: fix wrong judgment in siw_cm_work_handler
Message-ID: <20201102192849.GA3717262@nvidia.com>
References: <20201028122509.47074-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201028122509.47074-1-zhangqilong3@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0068.prod.exchangelabs.com
 (2603:10b6:208:25::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 19:28:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZfVZ-00Fb2U-PG; Mon, 02 Nov 2020 15:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604345336; bh=ouYMhT6V5V7kHGlOAaqp7Zoey++KUITRxsitMtVcUvQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ADf0TYYSunJGKKy/NapAwX7qjFIa8x5ep+zX1eQL6T7KrQRk4nMhD6eQ/4oaYLn2a
         uTWJsxsiOnGdf6sfJiKwya6LTrclkOAYXLblWXZfrGw6D3Q6+h4tmGPtzWG0hHUelv
         fmYeQgOpkR98hAppOD/9+1nsMfOUc4TUiSXtwLC1ttw8jFOYChuSuGDX4Nk/5vQMhG
         R5A/mGoiQyMcGEa4ZafqrnL72GO7VwyI38RS8iMU/oetV2oSbLPJNByiKvJG2aN7FG
         y10Yph+FLMxqFJWcLU8KotOUnZsSY6n2JngwbAgWwUw/VIjThrz8nNwKdsSW/XLf5r
         8lTHPa6ppIbFw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 28, 2020 at 08:25:09PM +0800, Zhang Qilong wrote:
> The rv cannot be 'EAGAIN' in the previous path, we
> should use '-EAGAIN' to check it. For example:
> 
> Call trace:
> ->siw_cm_work_handler
> 	->siw_proc_mpareq
> 		->siw_recv_mpa_rr
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
