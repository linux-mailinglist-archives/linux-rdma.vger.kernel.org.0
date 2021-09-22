Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049BD414F6A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Sep 2021 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhIVRwl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Sep 2021 13:52:41 -0400
Received: from mail-dm3nam07on2138.outbound.protection.outlook.com ([40.107.95.138]:35457
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236945AbhIVRwk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Sep 2021 13:52:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USHE+AMkKbr0D2/fTbpmzC27ALIsJcdCKPSjWg824iUv5oh/X5Ku1Lbl8diQ66JqiASH8wUODuUK3dGlSfEjNYKLlaTlJwxQRplo6p7ppEZRXJTrH51NXoSTp8rJ8ERueUxp4ODOqEJ8eFjJnXfFmhU+JQdNPJlQZWRI4sxkI7tgj2dYkV1HrqszrI2cxkUiMsxvVrDma4yv99vZqrj2pdmvpDhr1/qCTXN8e/mXrWX78L6zBgk5iAbIAe0N6zFgrRzdnrkQ8EkVBmhnKZVXOJrifUobe0df0I8DxtdNYtA2jEYGaRPFxYMij8g7vqYCW6JOarJUMQjGzhedg1cOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eXUzId9kxlmhESvSGo6b22ptXmHGcRGBFHu8UWFeb4=;
 b=D1w7CgHCisBrvM83nXkjYmY1sCDX3w84NmzqjM4btp+/7iOwoILBtusJhxv1RHQ5bgTgphH/8778uXWASEptCVNtwzKxK1WdU9dcBluZ7jt7k5UwhjYfjShlWXBnzllXnEXnEPobtWYRmbYo2j8wVlF43yn80YTyLl4XccJs2WtFCtygdTkJdRIW4Lv6g4I8Oc4pD1P1ceCS3/xasuaNtcmQofeBSkaRVgKzASrwxcYNQcvpVlHwDXdbGJ41loub75PQMzxOlB1nEB7zzpSBfBAaE9hV9jkBZvLyRmPZRZLrCfUl5iy6yIlrXYHepmIpLVOxj+eF7kAQ+h5DS3VxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eXUzId9kxlmhESvSGo6b22ptXmHGcRGBFHu8UWFeb4=;
 b=Ozbl2Pv8H8jpwDfK0vvQg+qjyWbetuIjbLB7BEzDQoZ5CYJAlDkHBc5srgWDnfuW2nvNJTjvqDtCs7+PbXYwSqtLch0cmpuDmK7zeEC9zjx2H1QNL6RK/rKFleFQJWQnlubuHTwg/PfEC2dBc/3O969T7Nsfm+5YoWKI9hRb/KsvuQi6n5hNmle+dRASarVVBv6/zubzpogQUdEBAkYd2kD77BpA2iYIJ2IyZFsK8auT8vQFc4h3WjEuKwUbcmZAfpqRsLZeIF6PiGMC5PXHU/CK+AK9EgTdYRGmZgl/QfQIZ14VCdjHUmkQIQN9CE+gUDFFJ5/w9+D+JE4HuvpN3Q==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB6040.prod.exchangelabs.com (2603:10b6:610:46::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Wed, 22 Sep 2021 17:51:09 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::30a8:19a9:b5c7:96cd%9]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 17:51:09 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Topic: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
Thread-Index: AQHXr7imk55risfKAUmS2+aCDTMROauwTzmg
Date:   Wed, 22 Sep 2021 17:51:08 +0000
Message-ID: <CH0PR01MB71536ECA05AA44C4FAD83502F2A29@CH0PR01MB7153.prod.exchangelabs.com>
References: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
In-Reply-To: <20210922134857.619602-1-qtxuning1999@sjtu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sjtu.edu.cn; dkim=none (message not signed)
 header.d=none;sjtu.edu.cn; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05030d17-5d04-48d3-1eea-08d97df18f17
x-ms-traffictypediagnostic: CH2PR01MB6040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR01MB60405A092059B3A1B5A2B909F2A29@CH2PR01MB6040.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UAE+itiFSmBTxRcEj1x2X5GNGExE3KAuNuTImf3ttcAJ7NHWiJ/+v8NJ/k5Mh3xZ7c0DUXqHd/ExapVrUSHf5EeNJJ+3cxeVTbnvIJYpx/4QVzcQGMwQXrMQ5JfLCtoR6TOnOnXnwn2bM7vpn8oD4ir56Zc+Hvttfg2oy3k8I+K+SIs4bXeMB4Xcy8nW/Yb5mf9HoqVtyUMg7+IjipKuZZNDwSZSNBXHJ+OvKb1j1Ge/GJut0U4BhJzAQSv3956Q8Pxyb8VqEAjQ7zYpaynuLydkwYHgbQSP6E9/FaqSyzK6EVFUedvUAbJ7+6VYgHToX40S7Dwy+ZPuSQ/hZRKbPl+hnoIHwdrC9H2lmuayg559Qe6bxw9R55YfwA4oupkqik2LSwMN3POCELfULrqt8yUheBVFoRkJmKP1BaeN/ffTb2zXCeVxvEsUEngb8zqKGx+dUaZmLFeNMbRctPev2qI73ASyxP1b7+VTOjbXwOY3Pf6aK8X7XPIOsh3NVKvPzwLnbFg9VWr2XPgqqzMhqDKZz4YhZt9as5+LjB9FaDg1pnuOe8qzXQO/QgdRP2zMXlwaxEnNsruHxNjKY10qcPIakj1N0tmFhvJrwiTxP2rC6Qn9Ad7wK4TIrjMm8ucuqThmEa2LwAeZQSY2tbZa8ggXwJ/Nzzw185EbURlUXE5vHso+broFFPg9CfMKcuDV+ZguZp1vBh/D/9JlxMKP4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(33656002)(8936002)(316002)(66556008)(66476007)(66446008)(4744005)(2906002)(38070700005)(6506007)(122000001)(110136005)(8676002)(52536014)(9686003)(38100700002)(64756008)(71200400001)(54906003)(7696005)(26005)(76116006)(5660300002)(186003)(86362001)(4326008)(66946007)(508600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aYoywqEBBSHIhsKu+pQ3xubZG/ivH+ELi6prqgYxzQR6uumoxBV4YZc4o7wT?=
 =?us-ascii?Q?LTrtC2JNZTLmlfsP27tj3/X/9H1HH2DFqmPqCB+UZa1JD/5GsOXPaX+tiuva?=
 =?us-ascii?Q?WRxZNpzs3kP4go6RVTEoMW71gM7brV0j/X7QrDdrfWofrejhRpJM4M4vA1j0?=
 =?us-ascii?Q?EIL30lR3E+9Pxcbe007R+Ez+AQziDENMz/L8JWFOH0VW8fxSTBJE9W2Bd2Ds?=
 =?us-ascii?Q?YGmC9Rdl6AKQBohgdbWwuBgbsa227n/esX8/2pf5QGPoCGUXUn9A3v6V3MgZ?=
 =?us-ascii?Q?9fdkhliqRGoSqWkun1Hi0xR4eM65YjDtrrvd6/yTXH72kgvMAZxS4nUFfwcz?=
 =?us-ascii?Q?/eBlhzGEwVAGbVg7C8AvkNr/p23DYFmNCFh4jx/0pjLjFeh0BTaZvXhoFxt5?=
 =?us-ascii?Q?bGOfvyKBWYKgH8bFz6st0y5FQsO/0CHvEMTjRJhnbRlaELSxKTVZJMxpYNtx?=
 =?us-ascii?Q?j8C/JDYexPjPfHGFgGJp8eRMd3ChVz0/RVcoLERROdXIBRxsizZMpLbTZTi2?=
 =?us-ascii?Q?yeryv9mbfUqel+c/Xqdq2HszXPV+qdjEtvOmy4LyuPMZrGLtpmE3F7uaQlOO?=
 =?us-ascii?Q?l6HEYCAVIEs7H+6O90ghl4e1CKunLhz1Fh9yYGAh4XPrXX0gjoYqH2vX2sZV?=
 =?us-ascii?Q?VAcUoGx09BtRtWHaBkmurnbQI9iXsr/y9fzOMOoJSB5Z2nvtr2OO33JeumHh?=
 =?us-ascii?Q?/cxMmb2dUKTORx6kAdjugkAG8HeEZoa2ImcJ4tmMNE+RU/23W+NKRL1BZr+8?=
 =?us-ascii?Q?XKpF3Xphr+hk+jBqXbyK8y2iTwSQVTnwgA1mdZ0YkH80MjAOr/hPAKkpC+/i?=
 =?us-ascii?Q?8nOKwfCTMrIBW047JNCgJxuIkHDiZslbpM8ke7gj0yiHfX5eRKID+Dnwq8re?=
 =?us-ascii?Q?hMCZJAIytLR1DMnzn1+grXQ2+S8y9b5a3bthd85EVXVjUbylJ31hv2E6dCZQ?=
 =?us-ascii?Q?xS7xT4bbNWZaLf2sMJBkGD/0UZlUs0RpqHWmsFu64krT57J+fhLUiJi8pMYX?=
 =?us-ascii?Q?7xa7z30WRmnXck8HZx1UwRQZMpJSM+sxTBAacbhoh4GWCPSHPFR2dO+AZ6tL?=
 =?us-ascii?Q?ObrkEQ6BRkIsOVXnsxrdhdrINvefJ6dS+pVybhTWI1evYtU/gt2h8Df1qfnW?=
 =?us-ascii?Q?kMYrMAw5rFdRBdRSYLK3r4ymbmswTY6hX9FitHRt/hy9TTLf8yo7CiehyEb4?=
 =?us-ascii?Q?l3SWldSRtCawSEbSjcM2mlwqsrHM4bJSTS1WqafBIm4iNGN+/MTWdC0yCWy2?=
 =?us-ascii?Q?AOeDMJV+JNcy+tyONdhtQWT+QEjtT6tVAai5onAZhGITrFnKKO6uMEZ6pon8?=
 =?us-ascii?Q?Ljk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05030d17-5d04-48d3-1eea-08d97df18f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 17:51:09.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpJGDh/7nGgXE08+74gYGM5dx598j1UNPLWNN+A84q38sWi48TSeIdmENE+hEyjS6DFgdtoZSvk/Gcios+wHZ6h35lYsfqr+6mwGU5nsLYLD6qLDgVB1HclyjRKJdif9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB6040
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> Subject: [PATCH] infiniband hfi1: fix misuse of %x in ipoib_tx.c
>=20
> Pointers should be printed with %p or %px rather than cast to (unsigned l=
ong
> long) and printed with %llx.
> Change %llx to %p to print the pointer.
>=20
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>

The unsigned long long was originally used to insure the entire accurate po=
inter as emitted.

This is to ensure the pointers in prints and event traces match values in s=
tacks and register dumps.

I think the %p will obfuscate the pointer so %px is correct for our use cas=
e.

Mike
