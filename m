Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33122C1984
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 00:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgKWXlG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Nov 2020 18:41:06 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19252 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgKWXlF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Nov 2020 18:41:05 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbc48970000>; Mon, 23 Nov 2020 15:41:11 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov
 2020 23:41:03 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 23 Nov 2020 23:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAfugsnKToH+Qzx3o4eTTN9XHrPScRr+JoNQW775mevvilZIKMa/UytEh4yPQHCbnujLbF/pabgSjoZktTyPmneQBu08SvWyE0Pz7nHveG7DaBf4FSgDTLakkhXQGXA89TA8JBv8TtdWZlWEZi6sCyXBBqxt/4FqspmoCGR2fLpJp9T6nULMr9LzRQHyDbTDowAcn/uADp03rVmIopsCTWDJHnPPrnZTOMI8z/AjLUThYJ7GnwiM47uTd9LXYNUDkytT6knyl8aVEJWInU7cEOx6hIgvJBOhIU+FQ9AHPJ9+lXaml6SBnwFS4H4+O0pw0x3QABWroGrsqNIUTVZXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6orZzcI1Iz59RwW8B8uANTp0lj6DxKNFPkHF5DgZ5I=;
 b=clO2xA1wZ7SYwgsj3mcSL2sjN0qAEIaXlvvzVYw/TL/Hg/231CSiLLTo8Czrz1Y0+CYhZlTA4dHhIWeyXBqLpH8SbxqbJ8xZsXioi1Eioag+rP730geCEcQ1y1hh96dTwX/lv+zykZx7Uv2ClKsTwkxnYYykQZ0P07FnxxsEtIdt2oTZY6QeyWjXEhR44cJfZwKCuOFndp7mD26Az7DuTzIw+Irs3F1gAOE7yKMXXpjkC07sDALInWVV+L24LTTvI4GENB7/E8O21BaKlCp+Y1E1utMFpFjVwIOAfPX8VEnKMQMlJDOht4WDTZ8GX+jjM5UhSGrwRFAxTAxAynJVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1340.namprd12.prod.outlook.com (2603:10b6:3:76::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 23:41:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 23:41:01 +0000
Date:   Mon, 23 Nov 2020 19:41:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Refactor the hns_roce_buf
 allocation flow
Message-ID: <20201123234100.GA142513@nvidia.com>
References: <1605347916-15964-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1605347916-15964-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR13CA0032.namprd13.prod.outlook.com
 (2603:10b6:208:160::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0032.namprd13.prod.outlook.com (2603:10b6:208:160::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.11 via Frontend Transport; Mon, 23 Nov 2020 23:41:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khLS8-000b5O-Br; Mon, 23 Nov 2020 19:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606174871; bh=t6orZzcI1Iz59RwW8B8uANTp0lj6DxKNFPkHF5DgZ5I=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=O5MGQeKTifAgIDGpBOOBnVcjPUXxoek6MGalt/+uxtGo5v892D58cd4FY9Lpi1IX9
         N8lL63c3Lwm9ojfnk0x44Dpg25DR66/WWBAikV3FMMAyOld0+4ohqsWFP67sQJYdWm
         0xilvXAVqVED6k82ohadwWM/DuqvB0plfNtj9S7Qqg72eWIo1o8ov0a86oKc4OhNkB
         IJcJvS0y/XxJKiPMQZah32u4I1oa++l8VozuGIkESX/Zr6wE8P6sfeQ/PD8mymbNzA
         ujWDAgpdtPBB2qU8u8DaGHgC/U7iovfbxYciZvqaPg96LKem9ECGu6FHNBstQm/EHJ
         95m87l4Grj3ag==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 14, 2020 at 05:58:36PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Add a group of flags to control the 'struct hns_roce_buf' allocation
> flow, this is used to support the caller running in atomic context.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Fix issues about WARN_ON() and IS_ERR_OR_NULL().
> Link: https://patchwork.kernel.org/project/linux-rdma/patch/1603967462-18124-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  | 128 ++++++++++++++++------------
>  drivers/infiniband/hw/hns/hns_roce_device.h |  51 +++++------
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |  39 +++------
>  3 files changed, 113 insertions(+), 105 deletions(-)

Applied to for-next, thanks

Jason
