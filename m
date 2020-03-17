Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E66188877
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgCQPBD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 11:01:03 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:22126
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726478AbgCQPBD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 11:01:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8+IxRKOFcSQtlQLYD1Ao0BWYlB7FMNtJpTljP9QeIyTDyUfHF4GQKwqaPQqahNU1DAm3DIGE4htiVVbufCRnlAkla1MF9FRRvj80u7AapplNOTbdpNJEmO75mfFFaT+mSVKFpOM+aVuscClSYg8fbL7W1Nk7G4yWtx+StDIhL3ipToTANAWh8Yytm6uZ6h0gWa4/qtBusvkcbWkx33qcFSx9jwPucu8DbMJuysnREhb/+MrCIANzmd5iqODnhKPGK4rEyEsDcg6y9HMaVx2QU4G5p8jDPp9TbaNVUQ+tzLTQZFqaMwZ7uy1SXBCrHzI9kb/a6LtYTr7fs8HiMgxsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJVOL5mEH8+4HfuSsjC6BwQCY4HmKpK8kBJ0N3pqcfU=;
 b=c44qKqkGYL+v5fZYjOmuMzDNJyDeZR94Om5pi2mjV0m0fXZXaUqHhOD9ElrU/zw6b+3+iFCyFKNrQTt3qVrKbc2Scy/UY5RUIw4i0i/c2XJyl0FdS75LSe3R+rKTO+Dz1fv991J5/kr6J8q3m+RFxL2x7S2iwF88q180KV4mUMPpaUaEYzs9KdyGJHaV7MZfc7eNhDcRCabrzW+ZTidDvxPhZ3DtflebGQxNU77iu3aMV3NA0lINp+BeKQEZr0NSXXZhY6oTnimgsKmQ9XyukqswTBqoGMZ21iM4jnhqKXFwCUV6GsLlgjgvRFCvpgGohxBmq8Hr98xuVGDIQjNpBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJVOL5mEH8+4HfuSsjC6BwQCY4HmKpK8kBJ0N3pqcfU=;
 b=MAx7uEcus3BjmqvvLeoy9WZZwwx7ceSxARNPhflx6BWs16Q1bO0ozDWEk1fJ5trMx8IMQyMauiQeVx29duND3EI5goQ/6pl6ytlshaxoIaZEPNfpfqLJmr5iwyUVvwbcLqIVdH6AW0nArJxqcM7C/EOEVAWaocI+5z09N5M7Urk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB5991.eurprd05.prod.outlook.com (20.179.0.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:01:00 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 15:01:00 +0000
Date:   Tue, 17 Mar 2020 17:00:57 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Lockless behavior for CQs in userspace
Message-ID: <20200317150057.GJ3351@unreal>
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
X-ClientProxiedBy: AM3PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:207:6::27) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM3PR07CA0093.eurprd07.prod.outlook.com (2603:10a6:207:6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend Transport; Tue, 17 Mar 2020 15:00:59 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc795018-e570-46e2-1938-08d7ca840101
X-MS-TrafficTypeDiagnostic: AM6PR05MB5991:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5991B1913A3CBC0A0E6B2709B0F60@AM6PR05MB5991.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(81166006)(16526019)(81156014)(186003)(8936002)(8676002)(966005)(6916009)(5660300002)(2906002)(4326008)(478600001)(33656002)(66946007)(86362001)(66476007)(66556008)(316002)(4744005)(52116002)(9686003)(6496006)(33716001)(1076003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5991;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: px2tc59mh5mMjhHkLpwIcQfLpHgghY5KqWMtJVSJBubVZkiHbjGGzyYEOMILZURS3J43KOy8IIigXAC3Q4dIc8leiwQWoCa3OJN4hrgU1BS8Z64bBsTV73nPkQqKtdhhXcO0O1mf0c9+WBtuP+w5aegJmb+V4dLQ5SOYw9yZTShUkhS3RJWxX5Q72m1LZv5uR6750Gm3SWT4gSKjeSudzdkq6160qpCXIUaGBv9uNNrywei3kFx17QrpQsgQTjGOIUNK30wG0TMZnj3hx2kifHtgtDGMExUAOnHXzhF8gAhvXlaAxMf4pjoAKwOp2XAOXUwj+nToiLmnMa8S19NEIi221vhXiOogZJITfMen0jm3j7U6r6Jiq0nw+Pt0nOLr7HGhvqwZ1/d69aAhG56O0u8M607PFHY8Hs31H4pNfo1c6NOBc6QQ1eOaunCgnarTyw5fEyuYmvovD8x9B5aNptWzpJlkPrWCMXGuNgcbFmxUlA/sqIr8Z+ktaxkX7dGihIVpn6Z2XAX61uPKFAGdZg==
X-MS-Exchange-AntiSpam-MessageData: RWwV8EbazPKOihORxdIsYIjBZz4igjakbLMrnTXPUjOnaowbl20Np8OpxRsYDp9sNWUZnvBQp3bVyeLgm1INnbdQd8vzlP4YOwFRbnUlHdOpkyimsx+hm8dOBCysPWHYLVM8L0Z9pr047KHwX1Erk4yHv/ve6N3SaR4XfOt1wzg=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc795018-e570-46e2-1938-08d7ca840101
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:00:59.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0TSVoGxSMfcdVH9cl0euME1bB1XGyuISWPbAsdOVHO4r0Ryd7XnIVX3EHh6SG8JiRS0RP38GK0AstRVUfy4eWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5991
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 10:45:08AM -0400, Andrew Boyer wrote:
> Hello Leon,
> I understand that we are not to create new providers that use environment variables to control locking behavior. The ‘new’ way to do it is to use thread domains and parent domains.
>
> However, even mlx5 still uses the env var exclusively to control lockless behavior for CQs. Do you have anything in mind for how to extend thread_domains or some other part of the API to cover the CQ case?

Which parameter did you have in mind?
I would say that all those parameters are coming from pre-rdma-core era.

Doesn't this commit do what you are asking?
https://github.com/linux-rdma/rdma-core/commit/0dbde57c59d2983e848c3dbd9ae93eaf8e7b9405

Thanks

>
> Thank you,
> Andrew
>
