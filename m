Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0367011474C
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2019 19:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfLESuD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Dec 2019 13:50:03 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:48151
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbfLESuD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Dec 2019 13:50:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVDj72VqtyNDHGWlqpFL2BAv12SYw2NTlY6lccOdHIy5cRWEblMMex5xxfyB5PkGQRaUAvsbEnS+U3wTFAJ0mrNegtDFlJ9qmQeeQW3qt3V6tKBzp3Sq87+u/EF3CO2JM/WMOhiCEjgskAOEn+GKxYAfHYXNIS9gzuPGM5jsK6RUrX/eSkiLAPMTLQrq/Q0wDDjVtKlcJ3Ors9dTF2Sl4BICbfBqOvATjBt8xdHckkNg5mCPuVZLw6X9IJST99yS7cnL3Z4JcDdYnOeP/+WHK2sfKz1hp4AlSV68Xlue/VjRHxZc5b3MqrxlOv70gt4Veis8CTs9utBxI8bNrRL7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqpEX+GRcN85lqr7uGDwuxAtDob+08CroYaIAD23nEE=;
 b=gqhDU/PaFx9LwscmckX+3O5F9KjPNShGxFt35MRbYbBpNstDcF0hUm9kWxSmS9OzfMVEtqHt6p50/l5i8QzP8oMAys09KzXOC2OFEFF34gABOtJTHzaHsEfJNyTCuexU63vfnASjrIu/8joSJ27s2ijlnOdkgFqh7mPvsh1BSpy1ZMTrFzHfrxmc5KtAoQGKDIQ4mVsPvkPc86wTmxUirJoPYEINk0By7gm/A4Ilht5TQYG/E+9LzVLF/jAwJ3cOQXrUeHabaswR6oxIMIfk15WqXR9A0akzEBXbabCXpL58gBEV8/rnAuTVYDmTPK4Ys0dsFMTbKG5ALmfimotbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqpEX+GRcN85lqr7uGDwuxAtDob+08CroYaIAD23nEE=;
 b=Jd4bTje69b75n46bjKpVVhUn5MW8a23mmiR/GzFa5jjJXutQ6rtTP3e7c01cCF61oak2wsi2qoXkgz2gcH12YhI/5pNWAAQHTClLPAzgp8buxq/35VaDN9fggx2waql+Qf8NHIrPj1xcUF8s2THa4BbSaFyl+Ua3oRJyD+kfTsA=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4756.eurprd05.prod.outlook.com (52.133.61.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 5 Dec 2019 18:49:58 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::16:9951:5a4b:9ec6%7]) with mapi id 15.20.2516.014; Thu, 5 Dec 2019
 18:49:58 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RDMA/cma: add missed unregister_pernet_subsys in init
 failure
Thread-Topic: [PATCH] RDMA/cma: add missed unregister_pernet_subsys in init
 failure
Thread-Index: AQHVq4X+uZCTp3HGm0yAWTgo2WdDwaer4g5w
Date:   Thu, 5 Dec 2019 18:49:58 +0000
Message-ID: <AM0PR05MB486638F7997D643FAD64B482D15C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <20191205160632.32132-1-hslester96@gmail.com>
In-Reply-To: <20191205160632.32132-1-hslester96@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70c08c0a-fbb7-49a4-57f4-08d779b3ed95
x-ms-traffictypediagnostic: AM0PR05MB4756:
x-microsoft-antispam-prvs: <AM0PR05MB4756336E7C79D24302188A11D15C0@AM0PR05MB4756.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:83;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(71190400001)(71200400001)(305945005)(4326008)(11346002)(14454004)(186003)(74316002)(33656002)(102836004)(26005)(478600001)(76116006)(6506007)(66556008)(99286004)(8676002)(66476007)(66446008)(316002)(55016002)(86362001)(66946007)(6916009)(81166006)(5660300002)(8936002)(25786009)(4744005)(81156014)(52536014)(2906002)(229853002)(64756008)(9686003)(76176011)(7696005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4756;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2S6h+9siS6ywIxMFrzlNiqQKHp/iaBcfaf/QLWze0lkWvdhKKvZPq8zsKBKVi1d/ZrTFYwDZvaZr3Y3meJzI/KE6itOcZmuuoZCCtIJfDqTAthM9SMlSESgYzwI7Z7cw4nlA8Z5JxDv7Df5hGeC7R0tsYjqeSxLrHpuFwP+2wtBnscNjShBYD2IjtJGVBPRWO3MgbZB8dZ4IeiYn1OW+j2EieaHoY6KGfFH9+Ml1P2i8OZ6lSeNf8v73/PQSppOpSc/iw7ni4XlUkhRnXb5fOYN1dWsqnXQjELE/vpAk4JLk/KT7whPSbR5xSQWcehVn2gavTOSvrjJN4sNXP/7yleGrh2L9TQbzFrjonLlhEQvR05g3gjyV68WicQBPBF5/Dl4ScBucSvf5Uv/Wkvysmb4+MGywi8RF21njTqjg/ZNv/g9Mqtg0ruqs9lejCXK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c08c0a-fbb7-49a4-57f4-08d779b3ed95
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 18:49:58.7469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZCTPfvtrtJCOD51xShImtjP2qFBRU2AbQ4t1QS3bjMyQWVSf5CU/T+OUkRMSu9eAEs7z/UhfccuvSc8+8n/cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4756
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Chuhong Yuan
> Sent: Thursday, December 5, 2019 10:07 AM
> The driver forgets to call unregister_pernet_subsys() in the error path o=
f
> cma_init().
> Add the missed call to fix it.
>=20
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/infiniband/core/cma.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.=
c
> index 25f2b70fd8ef..43a6f07e0afe 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -4763,6 +4763,7 @@ static int __init cma_init(void)
>  err:
>  	unregister_netdevice_notifier(&cma_nb);
>  	ib_sa_unregister_client(&sa_client);
> +	unregister_pernet_subsys(&cma_pernet_operations);
>  err_wq:
>  	destroy_workqueue(cma_wq);
>  	return ret;
> --
> 2.24.0
Please add to commit log.

Fixes: 4be74b42a6d0 ("IB/cma: Separate port allocation to network namespace=
s ")=20

Reviewed-by: Parav Pandit <parav@mellanox.com>
