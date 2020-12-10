Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF02D6390
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 18:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389916AbgLJR3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 12:29:55 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2002 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391930AbgLJR3t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 12:29:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd25ae20000>; Thu, 10 Dec 2020 09:29:06 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 17:29:06 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Dec 2020 17:29:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBWomuDTecsZSv31pp8/CqXb3doACic1TUfjQYcr3ok6YaO6Krht6cq/JD3UKPUhvpFGhxCEI0r3+LJlqC6sLItZCTKvC/RiPDXTnXde/0rIIyHbr+De7Rw35pRtY791nvt8oAuXh7OEaDzIOJUo9nH+5PwoRh3y7wN5g2q9a3ZuUS3HIpEAUGD7eoq0LKHa3LOP0641dHVfeI1aqMkR56Ufrvl7fJsdEIx8oBR5YPmt5fI9jPF7VGBUQ5+GgSeHndsWL3JcQnLH8rr7JtMl2Ptx4EyZ4WVCNEFYisq93rGk97C6f7L7lLH1xspmfPgnwi72khsowiYCOguGuJRZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akQAT9EpEKrxG7sK0vgbyhZpoyzdoKYNfV+0Jj+TSmw=;
 b=R8O8Q7lR4Z6X4WQ6vylapyz8gd/UHgBTvFDdDC/JNmiIUptTSGLMhuGGY2y9WG6I9QBLgqr4WJ89t1EE8nU47HWOuISky1JTl/cfFn+i7Ky/PIHHHIj2MKj5XD2vYl1+w5ToNqrCeeVCO6JMy2LRWZ6g1WgT3WKzl/2GSU0uCL50YIWQl6RkIZ0rCzZVvigQgjkrewfgw7tbsIVcgzrJb/DfTYXAZuw+Vidyu4qqI3R4RQr5IA6jIybqy4yntQUS3HkAVwEBP0XKn+V6EEwpCb3wGi54iMZ+fx5jsgwme+h7zdAQqQPznqAgOiCbaFJ2BZtMo1afIco89s6GBIr2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Thu, 10 Dec
 2020 17:29:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 17:29:04 +0000
Date:   Thu, 10 Dec 2020 13:29:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <trix@redhat.com>
CC:     <leon@kernel.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/mlx5: remove unneeded semicolon
Message-ID: <20201210172901.GA2117013@nvidia.com>
References: <20201031134638.2135060-1-trix@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201031134638.2135060-1-trix@redhat.com>
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR20CA0056.namprd20.prod.outlook.com (2603:10b6:208:235::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 17:29:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knPkT-008sjz-PS; Thu, 10 Dec 2020 13:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607621346; bh=akQAT9EpEKrxG7sK0vgbyhZpoyzdoKYNfV+0Jj+TSmw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WV/gBailCMyM2cFyHcO+RGu3pDW38hHvvXnG+NwlvX9HXD88uhL1k+/EUvAYoTKY4
         Zl9FctSX7MywspW+boArTTs5AJy/zuoq0RUDfkxt+UWFax7WZn3Z8Hi4Zx4IQ7JJTW
         4iZkQWn1kaJpQm5nqiyvEt2tH5n4hxpLcty3XeqbUs9TyQCayMa6mKJxrML/zVaMP2
         8JryDVceAZenWYFbanmItlWuz/8kBzTVWkrTtyBGFoHwszY5wLmNsYjxNQlI4XRHRu
         WeLKiDcLe5EqnuM9AV3hsLmYPxBMs5cfmB85S1iXf5qcBb+STMb+jLL5Or18tdRjKm
         FeKJQVB9xQUKA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 31, 2020 at 06:46:38AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Jason
