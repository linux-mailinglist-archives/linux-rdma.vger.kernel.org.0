Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A735109224
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 17:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfKYQsI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 25 Nov 2019 11:48:08 -0500
Received: from m9a0001g.houston.softwaregrp.com ([15.124.64.66]:55250 "EHLO
        m9a0001g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbfKYQsH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Nov 2019 11:48:07 -0500
X-Greylist: delayed 2085 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Nov 2019 11:46:30 EST
Received: FROM m9a0001g.houston.softwaregrp.com (15.121.0.191) BY m9a0001g.houston.softwaregrp.com WITH ESMTP
 FOR linux-rdma@vger.kernel.org;
 Mon, 25 Nov 2019 16:45:51 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 25 Nov 2019 15:56:29 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 25 Nov 2019 15:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loSoTKppE4BjvCBhDunsrfzH98n3w5TniRCESjEcqxmKEXFpuubrlgdLoDzsMcaabi4oyp5HmqTZ8w+cPIaB8L6/lMNQOYkZegwfjZRljJDHmyj8yWxqX26rysVl/jc0+Krf3XhqoJJbXnKe/1UH6o/8GeEj4YU24ZuxrbLoutaIuPqfQf5jK7602m1TrtaCGuqV2X0UOq6p1/vKzux7o5FIxIzbNrJ8rhNMgyw1A10U6qX1SyDjZ6TptEyg41ceXRadPmFi8U9csTg6gAf28zpUU632aIH+j5YFANAZjZZXQ0/xX96Sfygjxui1hFtpW/p6n6IGjyuk7qCQVdeGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKqO5j+wHc0SwLRYigdMDjU+1NJN5OXHh5lbZOpgl0E=;
 b=Drxn69ggJCULplT+ytMz1AX4yJK0fwDfeXrWFxsiILU5O7QJBmvs7AahbCUhn+QOjjCYHeHBZtJbj3BKScp1XnM10He2zUUz6hrTezZcApAeHCmh89L2dILd8UEk9zdKj2iiVRNnRigcxNw2ZuiyUHNx0tYRZKLybhwfmvsFnQ11BZc4rCcAXT6PtgosC85XT2M96zNSz66N2h3uvFRAc8QkrJ3CnGYs7RGP6EFLSXslXbrUv0nT6sJ2LuXXV0n8DT3YWIIRSplPOV55sPvl0WGUThFI3zk/Vbm7/lF4NKXye1CoozqHDfPOTCWFueHiHjfBB21XLiXo0FHzwKHs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3298.namprd18.prod.outlook.com (10.255.138.224) by
 BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 15:56:29 +0000
Received: from BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::948e:c2f1:c1f9:2923]) by BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::948e:c2f1:c1f9:2923%7]) with mapi id 15.20.2474.022; Mon, 25 Nov 2019
 15:56:28 +0000
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [ANNOUNCE] rdma-core v24.2, v25.3 and v26.1 have been tagged/released
Thread-Topic: [ANNOUNCE] rdma-core v24.2, v25.3 and v26.1 have been
 tagged/released
