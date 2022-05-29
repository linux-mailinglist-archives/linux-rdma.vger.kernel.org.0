Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4E537050
	for <lists+linux-rdma@lfdr.de>; Sun, 29 May 2022 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiE2IZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 May 2022 04:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiE2IZy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 May 2022 04:25:54 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636A556C10
        for <linux-rdma@vger.kernel.org>; Sun, 29 May 2022 01:25:48 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24T5FngT019633;
        Sun, 29 May 2022 01:25:47 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gbk8n1vv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 May 2022 01:25:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYF8G7F0EePrbyW//S8P898Kmf7aZ1qhO7iNrMVTzae+rD6mKDGcTY3quyVLG6hf9sOnsffMRDZMEPwt6PTh/G2CO/zKB1dxqg69glw2c8SORDsm/YbvVvhN46VN6W1KwH8Hzl7euVgYjFoqwcgHYjlhMR5BNiA9zer1s8jKPaY9+Vls2hTmsF2+IFpgKgvb10mFItsqjh3J0DQwIuboZl3iW1j++crlCVhkYcu0CdHwM4/xITREZ2BEVQ5oDat5Gmno24pJZ7Y+iTLq7gitWnXMaJWwWqcUgjBuyu4X4gbDrrraVFKTw746d5xcdhkqw430ih1dmL2b9qnEPemiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtYZmF1wuyzJSZ5P7bSxUCn6Nkg9QtOK8puRXsgtZaQ=;
 b=c8zEA83rOXLAcImbG0jYb4WPyihooSr1HcEHhCcK/6XaKtCh90UD5mducM3bx+z1MX/EVpkuERrn8Qyx6c1lP//bzf22j07yVCJ5Xxr+lrpZ6uo6tW8VqT1z0vD9TBaqfqD5QW+gj+jY0DoeEZs7Q4h4h9NEu+CzlTbZ9r/L+LMrMduKcZhBkE6Q8SP9xp9+NF+ybZLvW94tWge7UKAVtebd8ps3MeKFj275TY8hVRIF3ZGpkh7Ite61ev9kcudYCBMOEbfrMn9EP0EuNt2aDJ/NBy7woZDL+ZX4TVnzQDm8LyAF41bPZBr6xY2aO7DNaLhVFrecRMHS6xz0A1IImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtYZmF1wuyzJSZ5P7bSxUCn6Nkg9QtOK8puRXsgtZaQ=;
 b=WV7U3aV6j+gQeNgI8CVPUBmIBkfAGMJ80uazCRkmQND0cOO0sMK4DbShlu5S2Bd3uH6NR6l9wPRCKkLY6fwpQXAP1ppGQER73s24TzWLt4WChw1MFOnnTXp1SsxDPEiE17R+76PP+nSPCmuH1yKXuW6hgE3Ewnk3OonyWOywrnA=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by SN7PR18MB4061.namprd18.prod.outlook.com (2603:10b6:806:f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Sun, 29 May
 2022 08:25:44 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::2107:4c3d:3ac:fd7f]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::2107:4c3d:3ac:fd7f%9]) with mapi id 15.20.5293.019; Sun, 29 May 2022
 08:25:44 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Kamal Heib <kamalheib1@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC:     Ariel Elior <aelior@marvell.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alok Prasad <palok@marvell.com>
Subject: RE: [EXT] [PATCH for-next] RDMA/qedr: Fix reporting QP timeout
 attribute
Thread-Topic: [EXT] [PATCH for-next] RDMA/qedr: Fix reporting QP timeout
 attribute
