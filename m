Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD667D472
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jan 2023 19:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjAZSlV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Jan 2023 13:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAZSlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Jan 2023 13:41:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A206813A
        for <linux-rdma@vger.kernel.org>; Thu, 26 Jan 2023 10:40:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLze8cgYkucAunZ5UIkbA1l+lLlp+fW616iKU4EdUVowNvxQIzYQePNGWr3yCBThO6kAvFlzjsdgSQqKGXja/LNXvDYlGzgqVHKcSddM/IDlftjreBGrkzGjuqLBkWH1VDeZHIPeAseWdYmFv3ayN8xSDl2hbHz36XJSga0qsBy1xmDs1zwGmjp7D8qAKR5WZiLH8OkD48LMSj432cIvZhQMToKSa7p29zfTiTJTtpzCzF20PwQGqOSS8PLjZ0BJe5HRFfD69KR4gEvvKgeayUGMwDE6iX3QSkITmzzxqZ+EfiINoZlfcM+prn2d7tg1h8SoiKw1MXED9bIfomZLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pWqZnHCP8ixMoIhEWBYKqsVAgfuF8LBh+9/pAj16LU=;
 b=FzlNTrh+7Jgl02BqQd1UUyfgWZ6Myvv7j69uOJ3jho9FMMjhEF9MEJtG2wmZWH1u32i/zPDolKCjgSgmAmyj35wExWXAdYlVRuPSkkFLNd5bHZBr65sQSaHepZ+olWZ+ktZVBzH47nhqsgEHJ6Yk8tr3MH0TGm5sEDzfvHwApelyW24JP7QlLS9MmqaSHEZZYs1WrSAiakYtzKyWA/sgHm6zC0lfRYlsnWMWBMXRiuBR4UcnphtkBCd8QVroLNkckrUnR5J+CWlmZaiu//iTDTXEDtnixALBpnqVUt20P+j8yQOUVI+vrBtYnwbQmmVLC9xm8wgbcnnA/i7/+K6wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pWqZnHCP8ixMoIhEWBYKqsVAgfuF8LBh+9/pAj16LU=;
 b=QQ4LsgJPE+V2sGiYSEAElDdBQGM9j8lsP5h6IYgJaM7svUKuYbUAJ36WI0Zyp4jR6Frl2GZtKT6cWsxR9g9YX2WDFH8FlmYe7S3+ljryrs+KMy8ru8w5WdVgIj4wChjLdz2BOY+IDkT87iPqUC9vzWyHHWBucGc/g8gUMoLJ7Fks2H4neZHPbDiLhkHRYhv5K+3ecR3wvZhF7/aJQcLxAGTTVxfZHuBr9wDgXANPIti5x3AX7AD4C+f+4P8hraIKejx3cd3+Yhu5YKC6uHhdGzOtIkFhatoG0qD6YavndJxU5LtU5kWCpeXT8VWSFleyk/eNHFOK3PifnuVV/BO5JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 18:40:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 18:40:57 +0000
Date:   Thu, 26 Jan 2023 14:40:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] IB/IPoIB: Fix queue count for non-enhanced
 IPoIB over netlink
Message-ID: <Y9LJOHWYidVHBDMO@nvidia.com>
References: <95eb6b74c7cf49fa46281f9d056d685c9fa11d38.1674584576.git.leon@kernel.org>
 <Y9LH5kim0d5rBKOR@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LH5kim0d5rBKOR@unreal>
