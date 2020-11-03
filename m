Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029322A4BB6
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 17:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKCQh6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 11:37:58 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:15578 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgKCQh5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 11:37:57 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Ganic017241;
        Tue, 3 Nov 2020 16:37:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=yuyjk3SnNn8eUYN7iCxqINjOdwtchELyfB0nL6+LcB4=;
 b=bdi8G0J5nPy5ugnyoLzJW78bKAfdvX+LzotAshptuGzqxcT52oHtZ0pXSCfzkxILhioq
 gn7aLU7NDsV9hLCdL4S2wIMX0z/3C9XAKKLEFiyLx6yaQ2U2NaWPj86cKzhUlAGBSQfI
 WDA8ahwEm9fzA1YxM6Jo8JaJUiVeA5UqL24gAdbTB9bLBeNBmqMCnAPjPnRYaJZPj/EI
 2yjsN6ZG3zYt6RmuEt5m3D6YWFdwpN8XBafKX3B9ACUTQWL7OB2suRJi/ayNkite93Vj
 g9RziqkOJ3Hat7kztsg8C4XNvvkOmEySLlXEKfBl+j/rRlfX9qJAGUjk7quqpkydK32C Rw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 34h07h9gwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 16:37:53 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id DB39257;
        Tue,  3 Nov 2020 16:37:52 +0000 (UTC)
Received: from G4W9331.americas.hpqcorp.net (16.208.32.117) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 16:37:51 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G4W9331.americas.hpqcorp.net (16.208.32.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 3 Nov 2020 16:37:51 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 3 Nov 2020 16:37:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAF5XpaO+78CfmtJKQpS9oNnp99aZFqSNreWULx0SW4ZRAU6eN0fcd38R4OqFAoc85unLB5obgbYmrr4sJFNAnJP2mqyg/mM5i0rE+jPnOfHzm8wSnaRWk2M1oVV0wM93NZO740RPanSG+9qBXhK6tVw3KNQTC/bXzA5JG5g1/k4B+KHurr2sUBLqXmBfc8STnkZoSm88uetFMGE6Ov1q0trf/RGnGMSuGLFY4Un497fHEpn1OslDHESqL6kuwjCO4Br/A0uJUt5j9pB/Pi+RJYs+z/Rfn3qHBTnAYL61+H+9aE6a471SA/Qq7NI0b6Wst180b7+0NyWBoqlxBPsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuyjk3SnNn8eUYN7iCxqINjOdwtchELyfB0nL6+LcB4=;
 b=QJh2h47kxnXY+b8ZeRrwHHhLhsfuZNwIM0E+5w5BJQ+QtyBIlTnv4MhHuYbnzkTRIp73Vra9ZE1/wXzRw7eMi5agwzHjlVKwGjxaUeb9/LeJc7Gzh1j7X5WXjEt0wCkVhSzrGFf33fLtJftjjlTEcXXYz45TzZb1Q1bbmaD0pHY5ayeDoVCDsL4xUbml4XVGqB+Z33J1NVF6JUyiPM/mVblukI46dxJMnjq+bfzQPsb1Ks0L5kokcn7nTY5iW/YkTxfcASBk9ibMG9tnFm4mcIRhVSR4740QRHBT5UIedfz5fGM1t/Pbk/iHxPJUpuVTcegj4W1O2wdt2sBqgjvxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB0725.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7509::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Tue, 3 Nov
 2020 16:37:50 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7c1c:4b55:a7c1:cc55]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::7c1c:4b55:a7c1:cc55%12]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 16:37:50 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Olga Kornievskaia <aglo@umich.edu>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: RE: Oops problem with rxe from 5.10-rc kernel
Thread-Topic: Oops problem with rxe from 5.10-rc kernel
Thread-Index: AQHWsWv5aKu4RWaPLEiEw5YpfGlTq6m1jQgAgAEPQWA=
Date:   Tue, 3 Nov 2020 16:37:49 +0000
Message-ID: <CS1PR8401MB0821DB1022C281246962BE41BC110@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <CAN-5tyHaVyoLMOc0Qtte=Gz+UUE+HX1b3E1d9xh-RD3Uve22JA@mail.gmail.com>
 <20201103002614.GJ36674@ziepe.ca>
