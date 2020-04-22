Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB41B506D
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2020 00:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDVWjg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Apr 2020 18:39:36 -0400
Received: from mail-eopbgr50059.outbound.protection.outlook.com ([40.107.5.59]:62374
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725968AbgDVWjf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Apr 2020 18:39:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd+DZj6lKF+YZuyjL8ZN5x3fynDMZn/eFokQ1a4zNFkgVaXxQtGsPuMa47rluhJnnMtBOQcaUdvqQnlTWngjov8AlvpYKrb1JcseK8YOMnHe+NmtxT+7JQo5sHBW0Q5oLmRJTqxih3onlvKDL//nckTXuPswEA9w6v0Y/+PvNV89GxYGu4MwlDgIPtERcH0pZcCfYjttS3/W/tbbQWZYmc93r9+SFBJ1U8krUNQgG09KlS63yyOzn6Z/vha4DO9zGdZ3SNSWCV4Dm+5wEtfmfH0v8DM42ZS0s/r3tvY2tdhyGMEyi2/s8nY4n2Z9C1hb4M7GKdo2qm1r7UJKcaQRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjWWA4T+RtgQPCXfqLNJHvWak0hPaGD7WVKcamttDs=;
 b=Mq3xq7Kvpq/ony7Lv55y6EN7uWfR9Ssi+ydZHY5nciWToTBke0PxRUyizZAv6iWM+zDZU4Sfj0MQebFZH8u/nT44VD5LKXqDggIWK8OZRirLzWADsy5PQvd0b4qZlljo4dRI+/1VCSJfyyPA/KPuOtwsVI+ZsE5mbIoDeDnNo3qBlVGh9zkhhyNtYWoSUHURaclbzpPQPG2bOh8YwMKtDLdIlPeTXvo8sfQkMlikeCwu1M0T0Rci1k0MLKmnZ25Z3jGFWVpKxgZSppLdPSwcrH0GaVz35sDgPIr5jz3cMqV+BK9XIJ8iCFdooFKkh5UtsSOAwSIFZjo6KGUnZM46oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVjWWA4T+RtgQPCXfqLNJHvWak0hPaGD7WVKcamttDs=;
 b=iok8xrjnQb8lkbc5zJGAQ9RlDPwIeZq3rctRhwnLdLbldSx1h5bwSBdFO2UF6LiJuvhGJeb1JWHU9I6+N9BKGlGBVJ9f/AR6D5p/c+eLyxcBDz1GVDWwbxhNt95zvXCI6BH9FhCIRQZBia2wQQlKGA180sZsIBlTeK/RGBu77v0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5713.eurprd05.prod.outlook.com (2603:10a6:208:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Wed, 22 Apr
 2020 22:39:30 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 22:39:29 +0000
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To:     James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org,
        sagi@grimberg.me, martin.petersen@oracle.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
Date:   Thu, 23 Apr 2020 01:39:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::7) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by FR2P281CA0020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 22:39:28 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f0d82e7-adf1-4563-a48e-08d7e70e0516
X-MS-TrafficTypeDiagnostic: AM0PR05MB5713:|AM0PR05MB5713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5713E72938CA5305BB38CFE6B6D20@AM0PR05MB5713.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(316002)(8936002)(36756003)(16576012)(110136005)(66946007)(31696002)(66556008)(26005)(4326008)(6486002)(31686004)(66476007)(956004)(2616005)(478600001)(186003)(16526019)(2906002)(107886003)(81156014)(8676002)(5660300002)(86362001)(53546011)(52116002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjh589nqeXzEUYPqZpdozLtoD8YA6t/vfdlsGP17tdGDN09PLhV1Q1TwCEJ5Kcl7ryRqD5nEb58usiqz6L3lmnnue7h3KNmbTNRi5O708bsuBAHvOh9TmuhWK0Jygof9XxvB9sw+YGYWJsdlwYOCsmRl1aFO63WJhOMrYD/NKiEntam/mav1XDsQgI17FeBVnx1VJF6faC+GqdrDThWTgJlQ4qt3zC+E87b616E4Uib02ukuPjE9OF+0DgxpJpVN3i35rnY0/h2XTeBJRs+r/qpGaRFWSiX0Hv9Qy05MoOGySnDu8+NRQ4ieuVbZ3dCQyGwFVApdB8dkxICQsjpd+johaQ8RWkpqgETqymQCLvPO2ZGM551WxkQHMaBXes4U3f4aTBrxhEGAqZ5xC9d+QdkPsj49Y3hFw+mNf/zDN3FDhgbmaSQ3cNY2o+gdj9nI
X-MS-Exchange-AntiSpam-MessageData: x+MOvEZYUpd2RJ6+1Hb7LyihrVaE7Fb3qScTN9dokZye4npyJtKJMGlOByN+FqxJtvXWOIC2dDlj4dy6I+eiE5ChXHpTJBV49LpUZn/sofW/4iKvbdH9VR0MaHsrx621LvK6C7pZPVBLepFvTrBMW9vm6FV3q49o2MpvrgM/g/qpTSdDNpDsAxTFynVXYPyKWh2stzdA0K2Kee721HMFPNyCJI4OUIEiuHEg+oiJMffK8su1O6LBEuj8u1CF3Zhm1geHYcEmUuKX1xyVodwjGKVm5Lsu3ikksBfO+APsxzXOLZM0QD9lR5DyKjRonAxQN7EXM2L0OvRzAs4LAXCikIUBL+OZStEioyyxvVIlu4L0+HpP63X66eCVdWGx37mfeWNeJyl4jqocdhWtqYlOvEU4JNa4tsDBTthBFxsMZDvvcIzH/CUX/ukABKKL5WHjeo/55a/POtksaXd3boibl/C992e3bheowwxLRjx6xusgNbvJ+y8jA06adkbOrAvzl9XG77liVFUGHjF7lC+VOUfz7XNchrkhXsmyfyWbaxnw1H36+h0Vq57WS9Bih12svbwQA2brFljsJwF83ZuMlCQJj5Ny5dxypsheRpQuixQhzwpyZVoTqnxyDt/SL6eeTT2nain5cnX/Vti5Bl4mo+b/XY5vNqmHiS1xnXdsOM/JBX1mifV8NADxKCStT0rSbJkmSlwFhOYgDL7vhM/rSgBRWvuPg1YXbjOjFYz76x/zuXd3svCR/eGlIVYbMy7RUa/3uLDvU7Exa2AswVCJf04fIzkT0C+UVtiEx6+N4BcZg3SHGxPC/NNvvGWKCc7x
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0d82e7-adf1-4563-a48e-08d7e70e0516
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:39:29.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Lx3VOwuNkjb0Q8aQWsr4EQja98O589QGIXXpaRcDzBbfcgPBfd40klLt0VTCpa4sSj6BAaYVT7vv9QRcmNkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5713
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/23/2020 1:24 AM, James Smart wrote:
> On 4/22/2020 3:07 PM, Max Gurtovoy wrote:
>>
>> On 4/21/2020 6:17 PM, Christoph Hellwig wrote:
>>> On Fri, Mar 27, 2020 at 08:15:33PM +0300, Max Gurtovoy wrote:
>>>> From: Israel Rukshin <israelr@mellanox.com>
>>>>
>>>> Preparation for adding metadata (T10-PI) over fabric support. This 
>>>> will
>>>> allow end-to-end protection information passthrough and validation for
>>>> NVMe over Fabric.
>>> So actually - for PCIe we enable PI by default.  Not sure why RDMA 
>>> would
>>> be any different?  If we have a switch to turn it off we probably want
>>> it work similar (can't be the same due to the lack of connect) for PCIe
>>> as well.
>>
>> For PCI we use a format command to configure metadata. In fabrics we 
>> can choose doing it in the connect command and we can also choose to 
>> have "protected" controllers and "non-protected" controllers.
>>
>> I don't think it's all or nothing case, and configuration using 
>> nvme-cli (or other tool) seems reasonable and flexible.
>
> I think you need to change this to "some fabrics".
>
> With FC, we don't do anything in connect. The transport passes 
> attributes on what it can do for PI support, including: passing 
> through metadata (no checks); checking of metadata (normal); 
> generation/strip of metadata on the wire (meaning OS does not have to 
> have a metadata buffer), and so on.  Enablement is just like pci - 
> format the ns, then match up the attribute with the behavior. There is 
> no such thing as protected and non-protected controllers.  There's 
> either a ns that has metadata or not. If metadata and the attributes 
> of the transport can't support it, the ns is inaccessible.
>
> I understand why you are describing it as you are, but I'm a bit 
> concerned about the creation of things that aren't comprehended in the 
> standards at all right now (protected vs non-protected controllers). 
> This affects how multipath configures as well.

it's a bit late for me now so I probably wrote non standard sentence above.

BUT what I meant to say is I would like to give the user an option to 
decide whether use E2E protection or not (of course a controller can 
control protected and non-protected namespaces :) )

AFAIK, there is no option to format a ns in NVMf (at least for RDMA 
there is only 1 lbaf exposed by the target) so i'm not sure how exactly 
this will work.

We are doing all or nothing approach in iSER for T10 and I prefer not to 
do the same mistake for NVMf as well.

When NVMe/FC will support metadata in Linux we'll be able to adjust the 
code and the pi_enable according to HBA cap or any other logic that will 
fit.

>
> -- james
>
>
