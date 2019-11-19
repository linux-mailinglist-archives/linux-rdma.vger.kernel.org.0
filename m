Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91C99102CE5
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 20:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKSTiS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 14:38:18 -0500
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:52609
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726836AbfKSTiS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Nov 2019 14:38:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICaINGNJdBs3YuvHe15xTBhVMeq8GqmATexKtZc1iuyu1zudbR7n2IpjYtJOFfItHq1aPgWUSHiKWTSLbC5BfG+b7VWfWOhc2bNH5boVUYUAdUerB/uHzIqNfNMxbbIBtzsrMbKDH9n5ZkjiOnhkPko0AAuq2U7nJgJsY7MoUfWT2thT8NyEMn7liiY8kJ0XNG6WdUM0Gp9sxr466g3dWXGl9vTdNHRosW8KklXYCGEGcxkJhNEUC/L+00bDyQVSrNjjUtYQIHTu6/n3nrblcIsnLzc4X9lTZhxaFaAkFTnb3SJz5WztXeeKiD/9O1/a9e3BgXrhCZ0SWnvIlRw6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HxEm8ivnZfp9wj/qyZADCcVSKZnDEpwYxoptNII4fk=;
 b=SbmWidN4koE+KkAvbWe2pTA5nsd7hlDy/wYiXmv5XFo2Csoc81m35bs0XhkRRJ/Z+GRhQtRZMkPnvNKcIc+QHnb5RngyvpXU/nHPLVavoPzUB+qe9LgOWs0XOhTjyUxTPpHTkpRqU1pCerDbjk6w0GfZxF5Yoat6SyuUkCu6JpsnUA6pO3aF/rWiMSkooZzpxtnyWKlS2qq1MoywWRfEc7AXL4Q14sNJzCYOjsjLJqbyfqsMVMV/vstj/SkUxoa8DHDDpVexZQnv9+aNXbX9vyYIm/9M6DcfkLJ66rrKz1Puy9JoKW0iStaDNtWV5FNyiljFaRSJgnmFUFBeAvdN3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HxEm8ivnZfp9wj/qyZADCcVSKZnDEpwYxoptNII4fk=;
 b=Asl8FrhSgsv3fyHARSFM5p1/Fhlz7K76KrOEbChtlKjrsPJ4C+xXDCvsWLJjM4l0iBZzVFSn7RXOk315job9iCEXJ7qfBTrop4dB4u2/34KrT0Nqn/lHAi9JS2ZAH0ERvmeg6aTNy9sVgThtq81QK4XFea+uUYzdnrSH134ElD4=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4640.eurprd05.prod.outlook.com (20.176.3.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Tue, 19 Nov 2019 19:38:14 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2474.015; Tue, 19 Nov 2019
 19:38:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc 0/3] Broadcom's roce dirver bug fixes
Thread-Topic: [PATCH for-rc 0/3] Broadcom's roce dirver bug fixes
Thread-Index: AQHVnvDlBrbxo1T5mkqjQ0RrgyeVG6eS49yA
Date:   Tue, 19 Nov 2019 19:38:13 +0000
Message-ID: <20191119193809.GG4967@mellanox.com>
References: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1574178531-15898-1-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:2d::25) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f503cf82-27d7-4dba-26d4-08d76d28046f
x-ms-traffictypediagnostic: VI1PR05MB4640:
x-microsoft-antispam-prvs: <VI1PR05MB46401E77BEF2842972C0BF9DCF4C0@VI1PR05MB4640.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:182;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(6116002)(6916009)(4326008)(26005)(99286004)(229853002)(6436002)(8936002)(8676002)(1076003)(25786009)(52116002)(76176011)(6246003)(81166006)(81156014)(6486002)(186003)(5660300002)(86362001)(3846002)(476003)(66066001)(256004)(6512007)(14444005)(102836004)(71200400001)(71190400001)(386003)(4744005)(6506007)(2906002)(14454004)(446003)(11346002)(54906003)(66476007)(66446008)(64756008)(66556008)(478600001)(66946007)(2616005)(33656002)(316002)(7736002)(36756003)(486006)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4640;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wy0lZr6ZCYnRLCDEYdPYd4TMaLw8R0BYGBghk7U71mugx+pTEHjJuadJPtH3kHrBV6izwuZrcWuAjATj/pshQTAZaVATqzZbVGjZe9PK/UWAIK5Fk/bIkzAhRYji+g3rPdpnOeN+NIwNjGbbw5G8MH20UwDor9XPRmU2dRP6wXzk4yhwpr9wICnwOfWmPSynCqDihjAH0WxSefj6rv6dnU6SiPf3KoZg+o8pEpoUWkVwjEeQ96OkWCuKQIVqZtnsqfR2Tbusy93vDnDTLgti5Td6eh//lUgSpVNDCJKRQoTljX/COckGNlNKY638Fs3rVEEXBBew5V+lLg6M0MeiL7ySvo1+Q1bY1vegcsOM1bem/vIcSjckvChvhlKKmsfK3ZuY3pq+q2mLZ6QqSY8bN5sQAsjB2HtpVzooHFTnTfrBvBNeZpp5f4BgCShHEovb
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D0502DB716C02408FDF35074675C7E7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f503cf82-27d7-4dba-26d4-08d76d28046f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 19:38:13.8026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+QgB1QwIsZv1mulKpXJSt5OnFLjA7HYs2Ee20Zk3v6dd16NKeHR3A1vfawC/RftKP57fdTh3ggV7RTWi08cEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4640
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 10:48:48AM -0500, Devesh Sharma wrote:
> This series contain 3 patches patch 1 and patch 2 are specific to
> Gen P5 devices. Patch 3 is a generic fix to silence few sparse
> warnings.

These commit messages are not suitable for -rc, and a sparse warning
fix is rarely appropriate

You need to describe what the user impact is of these bugs.

-rc is done anyhow unless something urgent comes up.

Jason
