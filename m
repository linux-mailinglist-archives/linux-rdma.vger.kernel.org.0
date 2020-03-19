Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1FC18B1D2
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 11:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCSKzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Mar 2020 06:55:52 -0400
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:30062
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbgCSKzw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Mar 2020 06:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt1DUbi/g2zlgri1jF0UE/h566lz6f6cEL1heiBkTHzfw/IPVTjrqPlKkkNHJ9qP61ilsoQt5OQgFcPDKpP/QaMTZNYy/HP4JX8vPb2kP56j2KKUqJnScpWHVPxdJJFg8wiQqjL/9fFaCXrPteIdHc92QKaLp4UdNNfz9pWGjl/JzyN9PunpeV767Pta43Qnp20aXqcM8vJ7pgVTNAt7TeNVe7Bi6jgZEN1wcVjKmtWk58Sp9JNBmM4g4AO6YVxAXMtXmQL6NY8R1+jUggjUKkhti6mdqaYwYk7FxwvtANvss0JKtMmuHZqdfuGJhLDh3hd9u5/k8SH7s/Qx3v+wYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRCCvzP5xWZTdDebJzjcF/HMKdpD3jm0Y5iRSSL4Py4=;
 b=ckto+f3uQu3icBMx7og1173wR/0ojKRJqs8Dw3ZHVrBUmLoQQOpDnYTNWHyfjVGjSp8U3mq+Y3gmdqCqnuNR51lH3JXovTkFn1AbWhKfAQIxe/tYFc4NZw7GxBHTLSAS/tAHKBmudg6JYnh6HshPzAjf+B5WmIxoyZZ1OtxUWEZ3DZgafm4zdyE2EACaW9q2dnmu4BeCb23agdlybgcBtP/SWs97jIY3WA4U4gQs7VUkn3yZBuDMlaw6xtwKkEqPF94fG4Rjx84yPytmHlUlSQZOkqKHoLBSeWpuCuCmCshgqCTZGH8ap73B4spVycp0lP8hQcZ9hunxHko3qo3Ozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRCCvzP5xWZTdDebJzjcF/HMKdpD3jm0Y5iRSSL4Py4=;
 b=Ar4MVyhvUcPJmlAxuh0hqFAgwuT6vwzoUME6ZFDAJ5RLQa83laeqfWAKFeC9GRf/1+Q9t/hmzRwzLsh8ifY+E7MIZwend1/NifKNfCHwjjM01W8DUx8UWvLGYr7ytIG70k9tQ4J60fc8vIFYmUF3gud5/ZTErOMurBpqRAkJpk4=
