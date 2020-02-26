Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF81706D7
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2020 18:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBZR6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Feb 2020 12:58:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:58881 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgBZR6c (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Feb 2020 12:58:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 09:58:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="350441708"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 09:58:31 -0800
Received: from orsmsx126.amr.corp.intel.com (10.22.240.126) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 09:58:31 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX126.amr.corp.intel.com (10.22.240.126) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 09:58:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 09:58:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GbdeVvDZnm2v3ufRcaAcPs36RerenA43m7LKqotrTzz4erIWZlTxu4DMPWjWdDiUMEc0rTU8HlvY3HgFJwQzacS0+I/ksek8XlQCSpDunRj9etw1+tB2B1V2M83SKkUdMmq+Q6NoXQKlqt73ptfrkvaiG0Pi/N/i940OrLi0fOyxJcyI0txpHF+E2sFlTGaqRG7uJQ5NGF9hTxy9VBF6dDY4n7Txsly7+YJjnEuhit0KYXucfPv3+ajmUDzn/VS22Okq6T+fTQNlnRCmLC/jPrIkRDC6eQUzeh7QgBnEDIRQPvlhBff389ezjKB57CWhnRiL8BCbUhNfkKid9gLW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DcQjB2Ekjx7lIDpd+p2HgCW3akJnCF2PnUJvfaGucE=;
 b=dCZYPcXVxIhRLyvuc7T3PMt3IASwgL3LbuI3E39QMw9xetJ9YEwdiOIOTqwqg7PbGR9Z/xNvsniBP+O7I+sOyBHacaHwka70tVWGC8pMldfpZFQaWMYatWyWw+LbH9SzY8v2i8FOc5W5a6tQzYoyMCz7EpnA69MoLG2lW5elCF3+0IguWsZYADZbgF1MQBrefpXFLWT7HRi/URq0JF0yHNiEFzSkJ8s5aQWQONUjEu3QapCLlkn75d3gD25ASAfqnEiNtgPZx+etB+dy5UpW3LeFOuhy7Eth9Wn4KzRC23qc3DAh1X13B7u1FgdWxmugThmGsuPGgBmLZW6WQFY/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DcQjB2Ekjx7lIDpd+p2HgCW3akJnCF2PnUJvfaGucE=;
 b=bclWABtIo0apFkdt8xsbPOkEuQOix4DhKH0obJj5ulJWrS8dA8Bfdv60sMjfvIPFKW1pbQ2W6+BbCOS1MkbB4vbNKIYhy/U2ioDerrJQ+fURD+NvQyWM/ncHOK+zfdkhq2wNjrtOZz/bOmLfVtmrv6NuMfmXw97U1xXDEJXAGpU=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 (2603:10b6:301:52::23) by MWHPR1101MB2352.namprd11.prod.outlook.com
 (2603:10b6:300:7e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 17:58:29 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2750.021; Wed, 26 Feb
 2020 17:58:29 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     Leon Romanovsky <leon@kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH for-rc] RDMA/core: Fix additional panic in
 get_pkey_idx_qp_list()
Thread-Topic: [PATCH for-rc] RDMA/core: Fix additional panic in
 get_pkey_idx_qp_list()
Thread-Index: AQHV6+AJn6O5sTpnyEufWANZxzLkFagtctIAgAAFugCAAAZtAIAABJ2AgAA9mmA=
Date:   Wed, 26 Feb 2020 17:58:29 +0000
Message-ID: <MWHPR1101MB22712BF3F1A23340488F740086EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
References: <20200225133150.122365.97027.stgit@awfm-01.aw.intel.com>
 <20200226130432.GB12414@unreal>
 <a6c9d82e-59ca-eb27-fe53-ca6edd55fb5b@intel.com>
 <20200226134802.GC12414@unreal>
 <MWHPR1101MB22717251968B09F6D695214486EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR1101MB22717251968B09F6D695214486EA0@MWHPR1101MB2271.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 556a49a1-7c2a-4c8d-072f-08d7bae57c76
x-ms-traffictypediagnostic: MWHPR1101MB2352:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB235220ADB56F4983941DCAA386EA0@MWHPR1101MB2352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(64756008)(66476007)(66556008)(6506007)(66446008)(186003)(6636002)(2906002)(66946007)(2940100002)(7696005)(76116006)(54906003)(26005)(71200400001)(498600001)(55016002)(33656002)(110136005)(9686003)(5660300002)(4326008)(8676002)(52536014)(8936002)(966005)(86362001)(81156014)(81166006)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2352;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAy7KXStmUAUnoCxI/g0t9mKo3lPLqqXOZgARPi/vgkb99Fqo8KFxu0lNDuTdof/dmGAZeoHUXmY3gPFjubcQAf/87H6Ho7K0vpiJ11t0Kd+ohYLcUNVcVMcSTiXhrsEBnebgY3DUW08ToyQ+JSbBoHl12WVQajJ3Rs8FP+cbgLxwZA27tqqgG7mpPAwffETf0jGRajiqCZGJUxZrhXyD7sGggKJGV/ahSZdpmuBVY+EPtxW267nOQdNSSqaDVV3VF3ch4953i/VKm0seqXXXPg2YfzPzpJbzobRRCWlFQ7McS/jgZlX+imHz148WFedXAh4pdw3PecdzvGXoAuKikdKJxXLBDLxafdbozkgx2jhRyDdKz9tcegSJFzkjZGvGYSOjKjtyL5WTvylTUAm7e/sv+gL2s7Bj4UZMHIAN/OpLWsqCN7OmWqIX6kxV4LuCCr6ekz2Rkdd2FZsxfapF5ab2zkohJqhpPKKIr7KdRoaX7jZcZlu4x8LtckwU3OwIX2TeiS38IUG33iFsmnUwS/5w2sPtnfEYzH9AmSsZ9h/i55Tol4VyF+MS0d99dj2
x-ms-exchange-antispam-messagedata: GR3EDlOnkMdJxkovXCHZMc87A8DvxebC8ovfnUWOmJ5r9KGJtEipXNXEUyEjfOc56WPc5LejZ97nRMHD0DI1cNFaugEdkaG1/14LkwHlyxvosFJAjnaGllonSvNYlH4SjryqIz5PvlZn/t59jXavAw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 556a49a1-7c2a-4c8d-072f-08d7bae57c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 17:58:29.2982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDEliJfp8IemlvuTKOz42ifiMp31p3WE/R5YXzzmvP1Du1L9AvvnCP2UyO5rIXFfuSWC1Y2nKs4c1ZAe/e1VbQ8AIss/XVCz8o66MzzbPGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2352
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>=20
> > > You mean this one? https://marc.info/?l=3Dlinux-
> > rdma&m=3D158263596831342&w=3D2
> >
>=20
> Ok.  I will test the patch.
>=20

The patch definitely fixes the panic!

I do have a question on the new pp state.

In this use case, ipoib does the 0x71 (with pkey index and port) clears the=
 pkey mask bit, and does
the 0x51.   The 0x1 is the state.   The pkey index never changes.

If a ulp did the 0x71, changed the pkey index, and then did the 0x51,  what=
 should end up in qp_pps?

The state of 0 in new_pp I think will lose the different 0x51 pkey index.

Here are some traces:

[ 1316.849853] qp_attr_mask 71 qp_attr->port_num 1 qp->attr->pkey_index 0
[ 1316.857171] qp_pps ffff88905b58fd80 qp_pps->main.state 0 qp_pps->main.po=
rt_num 1
[ 1316.865454] new pp ffff889057fef0c0 state 1 port_num 1 pkey_index 0
[ 1316.872474] pp ffff889057fef0c0 pp->port_num 1 pp->pkey_index 0
[ 1316.902707] qp_attr_mask 51 qp_attr->port_num 1 qp->attr->pkey_index 0
[ 1316.910062] qp_pps ffff889057fef0c0 qp_pps->main.state 2 qp_pps->main.po=
rt_num 1
[ 1316.918347] new pp ffff889055e4fc00 state 0 port_num 1 pkey_index 0 <-- =
0 state never gets inserted
[ 1316.925365] port_pkey_list_insert main 0
[ 1316.929761] port_pkey_list_insert alt 0
[ 1316.934051] check_qp_port_pkey_settings 0
[ 1316.938542] ops.modify_qp 0
[ 1316.941674] new_pps ffff889055e4fc00 tmp_pps ffff889057fef0c0
[ 1316.948117] pp ffff889057fef0c0 pp->port_num 1 pp->pkey_index 0

> > Yes, this is what I wanted to achieve by "if (!(qp_attr_mask &
> > (IB_QP_PKEY_INDEX || IB_QP_PORT)) && qp_pps) {" line.
>=20
> Was a non-bitwise || what was intended in this statememt?
> >
>=20

I still have  a question on the operator here...

Mike
