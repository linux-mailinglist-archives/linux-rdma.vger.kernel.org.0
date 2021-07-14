Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046433C88D1
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jul 2021 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhGNQn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jul 2021 12:43:29 -0400
Received: from mail-bn1nam07on2121.outbound.protection.outlook.com ([40.107.212.121]:37504
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhGNQn2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Jul 2021 12:43:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzExzLCGAmbhnDaJsYYCzBi3YubjEXGe1zkwHTd/bg3XeVlsu4V0RLYxFm3RbWrgw0hqA2AZcMKsI3Ric86xmkRueUJ9mHBPNBWB4YZAuLwlApUA2lRe6QPjM80UuSMi3U5uzMcs2pFhpqJNn2cT6FchP6+SxYt54La8rtNxD3eSYZWal2gmEtPlpNbq97Ukgxl08uazR4tNpD+bkTNMzxTdFmblgvPv16e+WiObsgQc3RqppbwEOog2BmEgODP3VKSp7zOA0l0HC+gIF3xiFjW6IM6g12Yy2SG5dPZLSFRhUgok9cvaK8Nl1xLfRbzcAGTfTyyMqz8C2XdalHgKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydA7I12pGtIYJa86TsVuVYYRWUNCAx8W7CIksEhEG6c=;
 b=CHAhbwcaYMGE2bZnE3dmFO1/MtGz83CC5A0mN6Bl0tCOPhjXdO33HFtziJ4+9P7Ueks34gth9b0FMvV96thapW+Q4+W+MR8/h+qkbsPnylCAHe8rQmRFhmIAnvoEjJaVR9W4W4xZLBIk3AAk6YOAzB0HlXcA8Lxu4QnW620+36D2G+Rr4MYKZ6V1BfK4vriExktovOJB6i9oYx5T2IXCq0/35pW4p4+KEUyFaVohhZBM1JLXCAbx5WVpIHY9895AcjI6Ylf2bEQ/VKkoLOEmUM1qPI1XBaa3uodXq/XTAEBS9yIYzabP+BWR3fUc3z54SF7/5igQceIo9EZaAs2WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydA7I12pGtIYJa86TsVuVYYRWUNCAx8W7CIksEhEG6c=;
 b=N5VCZfWpEs4wm9H7KxyW+lkBTvDU/9bDL5l7rlQrY1pNVpQgQL+1Jrntcfz5q+7XdSupHGEakOd2SmGYjHu7pY1Up3bIBFZgt94GQHitiyGXg1fbFrojIjtFfwimjeV9gI5o8vfU45+f+61kLDL7zbQs6/kMof1UGRyUCecHEt59qXByb1OVsukm0pQx2Cdcfevlt5JiOp6AuSDxnENY8A1jJRj+YEb1faA8Lufm66fLMAr5Gcvhf0n5LJpolMhf8ByXnEdwZwXYsZMxZ9jp2SFGNCSDjscSi3lIT7tNnfDTTtoQFIit9EzpBBRk/Nxc31JnzhkdhOWm6z5v2LqOUQ==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH0PR01MB7204.prod.exchangelabs.com (2603:10b6:610:f4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Wed, 14 Jul 2021 16:40:35 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::f16e:8a3e:3b8d:8a34%5]) with mapi id 15.20.4331.022; Wed, 14 Jul 2021
 16:40:35 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: NFS dmesg errors in 5.14-rc1
Thread-Topic: NFS dmesg errors in 5.14-rc1
Thread-Index: Add4zo3mZX7NdJahRUuk4Wkzu3kNtw==
Date:   Wed, 14 Jul 2021 16:40:35 +0000
Message-ID: <CH0PR01MB7153D36F6E35AF2239C763C0F2139@CH0PR01MB7153.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none
 header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bbedcd0-75e8-447e-b3a4-08d946e61a95
