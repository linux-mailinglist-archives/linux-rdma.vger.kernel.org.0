Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276BB39BF28
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jun 2021 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFDR5V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Jun 2021 13:57:21 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:4238
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229690AbhFDR5V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Jun 2021 13:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aX0PZgxGrWoVVyeFhvf0M4z/AJbgb/CA1UTFF7Es1IJVUgY4fPFv9tYqbvKd0yEaqV2che64lQBB8Ex4Wu4VNmgmhKZFpOBnrklIx0n6e+tTmx5Ks2abP9y54qyvKRXwKqvBQvZv6E7hlY5FOjnRyT1LTUmPi1Rk/CgshH+NQdKAfo2POwmTfjINaSb3rjCaZVgyuELAaghHwwuzWf1570uMbJQAMH+agOV41MX6iVXEV6I7wMITfmZi4M5cvmBC2jzxr6//a5unRmhLkQ+DSsioNp94fQ1+enKeSSse9Q02BxEdA0ovGrEEpFfr6htUWszVp/db3eQrT50pVRYEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zxce1D5fj5JHMzBRc7v84kXychXHPZyc+U4BYq5wS4=;
 b=iOYKgzGZDJpa7BCozKaXKL3kJOquI8QDilSOpc02myJL0e094NVT3j3ChWZnMZc8QJle6QTPWgu4atpxM+FqNnjmmh+97IESwKt0a17mEy+zkGyEY/M3BqZIUjIF1hEGgLcruBsz9C3Qdl1fsRf/poF+8N2uDnWhgkXlnv20QTyvYcdBWrAeCBgFQ7URg+UrqYdWiXLkDMr/O04DeCAnV9au/Dj+/gzZKrHoWTd9ri6TJei9qlN9G6wWSGbeI6FDuDA/S9NGZcTeM4fCdZ9zbEl7HNWgEyXKDT7kWnXShIgl4vDp1ws9+SZSv4MwI2JN21e8p6j0ABsuvdaFuDTsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zxce1D5fj5JHMzBRc7v84kXychXHPZyc+U4BYq5wS4=;
 b=agEykbNiLBf22BNrze5KQTbFp9QGnH1sU6Qflwubhwj0wu8D1N632u5cHhG3LQA0xwlruOU/IylMDKVy2bRPfrHFHt8g6vOy9jXinUC3jfe2aoEjBUP1shJEOtkHRNWLvkxuqHL0kQh4nlFILXE2I2NZ3Izko47EVHEVrQAGveqFBVa/jAxBmrskkxPkjj+DQYHhhrrZUaAbFBh1cvK1wSxpEG+Slz5k2e+RI/uiL36WzGXH2OjP97VxeKTLtwnnwjpDf/478BfhH2UKJn4oEon52uIzeTlF8nDJ22+3doAb/aTIWxkiGgpPKRAlzkSZTDktwnvdERKvN/z7VKy9Mw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 17:55:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 17:55:33 +0000
