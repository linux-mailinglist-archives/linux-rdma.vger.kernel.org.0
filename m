Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B111FFAEC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 20:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgFRSSZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 14:18:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10818 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFRSSY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Jun 2020 14:18:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eebafe30000>; Thu, 18 Jun 2020 11:18:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Jun 2020 11:18:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Jun 2020 11:18:24 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Jun
 2020 18:18:19 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 18 Jun 2020 18:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBxdbOwn10zrOClp7Ysv3d9rGi9mZ5LwIt5ef3SEb0nwIHYlrGJwwkZtsSANg9ZM63+bFSbDVMcT0B9LYS/oDbtde0A/SJzPGUXtYQC9tHPhEucbrF1nFOOkB0FujFPdpotR/CHAEJjt1Pa6CHBYuFfoja55L/qmV2uwiA0QtK2QZdbQbtWnQvTCD0+2Anuodxy7O+DB4p9MuSzV2a2paDKifg89qb2EKgUdS6SFdSGHopCy5PVxQCZavZ8G9y96rL/hsFS8+T8PRqHgrOizZcOYEAGQXus5n7Oz1hXp7H1MF/cyAjzAkU6x/bYjpo67qdDNkACg3ZRn/ltU9eFKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLb6w+bYy5CdwxMrMA9IyHu8AP65Z2988HtOGFxhLXI=;
 b=JZzxLmYOG6O5zd6nfTfL5v2kjssCZK38Ia5EPOKYWiTBWOS6fNnANwDOfqS5N1dwAQN6NGE+7PKaL2r67dmyEozHf1PtRAI3UN7leZzkqTbITlI0AWXgcuLBa9rqCo8t+4zpc7xaDATyhwaz0Sp/Mtci42N1c4m+Dl/G8Ioax3EFXuK2zCyGxr33eMeQOcWCg1zlnMlFAGJJFWk7bTlsdRv2x0GAt+yuwspuYbDHaWnTeK20PDUv9oxSuTo1dEItKsjSFCZ1Zz//jJoRPbOSwbWdWQuln3LVNVWfJMJfSpYOHEAP7C0NcuGy58E7FuhFMfubqVjAOvSMC9jExoilqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Thu, 18 Jun
 2020 18:18:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:18:17 +0000
Date:   Thu, 18 Jun 2020 15:18:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
CC:     <bvanassche@acm.org>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <target-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v3] IB/srpt: Remove WARN_ON from srpt_cm_req_recv
Message-ID: <20200618181816.GA2453631@mellanox.com>
References: <20200617140803.181333-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200617140803.181333-1-jingxiangfeng@huawei.com>
X-NVConfidentiality: public
X-ClientProxiedBy: BL0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:91::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend Transport; Thu, 18 Jun 2020 18:18:17 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jlz7A-00AIJP-2G; Thu, 18 Jun 2020 15:18:16 -0300
X-NVConfidentiality: public
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a824ce9-cc1b-46a9-dbbc-08d813b3f912
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42670244D2B8828547B5A3AEC29B0@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aPpfp2ktCYKLLDr63Bbats2vU0dS3XmY7rK4tETSqDT+HzYozlbippoQx3332eaIfLnBpfR/iFardr2g4vd8CoBXxDABQid6wflYYfNb0BjaFqhX2F1g9AOTuV4UTnbUKsLBUykGijJ729XmE64mXQExZO7AzsYvPxossWDE6hCk8COlipiUmj9x0tAIeRRKGo2w7S+07I25fnUIGoPROPRJM5T4GTyN30k58GhISArFWeu+cifwnGq1dNDV5UkevA5LktnGJjKZOoMOLKZiObx23uoWi/mU+1CHxb1hyb9a4mIgA/Yd4tYXwNrpStTw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(39860400002)(136003)(366004)(9746002)(36756003)(9786002)(66476007)(66556008)(66946007)(33656002)(8676002)(4744005)(9686003)(1076003)(6916009)(426003)(8936002)(2906002)(83380400001)(26005)(86362001)(186003)(316002)(5660300002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gpY3cUEPdQmzC/jnhv90ChsZeaYBZekHkkiRE8uESgUtW7AQpaxMP4ClqAdYObUJqlhHnbKqAcF+vvtlw3pUMkv1aMo1YVBjPwObAjmGtilH1K22dzEAQsf5Y+b7McmHg414EAi48H8vfh9Pgn+L38BhF5nnXV6Z/dmMIZsDvQvduCqxIIf3dE47OcxVOPFTC775hsBgsRnpyle9SPUSXA2aPEnndl4diRlCzUMnxcK9M+pTEJEa0xZcK3EtRyuVFh6bhpo7o/pxfCB5SltpHQa2NMWW0Opsn45PlXhXjLSaUqt3kEphIzZ3OPjkxtTgSCK3YSARRkH7tB/O5rC5Hj4AXe3IUI80Qivj+Jk+YhcBz5Ej6yMmu4vEYc/4EdLctPTLLmiDAj6Cfi67FcolZHG2zN3jaRnx2czPFJ3G+1PPVU3UIPynlCb/6nCxnp9mzm9svWD8sl+d01EZNdN/25hwJOe0AtKOk6poqnCwFj0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a824ce9-cc1b-46a9-dbbc-08d813b3f912
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:18:17.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFJy6XgZea60rzQWMIUIhydZ9zFePkmGh49JT4bbPwz2Jjdou+sxEF9jmgn4i7rj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592504291; bh=WLb6w+bYy5CdwxMrMA9IyHu8AP65Z2988HtOGFxhLXI=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=hYziZV/9ilafgNV1zTzTSLDe/36ughC23oCNJ+QSrlq8EJnMEJ+Xuah6LqhJ2h0LF
         hlcPdkj/tMt7Bj814/v7YCYycjx73WU2FVsjVNbxtOoefM6nKX2Pm01CdhHn29mQBC
         KpuyZ5anc1plT7EP3UJHmR0+njKhCf09JBCOq437SxhnOcPlkcOLVUxa04isyv6Yef
         WNsT9QfJIQyrCZpX6Ey01vcO5P8c1WouoYQN5naL+i72Sn8TkzD1LJRJ7U3MeDOtKK
         ZBKjonbTXNEF4QsreKkYq5fFuBvgvbNI3WinTAY+giSrbRXQE/RFZrzGCYfu7AH9JH
         fP4kSrynyW/PQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 10:08:03PM +0800, Jing Xiangfeng wrote:
> The callers pass the pointer '&req' or 'private_data' to
> srpt_cm_req_recv(), and 'private_data' is initialized in srp_send_req().
> 'sdev' is allocated and stored in srpt_add_one(). It's easy to show that
> sdev and req are always valid. So we remove unnecessary WARN_ON.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-next, thanks

Jason
