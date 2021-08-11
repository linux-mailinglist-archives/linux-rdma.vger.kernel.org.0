Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820123E9660
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhHKQzR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 12:55:17 -0400
Received: from mail-bn8nam12on2133.outbound.protection.outlook.com ([40.107.237.133]:36321
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229535AbhHKQzQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 12:55:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz5FfQ5auO4hAaMn+VraB09kaYjIxQDqDtXcs/vI3NsTllYYKjgfimfKiagbmxTOHE70EhGg64QSUqiIvBOTO+m7y8SVAegl0XeE0HW4v6sqwul38fXeXjNlXakBNjUtKkoB1dcSaUs3BA7UacgTfhIzeJ8OFxUA2t/76w7/YoyZmRbObgFJEYsB0tUk8wYTFYO7JV7S2iRMvzeFRVpPLCt4eZzCjv+HIU3I2hUvi8J7wh/hc6snBzEj5u8c8SczyGcqOXElx+b2uo9zSdzCJm/xOITNp+vK1uTzkWM2KX/F3LeIkHcHhKhaQjZ4uLZl1Ux5UtygulBCr3VZ8gDujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jOB8IuuJBHYpoL+ojNWs2tGvR0fOZA/Mkl1bJqtzxg=;
 b=m+yeIrkAva5jqrwSLt4ke0kKU9Oi6nITLMYG1f1gHaMy350v4JJyhTS+lNnoej3nFiL0a06EHtFyrqQ0qL6kG+4t+GjPySMpCCWNTUjAZlvQa27Wg5zSDdemEMEd3oG2G6ABHtL9vWEewwaiPaK85iAcO3alpRYT75N3C/t1axyJJQ37NDg+ttKCnymB0phNHE1G80y2/zNEUJ5agDFTgvZj+hrRypzZXev3TIC5n7etSW7ZFgCMXOBwvH3WTBn8pAqDrWqsOE27toxA5rxGRPm5/0rvofW4nN5Lut2gutm8N3AcdG513fbFjjPWQdBVdNgnYsglZR0BA/XWKJv5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jOB8IuuJBHYpoL+ojNWs2tGvR0fOZA/Mkl1bJqtzxg=;
 b=ZNctL2WiGa2ONXEsKXYgFn604XlDw/ERSuL32GfzOSm/Snc5q9R7Ml3gYbjS1/atXY13iSO9EoJs6qpwXK49Cyi9tdUueONJUXmXx2hDNwxgcYOkpIizqa+dImFeDlzi/tQShv08fdGlltPimFet93ShJS6MUaZDJxaimqnnr7KBInjlyuaT2XkBIrEjAlRD0hR1FQB+6nJP1iYZqziLX7O65QoTD3YA7CTYRhtjDmBiaT4j3tBzKBBNwzHHQjCWJ1SPdXB344zGH9SVbV2zvHHHG/56AzDS2LTB6TbowXdJrqiAq5xJgNX8fv2IbBYzI0SMp3Wlh/Rh7jmhSqwMnQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB6071.prod.exchangelabs.com (2603:10b6:610:45::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Wed, 11 Aug 2021 16:54:50 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::d897:7ba8:32ef:e745%8]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 16:54:50 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Christoph Hellwig <hch@lst.de>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] RDMA/hfi1: stop using seq_get_buf in
 _driver_stats_seq_show
Thread-Topic: [PATCH] RDMA/hfi1: stop using seq_get_buf in
 _driver_stats_seq_show
