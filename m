Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953A83A2BC1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFJMkz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:40:55 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:17071
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230130AbhFJMkz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Jun 2021 08:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJfN3HN1UUGo0V9oK4QRw0RYEyI9wqilvb+xceW6BYJIFh7vT8zUJCO5+3INcQd0E8MFWt785Xav6omsL9GK85GVezV5tRs5n2TUTGmHSpjFcYNQzMzVX25QM47GG9PbJjWJAKkXptBrAfbbujL4wjyoZbb0G1/WZU20m6jMtrdM111WpEwDTDXu9mV8wo+nsWUGOcYHM/WD5Fu+TPXXXQF3vUJ+2zzVnhypN/v5gtnSfVZMx96ykQcP5OYb1+yfDEF4rXf1itli3IwaJNzQaoJ6XC/2WO0sbrRxuErDdqk+CgWDfuqsx/AVRgMiyDtTZLph1Sj3RTYCP2ZLTj+9xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kWXBYZcEGMOZi/tWUYMzbBEX2GD5ZasoJhk4VaExMg=;
 b=JxcKKDjnb6qmhgMegwavYknA5ca8EyG3E1gfT+em0HAXooCG0h74/2w4U+BVZAGhSdBptiMtDe5y9/5Gn4UPwG6IesyxYu/NA0QCjn9CPAdKnbgD7eSpUuBhoC+PtBYzStUmY+nuOQK6OUvdsFtIYkk2UEPXzUiRqKi6K9fxEXdLn32Po+fDlmGSSx2o968tj3N8dqeuxSlySBjo6gN6ZYRaW9Xkqo9NYO0p/LBiW7+C79MFy9GupBYiW7W8/APmJr/klNjb8xv9iExaWGUdBiQ7rnThBNqGDZxYUnRUnQ8+yt/8hla3Nr8UU3+bMPQK/QfeCK4yyyNL/Jri99ltyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kWXBYZcEGMOZi/tWUYMzbBEX2GD5ZasoJhk4VaExMg=;
 b=RFuMqnMN+uZlisnZ29Iv7MlQzT859EDuE9AufHqr5cqQqg6D+uyAThOSLGPSJ2izMgwUCtVTERSz2sUiuWILAo0IzaAVyhLjtcG1zWIjMK0y2Ov68l15PNsShFMFVlV4ncQbuRsczuHdn2j96nu2GxMW3uDuZ5TFABEYMCB3ziyjx1H8HgriNuUkNbdXODlr9iZZGO7zItzew66nAITQQprd56pgxRE/56vLMH8FtewGglvc4OUkCheIhb1hhtdbIC8nJOqkuHYVkePae+XzID/TYFyCg6wHJT7NwV6gzHGy9NBTwjAH0ddnA319gxv5N4+PWehENCDxQHrpZQ7E9w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 12:38:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 12:38:57 +0000