In-Reply-To: <20201103002614.GJ36674@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:8c91:3dc:8a22:b3d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bf23d2f8-3069-4b76-2a7a-08d88016cda7
x-ms-traffictypediagnostic: CS1PR8401MB0725:
x-microsoft-antispam-prvs: <CS1PR8401MB0725C7292625A0B908945FB9BC110@CS1PR8401MB0725.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOgMGZn7GUX+gc4zX5y4YEW7lkO4F2Z34AiuhgbKgt7tzILMlKLbhYEKh74HOOMrylHLkfnCg35U3+EfsFN5nR3ghAtf0ZE5HwXpbpn/DXM1iO07VBnsZoZuKV4wlWNKasgnEgUoxjr76IoiyLfH2XP8wonT5WeYL3IpCpkk855D0T6BGq559F7X+o1kpSrDQnkoCmie0Kxw3TWdt//O4xOl+Ubg02IXRysp0cm1dRLSH4pAIYOyoqpZrR24uE3VdEYDudEdCDVpswBOuKUlpnht1pJmXvn/IhZGUDjmPqgMdM0yFWRe4y3MqgfeBmOT9BvhDb+RKZAO0Bi4CncIZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(8676002)(2906002)(4744005)(316002)(478600001)(4326008)(71200400001)(52536014)(5660300002)(110136005)(76116006)(9686003)(55016002)(86362001)(7696005)(64756008)(66446008)(66946007)(33656002)(53546011)(8936002)(6506007)(186003)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZMgENzizyBIx4cF3fgCxqZ0RmU5pOyOoo9/zBpF5kl4CWhVbXzOxtWQPcJ/0hV8C+sY/S282GPHN6oIGlFVOlMGhr9TDFg7+69mUaW5efTCg8vAmyxhkSyU5UnmgzYrVeJcp6UXPY0h7oJ0deE/9FYOs8QyQro2Ih1M+B9yXKcWM0g7hWKTxWxvOhFnRge7n0l86pn8LUdlEpwcMzaL3cizKHTNxcJQLjVDsCT2ucxYpr/nLRWRqhfeA9WZ6gdU20c22hROrNzKz6dBg2a1QxeR28SEgjE/BVhej1/DQGocQrJieZERo+nvpwkPoaOFgPWgptZHJWLiZaA+s8Lsv1j8ZyGeP+Y34imTS8ELTwaAb20uUWf8vyQqKGiFt5oi3iT75tzafW1yLWtZDbU5NuxmTqKlGLkwFhxZR8bKWAjdpCl9xqIwMB7mPlDbtusNndV9B4TzWWsDPRpe99HWMohyFtzSrR4QmpMwuhblSUxLd7AwGUMUxVFxwvbf01z5nsWYN+AIv8ObWoUD9hBIFFPuu+DpX0EoFQcq5nNTOEHRroRqSsInL9tJ9Cm6l3ChnLxOZknuBVg+8pB8AbdTHks1VzQIYllbUwiio4XGBPUTrEtGwbecUB3QONF6+0IOWkiCxuBJSTZveb6ipbvYg6Jfs4tTilY+hDhtH6oNLkXRya8muha+1usYWOX6OTsp/C6rrNnr/zmjdD0ns7oGW1g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf23d2f8-3069-4b76-2a7a-08d88016cda7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 16:37:49.9576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zG5RSCYrycCYmqWnbntt/Jbi+IXmrHw4U6VNBzVD3EDCYbu8YhjKP5nxFWaoB5icBDL1AizpqnSq8Fc4UkGBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0725
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



-----Original Message-----
From: Jason Gunthorpe <jgg@ziepe.ca>=20
Sent: Monday, November 2, 2020 6:26 PM
To: Olga Kornievskaia <aglo@umich.edu>
Cc: linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Oops problem with rxe from 5.10-rc kernel

On Mon, Nov 02, 2020 at 06:00:02PM -0500, Olga Kornievskaia wrote:
> Hi folks,
>=20
> Is this a known problem? I'm unable to do simple rping over Soft RoCE=20
> starting from 5.10-rc1 kernel (5.9 works).This is an oops from running=20
> the following. I'm also unable to do NFS-over-RDMA.

Yes, it should be fixed in rc3

Jason

Jason knows better than I. so its rc3.
