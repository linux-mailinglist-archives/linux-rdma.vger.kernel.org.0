Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D61184780
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMNMc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:12:32 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:6154
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726216AbgCMNMc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 09:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqiS+R/n8o8kY8NJLjEl5Xb92rTZg3RkRcy1XwWJyzT1Jc8RUWgzIdgOJtDVHQbjMrJ4j6LrSlgR8sCw5WCrK9Qb67yKqU+Z+g+4hLho8l66Nr0SOL9shxntva63C41HvF7TDxTRDFSjd7ZxTAyQ23XtdzBhgNV6R3zz+VxsQd2upH5xPENDM1gg3kGzFaqOWl7UcyY9S6qDTBZyktQfox1MXTqPyy6+y199vKAFurpSoZ6vm59/IGwwG50GiZqzOahHJ9N7Tyv2R1inHSgo9BuUZhLIBw416ygkR26o7PfHbQHCJWwTyH+s2FZgnvL1c2CLij1pRWvGKgB/wC7vBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOFdfJlZjB5wiaMuxFz29Aw1Ss+edPn/EPkHWtvLiuU=;
 b=jnDK32i7T8kVbDYJuehPgl2/F6/HiXVgK7s5lM6ldVR1IbPCnHfnc468tQkDi5AX9IFY7H37RvlXazEiYFNDwXLEsCfmpGEaBi5myMQblY282Hx6tWt/wqVWnHmqNbDfXTIcZbh8VqsFCjmWV9X4C7tnKEHFGc57vAAIYqIWge8AaSTxBnFMhv7le1Cbm3wHLqy4qSXU/vQEKSy2Ycf56CkqSHC5RCaeCYzRr4mDtkubVcjR8eVvBVV+yw2ODbI6eR50UazYLxaorwnba25IGf4k99ofVmvMOn7MKdPU+mlfj3d81CtWSQeckEZPnVBrpsL2MOPEerKRDP2RTXu1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOFdfJlZjB5wiaMuxFz29Aw1Ss+edPn/EPkHWtvLiuU=;
 b=kd+PD3XrSgPufc0JXBu+Anrk/qPFHU02J/q+SxjcA4PIXZ19O85ApEa/fQ5BqvdTTJJ5bjyks6MtTIrTlvaktT5cwGgetnIvevHUtx5Sh/p73cf8J+LPDN/r1ncm6vwpxnlIRdFeLoMOpDUqf5pNN7CHEmOTPNWbofI+uG1skTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1SPR01MB0382.eurprd05.prod.outlook.com (20.178.81.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14; Fri, 13 Mar 2020 13:12:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887%7]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:12:28 +0000
Date:   Fri, 13 Mar 2020 10:12:23 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/3] RDMA/bnxt_re: Use ib_device_try_get()
Message-ID: <20200313131223.GI13183@mellanox.com>
References: <1584102694-32544-1-git-send-email-selvin.xavier@broadcom.com>
 <1584102694-32544-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584102694-32544-2-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR01CA0045.prod.exchangelabs.com (2603:10b6:208:23f::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Fri, 13 Mar 2020 13:12:27 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jCk6x-0002x2-Vo; Fri, 13 Mar 2020 10:12:23 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7acb7bd-24d4-43d5-e73e-08d7c7502de6
X-MS-TrafficTypeDiagnostic: VI1SPR01MB0382:
X-Microsoft-Antispam-PRVS: <VI1SPR01MB0382DB1D8D87F0FA6AD001DDCFFA0@VI1SPR01MB0382.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(5660300002)(4326008)(66556008)(66946007)(66476007)(316002)(26005)(4744005)(478600001)(81166006)(2616005)(81156014)(8676002)(8936002)(33656002)(9746002)(186003)(2906002)(1076003)(86362001)(52116002)(9786002)(6916009)(36756003)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1SPR01MB0382;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANhygKVkRnp6TEoBqfqWd3W/+W6qHxiTTWWEqAq5xMyFMJ+hNTW1VjYkSYhwr1o+YY5slJpv86QtMHQoHN1CneN7jqVHeNQzidMEfqzOQgxnL03M7Nir0MZLhJZjvms1FFNf+VHpRYdusjPJyFjSJQPTUoLOCl1OVK3/tD3hBAq8qx4fIPDcuPjRkACGGI6ddMUcInCbEgnQRRsMtA+CoG0dt/xtG9MkHebC+KTPncxAdigC7DLi6ekxpoAvFW5Y+qtU6478GrPR/sYWHo4MSckpH9QH0O1wyAfW3StNdSWpAQMG4sDCLadMJVX8ERZBfl6dm24getYZ25mlWepDMrRB6kSCh3CHT6tTQ9WtepfOBzUbqhW6GeWlPVMLX2LncxpcWiF4bEFrtJSHUIKE2jN77wLakcvg9caH9mN1MdCEjasde8+/4e3dnw5DSHqsZ2146UFUh4bTtXX8YKuIYuwYp3PWYO4K3uOOetVk2ECbEtX416wP6c8FaKJT83ey
X-MS-Exchange-AntiSpam-MessageData: dHEy+3rEJQzVmhblg0g/3oySJCc7er7xxKdPmVcqgmDlrQa9nCMwvdPhGazyoI2X5BlehVGxF9hBwgiFLqQHgkURhx/ADh4nI80nu+/dck4VYCrn4xHynccREkXexrFwuReVcKv0qInQ0UV/9773lA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7acb7bd-24d4-43d5-e73e-08d7c7502de6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 13:12:28.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wKbxFLMkzJ3TO/vbSplt6Zs9AVHhBLPaQhun3fJiphs1sd2F/rMHxWZxcV6jXi6FkW32O/SGSFD0sv4DcTw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1SPR01MB0382
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 13, 2020 at 05:31:32AM -0700, Selvin Xavier wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> There are a couple places in this driver running from a work queue that
> need the ib_device to be registered. Instead of using a broken internal
> bit rely on the new core code to guarantee device registration.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)

All readers of BNXT_RE_FLAG_IBDEV_REGISTERED are deleted now, the bit
and the writers should be deleted too in this patch

Jason
