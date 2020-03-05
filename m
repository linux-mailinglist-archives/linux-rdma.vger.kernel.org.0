Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 780E317A8B3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEPS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:18:59 -0500
Received: from mail-eopbgr70040.outbound.protection.outlook.com ([40.107.7.40]:39937
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbgCEPS7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:18:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQQ37HqbT28L0PYer4lpSMl2jzrD5ZkiKz2ndcuAEv4X4XuPDUW7TcyPpDNgLd3guop4+epAHRAIMghG1A8AzlBg3gvYd1iPyt4DoNFz4OzxkOAcIfTR6AU6OWytg9ENGRvf7HNrHND7XohfbEBSD6LjgNkyZvUmTlNCA6Cg3CzN2DclLGc5Slv1WzLJPaIl6yGyXPnHxhtH77ZhO01j+iZbLPaFtswX5nrs+xyv/Sig6Z0EtXSOzfNoVo2BSbuTHRRAshkNCqP0zB1fMMxuT8kHvVKTfspYXUJKLhBHZMwnXzGQIuou0yfXIhGacGOdhLPMAUXwrRis8+A1dzsCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKHpsy9+1hFmvHeu7YGCEpfivXChMMkF9yZWZ86CtNQ=;
 b=XPluE5GiAoD6LzQfyk+quXuVnueuqjJ2tzY8Zopc0PFtcTG3iFYgLaOW8/VhZwuCvWRnY2oZ1K38drnKqJ/EgH3TftWaEAnu0NFjm7GlrmpCdwE6QFBmeOGqQUvCDMWB8Z5RTRMJT2hWN9BRDZtcu6FxROfqQOibgvenJTQzKzGFk6vCuNvuPZDxoqRrtThdwM+KiDRQJ+hOxGL8jGI8eYP0gaPpvEt5XjNjYST4FtSm+UF/SRrdU+/qqr2GC8Hcuf5+nLBffGlBV9PxW1LJyYtVA2eGY+7lQiluwgmelMDAAVmYMSto/29SCh38Gkut3c0mTyb9/EDyRYhox6z0Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKHpsy9+1hFmvHeu7YGCEpfivXChMMkF9yZWZ86CtNQ=;
 b=Mhnbn4fgZpXGgi+uw/drsRuoohtgNzXS+VxZhzUz3kn5oImG4FaPn+GIoopFhLujg9VynP1NndBqaW7+BEaxu/6hsMP5Ou6Bq/i73B920DjReIdbjL//zYsaRRGCZvWe8VIgQ4uJ0l1IGG/b6t2tOMMd3uCUy/NsIVGHYXmH3NQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4543.eurprd05.prod.outlook.com (20.176.8.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.19; Thu, 5 Mar 2020 15:18:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2772.019; Thu, 5 Mar 2020
 15:18:54 +0000
Date:   Thu, 5 Mar 2020 11:18:50 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 2/9] RDMA: Promote field_avail() macro to be
 general code
Message-ID: <20200305151850.GZ26318@mellanox.com>
References: <20200305150105.207959-1-leon@kernel.org>
 <20200305150105.207959-3-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305150105.207959-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:208:160::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR13CA0028.namprd13.prod.outlook.com (2603:10b6:208:160::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.9 via Frontend Transport; Thu, 5 Mar 2020 15:18:54 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j9sGw-0006PB-Eh; Thu, 05 Mar 2020 11:18:50 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33d63aa2-5753-4e74-920b-08d7c1188474
X-MS-TrafficTypeDiagnostic: VI1PR05MB4543:|VI1PR05MB4543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB454322F9B4D27AD7487E1A2DCFE20@VI1PR05MB4543.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03333C607F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(66946007)(26005)(66476007)(2616005)(66556008)(33656002)(8936002)(81166006)(8676002)(52116002)(186003)(478600001)(5660300002)(4326008)(81156014)(107886003)(1076003)(2906002)(86362001)(54906003)(6916009)(316002)(36756003)(4744005)(9786002)(9746002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4543;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QiTbErdPzS0zQfC21oeeHWxruoRVTbc9HJvuGvkLGQuGo+6bgxdUaDF3t8c9XlnZ1qybqRW60QLZR5gCszT/5eEGXcoZR2xikec03SWBSe2OR0pO0sJbyUDPlF+21VbtP0imAVUyuooEhyPBRxJvXHHni4rm1jaw7L4sYHsuOSZSQjUeKyIZI6UeyseDLt/z7X+Cms8d2DCO77fnAlCWO+b58LFWQnFuZvTaH//cHPRZepL0cGhuy9R186ke9jcpfC2cDGNddjdoij1dSX30PgX57C4ZzNz+rFwNZL3iNbIMb87Hf3rio1nBQUZ8ogDK5sJ9VeWuCPSKs5HpS56E/LeYSw6TURP28vrQkxT8/WbDUzTfKUWS5ddEmxHTFLg3vQ9DbsGfgjVNmYkMOJERBLxNAox2HxxA4UflNqMomvuvlnLrcxrHK1n1RZFnGGRrVrkXQ62ZMS2V6/t3/uuPykBCe9iocqmfBEto7g1apUTTNSTX5AAi2gX2grsh++Y
X-MS-Exchange-AntiSpam-MessageData: G4QDOsK12Ov+0dxXeKiVJyLrqdq6HnChBcl2QhQGrKHjyuBukkbo54OjnQrOpwZXg1fEL8kELeYnrdrk3x59H4H1D2/doKWTMNyIB6ytZ8kDXo7WHjtoAUcusSdiifLciWGMT32FvwidSOkGtTVfLA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d63aa2-5753-4e74-920b-08d7c1188474
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2020 15:18:54.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUvTADhl8Lps8DLli97JbqcLg9Tedcb6s2UX8unwIUjc+7HtCAb2H920pOpMLLU1elOQV9g+iC+1oyEPCGQEig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4543
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 05, 2020 at 05:00:58PM +0200, Leon Romanovsky wrote:
> 
> +/**
> + * FIELD_SIZEOF - get the size of a struct's field
> + * @t: the target struct
> + * @f: the target struct's field
> + * Return: the size of @f in the struct definition without having a
> + * declared instance of @t.
> + */
> +#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))

This is already sizeof_field

> +/**
> + * field_avail - check if specific field exists in provided data
> + * @x: the source data, usually struct received from the user
> + * @fld: field name
> + * @sz: size of the data
> + */
> +#define field_avail(x, fld, sz) \
> +	(offsetof(typeof(x), fld) + FIELD_SIZEOF(typeof(x), fld) <= (sz))

This is just offsetofend, I'm not sure there is such a reason to even
have this field_avail macro really..

Jason
