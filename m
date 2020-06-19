Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD002008BD
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 14:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgFSMdm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 08:33:42 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:56646
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730998AbgFSMdk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 08:33:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGj8lHRKuv2aEd8uBrHHcJIVw/W/1XmwkFHd//tgxg0Ce3O0FVA3lxRbnNIRlcIczaKgAJ3Y2V1KxY6Jaq3zJQLexetZMS5CAH2sWwfWJ8SXZt0Nqy3Jm47NiyeAwnwnqPoWGOv7tKp/t0xyLR0ipfx/YOSJcPKA3O3e+Kl6xUAJKWx9Mve4cR4//R4iE/hkNNffMN4KI5kH10BC2/UnXouO2wd889yb5TObzARMH/NO4ebmUtm6P75DAhqlnlSfMRHt/a7iKRvg/bs8gHl5MsGg4YEiakZMMUKAJctdiDu4cQ2KpZSy3SQ0soft0BtwrJC1Yl8Sy1h5NFW4iKO7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvWXuyL8vcJUAr3w+cnY1fLCldiCKybA0rjZ3F7Y7EQ=;
 b=htcdaBpzTUsjX8O3yNc6V2vu1Kv1WhEL59jUSEKFpcgPtkwh10qRp04MXGVGirLc/ZI7f3hKKsWMv5i8BoxEPwMfiXKllLcTHLk/PFjh+LrvrpYVmxfBUfEpqXLnd5S4bXlVZzjX/Os/BdyTu/WZGXWIN5S+zINmkZWez7T6YRmWroOx041sahw8ZsvXVtDXw9uQsfxylRSg5FkYMwGWf5Lz+FQ/16HcMaRlF2vowQMPNtyjKV9n5WRk77ZNs8azUCOaPj8Y/NTzl6EX66kcN56CqGKHUHti7vQBkIdzbgvidyC7vR9r7ZqogXfU4CmGjANmuJqHQkeSqS11wqOdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvWXuyL8vcJUAr3w+cnY1fLCldiCKybA0rjZ3F7Y7EQ=;
 b=MamVRzhUHrno/B7UCToXC6P/l86TsrnEcUJZxolHhLL5bq9iTHMqpXBvEvVdt7LnPnqYpE3gyjlSNu4vazPF+yUxsiknCdM+Lndl6jrelULTl4/RQikKf6bT3kuNeSSnmdyZT1f5kjCDfJ6oHKpCIJeXZUIGBFpghT0dN3zc3QI=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4110.eurprd05.prod.outlook.com (2603:10a6:803:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 12:33:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 12:33:37 +0000
Date:   Fri, 19 Jun 2020 09:33:32 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: [PATCH rdma-core 04/13] verbs: Handle async FD on an imported
 device
Message-ID: <20200619123332.GU65026@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
 <1592379956-7043-5-git-send-email-yishaih@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592379956-7043-5-git-send-email-yishaih@mellanox.com>
X-ClientProxiedBy: MN2PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:208:e8::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0003.namprd20.prod.outlook.com (2603:10b6:208:e8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 12:33:36 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jmGD6-00Akr1-BH; Fri, 19 Jun 2020 09:33:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a5b9470-ab11-4356-148e-08d8144cfd01
X-MS-TrafficTypeDiagnostic: VI1PR05MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB41109BDE5936E1B1DCAC3DCBCF980@VI1PR05MB4110.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUgl0f8T68dB3bmlEP45/wOWq+jMCU+sDKnf0Abx2QKoTcLIFM8m7lhYrJS1ubHNlsc1Thb6C+Fy9YMvEaiWICKGVU3bmrUQv2VE/wDb9iBC67eOBIg5E/j7EqWD13mQ/tLB0ruggCkXblxsCrfJiEA7oXxMyMS8CB9T8p4y60Kgjp8MCNukT1pgE6+yYGIolcOu/A76RPvcjLFWgdQ/0KmHZqt6o98Oa3LiIX84FrPGvM6ezUeVA6Om/9jvgKWeEPNGrGpBYZuKz/LGjzDOixJ0d5L94MuLil7bBNcjzZkWeq47G9X8ia37tuOB7H0D1zot0WteITVrjb2KkHmaXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(2616005)(1076003)(6862004)(426003)(478600001)(9746002)(9786002)(8676002)(83380400001)(36756003)(86362001)(6636002)(8936002)(26005)(2906002)(4744005)(4326008)(316002)(107886003)(37006003)(5660300002)(66946007)(186003)(66476007)(66556008)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wHwtCXfL4ucWrr31j7UxwSWQfUm+tWEobalXakqd0NG1ASIR1nDQfszxd3mjaN1UELFO/p1WNY6hZIdIvR01B+VGtGtNwJtqCZG1uELqxcIwWaWhviwaW7CEDw/IRInyF3VNLMCaxWgRtXSGxRASJnwPPVv5r4t2m8EPWIVWGowyV0nTad8Dwr83pMFseOhbECxJYzbSQ2jrKmEakDX9Nqu0PsU6yIb9lVpveETwJl2/8ji33scH4AEhQBT0kAebXMeFaP1sLutbX2qVHpvSs6EavFwE/smmwAjVY5/LD4Vy4g/60spetmzb/ibDb5FPVM1blVOVfwYNhN1UoyKdMla3WYnAsDhIy+X1QDG5OPIR8pCT7L7NTCpyR/O/fb65kwd4nt5a6RIHoDwDNTZgbAHwN+v7QMOc8L6iVBFaszvOpPMBOnoOREri4MNGEVZCGymKs4DPE2jgAj3FyM9BdQ9dODVfElFWLR5PkK05GL8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5b9470-ab11-4356-148e-08d8144cfd01
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 12:33:37.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiWrxa2J9C4kmOSQcCAHYJxGw4W53MehsiMa9KTJzbbBpoa22zXjo/8FONyWVN/p2EdiSXP1aKoGXuHVGHRmGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4110
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 17, 2020 at 10:45:47AM +0300, Yishai Hadas wrote:
> @@ -418,7 +427,13 @@ static struct ibv_context *verbs_import_device(int cmd_fd)
>  
>  	set_lib_ops(context_ex);
>  
> +	context_ex->priv->imported = true;
>  	ctx = &context_ex->context;
> +	ret = ibv_cmd_alloc_async_fd(ctx);
> +	if (ret) {
> +		ibv_close_device(ctx);
> +		ctx = NULL;
> +	}
>  out:
>  	ibv_free_device_list(dev_list);
>  	return ctx;

This hunk should probably be in the prior patch, or ideally the order
of these two patches should be swapped.

Jason
