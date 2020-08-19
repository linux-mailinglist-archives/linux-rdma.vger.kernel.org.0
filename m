Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D39249C0A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Aug 2020 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHSLqU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Aug 2020 07:46:20 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18018 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHSLqQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Aug 2020 07:46:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d10cd0000>; Wed, 19 Aug 2020 04:45:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 04:46:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 04:46:15 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 11:46:15 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 11:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfXi0EkJzCzDLzPTsaWNKjFnTtMi44eETwC6C+R/EjGpXqqQR+vu0qd0VzDiAv6CB9hnVoIdY9RCF6fRtNNGnJvaSsU0LJML5+WIJaCPZWOT2FV+VMAjLvJy3MMTXQkTKG6a/OTkBMQr0jBcqtpGHCqfg4CBj0yQRl9GJQthFNOOC0dsXTVJi7sTzb0QIXYJg8M5ZWKXiXszSqSMtWFeHMD+XSq6yZH00HyfWDod6fIPdGULeCBlk8j/2Si0VoLnyUiUq/TPxFAqe7SphtaQk0isX6i7rbFOUozBqXq1xC3AhNbRqC+76TzkF6o8gBmm8vcZJGl0Jwu1RsEJhx4Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5FFuN4irdpCEDQzY7tCRMJD6inKu1lKLQQbsY3v9mU=;
 b=X6mFBNZzU93I7X5cfA+W9a3F/uydOjql+a5a5Zh6UdfRiLYclRWbsQfB2J9jtF36iigjz+GgCQr5nzmQezB1atggTD8bMuIbEE19FlYeGSUG5Uo4ckvfJqv68/yf3h8IToLZOzcPmrcWkBhUY2xG2GRC0AG9nWshG2T/r2k0peLTxgHnSpCHAaCLStx+EuJAV6r/QlSVxRjQZblmKthdLN1eAgEW3owrbArEF0NugtLwKnaH7ur4K7Vl6cNM8GlThABfbP1oA/Q2dBN7rQALRSKR/sw4DTgHQ8WqzH4+NunIwc0EG58JENnCH4AIxbjBjqNwCeOMHsx7vpD452hubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 11:46:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 11:46:14 +0000
Date:   Wed, 19 Aug 2020 08:46:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix spelling mistake "Could't" -> "Couldn't"
Message-ID: <20200819114612.GA2127968@nvidia.com>
References: <20200810075824.46770-1-colin.king@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200810075824.46770-1-colin.king@canonical.com>
X-ClientProxiedBy: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:2d::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Wed, 19 Aug 2020 11:46:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8MXk-008vac-KI; Wed, 19 Aug 2020 08:46:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57bfcd5f-2c82-433d-379c-08d8443579cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43562FB24BB69767B52E2B73C25D0@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7D2HeNFAovP0TDjwxXNA6Ubein1gSZXYro+9AfHZPnfazG4osndO2KPZjlUSC0mmirSy6CE9Vb6F5gp0jKtfKJoIyEci058rTreoo2CihUoZAF5bHo9QkRydycGMAaRl/+EkhcjptMMub0982AnDO2KfVDKziEOUkQ889raiV8mgFETpHIduqrclOavtFHvAiPpo0Je8+CEPhP353iXv3MNHSVioUASJh0oZTHVvVtdClpvSYRUjFoVfS7B53iv1O+nvPaX9qZJBQfwKU6J8ZXTHLsLQ8Z6xl3oj0C/iFf/jZEciNyX528/HVxvOk85LXu+8x65wVBeTSa8cOZimg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(2616005)(8676002)(4744005)(1076003)(2906002)(186003)(66946007)(86362001)(66556008)(8936002)(66476007)(316002)(478600001)(26005)(36756003)(6916009)(33656002)(4326008)(9746002)(5660300002)(83380400001)(9786002)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WLDEz8pgK8IS+I4f5yg/dar6wPtQ44wcuHYV/VvLcoZPz2CKYXMFyiTjdtx6ez23Q9c9B49COstkPo53nBkXNE581w1/VZxUV0O5SGMgtwm48HHFhYig0BJj3njMknIBF5YkvVb2YcTMOmVACwYD4k0ZKpeofTcdem4ParyeTju3e8YxRDQ7K+dAnoXDp+2lwhlKgMCQDFpth/B48eXH2GcdmwDwwE4ArOrHzZFgrH54CYKcLV4ng/SK6AGQIbmtyvOKnFFPzprpEYgNZOD307Fu4nI1LXPzfJl0/2QXaPmeR8eU2X0Y7nXDBFJ6yg5TRLhpn52qVFa7dtd160CTA/LPta37PMV13E1ljVV8XiUr7ZgX3bVRtjpnAaAgYMscpB2wxTiHmY24TiTDql1AFCQfQ6ZOI+WbwcuCmQtHdT4bhGNHLIb19WUoJzs9nLTv1xq4Xx8Goqx60m+Fa1XJv55GdzQo6guxSzDGS5veoEdZ928k/kdgLykIKxd0cSBWGg0gRj9XwOfVcstUlX9OgBY5VdnpX3jNhiI9p4/oXpgcf7f/CRA8WGSXGcBsdJI/PiMdxcZ69OqR52rzdW8mBCaoB667bsEkGW297QEXEBso2DAPJRBK1SqSAXspMW5yrmS9REaWATzlnXPIYZBWDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 57bfcd5f-2c82-433d-379c-08d8443579cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 11:46:14.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/Y24Tkt3OZ1Ws5KWqeMKVKYCynnaxtUDw3IMTCdHAjAdOtPExJlwgLR6nMZeJC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597837517; bh=b5FFuN4irdpCEDQzY7tCRMJD6inKu1lKLQQbsY3v9mU=;
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
        b=V04Czjw7Wwhfe+3Aas8TXqFKX+4KNg7rJOE6xVPkMvGqOI4HNubZN2IOlbzYtLsXp
         E6ndW5Fkej51/CeztnW2v9XnQyPj7l9lfj/FYtIpL8SwndbZ/RNw69TqCzRRORSH3m
         3fc2Q/40sleNd80+ccg7eVSORh9tuwUf77nUhYWowX/RShEOiLNuPh4EisHw34igmI
         0y3pN89mDUlEOQWcuTHifFuCQ+cY3GqyefOrL1f4eKqMqx9DxJCnXooFEXOerpexQq
         pHBO0HKwmf20CmYVrwvXwBEB5jdGNR3V5YSqxOqy7NI7ZlMuoxMNGtSkJEZuLSWSuN
         2jAZx1U+I0t4g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 10, 2020 at 08:58:24AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_warn message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/core/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
