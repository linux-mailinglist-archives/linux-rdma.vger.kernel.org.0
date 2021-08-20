Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23143F3451
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 21:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhHTTL2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 15:11:28 -0400
Received: from mail-dm6nam08on2071.outbound.protection.outlook.com ([40.107.102.71]:50656
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230327AbhHTTL2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 15:11:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4UDJCAi6KqQY8PdnKEkxCFxdLsl+7XdqnG0PI0vba9UZumwT3vwpkEwtnUgy4Bcdic4XyTwypSLAIcKhopoX74TXL7+MLtt6R5NAMfjOb2B4cuq9n3cru1LagUZ7/Hg1bvXS8Fjc3w3cadmDKPbR5E6WcODxyl7aXE4MEeyn6V3TXu80qpPi2m0WGgpK6yJ9x0Tk3JrCaP1plQbMbpzauM+av9XxAbo82I2NMqX4h4tCSo2NFzsI2UXv2Ynr1q2OvH0gr6u6ipyJrEmaNHIC00a2ZR2pjieDDf90mNXcGrUmng/Xhklp82l/o5Wq7RoUDNj7BX+qSgVs3j/30laUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfRPgkEAVOJm97HDF3zYEMxSa/NRc96upsMzzbOx2ms=;
 b=IXy7f/a0k54FZwf2KsbPT1aHQz78gL+YM/oksowmnW/tOgPrvbYZ5eWEAhU1V7Vem9sb/NxYTxx/+c8OAaTkDATuCdY5L1qIPda53pIfcJl06BfS6oCF2LHOi2WciB7ugHDySckL3byyn1LIUusVyp9bQsN6eJu7DVJ0moqOQ1Pw39yOAAHe6VuW9xD5P6texB4BTQsbxbEqyV9JFqdDJORKmbYgKGae8umAg2v1W86YcVVsc/jKujbhUGLkxW9hgGwbfQq1IsiZ9iZvqPKgGWrSOHY+uQhgUmMWc97Fbu/4rDj6hFOk6/d5+LiBF3BKpuUuev/GKdN94VaDqW1sgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfRPgkEAVOJm97HDF3zYEMxSa/NRc96upsMzzbOx2ms=;
 b=CA8M0XPmfR7AcrHnTizqcSm0jbx5dMrkpkxjath/JEALstfKbDsgiSD91jZBt789riGE+CIqBV2HDQpEBeQUoga4k3FGQ6U3BaavcC73FDIwpV5AkSdIFIgSX2dHKg8B20q1QFpJ3mXWMIiKLQqdpwkTwm3ZWpEdz1n/2OdJEjKgCw+IskW8UyS7jQN5ilINvo/eUSG+9D04aYMOIYUwYz9o+QPi5ryyS6F+73+vbvV2NQ1sPX+Im3S/FQG9/8bp77+Bsfj2ypoU6Ll8LxIS5bSSyhuNkqCIoCjwhgqizJ3CvsqLXNx0422/W7b9tTmREz+ilvInMpnmk7mKQzZ4vQ==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5320.namprd12.prod.outlook.com (2603:10b6:208:314::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Fri, 20 Aug
 2021 19:10:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 19:10:48 +0000
Date:   Fri, 20 Aug 2021 16:10:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
Cc:     linux-rdma@vger.kernel.org, aglo@umich.edu, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com, leon@kernel.org
Subject: Re: [PATCH] RDMA/rxe: Zero out index member of struct rxe_queue
Message-ID: <20210820191047.GA571330@nvidia.com>
References: <20210820111509.172500-1-yangx.jy@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820111509.172500-1-yangx.jy@fujitsu.com>
X-ClientProxiedBy: BL0PR02CA0075.namprd02.prod.outlook.com
 (2603:10b6:208:51::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0075.namprd02.prod.outlook.com (2603:10b6:208:51::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Fri, 20 Aug 2021 19:10:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH9uh-002Odn-8u; Fri, 20 Aug 2021 16:10:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6a7823d-3f1f-4ab0-3558-08d9640e37da
X-MS-TrafficTypeDiagnostic: BL1PR12MB5320:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5320FF7899FEE4BC713AC522C2C19@BL1PR12MB5320.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1M8NefKPbz996SUChgA7NcviOms4/GTjz5hmF+fGP/RX87SAhGYrZZVUcZmT2Vh9yqrQGiA9bkguEHTchaP9Q7iMMuRV4K2oHBXN5907H9oEHzRwegMOdJ9VyPIQBdCRQVuuPpgcK0acYBbbknxJkesptJIUk6vhrCDLCm+SFAk/4+yV4B3tVKe+aCO0OsoIEDpe153lWguapXzwr5lCIc2acvx4CoCJNK6qooeWgnt+xbeNUDTsEcBPqLcXXkEE1UPzndnZZifqBgApvKIic9pItDUtqfprbqBsVWBwSCgnGfN6Bb13gR6XwzU+G6MhGuqlGibMeO/UaSEOM8lg/CIlenbQQ1ikQui2XhJTBwzpAYwBGMhrUIMwE1Raiy6IZJtD/vyNg+Kk5/gTxFGAw8AYI4u/gKyZ1hKGKQlCykmy0mOiBRrDVDOJV2+PnRBerNMM0bjuibT+BXbh1/8jQBqpby9mM8/0FweEYdzHm89jR7AIFHyUz32LSSBVC6WZx6/D8Jutng2G7jGyMQbBiqlAU5JRcU4kLMsuXoTR12AnxGEKpO7WaqHLJGaKCLKCcYwZyjB7J5FP59JJ5w6KNJ9Wfa9QQ/WktZqZSBBNsCL918cqqxzXWt43YPOD/G320a0lbTrXwjPdf24QKWR4vf7PL6Oh9P3LTkj5DuGG0uF9h840qgjY6IFhSPfeTJFV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(5660300002)(186003)(26005)(6916009)(426003)(86362001)(36756003)(2906002)(478600001)(83380400001)(4744005)(316002)(66556008)(66476007)(66946007)(1076003)(4326008)(8936002)(2616005)(8676002)(33656002)(9786002)(9746002)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UMMy64GBlY/nSwB6beeS+nyy2NYTq6ODQznE6Kzjp90PAcTDVkaKd5eWLXa9?=
 =?us-ascii?Q?wh35lnwRnOk95rVdqmIwI5nhtNebndPb660ByGUv37bew7+CEPUDEVtCF9ck?=
 =?us-ascii?Q?kjxjrAVqBp6bxo7dBDbsen7WazN+pze2/mmvMuMrmf+gtGfjEMUV8Cwiv24+?=
 =?us-ascii?Q?C0+4Q7Gos9eSfDfPJoelJrC7R7tJyTBnxrzpgkZg8E6qveYToHdFm8AVHJEQ?=
 =?us-ascii?Q?usPSBE650uTLIwrH2g2AFdaGXVynqxS/YyyVhsZJFG9/JIb73TfvtJyFxux2?=
 =?us-ascii?Q?VWgn70RWwXMtgDczmICHiEFiEBP1E2ABBSrlR1t5e53sMsqp5MKTsYRLvLj+?=
 =?us-ascii?Q?r75T+40RJPlGzfi/gacmXLcqHWHyvRbm5XgBqFU6P9/NFwLmNkDbuEsTuxdA?=
 =?us-ascii?Q?gqTdS44LosqJp9TlwNRrkK/jzPLTwYO2cZLvtVfC6TWcW07c/vo1SCxr1ohO?=
 =?us-ascii?Q?pNf7b3AnE/+TA7nOBwHKT2mY5lrE8S9OvDtCRxIcPMBLFADhraOWbLuGDEkh?=
 =?us-ascii?Q?mXBBNK6vMdDLPFC5hXRY+F+P+AxlWpunzWxzG2qRDW4q4wD//z/s7e/1A8j0?=
 =?us-ascii?Q?vxcfQO0RYg/Xg6E7uSSdx7m+guLmuKLHMIfYp5YjQG43/frtzJOWT2C2PcYF?=
 =?us-ascii?Q?Uubu7EGNEEHnH/WEGcotGRGIBA8jjlzOYwvoSxTIJUwtiCNcmwUaED691OJI?=
 =?us-ascii?Q?I0wWO5eDsdPRC+o+ENHS8NzDxYNuCulItmY8/jOaT7vF47jdRW4IWydSH8kp?=
 =?us-ascii?Q?T4kEIbEkp8sWT6PTpeZKHQ7M9uWPHl341OOnbEItHbihEPgqI6wJOK7Sjdt5?=
 =?us-ascii?Q?qJz7KnHyLgZZoYnil/4+n4MEuPDIQuJml9meQRr/WR1Z1LVRNZ9S7c78z9rE?=
 =?us-ascii?Q?EbF5Cwc62I9YNyf8L75JtvWW4VPWLkjq6P9oyJdEnBTGWdH+aPnAjElMqBcC?=
 =?us-ascii?Q?WJezfrRR3mtkrwnZM+jrZSQY+7BkjjHW2E1yBJ/CVkL3ti3CfnH1vBu+GsA+?=
 =?us-ascii?Q?/jf8GDh+Q9JN20LV6AeiRet5cHDWucVRdxVLT7S6YLJDYjPnMaUE+tw9FHSH?=
 =?us-ascii?Q?WPm2HnE5FHLgVeyPM3aE4Oq9fsAgqh+2pLsUgwLwFkOqGM2wfDPwFXhwF3Mu?=
 =?us-ascii?Q?P/m0BSMA0AV7n9wgwPXeUYow50mycDaI0Z8W56MkQu1zxuVh9yENZ/5nr3rZ?=
 =?us-ascii?Q?mf73AEIQg3enEku9WQ124mNb3er/DbFBpNOrpHKJp25yIe12Yr59MEMtRrAe?=
 =?us-ascii?Q?ljqA2pKj+dxD2ujJ2XEF0sGy6l7zCIzZ9/nogHuNhpI143EB2McJ8+REBqg5?=
 =?us-ascii?Q?PnPFwYHR9uVMxoARA8Tk6uhk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a7823d-3f1f-4ab0-3558-08d9640e37da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 19:10:48.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFLj5ofEAF5y/hYN+CjrQz8eSoYxXg4cn3iZDTpY0kPtUzQkyATwQwJopxCcbO4R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5320
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 20, 2021 at 07:15:09PM +0800, Xiao Yang wrote:
> 1) New index member of struct rxe_queue is introduced but not zeroed
>    so the initial value of index may be random.
> 2) Current index is not masked off to index_mask.
> In such case, producer_addr() and consumer_addr() will get an invalid
> address by the random index and then accessing the invalid address
> triggers the following panic:
> "BUG: unable to handle page fault for address: ffff9ae2c07a1414"
> 
> Fix the issue by using kzalloc() to zero out index member.
> 
> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
