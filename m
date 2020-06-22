Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31F203E89
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 19:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgFVR4Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 13:56:24 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12952 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730194AbgFVR4X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 13:56:23 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0f06c0000>; Mon, 22 Jun 2020 10:54:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 10:56:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Jun 2020 10:56:23 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 17:56:14 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.58) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 17:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0kLZiDw5MlTIgcQ0O7uEN2pAfwXUFYxVrgD7/qfHHkDUP9GqJmnJcDGzVOIF7egB1s7b63/2m2f413o4WeGoWiG+zomXgY3gf/vZ2hmJ3u9ndgmmlVYuivRfmD4f0L/guO31Vx9o5v8o5FBdmWQgSJ+8mWjqJfB6De1JBgqnViB850oFNv7Ogj6uL9hmzaYhnY1KJ+KG/2on5grvAQlFFO9J4QMzFPxlhgP5ZCX0Vh8gGhty/scO8ox0wW0K/kiuY1NJJINqdD7Z2TF0V7x6+tsdRZDt/fFxKDd4OB6L6RkfwRHfd+t4SWGQ+SyCeu7PYkifwRY5aF94v9BADS+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXHQQaTRWip/y4yyxYiqzZMcD2o7Cu0Hc/pAbmT/pio=;
 b=RyHRqccq5G10jj2No4teqi4jsBJr/g5DrpB/FughkmUynuvVPVkGaVLvAJcNqwkFtCvgnY9WRzlw87YmLoKWFPemLzHCTSPOpq4xAc+5b2vrxZRKjLSWRK/zHz0z6LCDpt85YmH3mszzdW3zFO2tzjje2ejAmupKrH//4Q4zkR+9v2vdez4eRsWy1AkTkvXzm/YGwrIuHC2h7JaoiQuE65vDOWLgw3Ry2chexacdhoIzlWIlsUICYET9BPbWba/t5j6sHBfqhBE01x6Sxoaas+AeAnKZymVKZ5cMhH7Hnm1RQa7UsnGdFxgoNDsyimWSXLllyggx/YTY8CpNQFRbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 17:56:13 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:56:13 +0000
Date:   Mon, 22 Jun 2020 14:56:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Zhu Yanjun <yanjunz@mellanox.com>,
        "Doug Ledford" <dledford@redhat.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Remove unused rxe_mem_map_pages
Message-ID: <20200622175607.GC2892511@mellanox.com>
References: <20200622100731.27359-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200622100731.27359-1-kamalheib1@gmail.com>
X-NVConfidentiality: public
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR02CA0135.namprd02.prod.outlook.com (2603:10b6:208:35::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:56:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnQfv-00C8Uq-Kr; Mon, 22 Jun 2020 14:56:07 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ed6d30a-ce8e-434b-273a-08d816d58d8d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3639:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3639ED334D731F5839221223C2970@BYAPR12MB3639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InAK9K43NMejMSDLyLkstJZLmKst2HdJtHirMAuOTelt4Sn08j9Ad9GNL8oOfthvghBRCQefrwz5fOqIBqUXgAj7bAeIZlxfrNmPptmxQJZ5XZKi7Ptsmkw1HDsDX3oMfVGIA4Pb9YRRJBQaB+K5WvqoW9Yf9BGRB7HCs/Qqi9KLIl5phef4ovx8t/bEB38hOPh9i2VenEkYqOIRb/6x8ykI/DSKYXgONZvs+CMfAI9HRLriNTGUQrmPycLy5iy1uEb7IFgCWYvPNf2EuM+Ddmz9XPqd1SqDPWTxb5jml9PmkB2RxMyEV6Y20lIZ2bkxQg9hAjzDDHM9VCt0yPgPPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(33656002)(478600001)(2906002)(66476007)(66946007)(66556008)(4744005)(9746002)(5660300002)(9686003)(9786002)(4326008)(1076003)(186003)(6916009)(36756003)(86362001)(54906003)(26005)(426003)(8676002)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Fym3fQ4Ur7+2pIXEv9651zG/5Qnvnh7kcQvL5Al1/97K8pKm0D6zVnCV0s+16wrFkkrqmsdE3U/KBtdspHOEpVIbg1WEIbhh8Rn3eI7wVaB8ELdrSMp1kIUmMXO6a4oKmi6/quFWwFNRwGQDnYWcq+wXgbWhXOs2IbM2txjpMw/jM4ni1rJkknBOMYF+B9xHp1PgHkDr3ISV2t1Je0/vExb+RYEqyJZA5Jcl6kmlTulZVZsekRkg/h0tLCMglE8f+Z3n5FtS0l6rz2NEZIokrKaddQL+8oYtFnD3gBINKcTfoYUc3OeBYtLD1GhoTNOXVoUd7iTP17mFYCeZ1d/FfXgVmGxfHb7z9ruUBM1bvfLg7GDTYfzGjqnV54y9sWuXToX2w9k4Ds2+aNel3F7owuSPLkCLc0s9GFMObyyFmqZr9tPEJjHVIkd46cxRpHCEr3KvwfoBO9+8OUqnvQeIbNdWlrKnhMVgiDJF6nk5LIQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed6d30a-ce8e-434b-273a-08d816d58d8d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:56:13.3807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PATg2YgMx7xHqk7sZTtEFKC69QsbCvgkMBhTntAiyFt8aLl7Gg5A5mNhNqT8zABO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592848492; bh=GXHQQaTRWip/y4yyxYiqzZMcD2o7Cu0Hc/pAbmT/pio=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=a59Aun6zzt4UbnH4H2kMT5jcWbo7n5KIJZptFiGFRxZyF6myRJs0fg/tacaXzC2cs
         iP/mVBD2JEYNCVXLwWKkL6Mcfo0sxsfgpoX8LgVCaaBdo3DzdPJQ2Cl3TiwrUCLL7W
         BXcbP8PdZnziBHbsMYOYjWVUXnzpr9gy3RmXxxS2EVxr978dfXnGg03pcQSk3j8UO/
         9FPtQoMR/57b98b8Wg3F1nxQ3kGLayIeAlZEkGEahEHdxHPhEWNIML34zdOgebaxKL
         6QsQvRc1QfJQTYFFuKczfXmuTI8BnRzkxElQm7w5bBcsaDXga3CzKu/eWK44NO5oTb
         ls1tSDEkk3ssQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 01:07:31PM +0300, Kamal Heib wrote:
> This function is not in use - delete it.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
> v2: Add fixes tag.
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h |  3 --
>  drivers/infiniband/sw/rxe/rxe_mr.c  | 44 -----------------------------
>  2 files changed, 47 deletions(-)

Applied to for-next, thanks

Jason
