Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB93B0CD8
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFVS1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 14:27:31 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:47764
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhFVS1b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 14:27:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJft5maBPiXq2S2y1O8JZrV5n9beujXQDD5qbE225wmwUrCS8zS7E/V2gAuAof0sTvJcv93oCzugS+ST8wdUg6jJexfV6snnNWEG1cuXZKnaQK/0cbpXKib01R3PwEmJPGzpeHWvApNfWIVJm/s6zHw/RM4R8PcEYjazlm5/WVxtfSCYQ9bDoJgZcarepx7moeggBzqmCdt0qwkfN9FxwYS68nDwPQZyBPbyi0Nlf4Bxf2v9dGJgENTd2HOSdSzwAGvhYlhmfqKHrVns9iZO8KwgeQUETqBYrX2Xxys+2c0s7QmmP9LvnccheTNWc0XFqcxFtRYjRnRUx9xN1ynPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NF+4p3Kwj29gFWqYwArIZu+mY4zd+qsCJeMI/pDQ3s=;
 b=dCw69q9PHz5Zn6986g95jXfSpvNyrslQz2u2sNPQn6gHCmtimN2xhGH7zRmlSrj9Os0Jg1OCJ1+F0B5s4RiDLC8v9e7gDFXZVXQdgOXQ1O6LQuh9dpUVg1gehNCdloPrI7bu/jopzvQEsxvw47bPr38CpbXPi3wBOvArQ4EU0hXlMGrFZcgQUlwCDhr9d71PVcd6bsBwl+Y/+xButQ+Fv8U4XWXIqGfbsdqMkw16SQPFRTyoHfm3MC2Ygh9AuXLewI9BlJBvhdoL72M+oZ1Ij3quZ8mobytpBPazeioDqImKp9icGQjfIcp/56y2BDWIlLn+IJvcsxoOd3XSsaZAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NF+4p3Kwj29gFWqYwArIZu+mY4zd+qsCJeMI/pDQ3s=;
 b=eRf9IUc3XkFbUMMPqGwu9n8ayBRZZn4CQsll8Wfe9o7lS/oxHIlL9Y5w6KJ1vzh1bNFY95NoTpt8jjUEjMZMFh0xf9Eo+nZ89LzYlGtR5VQ7cfzei1IF53TTX8NYWaVcrNwllj63yf8UoXVDu6PAmmECQTqXiBksRU2X36SZsHZna8weQnYMIWfn+Kj7ycPtK0+5LFF1jZdxOUB8nwqwE/ROJMOStCp8Z1Ik8rBZLqPWKLAeNrca1Zlolt64Tr3aVTxG4RTRFc8WqghCptrkXEc2N/9FYo7w6a2nXQ8hMWrksm7C1qaXql1bDkfBL1MdDAPzIa3qfZT5t4/ndVlhpQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 18:25:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.018; Tue, 22 Jun 2021
 18:25:14 +0000
