Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C4139AB15
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCTyI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 15:54:08 -0400
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com ([40.107.244.70]:2561
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229625AbhFCTxd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 15:53:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb8IibL7FlbxJdMQFbPSeVxLMfahjqPiQFooegMooiK9OpPGI06DgqopeV4smyhhXr6styDwFlcDK4+NhYT9ZPpIZ3+YfM4UUdjWs0Q+7WgjRyxwiqrVm8OdXezIT2PQ6+N5zobM0zQtzTMzp2jq6nMlbBFUIAoQ+98el/MkJarAGM5zOYiKRWyIK5k+irUFpUtbw6hB9X6XEvrwyoOEtqOhDr90Z+faI8B+pl98yl4GhqlmcIqJCZlCLbv6EPpNiGfUuWLGqQSnQGvGuU6CeGtzmNtGIhP5fW7kMKuk0IXDPs8tWHaLECEqFwXlvu48nxlvA+fic2nYLNgSRy0YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi9RVJMRWUeCDxvqO42zdcTaD5evIlJjLD6j4SmfCMU=;
 b=E2mT/ShADNbMWsnAYyZ5zVQ3YCUp4oaGbR7zIVbyCnNdWPMl2ZH3WZ+O61o95rCFfJtNWLk20AgV9KywnJevNIWXGAhRw5S1hZuQUlIA09mWEG3lu9a9bY+1zmXNicVZ64NzmuWTiwUMsdDXZM1+4f4pP0Yw9fBaxg1a+jWB7uBJLpydD1OkC9Tma0xKmdh5PXc68cLGNmmpfRs2v+gfFA4RUb2hfwbLEDZ+eTNaCj+cTTdirg+P9UN2OSUMWE5KeRB6Ij7Rd3i6P4SaklqkYKXPqn5y7AHNk054aJw6tJ4Yd29GhomV3sBd83oo7ujgFnbqtATwrh591KffurCPIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi9RVJMRWUeCDxvqO42zdcTaD5evIlJjLD6j4SmfCMU=;
 b=SoH75d1wBF3CFzPznVQnXBv2QoRfhWoN3VpYged8NPGFQrt8IPy2PlatD7TGMZZQb6a2Elfi+O0I8i6+a6qNWp/+9YkStAFwbkxOe6fmmTMGl0fVq69HG/8zDtmgep2CVeBO6eNPF7myOT1V5geJ8gfEoMVEa5SrRt0PTsRQBVPc51rJXn/vX2mZS2zlHEC+DO55+m6ADFoZ1W/r4AeZOY7LUaB+b8xLHx16U+Ux6bUAo3isEPcUBL3TjmDZZYWpLr7UVSB4+28rPxSsJQHEueiZ1Vb2E+4YFkbwnwvsiRipVYDFym2+fUXKGrlrG8yCqIFWUkQYUp4zQzrlBWgJMA==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Thu, 3 Jun
 2021 19:51:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 19:51:46 +0000
Date:   Thu, 3 Jun 2021 16:51:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Fix failure during driver load
Message-ID: <20210603195145.GA322047@nvidia.com>
References: <20210603090112.36341-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603090112.36341-1-kamalheib1@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 19:51:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lotNZ-001Lo4-2a; Thu, 03 Jun 2021 16:51:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62b96f66-3bc7-4dbf-ed7d-08d926c904f9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51098D26773C128C79E1FE7FC23C9@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5I96aVISZ8nDaKPIMLmrcEKKyZzgtI29vIz5Ynpq+x+Zg9KwUjbwFdl3Jv4Eu3b2zaZaNYE39q9o3ESIXDrrrYckeOUYWYuCS7gUmtU851Qko/k7q7gcYQ1z80S+j5TqM93yRPg9TXNOjF7xNZaqx9vmk7aPSLPid2kcT/ceAH5sqpruWrO06I9auKdISghirZqu7aR2uhJbiyKV98N22dKxt1TUYqA2L6pWCf3RL3I7esNBK6toBQ9wUUZUvZgazWyo0zRo240FUrJxtTCU7omOFUkyXeauZaFsyn5+6MtExemnt7eFKKFCq/VVCRVtgFD5mj7djW/47wmKFsf7GDaarNGImk4Sq8fzcLUekPmi1VuLLCtJLbMNR9qgomjbJ9ug/QVccskm3PkdLsDDkgGJriPpe0wozvcksh+HWQckvkVStQbDQpc6snl7CnxLdPbZzHqUvsHnSVVQU7v9ea7QK9zYaMQ1JKsUIRnLc3VyKTUWgSM1qIXSuk6AnecGxdNkqOR/z5x1o40oc1Rgt3efj3n2HalPqJq8c09L/qqoziJKp6gCv+H1dYXgFfEPZVJdiw37uYxx+fDLJXALePK6w8X5+M0sKokq+ZGmkKApRKW0tboZIPAZoCzmEMOODv4NF0X+lAYrhc1aKndZihX91GlUdHe7oxeZhkgdUZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(316002)(8936002)(8676002)(478600001)(36756003)(2616005)(9746002)(9786002)(2906002)(38100700002)(86362001)(4326008)(4744005)(5660300002)(6916009)(66946007)(66556008)(66476007)(186003)(83380400001)(426003)(26005)(33656002)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WXcktt4XhQpzZaUu+KppEpK+DNcGmRlTV+IpP2jTvLUUwm3gHgNYf5BDU7Kc?=
 =?us-ascii?Q?Sg/YPBmdiDM4MOAYBdfxCmBfpQqBpCWM24nEYObCgS+Sm6tM3oSIJAXLUms7?=
 =?us-ascii?Q?Xd7RFBhzC89vzQ4tEr9DKzoIzzNQojJxdUwbeQyVDGrta2eG7+LAwieVrFhY?=
 =?us-ascii?Q?mxQ6rX9v5gVHH3MxhklfXTBxQh6Wbp2tZY8gmaMI9BOUNe2eVNqbPZxqil2q?=
 =?us-ascii?Q?cA/hQJCg77JTDTg4vsywRa/29AXTOcZYTBgfYR1ef9dCnycX9u+IUcuemi6E?=
 =?us-ascii?Q?ADYs0mrkQQkHu49h6JV7qfxnyt9s7eloY/yzWjlmhiI0MWpSK9kPlUDB7AKs?=
 =?us-ascii?Q?f2T5ijUPsN20kyf0Ee7PhXbDisJ0m7Izpe7NOCeRLYsxJmGJlZ3XxpJwSl6+?=
 =?us-ascii?Q?4MXPVWrCv3Rjo5bRnZ0H5sSrXNWt1STEj4Wqkf+330O2q7V6bwkDT89isL1p?=
 =?us-ascii?Q?/pC3UBWI7zRLYGupwB1TWkN64n1nYGmdPdV+/jVEHcFmvDpoxyG9Kn2OxB7D?=
 =?us-ascii?Q?PPnAqbixEZqPThXXLF8zg3uIjc55gjKcd4EcPRTERJOgkhcuDWn4j2mNrsnc?=
 =?us-ascii?Q?2yY4sFf9v/wCmZ9BMowwIRzxMj81yxDZmlJJxqAlkb2K9HFzwZgU9Hlj//mv?=
 =?us-ascii?Q?E0j3nP7XkM2cRapXIqpXObXycDGVlLKVcxCdEBD8zUNCLR9dB5ZGPu43EhAG?=
 =?us-ascii?Q?5A5RFPfYFmmOW2nOMn7mwRC/Tr9Bx8Vh8HCasPB7ml5j9yx4eKMSdoJSgkcb?=
 =?us-ascii?Q?+pDO2BHTzBFogy/KZaUfXVIMddAR+ugll/C8YIELgdEW8f9g0kx9npWj8wN2?=
 =?us-ascii?Q?GXwSXjh3dlZWg0OKZ40eEn31WgfncrQ44h2ZodQrzRbiCPUaEwm0aYIdxf+C?=
 =?us-ascii?Q?9C89pbX4WeJH5sciBv/lUBMcFIB+cInvGvFA3GPlWfyo7WLDllDiW0JtxaMs?=
 =?us-ascii?Q?7zOj6JeGprdHj1yy1I6U2Za1efMBx3NYMgPyDXACB5ckflVTh5xRwV7Jlruu?=
 =?us-ascii?Q?tTIzIj+ICgbKL36/+adm3inN5pIaHnaX9OGTtynJ+dx8ATeHQ6zikrl54Pfi?=
 =?us-ascii?Q?eNBAokhvJWNvp86USMJa6OMToauS5g7e2zal2MzmwOEYU8OWWoYIdvGliz7/?=
 =?us-ascii?Q?MJozrZQg3EP5+5rv1//X54yBDelnx7lhAlvaqCdZnflyeOEImYJmJsUCmnjx?=
 =?us-ascii?Q?hUbDbAOPChkxC5TG4dYq+JoOmC3QTdgy/eALe9RfQB+h2+/qMBpylGPqd9Po?=
 =?us-ascii?Q?rQBSkwARspXB4r4Fa5ULgpB/2FV8FL4LuBbUySB4ktiXdGXtYRCymynibS6h?=
 =?us-ascii?Q?wx37xbNxp9CHnBXskt2hGBrl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b96f66-3bc7-4dbf-ed7d-08d926c904f9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 19:51:46.5446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcfblBlLU2/vrFYXaAdq8W88RDUMEDjGb8EUQKclOjlXlg5YPr0aPwiNXWqucet2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 12:01:12PM +0300, Kamal Heib wrote:
> To avoid the following failure when trying to load the rdma_rxe module
> while IPv6 is disabled, add a check for EAFNOSUPPORT to ignore the
> failure, also delete the needless debug print from rxe_setup_udp_tunnel().
> 
> $ modprobe rdma_rxe
> modprobe: ERROR: could not insert 'rdma_rxe': Operation not permitted
> 
> Fixes: dfdd6158ca2c ("IB/rxe: Fix kernel panic in udp_setup_tunnel")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> --
>  drivers/infiniband/sw/rxe/rxe_net.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

I tidied the pr_warn english and put this to for-next

It has been broken for so long, and in such a small way, I can't see
this as a -rc fix.

Thanks,
Jason
