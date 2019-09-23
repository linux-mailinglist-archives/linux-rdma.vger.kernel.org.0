Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09C23BB172
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405957AbfIWJbC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 05:31:02 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63158 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405719AbfIWJbB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 05:31:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N9TxKQ013326;
        Mon, 23 Sep 2019 02:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=DFsY58hGpKQj+tt5ogmzHq0DHmakUho7F+hJSEFj7Eo=;
 b=JemvSrqja3szMkeWBkpbQQ38VTLFlCfvwTkwUKCH5gNQHKNf0ChnluCExOHD3zTH2RpI
 fgLZ1zUj03GY44ESXOwq4/EAqZjxVZJIrZwpqrk75nvJvD5SJW2jqazqbVPeeooG8VMk
 nhlMDLh5HNdaqafPi6UaLOFZSXny7iRky0uRUBj/Bg/M1uvgSeH/lhwiNfCMEQZE5vH1
 ydKw5l+Tv9BO5m7dWOy0nfbpSvAUA1Z+l3lOXf0mtsH9toEqSUidzP6oIVnfKGYFmIQD
 O4TN6riTKeyaSxC02BTbAI9pPeHaKQ4UDdsKPTlK05G4bSdxaHjudQ8YNGrDjvWORmhP Xg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v5h7qdv5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 02:30:57 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 02:30:56 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 02:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VieoPjysjB6R3SVRKYLggWvhZLJ3PHbuNlTWGBXocXWQCvNAv63YlOvSN8QFhBRsxojri8DtImaLis/GvEQz0v7KJKiElaCZD2VgMBeL/vLnv5OwQ31kbvtGk7aXTNyaOep9/qYE8lOn3jTZmYpWget48ZN3cycYZ/PgyBuekA2+wM1HuSnthxM3lYTnwaunwKmqP80j9DZyrazytPQInJDqDH2DivJHJy6kOmlJF1LwDDLzf86hgg50rCcLNHEQEBzzYtsw3Yjdh0ZU9BW9ZF18jhuurHTuLHoPS0V+ReJVeeQXwP25SWlV+eHwegpcYOZQytCCc0o/15OmO47eWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFsY58hGpKQj+tt5ogmzHq0DHmakUho7F+hJSEFj7Eo=;
 b=kbSabMOgZSbkmg9L3fn+xiyR+rJefGhFVx2xvwqDt1dlL9+lrWBUKiltVLd/M4nI4AfDhycaWKV3B2y5gglqtkMtAmYxXye/TfCyFbYbYQtxTLDHgzJSKJULg1UwP9RvlzdlHmGs3wVqMy6fIQtPjgV8E8M8WdNOZ1+JiI6tSpEg19PMx+9yVQakCJAjdIopCD6Xmt/z0rSV4Ld+NCovtbGjKyoeuIRKoTPUNfboyIyQPAmd0opjspSryJRn75RixmPhUR1NwwqvDEem21fe/aAKoW+ns1F1B+6YnQT1o4g3x7SiwJiFsQHehN4tpBrbniBWBsoiHYbSksHqBV2Hxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFsY58hGpKQj+tt5ogmzHq0DHmakUho7F+hJSEFj7Eo=;
 b=ih84qyAnlfpKFvm3KM/Hk6UewoC1Zg2bkl8RJTUqOS7lNG9uyFJOQhyAUrEe2dz8ATCQNmtaUzv+PU8n9ifG/gk66Iaspclln9YfUqXN2dXq7hVOaWSP/kEV05jzjh0uIm/y0y1wubYVclMxSOW0BPYcSJhlrerto7ibTr9BbdQ=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB2829.namprd18.prod.outlook.com (20.179.20.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Mon, 23 Sep 2019 09:30:55 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:30:55 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Topic: [EXT] Re: [PATCH v11 rdma-next 6/7] RDMA/qedr: Add doorbell
 overflow recovery support
Thread-Index: AQHVY9EoebY7Q3SmzUGL2RQ8ozmUnKczYSUAgAW33FA=
Date:   Mon, 23 Sep 2019 09:30:54 +0000
Message-ID: <MN2PR18MB318246963F0BD4E2FB7459F0A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-7-michal.kalderon@marvell.com>
 <20190919180224.GE4132@ziepe.ca>
In-Reply-To: <20190919180224.GE4132@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf089f3-630a-42f2-94e9-08d74008bbc8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB2829;
x-ms-traffictypediagnostic: MN2PR18MB2829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB2829FAB60F7FB560EB8FC8A4A1850@MN2PR18MB2829.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(39850400004)(346002)(189003)(199004)(2906002)(6916009)(6116002)(3846002)(25786009)(66066001)(54906003)(316002)(33656002)(4326008)(55016002)(256004)(74316002)(9686003)(305945005)(86362001)(6246003)(229853002)(99286004)(6436002)(7736002)(14454004)(476003)(6506007)(5660300002)(76176011)(71190400001)(71200400001)(7696005)(486006)(26005)(186003)(102836004)(446003)(64756008)(66446008)(66946007)(11346002)(478600001)(8936002)(76116006)(52536014)(81166006)(66476007)(81156014)(66556008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2829;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p2yOHHwSLBQtM7ASY0rR4qXHu0QAIHJoYNEwMDnP2WXrqXmelFfHuKUtv6cuuyGbS5Z2QRSRj0sfsTZOfx8H9cdDkAQE8ZFa3XX8DaA3CZwD9RMT8LNCuQnpua8sG9hYPu4rvb9HJmoN4OeGPBPdXdG1TX6ctepdmo3FhFKuf+4v1ShOm64y6D9huxgKcvLJ5bUaT0//nVfK+q2ChsFOve20+rKoTJBij+/nEJRR0swYfQhaUe4UEshW4op3hSU/Dju0/Aa43H7BT5HmPPYyFDNLLkL9O7yjhkBQidmrsGnGWPl5uM0NcORb1EA4iWlwjfTYEFULj1gvMHmCrW6nfdnCLWTxAW8y4rtBZBOEGo6ejdSckxO3ej+7vz19NRhVH0XiEExs/jQWAT9p4sr1aRVjKsGE3fD/1jp8ylArfqs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: baf089f3-630a-42f2-94e9-08d74008bbc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:30:54.8896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzUB2AjwvVySxwhcNQMY35jBjdYXGU+CLo+kfxCM2m7bo5ejIKyNOwFpfPWP4j/oasA6QJFSnOVkUr/ZBUnJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2829
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_03:2019-09-23,2019-09-23 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, September 19, 2019 9:02 PM
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Thu, Sep 05, 2019 at 01:01:16PM +0300, Michal Kalderon wrote:
>=20
> > @@ -347,6 +360,9 @@ void qedr_mmap_free(struct
> rdma_user_mmap_entry
> > *rdma_entry)  {
> >  	struct qedr_user_mmap_entry *entry =3D
> > get_qedr_mmap_entry(rdma_entry);
> >
> > +	if (entry->mmap_flag =3D=3D QEDR_USER_MMAP_PHYS_PAGE)
> > +		free_page((unsigned long)phys_to_virt(entry->address));
> > +
>=20
> While it isn't wrong it do it this way, we don't need this mmap_free() st=
uff for
> normal CPU pages. Those are refcounted and qedr can simply call
> free_page() during the teardown of the uobject that is using the this pag=
e.
> This is what other drivers already do.
>=20
> I'm also not sure why qedr is using a phys_addr for a struct page object,
> seems wrong.
As mentioned in previous email, I misunderstood this part before. I'll move=
 the free
To object teardown.=20
What we need here is simply a shared page between kernel + user that both h=
ave
Virtual pointers to, user writes to the page, kernel needs to read the data=
.=20

The reason I used phys here is because the entry->address is defines as u64
As it is common whether it is an address to the bar or a page...=20
Should I define a union based on the entry type ? and for a page use
struct page object ?=20

>=20
> Jason