X-ClientProxiedBy: BL0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:91::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 09065320-9a04-4756-b268-08daffccdd14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7L6Uf3QFRuPtkMp4rquQaUuXURGmfgSpTNih02EOW4uhztZEPda9UeEa2t/bh1B3Q6VG5xV/3JxC6jNU7yeujNolTt440ZKqJaPLVEaX875bbWYiu7Zw3SXtgd/e2e6JC2g2Ed67sJMImGODkDNDvduRmFZrmcwuQwu1yjVECI64GUMe2H8Kh7X8i+Zox4S4UlrQA0jEn+o5Y/a8S+rxvwNdEmq7wS7YCgwY2Fqk0cvVE0ZnysJBQlkr0AiD7DMJAFoCzdf8bgMp1Pq6UppsH8uAHyxJl1pCMR9Q9Ai1qNn54JH61WVthVhpWaXAvjly+heTudS4ZW6FuEOKQHhXjQzU292CIbN66ako7Oz0SyyV2JQVb2b/OrFNnjH0WULp5fFS4wFX6kXbPMDLsKihOR6Lthi0EA03b518xj1DXsOokpjJ+6Gws8Lbdm5tI6l7qascOED4b7qtk1GZ17Gl9nOIPDMaPn/PUm6KcsxFrH56MjGrD1OEN9huAW9eQpwwlNU9XMqsDqhUjOwkexfU+uudUy6zWTuT9qTmwqzlQ4GSPSy3mFMDay1taYAbWLu9nQjA252c/wofbUROiQRfvimv/V68U0Zs63RUk2StTnyYgjXVo+oPLCmM/HNUqV62s33PgNoNyjnax2sj7hk0RNtoehjIR4OK4GoOXRYRVZg+mi5x7C8nZE+nt76AnQ57TelqfQL1Ld5zOmyEAzeHOVUdpHVVn1Cx2QZzxqvP3hi9oPq1aswx2WJpJNQGjPSWde/9DwWb5sMIzaep4JZ/rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199018)(4326008)(36756003)(2906002)(86362001)(8936002)(5660300002)(6486002)(6916009)(41300700001)(38100700002)(478600001)(966005)(6512007)(83380400001)(186003)(26005)(66476007)(6506007)(66946007)(8676002)(66556008)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5UpALwpL1rkKriyjppX44QqGYQzzlUIRALSe8NZy7XOUXfny1SfA04+bMDYB?=
 =?us-ascii?Q?qVT/uHkc7uMP1kaNDPT3KIagviuMj+hupiD9yA/Hz4IXIGW7t3Q3Jl3+2H/i?=
 =?us-ascii?Q?qFv8y4ZPM5jSnSpGI52zD88YOVEQKZZtHEjucAsP146AKFwZ6RUiIBzZ2o4C?=
 =?us-ascii?Q?rizGYJmrcG/N5TkbcK3kr8LFBD+5ZWY21cpCFtKElqFEKStnSTecMuV7Usk0?=
 =?us-ascii?Q?tx2iMfSW82zIRVe8dlP69pqBLpY2qmx9IeYF4jdYtPc6bMEe0ssk12LAyYi3?=
 =?us-ascii?Q?qH/+BpbMc+cehyU+eSLV6IhjsfavZOZ0XE8+mtJktKSgMfyAdHaYuVIvP5y/?=
 =?us-ascii?Q?fEX12IRyLdpqP79WPgRHm1muQXSVxMLF0fvulvkXWkq0dXPGXilOVqC9QsH5?=
 =?us-ascii?Q?l1uQtHBztMAuyUXvNyX2BKas5PXfAZ3uMrkyYfEOLpDcN/q9WnosMHiE6KTX?=
 =?us-ascii?Q?7shobfQk/s02/FJgQ8UuqnYRimezN8EVQ2Y8TE0hKu7gAsprx7qUGwHswKLa?=
 =?us-ascii?Q?rSJknyNjSCkYnl0h8hztV8ly+nzGmT/3SZsNlr3VRhV8ZclQolTLtRmPFs6h?=
 =?us-ascii?Q?8Gn9eclvvGrZ0cU6FIOHc245JGQ52MVDmmIg2jXrggFUWSN4HBvcyFmTjkNB?=
 =?us-ascii?Q?zZdcju3mikeNHzK3+BLapi/9/IXeOHSEvtQBQrYN9M/UXsMzzKqXAYmtzNLP?=
 =?us-ascii?Q?EpI3xe6f081J9x91Wv9zCeTlKJfAF5R3Z4ekMf6m9ZVYjiMXhanCvV6pQqgU?=
 =?us-ascii?Q?64MO2TSXv+pDJnACq35Am/F/23BksT9TD4Dx7q6A55C7U4h55PAcYXJOUbnf?=
 =?us-ascii?Q?KaxnEltQiOMQAhMgg3gZBdYjYe5ZRWetN3nwK79UC2d/k1Pzbv224dC6p2wp?=
 =?us-ascii?Q?JgY2W2AHTMBsEQdwb6s4wyHEP1YypNc0ElZoSNmaFuKfZqcexO5Ei6u4kzJJ?=
 =?us-ascii?Q?OFV13/pUhdENGmf6ssNyrKUBEcAVIK8sL24NE9OSqMzVnSh0OA5SXWt8AmYF?=
 =?us-ascii?Q?1sZEpPVppJ5uFZI1m2pk9waFqWwI0U4OBsrfxN3XnVVjbdanqp0AjLaAPJ4v?=
 =?us-ascii?Q?ofzcHY7Com3qTb8YPFdpodHr3Dxn3DVW0YuRG/kSZhTyOqujK66T5Zf3YN3w?=
 =?us-ascii?Q?0LQqLp2wWsSZ7ImgfwrlcQwuOq56sW0vRHY0uIMsk9faxRS0mWvEougETj2+?=
 =?us-ascii?Q?fjObPnRWprH8bapmH3s0xmK8O9JUT3HxbLTqvr6wbOaBcWtkOyaqNufe+9MW?=
 =?us-ascii?Q?5gn6RE/UIBu4NuQa61Ccf6wSek+E3J9LM4QXXrMt9F+C8cWXAqbrPjODW7OP?=
 =?us-ascii?Q?QViPKfh47/mCGN2OcPEGoI7lAo8hyJvkc4yh1RgNSd8iimBb0F46tSQ3k5nX?=
 =?us-ascii?Q?RqChQ/g7JiVPwldAH0Ugs9Yqtr52sfbP9EMZB7nA8RhwqO4J+YjJ+EJP/qkW?=
 =?us-ascii?Q?07pLoQm8zMYklZPWrP1cUjKhzv4Op96OIag/wb68iP8cHbNuBibWzrvwo7S9?=
 =?us-ascii?Q?QzeVHX1bOdUsSCr98tUJlWU9ie91CcMsNIFvLhioxzSNlcvz0kVE8FZirkut?=
 =?us-ascii?Q?Tm07f0jeJUP3DvB0ILOAslEy63hFE2duNMhM5nlr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09065320-9a04-4756-b268-08daffccdd14
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 18:40:57.4972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He7y3FFTc+GngpBJKom8cmVbTgYE/VCbKr/Y3HJK1pHrS+2989lsgGqWI2PGCoOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 26, 2023 at 08:35:18PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 24, 2023 at 08:24:18PM +0200, Leon Romanovsky wrote:
> > From: Dragos Tatulea <dtatulea@nvidia.com>
> > 
> > Make sure that non-enhanced IPoIB queues are configured with only
> > 1 tx and rx queues over netlink. This behavior is consistent with the
> > sysfs child_create configuration.
> > 
> > The cited commit opened up the possibility for child PKEY interface
> > to have multiple tx/rx queues. It is the driver's responsibility to
> > re-adjust the queue count accordingly. This patch does exactly that:
> > non-enhanced IPoIB supports only 1 tx and 1 rx queue.
> > 
> > Fixes: dbc94a0fb817 ("IB/IPoIB: Fix queue count inconsistency for PKEY child interfaces")
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leon@nvidia.coma
> > ---
> > Changelog:
> > v2:
> >  * Changed implementation
> > v1: https://lore.kernel.org/all/752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org
> >  * Fixed typo in warning print.
> > v0: https://lore.kernel.org/all/4a7ecec08ee30ad8004019818fadf1e58057e945.1674137153.git.leon@kernel.org>
> > ---
> >  drivers/infiniband/ulp/ipoib/ipoib_main.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> 
> Dragos pointed to me that I sent commit with "old" commit message.
> The right one is below and I'll fix it locally once will apply it.
> 
> Jason, are you happy with the patch?

Why not use min?

Jason
