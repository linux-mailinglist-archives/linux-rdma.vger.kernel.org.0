Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0E1D6788
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2020 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgEQKvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 06:51:52 -0400
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:36192
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727829AbgEQKvv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 May 2020 06:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlTQJFtcmlaqq9195WOlO9/DnlwBBA5km/jaxu524nAEtS3UUGnFgA5+uMbJA7Eo//ntLYKTWrfIas/3HYxrcbxgUGpPcZgeIug5R7WSVPe1A/PjtjIHhordcZ3sRc38571H8/oHuNIjVZDlHz5Y2Kh5Tk+Tw9jAwYGJanv/y7pyDx8shm2Boi6slybWwra0JkwKh6VvpLFG5VacGbuav3cMQlxwMsp0pr1srdhglqLX6/JttHW4Zxt8sCxHvxm24SKACHc8el6+9tftihigHasTONyNfocm7p05AWMWXSkP9mSsCKf6kKe0R2b6kpjr+jmXmRaZXTWSQ9b4VNe08g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yRmr34P1bRDilmRo5ptFy1GhS/xnd9HT/lMLW/Y8Wo=;
 b=eRELRVO/BCpwC8DFZgpiT/nOrc/vOoxI9Fadv5+H9jDhNkQofIgi+ZT0/6PPzImun5Mu+LMz6R66ABsEZlSqM3qHwWn200Wt9Z37IrGuZKToNacQzvVV93kq6zt8U7CC3u0FUouinzo4b675sm6ArTk6alz2FCV7bCplBxLxzL5k2yhlHhrHlc6yNVjwqqUM3KuJtimfngy6T2MLxnNdDoE8l1Y+ngzMgRpX4PudFulRprGjNddi3rhZxXUGvdD6gtPDT+liGrcoDCuMXUoxY9Qjj43ZRzP3bXKYYUV259qwRdm1+GFikRrolm6MpmsNtrV8v+BYKwwidYG6rous5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yRmr34P1bRDilmRo5ptFy1GhS/xnd9HT/lMLW/Y8Wo=;
 b=f6I9OWCQ5HCptQ3beX+qVbhjjrbHfp19zhjZuUS27BO8igAgFnogFfuwQ9yURoZzO9f6LTBe1gxHe34ncJXCKtd/tztxpzv83D7JWW0I5Kvt9TFMW7UaktQUM7Bz4enaJM6PsZ9oelOXNPIXR85ZghLchz9KdfEchQMful3yQd4=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4193.eurprd05.prod.outlook.com (2603:10a6:208:60::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sun, 17 May
 2020 10:51:48 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.3000.022; Sun, 17 May 2020
 10:51:48 +0000
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     Sagi Grimberg <sagi@grimberg.me>, Tom Talpey <tom@talpey.com>,
        santosh.shilimkar@oracle.com,
        Aron Silverton <aron.silverton@oracle.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
 <479add48-6fdb-f925-c3b9-699c6aa4cfbf@grimberg.me>
 <0ea6349f-1915-3493-3bd7-0bc8086c5b66@oracle.com>
 <75f2cbe4-3a62-9b0e-93c7-fb076bf318bf@talpey.com>
 <53ac195c-dccd-3d30-9e11-f1389dc8332d@grimberg.me>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3e4c0d12-d0f9-87f4-a256-ebe7d881de08@mellanox.com>
Date:   Sun, 17 May 2020 13:51:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <53ac195c-dccd-3d30-9e11-f1389dc8332d@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::37) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM0P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Sun, 17 May 2020 10:51:46 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d4973cb-147b-4f27-7962-08d7fa504c38
X-MS-TrafficTypeDiagnostic: AM0PR05MB4193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4193C97F5F1CA5DCA3B6C3E9B6BB0@AM0PR05MB4193.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 040655413E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7LsBwwrtjcrS/xY+ZDlK/TB6FZclX+w4qE0T7pMO9j5pWyCGHETyBuNKqnanMwXv1NlwGr4zUlHScWsc3Q7onOjJnfP674hzBdpYwt1AUMAhnBn0vTp7AuLGyLv46XBfFRME6jjIu2Nwl1hyU+VuUmKNqSL12pBXtz/qUd2nMuzpKxTAMKU22HzFwEPblxYn+eNb8UF0GZ2kGulk432LnGKSWrSGQfYlDDXLxeTfw2bvd5U4DYLso9wmt4cevfP4rwPdSPBRHuu+D8hhwG/SKbnxl1WOic2IYJW5Y02fJ91gustbQcF2a3fjQ0JKadqbCM8qnZHsxTlYeEqQlpHwifPTrvA/Ydl1VUi1VAU8gxudGYTF3ZA+ef965XZILuusfQV2MzzK58EqWfLVsiw2uwzR22jTZpbrpgDGXKgmn1umIsLIfcMmfPIW2MH4BK4xDDo+HXRsbxaoWbtqR3pkDYomOQ4FM/spBEQbHpmDLB72fYETyMBaaEA1EjqBJjp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(8676002)(36756003)(86362001)(52116002)(66946007)(66476007)(66556008)(8936002)(107886003)(4744005)(53546011)(316002)(31686004)(16576012)(478600001)(26005)(6486002)(31696002)(5660300002)(956004)(2616005)(16526019)(186003)(2906002)(4326008)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lc266e5nZbVBdi7nmmrN3ZPmvvMoxIvFylNmhGaSxzAxqEioAeWW9Yi6wNeHSBb5LBaYAWA+VS2kYejNaJGJu0CmnrUku6GAAC/2T3Q07etyZcxfPPhBYRN2E+BTq/xvRSKkAgtmIbfF8UM4C/oIbYsIR8Anr8RnOinlldOBXmSD1T+s4khDUxTiAw+f8J/2iF0k5DhNU61ymXKv7VhQkKQSyeJEPHMq767yJKTe2e1Otcfoid0vNVQrY+5YXocYCn1CnmSPxM1rPqwl1idsk8HmWSOzN8AnO7pAJF4BB2wHO7iOTDEN/gnPe8/FEFOg6fArgkhMqETeC492iFDJb9/U9ij7ooVePNUlidD/04OAPrHbq4mVos2ehiDRAXCBrnzbyrlGX2b+6ntLNqOf0KK38tVoWfMgCpVS9xMi0ZoL+hruBFx3d9rROiJnGOpx1yfBTW+ru/sNCujNr71X1oLUdg6QVhGXjQx1KQxsv6viZYL1XrbQfrdA2xiaFm7Q
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4973cb-147b-4f27-7962-08d7fa504c38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2020 10:51:48.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mc/aWIcPnpkpYpgwwvePaE9XBbZBycJRw4jcEktCcF99GjLcxqrC2NDRL5EKJLFg4zAPe/XaWYR1TOQzpO53/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4193
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/15/2020 9:59 PM, Sagi Grimberg wrote:
>
>> It's not only the fmr_pools. The FMR API operates on a page granularity,
>> so a sub-page registration, or a non-page-aligned one, ends up exposing
>> data outside the buffer. This is done silently, and is a significant
>> vulnerability for most upper layers.
>
> You're right Tom, I forgot about that...
> I guess I'd vote to remove it altogether then...

Santosh,

I don't really understand the mechanism you use from user/kernel 
regarding the registration.

But I saw you use wait_event and wait for completing the 
FRWR/INVALIDATION. For sure this is not optimal.

But can't really say what is the bottleneck in your case.

Can you share the numbers you get for FMR/FRWR benchmarks ?

