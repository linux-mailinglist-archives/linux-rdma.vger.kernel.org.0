Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686A8270931
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgIRXlD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 19:41:03 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:39449 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIRXlD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Sep 2020 19:41:03 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f65458d0000>; Sat, 19 Sep 2020 07:41:01 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Sep
 2020 23:41:01 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 18 Sep 2020 23:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvIT5vKBqMbB6Bie858ji/V1YTX0TLI3F7/bDObR9084B4POoKVXzY5rMhkZPly5MI4dEXOM4BTI57VAEXdx4i37CctD6+WrihgTJziZ//gItzsnwpcX4zlQNYJtRUdnHucFK5J3F9IEkHPLMhxl3gF7/Is6TUdsoxE7eTRRVRF3vaw8/kl7ggP2/99B64JBAi1lHJoxHs4mehMsPnrTU6vnT3IokoeAv7yj2EkLhgS0DZn+y9oG352aH7/6fGt8Rc3kAdy+Y33uLAQECWp7x5/Vl1LgUVIhC+xu1XwheS/aqGdPnMmCX07OMYeX3tP2P+gpgYeQaMcUJ+0INj+g4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elp47yo9CCBFXnkFKUMDGMtrz13Cmj20FckLuwG7Lyg=;
 b=ap8MjgrnsHQw/GDLWu1DmLl+EbgYWCLA3FPOTLs/GEb0w3hpeG/0AnhKPQVqTgRP+Y3hr68pv2hS8Q+OvWCFkxdV1SqpCV8O/8gIzWQuimB97ka88zkQAutbr6av4lC+oQsErIb/AF+fA+e3twIhNQpS9SioAY2b9TDERnOHhwOkyQEW3n5yWopqcz8C1ffuAD5aAfJW2n2Uhp5YzynwTbIFhJ+napZGqxepOQCdacH0SmSeAyAjGugWESUzSFa0U9cNIxyhEhpeWnvehgCQz4MzR4+6UDXD9qRMJsZ5jkyuMYLQ+g1rANfSAFTYvyJK2vYYg4n5WxRXAXfNJ3w5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (10.255.76.76) by
 DM6PR12MB4041.namprd12.prod.outlook.com (10.141.184.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Fri, 18 Sep 2020 23:40:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 23:40:59 +0000
Date:   Fri, 18 Sep 2020 20:40:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v5 09/12] rdma_rxe: Add support for extended QP
 operations
Message-ID: <20200918234057.GH3699@nvidia.com>
References: <20200918211517.5295-1-rpearson@hpe.com>
 <20200918211517.5295-10-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200918211517.5295-10-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR10CA0031.namprd10.prod.outlook.com
 (2603:10b6:208:120::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0031.namprd10.prod.outlook.com (2603:10b6:208:120::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Fri, 18 Sep 2020 23:40:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kJPzt-001tbY-Hp; Fri, 18 Sep 2020 20:40:57 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ffc0fcb-bc08-4a09-5d10-08d85c2c4b71
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40413EC52742E2AB6044232EC23F0@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vH0rKDOotaV78NjciitnvyDN4RLGhrvwCfbD0rdVlaBujJKEt2SPkxhDmZuMBOGAaXGNJCk1QNrk4WYq8QPkE8rMTSn5lxiglPL5lhKsvQP6MNDdAUHTswKjaRWeelyZ39zMf77nB49+kCIegPWGTo8SgwMTTxVICBgA6XFhNhUR+nmDlFA7Jz8fenUXOWU1JZQNhYjitfZ2tLz16ZOXgGIkOevo6AZeYWMiFEGFSQHP7qc/EJNOmPYHhb5vj8G0uOtJEid8TlYjSn4Z8wFAnKI4u0C/87/cm/7ELow/We/MZynpXQSxMrGWaK1ZMI66NghX1i62NJb52DVI/mD+lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(8936002)(316002)(33656002)(186003)(8676002)(86362001)(1076003)(36756003)(2906002)(5660300002)(4744005)(9786002)(66946007)(6916009)(26005)(4326008)(66476007)(9746002)(66556008)(426003)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ziXuJD2yUKwnwu1rrWDS7Why9CWuU6qY3skR6nO5thw2b7RmdSZzy4+X/EZpupMZ5hhJed5ZiQydAyfKafW54jDL5/baFeo1R0IiWILQv6lj5FolxATNCoFAoYHwtyE5rbSAujGdrNVZD2m2caTjrkokEEq8zAGMCn7/Qp0N7wOZxay4PahTmCy8qUd87QDe8ZNZ4edku9/2n7MKiPvmF1up451CUzukoKvG5DW1d1RfCFBuYWJQlbbnU5W/HMlp/IbEuAeQ1FITu+YbqfoBaFaEii6UEkX8k9bD89P/hgWB6fo8piHUx70JE5qcXrxf/0Dxlim5jC4+FHApyN6WyKjV0BLIbaNqlgmwM4eoikai/dZYNCFs9GgDhrn9AlgS8XMfnFBnDra2moS0+JUGBiF9X8bqubJg8vyK5Ma+7DO6wmMYEQuUMIzMHfE9XGqyQh7BVcBHD/DLhMZaqaSBfASPdezQdz6MjT4g6f5ygedw8XYM4zreNJjWNRjfbTMhA80heT/gy13fccnsR99u+k8rKXbhvOR2DVLSvCoda/vkuKkFVZCxzuqUVET3uR9wTjmFIYIWpjNGj7pQgjhqLC++aEipCg5djjlEoeVFgSamt5CEwa6iMDFUCgPrPB21tdVY/PyVXncAkVOVC6O/Sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffc0fcb-bc08-4a09-5d10-08d85c2c4b71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 23:40:58.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROZiEIo78zczbAt9BlYLV2Ze5xb7OekoFa0rSFRqUpEARk57btHytam66rYVhzA1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600472461; bh=elp47yo9CCBFXnkFKUMDGMtrz13Cmj20FckLuwG7Lyg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
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
        b=kOtexIb7z0E01/a9RuWJRidSWWWSXt1n+UdogyBHOPqFxljw5XCjKA2uXwl93TYM4
         xEigf+EAFcYifUvEvg3YtaWCGZU9oUA650NR+vn5i+1uoo5x01yFS64DZcY7t86a0h
         msoI1YL0D/4oAt9BPs81dBaez6K1LBlDN0Q4bSU/ZwSNnwRWvY2Wi3c/K9z+6dCy7S
         8SLW4PUWhZjWtsxpzOs8rSbdiIeNqgc01d37UkHwEaz7pLG7VPgE0H9n8MiXNwX7/f
         5v4JKambxKoYs/JbNiiLYMyV9r9lDnBDvvCB044fwPTBWuXv9/wAX8nZzN12pqFJi3
         EXMTVHCLesPpw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 04:15:14PM -0500, Bob Pearson wrote:
> Add bits to user api command bitmask.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 594d8353600a..7849d8d72d4c 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1187,6 +1187,8 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
>  
>  	dev->uverbs_ex_cmd_mask =
>  	      BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE)
> +	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_QP)
> +	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_QP)
>  	    | BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ)
>  	    | BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ)
>  	    ;

Again I wonder if we should just set these always in the core code,
can you see a reason why not?

I really hate these cmd_masks and want to get rid of them anyhow

Jason
