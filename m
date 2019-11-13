Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 759E8FB40F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 16:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfKMPrW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Nov 2019 10:47:22 -0500
Received: from mail-eopbgr150042.outbound.protection.outlook.com ([40.107.15.42]:33863
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727745AbfKMPrW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Nov 2019 10:47:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU58zqYqOtj3uh6lKM+bcZdTofax9ldseY4A5O4ui+JJRJoL1KhYKcE9848X9YzQJdkXwFV1OT1RXyYUfMOS2TOtTe7YbbUeSgoXp54hdnSWpcZtC45PTnIGKC39t1F4Wbu3esKEvVYsntgAdwyjHjQk6LmNCRbgkzFYM/5pZWtzmssO7Slm/uTM+hzosjkzCISWRR96X34r/tN+VlImdqX48W7KtG+PNl88ab4hLQE8E40o/RVlB2b9rXAhI0ec2OwyH38YIuYOgSnPVWExalSquJnr5p4Jcg2SjvbQn4dMblcmBdusAdV1uiPKeEaH7H5wPhKNbWiQmWAEcJxHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7jFV2zKwPYpl11SK8W1draKWmAwiTKouTapnZZ2260=;
 b=ImwraV/gMPTeqpFZppvJ1dbnsOohLCpEjPUscgYZoM43bo7FM9W/b08NDiZVVUpkO466tOni+2uSFHJXOBjps/dHuW0CMZGLMt6FpDsdYiC4Uzq2RiggCOiHJiaIkVarASqR7bpFNvyA5bY8RAtw0r488fTS4hnFnEA2Qp1h1zM2Lv2NROPVsZ0YR/T5H52NCqBCuLocKWvN7K/DlHeJii1bkkAR5H9hb04Zyo0oF/ttugzprOQ4CqR12DRfRjKdcWL8e12CVzHidhlkt++L0V77pRYBeEyZiwtycV29eOaqczlCraxHktOhvx2wSE4J0ZDM/i4nXc+8W1mVExuZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7jFV2zKwPYpl11SK8W1draKWmAwiTKouTapnZZ2260=;
 b=WxkoiLQ5o67jqn7S88KzxKZGi+fJ9dJGyvbpOO4kUTghJSKRaNm7xc//dExc0g9mB3x5xwZZi/Dn/yy030rScKt3biPYgaGXf9509t9A5gZNJsyVhv4PC/5pruT8375c43CzSFWVuea2QTIeQ3EnheXrXfU4eT1eFFVDS6ncAyU=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4575.eurprd05.prod.outlook.com (20.176.2.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 13 Nov 2019 15:47:18 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 15:47:18 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Doug Ledford <dledford@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: remove DMA_ATTR_WRITE_BARRIER
Thread-Topic: remove DMA_ATTR_WRITE_BARRIER
Thread-Index: AQHVmfR777Pe0l0r8k2Ak8XW2xmc36eJP1EA
Date:   Wed, 13 Nov 2019 15:47:18 +0000
Message-ID: <20191113154712.GF21728@mellanox.com>
References: <20191113073214.9514-1-hch@lst.de>
In-Reply-To: <20191113073214.9514-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:4:15::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 26f0674c-2015-495f-faa5-08d76850c33e
x-ms-traffictypediagnostic: VI1PR05MB4575:
x-microsoft-antispam-prvs: <VI1PR05MB457575D07E945C9C12A21494CF760@VI1PR05MB4575.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(199004)(189003)(36756003)(25786009)(54906003)(4326008)(6246003)(6916009)(99286004)(66066001)(256004)(6486002)(229853002)(6512007)(6436002)(71200400001)(71190400001)(476003)(8936002)(2616005)(186003)(11346002)(446003)(478600001)(4744005)(33656002)(1076003)(5660300002)(76176011)(26005)(486006)(52116002)(386003)(305945005)(102836004)(86362001)(7736002)(81166006)(81156014)(2906002)(14454004)(6506007)(8676002)(316002)(6116002)(66556008)(66946007)(66446008)(7116003)(64756008)(66476007)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4575;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LoeOpg/526Dxi1h1MjNL0jUb+FzGBUHYevpsa70vLNWadP/8PJI12jfTpRsrsKKykFRIj7S3fur0biOLQ0ItM4b2w+/plPGeF9RWRJ/KiI/XrgJPFUeCBKyZj+t5D6+Q6F2OHnTKR8LL+kxpRjNbg3EdXQOg+VXpikbQwwxaeBA84BdyBTAhhWGM8dBAOpCcxjHELJAbNd0bkWWKbIfiUmmGKeNVHmcJD2Jig70CR7rt+qCMzWNxVonGWu+LGh2sAm5q8ptT8tq+W2l5k6KDkWqBN0+Mm2HUnhkp1q0aAjL3Pt7dmUpT52SOTpSCFyIHcuf/jyARGTjnU47iREUh/1MpqAvt9rLxqNJtf++1zPWwzi3ffqa8AQDqUAlfa3WjC70gVGx+QAgkU7ooP9jD0wwu/PNR2Fxx94UlaKVgMS5qWJrP0IsSxbSviqOBVOB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98E986531FE78A42B66B495E1530A427@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f0674c-2015-495f-faa5-08d76850c33e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 15:47:18.0450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: At3uNY2z15pAm4+fgMdQ/D4lgyRGSzUZw3070DOYuH2KnPi1xTAJApNT0VedYMpAUQ+wUvdODAAEwmzHZ809mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4575
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 13, 2019 at 08:32:12AM +0100, Christoph Hellwig wrote:
> There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
> now that the ia64 sn2 code has been removed.  Drop the flag and
> the calling convention to set it in the RDMA code.

This looks OK, do you want it to go through the RDMA tree?

Thanks,
Jason
