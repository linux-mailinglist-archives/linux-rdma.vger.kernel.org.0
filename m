Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EBB35D085
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbhDLSoa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:44:30 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:18241
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237222AbhDLSo3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 14:44:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/MYsvCtQqypeQy2kwFGUzwgSMKXBSuDPt933iRMtVfrPKn0gW9yn9XE6gTJ0PPD/H4Ey3gVdKq3xNv0htDHf5WqitB6NqBP0OdXES8eGFpZ+kzIsG6W7P8Gj0VOke8NVe8Bb5WYNVr1/svuDhFuFrtxoNagkn9KBFRtoRVT9Li2raECiXiZEAMwrjbxV+MeJibkSMdCffwh4GiM/zE0Y0mdNC45qjHGITNDGHibQnrFg4zltqF4HIq35v63sXpOAUUJH+DGNK8GltoXsDvW8qccDHsaPbGvg87zIJ0kz3zW9Vf2vaF1YGLQhzfVgRgBKxizI5psPf8IN8j+IIlgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ8MZzN60g2CZN4So5llDB/SjK+F4+u2C/0m5vwXzXE=;
 b=R7rFVCAoplYdBS4SScnkbEa2sf844q6CyWwYJQ8Si44QAZW04V1fWN6L9F3heSr+nthN9nZkFAa+CHrbkwtM6xeeImV4ynx4x4HKPX38yux/wqhtXZc4aCNZTBxbaFmT+fmM6Ai6y1t85hX17CANwSiRpXnbSWfcLzZw/dBeTJIFfkzweM/jwggCsl5TYDBRdPp5rpK/LDrgDXLUXIiF3UzSbrKfFoJXi0VOmdv9RbN7nwMYsV1ca7Vzot8hoi9HBBK0XinTPPC5TCV07TFb1uz/oVEMGfBlDOD/pccq7593o2eDLgSNkR4/qd7HDx//oYZn9HnZELj1yK7YB6YY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQ8MZzN60g2CZN4So5llDB/SjK+F4+u2C/0m5vwXzXE=;
 b=az70s2O02ZcU5sdLLjywnbfb01AerckLWQ9DtM7kDFuLy7LRR3eT4QweIGE0PDIk50GASaQByMojsz9eLgyylRY3wGpXPW4g6KSkW5qX78QNJk3vd5Pi8EnC60pDKgxYaJz3HUF/Z7UFhkEsdsUWWeUOcwUrS4OvSwqzPar2ablGdQx/TQDDR1qEljvJlp6Xk1KiQLK6ASw2iN9gnODWUO6XvWxBWioAieoJHtq3nkgkPvXexI3HFW6eZGTu7XdHFBE2BeJVEDXKmwHcK1bMb1yJTTMFTv9B7t1/LwIV8aryzmf8gaXTmj5AKiqXkOXw8ANpTS/tSiOEPXXS9mJ6UA==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 18:44:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:44:09 +0000
Date:   Mon, 12 Apr 2021 15:44:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv4 for-next 1/1] RDMA/rxe: Disable ipv6 features when
 ipv6.disable in cmdline
