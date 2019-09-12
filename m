Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D767B11D6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2019 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfILPKS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Sep 2019 11:10:18 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:20316
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732715AbfILPKR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Sep 2019 11:10:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ6sSftcgdjM8LTkcnIP5/LzQR+1LZQFgnMp2mP54xU55py8W0ob5piwgS15eqqxbkL8g4qAwBV4CsMOCHh33iS+2fMmppDoLlza66N5og98ZIpzbkZP5ihPmhnqCs790jwGEW5NRzEc1HbtmEIw8K1T/DOnxd9d+DLTcSao/twN0dMg8AKDoHLWQ1B8Fatc4xy7nGxQ6+DYSVecBRw2cQIlKB3pB/R8XQ8EwaJhh+3UB49cpocTTWsCiJ34nyfSZxKvkDCnrpQuH3jj6gMH0jaN/V+KwlTv0vxk3d3tOTcGsiK65Kct6aAIU7JO+WYKGcka84AEQCrWCffGTdROGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HClE9pg+iaUzcloG3yF69u+OwIYyr3ZX25d4/JnowfE=;
 b=TJTgDtl8cuiM9qLWx9WvOdvSM4a0nbzrw0j89JhhwqQlwMJuqDMP4AHxqBrN+78jHPThZe6fW7Ay3M5COx58DHGIyFBb+LRDcrtfJv4c1eqnDKcOww56t/mcsSwgBduh97aq9FHrCb1W7PSrSv1njmW7lJRijuB62P60uHtjDAWnWaGRyPmxzIBRybUimC/OQQUpHq7j02LGOvXk2bZqxSO4fqR0ioy9kEse7/nElA3tnJ54SJuo02RTvMwHU5YoQKOpjpNF3J+UEvbw21hsOsemt8dLgIGGBLOHUQ2ccVw41NsNpp72K3V+dWJ/praPMAOqQ8Y9QogVcYixqiL8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HClE9pg+iaUzcloG3yF69u+OwIYyr3ZX25d4/JnowfE=;
 b=iaKWGezUh6YkWP/CgMHTlOSHZPakrgRwFdCBqGPqdB7vOzhLh6oGlQVHGzHyLGoVTYHsMS6idgqq/8pEAgYX7hvlZqOsRDWudzvAvQuRyn6CHliM8R13amiFedPPYhhBBAQ341MMo+7RCwNFc6P7HoCwSkFvVVAPGA80i9G2tl8=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5616.eurprd05.prod.outlook.com (20.177.203.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Thu, 12 Sep 2019 15:10:12 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.022; Thu, 12 Sep 2019
 15:10:12 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/bnxt_re: fix spelling mistake "missin_resp" ->
 "missing_resp"
Thread-Topic: [PATCH] RDMA/bnxt_re: fix spelling mistake "missin_resp" ->
 "missing_resp"
Thread-Index: AQHVaXws6N6XSST4B0exfPzef9SRcQ==
Date:   Thu, 12 Sep 2019 15:10:12 +0000
Message-ID: <20190912150957.GA9160@mellanox.com>
References: <20190911092856.11146-1-colin.king@canonical.com>
In-Reply-To: <20190911092856.11146-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:4:4a::17) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.153]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631c54bd-6dc9-4e11-8fea-08d737934f06
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5616;
x-ms-traffictypediagnostic: VI1PR05MB5616:
x-microsoft-antispam-prvs: <VI1PR05MB561626A0E3A6BC22BC665347CFB00@VI1PR05MB5616.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(229853002)(8936002)(66066001)(26005)(6916009)(256004)(14444005)(316002)(2906002)(36756003)(186003)(6116002)(3846002)(4744005)(1076003)(386003)(14454004)(5660300002)(102836004)(6506007)(6436002)(54906003)(6486002)(476003)(66556008)(52116002)(11346002)(66446008)(71200400001)(66946007)(25786009)(64756008)(478600001)(446003)(86362001)(71190400001)(6512007)(81166006)(99286004)(2616005)(76176011)(4326008)(6246003)(53936002)(33656002)(81156014)(8676002)(66476007)(486006)(7736002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5616;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eL3jK6/RTYrzkfxEkwxW8HPzHLIlEHzwVFbpkGOQI8WwsSLsEqd2L0jGrEJH/+qMCJ/ferGchYkFjcm41m3Imt5nO0J7cYjJ1tWbI5iVw7MtkhUMMSuhWVCKj1i/vBIxkL41kNu7W6iJNn2zeY3+j+QNpX8dFBuB1LNizEFgWmbcJS382o08GzOr6H4ryN3/2H4J9a8pTX4SiPboqgQDj7OF80WBqp/f3yjg/nUA4+eOHbIVK9+Kd6J8ZYUDGgGKKF1Hdo8uccqQL8qjWp/JlHeoDVVpTqjoEHHyk7BQBOItgwAzV9G9uAnN8rTFl9Bn1Ljw15MKzNAFN/g+8oiL2tUiucfapivrCVBONZhEFqcbUtVRzgyRUoOX8HPSccXAebWF5Pn2qu0gvhFBxvf1HkAPQ2k2UzRwKYLVPAuRF1Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F312E810625BCB45B0A68D063AFAB0B9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631c54bd-6dc9-4e11-8fea-08d737934f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 15:10:12.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqs8FfpgKARC94iuGywyWD5z6oeRfeiYmQ3o0VLaFcpqD/QV0ZAR114E3SH+qW1FyOqiA5mhCFLACIQfwlK1Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5616
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 11, 2019 at 10:28:56AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a literal string, fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infini=
band/hw/bnxt_re/hw_counters.c
> index 604b71875f5f..3421a0b15983 100644
> --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> @@ -74,7 +74,7 @@ static const char * const bnxt_re_stat_name[] =3D {
>  	[BNXT_RE_SEQ_ERR_NAKS_RCVD]     =3D "seq_err_naks_rcvd",
>  	[BNXT_RE_MAX_RETRY_EXCEEDED]    =3D "max_retry_exceeded",
>  	[BNXT_RE_RNR_NAKS_RCVD]         =3D "rnr_naks_rcvd",
> -	[BNXT_RE_MISSING_RESP]          =3D "missin_resp",
> +	[BNXT_RE_MISSING_RESP]          =3D "missing_resp",

Broadcom folks, can you confirm if this is OK? Is the string ABI for
this driver?

Jason
