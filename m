Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D04E17184A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 14:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgB0NLX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 08:11:23 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:44620 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729032AbgB0NLW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 08:11:22 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RD5cKI003656;
        Thu, 27 Feb 2020 05:11:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=tG9F9oJwsuKIxM6i+S1fXCOHLtevfYuNwXjJFRTb+5Q=;
 b=e4YLZGbxuqDoHdFyT4sGgcKAo4J8btQb2p57Bu6LZzSU0Q/G0YjLMCcr3F2lcK8og1wl
 A74DAZmnkJ++W+ntv781BW6HLTQqOlNklQrbxlDkdJYaF8xzN4xZm7o026idlhmqyz2g
 fS6n4tbCrOmlUa4N3COjT0vd11A9/V2DvmbVmFsifTtNOy14CxO4YyjMn5YtsX4SfdgH
 KqpVF5ylO79R4FfD+QQU4zwICWUojyiNFXhNvEOppGnIOc/QuAJYHnPlSGWnkCr/r7nj
 aPGKmfNb7EZ0N77YRD0evcqNcLKgVIvEUS0zONIIVRD/HqJQT3l6TTimMH5PZgFH7K8S AQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2ydcm18ng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 05:11:16 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 Feb
 2020 05:11:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 27 Feb 2020 05:11:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iI/GReUGfdO/4tFEhmgtpEqeKzwhLshkTftXnM775eU3Q27E6mpZBt398gil1WYGOBQR5eyv+48AEcZgi+y4Ta9At2y7PRuo4i47TABDGgbcZW6Vz7gDE/ZtldppTKL6u6vPB4Zm7xETP3DMvnp1FZ2jsBTvRwl2+oTKFy13v0H7fnXPPfQ1G6UEA7XxVNlPSgOQaXmGvSmZ36BRfT1TPCsxzH5iNTuCNyf7rdbXNcru9ARvgjhJQGUf3mMITelEyD1Cm7Q1zAdJWZ2JCiTpwF0lJTuvSEDI9eZMPHnR+d3Fw7etaNbV/PGNuDsosFBHyoleVSikBvrNcdSy8/nzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG9F9oJwsuKIxM6i+S1fXCOHLtevfYuNwXjJFRTb+5Q=;
 b=Q3ARtMKU+cPNUtjgELDsV768GArsxJMZf7aQfGVh0w2ES8Txh4w8dRPfw4V/3JXzNva1Pz60PkL7zj7XBQ3JizwZdsHHbgO9zIGuuu3hYZ+s0CC6nUxwpG5luhr6ScByGR97lrXGk9XgBOK/3dcrYYFApC6MPNeiXDU32juf+A0nTyfzMq1NVlFABahI7qXHnIyGvuCvdL4aHSxhHSgiz4bzpQjOBJsHcVSq1O5JTKCqHOtO3fNU2NzhsgdrlSWc10SEGK+Bf6ZPtPDnWYkDoMBamDsC9KsKPFKuZEZGdDhsInk0KHNVJv6jwoGrA4mo+mEe/V7XslgvELb+c9/E8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG9F9oJwsuKIxM6i+S1fXCOHLtevfYuNwXjJFRTb+5Q=;
 b=UOq8z9N2zjrNwkOgvznybj4MXCvF7hFTlzyrlKI1omTQqyMgtFVGShW6tTckZIQwLQDinyX9enQwYX6syfHFapkNKJVA6EAqthqu/RJIzHbtUlwGBeWP73slm7zuvOAs3uOhGsKIH6kM+EVZmY+sOqNJ79JFz8r/XrOMxG5//bY=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (2603:10b6:208:163::15)
 by MN2PR18MB2592.namprd18.prod.outlook.com (2603:10b6:208:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 13:11:14 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ed5e:f764:4726:6599]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ed5e:f764:4726:6599%7]) with mapi id 15.20.2772.012; Thu, 27 Feb 2020
 13:11:13 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: rdma-core new/old compatability
