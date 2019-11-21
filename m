Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23555104D91
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 09:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKUIMZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 03:12:25 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:35160 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfKUIMY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 03:12:24 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAL89ilO008204;
        Thu, 21 Nov 2019 00:12:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=gvsTnK9H0rQTyzqbfkwBsDNCDVhitcKDr8Vuzj23UcQ=;
 b=D9s3B3PGpXWxwX8QvKbrIksWwHMiaGJbjYwfGmqz2MgVbkhjXPIaq69t1w1/JM3pECIt
 JbKVCyBOhtgDoqPTZe2+DuHE0XXrFq6RbnBlM7ppM0FvyCLKSPJVi4JKbIoWOYGp+PU6
 +VVezlFab4/9cjHGghP3EcMtGnL+OmQNqwTWcHDfMuMHTG/zNlmUFhDaO5mbAzx1EfpK
 vE53KL9KlbSLjshe6WOEsFQlI2CETLZ7WjCBSSuhv9qP6cAWC+5XoiPFOKD+Ha3P/dwg
 a9RSWCEcs6kHclHXx8nrMOlR00hDQIs0wmnQvRS0AmQDfa47JsVlqjT1FKk+MWb05Au5 2g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wd090wqcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 21 Nov 2019 00:12:20 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 21 Nov
 2019 00:12:18 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.59) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 Nov 2019 00:12:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iErkdsHxks6FOgFwzcBnF+yy41T37aS05K11lAi+u/nA08W6aJzOQaVLHwZ2yxKIUIyod5hQwNZyugIyyuq32r9mnaazVdrxhMjkz63vZJ1RD0/f4xbEQXFL2vdx4uGpH1wTnyFWzxwRtpnQTiOeii8ofSLK9KrFtFT7/PqxoJWLdAYAdVgKJjzbVn2l0Z3enjpsK41H+UI5urwOd0uoeusvxK8lxIeSjJDpPtyOrN5ZqdMtzfLUKR84ju3o5GfRsDYUzoHqFyfcDWnu2u79vGFdjZJ5BQsO7ttdkIyNTWwxEuPD5vLEOWJbVbVCh3KOyhwu0AG6DoVhWUxPyIRh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvsTnK9H0rQTyzqbfkwBsDNCDVhitcKDr8Vuzj23UcQ=;
 b=kZyNIOTbvXL7RbVzSBn/u3Nrmmwnjg1h2C/VFnydBCLCQdFqNjGiyAHgrpUfOS7yxZZLFfM8Wd/V8cX1BlMo7lssaX8dT0mbuGVIs/MnO09OE5aRb6Whto59a89YNZxKxM6sWvDdPfvToOj4uxo+9aKNFfPYDzox7FBaaaf2/zjXVwsvUiDwg6XjqWpJkSLki1RDp2X+v5LIoqHPdfHLam1ydwAuVt4lqXZzXKdhJvSqdP8mknmqByomcEYzxXykciaDLyDzekkHgPNScYjYWQr+SXm+JzFDJOlZQ5C2o3UxIaqGAQPHcRn2ZqnT/QqUnvoCheIGIgCIfcjNx6vKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvsTnK9H0rQTyzqbfkwBsDNCDVhitcKDr8Vuzj23UcQ=;
 b=i8rmk8YhZFgrNT2eVqJcxknBgMWsAqN9a3Hopm5muwsSkciBlJvOTJ8QusC8UJTk1cTD+1IYCvtCqRBufXj7S+EawTQ6+5Iybdgo5QaQXOD7wcUwbO9r0bkDcszvX89/QXhhMf8DJUX5bjLlPTiWn4pedDMUGgcpndMtrlrZRfI=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3184.namprd18.prod.outlook.com (10.255.86.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.18; Thu, 21 Nov 2019 08:12:17 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ec7b:50e7:c198:5710]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ec7b:50e7:c198:5710%4]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 08:12:16 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH rdma-next] RDMA/qedr: Add kernel capability
 flags for dpm enabled mode
Thread-Topic: [EXT] Re: [PATCH rdma-next] RDMA/qedr: Add kernel capability
 flags for dpm enabled mode
Thread-Index: AQHVn6WjkCsSDgoBe0uch/QTIht0rqeURqSAgAEApZA=
Date:   Thu, 21 Nov 2019 08:12:16 +0000
Message-ID: <MN2PR18MB318225AE1B1FA351FD5CAFF5A14E0@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191120132009.14107-1-michal.kalderon@marvell.com>
 <20191120165301.GI22515@ziepe.ca>
