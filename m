Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D04C5196F1F
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Mar 2020 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgC2SIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 29 Mar 2020 14:08:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8670 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgC2SIi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 29 Mar 2020 14:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585505318; x=1617041318;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QPa+3ObTgNoGMTHCzVj5bIFyc8aMZPqTX+FXqSkbo8Q=;
  b=ZqUmDnYGNb3ABwYAPOZW20yrR7ODVGgSNmmuDBEqDSlTfuVGvO8R0h4A
   BtjagZLXrrRF7tSKf9xQf1XuB7chKqWYURyVrpetQ5JuuQFbY5MXL6l7x
   woHZelVczfRNDwUgxMTV4zM3EDL6oRNDSQhSzAflQcvScJRWSXdrekTzQ
   TYo1DayvPiK3YeQrwUj1eZvC9U/0nCPW/u8he3qR1mMNIB7XkYXG/ksVA
   qWeVNFoHSFY/TfLZ6qrtQNkjzYPUuq/DOzQZFicBJdZnYDrRZVncP8rPB
   zv3hNYqekqOb4sPhsV427ZXlz7m8ekHeQxTPw0DyUr3XxueuYIiWGlVJR
   g==;
IronPort-SDR: B8wZk2AWxTUi2u8kamfGnWQcPYYTV88nACi9WW2K5wANeHfxJoJDX+VBHSopPmJhKEexEjUu6k
 9EV/WRo6vfnOIG/LclWPLsbDEFeWgbBNnR3FwGemygECINIR25QiwST1TfzIuOQGeWrr4Rm6lD
 c8XU8Eo5Sk+N6rS49jJROhWS2Fxm/nAq0UT/FJUjjIfK2GWpHAofya/boVWSdCW6fXlf4N6wPr
 QOqJphtvj3Y5eXSCdORbRWFRk6yYD0l1MsGa6/y94BeS96639nmGEb6JvPgL+WCwv0lv6ycrSu
 9k0=
