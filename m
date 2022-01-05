Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59704858D8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243324AbiAETGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:06:09 -0500
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:57824
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243307AbiAETGI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:06:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vski5SGfXP1oX3fFT7yCrdSNuWWdOsd+tCBltRFyt3iLgHf0q/WCbGqBw6efULDh5JKWdDTFIWqtpOA2zfK/oyfc/opYkaxY1CFt1BWNXZOpysMDE0rFG0y92JhZCCU/rxxxz8voxGb+1Jqa7PrvszxPJXQrwJG1muiXpEK7Dz2uV5z4YSZt8/QijrGFi3EqmYWHmJfynHDnJTM1N5HpliI2ntktFjYbcyr0/mjwZoz/38aDEC9iW+cw5TA5jjUnAqVdMloVSybCLvJzX7OlcGyxo+ZENwtB7gz2tAibhjUFqUqq5SCEyOJalBgijBiXgXYs0AIi8c/pykEPeJ2jeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0aPxu6Z1yMab9rsWJFqMsjSgiUfHwurpSPMVxXUXAs=;
 b=CiNbSQbUe1j9f4za3dkJhnCdjV/WgAvv9a1y9807lQx/BdynApaWcUdhMbKx07PP2pEiHyHLR5ILRFo1hhnIwk70PMux0XaxdsqGSzHvwYzLcMXP+ED1R9x/bMdh/SOT7SQC0wkfRg6Z5DELfzoxl5q1QBWnpgEVO75X6Q2cbNSCl0KnGPvG037Jkk9KeNb2X8yIRfH0occBG2fz8p9PEwoGW3cWmgkMP+l7eW/iVLG0ReV+YQG+uBBtlVRUNY0hdAUIhAWmsqESLAVfPDrymYrEPUtBCbMmk9R0xElPD29010ZCPrIYsy1FgQduSAyM3cPpGeH3ekO3X+NMn/ZNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0aPxu6Z1yMab9rsWJFqMsjSgiUfHwurpSPMVxXUXAs=;
 b=iXsauykaXhs245Dn91Qn5FIM8OzrtF1PHQJq9CJ9VT/+upGJ0+Kco+06ZFAhr6BUnP/TlNB5ag3wKuX2fnjWNc9hYOFRKMjqWp4zRqTk6yMGs8/owydXwc+QrmG1196FEqEoWUz4g0l3vjhpebx7sXLZSIvPIaaVPVky0pWf6vsdPhGaVbVVPMecrEvtUP6Tte1IBPs3SRKW56kb49qYvnuAHuWctZG1iiJsiT5aFW9a6bZo8o5+tBhD9GWtgE7PgiRZNTCLxys5N993zAJhSk78mekH6hUSQMgkUO1497Km8awgPe3bBqwbJbGKEKhaV2OsMZ5CXh+YhcJFusIOqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Wed, 5 Jan
 2022 19:06:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:06:07 +0000
