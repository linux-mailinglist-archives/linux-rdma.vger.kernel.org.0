Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613EBE0E60
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Oct 2019 00:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbfJVWwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 18:52:37 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:14060
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731850AbfJVWwh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 18:52:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsoBrpC1G/j0BY9l8pOGNGzV7MU5+AyrDGL+iubTDQa9LdiiSJnmVPeTs6p6jDZ4wFiOceaZZ2/LkJpOBJiF+2nB9PqSMasAssTFeeJ4VdF0G1vR0KRSzUExfrMloBAOnPgVhGvPL9w6St9z+7bH8Zr0xJBjV9n64rua3Iiyme0TDzEGXdrAKtD0qXGhSpQokCt4h/7rwM3a+VQVw9fZegiKvIT4IUjpIRqmz+Dls8Xrk6qps4tHre08bjpUkUW4/sDaU3j9YUa9fC0bpi/itjAJMxMnBVhTzcx6H3n1tZNyYRXveuMabhbN5aMjnU5PGJZahy3w9ddSv8cIuwMeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEYpimMGmPIpZLS+l0rEM5Y076zjNvwjGozb7fRYLdM=;
 b=A05m9KRYVXTDw6DxN4TnsWGexoSo1Gwoql2/GBzFlGQCHXXA8o5gJizewwkJmKSP1RzHWSDH74pUTswGxB1qclTI/rBVDZsIBYAjhSDLhjMVM++Khf+6Cvlq8//r37Nl4SHnETQ/ezzvuouT7rhNPGYAjjOptUHZ6QnHMfVzCrIDEWq1G3qzFI02uy2THS8JDOgc+XByn3QblBr8b3UzccppUbU38tGadyis/W99izipmZqHnP6By5XSLFxwQUgf8+1KNAq0JSSDRp+RnhVLolDTa8DfpLDEk/E0keuFI/yDKUUhxX5bey86aBlyy43R9+YaDA8VK6YZAvmP9b7Hxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=infradead.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEYpimMGmPIpZLS+l0rEM5Y076zjNvwjGozb7fRYLdM=;
 b=Y8wEkpHuSpTsM2GHWtBzej6/guRxacIUSNQojqi92gLDoq7Y7XL0OSbiNcAmQKdEiJ6dxnC38UeUIJ5NNHoFjIXvfHL22LuLmag2mYNJZw5zvmgH5XAlLC6/K7zL6iFn8eD8+7mv7dcJZj447xly7slIuV3W4KIjMMjVv6ucTp0=
Received: from AM0PR05CA0048.eurprd05.prod.outlook.com (2603:10a6:208:be::25)
 by VI1PR05MB5357.eurprd05.prod.outlook.com (2603:10a6:803:b0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.28; Tue, 22 Oct
 2019 22:51:52 +0000
Received: from AM5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM0PR05CA0048.outlook.office365.com
 (2603:10a6:208:be::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Tue, 22 Oct 2019 22:51:52 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT029.mail.protection.outlook.com (10.152.16.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2367.23 via Frontend Transport; Tue, 22 Oct 2019 22:51:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 23 Oct 2019 01:51:51
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 23 Oct 2019 01:51:51 +0300
Received: from [172.16.0.15] (172.16.0.15) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 23 Oct 2019 01:48:32
 +0300
Subject: Re: [PATCH 00/12] infiniband kernel-doc fixes & driver-api/ chapter
To:     Jason Gunthorpe <jgg@ziepe.ca>, <rd.dunlab@gmail.com>
CC:     <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        <linux-doc@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
References: <20191010035239.532908118@gmail.com>
 <20191022184109.GA2155@ziepe.ca>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <3f234558-f894-9dcd-da88-120fe4e15e6e@mellanox.com>
Date:   Wed, 23 Oct 2019 01:51:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022184109.GA2155@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.16.0.15]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(199004)(189003)(50466002)(316002)(36906005)(31696002)(76176011)(110136005)(2486003)(8676002)(6246003)(54906003)(86362001)(229853002)(53546011)(4326008)(26005)(106002)(16526019)(186003)(81166006)(23676004)(58126008)(478600001)(305945005)(81156014)(70586007)(126002)(3846002)(36756003)(70206006)(486006)(2870700001)(14444005)(65806001)(5660300002)(8936002)(6116002)(336012)(2906002)(446003)(2616005)(11346002)(16576012)(476003)(356004)(6666004)(47776003)(31686004)(65956001)(7736002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5357;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf779b6-517e-4b3d-5212-08d757426e1e
X-MS-TrafficTypeDiagnostic: VI1PR05MB5357:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5357180E0AE19925D41A087EB6680@VI1PR05MB5357.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfvEbLIcjHiUquVIPnwI00IerxCFrCyrKZtbikaepvuugrjZ8ISuotwvOiw3Hy+7MteQ6GA96itjrBMHe/g2n4cvDLdGEYkq03Xm6LvtLTC2y3vFGVWvc5Z+f3CaJtq2JgyTrybyzEpfDyw+6Cx0QWxayz48JVJm5FUj7pYQfDeIh/cPLRxputwhDRY0jEUxHi2oATdln8UHp33dACdbJOJV+vlo4b7mSqohHRkw3UFnrmGpovhuMZapPuFvsCUK79vxsADh84Z0Ylq2j7SV9PNF+hfzZ5WQ9i9USL6vy0D9GNJcQwJVWf2HUELH5V+4/jeSBxW//A7aXhTbC1QOvCY1ekvb6VlolfL6rNdUSQjvrNOzGgTdZnIwLDluA8B9zRAhMegdZRgfglLpQBVmFS1SNO9/klCbdB98RiulGcE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 22:51:52.1241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf779b6-517e-4b3d-5212-08d757426e1e
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5357
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/22/2019 9:41 PM, Jason Gunthorpe wrote:
> On Wed, Oct 09, 2019 at 08:52:39PM -0700, rd.dunlab@gmail.com wrote:
>> This patch series cleans up lots of kernel-doc in drivers/infiniband/
>> and then adds an infiniband.rst file.
>>
>> It also changes a few instances of non-exported functions from kernel-doc
>> notation back to non-kernel-doc comments.
>>
>> There are still a few kernel-doc and Sphinx warnings that I don't know how
>> to resolve:
>>
>>    ../drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'

@all_list:           entry in the entire fastreg descriptors list

or

@all_list:           entry in the whole fastreg descriptors list

>>    ../drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
@all_list:                list of all fastreg descriptors for the connection
> Maybe Max can help?
>
>>    ../drivers/infiniband/core/verbs.c:2510: WARNING: Unexpected indentation.
>>    ../drivers/infiniband/core/verbs.c:2512: WARNING: Block quote ends without a blank line; unexpected unindent.
>>    ../drivers/infiniband/core/verbs.c:2544: WARNING: Unexpected indentation.
> I don't know what to make of these either.
>
> Anyhow, it is an overall improvement, so I applied everything but
>
> [05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h kernel-doc notation
>
> pending some discussion.
>
> Thanks,
> Jason
