Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5774635D07B
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbhDLSjx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:39:53 -0400
Received: from mail-eopbgr690076.outbound.protection.outlook.com ([40.107.69.76]:22658
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237179AbhDLSjt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 14:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lao8+NRSUoIxnLm7eAi51mhcT7CeKVzwErSPyHnkh58zqH+itRDwvjU1ujzxOjyNJL+o1px097wD4vTJPyrMSAYcLqtrGmFD8HBWSNNZK7kjjII4Gsh4ZwD3gXaHLFg9uuGh84bHu073LpNYRIUR5LENLgt0T457d0Ol9AFrgXDH5MHG4IOfFyEAsoZj2ZjWVmahMPSPd+h4+25lddDLI0CUdAKk7rgVyYoEMlUQTCqI1SHC4/XLsDhIaSJpbYvfLT7N3ixienND+qPnRci39n/nBHJVU0kh48xfHk/tMUluNi/J0UfEEfSZn0V92GCpPUlrkYb8GdvFm8JuPe54AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTPmc5d3HWvtmzVbxhR0zYdHQfEAbY9Xx9fEiUCqW4s=;
 b=jfKflsJQ080j+eSD5O6/nIeRqZ8qzu+27kIUUSHNLAmqRguYfS75yYNvB8C8jEj4wxQZ94R5h7Y7rSq4GCXNcU8k9AHQJ5KM47gzwQJOFfUA+o9lWhDS/3S8gd9CDyxZP4luM0ZeR6kg55gN7qk5nve0gGT3ab2ZhciNm1PhCx4HbI4CaLoxKphREVI+I3dv8znUpZGk9PH1z73b8ttkvhggRZgSat/IlLbh4Wv6G2d+ybwBDR2j/48Q16nkG/K3MNmp3iBLYKZGZoWwTFE8MJv5d3nnXrNrM56rCQ5tol6b+yEYp9bGfCUG4UxO2+ht14WCqYE5lfnZCD+qB/mmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTPmc5d3HWvtmzVbxhR0zYdHQfEAbY9Xx9fEiUCqW4s=;
 b=Aaa1G2mi9MB3J5HielyjK/m/YO5B4nqK6CRjERF3Zut/ceRsDDOf51TFvbh0JOjZpAsTIlWVsUk0RPp+tw5tnbVKCqj7Afl/aMW9peqUsFYnkGNH8gJl6G4a9paT71uBPPonhinqFuQLl5rXHXDRZ/NrDaVx3nNuNWsKuuPeaxRuIpkSzU0MGieIFDkn8TmHCcVNdpQLPIC5QN4xx/e4J42yOkyj3kauKd3QsqkKB4AK9l/PWruR+rai4yiV869sv1q/X1+nyIEaxaivlOw+E/e2peE3FkM7doh0xeZ2WpczDQpMiPLBmwH6ks8gZqpoUtkkLhHLtUQPr1XeL3/RvQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:39:30 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:39:30 +0000
Date:   Mon, 12 Apr 2021 15:39:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ye Bin <yebin10@huawei.com>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] i40iw: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <20210412183928.GA1163399@nvidia.com>
References: <20210409095147.2294269-1-yebin10@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409095147.2294269-1-yebin10@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0056.namprd15.prod.outlook.com
 (2603:10b6:208:237::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0056.namprd15.prod.outlook.com (2603:10b6:208:237::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 18:39:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW1T6-004sfI-BY; Mon, 12 Apr 2021 15:39:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 850a1fda-25de-4b82-e73f-08d8fde24e9e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3929:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39290BA84F65C6DD5277791AC2709@DM6PR12MB3929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btxqbClY3W2uknlYiEB/yRPru43gWABEjFrUf5zX2pZ54Icwkm/2lPKRbAPVYBOuQ9chyafU8PKsPEx74HBd9xYdg1AvRl5cv1PZgm/2SNQTrUtdXFygyaB4S0jAo0VLz3EWDqcfU8HCiLoFU6EfvfE7YNNcBwaQEj5CSaxgw4T2LQPq8qKlkPdu1d+mR3yMoWeof/4vott6XcAp/a/lY5ZQ0zBBaUrS1XSDQcuLNiBQWPRDP8hLJwGnz5cLycdPnJrDLS8Mq1TsP7+leIYabM3XJNQDGnVEK3besc63X7ybtajBvGY2LUHbPX3jmdaMmCyVuyLQzEiqg4fu+bK1c2DfRP2Cfr/R4C+m+CW1ilOl4F8GxImOyF5w/4gdRNtrmycRxpd0YbMCKQ1Vg8572RJflvvIqewryqklvzRMMupjLU4MS7t8wJCBxfOiv1vVLsTVXrV8vAzejkiWwVHijwNrAf89xnlPuDaA5JPvVEa9bE1ezk3NM/oOoToUAjZ/sLxZkPH9X5noVcqHT8fR+kqM+lo+bLo3i7+8GCLXLJwoA++okdKwVRoblATWSVidZ/2licc87ROa2nIPfgTynvXdnU6+p4lXCoNaHT9dUzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(66556008)(1076003)(66476007)(8936002)(66946007)(5660300002)(36756003)(83380400001)(38100700002)(2906002)(26005)(4326008)(2616005)(4744005)(316002)(9746002)(426003)(6916009)(86362001)(9786002)(8676002)(54906003)(478600001)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TV6i0QvA0pcqdCNUd5xA+B6xpDIvG2ekl7LKwlZyNEryj55XYQE2EG6ss6KP?=
 =?us-ascii?Q?CSxJxYtcqyJzNBgpF2UGcdWPGufLScP9GuNwmVCcZFWBw67NRdyqmiSACFEI?=
 =?us-ascii?Q?seWeyKeyQzt2BfyoJQuBL8chZ/ldK9k2t45mWf4qAQaY0L0cEFflTK/6S3LA?=
 =?us-ascii?Q?gaY7NABI0CNZ2J7lGBpfiwkpJg1L6fBjI+04mlM0abThdPimSucpwehcSPek?=
 =?us-ascii?Q?ImC21ur4HUnVpp8fNWPjbDIwyMQblIXzPhdxx7Yo198FufOb5hl43C6ie2k+?=
 =?us-ascii?Q?tfsLvim2k3Eb0cYmOdW+rSqYM3I+AQzdlCNrc0WSUCnp/jaA0PCqVJ6EtOxD?=
 =?us-ascii?Q?6TDaWBDF15v9D9pV+tXBE9HUs2WpPCWrKu5oluqlRod9Og9ZZyNqbzebU/Lt?=
 =?us-ascii?Q?Td7Tp9jA/KLrPK2v4OLV38WR1Qxh/AG3FWm2pJ7epovq2aOuGWzTZx2D+Zq+?=
 =?us-ascii?Q?uGjREPSBHjRzb6gV6fUXmBDWxpgA1QEDzlNgCUMkLvIbbCDoM3vkJJ4VqGie?=
 =?us-ascii?Q?8QmhRhQ22EXdp56eN04xTCPYBw2DGssTkvjBJvBafGsQaq+gIrEHpDJG6oFT?=
 =?us-ascii?Q?TeTdRHpVC7JNzRFD+NYV8Upof/EsRYhHuTng/GBsSDWeXd2af8xu1BYQIskj?=
 =?us-ascii?Q?9IqgDW9xR65tnnMs9PDeHVi9Gk+I0ONqBbY0ymG1oO11E43e9TppRodG6oTk?=
 =?us-ascii?Q?oHf0cclputGIE5Mh9r1Wfbsv0UqpSFDPpp/1BODueSU1elf2Q4KghINESX6R?=
 =?us-ascii?Q?/gp1xV4jF3+FQQC8fqQXkT/qYtZuSeaCKodkbnlb3IpX1+bdAmqH2vuZpVJS?=
 =?us-ascii?Q?drPu97rx9IkJqDR3X9RbpbJVZ3+vcH8Krdy/7JnIBnDmjiJAfsH/E8gyiRFs?=
 =?us-ascii?Q?CayAc8FFGptLMgbFJrpVSEMLywUTm6di1shbKwC9NBh//57Sb+XnZ41m04IY?=
 =?us-ascii?Q?KmH9glWvU7wuS2zXg4Mf5sCEaVF0BAaUTniiZ+W3FLmiCRjalElz/5qg716E?=
 =?us-ascii?Q?5f+NMpZ1i52tnbBGAwcmzj/4QWhv749HHNq98VMsccyEk4bbdsUsPerVFwFj?=
 =?us-ascii?Q?fmvUcXT16oMKiLY/Sg6tNh1EbRFCPcz9jCYQzDZkG2VMHmwmf5bqGBLg0/tV?=
 =?us-ascii?Q?Eo/H+BIfZUa/lQzEUYCPBxyTAoZwz3Kkahc8BB2ZomSN0iSbOb0G+FdpW1Hp?=
 =?us-ascii?Q?ZDiPDXhsD/2mEBqPxii9NDG3rAlMKYdk8NL4PKoGGBQ6I67EZZDVkQU8Bxcu?=
 =?us-ascii?Q?VvOOjJ20UnvMW5r/VotHVjlA/0/gLU654Q1CwJ3x0hlfdy6zb1CQ/KJhb8OJ?=
 =?us-ascii?Q?t+NVja7FxAtElUKGzVNdbvMfQvIpMGWCco2euCU3SML5eA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850a1fda-25de-4b82-e73f-08d8fde24e9e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:39:29.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiE6SjsmpMIopu9ihomJ28jIDK4QwZDmlHz+PwlkPM+QacrYFzocqm3tlb/uwQNv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 09, 2021 at 05:51:47PM +0800, Ye Bin wrote:
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
