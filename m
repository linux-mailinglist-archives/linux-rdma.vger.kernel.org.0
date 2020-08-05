Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766E123CF91
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 21:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgHETWb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 15:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgHERlp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 13:41:45 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on0600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A74C008690
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 07:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEBVyW0s6kiwBud6uWvZpM7Dehsn2Yq8cEV1HTLX4Y82gVGT1KEYWymMRNAH3lezsRZFVoAzN4LRe8GSyTY75FcZj6LIvMqZPQ1bXxtT754Q6Q/9DKJ8Lo79w3rp4Yd+jWUD8266Tzy/fD9AyD36TFls/OmryUW8Klh1+Rca4XNuDBXFDayUZn4rXDlUpjqzpMKAvtU+bJmjVIeBZTWGJhz9aKmiCXZoi6faV8R1/+M5NcWNupkBBjlEArZx7V2ErBVwVj1dcHbrsFPpFd0P7eQ+lydvfIo/n6wqRQGA3JRp8JazIci6EPcmE2PPG3dY8V7DNQnUrhvBujAFJ9A2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwidUOz2pltPPaTWAIimDN6ZSZzyX11vTAUJeKqkKDQ=;
 b=kOaWFR9TF8F3Lac3rXBx4D5h/EHAQPsejWRXYoiNteOgQTV3vD694+4OZnhElGqmNjXIXBuR+6R76Rq5odSTncJyJr6F2bwZjtz3hyrK47y0eDQtHH8mrG8pm9SeShre/Zh01PWhrJIvk2kbEJfdypyWow2VtGLP5PL3gs+vpGDHyluR9P0rI+gBYNzIohGpGfEaLvCud1npOEDPWE51HIrqENdImvMqhO1CdSkNsiI5U3ggTfJrudFc45So+0lm2hCFw3dnEEcwiVufB0BXrB4KilQURnS65bnxq4Kz72Nczz5mZvSLelWpD+qRKM1C2VTHu1aeNG504OYpnMZhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwidUOz2pltPPaTWAIimDN6ZSZzyX11vTAUJeKqkKDQ=;
 b=otlfnujf4Ub1Wky7JvOWRvuGf97cYkfYMc6vnO99zSs9cRwiWbOvzB5WBt2Kf7m1Cg75jDPpoe2yXKnkP0CEuF9AQOgc7lSYVKySisB4u9PthXUKjEC8I+ET84ldmeYBF0ZAWkrCye0bpMSpI9mWOQWi3cWqlGJuecfVZ00LHh4=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB6470.eurprd05.prod.outlook.com (2603:10a6:20b:b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Wed, 5 Aug
 2020 13:16:51 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 13:16:51 +0000
Date:   Wed, 5 Aug 2020 16:16:44 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org, jgg@nvidia.com,
        jgg@mellanox.com, dledford@redhat.com, oren@mellanox.com
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
Message-ID: <20200805131644.GJ4432@unreal>
References: <20200805121231.166162-1-maxg@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805121231.166162-1-maxg@mellanox.com>
X-ClientProxiedBy: AM4P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::34) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM4P190CA0024.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 13:16:50 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4087375b-f6fc-4723-d7bd-08d83941d0a7
X-MS-TrafficTypeDiagnostic: AM6PR05MB6470:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB64702A68FA6AA2A811DEDEEBB04B0@AM6PR05MB6470.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muIXJs4r5SgZNB3S5BcwyxegX3wnrlTvnoQ627Rb+Qig3jxp7jVkgAew5RTERswcEb4FIwhZR4AiP4EXxiXIcBV7KhSaGqCeM2sZ31fPNUh4mpGvGaQ9sk0pbMYBMc8uO/mZefrlZ5FCfedxzudrdLtjaot3Hhr/QLHzDmN1N8mY2m73xew3YdnhCWaqzbmnuSTKWmztTPAFrbMrS0ztV3ZCatYqa78zu0mKjLMlb3cn9k/+RflUdMiCK8aWrJXucChjzZL26R3B+A3pajZbiCleCdUDgi3Xqp7wfQL9iOFkbRiEiQyKKKd1mjYbqrleMGRNnOfSkwLVLM8sTKNHIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(8936002)(6862004)(478600001)(956004)(33656002)(316002)(2906002)(52116002)(4326008)(83380400001)(66556008)(107886003)(186003)(66476007)(4744005)(9686003)(66946007)(6486002)(8676002)(6666004)(1076003)(16526019)(86362001)(5660300002)(33716001)(6636002)(26005)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4+od+T4U96odSsek9gtMemqHISV6gfH+Lc02Rgmvl2YNm6oie3XqOeMjNAoC4oFZg0D0qayY5w53o0XDUUBJKgn5f8AGwHvaLB6Dz49HQhLkmO/ozyJWNKQ+/GSypM2wE3H0dKak/pmL//EOXE92qtRmWluLvys+YedKIAjSQlWrzK1SdYlGNieLvQRkF9rijsYb+CDny9rj9fFLWEk7Hj7WLzdgTD27MbmwbUwn27HIY63JTconUENaabrSyZAGDG7SBwmFj9UFmLGKmBHZO5kc9NWMWyxDeFDUV45D8LdI6lkalx8EaonCririfBoQOqEUY+bVuKCtgZhUmm89Wx/CEAydC3FRhGG1lpJ2UerA4M3sXdYXUKovzbh8tpFg4uKikINxXKoGlFm52mIjqj/uJB5Qz4da7GUMF5Vt6Jho/LJOaWEjR64CSR5BSAH3VIKgtB1BCnOFX/bL6FXvQ0IZGBaMOuvGMNGvihwXG03yMHpSDkNmog2ehA5m3IWHMss68kgXpH7cqjaK2TcGsDg7Sfn3eKZBg7yesCTOYd9OvaHouiwWf7quj6W1zIjtfCoBvhpuCEgpt6vAXTx5kQfS1qTSwKciq7ze35HRBwRA+jvgIE8MFVnjS1ed+GebQPhp5zGIaJNFjNkowljq/Q==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4087375b-f6fc-4723-d7bd-08d83941d0a7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 13:16:51.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU+hUnt92T0m13zXEmDk9m3NUDU7SdTGpYsh/pQgCigXvIy6Sw3CqQZna115dYMMszuzcihqD6Bpl4ZEiioFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6470
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 03:12:30PM +0300, Max Gurtovoy wrote:
> Add performance optimization that might slightly improve small IO sizes
> benchmarks.
>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I find the expectation from "unlikely/likely" keywords to be overrated.

When we introduced dissagregate post send verbs in rdma-core, we
benchmarked likely/unlikely and didn't find any significant difference
for code with and without such keywords.

Thanks
