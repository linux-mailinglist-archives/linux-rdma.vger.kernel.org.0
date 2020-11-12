Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7582B0914
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 16:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKLP5N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 10:57:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17458 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgKLP5N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 10:57:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad5b600002>; Thu, 12 Nov 2020 07:57:20 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 15:57:12 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 15:57:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiPwnk9diOJVnU1Bhlme6P8cNXEko+Fbkb5Ifbhn3L8ysloNrp0OIybDn3avZkijFhlGrim7DJ54YNeNRBZt0yB3EEug2dnX0Wsbl5jYjn4IAOJfkMJK+V7HKhaPURh8NBN1RzPlPoYhXFuF4rI/Sg8xfh8c2ftdISgF5o/NzMewr7GElz/s19o5lFNNyamJj7qQW1b/z7zjrIvKfOXbMz/uRCQFNDeYiysB4N3sHuwqe+2PShdZDeGhgjNIzRxCAXWDjU/wT7jFh0vYbJ5WKugPfSo23lQkmm1cPF6Vdjn76eDbXigS6wJ/ExLFTloPSYe6y6pt8kt/u/CgnyGY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dwmip9SfsWFRV0fdUhqqP6GnUR3aMFmuNAg/gfeuKD8=;
 b=Im/40bGClR59Rq90/kqJy3aAW12LS+Y5pWtdwG24VH5R2KWZ0j/h/R9m3otQM8+xvYOHl1nWcm46bJJSg3SROOuyEkdpA/WTaioxKGexTf9Fb4N9eD4qWhckA+HQ2x+Bkt79Mqq6VvEbJR+S2ZT2zxLQp5QhX76VivPNoP/Riax2mkpVBnnxrtFLvODFTruO/d4ABE8VV7G5/Ixf+yi4EqWt3DYCd0MxLLRlHKwC1JEjIoEdU8x8DT/w34t3zILhWVmA/qh9t1/c591iZl4cHkRy0DdEAxBUaXxXKgKjIKlbBjrjJIHB8sKFLez4FExF9TcxtnyqbbYhZUpHHPeR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 15:57:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 15:57:11 +0000
Date:   Thu, 12 Nov 2020 11:57:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mthca: work around -Wenum-conversion warning
Message-ID: <20201112155709.GA894300@nvidia.com>
References: <20201026211311.3887003-1-arnd@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201026211311.3887003-1-arnd@kernel.org>
X-ClientProxiedBy: BL0PR02CA0088.namprd02.prod.outlook.com
 (2603:10b6:208:51::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0088.namprd02.prod.outlook.com (2603:10b6:208:51::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 15:57:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdEyD-003kfA-GZ; Thu, 12 Nov 2020 11:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605196640; bh=Dwmip9SfsWFRV0fdUhqqP6GnUR3aMFmuNAg/gfeuKD8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kDTI1a0IAGb+HNKRxvHJiGX9sDGDlP63CItgGVHhoDPSFJWCjVv+3zv1/qiUUsKGw
         gcnq2cZe2jCHBQpoM4H/MMWve8p72t+XYfwLvb2HLloKK7lPIkRMM2dOFH+NwHj93U
         BMmuXWsUdTtAWd9yua1EQe+XOyLqbga5B/q2CB1wzMnS+8nzmiXPoA/ujfVa3UXq/v
         WVX9KeFNfSMnUnK9fMMNFWpr+Re29fFjl4AEV7wTCTolkEG32Z3IPyvf5QDK/FSIfE
         Pc5Y+be8RPEZFLZ9oZoPzlCLthIRd+kvjUdtIpy8MaBf4Ne1E6jnLaikSaPcIb8hg5
         wVW7E1Qk1PTUg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 26, 2020 at 10:12:30PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc points out a suspicious mixing of enum types in a function that
> converts from MTHCA_OPCODE_* values to IB_WC_* values:
> 
> drivers/infiniband/hw/mthca/mthca_cq.c: In function 'mthca_poll_one':
> drivers/infiniband/hw/mthca/mthca_cq.c:607:21: warning: implicit conversion from 'enum <anonymous>' to 'enum ib_wc_opcode' [-Wenum-conversion]
>   607 |    entry->opcode    = MTHCA_OPCODE_INVALID;
> 
> Nothing seems to ever check for MTHCA_OPCODE_INVALID again, no
> idea if this is meaningful, but it seems harmless as it deals
> with an invalid input.
> 
> Add a cast to suppress the warning.
> 
> Fixes: 2a4443a69934 ("[PATCH] IB/mthca: fill in opcode field for send completions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>  drivers/infiniband/hw/mthca/mthca_cq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
> index c3cfea243af8..319b8aa63f36 100644
> +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
> @@ -604,7 +604,7 @@ static inline int mthca_poll_one(struct mthca_dev *dev,
>  			entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
>  			break;
>  		default:
> -			entry->opcode    = MTHCA_OPCODE_INVALID;
> +			entry->opcode    = (u8)MTHCA_OPCODE_INVALID;
>  			break;

This code is completely bogus, sigh

Is this OK as far as the warning goes?

diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
index 319b8aa63f3645..36416f937b696c 100644
--- a/drivers/infiniband/hw/mthca/mthca_cq.c
+++ b/drivers/infiniband/hw/mthca/mthca_cq.c
@@ -604,7 +604,7 @@ static inline int mthca_poll_one(struct mthca_dev *dev,
 			entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
 			break;
 		default:
-			entry->opcode    = (u8)MTHCA_OPCODE_INVALID;
+			entry->opcode = 0xFF;
 			break;
 		}
 	} else {
diff --git a/drivers/infiniband/hw/mthca/mthca_dev.h b/drivers/infiniband/hw/mthca/mthca_dev.h
index 9dbbf4d16796a4..a445160de3e16c 100644
--- a/drivers/infiniband/hw/mthca/mthca_dev.h
+++ b/drivers/infiniband/hw/mthca/mthca_dev.h
@@ -105,7 +105,6 @@ enum {
 	MTHCA_OPCODE_ATOMIC_CS      = 0x11,
 	MTHCA_OPCODE_ATOMIC_FA      = 0x12,
 	MTHCA_OPCODE_BIND_MW        = 0x18,
-	MTHCA_OPCODE_INVALID        = 0xff
 };
 
 enum {
