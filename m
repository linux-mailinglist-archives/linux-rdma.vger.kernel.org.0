Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09C03809A5
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 14:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhENMgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 08:36:00 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:38753
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233019AbhENMf7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 14 May 2021 08:35:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+v5EiRQekV9/2orf/WOroPkQgIoQoHpzVhdd4xQ7qOwFwq7dWipUi88MPKMrgkAGk/QC7x1Im1bTwTkTG8D+S/x3rvCHCZsLJvMVQ5pVH3yyZ577P49IfLPkKkmWZvvk8O/yKBGSbBXAY/HZ8kpXCQWxfswCBNhsOv46ChuCc3AQjQdN1kWSS62eyxFwoqEmYiV6+/WeR6/Q9WHMgVFb4Z3R5ZC7plK8F8HIkSP/F8Lo4gIonyMgo8CXEhUx+SyMHxipqF+5sMjuiMhcghri5Wxi02D8zH2Yzi2ckJhBX4ofE5Jv1lDofow01JVoZp4JixRLGvBcpyZUd6qiRnywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA2MH/211hddoknnwnmOGVgFhOx0xginwV9ob9MNUeo=;
 b=hpCe/L5/+9RkScWc+9WouIuvitaA8HOWwfermHPdCM8tiOetb/GEdtZJbyTGPCJDRzn2g1cNc8L0r1bgr+p6AUzicYKKB2FxjdPU9yA5/TRtoAJQyJ7sb+QDwSTLppMdwniNWKJMPbyC3lkcVlTApThROp4a1PNfrNd1lprD9dj8xHjwFbf6Z7Q+91v10fPPQ3XRsd6esqQtz/Oo7ryfqKusqvu8sFIoZuG7uzqcDkTBYHislfOkuKnySR7Y6qBj84SZ864yMv+nQJVBuw3Q+OrxehZ5RTp1DdWfgBIif99QL1xCZrUwaxNJgQOMaPilrZnejAifaQhc1KdK1aHuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BA2MH/211hddoknnwnmOGVgFhOx0xginwV9ob9MNUeo=;
 b=AJ7DA2+VOiFp4yxnXmYq6xmuTL6Rd/3XqScIIMI+pA5KokslfwyXIEknwPkt52dx9tDulQWD28VGnJr+ECa0MEYTl+cbovwrlTZMWbtIh4N/XVY7Nw5dKpTRg9JepITK+nZg95fwfmstexgDFOuMprLzPVf81PCAF+3ciZChG/a0WoHuwz7J4GI7YX+16M5z1u228Q4iK2GV5+ZKXoC7RTXoFLgpoGg5ziuR7S3eWfUzHYDYSD46F7ObzA2yd7GHkMZ2kJA3Yq3tpt7ZTgp2W+LwSDuyMLmyo0hnxdVAGQJS9yx6q/h7BlhS4BnEOB+BcENZf0BRGq/n8Qte3qotfw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3929.namprd12.prod.outlook.com (2603:10b6:5:148::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Fri, 14 May
 2021 12:34:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 12:34:47 +0000
Date:   Fri, 14 May 2021 09:34:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/6] RDMA/core: Use refcount_t instead of
 atomic_t for reference counting
