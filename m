Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFCD65AA4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 17:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfGKPnp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 11:43:45 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:3909
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbfGKPnp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jul 2019 11:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEx6PbajEagGnIEzOuNaVgXBaT4SKSxgwH42Kdi4chg=;
 b=Y+wtM7w79v7TtOIi5LoAzKOTNFZPXpf4J2jES/r/YogfNomncGCpaY4VuFqKri7RN6vOCrKLsPL88DurvK8fnPnKGRnTNEItbTfdiyJvkjeOt7vTPt7NLwaCaQyxrUkJNYfaPaY1KPjdptExfUDMkkTQ7QRK0fJGGyrh9nwNQQc=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4687.eurprd05.prod.outlook.com (20.176.3.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 11 Jul 2019 15:43:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2052.020; Thu, 11 Jul 2019
 15:43:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yamin Friedman <yaminf@mellanox.com>
Subject: Re: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Topic: [PATCH rdma-next] lib/dim: Prevent overflow in calculation of
 ratio statistics
Thread-Index: AQHVN/21HuAr6Ssdm0+h3g3lp6E1KKbFjsQA
Date:   Thu, 11 Jul 2019 15:43:28 +0000
Message-ID: <20190711154324.GK25821@mellanox.com>
References: <20190711153118.14635-1-leon@kernel.org>
In-Reply-To: <20190711153118.14635-1-leon@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 008e0b39-c052-4ce0-a2b4-08d7061684ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4687;
x-ms-traffictypediagnostic: VI1PR05MB4687:
x-microsoft-antispam-prvs: <VI1PR05MB4687BC0A7CE20835700ACB3BCFF30@VI1PR05MB4687.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(81156014)(81166006)(316002)(26005)(7736002)(99286004)(54906003)(66946007)(86362001)(8936002)(66066001)(446003)(6436002)(186003)(386003)(14444005)(102836004)(8676002)(305945005)(76176011)(52116002)(66556008)(66476007)(14454004)(64756008)(66446008)(6506007)(478600001)(36756003)(4326008)(486006)(53936002)(6486002)(6512007)(6916009)(25786009)(3846002)(6116002)(5660300002)(256004)(2906002)(68736007)(71200400001)(6246003)(11346002)(476003)(229853002)(107886003)(2616005)(1076003)(71190400001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4687;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xvQ4gUTvW5e7wi4gIxVCs+33rdBGeIDJlInGn5GCEKxY8IsHJsp7qY7siXLqCfmAlI3owxKwgcWzhZnrzGVrAi4iHwtLOXR+0QCmeZ1+IY+5nKVe4INgJaFPPjboGo4IdllkvCiubHXuIfMyZ45mh2kdi3jNf663phdN8hEgxo6s3Fvu5eelFqJXvxFrQkDX3kj5cFwJEprNH0Jq4rTyjPzzGa2wxMvxkr6d/fbkUFUuJfoKBaaW/PeJAJ3QDJpelfHCPSBABVF69BjIIV6rrP4UxbahJegzKc7xjv86z/NfgKqQm0gORM9E6yjGZk2mqBckH40YQRpv46g86rEWofKdmBz8VnoqLGrru4IK1r1lwRvYpeWB6djthGryZJwASBrdMAhmxt/CfkHBqsru99AOYfOPAREoq5slFW9W6oY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BA1E000ACAE2E4C874AF43DA5C0021D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008e0b39-c052-4ce0-a2b4-08d7061684ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 15:43:28.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4687
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 11, 2019 at 06:31:18PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>=20
> Multiply by 100 can potentially overflow cpms value and will produce
> incorrect wrong ratio statistics. Update code to use built-in division
> macro, so it will fix the following UBSAN warning.
>=20
>  [ 1040.120129] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  [ 1040.127124] UBSAN: Undefined behaviour in lib/dim/dim.c:78:23
>  [ 1040.130118] signed integer overflow:
>  [ 1040.131643] 134718714 * 100 cannot be represented in type 'int'
>  [ 1040.134374] CPU: 0 PID: 22846 Comm: iperf3 Not tainted 5.2.0-rc6-for-=
upstream-dbg-2019-06-29_03-18-13-29 #1
>  [ 1040.139068] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
>  [ 1040.144469] Call Trace:
>  [ 1040.145897]  <IRQ>
>  [ 1040.147366]  dump_stack+0x9a/0xeb
>  [ 1040.149061]  ubsan_epilogue+0x9/0x7c
>  [ 1040.150462]  handle_overflow+0x16d/0x198
>  [ 1040.151911]  ? __ubsan_handle_negate_overflow+0x15c/0x15c
>  [ 1040.153679]  ? sk_free+0x15/0x30
>  [ 1040.155011]  ? kvm_clock_read+0x14/0x30
>  [ 1040.156433]  ? kvm_sched_clock_read+0x5/0x10
>  [ 1040.157952]  ? sched_clock+0x5/0x10
>  [ 1040.159318]  ? sched_clock_cpu+0x18/0x260
>  [ 1040.160801]  dim_calc_stats+0x4a1/0x4c0
>  [ 1040.162274]  net_dim+0x147/0x920
>  [ 1040.163592]  ? net_dim_stats_compare+0x330/0x330
>  [ 1040.165283]  mlx5e_napi_poll+0x410/0x1030 [mlx5_core]
>  [ 1040.166876]  ? lock_stats+0xd41/0x1740
>  [ 1040.168266]  ? mlx5e_trigger_irq+0x550/0x550 [mlx5_core]
>  [ 1040.169918]  ? __module_text_address+0x13/0x140
>  [ 1040.171409]  ? lock_stats+0xd41/0x1740
>  [ 1040.172757]  ? net_rx_action+0x262/0xda0
>  [ 1040.174156]  net_rx_action+0x421/0xda0
>  [ 1040.175519]  ? napi_complete_done+0x370/0x370
>  [ 1040.176979]  ? kvm_clock_read+0x14/0x30
>  [ 1040.178316]  ? kvm_sched_clock_read+0x5/0x10
>  [ 1040.179690]  ? sched_clock+0x5/0x10
>  [ 1040.180920]  ? sched_clock_cpu+0x18/0x260
>  [ 1040.182286]  __do_softirq+0x287/0xb4e
>  [ 1040.183581]  ? irqtime_account_irq+0x1d5/0x3b0
>  [ 1040.184998]  irq_exit+0x17d/0x1d0
>  [ 1040.186212]  do_IRQ+0x129/0x220
>  [ 1040.187412]  common_interrupt+0xf/0xf
>  [ 1040.188673]  </IRQ>
>  [ 1040.189685] RIP: 0033:0x7f092c41a07a
>  [ 1040.190884] Code: 45 31 f6 e9 8a 00 00 00 0f 1f 84 00 00 00 00 00 48
> 89 df ff 93 88 01 00 00 85 c0 0f 88 c7 00 00 00 48 98 48 01 85 88 02 00
> 00 <48> 8b 85 c8 02 00 00 48 83 85 90 02 00 00 01 48 83 78 10 00 74 0b
>  [ 1040.195584] RSP: 002b:00007fffbebe7870 EFLAGS: 00000206 ORIG_RAX: fff=
fffffffffffd7
>  [ 1040.197933] RAX: 0000000000020000 RBX: 0000000000e239b0 RCX: 00000000=
0006b280
>  [ 1040.199740] RDX: 0000000000020000 RSI: 00007f092c805000 RDI: 00000000=
00000007
>  [ 1040.201525] RBP: 0000000000e21260 R08: 0000000000000000 R09: 00007fff=
bebfb0a0
>  [ 1040.203237] R10: 0000000000000380 R11: 0000000000000246 R12: 00007fff=
bebe7950
>  [ 1040.204944] R13: 0000000000000007 R14: 0000000000000001 R15: 00007fff=
bebe7870
>  [ 1040.206686] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: 398c2b05bbee ("linux/dim: Add completions count to dim_sample")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  lib/dim/dim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/dim/dim.c b/lib/dim/dim.c
> index 439d641ec796..38045d6d0538 100644
> +++ b/lib/dim/dim.c
> @@ -74,8 +74,8 @@ void dim_calc_stats(struct dim_sample *start, struct di=
m_sample *end,
>  					delta_us);
>  	curr_stats->cpms =3D DIV_ROUND_UP(ncomps * USEC_PER_MSEC, delta_us);
>  	if (curr_stats->epms !=3D 0)
> -		curr_stats->cpe_ratio =3D
> -				(curr_stats->cpms * 100) / curr_stats->epms;
> +		curr_stats->cpe_ratio =3D DIV_ROUND_DOWN_ULL(
> +			curr_stats->cpms * 100, curr_stats->epms);

This will still potentially overfow the 'int' for cpe_ratio if epms <
100 ?

Jason
