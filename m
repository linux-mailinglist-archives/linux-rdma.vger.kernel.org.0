Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABB466C424
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 16:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjAPPlW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjAPPlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 10:41:21 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530B27AAE
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 07:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USk/e/Yro1dGGkiFQHEDeNv3HkjFaC4y141zid4y89cdOVWLS5Sg6bGCodSpngFP3spN0oIGIPvTQCtpil6OPkgPuHoK/Qc8/aFDoP1LgVkZbOAp4IDw9KpXwe943jQ36/LCJC+wNDcm8C5YtlTJAZYHpKxt7GkS7NQ9P6I+zFAn7unLmNRm2CvJ2SMUUnGXLnL0kNobvv8yRNG0b8tE2MO3xwC8nmfJr7wuW8E/AcIr3gS0/cfnqjez6jdETc6f3DiVn3eMuw76zIvRwM6wgGpfIMYqX9FTyqKNHZ+VMUB27W8jFU/Y55qghpCNozM2D0CAMJZVur6LJePWhmKCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUdfV6nWKpNwI73xVDUw0wftFZCfQPSun4N9mpz6r7A=;
 b=HKmRnKRSZ42QobKzIKzVk+1cgD6xC/83Y9tVKL0Y4lHH5ZQEjU5v1+q+L4+aKLiZG6TuCWIcgsB+EpsvzT5dnnmqC9/HvE2quYMlEf5J6MciJagLtvpqe51jsZGWRhXDhUhWdXiWvzhqAMFyGc70+s8/OI9BisGyd3FmbJq5KK1LI+4cutCwC6qyoAj8ZWnx9UHQpIZeSEjYRMFRNmhcw1UTm3vsYr9cRU0zayirhGXmZiltQtx3AWwvtrWU6cj+ZVe/8C76fRdXorlzWQMRPmC+tRQr6xFdgRL0ga9watp+00YaHYdBa225Huzp4awYMX2kV5CM5F5uL5gAn/Sgkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUdfV6nWKpNwI73xVDUw0wftFZCfQPSun4N9mpz6r7A=;
 b=dbfTd/AD94WvPzCfuqn95TozQNg7CG34qtGpTRApKSy1qwzlhRAjmdilBuBzV2Od0fUUlRMCHFt+pDlLfdbBX8GSG/8KH4MPiSfHpJyzMwpQp5zbk3jpxzKpURJ2Ez51Rf2c3CTHFadsSw+aqGzToak/7tZItpCbI0HNW4nthLiRgLj7rjhjG0qCSv2Fsr/8UQYdjNfmms+BgRw3vXecFTMjj0A9GsUhfNqiiCwNe8DZKWNORlzG9qbJps440YaGocj+z7Msav0kUJNPVYSmS+UtYjsFJIluxIyJLcagRGZz3wWYre66EYKbe8QIwd7O5n9X/EyS7NkFbRA4t9e/4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5451.namprd12.prod.outlook.com (2603:10b6:510:ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 15:41:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 15:41:17 +0000
Date:   Mon, 16 Jan 2023 11:41:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc 6/6] IB/hfi1: Remove user expected buffer
 invalidate race
