Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8749514EB56
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 12:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgAaLAf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 06:00:35 -0500
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:50590
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbgAaLAf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 31 Jan 2020 06:00:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH+eYWktSORc9T6Eo9UYyStsnysyljJfc4aw2kpCBtc6XS1SJI3GmH/o5aSrY5nyanXG7/ili8SolymR42ptBhCQKmF0lPU2BUZHKzaMiiKiMB6vhzYHXp6EweQyc1PUf5NuC+eGYOULM+Wq3AC0bf7/Td+C85xInq2VNMqJxIJP0CXXQDRGum2Ki3Wj9EO+KjOVaipWFyYKYqRAT4MwYiK/cjRNNYvVoSXyuo7/WEjCvOgamTt9mHMUuMR4xp6gdRX2F8ZPbwzNUmW+PqWq0IpKalOxiI6Elg5e6wN14hzIEuePCrhuzY0dDkWX4+iq1S6bGX4OFEDey3/rF3nDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIqv9AcyQ4DNkPg2LnKcLv0Uycf+YQXFJzcgyPhtTIQ=;
 b=nfWFNar2OjtR7Dv5FYIeKKBO5kQjqLfexhfMq//pRY4/OQMnSSGinSuPeYwBD6u1ROIjgQeGGqRwPL/5iy6C+3YUfEjZ4JszbxoBX+SYLdKEXO+rk1WDWgf+u74PWZlomSXXzh8CT7+6ou6wYtQwdlV8eKZsCGbUNGjEQOCsaUAprtTSOVZZXKDXfb8dcyehSOzCvYOJ7JQBg8BFBXcOULoQth6dS5aYTwgJ0DCriB5TDCJiun0FNXwhGfd90K29tzq57tKWJpARl9Cu0asOVn0o1kaIZTq7qoqen9IaZ08Y8kZz5qV8+KaCR7vysDLNgqP8I1kSQeCrCSl3vmn9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIqv9AcyQ4DNkPg2LnKcLv0Uycf+YQXFJzcgyPhtTIQ=;
 b=s40INx41bsazvEM9mbnOJ7lSdDGP5V5QgAiEGjG/ThVfYNpRWBY785IdYdaT1DHWBAQFkec8LFKIY0kOQ56MXk9hwW4wwGNv84xx+fydAoCi4LHNc3RtOva4c2YPyYHrJRA1Yf1fxAjo7hX9pR1IN0FMQVEkXdplQAy9vzO8tqE=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4132.eurprd05.prod.outlook.com (52.134.95.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Fri, 31 Jan 2020 11:00:23 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::445c:4a14:1020:2346%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 11:00:23 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Jason Gunthorpe <jgg@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: RE: [PATCH] rdma-core/libibverbs: display gid type in ibv_devinfo
Thread-Topic: [PATCH] rdma-core/libibverbs: display gid type in ibv_devinfo
Thread-Index: AQHV2CHWPXYjVLViAU+bvTcZR5Jhp6gEl8Kw
Date:   Fri, 31 Jan 2020 11:00:23 +0000
Message-ID: <AM0PR05MB48663242B41CEB51D3535AF9D1070@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1580466773-24342-1-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1580466773-24342-1-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [106.51.31.117]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d09b7095-51f7-48ce-9e62-08d7a63cc57e
x-ms-traffictypediagnostic: AM0PR05MB4132:|AM0PR05MB4132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB4132A004F79A5B4D52E2968CD1070@AM0PR05MB4132.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(4326008)(110136005)(54906003)(52536014)(8936002)(7696005)(316002)(81156014)(26005)(81166006)(186003)(478600001)(76116006)(86362001)(66476007)(66946007)(66556008)(66446008)(8676002)(64756008)(55016002)(2906002)(33656002)(5660300002)(4744005)(9686003)(55236004)(6506007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4132;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GAo3+d3OrbxHkLLHncLCBbe5Cmxt30E+01ipL6W4W5LE/CKM8w0wkWWprnQYqIFtWmCyIX9przSbtUzhFq6ASZpkzcOVR8Xd1vQTE6YGoaO7eh4J4KXpQcJYjtyGL95WmtuqYx61hFy/Q3qIoUn0eEqp8dOZIDNTmZbHHVPkYX5yogHZnWrC/jyefKNrHeBx4jViccvk4khBBFrogpRLFV3nuinHCrhbwApnfVc0VR38KeXtQlYEJl5EVwh7CoTmODr7hVRTfrNmibe5AQXnFc7CzriRd+j3wb6mvIVCxhj/pFoBwioM0IkE9Ylii+d/lafNC73T07ckPOjANix/sO7niDmhXGGF8oEeAkivZ5pD7pwwqCK5Mq/vSGrOh4WXRW+jEJWCBsAgsIjUZWesX0tlAGn1Q2uiag7JLou2OZt4njAOOdUP/7T0vZ4jpSzQ
x-ms-exchange-antispam-messagedata: fQ1WbylSUiC4Fwi4b560M2xZGaQl8V6kAtYwnDaiQpbTQOxtE3VLTOreEHKM4qGMFfl73uNYSbI26T5S3+vBSH+qUEUOj6QerOAsVUhsVtsQJwyYInFfuWiUF0vhnKMLXLL0Mk/YfTM6HEztSPWZaw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09b7095-51f7-48ce-9e62-08d7a63cc57e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 11:00:23.4924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwOOcwzgP1rGxp5SMPYlPVh1pGg+0HYHB/8hesNy807yg3v5+ETRMJjm2F70VvhRvrn8UAUY6JL37/yzKRlKwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4132
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Devesh,

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Devesh Sharma


[..]

>  static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num=
, int
> tbl_len)  {
> +	enum ibv_gid_type type;
>  	union ibv_gid gid;
>  	int rc =3D 0;
>  	int i;
> @@ -175,8 +185,16 @@ static int print_all_port_gids(struct ibv_context *c=
tx,
> uint8_t port_num, int tb
>  			       port_num, i);
>  			return rc;
>  		}
> +
> +		rc =3D ibv_query_gid_type(ctx, port_num, i, &type);
> +		if (rc) {
> +			fprintf(stderr, "Failed to query gid type to port %d,
> index %d\n",
> +				port_num, i);
> +			return rc;
GID table can have holes depending on how IP addresses, vlan configured/rem=
oved.
ibv_query_gid_type() is masking the EINVAL error with RoCEv1 type so here r=
eturn is ok.
But as good practice, instead of bailing out the loop, if it returns failur=
e, skip the particular GID entry print.
This way rest of valid entries can be still printed.