Thread-Index: AQHVo6jlE8ij4GmTOE6RehNNSJS3Qg==
Date:   Mon, 25 Nov 2019 15:56:28 +0000
Message-ID: <BY5PR18MB32989AFF15CFB8C38CC69623BF4A0@BY5PR18MB3298.namprd18.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
x-originating-ip: [90.114.93.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 671e1bcb-05bd-425b-bc45-08d771c00893
x-ms-traffictypediagnostic: BY5PR18MB3266:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BY5PR18MB3266DDE58316F81EA54E1CEEBF4A0@BY5PR18MB3266.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(199004)(189003)(80792005)(2351001)(966005)(316002)(14454004)(6116002)(186003)(3846002)(55016002)(26005)(5660300002)(6436002)(5640700003)(7696005)(9686003)(6306002)(6506007)(86362001)(2906002)(66066001)(74316002)(66446008)(6916009)(33656002)(478600001)(52536014)(102836004)(7736002)(305945005)(66946007)(76116006)(91956017)(25786009)(2501003)(71200400001)(71190400001)(8936002)(14444005)(81156014)(8676002)(256004)(66476007)(66556008)(64756008)(81166006)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3266;H:BY5PR18MB3298.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2Ljr0ag8IkDJrkiCWSB9SRFpuVxDboB8xkz+m7j4BGob+SOmz8O+c6z38XMbZVXAw519MhUhmqGBWcyhtEekpJkrG39qRyWl7DzWENlLIVBmqZMEMnM8+UOwFvnQpE3MBYEVvubeAL97PfFvKTqTah56TyKKyHZP5uhpDZuht58i/5BzDtZAzQ0pfL3v1IpNEfZJPnVflLHjpQmHGt3C5S5d0DfdiRIfrO6Cv6+rfMaxkefqInTyB7/gJTG3KlVjamGYXELwSS3Z38czQY1DLkSIxxxD14mAvn/Ywniv4pa0nvIbAZfpXLlCvjs6UIH1g/D/eNBdZw36jr3RVFVE8QVBhroWfThWQhlHUpRY7Sp0ezHMOdQKsLpJU/SSoNvJiSms5AxoPXqRa29g2rmqsChA91xCuEHeVmXFHEIltTfL3AUj0ooPSfMBW/ezJk7TcT7p4nH80gZzml0Ile2kXaYi5W/7j9vV9lPUBEhdUI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 671e1bcb-05bd-425b-bc45-08d771c00893
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 15:56:28.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZxYEF1UVOwgoK6H8P+rjgSt00lIMWS5Tjz65YYHjWLMfe49/68G+SLP4iGF4TjQsVTh3Jwy/SrP3BmKf/Jwg9bJ/rnjAgJDxenRx/3uYwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3266
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases

Note: v25.2 was not released due to issues in the migration from Travis to Azure.

---

Here's the information from the tags:
tag v24.2
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Mon Nov 25 15:29:57 2019 +0100

rdma-core-24.2:

Updates from version 24.1
* Backport fixes:
* man: Fix return value for ibv_reg_dm_mr
* cxgb4: free appropriate pointer in error case
* mlx5: Allow insertion of duplicate rules using DR API
* verbs: Set missing errno in ibv_cmd_reg_mr
* pyverbs: Fix WC creation process
* man: Fix wrong field in ibv_wr_post's man page
* build: Do not enable -Wredundant-decls twice
* srp_daemon: fix a double free segment fault for ibsrpdm
* pyverbs: Fix PD assignment in QPInitAttrEx
* mlx5: Fix incorrect size of QPN variable as part of direct rules
* mlx5: Set miss address on copied STE during rehash
* mlx5: Fix incorrect postsend of new rehashed/formatted table
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3b5WgcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZFRqB/9WXjnfUn6H8ds86NCE
RDUyZtYUgDEYVFgJ96nl8knbyaph7HwBhzBd/0j7E8T6sA/iRIAw5dGhi5xHRbZa
CVhIcBRDUq2GI6FJRVEP5+7nnykNIPqjKT9vldZWLWyre5u+XD+V5aT/bLBENu4h
p+kCy35rZ90uqgHDttYF8XxFibWzYxaexh1pSx1l5k4RWz9d/btWdTNPCgy81dA4
7UtTiQnLf927aKLh32S8JyNhWpSBjrX8WRsl93jDA3HQzJaJfaOm1Ok/9fEnqzN6
ZxfRJlDDXk6btjJnKMLFYBHffMJClYtmHly7e8VHpdJbGDAjKTl3qAkB6G31RZAU
+i+f
=pDZF
-----END PGP SIGNATURE-----

tag v25.3
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Mon Nov 25 16:06:00 2019 +0100

rdma-core-25.3:

Updates from version 25.2
 * Backport fixes:
   * build/cbuild: Update cbuild to work with python3
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3b7dscHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZCbfB/9aCyNw5WAxhiPiE3HW
rIGRken7Md0nlPgufavwqrGlbEBLrJoij2za09mZNiPhwwlNl2JbvDxgOy7g4exG
GM7EXNuEysPK+oo2Pz1KGoedsHG9JS0P26c/fGO6L7KDefPPUzFw3QdVKPZgOL3K
BcXleVRIfKvEEuxXNF2NWyjwMnXVvdMfebMGnZfq28UwyphgOlL/CTsv7Ly++RBH
ByvKm21i9GgRf7IQnZLalDAqU9nHKgows1tV4KtuGD7AbmwlF3pNKDX0VxnRAa7f
UETkEbr9XmMKanUZoaZdrQv41Bz1GCtGfHChDU4kQVccq/I4Cw7nygjm0oXZqJ1/
YmVp
=iZwn
-----END PGP SIGNATURE-----

Updates from version 25.1
* Backport fixes:
* buildlib: Build devel stable branches on Azure
* man: Fix return value for ibv_reg_dm_mr
* build: Update ABI files
* build: Run CI builds on the stable branches with azp support
* buildlib: Remove travis CI
* build/azp: Have Azure Pipelines create releases when tags are made
* cxgb4: always query device before initializing chip version
* cxgb4: free appropriate pointer in error case
* mlx5: Allow insertion of duplicate rules using DR API
* verbs: Set missing errno in ibv_cmd_reg_mr
* pyverbs: Fix CQ and PD assignment in QPAttr
* pyverbs: Fix WC creation process
* man: Fix wrong field in ibv_wr_post's man page
* build: Do not enable -Wredundant-decls twice
* srp_daemon: fix a double free segment fault for ibsrpdm
* pyverbs: Fix PD assignment in QPInitAttrEx
* mlx5: Fix incorrect size of QPN variable as part of direct rules
* mlx5: Set miss address on copied STE during rehash
* mlx5: Fix incorrect postsend of new rehashed/formatted table
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3b5XAcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZF+QB/91L12nUiMeo57IWm7P
uRnlYDn8Uz6qMCpSs+sKQLHq9MoBAoa2aIuDpvruvohaC7VUy15RlaQpBZkGLYih
y1rjXR/BMzqCdGMowz4ir5VTb1IWASumzSq0WyqFa/Ayr95YARGqls9AkJlKubQY
whpeWZX52OlvkRCwgIsfk4Lr++bjS477kk3JUqQ2iuW8JonRkIfe0QCS7IeV3Pei
wjcGm+da29yoGEKwZhO7bsbSRF44Bkl2oJJxohCSG4sYe999dKWVlBxsEl4acIBz
Ct5vDx9SP9Puhb0sojwDnRiZ8i+YvCZ3nKmY/1nHLwdZVHgnAr+lso9KHHVv8LAI
8DFX
=/Bc9
-----END PGP SIGNATURE-----

tag v26.1
Tagger: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date: Mon Nov 25 15:30:12 2019 +0100

rdma-core-26.1:

Updates from version 26.0
* Backport fixes:
* buildlib: Build devel stable branches on Azure
* man: Fix return value for ibv_reg_dm_mr
* build: Update ABI files
* build: Run CI builds on the stable branches with azp support
* buildlib: Remove travis CI
* cxgb4: always query device before initializing chip version
* cxgb4: free appropriate pointer in error case
* mlx5: Allow insertion of duplicate rules using DR API
* verbs: Set missing errno in ibv_cmd_reg_mr
* pyverbs: Fix CQ and PD assignment in QPAttr
* pyverbs: Fix WC creation process
* man: Fix wrong field in ibv_wr_post's man page
* build: Do not enable -Wredundant-decls twice
* ABI Files
-----BEGIN PGP SIGNATURE-----

iQFQBAABCAA6FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAl3b5XYcHG5tb3JleWNo
YWlzZW1hcnRpbkBzdXNlLmNvbQAKCRCAG924JZiPZDeYB/4mBHSrCzkkz/FCBIBp
8Eck7eETZZzayoNNy9w5BW8O1F77MGoaB31MmECAd0++BruEI9J2YPb+jq8IBKHp
0aQAGGYFxMjYXGPwWyu4Q4U0B9DuHqlN+krY/2eU8T8XRSjXZT7tQu4LMD+zpxF3
+IcmQzTEekPLBY24X4KXex3+dm5POTbP4GfU3kkmJakijMYOQ+FgJ7LF0LrLLMGc
MMA9cP5NXaH2+ceeTsvKxsAwDgk4xXM2drQwPiQ1PIaZk++PdFScfcceVlYjnBoq
IEcDeINSNpIPm21hYEqg9EYcm2+wE69lwU8ZQpSJjfdEl6F+j6ny7fAH/rsqSDAO
Lcsu
=ZVSp
-----END PGP SIGNATURE-----

It's available at the normal places:

git://github.com/linux-rdma/rdma-core
https://github.com/linux-rdma/rdma-core/releases