Message-ID: <Y8VwHYPYlV459T1j@nvidia.com>
References: <167328512911.1472310.3529280633243532911.stgit@awfm-02.cornelisnetworks.com>
 <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167328549178.1472310.9867497376936699488.stgit@awfm-02.cornelisnetworks.com>
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5451:EE_
X-MS-Office365-Filtering-Correlation-Id: d93560e0-85cf-46ec-08cf-08daf7d81bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zr+X5+5YpQu25vT6jYksBLgV+8iud3zXsYnmL7+h7kzSAqQEuq/Ly300XKtiWP1o/DSuq1yVvRnXNuMN30zon+kvUjBaNCcBI01DxlZAFQe9nSOY7LtwHuI9lNoGA1IVPuI7NjBm9y6t3wbI5kpbXnCGLFFNBMA+HdvFwk2QuE3SxbRhdlVtpsoFg+0fW+Lxq1uMdxX3TCzvySmyL90/wQbO1h4jk3/2Vk8nIxJ7oc5LqhbU6N9dvf6Df7SSmVZlE9BZowYDdKK17tM+XG1fhqxOOiQ6sDgW9n63hwcf0YYx3L7zPSuNn/smIKrJo4NhLWlkYwxffkfz82tV4UYHkF7CjQDAAXBoqjdXd3uTIAcu2r4M7tF3rK0P/qRJ+ZBy1S203HLi70l5HXELFqjaUrWbFef1Jv5PA2/sqQcJWyZPzPTUr0S6Uvk0Vm99lAmZcuSue+t67T/8p06Bf4nMmLSFoMebPCM0FnneEAyxIpEKtbRkPBc7N+6Y5Pykh7KadtQEwV+7aDOdT29ozbxVW8VKuJOCZXWxR08iX51uH9UjjRpqCAdqL7U90drEA2amdb5oRvunfRC4wRJBvufUc5xLXoUXfyhlbI1diNzmo4ugzKRCz+i9YA82uqbQBOiBGM6JECoMZQssq3CYfL2NVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199015)(38100700002)(86362001)(2906002)(5660300002)(4744005)(8676002)(4326008)(66946007)(66556008)(66476007)(8936002)(6916009)(41300700001)(6512007)(6506007)(26005)(186003)(2616005)(478600001)(316002)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MczErvI6U0moFJwz7aN+ezV+EtE8KZvxOgUDhqqfguQz/z/sT0V7jgq1ayUk?=
 =?us-ascii?Q?jSG2y2FXpJW9e1D3ottkbmYwhZNUWSDGmaHaRuCFMwIZQZl1N3rrIe0oEOVj?=
 =?us-ascii?Q?RTaNI9Sa7tCb8iq8L+5pqweCjZ9uBdFpq+dGUYBvH9xTFjwuBob42/Iux2zo?=
 =?us-ascii?Q?PKcYx1PH8Nv77ro0l5WJ8bB2BlwzUJF/FXDFvHrmV+rklfjD7ssDYKH2Q7t5?=
 =?us-ascii?Q?MtsBZfxOK/6BAYHBRJXOmH0zFN/qzx55y6UGlnn1UdLjfiAzE4ZlJ0RkFiTd?=
 =?us-ascii?Q?/wnZtKf96psAN9TxnP7itxGlgD1ucrKEfbALoCuIm7Xc2vnM0olN2EHJ+22j?=
 =?us-ascii?Q?pcE+EJ/rfbvnsMJiF3GHfd5Odg4vaKJa6P8Ie/jOo3alAF/Y6bne4eEbxI/k?=
 =?us-ascii?Q?EothdUAukdMzra56eNpXAyuYb5xTqh/f9Gzzzqt46+mHiHaf4d8vwriKU0MR?=
 =?us-ascii?Q?zasySS2BJ8my/vqI9qNM36+xbgbyN/3BK933cOH96FDH3Z6DJ52s9+g85T6U?=
 =?us-ascii?Q?y6F5Fl/uCnCNNxkPnLH0FkCWjPgqzIjjRbipqJHCoiU2OFDuOtxD2CzkmBuc?=
 =?us-ascii?Q?NyYIQf5adeHYcjtmRJlCa8A9MW/bLrJGCesTzTGNC5nanKTQJaQ7ccCEftd7?=
 =?us-ascii?Q?dVrM9rEuuUksO1GMNiNo2w6nrJiq735biFtyHTn/YcxI7257FGaMC2wSSQAH?=
 =?us-ascii?Q?vRqCn9djV5YGlDNIdiavUjwFwmm7iiNVmdFOC8cWo7IjAWeK9lunM/LjmI6u?=
 =?us-ascii?Q?GKSCWf0V4BmIdPng7VyDQ/DTQznD/MNrMBtKLn7oYw13HxdqpIIYtroqmpKs?=
 =?us-ascii?Q?XuPLwkNn3qNhFEz7PPZJhACwmM/Nj8BC9Q+hjyH4ygUVjR20CXrX2M89f8du?=
 =?us-ascii?Q?PIdRvNjDTdO88HN77NTo0m277z9+UvLnVn+9OY3lRTzw90TTKO5qZgUoOEOC?=
 =?us-ascii?Q?AM9v3jtbzRoA3SlvqOgEjciQ68CS1DheVZT8MH5GkKkkN/BL9PfWR8J7hfaA?=
 =?us-ascii?Q?Z7Z4LqEPUo2QJYTzFUK/guPT4Iv60yknmEM2J9QP8VviQVu6iRT/T+w9VFYV?=
 =?us-ascii?Q?YElG9XWJas+mYtwZcHhP25l4fsa1dYWpUJckqKhU06wCaFrzhsE31S+88P1T?=
 =?us-ascii?Q?25qAqCnlOw0qwxkPtI58/xKSNR+WBPrqeKgPJuJ2EJo2wnfRE2TsxSJIjOoS?=
 =?us-ascii?Q?MVxDLK6WuHwF7YdfLhm34NjPciRpWaRNAVet7MkgAnOzeHqSG9UbSTt+CXjW?=
 =?us-ascii?Q?qVi3JcxpgHSTsj2v0TYgytB/XNcb0EMTXkUTF4aP+7ZbEYRjhpDIGC20yjy3?=
 =?us-ascii?Q?DJIZiVpsXdrhUFNqzL9vqqNgCpxQ7yc27zxAjbjlKxbBBcz/Rwmh1QWYpfjs?=
 =?us-ascii?Q?rW+k4l6DlTC+1lD1IikL3h51F+XdZ8aH1AWbF1o38m0jPe/G3YKszrQHRQDG?=
 =?us-ascii?Q?xFOJJLcFrKGh09kgGBsuTh4YnQKMv6bfV7/3oBPp95F4Ez4b9DP11HIlzNH3?=
 =?us-ascii?Q?V923x7ieMf7hWctLqyAycUxbTAouRT+njLkpukj7emPznwHBWTZmRuH8sJdm?=
 =?us-ascii?Q?TvMTdnsmojaVmTdXIsMBhqbPscLqj6jLjweFCusg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93560e0-85cf-46ec-08cf-08daf7d81bbe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 15:41:17.8032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WK15Wk+RsAqqXGqKEbtMsYs1/ho1DrEtYZ25ihL/sToke6OHmH5HpAlHffqrOBu1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 09, 2023 at 12:31:31PM -0500, Dennis Dalessandro wrote:

> +	if (fd->use_mn) {
> +		ret = mmu_interval_notifier_insert(
> +			&tidbuf->notifier, current->mm,
> +			tidbuf->vaddr, tidbuf->npages * PAGE_SIZE,
> +			&tid_cover_ops);

This is still not the right way to use these notifiers, you should be
removing the calls to mmu_notifier_register()

Jason