x-ms-traffictypediagnostic: CH0PR01MB7204:
x-microsoft-antispam-prvs: <CH0PR01MB72047E9B2398386B98292D84F2139@CH0PR01MB7204.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40B0T4Axix9jfOk1BJr5Rc8GiWeZGD75HyDfseanThh9ZUGrBO2YKAcfGDUIYudyrsEsYA1adfsBhXHkw3MFwNZboVdGqLNzD4GtjJQd6ae5ss3Vuh2i3i9bbKtPf2cpsIhzSl5I0TBBLZEmyR+ljtDl1vZH1T4nLPrWvsNY/6lZNyyzLfUZqQ32ysK400NN61j7MoL0VcN9buOYo7MDqbFw14j2y+vA5fW7o+5J80xoYJtMxjIicE2ZgUgyEFNOIA5HZXLZCRBf5zvIgFb1uzfR1fnF3x2sVVx9BO1L9Spsa9+n/aiUyF964pzGe7yLjxskL9yH3Jz2YoU7w3Y0A4G+dTvwQzDB2RXYEkI3g9Y22IYR/g2tgzO4Mbvd7Vf/Nr6U6HL+b9tWbkbUuHgH1BrohbZDjahuDmMFTqWMZcPc/GxsfQ3Ouv7IC9RCz1tLi4Py10yPDlju0XUmzrzz91So7dAQkUIeNGxKW9TOCcpXeLtV/PyLj9/Q/Og/6sgOOsvgRXxM9f2ETwl5mKsNVsmK/e8B8TGg9OoQmazz0bPtLtdYUU9hGynt71t8/08g5fNCwGvvKrsoURaT3EGmDXgC/bup50mBMHBh2u6ykHt64PBcZ7/3e63gQ/De6D9QR7bXBpPZbKW+Yl4VMYZcxV9asgDM2E61/GbWPl1RxOMySsm9Aj4UDxyyFDWHy+IUXOUQQ4jCRwJCZ9nouEdA2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(346002)(39840400004)(316002)(478600001)(71200400001)(8676002)(2906002)(83380400001)(26005)(66946007)(122000001)(186003)(38100700002)(45080400002)(66476007)(33656002)(52536014)(8936002)(76116006)(66556008)(64756008)(66446008)(4326008)(6506007)(6916009)(5660300002)(9686003)(7696005)(86362001)(55016002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hb/a3w6v0UVosydeNJqXUtb0Ou60rqAjoKcwED2sWqx1kqiLkmCQziKDVAvr?=
 =?us-ascii?Q?Sp2JPAuTcPYJDHsyNyhy5KLvk1ujx1GqDq82G8346/L0lsaDKai1CSCkSXoa?=
 =?us-ascii?Q?00GLeh+hDJtBo7/IsEbQ0Ck9WPmpzX5OVGtXySnrfewpgdaTTzEnw2fkWHEI?=
 =?us-ascii?Q?UEURG4nH2E6oM7sd/9h3a6Nv1f0jCiMrNhN9Wgzerj/DuHXfhDOPPAhh1T8X?=
 =?us-ascii?Q?jN3z68lXsF87K7rHIO/gBXPsud/ty9Py0xLaKcYIn8MjaDaUp74w/73aNh7t?=
 =?us-ascii?Q?F5myM9Qy+RmVGFL4bivg4ZGllbmQxrPwF1lKbLoz1Lemhc6AxbKtjjbpoXVt?=
 =?us-ascii?Q?EuxFTrilZ2Fmgoz2HZ9rDrYNDwf64luigjZUThSdQwjc09ycxamIGdm6gi4M?=
 =?us-ascii?Q?hy0coSUeVJGda3e3X5uYCxoJTkWI5AH3rJLWLFmw2/vaL0XqEUxR3CvtXnj9?=
 =?us-ascii?Q?VusskvpUVNFZoGeVjX2wYKNVyStYwS0CWuPvkLAnDZqin8sbyAGgQupt1Q4L?=
 =?us-ascii?Q?53E8V6qYYAFqscfmAJKAckJ4YEW2ZhOdXvN1EtwTuuzHcD69iTrgiMsv0XCG?=
 =?us-ascii?Q?wM6STYscvRG90lI549hUm3XDnumnYABx4KOxRboTNtUizH2BVhHq8qfE4tmb?=
 =?us-ascii?Q?fcPouLXPE5yRW9oE2hMoMAxClQPp6D34gnD2Lns+2dPLN59/qSp7AgL577BE?=
 =?us-ascii?Q?YKiQz7yGUY3NnSIooB5JjFLE1ExMIAqVh2/z51gs34La30gurHAF/d69Ptyo?=
 =?us-ascii?Q?J1K6Kp//fK+Yek6rGXfRq6xW5MoXE+0cmryqgfLmIZRYjQPydm2/8umHDqgI?=
 =?us-ascii?Q?Q8pinFC2+xujVwxF+EcHaomfQ5GXm/RxVCV/pKLJq21omfzjpmUF/LaoiENR?=
 =?us-ascii?Q?mbhhtOfOp/FRU0FkpqXFGrp/8HKWDXy95YmIEM48uo2xGqXA6ek0y3og/CQv?=
 =?us-ascii?Q?3PC8M65GKW4jK5IISt+WVzvy0sHFgT9VMsNycxDwH6YrgdB6dkjfuWLW8EZ8?=
 =?us-ascii?Q?zZMfdIqitPegxCOIx7E3bdJ5FEoqidSQgeqwzRgKAZPSSQecCzXro4DwAACq?=
 =?us-ascii?Q?nMyblnaCrXplnXXr0ZG2G+GfhQF1Uft4A5QHw9z1yrMhg0xUbO5i6ZS7BAOy?=
 =?us-ascii?Q?jtdBUi6fU8tYXNjKYwe7PfkimGx+G2ZwbjVkV1B5gwwY2R88J2s6jad3lBUW?=
 =?us-ascii?Q?O22kbkGlmmtQMU6ZE2BWi1N1SYZH7aPe1eWy/O7NSrcbNUY1pffCs3x1JKzh?=
 =?us-ascii?Q?oI4QAc8T+4cZboHPOi3tspz5dM/6bP3OxXa7Mko6uEegikXXGp/p6t9p3jpI?=
 =?us-ascii?Q?thE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbedcd0-75e8-447e-b3a4-08d946e61a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2021 16:40:35.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+ieBLM87JyvTjI3vkH/wM4NSgsPPoDHaVTEOTPQinfrm9PafGUyBdRAL/ywZm8LiUVayKQkydq1OXUIIJnyCM4vyqd2h0k+Cs/0vBdb26Ez3VwEn1/DTePggqzxsOHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7204
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Chuck,

We are now seeing this in the first RC:


[31868.644165] ------------[ cut here ]------------
[31868.650059] failed to drain recv queue: -22
[31868.655191] WARNING: CPU: 32 PID: 559 at drivers/infiniband/core/verbs.c=
:2738 __ib_drain_rq+0x163/0x1a0 [ib_core]
[31868.657234] ------------[ cut here ]------------
[31868.667133] Modules linked in: nfsv3
[31868.672832] failed to drain send queue: -22
[31868.677279]  nfs_acl rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs =
lockd grace fscache netfs tcp_diag udp_diag raw_diag inet_diag rfkill ib_is=
ert iscsi_target_mod target_core_mod rpcrdma ib_iser rdma_ucm opa_vnic rdma=
_cm ib_umad libiscsi ib_ipoib scsi_transport_iscsi ib_cm iw_cm sunrpc hfi1 =
mgag200 intel_rapl_msr intel_rapl_common drm_kms_helper sb_edac syscopyarea=
 rdmavt x86_pkg_temp_thermal sysfillrect intel_powerclamp ipmi_si ib_uverbs=
 sysimgblt coretemp fb_sys_fops cec ipmi_devintf drm crct10dif_pclmul crc32=
_pclmul iTCO_wdt iTCO_vendor_support ghash_clmulni_intel ib_core mei_me rap=
l intel_cstate mei lpc_ich mxm_wmi i2c_i801
[31868.682425] WARNING: CPU: 65 PID: 608575 at drivers/infiniband/core/verb=
s.c:2705 __ib_drain_sq+0x14d/0x190 [ib_core]

On the same tests, the mount command fails with a connection refused...

Any ideas on this?

5.13.1 (the first 5.13.y release) tests fine.

Mike
