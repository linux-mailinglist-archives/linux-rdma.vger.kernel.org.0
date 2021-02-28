Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06FA3273FB
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Feb 2021 20:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhB1TJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 14:09:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62760 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhB1TJE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Feb 2021 14:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614539344; x=1646075344;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eO3uqFu8Z5EhSeOgFytgXlOcGAD0pv0+vTGH7VRDtgY=;
  b=Z0A9pc3tjWeVYfBwwtnLGiiuPoJ04qFggCLbOoVdtTS70KhJnV6GDYZI
   6cs+vJpuUvNeLmUATEOAv7Shz7PUSA5hXCGZWbZL/yPZf4rGXVN8W/aLF
   GsQYoJrgvFdFCZyldQplXbOA+gV+2yeQuMO2S1x23bnEOi9JPEDSEUmP2
   vV2HB4Z01pUh6MIV+RHa/ljxhVjeY+Za0/O0ORYlAic5vNnuDK3GAmfGH
   rXygnNOBxEwG/jpJPdNwitnZJG8IXTvP+qWd8Kxy1E7/9tWrH6k8kKjum
   br8AcduNA0lPbVbZmcnkFCobn6vCy1TDmXRb4fehAasdFxwOCxWBEzdAH
   g==;
IronPort-SDR: 6xzXETEKreW8E6y773C4YkKd4WNKM7bhpPog4GK3Febrn8a6SKCyZfSGIrJP6T77mEX1CvQjMh
 fX28NQeOrpT8VX4wkxX822c+sNfd8RfRaAxs2maguLf7o3suE+xXE8xiKnJ5fmkskVVaxMyL4m
 kw2rgkmEWKfjhTb3WW9xkheElmJf5WTHj+OHny23/UHaLaaturJRK1sjJ/sYnKa6BaQHKi2MOd
 24YA0F40INOY7V4FlEOFLzK1fenKHn9/+eebalWSGq9Q2WQAh1Ac9S/WIKETDqY6k69PNdGXKJ
 8xU=
X-IronPort-AV: E=Sophos;i="5.81,213,1610380800"; 
   d="scan'208";a="160996278"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 03:07:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKzdCD/CHWfWtrRzRp/Di9By0MIFtOilITDLS61cq5+tZVSMU+E4QKX0MfxVzeUSXVau0pjEdxxHI7ylqojXtF3mLeiA1Bp59NjizDnUj9Jp7rCMBJ6C8Kb5kErShkMAcuTPrXrK2cyWPVRo6+a2ic0ZLBdPiAhEIErWldpwgrv7Up4AVnxxHhYDeGVDabqMqm+xNoXXUarQCnd7Pub/GGAB1G/E5WXOI915MmVALYkyEMdhULKHdn+ILLbEkGKoLWVU/yjmmi8Phh50IdWT8pUmifW0L0iVM3hfz9LTENh5JRAiF4yhWP5OY1TIKBF9tD0guebEwt0HQEnIuDxJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO3uqFu8Z5EhSeOgFytgXlOcGAD0pv0+vTGH7VRDtgY=;
 b=IcMorGZDdeLMpxNBlKz5rFh4H93upJPJ/Ram08Kje0TEsPaeOu5DaxMhiHOsGgiSvLGLOPB5AezzIqiEvcUtLTWbBj1O/Yzax0FUX+Jg7AfVBEDBMCWeLvmp1bdgkg2wl3M3jLQ62MIRrS9FccrGYpozbHpFKWZKKpQL/zQmq/SmVK0u/X/+TrE2G5d++EQka43LYMge/13Ql9SD/m7Gi72po0UqFD2GH3NDp8s8KOI6Zfxkd4mm1z9fBGdOnkm2/zZ4ya7lqzKkTyukg5OaQgb3IANKh/0IDdO+OuZKQ9KQRzADaZn+sj4X5m93k1BTSy0miUVTgbjTXLZl57qp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO3uqFu8Z5EhSeOgFytgXlOcGAD0pv0+vTGH7VRDtgY=;
 b=aYFnIy2Jwsw39JBwMEF+FPiXd2gsFe5OGdGaUilscprJqgHWMq/F/vVzntF6SwTMZf4A+i7wG391aejTIL0p0AWQGoXDQWVi+CjcbqfXzwiTxnZBF4nQYLL+OYl56gR2ERWWK4NBYmYx495COTyXgAJm8AWhLhSRYj8jMCIpDzs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Sun, 28 Feb
 2021 19:07:55 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.020; Sun, 28 Feb 2021
 19:07:54 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