Thread-Index: AQHYcDo7ZJWZgdoFZ0unXu6DJJmxjK01irHA
Date:   Sun, 29 May 2022 08:25:44 +0000
Message-ID: <CH0PR18MB41297A4A016C29A125DA3960A1DA9@CH0PR18MB4129.namprd18.prod.outlook.com>
References: <20220525132029.84813-1-kamalheib1@gmail.com>
In-Reply-To: <20220525132029.84813-1-kamalheib1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c07029-d925-4700-a84b-08da414cd31e
x-ms-traffictypediagnostic: SN7PR18MB4061:EE_
x-microsoft-antispam-prvs: <SN7PR18MB4061C1DD67B3FA52723DA444A1DA9@SN7PR18MB4061.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLnYuttll0jUYgbBpDOrKsh84HA7cxoxvIFGIJ85T9J+/FkKFJkcrfWdy1CIrDx+lnXsjKuRvXYjpKiAxI0yxKG86MzzOfyycPik53l++Jm6ir8S7BleIhv7qFQQ4bsb4F9hyPzi6LsAUGYhlfB4ouMN/6IpcdeFlLeOv0akLGOVcS7yuLDDuq0biDPoTaHsY0fXTgtxKkDnewxZmvUikaSZE8WwfiJTtFC8sXYXmXmrYf9d+dFwJGqle49eaiSqQmCOKLo1dusL9cFZ3SPgjxIRI1zO+QujuZ5ObV5XNvIo63B9Czt1M9cWQexJx4PiqeJOp+ex8t4tiUM+V3lzsCXvbg+hI3DSuR46u8zra4OxkLGiEyuDDcmLGYSGtODLbsT3gUFz3Hq3BujQNrKUo05gZZYDtobwcocnbMNYNbbSh4VbHBawXEUzudNXsmWRgEW9rdv/5ixtE/jVMs+NH0klu9egKJzYTvdFQwMC9dGri7OlR1Lgh7RmGfQkbBmZlUmwW9FOJ0/HkILsJqU0Ar1S+huUL36rOA7ASeHNCChLB2CU7jhIpnB+TSGJb9M1JKW6bZbpa0GmAttSIFEbQSOIi+yB3SdLn3IZ+vjnFgd0mdGrLCOSy1x3jJj9bNkdXDrjSYwi8nhhYUyJKopjem2qZ63CTAX6ckvJQgcZ0i7rNDWKsGBBWxudrXYqls97aL/vVJTyerjWjjIImlgZxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4129.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(316002)(54906003)(33656002)(508600001)(55016003)(9686003)(26005)(5660300002)(66476007)(66446008)(64756008)(66556008)(66946007)(186003)(76116006)(38100700002)(110136005)(7696005)(6506007)(86362001)(8676002)(4326008)(71200400001)(83380400001)(52536014)(122000001)(8936002)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rVPQZjM4GHJCGnft3WcCOIxGpk9IEYT7e+UXqKzI/uCdYUtA+lI90S+lSt?=
 =?iso-8859-1?Q?B9HNUF1MIoHpCzs0Qjfo3WLGR/krWo/nstQA6CC0ov/W8si89+imo4+D0Y?=
 =?iso-8859-1?Q?Luw+T97WvWhNAcyZS9O94Ma68Gpudb1B0hYSKXvFQw4dR1AiDvV2YUOst2?=
 =?iso-8859-1?Q?+HxSTa1P5Q7aCi42zBTWmDftHnqyHSgr6ilEGj6L8Zp1nzZvHPjOxEBuor?=
 =?iso-8859-1?Q?Id1Hlo/Ys/qkhcs6PDJniEfAE+b7qPeMD5i6fuWGi1k1xcptvSpNU07H0h?=
 =?iso-8859-1?Q?fKgJLBttDdEIujzhR2c9KoqUby+jOSdbTJPiEUZFRV9tf2h1p/2crai1V0?=
 =?iso-8859-1?Q?uOGt2GmZtuX++Z/RDwWFCNAIW979DFf71GoHVoDNwvD9o42gIfpuDecRPE?=
 =?iso-8859-1?Q?R0YoRjcS35TwMVbFZVari9vKCAFYD42CPGburQjlNKSkyU2DO6EH9Px8g7?=
 =?iso-8859-1?Q?gZjfu5WSKgCTdpFXRZFWxq1RQEDJ2kFGfIZIjG19Wp+rzQk5E134UTRyI6?=
 =?iso-8859-1?Q?ilNPot+6tKdWCO0hSavb0WH4cIvJ/encHEo+eWfZs3hq7t8xzD8gHBO3PI?=
 =?iso-8859-1?Q?nL2h5dU6IVkG5fyH6y5ZZF0sS0n8mmmJq3XmEGDvQnmr5dhRdwx3aKePBw?=
 =?iso-8859-1?Q?oJpDa0NAJ66h/sNzmmF4xgzb6ywTnogXHmHjSGFPNKmz1jjOAGDJ4nFsZD?=
 =?iso-8859-1?Q?apo7GMK+91/Zc//H2eLILfzGVVa6272gV7eU93fGoYpDE0FDa6mYi59Zcp?=
 =?iso-8859-1?Q?N6BtCvoWzbp1fuFIz3HBC5KrL38oKb3Q2nGUG/NfNpbAmzSdxWjvTyxqHr?=
 =?iso-8859-1?Q?11vElZQYr+cODBTU98oxd2akrTdmqje9+OiNuiw63Esvfq2SzSXG5c+e5H?=
 =?iso-8859-1?Q?aIdx+SHKo7LG4T8vdPdhHpzNJCpBUzf25ftQCyhLht+S5RM4Cx61QMUGXM?=
 =?iso-8859-1?Q?fhQIOe0GY9XBJCBMz7eTdenk5yXvYSb5gBW/wsEj6oXXCKJUadkaZEve2E?=
 =?iso-8859-1?Q?GL+M8GK30C21W/jnySW207es35jR3w2bZ+JUqOFROkGvCY39sdqIgSdADy?=
 =?iso-8859-1?Q?o4aJjqWiw4ao2AKWGwRlK8V5Wa4pVfwdJqS1LUwHLbm/SKxQBDk73SvJSi?=
 =?iso-8859-1?Q?KyPeO8jPPJ9Ze+hwOgZEcaZQtfip29DzWNmSM9hE+gvRxSz9rzFIN4XZjq?=
 =?iso-8859-1?Q?FkEpiP1uLlxx7985qj8M4MHPm9RgTsn/FKU6SG4N5MptA+1aFSY7h43rfk?=
 =?iso-8859-1?Q?2De7iVnjUEwe7efo3nvMrXGCFOfcAai1uTjdPxCv5KXi8ytxKelrZ7pLjx?=
 =?iso-8859-1?Q?9c+HEiSIuerxQgrVeN0qA7PcIEgB+WXJuosD88bPyPFIVhyqI6hdSwcOrP?=
 =?iso-8859-1?Q?EXfVbS6RBokQKI+zai4p14yYcPH1aO7bLEOELlF8Rfe2hfAQwXdooWIbZn?=
 =?iso-8859-1?Q?lM5gXFGn1646Uwq1ZjDbca8/bep24tMp6KsBoQwz/0et3NFmejepT9ajkC?=
 =?iso-8859-1?Q?uN2pCjVvxFVrfCp/TjO8Lq6eZDe07myywXYMb+jYipkEsRN4wY5xxCaf3f?=
 =?iso-8859-1?Q?OUHdm5TnDNFs7gvyK5sT0v/uo/UPt9Ay3B1Lb97/K8r/1C9mpb7tDHKEXO?=
 =?iso-8859-1?Q?9Xj0NPkli12li1thNIi4KyVIpUScyY57UC+Favh7DLTseLhKoJG9mUnMIP?=
 =?iso-8859-1?Q?0zSQ6Y0D/AkL1KVGJ6xfRCc1e8FgQvrv1BYWH6V/UH4nr+tEiLJpGMCPqD?=
 =?iso-8859-1?Q?fa96RYNdePH7Fj4pw0gbrPzldSjPRKSbSBC1FAagA3dg9bFokEtSUFSf8B?=
 =?iso-8859-1?Q?1tH2O3xXTw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c07029-d925-4700-a84b-08da414cd31e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2022 08:25:44.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XNfTMgt/w2VBqn5k+6Lizw8BE6QDDVVuDKpd5iPypRgSrgIDDS2qWvKf23q9AN+/q6g/jkMkGLPebP1O02/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4061
