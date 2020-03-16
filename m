Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5D186DC2
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2020 15:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgCPOsZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Mar 2020 10:48:25 -0400
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:24032
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731445AbgCPOsZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Mar 2020 10:48:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhywxfHcOVrD2J5DfA3Zv3G7qXMETbVhH0XhcVzZJDrqbQbz3hCGKrRv2cvlTqeTAPk3UJQHIw96F28/oqeBtIPLXIPwZSH57/Rv49As0OnCyvJ+xN5MGEBcUGWnbvj1Uf2xWzgBfZdgrAdRmFJBK6LKU772UkD3nI7FFVDSPHpk6oVLFwY24pV4dPCkLvUEyXnCQfLo6A5usxltOXAUbcE2skVGr0Vah/gvHHiM5+YjZYrcYiRqmG3/hEl3hbTpCUD3ExAmUYCUTqSkYdMR0h5nd9mDoPcxWNk4KYdhHjsVSB1JauAXA/SE1E83SGZWWlo8OABnnAu4dg7fuSxBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX8z8gU3e0V7r+XzNLPxa9jvafJy1FoGc3ErvMBU1HE=;
 b=YKyNNMMQbnpwBrNzdqez87G7CZNBUcmLoKeD6IGFIXXkebwNhXm1elQYIarplA8tHCJvSCu9g2DFsYFUv/zDu5nO3U8y5T39efhObzmEKkE0vEVUwdEEOUH7+EH7lIjKTaUAAezUAGB7CM+Hba4Yuzh5Fi9QX1x/Pau5+wnMrxoz091pJ2CJEM0DXySAB/TxdzAKwVrVwOE+V4PQKZs431c5/5RoJZlAV7WQDTJuTq3zwhGfeapYyFuRHuwKlj5KNA2kuLJRrfaEMZCFu8stXmSikMAad0d9C3OAAoGlN+OrrhRylfrZ9VMiXR6L7S2AWT6AeIEiB/anyJBL832ZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX8z8gU3e0V7r+XzNLPxa9jvafJy1FoGc3ErvMBU1HE=;
 b=tBf0g7MtRbZbpx1bHP6hiPyRB/G3pmpcvt3HfgS7Y9DDvsscPPF3dMl0zHvyWZ/c8ZcAjDD1pCsoSysItGlSCSyBdl7MEJawdnIvd+7aJEnfkp0jdgrozyjSGfLI5U40KMRT4SjRl6OAp3VodHrR9EZDw5rprxhk1bi1tJIiREA=