Received: from VI1PR07CA0189.eurprd07.prod.outlook.com (2603:10a6:802:3f::13)
 by DB7PR05MB5464.eurprd05.prod.outlook.com (2603:10a6:10:58::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Thu, 19 Mar
 2020 10:55:46 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:802:3f:cafe::7a) by VI1PR07CA0189.outlook.office365.com
 (2603:10a6:802:3f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.10 via Frontend
 Transport; Thu, 19 Mar 2020 10:55:46 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Thu, 19 Mar 2020 10:55:45 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 19 Mar 2020 12:55:44
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 19 Mar 2020 12:55:44 +0200
Received: from [172.27.15.129] (172.27.15.129) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 19 Mar 2020 12:55:17
 +0200
Subject: Re: [PATCH v2 2/5] nvmet-rdma: add srq pointer to rdma_cmd
To:     Leon Romanovsky <leonro@mellanox.com>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
        <loberman@redhat.com>, <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <kbusch@kernel.org>,
        <dledford@redhat.com>, <idanb@mellanox.com>,
        <shlomin@mellanox.com>, <oren@mellanox.com>,
        <vladimirk@mellanox.com>, <rgirase@redhat.com>
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-3-maxg@mellanox.com>
 <20200318233258.GR13183@mellanox.com>
 <1a79f626-c358-2941-4e8e-492f5f7de133@mellanox.com>
 <20200319091454.GN126814@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f08af9c6-b2bf-8036-0e5a-70b52e5ed168@mellanox.com>
Date:   Thu, 19 Mar 2020 12:55:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319091454.GN126814@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.27.15.129]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(199004)(46966005)(70206006)(8936002)(16526019)(8676002)(6636002)(316002)(356004)(86362001)(70586007)(5660300002)(186003)(37006003)(31686004)(54906003)(53546011)(47076004)(4326008)(966005)(6862004)(81156014)(31696002)(81166006)(16576012)(36906005)(26005)(36756003)(336012)(2906002)(2616005)(478600001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5464;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0203f30b-bc74-46c8-4836-08d7cbf413d5
X-MS-TrafficTypeDiagnostic: DB7PR05MB5464:
X-Microsoft-Antispam-PRVS: <DB7PR05MB5464C880ADCAF26B8E9B285EB6F40@DB7PR05MB5464.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0347410860
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4UhDafdviqrQQ+byYEMwj9TM7ILvcI0WVU0AZKd+bVt5Jeuc09jAuV1sswBvyopaOR+ia/M0DOVWJfKKMnMVVFhjZFLn2Ba+8JWzOxPG/hQg30WcmDt9ig2g2ie/1AxiCUZyVdtVvBA0bsZRJueGWDa7+bENgmmj26NPIHAaoymR4W5OyqjP8ZmcyYfv/R/hDmfTWsoZdjXjWeF9z0FJgK+wbNvbX8BR1+DqzIYx2+uuR/ZR7pMB9iToSvN9bTXCoshemrwIR9X22m7K8/zfh6kr35YAdLFash+okaSgu/Zd0e2mI18R4tPZYtG7w0zqC3zqENW1Fo3FMoWfDYSmf0wHdOv1fME1TyxqJbhhu42T+cOaPKAevth+nil62144yk4fIg2vueVw6secPn+wxaUfTdS0jNV8kiIJyHKXhm3LnfhKh3Hq0AYR2MKme1xkDg9b+Q6R2jQ3ugiCW7CpTW35HCrXT5d5dnwD9bKKz8LGLIulgM0nBbSc0QFhhK3gE7P5UkcpvTdaxtafuOt1wbj1zKQst5ZYF3umdq4592/3egxDJ5hAnQEiRdoElrclavb1WOmJTR+bqhiWRA+Z1Ajc04CD2NllAJY/5573SMPi4j2o2r7QMR1tUszsiJl
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2020 10:55:45.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0203f30b-bc74-46c8-4836-08d7cbf413d5
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5464
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 3/19/2020 11:14 AM, Leon Romanovsky wrote:
> On Thu, Mar 19, 2020 at 10:48:22AM +0200, Max Gurtovoy wrote:
>> On 3/19/2020 1:32 AM, Jason Gunthorpe wrote:
>>> On Wed, Mar 18, 2020 at 05:02:54PM +0200, Max Gurtovoy wrote:
>>>> This is a preparetion patch for the SRQ per completion vector feature.
>>>>
>>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>>> ---
>>>>    drivers/nvme/target/rdma.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>> Max, how are you sending these emails, and why don't they thread
>>> properly on patchworks:
>>>
>>> https://patchwork.kernel.org/project/linux-rdma/list/?series=258271
>>>
>>> This patch is missing from the series
>>>
>>> v1 had the same issue
>>>
>>> Very strange. Can you fix it?
>> I'm using "git send-email".
>>
>> Should I use some special flags or CC another email for it ?
>>
>> How do you suggest sending patches so we'll see it on patchworks ?
> It can be related to your SMTP relay, I see that you are sending
> patches through labmailer, and it is known as unreliable. Use the
> same SMTP server as you are using to send emails.

I'll use it in V3.

Thanks.


>
> Thanks
>
>>> Jason
