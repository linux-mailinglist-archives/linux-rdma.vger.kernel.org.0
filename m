Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2A105B3A
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 21:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKUUin (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 15:38:43 -0500
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:55810
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbfKUUin (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 15:38:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCDDrRj3+zmtznWtlcqwsm4mpoy/Vh8RAWtGlpWrDhJir4UXLbKzjUwAL3DYVSYD3zeiH/mSLKbd7v1mwxgQLQ0CoZDENnu0ippip49gUOhAGr8IIsGVhFgIYt/aEtnwt4M/tVwdREZV0eZYgOdGfPb5a6IsTNTTZReF8nevAMjqPKc7sOClYz0gkFlgevj3STjg68SUJVXAlihroowwiIh8OxY7kZr4CbjNH6NDHOX2lxPCssrYGKj8UIVsY5sOa00yLFxcm7lBv9XqYjLfy3ehZj8LBHMh8FwLK7wXhWpNLusgHRXCZa/uL41Mb+GyVwqQl808M104Q2aN+7O1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF7tsyaSiG26IncLjKRRUtVK78ijXBLzixhYxKI/gik=;
 b=Dd527oJt2ThtvDJaQ8heccwpBi7Cvws+AcdZp80AMuut0IBHCDkMgfdwcabyByMomhcTa+amDvv1GZDvSFTSDLCi+mp4Uci44TPudUcV2ukJVRYm8ZkCTPW0czfVHHgb7T/6wGXal+pDkOkDNYE5zxgFSiC833MlRqel122VVsa0IKeDO0Rz9RfTYUII+AYMOQzfUYiOqdPpQogjLJorTfrN+Dc4jhl9AGQPqnXuKDj/R+ZfXj8C3JF0Cj3k3HcABH4g4BVAbARALfpER7w6qEFe0x8lSKMvwHBiBY7FHe9e6/LWIGlt6jP/iVuvTH0YzODjT9hFNDA31V4eIx++jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WF7tsyaSiG26IncLjKRRUtVK78ijXBLzixhYxKI/gik=;
 b=mwNpO8dBVlYlsObbugkmf1pmWCOk7hz4Rz0v0wozSBIF1oP3fh2z1+gElzynTRDD/MGCI57FX3XJ9fcQQkpJjrk1jyH9oGvHy8fStv9hOQfuxhaZFysB7bzaMxnbN9xFhhjTyM7382xesQAbSNnmNU7WZXnrhHPFLTDX0U2mkNY=
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com (52.135.129.16) by
 DB7PR05MB5447.eurprd05.prod.outlook.com (20.177.192.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 21 Nov 2019 20:38:40 +0000
Received: from DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::451b:7808:4468:e116]) by DB7PR05MB4138.eurprd05.prod.outlook.com
 ([fe80::451b:7808:4468:e116%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 20:38:40 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Thread-Topic: [PATCH rdma-next v1 04/48] RDMA/cm: Add SET/GET implementations
 to hide IBA wire format
Thread-Index: AQHVoJdh/kr9vbiVpUaAUvWhClYcFqeWFhwA
Date:   Thu, 21 Nov 2019 20:38:40 +0000
Message-ID: <20191121203836.GK7481@mellanox.com>
References: <20191121181313.129430-1-leon@kernel.org>
 <20191121181313.129430-5-leon@kernel.org>
In-Reply-To: <20191121181313.129430-5-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:405:14::30) To DB7PR05MB4138.eurprd05.prod.outlook.com
 (2603:10a6:5:23::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [142.162.113.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ff4dc96-c185-4142-cbf2-08d76ec2caa5
x-ms-traffictypediagnostic: DB7PR05MB5447:|DB7PR05MB5447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR05MB5447CA8F8D673D5A33D563C1CF4E0@DB7PR05MB5447.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(189003)(199004)(6486002)(6512007)(6436002)(8676002)(8936002)(6916009)(305945005)(7736002)(4326008)(81156014)(81166006)(6246003)(2906002)(6116002)(3846002)(229853002)(11346002)(66066001)(6506007)(86362001)(446003)(33656002)(26005)(36756003)(386003)(2616005)(66476007)(52116002)(76176011)(64756008)(66446008)(478600001)(186003)(14454004)(66946007)(25786009)(99286004)(4744005)(1076003)(102836004)(256004)(316002)(66556008)(71200400001)(54906003)(71190400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB5447;H:DB7PR05MB4138.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: htYpXLwX8r2XgoczWtB5waO2awdmzC/OsHAJMPKD5X9PlLtL1eWcMh2weeG/BSmIHKqKUoQvL66xTITeiyF2pSmibSG+M3fGG31wy7mInPwNp9qsBZ5OzgsCfQPVm0Zswz5yqQajf3+JkXyFRw6F4ahwWUySNdS+2by5ZFLJG0sjySdMGDEQuovbTaERcrnrw5nozmBAbavPDDkfMTYy76zkefhFgnKuVngRbQlxiLb4zWc+Lv1j0UAKbr9GjBepmbF8PRgD7e3anmpJNOxd3MdPPNYeRvGBQuXcmMcFZVwq66YITwlPQbBz6RQOoX18fGdljMBgZgRouocUs6rv8+UyS+AdNpsAOBQyCUClZ49M69VFEX+qveLUilzov9ElfK5SUjLuRYec3Mm1WpLHprr8D7M1N9wtZa2BNMeLlSs5qgkUD/0JFbMQB7UIp538
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EE397719151374F8E58B2B58800FF3E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff4dc96-c185-4142-cbf2-08d76ec2caa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 20:38:40.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrRq2zOrJPfyim3BbhNIz/3Jdk6kMhbaeguA88GOktrtZKwbNwiNv+7HczkyqwH8g9BlhVBG17+NmTrJzkB6TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB5447
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 21, 2019 at 08:12:29PM +0200, Leon Romanovsky wrote:
> +#define _IBA_GET_MEM(field_struct, field_offset, byte_size, ptr, out, by=
tes)   \
> +	({                                                                     =
\
> +		WARN_ON(bytes > byte_size);                                    \
> +		if (out && bytes) {                                            \

Why check for null? Caller should handle

> +			const field_struct *_ptr =3D ptr;                        \
> +			memcpy(out, (void *)_ptr + (field_offset), bytes);     \
> +		}                                                              \
> +	})
> +#define IBA_GET_MEM(field, ptr, out, bytes) _IBA_GET_MEM(field, ptr, out=
, bytes)

This should really have some type safety, ie check that out is
something like 'struct ibv_guid *'

Jason
