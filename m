Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23B046C308
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Dec 2021 19:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhLGSqm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Dec 2021 13:46:42 -0500
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:23264
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhLGSql (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Dec 2021 13:46:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih/dFk4W1f1mmGrlzWsrJuOfeipbSBzTd/BOcF3t/T3r3vQtcY5ygr4sUx8KARvJMJ9PV3uq9qQ1oQ9mnI3tUHEmOBtDeT8NB34/PTvX0v+NY8RJzcHWqPiereub3dKYL7JDd7S/WYsJa/5YtcuQ6L45coZ8b3xF2iPxJGG77blGAB9Xv5zKSyvlN1EHjXnjEv8JThAJZp7zRTp2FD860UvSTwyi1I4+mT+e1NinPn7NbVDZJQH6t6KbHWhXVwcY6AXy+x7faTornNMVlrawqSCXhrQRwaZFvi5ZCjiKVhbTM35EJdud9eSz31RutpxmA1T8V65f9tpambLM78V3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwROI3j58DpV6XbtOtwGKgz2HBJoW0MVLqNmJRoF+ic=;
 b=nBLSgbXkNn6Eva067LF8BcvLhjZBXoD/auvC1PlRfJrXnSanVgTizv2TQkJD5y3wnHLUUGm7VWdeA4APDF0icHe1sDzMb/hbuy4JfxhpzlCaisamdh2ky3VF3TziV5cv6BwOMu9JF/pg0Q9vGkM0UTiD34Rpytyktf3Zqa2hchMJ7Bf+yj68T2oDA6ZtZO78z/l1344KapA/bQYa7UbvdlkNdambyTml9JjlbBm9kr5YxwC2BS+60m7RbMjRposwByaPKRjbdsgakEZVrdNs72J+uwsAqLi/Vnd66vcDcG494wOS9M8G6wnAkn2esbGXp9ZNSRF3CPwEJwtPBamC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwROI3j58DpV6XbtOtwGKgz2HBJoW0MVLqNmJRoF+ic=;
 b=DI4u0or1PHqZfXTMSngWQGpNkBH9EOxvxV2K8Zp1RSDZrChQ73GZfKgixuA2cAqJU8JjMyg7lsw/NBAq1wVVViUiVMAl3knvV4BZJTNAPRTKIesdlWg+pjYMcqB+LiXsfpt8b03FOMZ/tegKTCF93M3IMu1pfu0CiD13N3AUF1nn4BDCrbuRIK06SxgefHu0EsVq4mFES5GWcGJtp4GjFIr6kLXEnBzl7KogEMEkkag3FMi06ZUt4pDXyt4wmyG5bG2UHj0HDIi84DRAFR5qpaiE5OweZIUsPxS7ICyJ8cSLaCYEUUuJBFWcIZUaxwXdW4efWNZYjFz4HjaZMmMBbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 18:43:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 18:43:07 +0000
Date:   Tue, 7 Dec 2021 14:43:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Let ib_find_gid() continue
 search even after empty entry
Message-ID: <20211207184304.GB114160@nvidia.com>
References: <cover.1637581778.git.leonro@nvidia.com>
 <aab136be84ad03185a1084cb2e1ca9cad322ab23.1637581778.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab136be84ad03185a1084cb2e1ca9cad322ab23.1637581778.git.leonro@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by SJ0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:a03:33e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Tue, 7 Dec 2021 18:43:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mufQe-000Tlc-6u; Tue, 07 Dec 2021 14:43:04 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab83b029-1f50-4d84-935b-08d9b9b168fc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53791ACA1CB4F22037815DDDC26E9@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKmApornmIOdddzW2sDj4aBoifKVCw59ozSb6XZUcJisG7d829yr8wmdojq/hus5aStIULCqQ57khH56FrDSy8SpoTFNFyqnVwehlOY1+H1O+zNHVcOpZ8zlzVlBHvrUj+aqKDhZj60K+XlGgO2YYfrq+Bqztt2GltTOV07+FW/7bdovhWqeNUABldtTHjgjje3+4CQhdQktP7JrwyxOY+nL3Nd663Dwk83exbFP2kI/ENQtUObauOyeLHJrSRDtwFmwctOBI0zpbkJUPpn/MStBDvR7uSyD5KyaJolpOW+n++Hvs/A9PSOPSei5sH3VUsIlZmP3fB8oGBKEIU9xAJV/uKg7YDIe7kbCi/wgJC1f/4CAhDDU30IA8+I6k0G9otHVwx2yPyj7eCRvVcy8d19lRQdcwDY9uVucZH+gGg6bjx8lW/Pb27lL3+FwOia9CuJmbQuZs3ey9rFw7dTP4PxPM5qDL7xDoea1e7trc6BEAiPi15k+UF6NmaIKESHF+FwyN/NniyK6I3EBNkxSVDZo6W3H8GAhEL3Xaq87J5r4uk1rkjBazEYqKRiQzfXA4rGzst0fkg879PUdlO4r9loNKvPigeiRF71OfrLmCUozQzQSR67LRJ3cZ1Ss5XZ8uxoD3vnmPmwDVrNEkxyA0pEe/hsDXduSB+6o086Qu4qA2uED4AZtaLZxXrF+sCvDIkW7DDBjtJGpIX9SSbsoRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(86362001)(26005)(36756003)(426003)(33656002)(54906003)(186003)(66556008)(66476007)(8936002)(5660300002)(1076003)(38100700002)(66946007)(2906002)(2616005)(8676002)(9786002)(316002)(6916009)(4326008)(9746002)(508600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qZxK1wEFC7FtQd/88R1lxbI4uvtWp0G3EdwyGHWM8QnhahjnaliAZaLtygPu?=
 =?us-ascii?Q?G09E8v6FpXWb8PUHOf6XX/RBi197dlTPs0kokBBkHaia2LX5gDZlsy+zlvBm?=
 =?us-ascii?Q?wwH5sigHsId1wjZOWb47JPMWZkQ9b4pfg/MFHFjentWk+KaV2kwworFcJ3su?=
 =?us-ascii?Q?Rjse/gaYVnzBhyYvpRsBhZXkEwX3Bcv07Uui8cif06Myy3r4tIjAfIQtAim/?=
 =?us-ascii?Q?S0GOMS37Sx9nX/qjS6aadDqLGBSYVuPRbfA74CZfJfuAvt1Y+PRQOcd5fp0k?=
 =?us-ascii?Q?VCIdG91GsLXIjBwpw7J+WI0ey+qjmD7XftK/4CY9pWWZP7R5HrZ57VlJlTXi?=
 =?us-ascii?Q?GXkVBexaVuKYKakhzNr8VpkMCAfgWJbSRI7rsFbTs6JW+oIADR4tJue/5bCH?=
 =?us-ascii?Q?bFL5t4HIAR7roSdqayCfb3iKXQ7vmdD7AZ40UOAsMpI+tD5eNdrdTRG/Dlr0?=
 =?us-ascii?Q?ifQLjdc+JgrgtElLby3AsdUC+5q+dBdWtIDEFSIEw21Cu3DZfTe21ksl45Mj?=
 =?us-ascii?Q?RpLFV4JSZ7g64F7rxBvILPzBsFBYE6kV/hr+ERQF25wdafOE8yC8o0ofKmgQ?=
 =?us-ascii?Q?t8nWwIaDpOzhJTRHAz4bpL+wadjv97flLaXHrIjJ9q30zUVdo+wdtktqjJP6?=
 =?us-ascii?Q?mcKOXhTIeveCX3QGziFHmnK5xt0tq/t1H/1LCQIXa+xj0l6vdbXh021O06Xa?=
 =?us-ascii?Q?syRTWx1A2M3GvsZ5xyfvvCIQyhOuPMCcS8ipK+1oOqqxWpP1sUeR9kQMQeSO?=
 =?us-ascii?Q?kGJh0yK4c8i+5cip7cHs52p6A319Og04yaOy4JaPU/wjj0zsnZfZG8i70x3P?=
 =?us-ascii?Q?HYWaJR//2efzT6IypYhWQ8WUU8qodiD3X3RMhQ3l68ydD2HUTUw5FmBrYyZ/?=
 =?us-ascii?Q?dVXuMPjAq2H/FGb4s8I9tuT3fWLh3gTz7XQ19y42zOJVoXuexESKnwl3Mcqw?=
 =?us-ascii?Q?ZbLyi/5zX2JJvt3AqcsI8JnqiG2Wq5KDnrPFaW4XZ/dtWnncbaYZYLxweZ1A?=
 =?us-ascii?Q?reObCRNccpSznfh1LOJlXFIkWFyBdv3g9uI5TQkhLXon6em0y8ZBKrMOZ3r9?=
 =?us-ascii?Q?JgXpFaEsKUipSGj3u+HSpEfZzX3R6ql7faWi4X25/yEQkm7WTI9jDRxOD4yT?=
 =?us-ascii?Q?2qlw6bMBPsQkJKrRGzNSeifvwfJydZS9ile+cT/ORV6ig7qUzU2599CZoQaS?=
 =?us-ascii?Q?cZ43WUbjVzZvPugDn5EZZUnKGf66a6ZVZE6cEbwseZI2lEY4c8GHRpDkgGj9?=
 =?us-ascii?Q?FqKBAWyXArn+IF7eOQZ41foykzyjAOqjjAr6HPQnJdoNycqLf7AMWiyhvxwv?=
 =?us-ascii?Q?RnqRmRXHBtcHWt+faRAFQeI62xeJl2QbYC43TMiWP3YHKV4tn9yHJE4C/4Pd?=
 =?us-ascii?Q?1prr6M9QNJmx+m6qh8sw0RkFHSnw0r5i8cfLoy5/gwnAhJaZF/F1LqKMfn13?=
 =?us-ascii?Q?g1fd1NSJsQy/JxWFLvE9KcOAg8BYSzj00jFxcMz8haPoTFDVa9bDQueB10C3?=
 =?us-ascii?Q?RM5PrgAcObuP4faFs/tQcCb/jV7snkFhn8J8J0VL+Q3HcGs66vEVlxpudOsy?=
 =?us-ascii?Q?4/7uWvy2QlMf2fVf16A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab83b029-1f50-4d84-935b-08d9b9b168fc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 18:43:07.2931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7VIZUiuqSQnjbC3KrQHffQ5/f4MQvbjiHL/jvayCba34s/1PMxMGAgIagV244iq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 01:53:57PM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
> 
> Currently, ib_find_gid() will stop searching after encountering the
> first empty GID table entry. This behavior is wrong since neither IB
> nor RoCE spec enforce tightly packed GID tables.
> 
> For example, when a valid GID entry exists at index N, and if a GID
> entry is empty at index N-1, ib_find_gid() will fail to find the valid
> entry.
> 
> Fix it by making ib_find_gid() continue searching even after
> encountering missing entries.
> 
> Fixes: 5eb620c81ce3 ("IB/core: Add helpers for uncached GID and P_Key searches")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Mark Zhang <markzhang@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 22a4adda7981..b5d8443030d4 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -2460,8 +2460,11 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
>  		for (i = 0; i < device->port_data[port].immutable.gid_tbl_len;
>  		     ++i) {
>  			ret = rdma_query_gid(device, port, i, &tmp_gid);
> +			if (ret == -ENOENT)
> +				continue;
>  			if (ret)
>  				return ret;

There is no return code from rdma_query_gid that means stop searching,
so just write

if (ret)
   continue

Jason
