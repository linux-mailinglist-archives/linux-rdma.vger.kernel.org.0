Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3839AAB8
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jun 2021 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCTON (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Jun 2021 15:14:13 -0400
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:21216
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFCTOM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Jun 2021 15:14:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJCAa5eD7o9MoJLwuVkyTM0MriafeY6nMs0kZ6McDhOuWFeT998nR2mCf1+MPtSvSsOeGy4hxpRzrV7F07EouYjcJcSyBXzWm/HWbhvZ6CJ/wy6FxciQt/lSKswR5fxOW6Y/V4o7N3zdLgMP670Aae6fehTgebKRSymMqxq4cCJNP6jaY04V/5Y6xZvM60TmoK5PSPSgEXSyqDD2A49lIut1Ww4RSrv2JHqUfBP9vvbXXPMOjeTy7JSiX0oEq79Z5MZ94nP/Ktj37ItlblM7S/+l+pOnVqzQBuvYvqKVGoZEGW7tdRevqxsS6cU+AUoJstyzvszVSMLHMzdGjm7Jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S70Nm0Gf1q6uOQg89FQe84CDT++HvYjYcifMjoB0l4s=;
 b=L4cecw/H2AOGxtzr3Cp9QVtPdWJOW/5ybns1SxeywHmijGtTNlp6Gkha7sPvaE59SBVuNIBDuo769Jzu6Cmx50TQBemUbkUneCCCgpyjexsqC1lbOqcIZcSzuQAFwvjtkReVzDTyYNFYMH0SEm4Bi9QUtyJ6ctoe3mIZsu47qyvNNXD9MCOv0g9LOZZTsPwcrwhU9qjlBbMHZ1dnpb5IbivPs44g+8MhlcG0l+D7Y1oAjGKwpP/tKJfnLEB9F5dO7Gh0rinQhGnRlQy0nwp/ilV1zvsTKOIfE1xuxfLDw7pRi53TX+f8LEGSl5a8d74pXGuAJ5lehIPhmHTE+ZoYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S70Nm0Gf1q6uOQg89FQe84CDT++HvYjYcifMjoB0l4s=;
 b=OwGujjeTh3pCfRbkqZukaOfQOUtNJWfjivWjZSg87+jqcpoIdHluc6WR7M7aquptLeaKYL0QTVqooZ1hM9ALBJhG6okRPyjK8UwgvPwk2fAR1FjHa8UmYum1huHpLB9aO/wlV/Fj1jnNq5BcXYFU68mV+UUrueuELhfjIkRp2H95igduIog7CG2UpqxRv28q5NfhOd0cinpku6zKSd3c9qnjYY6lQT2nOiC3QysJAbbZGyGeVK+3bPLHV5eFRri41FqeVxHtdyTlc319BxGP6GRUBD8CLiGiaA5w5PZWroFjzyRCYZl4IRxCbCV3BCXneh9gh1vR9h3uYny9eU/F7w==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5272.namprd12.prod.outlook.com (2603:10b6:208:319::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 19:12:27 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 19:12:27 +0000
Date:   Thu, 3 Jun 2021 16:12:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Yixing Liu <liuyixing1@huawei.com>
Subject: Re: [PATCH v2 for-next 2/2] RDMA/hns: Support direct WQE of userspace
Message-ID: <20210603191226.GD1002214@nvidia.com>
References: <1622705834-19353-1-git-send-email-liweihang@huawei.com>
 <1622705834-19353-3-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622705834-19353-3-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:208:23a::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Thu, 3 Jun 2021 19:12:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1loslW-001KyO-69; Thu, 03 Jun 2021 16:12:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7b572a6-287e-4817-dca6-08d926c386a1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5272:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52728A3BA3AB875FF881E3CBC23C9@BL1PR12MB5272.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ERsBMjiYfJDpqJFxXXbhv/bWkwcKILZJaSaElsF1//BDDi/FbALbM/vpiviSOVxqvU9961B7DWWsU67SzIllMU6zj5f5Y4rojxQmO1FGhXAuixGyn3ZVGR8obqpJkPgIwVtgZSfvMj9yPo8EyPHwtvwyLV2z2jWoRf5F1swvKUVhqH+NTQlxxML6a4KMXbexPm1Z9V6DUe40XwkO1nFZUywFk4cW93f8TLr7uePv+D6UHrk1c4vnEa98lwAf9FWflhTaX/FWvg4MpUuvfM5Q82qZDdxXsGWuQQ6k6K+2bXHcK6dJdu2CfotLXxXCdhJ/vefgM4LSqgg4f7yfOLT3ZVUkd6DxHk8rSHJgSoo+rg+xEwHzy1h1kvI5oiP+R4JYsg2gxwBn+osGVhqtHofBEcjCv5Va7xj06rg7CVBcsG30oQENhOnFJCD/tZPhGJDYdL9f7hda/hoo+FE84sPRtlHSVuOnwHIEiYRsg+t+YMt4kgzRnp6iKU/CGq+UKYZpUV1prg4jOpafJrGBJI6BbVOdVqD0Q1nQRP5hzfuIRGMXGEj0ZxpNv+C1y8OiBaFYMYNF6iBPKRVqKwfgfZovfhuY1nRK3idD4OY4hIF15o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(4326008)(2906002)(36756003)(186003)(86362001)(316002)(478600001)(33656002)(558084003)(8936002)(8676002)(38100700002)(6916009)(9786002)(1076003)(426003)(66476007)(66556008)(2616005)(5660300002)(66946007)(9746002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hfCiDGv+qNtCdtoJC9fFyXiM/wuEVdA94IQHuM/pRlB57suBXhilP6e9GtOT?=
 =?us-ascii?Q?MvVRthh3YKftPKQqqgkkV5Ha/yTKTrK6WrgfuVEXdAkANSfnZxmYlg2WAYMe?=
 =?us-ascii?Q?ZSQXAXdItNX76h+7pRuXY9X8dbC1sSMiAcYFZH4DK2OH/aB451Mbibd5IdCt?=
 =?us-ascii?Q?6nJySFBik7iSb4+WGFcIJ7Qg9fDTceuux+DLL/wBbQDaO/00j54PK/wpIVnU?=
 =?us-ascii?Q?8InnPy0eCL7cJC+UbKElyj2Q3gEScmss6jxPNeQoPQ+yXzlRlKxneseUd25Q?=
 =?us-ascii?Q?S7V047P1NK32BA39+SZuSUAsS9H5O6EpQNM1nbv47jPXRLIskbDhtrJED7lP?=
 =?us-ascii?Q?W7b4ujwrH2+FQ3ZigYy6d/1+hhBqwZZEltFeM42u+wbzdmJsyEjPdRWNlMEW?=
 =?us-ascii?Q?SE+yRLf63/Y5+91ybUddy/LNdW3Gf3n916qgkPFamETfPDdspRAiC9aFkkeb?=
 =?us-ascii?Q?hLZZWAStwslbZLgfNLKAHxRc5K6hzh4mBwUJMEgWXkkS6AyIt8SS192A+OXv?=
 =?us-ascii?Q?jjBXtoFccIdZ87L+upVqvpf/JT071masE+Khol4Xb83g67kqgUhulcMVlOBV?=
 =?us-ascii?Q?L31kPYaf7yHsRGIzdnpFJ2ebIaglPfOvuJugQ2dcoML4DF3DX4zhYPLpEPNd?=
 =?us-ascii?Q?3ZBZlXpVzWzOraCQGcABrFmwm19qRdOmdIO20ZYP1L2usssYZeGt5En9AsuP?=
 =?us-ascii?Q?8WvP6zDNHKn12JDSTWPGKBj7JeuS3K4A7A8R2hz3zni0hFnBelF5NctSHLqV?=
 =?us-ascii?Q?wFAevS9hBjpWVirZFzlba56UXfXNSLUeVv374fyDqR+B5gb2JWStJKjZsV+D?=
 =?us-ascii?Q?AnbSFVRlFWGOtkvqc78iG86ZG4CgFkdxp2txfIvFxgLvNQhXGPDzlcpvLfIe?=
 =?us-ascii?Q?geSUt3e+wYaU7ttTKYoXsoled30GYcE/sbS9qfVOVqMPJrj0ABqlJTarUgdZ?=
 =?us-ascii?Q?bhLF1ufToS9birVdlcolQDJGI3jyXFallXuaofuGl2Icet8zWUbHjKJ2Dh/y?=
 =?us-ascii?Q?HBmmWF+XPvCEJGpV2J9mrKFbOiIgDAaPIqF89H5GDHVUzhxOF5CE5WNmxDTW?=
 =?us-ascii?Q?oOcfMaFcsn4ML+G5px0+PUsODpTc9NZ04WGCqF+08z0TgtKsjf96Nq3J69Eh?=
 =?us-ascii?Q?Fgpj7ZIUBuDKRz5gSw8Lcp8Ocok6WGAbGiWLOKsqQa32BFK58lldEZb97fem?=
 =?us-ascii?Q?X+Mung0VgcAHA4z91caf2xdxJDNTZX3qUjkGKiR5uR+SeyMtCNQuYZw/i7Kn?=
 =?us-ascii?Q?spTioelhSVYLYbDgoOy5ODR+xIUc2WN3Qetn57Yt40+pkUn/xvVdc/WbWVM8?=
 =?us-ascii?Q?p50WPnTiqwfyfABPmc1DsQrR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b572a6-287e-4817-dca6-08d926c386a1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 19:12:26.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyJvdV00veOk0UhBdPyaTq5crOAJSPkR4VIggMFujU/zSRZVZ6oJagxUkmVyCPOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5272
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 03, 2021 at 03:37:14PM +0800, Weihang Li wrote:

> +	hr_qp->has_mmaped = true;
> +	pfn = context->uar.dwqe_page + pgoff;
> +	prot = pgprot_device(vma->vm_page_prot);

Why doesn't this use pgprot_writecombine() ? Does the devce really need
nGnRE not GRE?

Jason