X-Proofpoint-ORIG-GUID: DKcCHWUz6TMjmFi8eMlntiYeLnLzIPJx
X-Proofpoint-GUID: DKcCHWUz6TMjmFi8eMlntiYeLnLzIPJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-28_10,2022-05-27_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Kamal Heib <kamalheib1@gmail.com>
> Sent: Wednesday, May 25, 2022 4:20 PM
> ----------------------------------------------------------------------
> Make sure to save the passed QP timeout attribute when the QP gets
> modified,
> so when calling query QP the right value is reported and not the
> converted value that is required by the firmware. This issue was found
> while running the pyverbs tests.
>=20
> Fixes: cecbcddf6461 ("qedr: Add support for QP verbs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/qedr/qedr.h  | 1 +
>  drivers/infiniband/hw/qedr/verbs.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/qedr/qedr.h
> b/drivers/infiniband/hw/qedr/qedr.h
> index 8def88cfa300..db9ef3e1eb97 100644
> --- a/drivers/infiniband/hw/qedr/qedr.h
> +++ b/drivers/infiniband/hw/qedr/qedr.h
> @@ -418,6 +418,7 @@ struct qedr_qp {
>  	u32 sq_psn;
>  	u32 qkey;
>  	u32 dest_qp_num;
> +	u8 timeout;
>=20
>  	/* Relevant to qps created from kernel space only (ULPs) */
>  	u8 prev_wqe_size;
> diff --git a/drivers/infiniband/hw/qedr/verbs.c
> b/drivers/infiniband/hw/qedr/verbs.c
> index f0f43b6db89e..03ed7c0fae50 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -2613,6 +2613,8 @@ int qedr_modify_qp(struct ib_qp *ibqp, struct
> ib_qp_attr *attr,
>  					1 << max_t(int, attr->timeout - 8, 0);
>  		else
>  			qp_params.ack_timeout =3D 0;
> +
> +		qp->timeout =3D attr->timeout;
>  	}
>=20
>  	if (attr_mask & IB_QP_RETRY_CNT) {
> @@ -2772,7 +2774,7 @@ int qedr_query_qp(struct ib_qp *ibqp,
>  	rdma_ah_set_dgid_raw(&qp_attr->ah_attr, &params.dgid.bytes[0]);
>  	rdma_ah_set_port_num(&qp_attr->ah_attr, 1);
>  	rdma_ah_set_sl(&qp_attr->ah_attr, 0);
> -	qp_attr->timeout =3D params.timeout;
> +	qp_attr->timeout =3D qp->timeout;
>  	qp_attr->rnr_retry =3D params.rnr_retry;
>  	qp_attr->retry_cnt =3D params.retry_cnt;
>  	qp_attr->min_rnr_timer =3D params.min_rnr_nak_timer;
> --
> 2.34.3

Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>


