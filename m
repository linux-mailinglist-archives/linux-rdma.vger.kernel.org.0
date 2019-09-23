Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDBABB14A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2019 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406865AbfIWJVt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 05:21:49 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406104AbfIWJVt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Sep 2019 05:21:49 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8N99ZJh003353;
        Mon, 23 Sep 2019 02:21:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=e35M8o9dVFmKdrtvMbioFl4HzCGb7TXASU3fpOqDemM=;
 b=AESNsBVJnJwXotDS1pyo3CVwFRZFfl91Fk0YOeh2Mkyf2Jjw7kTp+Aaf0LqhR/VCI2dI
 m1ywT0JQfjcOW8c7kT6C2TnPk+CzDPIp3KjD656V1/mSxpZ9vgf9KxwZ2T4nYTySWnGS
 lxB+WSRSI1JQPyvcfbPuZY0TD4EQiYn/58RvF6rL4aiDqm7eLVY8tX+0ogVTQAE0j3ug
 KFNVWLTQHOOT6qZKB7epwHvROPvX7xo9KkpW7h0VYyfEb0BA979z6tpg/NDEJ1d1eXFm
 eVNnIRFGEuD1YBlzB4skeOAbNOKJjhgMMzfVWcqSm0mDEBnIlrd/t6fhJXWFMqBTRXvj 5Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2v5kckn52y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 02:21:40 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 23 Sep
 2019 02:21:38 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 23 Sep 2019 02:21:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4840+6LjwOHa4WQegsj8SkGewaf2cM6qexqgQ0eXqOkv1N3an9JuNnHaqlrMuPheMyTOorqV8Ldw5Glnm+NMgwk8aSefAXLOV0cvjY2jNsb1qa1TzlnTJboUNSddbzFA/lW+cjaC8u7y/d20r34qlo/nd4+LixM3lTyVa0wfy+GG4t29T/8oHptc+f4v6chS11BA2+dcc8lBPfB9GBhT0RR8MdjCFfDNBiKum7UeHEw109fpbYuaFv/AGvu4GorOvENZnb+8DSmvL293WWzuJIvin0bax23a4lz8tEQIt7gTvu4x3dnEyXsW9s4/h+UY9bd8FMAsHO8oRF0A0u6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e35M8o9dVFmKdrtvMbioFl4HzCGb7TXASU3fpOqDemM=;
 b=dZkv5H8QrfVFGG/QEl0loPDdM9t6RJacqO5hW/CuJVUM32D8trZq5X7QZyaVDoTxeoqLrS38N3VNOzhGmw+WxYWsKNGvpKF6Hqruez+yVlw0lnZVneq7s0qJOy4amdPJo21Gx+OGF/JshLa2GlLb7jrEZKhEzRjedmBdXcNdQYphMNIS5yaErO0Y1vCPWQ44sm5+tnjfR+QZ2tNpVui38MN6XqdcoztKu8l7qXVqyjHWgaW27+mvawcAPHVQtgmUAlZVZgjmyk2kzqveEmdxjqPhkeUa/japWeddgkeqFRql4JDyboWbewyjnvyuT7ypVIKffAxiXrrjxF70W2S9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e35M8o9dVFmKdrtvMbioFl4HzCGb7TXASU3fpOqDemM=;
 b=eRf6VkmfwQstcllctK/1/nMhfy6vNtjnIk192/LmU+IuYZv8dJlkP8oOg/gSqiuAgJqrn03nYlXrMICZRdn3LlkeOiJYF7Qxawajv1KKSQirt/Y89cXNZB2R60QHZJg0AQQHLsuliOyBdUBuVhl74oc8SwnBn/9uqB1MVOj7a34=
Received: from MN2PR18MB3182.namprd18.prod.outlook.com (10.255.236.143) by
 MN2PR18MB3327.namprd18.prod.outlook.com (10.255.238.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Mon, 23 Sep 2019 09:21:37 +0000
Received: from MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8]) by MN2PR18MB3182.namprd18.prod.outlook.com
 ([fe80::9d49:7d09:abb5:34e8%7]) with mapi id 15.20.2284.023; Mon, 23 Sep 2019
 09:21:37 +0000
