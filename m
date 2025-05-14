Return-Path: <linux-rdma+bounces-10345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE24FAB6A7C
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176493AE723
	for <lists+linux-rdma@lfdr.de>; Wed, 14 May 2025 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13973270EC5;
	Wed, 14 May 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ru.nl header.i=@ru.nl header.b="q9J6n/Vg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2130.outbound.protection.outlook.com [40.107.20.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E01C3039
	for <linux-rdma@vger.kernel.org>; Wed, 14 May 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223339; cv=fail; b=Qwn4vlRii1bnuiudM5XAkK6JWB8OHUg3Q4EpYSWOJS9+Fs/F2foGUL28MZSplA/w1z4SXxmciEvn2NN7aLrm390/0RqAWJr44gvDTVyp8lJHbWRMPRV4bEa+PIFVM97PXEX5AsUUOMvnSyhuzUa5d9HjWPZ4WccC/wcWwLN4fQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223339; c=relaxed/simple;
	bh=+7f9r1z6Vo5BSGYjriEkZMTNLiKGK7BSS4DQyEjvobU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tLFijsnyjWoaS8gndzXuHR0Vzg6FCBATwJBStmJUg7PoW5LrFq2RuAnciMbQ+OyPA/C8/s0wWYUyQufEKlL48FodUdWnxcdiTITKLb2FZr3FFHtwonb4w7sCdxW4wj4cmMxywET6HYn1J3kchTh7l6Ul0G62/k91aYt/8W9U72E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ru.nl; spf=fail smtp.mailfrom=ru.nl; dkim=pass (1024-bit key) header.d=ru.nl header.i=@ru.nl header.b=q9J6n/Vg; arc=fail smtp.client-ip=40.107.20.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ru.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ru.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZNcbKG1cMRwbhAYDr9ocD3oW7PUIOhe8iwwkRJipqgLL5eogKePZvZ3Vin+pnhSZEVJpnHQcjlQB+voVZf4N4xMwD/cX/jJiT9eCaamB8QN9EWzvpRvSeNDav7gnGu9oVbH5EJ9StdCKCq9X8Fg1/v4j7AAD4xGKhPeNAc1vkGDamNEw7k6dzgpf923B6sn26Cb2ti26wnmx2TYcg9lF8XrptQpvW+8OVO8wA3mJfq3nOb7NIIX3RjvjRUgb9OvgyLMwZa3yPZ0TqKyB5VCSNEE8ecjYCecWRUjNebQ489WLWGt6iDH3YjrLcn57951rCXMByCI6mZiwwFWqaogWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7f9r1z6Vo5BSGYjriEkZMTNLiKGK7BSS4DQyEjvobU=;
 b=TvxEgmnWDuIDkEebkTcPmEzJr/zwjZitAr5YgQPT8w/fY/JLgT5kD8j2i+ADogNX2ThNybCNjb5nW/+3KoNk9Rl1xZ8wi8ZnocNCdz8RgNLJrGAMvuUVejSTLLjw0LFIEb3HDfsb763Z94SweZu7Okw8xqQOWRtpS3VFAP/J083Jw1PGBa0Fkgb2PeEvUQ8i03rrXwUaTiMbO1bExGUmuIBzwqz9pGEJWBUmqeOzKVQaQduRWM8stxjB6ulBCWqJlUjrcPInmBn1V3wLk/nlNBhXGSWrSXwRNI6RQJDw3uULfbq11rBekambuRFm92TYbM/ZoFlW/CK2w7CgS6HovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ru.nl; dmarc=pass action=none header.from=ru.nl; dkim=pass
 header.d=ru.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ru.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7f9r1z6Vo5BSGYjriEkZMTNLiKGK7BSS4DQyEjvobU=;
 b=q9J6n/VgMuYNj0/A7U/ZYM4AxO6CqIDEjO6Ja++sB5A95oBQRfs8uzhOReIexkj+j1FYguZiB21VbgOEw6A1l1E6LdfMec/qOODy4jHgNqNGjP2MGYkJrK7Sw27f5F0xmGIYfavjU3lokCtPUlte3LtjwH3WW5FQ1ct+TFwIJ4A=
