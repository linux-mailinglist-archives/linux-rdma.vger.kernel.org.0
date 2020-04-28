Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FB61BB9AB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2020 11:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgD1JSg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Apr 2020 05:18:36 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:53667
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbgD1JSg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Apr 2020 05:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxEa8r/YhMo1O7Wrg563EqpNk7pQv3izmCCcEdFhpQR+ylj5EUIS+QIh/25pSafpm9ml61/xDXAZj3ckg1irE9MivPs89rymFL/qoqR9tV3lc+DRRQXuDrGBx3hKinGVnI3SMSesAY+f43VqK1XFov7PW9PMSFViy86Gzx/VbDQZ+mMWtNeqJo625rL6nompnzz4DFF6Md5oLMtx36uhgR+uV3f47tOxwyFP3HB/ZCKWeNJwWmrOdFcb+psQozHTeCvUkafHBXXxPear8E1eWatQl6KgB2LFzRLCIPpgGjYHkAjV4ktK7OUB2Mk2+DV6dk55QrrEwqoAhgr/eRshFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkoML9Rlbuwlfy9jGctZNMToD60heGERIGCr5ZnkEz0=;
 b=Og0qXG5FGvla7xZ+Wt3Qxa3efexsjHqe136o3z6etKa0ks7xdp0f9WhgOrXDHZhjaCGG35vBVz6EtQd6YEFsy9PiG5hJ2KiJZLO3J/1KqZXaTwWP1bQ6ub6XIXW/okvHxEe9ayGsv+UP1dYDqfjFe96yy8W4JvEW8qZJJO3ZPuPxDYUCoN356QtigHPsxm5pBggF4A8oj9ZmlNAjttNAIGxaf7axAdlPZNcoY51SE800l+Gu/SuvlpsxzlTaQfZ2sDjtqXIVd0ce2QBV7hW0Ff6AcFeAj2lc7aFFdodOJqAQ67hN1z1BtCB8vS/3HeKGyvTx+/9lEOMIC3BU/jo9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkoML9Rlbuwlfy9jGctZNMToD60heGERIGCr5ZnkEz0=;
 b=l8jhvun1XAkw3c6REXPc99KwTSpFopUcIGnpp4PLAVusfW+dKpo9vm+iEY1vx1Eno6A+83xPes+SHrRY8QusfG1wO+337n0inaGm3BDUyGa392IbLaTGETKYoVsMiKKrVOYcAmCRxhmJPSKS24wfLdqOxuJY8NvsF8xPGdq07jM=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5028.eurprd05.prod.outlook.com (2603:10a6:208:c9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 09:18:32 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Tue, 28 Apr 2020
 09:18:32 +0000
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
 <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
 <20200423055447.GB9486@lst.de>
 <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com>
 <20200424070647.GB24059@lst.de>
 <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com>
 <20200427060411.GA16186@lst.de>
 <2c6f172a-7923-6531-8d19-f8c496964b9d@mellanox.com>
 <20200427135427.GA2835@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <b92c4117-8598-5a50-a32c-94d5c581839f@mellanox.com>
Date:   Tue, 28 Apr 2020 12:18:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200427135427.GA2835@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::16) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM4PR0101CA0048.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 09:18:30 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91aff191-69af-4129-082e-08d7eb551f01
X-MS-TrafficTypeDiagnostic: AM0PR05MB5028:|AM0PR05MB5028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5028FAEBA9999ED3BF6E55A5B6AC0@AM0PR05MB5028.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(316002)(16526019)(31686004)(107886003)(6486002)(5660300002)(31696002)(6666004)(36756003)(86362001)(186003)(52116002)(2906002)(478600001)(2616005)(16576012)(26005)(956004)(81156014)(4326008)(66946007)(4744005)(66476007)(66556008)(53546011)(8676002)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCdO/vy43UPGevKrY1QX5USB6AiX33Dl0dF5U6j5WeedaRTYo633h2fmPrTkXi1M/WQIQOxn5GxA3ivrFHoF6iWXWrVmjDSeAXzLe/AU4pH1hnkhYrMXtbszqTH1P7y3I5fYqLTK8Rtgq9e8IL9+ojiglQM8ucB6bbRxjYWrthW+l17CuWfH1A8UIncRT0LfCM2V4GM/OihQ6uW0E8hBbu/CWAF18r0OpJclI7OG2wjR2C6WyCBi3ZdVjVTBilKEfZnxt4fsAD7wyOzwycRzvm8Cz4utRSu4rFZooMOxsR5A5c2dme3Nkn7u6XTRtU+9+EZgbbcj/BuWjPEiLAFqWf+LtaNaSWcIy/9C7RkjnfTTjQ32vuaRZv54eWFLB6SIGoI15TiueJAp2+37eGR1tU/3IT+L5eRcTxW3BOrrq9wJ6v1ISHs0uOlOJ/M73Wbo
X-MS-Exchange-AntiSpam-MessageData: V3A6t0B8itNnRwbIXBst4sXnYAKcHraY1fuj2YFz/NUFCwQZkzc6VwhkbjgtKOpfUJDA6YV4UZ/5+0kzQUe/PPx4QOci4FLPEWNmMXvfFzFez+5dAnnt7I/OBRb+BhwJGOkkdKxv76jFpcHHHTn6GNi52b+vdK6OUyGKriV6qx/WLUEqB8XCPen1ZtE+ROWJcHgR4PoNltCDpb9BCvrDgdAFRJ8BOIFkVv1uXddq65OwTWkbc/ypfd9Txo1z6Ef8m+TYzowaveyGRxiE2cuzP8BxdI7h+TEgbieg02EzbHrYiPK5mYn/E3NGA0qRH6/hUOxcR9tsU5cDiE7FHvHwp7dt7XsIXMDPgy6eJOn9vfj/q8dmx4SobZzuanShV6lU6a/pk8BusAoii1EwY2NrEx5zX/EPAbjuRo4LSMBKOVJy1zpfBcsCaCU6J3FNr/HsiOJ80f4E/XKfJIW168FSSnr5VmMl2KS8HQdZOJ35Y6+cNZiK5K4CeTrVkcqZSKui0BI6/9Wk4l+UABplVaZnSXFb/S80IoOK4PMu0mKHbAZSdT+UNDR1TwcSmaxolGtfC0J0iwo9vcq2sjQmoHkrKclChZkZ6by3qLss/ZsI5KIVE8/SKOccjs4i4kQBAZ94pRPixHGjStCQes4WFdZPhfihn1KhaMgjshvPirXmjc56oYNCpwQOVGzRv253y7/y9tloGZCpFkL6aBizVtTqsOmZ5XVVjaN4f7MmOILhOOuKMS6t2JketGO5OInobnEo7TJK3pp5srdhVtrLLObOk0Flc7xV5fRsclGuahSwJn8=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91aff191-69af-4129-082e-08d7eb551f01
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 09:18:32.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQeqo9uuQKYZu08nOf27SVZDPZyzNdqwQ/WG+yGFHRWuEY30WHpLzq4YKGmp9nb6HGRjbnbv3BGAuI+oSXBPDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5028
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/27/2020 4:54 PM, Christoph Hellwig wrote:
> On Mon, Apr 27, 2020 at 04:52:52PM +0300, Max Gurtovoy wrote:
>> but the default format on NVMe pci drives is without metadata and to enable
>> it we do an NVM format command.
> The defaut namespace format is entirely vendor specific for both
> PCIe and Fabrics.  For OEMs that rely on PI the drives will usually
> shipped with a PI-enabled format.

Ok I'll set the controller to be capable in case the HCA is capable and 
then act according to exposed namespace from the target.

It will cost us integrity_mrs (that are expensive) for ConnectX-4 and 
above but I guess we can live with that for now.

