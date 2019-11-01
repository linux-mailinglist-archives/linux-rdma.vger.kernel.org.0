Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10EDEC64B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 17:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfKAQAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 1 Nov 2019 12:00:25 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:50913
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbfKAQAZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 1 Nov 2019 12:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n530+rnEXw7m0bBAhIG1Orzt76bVOmXtLhu9px65ytJIjzdjapllmrl59urrsuw9LazrmWLWKutoaMSpcPIR1rg2qh4neJBPikOp9PVfSC561F2e/OHvJrzMj0QRQSGzbNXtHTwc0SiH7BY24UMnKCWWLaQGo9dBjC4k9iQ5k6onj+uItmfai5jsWhoV/bEMg4UabNk1l4YEDN9MbVXEsxM6yP/JY8HWa9B7zEz4Ofk4gTpICkPOMjD7HpALuJutN/fjmHP9OzsEn7xF3arDOKcMB+xzc3j3qK1ACyk8pPWh/4IRHcitr+LNpWE5+iSXuh2seeb8BcKGRMZxRWTXdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRK9ZzUVcI2M50nxTjMyu8CybyGusU4TbaDU62Ikupk=;
 b=VAnMHkJ+GxYjajeE8iWCMnp/BmmkrwZJJ+LCZxDlb9TA9AkrG6Lb+MvsXuCYcTOaY7GzF74CKd7yg94B+8CHv/j7IzcSEsvSpWNzDzOEDrUWzEi3ice6bUvWKgGbBocWjfD2I3v3WO7LTJq8CsFgYIfn2oZ/vedqzOmv9tKbfWNjtEwPrdBBTb9JxRSZWDxQFItq2tToeF9YggY8YNL+k3O07SPdI3/Ppqwu4+zNJ7kVjg42WzFstiLYD23BNaMXm478l2qxjdR7utjcsz8A+t3Uqee53Uyma33xyh+IQUToaaPHkRpQ04Tz/D32mqCLDgYi+h37QxHsy30LqJ/WTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRK9ZzUVcI2M50nxTjMyu8CybyGusU4TbaDU62Ikupk=;
 b=ULEdXL30T8xNNBly44VV5mwvNDSbK+P3t6CgYV904DMML6IXRHfwMvzAaf0/IZO5YLgtWYDk4/k6axUna6z1K3jtAII5daVY9EzNT6Aei5UnwQCyrzMr2hDvSlVgfLGzmB0fxOw9baVMwcPevR1hUYSx55lKXzdEXIg6Dnbwh6s=
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com (20.176.214.160) by
 AM0PR05MB4994.eurprd05.prod.outlook.com (20.177.41.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Fri, 1 Nov 2019 16:00:17 +0000
Received: from AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432]) by AM0PR05MB4866.eurprd05.prod.outlook.com
 ([fe80::64b2:6eb4:f000:3432%7]) with mapi id 15.20.2387.028; Fri, 1 Nov 2019
 16:00:17 +0000
From:   Parav Pandit <parav@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, oulijun <oulijun@huawei.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: =?iso-2022-jp?B?UkU6IBskQiFaGyhCQXNrIGZvciBoZWxwGyRCIVsbKEIgQSBxdWVzdGlv?=
 =?iso-2022-jp?B?biBmb3IgX19pYl9jYWNoZV9naWRfYWRkKCk=?=
Thread-Topic: =?iso-2022-jp?B?GyRCIVobKEJBc2sgZm9yIGhlbHAbJEIhWxsoQiBBIHF1ZXN0aW9uIGZv?=
 =?iso-2022-jp?B?ciBfX2liX2NhY2hlX2dpZF9hZGQoKQ==?=
Thread-Index: AQHVkJfhnQfcRJI2EkWYHU+fh643xqd2SO8AgAAtUBA=
Date:   Fri, 1 Nov 2019 16:00:17 +0000
Message-ID: <AM0PR05MB4866715D6F149927D4B31C46D1620@AM0PR05MB4866.eurprd05.prod.outlook.com>
References: <fd2a9385-f6c7-8471-b20c-476d4e9fada7@huawei.com>
 <20191101130540.GB30938@ziepe.ca>
