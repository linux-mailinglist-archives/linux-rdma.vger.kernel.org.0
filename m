Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC452DB2FA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgLORsM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 12:48:12 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6045 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgLORsG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Dec 2020 12:48:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd8f6ae0001>; Tue, 15 Dec 2020 09:47:26 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Dec
 2020 17:47:26 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Dec 2020 17:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYn6YGaAJcv7hvf9SSQFRpZCN3YxhSfEec/T+30WXBd1m0T/a+jDYq99LoJrDtJsnIfxCsh9JH9RA+YER9j7Cl5DseukGG1G786++z8Lk0R1SmmMU4LCE3rYxcuRvPLLtQ8+GnFVqE59RwvODHucSPV/wLnwBf21FwPmPfBPm6AL+dK/tdLNt0BHyXc9D+9CDzcAH82XabAu8CJRQ+VX9M8/HWfUb7Fo17dhe1FHFruv0vpy7nWWakuJBCfgOg9eZcuEY4giWZM6SrokbPfHKq2CcSjqaxUvMun1S69VQPqJauhAT6/0pqDLShnkxnilRFpGMVcM6+1nYmsXq6rjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6Mt8oMG6707IXG9uhfxur226sIgo4Sgi6IVVl3knsU=;
 b=Skq4Curt2znsWNbJtBdnOGL/iR2W3Ch7o4P/Lt4sV+eHEIM+nabegk+zt6jUFD2Yg7rGSrZUmr6BsPDlwOKnBCD1rmqVnVCN8RmOUVH7N4eIjdrit68Mk/jVCNvKMbPqvf90RCs7L9Oc1ZW3X+8ZIZ272VH0gFqF+ptQpnZKZCPlSZIAaAeSJWyUoK3fZQ7+4R6fT/Rt1VsXI0fAcYr0YNFE7hkrLs0iIdPKNf0V6ZvOpfGxeWB7ctSZI9xuAGnOM1ASYuhmW0zjhFnGsiJMmUFNvvDleDzbi3uGhsavBQIu02Cuhs15lbQT+D2fG/gC19yGI0oa2bcecbuCi231Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 17:47:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 17:47:18 +0000
Date:   Tue, 15 Dec 2020 13:47:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
CC:     <linux-rdma@vger.kernel.org>, <kamalheib1@gmail.com>,
        <yi.zhang@redhat.com>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] RDMA/siw: Fix handling of zero-sized Read and Receive
 Queues.
Message-ID: <20201215174717.GZ552508@nvidia.com>
References: <20201215122306.3886-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201215122306.3886-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL1PR13CA0465.namprd13.prod.outlook.com
 (2603:10b6:208:2c4::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0465.namprd13.prod.outlook.com (2603:10b6:208:2c4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.9 via Frontend Transport; Tue, 15 Dec 2020 17:47:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kpEPt-00AzcV-4B; Tue, 15 Dec 2020 13:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1608054446; bh=j6Mt8oMG6707IXG9uhfxur226sIgo4Sgi6IVVl3knsU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Ap7tc+W3ve/r7b2a849F0lzxbKR4NMtdKHM91fQMbe1wchaJ99mpJcblHTTgdZchS
         zZO4NM5nUpEWmj+E4hDopupuSaOSOEA+zchfaGC+UPXfR+brv5xb3HaUCgf5Kgpath
         sJqhb05lKZbQBGo8gVpcRBqK/SUAspqumSCd/AqGGt+MKUyXWjCvJ2aChUyRpS1m8E
         AgXsKl9qkJwHJmJSRWqN4MAKw8J4u4t1QsaFoh6tEpV/ql+71EGdelmk3wIvMXEIQq
         k2Le8os/vBX+cvn9x2+p9ZKL3xkn28naS0ZnFXdEMB+8ftnuONcsD65MfVpVADqC0J
         PdH3MFXaNkD6A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 15, 2020 at 01:23:06PM +0100, Bernard Metzler wrote:
> During connection setup, the application may choose to zero-size
> inbound and outbound READ queues, as well as the Receive queue.
> This patch fixes handling of zero-sized queues.

This fixes a crasher? Copy the fixes line and oops from  Kamal?

Jason