Date:   Tue, 22 Jun 2021 15:25:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 00/10] RDMA/hns: Updates for 5.14
Message-ID: <20210622182512.GA2582295@nvidia.com>
References: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624011020-16992-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0003.namprd15.prod.outlook.com (2603:10b6:208:1b4::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Tue, 22 Jun 2021 18:25:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvl5E-00Apmc-Um; Tue, 22 Jun 2021 15:25:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfbdbfdd-b94f-48c3-47b0-08d935ab13c8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50787EF995697182A6389494C2099@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXJoP0ayBN+qJLKFqV3rmddhQ1JaY6crMwoyJSVdeMwBY8sSkleJYIA7+pSLKuc7MmXQewLhui5gvXGDm9U4Pbo18Su0T1Ojh/tyOYG968N87qrw3SI6JKWp8x666WMtXWbFiRpM7radmlye0V50iHlEtc7ZofcnOOUiyNVTg2ae55Nqpr4kQP9K7jqJh6Vzq3hFQpGnsX2qQmWoC6gjqamI4kUJBiqg+0FTb3oERG/uZJQcfH5HcS3XBFG3yGZ0+brarZ8kjgrb3L39IOLU/AWV1YibfP2Oprx8sog7cMSGJynT8fHbJGf28dw5Skn5oKSnpGEqvl0DDqFQ2oApuw1YPNPekoiK1CxHGBVxMPsYRRkxdnbYw45fvxyVlz+PqtDGMfWT0C+6dr8A5jaPjtUDqdqFmyQFU3yzoiyrNCr8SJeLWdiogajMidkxzAx/uArI5u0spu69LeeyoNKLjafacFr157BjG3PF+5vrfEmrCpjPeJzSKwfCQM6KALLFehgNF9EuhOvTl1U1bMD+miWnxXKjrDIVvJmWoYuZJcOeY04Qsj7m2aBdi0PKOugcXQdhvaLS6D6w0UkKBRvfK0gyY2c8AvhGG3NrR5voMRE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(1076003)(4326008)(4744005)(5660300002)(38100700002)(2906002)(6916009)(33656002)(83380400001)(66476007)(66556008)(26005)(9786002)(8676002)(9746002)(426003)(86362001)(478600001)(36756003)(2616005)(316002)(186003)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOwjxi4oIrK7ss9R+3xr8IBWXr5BJ66eJ3SGVdT9qpFmojq/OPSP6zkmbBnU?=
 =?us-ascii?Q?CrruiwNbLSdVnqovF/dsMtqe8U0LzI5Qqfdc2bgGI8/xlXwi2kQYPINIWukn?=
 =?us-ascii?Q?85psKb7I/9lBrysiafQtuzC4QbScyThuT5EqZZb4LtROFPn8XZ1bRB58dQKP?=
 =?us-ascii?Q?nrO2NMLOyEBnAmKkjs0tV3MFHoR+rfmkOWXYZi06CkktecKWr2P1irLb7rcK?=
 =?us-ascii?Q?ChwQFMvpX6cvoACUIppG5JTK999BOG0sx6GMIua/oHNndMfve/by6hNirihR?=
 =?us-ascii?Q?8dKhfRxeJaJwItXl9HKtugfJyrmOgbTTOWabs+tK5VL3iAhMvlt66FU3AOGD?=
 =?us-ascii?Q?qFzxI91WJhRQiL+GrmfKkl8FC6mo0IrF40M9BUBiEVDDA9fd/GIZb2RT/O4m?=
 =?us-ascii?Q?PnddhnrjaGo3ad/8RY+Ie5uEEGNnVBHBhjv5gY0fSNmCSm9vTobSakR6zGMq?=
 =?us-ascii?Q?yBHE1Zcm1Y4GU09VnCz+u/gbDooLYmVDDcJrRzz+YFqTB9dw5P4i13r6Hbm8?=
 =?us-ascii?Q?s+Oi6R3TgppKlJ0cKO5VeUgdqm5V+BzkdqM/VKkEJvwqbsiXCCypGLyGcmM/?=
 =?us-ascii?Q?YK3j6pF0GWnPVzHzky9gzeOExEs8kPOegpSDpPCHghXLLCsOEFkQY6122bCv?=
 =?us-ascii?Q?JBxW7Dy9sBuwOULBKndhiIbkOSypQD6SeDw02vuKqduOyvpjmEbeqH4cTgqo?=
 =?us-ascii?Q?fmyhW6sLl/YObTvvzikJQefnrwb6uu1xUD9ZzwW6HJRwO+1OHUDPDTM0P9Qe?=
 =?us-ascii?Q?abT33wCO6unqGVsB4YfmbJbyOR4pV3gM2MNtlG5Rn+7SCHQ8P2LQ45D9b5fB?=
 =?us-ascii?Q?qthKIdVwsRwdpX5VD7VqaxJb4g2BPSeLQcK2P6uX9XvEB2jhD3wD9AzpZykY?=
 =?us-ascii?Q?W/32iQfIUF40L8bwpx0x26qTsEdRdU+BtOMfHM7HAcxVOM09YtuTpYr7XUsZ?=
 =?us-ascii?Q?rdljL6+oI//1tL6NK7X841vn4zhI0ixB33wXRjOmKgp5rquhuV8xUUATXSuh?=
 =?us-ascii?Q?YZjAmrYmWyVO/ot5XYKb0+Q70JLGj+Qu9rfdhemZ4LPcrGvtqeygdqxhOn9/?=
 =?us-ascii?Q?2nO3UBN14nLYE2knSKn8Ti/cnxGUtuuB0K36M/WEwU84M2YQO018tbhr31q/?=
 =?us-ascii?Q?Nt69GSWy9mGeAtJxqUdteKWEUET37I9zF0tkIMuIS4EV64Ybf4mu7/epJ6tk?=
 =?us-ascii?Q?/h12p2HGNHh5bDbGLqP+PUupW7SJEJBQ8natxBDi9oqBjkEW1Pgb4yWa0yX0?=
 =?us-ascii?Q?3nCuVbWKqC6NYAriknJTqaudj/layYixjj2kjZ24O8/cz1KB0z2/vq2DTKFO?=
 =?us-ascii?Q?wDuBjA938KvWjchAdhDzcxp7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbdbfdd-b94f-48c3-47b0-08d935ab13c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 18:25:13.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNu3rmEtsqZQ/C5wGaQZL++D0iw1IuYDCS+LCaA8DiZQClJtmSK0m5uGMRi4rZ4r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 18, 2021 at 06:10:10PM +0800, Weihang Li wrote:
> As usual, this series collects some miscellaneous fixes and cleanups at the
> end of 5.14 for the hns driver:
> * #1 ~ #5 are fixes.
> * #6 ~ #10 are some small cleanups.
> 
> Lang Cheng (2):
>   RDMA/hns: Force rewrite inline flag of WQE
>   RDMA/hns: Fix spelling mistakes of original
> 
> Wenpeng Liang (1):
>   RDMA/hns: Encapsulate flushing CQE as a function
> 
> Xi Wang (1):
>   RDMA/hns: Clean definitions of EQC structure
> 
> Yangyang Li (3):
>   RDMA/hns: Add member assignments for qp_init_attr
>   RDMA/hns: Delete unnecessary branch of hns_roce_v2_query_qp
>   RDMA/hns: Modify function return value type
> 
> Yixing Liu (3):
>   RDMA/hns: Fix uninitialized variable
>   RDMA/hns: Fix some print issues
>   RDMA/hns: Simplify the judgment in hns_roce_v2_post_send()

Applied to for-next, thanks

Jason
