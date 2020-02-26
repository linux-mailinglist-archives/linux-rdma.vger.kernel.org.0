Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D3916F745
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 06:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBZF2r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 00:28:47 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:39232
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgBZF2r (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 00:28:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W14QOmiBEUAc9Bm3F7E1O6PK5N19CIs+EDwYDmWB4UrA2Qo5uKtaIYY3BGyoS9tz5/uxyg3qgQgyR1YuVxUR86cI4EFSbjUSWj2i05EU8MoX1t40R/WA2+rBnZcUirAaXuCbVdV3U3C/dn2MYvOPNsNjbnnEio+cZavsFYgSR8A+Lg/f8bV4WAUI9Zv9buKN7Ws9lJLfT9Ozc0zleI2ndOQX20KkjJlLp6xSeuzJIwmV9J+RuJqr6f75gRdN0aMtjP5bCDne4k9Ih/vLbvAqE9WkhFkI8K/tc60bPLHF1zybBSRO42uE7fwvhiLVfKSH66jrmuqIqir2wptd+Qab6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neZpeDQunM9ER9d96aZwphhlU67MCa5PrYs9WvhFhGk=;
 b=f26zPrWoe5rV3Hzy5+OfEoG5z54xlveGoxinZu01ax5BRDDyTrdnQy70DCSuzX6NWeTavIXHoiWkPG6J+nBWqNn1VHPGIrZEvt5CSdzaxvONsmLPfDmAeOnPLb4JeROwpCFG3YxVHVDXkOqGYwsy/sPLpma8KE4X79g18YeGbu8dGPZVva0aQvI6Jge6QByLa5yQsRBak++iqAxC9PbL51gM8upUrkWlt2l8mMw6pxuqZ7gKXqXPo3VL9iouiIJesMTfB9Dx+u6y3nv3xhxdM0BCdc1Z3TzGtzOMRI3S4YXU/jLS5HE3wCuXS3zn4fHac0BJvLlQXvhoYXfeinMrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neZpeDQunM9ER9d96aZwphhlU67MCa5PrYs9WvhFhGk=;
 b=OFHpdmsWz4Fe6IvihdZ0Ul+RI6dwDKZTv/buqYo9EcxhhzLd3RBjdwb2JAYtBhB4Ngf9G4wFxHKzIGhF7giKVhUAiHff9ktyPSTxcQjDiVjxp5r1WDm4q+ByouFV3/uNv0wDNoyZoI0x/fyNNjFGWPxFAWkTxaH1tt9jbRRS+v0=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB5953.eurprd05.prod.outlook.com (20.178.202.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 26 Feb 2020 05:28:44 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::8c4:e45b:ecdc:e02b%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 05:28:44 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-next v3 1/2] RDMA/bnxt_re: Refactor device add/remove
 functionalities
Thread-Topic: [PATCH for-next v3 1/2] RDMA/bnxt_re: Refactor device add/remove
 functionalities
Thread-Index: AQHV7GMFrAzYEk2Fz0ynIoK1bQ4fwKgs8Zrw
Date:   Wed, 26 Feb 2020 05:28:43 +0000
Message-ID: <AM0PR05MB4866C0C2C9CB59C386C6FD17D1EA0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <1582693794-23373-1-git-send-email-selvin.xavier@broadcom.com>
 <1582693794-23373-2-git-send-email-selvin.xavier@broadcom.com>
In-Reply-To: <1582693794-23373-2-git-send-email-selvin.xavier@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [2605:6000:ec82:1c00:1566:5450:92d0:45ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbf34a01-9137-4ce7-26bf-08d7ba7cbf11
x-ms-traffictypediagnostic: AM0PR05MB5953:|AM0PR05MB5953:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB5953E144A2A085008A273A85D1EA0@AM0PR05MB5953.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(199004)(189003)(71200400001)(81156014)(5660300002)(33656002)(52536014)(498600001)(8676002)(81166006)(4326008)(86362001)(8936002)(110136005)(7696005)(66946007)(2906002)(66446008)(186003)(66556008)(76116006)(64756008)(6636002)(66476007)(9686003)(55016002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5953;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xbquCK0d11pjACM6lu5gsdTIsi4MBXLc6c8TfO+sG453phvLKXztcRKkCWnGt30fTjTmb5vvZKgM+mFxYNJmPZARSuJB2TT/7AwQpJbJ/em4NM15rMcInIjVOYN63PMLZHVO5v9Hw66FK7xz0faqYlr0Kyq47QuvWk4BT6KCO9Ig3nX7b4O+0FkMjtUrYw2ptPvrmV7YFYAEQwNc6iu29G3r99zii8UxAFV1WArHb1bGq02e5sK26CWRC9SS5rb6vH6rObsBY7njqkro/3QR9HXjlSE0KPBj/BHGZUCeCQES+Pz+l1FlUel60oX7rJ8Yox+pnkqjuahidF/nTx1zRMUiOkRvmGI01FKuuW/06MmwqLWq8TddyU8LDVu5YqHoGSlJIhxPF5+lqN8zkqAmpDSDbafZ9rJ3UfsDX6xty/WkzBBV0sd2U79lxfgX9RTu
x-ms-exchange-antispam-messagedata: Q4Pj/Ow+rNJW0MvSg2wq/cD3BP4JVWA3khQmnacVdU5TbEpDrOkQOJR+18jYctAQk1WG7j6I1TnKJ5YxPNcKmgLxsyIn3mmHZmZQYQiOyF8i/XOQo1kqrGWUjsda53xdyeH65f5AHZh8v3koe3GYtSudtJwFKZegnb2MZkakjfgwgESydBOQAWmNxbuUcVyasAUlnmrlkqIJjB4HURSmWg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf34a01-9137-4ce7-26bf-08d7ba7cbf11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 05:28:44.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLRY+5RgWtjo1w3rGcuopzPZn9tgpcoBgjPJqncNycVhPwV6frDEP4bK3A5w4rlc8siXV6yb2Fa7q/dsWoO6jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5953
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Selvin,

> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> owner@vger.kernel.org> On Behalf Of Selvin Xavier
>
 [..]
> +int bnxt_re_ib_init(struct bnxt_re_dev *rdev) {
> +	int rc =3D 0;
> +
> +	/* Register ib dev */
> +	rc =3D bnxt_re_register_ib(rdev);
> +	if (rc) {
> +		pr_err("Failed to register with IB: %#x\n", rc);
> +		return rc;
> +	}
> +	set_bit(BNXT_RE_FLAG_IBDEV_REGISTERED, &rdev->flags);
> +	dev_info(rdev_to_dev(rdev), "Device registered successfully");
> +	ib_get_eth_speed(&rdev->ibdev, 1, &rdev->active_speed,
> +			 &rdev->active_width);
> +	set_bit(BNXT_RE_FLAG_ISSUE_ROCE_STATS, &rdev->flags);
> +	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
> IB_EVENT_PORT_ACTIVE);
What if the link is down at this point?
I see that it was done this way before, but since you are refactoring, may =
be you want to relook?
Do you still want to report it as active?

> +	bnxt_re_dispatch_event(&rdev->ibdev, NULL, 1,
> IB_EVENT_GID_CHANGE);
> +
GID addition, deletion decisions for RoCE ports are taken care by the IB co=
re.
So hw driver shouldn't report this event. Please remove this call.
