Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876C83F4227
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Aug 2021 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhHVWZ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Aug 2021 18:25:57 -0400
Received: from mail-bn1nam07on2071.outbound.protection.outlook.com ([40.107.212.71]:58338
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230172AbhHVWZ5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Aug 2021 18:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apj6whX/G/PnEJ376l08/ZwaatxuIMWsl2JPlxwIJ46VP8ejqhzrqcA6gPYEAuuvmGQ0iDtqKTSMUwipj+tLx0819/fncQR/XabO1PhpxZZxLl3PoPrp8QG6OIgBtBrJsn10HlTZbw7E1xWvowmLZxp7favtr8gNbHUBUGdWbuXeqzt5JpYeGe3OCT6jPiOJkSl6i8eempmJLJjfv/jjCHQuClF/jX4pQeR68eY/FkRPC0xJuxlTiEXQEAboPuQm1FrM3nm4X2MEVLbRka7x/AHbnMwwwdKHbuhC4cD8xDwkT7zpTDXoIBbtHNzagFUxrlsVSaXD6oHjDxWoawbdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul1e+2W0PIoKhN7/S92FdpUZKmpnptxVzH9bqHOSaHw=;
 b=jpDBYI+I9Ww1A1FFNa8GX0SDGqSjEkJe5NxATAzbNySRaluPJzYo8jw9ar1GCYgh/LfSWlSkqIzIR48vrpk5L2WQmoRQoTmbe6CjYd21iAsTk5nQ+SMmRw7ZJECy7jRT1+F+MVTQmuWLgslfEnMxMA2cukpmYIU2LmvMDwbRqdLgVXrt8iEXzxNnBje/q9/x4s6E8s+mAqwxcPQe+lI3z8Fzlj46DNRoz+6+0cthg8P7KlVhj6XIiSsnAJr+A/mhqr91MsVagzIMIt+PJh98ZYfGOR/1/7tOq0RxUAh72JqD0R7/D21RcAl8AYW2FuaxhXlbVnUo4wap5FTdXCczHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ul1e+2W0PIoKhN7/S92FdpUZKmpnptxVzH9bqHOSaHw=;
 b=GbTh7mQtcjmj5bhfbFizUHh/i5AHYmUfRxwWN5AePUjlDcOUOzgo+Qp3ZZEgrnvdFyTl4GCMXLAl1tytOBQauGFUMoisshTp7Hz+ClRDyH342xqx+m2z4eZHjeZIDSsgsv7f3spyZe/fKbFagc4SKgZ7PCU0GHi7ZbP6cVZwcB66ZhwoEhu8Xp8sp988icwXxrOdmZ9p8iO+Ij1zWae0CmA4htS9m92B8cNFAK2OFvXPZ68dbD4VsGubFJs3OKzQLkD+O0ESyESe0kgDIEgPmsz560hwowvyr20I08oZkQz3TlqJXzNCx4bmXTWMtDvY3FI9NJzkXQQEphNBu3X0nQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5555.namprd12.prod.outlook.com (2603:10b6:208:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Sun, 22 Aug
 2021 22:25:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Sun, 22 Aug 2021
 22:25:14 +0000
Date:   Sun, 22 Aug 2021 19:25:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, leon@kernel.org
Subject: Re: [PATCH v4 for-next 00/12] RDMA/hns: Add support for Dynamic
 Context Attachment
Message-ID: <20210822222512.GL1721383@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <3b0d66e6-2e04-33b7-e6a8-e9a4ca6ec8bf@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b0d66e6-2e04-33b7-e6a8-e9a4ca6ec8bf@huawei.com>
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR08CA0008.namprd08.prod.outlook.com (2603:10b6:208:239::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Sun, 22 Aug 2021 22:25:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mHvtw-0035IM-6H; Sun, 22 Aug 2021 19:25:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2761fc3-7bea-4910-ebcd-08d965bbb619
X-MS-TrafficTypeDiagnostic: BL0PR12MB5555:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5555BA70E74F764045A87B06C2C39@BL0PR12MB5555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1CM5wuFRZ6UpJ1+HfXChLnBGRi6kron+K82+zzqv75ggVdCsQwaTFXUSnqkrJdP7uSzyPP/Zold7K3/NMBeeOYfQIUoskx0N9hNOKzG3EsfWFd72nHBYat9OOH/bE2hqcYz7/pe9CkDZZxDYBV5ZZQ/sedg9tQkzDYRLuWhgh05R3w9vizWHJBxxzEKFOZGOYplSm5U6ZwaApIITWe5ujvJ22fpUsOwb+12WhE1nPqwrnxqcVvAVlvIMghTfnbzFpdlWcLfu7nb4GT3S8dgT/TJe/LvtLJbrVD2Rw9yEiGMEtTTduiItfJAtaahFA8LCeCK0NMAwULMvLMF/CLTz807CBqGlX16DcRuJ8NN+3GYVmJEV5Z1VAp7y85YmtWe3MFZmCvNIwHX4dTn6xYpN6X5jglZQEZau/gnsP6AFVOitpVUvBsiIZ7e8lHVUuRZ1u5c5+Wux1lF90E/WK2tfxYiPVzWFx3J17tRfdR8xiV0KUaZjS/fginsZc/zycvPdtw14VH9ZsnxfTTKf1bnmG+5ZMXzPdVlqK8smhFPg3FOKuMGXDrTHqOyQFKjWxxG9Fqs8C8YwbfEuF6nlbLnUraD+alQ2z3n7e3OyK3PXxPRXJTI2hbRxbZ7rPqEhTNl3H43XNuut1tMX16vwhQOPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(9746002)(4744005)(38100700002)(478600001)(1076003)(426003)(9786002)(53546011)(8936002)(8676002)(5660300002)(316002)(36756003)(2616005)(66476007)(33656002)(4326008)(26005)(66556008)(186003)(2906002)(86362001)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDzzYspHKK6sWzQLTpMXSNyOf1hj6wZewqT9anYGvMifsx0QQx5WD85EAvyp?=
 =?us-ascii?Q?anx8+XNQQdg0OZ4N7xUlFcWdqh/GWvetmygw5BBfbI+I0Y1ALJ4aGaQ4Ju9u?=
 =?us-ascii?Q?0PT6UudcMHqRh3VX2CiCp0xwSZ73b2WkjxxnS53ky8BrBoXZ/jc1lyQ7D4Yw?=
 =?us-ascii?Q?u/4MNbJo3PjFLmLD3cRanOmWleW96twHItXqcRiLsB1grAfaW9+kIBv2xvvX?=
 =?us-ascii?Q?aTlSBO9QXjYCDArT/Oc5e5JHFu1MSJGWjP14kuQ/L1piyO5BbgfyzHeHuUnm?=
 =?us-ascii?Q?RRR66wsceIxcGhESx+e+dCxrbUny0hV+djUtjhB+ufl79WL5UKLMwbCZ4Ibg?=
 =?us-ascii?Q?xs4cACty6vM2T2NMWi3XVuvkapsMQrtmtyMQYOW+8kLy3kZmWBzFZmKgwVEQ?=
 =?us-ascii?Q?4sI4qUD6+JUyfNTXe389r94WYDvt1TOORUT2NmVTeu1CUfN9UVKiJhqOC09V?=
 =?us-ascii?Q?KZABi65xyhNGq1ZuURzWWpPocMujJU0+wMedtbPDqzqR77BbfdfzPt/36BsT?=
 =?us-ascii?Q?ZmlySQUfEbnBXHessfrCzQnO/PodoMXkIPvMyEfklng4hyRNTwFO5yu8DQgg?=
 =?us-ascii?Q?/aFnqeTSAHXI6GzEj3jMV9Kw13z65GdjFDPzR1+xBb3hGTxYtXonvVV7d81h?=
 =?us-ascii?Q?qqarqkff14TycGZNdB1DiMz0ipRC/P39wT67yIMeUZ9cnfrna6dyiFsQJmS4?=
 =?us-ascii?Q?wj4eQZrPcMQjECWXTNOMNkfWPaiHRD0pIgmKzXMnA61SYWPMj7bkVIqz2HoV?=
 =?us-ascii?Q?y+cUs6Xg4BbBfRHp9Prxsoruu4B0HDzAfJ+PE0aQBpV8zigSZlIZfi/fgvkE?=
 =?us-ascii?Q?0Ie1PFp1YIEZBVLQQEVxmIbblraImOZjpZipzTBujzm54sTx8DvKKaALvZw+?=
 =?us-ascii?Q?DFzWLy/yZ0+6sPjOW80U4SNcYjkhfChyLey0L2Hpy9BbQ6UiKxzTmdtL/0mm?=
 =?us-ascii?Q?Kg2EXZ8k9WhMnkq+YzrGbWyMclhEHTWqaVHuoVWRerqQuT7PsXh2CyM6JRLM?=
 =?us-ascii?Q?A8XHCMxjdr/Ug2lhwOxESYd6fYnouyTeAjWWT2vhiy+Q8WMS6DaFTelnZ+1z?=
 =?us-ascii?Q?SluOUYPIfsHymjqwLYFR0VWelvURxHSszAdOya1lIWnrypuIDoQZfV1KxV2V?=
 =?us-ascii?Q?x2qw3LnSvgt5FRWpOEJs7wjHYvSCx60I47cthSsvqX/sBO64RvxwDwoJD1Oj?=
 =?us-ascii?Q?t3GzyFHkh+ZsBSZ95WBuFOQBHdpIM4KJg2V05AOVEQCvq4Fbp09dwuTQTOpD?=
 =?us-ascii?Q?f7P9rklyDi6d5lfMZtlCqWi2M83sozJxsQ2PatzaQxjNyeHFl5cv9lWUOoav?=
 =?us-ascii?Q?h978XzTUnCMIM+pdFUg4S8Ru?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2761fc3-7bea-4910-ebcd-08d965bbb619
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2021 22:25:13.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01Q/ChdKUEXg/vQaUxnjjN4FLPkLelXNJqnzuwOAyh/AvzCzUtG9Nyxdycw8QVcq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5555
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 21, 2021 at 05:34:48PM +0800, Wenpeng Liang wrote:
> 
> 
> On 2021/7/29 10:19, Wenpeng Liang wrote:
> > The HIP09 introduces the DCA(Dynamic Context Attachment) feature which
> > supports many RC QPs to share the WQE buffer in a memory pool. If a QP
> > enables DCA feature, the WQE's buffer will not be allocated when creating
> > but when the users start to post WRs. This will reduce the memory
> > consumption when there are too many QPs are inactive.
> 
> Hi, Jason.
> The comments of v4 have not been fixed yet, but the jgg-for-next branch has
> already applied this patchset, should I send v5 or send a fix?

Oh, I made a mistake, I've fixed the branches, thanks for noticing

Jason