X-IronPort-AV: E=Sophos;i="5.72,321,1580745600"; 
   d="scan'208";a="134245295"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2020 02:08:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei9EBMrzX1N1eRAcrJyTODL6KTxJKlyQY1/sA5esclCjeY4TU9y3Vj9yzkwFuWy3SnWxUklcvjZd6e4qN7fd+Ftfjiw5jlpRIWSqxDEBEM9EEmU8yK2kYUQMSUzQOMopctO9UEO5CjiSBIGfV1MvUdW0abueiNFjKVIKxxbpSNIUgEPn/AGuFQrd/8lY1iP9ysgM4vESU82/w9YK7dCcAy5whQdLYW4pvwtB2qznPj/ZRYRj5HY5VAPOyQuLAm3Svhtntf7gLGk3P3YdTNjLcbF0AwiKaMCoZDdp7RYkqWDqpPjMVIRD0Bxy6nPaSKOtnKlS9AUmkqAB7CEcamv6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWWF9gHjXAOcHkGDZKDrxwMP2ex+8SlDgNdvHql4RKU=;
 b=Lo4/so7k9T3W+F5xcVCg7iFYvRJdJYDFIQPeiU7u1yKI4vmCzqTtaBVmuz2dYfQBwXW7WeFjxYYQ2RbKYRYEO2a/xBfsShgQUWezLCp3hwzU8d7PcbPbJfJxX71pJmv8XkDKs2kYPmEGX2hKt3Ot9kX3sV+NjfaQDZUhqKu8Z0hCfmbvWflFG5dj2ks8QoZKp8CZyc+RPKRt19vaPnnMPiUvvusJfpWf1+fxJtw5brEtXqAKrd5SDO24Y4VvPCm39vdluTCD2VJCXhvNfsYo1w9PrhRY+u/FbwQCZ+/jm/ltvCItpOJKyyLb6HDAHIEaoElSM7bBbr87cvQWXd0JCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWWF9gHjXAOcHkGDZKDrxwMP2ex+8SlDgNdvHql4RKU=;
 b=uxVSBZKwivng+8Tt3F1jjtQKkwRm67oddD54UKKWounfMNrld0NX4etj3Xvkv6kNWf8MDHkMi8u/a6R266yS5kjYed/NAfn5BzGuahu2fQpR+N1Gvl+7aGrcEksQpHCVmaC5Fu3dTx/cJCqczT0cJKbLVm1cGN/0ES4/W9Etpls=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6232.namprd04.prod.outlook.com (2603:10b6:a03:e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Sun, 29 Mar
 2020 18:08:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Sun, 29 Mar 2020
 18:08:31 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "rpenyaev@suse.de" <rpenyaev@suse.de>,
        "pankaj.gupta@cloud.ionos.com" <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
Thread-Topic: [PATCH v11 15/26] block: reexport bio_map_kern
Thread-Index: AQHV/rGKCEGMgRuVP0mTYK+YBVb5SA==
Date:   Sun, 29 Mar 2020 18:08:31 +0000
Message-ID: <BYAPR04MB4965BA89446761D2C3D414D386CA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
 <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
 <20200328082953.GB16355@infradead.org>
 <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
 <20200329150524.GA13909@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7d413d6-a7b8-4c0e-9fbe-08d7d40c30c1
x-ms-traffictypediagnostic: BYAPR04MB6232:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB62325627DAB0B38259B7CBEF86CA0@BYAPR04MB6232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 035748864E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(26005)(110136005)(316002)(478600001)(54906003)(4326008)(186003)(81166006)(7696005)(81156014)(66446008)(7416002)(53546011)(8676002)(86362001)(66476007)(2906002)(66946007)(66556008)(71200400001)(9686003)(6506007)(5660300002)(55016002)(76116006)(52536014)(8936002)(33656002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTmES70+9XH/y5k4KDy+K1Rkx89+aNL4GSEYl8AZJcR0q3qoKn8MFq/rrKrA2evphWhurl2OpZpVb2C7Qn4Q4AlsX14MM1YhRoyKCMHcW5RvgCW7aBe1pNy9rWRu7bLmP8gNFVA/XBseSCA6yXiFWlUoFLDNd6Tmqbl39KI+We56mUYix8Y65fa+q1Nq/laNb+Ug1XthRZyC7KMirHkFXb9uqQLdpGiezexvkj7neVfgh8UJ8cvgLNbO57Aiz6L67CbHhfYHOlkrPYRIPVPusg0dMjm9utGIvtJ1Tf7I91rsAZT18zPzQenuOEvkIzortedvcZPlzYeNG80IwWxPU1aWksaqLXcbbcXnf1ReMvU3WOUe7eUJ1s+8mupCIMUlXV3ZiUUR/VZ740fTUxtAH0JAL3TExmkmny6eDSYb3g06UCDUn9Pz1NFKHbVcaCf4
x-ms-exchange-antispam-messagedata: EgkwIOBc1AuvZXSVt3pLrPOzGcJT3yCLHhp/Qx9F1SheZTki/gkH3iNNlDvnQY28Jd4Ga7+2Lh6z9VqZp8oMWUFEiNt8JlMIylJMtRiSXAeUmtRFcgZSgp7LWgSrus5GaZMjDUHO9Ff1bf6K7/DoTg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d413d6-a7b8-4c0e-9fbe-08d7d40c30c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2020 18:08:31.7607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YLqjA4CPZMjyFazXe6IYA8yiOrTJ7U+0EyD7RXir/8Z3PdK8lLKcVKAV0bvZCURul723oXLOZmBizLf3dU+vaXki3y2e/JZih+GfyqlUfVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6232
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/29/2020 08:05 AM, Christoph Hellwig wrote:=0A=
> On Sat, Mar 28, 2020 at 09:16:55AM -0700, Bart Van Assche wrote:=0A=
>> >There are more users in the Linux kernel of bio_add_pc_page() than only=
=0A=
>> >bio_map_kern(), e.g. the SCSI target pass-through code=0A=
>> >(drivers/target/target_core_pscsi.c). The code that uses bio_map_kern()=
=0A=
>> >is in patch 22/26: "block/rnbd: server: functionality for IO submission=
=0A=
>> >to file or block dev". Isn't that use case similar to the SCSI=0A=
>> >pass-through code? I think the RNBD server code also implements storage=
=0A=
>> >target functionality.=0A=
> No, it is not at all.  The RNBD case submits normal read/write bios, for=
=0A=
> which bio_map_kerl is the wrong interfac given that it=0A=
> uses bio_add_pc_page.  Read, write and other non-passthrough requests=0A=
> must use bio_add_page instead.=0A=
>=0A=
=0A=
Since rw are most common operations, it'd be nice to have a helper=0A=
function for REQ_OP_[READ|WRITE] to map and submit bio from data buffer=0A=
with chaining to avoid code duplication in each driver which based on =0A=
the bio_add_page().=0A=
=0A=
I'd be happy to send a patch for that if that is acceptable.=0A=
