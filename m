Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE64C16AE52
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgBXSHS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 13:07:18 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:51168
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727479AbgBXSHS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 13:07:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF7pmeZ2PqPR/E2zSrLl0TwBersiwbfHPXa5fsUeeMGDlnaLJuGBOZmaXEJ1oPm2R+pcKxm32NEK87KeBzm/yp/iyHAw2PTzPrqiZqpV3juwfBHuYLxgQvqjcxhNn31keKCoujQXrUU32Wl02TSnv/4dtWcEjRnawIWrzXGw+c95RYDPU8QMDdTmpe3ArInZz2PHA40/ns+4uaD/3ISm+djn34mMbIL4ihRs/YB92JwJ99XnGG7Wzy3I6qScWCz5eD0sE9GZVWS0UOCwolPZFZ2/oE3syuz2cQHUnVtBZ6lTwGyuavYGRriOS8g+cbtzxswImoRF17jBcAc9zIWTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k2aP/Qn84sGDB3Fzy8BSv9o37PUTIZRQt/O8ve/MDM=;
 b=SejvWp3L5RHg4rYbw4m6GX3UMm3GLcJslFK/N4Q3tHnny5RKLYQy0SIGwcSAh/+dswuffGzGMMSzD/W5pZcl3FTC03iQUwcg1lahx5/4gJsHJPZ57fxu74HWArcUBjfWoKR4lpByfKsjC6s1bMEht/Er+7TqBlqmP46CQdCm+w7wE1ePXs4EUnCwQkHnGfN18j2xaq55amYhkHAejIwPiJtI7PFq9wk0nq+fgDFuXe9wxI+RGkA1+SjD89jEqUj9AWDh88WVqqkKCCUERIEjQkgu2DKwCnm4Q3r/ki3NONKzeSW/wBPQCowSibSZuRhsvVWoCWUy62T+H7jeHn9Fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5k2aP/Qn84sGDB3Fzy8BSv9o37PUTIZRQt/O8ve/MDM=;
 b=JmKC6rm/mdzK0NdVB97WcMxqbq6HrDGe9/SIHDhDPMZ3J0PiXXF2AWs7HYw5E3OgpmfuZRcMPR6JX7vXmvEI6+eRFVs+X+lRCA3flPvdwNZC2/ySubsbRmrWFkWjZ58kKpkgxh0pSgmsVNqU5EOTO3qHGgD+ZiMR4oP046zxIJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=haimbo@mellanox.com; 
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com (10.170.246.152) by
 HE1PR05MB3163.eurprd05.prod.outlook.com (10.170.241.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 18:07:14 +0000
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f]) by HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f%6]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 18:07:14 +0000
From:   Haim Boozaglo <haimbo@mellanox.com>
Subject: "ibstat -l" displays CA device list in an unsorted order
To:     linux-rdma@vger.kernel.org
Message-ID: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
Date:   Mon, 24 Feb 2020 20:06:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:200:89::16) To HE1PR05MB3259.eurprd05.prod.outlook.com
 (2603:10a6:7:2e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.0.75] (193.47.165.251) by AM4PR0202CA0006.eurprd02.prod.outlook.com (2603:10a6:200:89::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Mon, 24 Feb 2020 18:07:14 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28b8b6b4-90ea-4ad2-9d07-08d7b9546089
X-MS-TrafficTypeDiagnostic: HE1PR05MB3163:
X-Microsoft-Antispam-PRVS: <HE1PR05MB31639BB4C7C01CCE1BAD113AA5EC0@HE1PR05MB3163.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(189003)(199004)(6486002)(16576012)(6916009)(5660300002)(316002)(16526019)(66476007)(186003)(2906002)(478600001)(66556008)(956004)(36756003)(66946007)(26005)(52116002)(6666004)(81166006)(4744005)(2616005)(31696002)(8936002)(8676002)(81156014)(31686004)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3163;H:HE1PR05MB3259.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwk/o5DYmfzdrSMi03uGWUJyRT+nRwsa2BCB85LLs5aV6wGLuQWHmVsrNmW/1X9BLX9WOqLpuOJI0dholasjLmZbYkjlIAFEjXytmeXcvdWiX968MlkeTTNxuIcfl3JjfgeTzDMvf9Ckm4CWMR1a1zGLFbK+hqG8ApDG79HqGRYkqAbym+8Ebk7jU/eSaWNsBh64pWackYe7fyUrRbV8ogs7RUucek9lqkqIta51XogLoWIS+Wcfla8FDIJDZ/InK0WLfmtdOfCdNgHWQj3s6NsFcspphhrtMAsN3q2i8JQ6DBC7Z9Zm0glD3Q5SBizVSe9EIM4Kg4bD675iY+uu0bFfwzWpEoueGoRcbMCzPRRIjjxzjiIgxhLUl1DX1y0K+p2eo8UOfH8ETBZ1QzIGQUD6k0iqVstqL36swqcgxQdTXn4XrBAGw8wltAeCpCKH
X-MS-Exchange-AntiSpam-MessageData: u+1ZwT/U4e6ZqxrA2EfAkmdy/M5FPt0rFC0xIwTcTt5A5tW+iFQAmMqpIXjNdcrTE03I2trjkKg59K5uhi3y8O3mdsh1D8qWebU0SuVzHxoKEx/nmj72C4fUGF1rNqY+iAW4N5RvU2PwOVdQDhnBjw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b8b6b4-90ea-4ad2-9d07-08d7b9546089
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 18:07:14.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w63cSIT91Y1ZksTmwKL3KYpeaFz2RpteDUi93DS8NZ8QHBjTGMl1dsvoc1KzVshvpPYaY0Qrfv8urmRezoZrRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3163
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi all,

When running "ibstat" or "ibstat -l", the output of CA device list
is displayed in an unsorted order.

Before pull request #561, ibstat displayed the CA device list sorted in 
alphabetical order.

The problem is that users expect to have the output sorted in 
alphabetical order and now they get it not as expected (in an unsorted 
order).

Best Regards,
Haim Boozaglo.
