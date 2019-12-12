Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 709A211CCC7
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 13:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfLLMGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 07:06:34 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:57959
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728996AbfLLMGe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 07:06:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kghdDb8v67goZahcGgju2kI28OwTiJAmqsUX2ClUKQQsdy3DSdBzTRayxkUMPTKKRIj6CcRk4reSAQnVndYv9HmqAG6PWj7OmM1NuOUhLTwannOGB+Km7g50LOGZFC6mIB0sy03op2GGXF54A7AtdaIqayruUy648XRkV/oS68nPPVNxkKidhT8D5UvrEFNjWOKTakqQm2w95BUUqxix5iTGqBcHtxn6RpKLuAQQ9og7wWGMgdNZDiHjhhy6RBYb2lTpSBU7MW7Z9ZY1nxBfxINgci5cdnuU1f9gXsHfr6nzIghLJ5ZVTJBjOby3+gznWoII+dGW783cNRgvEhuHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh2bAR47q/dXH38RSEkfUB/ory4aL/mn/rlmXbH9Uo0=;
 b=MBBpV61yyqiu/WdfNZ1NSW2/hL3GawIP7ZjGV42ky0u70/p/DGCY94ydZSjheASr7ZJ9d/94IJa5ZE266cqmRQNj85BbSyEgWwhnOc02Jcpx9X1HGwioxQ6aWBpQ5cZu/v+kbMTez2Ifn1nBVSj2n1OzZGbv34jfjJ/11oce9D72syAn9/SnuEv1fm1khhIOiDdpi7KClA08WyANuw6oOtkITJqj+JTVyocsDgenPZKnu3HpfwjzYajF5pFSJn41SIn4/Qvot+ZvS6qsAU80kNUotRmVEObMveIbbfAdHI8eYhHsvMVtDP2QVPJJV1K8h3iBBj+TSlgzGG1UYUAsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh2bAR47q/dXH38RSEkfUB/ory4aL/mn/rlmXbH9Uo0=;
 b=RMjlsNCD3PCBb1Qljd5vAJlcHMTmZAX4/m2DEQKc3cA2X89XLiUEHh+6xotdQrog0C1hZWpwEv6uN/65mJvj4voVCL77hS46YUQx3A/cOjwVEc6nuXIfSn2IruNSZL9ZSNuX1o6HAoAAUe1Mnlt1JsZnsNvbtRS90YEwcilws7g=
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com (10.171.188.155) by
 AM4PR05MB3457.eurprd05.prod.outlook.com (10.170.126.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Thu, 12 Dec 2019 12:06:29 +0000
Received: from AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398]) by AM4PR05MB3137.eurprd05.prod.outlook.com
 ([fe80::e5c3:58e:7e9:d398%7]) with mapi id 15.20.2538.016; Thu, 12 Dec 2019
 12:06:29 +0000
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Thread-Topic: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Thread-Index: AQHVsOSWzFdw+h1trkSqfb9zGi6JJA==
Date:   Thu, 12 Dec 2019 12:06:29 +0000
Message-ID: <20191212120627.GY67461@unreal>
References: <20191212093830.316934-1-leon@kernel.org>
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR05CA0004.eurprd05.prod.outlook.com
 (2603:10a6:208:55::17) To AM4PR05MB3137.eurprd05.prod.outlook.com
 (2603:10a6:205:8::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29413736-9740-4ff9-7a19-08d77efbb870
x-ms-traffictypediagnostic: AM4PR05MB3457:|AM4PR05MB3457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM4PR05MB3457AD369A12C8A55BE84FBEB0550@AM4PR05MB3457.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(558084003)(9686003)(6512007)(66476007)(66946007)(66446008)(66556008)(64756008)(316002)(110136005)(33656002)(4270600006)(54906003)(71200400001)(6636002)(6486002)(478600001)(8676002)(6506007)(4326008)(1076003)(5660300002)(81166006)(81156014)(52116002)(8936002)(2906002)(186003)(33716001)(26005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR05MB3457;H:AM4PR05MB3137.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQAkOJtuVXTAzGru6sBXdrMAjJNYezaofk4/iNhoitcqRiPEPE4i8Q44KW759U8C6KQvIjeZ80R2yBdcdtYeIzK+mFg13ENAtAfJ/aKmMhMINnm8hyuE+zCcjFJSzWW5MZjnBSmZEDzavPbQf4J5J+UIhu2QwsVx4oBUv0pfKs9p+Xj+cantItYx89onpnm3GHCrzN0zzq729ydKpbYyvpn9T3lz2LRidVcHh/G5KRxz8RpncQZ6ERiIg57RYC46rS2L/P1ZfNYOSXriWjSKSfk4Hw1WmeYBLYPt9c0jM2YBUGqQEiKKycx4wgyj43qyx62knwID3kL5UAhiAPonlunABiVSkSxmPC2/B6TEjEU5LJKv5RsC3qtnQQUDhcyzRLNrvXcDEsQw3CedIE5yjbAyxSfbS6SsmrZe4HCJWge6QAW3OJZbRLH5xa5nMh8I
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CA0821C1ABB5D439FBE3771A86B3F98@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29413736-9740-4ff9-7a19-08d77efbb870
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 12:06:29.4353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjifS6JawfVrorbKqLu4U8TQIGAaJFINWcgalDtX0agI/hk0V5tnkoaS2WpdczcUu23kx0iCvPjt9XNQPpOF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3457
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Of course, this series to -next.
I had a bug in my submission scripts.

Thanks
