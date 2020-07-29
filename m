Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD22324EA
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2SxK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 14:53:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:37343 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2SxJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jul 2020 14:53:09 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f21c5920001>; Thu, 30 Jul 2020 02:53:06 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 11:53:06 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 29 Jul 2020 11:53:06 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 18:53:06 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 18:53:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdcyT5ZfeWNPcWny6GbnFEsRlDX0CLUIWpV01efAae5sBXnXolhASfain7n/HooJuWuSUKGs0j7GyR0qWj9NpDYhfzT7M1YuVKspWibpExoQ79kXikiVQ+rRTBTN4AfU+BzCiBHhoadcxG2VTotTnWrwxaqAcSALvn/mc8bSDTBX54a0e+fNC9hyMb4cHhDQvuhLJVt3KDbKRcOhX7JT/WIabKSfOz3xvJ68OfLI9BgfYogfq0TUxeCHNto0btvg76zBEYebzungW+2eZ94EeHzvWTYKsoHimU2QW/t7DphqJNih+UPIyr5kALnRGI+Qhcyc35CEVet/sH9KoxqeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvdhjq/rJzYpHg4QJtNpYlosvS+NK4gLEDKHXCaCN1w=;
 b=eB9M+p/6/uIvUHNw5ziplDO+lVOsvsc8Oa0YTbBgPs6uAz8U6xW6mfEdsuDKhDSg8ddaT0JphezdK6OJhIx6EvUWuD1Qx2OQcyO+ipa4jZAPlWvnncwaNyQdGprHNYOKrzCdeZ7IDWo48YiY1EmHqWar04NV81wgtGq4Byag9oF1hAqEiU5kBVnRICUvA9Bb9DzNsU2Ext9oIuKNNOp7N5JHAsk2ePH1wDhkFy74mopq4GvaSNCvChoT/vGD9s5gnFbOpnlCrM4M0q5tVXcWVV86B2+oZIRkbFXL5P7Hb90cR4ZpTdOngajX+agUgxwkLYTT+NWyQ/G1gOiTMJgXew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 29 Jul
 2020 18:53:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 18:53:03 +0000
Date:   Wed, 29 Jul 2020 15:53:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markz@mellanox.com>, <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/netlink: Remove CAP_NET_RAW check when
 dump a raw QP
Message-ID: <20200729185302.GA274983@nvidia.com>
References: <20200727095828.496195-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200727095828.496195-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:208:120::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:208:120::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 18:53:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0rCI-001APx-Kc; Wed, 29 Jul 2020 15:53:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f6af05-2252-46e0-e044-08d833f09f94
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-Microsoft-Antispam-PRVS: <DM6PR12MB33080F017AD1D2E35ED9F03DC2700@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/5hgdaO/9APgIkudyW68DiqkQgCrPHhU8MuX21QsZqrtXJtoxXWInf9HF4MmLVehBg5Q2OKAINJXI0r0HGllSqjsGp/cAoxderPMFLQPyKB1gUAG7G2O1cc8paTf/QPSKMpz2M7AH0jMphbeZVmIFrv8rmOJ0c4AaOVLcqtg5pMJOhilOXLfrj2hEqRwbPEfMliIK/WB9CKthjHeX3bXvjGFG9xv3Ai4Ix4/vz/iS7bMTGMaosrXIKDP49yvg4FQr/8tEJHR8alBLj13AKYTdV5F5iHOPS/MqS3TJRdlmIA8c1r02fPR3EW2fjJpT7bT9EeVaR9oUe666cB+AAIM9P5ae3riQz6wHyrCa7KMqV8DAwz5zctAmSZCIZkgNCA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(66946007)(66556008)(66476007)(36756003)(5660300002)(4744005)(8676002)(6916009)(33656002)(4326008)(9786002)(316002)(2616005)(8936002)(186003)(26005)(9746002)(426003)(107886003)(478600001)(83380400001)(54906003)(1076003)(86362001)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oii2gL9ykGosBAjTSxeLluK0ZQKhzx3KpyS6Ewoig+NTgIBnGfUPfBb7nIgmf/q0ZlEMAnC3vTvHiF/r7EZBR8EmChErJq7R5yGb4fiUAaAEG+ZD41x9QeA9CZYe7WVXI1syEnM4v233q2vkq3xbHvnbA7L/gjlrbcJieWvkRcGeB7lZL0Ce55WV/Kk0E9QLdBd0ipRuqtndW6pV28Y0SfHkYCPxKThh7iD8mVGdJ2wOG8aGXJUi4pxpYUXlnnHhx2FJueQTOd4Vp3Z5fMlY1YJ8hhmb3R5gzGwSjxGGc8gMgA6KJiNWnvDdH3rIRziLqvaEtKJ4grskTuTHvW154XPl9av+oZHcN74TI+Eg9GLPU42sDUmXB456FoLe15cwv0+BNO34P+pXcXk9vTKjgCjuZO+tcvYn7LCQkIE4vrdt4rtG1e3Eq/px0EkjnCT8ZLr08lbw/TJ8EaIk7g491bWc/iZsr10kbg84nyZCjWXpVeNv32qoTsqls/PaLpmcn65L+9mxcdyz+sO0K16xseC+sB7YKPCGT1KG0rDQc+gWF4HPe2kPiQox8zYZGP366PjUGbmWVZX1UrFBC779nHplHc6qFlpf4omgmXF9rL6p25gXxdusBkQamwaXDKSjudQWs0fqnUNuGThSN6HyXw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f6af05-2252-46e0-e044-08d833f09f94
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 18:53:03.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzLP7EBPAG/icB3dTS2n6oNfZ0kCjRWJGHmYptIc8rtw+xUp5ejXH1A53loS37vP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596048786; bh=Uvdhjq/rJzYpHg4QJtNpYlosvS+NK4gLEDKHXCaCN1w=;
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
        b=RJApqCxfon+7v+Z8VRjZj2/ZRMJ4oVB479PEIUAkLtbNOmjwHah5LVoMAZU4mwVdY
         hbATL3Y3R4EKMmGGWuzxgJoQdmiataqqjt2W0yqUw3n7gPQY2G888WpPMvBG1sOdlE
         /xgzLtDcMG1ZZzRuHV0secpAjQIt4RyJ0FY1S4m8mVNhK1JRmwnyohNfrBt/5/4qIE
         XesnsV6bfR0I2xU4D+07CAW1wqIKknse0eZmEzCWKtMuHN8JF9QtwEwTpmpRSqfO9+
         u5w2sqdSb0eVlDO56Lf42+htKDlLrj69wn3lh2LayLAeWGyou+xeUMw0pPHKRP+wIk
         PQLTCJHtX+44g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 27, 2020 at 12:58:28PM +0300, Leon Romanovsky wrote:
> From: Mark Zhang <markz@mellanox.com>
> 
> When dump QPs bound to a counter, raw QPs should be allowed to dump
> without the CAP_NET_RAW privilege, which is consistent with what
> "rdma res show qp" does.
> 
> Fixes: c4ffee7c9bdb ("RDMA/netlink: Implement counter dumpit calback")
> Signed-off-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
