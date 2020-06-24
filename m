Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C21207292
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2020 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390782AbgFXLxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Jun 2020 07:53:40 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:62179
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389353AbgFXLxj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Jun 2020 07:53:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIbEIYcU4ktA5Zso9dTxySy2MBMaqQedf8jJHLWsP6730DbzLN/e+1kKNR9ywvIAoQu++bYETDVuQSukCnG7LsWdaOS5apNWVmXsTw/MYNx+C9eBX4adh19mDBcoaFZf56wHi/tLcU1QxlPHCckIFIgeUjU40iYkiFLLDU0Lv6FiuXZ8KarbAUqjhervhCXj1HbhgofDumFj7gGxe9h9OH+Qzjm1Cv6wNGi0bsceeNDk3hOzo180jfot2R+ATJJyDg+13hWTW1gA8Pk9fag2Vi/sD6c8wozWjl6oCg2fWE/kszIQlOUX7+rFKAD8SUZRmNvEEpAkQ7IE5R0pTh5DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=797FVRcjZdn1qhW3E9Jyw3UZK81VbJR1cHmAy8a8DWs=;
 b=T9vfjqyCStPQkxBT8I9Af+tYR++PMmgXebMIDuFE0/LPJXHv3eBlyCiNJrQetW25ci9trXiWTt3lX0vkN7/trU1dgMsP0nyPTmK8SVsRDY7fAWzn0aGf6qM3RIUl78PogREtynU6xX74XSaZOFKNmTWvPhZXRu7P06knZ+U5JNR5ZPI69BtiAmgcWCW/oJTmOQLsyKQcz7eBvtRues8uXeFX2PpyY2djXve1uUyhf4GGxU2MGc282RI2+d2WtyJXK1LYSzw0VNSSNVow+nNzhgqazDmPH+Ix0FzT+1/6pNp31NqgpTqeT624idX1a1hgTi9pLA/8iZ0EtkaVSZrhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=797FVRcjZdn1qhW3E9Jyw3UZK81VbJR1cHmAy8a8DWs=;
 b=H+LpedfhZtF4GTKaCeEwwe6VrU6vvVVo9hTbuouboUq26tOOqe8/CFfJUC9WXWEceaqH0dKTWE10Jw5GQAxEEpoi3zuNpjaIgQYECKmEI+erCdOYXS2PjjZvBjY+mvaECSBrs9HVAiPsbZ1UwNCKjeASed7p+H2/BI+cjqjjHSI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR0502MB4079.eurprd05.prod.outlook.com (2603:10a6:803:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 11:53:35 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 11:53:35 +0000
Date:   Wed, 24 Jun 2020 08:53:31 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH wip/jgg-next] fixup! RDMA: Add support to dump resource
 tracker in RAW format
Message-ID: <20200624115331.GQ2874652@mellanox.com>
References: <20200624070031.1436711-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624070031.1436711-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0007.namprd15.prod.outlook.com (2603:10b6:208:1b4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 11:53:34 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jo3y7-00DJlf-2o; Wed, 24 Jun 2020 08:53:31 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28747999-dffa-4cb6-7fe8-08d81835397d
X-MS-TrafficTypeDiagnostic: VI1PR0502MB4079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0502MB40793906FDC8F56CAD52FADFCF950@VI1PR0502MB4079.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:169;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lksqdc7YaM+uXZCVKDD5emLBHP6EySBlUcZG0VtoORu273RB4vCyoQzdER32foBWrRthQ4MWdaCaxJDIPW2MDO+39ckCBspS62dK2K1qZh5eAkYp5oXhVvTai+J7Y4RHKcHBDMMoTHq61a0QhaqXjuyjqFfTK2mmMqYvs42hrfrs43B15KdkmpO3UWKyqx4Ffpiux4+f4hdej0JOagj+Ip0GSKa3yVwUJ4SbXBRyNQ7AedpldmB+6tFwLgOGp3PJLqi6Itz1dQPhRbpZ7fb8AYTbl2H8CsL98VgXlqn9JlTWMd8FwXaFL8g9YCgeEu7orCeX+taQWGiw8YRSAb224dS5F+xPS2p8iujsN/4LOHiZt60PFfeTyS2N8WhBvhdKrlVlc0GgcZABx43LhliQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(186003)(54906003)(26005)(8936002)(33656002)(66556008)(66476007)(8676002)(4744005)(6916009)(9786002)(9746002)(66946007)(316002)(5660300002)(426003)(1076003)(4326008)(966005)(478600001)(2906002)(86362001)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RSn3AE8YCJ8lwIDF0xtvFmFevjfpjED+6lVUZTUlK88oIF3TlSn1uKIcznVx3b8m/Gq8vJ0C/iCW10tvw1lXSzh75yC3DPfc4+yxG8my24uJq5gYfxxOLAU/hxzqurP1v5eE8HwLeqJ5JeYgM8bPKltg1mUNE+SwV68ebeLHaFkKLeLA5LbT6TA+cmtFzYFKanpTeSBkj2RGfsG1zvHM8MxYD5egy2m5E3vBfM6yXWwOsnFYqOhNZU/pAcfPKxmTuKZCjVMIR0rWenfTkTlnoBMj5icRotEK9ac0Nr6EWC+PYC9qLNW+AVBbnY7CuElakWAzLBw6NfEOsbeMaJNH5D/oL77rlTQ5xX+b/xzlkEQfa3ov2+feM09K2KVSDDEfdlayoOun0jDUu7DNMROciMD84KJppbIem/d4Srg+me7ffF2Pov/L25E3SmlQewaleSR0Zeu10iCqONAQ0mL3NJSB7wYH3QuqdkDOF3/GG3I=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28747999-dffa-4cb6-7fe8-08d81835397d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR05MB4141.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 11:53:35.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sfH6ua7OulqDHBXv/AfGoJoSKXXjRyXvsnN1SxxNqqzKfFQBJA1CFvKGlPgFit89grG9hfE5b82twDf1bXFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4079
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 24, 2020 at 10:00:31AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Rebase error against
> https://lore.kernel.org/r/20200507062942.98305-1-leon@kernel.org
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/nldev.c | 2 --
>  1 file changed, 2 deletions(-)

Hurm, OK, I squashed it in, the commit IDs will change now for your
userspace series

Jason
