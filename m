Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA583B2EEB
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 14:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFXMcT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 08:32:19 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:22465
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhFXMcS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 08:32:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk9VMjdgUhkf7o5ymKKBCS+HsT/YGsOIPTw6HI1T+XOr3GotxCtEvO5gfjJyb5W2jfY9zHewaaqCsajn1/V4XNAI5/HcWPotl4OS+zHCdFS73kivziea8xHY0OM6O2r4ZyOFYVyj3bllTQMlay2eSXljHmYvGcZR6lRgLQCEX0h+D64yAThtJ2Wim8F06qVRmmBSzaxtJLgM4v6Qb02XRJjx4iWlVg3E74vYtgoKq9dQntyssT7pF0RjmGCw3Y4nGyrQIJODGeGu0+PbDvplP9Crpug/calhDeinNkAFiy5ywWgeLp7PbLVwpxjvpvkMwuvEt9tkD0MuTlA4EdMdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVlJBI6NV8wYk2UU/uemcuMZDi50LGtf/L7IEg2irKc=;
 b=WY346GQWLhf71E43ARpFccuXd6rpQLCT9ywSMl6WVxONsZb0TPJfF54PqZOeMmioyXsWm0q8Oh4xFWcq0IGHo937H0RksJMI00r8wBOLXMTZrkLe9/BUUthfsVQcxfxxRXmSvtcxsbnBvUg9bGI9gtYwe25RYododwE0go6kUvD26XsZU/P1RlrxGi6BDNVhaUE4XPT6K/wKu5YU3jTnpawBUkW4DGmmyNVvwsvl+RFLpqL+Bfm9w5IQOChydlq+hSozwanD8EBub3R2WeJteu0L4tECAxa0EfJmynoEnAStvw/8uZ39+dJPNCL59CUNRSvVI7vYP3bheVVQNiXR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVlJBI6NV8wYk2UU/uemcuMZDi50LGtf/L7IEg2irKc=;
 b=UCJLbh+oZlZgtf+DY7a6A/46xPk+VtdLmreINoxoAUdKcALfPDw8W4SPtfeLrYypXRdtd/gMOt9K7qFL8JEa86dTRGzqEgDF2ZpECjHOGG34EZ45x5MHBNruqJ19ayzLSPhfZ4hSjUejpBSn8tC1NMw8P8RqrPfHUaSgIGMeV+9t97KMKDySkVhd3CCP2AWYj6uRfUAIJKPDFWaS8InkEZ4ffq40Io3UISubo2rM4PM7IBqK7cTLbKFw8OZf0l1WTIR79lgwILaTZvI6vVz9pCCYwu0OP2znTVaCFKbVBAo8FEzCtURY3uZbIe0nW2ZCI+wcvIMyeEFVC2FlhbzJHQ==
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 12:29:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.020; Thu, 24 Jun 2021
 12:29:58 +0000
Date:   Thu, 24 Jun 2021 09:29:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next][V2] RDMA/bnxt_re: Fix uninitialized struct bit
 field rsvd1
