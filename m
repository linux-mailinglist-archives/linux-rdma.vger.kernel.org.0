Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD722228BC
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGPRLJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 13:11:09 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:38181 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgGPRLI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Jul 2020 13:11:08 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f108a290000>; Fri, 17 Jul 2020 01:11:05 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 10:11:05 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 16 Jul 2020 10:11:05 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 17:11:00 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 17:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK32X6aVKCSX+MhAiuPGk+KomX2HW/1HuXhhzpD6KJfeH8zb0IOyGpgLONA6s5fN/FYcRz/A4nZIhu1Srd+rTENV5VPc5vT0+AxSicNMdz91a5KzGqbq7mbmsTmKOvqPf5XFPKnuydpXxRRd9GmrjkzDOYhiPJ7Fqr4Wjza+cy9VeyEJ9nsQuEw4JkL6Qy0Kzt520FelfN2BTzDi4Qb0LL5ie95Mj37ypPXinr/podC64SjrqlEFBocq+tNYyPZWA+6+DILlN1aEUzwNok17iL/AH6PWAkG8fmOrX7tcauX5TrFLrn0JvgkOnHyUNwwAvor6woXbQCzdXxRHsJ6U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joxewqCXN3W1QVcYXMssU/ulYAgnJ/dOPj7dtc3K7Vc=;
 b=nG3zk3BKE/D4JX8zLiuHzKww2UCIZEfV3/uWFYB3qVj/QaBdg9e+2svSQGF4KEHOLBbjALU7FJW6s+XFqtpzhvtymEqxWl9MN9HwWPT5u6TefSdfHniRn8wFgeqC+qiK3B73CDM/h5vVWvl0SGX15IiWTHdJGq0YmVe+5azoQzyjKX0KRZMOmVOs5OseiTMNWs0gBmnhMhKXTmGSOSf2TRtAB2ufmY0rXv3J3iV1C2bcsefixaJih8KU5oClmfL1r99d5eG5YQKDS8+efSvU7th4wjcO3tF2nDnYxYplEsUo7T0MVAwAzb4qH+KL88c8IqOBMDceeR4hZroxqMlMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 17:10:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:10:57 +0000
Date:   Thu, 16 Jul 2020 14:10:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michal Kalderon <michal.kalderon@marvell.com>
CC:     <dledford@redhat.com>, <aelior@marvell.com>, <ybason@marvell.com>,
        <mkalderon@marvell.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Message-ID: <20200716171055.GA2645531@nvidia.com>
References: <20200707063100.3811-1-michal.kalderon@marvell.com>
 <20200707063100.3811-3-michal.kalderon@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200707063100.3811-3-michal.kalderon@marvell.com>
