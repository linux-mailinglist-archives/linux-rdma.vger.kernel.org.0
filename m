Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137DF4CD07
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 13:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbfFTLjc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 07:39:32 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:7693
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfFTLjb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 07:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5J16XCziHnKfTvVaUJtyekhYwjVIdu5oWoW63PwC6a8=;
 b=Tto59ZOAsJ3+iKfJYOg2uo/ans+vuzgA4DKmKCJXS3MGfWnXnNqXEMoK2xbMCpLtUKEbvLPq5lwAGoDmRX/O9tfNPoNbFZxuTuk5eUGUfuFFBERezPUBFuNfSvZp80hlrhJu+gOGlyj0Eh1mgiWv0SI3FeIl0iWQWlK/BXNyzIE=
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (20.178.116.18) by
 AM0PR05MB4529.eurprd05.prod.outlook.com (52.133.52.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 20 Jun 2019 11:39:27 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::80c4:5513:93c6:65fc]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::80c4:5513:93c6:65fc%2]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 11:39:27 +0000
From:   Max Gurtovoy <maxg@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "hch@lst.de" <hch@lst.de>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Oren Duer <oren@mellanox.com>,
        Vladimir Koushnir <vladimirk@mellanox.com>,
        Shlomi Nimrodi <shlomin@mellanox.com>
Subject: Re: [PATCH 00/21 V6] Introduce new API for T10-PI offload
Thread-Topic: [PATCH 00/21 V6] Introduce new API for T10-PI offload
Thread-Index: AQHVIG3E7KGLvfxi302pDA09ExScVaajvXEAgAC7VXk=
Date:   Thu, 20 Jun 2019 11:39:27 +0000
Message-ID: <EAD1CD56-D710-4024-B9A6-E07D0CFBF5B5@mellanox.com>
References: <1560268377-26560-1-git-send-email-maxg@mellanox.com>,<20190620002858.GA16100@ziepe.ca>
In-Reply-To: <20190620002858.GA16100@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
x-originating-ip: [185.175.40.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ddf8500-f535-450f-26dc-08d6f573f3bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR05MB4529;
x-ms-traffictypediagnostic: AM0PR05MB4529:
x-microsoft-antispam-prvs: <AM0PR05MB452970BD3E939A221B3CC6DBB6E40@AM0PR05MB4529.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(6486002)(19627235002)(102836004)(76176011)(107886003)(8936002)(316002)(86362001)(6246003)(8676002)(26005)(36756003)(99286004)(54906003)(486006)(3846002)(5660300002)(6506007)(4326008)(68736007)(66066001)(14454004)(6916009)(81156014)(53546011)(11346002)(478600001)(2906002)(476003)(229853002)(71200400001)(6116002)(81166006)(14444005)(256004)(71190400001)(7736002)(6512007)(446003)(305945005)(25786009)(53936002)(66556008)(91956017)(66476007)(66946007)(66446008)(64756008)(73956011)(76116006)(186003)(33656002)(6436002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4529;H:AM0PR05MB5810.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: usnqYokgIrimTpodlecPS6MHKprSDDTUXgA5qBVPsOU0NXXjvrDLVVk0xpmd940eVtHTqwI5haETb9lSzhTIsTGwQsPKMLCiOyMov6WEBeOhSK7eXw6UhGpbB9zTNCSD5FVuQefL+PwCpWs+t8xPqGMX3DEjREGPaYLHbdAZ/QRmPFzukBnRhD7H0KEtx6GRjL2x6XnoYYyy9eA3kABc17Ndhk+vdDNoSxhIbC0JoxhrHp5PpfnL4Xa4bslmbX9YcbTZ1vME54ask3KykGjr8bSs0f/uM+R6cU3pFEQ+HiiFhpkk0+6iou7PV29UEfhIFd/bIM40vGadKiJ0hvEbQIGiZzdd5iO92xRKsOFlGTH/Mt20Xj+Hkxy96CZfQq7z7Dpv7OqvwWx/KccdL/TnQJH+dB7npnCU2tJ63f+lF9s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddf8500-f535-450f-26dc-08d6f573f3bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 11:39:27.7647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maxg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4529
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On 20 Jun 2019, at 3:29, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
>> On Tue, Jun 11, 2019 at 06:52:36PM +0300, Max Gurtovoy wrote:
>> Hello Sagi, Christoph, Keith, Jason, Doug, Leon and Co
>>=20
>> This patchset adds a new verbs API for T10-PI offload and
>> implementation for iSER initiator and iSER target (NVMe-oF/RDMA host sid=
e
>> was completed and will be sent on a different patchset).
>> This set starts with a few preparation commits to the RDMA/core layer.
>> It continues with introducing a new MR type IB_MR_TYPE_INTEGRITY.
>> Using this MR all the needed mappings will be done in the low level driv=
ers
>> and not be visible to the ULP. Later patches implement the needed functi=
onality
>> in the mlx5 layer. As suggested by Sagi, in the new API, the mlx5 driver
>> will allocate a single internal memory region for the UMR operation to
>> register both PI and data SG lists and it will look like:
>>=20
>>    data start  meta start
>>    |           |
>>    |d1|d2|d3|d4|m1|m2|m3|m4|
>>=20
>> The sig_mr stride block would be using the same lkey but different
>> offsets in it (offset 0 and offset d1+d2+d3+d4). The verbs layer will
>> use a special mr type that will describe everything and will replace
>> the old API, that enforce using 3 different memory regions (data_mr,
>> protection_mr, sig_mr) and their local invalidations. This will ease
>> the code in the ULP and will improve the abstraction of the HW (see
>> iSER code changes).=20
>> The patchset contains also iSER initator and target patches that using
>> this new API.
>>=20
>> For iSER, the code was tested vs. LIO iSER target using Mellanox's
>> ConnectX-4/ConnectX-5.
>>=20
>> This series applies cleanly on top of kernel 5.2.0-rc4 tag plus patchest
>> "[PATCH 0/7] iser/isert/rw-api cleanups" that was applied to for-next (J=
ason).
>> We should aim to push this code during 5.3 merge window.
>>=20
>> Next steps are:
>> - merge NVMe-oF/RDMA host side after merging this patchset
>> - Implement metadata support for NVMe-oF/RDMA target side with new API
>>=20
>> Changes since v5:
>>=20
>> - Rebase the code over kernel 5.2.0-rc4
>> - Change return value of ib_map_mr_sg_pi() to success/fail
>>   (patches 4, 6, 11 and 16 were changed - Sagi).
>> - Squash and refactor "Validate signature handover device cap" and
>>   "Move signature_en attribute from mlx5_qp to ib_qp".
>>   (patch 15/21 - Christoph)
>> - Split out helper function at RW (patches 16/21 and 17/21 - Christoph)
>> - Rename signature qp create flag and signature device capability
>>   (patch 14/21 - Sagi)
>> - Added Reviewed-by signatures
>=20
> It looks to me like we are done with this now, yes? I'll apply it
> tomorrow then.
>=20

I guess you're right.
Thanks.

> Thanks,
> Jason
