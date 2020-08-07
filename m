Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA0E23F0A4
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Aug 2020 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHGQKa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Aug 2020 12:10:30 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:34958
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgHGQKZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Aug 2020 12:10:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILJAdWLjE4i0qx4z/0M8Rhd+UkOftndKiM5vCzBkrlnxhMTx2Wi31egWRrEDROM8r0K0q5bPM1z9gdkJ8Jhe3CgDIgO/usEcgQEDJzK9V4OkF8YPlH4uNB6t0+bWioQmSA6TWXi3Pw2KxCdDMwh/Vo3n2paifhanS7BjzknkwwcjQmTxqGYa074FFrqM9+0GXcdh5fcf9vNbjYFMEIVLQF6wKDLJq3d1RV108TgkAoai3hIfj+FvwlBfZsDuDqboM/PuvxJsvO48brnVz8emavvvSKqOyis5RKkQqXyQNhZ3TBdhov2f3PZhCNuWr745aFxzZVjAZWdJtlvJik1cLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmc252sr//fWUKJtuGT/EqPC54WWLzM9Ql2w4VkfT1E=;
 b=lCJvHHD7wssBY1skATctPGYZZE0Fg5l88KQXUkk0BmjZWWDhVTDPNECXdzXRd60bNJCN/2qf9RF5DxDuInmepkr2FzFXakeryp3aWzwrld4QQR/ryfPE4W7XZDGzLSluto6xexMU7aJAopvrSX9p1+XdxnlrOS+PV3TbFKwycKBK9y+VQoB60/qgPQbdCq6JK3i8JRE3GXNCFWOnlRgPLPZJXl2JGyIBxCVyCed41a307sV3+I2onPZm4ThKXqhLLdnUy9jUL6QHaJNoyIyBADXC3y2QdMRJUg0/kxfcpteeJtG4PL+2cHOJmPZxPVzG3vd6I1ZGH/C7J5l8Qkwdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmc252sr//fWUKJtuGT/EqPC54WWLzM9Ql2w4VkfT1E=;
 b=nGfuDuh73LnuXYjmEDnHp0yXGir5QmiIHTVh83KPEw5lkTAZYG2ZhjTiKal4uwLriPy/cK6qmypc7AXP0NLP0zDd6RBWgGaXme4Grt3k7fmnL05TsHGLAZWyUiJR40r1amBNjGQu99YHAuAMXxXzUcNDMNiXQjWn3eRW+PLI2V0=
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM7PR05MB7121.eurprd05.prod.outlook.com (2603:10a6:20b:1a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 16:10:22 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::15f4:b130:d907:ce72%6]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 16:10:22 +0000
Date:   Fri, 7 Aug 2020 19:09:56 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, jgg@mellanox.com, dledford@redhat.com,
        oren@mellanox.com
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
Message-ID: <20200807160956.GO4432@unreal>
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805131644.GJ4432@unreal>
 <3777c9d9-1d36-f8e0-624f-aa633fd517ab@mellanox.com>
 <20200805160601.GL4432@unreal>
 <6cd8d78e-3017-696b-508c-73c3c8b92802@mellanox.com>
 <20200805163738.GM4432@unreal>
 <5364b857-fb44-78ab-85e9-d0e6700ae7c1@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5364b857-fb44-78ab-85e9-d0e6700ae7c1@grimberg.me>
