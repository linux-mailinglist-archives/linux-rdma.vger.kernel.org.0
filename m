Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC11983CC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2020 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC3S5w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Mar 2020 14:57:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58474 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3S5w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Mar 2020 14:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585594673; x=1617130673;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gbhi8dvoi3yU3gJPEkhcOoPbadUpDL9ShnjbsFIxtAM=;
  b=ND8CKYJzn97WRXR8UoAhDftQeBagQHoDOHt2jwYzOyrMleKhAi/2I+t7
   TIyGmTrc9tLjE44p+GzeuB6pohU5jfv2Bh6fnpFkwR2lvdSB8n4XprGrV
   upiiIAM9WA7D2wBbd+4PX7wxusVgAscfw14EaXn4oMgq/M9sKPvXUZbug
   hkmvhzJVzqFWpgXpanfvraKi5K+z180DeCIV4CPQl4mB4bHIVkczOV41J
   i2Xu7busVWZPEOkmLfBlJ/K7tyD+WOnqQxkCftIi7SdJeSaHf37rAxI9c
   /CbZt2ZM+fCSbB2i0TSzEyhPVViIOeFnttoeEHDJInI4K244mbN6VLDVm
   g==;
IronPort-SDR: BhLiCP+WdBmp42oqalXtVaXLUZQnYSa4Gj6RjzgIPiUH1/s8zg9ZAFDDWS0MfgPe9rqxlwg7N5
 QCuTw3REodx5FhR1lwhhsxv6UzibY5Y+q15UMrJI7IsM+HEFk4fZcgXaVCRjy8L/6owmfQmV1N
 IKWgpSFpoW9lfrBG4VhMtZOW0zBgd7QRxLVbe1gCAvaG4p2VG97mNSlMW+mwrsYbRm1p3cozrP
 6L4zPnkQMyC0S/DpTkdHp2iYQ7P88kHXJaFgHyZ/Yb3G60wG6PNbv2i5S5PJp2PRPbWDTDH9Ty
 vuU=
X-IronPort-AV: E=Sophos;i="5.72,325,1580745600"; 
   d="scan'208";a="138277685"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2020 02:57:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+xu0e47siBlbc1jac0f/OxJ0q1I4SvLiubSCer0YHIi6L3VpGF7vX8yU0YB//tMkz8X6qsbiBYCAvv8i2VdUiLjTPi4uriaQPRseL9xLooVBgo5Bns2OTFSyH82fP2XmCRQCWkKhO0mjlVenYkXizTaQIqzWpl32CyLXaO2knWk1Lxb6J0wea6SlXS6F34L+SpCgUrxXYNFPgQtEAvaSMhNd2Tcg7Kl+19SlAc3QBwBQ9OzE1zzndrW7ikB9ImG5OS1WpKkMulLBPF6CDqReUHQS12WPQBthJOGcKWQ+IIrZesJLlpdtCnZr0i278E5UDGHqSRUlsAP08DhPNAcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbhi8dvoi3yU3gJPEkhcOoPbadUpDL9ShnjbsFIxtAM=;
 b=OBCj7mpbmWeS4aifAQlR3vMNKdGMDnAgjfSfE1dDkm3M4RrqTvDBR9u08mz2b+T1d/Ogn984rrtuRc6NN2si8Hsy0mOTTFGt3WPzjHQFkDD7nK9PnurdlpTqMP66u32ydbaM6UV0m8d3p4PLXiG7DzV4SuCignEZwR5t5oD8cqc0dvdE4kopE0lAxiM1eVsRdPzfsSR1dltOgv6GSIp6MC7mMH2MIkxcvdMy6Vob9d/DcJFUp4v9S/L+tcDBCiNpyBItr4YiS7vaKE+7vTm+YzKQxQlHbYOxCe6ZQeKRY9/SsNJD9LjK26KWjyKgremGq2qvSUtw3SfzgQYWySbdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbhi8dvoi3yU3gJPEkhcOoPbadUpDL9ShnjbsFIxtAM=;
 b=KiUgKr7gDV3LVMAs3CTjjopUE7w22dhRWxEmrMe5iDsaWuPM+wAQFUgpssnSYWNgTuQEFzDybHS7cJe7mHxRGUwPo8QoV/WgHuP9UhxgsPkg64EHYCA4cl3e/2Dhox8tedKHERtYsZNQv45gLejW2pWveqPolYX26rnGm9GupaU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6181.namprd04.prod.outlook.com (2603:10b6:a03:f2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 18:57:50 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 18:57:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v11 15/26] block: reexport bio_map_kern
