Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C16149711
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 19:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAYSDH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 13:03:07 -0500
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:47131
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbgAYSDG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jan 2020 13:03:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duXEzpZ8g/a7uDyB+KqwKKX+b3IE7KwLxPafdNFHjMrNfVpuDolZyGJ6QZIYpHewCHud/AZFWA/7JdqeIDY4i8dLRebLoNTc3sz6eRkepSi2ipEQ/rNs5ZSe+/cPUp5RA35ipsnAkK9wMkMCU/9zTR48PUGZmuIzeviaAHGYIVBVk2FUKbEdzir997Dn0eeoBjVAMxCnJGnkBKVSyRWsbjWnhBzp6mNnxLka556kCRJ2dV8X4CzXLPn4ytqDxDeQLQMbsAxwQghuIFtjwL5a4HOQ6fXc2pNuuHtejP40+zYe52oYiHs8eL175fA7AXfadLPv5DiDecbQihsjY9Ew5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc4UAMFMlPM/E5VtwpnV7+Z+eW6YW6ZVwzQUV1je3gc=;
 b=TmK59+c6fiQvJC8R9aIvvus0S7yH27FjUAmsgdT8IBtlSLm0+tFU0oBp8kl67UnbuNbe2wPMukdNYMz2LxBgEYqx8C8euO2LOwikqB4PT2udm3OL2A/+THFKxZfoAxhEc55Oj7NwlwgieIMO2lTYFLT++peduSeqPiyfKbYlALmqADL30gk+9U2rmXVyITD98sOPwNQD8hy+VbAvRNIsvEFijuVZzWwukFwUhYDp97ajC3xqeKiwa2O0cPIY+oNuNsuL9jzecTtFQE9qG5uG5en6jSQG7Z9GQHOYKhVS72HIPSrqqftPfJ1GXKT8C1oQK8NfHDwG1TOvKlM+uNC0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc4UAMFMlPM/E5VtwpnV7+Z+eW6YW6ZVwzQUV1je3gc=;
 b=ZUGO6+gXeNSBNxi27AczefrU7R56oa9EEjhxdmOn5QjkCn7ztZcKL9fpG4NTcIr7PctzrsVsGM/6veKlVsAiw+w2VWvvX40Uhme/YF8IP2sjO6X8LBH8KiBwK45nwMKKN2OY+6+/1zzMLufWX+UCVM5BN+1zIpUXbuzVkwWGm9M=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6813.eurprd05.prod.outlook.com (10.186.162.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Sat, 25 Jan 2020 18:03:01 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2665.017; Sat, 25 Jan 2020
 18:03:01 +0000
Received: from mlx.ziepe.ca (199.167.24.140) by CH2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:610:58::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.23 via Frontend Transport; Sat, 25 Jan 2020 18:03:01 +0000
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)    (envelope-from <jgg@mellanox.com>)      id 1ivPlk-0001eU-Jo; Sat, 25 Jan 2020 14:02:52 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context structure
 with pointer
Thread-Topic: [PATCH for-next 2/7] RDMA/bnxt_re: Replace chip context
 structure with pointer
Thread-Index: AQHV0nqLx+VkrTQJYk+zGSveksMYG6f7rl0A
Date:   Sat, 25 Jan 2020 18:03:01 +0000
Message-ID: <20200125180252.GD4616@mellanox.com>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com>
In-Reply-To: <1579845165-18002-3-git-send-email-devesh.sharma@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:610:58::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [199.167.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2fb1ed79-a27c-4fda-2fc7-08d7a1c0d14c
x-ms-traffictypediagnostic: VI1PR05MB6813:
x-microsoft-antispam-prvs: <VI1PR05MB68130045CEB548C993C47FBDCF090@VI1PR05MB6813.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 0293D40691
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(66556008)(66476007)(66446008)(64756008)(66946007)(186003)(26005)(5660300002)(478600001)(2906002)(6666004)(6916009)(52116002)(4744005)(1076003)(316002)(86362001)(71200400001)(54906003)(2616005)(9786002)(9746002)(33656002)(8936002)(81166006)(81156014)(8676002)(36756003)(4326008)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6813;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uv3ylUBBn5tvAJZRmjt3zgWaO0jz/Xht+vXOIjQBo+t28WxoN582ue3eS6WUpCNYhrqil6Wly1I9UCn1LW79lccYbClH2DUAcrgHjXRKecwZMF5T6AW8+8hV526noBtXszyODNyEK3Uc6tbLwQt4woDqZlOFtF59SICLdpdYI6lrf4Anb8VTQHug86fjDNl8Q9YEiYsLlgh7V5qT8Wfjhi/TXJ3RGPgs/aniJkgn2NktRj4o5XsAdDkjQd723HAcFNtcmptXb6E7NH6d+NH5IrZsyajpq/oobWBkD7NmNjzASp7dLuNkTWeOLVWk9sDCMSuxFi4dLb+gNAGpqlOeh0rwAmUnjCp4enLYL5fy8tn8Mg31ZUOMo091a50IXt2cKq+adPxA2OGHUDg+kHEqOTR9rRnyKKkV40CWVMr8Pw4Y6A9slQp7Hm5H1qgTxAG5i+7r1PHh8iAa5vwzFzs2842VX1higOI6o2DzqXY4BFdBIfaINXuDD5J1m6bN4VOR
x-ms-exchange-antispam-messagedata: Jg6QKw66yberuc5FOmXKAIKdpTX6yqaEZ3nRMHr3ZaM4PTtBtmj7Mw8TGXsPeCVDkGprnJwKjrAtHX5o0QtKg+dlU8VnqWMo21udIRLhvislheJi/qvVBkQMYGVmkRZSsOQ1JLJVfEUpF9vJhnEO2A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8290A1B0F5F501499578F3DC6104A923@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb1ed79-a27c-4fda-2fc7-08d7a1c0d14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2020 18:03:01.5617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ItM0tUzMGLISynBdn/9WkBLfInkM3Rl6NOTTws3LJxYL6bCurDCO6832DOuf5BVPX2MPywNgnrhIsPoqVMvgbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6813
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 24, 2020 at 12:52:40AM -0500, Devesh Sharma wrote:
>  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
>  {
> +	struct bnxt_qplib_chip_ctx *chip_ctx;
> +
> +	if (!rdev->chip_ctx)
> +		return;
> +	chip_ctx =3D rdev->chip_ctx;
> +	rdev->chip_ctx =3D NULL;
>  	rdev->rcfw.res =3D NULL;
>  	rdev->qplib_res.cctx =3D NULL;
> +	kfree(chip_ctx);
>  }

Are you sure this kfree is late enough? I couldn't deduce if it was
really safe to NULL chip_ctx here.

IMHO you should free it as part of the ib device dealloc.

Jason
