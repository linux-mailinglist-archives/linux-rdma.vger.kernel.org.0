Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C6AD525
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 10:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfIIIyB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 04:54:01 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:34818
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389047AbfIIIyB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 04:54:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvKDoW1k2YeVHjBeRMMPedXERyDHl37QxFkRvOoSwdSXvIAE/3kuM2rmna0pOul2mORCoirMsJ0v8vz3xmmyQqO7yk2Ei0dfpkueykaNUM/y1RDNiZx0TPmS5+acouSFypWse+C+kA36WZHPOMWMyfYBFyY3nkdt4DQaa78hUZp6phpnOlcsBLgu7AVSvvEOFQi9/Ctp3H9PZSZHElXAa8nJLmhjerPNpJ1ZXgEBIiaP0HKc1msbeji+mVqttqcY2oZ3wVOqZmzBf2ZvJ6Fg+qK7JIA0yPwQc6/clpycpypoeEjTS1LFPQWcan1xBAfIv3B5ShFinGaqvI9PWX26WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKmU5sPyE5MOztZP1r9OlnMFRp8Pc4CfpVywE9CelLI=;
 b=LyhhNAjUKCLxvKL6Lcvq8GMRRhxb9cHU6hAZVLJWzP2Msdz2Mc3S7+Eo5sgZP+CMJaEwr8cW9VF/KV2YWToPkhwLyYqWtx70hFrbNRvB3mVPJgqkNfA9ybb4Gau9NKGvKn1I+rdEdsXZVwkFrzdsZoHCUJTVsGYaqJT7OeD+3kvDY8nXbev2xBNlu4ONQcEzPboepEbXmMU+kWxS3xt+ooTBv2HVrma+D4ROEoh0LGp29bL6blGz33cNWI3JBIy0zOmgMBB92LTA/UxkYmYpwozK9eqgz4N5FM4LcqZnHYywFxAfEYrXh4ACKLZ3TcJ6ZIuIYxOarvbg/mBLjRiSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKmU5sPyE5MOztZP1r9OlnMFRp8Pc4CfpVywE9CelLI=;
 b=GyhLHKFDCRPD28Q2171cev36DIIKTs1B6DmHqPrNl+0Ym1/JR+NppzfaILp6zgGGob4G2/WaCpLx7k6fupOaPeVv3Y3cGIOpkTmisp3OeIUU0IoF1iO6AF1jOgKpivY5IXuKTTUIVzorh/VzhSLQbuR6Za8nGcbHyf1di66Si8c=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5104.eurprd05.prod.outlook.com (20.177.49.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Mon, 9 Sep 2019 08:53:57 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::79a3:d971:d1f3:ab6f%7]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 08:53:57 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 4/4] RDMA/mlx5: Return ODP type per MR
Thread-Topic: [PATCH rdma-next v1 4/4] RDMA/mlx5: Return ODP type per MR
Thread-Index: AQHVXws8lIwVf0WrrUuudwQ3iZvIGqcjGiKA
Date:   Mon, 9 Sep 2019 08:53:57 +0000
Message-ID: <20190909085355.GE2843@mellanox.com>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-5-leon@kernel.org>
In-Reply-To: <20190830081612.2611-5-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MR2P264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::23)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [148.69.85.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2a060be-af65-40b9-7820-08d73503400c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5104;
x-ms-traffictypediagnostic: VI1PR05MB5104:|VI1PR05MB5104:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB51046294677661E624973F75CFB70@VI1PR05MB5104.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(199004)(189003)(52116002)(6486002)(76176011)(6916009)(6246003)(316002)(229853002)(107886003)(478600001)(4744005)(1076003)(36756003)(99286004)(6436002)(14454004)(54906003)(66946007)(186003)(26005)(66476007)(446003)(2616005)(11346002)(6506007)(386003)(64756008)(5660300002)(102836004)(25786009)(476003)(7736002)(305945005)(71190400001)(71200400001)(53936002)(8676002)(66066001)(33656002)(8936002)(3846002)(6116002)(6512007)(81166006)(81156014)(4326008)(2906002)(86362001)(66556008)(256004)(66446008)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5104;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7LGfSobC6Y146Q/ufxi4adcaHedBiWvZF8yGsocNMgI6Rn9Ms5vDJgeFhtz9bhJB/lNlncQOfzPYHsPWcKJDtdlpEOozAdE99Ed+ADQ/qyQAdWfQ8bjPRKiVZU4sATYhS7Gn41UtDQ1mmqbWT0AEDhPFt1AUlbTLsloPp9cws91mPqzBa/jnz9qPD2IXGJnaXhV7Hz3HE8vX5/3fzuXscNDyFMS2Dbn0gctQF6Bd27vNptL+5cjmTR90fPw5/Bo3azf+cE+iX6mfLOYpcs75zfusaqWxzMT3AQW1mPDWgA9d9Va6owLTIWNLcuZDeUEQhXyCUZ+0kLwI2/nohj3gB3XX0AaIQgfpHfd1T9khq1WNz4Cq85N1UDxXwQPH/IrC9E6eKFzWdK+rE3E72TmZAnU9Agvy4diQMCe2Wwi1vG8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <500E90AB843FA84DBA0AA244588F5AEE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a060be-af65-40b9-7820-08d73503400c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 08:53:57.3326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E2CCgKH0r48NTJAT0jG4OryIaxcDb12r5pXtdUUfYRUKZX5cMlfp7vsQhBwTYisH/AbOS9xvo2dXDR8A6hmEEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5104
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 30, 2019 at 11:16:12AM +0300, Leon Romanovsky wrote:

> +static int fill_res_mr_entry(struct sk_buff *msg,
> +			     struct rdma_restrack_entry *res)
> +{
> +	struct ib_mr *ibmr =3D container_of(res, struct ib_mr, res);
> +	struct mlx5_ib_mr *mr =3D to_mmr(ibmr);
> +	struct nlattr *table_attr;
> +
> +	if (!is_odp_mr(mr))
> +		return 0;
> +
> +	table_attr =3D nla_nest_start(msg, RDMA_NLDEV_ATTR_DRIVER);
> +	if (!table_attr)
> +		goto err;
> +
> +	if (to_ib_umem_odp(mr->umem)->is_implicit_odp) {
> +		if (rdma_nl_put_driver_string(msg, "odp", "implicit"))
> +			goto err;
> +	} else {
> +		if (rdma_nl_put_driver_string(msg, "odp", "explicit"))
> +			goto err;
> +	}
> +
> +	nla_nest_end(msg, table_attr);
> +	return 0;
> +
> +err:
> +	nla_nest_cancel(msg, table_attr);
> +	return -EMSGSIZE;
> +}

If we are having a custom fill function why not fill the ODP stats
here instead of adding that callback and memcopies/etc

rdma_nl_put_odp_stats(...)

Jason
