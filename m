Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387313E4651
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Aug 2021 15:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhHINQH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Aug 2021 09:16:07 -0400
Received: from mail-co1nam11on2125.outbound.protection.outlook.com ([40.107.220.125]:17568
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234207AbhHINQG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Aug 2021 09:16:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4bm6R6jzrq5zC4a8LSOgu3On1p1Rd7yfssjp6b9cfAaVkiV1ioGdtqdkrXA02N4yLW3WoRLwf6b+VKVt5uMEUeJrMjio5uDKX5ko3GMNkrg13vy3wUOpYbjnmeQeLX4sXC/1aLSXOn8CSgkw/YljGR2aDy926JmrlIm5Pn3wLsmUrrNUHc46dJAJTxOXVrI62dGQ1qXNtUwC7X/5wWCL2txNZleRBjq/IUJMGHMwTP+DrKxRoyJDnDkis9WmBtocUFEP2hJGIsMuopGHczo7BQMYm4fyHwAWX7PtuQgEs4KnITe7GGXNdMq+Bu799YUw890sCjfKixFttH0GFe2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kNumXxrlfhGP2B8u4An5fiimEtwhE6Y7rVPlU92yeA=;
 b=eFZ8ymkfBmVgt0NitfgWEsYuL/HLeCAeKFJLQoaBzgJXypnbEAWL0AqTc6/w2SSerb2o2b1ZJ43McZcIWSmoZUTZj9nCCHCIsUPTBgiqB/pAiDQ2QjJJia6aWuF7Do60Gpvv8cmPFjRBk1HwHqalvUmaug1DEALYLGMtm0lvfQlQ1pcdtHeo35ehYU5dDVm4adIuYeCPOUj6yxUpUZp4QS464ZFokzJjfLO0YEzwLoihMkdruh3pDKqzRLiP95EMegVpL8vtQ4E5udLcYZsxQfSS59z8ljgnF16KHYs5GSn1lOKDT4J27IgeZfhsRloReYuBy/peQe1NycOWnGJ57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kNumXxrlfhGP2B8u4An5fiimEtwhE6Y7rVPlU92yeA=;
 b=XxUPUdKGWwToKEyi66RTIf1X87B7ajA0AA1gtVaq8fipnX5VxcYSlMxnZ9qy4tIibkZYd+FCRh9GOW2XBLR3eXJbj46qfUNLSkdTrMsegBE00HtVXPpjmceZZUlhmPugSIGf4OU5/ZAtzaod9c1nM6Gl6ugsCFYG3x7f9GKflZwOJOv91FIrxaYniaOh6norQUmLnt9c/bTz04oOHGo21RXDQUqTD5O1tYf/Uw+5lKUy5yunj5QVT/VtDVts6VUEPV/ll+yzEVrvjkQmUDbtK5MwovDytmwJbYVlzWNwmBPemitZmICnZhBo4kNlKGWsm6AJwgDC8Kk1N/Z5VEq44g==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5879.prod.exchangelabs.com (2603:10b6:610:3c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Mon, 9 Aug 2021 13:15:43 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 13:15:43 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Tuo Li <islituo@gmail.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: RE: [PATCH v3] IB/hfi1: Fix possible null-pointer dereference in
 _extend_sdma_tx_descs()
Thread-Topic: [PATCH v3] IB/hfi1: Fix possible null-pointer dereference in
 _extend_sdma_tx_descs()
Thread-Index: AQHXisdVCiYfRycHCkqSzyQ/bPA5dqtrKwdw
Date:   Mon, 9 Aug 2021 13:15:43 +0000
Message-ID: <CH0PR01MB71535B0EAF68AEDAA3D45D97F2F69@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210806133029.194964-1-islituo@gmail.com>
In-Reply-To: <20210806133029.194964-1-islituo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2285d03c-3dd0-42b8-edcb-08d95b37cae7
x-ms-traffictypediagnostic: CH2PR01MB5879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB5879725BFB4CA72FD6D88C5FF2F69@CH2PR01MB5879.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F1W0c/XeGi8vVicc9b4LoXIghG2KPDdmdIzNP6j64JoiRRaPiF+RKxZoA44rO1kL0lgazEIojT7vxvx3LoNn6ehVx+tkYwS+5biygnSUnoFYj/FJlvT3oqUPsJbTLaUUDBEQKd4j8raTg1yyjdfwVbqMFMPYyATvZosFUKiDvX44SD3DJWU7ZbcE6hxw5bRrSjd4+6svcrSaHMvrQpya5O22xjkr3yEb9QmVCRRo4xVvd37nYiyNDpqKruI7ySzLjC7UAD1VD8JDsiMi6NLDW1ySXYP5bwmPh0Vl0nJUnqUdYyk3LBm8DAALj0DPgtoDZgLH2z6i/UlKu0eKUT7JXJJsHrXkvTnE+APTxtNmh4iZmOypieSTZKQXhz9mdncb1GtwS9HKNqJA5saSUvJjzxFxLwFi+RvGhLBST6cjotorzHjNEKrhOaVwgArmAQVyN0RUQXdnQN1hakNGWeecUYnC5suwiRYILmh0siM7d0QJacA3eZ3jsTSrr8ZLMUOwEiINfO89KOddzRKDa02Da9V0tNH6S1vM+MBRggVf4iTE1kTOebz9cKBIcBvbAS6hRtB7hIOWhKjv+vyVp6fKTsb1mUoEgUqBy/xQu+Z4EU2Md4kjnPOU0kXX9Njqu5O3RFPtWfvCUq/K8zhKfRJ8jAVGz0yuENfvQf3RSMHhnhvBMbVQI6QOGAt7pdDkdasfLsV46gN2I3JXqJi6cpK7fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39830400003)(366004)(396003)(376002)(346002)(26005)(66556008)(86362001)(186003)(4744005)(71200400001)(4326008)(83380400001)(64756008)(6506007)(66476007)(66446008)(52536014)(33656002)(8676002)(55016002)(9686003)(8936002)(5660300002)(2906002)(66946007)(478600001)(76116006)(110136005)(54906003)(316002)(38100700002)(7696005)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YISbllA74Fc0t8EqtmNBzbfn5veJi3JT0ee8Yg3K1f7rOuqX56FkTcS+Mi9w?=
 =?us-ascii?Q?KwfuCw6uVb2t1O5LDstOEqj9Suo0/AdRUZ6snUlD1H/ftq5C08NnoBstI/bT?=
 =?us-ascii?Q?NZNiq3wymWlhrS5blelcwaO/CZ0GBcqpWmws0owBRVbsnHsDgD7mtWhviN2H?=
 =?us-ascii?Q?Jqucheb1mp7VI10N/xvJXqN6QOKEh2QNRBmZI/T7E6QAJdGKlFv4e8gFhveI?=
 =?us-ascii?Q?9l1w7YgRcE+11VkiFV1+ci6QHHtWn/zEYTyYWWSzaeydku7tXEjnHGvoajro?=
 =?us-ascii?Q?TX+FL00hZbANdUvJWd91gc9zTTsPZvllfMa9kpRdwZTYuav+u6ktQEWasl4r?=
 =?us-ascii?Q?wdIotha7Ig+ppz0VMrarYacYi99afJG7qpsDpDYweVlIGD/CSQpBsS27CJ/y?=
 =?us-ascii?Q?9qyec9pJyskB4O/Su7Y67W2DRevyToTEJmBJLRSbSQ7RxKtjLqROxCLwVPCI?=
 =?us-ascii?Q?A13/stOFVbBfp7UM+XiBwzuAGqkrz2xV6bZp5kPZ9Rb7Q3WTyCq0wMFKQ++p?=
 =?us-ascii?Q?AS+9sHqPK+lnzCnvUU2vDVGaCSlk2QndZQWKHcuug30KT3vTvxleuQpB7ylb?=
 =?us-ascii?Q?gk7aNczhxJMI+1SYXEwh1NCnDNLCNoTSZyjY4VtBFPeyp2R3x9zi/fPfKeCU?=
 =?us-ascii?Q?/bpmvInE1I22FfLKHtlcZRekg77kYv7a04rUeehOZjgki6n2FvD2ZUzzrasa?=
 =?us-ascii?Q?ve4p2abCofVINp64n3EaSr0McSRMsYHR090iABmZXrVKLpxdXfVVMsiG0cpp?=
 =?us-ascii?Q?FEQo8eksI+yW1gyKYyc2MOyCO9BkwjpoXaX0swdioqpigkE/1KZpgpwNkbXe?=
 =?us-ascii?Q?O8gMEfHp79rxhXrang+sOrgGunJtvJV75YNF/sx829NTwsrk4bzgoE9v1ypA?=
 =?us-ascii?Q?92MiRFP2ajU+HHJRgkrC0uEWsEXyXKWUn3n5fFN0KeiXT+gEwRz+Vq9Wb8GW?=
 =?us-ascii?Q?RcxgyY5ShMvLOOvDBzFeRDuIenuO95Ioa4meSL9mcEmBwbNztwH/BSJAurVN?=
 =?us-ascii?Q?aCDLm89bFJJc9xGt1f3eAQTZOIQpEOccR4jiFZFgQPKUtBdSblimqN/iQxQo?=
 =?us-ascii?Q?3td/sSje6zUAk4gnf91PMGGw7fClPWXblCfrNzE/KHPVGG4bUqkn5bCbg8xh?=
 =?us-ascii?Q?IsmjULgxrxf7SOmgqrBe2coAtxycOpNmaTGBXMrY1Fvbh1R9/AiA17aEDtvE?=
 =?us-ascii?Q?IlOCwAMWRUaxhxHyLe6S+PSKrAoSAaNOYLdZCk05IS1HIlmnxiElvALk/A9Q?=
 =?us-ascii?Q?0fjEUAeYZU7AY3YzxyHtZrTAed2epJu6Wq+NrNu3ZNdqTIejXV7urZ21gDVV?=
 =?us-ascii?Q?ogI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2285d03c-3dd0-42b8-edcb-08d95b37cae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 13:15:43.4345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kX55XJN9FaX+3x/7Fb7vPIHgQeDd0iikEtNgZIiZph+3k83gcPCMRp268+2PgNBCe2eE9+Xl8vek3mvlATajJ31yyeVRiRwSoasvh06nL1sujAA4kaLiy+itjeNwWtSQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5879
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Fixes: 7724105686e7 ("IB/hfi1: add driver files")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v3:
> * Add fixes line.
>   Thank Jason Gunthorpe for helpful advice.
> v2:
> * Assign the return value of kmalloc_array() to a local variable and then=
 check
> it instead of assigning 0 to tx->num_desc when memory allocation fails.
>   Thank Mike Marciniszyn for helpful advice.

Thanks!

I'm curious, did you find this with some fault injection testing?

Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