Date:   Fri, 4 Jun 2021 14:55:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, zyj2000@gmail.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
Message-ID: <20210604175532.GX1002214@nvidia.com>
References: <20210525213751.629017-1-rpearsonhpe@gmail.com>
 <20210603185804.GA317620@nvidia.com>
 <CAD=hENeqZrtLbJF2J-HuetJec8MNfAVDHmcwkWmMNAfeX4-vng@mail.gmail.com>
 <0c9c8709-8816-6083-59ef-c8d664ba382c@gmail.com>
 <8ae22b01-51e0-4115-31a5-ff9c1378efb6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ae22b01-51e0-4115-31a5-ff9c1378efb6@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0024.namprd22.prod.outlook.com
 (2603:10b6:208:238::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Fri, 4 Jun 2021 17:55:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lpE2e-001mWs-7S; Fri, 04 Jun 2021 14:55:32 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e00ad9-c4d0-4dc7-1a47-08d92781f321
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB534928CFEBA82EF783621E90C23B9@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QHNY13N24BcQe7ZDXxjI+XssMet1BybUVfeRQAPqfQhLW+5d9h3l4Kvghh0fwGKB6ZUV3dGfp9IV9+c3wDoB4a+xxmgnfjK2oDZ1zmk9fDO/cxia6Td38MrxtUbs+sTUV3xeIKmla4j7jZOQ9IudTX02/JS1Jwa3wBlABvtnPY1yhfeMYe4HkiZpPwYXMzho1dGWMr3tFohRlTC97ZWYS5LnEpwgTAF15TQGpCQpXJtKUlurCPSteGxKhHKLDpIkk0mUECe2ZW/798ViTF/tupuie9YxJWU2jggx2CbEMFzHeT2X+XJz3k/u5PqbBtoqARPRIQ/SOwrenYtaehfb5BbBeUu/jc4PkbD2YT2ybW0H0RS3hm0NFNj5/vDwuTNr3myAh3qQy+ug3GuiJ55WBp3l2WmkYj5BfTdVwKtSInFuQJ0AzJnVaPrVgC6/aS/BSgYU7GkOdmC77jiPgBAVYud7OuQEr4VKFhT2iquAYe7pqn+2ytLg8t9djH2Yv2AsYJ0QqOlKOLhKmg1WFkhQE/7KnMAvJnqQ0+UTJFhPtsswoL5oEGP4JsDTSDoKfP923+ZB4BDUdacj7MTsr3/yT9BBU5lC8NXTpgGGXAVKIxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(1076003)(316002)(426003)(54906003)(8936002)(5660300002)(6916009)(8676002)(38100700002)(9786002)(9746002)(86362001)(83380400001)(33656002)(2616005)(66946007)(53546011)(66556008)(66476007)(478600001)(186003)(36756003)(26005)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UbW1YZ04UPrxc0fTcQpzjpr7WandVZh+pERpIobf86bAoo9IRPb/In+SKlfLNxNQkt12RSZgOkT4acpsYQXJY8A4jZ/8Z2FNxqojV416lkThcU7dzqYDFGWdUyBIxtSbUOMrHEOxUR2ePjSnrVRqEccFyMSOxFpG4isYsHgVRXBmTS4H7bNiiT9LJrtdOai8uEa5lOsZWrmRpsCLmv7wkfUTfCYeRceB7rXBCx7QhB6ZW7859dGGMmyCflGr04nTiHKBMiSftivW8qyEdEs8qnYMxhv19GAKL53uqkPSAWa6pk6sP5uFbkkZ7JmMAuUT68bx5qxFUT3gVUglQYo77LTkdXuoI7O3ojSlVnB0i5wT8YlPHXjh8seMInSP6ajJmQvwSxvsHpUT3TAUZvwDV6yi9nnhyNDodeM95lUOAH/0iqzd+SCyGx9oLxz+qpUHcZ9fziXnj8SkpEhPoi5KefyCBDnybBYOyOQqTLqv+QlgbmsbtdJZ7l4vAvtKf/GzjniQGM/nm1cRg56NHlK3kJjC+vMOE6/QzqshwXP/oIs4GMjaxfj/4B0TlGW2DI1i5oUoG3rf2ons7urshJclf/Q0ubGyUbYCeLI2sxGcxkLsWTYp2VCrQ7k+kGWIsA/xZLvIwqR1sL+lP1A8ynPGwP9FiowdIalY84lToXuxhOkVfrBv+JXrUMZ7bsBmanCug2k9uwz0SAj+OnEV3/5CnUw8tDnMOE3U5AK35MTysn4GoNh2frvTyka5TtUyULUp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e00ad9-c4d0-4dc7-1a47-08d92781f321
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:55:33.3669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MD+W2wbd04nFsSlKg3dnOd5d96r4RBc1djApw+MGYihYL542AP/P24S8+KVCswS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 04, 2021 at 12:53:51PM -0500, Pearson, Robert B wrote:
> 
> On 6/4/2021 11:22 AM, Pearson, Robert B wrote:
> > 
> > On 6/4/2021 12:37 AM, Zhu Yanjun wrote:
> > > 
> > > After I added a rxe device on the netdev, then run rdma-core test tools.
> > > Then I remove rxe device, in the end, I unloaded rdma_rxe kernel
> > > modules.
> > > I found the above logs.
> > > "
> > > [ 1249.651921] rdma_rxe: rxe-pd pool destroyed with unfree'd elem
> > > [ 1249.651927] rdma_rxe: rxe-qp pool destroyed with unfree'd elem
> > > [ 1249.651929] rdma_rxe: rxe-cq pool destroyed with unfree'd elem
> > > "
> > > 
> > > It seems that  some resources leak.
> > > 
> > > I will make further investigations.
> > > 
> > > Zhu Yanjun
> > 
> > Zhu,
> > 
> > I suspect this is an older error. I traced all the add and drop ref
> > calls for PDs, then ran the full suite of Python tests and also test_mr
> > which includes the memory window tests by itself and then counted the
> > adds and drops. For test_mr alone I get 85 adds and 85 drops but when I
> > run the whole suite I get 384 adds and 380 drops. Since the memory
> > window code is only exercised in test_mr I think it is OK. Somewhere
> > else there are missing drops. I will try to isolate them.
> > 
> > Bob
> > 
> Zhu,
> 
> In rdma_core/tests/test_qpex.py test_qp_ex_rc_atomic_cmp_swp and
> test_qp_ex_rc_atomic_fetch_add each have two missing drops of PDs. This is
> either a test bug or a bug in the rxe driver but it has nothing to do with
> the MW code. We should treat it as a separate error. For some reason these
> test cases are not cleaning up all resources.
> 
> The cleanup code in all these Python tests is very implicit. It just happens
> by magic so it is hard to figure out where an ibv_destroy_qp or
> ibv_destroy_cq went missing. It would help if someone who is familiar with
> these tests could look at it.

It is impossible for userspace to leak a kernel resource, when the fd
is closed everything is destroyed back to the driver guarenteed by the
kernel.

As long as pyverbs has exited pyverbs cannot be the bug

Jason
