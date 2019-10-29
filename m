Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF0EE8BBD
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Oct 2019 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfJ2PY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Oct 2019 11:24:28 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:60481
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389695AbfJ2PY1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Oct 2019 11:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3OzHVTGFf0h15E/dyEczBe2PThG84jt5o7sovYyllj/9CHP1ih8T5gBQLgnJETwu7ygmG8pO78orPQpFtmZjfIN23T9ufqCdUvX7eY9qRRTFRoUy70SJU+mHXjLXvxL7IiwiFTzdb3AUmTy01SnoYvWK+vDqDwn9xYJ0zaSb2UUW7s+VGsTYq9RU9NyDXuQQ9IkSUCCyNgeWytcIzZ1P57I2utDrWpFz1YAALbxDev4HV6xjh1sEynvOlZZhtOVwkxOcylkiFTp/lX2NE7DRZYILIRitQJyMqbLHpv97F/6yZe4Qkd7c/ANvyDn486cxJ3ikBRyqEzAzr57cHbb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCfSSXX1Bjy/5dGBY1MIHj2v7uzupO0f7xP2XudaJRM=;
 b=lupNkKJFEelm3r4FkuZslYuK6Mq4/RF9VYRjg9ldYmFOJwvgnBE91zCvPhL9QXMOiBqF1LqyEYTvcwcQMD3aLoRJwl3MHsZbnwI4U0J57Y4VEP641FHAQU3XcMsGzI6b8NtCHKPQewhEIXV+SCi1GnlWAqDDFhCmGfDjRNa5gxsd15gAfk3LUuNZ1pqdm9ygU4y9Wpax/6KxLyYA38KIdLQTARdnfUJ3U8SRjM2L1wIbJZyZnE5YRzL1DdvXIuVHotgenem3geXKH0dGtcmowL/w1PLhsXd8LSRoTYcc+BSM7/UkLKQElKCnwrZthE+0Jq/DJCsJpeKD82RCehhqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCfSSXX1Bjy/5dGBY1MIHj2v7uzupO0f7xP2XudaJRM=;
 b=ZGN05D5fPqRFI0ivWw0B3+a84hc0mV20ekbhkhkolsbPOudTUV9ciSWD/PnlA3jREp/Vq4yCfIy/p+LJn90VBLx9zdVhWBKRV+8F6SUBvez+R/g6GrjLsDSkI9nEToUvd1ilXSx8enOk+eigG1lhAQ/Xhhb1IAhqlXWSb5a/I/w=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB4976.eurprd05.prod.outlook.com (20.177.50.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 15:24:24 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::b179:e8bf:22d4:bf8d%5]) with mapi id 15.20.2387.027; Tue, 29 Oct 2019
 15:24:23 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Topic: [PATCH rdma-next v1 1/2] IB/core: Let IB core distribute cache
 update events
Thread-Index: AQHVjk+ClBFC02EY0UK7mQp0UZzexadxvT6A
Date:   Tue, 29 Oct 2019 15:24:23 +0000
Message-ID: <20191029152419.GL22766@mellanox.com>
References: <20191029115327.16589-1-leon@kernel.org>
 <20191029115327.16589-2-leon@kernel.org>
In-Reply-To: <20191029115327.16589-2-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0010.namprd14.prod.outlook.com
 (2603:10b6:404:79::20) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53b3b295-dfa5-47a8-b257-08d75c8413cd
x-ms-traffictypediagnostic: VI1PR05MB4976:|VI1PR05MB4976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB49763ACCB4A763E77B1C9D4FCF610@VI1PR05MB4976.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(6916009)(3846002)(229853002)(6486002)(478600001)(86362001)(6512007)(6436002)(6116002)(2906002)(5660300002)(25786009)(14454004)(256004)(14444005)(33656002)(99286004)(4326008)(107886003)(6246003)(76176011)(476003)(2616005)(11346002)(446003)(486006)(52116002)(6506007)(186003)(26005)(386003)(102836004)(71190400001)(71200400001)(4744005)(316002)(66476007)(66556008)(64756008)(66446008)(66946007)(54906003)(8936002)(8676002)(81156014)(81166006)(305945005)(7736002)(36756003)(66066001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4976;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SFAPsH+WB13AdEr3EXnSrumS94PRa0Bnew9+ura/smqH6idiWKiGyPUratQGeMVMHYMM5EIPpxpG+z9p5gecHjaslA/mCT1uApd1ECmSVwQjckFI3NJErhBcIovIzEMBBsvb2gxXGzV8NuwP1XHxHjfCdg9i6oDoota5fI8XUy1BxPeZ6n0JpqyJBjpN6373ny5tpbOxXLWKLSKmHGS/8ISB+MGbVdqsgjwkd15CjZ5t8lf8LTAJj8bnTtLhqZSFOfIqYFofuZcG6GYOMYQ1A+XAyPX2/juZaXhy0Muh3jg6CwRwW+UW/fJL9MPPjwIl1w4hNDXrImkbfipcbxEF2uxSKD2cHzAu4WA1LhKjnmvXQ4dNBcpUBdDKKUBk8dNfyPD150NrbPUey4eCPNnynNOjbtBxxfaUoTc5dLD3pSzp2LWOXexCnOBAY6PzWIJ7
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BB00DB9EE5531F4EB052EA2FE7CD8F67@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b3b295-dfa5-47a8-b257-08d75c8413cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:24:23.5929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzsuAGpXf1AJW374i1FjkKyuvSkb3Vhy60DH0soFtGt7EfLWeoelUl0v2ZkHA3g3LKzncsSlV9KynINrm9idcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4976
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 01:53:26PM +0200, Leon Romanovsky wrote:
> -static void ib_cache_update(struct ib_device *device,
> -			    u8                port,
> -			    bool	      enforce_security)
> +static int
> +ib_cache_update(struct ib_device *device, u8 port, bool	enforce_security=
)
>  {

Formatting

> +/**
> + * ib_dispatch_event - Dispatch an asynchronous event
> + * @event:Event to dispatch
> + *
> + * Low-level drivers must call ib_dispatch_event() to dispatch the
> + * event to all registered event handlers when an asynchronous event
> + * occurs.
> + */
> +void ib_dispatch_event(struct ib_event *event)
> +{
> +	ib_enqueue_cache_update_event(event);
> +}
>  EXPORT_SYMBOL(ib_dispatch_event);

Why not just move this into cache.c?

Jason
