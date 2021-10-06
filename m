Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E00424A3E
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 00:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJFWx3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 18:53:29 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:62432
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232968AbhJFWx3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 18:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNiaJyZC8ju04IfDGM6kUsBFmTJDwOwSEmn3+OefU78RvKhI/qb7W7zao8X5nHdHNHoiL5Ep+5aW3f4D1qui35ndF4UEvHr9U+vdpvUSHQRV+3yQRA4slEt0zP8fxeHvLSQKJQwrLuzgJUt2CDZKV+a576uFHsaM18+V6tkAws/wZVhsioP8c+JOhbOBKiVZwogbLoRBYMww+gy4GXgnezeb+sKV4RDozhRWgMnjegGee5e3hY4HeV48mjCaWz6NFzqn8zB+uqtpIvtlzw+MV/3B12JQnF+fXW/5/kDfZrNbNOrHn9V3szKh0pOCqn6UnLClbs8WxfXKvZ78q2HVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agYf+dbW+ZOVzQ9K/sWRewbWrAEebhRH4NjpnP7aDPg=;
 b=mP6Q0gDDDQ242Qw5M0xuep46sUJcckeq30zC9eiiSRGdYOxnZRxIi6uIJDJ0Uaw/PQieE8if9u9q32PbYpWxS4Tr2Kxfn8S7B9SRbxjXeBQjf/1aiQmJqxy9ANF7XRN3aNYe7eeVi/r+3nF9m9lra+aQahEARXDaIB29zQWZMBCaCUvT+2fdwrb1JkadZJXEl46f+Hxpfz2tQsrKueFrm91simXg+i/QYJoZJIRNMaOhxsvW5KthK72vp7Rtl2pAeA1AmeEsyR99VW6qvPIV59JsJPWpcTdYfS+uhnquPqWunDcN6z5TbQRsGd8xHxH1uaUQNjanFZbupA+o75T3bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agYf+dbW+ZOVzQ9K/sWRewbWrAEebhRH4NjpnP7aDPg=;
 b=lV+NIN7dtmYwvLGx1VozTZoHVMJrlA6IFATnFV8qecR93AtoI+ZoE9zVklCcmPiQgOgJZdGkkXPaijDOom3TLUK55LuaHpeSCBYf7JXsrximOWfkPVi0t/uvgJFA/oDbcSyGpIJLEhmJuA6Qwb15WOZ1bBJHEHLRWpBel1/cVEAkrqbPEfRSSw4AMzLtu2oiQDnQa3wkXJSKRf6H89B/cq6md+dy4SmgSy5CcQIq7MTyGe+FtDFXNEyQ4Hjm+PpJaHCgn+5HrUnIDAOIh2aqsKJgwDMEN+Aa47xtsD39StwxcUnd8bCwlW2lypOpUwwgfx24wevf7yDpZUzxi8t3eA==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 22:51:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%7]) with mapi id 15.20.4587.019; Wed, 6 Oct 2021
 22:51:35 +0000
