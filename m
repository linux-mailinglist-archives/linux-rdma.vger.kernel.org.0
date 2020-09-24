Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D178E277C2D
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 01:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIXXJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 19:09:47 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:30456 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgIXXJr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 19:09:47 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6d27380000>; Fri, 25 Sep 2020 07:09:44 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 23:09:30 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 23:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj35tlVckOqRjNRD0DidI6131Ht0FPn8sdWaBBxD7+EmjRgqOdoMPTTbOUYc2mVNf3hDvF7MBUmkGMwMH8R5g3dOLY8SwVwfkyk+MUHF3epCjnZ9vx2ogyW45JP8koSten8azkSsuqLBz0SPUbNrSxGuziSag1kjLqhKekpsQ3ZGMsJ6yB3PO21cd/iZDSYQAkRIXn6K0dputqOn8hF6in8Eeo1/isTnW2aZclR2hAIJ+G9bSS2IIcrU9WnGYVQT72NLIgOTPf2gq2r7xibi3V8qnEBaYHL+XwQva/TgmsT9X0rKzRy3qQvSHkD+magkmrDvb6ckZsBee9VaUrMxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsmjbZ2tPxAoaY7C2nIw4hhnXwJUwMMwUK0Fungptco=;
 b=cTAKp3b0GdLQU+bv5l+h9kJ3OjxT981AnNkAnJo7RfNj9jvnOUhd2jwK6L7HCBinm1QEEyb74jhfGzgmuemoLWziktTyoMKH/S/4DlgHSh+t7/2oYyr2HqGLWXULzEckAjou3Gad6eEq4XpJcvv4+mYtaUQoZIWOFdOmg3wtOIsg5vRFix/D1AV5E4t5Ga2y/piWzjYaEjHrO0LdUIxvMO5YQImajwXjAVziOBM99kq/nsQD1qZ6+KiGJq6VIYZNfazTdjZ+j2y/gsfyc4c3JujFgFyZ/CWSYVP26GmWEOzDOFNtuZp+UZJQcmSCBT6FdvBnarvlq/qnUuFteHAzvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 23:09:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 23:09:28 +0000
Date:   Thu, 24 Sep 2020 20:09:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Faisal Latif" <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 00/10] Prepare drivers to move QP allocation to
 ib_core
Message-ID: <20200924230926.GA145771@nvidia.com>
References: <20200910140046.1306341-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910140046.1306341-1-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0007.namprd22.prod.outlook.com (2603:10b6:208:238::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 23:09:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLaMg-000eCa-Tv; Thu, 24 Sep 2020 20:09:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1692b20f-3197-4cab-92c8-08d860dee2f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB330608587431A3A2306CDB7BC2390@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6oKNaQJPmzZZYIxgcllZ0kxlKBWrEuUGSANKINvn2O1dESL+k8uC0ZjxVIqkykYUrKj7U98jP7dZiqrhYm/PucbyHhYeqxfQvUVQ+1etZn/vHLZHKrCNaTxpYlDAwIMGdZcoEZRZL30K5JSYGYCtGicGCrZBxPs8EX4IpkpAz1IyBZAHcrf7NeT8MEGWl7lDQGnW3MnB/EISe319yja6cN7G+wGIHtuKemHnUUDcqYZwptbky9opLCt+fjXA5j4gAXcGvsgmi4ewV73K/Ep+ybpWHBU5whowlBfQZOKBHEkOtRpz+bdOpxwxYjkHP1CrcspKoSOJ9yUEyiesDiUkjeZsPP/LKK+TIimmuzyHSIkROCTSjChbOWx0f0LFeRX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(66556008)(66946007)(54906003)(4744005)(66476007)(9746002)(1076003)(2906002)(186003)(36756003)(86362001)(6916009)(83380400001)(9786002)(33656002)(107886003)(8676002)(8936002)(426003)(5660300002)(478600001)(316002)(4326008)(7416002)(26005)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N0hUiH+V9wPykBJ2kzTQU/HR6B3edBHquPWh4H7YIwN/a9Mdbpqi0y5EPZwDXvEnwrTb4AzuCHghnHdP+NSVMuSLBxW7t440jENCXQttL203IrNDiNfwoh/j1FPwEfxjScw83wpLHCuqVvYjbWXOGpFMSBV/GX3tEXSckc4coQpUKZzgjyvitjpqsexKamRKpXQ48lNV6UeoIUgClPeaiO9Er3bf+QGJ8jHC7wS1MRjgzCsB1Sqh9cSo9ThGX6qsW4U2xLjkv0ZExnNRRl9J+u2j3oSELhxzAU+emMCsMRSt0kebv3JeOT5n5YPb7hQc9j8MDWMGHoxRMU/EjLKmLkz0ZRKPk3c1nBwfh4eG+5p381XX6bKMBJjilL2aLBjXYb4eFmlnX6cs+S62pNPRstXZAmh4kboh6KA8JuuPLbtftQoHaDorab/n6gv+VhEW9To9hPGL8bgW715bRPeCvvXiD99hXT62QQpkBbmN24IZMeiUdHcljM8BHoEuULMe20FKZ896D4PL53EPbGRs/GXfukGjW+BpLEwPtDXwX2UtuTK4YGLCsTwUec9QKTGKOxkU/bIY79q/3s7G4xDYeCPFOiH5s4hBXKQuhZrAdCHwl0CjwXeOG1PjhhIf0eDD2wuqGUn4uQ+gbH2R1KmBzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1692b20f-3197-4cab-92c8-08d860dee2f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 23:09:28.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmVkc7JWPpVaauitEpolPyjxbUPsyK379/cB4CCtFFY4f8QoHQDHbO/Cp6lK+/YW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600988984; bh=fsmjbZ2tPxAoaY7C2nIw4hhnXwJUwMMwUK0Fungptco=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=kc4iLrjp17lwfRHDZj2kC6I3QmdWdrE++v9vWXN1U8z6FRarc7oBwCH1SXFVGXhIf
         9RGHptuhjj9RDe1BhkfpoC8SVB22we18bqSjrZwsLYYiTT+CsGmSqBT8r611TBPhWL
         pTTxBnwTQhkSxoZ2fZECxk2fMiGbd0Cv32q0v++BtE5N+ZqgwQKba1BPmp0t5HxKLY
         tSndDLI36l/c+cuLWkCtQGSrrOPB4Tc7E/1nEsFrMwunFJSiU4nZXkJNSyb+5sdAbz
         EUcewfYzbkzjuoxVm7FJqF845pdX3gRgo/Qi2DFb8kxpo6yFQAr4fLx0wnAZWMPv9P
         KGtOckDJLLS9Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:00:36PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series mainly changes mlx4, mlx5, and mthca drivers to future
> change of QP allocation scheme.
> 
> The rdmavt driver will be sent separately.
> 
> Thanks
> 
> Leon Romanovsky (10):
>   RDMA/mlx5: Embed GSI QP into general mlx5_ib QP
>   RDMA/mlx5: Reuse existing fields in parent QP storage object
>   RDMA/mlx5: Change GSI QP to have same creation flow like other QPs
>   RDMA/mlx5: Delete not needed GSI QP signature QP type
>   RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
>   RDMA/mlx4: Prepare QP allocation to remove from the driver
>   RDMA/core: Align write and ioctl checks of QP types
>   RDMA/drivers: Remove udata check from special QP
>   RDMA/mthca: Combine special QP struct with mthca QP
>   RDMA/i40iw: Remove intermediate pointer that points to the same struct

This all seems fine, can you re-send it with the fixes? i40iw also
needs a trivial rebase

Thanks,
Jason
