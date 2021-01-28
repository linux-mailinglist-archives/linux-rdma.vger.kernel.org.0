Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15BF30772E
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhA1Nd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 08:33:59 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9389 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhA1Nd4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 08:33:56 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012bd1c0001>; Thu, 28 Jan 2021 05:33:16 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:32:54 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 13:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPEa/0cXTUDOutnkXZuQnyXrI/xskeGiPyqt1GYopBE7+9xBuDzwsr4G2fUs/g++whvYKBwgztHAJyGDL588MJ8WxuN7LZs0t5HeUbi8LA5exNtuUxG60z7at+fDDFwSU0aCBGvVAOrvJBh90RGwHF/H7ZMP9iskK+oihnBNk8CRxe48AmDuRfcd+EJ5nvQrNinDW+ApV6FaBYXXyrP/H6m5Dh3stuk4nzW5VfbkPo+8alLlEATICHMCgArNndGxnLyGMKdJs4qgXnZqsDZah38XTRn1WEJrwH3Sl8F4AdsNwJGEpBRiDFmx/dYq7w2defQnzkVLfr6dLSPKRM7BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+783QMWjJ3UL5D10+jBoSBz2uh+4RycZ8lgcFXVvdEc=;
 b=DCkfoueiX/pUz0SdeC0EwQo6TSX/dTg3ZcTm/uXcWej0o7+QSFT5WpgkSJ/nEWhaxf5/aBR4kVhkcMvbatpzMGLaOK7XuNiwoGZvdv6gNM6EkVrcMb/5uwAIBIDpA1kX+CtCOCPfueRb4Lcyc5GTJ3qTWnJtzwxX+3e+kybl5SDOz5yQ5CZ26LRHkxUr8nzYyOf0j+zplOd9O1dMKFDsay9UtwS6VPgu56dycCDeljQR0zlAuP8N+S2huVHeK6PUcWgB/H/vEr0TAmJ55Y8P+4+MubpFJiFE4gTbTDuaxPfhcD6BOwlx6Rpn8JdaIrMHtf5R0OqUg7cppkgLOQhYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 13:32:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:32:53 +0000
Date:   Thu, 28 Jan 2021 09:32:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 3/5] rdma-core/irdma: Add user/kernel shared
 libraries
Message-ID: <20210128133251.GB4247@nvidia.com>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
 <20210128035704.1781-4-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128035704.1781-4-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0237.namprd13.prod.outlook.com (2603:10b6:208:2bf::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Thu, 28 Jan 2021 13:32:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l57Pn-00033a-L4; Thu, 28 Jan 2021 09:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611840796; bh=+783QMWjJ3UL5D10+jBoSBz2uh+4RycZ8lgcFXVvdEc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=nkYpEwmXGbMSZYtrtVA+78rTz9voPLTbb+491ALuZRR09AoLuwAgRclKPNaFQDlZe
         64H7wIUszUaXQNx84qrT3Yuh2N3DJ8uXSPoJitaxLBOUdWwMBuo5WOPXpr7eVzMfcm
         p+JIpP24cRXqXOxNGpmqAjkTohwM+LtyjYreyO0vU9lqqlAr4VyfLUSrb+6bbfG4K+
         fcIDb85EvvJmhcfjHj8zTktUIEwnqLqaqZE9Ezy+9RIvOjaX1BmpCjXLbFQKQKkMGs
         E1SyC4knHInuVRjL2dXt+0E6dOrDR2kAkfOLIX/CEHoHFDO2RUmPOPPpUk8ULQRhiZ
         55H4gIgJ4TDQQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 09:57:02PM -0600, Tatyana Nikolova wrote:

> +/**
> + * irdma_qp_post_wr - ring doorbell
> + * @qp: hw qp ptr
> + */
> +void irdma_qp_post_wr(struct irdma_qp_uk *qp)
> +{
> +	__u64 temp;
> +	__u32 hw_sq_tail;
> +	__u32 sw_sq_head;
> +
> +	/* valid bit is written and loads completed before reading shadow */
> +	atomic_thread_fence(memory_order_seq_cst);

atomics are only used for synchronization with CPU threads, if this is
synchronizing DMA it needs to be one of the udma operations

Jason