In-Reply-To: <20191101130540.GB30938@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=parav@mellanox.com; 
x-originating-ip: [208.176.44.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ba384c8-6dc8-4fa2-170b-08d75ee49710
x-ms-traffictypediagnostic: AM0PR05MB4994:
x-microsoft-antispam-prvs: <AM0PR05MB49948E0182F98F6BF6E55750D1620@AM0PR05MB4994.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(54094003)(189003)(199004)(13464003)(66446008)(66066001)(7736002)(2906002)(71190400001)(305945005)(71200400001)(186003)(52536014)(3846002)(6116002)(33656002)(476003)(11346002)(446003)(74316002)(14444005)(256004)(86362001)(486006)(5660300002)(64756008)(14454004)(6246003)(25786009)(81156014)(81166006)(229853002)(6436002)(478600001)(316002)(110136005)(76176011)(55016002)(7696005)(6506007)(102836004)(53546011)(8936002)(76116006)(26005)(54906003)(4326008)(66946007)(66556008)(66476007)(9686003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4994;H:AM0PR05MB4866.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jp9PzqO48MzuggPL/nNh8ocA0QB75f+RvphwBGzHS+hx0138OTGgHNJqb/QpreJ3dj5OTwN0ObOLQfoRVWkEZgJC6+oOvA/V6h3A9tnu5v3tKBPX2ZtnjGRxGuLVE/rhNvg20PcPkIEsD0QowfcPxokwNqNq9Be4PBvAcjjERC+TER5/3UGe/KHA2zQ3GJo/hgzTD4XjGNUOUceTXfHgtspjTlHXI6Ptx3yIUS8OZtD5BLmc5bspHVjRk1a5wswpDa3JmUIUPzt88y4Tq5q3KYeS6tzuxD7buG9G+tcv6UKm8D6TLtsi9Jmx07wq1Dz9NOxItsaoQK1oiCXMWSK1U+3waHRCi9XH6n6hiMp+z1Ga1zHTbW9fQak/+uxF+X83npTWKBB/idt4vITO6SD2VoQH1e2/Hoes+x4yB5NmRnk9pDcb/7gdfP5740WycSND
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba384c8-6dc8-4fa2-170b-08d75ee49710
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 16:00:17.5343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9JVgOO42r4x1nLpv5oMUuLX/P36O3zr26EFQaj12yqIIHNPCfyiF0sH+gQDiuy1q+/MCxLnn9DyDG/NE2rpjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4994
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Lijun,

> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, November 1, 2019 8:06 AM
> To: oulijun <oulijun@huawei.com>; Parav Pandit <parav@mellanox.com>
> Cc: Doug Ledford <dledford@redhat.com>; linux-rdma <linux-
> rdma@vger.kernel.org>
> Subject: Re: =1B$B!Z=1B(BAsk for help=1B$B![=1B(B A question for __ib_cac=
he_gid_add()
>=20
> On Fri, Nov 01, 2019 at 05:36:36PM +0800, oulijun wrote:
> > Hi
> >   I am using the ubuntu system(5.0.0 kernel) to test the hip08 NIC
> > port,. When I modify the perr mac1 to mac2,then restore to mac1, it wil=
l
> cause the gid0 and gid 1 of the roce to be unavailable, and check that th=
e
> /sys/class/infiniband/hns_0/ports/1/gid_attrs/ndevs/0 is show invalid.
> > the protocol stack print will appear.
> >
> >   Oct 16 17:59:36 ubuntu kernel: [200635.496317] __ib_cache_gid_add:
> > unable to add gid fe80:0000:0000:0000:4600:4dff:fea7:9599 error=3D-28
> > Oct 16 17:59:37 ubuntu kernel: [200636.705848] 8021q: adding VLAN 0 to
> > HW filter on device enp189s0f0 Oct 16 17:59:37 ubuntu kernel:
> > [200636.705854] __ib_cache_gid_add: unable to add gid
> > fe80:0000:0000:0000:4600:4dff:fea7:9599 error=3D-28 Oct 16 17:59:39
> > ubuntu kernel: [200638.755828] hns3 0000:bd:00.0 enp189s0f0: link up
> > Oct 16 17:59:39 ubuntu kernel: [200638.755847] IPv6:
> > ADDRCONF(NETDEV_CHANGE): enp189s0f0: link becomes ready Oct 16
> > 18:00:56 ubuntu kernel: [200715.699961] hns3 0000:bd:00.0 enp189s0f0:
> > link down Oct 16 18:00:56 ubuntu kernel: [200716.016142]
> > __ib_cache_gid_add: unable to add gid
> > fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=3D-28 Oct 16 18:00:58
> > ubuntu kernel: [200717.229857] 8021q: adding VLAN 0 to HW filter on
> > device enp189s0f0 Oct 16 18:00:58 ubuntu kernel: [200717.229863]
> > __ib_cache_gid_add: unable to add gid
> > fe80:0000:0000:0000:4600:4dff:fea7:95f4 error=3D-28
> >
> > Has anyone else encounterd a similar problem ? I wonder if the
> _ib_cache_add_gid() is defective in 5.0 kernel?
>=20
> Maybe Parav knows?

I used the kernel from [1], which seems to be fine; it has the required com=
mits [2], [3], [4].

Are you running RDMA traffic/applications which are using GID 0 and 1 when =
changing MAC?
If so, administrative operation such as MAC address change during active RD=
MA traffic is unsupported, which can lead to this error.
Can you please confirm?

If you are not running RDMA traffic while changing the mac, I need more deb=
ug logs.
Can you please enable ftrace and share the output file mac_change_trace.txt=
 using below steps?

echo 0 > /sys/kernel/debug/tracing/tracing_on
echo function_graph > /sys/kernel/debug/tracing/current_tracer
echo > /sys/kernel/debug/tracing/trace
echo > /sys/kernel/debug/tracing/set_ftrace_filter
echo ':mod:ib*' > /sys/kernel/debug/tracing/set_ftrace_filter
echo ':mod:rdma*' >> /sys/kernel/debug/tracing/set_ftrace_filter
echo 1 > /sys/kernel/debug/tracing/tracing_on

ip link set <netdev> address <new_mac1>
ip link set <netdev> address <new_mac2>
cat /sys/kernel/debug/tracing/trace > mac_change_trace.txt

[1] git://git.launchpad.net/~ubuntu-kernel-test/ubuntu/+source/linux/+git/m=
ainline-crack v5.0
[2] commit 5c5702e259dc ("RDMA/core: Set right entry state before releasing=
 reference")
[3] commit be5914c124bc ("RDMA/core: Delete RoCE GID in hw when correspondi=
ng IP is deleted")
[4] commit d12e2eed2743 ("IB/core: Update GID entries for netdevice whose m=
ac address changes")

