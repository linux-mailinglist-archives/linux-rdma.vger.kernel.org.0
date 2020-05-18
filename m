Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641DD1D843D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 20:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgERSKq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 May 2020 14:10:46 -0400
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:6048
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729609AbgERSKm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 May 2020 14:10:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfJmQuNAuhlTSo4lbdCwg9p8yI7/CUJwwPPHiyx+FQuNYSRqHMhsELEhagBI6HuOEz828HW5e96quV+wZ2Z+lp0IUons6SguO56vVtNzysaw67K6dPxauuXwCSMK5CCXbb6S+J3dZNoLSWP+pTNVJlOr0fqHpmspSo8ye6ljcrJUJw6fLIi5opOfg0BTix61DM6CR4MNk4ectCW4WLGRl0u1m922Ate7j+Gy84dzoTiCNnaGxJvgOy9m1b9ee3MRBZlKX1tRn6rakTSCDMxkbfLUf1tZjtWkSpX/bGHQgSwlwx2shwFANEXx8iz5aiywn4swqeFNUQ36h9VfWD+ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwyDL0PTl6IP8JCNW+WP8l8zHxW1y1jTCH6FNyRiGxA=;
 b=a3w6bxZ/8/P4H7Xj/KCGy+RsL2+74mFELQiKPjGj8zz69aCwi1poGDq1eWgMYi7Iw6QwubuRnToaTN4zQfPFLYQsMNb84o4Gte4wuC8TcjIDCyMWvzTRhin4qird/a/Ci5n8QbnlH+Ml9Z4A0/P2TVG1qv/L/rL2rxCYzkMPOvkeWBwGDNdOKQG6+Y+8ADpO3ZfXQytdcuNnORYgrQYa6w0AoqKwYe3PlGigAtWMp+fhYFBXkICjEwLqLxSX1aYPwSD2+yLzbAKwVFo9YjyOrF/eCiKgbgIAqCduv0iBHC6Wi+dLiUusEbwUG0ywhpNEfAAfpmeC/UxsduQ2Q+mzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwyDL0PTl6IP8JCNW+WP8l8zHxW1y1jTCH6FNyRiGxA=;
 b=ZtXkdsbZR4wPzZ3sXsVQCm1EGF7x/jKs2oorSQkwAcGb6XV7wZ8dPZPTeiLX+TNLaJwFTsNK3J4weo7u9kaxcoWkrTkqPeWJT7A2ARNLRIgZOroi0aP1R2RAnFleLCs6REHKoVUPGqp0/CNR0LIkxDlVyG/bAwEFbNg5Le9izAE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6206.eurprd05.prod.outlook.com (2603:10a6:803:d7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 18:10:39 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 18:10:38 +0000
Date:   Mon, 18 May 2020 15:10:35 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
Message-ID: <20200518181035.GM24561@mellanox.com>
References: <20200514120305.189738-1-maxg@mellanox.com>
 <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:236::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0048.namprd05.prod.outlook.com (2603:10b6:208:236::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.12 via Frontend Transport; Mon, 18 May 2020 18:10:38 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jakDj-0000dz-3i; Mon, 18 May 2020 15:10:35 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de9f55da-e4be-4ac3-9ef4-08d7fb56c4dd
X-MS-TrafficTypeDiagnostic: VI1PR05MB6206:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB62069DC319883D99DFAFCF4CCFB80@VI1PR05MB6206.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J80A0GipM+1Tdnpu2KE/roPYMNMgBF2u2N6gTx2AnFg1DF+hanKsAL3+wqXRiF1c77KeQzu+C3OWVauOkDzbd2tp/FkufFXbcJdtCOc4NAgLLVwrvK80vgmV5vcF6jbNyMw+CYTj+dIsC2uubckgu6pbmyCjJD83HEkW/wTqVGJ91knQh9VniixxK6u2MoTjxH5w7SCc/LQE/C6d1M2U3BFwuO/exgrYl2X6uKUDMrnsnOyH+e8bnXAXbWugVlQsGVLz9YP+1Y/OU4XC+8omTScusZZPFkgPmPF9b0sQnAq5uXnIrfo1L99roWgp4G6bXYq8Y8UpBpztY/bWFbzy08zDLBGu4UGdCMZV4YYkY4bETKYFKz959TFjZikZt6JJW7GuqrWLP1zaFMsFBS4LJloGkIXRNX/A5thlBIBuQCA0yGxxJmcrTNKAlzteJ2Fymylt/3i7qId1/9UxslHD6k5GKVUCqKBx63phOg1+poqi/lXJ7DT2rQVUqbgE4BIF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(4326008)(478600001)(2906002)(86362001)(5660300002)(2616005)(8936002)(33656002)(26005)(6916009)(186003)(36756003)(1076003)(9786002)(9746002)(316002)(8676002)(52116002)(53546011)(66556008)(66476007)(66946007)(54906003)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XH0/u+uxVOV/14oApH9H408nrx5VTweuq5UjjcHSb7QqEpfRkbFSWAXP7Nw2yDNk4p8jILi23e4QnT/sz839JBCARmG28SSuCIhPH0GLRDJyt+pQniVV8Unv0/NNZ6AGPvsKq7n2N48TP3Ir27wisZmUdbRB+8hs7XBJp1ORvQEmy4MbMwrSQZj3cpnq0Fq/p6yZRjAvZtrOu8InsMgPzyQNRQ4kLa1FE7YLx+H9iMp4ohwkwX3Kcuq0M8JH3ITLuL018mG2HFZPoMqSizQhecq0dX4xZsRJbxSSOO91LozadJXOiXvD9sxRiD1Sq7ADNYFmmJp4DznPZDCpg1IioNC0cfbRCk6a1MCWtdmAe9f4H+Xi6TVOOYvj2XdKR/QM1r7AVp2ySlwzPj/XGffd3K3lQrrGAhVoVQKBYKaPCT7gMSmdAuTyxqSifpk2y0qaT9Idu0cEGYTgcnF2yEmZgDHA9l0vY299QFdK9/sJ+8Q=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9f55da-e4be-4ac3-9ef4-08d7fb56c4dd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 18:10:38.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Onqcg7TvMj6ne7PabjEeSbUF3okfOIpDVL/oCdV+SQoTE9NJv15Xf+OQ1r1OXA7YJpjcMkI8Ujazvxx200+xow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6206
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
> On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
> > This series removes the support for FMR mode to register memory. This ancient
> > mode is unsafe and not maintained/tested in the last few years. It also doesn't
> > have any reasonable advantage over other memory registration methods such as
> > FRWR (that is implemented in all the recent RDMA adapters). This series should
> > be reviewed and approved by the maintainer of the effected drivers and I
> > suggest to test it as well.
> > 
> > The tests that I made for this series (fio benchmarks and fio verify data):
> > 1. iSER initiator on ConnectX-4
> > 2. iSER initiator on ConnectX-3
> > 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> > 4. SRP initiator on ConnectX-3
> > 
> > Not tested:
> > 1. RDS
> > 2. mthca
> > 3. rdmavt
> 
> This will effectively kill qib which uses rdmavt. It's gonna have to be a
> NAK from me.

Are you objecting the SRP and iSER changes too?

Jason