Thread-Topic: [PATCH v11 15/26] block: reexport bio_map_kern
Thread-Index: AQHV/rGKCEGMgRuVP0mTYK+YBVb5SA==
Date:   Mon, 30 Mar 2020 18:57:50 +0000
Message-ID: <BYAPR04MB496521270DB356B16475F2CF86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
 <15f25902-1f5a-a542-a311-c1e86330834b@acm.org>
 <20200328082953.GB16355@infradead.org>
 <bbba2682-0221-4173-9d00-b42d4f91f3b8@acm.org>
 <20200329150524.GA13909@infradead.org>
 <CAMGffE=Oz+x8PCG3NK4Oo+Y1oDV70XbhSF9oVy8q=Z5+ZwnCGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d9066aa-d71c-491e-bd69-08d7d4dc3e72
x-ms-traffictypediagnostic: BYAPR04MB6181:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BYAPR04MB61812C7A9F31D3070725AFE786CB0@BYAPR04MB6181.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(86362001)(7696005)(186003)(26005)(478600001)(66556008)(66946007)(4326008)(66476007)(9686003)(64756008)(66446008)(55016002)(54906003)(4744005)(2906002)(81166006)(81156014)(8936002)(53546011)(76116006)(5660300002)(71200400001)(316002)(110136005)(8676002)(6506007)(52536014)(33656002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ha3dcUyIByt8OlU3esjWExpJnYthNtqAcOfs4hEvZCepitgPul72QGohTlEzpV0sYEEUWjgEHp4oP1QjCi4wWsP/iioUdUMK3VTZ9EFCcM6GbbPCznkeyrRMcOaZz8jUBVsG3x/M97ZWm97kKWw0v5AVVlQYgFuhCNW9bjgd0qkq2q39g43Q0htx/RN8vhJTQN5iX6xtANBsg2SagPC7Idz/OShfG0IiGBanGm8wLDmlNDEn6fQ4Sx4Nms9fR5pIMjBDWnUZ7v845Kd4zmMigB1ZFJKmuxCrh/KSts4K4j1qK4z4qPpUEwxEHS2DrHkKQERKTRSgICQFoxj2csA0x6+uBRr2h5g9d25wZ7+As7ekJ1qawurpUDZnjhMgH4+a+kjhbeHjijLTpoRauD8eveOMfhOBsbyN//X1s35wU36rBMNubxoVVVSOwpy+F8S
x-ms-exchange-antispam-messagedata: 7w2ETVzVqZ7Y92v+4aiGRvUCdvbfv7/qJigKxFhl8yScvrPbqGNTBdiGlQAgayqs64qxxm2Lbo7LPxq2LjCjBSzUyD/AMIVPnf/k2bXkJJgkfJyB1BePtn4l+PfarF2J+ujnIhb5tXs2Fzb7oXjk0A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9066aa-d71c-491e-bd69-08d7d4dc3e72
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 18:57:50.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ePjZ5u/M8eQu0tJCpoZqy+pZLVDSW7cHYR7vshfPg9EO4Avk5aELR8/Bb9tYoy3M0nTuAMOD+XvrtIie3CtXRUKaWSwENlLOyh6og4JE2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6181
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 03/30/2020 03:44 AM, Jinpu Wang wrote:=0A=
> Thanks for comments, Christoph.=0A=
> If I understood you correctly, so the right way is to construct bio=0A=
> similar to bio_map_kern, but we have to use bio_add_page instead of=0A=
> bio_add_pc_page?=0A=
>=0A=
> As mentioned by Bart also Chaitanya, looks it's reasonable to add a=0A=
> helper for normal READ|WRITE operation to map and submit bio from the=0A=
> data buffer,=0A=
> but sure can be done later.=0A=
>=0A=
=0A=
Yes helper can be done later.=0A=
=0A=
> Thanks!=0A=
=0A=