Date:   Wed, 5 Jan 2022 15:06:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Remove the unused variable
Message-ID: <20220105190602.GA2861973@nvidia.com>
References: <20211216054842.1099428-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216054842.1099428-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 968cb27b-33b9-465d-7a1b-08d9d07e6d5b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53623D40D5FEE43BF77153CDC24B9@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwHEJ+4LI4MQnkgyXsIFUByZ9Bu5BBWOdEngPj9PyzCe/gUYLy/K3fv98E0XPp9QOI8rpV7jH1xHP0T/cpRASO5k3AGgLVgNzoTEyo14dupwoHwTZQQu+i0U+1BRx/2ygQbdVauuM2WhNVqZ9NY9pKWYOVGaLmm6XDgesmm4/g1zPDyiP8NikwACQshHQOPYKt9fUN2MAADsu0kKWnB3Qf+5jFJBak4scXlpYp2EsEa7uNQxAG/42N7Zyj5nEBKKGytV5cgR1XhIZUykFmZw5qTaOPXGfLNHH7H0dJ/n6WrgGWniQ/plrCf+2zW66xMDxxD7usvHK5oQsdNLJyB01XD/sxwf8oaj5XIZraXXWBEkHQDIWnhET/vzOBDLybYiZpLH3eav6B+eqMveblgoXHNtfakVnSAvovWrTve/iAIDexXlD7uMxZ3yjqfOUGwwHiYR39ya3yO3F2uHGfBNH3NjLFWA4ax2DOwbRRuqvEtZpuPbszQOxqoCnBIL273npV48zhjAQfIgeiBIGoDTY+1kG04wqEmUb+bm1tjkohpA8u1KccZqsHwbvGV47otAyaW+snadlCUvJRG7102e+AZdhuU846mkA+n0K/3A3BlGA1o12M2nNwJtmn9MayAlXpkmPBH2xS1iDqxIEh4xeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(186003)(26005)(66476007)(508600001)(33656002)(5660300002)(86362001)(4744005)(2616005)(38100700002)(1076003)(66556008)(6666004)(316002)(2906002)(4326008)(6506007)(8676002)(36756003)(83380400001)(6486002)(8936002)(6512007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YnkI3aPhQtdfMQ55vPmW+bQ5G4Ffdhj0gMGSE5c0Dj5mQPqvHZUw7Oxm139h?=
 =?us-ascii?Q?QV5XLgScxk1LfGB/3PYuHGg/KSyQRt+SZbWHzVgXpXSmVURrqyxN8pHHd9P4?=
 =?us-ascii?Q?2MPBdcpgDRxu4y0WvrSo5HFHzqvTI+jN6CXVROYRrxZQ1/ZfATvoNT5WAXgf?=
 =?us-ascii?Q?zorz7FztCX1C0EStMTlq1EEL9tSrYqCmjCSGkE46tU31SOEO8o5vEI+5FXaS?=
 =?us-ascii?Q?7J3zrbHzjAD40rpq45/skewI141C0EPyH3MQ//qacUdBqHvoqXYzU7+9rQq6?=
 =?us-ascii?Q?5LUks8GbxQ/THRc8A1E5ONvoscsFWXkXl60bMsDTCZwAIW65UlWUYYXThRCw?=
 =?us-ascii?Q?BmCWP+kwjj4KSK/f6pLuLuE4fI+mK22cq5/LaOEo4Wz7F0l9FpktpzOdpVCC?=
 =?us-ascii?Q?O1EMGDWdaqkgWKHoWsrf5VrKt+4YrHZ/69jz+gQJKLguQaJgWf+ssVTUqpB3?=
 =?us-ascii?Q?N5KQrv0RHs+3SgpKgLrBD2N5gWnF97AmTML/n3TgqUgniHvCT2KGRFQOwoUn?=
 =?us-ascii?Q?Ep8nNH49BTcj/c1jbq2PdSmzJVOWBdrTZOR1ezCjYosoRKGnbmLNu72/OC8p?=
 =?us-ascii?Q?P+lGO6DJ16gm4SBgdeGizvhz4wQcOsuZnb7SR0Ka3MBZyGvSdTfplpISP7Vv?=
 =?us-ascii?Q?nV31w31lktAR671gIuB3wezz2GzihAHQqY1vOeTPyOXhrxPZZjwDB2nzyAZ9?=
 =?us-ascii?Q?MplemwVZ3xphxTQqst44EpF3dKLXw12W0K7ROaXMuvf703oA04ySLbGUqng9?=
 =?us-ascii?Q?6zZNQMumvZdNh70K7NZJ2X9m4M+k5pAyyejKwP7DIIQROJgGIYGbqLcyJlSp?=
 =?us-ascii?Q?UbseCmuyllWeo2R1yVCGyfmkuRfqGWAOQO3GzK93WTFkYn1xrhL4Spt8zcLp?=
 =?us-ascii?Q?0RR7AV+2FeTDwCgBJF+V6kPbD1QJXhFFgvA9r6OFQ3QR//1yjrAs0tSHf6Q7?=
 =?us-ascii?Q?ixFwfpqqvfWAuDWggfTi/kWG72GRIRE484pFkiYBoTsv7gg7IdhEVyQClOyf?=
 =?us-ascii?Q?gcNYf6hl6vaRJTVdQJ0QL+g2Q+wxWK990dBCpCvIeQIsIxgZ7B9uc0Vs2CpH?=
 =?us-ascii?Q?acPIEja2TuqhzX0nNx/93I0UTogSZp+ysir+6TtojBERREUpa4bywasweubv?=
 =?us-ascii?Q?+vtnStlIC5NPOUgABwXRZ+BeP9JenDwjESKhZjoa4UGj0OrNZQMkuxhlN3dr?=
 =?us-ascii?Q?ai9/1rpzsrdhVNUOwebTVQW3vOQ/xq28JVlVPbvZ0q555x6Nvoptc8QOogb8?=
 =?us-ascii?Q?UVaeFsC5ywAvXkHz5OKWhtXtHX/XY5oz0twmFmNpzoFO516rTHdw6m0zmdwy?=
 =?us-ascii?Q?W47KkzChtgt6GPOnyndsL4v0bMG6GnLlfGvkxROD978+NFx6yoPosZaloYP7?=
 =?us-ascii?Q?skyT9jp9/ZHbsLAJ9ZNSeYpPF+uf//bdT0eAmi0rUOvDWeP0nWy1rcNu07Bf?=
 =?us-ascii?Q?8jRedMcWrNDq4nz6OpD85TOynXn7Bs8FbHmWXnG6FmVO+XJ0KAdhsGUzqm50?=
 =?us-ascii?Q?YmbkdOL/2D/F+iu4OLMmB/x4ZIQFMj2aYB+nv+FAVHB4hoeuguZ8gpXjQiMS?=
 =?us-ascii?Q?awB8Bciq0m4AKKaHmcA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968cb27b-33b9-465d-7a1b-08d9d07e6d5b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:06:07.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpF61JbMuSO+PSqY6+66ghqRNojP3QLAuKBsz/PSpwtjrflrh7QUBkAc3hZ4EHTA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 12:48:42AM -0500, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The member variable xmit_errors can be replaced with
> rxe_counter_inc(rxe, RXE_CNT_SEND_ERR) totally. So
> remove it.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_net.c   | 1 -
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 2 --
>  2 files changed, 3 deletions(-)

Applied to for-next, thanks

Jason
