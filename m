Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4610CA47
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2019 15:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfK1OVg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 28 Nov 2019 09:21:36 -0500
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:42073 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbfK1OVf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Nov 2019 09:21:35 -0500
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-rdma@vger.kernel.org;
 Thu, 28 Nov 2019 14:16:42 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 28 Nov 2019 14:18:16 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 28 Nov 2019 14:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsM52CP3hc/8R8bxjj3wCK26hwqeVJ5PxrZpLUaYshkcao18rZXVj40sU3d5HoYywfJK2T28mai1n2AKHs23JR7/YBARS9BlrOtVou6wan/x5s/g+9FuAgefTOnt6dWDoavAMH1/rHpwDmaGkYnsS3u14LUQeoiIuBflIl0eSfiOu/cMDIg/Br+Poh/TlMxPGtY3iGqEPqVbMzvL5gOcqY7/olvrGT9GutcZSsX1yG7HNf81MQmGu8mCW9zGWVbPcssVqm4Jv3JORPXxHakYp5kBUrSd4niAf8xPsGWcgeKPVHeD3YbYxrGxE8/ggFdz8Xr0UnMUFWkZdX1GWDyoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJktrLUDkAFNJCq6qVLOYQS+HurS2WBz8UhNy1fkNg4=;
 b=AQiiEQOS8E26FZACnnliH6WdCYmE0WqdemSzlL92o2EAgmAid0nUP253bXiraf49N3yWlzxt5eyegWwmWwFxXJFRgjsuuu3iXTUytk8Le7u/mqLgXrk3fNzaSdk/2JiN7AA7zTn11yoT0otyGb7qHfHbJy7JaGy29bfYFlbNpGRr8EoFFfX/DLLDZqbKVuSsNTRzQo5UNxZ8qiImSGe/WBOZrqaX+mboFNixMtO1lSTerviJCHDrDxKyJu9vDwvPHfp9cFWWipSDX0tF4E1mJCT2sBGD5HXMrH8NO5k8JOo9xnv6faWreT9is7VJn288DkZd1Tx9EsrEmcBqCwS0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3298.namprd18.prod.outlook.com (10.255.138.224) by
 BY5PR18MB3121.namprd18.prod.outlook.com (10.255.136.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Thu, 28 Nov 2019 14:18:15 +0000
Received: from BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::948e:c2f1:c1f9:2923]) by BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::948e:c2f1:c1f9:2923%7]) with mapi id 15.20.2474.022; Thu, 28 Nov 2019
 14:18:15 +0000
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [ANNOUNCE] rdma-core: new stable releases
Thread-Topic: [ANNOUNCE] rdma-core: new stable releases
Thread-Index: AQHVpfar+MR4ZSh+skKhdX4KtXIbaQ==
Date:   Thu, 28 Nov 2019 14:18:14 +0000
Message-ID: <BY5PR18MB329819FFCF162131B7340091BF470@BY5PR18MB3298.namprd18.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
x-originating-ip: [90.114.93.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99eac421-49d1-422e-25cc-08d7740dcee8
x-ms-traffictypediagnostic: BY5PR18MB3121:
x-microsoft-antispam-prvs: <BY5PR18MB312100E7590BC617EF07EF38BF470@BY5PR18MB3121.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(66476007)(64756008)(8936002)(55016002)(7696005)(66556008)(66946007)(14454004)(9686003)(66446008)(5640700003)(66066001)(316002)(478600001)(71200400001)(71190400001)(6436002)(6306002)(966005)(33656002)(256004)(2351001)(6116002)(3846002)(52536014)(25786009)(26005)(7736002)(305945005)(186003)(74316002)(102836004)(6506007)(81166006)(86362001)(99286004)(81156014)(8676002)(80792005)(6916009)(5660300002)(76116006)(91956017)(2906002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3121;H:BY5PR18MB3298.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukzxfX/L4hSJSIB3vcJ0jNtAid7C2B9XQCZFIAV9ESvu1rO9c9wlsMGVyw0UPK1/CpwEIyFCFK8zcqm9QODAqMT9K5/ggiUcpO0qGXnk4oLhQpJCkDruVSDEwLzpVJl1WXlmHBPks6tbC+yAWtmW06k2LmJLmn1P7nAgIvMq34MfHsNFjt92c4WmNwUtubcE1I5r3PjmNuu+0OLvkSRh4SUv0YkF1JZlFvWrWFy5l8F0/YL5a4DWLV/2VMfrazT1ARfHHFK6MGAor9bHZafPn2IZIfaScPaeCPQDKMfpmfFCSdPMuUqHlFJosXg35rlPZvFr55DU5HNAp38I3yCMb6/9dZuFPs7vMzTbAwOwjpxLjEusSoIlU2Uhgbmw78lszNB1R9cFtRuFpRGs2cg8H2/SslDLygIBTdKyBcg9f7RlertXk7MN6FSMm82E7CD8msT0nYR9pqW61nBmj36jrpVjLr1/8eJ8G/06d6bqZCE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99eac421-49d1-422e-25cc-08d7740dcee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 14:18:14.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UySWz3r6Q5aJKQ08HZ8mxkbfuVb+WDzn2VSokk4FvPGpm756FNZiXjxRNwKoNG0FZMEN1Yu4CMHlBGLadWrHJgO9nuu0Y8/PvFDnf5B4FE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3121
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These version were tagged/released:
* v15.10
* v16.11
* v17.7
* v18.6
* v19.5
* v20.5
* v21.4
* v22.5
* v23.3

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

---

Here's the information from the tags:
tag v15.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:07:56 2019 +0100

rdma-core-15.10:

Updates from version 15.9
* Backport fixes:
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjm8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZC3OB/wNwM+JM1MR92460T4j
V6fjqGjMrPsLqkEJD/9v6o9h9XpY8/AnwnZ/Q9Z8Xq2iOBEX5BcNaJk2U8Aam18z
flUJxqeLZlfMFIxBZGYXMHXiYnsvocLrtKb3mlL00Lefggh055moR0kwxVVnSw9e
mgfvPXOb8ZwAlte9jq9LVv5piDnY6DiaRTcAeZB3g9l9kmQHXN5fQG41EbHSRZrL
kApnUQDXhiJON0ox6x/JdSKPdGdm9NzkK9A/TkOPGBDsVIvVboc/EOl83banl5tK
dNF4QqmmCg/6+b3O1A3xoz/mgsyMs31ecGgATF/ET7W/g8ZhHAqtc8Y574AkSzcn
t11O
=wmY3
-----END PGP SIGNATURE-----

tag v16.11
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:04 2019 +0100

rdma-core-16.11:

Updates from version 16.10
* Backport fixes:
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjnYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZC2hB/0YNyTF0K5m3izIx6zO
046VVpJENTr2nkxN1IQWa5h+g2ttpRqTL1i0Ae223KyeJ5h7MxiYKmNPMFxM8sbz
pBdxfmoISYqmJ5hDW9LAAi54Bjp3waAR7G83s72jdQK+JIpkd3TLAE3nWIXl55dS
PettWsI9fiqmUPfuTYeKOllEL/i+to+t9ti2HWcsySARD8AdaNtqKiCuRy7tBEXq
4asXAEChX0LoyfsbEm1eUVDpJFGSluFcqblhScfCbv94bf9MtiT3uhKO/ycwyJAb
iEBL7/vnTirNhujcb2ek5eeQy/GDvzpMEK3v8gfF5iU7A/ENZ/+Z9SqZmgUMEl+4
46gJ
=cxgi
-----END PGP SIGNATURE-----

tag v17.7
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:09 2019 +0100

rdma-core-17.7:

Updates from version 17.6
* Backport fixes:
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjnocHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZIixCACNO71naAOf3epCHR/t
n03o/1GLEgaIBzhKLe3LdpzJKxOeSPHDx8vJcRpfxDDzN/KP1EweMrQCs8Px17eb
AGyjLgVjwvqyPiohDqiYgYUfyUkd/VpoHRF/APQvU/unkyVKMxFnq7Lj7xSxuQTG
PGhotnweDKm6sVapPY/Ve5m+akX4VoSeltVx4DDXt3TBzmqlc8lBBkPO8a0W2R9u
CNsboZuFz9wOMo5F6+YhTKd+6vQSXw64d5h4DNWv6WQYtb/0SkvQmzzgoWLENC7K
eZ1LXCQkqOTpUHuUQ5f/4P35oV/dNiKvykHmPzwtF0kgX6auDf5Ou6NLECeYeIHT
R2OY
=d/gD
-----END PGP SIGNATURE-----

tag v18.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:13 2019 +0100

rdma-core-18.6:

Updates from version 18.5
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjn4cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZMurB/9SStpyR6Su69X2GcnU
YaqNUQ/pzw8q5H4mhIGBniy6XZska4+SpYLUxqeWk/ppq6kcPQGsLnmrOkx6iWcB
IRtx+AR3FFbF5wTYPxogfoYdJlxGM3AEiukB2AxKz7GF7fbm8pbgi3v0Xm53uI5N
0qOdeqiH8VCehEpIkVp/YJvCF8+rnYdFrrTgd6l0suJAbXBp2ur3Uubm9i5L+QR0
YYtzLn6rd6wTIsEXLy4ZcZASazFcHrIvS9k4curzPoqNObo07cFARfDhhqkgdlSX
7FI0Iy3CYjaVa+Ul/6nVwIKnQCf94WbRCEPfOYISF/jPfI9B/4tG/A2OVHjFeLBc
Uanv
=2dX6
-----END PGP SIGNATURE-----

tag v19.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:17 2019 +0100

rdma-core-19.5:

Updates from version 19.4
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjoMcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZOJ0B/sHH4s7Xyc4Ql0/5jIz
WTw94uFawdiuninGAepJLfjSobDyQGSKf+0wWoHuaB3BJy19KBMSh80n1KAKxPBb
tQasm9gBJqzi4l5eUW9gN8wAZ0o7mpLWFldHuNBU9kKrrhDLuwAEQaQiRaskGd0Z
TnUxpsLPQKXUryImRuEa7puTN6VAgLZhsxSO2+cOxdutPIdEzPevmqd83vRROOa7
5PqfPo1O7eRe7QWwaO6xUDsEtHm9FRchjDAj9A55LU142ikbH4qkwX0GkChjBjgr
Q+eRPSiWtqXD8tjLPlnG5KYf1knVkZNr3HqLzLIUVhtfoGCAEWFChUtme21qSghe
KTMf
=h5m2
-----END PGP SIGNATURE-----

tag v20.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:22 2019 +0100

rdma-core-20.5:

Updates from version 20.4
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjogcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZAlnB/9uaWEEiBDv2i8thknH
IIkHYZ4Mh1Ip9fzFpRzo/5NzqswNL1mk67vPQA9RZTb214ojmHhn+yiRp12cZY41
/Nq5arQsEGqmZgzSrecLXWDoP2cltE8yK0NzGX4wigQAfPAt8Wo7czuRYu6t+7fZ
Z3VGc99bxdcUgESk+fUOByirQeJQhT7fNDbO1KjAta4P4FtyrgQ1AZKoxAYVszwW
DzpdbHdxlZOSKYZu51xU6R0kqAgvkcm/vFFw+v/LPl/QinpnlHBa+1+MdET/IUnb
h/CT2i+uzo8AyozS1hJ4sZni8I7e++HqzKpzlylv+byXQIWrS8jbDJVBrltLAs6O
33Sm
=h/XJ
-----END PGP SIGNATURE-----

tag v21.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:27 2019 +0100

rdma-core-21.4:

Updates from version 21.3
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjo0cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZAGoB/418E5/Qn/ezYM/Cahf
ic/8r3/S66u69REiIqAIpAtErKjCm0eVW+vnhm/jIo/uPMTWGaxFOnqqas9YQen+
JAxO3QpAoCPwbqDvoJ6zNx340HU7rea+YorKml5ast+DSNC4Zbht88rnroAuXPnI
nqdPpkrktUkZAbYdTY49uow8ExAIpi3lUB1Jd+ZnwaelA5E5Iv63JvDG7i16uNKP
PhmDUAnhGPkpfEr3xSjYFUv3zaegLPPnJdYs9MXhvrZT4FA5GYjs4Uu0Qq7iB33R
eSLjv7m5KmdE1pwc1SGu79mOnyYtMSxhMHGjWeJKWRJtbHMlSq5F9yrfNZAFntng
OLit
=2f4v
-----END PGP SIGNATURE-----

tag v22.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:31 2019 +0100

rdma-core-22.5:

Updates from version 22.4
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjpEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZI7mB/98VU0RhrXYgxFRQaaN
awqHYDiWTlF6DWbsCnLE26dnTVQeSdA89/R4I0BnLdKWc4ZAOne8tOA9ltC7u8T1
QQxdxc8Uog/FL2qTI14UQk4e5BF0l7gvWCjUGm354sgSTIM5td0CSLOyYbGHLfX5
2399h+MKDrZ6fxxv9/MTJk3sWpR25fiYIU7CKDHpNAyqfZRKmcI1Eud4HemQErbp
7syFBoPNU1RA3xfRfal8f/fAuAxaxI/j/hbaYr0glnTOCMASGh+YmRbtDtUhIGP8
zaC4XiJsdctU9IN02p/jIBvQcryNRBU0eF5re/6PxBGiqfCyDYeogKvZ+Ss/mYHk
BPfU
=YYdY
-----END PGP SIGNATURE-----

tag v23.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Thu Nov 28 10:08:36 2019 +0100

rdma-core-23.3:

Updates from version 23.2
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* verbs: Set missing errno in ibv_cmd_reg_mr
* srp_daemon: fix a double free segment fault for ibsrpdm
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3fjpUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFkKB/4l147FUSszvCNDxOaF
RgL85kAN4WaKc8eLh5deb1oPaBl3FW7D72fYJqGQ4bsBo9VkWICbt4Q+0/QP2Ko+
65KFygT59oZcMhBZ8OHE+pXKQ9xVelXm1pKea8n/QjIqho4TjNxtsWAsEta3uk/g
PjQ3IyHCdlnDWB9zU1HqM7W/80tAZnqPzR5d2N5Mq/37n3m5KHjWIFJz7PYiqsmf
YlOt4MUVoZRfZnE5xDxgfhjQ6MA+oVW4dnbG45EXeN8g/qdh1+DpcvwKcpjWjf6T
JjaRIiwhZHItgHfF90ZY34uekW/2BGji10roklWbHoBbbi7GBPmL79HPo/eBE1QC
Du4q
=dfqh
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases


