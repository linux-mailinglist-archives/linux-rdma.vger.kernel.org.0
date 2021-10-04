Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7954217F8
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 21:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhJDTyS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 15:54:18 -0400
Received: from mail-bn1nam07on2054.outbound.protection.outlook.com ([40.107.212.54]:23566
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234618AbhJDTyR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 15:54:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScUDVigygTMDVS73pecljiBoD/MrIscSSz+TBSZm3JSFeWlLbLkSvKXBSEnq4TS2sG7AbfQsUc4Z6kL+ZdNDSIsQrNBGry94tQAnx973H83ux+58luajwxHALsQ7v/LDkmLGrWlD4J2nEgGuVN+zVcb0k+ZkWW7ZAJCqhvIQhSP3hxhx+IBH+Dq12Tb+2J0QQkFr5dZXpsX+b5ZgRG0fXwIaLR41dOZF7dX8pcP1V62tXDrQDryIPz6mQwyLPWR+G25URGG3nwLBnTYA08Ci75XX5E2bPSnzmoXmMfF0BHSkT6QaDRIOl1Fgbvc2Dw9fD2omwHc+XWUbPmqVID66DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1+7uqCISSi0qsNYJcF+JVP+720qq8xEn+SHTpUWoW8=;
 b=PvLuoRmCO3csAwgov1UBDQUhlit9W9OEMYXpxH0VDpeiEVQGIk2mbu9sMlC99hUcbzzeqoU/wMZCdgp7/1M9tuFqQ6C4GBkkPegcEl9pkbAl9VklziHbpw6mv6Z/hk7q0Ltdlw1393jMgmKCWYf0Hp1UBkj34y51sZ18UG3HBNwxOkmr8MQ0+9w+AaWvrpF6V1SkKFpsei18SJuXDhJNnnuzxzFY5UD5Y0Imm3MxdMiUEx+ZZ7FfCiZpWmuzuPPxgOhBdiALL8pQyutFcnrne2Bxa9ad8t5Mjv5hhpCZAiU1OJ0Bl+zaJWRdwdDtm4mrsUUhZJFFF4b6VUvFN/CbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1+7uqCISSi0qsNYJcF+JVP+720qq8xEn+SHTpUWoW8=;
 b=JvNIltimNWZnEKFbGdZNvLC68iKZ/tZQBk1Q+gyz7xs+M2ym0fl2Y8plgwkLa14rmh2f2rYjIzO4o5MeGePO8uB4l/zH1HkbEsIDTZlsbd5tXIAyFsjh/ia1q6GFfX1Q0MbWo1hUceGjYmX/QsrFwiyVf4+za/s73ckCIPp047FMXd35xQNlbPexoaUupDbTqwOX8ztrdcAD3JxcRulyvEWbz+kwSzcj6OUOK4oUH1nHoapdCh0/4okFqo0c9eQOCPNPtgQPOAYUXTaIQvyNSNIhha8qrjXD2v4DRxFDin2mVr1+DIp61h96+3KqrR4ho1V7iOonZmUyIWASssdoog==
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 19:52:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 19:52:26 +0000
Date:   Mon, 4 Oct 2021 16:52:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
Message-ID: <20211004195224.GA2576309@nvidia.com>
References: <20210926061116.282-1-caihuoqing@baidu.com>
 <20210927115913.GA3544071@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927115913.GA3544071@ziepe.ca>
X-ClientProxiedBy: BL0PR0102CA0038.prod.exchangelabs.com
 (2603:10b6:208:25::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR0102CA0038.prod.exchangelabs.com (2603:10b6:208:25::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Mon, 4 Oct 2021 19:52:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXU0e-00AoDx-VC; Mon, 04 Oct 2021 16:52:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bf58461-db4d-4ea3-e58a-08d987707d48
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128079B39CA1E4AC513CF9DC2AE9@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pjFSJcZ97sUvuFdrNwtd496XwmHCkoMgUEfDE9Ypk7wdXZeF774gOelServ+UHvWpquiheZJY10Rvx1L7Vqm5WoHuDFMqr90qXMtaCbc1FWxUbC2JMobad3k5jEDavgj8u5BdQH+ORgDMEAamwDSVklNYLh9YwDDMXYr9ss782Xn+/lLgSj+OZ7djbUL2xUYS14R+6L1xEwAx4cPox52bciMLVNJFuJ6t3ZoUZTfPJoMODvKOJFs/K2SdJcYNjGO1j1eJdMuHRguvFNMNknoEdeacjzZvUKlfOJkNEW5IK3dPwPGFOx2nwTbXtNYbvl7jvi3HARa0B6HzDPYCySf8J3o2CZ5wOaGxaThwOWttnkpcO0EZ3YJjKin2NVFm29T1yfQHxWOuqzf4MY+VqNEuOEzAjx3NODJIjLDK5hHxIotKMIRyi5yCefw2EgvZQ9VnHQm0crZq67lI50xPQHfkTnWuW5MqQb70dH82jEvdrYDEjIvWaavk7sWbQN9e16TohQJXZPNIxkQZz+85aXs1OQ3CUfJ0+S61yzdmk6gVY/2WltWAeCVfSi5mPF7WLXNBp3gYlUskD85br5X2nNrP88uOum2u55nIhq//t99gKWK5nIBOQZp8691S8UwunGOCi/n7G9pK/ZbbgnpTMiL4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(36756003)(6916009)(5660300002)(426003)(4744005)(86362001)(33656002)(2616005)(38100700002)(1076003)(83380400001)(66946007)(4326008)(66476007)(2906002)(186003)(9786002)(54906003)(9746002)(66556008)(8936002)(316002)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuYilCKAhnmz1JwyqfTzgdqR1CvZxsdK5+kDrO4g8bHNtUIPZFfKwT4XIKFi?=
 =?us-ascii?Q?GOpCQZYoPXMcz04YqIqJidz4scNG/en4umm1r+yXlmf6r1BY3xGIml5dNjHv?=
 =?us-ascii?Q?Ufg6OW457kX76UdaCrepse6W7p6NK0ZmQukSS3qqXs8ck4heKmE7klFfnW1X?=
 =?us-ascii?Q?E8ha7McVt4rL2I++L0E5DbyVK3JbNmeVvH1QtbsakY/HUjM2H6+/qfsEewXx?=
 =?us-ascii?Q?zEkiFN/ip0OCtMe/WmWtflF1tivTnS6ebzs7CEmygdqRl7E0Y59Y5TeP0Oe0?=
 =?us-ascii?Q?aPAHdu+QspRgqCUVsDFwebdmr2FwY6RuTcpXM0UEFaH2hO+ImqsAcfy5rEdz?=
 =?us-ascii?Q?Z4H6lIcXlSYDstBmbdeoiB8E7mHRMjoblAZ/WeAtVpqRweklnq+XRgc3Omyf?=
 =?us-ascii?Q?uCSbGbSIRIBJvWUsyHmtTd9IrlienJrpOTQZPLkxu8dya2RuirdTS1rFQ2iL?=
 =?us-ascii?Q?BpbaGkLz4TNGLnaFcGA7NTA3nshjC4I6u/Rb6MEbqJ7a5aPmieh3m2QYQqxW?=
 =?us-ascii?Q?ECnsDVVpdcVOcXmCMn8vx+uFeHHrIOaMAxEtEFftCtztUJhvhqWVlCsyry7c?=
 =?us-ascii?Q?32WvmLeAe+X48fTeivTDtD45BAz84Z/C0qZu13BhIoTaNTpBaV6IfbJjH3sa?=
 =?us-ascii?Q?eyKcd5FVARvpFPKKG3zv3eckiq0FuURTsUufHe66gMZT590as24LuNCG5xRm?=
 =?us-ascii?Q?I5KVyvFB/fbhZnndjXRcIjmxy72n8OqjQaqQTIGhtqUkqBGCBNa0mAeooLeR?=
 =?us-ascii?Q?yb7TNfdYjKQXK8Ri8WKM+DPOrCkdS85QjkN1dEWvRmHriGNm75FSrb44UXUV?=
 =?us-ascii?Q?oIVLbd8HtT5037NcgidhAkfP8DZWciju/nfIhiyecg0WYnzcHaYE9B52PZHw?=
 =?us-ascii?Q?JOFZ6xyNBB6jCCJCdCSIBhA4vfaIaLJGCiEQvp63NHfIVX001bIl8cKssZnS?=
 =?us-ascii?Q?Xp5oEW2zYS157M9+gtMvwtRqhxtYDHsvo+STJ+hCXq9O52AQR7A0XT9GIz5e?=
 =?us-ascii?Q?hciBBdANkbNFIVh4J7s9Snwux4HaCOZaGGK9XemAAe/6PM39kGqdwAs+QxmN?=
 =?us-ascii?Q?Vm7FctY0buBnGNLIqJjMcxZ9rltD8EdbpWMd9cNxWsptaDYZclWL5KVQuka2?=
 =?us-ascii?Q?ULlONHQ+Uzo8N40VO3/BNClyZy+D3lafxdTkk+kWIq3HQ5H+PzUSZM7HvGdK?=
 =?us-ascii?Q?3p3Rijdq2fxGm4pGWDw1ZOZhUipo7xna3F/IyOWo6KWdEcw8oftBG0Iqko6Q?=
 =?us-ascii?Q?oo2WOH3mhL9DUCFyhlUfSNwNCWjwfDkO2lgKOakHTByj7QJz3VoW3Ohu92X6?=
 =?us-ascii?Q?U7Le8fS2GzpbndpgH95y4FCNgjjVainxc6XsPj2Ie0L8JA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf58461-db4d-4ea3-e58a-08d987707d48
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 19:52:26.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNs/zUX9kLhW7PKk8t2kUx6VFM/u+6+DHBXzNVpcm/+21U9C1rnVQrLTGuHsIESX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 08:59:13AM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 26, 2021 at 02:11:15PM +0800, Cai Huoqing wrote:
> > Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
> > with dma_alloc_coherent/dma_free_coherent() helps to reduce
> > code size, and simplify the code, and coherent DMA will not
> > clear the cache every time.
> > 
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 20 +++++---------------
> >  1 file changed, 5 insertions(+), 15 deletions(-)
> 
> Given I don't see any dma_sync_single calls for this mapping, isn't
> this a correctness fix too?

HNS folks?

Jason