Message-ID: <20210514123445.GY1002214@nvidia.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
 <1620958299-4869-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620958299-4869-2-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:160::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR13CA0002.namprd13.prod.outlook.com (2603:10b6:208:160::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 12:34:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lhX1h-007OYz-HC; Fri, 14 May 2021 09:34:45 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd82538a-976f-49aa-c83a-08d916d4a888
X-MS-TrafficTypeDiagnostic: DM6PR12MB3929:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3929E5B7D05C3A6AEFD079DBC2509@DM6PR12MB3929.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yzNdhpEBQ4ki8QReNv6cM3reomF6tuBCZ1vP8vNr92Eua+LdAF3MJm2i7Zld8iDAAMb2ni6Vxa7GSz6kDn1k6trvvizN2wJBHf3iO8oSk+jGIDxtI0miBbcxV757GdUi767mdMveLOmN4Z8OEcREGIk+GIGSiRMvQqFWPlqx3oLoH2mKIUtxshKGUbi0sWlLESTfZRV+eTCPcn0L0HOFb94kAgWfznh/UVWiw8usJ5XJqowz/Nbrz0tu6lV6pFho4wJVJs9AFTcisqpzi+iHHP6o/Rv0ThO7kjgG78zsCGh3SNd4c+2hI9+2V4+wh9mApkPSkG9dRQl5legWzNkP0ERhzWwNJZVnNzr36k46qZrbjkI1isGD2wfVAgE3rRXtNcK7MjmQd7q8rE0NNHQDGF4DWLubycNj2CaXf27jMv6KqA6awjmfE5qkMdg/LhBq2Metxyq7A1FseomEMTB/2+4caXGFfPgLynYi9IOefrtizN2Qq2EcSdFwe/QBRzsvB0W+y64NUiTJNRF64sdvz0Q10Oa/E+TRhqEZTVqLeFxmZM7u5IVusKZLuPewPvdtoZq1IetgKGlm6EbiIh7wyM1vZqUduooWaap05injvtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(6916009)(66946007)(5660300002)(66476007)(66556008)(8936002)(2906002)(316002)(8676002)(38100700002)(36756003)(1076003)(86362001)(4326008)(4744005)(9786002)(2616005)(186003)(426003)(83380400001)(9746002)(478600001)(26005)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?N+1d682HWB1VJKUBTC4ISnpSasWE4Y3OIoNzysGFH94H4T79pX9Y48+tAvX5?=
 =?us-ascii?Q?xiZ6Lt019FDjzdWy4kOy6FI4VVmgU5bMhvwoicKSjz7iHor/yxgN9m9huzGW?=
 =?us-ascii?Q?paWlKggW1pdCM/K2msmJZkAI4WvHVwY2hIv6YBIh5wOFZYShAUKgWPSI/sp9?=
 =?us-ascii?Q?ZPTFYfT3ON6mQXMhAkIBS9e4ikFm7XU24ZZ5Dz8LrMqiXT6TKQbeiFF5pqep?=
 =?us-ascii?Q?6mpK2c6qUNwsvOMb070ZICC4CVS4BiQj7SoauPIWq21iGeGPWbHPdI53odvd?=
 =?us-ascii?Q?OgEz5s62+MEK6FRYgIAYlvMVDnilHARXHmULd/vubEG9wtK1G0crlgfHAbHJ?=
 =?us-ascii?Q?LdrOUruzhnvsjRQ2VuBZz1ztcsbK8NIWHcvk6uy/I5RHHMdec5vL5wBabRPO?=
 =?us-ascii?Q?eAxpznJFxTb+1FAe+rHqBTMeCdeFu2k9Py395VMqz3/fXDZ8mDIfCGt1JsDW?=
 =?us-ascii?Q?t+yGB3OsTsWrjOLf+qvYYjmZfdrPnOW4CDs0/6oMfxnlfuFVnL0P9AQVz49t?=
 =?us-ascii?Q?28ALI2gmNnJAQ437lQ6ePpkfCF2SQ428TI9dqE6KQZfTEvdXTOnFTbs6VZKZ?=
 =?us-ascii?Q?R23pLOCvmWjp5CL1YmAdHwfHM2fwuQyFsiFTH5T7t1spLP10y8Cy2KpnuZHf?=
 =?us-ascii?Q?mn+6P/ZAPrS1NMUKA/P/k05IwZWsrxT3SfcxeL0Z2rbjF78mb4lHhXEJo1wC?=
 =?us-ascii?Q?bKs0x6RtjU96cpKB7Kmt57Tb70aRgHLzMvuagUZg2HPPMQUv1CMDbCHAZ49V?=
 =?us-ascii?Q?N/pfWHpdfQNWc9Ca6IzPARwzz0Y6m0xju0XmdOOh4p/mXW5Rhy66i8cwcfV0?=
 =?us-ascii?Q?HadpNjTY837HBywX6QrfMJTHO7ElWzqZzcEsuKq/qutsD+cMgbwLCOphOrwq?=
 =?us-ascii?Q?lMA4+giXMMvKk1QOZou+oY/DAnfnc10U6hbBFoS+3Wfv1vU/lOB71ku4GCsl?=
 =?us-ascii?Q?LuLmtrKtQ2hR5zVGH7YUGPwy5LwkojHdHoM0Ey2O1ZEQo6SiGT41ewtlS+xY?=
 =?us-ascii?Q?y2szvuFNb7vYklHdznEUV5CM7CmnJ0p9sF+4LXPPDmrI6y256wicuQbDePjR?=
 =?us-ascii?Q?OM41i8mdE3KNy2ZNY0YRgAScBFxTwX4Uu6H5GOm81a8PrfwUfo5A5nChyt76?=
 =?us-ascii?Q?eLwgdre7t8iX5gk2qIw7220DeE9xQAY7CwlK8rqCSpX1NSv+hQHIQ2cy3g6A?=
 =?us-ascii?Q?JgjUOF9Rs54fnoxEBMHLPrspmYsWq8eHRASXCTGpj0b0N3xw0V1LyQ7REjS7?=
 =?us-ascii?Q?RHFO2Q9kooT8FLP17jRH7HgbuBB8YB+sjlEisfaPpcUNyrIyaNvNZF7Klis5?=
 =?us-ascii?Q?sZiT5RxlqDjQ5zQojT9tYK01?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd82538a-976f-49aa-c83a-08d916d4a888
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 12:34:46.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZqs2mZ3Bv4tEh72SRaGaWsciqyvgkBDmpZ1zA8fv6W/JrhKHg+4EPgQERItyred
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3929
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 14, 2021 at 10:11:34AM +0800, Weihang Li wrote:
> The refcount_t API will WARN on underflow and overflow of a reference
> counter, and avoid use-after-free risks. Increase refcount_t from 0 to 1 is
> regarded as there is a risk about use-after-free. So it should be set to 1
> directly during initialization.

What does this comment about 0 to 1 mean?

This all seems like a good idea but I wish you had done one patch per
variable changed

Jason
