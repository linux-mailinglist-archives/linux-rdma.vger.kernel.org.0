Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0864A1CF3F1
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELMDi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 08:03:38 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:18854
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726891AbgELMDh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 08:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIy0A9XSD6c7uxTG04vly21Q204IloILmQ00av1ZT0Kpre525UmJxma97jF52mbMlRUoF0YfaOj78ViGYDm+wrh9zgA4Wb01bSU1VslRqM1Ow0e8+NfMA7vae4EqkVDoNjBAzvJeGwa3FscURYzNc8LiSsAevU9fsIA1lUb2TsO82k/hwHcyUdEehydZhpFvW6pppxCoCflOHqXsB9ZX8NpqG6RxtR5BDj0xrra5F4dZpdKO+MoMnnoMqIeVdAxnDEq87ar/CCVKtzu2oK2RWJDvwMU+o3Se5kvkFkBt8eHvciD4Fae1Cgtrl3GmVObKPEz5bi1CT7zkCmfVyKwtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxF6bObGv7EvKM64dHfzD9IFVp2nshsTEpSKktmwHGU=;
 b=h1tDHTu/8+rGuW+uSFsKwZ2JZ8x5gqeZOqu32wbpFnSe2tnEJjBbHEJICg3T+lP7PeW676WddgiIHiqomXcFDmy7vfxdcbSpdPezou3oz1xDxWjidTnSpL/mgtW8W7LZnvKwEExZI7oo82MR11eYilhgChksxRir3+rhAkqtZK6hodO4VEAZQ3OxvKFPCS9WD0LgbVpCnd1whGeDknXMQZNMsR6ljjruVz7ZPavHTcS7g49/66BS5sj5a8tPLgB9pxOM89pBzthhdRqMbA2P+3Ff1JIxPBiXEG1ybLSsteCLVtNBiHgb0UyZJJKLB2a3GofYnHJSmGJpv1yxnlejsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxF6bObGv7EvKM64dHfzD9IFVp2nshsTEpSKktmwHGU=;
 b=BdiJWa7+gZknLcs3UU+Bhn/y3234j3bc3UTgRXsirrIINr323SoH+Ogo4XpV2MCXrkbxBHiH1UtI2qKs+fzdEhLCcIGemix4nblvPbgHxvjZhTTE4ZDH5OnKfdI8tvnyGnmWF+VcrohQOQ47AoKIqnHqqxwM9hAFL/DQoHyPLH8=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4590.eurprd05.prod.outlook.com (2603:10a6:802:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 12:03:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 12:03:34 +0000
Date:   Tue, 12 May 2020 09:03:30 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Alex Rosenbaum <rosenbaumalex@gmail.com>,
        Yishai Hadas <yishaih@dev.mellanox.co.il>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        "Alex @ Mellanox" <Alexr@mellanox.com>
Subject: Re: [PATCH RFC rdma-core] Verbs: Introduce import verbs for device,
 PD, MR
Message-ID: <20200512120330.GW19158@mellanox.com>
References: <1589202728-12365-1-git-send-email-yishaih@mellanox.com>
 <a46dc0e5-7261-0bf1-9dff-1c62644c3c73@amazon.com>
 <ac69f0fa-e177-62c9-6fe8-5b0700d97712@dev.mellanox.co.il>
 <1ada043f-b9c7-b961-d35b-9461f78ca9d2@amazon.com>
 <CAFgAxU9Q79Xh_C_-ROXOJiGf_NAMqb0Hc0L4qay_hWB_7qcfNA@mail.gmail.com>
 <3f81f2a9-ba33-618a-2f08-fa4c164158e6@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f81f2a9-ba33-618a-2f08-fa4c164158e6@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Tue, 12 May 2020 12:03:33 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jYTdC-0003g6-Az; Tue, 12 May 2020 09:03:30 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18daceb2-7c8d-447d-61ca-08d7f66c7e8f
X-MS-TrafficTypeDiagnostic: VI1PR05MB4590:|VI1PR05MB4590:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB45905A38AEAAB841F838DE37CFBE0@VI1PR05MB4590.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2GNjE3HlTeI0O/Ty5sLG5z1Y2k81OfSiqZpL3X6pEHbF9FPjDefmc2tOFatAYZmnTQJZuZvbhmDgfSDEW4Wl77EsXPcukbdFyuKVFdTsifc/+P3FlEXCL91wDBVshKTv78x2bS13tU2bZ99Vpb5TBeAyXEY3XfdKQeWfdn27VEmG7CHnGzEPOR1L6NXgdaVXDyHQAqN3Z2paRRBKo0no+HSpSEiRc1LvN9dMInWWVzwJSHNYkOskxVCD6USEXeghOO0pJHRzEYKsjRnSHqmGTC6S8RX7fi/jR7xfejS9PHq6LtV3Ios5bD081lo9YkYPm7bmHXW59mLd/F8FiwQUvsGgZteU+bz3pFkqKtKkJBtGYbMbsyy6Bnq5EDGUBgSw18Utzd/sVTtwLa6C/3+C2v6hEviAw3WqmQKV/rOAn19n8Mpg3bcUr2OtQRKYHySqgGyFEqqOFtARd0SFC4OMInDiEgQWYD8XLucIfwWhFYd0jZNUZn3+o97JWBsgXJrR3T3HWXLtQiqSrjRCmqPvk2ATqfx72+hOWOjj5u8iMVFxmE+du01agzH1DTIh1nr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(33430700001)(66946007)(66556008)(478600001)(33656002)(4744005)(1076003)(5660300002)(2616005)(107886003)(4326008)(2906002)(52116002)(66476007)(86362001)(316002)(9786002)(8676002)(54906003)(36756003)(9746002)(6916009)(186003)(33440700001)(26005)(8936002)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yqISyO/t/rusIwgLOs04B0fK/Ar5aUOddkIPrYO6Z8aq1BrjzXifpH4q6/HIeSzUYZtMns6F2h2LSNvvYK1/WHUv2hWesLR1tVVAQ9TClfpq48VtsHvEAYyb57pdgoDUwfAElcyIvHTs77tOAK7dkRyR1qFbvtu4bHgaXhNpRQXG8Q6lg7lxxSqvBoJDCTfM0CPVo/7vfQVSHrobbOIIMePzBT2C6PJgjnP8uMI7N+Hh2K0ogcpTBOQLlrFx362rBFaGj4gQvZIH7C3bzninzGXiYt/oRuDPaIzuRhyX8sgwwL6CJhYX9hQ8UcctVid24qvc+1scUMPi31X/je7EDP1cVV0gavTqe5T4xGeipM4DLQwyPV04k8AuP3iH7kyZL9tNNL/koETRpait/qUv3YxoYggjprixIQD8LmHsO6aROQJ+dipNQdaIeIFbPVnwYIjgRIHUts9jfkt4Ecgnwq1joWB4VpHCggRPyJeCmkBrSSX8C6aJtrnhWUHoFP8m
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18daceb2-7c8d-447d-61ca-08d7f66c7e8f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 12:03:34.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2KeeTDlGPjqSrRbxmCnnFfC0ncPlhDCy88RHmzD/oyBreISgoH1pkfPDDF5pt2TWbVoYmCQv5gg3bhdcJl4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4590
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 02:44:54PM +0300, Gal Pressman wrote:
 
> Let me know if I'm missing anything but assuming I'm importing an MR, I realise
> that the address and length fields aren't going to be valid, but
> still the MR

The length can probably be made valid..

> points to physical memory that probably isn't in my address space.
> So the process has access to post operations on the MR, but can't access its data?

Right, unless the app takes other measures to share the pages
 
> How's the implementation of the new callbacks going to look like?
> It sounds like this feature doesn't involve the device at all, in that case I
> assume it won't involve the providers? Is it going to be a generic libibverbs
> implementation?

In the ibverbs model drivers always have to build their driver
specific objects, so driver involvment is required, though it may be
trivial for some drivers and some objects.

Jason