Date:   Wed, 6 Oct 2021 19:51:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: CQ notifications
Message-ID: <20211006225134.GA2788140@nvidia.com>
References: <20211003105605.29222-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003105605.29222-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 22:51:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mYFl8-00BhKp-AB; Wed, 06 Oct 2021 19:51:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaadd6c3-f4d2-4d06-ca1d-08d9891bd974
X-MS-TrafficTypeDiagnostic: BL1PR12MB5144:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51449D9637BC12C5FBB32409C2B09@BL1PR12MB5144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmSvRCoSWZa610rYIPm6tDT0fg0i7WGAlPVgSCiqjInF2WC5bnhOdBDpS1Qszu6JRp+NGA4BICozjPL9dM3gtQ84o0YMHx6acxxXHuo7A+6+skKd5UOB/5xuRas4X91KbIzLmHSdnYK86wmctKQLvSCSWRUUfbapvwwmvrnWhfLzOaJ35unqu5gPUMhLBLqutk6J9OSwoTulnTq+PxtB56h3foHkd3sINr1iwLiVj9ORpVAyR3Xtt6mBoMXj8BxzdwFGAivjeQMIlHyaeVvDiOj/uJtD4Y4yYIy7itxhBSvmLnzRu0U1jz6XF//EX5bBnXlciuCYiFn62Z4l+MToZbWetNTmUeNx8ypG3ORZ9OKOdLeAN/nhyP13y0G9aRidwqe7WZAckH++amZaKgEsL22MwueVuy4Fq6v4Jb+gmPxBIyeOOdEp/AkUr6rN/uMXhbKwOYD0/p/46ls8QUrQpwLYt/CVdQlPaSH1ha78MTWRNcpXCSsjBrCunX1bZO9bacFxwUWuki51kcxzTdiiG+0swLe3vFIJGWdGPRBehE5GzDTAlrXZvTZsjGNWRYGRU3tDzltLPs9ko+R8DQdW/BAzbLC1DLqh3Ypo06ucQUxGlujS1JJhR4G22BHxPAxwhJflSQlUK3ljiaVJD5XOobeFBxp46eUkO68UZeA5g6lmZ0+9Lt3Ga2tfOfMnSn+hkDx2dR1MyLGnLBYzTbvKZ/WCT7S819UYRpLYqdaoAlee4kEfJvmpDI6PMpLlaEv7HqZBtQhbj4brTNtq6Frs3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(5660300002)(508600001)(54906003)(1076003)(33656002)(316002)(4326008)(966005)(9746002)(9786002)(66946007)(83380400001)(426003)(2906002)(15650500001)(66476007)(26005)(38100700002)(36756003)(66556008)(8676002)(8936002)(86362001)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOTZAXdwCbt90yA+Vh3M/lQBHakXL7/L9o2F8SPU8DXnGNUfMw6sDMpjAeiO?=
 =?us-ascii?Q?T6h5pzPWBw+xuXt7tvigB/pszAA1BeYE6HNBWJN14l5di5lnE13VRweplFFp?=
 =?us-ascii?Q?zIrrbUU5bpSGdNrYrJFQhlNFcIQf4605E3gNcHQoFfa5DsOJDMW1URQlBlJf?=
 =?us-ascii?Q?M3sM0RasB57FGZ3VT8m38bvBa4OLRAz+YcA0I69jk5m2KqXQqyGaqIPoKjCc?=
 =?us-ascii?Q?nyho1TOBdfJ+4jDZROrdLiE1RWz1yff7AK0MfFkaWkCd9zoRqewsDi5Y8BLC?=
 =?us-ascii?Q?HWrU5MxKSmwN7koPEu4xm1G3LxSHjW7UiuymYHCeuhaW4iPP6ZPN4MRYsidl?=
 =?us-ascii?Q?TZ0x3Dk/OipuVi22p5ywp5ziXdEdXI23lzGn3sWYQ4io/JYBErGWDjeV0J5Q?=
 =?us-ascii?Q?al2TU8FVj5D6PR8oU3vtTgoUQUPKch9lCCC23c8LerZYwlgqWqy7udkBm6m8?=
 =?us-ascii?Q?pjF4nDekpqkGM1+BC+rt5R/DKqFYwtBdlpLNr+WppkSDneWcsGr3Nu2WIlrk?=
 =?us-ascii?Q?baIL+BpgkT8HL5ExduCvdqPRmMCpn7QsRH6/vg+y9IaQ8TX1JKDJdp7Hbv+1?=
 =?us-ascii?Q?zmVbbpEmQae21LBERKftYuZiGnLJ34HSQdn8lriCBFEyUTsCcnHdt7B8SDnz?=
 =?us-ascii?Q?yXfxDejSu+dG5EnS0MK3A14Zghn+SSQWeGYaFoA5pz9LdfRuZlfPbzXTOui+?=
 =?us-ascii?Q?lBC8pphuWTJdiCwv3nMaL2QqH0o8RxUX0qxljXlw3tvel6liGQs5t01q3c0b?=
 =?us-ascii?Q?rm81sgnzsEQ3ZbRX6u90edeaUdpEIEBG7Wjpwp1T25bXRyUidkb/tdgGjriU?=
 =?us-ascii?Q?gRRTTojGYws0fOBCqSEmBXvUwu4W/OX7QAh7DrkhRoKs1L/VVtUwIJr22p/z?=
 =?us-ascii?Q?AAX9fDhosH4VYEAIpBok45Cc6Y2G6rN+mXD3IDCLjTioJa5qYy/LTPsgvgvA?=
 =?us-ascii?Q?8rhaHOR25VMPd3xX7ZJw/jy2/ZDdPa+wAzSDNQhMR9aoe+hSpXYvjh2w6vXe?=
 =?us-ascii?Q?7azo8t3Vb0vOTx+0pWjKGTkoF8uSDt4uG8RT+LURJpdAv7VIVizocBpRj0K3?=
 =?us-ascii?Q?klgyrhsc/zKb7je8aZcjWBUXEvVfy9qd8Ms4+2+RVl/BIcLCBH8NN2lrxGMi?=
 =?us-ascii?Q?TxaJ2Wz2H1Oej5mfS6VsjkT2nxmBXxqcxrGMIkEMWL4XLP4b8CfcX/myEnmW?=
 =?us-ascii?Q?gQBPhtZupnrLe7rqZ4pJuYn90VUq2ShkYBGF+kw4Ku/WIx9alB2/U2JYND3o?=
 =?us-ascii?Q?SSzg2y4ABMn9Z9XCSYwXjtkbiWFhWdx8AM2a+iCS5qKXj5L8C5PNY3+sRpMO?=
 =?us-ascii?Q?ieA/7qaehpYaKTXZVLtcFnUUb3VJDRHyQF4HzQ7PY2esKA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaadd6c3-f4d2-4d06-ca1d-08d9891bd974
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 22:51:35.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6SroNUsRRePdjOxCsbvH9p157DhJDbASXUni9gP68BCKl0oehtQZtEiX82X6CHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 03, 2021 at 01:56:04PM +0300, Gal Pressman wrote:
> This patch adds support for CQ notifications through the standard verbs
> api.
> 
> In order to achieve that, a new event queue (EQ) object is introduced,
> which is in charge of reporting completion events to the driver.
> On driver load, EQs are allocated and their affinity is set to a single
> cpu. When a user app creates a CQ with a completion channel, the
> completion vector number is converted to a EQ number, which is in charge
> of reporting the CQ events.
> 
> In addition, the CQ creation admin command now returns an offset for the
> CQ doorbell, which is mapped to the userspace provider and is used to
> arm the CQ when requested by the user.
> 
> The EQs use a single doorbell (located on the registers BAR), which
> encodes the EQ number and arm as part of the doorbell value.
> The EQs are polled by the driver on each new EQE, and arm it when the
> poll is completed.
> 
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/1044
> 
> Changelog -
> v3->v4: https://lore.kernel.org/linux-rdma/20210930121602.63131-1-galpress@amazon.com/
> * Change destroy EQ functions' return value to void
> 
> v2->v3: https://lore.kernel.org/linux-rdma/20210913120406.61745-1-galpress@amazon.com/
> * Only store CQs with interrupts enabled in the CQs xarray
> * Add a comment before the xa_load to explain why it is safe
> 
> v1->v2: https://lore.kernel.org/linux-rdma/20210811151131.39138-1-galpress@amazon.com/
> * Replace xa_init_flags() with xa_init()
> * Add a synchronize_irq() in destroy_cq flow to prevent a race with
>   interrupt flow.
> ---
>  drivers/infiniband/hw/efa/efa.h               |  19 +-
>  .../infiniband/hw/efa/efa_admin_cmds_defs.h   | 100 +++++++++-
>  drivers/infiniband/hw/efa/efa_admin_defs.h    |  41 ++++
>  drivers/infiniband/hw/efa/efa_com.c           | 164 ++++++++++++++++
>  drivers/infiniband/hw/efa/efa_com.h           |  38 +++-
>  drivers/infiniband/hw/efa/efa_com_cmd.c       |  35 +++-
>  drivers/infiniband/hw/efa/efa_com_cmd.h       |  10 +-
>  drivers/infiniband/hw/efa/efa_main.c          | 181 +++++++++++++++---
>  drivers/infiniband/hw/efa/efa_regs_defs.h     |   7 +-
>  drivers/infiniband/hw/efa/efa_verbs.c         |  67 ++++++-
>  include/uapi/rdma/efa-abi.h                   |  18 +-
>  11 files changed, 625 insertions(+), 55 deletions(-)

Applied to for-next, thanks

Jason
