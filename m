Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6488D55F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 15:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfHNNt6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 09:49:58 -0400
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:49411
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfHNNt6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 09:49:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lt6+akrIKCQilzb3OJFXKl7qer5u79LRJHS9PM3yAP9Ld5FDea6ZNA5CWqDgvanKX3RVppehgZEAFqUsW0O4GzOJy4zrtzHUd8tzzTGR07bx9p+KHCh2BaLv2vksYpSK1lt6z2OfxEt/2UXh+x8iccoOVYB/M5VmkjX27ZnI3KST8Hw5cCN+suwnFTNKptHX1fFp0aiK+20P0qLBxma8hnLhkh+bXId8XH8MI4MWNOC6IiWc1s0xdvUsNSSpb13JHQBv1RoG2YPZ6D0JJjIblYZLIJ0s2s8ZnQiaPfeaxo0OXhKGUxdjBIOSpHnqt8GLRPb19QdZ/D3b51vNbtdWeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p78FA9Q4NSsJEbeEeUXXyc+BHuA78MIEHwvZFCzPJNw=;
 b=hIcJK9bRIPx6Rab42FMQl5bjzewQzN1A3qFzND8a0cB429AHquKJBhd2oM6noq4buuqua75OwiamhUZeU7foxwVmv/BwUsWX0gE4OFpVLCtZTibykbA3ov2+VosfRdn1Rqi07ixiBxi6gis9PyqXYb347k/por2Kho2l+eY8Ung4eP3HjFLGy9Nt0TNtqZq8bt2XZcAlK5kyeTU6Mh/kU80BELUS9HD1bu5FjUvQII2TXrnkKIZiuKwWh0CzIxjeLA17LxxedsFtnAanLYJ793loSpjgJRVp7nNS4gttvPU+1kGfnRuToLFqTfHWyix3DQ/KHSmwtJl6teFpeQroRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p78FA9Q4NSsJEbeEeUXXyc+BHuA78MIEHwvZFCzPJNw=;
 b=kNFOaELi8TnZYj1GutBgBH1PdnnL1uXzDlAeEQN4Cn5DT7CY6JvP3Kj8uewxpwGgjvyVRnooJ4pWdGgu8JYsm6gqG7Qr5LhXZVAKf0/627A/hW7RiRS12n7kIEWbtBHEeDfUCJrfRY//NcauAZIOeWDyQCI4JByJr6qTA+4msiM=
