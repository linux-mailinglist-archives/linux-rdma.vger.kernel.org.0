Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A772FAAD2
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 21:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437765AbhARUBT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 15:01:19 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13193 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437854AbhARUBO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 15:01:14 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6005e8e20001>; Mon, 18 Jan 2021 12:00:34 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 20:00:34 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 20:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0IPz84MMI7alz9pL864S2Gp25MfFxfDyK7+VMYiYcsaf8i92ClInSw846dT+I0S2d07bNP8kVsHF1btuidjxCGPDS/ygzSWKvBDMCVPJ+LLT87YNLnJCyfffPOG8KevfKdKK31s0RFKGmXqX7Tnz840Csk0p35KVM79P4w4CvxDg7C5YoINefkF6hU6EBbki+z6LrKB5Fz+Lty+ZaIhBAHZVoYjzg4UAR4cO7769QLZMiblbt7mRm4Y9IgLAxiKhZxhGCY2HtPRVWgdr6Ue6ON62fROLlkMkEnk/7VoaUDkiVhgySK2ftudiYhJ8nZae0P+Y4Sh5rhKGHW6IwyHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWLbssit1aGNiPbJqt/5IgfEuHfj5M6ZnEYZ9/LBfRQ=;
 b=RF9pAD3AveL0hRb0XDxYONcOT7DutGzpQcvQf63Hdjhm6fcJB8mPkQ1bJstYKe71O9sw7oH+CXEGwueAD8J/ZLUF4JyPcYbp2dASWy+RtAHbZQA+7MO1gCi+GgWSoaI54BzWVX0o/4JQr+c5Ens9Aulwzx3kRZYliKW4D9bLGyetJtGmrCv2twCA2zHAc1qFWo2N7717HS2b/9G8+NWaW7aFgoVDjMplbH8RS41vSCwo3Rhg+Jz4MCOWb7Um5+hy2Re+kz2dkQNDEifx658iGF6xGqt7B/iihjVQjDvJGvIQvKvfc6ywrnlO71pH2lv70LTDhUTfuCLYmjTb/qAGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 20:00:33 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 20:00:32 +0000
Date:   Mon, 18 Jan 2021 16:00:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/3] Cleanup around DEVX get/set commands
Message-ID: <20210118200031.GA729141@nvidia.com>
References: <20201230130121.180350-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201230130121.180350-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0312.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0312.namprd13.prod.outlook.com (2603:10b6:208:2c1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 20:00:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1ahT-0033gx-4K; Mon, 18 Jan 2021 16:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611000034; bh=yWLbssit1aGNiPbJqt/5IgfEuHfj5M6ZnEYZ9/LBfRQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WPPeTTSOeffx74R1Du2HFW+CeShdlY0jXgBNk1PyGJTAZ3ErXQEAL2oNOdDCFflw5
         K9P01hv1kkqG8VOFh86T3HbFR/rXeCiRv4Qud1yQfod30g4kzAL3q6TVnh81ZjxbEn
         EMkdfrErj7xYL63d8VTwmaSY/3Qo9pS4oKCKPRf8zcCQriKzwGMDECJL/YHRyFDu+k
         FLGs8+sSoAgOaBaZfSBhmrm36n9WvPfZ0IyNmyvelBsIU2c78viQ/7leAtKg4oJmHQ
         Pr3+YkHr692c+hUJQzYHOLXSdLSWsZ2zGgJ+9/VGmpHCHEvFSWspNLqRXXsrPrI+bp
         EoLgKVby2x3ew==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 30, 2020 at 03:01:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Be more strict with DEVX get/set operations for the obj_id.
> 
> Yishai Hadas (3):
>   RDMA/mlx5: Use the correct obj_id upon DEVX TIR creation
>   net/mlx5: Expose ifc bits for query modify header
>   RDMA/mlx5: Use strict get/set operations for obj_id

This looks fine, can you update the shared branch with the ifc update
please

Jason
