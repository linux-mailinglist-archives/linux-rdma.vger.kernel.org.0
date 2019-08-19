Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EAD92354
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHSMVf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 08:21:35 -0400
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:53150
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfHSMVf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 08:21:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lipn8KawDKeohOjbyrRik6ZqCTqpZkLyNW4bp3ZQOPgVmjNfhfWIBNNoQ1oSS2E2jJICUc2lnRadILVXYfBYYDRVb5xIk9WrXwDBRQcxdh3oK0+tjvaq0KqiH93MZnvGZ5a3GTaaUYRvQGYaOFL0hKifxttEEjEIn6QQieCn0GTxcuoY8wDyyv7Sf76MIowyzOezYhZogUw85gW6exz/ABBmOgn7gzrzXDvUe6XatL8/SwA9/NUBrs1fMiDHGhZmz/YNYI76mAhPvmTtqFpKHUwp9MGhHb2SOq/yVUDXZIeeHqJ8nCb3e5UFUyY+7yarLxjQr0nKGEFH3DWZ7OiNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpFKLlB72VHsJMJ3bD0BSSgS0WWQ1PHc+l1+bBSECsc=;
 b=ePqkwIKPk3U3+/mvUL6ypOFx59PxkoYfVHzjeeGC7KAfUOTGHR7lCd0lJSUH9sG9FPUecniNCj7PLZ/cD02Jjgz+xQShk2Ren4jCVHSSVslpg8JgDE86aNW2Y04AcPAFI5jXu7n6sqjov7EbXxuUYNGm18hb2mhsmp+Fd5XXc3Tg4WZjXlfcm0XnSyGH8iWFv2WdCxlWvaPHg6enc7z5xMibv5TNLGPeRIiEIhwqm1NhUtcb+NZSEBbFIoKkyuVOozVMEE3AjDhmVYuiqn6VBlASovam3hxRFcZNcdozmpt51ZrdgUEqhTnqFF9i/L8+buGqFqZlUdiT9U/WGKZB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpFKLlB72VHsJMJ3bD0BSSgS0WWQ1PHc+l1+bBSECsc=;
 b=EPnBtLqu8CCx++DKOz06mD5cOMFNN/fzCA/ZFIBFYSZBbgJFMqI6LYQUJTo7HPCc9SHvx0Ylp3xd9+yRH0c9mv6Z9ZA6zDcogu8nn3rx4pyzoaXSstd8dqSbvawkjkw6Qx9+Z16BnKNueZlYfF5QpDZxjv1wfxZl39YnV6Jy9mc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4831.eurprd05.prod.outlook.com (20.177.50.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 12:21:32 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1d6:9c67:ea2d:38a7%6]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 12:21:32 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Hal Rosenstock <hal@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        oulijun <oulijun@huawei.com>
Subject: Re: [PATCH] RDMA/srpt: Filter out AGN bits
Thread-Topic: [PATCH] RDMA/srpt: Filter out AGN bits
Thread-Index: AQHVVoiim0GU9wq9dk64C5+GB9JNzg==
Date:   Mon, 19 Aug 2019 12:21:32 +0000
Message-ID: <20190819122126.GA6509@ziepe.ca>
References: <20190814151507.140572-1-bvanassche@acm.org>
In-Reply-To: <20190814151507.140572-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd15de2-e20d-4020-99ee-08d7249fc4f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4831;
x-ms-traffictypediagnostic: VI1PR05MB4831:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB48317C520AEC2D11879F7667CFA80@VI1PR05MB4831.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(486006)(229853002)(11346002)(186003)(53936002)(71200400001)(71190400001)(14454004)(26005)(305945005)(7736002)(76176011)(6512007)(6636002)(2906002)(52116002)(9686003)(476003)(446003)(6116002)(3846002)(478600001)(6246003)(4326008)(36756003)(110136005)(54906003)(25786009)(99286004)(316002)(5660300002)(6486002)(33656002)(64756008)(1076003)(6436002)(86362001)(66556008)(386003)(6506007)(8936002)(102836004)(81166006)(81156014)(8676002)(256004)(14444005)(66446008)(66946007)(66476007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4831;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jhByzjaSeX1Dp12eWVVdqdbAmsxhJl5edESDz9tcZ0nfvO364mP1PM4/dngtLmmhsiG1HYaWZv5H72bhQP0VIHaG1+uYebusuorktYglWHNWVcGZbcNE/xGJYPFcZS231aITxDXuxg8Kpgy3VTeaOngv7YLtJ07agS63WwDbJ/MQBu/Y4+8m2vJZW8ntXbJPC5AOWtMuczURL7ndY3Al9A5KbjrPo9ZGxmXuuXMPwRONxUSAVW5IrJD84vDnN2p+J1aFjiX4LQxLSoxOTyQDwtrU1iVIEWRMTrbQw1CMJMXh0GA8x/WfNwad0DNA1/yg6VZ5Kb7cAJHmleBcgjEPka+aP0n3pd6+8Ze5kLFC7qz4chCsJXEpMAXl8fSDgFCfZp5BNjiYZul+S9xTVlJbCT/nAAo+hSd+hnlIF8Ceze0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BC14C9F6592D441AD539430671157CE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd15de2-e20d-4020-99ee-08d7249fc4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 12:21:32.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ylkNf+F88rGaH9dRbU8NEQzedaIEKHXaSdosRY6AlvrcP+L0P7pBgCS+/2fr+Kjq2OegBMdlITZhmFGUJQWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4831
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 14, 2019 at 08:15:07AM -0700, Bart Van Assche wrote:
> The ib_srpt driver derives its default service GUID from the node GUID
> of the first encountered HCA. Since that service GUID is passed to
> ib_cm_listen(), the AGN bits must not be set. Since the AGN bits can
> be set in the node GUID of RoCE HCAs, filter these bits out. This
> patch avoids that loading the ib_srpt driver fails as follows for the
> hns driver:
>=20
>   ib_srpt srpt_add_one(hns_0) failed.
>=20
> Cc: oulijun <oulijun@huawei.com>
> Reported-by: oulijun <oulijun@huawei.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
> index e25c70a56be6..114bf8d6c82b 100644
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>  	srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
> =20
>  	if (!srpt_service_guid)
> -		srpt_service_guid =3D be64_to_cpu(device->node_guid);
> +		srpt_service_guid =3D be64_to_cpu(device->node_guid) &
> +			~IB_SERVICE_ID_AGN_MASK;

This seems kind of sketchy, masking bits in the GUID is going to make
it non-unique.. Should we do this only for roce or something?

Hal, do you have any insight?

Jason