X-ClientProxiedBy: YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTBPR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Thu, 16 Jul 2020 17:10:57 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw7PL-00B6Ee-Hw; Thu, 16 Jul 2020 14:10:55 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 791d3b07-1869-4440-a3d9-08d829ab34a9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB445197131C85E9F7711E2C23C27F0@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QEu7Wc/TPxSNICKB7RLgm8tcZHtxNpmgxGUI1eQNnpDIlnCyYN2Pi/Jq9JDBFGzmlKCrVy1lthEGPEMlS0AkC3x5Zd+sLXcZE8pcVy51cAit4lVjiFJ8OiX2r293z200rif4UrqtSqWZi+mvgrEsfMrhVQslH7fzDTn4dmfsk1zgQNpxQi+9Fmpkdd3qv4wm4OBmiHjwCIzpyoNdythdEN06YWDo4662myr58/AXk8vbhfQZ2RVjl/vJ7yYqC55iSVCYrNTAzu+FrGvpKU2Zj19PD0jzAqZM7PulccEDU266R82K8cAYeHPl0Zpf5qmIWprqAqssQiXZaE5YTEJmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(316002)(26005)(2906002)(5660300002)(8676002)(1076003)(66946007)(66476007)(426003)(66556008)(2616005)(8936002)(6916009)(186003)(83380400001)(86362001)(9746002)(9786002)(4326008)(33656002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: weHXNVkeUNHVKrpAw3mcfrgtc3fRHqlrJ7B0Ls+Q1GlVqi9hSBrYnrni3KmKjoPwLeJ24fEfiQhrKwQ2wT4f86z/TSPJe93YXxw3Cizl8ce14zn8hYSG09nM2LaDIx2nXOo1LSQAsLH1vBmNeEsI+HUAyjR7ndB2r6CRp4NGVMGUbTqHcF219Inwlj0wRbyCE33iBzLxRr+bT+RqxheCYXArilr4Msa/c8hKs/bp+/Q+nPaRY6WbIsYDWmCg8HDIHtWUjBCJafmejoJVC25MZDvrsxBCwVT9xy+CEIpne1bm2Mf3OEHCLJ/H/DQbP3L2y9X4cL16E1qfJEvkvy5npcWVHsn/03fr/T/NIq85hxZr2gkUMNuuVfN2nJptNXptpfPJ0vj1xzfMTo8SLDBprwW5EUk6jbOknGJpn2pqiawe4udNj0WZU9IGSFWWwil//+IXcLool9jc6XGf2ZszHy2RBV1V0UKxhvMbBmUQ1ao5znruGxPsFkm8gRi3lbyY
X-MS-Exchange-CrossTenant-Network-Message-Id: 791d3b07-1869-4440-a3d9-08d829ab34a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 17:10:57.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/tpEAefaf3seiO3sMO5btRlfVW56WuXfRnB03DitUVjnKb+8/PwLnl5mbRtIzpE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594919465; bh=joxewqCXN3W1QVcYXMssU/ulYAgnJ/dOPj7dtc3K7Vc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
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
        b=I+yZPvueMz1pJfxSrrCj60R9acaZkfb5JW5Wzz1GKvoQZXgimfnc7ktY/Izjh0qYU
         Moy453ksRHlJmFJKKboz8YB27/3Lg1PjtJVyLRtFid7Im66ThxB+sKne8yoWFuR45a
         Vuh7ZwPozfdFxwYMMndzlEeQECGmwTMJ8EnQVBJ8PDkvJbasORVTor2VtQ8BhDnaQs
         v8xzDsYFkrln25bcXLmAHG4SoM4Y2jIQwbpz4ApRxzmwMg1Gx3oBLCx50f3rQJJ3jN
         46GIMB7klmuAfVU/RI6kF0VxVEWoXa14MciboWXRyORyxZ/CVUDC57oJXihK78EjYp
         6RiFPBzaiD+Kg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 09:31:00AM +0300, Michal Kalderon wrote:
> User space should receive the maximum edpm size from kernel
> driver, similar to other edpm/ldpm related limits.
> Add an additional parameter to the alloc_ucontext_resp
> structure for the edpm maximum size.
> 
> In addition, pass an indication from user-space to kernel
> (and not just kernel to user) that the DPM sizes are supported.
> 
> This is for supporting backward-forward compatibility between driver and
> lib for everything related to DPM transaction and limit sizes.
> 
> This should have been part of commit mentioned in Fixes tag.
> Fixes: 93a3d05f9d68 ("RDMA/qedr: Add kernel capability flags for dpm
> enabled mode")
> Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>  drivers/infiniband/hw/qedr/verbs.c | 9 ++++++---
>  include/uapi/rdma/qedr-abi.h       | 6 +++++-
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index fbb0c66c7f2c..cfe4cd637f1c 100644
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -320,9 +320,12 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
>  				  QEDR_DPM_TYPE_ROCE_LEGACY |
>  				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
>  
> -	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
> -	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
> -	uresp.edpm_trans_size = QEDR_EDPM_TRANS_SIZE;
> +	if (ureq.context_flags & QEDR_SUPPORT_DPM_SIZES) {

Why does this need an input flag just to set some outputs?

The usual truncate on not enough size should take care of it, right?

Jason
