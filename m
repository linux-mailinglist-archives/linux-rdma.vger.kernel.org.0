Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04589277C30
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Sep 2020 01:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIXXKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 19:10:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15096 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgIXXKs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 19:10:48 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6d276b0001>; Thu, 24 Sep 2020 16:10:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 23:10:47 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 23:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZbbXBgNDss0aWzL/Ioc5fJxgru3DAR/RXk/PD0lugGHxERvhCEaH7WKbMjgJnPryLqTLBJND0SZIftCxnjjHl4AGW1oll9/7ULipFI7ZaUUYpVGJVBR41xBw/GC5e/NbCWeN8ydT/HD4qBkX8KJaSUmQCQ0Sqj4Fm9AJNPXDAZXBi5mHuWZvXR1lTuupkf1vvztRu5MI1vKFRXfkthUSfOx10O2PcmeshDjEgxg85Dr1BMgWSiUUECYCFqteDz91hzoOWI73iAHXKp9eoENMasloPBfEUjxotrWEJEW6Tdt0tC931SP00dcm4e+HJn8hJXJNlIegpNmtNlAJI1wqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Tm+kd0lQv0wO515N0ML0ChwVm2hXYjMlZWybsHpYgc=;
 b=BSV32j9hZQN5Uw3rRpK5caUEExUHYWPUGzYCnLrpx9XJiBIwchaOWgSHLHW9WdtPaAnLELaNYVqgwm8v69iPKHpCK+VJPshCiKmLcXXJI7W9KnLzmZ5q0EfHRxYIUpo2OCf8NJqXsVB42q64gkbKFsqmaJZP4H1UyH3EKJ/ELsFZY+JS56LqLiIYk7ltv7rLr9FxCIBJ+vlXJsZOocn1H3++KQc+thX7lTtlmBgCoj3HPVy4NqGgoe2wwouOtzJlSU472K76ainTr04+EH5SBShBFW/9SN1caAFFH8XDAwsZqYvg5pYhxiXHToft5YW145TuYjrY4KAjXgogNUK8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Thu, 24 Sep
 2020 23:10:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 23:10:46 +0000
Date:   Thu, 24 Sep 2020 20:10:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next 07/10] RDMA/core: Align write and ioctl checks
 of QP types
Message-ID: <20200924231044.GB154642@nvidia.com>
References: <20200910140046.1306341-1-leon@kernel.org>
 <20200910140046.1306341-8-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200910140046.1306341-8-leon@kernel.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:d4::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 23:10:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLaNw-000eFZ-TW; Thu, 24 Sep 2020 20:10:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfbcbd1e-b3e5-4541-8095-08d860df1177
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487E1D5D12731DA71F02EA4C2390@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irywu+ha9cmlKBopfhv3oV4F2Sylsr5qlOFt+mf4XMsv5jrTI8JXrnpMmWVYUGJSe7/wU+avxxvwZc9nJc67IAFgfRGJnwtelw+gP98mp58wN69vBb3Y86dtaWEgRvj+r1nD9JVX0b0SYCssK5ZKtvmogUevEDMj5V4QxuyKGzxppg/yQdQXbGzmPh4wapv9lJXx9O88xMcDCw4+738DtXDBHObmaLKydM/gRaPOETaKrP/RNrxt6xsDfh4CZzGoeWWYXu6uQ84A5qRzBOdNzyZOzt2G/5k2ZF16rkTMU7k6KO/VQzI/s8i4TmR3mB1U8/9QdrdgJPwmFDqsFsfUtNRcKtxyUUklP3Njdy8k5b8fBt7s3CpwfkmtaXYUocSr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(54906003)(2906002)(316002)(4326008)(86362001)(107886003)(426003)(5660300002)(66556008)(66476007)(2616005)(83380400001)(1076003)(478600001)(8936002)(9786002)(36756003)(186003)(9746002)(66946007)(8676002)(33656002)(26005)(6916009)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: y1HwQCvsB0Dc+TKvkIaZnb8pD2+rppdwqSd3Gs6e714L903+oC3gGe6MrZh8VSsUysTXSssUC1R03h3LqNyjvugtpQWuG5JriTTcvFKE9E3f9Xr9XLC0G3iNUm75Z/Ja2YjvlLt0dIZidM8TsdE77ZG5p2QL5CdDdsSDxXIUwvFEtnZU/a7YEueHBhxADdxoezncKo+JqiEGW9/qU/wvOwD+NE7nb2/i/wCbzhayDMUX/vhekWGX8LavfaOrCjv3VQ+E04zjaxVN+13WQ38cmEp7kzJ3Nsu4/RN6uzemXANVGKh8PCEATFRibAV12xCz6xJEM/XApY3NEjyffrqFt3lD39ulYxZJ7mnwyQxmTk+ymWUjyueSvRhVWVp9WZ1seIavK9gMJHDcr06iqQWbI5BIQKL2Ihw955BuCKw14MHdvdPlOihQWadtCvMOoxrquwvsCjUIUdT9qEOTXb6RCXoJB305eBL0A4ntd6HU6ap8RYGvZakRiXpaZu3D4rZ27kECqqorcYwS3Zt31DVA0V0qlRCxpXj6DLINe3Mn5C0XJPKiJQKaZKXR2HulsdnA/RS09coDKQR69+9q1O4L2RvZem1I04SBZImbNFZB+Ad8d5pPtqurEIVpzEX7YV/VMkuhAFez+9/Xtq79gWyykw==
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbcbd1e-b3e5-4541-8095-08d860df1177
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 23:10:46.2171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKacONYJJ2Fm1JHED4DALfhElaFuSoyx4jiRlaSYBxq5w01jRb2O8XB4BMbO9PJQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600989035; bh=/Tm+kd0lQv0wO515N0ML0ChwVm2hXYjMlZWybsHpYgc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=MQJMriCwj8j5F1XLvSNmuPf570LqAvA1MrtODgrD5MTvSHAghKvsZ9fZnv38Rfa5E
         CBgXACxH/S6QeoB7e/DOURB/a7MEGntusmbrLc/GiLnwNorViv9R4umkZ7aThaoYoA
         k4TJG/nXVP7WZyjrxu/Ww50FDUE/PgmCP5l3E0ncnRAKlZkhw9qXskw2eFMTv+3Pxu
         XHTnLQQZ9T7tkYHPCyQhUq4IWfKKUw7IcuuM8pIgT/FaBQjfLH7zIA0l/+4UEZmYMT
         9+SpEjTJakQ13phmJQqKFW5EoUCrreQfUE5XIyDXkgOOGTOuXPZgefRTOLc2lRCj0/
         hN1j4NMJI+Vvg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 10, 2020 at 05:00:43PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The ioctl flow checks that the user provides only a supported
> list of QP types, while write flow didn't do it and relied on
> the driver to check it. Align those flows to fail as early as
> possible.
> 
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/uverbs_cmd.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 408a1a4b67f6..b4e383505eda 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -1275,8 +1275,21 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
>  	bool has_sq = true;
>  	struct ib_device *ib_dev;
>  
> -	if (cmd->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
> -		return -EPERM;
> +	switch (cmd->qp_type) {
> +	case IB_QPT_RAW_PACKET:
> +		if (!capable(CAP_NET_RAW))
> +			return -EPERM;
> +		fallthrough;

I think the consensus is this fallthrough should be break

Jason
