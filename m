Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13051BA56E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 15:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgD0NxB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 09:53:01 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:11733
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727073AbgD0NxA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 09:53:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHJMciY/d+PWIfTu6tvgZnsAnfqea+Mgs2p71HqhlcvZKaERBypoCUuK2YYZ+Kq6sOzKDLif2PEig8nzEFoyJ4AI6yHjLxp1O1SLi5Xs8o06SeJl3LRLGCWg5k0PjUses7IhqJcehhLJuxGyemXLqOKQHrvzl4LVjqDnJAQTooHCHskBKByoE92681/BrcKwlblUYyovH1i9fgqAEV4MJS2p9o2wg8x5TrwGYdZSvo2R3Ds2hG9JYEqyeU3aUlGXv1KRHTvPBobCo6/ntiCAWgpD6dR5Dbt4qiihiug+cr2BO7b3UgADqA5Q4nVvNzbRvpu4FTTNUs4W5A5gdZW7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iSaiElOOiNei5elLBkbTFT+/U3joTtvBkgl7ZEW5Sg=;
 b=Iismh/Bh+4Cs1zlm450YGGl8Br+O+DZcDxBpqyJUXy37vEcm4rOCflAXmBDm8qks9ZgW3IIZWaF5pfUvuclLLIa4zF90iVaKweZjSODbRgAVIzdx/cuaY3MQIbYYQPrtyhVPGG+TlEEq8cLWvGCaTVf7UQwvD9t1hEz1H6N2LBeW/cTiQJaILMluZLIPATJg+FSxGi6vWY4rFVbeP4hHrx6Jta/nHc1U0ELsEWDZi5WXI09qxLZ1myLOSxt+n+DMuzWicg7yd/TCb839sOHPOvmGb4PBcW8PKknr4f222hRnqJoj9O1JUDLKF/O8opCWO745GHjVQcPiRPcUTcYZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iSaiElOOiNei5elLBkbTFT+/U3joTtvBkgl7ZEW5Sg=;
 b=m0FpuKmkuu0q/+G3GxW83AxnR33YoP3+k3u6qboE3QUjVK9i9H6r0w4HgPR2h74GwUjVmAiZGekOYflPXtAeYnQVB8OXqJxtM3dKwW2gHjhFs3mHxpEzNCvCbT8PHayl2GqB4aBuVUvj6E1EMfUugAXb+z0RuEcwAE2axy3LXEk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5025.eurprd05.prod.outlook.com (2603:10a6:208:c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 13:52:57 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 13:52:57 +0000
Subject: Re: [PATCH 05/17] nvme-fabrics: Allow user enabling metadata/T10-PI
 support
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, sagi@grimberg.me, martin.petersen@oracle.com,
        linux-rdma@vger.kernel.org, idanb@mellanox.com, axboe@kernel.dk,
        vladimirk@mellanox.com, oren@mellanox.com, shlomin@mellanox.com,
        israelr@mellanox.com, jgg@mellanox.com
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-7-maxg@mellanox.com> <20200421151747.GA10837@lst.de>
 <54c05d2d-2ea5-bf58-455f-91efa085aa9b@mellanox.com>
 <70f40e49-d9d7-68fe-6a63-a73fabcd146d@gmail.com>
 <172c1860-bebe-04b2-a9ab-2c03c7cfbf18@mellanox.com>
 <20200423055447.GB9486@lst.de>
 <639d6edd-ffa6-f08a-9fa2-047ca97c47ee@mellanox.com>
 <20200424070647.GB24059@lst.de>
 <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com>
 <20200427060411.GA16186@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2c6f172a-7923-6531-8d19-f8c496964b9d@mellanox.com>
Date:   Mon, 27 Apr 2020 16:52:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200427060411.GA16186@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0126.eurprd07.prod.outlook.com
 (2603:10a6:207:8::12) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM3PR07CA0126.eurprd07.prod.outlook.com (2603:10a6:207:8::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.7 via Frontend Transport; Mon, 27 Apr 2020 13:52:54 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e17af611-3145-404b-13ff-08d7eab24a1a
X-MS-TrafficTypeDiagnostic: AM0PR05MB5025:|AM0PR05MB5025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5025A9D0663D9DA443DBBFB3B6AF0@AM0PR05MB5025.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(6916009)(316002)(66946007)(66476007)(16576012)(478600001)(66556008)(26005)(107886003)(36756003)(5660300002)(31696002)(4326008)(52116002)(81156014)(6486002)(8676002)(186003)(86362001)(2906002)(8936002)(31686004)(16526019)(956004)(53546011)(2616005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htv0gW1xn7Wwxz9JaqpfqVWsVh7LusQFqkFmk5XxtKReRwzZud/2uyDvJ4ke514PSq81Grr9cXq3twYOHDZLnBXgykQv/VrMxqWi31CA6jf+dWvgoUTzyvZ8MiBXtD2ldLgSiAxlpSHBMlahB9dgLSLHKZ9qF0K2kEY4Mtya6sBnEUchHMi1fL397WFrft8pt5lGWYyqT72gTd4e699lbPW33TanBpo2IJ0xX9b1EmBPLrnvKxct6ckZWd5DI/XpzOYSQQ6mYjgydxI/cAWW2PELIvD89/vdzRdqPDpuJ4OKdEGOQ7y/0QYAMdGisSEYL7nYIE2XTBVRxpnzTHkcWxTPHLDQB0gQU84K1nFovWfpHnaWR+xIFtdim/H7tjYMMvosH4M/4wrjwmAL7Y+5spmda2f9JgB7QprV7Sf08NilxxT5+WaD65atDGXRcrrK
X-MS-Exchange-AntiSpam-MessageData: 2sX8azS0epajk2GrGARvZFuphK4ePfiMswj5vs7QtutPuf9st29GYfEV//ZL7+M2rrLuoa5x9a/njQSRhRjIiG6/ynIaIcs4dEY5w9YX2W1/Z+ssG8+vbLrkH3147/8GItLBV7D99Kz2bsH6Jp9ORQ3dxMtFQp3ubbycWEJuzUiocyrFNNMEyESjwYTrbjDEsOvmdmV4tA0MgD2bF8vbvy4LlY0hgeBFJ+s/ANPW98scBODsuT/SSDs8+k4w4Uex2cUd6UPghff8+ELDLHlYbzJ3x9VyM10/I2vEpmmfN39NJzLxDti1yLCNBAhlOhNa1IKdMgyY/HX9Qgpj6Pj6NfHpbhUzVf4ix0Kve5vixx0+oJCixoQtqn85tk24voq4A9BOL0LAJOrqL+Zo0dgCq80aAbj0dgtGXTUoALX01DUsTdEGGbSFfaPSAsyLwBqzxdUd535eENVr/hBvssW6QpH/msMk5uKMtbpYWG7hg/hQEzok1IAcIjhqVXr1nwzIcaR0jQOBNXx+nExa3Z79tVcOcPSWOwZD7PQHPIoUFh+Ghjkur+RvvgerdALQrk7MWup2iMqydBE/0XFDyvpyEPrYX2UxyshNjnG6STvddSqdhhyQ5TzHqxHD4ac+JrR33i0n459flRJTNiCWxl9Cl7pJD2E6YetFhRb0HcQIVXDnJdhbvVpMMWYzSFz6aeovc4/LRHrXq3U8b0r5p2WSukmkUTrG2yK1i0ilWlMHQPpeWw5qzhhorLgCYE/A8dJ6pKxFs2hrBLmc7dY0wj5wCDDPKjTagj+qVpDcxDRNKYE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17af611-3145-404b-13ff-08d7eab24a1a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 13:52:56.8583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWI3NWj5acVBa89BzMKRpPT2mZQ872UkdHDZuYyuLxt75OyQoOgVbw45bMe9h8Phhc9265Bk/UZl5iWscziBhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5025
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/27/2020 9:04 AM, Christoph Hellwig wrote:
> On Sun, Apr 26, 2020 at 12:48:18PM +0300, Max Gurtovoy wrote:
>>> I see no reason not to support a simple Format NVM for our fabrics target
>>> implementation.  But that isn't the point - you don't really need Format
>>> as you can also control it from configfs in your series.  So for the
>>> initial version I don't think we need Format NVM, but I don't mind
>>> adding it later.
>> so we're ok with passing -p in nvme-cli during connect command ?
> PI should be enable by default.  We can think of a hook disabling it,
> but please keep it at the end of the series.

but the default format on NVMe pci drives is without metadata and to 
enable it we do an NVM format command.

So for this model we need to do some action to enable T10/Metadata.

Regular users will usually use default configuration and are not aware 
of the pros/cons with adding the metadata (resources/performance/etc..).

Also adding module param as we did in iSER is less flexible than having 
a flag per controller in the CLI.

I'll think about another option that will replace -p in connect command 
(the only one I can think of now is always "on" as suggested...)


