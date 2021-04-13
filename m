Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAB35E408
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbhDMQeW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 12:34:22 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:24608
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346011AbhDMQeS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 12:34:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK+QRnluBJTicztjrQAkbscrlOoJAFqxVcL11wagxy5L/326LpsXi+wLokXi9CgqyE0GImy6o6SkyFEdjvJJVQbquYYt7JhdRx++Sn4sgvFjW5wFMeYirYYh70tGxe9ffp2/QFp+NPXJhIud4G+s5otx5h5G2V7RF/hqQlhQYJY05Ul4/45YYFfkcKeuwCW584H7GbdWIEE8PapatFfe751fJ1ST/vWDxilyrzXVnPvQHK1ujoZmnGTg6PULT5vU+QjqkFOIboAB6AcM0gG8z97qB1Immk0kQNTLoEdKnJiQWML/DlnIq1EiwMZ2HXalgAkd88X8QjEV1T6YtrDeRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umVkky5ZJ85YRHxrCBauQ0Lkw1X8yfzoKmBPAa9Djc8=;
 b=lfHFaDCZ3KB1sqhKgqVFp+rh2fZnwI498yEvFbHiYsQtoQRL/hz3+1nJQYCKi04n53jZJAnkqyv4d7W4m9+4nYcSpr80uAlmjXp469izdLHQPxPqgWAJ/IW4oflItqab5amue+puQvc6/NkwNnrgF2j61jjACAFzHnwi5igqxy33OsTzb17dhCJg5diZI3fGuInIC4Lsyv+MaMnXD0El+cGHvCjFtENAlCp+OFR8odwhOnvWi/94xyheN0RpKz3zu+mq40tukY5GwtyYZaxebi4hAI54u/gVsMUnJvNa0X+ZALFenOw5FhR1vQ+e24RczEqwLEUeGhu0DjXtXgxAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umVkky5ZJ85YRHxrCBauQ0Lkw1X8yfzoKmBPAa9Djc8=;
 b=G9REXc14bhvDhOppvFZoR//xnQP48Z2Q6TMpQkeg2c7hdnc3Sy8NKYwd4ZJTdj6jCdgOOBhMkIYyqprMOL5sh28i/sJmbt4UmCqdQ7CcdEcUMCYdWunE0k8rMWX7HrvKMK7z+rNycA0DDetKxxYYlkJpsOjay3x712tHXQwPxdKAa9UuJ1n3VSEBlVl50JxmAniDToZjIeAMXC70CH5ppKtPLDQQkTRubf+Asg1Jyi4UBibBK7cTxEjpozNcUpgY0CZQ0PqppDxAy4oxsxo2IFgIoHsiLzDUJGqq3de/vTXEinVAGzFJZ9HzgzCDnVtm9arOa0lSONESV1du9VeuFQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 16:33:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 16:33:56 +0000
Date:   Tue, 13 Apr 2021 13:33:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yixian Liu <liuyixian@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Remove unnecessary flush operation
 for workqueue
