Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EA620F7CA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389199AbgF3O7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 10:59:33 -0400
Received: from mail-db8eur05on2081.outbound.protection.outlook.com ([40.107.20.81]:40353
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389189AbgF3O7b (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 10:59:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh+Bu/TIBROHpubWofE5V00XGDHn0EXwb0LQrMLpvqAEY6Ja+TgUbNtiAOUGM1vrTjdsRqGWEa1/UmlBbtpgO/JDrmyYe0aGfCB6TpzQACyGgTne3Uj0T4FSoMeJ7FYvUX4pHs+1F/d7hU7FJacXKu4CiA81BQzGBkXK3/qfLb6HFyOLMiFKBQB7hmP0wOUeMJF3a1hqbhzkfpNUg725ArY/hY9T8RXurCpQsbkuvcbFoR50pINelpwlyDSf73mzwajcwdGeEhO3vNReig4cRhnK/DVUikgtJRDSXETVeuHKM9sqFzgsbQHzcE96KA767SMt1xYdjkuQqxR9HaqNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS6cGqQoq38ZV97YSt38ngXvCTX0SazQh6ZoNrOtMEM=;
 b=QJWZtYtOoo8anePTr8zDxxAOKOnkFPnFDqgodLTp88O7h1F05aqRZOzL8fyNoR1yh2J9Xce1x1FatI0JbqO2yRgCokMJVTuSxXk1iHiuEoj7GJvhhB44HKd8+CqmqEwSY7cJoG3rAF2iqnhv9VF6XREIqVLPWxyejxPOdpIxPjsswYo4UT61hVxdRIUbSZDzDW9aCUp+v31g2bn630LMq4f2H2gIykVqmaIXYHqW2teJM7eg3S6TEpPuGIkWKlR81BiRDrBZdaUqDXNYGGpVqDPnJLbiXVT0yu+Q8BIXMxalWScMrfCLpi7YdtsZmCwOeCZKAo8L+D8Q6hSYXJx2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jS6cGqQoq38ZV97YSt38ngXvCTX0SazQh6ZoNrOtMEM=;
 b=TQejIFvMU+MtNQOvGsb2qNjBLkYuq7mmQ0bQ2Mgy2jzdjzzFKPN3vmDMpwPO2HP5V6rTwZ+Vra10zmAJjhvZRlR95+mdQ6QrPtHVcC0tlWqQSKyV/qWInDn7X8cLop4FM8Qr4NPSrfXwJY/zycOhsSWYfMIvUqtuloUPSEwkrFw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB5320.eurprd05.prod.outlook.com (2603:10a6:20b:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 14:59:29 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 14:59:29 +0000
Date:   Tue, 30 Jun 2020 17:59:26 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Lijun Ou <oulijun@huawei.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 0/4] ib_core allocation patches
Message-ID: <20200630145926.GA4837@unreal>
References: <20200630101855.368895-1-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630101855.368895-1-leon@kernel.org>
X-ClientProxiedBy: AM0PR01CA0093.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::34) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR01CA0093.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 14:59:28 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bce2af0-45d2-4733-e4ae-08d81d063000
X-MS-TrafficTypeDiagnostic: AM6PR05MB5320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB532015706EEC49D8285F02FEB06F0@AM6PR05MB5320.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/iRX/3NVigfgZolHPIdOhgYbFQqGdKrsJnsWh2xuEbDv8NNeaXoMZyZACm/l017mAOarHdFDY3wLpb9+n9DuGjv+QJMLUYBYpYxtGcOopc7Mqgo076SCpvY2weWKMkQe87Y7GarkOqzZQhl4+mgXTDmYLo3Cb5TwsOJJQ47W2U1LacFPSqvev/hjTldqGAkfMSy/3PfP+hyIICkM4k+CygWniHmaz7+BMWwUWC4Y+9FjXzJw8gIrXay4RY9XL6jMk6NzkgEiKnp1EQ0IZ6LWZSri1gfUK4+DGDTc35aSwiX+cIHaLi+Jhi4zsAPgJqvw+UgRYdJyjCfDX8j3P/aJIHKYGAZpIPqCMAh+iLmZc56q9rXh5vP1pRSHAeHxNP6JRGj5bbtM+10bLjF39Lnuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(956004)(4326008)(6636002)(478600001)(52116002)(16526019)(54906003)(1076003)(186003)(110136005)(316002)(107886003)(4744005)(26005)(966005)(9686003)(5660300002)(33656002)(83380400001)(8936002)(6486002)(33716001)(86362001)(8676002)(2906002)(66556008)(66476007)(66946007)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xrAnPkI0J2UQlBkNTUtkRJMtx8/c9r+nk+Uosu5KDqqsK2eVVcr1fqTwgmJ5QRSDl0eRQWcZhmOV1HW7GSvqirxYD2AOW6fFn8Ux6FCqZr83hYl2QCSLihSTNuX5zbmG8NzS+reClW0gE6pFao/1ajwrR91nvAKj7SNZHNdVymG/NaXuU/bUrfJL1Q0lunXwBy2RscOPb7QRJ+L1ExZstF/uRowcefprnRhQG0/VT5BaGIVhR1/BEO4Z8s1wMtLjc/JZaz5oxOquNf5LVGzwv2Mx5w06JLi2i1XuHwgwsxC3U2zf+k39ziFdfFb2/2V7SIKsxdWlcsbqTgorHMrUYfJS+WMyHaX9dHL+eU0efr0lwtODtBurg7pctdKhxaOMypMrp/3GUE8Un0Zpu2Lz1PdBJaxrLbF/LTsBZYOjP/Ifz/5V6lukmSSGnLg9Vk5Yen7uHdkAZr8JjrHR/0LL5EICk8KCc8Wct5+28Ng+Lu8TyH1azKbwHOB/oTarqBKl
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bce2af0-45d2-4733-e4ae-08d81d063000
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 14:59:28.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOV7d/YnzWAxCBd2wzZDAW+NbRgWjT3bRotHxjB3HbZ1A5RnCcFeRxnSzQ8E6kwLzrphZdiDk0bD6OmimAbMJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5320
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 01:18:51PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Changelog
> v1:
>  * Removed empty "//" comment
>  * Deleted destroy_rwq_ind_table from object tree
>  * One patch was accepted, so rebased on latest for-upstream
> v0:
> https://lore.kernel.org/lkml/20200624105422.1452290-1-leon@kernel.org
>
> ----------------------------------------------------------------------
>
> Let's continue my allocation work.
>
> Leon Romanovsky (4):
>   RDMA/core: Create and destroy counters in the ib_core
>   RDMA: Clean MW allocation and free flows
>   RDMA: Move XRCD to be under ib_core responsibility
>   RDMA/core: Convert RWQ table logic to ib_core allocation scheme

Jason,

Please drop this patch, I will resubmit it together with fixes to
create/destroy RWQ table, like proper error unwind and proper usecnt
usage.

Thanks
