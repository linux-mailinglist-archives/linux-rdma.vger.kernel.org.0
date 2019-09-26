Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3031DBF495
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Sep 2019 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfIZOCy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 26 Sep 2019 10:02:54 -0400
Received: from m4a0039g.houston.softwaregrp.com ([15.124.2.85]:38241 "EHLO
        m4a0039g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbfIZOCx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Sep 2019 10:02:53 -0400
Received: FROM m4a0039g.houston.softwaregrp.com (15.120.17.146) BY m4a0039g.houston.softwaregrp.com WITH ESMTP
 FOR linux-rdma@vger.kernel.org;
 Thu, 26 Sep 2019 14:01:56 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 26 Sep 2019 14:00:00 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 26 Sep 2019 14:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adrAKUw/cIYBoWB2DmH6CnNYIJ6nkuebcRpRRv1buAaRXZAME2gTxcx+cg18S4CMnCBpsGVlqTpgE8Yv0/rBi7RqCzuXAmiwNdZabcNa1RoYKvSlQxrpMKik2NvAsMEDAqTDRVwyhjCp5/O9BQQRuwVG1qC9mmKEmAljPeljCe8ttxB7jssS7WCNWMlXYGcBavDTYiSxfqYPbCPoYUb4FuyFw0VyxAVu5egzMHqURZMyhyB4W1eYgnQ2DTuf6Ahe0U6BxcvCXpWZEORTipYq/Tgg/P2V6bIWYlC5kJ/1oTk0R26fv0Dl3Gp7p4VqaXx4axe8pPx9/UCWwDlMWOtftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8xhM14q3QqqjTJ7SX8W3newUkmqomO+0aOSAyeTnlQ=;
 b=Jlr/eX4fVBlGoeiUqAR4XfaY475Qk2A1v2w0gNV0NSo8qz3U60RQmNzo4fEit9N/vu90xdyVWF7nL4xIOIqjj/hs0yIox91Cvog1t8JQ8/btjpKwDfjdu8R7PFiO9kqh/qPlChNrna2M4TPyKaydrxmuTrP6/P6IbZ+tYosb8ZmrW0MDjB3kITgfMkzJrbq2381pjZSyTx9bbFd+Q6nf610hbB7XhrwSICKcTsH/dLeNDhZreR+h/8zOE0QEFfOEodh9903eTN29vYElUs2OYw06EiwIzsqBdjMPKUyz3Ee1Y3CH5LY4+ohG5/KUu1baSo28tdlgAqfvsFbxK618jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3298.namprd18.prod.outlook.com (10.255.138.224) by
 BY5PR18MB3154.namprd18.prod.outlook.com (10.255.137.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Thu, 26 Sep 2019 13:59:58 +0000
Received: from BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::6cc3:48d0:8726:7005]) by BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::6cc3:48d0:8726:7005%7]) with mapi id 15.20.2305.017; Thu, 26 Sep 2019
 13:59:58 +0000
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [ANNOUNCE] rdma-core: new stable releases
Thread-Topic: [ANNOUNCE] rdma-core: new stable releases
Thread-Index: AQHVdHKuFCvy6grTXE6kOb+dpZHsHQ==
Date:   Thu, 26 Sep 2019 13:59:58 +0000
Message-ID: <d4c12c2f-befd-2737-077d-30fbe6eb3799@suse.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2PR09CA0003.eurprd09.prod.outlook.com
 (2603:10a6:101:16::15) To BY5PR18MB3298.namprd18.prod.outlook.com
 (2603:10b6:a03:1ae::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.200.198.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21bd6388-5d5a-43f0-593d-08d74289d148
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BY5PR18MB3154;
x-ms-traffictypediagnostic: BY5PR18MB3154:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR18MB315454EFABBB1B55D47436F3BF860@BY5PR18MB3154.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:534;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(54524002)(189003)(199004)(486006)(2906002)(99286004)(8936002)(386003)(6506007)(81156014)(102836004)(26005)(2616005)(2501003)(31686004)(2351001)(52116002)(186003)(476003)(3846002)(66446008)(66476007)(64756008)(66556008)(6486002)(5660300002)(305945005)(7736002)(30864003)(6512007)(6306002)(80792005)(81166006)(86362001)(256004)(14444005)(36756003)(66066001)(14454004)(478600001)(71200400001)(6116002)(5640700003)(6916009)(66946007)(6436002)(31696002)(8676002)(71190400001)(19627235002)(316002)(25786009)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3154;H:BY5PR18MB3298.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tqsoAYR7rssVSTg4bhTAVBMI4jCFWZMMmchm26bEuCsHJD2Al5AzZ3x+AStOmi8546IAAB9RpT9pJC/NnVuToDpQJ0jeXB+370M1maK1RmpYXC3cSubioGcRjOHQwI2rCnt4/qY3kXUwELaBLo37Cc9QCKKGnf5diHJVH6bDtL7k1BrKIJTUEmaZCzsG1DHbGauHT3g9k54Q/feXm9UJ7CUJnbp/92WtHKfcTLlngVlsZwgtep8sE/ZQ8WSdRZiYf8YVTrLvIZT93YFwC7zJhpKykGHNwH1vkeq9g61x5ODKbib26OLiVWUYic3e55ezOxc87KleiNdGAWLIWzBw+W3xAK6kcWTKeV+zo8qBI9uNzRmFPtk6Hr8AUF9+nr41FUFehM3QY8oxwEySQ8tXaJH8s6KY2/AY2YLaimM/fMW/piiwWEs43Ar5j/dy7NxABLWl/0wFU1benq0WPxestQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <9B65EDB9CCC5134DB46C08F4A5AD58CF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bd6388-5d5a-43f0-593d-08d74289d148
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 13:59:58.7145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOcDBAoM5Bk3ODT6VGN5llsO4do2CaqqLGxeslTzJ9Bq9J41WP7dCrqE4V26ng31peZ7m7DnPG2cHpjoatKX+ghoVgN0NlPQkVBtI0JFXno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3154
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

A whole bunch of new stable releases.
Linaro publishing multiple aarch64 toolchains and Leap 42.3 disappearing from available containers broke CI for almost all stable branches.
So even if the older ones had almost no fixes pending, they are still getting released with those CI fix backported so we have a clean slate for later patches.

These version were tagged/released:
 * v15.9
 * v16.10
 * v17.6
 * v18.5
 * v19.4
 * v20.4
 * v21.3
 * v22.4
 * v23.2
 * v24.1
 * v25.1

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

- ---

Here's the information from the tags:
tag v15.9
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:23 2019 +0200

rdma-core-15.9:

Updates from version 15.8
 * Backport fixes:
   * cbuild: Fix packaging of SuSE leap
   * cbuild: extend CLI to pass --with[out] options to rpmbuild
   * cbuild: fix python path for leap
   * buildlib: update SUSE validation targets
   * travis: fix aarch64 extraction
   * suse: fix dracut support
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqJUcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEZkB/4+esxgDVOJGorCurRh
NEnWvExOEZ/jXgVo4k/4vhtIsEeDQjizJ1BFvhz32pcO18mNOn3bNMjdOgMQm+C3
CIj3Kwi826A/GhUkJwem6NvhvXMG1CdDbCVzvEDzmiZ60+thjR9VXhFbJRJ2Ontk
vicg4qb5sjmCOQbvlTFCEiOVAD9UOSUzfiZjAQL8SXl7ZOmLV+MNaGAJ3Bowq1tR
NKuU1elUupChkTfiM8YYuQdpE5zPM71PP2TL+4nXL48NcApoIuIQHlTgU8L9/TX5
cyIPwYa5MBHM1yR42fk2y0Kt/30H8rFPoZLse6hIw4wv9nwLpPdUOmQg5JuQi9Ji
CUzv
=5J3M
- -----END PGP SIGNATURE-----

tag v16.10
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:30 2019 +0200

rdma-core-16.10:

Updates from version 16.9
 * Backport fixes:
   * cbuild: Fix packaging of SuSE leap
   * cbuild: extend CLI to pass --with[out] options to rpmbuild
   * cbuild: fix python path for leap
   * buildlib: update SUSE validation targets
   * travis: fix aarch64 extraction
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqJwcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZBCZB/45ntJJCjoizZXgoQK9
2fUkFmcTro8TOb2R9xCq2in2WtIaIZLyJMxZkZw9WhLCsZjGXeCj9tReZMRPpIl2
t+p3bKG6Ox1u0g+BNPlZfgDsH+31sN/lebpkQQEIUhqixCf+PZy0ZzwMx1HciWYJ
5NEPRlTgJPk7iiew5au5gH/eNJooPvGe/eT+AJ42F8yvvtB2WKLOedqIQXQ7wnFM
90A/FBCAw+cPGge+nKjRwIhq7RYKfH8QuUv6u+V1verJoBUnVtoJxySsZcyYe2/I
ht2lzUjxfrI9CV/GdHAHvhbxyjEt5Hk2VsGpbqPrTTU7rLG1EzkOIoNshm3nA8x8
hpoT
=phkl
- -----END PGP SIGNATURE-----

tag v17.6
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:35 2019 +0200

rdma-core-17.6:

Updates from version 17.5
 * Backport fixes:
   * cbuild: Fix packaging of SuSE leap
   * cbuild: extend CLI to pass --with[out] options to rpmbuild
   * cbuild: fix python path for leap
   * buildlib: update SUSE validation targets
   * travis: fix aarch64 extraction
   * suse: fix dracut support
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqKEcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZN03B/4sxVnl5xbZHtlkN3i8
f9cvTcHsSZQ7TbC4ndxCNz8gxKBE6f2PuPfkkTeMpVK+6oUlywu4M5c8d0wIaoKe
0qtEufizFA7A3ju7A416uqlmxLoe6aSQOZTkVDb4VjgBR6WkYc4HxWV0ZGg9AAoH
1Ww66s9A/wK7ou0J67dvesLdvLCY1w8929drYPWtDxTi68ksmL7abonHrke9tSTe
L7jyWaUETwCqQeMr2WD1p3DOhfR2B1tPMZtYvYkfcDU8blMm75+cJP9hNJV30Uiv
U0HydLxJCALx5brkrtTSgERCuwBDpeQIhISyeiD6/FZOCBp8HLajuSsCB8CxNZey
TxgU
=YlkW
- -----END PGP SIGNATURE-----

tag v18.5
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:40 2019 +0200

rdma-core-18.5:

Updates from version 18.4
 * Backport fixes:
   * cbuild: Fix packaging of SuSE leap
   * cbuild: extend CLI to pass --with[out] options to rpmbuild
   * cbuild: fix python path for leap
   * buildlib: update SUSE validation targets
   * travis: fix aarch64 extraction
   * ccam: Properly enable ilog32() calculations
   * suse: fix dracut support
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqKYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZPYLCADCOZhh5v80/Tr8fN6I
pwHaxH9ypDYeuvnkbASYiTNFak8sScUTirkaYMDuA+7XNeNeYfhRa0y6dRhz4Fnc
hi/EV34qy4HN946MYwb4UE8Wk1f1SRfHBGInUvIwzr5bWoRxBeYg4P0wzQ6DOWqV
d2gacHqtvdk952kGwsyUAN65PE/1Aq8nwqGBHwNAwhYpx6SkgXYBxru8QOmp3lxT
oip8L77vIfs68nf07fcJP6MqKzFnRh7+9S3sYND1Fynlt6Zcv94TQdWCpgEXbWwa
q5S8ECDZXo+ignUlGJq25IPDGSg5Bw06maeopXy/q29qJEJkM8SkyPyxTB1ZIpRD
fCpX
=Iu9E
- -----END PGP SIGNATURE-----

tag v19.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:46 2019 +0200

rdma-core-19.4:

Updates from version 19.3
 * Backport fixes:
   * cbuild: Fix packaging of SuSE leap
   * cbuild: extend CLI to pass --with[out] options to rpmbuild
   * cbuild: fix python path for leap
   * buildlib: update SUSE validation targets
   * travis: fix aarch64 extraction
   * ccam: Properly enable ilog32() calculations
   * suse: fix dracut support
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqKscHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZNHEB/9kVCOYWcOj3WItD5T6
O3pwQynd1arRYzzfhCzPqQ6YmCh8/6S1T21Zi6+Bh3pBuz4Hkxb+nwus+ddZVASx
geqIOyxSYoEu4WW69vth2ZI8dOT4sPSik+TnGG6JQMUfIN9OI2JCYYUb6GyHWElZ
RdCAuFlzkaLkBfotc+UR0DxZx4B3XU5lXL/oadFQnZR3t93nxes8vio9kUyEjrZi
isa7PmwkTiyTR/yP/tjIksy5QtSvG8HrWdWON+yICUjPKhqSDdinitEVMjhCeaZh
49fwltJRG20nfvMxA1PEhTfTg91e2270WCvlXBoklIMiE4BslKQa3qYJBhfi8naM
d88y
=SX4Y
- -----END PGP SIGNATURE-----

tag v20.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:50 2019 +0200

rdma-core-20.4:

Updates from version 20.3
 * Backport fixes:
   * cbuild: Fix packaging of SuSE leap
   * cbuild: extend CLI to pass --with[out] options to rpmbuild
   * cbuild: fix python path for leap
   * buildlib: update SUSE validation targets
   * travis: fix aarch64 extraction
   * ccam: Properly enable ilog32() calculations
   * suse: fix dracut support
   * libhns: Bugfix for flush cqe in case multi-process
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqLAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZPKHCACZTMuf4mi9m+nA4Jpn
WXS3sHr6O+JnHtilbjftK634cDIeu3IIpDmrE8oYUY0x1pU4mSYA/nlZ3B/kFmRM
TUjyswSnIi4Dck4wPJySmDFjs/Qbr+bwj6lVBtO61I6Pbu1VRsDGngUuIiSsE6H/
90t+azFI6evtif/ch59yKpn8iMX1P/40zvaeerWGbVlMt2U1NG199m4fiwqkqG3N
ltled2m0XWwj018Xv3ofhhcBOODcj61JWL7Bikyi1U4XFTr8piCMy7TV6DioZT2Y
164J11n0BOoQZcIDDS+qeYInGwBeWGj2Ps4Vky3jj96okEyb5NN4Sb8D6BlNM6y1
qpVG
=nZEn
- -----END PGP SIGNATURE-----

tag v21.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:01:55 2019 +0200

rdma-core-21.3:

Updates from version 21.2
 * Backport fixes:
   * travis: fix aarch64 extraction
   * ccam: Properly enable ilog32() calculations
   * suse: fix dracut support
   * mlx5: Fix man page of mlx5dv_create_flow_action_modify_header()
   * libhns: Bugfix for flush cqe in case multi-process
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqLYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZF72B/95bzRJ9uOelzMOmL3D
aarob6epVYs9/96p5kElZyV82ugctqLppu+gBVcWP6uQM2gTh+cCu/B7+WQ0f1P2
sZyFwqsI2U30rl4Zvs78X3srUTVikcDK6ZUo0bBjbcSJX09pv6gAKjaiCCRiyfSV
vpewTZJ+9yEjLvd37eGWC4ex1dmLxZWPcuQQvbjLYX6RdTPUd0wIgwZD9rTfz4Ij
Wds10iWvzZ3Rtq7oyX5swaX2rocZ4OFvVYd7Oe72UZOqJzAJPv9KABPF5/+iN5QV
0pSPmcvo1bn1bOeYOMbWjkaRuETbOdvPpvadQLsex69evkFtd9TGuQOV37WM30kQ
csYb
=gvFT
- -----END PGP SIGNATURE-----

tag v22.4
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:02:01 2019 +0200

rdma-core-22.4:

Updates from version 22.3
 * Backport fixes:
   * travis: fix aarch64 extraction
   * ccam: Properly enable ilog32() calculations
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqLscHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZHg9B/9/hgao8ue9caaBYdRh
D8GuAFb1H/ZlJxx6TVNAwpsnxIcktrM2pZsXrURNzJ6TnV2wdjQOn8d07A2zKmwv
HcvoKT25JFvN6lLrFvRlYvMyUJXviVMbh+PdzQ2NZ4ra3iPGk2SYVnL5yC06k9iY
34mQ9cgwjq2/Y7xJ885/zlO4uB4H6n6kh8RLFVXseSS/yf3XxEwXFBW18+vjjiqL
Vu979emNogR8OdXF3SR+FKGW5I7tgnYl8vpJ+FPxGA+h9UFac4UpaGBIjdk2vIqA
7WYqceYqew35315Pqi9EJyLXAUDrOHzNcUSYG5KtT62MeCAOXxCLBjqGGHHwc06X
Wdaf
=Dzin
- -----END PGP SIGNATURE-----

tag v23.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:02:06 2019 +0200

rdma-core-23.2:

Updates from version 23.1
 * Backport fixes:
   * travis: fix aarch64 extraction
   * ccam: Properly enable ilog32() calculations
   * RDMA/hns: Bugfix for identify the last srq sge
   * suse: fix dracut support
   * mlx5: Fix man page of mlx5dv_create_flow_action_modify_header()
   * libhns: Bugfix for flush cqe in case multi-process
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqL8cHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZAXFB/49K+Ih6CjvDUPyO57O
9mOFjyJS/LEvzR/TR7PZtXqRQKPjRvrmZhiIPk9rvEghgOdCuY/a3s4HROLamI74
j166a38KKOa+toqQBczhOzJ+3caDMAst3eK1f+e2Onx28MuEx16BL9TJ1YGwS8m4
c5TAIJsKyjVi46XyG99LkOz277+1vbWY5MolZCqnjoA2yErEpuBVFUAW/HSJaO0j
tvQ9/SSVUbUYFUF4+B/hpF/b+QXsNf7ianwQJFz9N/ULxuIsNsOOeyD6CsKdJJWp
oa5q9cliMaZk2xUGNdUKrj4q9lF9GEAQc9UNf7sOF3Mzv41en7vQ8u+WRARaPYe5
Qydj
=s9b3
- -----END PGP SIGNATURE-----

tag v24.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:02:10 2019 +0200

rdma-core-24.1:

Updates from version 24.0
 * Backport fixes:
   * suse: Fix name for libefa RPM
   * ccam: Properly enable ilog32() calculations
   * travis: fix aarch64 extraction
   * kernel-boot: Set default prefix for RDMA devices with unknown protocol
   * kernel-boot: Fix garbage name due to wrong usage of netlink API
   * mlx5: Fix mlx5_ifc metadata fields spelling
   * mlx5: Fix bucket allocation check
   * mlx5: Allow matching of source QP regardless the source port
   * mlx5: Set the proper flags upon dr_fill_data_segs
   * RDMA/hns: Bugfix for identify the last srq sge
   * kernel-boot: Reset buffer before refill
   * suse: fix dracut support
   * ABI Files
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqMQcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZG94B/49Bnjhe2ZDQAo3H64m
UxUGf40XQpnLc4XAaWPGCYUUrP0hfVbCZiWY2eOaJ1tWur/GbYGV663i79vF1lEh
OyTCaQWv7EtrnpynaKCGh85Vfmfz1TitDmUCwLmw8VVW7npiBpCwxiJknCBkEC80
KbfYA+JOumBAcoO7pmTxdxUdYJlsQ0XDjZQRsm4pcjoi+qSgfuQzPvkb4vVrjlRe
ooRxwFKORkALN4MGpCZhuv2yObyVs5z0wGIYMm0bhBEksY2CykLmbeHLQtaHHesc
qFapLAuQqewObkL66Qqib68XsroOECnFkmOxhxb+iHWBpEETTR8sEL1/KceK6WRQ
nTEg
=9bZ7
- -----END PGP SIGNATURE-----

tag v25.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Thu Sep 26 14:02:15 2019 +0200

rdma-core-25.1:

Updates from version 25.0
 * Backport fixes:
   * suse: provide libibmad-devel
   * suse: add perl dependency for infiniband-diags
   * suse: fix dependency to rst2man
   * suse: Fix name for libefa RPM
   * ccam: Properly enable ilog32() calculations
   * siw: Change user mmapped CQ notifications flags to 32bit.
   * travis: fix aarch64 extraction
   * cxgb4: fix chipversion initialization
   * kernel-boot: Set default prefix for RDMA devices with unknown protocol
   * rdmacm: Fix missing libraries on centos6 build
   * ABI Files
- -----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MqMkcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZEDGB/0YmyMTu31vuGgglXXz
M0LJr7nXNzBpPPcDaVox14L9mhRkcg6voBeciIu6EWfVAIGb4/e9uBmWe2Nsh8NX
as9qFdlaHpduSrp8Q+a/kVyZR13Y119QLR03cV9kMqLXcPtEetKThSeqVSzqX6ff
p7aHNVxPJjyxUm4dj122yev7illdPuG486DAsojkiAi09srAanIphaImAIsZEvJ7
jFb2hJJRG8S0/+WvabFtUAWBDNHKp174JoH4daiBP+FBsgvAmCr2Fs8X5jQapF+Z
BcSG1f1RVxOfI2aknh+SYjUVAlOXfjxUJCAgfu86iV9e2BA450eozKLD8sPMA9Gw
1UOa
=Uqmv
- -----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl2MxFYACgkQgBvduCWY
j2S9GggAmbbi9EqgyBxxTspM1ntEQv6SfwLhdHhQ9/cXlT720hTyZmC1xIUF9Yir
nnvSszHGDRlWun4WL/1173X4g/rEWNJlFUMSklIZbUDhy0XgPGKtY3Fq0aAimHUz
SFJB+nl5y4EcrF30KdpBKp9CVg3DvkwaaqevRRwOHG7Ap+VKENOJxthPvpP/4kRg
ag9V4gjl0fS0kdi6AcCrHyK0j13ha/N/SzwwerighAORQ8sTX+nKwdth6C7AsNR7
CkS0PleruLeA+cyil+6XybU2Xz1SrV19yRt0RyXcvJr3vQ+9KkxYRb1LSQIQlSkA
3Q4QQXZVK3qXz35OJjO8DnXVTg4GJg==
=Bs+8
-----END PGP SIGNATURE-----