Thread-Topic: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
Thread-Index: ATMEK5ZZiq5dQIEjdxrgFGOXaz1llw==
Date:   Sun, 28 Feb 2021 19:07:54 +0000
Message-ID: <BYAPR04MB4965FDA9847096508E35FFB9869B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a77c6bd8-e1dc-4d59-7896-08d8dc1c2753
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-microsoft-antispam-prvs: <BYAPR04MB6024C08241CD56E7DF86EEB3869B9@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vH/5n5oZAaesIMn9Fot0ybNRm2mc/mhCuWDFHVmt4n39irmw7JcEgiawVI5veTxiFgnAIM5klxE7w5HS+SVFhgRHOhyb452MupIsZjSYbaMpNFLRrfXRI4xMQHnloz03bhAtOGEg3txjuG/sMe/wtJ2I0WOp+HQ0CFd/CtBM9ZhT7hovF8nq6MIiFr08QmkAu3Wq2lKxfUJa33Y+XQbGPFg9NRgHBKX/OhmLCjQHXGe4g0phJYsVaH8cOjJ0QL4l0LpvDH0EYvXS/XRT1t6fnSNM1ZI8ihNUrCir9q8KOr/OwugHU5QO3cauMADsnVEn2hDf5lFsKk4g62GhkbE1sA49aQ2eo5Q32BOLpB8M9UUjJQrqSi+xNqFJROhP/Qx2LcOP4jYocIV7ZAQLOzmzt7Q3ATErZyz+P1gYMq8VXu4J/djkiLd70pbP+NgwTZwtv9xwBiKNDJuchsooj6Y7az3yVOk/20hMd6AkAfc0h5Hn89hOyZAdqijNnugq5gPPa4tr86RB+cdSiwcZ6oKbYbsRKaxK9AS+vuf2rg77B2TAqQzigA+7OGONrVgOt2gd/kvM4PgyoZXQdTY+ymxMOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(9686003)(71200400001)(558084003)(66946007)(76116006)(55016002)(2906002)(66446008)(66556008)(64756008)(66476007)(91956017)(86362001)(5660300002)(52536014)(478600001)(316002)(6506007)(8676002)(53546011)(8936002)(33656002)(186003)(26005)(7696005)(110136005)(128973003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wm1z1wIDksV9gY0NZr1KPIlvx4wFWh/5eq644ycKej/U826rT4xH3gWbmVVu?=
 =?us-ascii?Q?9ELm/2LiEntRTtl1uoMps9Nlp6jrfhylWmYfUv3MVVYLg9g2jImtlGomn6jJ?=
 =?us-ascii?Q?pvu782BY9fTR/x1Ql/FAD+F47xLBX2MihdNkPoRQ/Ic3/Vvo64r66JLHTCIF?=
 =?us-ascii?Q?3WCNVHr6PuR2qTZ6VkYdq+uBw4lTxFLXGH18CsDw8S0JX+znaYBtpVle9BYx?=
 =?us-ascii?Q?d/k6zqSyqrUUHQBeQDKj9M7cOEO65cfLbvZ6JZfoP6j9Ozt6owCPpPll4aK5?=
 =?us-ascii?Q?rJKqlVf+qTZqaf4SPApkMOgjLb1qhY579WboVWuBRCazskEwOEJYMp49WVsV?=
 =?us-ascii?Q?S+yORuHyFjl7cPftNRRoxGnHv3VBG3jwA/VjF78n7BLXrIfybCNPNXXqTArh?=
 =?us-ascii?Q?nin7zO8dOkgX8PAEJ4uyzmLs1PkTTzJXwf1vfC2TNAJjutFhmhZElIqfnwQY?=
 =?us-ascii?Q?M4UFBod0ZQcWBmBjZXCViEBJNVOqa4YjW03WqNOh0LTImoTYBNCkl+csh8fq?=
 =?us-ascii?Q?5+GnwLfv9tl1WsdEbCpfgnJ/53+BN9HiVxQoCvSeuIpzW6Vg/qmSbBk8hNNk?=
 =?us-ascii?Q?/YseTv81M2geTOMU353/FU6pj6+iNwxgIaj9weKZuXb42csjYyc4j3ym/wGW?=
 =?us-ascii?Q?vZ9XT3u4wiUlkbyggAhiYBdFNmJdhZ1BuFQg94F6jxdyREIaBakPizAzvx80?=
 =?us-ascii?Q?BJiah3CtN5kTHtWVyGrXJJPROecDskdJggT106xa7sgJcrEViSEfACBNnzny?=
 =?us-ascii?Q?d0xii7sfwzTFj3ZL9YxVL5bMRpuwvvKM+qc5OU4sORsxgsv8Xhlo4RRkxeiJ?=
 =?us-ascii?Q?DoDghp4rinXW44vpErOEhUmqH1aAvkFIPiCBySG41bwRHJOjwW4P8oIQfsYT?=
 =?us-ascii?Q?m5TJeGPIX4DKJCenUkLDx/xLbQb343/Ek47lnTpcpS5QZI6v5e27xvZ8Yvae?=
 =?us-ascii?Q?mGwSO7FeBI2UU0S2pp57kC+PJEB8574SkMj015xPxKmrr271gQj2Iq8YbkWR?=
 =?us-ascii?Q?L2m5o6NUQfIMBvz091DwGgdYpKqDJrlAoYZDlLkqr27+Rk9aCFFeep5x/lC8?=
 =?us-ascii?Q?83nO7eafCNXCyuM3m0Chdu8+LrWU7SYw8z6Hd37tlnQfEEZ5UqcTukkR/kTg?=
 =?us-ascii?Q?ys7ymuB+rY4T4b8iwOtQrYnaudQVVP1s/G9532lUDuHXDujvPmEQz7KDnLU6?=
 =?us-ascii?Q?BrxiuwLzNNSek5mk+eIgGojY1gBFrEMBoXdQ5RmSTrV8IR/U9Qz1sbwbP4jF?=
 =?us-ascii?Q?hDtjvvyhiOfVQXiOOr82NN6ABHozRceYqZLpM7dYn0/CDKqQbbLfsrmXsRA/?=
 =?us-ascii?Q?pnzqpSrzccRNAjOjK8aV7DV4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a77c6bd8-e1dc-4d59-7896-08d8dc1c2753
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2021 19:07:54.8152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIDJMZibMVEKsbsmn5BIAhkBIcqLEQXb9vBzHStRoFNor3MvLZoA/SV6ZSh1eKUX+mux51bP3ZKlOY8SmWaNBnhqPTwecTaHlYnFx+3PNpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/28/21 01:52, Yi Zhang wrote:=0A=
> Hello=0A=
>=0A=
> I found this issue with blktests srp/015, could anyone help check it?=0A=
Until you get some reply you can try and bisect it.=0A=
