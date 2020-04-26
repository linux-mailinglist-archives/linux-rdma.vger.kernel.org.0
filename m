Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9665D1B8E95
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 11:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDZJsc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Apr 2020 05:48:32 -0400
Received: from mail-vi1eur05on2079.outbound.protection.outlook.com ([40.107.21.79]:6123
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgDZJsc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Apr 2020 05:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2ViKzISaG4R49WgNT9JELhfA2JMBAbbLAy8LI84QrMDMTIDskSGU80sj9OTf4PdIpK2XEfx4qxyA+H/0Lu9PadfrtCdjnAAeBmNb39JZpQ4I8hWJJiQwtqAJFbmPZ6Bifzh0i4+99CxcJIN5QhXe84mEyFWJNfzRIz7QlUgVcu0YZyZ8DPAF8NIcSnKuy49WDpZ9uZv+hXLn8sPDpL7Mq+6Y35U+QKSlgbzsiX6QSuA4C3qp9Vx2COhwecLOO3j1C2f6s73DnKWpgUk5JiSAg0XUt0DdWlyWeJ8aVaD6al946XdwPHsNVib7GwogBYwfKPJEmeljw5wp+3AN3UIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEeu7ZoXtCdgSH/AUZX6RwStG4bMCiPK271r6/e3++Y=;
 b=oK27ieZ5NcPvUiYK2hW1oZLQSdiCMQhWCOiRLg2r9Iufg647HSBwL1semwm6XViYEc+Z0b3+g2ZOQQjqWjtd6k7DUMh117zdElr6597fOtvVln/qy7RyVZsMmKq2UUhBYsqT0OdFnENfVh59ZoS/V2txhRZKTS1VkeP11Hooh0PZMcEQASTe1ffyHSXs8QhnicYPVQi3epRCXPrahpG1OWGsJTPEtHIhuF3s9KYI2FxaFGVWPaccyidaM7ENzNJd1b8Vq5IEAKTuZ1occ/Wwnxz2U0D9L2GXpL6CvrPgT/s82eQ0Qm62RQe/pLM0BnkvBaUU4MlsreyU1N/TX5FYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEeu7ZoXtCdgSH/AUZX6RwStG4bMCiPK271r6/e3++Y=;
 b=jmnmzLglACFTzIbCltty0GcOBdr+c8AowEoGEcWXGWlUPHmx34YRIw8hIFy3ZG2xOesopTPh6GRRABOsnlWBNmqf8E/aQ3TT9hE6Uph1snGzAfAXnuc+HTL/tYxuYx5MnvfY2MDvid+4yhotpgdZCF8hQynB6DKjMdETYUMU+oE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5172.eurprd05.prod.outlook.com (2603:10a6:208:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 09:48:28 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 09:48:28 +0000
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
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <7ff771eb-078e-7eb1-d363-11f96b78eb64@mellanox.com>
Date:   Sun, 26 Apr 2020 12:48:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200424070647.GB24059@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0091.eurprd05.prod.outlook.com
 (2603:10a6:207:1::17) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.7] (217.132.59.243) by AM3PR05CA0091.eurprd05.prod.outlook.com (2603:10a6:207:1::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 09:48:25 +0000
X-Originating-IP: [217.132.59.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02bf968a-d6c2-44e0-0e35-08d7e9c6f881
X-MS-TrafficTypeDiagnostic: AM0PR05MB5172:|AM0PR05MB5172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB517245A2AD6A38B2DD94C30DB6AE0@AM0PR05MB5172.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(52116002)(2906002)(8676002)(6486002)(31696002)(86362001)(16526019)(8936002)(5660300002)(36756003)(186003)(81156014)(66476007)(26005)(66946007)(53546011)(66556008)(107886003)(16576012)(31686004)(2616005)(4326008)(316002)(6666004)(6916009)(956004)(478600001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVoWO5cu2heiQm5l7ewmvwOCIST9ISxGDeAz5Nhz35qVNrOHgtPTr+ZMO1WxMjMa/SfTcK39quL4vPm4NLAlzJft/wpn3za/0IBYmWO1O14mqN3veoDGh/y6WlaB45/Dko/mxxP4ECr1NhrY5qSHrU59swOw7wZFBBVDs1IzDRYqtM+EdiQzZ5fYRQdwks/4mM3toQwWuP6coAWVjrt4Sq5rdrF69yr1I+6NFPn4EzCaJaSZgHruq6t3uKR9FKR0SBmSp+JEFYpGLKZ0ai2osGLJkAv7F1xOzPW5quwL2O4RyfFna1l2Vim6iIKKXurNGbeKb2HXgxSuKQaFEoffSRS+gDwRWODUnHtV1M7MGRtncyemTKvYdjvz7AprAKH6YOC36P5BQcZwbfDhfkBAMqmknn8XnWPM+yHpPo7aYhbIQnPfhvDyMZ5ouRw2CfWq
X-MS-Exchange-AntiSpam-MessageData: QmjaD1C+qNsTzt12Y+o9xzW9DtH5Vd5aP+tp3kvBdXeegi3F5m8MB/ZsFEdrAD92CUhPk/cIWL7/iDlRodOY++02EgQrwlzn6LMR8B9Ff+qNeYPM3xEF7MzgSqdBqSi0OQSdO/LS6RfbtYiTkz0GsSWO2M6aP9O3tcRYtm1owkdHJjegdh9h9fCFZ4GXUXm8TLiQzGLNMCQR74Dj4ME1PtvaGC5OpOTX1FPgrZVkW80h0pdCNIMfvVQ7iH3PtXHbjfgmluhwbSKiuFOoXdFeKn2yh7AbSraOGipBzEIo6vrP8ZwtoTj0okFRaGE/zqd3Eb9YQl+z7U2kkNSu2ekW+jPzmB7zuPO6rpcwd3C6NlMnk6CqaFPPWCpT+a98HGNnMXl2MwqzB4y98mfasW40EflDyuJEJeDNxB7IOci8g2atq8Cs/CZyDLFz36s5PGTI5xTmyIkkltu+ofOe20Hf+Sae2wTOTCKgNoiwJjVonMai6iNyTk++S3qX3szkJXj5uMLo5tvklr0m5neMk+RPMopyYlvdL5A6DSjW7MwV2bN9D+CzGExGWLTUjg2FYfWYXo30cHRzHDtLlS41R1ApBvfa6AfFYLRLXExZwW9cvRVNr/Or/yc16x+wIRp8kVg6DhRoDh5B0+zzmlJIMXp/kvupLZIf15Gkje7tMdnGn0Ik4pObz+OsMqYuT0hatS3qMAl687Tda/RiJHPIKoyZn/VCowjcqrCPdw7fH0zu6KqX04vT7kL2JrsJdHkHfNANYWShVGVpyQ5nh7IRJAnlLatKpVOHoIPIf5r4g3sehpw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bf968a-d6c2-44e0-0e35-08d7e9c6f881
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 09:48:28.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcdKqwkuS3iKZ+7QrY7p229DlfmuwTMd6pH5m3IvtkySBYgCceO9X1kCInwOuiMpTHrxH4oa/HywRy3+6J2NXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5172
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/24/2020 10:06 AM, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 10:30:44AM +0300, Max Gurtovoy wrote:
>> On 4/23/2020 8:54 AM, Christoph Hellwig wrote:
>>> On Thu, Apr 23, 2020 at 01:39:26AM +0300, Max Gurtovoy wrote:
>>>> it's a bit late for me now so I probably wrote non standard sentence above.
>>>>
>>>> BUT what I meant to say is I would like to give the user an option to
>>>> decide whether use E2E protection or not (of course a controller can
>>>> control protected and non-protected namespaces :) )
>>> I don't really have a problem with an opt-out, but I'd like to apply it
>>> consistently over all transports.
>>>
>>>> AFAIK, there is no option to format a ns in NVMf (at least for RDMA there
>>>> is only 1 lbaf exposed by the target) so i'm not sure how exactly this will
>>>> work.
>>> The NVMe protocol Format NVM support is independent of the transport.
>> Ok, but it's not supported in Linux.
>>
>> Are you saying we should implement Format NVM for fabrics ? or stay
>> consistent for NVMf (and not nvmf + pci) ?
> I see no reason not to support a simple Format NVM for our fabrics target
> implementation.  But that isn't the point - you don't really need Format
> as you can also control it from configfs in your series.  So for the
> initial version I don't think we need Format NVM, but I don't mind
> adding it later.

so we're ok with passing -p in nvme-cli during connect command ?

