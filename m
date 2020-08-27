Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976D82548B1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgH0PKo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 11:10:44 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:43555 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgH0LsF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 07:48:05 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f479d720000>; Thu, 27 Aug 2020 19:48:02 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 04:48:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 27 Aug 2020 04:48:02 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 11:48:02 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 11:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVO5PP+5HOmCXiQ9AMz48FYgDeJAnhkedxjLlYRwfGWpXW5XW9z4MfG2fCiMFTw1930tRkLSyzNoovXLNKlUFcFDVVjOSenV39iWVWLyq+ffAMYpESMtDVYpyJwC6d+ng59yperm8aK+954ItBMvD4POuLZrT1CuW8L3dgeygHp9urFSAAA4pHdYKjayOtKxGhSdJsHylCGcvELScI57Ab73DaNfQcBa1iCokDyYLvPgjZ0eF7dn6wlDLL/5RVgePOhksZ35W38+l79oCs4fP8m0SzAKlAzM3XSjjPAw0mgqsU2/yMrvBrPoM62VB3HjnZeeP6UiVA93Uv2O84rWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zo6Ke2qK0TIlHdBdxUuscYCC3G+zz+J/TRn+dQ31f2c=;
 b=GWJnkg9zy0zdLYpnYiycWRqk7w9NDyAY6c1Fo6avdjJmKwIi86NDdbe59o3X9BBkZlgXdzvqdpUM1BsKVZY9tz1vW3iLIKUA9SG2o8TqIXcl+uoTVlpq/Haf3JagZ/WlXxakOu5tReYKPxXrLA7er48tCrqPH9HHQ7VOI4iGhxISxW1rwIMszRybqONsWsR6IZkuKeRKRAK9IGA+oN6BUPyE+dR8mwHhQQ13sBvRq0thvws2MKTUBOMuIQGTsU587IptkAoa2Q2fIMUCctLpkpUu1+zswFC8ZUInViKUToFOAw5Io5QbSn1eVVwne3p1iAnrkZTxTpN199ARLfHs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: zju.edu.cn; dkim=none (message not signed)
 header.d=none;zju.edu.cn; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 11:48:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 11:47:59 +0000
Date:   Thu, 27 Aug 2020 08:47:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     <kjlu@umn.edu>, Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/rxe: Fix memleak in rxe_mem_init_user
Message-ID: <20200827114758.GA3997325@nvidia.com>
References: <20200819075632.22285-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200819075632.22285-1-dinghao.liu@zju.edu.cn>
X-ClientProxiedBy: MN2PR10CA0036.namprd10.prod.outlook.com
 (2603:10b6:208:120::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR10CA0036.namprd10.prod.outlook.com (2603:10b6:208:120::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Thu, 27 Aug 2020 11:47:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBGNq-00Gltn-5C; Thu, 27 Aug 2020 08:47:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35ea42b3-10cd-4664-a5f1-08d84a7f0beb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18822DF9E2F66359753BD2F2C2550@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ru9UI+tm5kcE93ZzeKKVBOqflUc9pUSj0l9NykJW/KxXz8V6V1llknD5WZCWXPT7pJhXK4PTFUbUS3S3cKMU/UL6nvUQPmugcV7qCs3ayHFTFyK8Is6dJhkPSpvY6n7NUAtJ3Y8bOon4yHt+/UBXUmzx7pUOqRrK3rqFsw9VSD/Hu2NfdJi5mrOJs5VjbemzE1Wwf75LVHtcSvLUxNXLsoWnOmjq4MkyOpuoGfTaDfcYnpUAeyjumryj7o8s0tzldJfk8zPPxmS4V+wcFJp3kn/C4OrB+MhC6gcVzVxreqJSwLtAByaesEb9WoX3jKS2mvZrslUotg23hu5iKmJGEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(66556008)(66476007)(9786002)(66946007)(36756003)(9746002)(6916009)(478600001)(426003)(8676002)(4326008)(2616005)(1076003)(8936002)(316002)(26005)(5660300002)(186003)(4744005)(86362001)(33656002)(2906002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O4Ks6C90Gn1SlbZxtZ3N8p1KgdCdP8I3h8yPwvJSjy7Ayyz+BJUMAlowduWFnuW59EZzsZyA8/NoGBoVzksyTMYbtZ8KLEx4WfhTDYakQw9wiRUd4gkobRYVGTlZET7HCN24ksOZU4w9iiDGBFrb5Xg9gryrUspM/cFUdk8aXuSIfWCTXIpbWYgUC2ilIr4lRkaYTV+MzSazgEOK/KjQ5eqKl2Fg9z1v87QOKqpQdK5XKCbA5W8B8vt0X1KHJphX2MqC3oXRWBQIRtsuvjXAlv2Z12Vae967in38cIqS5Lhcd03QL7+ftHiizfv8UCNmSZqvpYUxt5rjVV3HyeR0juZhgfEHaxbwr3vH51q2qvtmQRPl+ces+e4cHRIJwEpHnVcn7We6Hp55OOvvIpGVqkYVE+EmdSzEBUaZCSeh9I6y/ckk5RODOcC401GPjQPXrNwOxftOqjnYuYIw1X4DcSEACYK1R8swmGnH2qMCAWddmIlmMwf+5jnjZXlTjtynrEb1uqsbKYTT+6d+IC2fbiwlqT3c9z5NoCpX3XQIKtxcQ/PcX5S9qFPo6Gfs1ArRmxhqswhDx/qZrFVpL3NaqCyYpW+CxgNhln9UaMY6RX6i1++3TCDI4Cf35LsSOWeVyHYAh4tJ4JPeJtSrErBFCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ea42b3-10cd-4664-a5f1-08d84a7f0beb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 11:47:59.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3izvq9Zq6xTzjCXT7mXZJOzIjvOFHkKEZCn8bkiISLM26MiPlIedCdYrj0t0uq3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598528882; bh=Zo6Ke2qK0TIlHdBdxUuscYCC3G+zz+J/TRn+dQ31f2c=;
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
        b=eBtTDkomGIL2e423YHt9VLpIsQSIA99ITUD8xaEWIWVpo+p+OZiYuxCs7b4vH2XEh
         QGR4z+WQI/jfKxUMEbjKJ47mSlOKyrfLVOam+m5wbl3z7AE35Qs1ONCY1edCWnchj9
         ZAlLCYrsc850oHS4lgG7tMu+jalmiw6+3TznBNVT5lH9xhwClV01nV3Vyz3tSzSnOo
         mKIAPZ0Fr1OJr/njLyy5lZ7W08Ido7Q6XjaazvAb2ZyLqTzPoWTHUvZPZCWO21i9Gs
         cox46/kKwPRxG+I2TfBR9SA9yg0BLlk1volCFl2uTCiqkB4CC5DklfrTaEz0smBVn5
         hKPBFTa/53vHw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 19, 2020 at 03:56:32PM +0800, Dinghao Liu wrote:
> When page_address() fails, umem should be freed just
> like when rxe_mem_alloc() fails.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, I added a fixes line

Jason