Thread-Topic: rdma-core new/old compatability
Thread-Index: AdXtbVWfLJHDmaJ9RpWO761kWPyf5w==
Date:   Thu, 27 Feb 2020 13:11:13 +0000
Message-ID: <MN2PR18MB3182F6910B11467374900AD9A1EB0@MN2PR18MB3182.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b015504-ba9c-4ee7-1fd8-08d7bb86859a
x-ms-traffictypediagnostic: MN2PR18MB2592:
x-microsoft-antispam-prvs: <MN2PR18MB259220FCB3128B6BBB07DD8CA1EB0@MN2PR18MB2592.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(199004)(189003)(64756008)(66446008)(66476007)(6506007)(66556008)(76116006)(66946007)(7696005)(186003)(26005)(33656002)(3480700007)(478600001)(71200400001)(316002)(966005)(86362001)(81166006)(8676002)(81156014)(2906002)(55016002)(52536014)(9686003)(4744005)(5660300002)(8936002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2592;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzAHDGet+SK3fyAjkCZ5w4qHlCHJfRcBGtvXaOnYzWznlIml5XXt9FT/GxUnJ/QqAIbhR80FQkRmPeqtAcDZNpe5GzFjRZNQqB7oRcg0oRLjGsmuUfOjWK0pcl3sjpEl1G3NbG8NY0Ioex3fI1pomJcFIp7+f+9djnRreOQaO/kEeo1r+uv1B6Y/qISEqs10nfZZCg/ZajARhavGtnaFevdRqz4xEich4kntalmIZNiOOfWgMFr9+7XwcafJDedMVbtZ2EcVdaa5oXajLez+D7T/WuZOM6k2tjBiRaVcvd91INXr0J2GxmTsQg4kDbk+Bz2TUJWi3gY4LDnyckaqKidEpgbEaumebxQz540Cl57lc3FkT/zwOYDj4HRHyP5OI4gzI4QKaPA6gBsjj7P2iXyy2bgGfFqm5FbWSz2O5EuDszowFcCxwM2hf0ikuQDcQQdXsM7AaVZlRH4StI1uxTa8KUaj4aXd5yx1hkzXPWjfvMGTEdNPqtBxbJSX9wqOSA29sK9oa1vg9knio7iwUQ==
x-ms-exchange-antispam-messagedata: Y0S9F7BL85l/STY3prNn3OtdJQ9azfbLyQRAqMgjVKBrrmFsOIpSUu3RxXYCQ2vVSct6KIUlAV3udkXv+q2U7Q/yTFw5HpOHpAIE9JSxAcC2Py1E9bnW6vYOmJeHOMWsi20+j8Xf9eFcznSLxbXJQg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b015504-ba9c-4ee7-1fd8-08d7bb86859a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 13:11:13.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLcFXLA364FmdsHPyDVzEv096p2AVe6n1NXphwcYUoOc2/R9nP7xqaBIlX6t5tP4RaZhNYRlv5Nh/etOXT8COw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2592
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_03:2020-02-26,2020-02-27 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Kamal, Jason,=20

Running a version of ibv_devinfo compiled against an old rdma-core (ibv_dev=
info from libibverbs-utils-16.2-3-fc28.x86_64 )
failed to run with rdma-core release 28.0 for qedr.

The patch that caused this is commit c2841076
https://github.com/linux-rdma/rdma-core/commit/c28410765bdfe5cbed3cb2cdb158=
4eac3941469c#diff-8da8bc8b2790169de557d5dee83a278e
c28410765bdf=20

libibverbs: Fix incorrect return code ...

The proper return code is EOPNOTSUPP when an operation is not supported.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>

The reason it failed is because qedr doesn't have a query_device_ex callbac=
k, so vctx->query_device_ex returns EOPNOTSUPP, and old libibverbs
Compares the return code to ENOSYS

I think applications compiled against old rdma-core should continue to run =
on new ones as well.
Can this commit be reverted?=20

Thanks,
Michal