Received: from VI1PR05MB5295.eurprd05.prod.outlook.com (20.178.12.80) by
 VI1PR05MB4143.eurprd05.prod.outlook.com (10.171.182.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Wed, 14 Aug 2019 13:49:54 +0000
Received: from VI1PR05MB5295.eurprd05.prod.outlook.com
 ([fe80::ec21:2019:cb6f:44ae]) by VI1PR05MB5295.eurprd05.prod.outlook.com
 ([fe80::ec21:2019:cb6f:44ae%7]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 13:49:54 +0000
From:   Vlad Buslov <vladbu@mellanox.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Vlad Buslov <vladbu@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report] net/mlx5e: Extend encap entry with reference counter
Thread-Topic: [bug report] net/mlx5e: Extend encap entry with reference
 counter
Thread-Index: AQHVUo7BzpBonnqFR0asseUVjZ66Z6b6qSyA
Date:   Wed, 14 Aug 2019 13:49:54 +0000
Message-ID: <vbfpnl73lhc.fsf@mellanox.com>
References: <20190814105302.GA14514@mwanda>
In-Reply-To: <20190814105302.GA14514@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To VI1PR05MB5295.eurprd05.prod.outlook.com
 (2603:10a6:803:b1::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [37.142.13.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f9413d-a6bf-4018-43a2-08d720be4968
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4143;
x-ms-traffictypediagnostic: VI1PR05MB4143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB4143269DB26A84974B8C3B33ADAD0@VI1PR05MB4143.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(199004)(189003)(305945005)(11346002)(7736002)(66556008)(64756008)(186003)(486006)(14454004)(5660300002)(2616005)(446003)(476003)(102836004)(76176011)(66446008)(66946007)(66476007)(386003)(4326008)(26005)(36756003)(52116002)(6506007)(316002)(14444005)(256004)(2906002)(66066001)(99286004)(25786009)(71200400001)(6512007)(81156014)(8676002)(54906003)(71190400001)(6246003)(53936002)(3846002)(8936002)(81166006)(6436002)(229853002)(6116002)(6916009)(86362001)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4143;H:VI1PR05MB5295.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: evHND7Hx2Y3BZCURW6BrwFX9o2BRlI0YYLerauolVKNAI7GUJDEG5sPd3E+U/eKIlWx4ZVXC89mhEaRG5iUNMmmlZdz2fV6YNFe7auid3VbWJuEl56kRgS+eNRF36I4bKID9uzUFU4Ui+mFfHjUjKhgNf3YDFGe1hAs8Kxbcx1FifbU9vl3Sd+i0yzNGFwFaPtLqYT9RuqAnLWvPlXPEoH02EyR/MlQRxniON1gy/0fnUDbWRaN/76yV58NPgdmWMdNCDCE2Hw7boJKI/XujIqf8hR7ruNFxp2xtPBFe4JoMiO3FoPZ+AeLiOpLiUcfq9KrppzaJxNdhuBXI28j/wkOXsFNmzPtr+HfFzeXDQXrEVt3nYozsK+eCIGvoA69l8UlVDFKW3pJGAP8KsFqA5AWr5DTK96mNSYNM/dGxHFI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f9413d-a6bf-4018-43a2-08d720be4968
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 13:49:54.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VU3DlbpIzjGCrJc7Rtu4hunNhvTiV6jOvJWRdfl55Ae2in58ySPVh9tdC5aqJ4hzd+RXuEYC7kdLrsWDPOuFhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4143
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On Wed 14 Aug 2019 at 13:53, Dan Carpenter <dan.carpenter@oracle.com> wrote=
:
> [ I already wrote this email, but it looks like I deleted it instead of
>   sending it.  So weird.  I hopefully don't send it twice! ]
>
> Hi Vlad,
>
> I noticed a possible refcounting bug in commit 948993f2beeb ("net/mlx5e:
> Extend encap entry with reference counter") from Jun 3, 2018.
>
> 	drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:1435 mlx5e_tc_update_nei=
gh_used_value()
> 	error: dereferencing freed memory 'e'

Hi Dan,

Thanks for reporting!

>
> drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
>
>   1415  void mlx5e_tc_update_neigh_used_value(struct mlx5e_neigh_hash_ent=
ry *nhe)
>   1416  {
>   1417          struct mlx5e_neigh *m_neigh =3D &nhe->m_neigh;
>   1418          struct mlx5e_tc_flow *flow;
>   1419          struct mlx5e_encap_entry *e;
>   1420          struct mlx5_fc *counter;
>   1421          struct neigh_table *tbl;
>   1422          bool neigh_used =3D false;
>   1423          struct neighbour *n;
>   1424          u64 lastuse;
>   1425
>   1426          if (m_neigh->family =3D=3D AF_INET)
>   1427                  tbl =3D &arp_tbl;
>   1428  #if IS_ENABLED(CONFIG_IPV6)
>   1429          else if (m_neigh->family =3D=3D AF_INET6)
>   1430                  tbl =3D &nd_tbl;
>   1431  #endif
>   1432          else
>   1433                  return;
>   1434
>   1435          list_for_each_entry_safe(e, tmp, &nhe->encap_list, encap_=
list) {
>   1436                  struct encap_flow_item *efi, *tmp;
>   1437
>   1438                  if (!(e->flags & MLX5_ENCAP_ENTRY_VALID) ||
>   1439                      !mlx5e_encap_take(e))
>                             ^^^^^^^^^^^^^^^^^^^
> We take a reference here.

Okay, we take reference to encap at the beginning of outer loop.

>
>   1440                          continue;
>   1441
>   1442                  list_for_each_entry_safe(efi, tmp, &e->flows, lis=
t) {
>   1443                          flow =3D container_of(efi, struct mlx5e_t=
c_flow,
>   1444                                              encaps[efi->index]);
>   1445                          if (IS_ERR(mlx5e_flow_get(flow)))
>   1446                                  continue;

Now we take reference to flow at the beginning of the inner loop.

>   1447
>   1448                          if (mlx5e_is_offloaded_flow(flow)) {
>   1449                                  counter =3D mlx5e_tc_get_counter(=
flow);
>   1450                                  lastuse =3D mlx5_fc_query_lastuse=
(counter);
>   1451                                  if (time_after((unsigned long)las=
tuse, nhe->reported_lastuse)) {
>   1452                                          mlx5e_flow_put(netdev_pri=
v(e->out_dev), flow);
>   1453                                          neigh_used =3D true;
>   1454                                          break;
>
> I think we need to call mlx5e_encap_put(netdev_priv(e->out_dev), e);
> before this break;

We are breaking from the inner loop (not returning from the function,
just breaking the innermost loop) here after releasing the reference to
flow which was obtained at the beginning of the loop.

>
>   1455                                  }
>   1456                          }
>   1457
>   1458                          mlx5e_flow_put(netdev_priv(e->out_dev), f=
low);
>   1459                  }
>   1460
>   1461                  mlx5e_encap_put(netdev_priv(e->out_dev), e);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now we are releasing the reference to encap, both when inner loop
completed normally or when it was terminated with 'break'. If we were to
release the encap before the break, this would be the second time we
'put' it.

What am I missing?

>   1462                  if (neigh_used)
>   1463                          break;
>   1464          }
>   1465
>
> regards,
> dan carpenter