Date:   Thu, 10 Jun 2021 09:38:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Alaa Hleihel <alaa@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc 0/3] Collection of small fixes to mlx5_ib
Message-ID: <20210610123856.GA1261016@nvidia.com>
References: <cover.1623309971.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623309971.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0272.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0272.namprd13.prod.outlook.com (2603:10b6:208:2bc::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Thu, 10 Jun 2021 12:38:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrJxY-005I3W-UK; Thu, 10 Jun 2021 09:38:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82880acf-c232-4814-c414-08d92c0cb74f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB517344A16B0835014409AD45C2359@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SB9ZlBPmLtBNXh9XqN9sLt3z9Vji3fqEU4slkdf0+MVrDQSsS5YNtqUsXQKZPhQb6zazlw8kj1ZVAbyWLGAR6aD1tSSFH9uYWCEzUmp2t5jg5tAbKPAp+dXXglAbGt+VOLYZ8XIFtNDjVxYJIHsWsBqwB9eFxV4zrqrlZ/8i6j8Lrb/NRyIPVENZNLR1cXYRJ03EqxYaL25K8HhfBSCs4UpE7EaGhtksAhr9P9EOidF0B3LxBCIeAQuEeywPCP79xtTgZ54mQGLcBoHHqRnxfmEqr3T8R2UFnYi8UonSFdROLFgbiMR+ic8AEOo7TXYAYwXPRoRIFtp5TKEuOTlMKTu9D+WuBHQLWtuYxxKNRCgpwlqtZtY4JJlqI3KeLvrmyGxCnp4iO9CTnS74BkSSzxTX4iZs/Lt/HU5PDl9STScYjokWsfl9Mb9i+pXzJt7X100fod9FVPRVdnMuxiTTa/g1YBAWtGKGgeAb4z98VN1ixuP+gjF+/rF2DzIsz1jpAH86vOVmHqaoTZxL+Uaf4MS4Bfo9MxJ/2rGpT9sQfGKhzVAOo4t0Ul3d1RSWm+O/mDlBd28AR0u+naXAULqpbE50Jb/FAczcJFLvR86MNeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(66476007)(4744005)(66946007)(6916009)(66556008)(5660300002)(186003)(26005)(54906003)(316002)(33656002)(1076003)(36756003)(8936002)(4326008)(86362001)(9786002)(478600001)(2906002)(8676002)(107886003)(9746002)(38100700002)(83380400001)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mk+GEsyThlPVT+EqLDNgmIUuPdd4VueMXCAVhnpM/XZK1d3U9CBRE0yt79Ag?=
 =?us-ascii?Q?tHGo1f5F4D1WdV30jh8pIkkhKqlHcOwSw6RiwTAmGvNCWUqLJOht/EH73ymY?=
 =?us-ascii?Q?SjgrVVhlpxERdMgj8YG5fma8AwXe2hfDAzQtMFZ8YAdqSAeeKgfJ/VPWGmTO?=
 =?us-ascii?Q?xrndIo46YQmPQ3yI/nyPusYiGQrfgWjLvqKYe4vwq3hnXRXT6EhcAAGAHEPf?=
 =?us-ascii?Q?i+Xm4vCEQ4yVJBMV94aiDFqaPbDuWNYZxnfma0AFTHsSYmp8hsPFXyoYacdy?=
 =?us-ascii?Q?m/OXl6YYnRulj1cs5cDa7h09XtU8JcsStvbEP9dF5wecXLeJc6xrWOCFy+rT?=
 =?us-ascii?Q?Jdv9KB3Np1hcEh48VD3lrFQJqRB1Ikl9buYVrioN4NZleHCewd+siB5bDZIo?=
 =?us-ascii?Q?5GZsLbX202GaY3Ce0HYPSY/WZ8JgE6VGZaqR0axtpPRANzOVW+1NxTO20h/h?=
 =?us-ascii?Q?YFpZqRkD51dexiUUk5VsZM7eMfPjo4VP0qAfjEk8LxQstg9QbGr9AB0K1Few?=
 =?us-ascii?Q?wP6/NexSwm79+Gn3WUmEHjtnrnPeXHOdXOKELQuLOOhEYJ86OATaL4y9j1bx?=
 =?us-ascii?Q?eaQwD988Ih5dIEgxMj16HanZswz8v36dVd4LmN2k/08/IQr1YG5nKDWSLg6T?=
 =?us-ascii?Q?9oxxX81eWyB9jsO7Zzq4IREydLDIcfwYD0mVgaUJiy1wqnCxsket2V2k9znA?=
 =?us-ascii?Q?W0wXkjYl46KAm9yjn4s05zcPNdPubs6V+6aGqNiTKqu7bRDwg7NQjTyOnKqK?=
 =?us-ascii?Q?RfyYydH056gzyOauwV4RSnv90Rzocy+Yg7SDIsqIsNzLtzqX4W14K0I/aQq5?=
 =?us-ascii?Q?imWQmr7LcnBTGjly6h8+wuQr3EBsMjtUiUHBEXVOrWXpXSB7ANUJFIFo8/NL?=
 =?us-ascii?Q?j1N1d3XdvLKE1KmoFla58qmL7MWemv1gglJmrmaLo9yVeih/xcdBRJb6Q5Ih?=
 =?us-ascii?Q?YdtM3SW3qfbMoW9E+HPwLBDqOJ6oEMjuk8x+B7eqbylQcpMv8r/WfcqJL5BQ?=
 =?us-ascii?Q?RcseYDOC1lnHgSIoEd/vKaa/q5XlfTzwnDllwvGLYWJhu5ix0LQ5qWl1DTS+?=
 =?us-ascii?Q?/CK9O9H5bQ1BSnDuSW4LptSBS02mq7xiZFriZZOuOj4Od93MwQf/LroCeLQj?=
 =?us-ascii?Q?WiqaZwfquy8n69Fk+KJxPBQHXu8XvcUNcUrPG4ciRlH+6HUqlRUvGLUKkcO0?=
 =?us-ascii?Q?cvMe1sRXKE6XucaY5LzcZx+5n6/d9kmxDpHWiLSz3HOdlmvfducfQ74Kwpsz?=
 =?us-ascii?Q?8MgPrzEzbCSbEHwMVacamHVqjjAsDuHdAk+pndta862FzBX2BF0bo5HzZoYn?=
 =?us-ascii?Q?oI7wpaSvhUpTADzccbTaK0sd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82880acf-c232-4814-c414-08d92c0cb74f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 12:38:57.8314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dGamiUvNBj+6X22naslDyRv83Nd9jhey9+RLBMO/Z2HmIZVvYdz9GFcIw0mHYQZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 10:34:24AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is unrelated batch of fixes to mlx5_ib.
> 
> Thanks
> 
> Aharon Landau (1):
>   RDMA/mlx5: Delete right entry from MR signature database
> 
> Alaa Hleihel (1):
>   IB/mlx5: Fix initializing CQ fragments buffer
> 
> Maor Gottlieb (1):
>   RDMA: Verify port when creating flow rule

Applied to for-rc, thanks

Jason