Received: from VI1PR0502MB3888.eurprd05.prod.outlook.com (52.134.6.21) by
 VI1PR0502MB3968.eurprd05.prod.outlook.com (52.134.17.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Mon, 16 Mar 2020 14:48:21 +0000
Received: from VI1PR0502MB3888.eurprd05.prod.outlook.com
 ([fe80::c971:79e4:60ce:b4b9]) by VI1PR0502MB3888.eurprd05.prod.outlook.com
 ([fe80::c971:79e4:60ce:b4b9%6]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 14:48:21 +0000
From:   Tamir Ronen <tamirr@mellanox.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Subject: [ANNOUNCE] opensm 3.3.23 release
Thread-Topic: [ANNOUNCE] opensm 3.3.23 release
Thread-Index: AdX7oVx/T6YrcoQESGiuweq7GYUAQA==
Date:   Mon, 16 Mar 2020 14:48:21 +0000
Message-ID: <VI1PR0502MB3888F8C89DBCE739AD5B3B7CB4F90@VI1PR0502MB3888.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tamirr@mellanox.com; 
x-originating-ip: [2a00:a040:199:924c:bd4a:64b8:e20f:dfbf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db29e90d-967c-45b1-6010-08d7c9b912ae
x-ms-traffictypediagnostic: VI1PR0502MB3968:
x-microsoft-antispam-prvs: <VI1PR0502MB39689D407B1597AF972DF15DB4F90@VI1PR0502MB3968.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(8676002)(86362001)(110136005)(81156014)(7696005)(81166006)(6506007)(966005)(186003)(55016002)(5660300002)(316002)(33656002)(66946007)(76116006)(71200400001)(478600001)(2906002)(52536014)(8936002)(64756008)(66446008)(9686003)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3968;H:VI1PR0502MB3888.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ZdavfGIdAdMECigYJ2VvN7u/ecvmUsVTAIuiUUSA6NwEojUO2NJGlWapP1mIisfNdtQA63yAnhT/ISimXzPIrtYJixQvzdgeh1IRNP1n73+fASEjaBO6gEPLTNyrIpd9gSzX1/6urfULQLulA4hiS19nS59ndjkGTi4/v+3Rwwv4Q71p7Ve6VF//u8KPkuoeMCNNbAqBjDcoPQylZ2LeJXAS4VCnoWFuXtGrBuAGltv+4D87iT9xmIiaprFFm/0FBAxJq+VQ2J89rkPwBWyyZb8q1thCRSF9VS2+PY+rlbsLh0814wTOZqm8s8CQsTEh7dqBXIiEGFmLxwwCkxDwMCCb63J3ROTMEOpovhVs8JaB58WTizDZahgQz8BjzOGKrwApJRvZ3zPF9TpYJ1/doRl20KVFutpKNZQkNbu7riGTyJG+CZQYnQVoMdjDB7vAdIl8g4gupgbbbzsf2FjaR/4CBq8ZOGr1ZDvsT6aKPVCBTEmCW675RavvUZ+VsB9rTFijAK3oGXaz0pKU2I1qg==
x-ms-exchange-antispam-messagedata: Rif3o5/Ta2Ei8nWQtmrDXMy/yHUTOtFy2phZ7qW+dfdj+PSQrwsJZUMNAb+pDZ/iS/nCaRdU0qBQdC8CsVlxtrLT2NY79pTl+9pYIBP5CTFTOrdmobbYA+7gKibdJeKlepdsTwqgxvDNmkaSeSGTtqAYI2i9xxsq8Tz1r6tgho4CnToG9XgNpMIq2YnoNzIM+21CbY3j9UmREQE/KJyPTg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db29e90d-967c-45b1-6010-08d7c9b912ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 14:48:21.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: im/oSEBP/clhvMGTD6zUUlkuliIlT19DIi4sim2yULDe/EhM/7pZ7oXkOq651MVq4jUElPMFNbLzzJKFq6AtDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3968
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a new 3.3.23 release of opensm.

https://github.com/linux-rdma/opensm/releases/tag/3.3.23

Changes since 3.3.22:
Add support for registering an opensm plugin as a new routing engine Intern=
al improvements and bug fixes as noted below and in release notes

See https://github.com/linux-rdma/opensm/tree/master/doc/opensm_release_not=
es-3.3.txt

Full list of changes is below:

Nicolas Morey-Chaisemartin (6):
      osm_opensm.c: Fix use of enum as NULL pointer in osm_opensm_init_fini=
sh
      osm_ucast_ftree.c: Fix clang warning about empty loop
      osm_[port ucast_ftree].c: Remove unused static functions
      Add travis validation
      travis: Add patch check
      ib_types: Drop packed attribute where unnecessary

Tamir Ronen (3):
      Update shared (internal) library versions in accordance with changes =
since OpenSM 3.3.22
      configure.ac: Update package number for OpenSM to 3.3.23 for release
      Update opensm_release_notes-3.3.txt

Hal Rosenstock (2):
      opensm.spec.in: Updated for move to github
      opensm.spec.in: Move COPYING back into doc

Benjamin Drung (1):
      Fix spelling mistake of "switches"

Cyrille Verrier (1):
      Add support for registering an opensm plugin as a new routing engine