Message-ID: <20210413163355.GA1318921@nvidia.com>
References: <1618305087-30799-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618305087-30799-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:208:134::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0016.namprd16.prod.outlook.com (2603:10b6:208:134::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 16:33:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWLz9-005X7s-KH; Tue, 13 Apr 2021 13:33:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0defc635-cc1f-4ced-3353-08d8fe99ef0d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43566907BC4B62DCAE806A75C24F9@DM6PR12MB4356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tm1G6lgp1OfidWIYGlp73+51jKpuCNSdVhztukqyNm/6O0OhfLw6ueHiQ5BZfLXPlPjLT6pr4ChVIlLV4nY5koDQX6zaOgCSR8huui5wOefn0rkJY6aVnsQsI1qHME9QL9ojMuJ8DZZ3FF6GOeNyPuZQ0wu+P6eofNLi9vdbHuFtS43ogOLKuFgXLXf4hknllcLNA20DBOve9rl9SaXV8T3wuIk09InyrMgUReady4DQpAHCN6QOLRe2qWflUF2aJV2AVh1x5KTWceH+D0nwZm2/zHetBi2cVfQH6IZe7t5x9YUchYU++h9KemadHnaYsrLFwdkWbKtr+3HCTJTLvSSXEKlJyoh/MYuV6o4/IfMt4+qjq4MXy/a61jMMTOK9f0i58SWJnCwcWaV2K6aUuTzei9cqfZ7jt+bWRymt9DCb9++HcBUBDMiEJkdmuPoljbbJ0UhNj4XiUuAmE5fEvL70Q1WjVapd45BszIs2omXxOc99mLK2aMLzrFJAk9S0gOL2Dg23tgwOx1UKqZH15iZZ9gnTdAN3hnr4gcnxuiPqdstHQ9JIYJ0JBJ0sSNFBNHg01AUjErfFZFUjj+0rVrDEo4lHQGesGTTmpKreUEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(8676002)(426003)(4326008)(86362001)(478600001)(2616005)(1076003)(9786002)(4744005)(6916009)(9746002)(186003)(2906002)(66476007)(26005)(38100700002)(5660300002)(83380400001)(66946007)(66556008)(8936002)(316002)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?42Glvxdxw+CCL/8zjpi5wfHEWAKAjDZcKhljBCRrg4v/tddic1oCSJc8eYDP?=
 =?us-ascii?Q?DVbJiKVcj0WJhX4YUV6cKEzUkhaBekOB0BU5uKjDjl39IY87rihfq2k9SGo7?=
 =?us-ascii?Q?MK/oaU/EDASTkveKTwJS1X917pJR6fFggZn+8/ezfVtpDvKkHqtbyEDcS9Ci?=
 =?us-ascii?Q?lLaivtzqKfXJDW7a/LR6k2NXUnUAUtbezNY7+k2bbae+JzDFzUbNePDl12rW?=
 =?us-ascii?Q?sjeBOIoHqTEkFCNOZflGJBGWL8RptYeUT7KNJ2d3+Hzrcw41QSKqQyLuDA2K?=
 =?us-ascii?Q?13VwylCiDWz7QKMF3t/CFb2gbjDJCbYiXIerbuK3IDOXZMYJYBZYt/wZZi12?=
 =?us-ascii?Q?OYIClF81LdFdjBR+xR2ll9PFX3iZ3rHmW+c34y27zQ3L3piotolxy0YfrdfW?=
 =?us-ascii?Q?AgdN7Mtuqu+81ji84e0bYsXBs6ZAYmOLAM3wBNVsXFq2zEsqjzFbK6kXJPhM?=
 =?us-ascii?Q?muoKsY9i4Urck5+h2ImTPym79+VZg36lavyDkyXrPPqP8YulPC0fjrIpc/4N?=
 =?us-ascii?Q?9pGYuZEaFupl8r9EbvFRV3pvbiLvvtQQ9cYkZtYrLDs+WWxYEOYLfq22OkwJ?=
 =?us-ascii?Q?a1yChKahlxUwNPamsfBpl8PaRIQnbZqpC2wmjQzedRk8DCxvUPIzYRAeo3hC?=
 =?us-ascii?Q?EvakVrpGXa6JpKs8niPi5VIVqtowpnE5yqSgu789ZmQFebzEtgrO4H40xfiY?=
 =?us-ascii?Q?w/Rek2lI/po9U08Gf2ZKhiVIVZsZKfTymESFjlUPqdAqEDI6JjLox1rFqgse?=
 =?us-ascii?Q?85w1OxHJ3WSgw/sT5W5QKI/KTStFwcBSahAHBVkKPOWKj365ZfpAHDW6qwY6?=
 =?us-ascii?Q?TxXCWLLtjYjgCE9Zchx5bgZbdUu5okQulYGphmkTEe3s/OkVu7/gFpEEmtdH?=
 =?us-ascii?Q?XEvbZaqF6BhgreIlhCZnHt27sWlgGLbhQw1VC3rnaSd0fEW/Bgiia9A19jrU?=
 =?us-ascii?Q?R4sGV62FDlpyErb+B1MRBgoijfYUUFf1KkBiwwVQKO3L5BLUgkSZag7IE/xL?=
 =?us-ascii?Q?Iw+N5IJvsIRXWvGAdZ4w9w6DGz0Dto9KIesQeaTHE7Adurp2hS1DFq5MolVf?=
 =?us-ascii?Q?9YhTmRJT+Eqc/52SgewJ0HVVQzovg6dse99yPbiNxFkXAyzi8IIDxPbkpLsf?=
 =?us-ascii?Q?LT9tW/sHt5KuzhIKHbqQDUMZJzMMfacD/m2DnXc9Tqv7iLrxJOKFHX/jLCMe?=
 =?us-ascii?Q?BVO8lPN2zNnsAozjd0fKFGrZTYZHYRAEPipU6Utyho0B8m3ap5SfYXptLA3I?=
 =?us-ascii?Q?v79sM5dC0f0Wx73zqUf6Ey0jxBAjMFSW6GkFsecDKnmaaRUmAEaxKg0xP2Sg?=
 =?us-ascii?Q?zJUF9G9OqKvWB96Rilo/ovcS6zFcPQ6VjGRwbwKztUYl5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0defc635-cc1f-4ced-3353-08d8fe99ef0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 16:33:56.8435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtKpt/GMwbILhUQLUHmuGuEZgHZobxdZ99FI5G17DcE2U0KNRKzLcZwVG1D9aqhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 13, 2021 at 05:11:27PM +0800, Weihang Li wrote:
> From: Yixian Liu <liuyixian@huawei.com>
> 
> As flush operation is implemented inside destroy workqueue, there is no
> need to do flush operation before destroying workqueue.
> 
> Fixes: bfcc681bd09d ("IB/hns: Fix the bug when free mr")
> Fixes: 0425e3e6e0c7 ("RDMA/hns: Support flush cqe for hip08 in kernel space")
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 --
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 -
>  2 files changed, 3 deletions(-)

Applied to for-next, thanks

Jason