Thread-Index: AQHXjfsEgVxhiumyEUmeV0cILSC+AKtuhsLA
Date:   Wed, 11 Aug 2021 16:54:50 +0000
Message-ID: <CH0PR01MB715300FC66FA287A60BAE12FF2F89@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210810151711.1795374-1-hch@lst.de>
In-Reply-To: <20210810151711.1795374-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a982597-ed62-4b4c-2841-08d95ce8bc27
x-ms-traffictypediagnostic: CH2PR01MB6071:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB60718A7465E1DCDA8E85CE46F2F89@CH2PR01MB6071.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MtodDXnlXEOIfM5NM+RdR/gjPNe9ybtZFp2cGth6S+kwnIYZLC0URAyHe6wlc3MebSznK+0F0Nkz944L+LQW7ggVfcEWrd0FEoHdHfccE1P/rAoE74cghp2OLlxKwWT/OsC2MCqshDtJTwIEedm7f7tBRZ6F0TyGMGFsbE975lAXEjP15/LWr0f/77cM6dLDVlUKZ2nApnlPPR4dRvNgD6Gr/aQ+6JiyvhqVyQulvleciux6BYKsFzWaRPMmyC9yVg7JCYKKgpV9wzzJ66fGkCiNU1OfeV/l98kWw5ieitxC0tYI9SkoECaW5gC6yhY38vcUtNficeUKdn3VAkiXRoxh+JI9qfsfN6AVUqQRPMWsr2Q0cYZ+zwwy5JhT4OY4+9AbLllWwOOKxQ2+7M5+apcURrajYoAvTCuHVBReQpjqLIvRVGhrVW8cpbiNj/k29/NJ3JY0JMuT1RHy24uqbt8HslBnLaMWL6yOmtBAui4E+H3DNoOSLXXXzvEDweB12uFmZ6HqupulNkH9+6XHTqWgFs0pkaHeWohlhI26MI0efXZllVAWkDlKjU2/ZaUM7bZq2YPNnrfOXnNSzH/937M1bNQf7wQkmyoAW+SKqybwvhCZtITzm2BbNqyfrqs6cO+2JzcvTibopMJRGcknzR5KOpinnibDG76ZQL3KdDcmxPiN6U+ctGE9a+gv1qajUrhhWFMWDi31KntY/XoOCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(76116006)(86362001)(2906002)(316002)(38100700002)(66446008)(122000001)(186003)(71200400001)(83380400001)(8936002)(33656002)(478600001)(52536014)(7696005)(26005)(8676002)(55016002)(66946007)(5660300002)(4326008)(9686003)(38070700005)(6506007)(64756008)(110136005)(66476007)(66556008)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YN9ywWXUwG7EjmCO+pnOcW85sYwVmyPg3hk3+BCAaK3Z0EKUc2yltdytpzFs?=
 =?us-ascii?Q?bOunLc6Yv4Gkm48PY7VmNt+T/I0smmG4wHBNIlXdNV2C98dmvattm9B0F5XH?=
 =?us-ascii?Q?sk/+Npd2CERGa76PdNVS3h0j0byZGO0tzpFEPXJFSkP8LxEzxvnqn6X6Q3qQ?=
 =?us-ascii?Q?2cb5k9g7+PIjhHjsTQjRDIXX9rkMNJOYrihLr6rzKXc1FZulx0/F09VOmASF?=
 =?us-ascii?Q?60UmNDRgy+yZ6xi/5nA6a+XSz1VvQmT4sUHakMWgV2kV7bQIhlbMWpJt7xIW?=
 =?us-ascii?Q?bPaHykbd9Et0YCsrrV2NS35+4frCJOM27TRHkkmAcHzFuK5VTumNzQuURlKY?=
 =?us-ascii?Q?ihZxUjRhJcaBAO0njf/twxFMDPDujZYqfnFQEUALnqNBRjNifXQ+WSartJhY?=
 =?us-ascii?Q?QI50SgI4UMPXtNfmy8FUp4dKbhaqvQjBuODAfa+d6NVuoewzvfIwHuxGOiK6?=
 =?us-ascii?Q?Ssbdbf7Calbs4VazmRqu+Vurr4u6D4HtDrm4vm0X7efRwgtFojvvsQ8yIm1k?=
 =?us-ascii?Q?P2BAUVSYeBy9Jjzu0CnZ9vhwwCtq+kl2KYrmxI2WvjKgyQSl+9yyFbmM3ptN?=
 =?us-ascii?Q?g3D/knZ4ql4uWTI8bWzqO7MuKBuY+iX1nFCgzm/wU5XyvTQBSEyncmI/qQU/?=
 =?us-ascii?Q?jJ2wWPbSzw6bwdS0930HDGG2NPzN7T5LVbz18EFWPSTa0Kik8ZXQdXZTzNfe?=
 =?us-ascii?Q?RjmqLdJA870iw2RZylCBXh4o4ZOVCjEM1FvCa9i+N/cl2y0a8MoDFhACEfGV?=
 =?us-ascii?Q?mxE6cgdX2SOxmDvx3HtQy3RtkJ+7gqsn3Xv4g1hdGbjJD59mdrAhR3ArlED+?=
 =?us-ascii?Q?XUlrjF3LUVNKgdlfaF16GByEvH6mdUhwZEUqQiBZ2343N4grJjG9TfoAv1oV?=
 =?us-ascii?Q?0JiNzNzTK08g90CmH799CcEv7J03EELMBKgpH9cRQGqhJ8j/Ge7HUxK252AU?=
 =?us-ascii?Q?dEzKqnIU3toL8uzY8XN/PiN5faDzqg5SW1gauJ0hh7IzqtbwaeFKga2zMBIt?=
 =?us-ascii?Q?mzoNfZMdiZXiStxesBSfZMbo1CKlgBHz7t63C2OSSYGZHc1KJ/D8lAAfTu9W?=
 =?us-ascii?Q?X/CLTpKzEOj/nVkgAdi2GaF0+Af61EJOJLZ/OoyoI1DdsgUbGDdElDUVxI+5?=
 =?us-ascii?Q?G2wz1/XeayUNSjpBzYbO6IaWthKBfHeWiuo16/Icd9JTiceBccRlNJgba9JQ?=
 =?us-ascii?Q?ZTKFlQqyE6rK7eHuGnN8TEKmtjyUvdyNqznvnDxKQ6JxAjbF0T2XlnQtYGXR?=
 =?us-ascii?Q?0JxiQZKWlEWoydJiSsNXORhqRc4WFMJemkfY6ybQPmCWouDJno2kF34Txyqc?=
 =?us-ascii?Q?Hc4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a982597-ed62-4b4c-2841-08d95ce8bc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 16:54:50.7257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f16+wXj4GbkxZizXmaf5IfbiE2Ur83wUzRPhAImoicSY4+XacF3UTn2jZR2xH8oxWTttc7pmd75a2trHBJvRAZBZLOtKlZeNo7/c2avW8h+8Jebkwyi+JBKyqAeNl4wD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6071
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] RDMA/hfi1: stop using seq_get_buf in
> _driver_stats_seq_show
>=20
> Just use seq_write to copy the stats into the seq_file buffer instead of
> poking holes into the seq_file abstraction.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/infiniband/hw/hfi1/debugfs.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Patch looks ok to me and it tests ok too!

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Tested-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