In-Reply-To: <20191120165301.GI22515@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [79.182.10.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32ab4114-3ba2-42b0-a114-08d76e5a85f5
x-ms-traffictypediagnostic: MN2PR18MB3184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3184C0E286BFD37ACF3BC67FA14E0@MN2PR18MB3184.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(3846002)(14454004)(102836004)(6116002)(26005)(66066001)(6916009)(86362001)(7696005)(25786009)(6506007)(229853002)(8676002)(81156014)(81166006)(76176011)(33656002)(8936002)(66946007)(66476007)(66556008)(64756008)(316002)(76116006)(6246003)(66446008)(478600001)(71190400001)(71200400001)(55016002)(52536014)(4326008)(256004)(6436002)(7736002)(446003)(5660300002)(305945005)(2906002)(74316002)(99286004)(11346002)(186003)(9686003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3184;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQym17FD6Wvj//lprZ0lCcdROLa/wl0i6BpJsi+gUtnU2VisMTmMpimFK7RqzyjmfE5kUXZmN9RBWWoMOFK6ivTy87gUiA2utcfim1gWjHs9KX03G8xa8GCqSpKu4/sKez/OjftHWp0rWdC3jqnnLRWHC2IHguE2BUoloNWbHeWYJydePO6cJJeSgo0YiTMs78DUrqw+6MyyKT+C7dGFsytlTkJjXfUIzyPT3bAWDhS3vowQqxaqXQDKY5VLDntAJon65rvi/XHp/yoWQ6OVGyShD23qqSJtQ7nNgkIaSw0Moyw+IK933iLQETvFZJKjQwVzMfTCQ12IaIANuFPUl7N2RYvIq1VMv5nrYCxNf60XBdUcuQGWAyaGqjij+AIYb2pTu4rAUXdgLXXOMxk04aF10Lfn9bgW/sl2UEjmLqv1SSGnkr/wdrTIwNQe0knD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ab4114-3ba2-42b0-a114-08d76e5a85f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 08:12:16.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uy3NRbrK6vZ6pjXbwdq0Q6gBwISMyMNe67jZy2Hi/h0lAk2JvkaZQm/bMwrshf8zZ2ckrCvDF4bB7mGy7tkpSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3184
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_08:2019-11-20,2019-11-20 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, November 20, 2019 6:53 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Nov 20, 2019 at 03:20:09PM +0200, Michal Kalderon wrote:
> > diff --git a/include/uapi/rdma/qedr-abi.h
> > b/include/uapi/rdma/qedr-abi.h index c022ee26089b..a0b83c9d4498
> 100644
> > +++ b/include/uapi/rdma/qedr-abi.h
> > @@ -48,6 +48,18 @@ struct qedr_alloc_ucontext_req {
> >  	__u32 reserved;
> >  };
> >
> > +#define QEDR_LDPM_MAX_SIZE	(8192)
> > +#define QEDR_EDPM_TRANS_SIZE	(64)
> > +
> > +enum qedr_rdma_dpm_type {
> > +	QEDR_DPM_TYPE_NONE		=3D 0,
> > +	QEDR_DPM_TYPE_ROCE_ENHANCED	=3D 1 << 0,
> > +	QEDR_DPM_TYPE_ROCE_LEGACY	=3D 1 << 1,
> > +	QEDR_DPM_TYPE_IWARP_LEGACY	=3D 1 << 2,
> > +	QEDR_DPM_TYPE_RESERVED		=3D 1 << 3,
> > +	QEDR_DPM_SIZES_SET		=3D 1 << 4,
> > +};
> > +
> >  struct qedr_alloc_ucontext_resp {
> >  	__aligned_u64 db_pa;
> >  	__u32 db_size;
> > @@ -59,10 +71,12 @@ struct qedr_alloc_ucontext_resp {
> >  	__u32 sges_per_recv_wr;
> >  	__u32 sges_per_srq_wr;
> >  	__u32 max_cqes;
> > -	__u8 dpm_enabled;
> > +	__u8 dpm_flags;
>=20
> Is this redefinition backwards compatible with old user space?
> That should be described in the commit message
>
Yes it is, I'll add to the commit message, thanks,
=20
> Jason
