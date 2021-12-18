Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4300D479D66
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Dec 2021 22:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhLRVZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Dec 2021 16:25:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22424 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhLRVZY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 18 Dec 2021 16:25:24 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BIBjrUj004804
        for <linux-rdma@vger.kernel.org>; Sat, 18 Dec 2021 21:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2021-07-09;
 bh=hTaGhq2bdeokDbrvJ1M6Ndo0gPfD/zeGdo5WkOwXAl8=;
 b=O7exgqJ/6MJ7qMn3nQlxRfQ+cR+oCNZdHOR7L/mACVpnefOK9egTlYJmM1LfBzpuAhVH
 mMT7H6D0JRewzg2Uej/1b6LBv+QZKeZJdsG4w3pQf+YLUQq4BHP/T522w3CrnJa/HvQ2
 aDdRtiYlwpDWzygRtoVPBTh2CGlW6F86XkuygkqmfG5CA492VDzTT3o7MDks3VEcM9Bq
 VbWKyQLK0HkCqQLxMfa3Ss2p6pDrznQuRw4bD+M1vioTmQHHv7iK4XDelqPrCItnos1H
 aGdQm0hKC/Ruw/74mag0LDQTcH8uBFNFk7pkQQbRw1EIHjLolnUjLQDGp/3OvhPJtavX eA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3d17h9rv09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 18 Dec 2021 21:25:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BILANaj161088
        for <linux-rdma@vger.kernel.org>; Sat, 18 Dec 2021 21:25:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by aserp3030.oracle.com with ESMTP id 3d15pakj36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Sat, 18 Dec 2021 21:25:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5EWpPHMx2aa42pzX47R/zbVL9d9XTkJMR5epr1SSDKOtbJ5Ife+YggrcAFSmvLU7lqeejMgGBy+vV6eoiFuftDFZXo4RF5D7rX33p8Rmv5hNKQtj169JaR+M9YcQWEkg9KfyFLNrIP9aTKCr+WDWgdoGFOVtzF/FQrsicCou0vHCFopmVn2b1Up94wwMUHizktzIRgcRptyuWIqjICkbW2fbBEpcY9qqnsISrRNQU70ar+ojFTtzmiPepglzpnNRrkofaNfw9vAycgo8iScg+iOL84eLqZoGCnDKOSVmUp/GBSCbMzMRTjSo7xml2CKS9GBJv388xj+p4H27Qe9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTaGhq2bdeokDbrvJ1M6Ndo0gPfD/zeGdo5WkOwXAl8=;
 b=PZWZPY7OPE4oBPFUmQomr8iWJKdRppZE60HHhipz0B8us2ei1uCtBKV1NB39xvkdHumf+vs9j0l96RbMt9bzZ9B7wihk/aJh3cczRiKxb7cPrIP9TRu8543AlvZDA5KMep4iuPMgM+HSHRXpMA1/cLgJgOJJ7e/mxMjv+Q5mVPztJ4VYirPN81Uf4N3ma1hlzL0LVMZG5jBF1uJVeM5wRBh9DM/mmVnG1PiOpL2CORQDf/AjYY4/Qge2JKm4HZmUZr4d9aKfNBpJn8zbLTK2d5eY2jyKllcI/Tl/sxe6WeR9Y/58dnGDS9TBdwr/Ozvyk/PRP8b7BDgLB9VesWJ10A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTaGhq2bdeokDbrvJ1M6Ndo0gPfD/zeGdo5WkOwXAl8=;
 b=THp0f+RM6ZNONqZ72Eyf1NaDi0ij/WpY5/FqZp/Ivt/m1npwYFnXtbuYPar857F4o6Lghe+dFKYga9CaUhpKm5NDjY2hSjUuQqMrX/qVQBie7lxza+UaBlk0lbwSJpQCigdchs8ZJ0SilRla7rYaUmEiGBLJd241Osg6nWOPzPA=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5498.namprd10.prod.outlook.com (2603:10b6:610:ed::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sat, 18 Dec
 2021 21:25:19 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%6]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 21:25:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in dereg
 MR flow")
Thread-Topic: f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
 dereg MR flow")