From:   Michal Kalderon <mkalderon@marvell.com>
To:     Gal Pressman <galpress@amazon.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Ariel Elior <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "bmt@zurich.ibm.com" <bmt@zurich.ibm.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Thread-Topic: [PATCH v11 rdma-next 5/7] RDMA/qedr: Use the common mmap API
Thread-Index: AQHVb7ju3H5srlnZKEWQePz8q/pg2ac4//Hg
Date:   Mon, 23 Sep 2019 09:21:37 +0000
Message-ID: <MN2PR18MB31828BDF43D9CA65A7BF1BC8A1850@MN2PR18MB3182.namprd18.prod.outlook.com>
References: <20190905100117.20879-1-michal.kalderon@marvell.com>
 <20190905100117.20879-6-michal.kalderon@marvell.com>
 <20190919175546.GD4132@ziepe.ca>
 <af160e72-bcc3-c511-8757-a21b33bd9e5c@amazon.com>
In-Reply-To: <af160e72-bcc3-c511-8757-a21b33bd9e5c@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53a4b33c-9945-4db0-5657-08d740076f65
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3327;
x-ms-traffictypediagnostic: MN2PR18MB3327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB3327BDAA0F7836389F2AACE9A1850@MN2PR18MB3327.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0169092318
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(2906002)(305945005)(8936002)(476003)(33656002)(3846002)(74316002)(7736002)(52536014)(53546011)(6116002)(102836004)(76176011)(446003)(99286004)(11346002)(66066001)(7696005)(486006)(71200400001)(71190400001)(26005)(81156014)(229853002)(66946007)(76116006)(55016002)(6506007)(6436002)(186003)(66556008)(64756008)(86362001)(9686003)(478600001)(8676002)(14454004)(81166006)(256004)(316002)(25786009)(5660300002)(66446008)(110136005)(6246003)(66476007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3327;H:MN2PR18MB3182.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4MXFDergwbvrOII/s9zCasvAVnALfJBYBcvmDkpTcDAYki2efBHNVQPMMaEXOH7CBE50/zx1cweVWRboQMDAF0Dex4HFzjK7gfA+7ppUk72F+geQ+2Owdg+SqshwsxG7GHDRa08EQzZ6E3O0L5g7UC30uzvkoEX5WvRdmZD78atHy6LBwd/28FH0ydQY2zYr2cj4CUAp4cyG5OQkhYFanXcHDmnfjrCpkdrcsvz9X+Lo+0tm+YLmFX5AenwsiLRuqjrBaPHPR6jir2UmbKfoDeRfIevuYqKGPPQ5VSLlv8s7gPvt1230vOmT9e+iNPXv6XizQtcm2qTxD4MIACagezrbxCyzCusT0OJPIi5OyFUJjn1VH5ZvLal9C8HTzs9QLotpze7fVVEfTk591Qjp68ahMAkfmB6Ue0n/wBqRFHM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a4b33c-9945-4db0-5657-08d740076f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2019 09:21:37.2856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tr/WKbbfX/mJbMgScxHFOVzy/JWrDORbhdMwM/QiVwdUuLhEK+R1F3md9mcx0zk6apYpO/3cFAn0qmm0+VaGUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3327
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-23_03:2019-09-23,2019-09-23 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

PiBGcm9tOiBsaW51eC1yZG1hLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgtcmRtYS0NCj4g
b3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBCZWhhbGYgT2YgR2FsIFByZXNzbWFuDQo+IA0KPiBP
biAxOS8wOS8yMDE5IDIwOjU1LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gSHVoLiBJZiB5
b3UgcmVjYWxsIHdlIGRpZCBhbGwgdGhpcyB3b3JrIHdpdGggdGhlIFhBIGFuZCB0aGUgZnJlZQ0K
PiA+IGNhbGxiYWNrIGJlY2F1c2UgeW91IHNhaWQgcWVkciB3YXMgbW1hcGluZyBCQVIgcGFnZXMg
dGhhdCBoYWQgc29tZSBIVw0KPiA+IGxpZmV0aW1lIGFzc29jaWF0ZWQgd2l0aCB0aGVtLCBhbmQg
dGhlIEhXIHJlc291cmNlIHdhcyBub3QgdG8gYmUNCj4gPiByZWFsbG9jYXRlZCB1bnRpbCBhbGwg
dXNlcnMgd2VyZSBnb25lLg0KPiA+DQo+ID4gSSB0aGluayBpdCB3b3VsZCBiZSBhIGJldHRlciBl
eGFtcGxlIG9mIHRoaXMgQVBJIGlmIHlvdSBwdWxsZWQgdGhlDQo+ID4NCj4gPiAgCWRldi0+b3Bz
LT5yZG1hX3JlbW92ZV91c2VyKGRldi0+cmRtYV9jdHgsIGN0eC0+ZHBpKTsNCj4gPg0KPiA+IElu
dG8gcWVkcl9tbWFwX2ZyZWUoKS4NCj4gPg0KPiA+IFRoZW4gdGhlIHJkbWFfdXNlcl9tbWFwX2Vu
dHJ5X3JlbW92ZSgpIHdpbGwgY2FsbCBpdCBuYXR1cmFsbHkgYXMgaXQNCj4gPiBkb2VzIGVudHJ5
X3B1dCgpIGFuZCBpZiB3ZSBhcmUgZGVzdHJveWluZyB0aGUgdWNvbnRleHQgd2UgYWxyZWFkeSBr
bm93DQo+ID4gdGhlIG1tYXBzIGFyZSBkZXN0cm95ZWQuDQo+ID4NCj4gPiBNYXliZSB0aGUgc2Ft
ZSBiYXNpYyBjb21tZW50IGZvciBFRkEsIG5vdCBzdXJlLiBHYWw/DQo+IA0KPiBUaGF0J3Mgd2hh
dCBFRkEgYWxyZWFkeSBkb2VzIGluIHRoaXMgc2VyaWVzLCBubz8NCj4gV2Ugbm8gbG9uZ2VyIHJl
bW92ZSBlbnRyaWVzIG9uIGRlYWxsb2NfdWNvbnRleHQsIG9ubHkgd2hlbiB0aGUgZW50cnkgaXMN
Cj4gZnJlZWQuDQoNCkFjdHVhbGx5LCBJIHRoaW5rIG1vc3Qgb2YgdGhlIGRpc2N1c3Npb25zIHlv
dSBoYWQgb24gdGhlIHRvcGljIHdlcmUgd2l0aCBHYWwsIGJ1dA0KU29tZSBhcHBseSB0byBxZWRy
IGFzIHdlbGwsIGhvd2V2ZXIsIGZvciBxZWRyLCB0aGUgb25seSBodyByZXNvdXJjZSB3ZSBhbGxv
Y2F0ZSAoYmFyKQ0KaXMgb24gYWxsb2NfdWNvbnRleHQgLCB0aGVyZWZvcmUgd2Ugd2VyZSBzYWZl
IHRvIGZyZWUgaXQgb24gZGVhbGxvY191Y29udGV4dCBhcyBhbGwgbWFwcGluZ3MNCndlcmUgYWxy
ZWFkeSB6YXBwZWQuIE1ha2luZyB0aGUgbW1hcF9mcmVlIGEgYml0IHJlZHVuZGFudCBmb3IgcWVk
ciBleGNlcHQgZm9yIHRoZSBuZWVkDQp0byBmcmVlIHRoZSBlbnRyeS4gDQoNCkZvciBFRkEsIGl0
IHNlZW1lZCB0aGUgb25seSBvcGVyYXRpb24gZGVsYXllZCB3YXMgZnJlZWluZyBtZW1vcnkgLSBJ
IGRpZG4ndCBzZWUgaHcgcmVzb3VyY2VzDQpiZWluZyBmcmVlZC4uLiBHYWw/DQoNCg==
