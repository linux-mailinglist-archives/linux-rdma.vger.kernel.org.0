Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6725C2C6
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgICOeq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 10:34:46 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16576 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgICO1c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 10:27:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f50fd3c0000>; Thu, 03 Sep 2020 07:27:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 03 Sep 2020 07:27:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 03 Sep 2020 07:27:21 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Sep
 2020 14:27:21 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Sep 2020 14:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kF/ZAaJqRJFoKwkkm0T7CtxCUedPomy06qbQxucoWOhpo0Uo+VDwbyM3q3SJi/LiI7yOM0j3AzgY4uM3jmuubaQLq5su11Z+g0WfmbjmRaxcFT22nGZ2v8a/WX5OCzjTkZRtqqfcM5oNNjde0kkTL0CswllDyEU0PNhI9/2cFgg3EkxOBHPHnFQEVFSZ/1+DH55Q0/aRta/ZydB9mgDfQmD6H1oozPKxD+KpeJ3o0ozUGY7XPSsn2IZy9qoOOqLufIYy004vk8rQg+G8DrVN19JB3SLEPlt3TT3RMvXVbDAOews4p7mBgc8WgHkoevF5xv7egs33Kaskr7v0cZY+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U3Ym5kTvif9u+eJcYDMqL4K4XKAVm9rx2yEh25Ubj0=;
 b=hyX7jRtFVE7LSRsagAjzVOXzvC8w5Mfl1kqDml7GuBZak29zOZzmrzqAY4tpHWdKcVB+rvShGXbDmmmDvq+vpu0BF7cIBoU3LdfrrD55U92s26EaE20xO4ORtn2uPwJZcaiFTZsjQSjVTdCPphWZE0uXgXWMxKjCtTLzPMBIz80hA5PO/qOim6XuZlRv/hnlyUZg+n7F/ljkLHTqUhs/EA43h7IHfWdOX/JzWJdg9gk16AtatcSciLax73rKF3zOoa06CpNoGtR3EGZnNqF+xAzeXaaG16CI9imUNbFSfM3q6s084xQrxKmj9CtoBxJvHFf35unJKyJN7Zlya/VoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3307.namprd12.prod.outlook.com (2603:10b6:5:15d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Thu, 3 Sep
 2020 14:27:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 14:27:18 +0000
Date:   Thu, 3 Sep 2020 11:27:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 01/13] RDMA/cma: Delete from restrack DB
 after successful destroy
Message-ID: <20200903142716.GA1550655@nvidia.com>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200830101436.108487-2-leon@kernel.org>
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR15CA0055.namprd15.prod.outlook.com (2603:10b6:208:237::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Thu, 3 Sep 2020 14:27:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDqCq-006Wdm-Rv; Thu, 03 Sep 2020 11:27:16 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 439e861f-d1f4-49df-6b72-08d850157629
X-MS-TrafficTypeDiagnostic: DM6PR12MB3307:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33070AF46C73C4E428654648C22C0@DM6PR12MB3307.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i++Yupg9xWy/MXD37NVngFz8F7i6u7m4j846TauPOvzHy9uenntBXAyUPqZStEQL3MLELlec04m9P36Lsdf2F6la2wEtOz41UtzES3/RksvUxYfT8NYEFf/Ti1AntMSGli9syjcGbq+/fTCde6N9gMBsbFyoAkFibCKqEcg9OlrSYRRyyUYiZevpSZSep6112xogkKvYflYKDkk5ykLBLx7zjfB/xAXOGdYtx1E29i8kLpi1oZElLKyg/K0PB3yevJu9ck8p3eIdN2riCeHna6PnyD7N7W1eiRTj1Lc4Ze3kDJXj+x1CI1BFu2iai+Cu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(9786002)(86362001)(66946007)(478600001)(1076003)(316002)(54906003)(2616005)(36756003)(26005)(426003)(8676002)(5660300002)(8936002)(9746002)(2906002)(66476007)(33656002)(66556008)(4744005)(4326008)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vYnhNkF9vctixgBWld0S4lXXdoqQTqllspSvmUwh4xm6CA4uVzLK3RJ6mOqFDlZRhDo6DApifWvBu+gwCDa2mDTgxr2kY6O9I/cayKm22UWi73vzGk2SJxMOiYnxhB6xEIqdtWtc7sZBOx5oThVj9eR+UE2QMEcimbQXiOmXkzpanMx61NCe+SUGlq3UAajhr/VsFI1h8Qfff3Vlzb6kpt7ZcjnifMY0b0XTYVGKTcAg0rGQOW8I6V+snGDeiwvafI3Y1V1X0okhWsZvg7EE1HcClKb9VyQEAY01Jh5OaXXE2f5jUlLjAaCS4EosPvlPV8hMLl969J8gTLG376FEOj9wzkfRDmwcEW+jeTFyJ5hmFa81EJtYAw/6pM9IVvESOg+YDz98G8fY5B8fBKP0+S64S/CYkaxhryCVzi0yAXWzCdRo4EejB9noGyvIbgAaKXuGVM1C68G8QKa2pmk4yck3zkA0jq/cYUiwwA0KdFTf50j68r65c2lPa54Xwv8v0SXMhZNhl3fzSW9YkFg/L7LqynFwYq4+dLCgkKlIdplxRMKIkHM46F75UPlcH/wK9YqEiIy+Vw9laljY2RFNmNMPk465KipqcdwCYP7ZtRMk5ID/tK6Z6ywbIRa2/wAOLiGnk6FwlhjKfiawOjPDnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 439e861f-d1f4-49df-6b72-08d850157629
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 14:27:18.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mjR1rriNfwtyI+DoT1jHx6tvllw1JrSoxI7lcCwwAdD1YxWIB3NZ4p8Mxr6+B/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3307
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599143228; bh=7U3Ym5kTvif9u+eJcYDMqL4K4XKAVm9rx2yEh25Ubj0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=dxywH//HRxND99/4/fUwzlt5gnU67NeHhQi5XIA8wQTm6Rns7EU0kPBmR4WSrHsW9
         VFjWGA4g78xM/ue93Yd/+DR4x1vr6KxU9aR57UKVxjzOnXcoooNLZ0XO7K+WvtglQJ
         DNzGn4Bm34bUiC7cXaZL5ONfMV5s+18cv7JgY2D8pEJ71g0Gwx5yXP/Qwn4hmw+INV
         KsMN6L0gFplDKWJXdub8TNaL0sAGHITxVezE0LvqR1cue+lBTd1qivmdhLlcGsHHyB
         JmFE442Fl0EPphvsTGITECYqQ0h12AngAHq1oreSRXLeSrvvuVaYkpVDxYJKjl2I8v
         8AlEwhOxy16GQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 30, 2020 at 01:14:24PM +0300, Leon Romanovsky wrote:
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 62fbb0ae9cb4..90fc74106620 100644
> +++ b/drivers/infiniband/core/restrack.c
> @@ -330,6 +330,9 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
>  	rt = &dev->res[res->type];
>  
>  	old = xa_erase(&rt->xa, res->id);
> +	if (!old &&
> +	    (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP))
> +		return;
>  	WARN_ON(old != res);
>  	res->valid = false;

What is this for? It doesn't seem to have anything to do with the cm
change.

Calling rdma_testrack_del() on a yet to be added ID should early exit
from !valid right?

Jason