Message-ID: <20210412184407.GA1163957@nvidia.com>
References: <20210412015641.5016-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412015641.5016-1-yanjun.zhu@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:208:239::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:208:239::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 18:44:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW1Xb-004sqJ-RS; Mon, 12 Apr 2021 15:44:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 687e6816-2f9c-417b-5226-08d8fde2f520
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB481015D4CDFFBE0F2097664CC2709@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldRUj9eF7aP5Vkq1yPrw9WW6pPhaBmGaONIwOtSjjy1Nu75i37o1dj9UFLEPB8hsGG75/XP1lrSVUb7a6tiGuIPuDz9iu2SJfSiihUIr4OyzF24K/wKxp8v4qfnGOYxqlNSz19e5uCBbFU355shOdgN7n5Hcwbx75+tb0a1gbco9rRCoizx7e0YsRD/T7Df5p9wtnOLXeumwYIMtqLHyQwgN/KW+sV9Ju9Ax1b6rmcUj/ubDXPFgT43cyqsuJLhKkUwiFBQa5mwyAKOO0wLSvkY+JCyNqhn3mG5ZbeFfGJlJUgfksP/Gb5xVyToXqsqudw0MeIa43IMAA5A6eW35nK4vAbTcTzO6vy/jhbumNfoVzO0HhSiE7s0Fh3Ns9SMQNr3hD+U7s5ItQ/5gJArJuuZZqBfMcU80pUn/1Mb8txurKYeeZD6hAGa/RgXjS30WXxemQ0x8YJ0Q5QT/ocyBaZD9bO+h74hXlzKLIHWa1ggwxsAdGycRS7dcdDdxtwHfNasQy7+kZYOm/5rf7rWVjBGcaeRrR6mOqds6OVfikJNjoQLL9f9fWTkAT78yDlPUj+0t8Oe+sxwwlaaEp1Sk5zhK/oyPr3+E4mI9BgniiiiyYa2RMt2pWgP2xBBqwOWksgE/W9reakjYL7EXXKlJEK4kFyOQ7eJXepQoW8o8sQvdHpcwRHmTq2yeSd6PiR7i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(54906003)(6916009)(107886003)(33656002)(316002)(36756003)(83380400001)(2906002)(86362001)(966005)(478600001)(9746002)(4326008)(2616005)(426003)(38100700002)(66556008)(186003)(66476007)(66946007)(8936002)(8676002)(5660300002)(9786002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G0GebupcJmSnF44SOgckUQ8RpMIV8DpxxiSOTbg9GzrFukg2A0TMv/2aoycf?=
 =?us-ascii?Q?7PKrZoNvBHokP0oGnkzJ4PsAg+dJfgTEcz8oxvwJmG4nBbQ1miYzFEn4JqML?=
 =?us-ascii?Q?khl/+gOYiI89cfr28/cyNkrJ9Gmxou93xLFv3Qsg0cXo6ELLiyLE6SQJCRvl?=
 =?us-ascii?Q?ahkOMBC10MUPGWHI2/NsDhdf88MfZKYj0Fm+wujkAoAsR7IvbnpbWID3BNSL?=
 =?us-ascii?Q?mW/X1P13R0DHG4OokjI/QXcUqYf70QHdibYwEqxZZJc3/TRuiJ8aZZkKNU4q?=
 =?us-ascii?Q?Ngli64D2uojzoYzAAwpW31rVcMRydKOifq9/07KN1Zx5TDSytSdQ9ou3aIN+?=
 =?us-ascii?Q?q6o/7qIp0aAznH7cQedokfOt+30xlDJxxGHAaiYzY2Tu4mMJHhQzvUtdYOWh?=
 =?us-ascii?Q?Jy8UvHYg3HNqJrrM0JKDngjgBNU7h4A/2xWah7zUor3m9BuMXdCvtBARNcAm?=
 =?us-ascii?Q?yCRiqr0l7TkO5N2WRl+kvTfMOl0p0Ll1R47LRguZ84WwtNlo7on3ppgbbhdt?=
 =?us-ascii?Q?RdLfQ+lJea469Q67CZJ4npa6xw5y+A8G8T42/stnbzuuKRyzEM+KSLfWTFb5?=
 =?us-ascii?Q?Ed5dxH9OMVVXEKQsLTR6kfzWp+Y1cxkDY+SkOghrVSU1tfJdMbDV2rddeUxQ?=
 =?us-ascii?Q?iZv/PskTXMwim7iko5FJghJI5r3GkACRq3XlLeMm7LfqmTS7MzsGNnc6Aj6H?=
 =?us-ascii?Q?lkw1EYbKoVAkw8/8h2hrVjYAsJl1UeOv2bLW8p1RkCg7GdV80XoD/R9gJEw2?=
 =?us-ascii?Q?AoLNwGsK5rToMYk7Go4/jFlkBWR/djBIv1/eThENwutBav9fW8NqScptz5LJ?=
 =?us-ascii?Q?rAYL5O6pEKDvPVxrnIk75oiMolIGBjKoTG+Obd3wfwpQdamWp+S3GpEAaq2q?=
 =?us-ascii?Q?IeNf2hHiwzDCKO/ao90vUVxBNDazf5A8Dr3wNMenQ7VGaM4dEP2Z6FzRL/ka?=
 =?us-ascii?Q?gTfr8yXNL8HBPnSDJlLOncD7KtTF4b52BsZ76qlMaYOfWIIZf6udCqJBK3IK?=
 =?us-ascii?Q?xWmNMrfthATuD2jhvWKCARpg3Jpms0XlRCTpddKBopiNic/7xwFWLUloj+PG?=
 =?us-ascii?Q?MWRz08BsBpyPLiEvQM5bAx0hQUWCEyw2pSbIz2MgQT4K71osidrBPuO3oedq?=
 =?us-ascii?Q?KFmpaJ3VDctTVDPamgaxMFLVS/tF1mR0sdOuvayXtyYlGHipcGgZk5UgIXVp?=
 =?us-ascii?Q?r71AYlfMTR0zaYZyggpnRmEF9bnqoBXMOC0vmgieEls32LXK1zrBxOo2q37d?=
 =?us-ascii?Q?oaXwyFkJDiHVu7dK9LJJErX7NRj+pwZP2TJh2PwR1qHe6uDq+Mxvn+J6jcWE?=
 =?us-ascii?Q?d7lwq0aYvSe0HUvB2EXE46mpH03gBby71UsrckygdbFJ7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687e6816-2f9c-417b-5226-08d8fde2f520
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:44:09.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeI0We87wWO1UeW95VwbqPDyVKgoBDQSiE/1gznPh4966/1qN1m3zsrCiNMG/ScW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 11, 2021 at 09:56:41PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> When ipv6.disable=1 is set in cmdline, ipv6 is actually disabled
> in the stack. As such, the operations of ipv6 in RXE will fail.
> So ipv6 features in RXE should also be disabled in RXE.
> 
> Link: https://lore.kernel.org/linux-rdma/880d7b59-4b17-a44f-1a91-88257bfc3aaa@redhat.com/T/#t
> Fixes: 8700e3e7c4857 ("Soft RoCE driver")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

Is this signature block accurate? I'm pretty sure Leon didn't look at
this version of the patch.

Did Yi test this version, or is this leftover from a prior version?

> ---
> V3->V4: I do not know how to reproduce Jason's problem. So I just ignore
>         the -EAFNOSUPPORT error. Hope this can fix Jason's problem.

Who is Jason?

> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 01662727dca0..b12137257af7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -620,6 +620,11 @@ static int rxe_net_ipv6_init(void)
>  	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>  						htons(ROCE_V2_UDP_DPORT), true);
>  	if (IS_ERR(recv_sockets.sk6)) {
> +		/* Though IPv6 is not supported, IPv4 still needs to continue
> +		 */
> +		if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT)
> +			return 0;

At least this looks OK to me and the original report certainly said
the error was EAFNOSUPPORT

Please clarify what is going on with the signature block

Jason
