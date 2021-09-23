Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B53415D03
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Sep 2021 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbhIWLrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Sep 2021 07:47:35 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:22240
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240617AbhIWLra (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 Sep 2021 07:47:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LhBSIT27oa8r1QWQgRTZz5r9UDZScc8YLWwhqVOTKFmD0S+v8tCYttNFW17f8WCNLO2pn/hLEulADT08qEVWE//yn6XWVtvg6sbO1JrLkL0dT7ui+T2Xk5h3xhJdjzNhacAWm7rBbnLUNr5/8LYu0L95P3hGFlEWdRbUys3MzSaImR0fJ7QJiEJaS7GekkMSwkwobZ7jz9ed6BBtCjqrhgSOVuV4Ln9Np6VZN7HABlyWf1geWcOUFAoFjlnFyHtwqFmMsUApCK4wqa5/f5k8F5/GeMzC/IsrqZxeBe6cVyV3qXZOpmwRs4f3FMaZuZLmaqeKugUYk9lExgbOSo+dEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sO5QJGtdG+GSpXgD1iahPWNsY7w8v07d1Zjizz34Hjo=;
 b=jwk/qH38p/8uNnzLdhSM16n/RthtUxnd7op0LnueBdio1To/eUxKU8qhscI9vDW2/vAd/+7eybXNTS6aWoi24yk/5703VOFgcinOzYF5cebGGclYWpfXUL+b49GfhBJ+qJcMsxPEKscbFLPPI9l/S0S2uRPVF+PPipWLx08XFLejNyxdScr4Z15rTuAK6re4KO/Ay/ehAIuBUq6o/d3Jwg4nxKl8qbPUJr3Q6j8/K4B2O9Z4KHk/PeRb6OMZrlFWG0RPsEl7NpkZqIPWUDIVIS5gM6dJ0T32kA9V8WAFlJ6hHQFP74b4Gj3yVZZtr/zNbYKSQYlRnGxR+35ZO/lgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO5QJGtdG+GSpXgD1iahPWNsY7w8v07d1Zjizz34Hjo=;
 b=F6lgeJpqwj/LOjl/lXl2uCbsAktZQWZ2qZQ/QedYpElB6w8UZgguI+Yryga+xF4Ptfx18TFY0P2qlpWZX15rxfuDZKqcmS3Dv8OsuPl0F6sg+PxIqXAR9mrYY+N0T53M6vOKnRTpwHhzzNcijLh55HPjywYeyYmKdgeTTlNa2ja/DWsJ7x0gh/wmmN6qutx8dMDH/ddn28rxh2ppQI2T23mYi/NO+FWQxBr9vL/R3CuH18qf7wFOHjZaCir0LQ6fahA4BLcHZJ+9F5EXIy+Lh7e94TqcEYvV10gt/PHPuk15eEBWRsDH3AZnOEtQCUAIhpxkRZU0n8gRyf10RCZlVg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 23 Sep
 2021 11:45:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 11:45:58 +0000
Date:   Thu, 23 Sep 2021 08:45:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, linux-rdma@vger.kernel.org,
        syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
Subject: Re: [PATCH rc] RDMA/cma: Ensure rdma_addr_cancel() happens before
 issuing more requests
Message-ID: <20210923114557.GI964074@nvidia.com>
References: <0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com>
 <YUri44sX8Lp3muc4@unreal>
 <20210922144119.GV327412@nvidia.com>
 <YUwVUjrqT2PyVEO7@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUwVUjrqT2PyVEO7@unreal>
X-ClientProxiedBy: MN2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:208:e8::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:208:e8::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 11:45:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mTNAr-004OTh-Aw; Thu, 23 Sep 2021 08:45:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d4ef0e9-c822-4fd3-8f6b-08d97e87b59c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-Microsoft-Antispam-PRVS: <BL1PR12MB506170F1E4EA4CD167B9E4D6C2A39@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPk5fGKShyUDqL807W88sKA7b/8pzEMKu3waLegFrboVslJYxDVq7BshuN5rN135C69neyr6Hc623OfeIkiK6QgTjAnTSc7gvRHvV0UkKhIisIFPFQDaliSmws/5GWZPBcf0tehAGKuBDdX+xVN/lJaK4qqoaDBgS6rklJ3QevW1/zI1dBfjx8hKcZ2Cz88ub03+FU7/nwIAemaUsUcWDaQAtm7qG8N3rVlQbMURM0zFTWfcy5XNuM/kn0vBgfr5WTn180jQl1jeQ5XaR18H7HgxPEmGv7WlwRKm4OKjijOzpFZGZ83BXFVe8aGKIDF9p85cjiCjQGf1l08fdwetQpzepRRv2Zg0lr2W4HFb9zX4wrs2ukIMxKSKXipmHwyngCGu1AJoCvxBlEd/nqKMtOL9bC7OWub5izxmsC7aDPHeMKoEztXsX9N0uz/zKOfwmchfYauekI+gJ2IooxY5VMFr9kVebs6zlfepOo3ObV/8VRvxcrW9/mciJWHPy+LF9S3rzS1fYULyS0vszeNulqMr/oExm0dmllMcfeAD2hhc0ZW2G2hkyV/tozPKrSTKZ+a9sosi5jC2oUYgKVrWFIyIx8FpBCH1d+GHOJtpXnNVlBli995lkQKqxbO9XMpBN568/lp35a/89aj33Y/qhEJFTrJYMAOuKw84Om9aLUo4Iom03oRpboxr71466914
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(1076003)(186003)(26005)(4326008)(66556008)(316002)(8936002)(8676002)(36756003)(2906002)(66476007)(33656002)(86362001)(508600001)(426003)(6916009)(83380400001)(5660300002)(38100700002)(9786002)(66946007)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvDIXax8HhsR9ZJZ3DjP2+EY1/Mcao2TTs0N1n6+89E7jdB/O+gF0FzOBL7U?=
 =?us-ascii?Q?JHsB5r74ucaOvTMI6iIhiuzaSncOUvXScpPezgKMoHEqQKfehX018Y7fsIoU?=
 =?us-ascii?Q?TEPaVqd4acZyF0P4CzTwmy31bRT06q5C6zZk1tH3y1Aw+y9qFj3ikQCyT+k+?=
 =?us-ascii?Q?ww80v+2yAZVha3oojU9u0/MKIrR3bZehbKrRjxL0GOkJ+fQznxasRrrRBkbV?=
 =?us-ascii?Q?40k+LfLr/CaGyeGoRhQ5OWTEm+S8NMgDibzMhs4E1PQ82Zp3+MSgghsQxWxy?=
 =?us-ascii?Q?FhCSyj1IA8Eu8uE8E7Td02a57klK041O/0DNdLvX6gM2JwHPYLmGQezt/PHd?=
 =?us-ascii?Q?LxucJTJkN8p8u+vRdl/1/iDA3msswTEhVXQFmyTh4XMRuPHFbEXT4WSMHP3g?=
 =?us-ascii?Q?b9JLwd44/GYL+HhJjWWA9awT0jh1LbJHK4JzNDLvakDlr2SEGQIdrNFuuaMa?=
 =?us-ascii?Q?6aMEXeOchVOjLT9xyPa6U7aKCLeDbW1ApNgiASaMmOkGAi8JdC2YX3nzLd/U?=
 =?us-ascii?Q?UAA37RT1gTy2WQJmH/Cx9ikFUmzpKIMTTbFMzExVOJcQRyV+rJ3/vfojLDLe?=
 =?us-ascii?Q?2oA1K+ZTcH8/lblmBhENe26aQZieuimK8oSd9q8F57XuMfuy3OLE6DdayWFQ?=
 =?us-ascii?Q?6y687GgRwKYcsSe0Cr7BvhU0YW2vIo3Ul8ZOFDb7tTieFd/XhGs1uSy38LR9?=
 =?us-ascii?Q?CcRXj92vmbAf+iRTpI0VThYftZ6zZoCEnqmKcyb7wnvnDE+b5WVYBmF71QoZ?=
 =?us-ascii?Q?K2EEnGP9kp2RXSR7G8D589M5vlY/N4skzALJeeE3v+2+83OldDitcaNXwyeU?=
 =?us-ascii?Q?YowkPuVsRTyIiGnXN6W2bLsd4yOvM15ONdLbkE4YIwePUBkGUI5vCM7ogPpM?=
 =?us-ascii?Q?muwDWEi1Gp8rkys0IFgL0CLAKAPWfZVWvWzD5G2sQ8cymvy9ZsdzmIrfjCsk?=
 =?us-ascii?Q?5dFxnllTrQn3D9avnE2aKRpQ6fuuMgK0DDReyRKxYTMMBUyrnBWLdySbAjCN?=
 =?us-ascii?Q?hfwkwYG5l5hpQAR68azIpBV5Cu7Wg/k2cS1gXC59IP8pVoNEfIBJDDbtZgRR?=
 =?us-ascii?Q?idlO9AtwlBh0cSYe6urW4HWKvlcVNkd9g0cwPHEbISX4d3sNim2j878iGcYf?=
 =?us-ascii?Q?yaJwtXEorqTK3DjskiL1QxI+xgJy5audOZo/RC40FU4zL0jz7yMj4Tq2VaQ0?=
 =?us-ascii?Q?nJK3s9NvrdtoEZccmrd6x5vu3sV9TTTRWJuzqM1hcDCRt9S17FKLz6smGqLt?=
 =?us-ascii?Q?g5YMyttg3P+B4dMqhaMH0WY0vaYsbggbsZdSII32GlyNMmRfgd0P7+qMna57?=
 =?us-ascii?Q?RQUzE9Fr/UD+N4iBgnrFTs3+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4ef0e9-c822-4fd3-8f6b-08d97e87b59c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 11:45:58.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhnMUdxppSIpHnD/uFUMNWZlMT+pSS2qBiurfED2GZqCKB4YYS9ABlfFObYhFbOA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 23, 2021 at 08:49:06AM +0300, Leon Romanovsky wrote:
> On Wed, Sep 22, 2021 at 11:41:19AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 22, 2021 at 11:01:39AM +0300, Leon Romanovsky wrote:
> > 
> > > > +			/* The FSM can return back to RDMA_CM_ADDR_BOUND after
> > > > +			 * rdma_resolve_ip() is called, eg through the error
> > > > +			 * path in addr_handler. If this happens the existing
> > > > +			 * request must be canceled before issuing a new one.
> > > > +			 */
> > > > +			if (id_priv->used_resolve_ip)
> > > > +				rdma_addr_cancel(&id->route.addr.dev_addr);
> > > > +			else
> > > > +				id_priv->used_resolve_ip = 1;
> > > 
> > > Why don't you never clear this field?
> > 
> > The only case where it can be cleared is if we have called
> > rdma_addr_cancel(), and since this is the only place that does it and
> > immediately calls rdma_resolve_ip() again, there is no reason to ever
> > clear it.
> 
> IMHO, it is better to clear instead to rely on "the only place" semantic.

Then the code looks really silly:

	if (id_priv->used_resolve_ip) {
		rdma_addr_cancel(&id->route.addr.dev_addr);
                id_priv->used_resolve_ip = 0;
        }
        id_priv->used_resolve_ip = 1;

Jason
