Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3B22D19A7
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 20:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLGTeh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 14:34:37 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:48681 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgLGTeh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 14:34:37 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce83a30000>; Tue, 08 Dec 2020 03:33:55 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 19:33:55 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 19:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STdvFvoVApo34xAp8nzE8d8ybN4mU+mwYRI0CYNGjCmG/QnNtDDJHqtXijIZ5PAUjs7c7LvnV0nAzuNMpbJCiFuXq9y9PTUMthdimxS3FvMR+hbcctn+als95ZurbBKxb642/oGLVVzZ/qBrqsGfH3wRy6uEPHtyPYE355fcs4IZV44LRi3tF4WLtV5WWnx87Afum2iZ7PHDx5mQXOubzAxf2we9L1CL8XlR+tz02zgIGbX//zt9di7AOsC+3yTTqGVKdY9DrI+5YnhiLrSuURRTyL1ec71syMXbuANXpv/4GcMsVqJOuy/o86x41OdKA1RGLhUR+bSTwxjqTSmD4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ArUUPtAEa8s5UEpT+cWCZD/ddIX3eW45nQ5OTfR2M8=;
 b=HwPac+Jgy4e4Kn9S83onA0XfsEhMVBfLO6G+c1jfLy4a8V0f7V8PBPLOAC0P2MVFEa6s9whZqN2adhEZ5DXCMUwzprI9HDp2oGFdcUGXB6WbKsxz20f3Ch6DvSIf8nr8i4EAaNDa3k7rf6F8mPMRl8edLS9BWl6Q5MOJaJkQ9LH09JUWLPQOuV6fX7eL12EyLDnmdOBMsqrr1scQVDioJlPYky/9s3a/7AFs8bStFmrO1UQe/FamVkcE1IeuCpQYJ+l/IsIhr4eI8dGGBNKtq+4UGILiCUnbfIkCmPwTq4XD1W/OGOeXmh/xWi5twTEQLfECp3AVCaaAf45ic+ssaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4010.namprd12.prod.outlook.com (2603:10b6:5:1ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Mon, 7 Dec
 2020 19:33:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:33:52 +0000
Date:   Mon, 7 Dec 2020 15:33:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] Clean up rereg_mr handling
Message-ID: <20201207193350.GA1762196@nvidia.com>
References: <20201130075839.278575-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201130075839.278575-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0051.namprd13.prod.outlook.com
 (2603:10b6:208:257::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0051.namprd13.prod.outlook.com (2603:10b6:208:257::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Mon, 7 Dec 2020 19:33:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmMGd-007OR4-0O; Mon, 07 Dec 2020 15:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607369635; bh=0ArUUPtAEa8s5UEpT+cWCZD/ddIX3eW45nQ5OTfR2M8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BNZmLNEyKoEHV7irMeUNZkOOP7VborVSitajK12B/iu46+33C7SJgzdlRXdzFFmcS
         5v1EUdz2Ktnm6h2camiPM2dGrrJ4wMJfQRay7oLxof1nFbVc2uXkNDebyCtUiZXA94
         zat2zrbbKHo4zYQLb1MmmqoR8A1j2SFPf204ba5zjGuz6xNiYmb4vxO55y/FVC9Zwq
         +5svaeBWOFjx80hsYO6rzg1bpgLL2IosOPxh65efHr/5yGFkj0QeAX1cOwt9eal8yL
         kro/KWIp++UAPii6P4ZcBsJbtmGazhC45MgJa8H+ibwS9Dh2XX22Egp9/vccyhUFrP
         FAGm1K6cv9Z8Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 30, 2020 at 09:58:34AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mlx5 rereg_mr implementation is convoluted. Such code causes
> to hard to spot bugs and even harder task - code review.
> 
> This series from Jason cleans that flow.
> 
> Thanks
> 
> Jason Gunthorpe (5):
>   RDMA/uverbs: Tidy input validation of ib_uverbs_rereg_mr()
>   RDMA/uverbs: Check ODP in ib_check_mr_access() as well
>   RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr
>   RDMA/mlx5: Reorganize mlx5_ib_reg_user_mr()
>   RDMA/mlx5: Fix error unwinds for rereg_mr

Applied to for-next, thanks

Jason
