Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC1FF8C7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 11:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfKQKeT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 05:34:19 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28024 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfKQKeT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 17 Nov 2019 05:34:19 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAHAV1XZ021459;
        Sun, 17 Nov 2019 02:34:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=TL00TBAJNcvssz4WIqhN9iBHQhQu9AeWhR0csNbPPJs=;
 b=bAxX9rFLzIxKei3qFM0Ekb+tN9Kcf4dZBHN8Cwd48C6iQuIkyFtwkIKlipQf6Y/Ogvex
 dHrZpCkIYL0L4uIiDFO4Cw75e0+N0Om9lSeSNeuEVUHV3T/9KVwpzHktY4nqnGAeT7h0
 BjIM5RhaIE65ooh4EutxPqJFWmpjp2TRkb4j7+2H1DjX4ss72k5PyfeblyHEDSPzg3Mg
 gA4+uIVI3Ss3R1vkQVlHXZUWm550xm7iHf3pp0KOJnLDd2eijhGRN7ruLbGRhpmjJDHM
 WMhVJj4lS3eh/yG+XU+SMyzRr4zLEzFqGwauR6gbGvZxH//ZLH2Yb/xAiMrvs4cS55FV yA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wahgs2nnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 17 Nov 2019 02:34:10 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Sun, 17 Nov
 2019 02:34:08 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 17 Nov 2019 02:34:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLKfL6wcD6UY+gzZgxkIggcBUByqqAWI0HHGegzsUM7fiXhb7M4uI4GtQoL3sgseUwZ1u8/w0jNEDU97ld0yftEbLFwNw3Aua0PjwFKqs7G1B7eaoSMVU+duZ6KQau2RYXYIhUDuDU55IHT2QkXVhZ65ZhvNd2sACZOjbiED5vy6OGdIAFLe2HrNhulI+uxEinZoxvsB5mn0uScxJMCWuViGPZojKvitB8sxt7422UgpDeaHoRr6PB6HoCDZgCPgWWEZSs4iwREmGDRKBK2oSaTTxeAz1lTz2dkpKa4twO8mGICuqU70Oo3sRofXwBL3+RA2hNHcOPoajzG/8Falpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL00TBAJNcvssz4WIqhN9iBHQhQu9AeWhR0csNbPPJs=;
 b=S42/Q3LjBob83Ee5LFHx8lCYJANbDrU9MHN1BIYL1Zm5/nFmyEz3vAXP0CEb8NO4XtTMMdSNk57fQ/+Lb9T+HdQ7AdL2Yl+OMge1EOgY/jODGiXq4tKsr8V+R0WJEe8KZZuM7O/6jrx/pCCK8TzK3uSXuSSQauFZ7WKYkOTGGI9wISqSfV80auPwjDw+PMhEv5S0ok271RfXeAc2RtJVp1jUdqYhGGPNh3+7voXW35XmWCSx7vA70Gix1p7imgTmdpZXFTa6zkijW7D7S1IKXAk7tszjEQcPyJaaZRdFTHmGq8guH75RorlwanWLPmk/tF+Ggnhh9BNLN1Ylc47LrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL00TBAJNcvssz4WIqhN9iBHQhQu9AeWhR0csNbPPJs=;
 b=IggdG9aWWYRnVCPPOGmC8W9HjBRZ9xFAxenHKoVE5yxvVDrouSuvaRYGFQwuSdGZ0Rz36ND0zwrCoZ76IEIfe0snzpKfi0Lq4JhN7C/N2SBI5mNn/NhcuMVBXKK6gFSsn4uJE+foaPOAfQ8uFpulu3qZMqcLv03bcnPaecbsUFk=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2880.namprd18.prod.outlook.com (20.179.22.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Sun, 17 Nov 2019 10:34:06 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ec7b:50e7:c198:5710]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::ec7b:50e7:c198:5710%4]) with mapi id 15.20.2451.029; Sun, 17 Nov 2019
 10:34:06 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>
CC:     Doug Ledford <dledford@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: remove DMA_ATTR_WRITE_BARRIER
Thread-Topic: [EXT] Re: remove DMA_ATTR_WRITE_BARRIER
Thread-Index: AQHVmfSDVWBkZI3TfEylQya/HE3fYKeK/TAAgAQzy1A=
Date:   Sun, 17 Nov 2019 10:34:06 +0000
Message-ID: <MN2PR18MB31826245953F4F2E3227E4F0A1720@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20191113073214.9514-1-hch@lst.de>
 <20191114182302.GA7862@ziepe.ca>
In-Reply-To: <20191114182302.GA7862@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.203.130.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 739f3db0-8344-4bc0-5585-08d76b49ac49
x-ms-traffictypediagnostic: MN2PR18MB2880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2880FD9C85D29951C3FCBF90A1720@MN2PR18MB2880.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02243C58C6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39850400004)(376002)(366004)(396003)(189003)(199004)(6436002)(81156014)(8676002)(14454004)(316002)(256004)(66066001)(54906003)(4744005)(110136005)(99286004)(52536014)(66556008)(66446008)(64756008)(66476007)(33656002)(74316002)(305945005)(5660300002)(25786009)(478600001)(7736002)(81166006)(86362001)(8936002)(55016002)(4326008)(6246003)(66946007)(76116006)(107886003)(9686003)(102836004)(6506007)(3846002)(6116002)(76176011)(71200400001)(71190400001)(486006)(11346002)(446003)(186003)(26005)(476003)(229853002)(2906002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2880;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2UyWgb0oHCEs5fHRK7pLYrGR71GgUWAp+WkdQNU3vOHhF9HB732l++h116c8cTcSun7B9U0OqkGNLnUGqGx+ha61ftw6K2hm0CZw16hvFkPIpLTTw9HNi2+y535JwAtjiUTFSgRz5bNrwNQ3puDNnZrbva3EpcGES0rPR5kZQeCSNNukltwHax5jfRaKX/DUVyxgWRfHYsr7Wy9aUdD08v70qmbh5YePo0b8ULOOUbbSfaflLLE6wR9iWo60RayNM/iPII5979XPsseTIkQ7FWPuKlWVOnT3hD1bBWAruAFkJ9o9TH/Oyd7zbVJCzVqnlx/IOslIrFszYz6LNelkCIgbtpNPlzyfUGhV9bGJh4bzeWK+W/mYc5goHpnCd7kZMmD5KMiwBDFv9zIv/IYj0C0kJdROvRIPgLzUVhdBmpNKkzfTjN+NJB4SwLWLs4uO
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f3db0-8344-4bc0-5585-08d76b49ac49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2019 10:34:06.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwiUSXRMqoD3rzKK7sVmlabIONNDkp8lYADbnNdHj/vB37Xa7Uy+89lgVTRO+JqEU+9UPPSExj+ZEBCFwI7fQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2880
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-17_01:2019-11-15,2019-11-16 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, November 14, 2019 8:23 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Wed, Nov 13, 2019 at 08:32:12AM +0100, Christoph Hellwig wrote:
>=20
> > There is no implementation of the DMA_ATTR_WRITE_BARRIER flag left
> now
> > that the ia64 sn2 code has been removed.  Drop the flag and the
> > calling convention to set it in the RDMA code.
>=20
> Applied to rdma.git for-next
>=20
> There were a number of conflicts in qedr, I fixed them up, but Michal
> probably should check it.


Thanks,=A0

Acked-by: Michal Kalderon=A0<michal.kalderon@marvell.com>

>=20
> Thanks,
> Jason
