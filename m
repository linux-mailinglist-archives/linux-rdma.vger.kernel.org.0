Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8625043B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHXQ7i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 12:59:38 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18657 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgHXQ7a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 12:59:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43f1b40002>; Mon, 24 Aug 2020 09:58:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 09:59:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 09:59:29 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 16:59:29 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 16:59:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fY5onWMOws7xLLI0ZQZK+o76irIRVYpnbtTL0NFfBOB0Wzlyc/zI6vDgnR4GQk8HneIpTZIONozo9bbzJ5Q6ambbIF60LgpV47yIbBOHtKiWVrCKdA/OMKwoYQq5udFnpwD6NU/hqv/M6csjdQ0umdX7DlX5xHiZlupIgk+IkVm9llsaiCQvs/LpWYW6Ny0X1hUwT9BwnWDXu0m5ZU0UVgZeCDIBjFLo4nDiYBKNG4YDiBfmJX+h7JErc0stDuUnGhzfhgG5cVCY/irYGye+Fyqn4T3z/tlQjEOWCbub3iSKCVpuWAFyzqq7Txhh9zXR9r4oSDGBMJCyBhfj+LiMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4zqmzIXfnip918T5juXL5ppEt3Li8+xlOIN9ww1Ntk=;
 b=eR4PQbuYa5l4EdETNVJ48CEJIooTtq/3KtTxdTlq8uJIFP1E9h7mvmY5Hb5ydgWTmTxb7b0T6f8rvHAx9s7GPKXwuv9mcwBduuT3oXPJ0GMHwDTvjhOadKueYliVmkFTedU+zBKw6BxKWk+M6WnUBC+bl3A9+SLOr2PKP8N41Y+mRV5hR+WU7FbHp5mr7LpO+Dl2Q8DBTJP+RN8P07fbEVEXEhijbr8WRV4IjKrqRpGWkDnFhEWI8M51xJlIzPrP63qFcl5+eWQUCT69wVhXgNNghHCyQdan7iUdcKM9UH0Lg8UH+2RebZcnBr4ALzE5A9ORZJrt3aQ4xLpkWTeSuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 16:59:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:59:27 +0000
Date:   Mon, 24 Aug 2020 13:59:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
CC:     <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leon@kernel.org>
Subject: Re: [PATCH] RDMA/rtrs-srv: Replace device_register with
 device_initialize and device_add
Message-ID: <20200824165925.GA3208822@nvidia.com>
References: <20200811092722.2450-1-haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200811092722.2450-1-haris.iqbal@cloud.ionos.com>
X-ClientProxiedBy: MN2PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:208:238::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 16:59:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAFob-00DSlt-J4; Mon, 24 Aug 2020 13:59:25 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d56c1fd5-d376-4e88-575d-08d8484f0f64
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43889640F96FE8ABF56E7C90C2560@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVsYJbAbo1BXPzhzffGcHMgd0oT9eZeoOsn7Qwntsg4MwJynct9T43lucoHIt4ybQqOg5HF7tT9ihjlrg4eFY8lv7oeomsg8XwgICIZGOu4YybJe2RY6XaL9BIEZ+gS6TPWtbONeptYXOREEApDUJY4IHKv+0+NgrK4UDulIFURqzc7HGbvtracJFPNhOfLv2deYjkWum1A1rFzdjUTf/Nt8C6chwRVWILqFLve34CrGVVl9iGm3wcVOrAEF9/nrj51I2cEcY2I8HEsfhTMlgSyVZlGeth15Ur7g4/96LOiHba23QRUHYPU8LOfcP4YsIj4ZhzEkuiuS2Cmo242oAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(36756003)(66556008)(5660300002)(8936002)(66476007)(2906002)(66946007)(86362001)(4326008)(9786002)(9746002)(426003)(2616005)(26005)(478600001)(316002)(33656002)(6916009)(1076003)(8676002)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: obsfChfVXAufigpq2ARrsQ1rCg2JDO1yCy4gqiHaNZfJSpAPMiwwrBOqiYqElmvnCHWqPxAW7W0pjDd+jNEJuPoDcbOlXCVqapSb+9wTjEyN1xFMruDs0IrranneT45KfAJoR6d5xBUkONHMNu71d8Gogg1ixShUEN1DbvUHzcL4vHZufMoRaruQ6MvtpIqWO63WuHwPs5HUHfZdKpUoHh7icjd4UuLRUZ9/i7+Jz6KGIdIF1VZdF9T36oLZ05hm7StDuNu/uq9QcT3SCNRJCbjCGw2OpUUK1JHu7WmaQ5VIG4AIFy24ZgCGyo7czxmbZYujXBmDyvsemYXczJ766ZwKhw0iV92VjnLrTYFl2Avx+UYv8W012dGgQKOePOc7mH/o6EZCvLwitRz1Z9PFVknrncPoBJAV8liZ7+0SCT6p45PkoUyCz9qr0o0irlsTXwRFEtQbuxCWBVFSZ2Iml9QBOR8l/9Fem0HkaMXHoTMevy3tmqeegvwIAfRneqscahLUBdSd8UzeCjKlAjVOYPNoDQSjMvuz+A7x/Rl3opmVwq0b2Vxq9suhlPxJHzJ7sZTv0pLnHuME0LoiAaC7S9bFezUIpczCo65xeJ92mIq+PyUxbp19357qoknkW74FP2JKir7S/I2IaqgBT2OXjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d56c1fd5-d376-4e88-575d-08d8484f0f64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:59:27.2974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k25AeK+r4sl6MmIYjti/KY9vE16j3Zms5uEe6YVgJk/rHyAaB/ny00+YSeThfGuQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598288308; bh=m4zqmzIXfnip918T5juXL5ppEt3Li8+xlOIN9ww1Ntk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
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
        b=A+4Dm6OII2icbGAPOWKYQSPYEzmvSWNoTnpOyKKPeTOERObsRY85na+VSug4F0naf
         avMs7Pl9W6lQitNvERe1SnOE4qkPsZcgb0mzCfXtPHkZ3Rq8nM3ac5sHT4cP0ErmZC
         Q3TF4cY0IgSemUjDjRyzFtJ8rTdDikqkW1FsRXFH4RoWnJKQM+S9RIPND7z92vEyX7
         eB/zYojrb9Scl/eJAvRFpYWz+/mU8aqB9hMLQSyl4mQ341pKMQi0/ygrtTQRtOWstt
         q1UQI1ssUmpZtwsRm0ZtBBXaiHZpO+Imzva7FXVyF8b6+ZW2+16hYjQg4iytHbPsSo
         IH4qzIVNoJuJg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 11, 2020 at 02:57:22PM +0530, Md Haris Iqbal wrote:
> There are error cases when we will call free_srv before device kobject is
> initialized; in such cases calling put_device generates the following
> warning,
> 
> kobject: '(null)' (000000009f5445ed): is not initialized, yet
> kobject_put() is being called.
> 
> It was suggested by Jason to call device_initialize() sooner.
> 
> So call device_initialize() only once when the server is allocated. If we
> end up calling put_srv() and subsequently free_srv(), our call to
> put_device() would result in deletion of the obj. Call device_add() later
> when we actually have a connection. Correspondingly, call device_del()
> instead of device_unregister() when srv->dev_ref falls to 0.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 ++++----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
