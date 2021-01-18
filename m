Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C1A2FAB0B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 21:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437743AbhARUJt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 15:09:49 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:31833 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388785AbhARUJn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 15:09:43 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6005eadc0000>; Tue, 19 Jan 2021 04:09:00 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 20:08:59 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 20:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc+p3rG0L6QgLZCYpTs1RQxZM6mOsJfj3UQ2NwIPvULedHCprOaJjMsjAJI51fk3HGzrGtNn+zhxHfeKuCVuog9nLEp82dm3tEwBJkbyIOTJFr3IMWSW9FW410onrs84t0P6l0qfFvyE9Fobgt9P3M/Th04Yv4JFHfAm20bsVOnSZawMt/OsBp2/lj2wjkbFy5DcD1bA8Qsw0AZLyIOG8ggNy17xBl9s6Mw9Qf+rZOL8Gc0iHf6/cBSIxpYTrmkL7G08ViEl1MZ/qpkLcwK2ganzrMtLiu1nhr9iYiwryP5fUit9ScraaMK6CUboTMbVlMZLn5YcbZmHwlcMAJHi/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF86lOtaNNU5QezIgjKJ2jM4Ka7DSLXRCN12+eUgMC4=;
 b=KYqO3y2/Y0n9GzVfWNC3KWWluZTrJGrFfP/kbSnuRM0CFb1kcnzrE31wiunNn78Zf0Joc0f9APrDCyTcDVqMsdmx5Lyz4j+o6xnp3h1AgcSZrB7DZG2g6ffebwOCFGwy7pXWY5esxkiR2+TI8ksR5sj+sjSWdkV9Jz/ShYuVQXUdr6b/xeY2dTMocOtBYTQmUDPjVhRVoJ1TduVim3POVSAoIJJ8LFz+prWJ5nJwtDv5i0Il5kIeVx7vuC7XHO2uykh9oE+/sPTXablOMmgM16HySnm9D+KWyJ/NGl6QZ20UOlDGReDbGW3JeA00wH1AaU8YKH06sSOmyvad4+YIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 20:08:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 20:08:56 +0000
Date:   Mon, 18 Jan 2021 16:08:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add caps flag for UD inline of
 userspace
Message-ID: <20210118200854.GA778611@nvidia.com>
References: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1609836423-40069-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0065.namprd13.prod.outlook.com (2603:10b6:208:2b8::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 20:08:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1apa-003GZA-VH; Mon, 18 Jan 2021 16:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611000540; bh=GF86lOtaNNU5QezIgjKJ2jM4Ka7DSLXRCN12+eUgMC4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=gQE2r431iPnGuMO9sREEhPeJaC8QmMzqSqk76JqzAxdR6TQOWkX4KSm2vhjXk8Zs4
         evp0etPflrGxY+DK3jKxP4ZW5BUA2urpHxkznXuYqRQ+X4+01ACX44Bac+IaBg4FIL
         PNz44EJmJ594dJtmZsyJtcsaS9vMZa4AvoiVC6rYQ28zdFE+H1Ia1iiEEymY+Xq4yC
         Qt/XcqyQZSUikCotA5z7lnRo3znReR0tQDhrhL0SRx1umdRSgh9eOD9pVRjFOCCDMK
         t7vJwW2P32R+u9pJHCwtqScQfKCG2wfE0oGF9AT/Mhu7i2f2ZK9RkafMRsm7Xcl2WN
         hcxC7NlQR0mpg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 05, 2021 at 04:47:03PM +0800, Weihang Li wrote:
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index 90b739d..79dba94 100644
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
>  	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
> +	HNS_ROCE_QP_CAP_UD_SQ_INL = 1 << 3,
>  };

Where are the rdma-core patches to support this bit? I don't see them
on github?

Jason