Thread-Index: AQHX9FXB2QwwVKx930KXJNGtxnlVWQ==
Date:   Sat, 18 Dec 2021 21:25:18 +0000
Message-ID: <EEBA2D1C-F29C-4237-901C-587B60CEE113@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7babfb1-08bf-4ff8-6b38-08d9c26ce42d
x-ms-traffictypediagnostic: CH0PR10MB5498:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5498B6DCBD9B309FDC2DFA6C93799@CH0PR10MB5498.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UAg5lnl5YG3ql1gXxrJC561/LbgSVQBjmfoDjCnAgif3Ub35xiastnN17/FkMvdHSDp4yrYUlTVjrkVbNBZSJeMXqVylWuFEQIHMHwyQbfKrW6QEGthTuWzZx/4JOcr8mNZPfu0BWt4J0xX4rszoUdMQ2ALq450hNbPNJ/ZtUCUJyLabKD2GW2+xTWjHHs+nZLdY8V7AgJe1RoYOt/COlqrakyJZa12Jir/S7ym1EAwFmUADndOTjBf1Rpn1w0vZFT9b5Z0ZZQLlvUPEv0TlNt30LpoOTAQaEfQ5+ix6ejeFTgWLlpjiTpJdiE0rd20Ao/Oxi9ijtDetB+XssVS5BS7KDRZhE5f/UeAexy0e/YiHapdjzjwhCUdjCAdMzN+7+rVKZGq/8MMGYt8sKS9bGXsNnIfKMKjb5ICPb2zgIAO+0VoYCV6ll7sqF70lcpYYcoN4jFr6lBX8fj/8JITfvQIkro/w4lnzTP64jxjz2spT41Ps6iZ+tw2SF81fZhcq9UaiChWKaI+OqGZKMej/mk6hXCVG7OcNIQnTUrKleZm1UrsCO2f0Uark2SiCAL5ZcK2r+qU0kC8k4FJtwe7mBZ/drJvuSG31bB6eRzaxi2hTwbA6n6AdHh+VEf2huxtUG5S7MNmAPfmy6dBNZQmMxOQ+Ai2KB+u5sanMjnP2AgBkXf/QX29R2pUqMkz/X7r1zflxaLWcYUlR8P2vN6EkHhxe0nsN8gfGrdWD4i1HvdxYM+h21Pfuc5miXhzX3OXl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(66446008)(66556008)(76116006)(66946007)(66476007)(36756003)(6506007)(38070700005)(8936002)(8676002)(122000001)(6512007)(86362001)(2616005)(71200400001)(38100700002)(83380400001)(508600001)(5660300002)(6486002)(186003)(33656002)(6916009)(26005)(558084003)(2906002)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?48CBy2Rwtgg6tjEFMgrpW70v7ewOfbjvrIP9nQRNLVOhrv32iV99lbZVfsFa?=
 =?us-ascii?Q?KdCjcDnoQQzNJf/3s/uMCo9vD0nJwfZXRJugDLdep0atg8Fn088NXvSmAjl4?=
 =?us-ascii?Q?sL9wWJu3SJxqkJGF1MUEa/rbHJkIVHLl3povZZcGhFOIeC5F5Dwd+FymZJkQ?=
 =?us-ascii?Q?NtJFmjfNYO+AuF/SxHB+ZuO5i61xFTYZU9VEHS3JpPAqBCnpV/bFlf11a4Ix?=
 =?us-ascii?Q?cZ2okM7UABqy8ElUB94XKEAJnIwH+zUi2Y9n0XtY4g8AAGOgCY0b0AcVOSFD?=
 =?us-ascii?Q?Cl2bMx8qanmJl0ta2QhF0D6+p+zSS1fEn0rgwTsDDCsg+GDlA4WSQx2ePrAC?=
 =?us-ascii?Q?bqKrOI2h3FeWer6rxMPV7/IIG5aBKCfRoM7oKJOUzNCIfwgaDHrwgnizp307?=
 =?us-ascii?Q?Tjq/fGME+kpTPerUyseRDY4aePTOF66ryJj3ScQKyck5q0NwxFP1QEaL+eY2?=
 =?us-ascii?Q?iVp4qrvJ/+En7lKswcHc9RHHIzyGU7jq21zFCqd9KjkS+Rb7FDpSPYzDs26W?=
 =?us-ascii?Q?+JyktPQo6lO3NVfqpVqZoLFkwf02noJQA5Vbv4ZVyv06WTORjTwKKD/SLtmT?=
 =?us-ascii?Q?A0BpVE8ogTUta17NOOmq0Jyginez9ERL4yB2Md+ELVTiR6gj4Ww8IPWvgU+s?=
 =?us-ascii?Q?+sYjjLqiVRUGSKMzGn3Tw5SyJ7iDAgv476wwfXLM0qYd6nP3T5bTxRcxWORR?=
 =?us-ascii?Q?iAtHdxWnBnDV9VMLlPhsut8jl2AzjYz/0PSiZsYTKMFLjZ8XiKKWNrs3v4zr?=
 =?us-ascii?Q?qPYLmiIlH5L6npUhJLniJ6dpoWO174WxXm1BCgv+HjpmRf/gVBnCGfd1Ly8u?=
 =?us-ascii?Q?IkMtYV8tSiIaUQArbU6qr63wL5Yp7TrzQad1WHud+yyjL+V7HCD3JeVQ6jW3?=
 =?us-ascii?Q?VLB/KLG686PJ/7EgBn4mkJA3zWr898C4fbzu8HZ6zMxTJKbvk3HNBp+r8P/j?=
 =?us-ascii?Q?N0cWkoud+rVWjr5clC90y+aPq0Tnzecu6QcqzyOH3qpjGi3Ng4ANGXvEOmkF?=
 =?us-ascii?Q?sohPsDw90p0Wd4RthDujSZKEg7iwBFgb8zIsC26Jb1/NYpgBlHJDtspQcj+o?=
 =?us-ascii?Q?AN4XBh9/JpYokhB9Yud/0Aev4/Y/q+6m3urjVPkzvpWq31bmdfAxOGjdlLjN?=
 =?us-ascii?Q?Ry7UDjVds0vwGtXhUG6oTAfcFg9baGZiP7hIAZoLM79uK0ZqflYJnSJek+3d?=
 =?us-ascii?Q?HORuh7KK5a9K7sh6wTeoN/ANdszP7MMPPbShPHrJqUeKgF2BXVv2OcS5Gn0q?=
 =?us-ascii?Q?6pU2luM7Wpo71q1O7ZSnZvQ6PVxevPra9X+B2zCW3jhG6JNhUn7Oe1hqvoa2?=
 =?us-ascii?Q?tvZjYRq/QM90c4OdxZZ7SvY2eR25qLwH4dG6g70VapJ0evh7SYz8aazZkf8t?=
 =?us-ascii?Q?PgyCALl1A+lvDvfnAZjww2AUqAbHQU61Pd30Pha0jD9HW/Cmkv1No15xkjSw?=
 =?us-ascii?Q?Oimupgr4p7jVOsO19q2cBYipM4wfvueeen38edewNZ1prZqtXmvpW2DpthfJ?=
 =?us-ascii?Q?J+X6Vu0n6/lXPYA5Hel41NHJfZw1aS5nFXz2C17lLg2F0dqXStqW2EC41IFx?=
 =?us-ascii?Q?eF6ccw6PgQT7cTP5AAQDDfNkDRKK8zwruAUdRDff7+rapGoYawYOGmW3mEUv?=
 =?us-ascii?Q?/W/S0rY0VjxSZRSzu0ELJYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79219E30FF462E43A0B1AEF6518C3F34@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7babfb1-08bf-4ff8-6b38-08d9c26ce42d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 21:25:18.9293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHG6tdGFDiBZBrvdDyA/Rdx941SMoOedKiU+AUyhlcy78FOEGag4EzSXCzuMJ7knzxN2vx1heb2cWXkkaH7FpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5498
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10202 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=812 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112180129
X-Proofpoint-GUID: 7wwXuQH4t7cit3VXfqPWgEKTN1skbL5N
X-Proofpoint-ORIG-GUID: 7wwXuQH4t7cit3VXfqPWgEKTN1skbL5N
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

NFS/RDMA with an NFS client using mlx5-based hardware triggers a
system deadlock (no error messages) on the client. I bisected to
f0ae4afe3d35 ("RDMA/mlx5: Fix releasing unallocated memory in
dereg MR flow").

--
Chuck Lever