Received: from DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b5::9)
 by VE1PR10MB3967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:14a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Wed, 14 May
 2025 11:48:51 +0000
Received: from DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cee:6441:3c9:77d1]) by DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6cee:6441:3c9:77d1%4]) with mapi id 15.20.8722.021; Wed, 14 May 2025
 11:48:51 +0000
From: "Koopman, T.J. (Thomas)" <thomas.koopman@ru.nl>
To: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: What performance is reasonable for ibv_reg_mr?
Thread-Topic: What performance is reasonable for ibv_reg_mr?
Thread-Index: AQHbxL6wgCACbAO6xU2R/4AW7NsZCg==
Date: Wed, 14 May 2025 11:48:51 +0000
Message-ID:
 <DU0PR10MB5923C51E458A0EA4370BE1FA8A91A@DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ru.nl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB5923:EE_|VE1PR10MB3967:EE_
x-ms-office365-filtering-correlation-id: cbc22cd5-8ee0-42ed-8911-08dd92dd4be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?N9FoNDQca56xQGiG7OszR7oHfh1SNNCaDjUFDSqNfVZMVaegVzyG2+tU?=
 =?Windows-1252?Q?ofA3HfnfOZ6H+HXwdscCT3RdTxR7LJlkHWJlT0iHzSLP2PFNYQj3m9vk?=
 =?Windows-1252?Q?oosO0AVw6b3NXX3jmAGmCHtAg05NPrBn2fMgvPql2F8S5DfYM8OPMeyW?=
 =?Windows-1252?Q?UpU5CkyOXLNq6Dd8etTLOYmhIwtH/x4JRDaFkP3NBzTolWBD6/t1erp0?=
 =?Windows-1252?Q?SvHxwQ9NFuI7BWz3hGm+Z9Z88KgeM5QGm4pRw2T9yplVTetcmqT+es2x?=
 =?Windows-1252?Q?gj2EmH9r8TYLTvOZK/Y3DqbQGXWyh0R6bLBy4UDSUzyNXnEA07jRv1CF?=
 =?Windows-1252?Q?7h0jy5qtvuy9qrhmXCy/LcTyBdE4o5iSOeNHcWiZsKonJG3K2Lr5/P1Q?=
 =?Windows-1252?Q?cg8puWa2e4BfQbbsAjoIKNjwvsR9FDTR0rrDehF8Kd5l+IpcWDWrqQVt?=
 =?Windows-1252?Q?fjR1aFfTTThKAd3te5hWpUAYJu/zfeteQpx5+MjBfDEBlM2v7YsKyjDV?=
 =?Windows-1252?Q?n7dHQcHAfrvPDrCZd3PH0jcbz2/LQUCYOgu0mkEDmne4QqDrPc5F9K7e?=
 =?Windows-1252?Q?CaUMx+uh+uFGnR61lwrWmuZ5Dnhv3ckcrzmUKXnt3+5RMBa97//PuU9G?=
 =?Windows-1252?Q?CDBSOvnlJ7D7MADoULIG6PLiRrozDf1zzSiM8Y/POLZehjmqJBkR6hpZ?=
 =?Windows-1252?Q?fqOATtGIFwe1cIx0KY1KAjGLjSgribrns6iydwvI5EPbVMChzL/i/AbD?=
 =?Windows-1252?Q?sCEZQQC3hCuBhr3xJgkK0T6qyMORF/NKtWQyJFwjsjbZc+TnrPWQx6S4?=
 =?Windows-1252?Q?vIiNM2eXx3IhUpx7jObDbJJFh9znxAJ5SmVhxjq+44bCV8ob3HPXJQZS?=
 =?Windows-1252?Q?jR5t6zNWX+vmZzaQnRq891qSCL4wJZKcYyHZI5D3vyF16x49P3B++JAF?=
 =?Windows-1252?Q?D5EfH33DYwJszNXYFry2n6ToLDgf7gi08FJ+eK/7PGRYNoGFUvpA7e/B?=
 =?Windows-1252?Q?yMOdRAgjVgermjcv8PVp+yXYFPgD3dCZWN4RRsj1iKVj8PtH9I7fqkE6?=
 =?Windows-1252?Q?8Vely5mL9Q901TB80BoWd5Ewmp3O0c61pP/PZhUuqQs2TX6JqhHW7gos?=
 =?Windows-1252?Q?L1qQbSqQQh4aLwODF9cLKoS0jiZa8wGzLU/jxP2o+2/j/yRMWXyJzQeI?=
 =?Windows-1252?Q?S8LJVCFS/od72znSPZHgDW6+iryfSKa45KMnxXblHc2ZLTEqvwFkH+WP?=
 =?Windows-1252?Q?rSUTpKo20nbAiN7jrrUMm1NMAY8GurLnLA2hBE0qekYDHjvb3eg+Zx/f?=
 =?Windows-1252?Q?XQhRl+x+G2iE2xU4Z68S7xvuh07g5I6Iu1eUlkdLgOgyx8y/C6Na2SKC?=
 =?Windows-1252?Q?Xux4EJ3KvzxZzCVP4Fd8OwifCP0nJ6TdjieNn55p+Qm0EQv5IYDcFXmF?=
 =?Windows-1252?Q?hia8gBblr++eujWAqaHzkwtepE+wqPJGUGTHuchnKqsX8sce+Nh5/x56?=
 =?Windows-1252?Q?oPZxhqQpq0Qz+X0mpEe20bQ4JAgElZe4UrvE/lBmOjOFun20fS382jfZ?=
 =?Windows-1252?Q?cgwYJCCWVXLjKWovRWhJI4SAW6+SYA+wjAu9XQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?MVPgNNsVKPT7lZZtZx10PwV+GnKxfUjqfP10yW45ONVpDf0dwpTrOAfo?=
 =?Windows-1252?Q?Iotj1Bkc8Kwe64bjQRSqYtTcBo1eKVOUbxrz0yUs3KfCkHePoS7OpCRw?=
 =?Windows-1252?Q?yGQ1T5g9Hf0OQMjvhHlvqf++d8aq20OyjshdKKiVJNn+Eaf0mMSsdPwa?=
 =?Windows-1252?Q?7AN4iOQYU6rh/pPqo7MDLrsxgcZy9xQItGtynbh+gLnIM6ZSK0lyXVtJ?=
 =?Windows-1252?Q?OSjt3bB13GveaMeX8QovWAEH0L61HxClUC4vYNfUhAgPkvEFLE6w7Pqg?=
 =?Windows-1252?Q?aY1yQ0uZVuxk0KjMsEVp8OvxwNUxVIg25IpkHbGah2Lj/65Yd5vxNmFx?=
 =?Windows-1252?Q?6oH816Fa7z/bgS7NgtuuIw0jHYROYKDOoAAMd5j73xnA0oJkl7zhfr7r?=
 =?Windows-1252?Q?XuVWLtFSh2CmwXIen04jKMuDCRB+fsxwyz0v1r1GevLUwKJUIzK9MN8X?=
 =?Windows-1252?Q?pMsvyQqEo64ST5s6ys8mJQse7GmgbbZQ5TCweex1kP9LZTU9ggyOUpLz?=
 =?Windows-1252?Q?ZCAV+OTS5O36bF7NR0PBE79Fam/mIAOQWkU4Y2mMfxFtpFUWKR+JxVlv?=
 =?Windows-1252?Q?68O9tXM/aDJZk28f4eyM/mDtgtANfPxh/bD5q1ZgcfDIJKvVuZkjJtzL?=
 =?Windows-1252?Q?TcGdA27kYq/KzFgBzKBn8iGAG/uDgaOCQncze3Ymtuu/8Mjvb/6VU/dC?=
 =?Windows-1252?Q?JbN9S/ziAjHBTXvHNyYtNHJ1PZW+5f29dC6QbYOe4JeQnd9zGj7hw0uD?=
 =?Windows-1252?Q?R4vJ3EHj5uXK6oGVP3eYa8xwQAqrTBUrvDBzheFCTy2xHOCaYJx01ZIF?=
 =?Windows-1252?Q?hbgxjFRp+acGSJN0h0XY6wNrLJpUgzSd7nTQ0yQ6T8cx78//thaxD/LC?=
 =?Windows-1252?Q?fsA0K0HAvBMzPlG1XOsJn9v7T0TXa0pQHICaR7GGL39Q5dJ5+C5Pr9/u?=
 =?Windows-1252?Q?3R73OOrfBX3XfwINyc2LVBQQ6v9E7SxAmVkmffrTRicZAxGP+EcTzw4L?=
 =?Windows-1252?Q?fC/cIVf41BFO0/seH/jHAxZbacA17cmB48vt/K05vLHFMh3kmOendf75?=
 =?Windows-1252?Q?C2yR2uEvm2dFaTBJLE5t9rf0PkbSGxz61kEKRb8cciA2LDHovT/DNubq?=
 =?Windows-1252?Q?Dn0FL43b65x2ftSrBVXrLFYy/E9n05yZ2fSfMfOwmM1WMTO6E0OgJ4dO?=
 =?Windows-1252?Q?CNZI6xL07yWEqrYNcmNWhChKqZvGEdNi+FkD+e7BQxNXgyvli2WLeLcS?=
 =?Windows-1252?Q?s3RLzH2R9/YRfAtA3eAmvQLEBz2oyULqevItzhhp5w+A7cWGxFQSWMiQ?=
 =?Windows-1252?Q?/WvQNme5HTrp6tLRvFZWNTTAbjzcKNnGpAH1YttjTHpEh4SM0uDji9z4?=
 =?Windows-1252?Q?6LQNaNptUOPHNyI/v/uQOxd038exFHxvPSmV+KKNrO88KUkdrNcqMNAK?=
 =?Windows-1252?Q?1YHJTWq//dIVfhf50Vn4HDa/z67CCtPiggHyXBtOks6b3T8UU1+tFFJb?=
 =?Windows-1252?Q?5CIA01PCQ1HmQ49T4DmmII62LwwXw+FVlRhfgMYI59RCygGzrJqdbinn?=
 =?Windows-1252?Q?wsoUchwx+f6cWktRU/WMh3dHFRSFUXLn0m3CUATg04idaKoXyt6Q4MAZ?=
 =?Windows-1252?Q?d0AI/8v7YOjm10H06EWQPAKf0tLC2VG/iayatXPDZjZAqJvwxjjMDRzW?=
 =?Windows-1252?Q?TTSv6p6T3ONGeMZNx3PASC5+HA1qPc03?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ru.nl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5923.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc22cd5-8ee0-42ed-8911-08dd92dd4be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 11:48:51.4771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 084578d9-400d-4a5a-a7c7-e76ca47af400
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Aqy2FHC2kBDc2Bp+ZGUN9jX8t6Enxim6xd9isa4ZbRvyBPEIQt8cw8RnmE8RH4z/FinLZ9GcBrZUPZkPAFAqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3967

Hi all,=0A=
=0A=
I have a benchmark where registering 5=9680 GB of memory using ibv_reg_mr o=
n a=A0=0A=
node with 224 GB of memory is done at a rate of 4 GB/s. This is much slower=
=A0=0A=
than the 215 GB/s of DRAM bandwidth, or 12 GB/s of node-to-node bandwidth. =
Is=A0=0A=
this in the ballpark of expected performance, or am I doing something wrong=
?=0A=
=0A=
THP is set to [always] and the performance is the same with and without=A0=
=0A=
RDMAV_HUGEPAGES_SAFE=3D1 in the environment.=0A=
=0A=
Please let me know if the benchmark or more system details would be helpful=
.=0A=
=0A=
Thanks,=0A=
Thomas=

