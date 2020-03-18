Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D44D189AE7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 12:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCRLnk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 07:43:40 -0400
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:62746
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbgCRLnk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 07:43:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ocf3MLT5X84i7ymS+QfBNFZm9kSEqseKyq+SKKXGqjaCcjAHiJOHwO8WlGCtru3OdnjSc6COYVU20Fe6O5ZK1HkgpndED9ZTptV/kZdItyUPoPS/zePpXbMxgS52rXlhpnyT6rYcavM8ZYmbTPnpiCzhIkqoIYtKWR8EoKNzKc1BlSaJcNvViODN/LJ6AonoME8YfM7r74rdrpeIjWPdNWKw6roKosPNajUqZ9xj5xXBpI9fJmfcco3SC2/TznC5GmdCgN/GJUwmTN/4gylqtNAPpLTPG8eVFDpLFqXBpddh/p1PQArWsexATvN9mLjpoX861IEwagFYJi8SsRRdEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjsj0GZyFU69um9vQ/xscCKNEZsGrQC9boEjIKmB59k=;
 b=P+tayzEEFRefY47uRpV+zINuNN8y8ca9j1vFl2hmQIdkpnFrYmbEnBbeWyyUusC1rHgObsTbd2ayHLUjAKooLOO0QgX40EYnOf7QGrPxJ1h17UXzEWXugk8XTPDM+VUDIBqotzA+sGBLPreC1EbUAE+cKI6mHsgit3+DpYl7DTg+SK6YGEfLIQM3ZaHMlJK+eS7gl3NG5MD66LZxtuQ+2Z6GajZ2LSlKX6/gW3gdB4TPfS/bWv3fguOKICOaauUyq6GwPUBHvSUN+t+X4DkTAwX2l3N+f3egseUhlWE/Dl8aVsVktGrOVB18vjBHRuTuz0H+UzwHohFwaL2nRQbKnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjsj0GZyFU69um9vQ/xscCKNEZsGrQC9boEjIKmB59k=;
 b=NvVRLwxhIgbnXGLSz3GJrCAl6ndcOikOnPbAouHKL0pdFlbQgGy3LmoEkV+HBRMwdPhuJDVNWlBahghI6Qa6XExd167A0tmt9tp0qC7qE2C3izsY4jE/orLFzAltVFWHJ1/08+iVHujnK6PGgoiEgHhk3KW8Jcb88eSw7PmHM5s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5888.eurprd05.prod.outlook.com (20.178.125.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Wed, 18 Mar 2020 11:43:37 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2814.025; Wed, 18 Mar 2020
 11:43:37 +0000
Date:   Wed, 18 Mar 2020 08:43:32 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Yishai Hadas <yishaih@dev.mellanox.co.il>
Cc:     Andrew Boyer <aboyer@pensando.io>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org, maorg@mellanox.com
Subject: Re: Lockless behavior for CQs in userspace
Message-ID: <20200318114332.GE13183@mellanox.com>
References: <6C1A3349-65B0-4F22-8E82-1BBC22BF8CA2@pensando.io>
 <20200317150057.GJ3351@unreal>
 <F97A8269-872F-4B94-8F03-7A8E26AE0952@pensando.io>
 <20200317195153.GX20941@ziepe.ca>
 <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73154a58-8d65-702a-2bf3-1d0197079ed8@dev.mellanox.co.il>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 11:43:36 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jEX6i-0002yY-SW; Wed, 18 Mar 2020 08:43:32 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dfbd64c1-6bdf-4b26-8c03-08d7cb319873
X-MS-TrafficTypeDiagnostic: VI1PR05MB5888:|VI1PR05MB5888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB5888C1064E0098D52A79960ACFF70@VI1PR05MB5888.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(199004)(86362001)(9786002)(9746002)(107886003)(2906002)(5660300002)(66476007)(66556008)(66946007)(33656002)(36756003)(52116002)(478600001)(54906003)(316002)(8676002)(2616005)(1076003)(4326008)(26005)(186003)(81156014)(6862004)(4744005)(81166006)(8936002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5888;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoviPmfWHyuA24xPH7FWcQi2cU8fRkpM2/xHm8RL92pf5WkkKY+lKIYk8HU1qALRYqWbx4r5jKmcCdkLjcQ0UwAl4mYZ9qUD2vrR2yYfmm8FJT8W0GiHlQtHrM+UIRF83qJ3QQQm9Wye3y/EaBYnoOud8zr/Yr232gQAmQwEMRxBqjecuynZJCqysNhXFo20gbIhNLpJTuSrZld4Okmum/+PwVirwuhqxr8MF+XSq/eCtZ1fQ3+kZVKxw0hU1DLtDUH3yObXz0APcAu5Qy9B5sYOemXE3CQgTYCmv75VHRLpY/x7wXtVJaajBwPLDoDFQ/jGJOp9vt3M/HIbjEFMwgc6gvl7RWFIBv8RByiPdCeu0/F82bUcZhh3ko6ze+3u/MGl/F9LqgrpLZSzrfS9jxMOt/FhP2cd4ableRTXxAgzpnSv4kUaYT+E8Vm7MisfJV6suj+9F4B+TqoBzBPT8UJ5sUw9ZKYDrE7f2bfE2zRLPnhFeH5wuCcHa9Ce/tLw
X-MS-Exchange-AntiSpam-MessageData: V0xPL049f8ZrZm3ZUyNhAM16Lp2SI0dMmiAQ1DQQOizY+81mvMzZq2bwhK4j1DliXaWAPfueF6k3WRVb0A1NvtoYu6EedcUMIi/O33w0oyIxqSbsIPJuObhwWDm/ycMN06US5HCvRGtGgLvU6F/b/Q==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbd64c1-6bdf-4b26-8c03-08d7cb319873
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 11:43:37.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38+W7zIxVi7lbNErctqBQlxjoqt5tz4NaLltiZLujS5hVTpOI8AxUVmAHO2lxSKQlp6tlZXsouXd7x3qPOXKvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5888
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 09:52:27AM +0200, Yishai Hadas wrote:

> We can really consider extending the functionality of a parent domain that
> was just added for CQ in case it holds a thread domain for this purpose.
> However, current code enforces creating a dedicated BF as part of thread
> domain unless we extend ibv_alloc_td() to ask only for marking the single
> thread functionality.

Doesn't the CQ need a BF too?

In any event, I don't think it matters, any real application is likely
to use the thread domain with a QP as well so the BF will not be
wasted

> The existing alternative is or to use the legacy ENV that mentioned above or
> to use the ibv_cq_ex functionality which upon its creation gets an explicit
> flag for single threaded one (i.e. IBV_CREATE_CQ_ATTR_SINGLE_THREADED).

An apps that don't want the BF can always use
IBV_CREATE_CQ_ATTR_SINGLE_THREADED

I think consistency says that if a thread domain is passed into CQ it
should trigger IBV_CREATE_CQ_ATTR_SINGLE_THREADED

Jason