X-ClientProxiedBy: AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::39) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (213.57.247.131) by AM0PR10CA0059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Fri, 7 Aug 2020 16:10:21 +0000
X-Originating-IP: [213.57.247.131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56172523-1d95-427e-5581-08d83aec62c6
X-MS-TrafficTypeDiagnostic: AM7PR05MB7121:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR05MB7121EDFDF474A2E033217983B0490@AM7PR05MB7121.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4gnjC118u824X87wdmINmr5d08NBePrwfjK9lo6SVdeXob75kVmNg86W+HbxEL7IhXs3oV5NBcHP8sCSINqrJtcPbxGWQ3wYQC2AqQNOo8L1p3v4pXGXGj4piKz0MNhAZ4AOf0UliO/qQRG72lMEtj3VZfiVftz7f7tn5GJz6J/v/pHMqNXUqA9jVPVznwptpmCsewJt0Sjo7PGL4o889BIklf2X/xRd0gmQYDz7gI+6zdimlBsc/jipNTsqptO7fMbnzoe5IpELkCejF3lz2588f+L1z0VW+DtUmdn4I5c+woCBheY8Tq7setWVbADr83yEf+t9Zua+SEsrnv6Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(136003)(39860400002)(346002)(396003)(366004)(376002)(86362001)(8676002)(508600001)(66556008)(6486002)(956004)(66946007)(1076003)(26005)(107886003)(8936002)(66476007)(9686003)(6916009)(4326008)(5660300002)(16526019)(6666004)(2906002)(316002)(186003)(52116002)(6496006)(33716001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kyumGaDmIRhACp6KdxjHsbzJT8A/C62TAHacqoJuzhXw6NSCvKrDJhRYrN+9801M4n7iTlpd6AKkqUi/xazVXK/sPGWz3+ffWplJ3tP2EIC1wpTxLPebSvkG3C+biIUpaSesF4rfDIDrKyBhyQTrOnshYv6xs+zXni7nZJAjOzaBqAEo44skM7l7AgUwVt1wlVje8lLxTYMTMEm14bHEyROu8G+8G93pop/O4u1WQ1TFsOVrHJ6GabN/Rnn9o5da4VIXFMd0tlKZZLDAAzVM7/z6AMrAqOu0oxgcPVE3ITUWjHqBbZh0d/NyQHKgmNhplADBncFtNxcLMeAj6eRrk7w8AQ+RvFgJcqeTxXp/vStIN9S/C0kv+X4qxWDxwnE31ZpgC+OFoT7ZnOV1UwHLHakVvUX2A3ZY1tyckYOP6wgTNrLOU6eLzUJ3svzibykc4qJPftQb9ax1LvU5k/hdExBYIBK6+9BM2YG1/gOcPLMpDY/WGZ3KxdYBCkkXKrSKR2TxzV6GaLM8idJW1wCQevn8qCh8yPBtsk1RjQab84+lOPZG6o1Cf0LZNkwA8xlonD6DmMpTaZ01AFGhDWWGdTToNlLjYfS6WBuGQjtpLEBHpkuhrr2kuCbaU4BcJC6GodkJGvqExDEWdl/VRiv7cg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56172523-1d95-427e-5581-08d83aec62c6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6408.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 16:10:21.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPO7qHKVLDyxQr2y4/Uczq+i4RJYTQu6gT5jKZnCau1bONANTa42xfR05poU0DuuxC2gs4zg9TmzZ5TlQ5XxVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB7121
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 06, 2020 at 12:51:15PM -0700, Sagi Grimberg wrote:
>
> > I reviewed this patch and didn't find any justification for performance
> > claim, can you please provide us numbers before/after so we will be able
> > to decide based on reliable data? It will help us to review our drivers
> > and improve them even more.
>
> I don't see any reason to find evidence in justification here. It's a
> fastpath call, which is unlikely to fail, and these macros are
> considered common practice.
>
> There is no reason to make Max to go and quantify a micro-optimization.

Unfortunately Max didn't try to see if these likely/unlikely macros
change something, but I did.

Simple objdump -d before and after shows that GCC 9 generates same
ISERT code before and after this patch. It is expected and there are a lot
of reasons for that, but all of them can be reduced to two:
* First, GCC is awesome in building profiled code with right predictions for
standard flows.
* Second, likely/unlikely is intended to be used when input/output is random
from GCC point of view.

So as a summary, there is no optimization here, just misuse of unlikely macro.

BTW, old GCCs behave the same and kernel full of wrong copy/paste.

Thanks