Message-ID: <20210624122957.GA2879416@nvidia.com>
References: <20210623182437.163801-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623182437.163801-1-colin.king@canonical.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0077.namprd13.prod.outlook.com (2603:10b6:208:2b8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Thu, 24 Jun 2021 12:29:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwOUX-00C56M-0Z; Thu, 24 Jun 2021 09:29:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65667c7-a037-4038-3ca9-08d9370bc742
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5380AE60B4477075C6963F4CC2079@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kziq28w18eJLA6ZbRwp6w4gHf1sfQX+c2mU5orsRLK+KVoXi/lHEv+YSYYa+Zml4yOxw5D0kL1sWsA1bbCaONN6HPwO06QiNSvFm7VJbrjOCd/nnIkEPZ8CVnFqBlEhkOVNVl0+gBQJJP8oCw1lfRTOzm4otVu3TZfp4BCTUPlJI2r6OfNdFYyn1WdC2lRUAl0XTDKvX7avPdR2WBzr7vt0wxJPRLXj/jktEWzP2DkvwnFdzwGtW6CLL0kLEoDwQdpCLYC3J+8OCcxzpSgUTTdPlk8PAHabCD/vwj6PS5XTgcJddOikBHMGR/tqg5doGIlU6aMG48WSxBq+43iodvSzd/A4s6ooY6lzPlX+sC6/sGQrE7fXLocEjhOyCxJJ2otNbhixbzMbv4S7edVnHHaaJiz5hajBmG+fE0epezSnJUDvsNPVPrWo2c9laihBpc8F+dYp/zTf8CyDH5w1s10qrbgwvfdF8T0ZBQebZrnxgoMwxKHX8cT88PU7qTXWK0V/uPEKpkScn8bHpQfwyvi46hoonW3vC8GtrnIzMuJTu9BuGHzq0M5tpOYpOtOLb4KmKvYEpHyRB0DNahviQc+5xqcIjpcTFcIoszjoEnK9oB9ahU3nn5Vzxtt+9HapNzZ7IFHR0AtspQGxi4AzUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(376002)(136003)(396003)(346002)(1076003)(8936002)(2616005)(5660300002)(478600001)(38100700002)(83380400001)(4744005)(8676002)(2906002)(6916009)(26005)(186003)(66556008)(36756003)(426003)(54906003)(316002)(9746002)(9786002)(33656002)(66946007)(4326008)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgvbwM93D/VlHEhV3qgg1NU+Wm8ovEaYOHY/otey2kenUDamMSZ9hBncO4k6?=
 =?us-ascii?Q?nMo0Lx/z6u7nKZwsaiDvj25cX+gR3YjgpldBrU/yC+xixI7qLq2XqJNARP0s?=
 =?us-ascii?Q?bqQ4uecg0pG1oA3LibXCnMeo7Th8S209ysOohnAV5K0dr2xNwO6bV4vfz9fC?=
 =?us-ascii?Q?ifcoEfZqDU6z87nzdGSgv5KWEMwz/mP7X2nI0+vqOEadT2Gi30mX4NEWJ3F0?=
 =?us-ascii?Q?7IZ/YQbXuj3ZLPR5Odx3aREVbAZAn1DzxEidE1KiEeT5NysJy/7ZJRHza2tB?=
 =?us-ascii?Q?+wzBxFeEoGAiBrSTIOIOngx0lAi0LLayhdGXHqpGujiIQMI+cG1zYRX5QV1l?=
 =?us-ascii?Q?Xo2PR07GwlIGNou6Cwj6/uQCX8GQ/U6hRiV4bVj3/Zd7nDWtmapb7KASDZzj?=
 =?us-ascii?Q?+Dtt8T/XJMRVQiO2/iNBrLEFBvRx7CFUKvATzLjepnwMjbN84EpomPizHfoc?=
 =?us-ascii?Q?eqiuRlfAfllzobHlsD0uNAIq1dJTdl7WoJjBW7S8l3qWWkencw+/MGlqEc2x?=
 =?us-ascii?Q?LM3Hmeg0Vwwkj6rAsNwis80ll9tmQ8+Qo3FISAqHT/d+x+CxdNAfhrw0roxj?=
 =?us-ascii?Q?mIZZvc8zhyfVbfxq9udqxIY9Ko4OUXRCF3dBBUJFpDluQrt3NPUR/HXYkxsH?=
 =?us-ascii?Q?DCcq9Ns6+34pATQoYizswEVwXNJoA7UFmicJvqks9azmBHJNgctsihatgIsO?=
 =?us-ascii?Q?Lk8gXpkCrPUQNnx1mRlPi06iIEoj26ixn5EYz8Ow4gbKyZoJXgRzxng3XIZZ?=
 =?us-ascii?Q?OIOclO70wM2RGU9wvJWXW8stSPL5aVmvn1LqZVPf+CEuH6e7gFFiQwgMd6/7?=
 =?us-ascii?Q?J/vrBVP2eSO1SnbN/N7nfU29w60k23nuxV7brreVCmiXQ2hT0oXoqe6eA/sK?=
 =?us-ascii?Q?vJWkSdijEYBijRT2mp2U5GEjMLpBx7+0i86RcI25zdAjWP4w066wjDuAeYdy?=
 =?us-ascii?Q?qvSUWI7AQZormld2jfYlYBvdG3otiU/98ldKawJw9QD118VabShCehKhPJwi?=
 =?us-ascii?Q?psttYpryiXP7dhnESM5sVcYOiWEUyLmB1kh1inOucaTAVYFVZdNR7kL2jZFS?=
 =?us-ascii?Q?f01gjd9gi+bfnzSFM5csJsZ++N+vhj8voCFWmE5IDlUUI0wYp/Lcl/eHGqfP?=
 =?us-ascii?Q?Ze+TX8xOLo3P+OLSiH3wcgOy0Tse86fbRmm/dlVGV0pBiQTLOXekyP+GXDk+?=
 =?us-ascii?Q?RRfCYFmCpnP5oSX7/imgBw8yKnbcDfIAD4443hWT2WiseUSZWSq3acoag/mo?=
 =?us-ascii?Q?qUBIyosgIjaS8274FLKP5unj6jXrQ+BC1tMvPiU9dJ98BqUwS813dH4gA1wm?=
 =?us-ascii?Q?qX4Smj6GK/DgdG9gEgqNvlp2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65667c7-a037-4038-3ca9-08d9370bc742
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 12:29:57.8931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUcr21tzBJlBolHkRhjEIRWaYyHp43zklkeCI0J8aJuv40Gvx5PR73YJK3lX0NR7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 07:24:37PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The bit field rsvd1 in resp is not being initialized and garbage data
> is being copied from the stack back to userspace via the ib_copy_to_udata
> call. Fix this by setting the entire struct resp to zero; this will ensure
> that further new bit fields in the future will be zero'd too.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 879740517dab ("RDMA/bnxt_re: Update ABI to pass wqe-mode to user space")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> V2: set entire struct resp to zero rather than the new field. Thanks to
>     Jason Gunthorpe for suggesting this improved fix.
> 
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

I amended it to remove the now redundant  = 0's.

Jason
